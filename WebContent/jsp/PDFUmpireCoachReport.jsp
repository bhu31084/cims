<%@ page language="java" contentType="application/pdf"
	import="java.io.*,com.lowagie.text.pdf.*,com.lowagie.text.*,sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*,java.util.*,in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.common.*"%><%
	OutputStream os = response.getOutputStream();
	response.setHeader ("Content-Disposition", "attachment;	filename=UmpireCoachReport.pdf");
	Document document = new Document(PageSize.A4, 50, 50, 50, 50);
	PdfWriter.getInstance(document, os);

	String report_id = "1";
	String strMessage = null;
	String loginUserId = null;
	CachedRowSet crsObjDetails = null;
	CachedRowSet crsObjUmpires = null;
	CachedRowSet crsObjViewData = null;
	CachedRowSet crsObjMessage = null;
	CachedRowSet crsObjUmpireData = null;
	CachedRowSet crsObjUmpireCoachAdmin = null;
	String matchType = null;
	String match_id = null;
	String coach_id = null;
	String coach_id_admin = null;
	ReplaceApostroph replaceApos = new ReplaceApostroph();

	match_id = session.getAttribute("matchid").toString();
	System.out.println("Match id" + match_id);
	String userRole = session.getAttribute("role").toString();
	//out.println(match_id);
	coach_id = session.getAttribute("userid").toString();
	loginUserId = (String) session.getAttribute("usernamesurname").toString();
	//out.println(coach_id);			
	//coach_id = "34285";

	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(match_id);

	Vector vparam = new Vector();

	String umpire_id = null;

	if (userRole.equalsIgnoreCase("9")) {
		vparam.add(match_id);
		vparam.add("6");
		crsObjUmpireCoachAdmin = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getMatchConcerns", vparam, "ScoreDB");
		vparam.removeAllElements();
	}

	if (crsObjUmpireCoachAdmin != null) {
		while (crsObjUmpireCoachAdmin.next()) {

			coach_id_admin = crsObjUmpireCoachAdmin.getString("id");
		}
	}

	if (request.getParameter("hid") != null) {
		if (request.getParameter("hid").equalsIgnoreCase("1")) {

			String[] retrieve_ids = request.getParameter("hidden_ids").split(",");
			int retrieve_ids_length = retrieve_ids.length;

			umpire_id = request.getParameter("umpireName");

			for (int count = 0; count < retrieve_ids_length; count = count + 2) {
				vparam = new Vector();
				vparam.add(match_id);				
				vparam.add(coach_id);
				vparam.add(umpire_id);
				vparam.add(retrieve_ids[count]);
				if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
					vparam.add(request.getParameter(retrieve_ids[count]));
					vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_" + retrieve_ids[count])));//
				} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {
					vparam.add("0");
					vparam.add(replaceApos.replacesingleqt((String) request.getParameter("rem_" + retrieve_ids[count])));
				}
				vparam.add(report_id);
				crsObjMessage = lobjGenerateProc.GenerateStoreProcedure("esp_amd_userappraisal", vparam, "ScoreDB");
				while (crsObjMessage.next()) {
					strMessage = crsObjMessage.getString("RetVal");
				}
			}
		} else if (request.getParameter("hid").equalsIgnoreCase("2")) {
			umpire_id = request.getParameter("umpireName");
		}
	}

	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("yyyy-MMM-dd hh:mm");

	Vector ids = new Vector();

	StringBuffer sbIds = new StringBuffer();

	vparam = new Vector();

	vparam.add(match_id);
	crsObjDetails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpirecoach_report", vparam, "ScoreDB");
	crsObjUmpires = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getUmpires", vparam, "ScoreDB");

	if (crsObjDetails.next()) {
		matchType = crsObjDetails.getString("team1_name") + " v/s " + crsObjDetails.getString("team2_name");
	}

	document.open();
	document.add(new Paragraph("Umpire Coach's Match Report", new Font(Font.HELVETICA, 16)));
	document.add(new Paragraph(" "));
	document.add(new Paragraph("Match Id : " + match_id, new Font(Font.HELVETICA, 14)));
	document.add(new Paragraph("Match : " + matchType, new Font(Font.HELVETICA, 14)));

	if (crsObjUmpires.size() == 0) {
		document.add(new Paragraph("Umpire not assigned for this match" + matchType, new Font(Font.HELVETICA, 14)));
	} else {
		String strId = null;
		boolean init = false;
		while (crsObjUmpires.next()) {

			if (!init) {
				strId = crsObjUmpires.getString("id");
				init = true;
			}
			document.add(new Paragraph(" "));
			document.add(new Paragraph("Umpire Name : " + crsObjUmpires.getString("user_name"), new Font(Font.HELVETICA, 14)));
			document.add(new Paragraph(" "));

			if (strId != null) {
				vparam = new Vector();
				vparam.add(strId);//strId);			// Put umpire user id
				crsObjViewData = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_useridfrom", vparam, "ScoreDB");
				String UmpireUserId = null;
				if (crsObjViewData != null && crsObjViewData.next()) {
					UmpireUserId = crsObjViewData.getString("id");
				}
				//end
				vparam = new Vector();
				vparam.add(match_id);
				vparam.add(UmpireUserId);//strId);			// Put umpire user id
				vparam.add(strId);//strId);			// Put  umpire official id
				vparam.add("7");
				crsObjUmpireData = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpirereports", vparam, "ScoreDB");
			}

			PdfPTable datatable = new PdfPTable(5);
			int headerwidths[] = { 7, 5, 9, 5, 9 };
			datatable.setWidths(headerwidths);
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);
			datatable.addCell(this.getLeftAllignedCell("Description"));
			PdfPCell cell = this.getLeftAllignedCell("Rating by Umpire Coach");
			cell.setColspan(2);
			datatable.addCell(cell);
			datatable.addCell(this.getLeftAllignedCell("Self Rating by Umpire"));
			datatable.addCell(this.getLeftAllignedCell("Remark"));

			vparam = new Vector();
			vparam.add(match_id);
			if (userRole.equals("9")) {
				vparam.add(coach_id_admin);
			} else {
				vparam.add(coach_id);
			}
			vparam.add(strId);
			vparam.add(report_id);
			crsObjViewData = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpirereports", vparam, "ScoreDB");
			int counter = 1;

			while (crsObjViewData.next() && crsObjUmpireData.next()) {
				sbIds.append(crsObjViewData.getString("id"));
				sbIds.append(",");
				sbIds.append(crsObjViewData.getString("scoring_required"));
				sbIds.append(",");

				ids.add(crsObjViewData.getString("id"));
				ids.add(crsObjViewData.getString("scoring_required"));

				datatable.addCell(this.getLeftAllignedCell(crsObjViewData.getString("description")));

				if (crsObjViewData.getString("scoring_required").equalsIgnoreCase("Y")) {
					String[] strArr = crsObjViewData.getString("cnames").toString().split(",");
					int length = Integer.parseInt(crsObjViewData.getString("score_max").toString());

					int selectedVal = Integer.parseInt(crsObjViewData.getString("selected")) - 1;

					String value = " - ";
					for (int count = length - 1; count >= 0; count--) {
						if (strArr.length > count) {
							if (selectedVal == count) {
								value = strArr[count];
							}

						} else if (strArr.length <= count) {
							if (selectedVal == count) {
								value = (count + 1) + " - ";
							}
						}
					}
					
					datatable.addCell(this.getLeftAllignedCell(value));

					datatable.addCell(this.getLeftAllignedCell(crsObjViewData.getString("remark").trim()));

					if (crsObjUmpireData.getString("scoring_required").equalsIgnoreCase("Y")) {
						String[] valueArr = crsObjUmpireData.getString("cnames").toString().split(",");
						for (int count = valueArr.length; count > 0; count--) {
							if (crsObjUmpireData.getString("selected").equalsIgnoreCase("" + count)) {
								datatable.addCell(this.getLeftAllignedCell(valueArr[count - 1]));
							}
						}
					}

					if (crsObjUmpireData.getString("remark") != null) {
						datatable.addCell(this.getLeftAllignedCell(crsObjUmpireData.getString("remark")));
					} else {
						datatable.addCell(this.getLeftAllignedCell(" - "));
					}

				}
			}
			document.add(datatable);
		}
	}
	document.close();
	os.flush();
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