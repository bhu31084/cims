<%@ page language="java" contentType="application/pdf"
	import="java.io.*,com.lowagie.text.pdf.*,com.lowagie.text.*,
	sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
	java.util.*,java.util.*,in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.common.*"%>
	
<%
	OutputStream os = response.getOutputStream();
	response.setHeader ("Content-Disposition", "attachment;	filename=RefereeReportOnUmpires.pdf");
	Document document = new Document(PageSize.A4, 50, 50, 50, 50);
	PdfWriter.getInstance(document, os);

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
			document.open();

			if (crsObjRefereeDetail.next()) {
				gsUmpire1Id = crsObjRefereeDetail.getString("umpireofficalid1");
				gsUmpire2Id = crsObjRefereeDetail.getString("umpireofficalid2");
				gsUmpireName1 = crsObjRefereeDetail.getString("umpire");
				gsUmpireName2 = crsObjRefereeDetail.getString("umpire2");
			}

			document.add(new Paragraph("Referee's Report on Umpires", new Font(Font.HELVETICA, 16)));
			document.add(new Paragraph(" "));
			document.add(new Paragraph("Match No : " + match_id, new Font(Font.HELVETICA, 14)));
			document.add(new Paragraph("Teams : " + crsObjRefereeDetail.getString("team1") + " Vs " + crsObjRefereeDetail.getString("team2"), new Font(Font.HELVETICA, 14)));

			document.add(new Paragraph("Name of the Zone : " + crsObjRefereeDetail.getString("zone"), new Font(Font.HELVETICA, 14)));
			document.add(new Paragraph("Venue : " + crsObjRefereeDetail.getString("venue"), new Font(Font.HELVETICA, 14)));
			String d1 = null;
			java.util.Date date = ddmmyyyy.parse(crsObjRefereeDetail.getString("date"));
			d1 = sdf.format(date);

			document.add(new Paragraph("Date : " + d1, new Font(Font.HELVETICA, 14)));
			document.add(new Paragraph("Name Of Tournament : " + crsObjRefereeDetail.getString("tournament"), new Font(Font.HELVETICA, 14)));

			document.add(new Paragraph(" "));
			document.add(new Paragraph("UMPIRING PERFORMANCE", new Font(Font.HELVETICA, 16)));
			document.add(new Paragraph(" "));
			document.add(new Paragraph("Match No : " + match_id, new Font(Font.HELVETICA, 14)));
			document.add(new Paragraph(" "));

			PdfPTable datatable = new PdfPTable(3);
			int headerwidths[] = { 6, 6, 6 };
			datatable.setWidths(headerwidths);
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);

			datatable.addCell(this.getBoldRightAllignedCell(" "));
			datatable.addCell(this.getBoldRightAllignedCell(gsUmpireName1));
			datatable.addCell(this.getBoldRightAllignedCell(gsUmpireName2));
/*
			datatable.addCell(this.getBoldRightAllignedCell(" "));
			datatable.addCell(this.getBoldRightAllignedCell("Scale"));
			datatable.addCell(this.getBoldRightAllignedCell("Scale"));
*/
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
/*
					if (crsObjViewDataUmp1.getString("scoring_required").equalsIgnoreCase("N")) {

						if (totalFlag.equalsIgnoreCase("false")) {
							totalFlag = "true";

							datatable.addCell(this.getBoldRightAllignedCell(" "));
							datatable.addCell(this.getBoldRightAllignedCell("Total Points : "));
							datatable.addCell(this.getBoldRightAllignedCell("Total Points : "));

							datatable.addCell(this.getBoldRightAllignedCell(" "));
							datatable.addCell(this.getBoldRightAllignedCell(gsUmpire1Id));
							datatable.addCell(this.getBoldRightAllignedCell(gsUmpire2Id));
						}
					}*/
					datatable.addCell(this.getBoldRightAllignedCell(crsObjViewDataUmp1.getString("description")));

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
						datatable.addCell(this.getLeftAllignedCell(value));
						value = "";
						int selectedVal2 = Integer.parseInt(crsObjViewDataUmp2.getString("selected")) - 1;
						for (int count = length - 1; count >= 0; count--) {
							if (strArr.length > count) {
								if (selectedVal2 == count) {
									value = strArr[count];
								}
							}
						}

						datatable.addCell(this.getLeftAllignedCell(value));
					} else {

						if (crsObjViewDataUmp1.getString("remark") != null) {
							datatable.addCell(this.getLeftAllignedCell(crsObjViewDataUmp1.getString("remark").trim()));
						} else {
							datatable.addCell(this.getLeftAllignedCell(" - "));
						}
						if (crsObjViewDataUmp2.getString("remark") != null) {
							datatable.addCell(this.getLeftAllignedCell(crsObjViewDataUmp2.getString("remark").trim()));
						} else {
							datatable.addCell(this.getLeftAllignedCell(" - "));
						}
					}
				}

			}

			document.add(datatable);

			datatable = new PdfPTable(10);
			int headerwidths1[] = { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };
			datatable.setWidths(headerwidths1);
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);

			document.add(new Paragraph(" "));
			document.add(new Paragraph("REPORT ON THE MATCH"));
			document.add(new Paragraph(" "));

			datatable.addCell(this.getBoldLeftAllignedCell("Name of Asscn."));
			datatable.addCell(this.getBoldLeftAllignedCell("Innings"));
			datatable.addCell(this.getBoldLeftAllignedCell("Runs Scored by the Asscn."));
			datatable.addCell(this.getBoldLeftAllignedCell("No. of Wickets fallen"));
			datatable.addCell(this.getBoldLeftAllignedCell("Total Time taken by Asscn."));
			datatable.addCell(this.getBoldLeftAllignedCell("Overs Bowled by Opponent Asscn."));
			datatable.addCell(this.getBoldLeftAllignedCell("Overs Bowled Short by Opponent Asscn."));
			datatable.addCell(this.getBoldLeftAllignedCell("Financial Penalty on Opponent Asscn."));
			datatable.addCell(this.getBoldLeftAllignedCell("Match Points(league level)"));
			datatable.addCell(this.getBoldLeftAllignedCell("Match Result(Knock Out Level)"));

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
			}// end of while

			document.add(datatable);

			document.add(new Paragraph(" "));
			document.add(new Paragraph("Summary of breaches of the code of conduct laid down by BCCI,if any."));
			document.add(new Paragraph(" "));

			datatable = new PdfPTable(4);
			int headerwidths2[] = { 2, 2, 2, 2 };
			datatable.setWidths(headerwidths2);
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);

			datatable.addCell(this.getBoldLeftAllignedCell("Player Name"));
			datatable.addCell(this.getBoldLeftAllignedCell("Level"));
			datatable.addCell(this.getBoldLeftAllignedCell("Offence"));
			datatable.addCell(this.getBoldLeftAllignedCell("Penalty"));

			if (crsObjOffencesDetail != null) {
				int Offencecounter = 1;
				while (crsObjOffencesDetail.next()) {

					datatable.addCell(this.getLeftAllignedCell(crsObjOffencesDetail.getString("playername")));
					datatable.addCell(this.getLeftAllignedCell(crsObjOffencesDetail.getString("breach_level")));
					datatable.addCell(this.getLeftAllignedCell(crsObjOffencesDetail.getString("description")));
					if (crsObjOffencesDetail.getString("reason").equals("25000")) {
						datatable.addCell(this.getLeftAllignedCell("Reprimind"));
					} else {
						if (crsObjOffencesDetail.getString("fee_percentage").equals("0")) {
							datatable.addCell(this.getLeftAllignedCell("Banned For " + crsObjOffencesDetail.getString("reason") + " Matches"));
						} else {
							datatable.addCell(this.getLeftAllignedCell(crsObjOffencesDetail.getString("reason") + " Fees"));
						}
					}
				} //end of while
			}//end of outer if

			document.add(datatable);
			
			document.add(new Paragraph(" "));
			
			datatable = new PdfPTable(2);
			int headerwidths3[] = { 2, 2};
			datatable.setWidths(headerwidths3);
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);
			
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

					if (crsObjGroundEquCrs.getString("parent").equalsIgnoreCase("0")) {
						datatable.addCell(this.getBoldLeftAllignedCell(crsObjGroundEquCrs.getString("description")));
						datatable.addCell(this.getBoldLeftAllignedCell(" "));
					} else {
						datatable.addCell(this.getLeftAllignedCell("      *    " + crsObjGroundEquCrs.getString("description")));
					}

					if (crsObjGroundEquCrs.getString("scoring_required").equalsIgnoreCase("Y")) {

						String[] strArr = crsObjGroundEquCrs.getString("cnames").toString().split(",");
						int length = Integer.parseInt(crsObjGroundEquCrs.getString("score_max").toString());

						int selectedVal1 = Integer.parseInt(crsObjGroundEquCrs.getString("selected")) - 1;

						for (int count = length - 1; count >= 0; count--) {

							if (strArr.length > count) {
								if (selectedVal1 == count) {
									datatable.addCell(this.getBoldLeftAllignedCell(strArr[count]));
								} else {
									//datatable.addCell(this.getBoldLeftAllignedCell(crsObjGroundEquCrs.getString("facilityid")));
								}
							}
						}
					}
				}
			}

			

			document.add(datatable);
			
			document.add(new Paragraph(" "));
			
			datatable = new PdfPTable(2);
			int headerwidths4[] = { 4, 2};
			datatable.setWidths(headerwidths4);
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);
			
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

					datatable.addCell(this.getBoldLeftAllignedCell(crsObjRefereeFields.getString("description")));

					if (crsObjRefereeFields.getString("scoring_required").equalsIgnoreCase("Y")) {
						String[] strArr = crsObjRefereeFields.getString("cnames").toString().split(",");
						int length = Integer.parseInt(crsObjRefereeFields.getString("score_max").toString());
						int selectedVal1 = Integer.parseInt(crsObjRefereeFields.getString("selected")) - 1;
						for (int count = length - 1; count >= 0; count--) {
							if (strArr.length > count) {
								if (selectedVal1 == count) {

									datatable.addCell(this.getLeftAllignedCell(strArr[count]));
								}
							}
						}
					} else {
						if (crsObjRefereeFields.getString("remark") != null) {
							datatable.addCell(this.getLeftAllignedCell(crsObjRefereeFields.getString("remark")));
						} else {
							//Blank
						}
					}

					refcounter++;
				}
			}
			document.add(datatable);

		} finally {
			document.close();
		}
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