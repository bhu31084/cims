<%@ page language="java" contentType="application/pdf"
	import="java.io.*,com.lowagie.text.pdf.*,com.lowagie.text.*,sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*,java.util.*,in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.common.*"%>
<%
	OutputStream os = response.getOutputStream();
	response.setHeader ("Content-Disposition", "attachment;	filename=UmpiresSelfAssessment.pdf");
	Document document = new Document(PageSize.A4, 50, 50, 50, 50);
	PdfWriter.getInstance(document, os);

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
		document.open();
		document.add(new Paragraph("Umpire's Self Assessment Report", new Font(Font.HELVETICA, 16)));

		if (matchSummeryCrs != null) {
			String umpire2name = null;
			String umpire1name = null;
			while (matchSummeryCrs.next()) {

				if (userID.equalsIgnoreCase(matchSummeryCrs.getString("umpire1Id"))) {
					umpire2name = matchSummeryCrs.getString("umpire2");
					if (umpire2name == null) {
						umpire2name = "-";
					}
				}

				document.add(new Paragraph("Partner Name: " + umpire2name == null ? " - " : umpire2name, new Font(Font.HELVETICA, 14)));

				document.add(new Paragraph("Teams : " + (matchSummeryCrs.getString("team1").trim().equalsIgnoreCase("null") ? "-" : matchSummeryCrs.getString("team1")) + " Vs " + (matchSummeryCrs.getString("team2").trim().equalsIgnoreCase("null") ? "-" : matchSummeryCrs.getString("team2")), new Font(Font.HELVETICA, 14)));

				document.add(new Paragraph("Venue : " + (matchSummeryCrs.getString("venue").trim().equalsIgnoreCase("null") ? "-" : matchSummeryCrs.getString("venue")), new Font(Font.HELVETICA, 14)));
				document.add(new Paragraph("Match type : " + (matchSummeryCrs.getString("matchtype").trim().equalsIgnoreCase("null") ? "-" : matchSummeryCrs.getString("matchtype")), new Font(Font.HELVETICA, 14)));

				if (umpireName1 == null || umpireName2 == null) {
					document.add(new Paragraph("Umpires : Umpires not assigned for this match", new Font(Font.HELVETICA, 14)));
				}

				document.add(new Paragraph("Match Id: " + matchId, new Font(Font.HELVETICA, 14)));

				document.add(new Paragraph(" ", new Font(Font.HELVETICA, 14)));

				if (umpireName1 != null || umpireName2 != null) {

					document.add(new Paragraph("", new Font(Font.HELVETICA, 14)));
					document.add(new Paragraph("Umpire's self-ratings & comments on their performance", new Font(Font.HELVETICA, 14)));

				}
			}

			document.add(new Paragraph(" ", new Font(Font.HELVETICA, 14)));

			PdfPTable datatable = new PdfPTable(3);
			int headerwidths[] = { 6, 6, 6 };
			datatable.setWidths(headerwidths);
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);

			datatable.addCell(this.getBoldRightAllignedCell("Umpires :"));
			datatable.addCell(this.getLeftAllignedCell(umpireName1 == null ? "-" : umpireName1));
			datatable.addCell(this.getLeftAllignedCell(umpireName2 == null ? "-" : umpireName2));

			if ((AdminUmp1 != null) && (AdminUmp2 != null)) {
				if ((AdminUmp1.size() > 0) && (AdminUmp2.size() > 0)) {
					int counter = 1;
					while (AdminUmp1.next() && AdminUmp2.next()) {
						datatable.addCell(this.getBoldLeftAllignedCell(AdminUmp1.getString("description")));

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
						datatable.addCell(this.getLeftAllignedCell(value + " : " + remark));

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

								datatable.addCell(this.getLeftAllignedCell(value + " : " + remark));
							}
						}
						counter++;
					}
				}
			}

			document.add(datatable);

		}

	} catch (Exception e) {

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