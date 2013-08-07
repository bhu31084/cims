<%@ page language="java" contentType="application/pdf"
	import="java.io.*,com.lowagie.text.pdf.*,com.lowagie.text.*,sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*,java.util.*,in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.common.*"%><%
	OutputStream os = response.getOutputStream();
	response.setHeader ("Content-Disposition", "attachment;	filename=UmpireReport.pdf");
	Document document = new Document(PageSize.A4, 50, 50, 50, 50);
	PdfWriter.getInstance(document, os);

	String reportId = "4";
	String matchId = null;
	String userID = null;
	String loginUserId = null;
	String umpireOfficialId = null;
	StringBuffer sbIds = new StringBuffer();
	String series_name = null;
	String team1_name = null;
	String team2_name = null;
	String zone = null;
	String captain1 = null;
	String captain2 = null;
	String umpire1 = null;
	String umpire2 = null;
	String umpire_name = null;
	String strMessage = null;
	String match_no = null;

	matchId = session.getAttribute("matchid").toString();
	String user = (String) session.getAttribute("userid");
	loginUserId = (String) session.getAttribute("usernamesurname").toString();
	String userRole = session.getAttribute("role").toString();

	CachedRowSet matchInfoCachedRowSet = null;
	CachedRowSet crsObjmatchreport = null;
	CachedRowSet submitCrs = null;
	CachedRowSet displayCrs = null;
	CachedRowSet umpiresCrs = null;
	CachedRowSet useridCrs = null;
	CachedRowSet messageCrs = null;
	Vector spParamVec = new Vector();
	ReplaceApostroph replaceApos = new ReplaceApostroph();
	GenerateStoreProcedure generateStProc = new GenerateStoreProcedure();

	spParamVec.add(matchId);//(String)session.getAttribute("matchId"));
	spParamVec.add(user);
	matchInfoCachedRowSet = generateStProc.GenerateStoreProcedure("esp_dsp_umpires_report", spParamVec, "ScoreDB");

	while (matchInfoCachedRowSet.next()) {
		series_name = matchInfoCachedRowSet.getString("series_name");
		team1_name = matchInfoCachedRowSet.getString("team1_name");
		team2_name = matchInfoCachedRowSet.getString("team2_name");
		match_no = matchInfoCachedRowSet.getString("match_no");
		zone = matchInfoCachedRowSet.getString("zone");
		captain1 = matchInfoCachedRowSet.getString("captain1");
		captain2 = matchInfoCachedRowSet.getString("captain2");
		umpire1 = matchInfoCachedRowSet.getString("umpire1");
		umpire2 = matchInfoCachedRowSet.getString("umpire2");
		umpire_name = matchInfoCachedRowSet.getString("umpire_name");
	}
	spParamVec.removeAllElements();

	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	Vector ids = new Vector();

	//for match details in top table
	spParamVec.add(matchId); // match_id		
	useridCrs = generateStProc.GenerateStoreProcedure("esp_dsp_getmatchuserid", spParamVec, "ScoreDB");

	if (useridCrs != null) {
		if (useridCrs.next()) {
			userID = useridCrs.getString("id");
		}
	}

	if (request.getParameter("hid") != null && request.getParameter("hid").equalsIgnoreCase("1")) {

		System.out.println("ids : " + request.getParameter("hidden_ids"));
		String[] retrieve_ids = request.getParameter("hidden_ids").split(",");
		int retrieve_ids_length = retrieve_ids.length;
		umpireOfficialId = request.getParameter("umpire");

		for (int count = 0; count < retrieve_ids_length; count = count + 2) {
			System.out.println(request.getParameter(retrieve_ids[count]) + " : " + retrieve_ids[count + 1]);
			spParamVec = new Vector();
			spParamVec.add(matchId);
			spParamVec.add(userID);
			spParamVec.add(retrieve_ids[count]);

			if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {//combo
				spParamVec.add(request.getParameter(retrieve_ids[count]));
				spParamVec.add(replaceApos.replacesingleqt((String) request.getParameter("rem_" + retrieve_ids[count])));
			} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {//text
				spParamVec.add("0");
				spParamVec.add(replaceApos.replacesingleqt((String) request.getParameter("rem_" + retrieve_ids[count])));
			}
			spParamVec.add("");//admin remark
			spParamVec.add(reportId);

			messageCrs = generateStProc.GenerateStoreProcedure("esp_amd_pitchoutfield", spParamVec, "ScoreDB");
			while (messageCrs.next()) {
				strMessage = messageCrs.getString("RetVal");
			}
		}
	}

	//For Display Table Data
	spParamVec.removeAllElements();
	spParamVec.add(matchId); // match_id
	spParamVec.add(userID);
	umpiresCrs = generateStProc.GenerateStoreProcedure("esp_dsp_getmatchofficialid", spParamVec, "ScoreDB");//to get official id of umpire
	if (umpiresCrs.next()) {
		umpireOfficialId = umpiresCrs.getString("official");
	}

	spParamVec.add(reportId); // report id
	displayCrs = generateStProc.GenerateStoreProcedure("esp_dsp_pitchoutfieldoneday", spParamVec, "ScoreDB");

	spParamVec.removeAllElements();
	spParamVec.add(matchId);
	crsObjmatchreport = generateStProc.GenerateStoreProcedure("esp_dsp_referee_match_report", spParamVec, "ScoreDB");
	spParamVec.removeAllElements();

	try {
		document.open();
		document.add(new Paragraph("Umpire's Report", new Font(Font.HELVETICA, 16)));
		document.add(new Paragraph(" ", new Font(Font.HELVETICA, 16)));

		document.add(new Paragraph("Tournament : " + series_name, new Font(Font.HELVETICA, 14)));
		document.add(new Paragraph("Match No : " + match_no, new Font(Font.HELVETICA, 14)));
		document.add(new Paragraph("Zone : " + zone != null ? zone : "", new Font(Font.HELVETICA, 14)));
		document.add(new Paragraph("Captain (Team1) : " + captain1 + " (" + team1_name + ")", new Font(Font.HELVETICA, 14)));
		document.add(new Paragraph("Captain (Team2) : " + captain2 + " (" + team2_name + ")", new Font(Font.HELVETICA, 14)));
		document.add(new Paragraph("Umpires : " + umpire1 + " and " + umpire2, new Font(Font.HELVETICA, 14)));
		document.add(new Paragraph(" ", new Font(Font.HELVETICA, 16)));

		PdfPTable datatable = new PdfPTable(3);
		int headerwidths[] = { 10, 4, 10 };
		datatable.setWidths(headerwidths);
		datatable.setWidthPercentage(100);
		datatable.getDefaultCell().setPadding(2);
		if (displayCrs != null) {
			int counter = 1;
			while (displayCrs.next()) {
				sbIds.append(displayCrs.getString("facilityid"));
				sbIds.append(",");
				sbIds.append(displayCrs.getString("scoring_required"));
				sbIds.append(",");

				ids.add(displayCrs.getString("facilityid"));
				ids.add(displayCrs.getString("scoring_required"));

				datatable.addCell(this.getBoldLeftAllignedCell(". " + displayCrs.getString("description")));

				String value = " - ";

				if (displayCrs.getString("scoring_required").equalsIgnoreCase("Y")) { //for combo
					String[] valueArr = displayCrs.getString("cnames").toString().split(",");

					for (int count = valueArr.length; count > 0; count--) {
						if (displayCrs.getString("selected").equalsIgnoreCase("" + count)) {
							value = valueArr[count - 1];
						}
					}
					datatable.addCell(this.getLeftAllignedCell(value));

					if (displayCrs.getString("remark").trim().equalsIgnoreCase("")) {
						datatable.addCell(this.getLeftAllignedCell(" "));
					} else {
						datatable.addCell(this.getLeftAllignedCell(displayCrs.getString("remark")));
					}
				} else {
					datatable.addCell(this.getLeftAllignedCell(" "));
					if (displayCrs.getString("remark").trim().equalsIgnoreCase("")) {
						datatable.addCell(this.getLeftAllignedCell(" "));
					} else {
						datatable.addCell(this.getLeftAllignedCell(displayCrs.getString("remark")));
					}

				}
				counter++;
			}
		}

		document.add(datatable);

		document.add(new Paragraph(" "));
		document.add(new Paragraph("REPORT ON THE MATCH"));
		document.add(new Paragraph(" "));

		datatable = new PdfPTable(10);
		int headerwidths1[] = { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
		datatable.setWidths(headerwidths1);
		datatable.setWidthPercentage(100);
		datatable.getDefaultCell().setPadding(2);

		datatable.addCell(this.getLeftAllignedCell("Name of Asscn."));
		datatable.addCell(this.getLeftAllignedCell("Innings"));
		datatable.addCell(this.getLeftAllignedCell("Runs Scored by the Asscn."));
		datatable.addCell(this.getLeftAllignedCell("No. of Wickets fallen"));
		datatable.addCell(this.getLeftAllignedCell("Total Time taken by Asscn."));
		datatable.addCell(this.getLeftAllignedCell("Overs Bowled by Opponent Asscn."));
		datatable.addCell(this.getLeftAllignedCell("Overs Bowled Short by Opponent Asscn."));
		datatable.addCell(this.getLeftAllignedCell("Financial Penalty on Opponent Asscn."));
		datatable.addCell(this.getLeftAllignedCell("Match Points(league level)"));
		datatable.addCell(this.getLeftAllignedCell("Match Result(Knock Out Level)"));

		while (crsObjmatchreport.next()) {

			datatable.addCell(this.getLeftAllignedCell(crsObjmatchreport.getString("nameofasscn")));
			datatable.addCell(this.getLeftAllignedCell(crsObjmatchreport.getString("innings")));
			datatable.addCell(this.getLeftAllignedCell(crsObjmatchreport.getString("runsscored")));
			datatable.addCell(this.getLeftAllignedCell(crsObjmatchreport.getString("noofwkt")));
			datatable.addCell(this.getLeftAllignedCell(crsObjmatchreport.getString("totaltime")));
			datatable.addCell(this.getLeftAllignedCell(crsObjmatchreport.getString("overbowled")));
			datatable.addCell(this.getLeftAllignedCell(crsObjmatchreport.getString("overbowledshort")));
			datatable.addCell(this.getLeftAllignedCell("Rs."));
			datatable.addCell(this.getLeftAllignedCell(crsObjmatchreport.getString("matchpoint")));
			datatable.addCell(this.getLeftAllignedCell(crsObjmatchreport.getString("matchresult")));
		}
		document.add(datatable);
	} catch (Exception e) {
		System.out.println(e);
		e.printStackTrace();
	} finally {
		document.close();
		os.flush();

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