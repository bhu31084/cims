<%@ page language="java" contentType="application/pdf"
	import="java.io.*,com.lowagie.text.pdf.*,com.lowagie.text.*,
	sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
	java.util.*,java.util.*,in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.common.*"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>	
<%
	OutputStream os = response.getOutputStream();
	response.setHeader ("Content-Disposition", "attachment;	filename=PitchOutfieldReportFiveDayspdf");
	Document document = new Document(PageSize.A4, 50, 50, 50, 50);
	PdfWriter.getInstance(document, os);

	String reportId = "5";
	String role = "4"; //For refree
	String matchId = null;
	String loginUserName = null;
	String userID = null;
	String flag = "false";
	String message = null;
	String startDate = null;
	String endDate = null;
	String allDays = "";
	int days = 0;
	//String umpire_name = null;
	String umpireOfficialId = null;
	LogWriter log = new LogWriter();
	
	ReplaceApostroph replaceApos = new ReplaceApostroph();
	StringBuffer sbIds = new StringBuffer();
	StringBuffer sbIdsOccurance = new StringBuffer();

	matchId = session.getAttribute("matchid").toString();
	userID = session.getAttribute("userid").toString();
	loginUserName = session.getAttribute("usernamesurname").toString();
	String userRole = session.getAttribute("role").toString();
	
	CachedRowSet matchSummeryCrs = null;
	CachedRowSet submitCrs = null;
	CachedRowSet displayCrs = null;
	CachedRowSet umpiresCrs = null;
	CachedRowSet useridCrs = null;
	CachedRowSet messageCrs = null;
	CachedRowSet refreeidCrs = null;
	Calendar cal = Calendar.getInstance();

	GenerateStoreProcedure generateStProc = new GenerateStoreProcedure();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
			"yyyy-MMM-dd");
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
			"yyyy-MMM-dd");
	java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat(
			"dd/MM/yyyy");

	Vector ids = new Vector();
	Vector spParamVec = new Vector();
	String score = request.getParameter("hdSelectedValue");//e.g."1:1~2:2~3:0"		
	String scoreRequired = (String) request.getParameter("hdScoreRequired");//e.g."1:1~2:2~3:0"		

	try{
	//for match details in top table
	spParamVec.add(matchId); // match_id
	
	matchSummeryCrs = generateStProc.GenerateStoreProcedure(
			"esp_dsp_matchdetails_pitchreport", spParamVec, "ScoreDB");
	}catch (Exception e) {
			System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
			log.writeErrLog(page.getClass(),matchId,e.toString());
	}		
	
	/*useridCrs = generateStProc.GenerateStoreProcedure(
			"esp_dsp_getmatchrefereeid", spParamVec, "ScoreDB");
	 if (useridCrs != null) {		
		if (useridCrs.next()) {
			userID = useridCrs.getString("id");
		}		
	}*/		
if (userRole.equals("9")){
		System.out.println("Role is admin");
		spParamVec = new Vector();
		spParamVec.add(matchId);
		spParamVec.add(role);
		
		try{
		refreeidCrs = generateStProc.GenerateStoreProcedure(
				"esp_dsp_getMatchConcerns", spParamVec, "ScoreDB");
		}catch (Exception e) {
			System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}		
	if (refreeidCrs != null) {
		while (refreeidCrs.next()) {
			userID = refreeidCrs.getString("id");
		}
	}		
}
	if (request.getParameter("hid") != null
			&& request.getParameter("hid").equalsIgnoreCase("1")) {

		System.out.println("ids : " + request.getParameter("hidden_ids"));
		System.out.println("ids_occurance : " + request.getParameter("hidden_ids_occurance"));
		System.out.println("hiddenDates : " + request.getParameter("hiddenDates"));

		String[] retrieve_ids = request.getParameter("hidden_ids").split(",");
		String[] retrieve_ids_occurance = request.getParameter("hidden_ids_occurance").split(",");//for >1 occurance
		String[] retrieve_dates = request.getParameter("hiddenDates").split("~");
		
		int retrieve_ids_length = retrieve_ids.length;
		int retrieve_ids_occlength = ((retrieve_ids_occurance.length) - 1);
		int retrieve_dates_length = retrieve_dates.length;
		
		umpireOfficialId = request.getParameter("umpire");
//-----------------------------	//one occurance	
		for (int count = 0; count < retrieve_ids_length; count = count + 2) {
			spParamVec = new Vector();
			spParamVec.add(matchId);
			spParamVec.add(userID);
			spParamVec.add(retrieve_ids[count]);
			if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {//combo
				spParamVec.add(request.getParameter(retrieve_ids[count]+"_"+retrieve_dates[0]));
				spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter("rem_"+retrieve_ids[count]+"_"+retrieve_dates[0])));
			} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {//text
				spParamVec.add("0");//for score
				spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter(retrieve_ids[count]+"_"+retrieve_dates[0])));
			}
			spParamVec.add(reportId);
			spParamVec.add(retrieve_dates[0]);
			
			try{
			messageCrs = generateStProc.GenerateStoreProcedure("esp_amd_pitchoutfield_for5day ",
					spParamVec, "ScoreDB");
			}catch (Exception e) {
			System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
			log.writeErrLog(page.getClass(),matchId,e.toString());
			}		
		}
//-----------------------------	//more than one occurance		
		for (int count = 0; count < retrieve_ids_occlength; count = count + 2) {
			
			for(int count1 = 0; count1 < retrieve_dates_length; count1++ ){
				
				if (retrieve_ids_occurance[count + 1].equalsIgnoreCase("Y")) {//combo
					spParamVec.removeAllElements();
					spParamVec.add(matchId);
					spParamVec.add(userID);
					spParamVec.add(retrieve_ids_occurance[count]);
					spParamVec.add(request.getParameter(retrieve_ids_occurance[count]+"_"+retrieve_dates[count1]));
					spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter("rem_"+retrieve_ids_occurance[count]+"_"+retrieve_dates[count1])));
					spParamVec.add(reportId);
					spParamVec.add(retrieve_dates[count1]);
				} else if (retrieve_ids_occurance[count + 1].equalsIgnoreCase("N")) {//text
					spParamVec.add(matchId);
					spParamVec.add(userID);
					spParamVec.add(retrieve_ids_occurance[count]);
					spParamVec.add("0");
					spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter(retrieve_ids_occurance[count]+"_"+retrieve_dates[count1])));
					spParamVec.add(reportId);
					spParamVec.add(retrieve_dates[count1]);
				}
				
				try{
				messageCrs = generateStProc.GenerateStoreProcedure("esp_amd_pitchoutfield_for5day ",
					spParamVec, "ScoreDB");
				}catch (Exception e) {
						System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
						log.writeErrLog(page.getClass(),matchId,e.toString());
				}	
			}
			
			if (messageCrs.next()) {
				message = messageCrs.getString("retval");
				flag = "true";
			}
		}
		
//System.out.println("??????????????????????"+message);			
//----------------------------
	}

	//For Display Table Data
	spParamVec.removeAllElements();
	spParamVec.add(matchId); // match_id
	spParamVec.add(userID);
	
	try{
	umpiresCrs = generateStProc.GenerateStoreProcedure(
			"esp_dsp_getmatchofficialid", spParamVec, "ScoreDB");//to get official id of umpire
	}catch (Exception e) {
			System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
			log.writeErrLog(page.getClass(),matchId,e.toString());
	}
			
	if (umpiresCrs.next()) {
		umpireOfficialId = umpiresCrs.getString("official");
	}
	spParamVec.add(reportId); // report id
	
	try{
	displayCrs = generateStProc.GenerateStoreProcedure(
			"esp_dsp_pitchoutfield5day", spParamVec, "ScoreDB");//need to change
	}catch (Exception e) {
			System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
			log.writeErrLog(page.getClass(),matchId,e.toString());
	}
		//create new document

		try {
			document.open();
			document.add(new Paragraph("Pitch and Outfield Report - Five Days Game", new Font(Font.HELVETICA, 14)));
			document.add(new Paragraph(" "));
			if(matchSummeryCrs != null){  
				while(matchSummeryCrs.next()){
					document.add(new Paragraph("Match No : " + matchId, new Font(Font.HELVETICA, 12)));
					document.add(new Paragraph("Teams : " + matchSummeryCrs.getString("team1") + " Vs " + matchSummeryCrs.getString("team2"), new Font(Font.HELVETICA, 12)));
					document.add(new Paragraph("Venue : " + matchSummeryCrs.getString("venue"), new Font(Font.HELVETICA, 12)));
					String d1 = null;
					java.util.Date date = ddmmyyyy.parse(matchSummeryCrs.getString("displaymatchdate"));
					d1 = sdf.format(date);
					document.add(new Paragraph("Match Date : " + d1, new Font(Font.HELVETICA, 14)));
					document.add(new Paragraph("Name Of Tournament : " + matchSummeryCrs.getString("tournament"), new Font(Font.HELVETICA, 12)));
					document.add(new Paragraph("Name Of the Referee : " + matchSummeryCrs.getString("referee"), new Font(Font.HELVETICA, 12)));
					startDate = matchSummeryCrs.getString("startdate");//yyyy-mm-dd
					endDate = matchSummeryCrs.getString("enddate");//yyyy-mm-dd
					days = matchSummeryCrs.getInt("days");//days
					int startDay = Integer.parseInt(startDate.substring(8).trim());
		 			int startDayMonth = Integer.parseInt(startDate.substring(5,7).trim());
					int startDayYear = Integer.parseInt(startDate.substring(0,4).trim());
					String firstDate="";
		    		cal.set(startDayYear, (startDayMonth-1), startDay);
			    	cal.add(Calendar.DATE, 0);
			    	firstDate=new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
			    	allDays = firstDate+"~";
			    	for(int i=1;i< days;i++){
						cal.add(Calendar.DATE, 1);
				    	allDays = allDays + new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime())+"~";
					}
			    }
			}
			document.add(new Paragraph(" "));
			PdfPTable datatable = new PdfPTable(5);
			int headerwidths[] = { 6, 6, 6, 6, 6 };
			datatable.setWidths(headerwidths);
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);
			String[] allDaysArr = null;	 
			if (displayCrs != null) {

					int counter = 1;
					int occurance=0;
					allDaysArr = allDays.split("~");
					String description="";
					while (displayCrs.next()) {
					String scoreValues = displayCrs.getString("score_max").toString();
					String remarkData = displayCrs.getString("remark").toString();
					String[] scoreMaxArr = scoreValues.split("~");	
					String[] remarkArr = remarkData.split("~");	
					occurance = displayCrs.getInt("occurence");
					description = displayCrs.getString("description"); 
					description = description.replaceAll("&nbsp;","");
					description = description.replaceAll("<br>","");
					datatable.addCell(this.getLeftAllignedCell(description));
					if(occurance == 1){

						sbIds.append(displayCrs.getString("rolefacilityid"));
						sbIds.append(",");
						sbIds.append(displayCrs.getString("scoring_required"));
						sbIds.append(",");

					ids.add(displayCrs.getString("rolefacilityid"));
					ids.add(displayCrs.getString("scoring_required"));
					}else{//occurance >1 (4/5)
						sbIdsOccurance.append(displayCrs.getString("rolefacilityid"));
						sbIdsOccurance.append(",");
						sbIdsOccurance.append(displayCrs.getString("scoring_required"));
						sbIdsOccurance.append(",");

					
					}
					for(int i=1 ; i<=occurance ; i++){
						String value = "";
						String remark = "";
						if (displayCrs.getString("scoring_required").equalsIgnoreCase("Y")) {//for combo
							String[] valueArr = displayCrs.getString("cnames").toString().split(",");
							for (int count = valueArr.length; count > 0; count--) {
								if(scoreMaxArr[i-1].trim().equalsIgnoreCase(""+count)){
									
									value = valueArr[count - 1];
									
								}else{
									value = "";
								}
								
							}
							try{
								if(remarkArr[i-1].trim().equalsIgnoreCase("")){//remark1~remark2~remark3 so on
									
									 remark = remarkArr[i-1].trim();
								}else{
									 remark = remarkArr[i-1].trim();
								}
							
							}catch( ArrayIndexOutOfBoundsException e ) { 
								remark = "";
							
							}
							
						}else{
							remark = remarkArr[i-1].trim();
						}
						datatable.addCell(this.getLeftAllignedCell(value + " ("+ remark + ")"));
					}for(int i=occurance ; i<=3 ; i++){
						datatable.addCell(this.getLeftAllignedCell(""));
					}
					
			 }
					document.add(datatable);
			}			
		
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			document.close();
		}
	
%><%!private PdfPCell getBoldRightAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLD)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getBoldLeftAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getLeftAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getLeftAllignedCell(String name, int colspan) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setColspan(colspan);
		cell.setBorder(0);
		cell.setBorderWidth(0);
		return cell;
	}

	private PdfPCell getBoldCenterAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
		cell.setBorder(2);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getRightAllignedCellWoBorder(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorder(0);

		return cell;
	}

	private PdfPCell getLeftAllignedCellWoBorder(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorder(0);

		return cell;
	}

	private PdfPCell getRightAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);

		return cell;
	}

	private PdfPCell getRightAllignedCell(String name, int size) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, size, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}%>