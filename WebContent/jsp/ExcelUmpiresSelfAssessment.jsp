<%@ page language="java" contentType="application/pdf"
	import="java.io.*,com.lowagie.text.*,sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*,java.util.*,in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.common.*"%>
<%@ page import="in.co.paramatrix.common.ChangeInitial"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFHeader"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFPrintSetup"%>
<%@ page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*" %>	
<%
	OutputStream os = response.getOutputStream();

	HSSFWorkbook wb = new HSSFWorkbook();
	HSSFSheet sheet = wb.createSheet("new sheet");		
	//set width
	sheet.setColumnWidth((short)0,(short)(1500));
    sheet.setColumnWidth((short)1,(short)(5000));
	sheet.setColumnWidth((short)2,(short)(3000));
	sheet.setColumnWidth((short)3,(short)(3500));
	sheet.setColumnWidth((short)4,(short)(4000));
	sheet.setColumnWidth((short)5,(short)(4000));
	HSSFFont font = wb.createFont();
	font.setFontHeightInPoints((short)10);
	font.setFontName("Courier New");			
	font.setColor(HSSFColor.RED.index);
	font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);	
	HSSFCellStyle style = wb.createCellStyle();
	style.setFillBackgroundColor(HSSFColor.ORANGE.index);
	style.setFont(font);
	String reportId = "7";
	String matchId = null;
	String userID = null;
	String loginUserName = null;
	String message = null;
	String messageFlag = null;
	String appruval = null;
	String umpireOfficialId = null;
	String flag = "false";//for displaying message
	String appruvalFlag = "false";
	String appMessageFlag = null;
	String appMessage = null;
	String user_role = "";
	int noUmpMessage = 0;

	String role = "2"; //For umpire
	LogWriter log = new LogWriter();
	StringBuffer sbIds = new StringBuffer();
	ReplaceApostroph replaceApos = new ReplaceApostroph();

	if (session.getAttribute("matchid") == null) {
		System.out.println("sdfgsdfgsdfdffas");
	}
	String gsflag = request.getParameter("flag") != null ? request.getParameter("flag") : "0";
	if (gsflag.equalsIgnoreCase("1")) {
		matchId = request.getParameter("match");
		loginUserName = session.getAttribute("usernamesurname").toString();
		userID = session.getAttribute("userid").toString();
		user_role = session.getAttribute("role").toString();
	} else {
		matchId = session.getAttribute("matchid").toString();
		loginUserName = session.getAttribute("usernamesurname").toString();
		userID = session.getAttribute("userid").toString();
		user_role = session.getAttribute("role").toString();
	}

	CachedRowSet matchSummeryCrs = null;
	CachedRowSet submitCrs = null;
	CachedRowSet displayCrs = null;
	CachedRowSet umpiresCrs = null;
	CachedRowSet useridCrs = null;
	CachedRowSet messageCrs = null;
	CachedRowSet appruvalCrs = null;
	CachedRowSet AdminUmp1 = null;
	CachedRowSet AdminUmp2 = null;

	String umpireName1 = null;
	String umpireName2 = null;

	GenerateStoreProcedure generateStProc = new GenerateStoreProcedure(matchId);
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MMM-dd");

	Vector ids = new Vector();
	Vector spParamVec = new Vector();
	String score = request.getParameter("hdSelectedValue");//e.g."1:1~2:2~3:0"		
	String scoreRequired = (String) request.getParameter("hdScoreRequired");//e.g."1:1~2:2~3:0"		

	//for match details in top table
	spParamVec.add(matchId); // match_id
	try {
		matchSummeryCrs = generateStProc.GenerateStoreProcedure("esp_dsp_matchdetails_pitchreport", spParamVec, "ScoreDB");
	} catch (Exception e) {
		log.writeErrLog(page.getClass(), matchId, e.toString());
	}

	if (user_role.equals("9")) {
		spParamVec = new Vector<String>();
		spParamVec.add(matchId);
		spParamVec.add(role);
		try {
			umpiresCrs = generateStProc.GenerateStoreProcedure("esp_dsp_getMatchConcerns", spParamVec, "ScoreDB");
			noUmpMessage = umpiresCrs.size();
		} catch (Exception e) {
			log.writeErrLog(page.getClass(), matchId, e.toString());
		}
		if (noUmpMessage > 0) {
			if (umpiresCrs.next()) {
				umpireName1 = umpiresCrs.getString("namesurname");
				spParamVec.removeAllElements();
				spParamVec.add(matchId); // match_id
				spParamVec.add(umpiresCrs.getString("id"));
				spParamVec.add(umpiresCrs.getString("official"));
				spParamVec.add(reportId); // report id
				try {
					AdminUmp1 = generateStProc.GenerateStoreProcedure("esp_dsp_umpirereports", spParamVec, "ScoreDB");
				} catch (Exception e) {
					log.writeErrLog(page.getClass(), matchId, e.toString());
				}
			}

			if (noUmpMessage > 1) {
				if (umpiresCrs.next()) {
					umpireName2 = umpiresCrs.getString("namesurname");
					spParamVec.removeAllElements();
					spParamVec.add(matchId); // match_id
					spParamVec.add(umpiresCrs.getString("id"));
					spParamVec.add(umpiresCrs.getString("official"));
					spParamVec.add(reportId); // report id

					try {
						AdminUmp2 = generateStProc.GenerateStoreProcedure("esp_dsp_umpirereports", spParamVec, "ScoreDB");
					} catch (Exception e) {
						log.writeErrLog(page.getClass(), matchId, e.toString());
					}
				}
			}
		}

	} else {
		if (request.getParameter("hid") != null && request.getParameter("hid").equalsIgnoreCase("1")) {

			String[] retrieve_ids = request.getParameter("hidden_ids").split(",");
			int retrieve_ids_length = retrieve_ids.length;

			umpireOfficialId = request.getParameter("umpire");

			for (int count = 0; count < retrieve_ids_length; count = count + 2) {
				System.out.println(request.getParameter(retrieve_ids[count]) + " : " + retrieve_ids[count + 1]);
				spParamVec = new Vector();
				spParamVec.add(matchId);
				spParamVec.add(userID);
				spParamVec.add(umpireOfficialId);
				spParamVec.add(retrieve_ids[count]);

				if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {//combo
					spParamVec.add(request.getParameter(retrieve_ids[count]));
					spParamVec.add(replaceApos.replacesingleqt((String) request.getParameter("rem_" + retrieve_ids[count])));
				} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {//text
					spParamVec.add("0");
					spParamVec.add(replaceApos.replacesingleqt((String) request.getParameter("rem_" + retrieve_ids[count])));
				}

				spParamVec.add(reportId);
				try {
					messageCrs = generateStProc.GenerateStoreProcedure("esp_amd_userappraisal", spParamVec, "ScoreDB");
				} catch (Exception e) {
					log.writeErrLog(page.getClass(), matchId, e.toString());
				}

			}

			if (messageCrs.next()) {
				messageFlag = messageCrs.getString("retflag");//number 1,2,3
				message = messageCrs.getString("retval");//message string
				flag = "true";//to display messg or not
				appruvalFlag = "true";//for appruval button
			}

			if (request.getParameter("hidAppruve") != null && request.getParameter("hidAppruve").equalsIgnoreCase("1")) {
				spParamVec.removeAllElements();
				spParamVec.add(umpireOfficialId);
				spParamVec.add(userID);
				spParamVec.add(matchId);
				spParamVec.add("1");
				try {
					appruvalCrs = generateStProc.GenerateStoreProcedure("esp_amd_umpirecoachapproval", spParamVec, "ScoreDB");
				} catch (Exception e) {
					log.writeErrLog(page.getClass(), matchId, e.toString());
				}

				if (appruvalCrs.next()) {
					appMessageFlag = appruvalCrs.getString("retval");
					appMessage = appruvalCrs.getString("remark");

					if (appMessageFlag.trim().equalsIgnoreCase("1")) {//Ump coach exists
						message = "";
						appruvalFlag = "false";//to hide approval button
					} else {//No Ump coach 
						message = appMessage;
						appruvalFlag = "true";//to show approval button
					}
				}
			}
		}

		//For Display Table Data
		spParamVec.removeAllElements();
		spParamVec.add(matchId); // match_id
		spParamVec.add(userID);
		try {
			umpiresCrs = generateStProc.GenerateStoreProcedure("esp_dsp_getmatchofficialid_umpire", spParamVec, "ScoreDB");//to get official id of umpire
		} catch (Exception e) {
			log.writeErrLog(page.getClass(), matchId, e.toString());
		}
		if (umpiresCrs.next()) {
			umpireOfficialId = umpiresCrs.getString("official");
		}
		spParamVec.add(umpireOfficialId);
		spParamVec.add(reportId); // report id
		try {
			displayCrs = generateStProc.GenerateStoreProcedure("esp_dsp_umpirereports", spParamVec, "ScoreDB");
		} catch (Exception e) {
			log.writeErrLog(page.getClass(), matchId, e.toString());
		}
	}
	//create new document

	try {

	 	HSSFRow row1 = sheet.createRow((short)2);
		HSSFCell cell1 = row1.createCell((short)0);
		cell1.setCellValue("Umpire's Self Assessment Report");
		cell1.setCellStyle(style);
		if (matchSummeryCrs != null) {
			String umpire2name = null;
			String umpire1name = null;
			int i=2;
			int srno = 0;
			while (matchSummeryCrs.next()) {

				if (userID.equalsIgnoreCase(matchSummeryCrs.getString("umpire1Id"))) {
					umpire2name = matchSummeryCrs.getString("umpire2");
					if (umpire2name == null) {
						umpire2name = "-";
					}
				}
		
				//css for the row data in excel sheet.
				HSSFFont cellfont = wb.createFont();
				cellfont.setFontHeightInPoints((short)9);
				cellfont.setFontName("Arial");					
				HSSFCellStyle cellstyle = wb.createCellStyle();
				cellstyle.setFillBackgroundColor(HSSFColor.ORANGE.index);
				cellstyle.setFont(cellfont);
				cellstyle.setWrapText(true);								
				//cellstyle.setDataFormat(org.apache.poi.hssf.usermodel.HSSFDataFormat.);					
				
				HSSFRow row = sheet.createRow((short)1);
				HSSFCell cell = row.createCell((short)0);
				cell.setCellValue("Partner Name:");
				cell.setCellStyle(cellstyle);

				cell = row.createCell((short)1);
				cell.setCellValue(umpire2name == null ? " - " : umpire2name);
				cell.setCellStyle(cellstyle);

				row = sheet.createRow((short)2);
				cell = row.createCell((short)0);
				cell.setCellValue("Teams:");
				cell.setCellStyle(cellstyle);

				cell = row.createCell((short)1);
				cell.setCellValue((matchSummeryCrs.getString("team1").trim().equalsIgnoreCase("null") ? "-" : matchSummeryCrs.getString("team1")) + " Vs " + (matchSummeryCrs.getString("team2").trim().equalsIgnoreCase("null") ? "-" : matchSummeryCrs.getString("team2")));
				cell.setCellStyle(cellstyle);
				
				row = sheet.createRow((short)3);
				cell = row.createCell((short)0);
				cell.setCellValue("Venue : ");
				cell.setCellStyle(cellstyle);

				cell = row.createCell((short)1);
				cell.setCellValue((matchSummeryCrs.getString("venue").trim().equalsIgnoreCase("null") ? "-" : matchSummeryCrs.getString("venue")));
				cell.setCellStyle(cellstyle);

				row = sheet.createRow((short)4);
				cell = row.createCell((short)0);
				cell.setCellValue("Match type : ");
				cell.setCellStyle(cellstyle);

				cell = row.createCell((short)1);
				cell.setCellValue((matchSummeryCrs.getString("matchtype").trim().equalsIgnoreCase("null") ? "-" : matchSummeryCrs.getString("matchtype")));
				cell.setCellStyle(cellstyle);


				if (umpireName1 == null || umpireName2 == null) {
					row = sheet.createRow((short)5);
					cell = row.createCell((short)0);
					cell.setCellValue("Umpires : Umpires not assigned for this match");
					cell.setCellStyle(cellstyle);
				}
				
				row = sheet.createRow((short)6);
				cell = row.createCell((short)0);
				cell.setCellValue("Match Id: ");
				cell.setCellStyle(cellstyle);

				cell = row.createCell((short)1);
				cell.setCellValue(matchId);
				cell.setCellStyle(cellstyle);
				if (umpireName1 != null || umpireName2 != null) {
					row = sheet.createRow((short)7);
					cell = row.createCell((short)0);
					cell.setCellValue("Umpire's self-ratings & comments on their performance");
					cell.setCellStyle(cellstyle);
				}
			}

			

			row1 = sheet.createRow((short)9);
			cell1 = row1.createCell((short)0);
			cell1.setCellValue("Umpires :");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)1);
			cell1.setCellValue(umpireName1 == null ? "-" : umpireName1);
			cell1.setCellStyle(style);
			
			cell1 = row1.createCell((short)2);
			cell1.setCellValue(umpireName2 == null ? "-" : umpireName2);
			cell1.setCellStyle(style);


			if ((AdminUmp1 != null) && (AdminUmp2 != null)) {
				if ((AdminUmp1.size() > 0) && (AdminUmp2.size() > 0)) {
					int counter = 1;
					int rowCounter = 10;
					while (AdminUmp1.next() && AdminUmp2.next()) {
						row1 = sheet.createRow((short)rowCounter);
						cell1 = row1.createCell((short)0);
						cell1.setCellValue(AdminUmp1.getString("description"));
						cell1.setCellStyle(style);
						
						String remark = " - ";
						String value = " - ";
						if (AdminUmp1.getString("scoring_required").equalsIgnoreCase("Y")) {
							String[] valueArr = AdminUmp1.getString("cnames").toString().split(",");
							for (int count = valueArr.length; count > 0; count--) {
								if (AdminUmp1.getString("selected").equalsIgnoreCase("" + count)) {
									value = valueArr[count - 1];
								}
							}
							if (!(AdminUmp1.getString("remark").trim().equalsIgnoreCase(""))) {
								remark = AdminUmp1.getString("remark").trim();
							}
						} else {
							if (AdminUmp1.getString("remark") != null) {
								remark = AdminUmp1.getString("remark").trim();
							}
						}
						
						row1 = sheet.createRow((short)rowCounter);
						cell1 = row1.createCell((short)1);
						cell1.setCellValue(value + " : " + remark);
						cell1.setCellStyle(style);

						remark = " - ";
						value = " - ";

						if (AdminUmp2 != null) {
							if (AdminUmp2.size() > 0) {
								if (AdminUmp2.getString("scoring_required").equalsIgnoreCase("Y")) {
									String[] valueArr = AdminUmp2.getString("cnames").toString().split(",");
									for (int count = valueArr.length; count > 0; count--) {
										if (AdminUmp2.getString("selected").equalsIgnoreCase("" + count)) {
											value = valueArr[count - 1];
										}
									}
									if (!(AdminUmp2.getString("remark").trim().equalsIgnoreCase(""))) {
										remark = AdminUmp2.getString("remark").trim();
									}
								} else {
									if (AdminUmp2.getString("remark") != null) {
										remark = AdminUmp2.getString("remark").trim();
									}
								}
								row1 = sheet.createRow((short)rowCounter);
								cell1 = row1.createCell((short)2);
								cell1.setCellValue(value + " : " + remark);
								cell1.setCellStyle(style);
							}
						}
						counter++;
						rowCounter++;
					}
				}
			}

			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-disposition","attachment; filename=\"UmpiresSelfAssessment.xls\"" ); 
			java.io.OutputStream outputStream = response.getOutputStream();
			wb.write( outputStream );
	  	    outputStream.flush();
	  	    outputStream.close();

		}

	} catch (Exception e) {}
	finally {}
%>