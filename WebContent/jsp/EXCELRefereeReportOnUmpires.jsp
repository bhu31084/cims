<%@ page language="java" contentType="application/pdf"
	import="java.io.*,com.lowagie.text.pdf.*,com.lowagie.text.*,
	sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
	java.util.*,java.util.*,in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.common.*"%>
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
	
	String role = "4";
	String FLAG = "2";
	String match_id = "";
	String user_id = "";
	String loginUserId = "";
	String user_role = "";
	String gsflag = request.getParameter("flag") != null ? request.getParameter("flag") : "0";
	if (gsflag.equalsIgnoreCase("1")) {
		match_id = request.getParameter("match");
		user_id = request.getParameter("refree_id");
		loginUserId = request.getParameter("refree");
		user_role = "9";
	} else {
		match_id = session.getAttribute("matchid").toString();
		user_id = session.getAttribute("userid").toString();
		loginUserId = session.getAttribute("usernamesurname").toString();
		user_role = session.getAttribute("role").toString();
	}
	String refereeReportId = "8";//report id of referee report
	String flag = "1";
	String result = null;
	String message = "";

	ReplaceApostroph replaceApos = new ReplaceApostroph();
	LogWriter log = new LogWriter();
	CachedRowSet MatchTeams = null;

	CachedRowSet crsObjViewDataUmp1 = null;
	CachedRowSet crsObjViewDataUmp2 = null;
	CachedRowSet crsObjRefereeFields = null;
	CachedRowSet crsObjRefereeDetail = null;
	CachedRowSet crsObjmatchreport = null;
	CachedRowSet crsObjCaptains = null;
	CachedRowSet crsObjplayerDetail = null;
	CachedRowSet crsObjBreachesList = null;
	CachedRowSet crsObjGroundEquCrs = null;
	CachedRowSet crsObjOffencesDetail = null;
	CachedRowSet crsObjSaveRefereeData = null;
	CachedRowSet crsObjSaveUmpData = null;
	CachedRowSet crsObjGrEquipData = null;
	String totalFlag = "false";

	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat("dd/MM/yyyy");
	int counter = 1;
	String gsUmpireName1 = null;
	String gsUmpire1Id = null;
	String gsrefid = null;
	String gsrefname = null;
	String gsUmpire2Id = null;
	String gsUmpireName2 = null;
	String gsAssociationName = null;
	String referee_user_id = null;
	StringBuffer sbIds = new StringBuffer();
	StringBuffer sbrefereeIds = new StringBuffer();//For referee fields
	StringBuffer sbgrEquipIds = new StringBuffer();

	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(match_id);
	Vector vparam = new Vector();
	Vector ids = new Vector();
	Vector refereeids = new Vector();//For referee fields
	Vector groundids = new Vector();

	//To display the userrole id's of players
	try {
		vparam.add(match_id);
		crsObjplayerDetail = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_userroleid_for_breaches", vparam, "ScoreDB");
		vparam.removeAllElements();
	} catch (Exception e) {
		System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
		log.writeErrLog(page.getClass(), match_id, e.toString());
	}
	//To dispaly the player records
	try {
		vparam.add(match_id);//Match id
		vparam.add("");//UserRole id
		vparam.add(FLAG);//Flag for display 2.
		crsObjOffencesDetail = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_referee_breachs_fb", vparam, "ScoreDB");
		vparam.removeAllElements();
	} catch (Exception e) {
		System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
		log.writeErrLog(page.getClass(), match_id, e.toString());
	}
	vparam.add(match_id);
	vparam.add(role);
	crsObjCaptains = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getMatchConcerns", vparam, "ScoreDB");
	vparam.removeAllElements();
	if (crsObjCaptains.size() == 0) {

		//No Referee Assigned For This Match

	} else {
		//To dispaly of details of the MATCH
		try {
			vparam.add(match_id);
			crsObjRefereeDetail = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_referee_feedbackdtls", vparam, "ScoreDB");
			vparam.removeAllElements();
		} catch (Exception e) {
			System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
			log.writeErrLog(page.getClass(), match_id, e.toString());
		}

		//To display of REPORT ON THE MATCH
		try {
			vparam.add(match_id);
			crsObjmatchreport = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_referee_match_report", vparam, "ScoreDB");
			vparam.removeAllElements();
		} catch (Exception e) {
			System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
			log.writeErrLog(page.getClass(), match_id, e.toString());
		}

		if (user_role.equals("9")) {
			vparam.add(match_id);
			vparam.add(role);
			try {
				crsObjCaptains = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getMatchConcerns", vparam, "ScoreDB");
				vparam.removeAllElements();
			} catch (Exception e) {
				System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
				log.writeErrLog(page.getClass(), match_id, e.toString());
			}

			if (crsObjCaptains != null) {
				while (crsObjCaptains.next()) {
					gsrefname = crsObjCaptains.getString("name");
					gsrefid = crsObjCaptains.getString("id");
				}
			}
			if (request.getParameter("hid") != null) {
				referee_user_id = request.getParameter("hid");
			}
		} else {gsrefid = user_id;
			if (request.getMethod().equalsIgnoreCase("post")) {
				if (request.getParameter("hdid") != null && request.getParameter("hdid").equalsIgnoreCase("1")) {
					//if(request.getParameter("hdUmpireId1") != null && request.getParameter("hdUmpireId2") != null){
					String[] retrieve_ids = request.getParameter("hidden_ids").split(",");
					int retrieve_ids_length = retrieve_ids.length;
					String umpire1_id = request.getParameter("hdUmpireId1");
					String umpire2_id = request.getParameter("hdUmpireId2");
					for (int count = 0; count < retrieve_ids_length; count = count + 2) {
						String umpire1 = retrieve_ids[count];

						//For First Umpire
						vparam = new Vector();
						vparam.add(match_id);
						vparam.add(user_id);
						vparam.add(umpire1_id);
						vparam.add(retrieve_ids[count]);

						if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
							vparam.add(request.getParameter(umpire1));
							vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_ump1" + retrieve_ids[count])));
						} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {
							vparam.add("0");
							vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_ump1" + retrieve_ids[count])));
						}
						vparam.add(refereeReportId);//Report Id of captain report

						try {
							lobjGenerateProc.GenerateStoreProcedure("esp_amd_userappraisal", vparam, "ScoreDB");
						} catch (Exception e) {
							System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
							log.writeErrLog(page.getClass(), match_id, e.toString());
						}

						//For Second Umpire
						vparam = new Vector();
						vparam.add(match_id);
						vparam.add(user_id);
						vparam.add(umpire2_id);
						vparam.add(retrieve_ids[count]);

						if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
							vparam.add(request.getParameter("ump2" + retrieve_ids[count]));
							vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_ump2" + retrieve_ids[count])));
						} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {
							vparam.add("0");
							vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_ump2" + retrieve_ids[count])));
						}
						vparam.add(refereeReportId);//Report Id of captain report

						try {
							lobjGenerateProc.GenerateStoreProcedure("esp_amd_userappraisal", vparam, "ScoreDB");
						} catch (Exception e) {
							System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
							log.writeErrLog(page.getClass(), match_id, e.toString());
						}
					}
					vparam.removeAllElements();

					//For the ground equipments.
					String[] retrieve_groundids = request.getParameter("hiddengr_ids").split(",");
					int retrieve_groundids_length = retrieve_groundids.length;
					for (int grcount = 0; grcount < retrieve_groundids_length; grcount = grcount + 2) {
						vparam.removeAllElements();
						vparam = new Vector();
						vparam.add(match_id);
						vparam.add(user_id);
						vparam.add(retrieve_groundids[grcount]);
						if (retrieve_groundids[grcount + 1].equalsIgnoreCase("Y")) {
							vparam.add(request.getParameter("groundId" + retrieve_groundids[grcount]));
							//vparam.add(replaceApos.replacesingleqt((String)request.getParameter("ground_"+ retrieve_groundids[grcount])));
							vparam.add(request.getParameter("ground_" + retrieve_groundids[grcount]));
						} else if (retrieve_groundids[grcount + 1].equalsIgnoreCase("N")) {
							vparam.add("0");
							vparam.add(request.getParameter("ground_" + retrieve_groundids[grcount]));
						}
						vparam.add("");//admin remark
						vparam.add(refereeReportId);//Report Id of captain report

						try {
							lobjGenerateProc.GenerateStoreProcedure("esp_amd_pitchoutfield", vparam, "ScoreDB");
							vparam.removeAllElements();
						} catch (Exception e) {
							System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
							log.writeErrLog(page.getClass(), match_id, e.toString());
						}
					}//End of the ground equipments.

					//For referee part submit
					String[] refretrieve_ids = request.getParameter("hidden_RefereeId").split(",");
					int refretrieve_ids_length = refretrieve_ids.length;
					for (int refcount = 0; refcount < refretrieve_ids_length; refcount = refcount + 2) {

						vparam = new Vector();
						vparam.add(match_id);
						vparam.add(user_id);
						vparam.add(refretrieve_ids[refcount]);
						if (refretrieve_ids[refcount + 1].equalsIgnoreCase("N")) {
							vparam.add("0");
							vparam.add(request.getParameter("rem_" + refretrieve_ids[refcount]));
						} else if (refretrieve_ids[refcount + 1].equalsIgnoreCase("Y")) {
							vparam.add(request.getParameter("refereeId" + refretrieve_ids[refcount]));
							vparam.add(request.getParameter("rem_" + refretrieve_ids[refcount]));
						}
						vparam.add(refereeReportId);//Report Id of captain report

						try {
							crsObjSaveRefereeData = lobjGenerateProc.GenerateStoreProcedure("esp_amd_matchrefereefeedback", vparam, "ScoreDB");
						} catch (Exception e) {
							System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
							log.writeErrLog(page.getClass(), match_id, e.toString());
						}
					}
					vparam.removeAllElements();
					//End of the referee part submit
					if (crsObjSaveRefereeData != null) {
						if (crsObjSaveRefereeData.next()) {
							//result = crsObjSaveRefereeData.getString("retval");
							if (crsObjSaveRefereeData.getString("retval").equalsIgnoreCase("SAVED")) {
								message = "Record Saved Successfully";
							} else {
								message = "Record Updated Successfully";
							}
						}
					}
				}
			}
			if (request.getParameter("hdid") != null && request.getParameter("hdid").equalsIgnoreCase("2")) {
				String[] retrieve_ids = request.getParameter("hidden_ids").split(",");
				int retrieve_ids_length = retrieve_ids.length;
				String umpire1_id = request.getParameter("hdUmpireId1");
				String umpire2_id = request.getParameter("hdUmpireId2");
				for (int count = 0; count < retrieve_ids_length; count = count + 2) {
					String umpire1 = retrieve_ids[count];

					//For First Umpire
					vparam = new Vector();
					vparam.add(match_id);
					vparam.add(user_id);
					vparam.add(umpire1_id);
					vparam.add(retrieve_ids[count]);

					if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
						vparam.add(request.getParameter(umpire1));
						vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_ump1" + retrieve_ids[count])));
					} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {
						vparam.add("0");
						vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_ump1" + retrieve_ids[count])));
					}
					vparam.add(refereeReportId);//Report Id of captain report

					try {
						lobjGenerateProc.GenerateStoreProcedure("esp_amd_userappraisal", vparam, "ScoreDB");
					} catch (Exception e) {
						System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
						log.writeErrLog(page.getClass(), match_id, e.toString());
					}

					//For Second Umpire
					vparam = new Vector();
					vparam.add(match_id);
					vparam.add(user_id);
					vparam.add(umpire2_id);
					vparam.add(retrieve_ids[count]);

					if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
						vparam.add(request.getParameter("ump2" + retrieve_ids[count]));
						vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_ump2" + retrieve_ids[count])));
					} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {
						vparam.add("0");
						vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_ump2" + retrieve_ids[count])));
					}
					vparam.add(refereeReportId);//Report Id of captain report

					try {
						crsObjSaveUmpData = lobjGenerateProc.GenerateStoreProcedure("esp_amd_userappraisal", vparam, "ScoreDB");
					} catch (Exception e) {
						System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
						log.writeErrLog(page.getClass(), match_id, e.toString());
					}
				}
				vparam.removeAllElements();
				if (crsObjSaveUmpData != null) {
					if (crsObjSaveUmpData.next()) {
						//result = crsObjSaveRefereeData.getString("retval");
						if (crsObjSaveUmpData.getString("retval").equalsIgnoreCase("Data updated successfully!")) {
							message = "Updated Umpire Details Successfully";
						} else {
							message = "Saved Umpire Details Successfully";
						}
					}
				}

			}
			if (request.getParameter("hdid") != null && request.getParameter("hdid").equalsIgnoreCase("3")) {
				//For the ground equipments.
				String[] retrieve_groundids = request.getParameter("hiddengr_ids").split(",");
				int retrieve_groundids_length = retrieve_groundids.length;
				for (int grcount = 0; grcount < retrieve_groundids_length; grcount = grcount + 2) {
					vparam.removeAllElements();
					vparam = new Vector();
					vparam.add(match_id);
					vparam.add(user_id);
					vparam.add(retrieve_groundids[grcount]);
					if (retrieve_groundids[grcount + 1].equalsIgnoreCase("Y")) {
						vparam.add(request.getParameter("groundId" + retrieve_groundids[grcount]));
						vparam.add(replaceApos.replacesingleqt((String) request.getParameter("ground_" + retrieve_groundids[grcount])));

					} else if (retrieve_groundids[grcount + 1].equalsIgnoreCase("N")) {
						vparam.add("0");
						vparam.add(request.getParameter("ground_" + retrieve_groundids[grcount]));
					}
					vparam.add("");//admin remark
					vparam.add(refereeReportId);//Report Id of captain report

					try {
						crsObjGrEquipData = lobjGenerateProc.GenerateStoreProcedure("esp_amd_pitchoutfield", vparam, "ScoreDB");
						vparam.removeAllElements();
					} catch (Exception e) {
						System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
						log.writeErrLog(page.getClass(), match_id, e.toString());
					}
				}//End of the ground equipments.

				if (crsObjGrEquipData != null) {
					if (crsObjGrEquipData.next()) {
						//result = crsObjSaveRefereeData.getString("retval");
						if (crsObjGrEquipData.getString("retval").equalsIgnoreCase("Data updated successfully!")) {
							message = "Updated InfraStructure Facilities and Ground Equipments Successfully";
						} else {
							message = "Saved InfraStructure Facilities and Ground Equipments Successfully";
						}
					}
				}
			}

			if (request.getParameter("hdid") != null && request.getParameter("hdid").equalsIgnoreCase("4")) {
				//For referee part submit
				String[] refretrieve_ids = request.getParameter("hidden_RefereeId").split(",");
				int refretrieve_ids_length = refretrieve_ids.length;
				for (int refcount = 0; refcount < refretrieve_ids_length; refcount = refcount + 2) {

					vparam = new Vector();
					vparam.add(match_id);
					vparam.add(user_id);
					vparam.add(refretrieve_ids[refcount]);
					if (refretrieve_ids[refcount + 1].equalsIgnoreCase("N")) {
						vparam.add("0");
						vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_" + refretrieve_ids[refcount])));
					} else if (refretrieve_ids[refcount + 1].equalsIgnoreCase("Y")) {
						vparam.add(request.getParameter("refereeId" + refretrieve_ids[refcount]));

						vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_" + refretrieve_ids[refcount])));
					}
					vparam.add(refereeReportId);//Report Id of captain report

					try {
						crsObjSaveRefereeData = lobjGenerateProc.GenerateStoreProcedure("esp_amd_matchrefereefeedback", vparam, "ScoreDB");
					} catch (Exception e) {
						System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
						log.writeErrLog(page.getClass(), match_id, e.toString());
					}
				}
				vparam.removeAllElements();
				if (crsObjSaveRefereeData != null) {
					if (crsObjSaveRefereeData.next()) {
						if (crsObjSaveRefereeData.getString("retval").equalsIgnoreCase("SAVED")) {
							message = "Referee Points Saved Successfully";
						} else {
							message = "Referee Points Updated Successfully";
						}
					}
				}
			}
		}
		//create new document

		try {
				if (crsObjRefereeDetail.next()) {
				gsUmpire1Id = crsObjRefereeDetail.getString("umpireofficalid1");
				gsUmpire2Id = crsObjRefereeDetail.getString("umpireofficalid2");
				gsUmpireName1 = crsObjRefereeDetail.getString("umpire");
				gsUmpireName2 = crsObjRefereeDetail.getString("umpire2");
			}

			
			HSSFRow row1 = sheet.createRow((short)1);
			HSSFCell cell1 = row1.createCell((short)0);
			cell1.setCellValue("Referee's Report on Umpires");
			cell1.setCellStyle(style);
			
			HSSFRow row2 = sheet.createRow((short)2);
			HSSFCell row2cel1 = row2.createCell((short)0);
			row2cel1.setCellValue("Match No : " + match_id);
			row2cel1.setCellStyle(style);
			
			HSSFRow row3 = sheet.createRow((short)2);
			HSSFCell row3cel1 = row3.createCell((short)0);
			row3cel1.setCellValue("Teams : " + crsObjRefereeDetail.getString("team1") + " Vs " + crsObjRefereeDetail.getString("team2"));
			row3cel1.setCellStyle(style);

			HSSFRow row4 = sheet.createRow((short)4);
			HSSFCell row4cel1 = row4.createCell((short)0);
			row4cel1.setCellValue("Name of the Zone : " + crsObjRefereeDetail.getString("zone"));
			row4cel1.setCellStyle(style);
			
			
			HSSFRow row5 = sheet.createRow((short)5);
			HSSFCell row5cel1 = row5.createCell((short)0);
			row5cel1.setCellValue("Venue : " + crsObjRefereeDetail.getString("venue"));
			row5cel1.setCellStyle(style);
			String d1 = null;
			java.util.Date date = ddmmyyyy.parse(crsObjRefereeDetail.getString("date"));
			d1 = sdf.format(date);

						
			HSSFRow row6 = sheet.createRow((short)6);
			HSSFCell row6cel1 = row6.createCell((short)0);
			row6cel1.setCellValue("Date : " + d1);
			row6cel1.setCellStyle(style);
			
			HSSFRow row7 = sheet.createRow((short)7);
			HSSFCell row7cel1 = row7.createCell((short)0);
			row7cel1.setCellValue("Name Of Tournament : " + crsObjRefereeDetail.getString("tournament"));
			row7cel1.setCellStyle(style);
			
			
			HSSFRow row8 = sheet.createRow((short)8);
			HSSFCell row8cel1 = row8.createCell((short)0);
			row8cel1.setCellValue("UMPIRING PERFORMANCE");
			row8cel1.setCellStyle(style);
						
			HSSFRow row9 = sheet.createRow((short)9);
			HSSFCell row9cel1 = row9.createCell((short)0);
			row9cel1.setCellValue("Match No : " + match_id);
			row9cel1.setCellStyle(style);
				

		
			HSSFRow row10 = sheet.createRow((short)10);
			HSSFCell row10cel1 = row10.createCell((short)0);
			row10cel1.setCellValue("");
			row10cel1.setCellStyle(style);
			
			HSSFCell row10cel2 = row10.createCell((short)1);
			row10cel2.setCellValue(gsUmpireName1);
			row10cel2.setCellStyle(style);
			HSSFCell row10cel3 = row10.createCell((short)2);
			row10cel3.setCellValue(gsUmpireName2);
			row10cel3.setCellStyle(style);
			
			int rowCounter = 11;
			//For Umpire 1
			vparam = new Vector();
			vparam.add(match_id);
			vparam.add(gsrefid); //change to userid
			vparam.add(gsUmpire1Id);
			vparam.add(refereeReportId);// report_id CAPTAIN REPORT ON GROUND PITCH AND FACILITIES Table:feedbackgroups_mst

			try {
				crsObjViewDataUmp1 = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpirereports", vparam, "ScoreDB");
			} catch (Exception e) {
				log.writeErrLog(page.getClass(), match_id, e.toString());
			}

			//For Umpire 2
			vparam = new Vector();
			vparam.add(match_id);
			vparam.add(gsrefid); //change to userid
			vparam.add(gsUmpire2Id);
			vparam.add(refereeReportId);// report_id CAPTAIN REPORT ON GROUND PITCH AND FACILITIES Table:feedbackgroups_mst

			try {
				crsObjViewDataUmp2 = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpirereports", vparam, "ScoreDB");
			} catch (Exception e) {
				log.writeErrLog(page.getClass(), match_id, e.toString());
			}

			if (crsObjViewDataUmp1 != null && crsObjViewDataUmp2 != null) {
				while (crsObjViewDataUmp1.next() && crsObjViewDataUmp2.next()) {
					sbIds.append(crsObjViewDataUmp1.getString("id"));
					sbIds.append(",");
					sbIds.append(crsObjViewDataUmp1.getString("scoring_required"));
					sbIds.append(",");
					ids.add(crsObjViewDataUmp1.getString("id"));
					ids.add(crsObjViewDataUmp1.getString("scoring_required"));

					HSSFRow row11 = sheet.createRow((short)rowCounter);
					rowCounter++;
					HSSFCell row11cel1 = row11.createCell((short)0);
					row11cel1.setCellValue(crsObjViewDataUmp1.getString("description"));
					row11cel1.setCellStyle(style);
					
					if (crsObjViewDataUmp1.getString("scoring_required").equalsIgnoreCase("Y")) {
						String[] strArr = crsObjViewDataUmp1.getString("cnames").toString().split(",");
						int length = Integer.parseInt(crsObjViewDataUmp1.getString("score_max").toString());
						int selectedVal1 = Integer.parseInt(crsObjViewDataUmp1.getString("selected")) - 1;

						String value = " ";
						for (int count = length - 1; count >= 0; count--) {

							if (strArr.length > count) {
								if (selectedVal1 == count) {
									value = strArr[count];

								}
							}
						}
						HSSFCell row11cel2 = row11.createCell((short)1);
						row11cel2.setCellValue(value);
						row11cel2.setCellStyle(style);

						value = "";
						int selectedVal2 = Integer.parseInt(crsObjViewDataUmp2.getString("selected")) - 1;
						for (int count = length - 1; count >= 0; count--) {
							if (strArr.length > count) {
								if (selectedVal2 == count) {
									value = strArr[count];
								}
							}
						}

						HSSFCell row11cel3 = row11.createCell((short)2);
						row11cel3.setCellValue(value);
						row11cel3.setCellStyle(style);
					} else {
						HSSFCell row11cel4 = row11.createCell((short)2);
						if (crsObjViewDataUmp1.getString("remark") != null) {
							row11cel4.setCellValue(crsObjViewDataUmp1.getString("remark").trim());
						} else {
							row11cel4.setCellValue("-");
						}
						row11cel4.setCellStyle(style);
						HSSFCell row11cel5 = row11.createCell((short)3);
						if (crsObjViewDataUmp2.getString("remark") != null) {
							row11cel5.setCellValue(crsObjViewDataUmp2.getString("remark").trim());
						} else {
							row11cel5.setCellValue("-");
						}
						row11cel5.setCellStyle(style);
					}
				}

			}

			HSSFRow row12 = sheet.createRow((short)rowCounter);
			rowCounter++;
			HSSFCell row12cel1 = row12.createCell((short)0);
			row12cel1.setCellValue("REPORT ON THE MATCH");
			row12cel1.setCellStyle(style);
			
			
			HSSFRow row13 = sheet.createRow((short)rowCounter);
			rowCounter++;
			HSSFCell row13cel1 = row13.createCell((short)0);
			row13cel1.setCellValue("Name of Asscn.");
			row13cel1.setCellStyle(style);
			
			HSSFCell row13cel2 = row13.createCell((short)1);
			row13cel2.setCellValue("Innings");
			row13cel2.setCellStyle(style);
			
			
			HSSFCell row13cel3 = row13.createCell((short)2);
			row13cel3.setCellValue("Runs Scored by the Asscn.");
			row13cel3.setCellStyle(style);
			
			
			HSSFCell row13cel4 = row13.createCell((short)3);
			row13cel4.setCellValue("No. of Wickets fallen");
			row13cel4.setCellStyle(style);
			
			HSSFCell row13cel5 = row13.createCell((short)4);
			row13cel5.setCellValue("Total Time taken by Asscn.");
			row13cel5.setCellStyle(style);
			
			HSSFCell row13cel6 = row13.createCell((short)5);
			row13cel6.setCellValue("Overs Bowled by Opponent Asscn.");
			row13cel6.setCellStyle(style);
			
			HSSFCell row13cel7 = row13.createCell((short)6);
			row13cel7.setCellValue("Overs Bowled Short by Opponent Asscn.");
			row13cel7.setCellStyle(style);
			
			
			HSSFCell row13cel8 = row13.createCell((short)7);
			row13cel8.setCellValue("Financial Penalty on Opponent Asscn.");
			row13cel8.setCellStyle(style);
			
			HSSFCell row13cel9 = row13.createCell((short)8);
			row13cel9.setCellValue("Match Points(league level)");
			row13cel9.setCellStyle(style);
			
			HSSFCell row13cel10 = row13.createCell((short)9);
			row13cel10.setCellValue("Match Result(Knock Out Level)");
			row13cel10.setCellStyle(style);
			
			while (crsObjmatchreport.next()) {

				HSSFRow row14 = sheet.createRow((short)rowCounter);
				rowCounter = rowCounter + 1;
				HSSFCell row14cel1 = row14.createCell((short)0);
				row14cel1.setCellValue(crsObjmatchreport.getString("nameofasscn"));
				row14cel1.setCellStyle(style);
				
				HSSFCell row14cel2 = row14.createCell((short)1);
				row14cel2.setCellValue(crsObjmatchreport.getString("innings"));
				row14cel2.setCellStyle(style);
				
				HSSFCell row14cel3 = row14.createCell((short)2);
				row14cel3.setCellValue(crsObjmatchreport.getString("runsscored"));
				row14cel3.setCellStyle(style);
				
				HSSFCell row14cel4 = row14.createCell((short)3);
				row14cel4.setCellValue(crsObjmatchreport.getString("noofwkt"));
				row14cel4.setCellStyle(style);
				
				HSSFCell row14cel5 = row14.createCell((short)4);
				row14cel5.setCellValue(crsObjmatchreport.getString("totaltime"));
				row14cel5.setCellStyle(style);
				
				HSSFCell row14cel6 = row14.createCell((short)5);
				row14cel6.setCellValue(crsObjmatchreport.getString("overbowled"));
				row14cel6.setCellStyle(style);
				
				HSSFCell row14cel7 = row14.createCell((short)6);
				row14cel7.setCellValue(crsObjmatchreport.getString("overbowledshort"));
				row14cel7.setCellStyle(style);
				
				HSSFCell row14cel8 = row14.createCell((short)7);
				row14cel8.setCellValue("Rs.");
				row14cel8.setCellStyle(style);
				
				HSSFCell row14cel9 = row14.createCell((short)8);
				row14cel9.setCellValue(crsObjmatchreport.getString("matchpoint"));
				row14cel9.setCellStyle(style);
				
				HSSFCell row14cel10 = row14.createCell((short)9);
				row14cel10.setCellValue(crsObjmatchreport.getString("matchresult"));
				row14cel10.setCellStyle(style);
				
				
			}// end of while

			
			HSSFRow row15 = sheet.createRow((short)rowCounter);
			rowCounter = rowCounter +1;
			HSSFCell row15cel1 = row15.createCell((short)0);
			row15cel1.setCellValue("Summary of breaches of the code of conduct laid down by BCCI,if any.");
			row15cel1.setCellStyle(style);


			
			HSSFRow row16 = sheet.createRow((short)rowCounter);
			rowCounter++;
			HSSFCell row16cel1 = row16.createCell((short)0);
			row16cel1.setCellValue("Player Name");
			row16cel1.setCellStyle(style);
			
			
			HSSFCell row16cel2 = row16.createCell((short)1);
			row16cel2.setCellValue("Level");
			row16cel2.setCellStyle(style);
			
			
			HSSFCell row16cel3 = row16.createCell((short)2);
			row16cel3.setCellValue("Offence");
			row16cel3.setCellStyle(style);
			
			
			HSSFCell row16cel4 = row16.createCell((short)3);
			row16cel4.setCellValue("Penalty");
			row16cel4.setCellStyle(style);
			
			

			if (crsObjOffencesDetail != null) {
				int Offencecounter = 1;
				while (crsObjOffencesDetail.next()) {

					HSSFRow row17 = sheet.createRow((short)rowCounter);
					rowCounter= rowCounter+1;
					HSSFCell row17cel1 = row17.createCell((short)0);
					row17cel1.setCellValue(crsObjOffencesDetail.getString("playername"));
					row17cel1.setCellStyle(style);
					
					HSSFCell row17cel2 = row17.createCell((short)1);
					row17cel2.setCellValue(crsObjOffencesDetail.getString("breach_level"));
					row17cel2.setCellStyle(style);
					
					HSSFCell row17cel3 = row17.createCell((short)2);
					row17cel3.setCellValue(crsObjOffencesDetail.getString("description"));
					row17cel3.setCellStyle(style);
					
					HSSFCell row17cel4 = row17.createCell((short)3);
					if (crsObjOffencesDetail.getString("reason").equals("25000")) {
						row17cel4.setCellValue("Reprimind");
					} else {
						if (crsObjOffencesDetail.getString("fee_percentage").equals("0")) {
							row17cel4.setCellValue("Banned For " + crsObjOffencesDetail.getString("reason") + " Matches");
						} else {
							row17cel4.setCellValue(crsObjOffencesDetail.getString("reason") + " Fees");
						}
					}
					row17cel4.setCellStyle(style);
				} //end of while
			}//end of outer if

			
			
			vparam.removeAllElements();
			vparam.add(match_id);
			vparam.add(gsrefid); //change to userid	34214
			vparam.add(refereeReportId);
			try {
				crsObjGroundEquCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_pitchoutfieldoneday", vparam, "ScoreDB");//need to change
				vparam.removeAllElements();
			} catch (Exception e) {
				System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
				log.writeErrLog(page.getClass(), match_id, e.toString());
			}
			if (crsObjGroundEquCrs != null) {
				while (crsObjGroundEquCrs.next()) {
					sbgrEquipIds.append(crsObjGroundEquCrs.getString("facilityid"));
					sbgrEquipIds.append(",");
					sbgrEquipIds.append(crsObjGroundEquCrs.getString("scoring_required"));
					sbgrEquipIds.append(",");
					groundids.add(crsObjGroundEquCrs.getString("facilityid"));
					groundids.add(crsObjGroundEquCrs.getString("scoring_required"));
					HSSFRow row18 = sheet.createRow((short)rowCounter);
					rowCounter++;
					HSSFCell row18cel1 = row18.createCell((short)0);
					if (crsObjGroundEquCrs.getString("parent").equalsIgnoreCase("0")) {
						row18cel1.setCellValue(crsObjGroundEquCrs.getString("description"));
					} else {
						row18cel1.setCellValue("      *    " + crsObjGroundEquCrs.getString("description"));
					}
					row18cel1.setCellStyle(style);
					HSSFCell row18cel2 = row18.createCell((short)1);
					if (crsObjGroundEquCrs.getString("scoring_required").equalsIgnoreCase("Y")) {

						String[] strArr = crsObjGroundEquCrs.getString("cnames").toString().split(",");
						int length = Integer.parseInt(crsObjGroundEquCrs.getString("score_max").toString());

						int selectedVal1 = Integer.parseInt(crsObjGroundEquCrs.getString("selected")) - 1;

						for (int count = length - 1; count >= 0; count--) {

							if (strArr.length > count) {
								if (selectedVal1 == count) {
									row18cel2.setCellValue(strArr[count]);
								} else {
									row18cel2.setCellValue("");
								}
							}
						}
					}
					row18cel2.setCellStyle(style);
				}
			}
			
			Vector refereeFld = new Vector();
			//to dispaly of Lower fields.
			refereeFld.add(match_id);
			refereeFld.add(gsrefid);
			refereeFld.add(refereeReportId);
			try {
				crsObjRefereeFields = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchrefereefeedback", refereeFld, "ScoreDB");
				refereeFld.removeAllElements();
			} catch (Exception e) {
				System.out.println("*************RefereeReportOnUmpires.jsp*****************" + e);
				log.writeErrLog(page.getClass(), match_id, e.toString());
			}

			if (crsObjRefereeFields != null) {
				int refcounter = 1;
				while (crsObjRefereeFields.next()) {
					sbrefereeIds.append(crsObjRefereeFields.getString("rolefacilityid"));
					sbrefereeIds.append(",");
					sbrefereeIds.append(crsObjRefereeFields.getString("scoring_required"));
					sbrefereeIds.append(",");
					refereeids.add(crsObjRefereeFields.getString("rolefacilityid"));
					refereeids.add(crsObjRefereeFields.getString("scoring_required"));

					HSSFRow row19 = sheet.createRow((short)rowCounter);
					rowCounter++;
					HSSFCell row19cel1 = row19.createCell((short)0);
					row19cel1.setCellValue(crsObjRefereeFields.getString("description"));
					row19cel1.setCellStyle(style);
					HSSFCell row19cel2 = row19.createCell((short)1);
					if (crsObjRefereeFields.getString("scoring_required").equalsIgnoreCase("Y")) {
						String[] strArr = crsObjRefereeFields.getString("cnames").toString().split(",");
						int length = Integer.parseInt(crsObjRefereeFields.getString("score_max").toString());
						int selectedVal1 = Integer.parseInt(crsObjRefereeFields.getString("selected")) - 1;
						for (int count = length - 1; count >= 0; count--) {
							if (strArr.length > count) {
								if (selectedVal1 == count) {
									row19cel2.setCellValue(strArr[count]);
									
								}
							}
						}
					} else {
						if (crsObjRefereeFields.getString("remark") != null) {
							row19cel2.setCellValue(crsObjRefereeFields.getString("remark"));
						} else {
							//Blank
						}
					}
					row19cel2.setCellStyle(style);
					refcounter++;
				}
			}
	
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-disposition","attachment; filename=\"RefereeReportOnUmpire.xls\"" ); 
			java.io.OutputStream outputStream = response.getOutputStream();
			wb.write( outputStream );
	  	    outputStream.flush();
	  	    outputStream.close();
		} finally {
	
		}
	}
%>