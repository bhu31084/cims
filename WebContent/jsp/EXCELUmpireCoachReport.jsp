<%@ page contentType="application/vnd.ms-excel"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="response/error_page.jsp"%>
<%@ page import="in.co.paramatrix.common.*"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="java.sql.SQLException"%>
<%
	try {
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
		//System.out.println("Match id"+match_id);			
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
					//						//System.out.println(match_id);										
					vparam.add(coach_id);
					//						//System.out.println(coach_id);
					vparam.add(umpire_id);
					//						//System.out.println(umpire_id);
					vparam.add(retrieve_ids[count]);
					//						//System.out.println(retrieve_ids[count]);
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
%>
<html>
<head>
</head>

<body>

<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<tr>
		<td colspan="2" bgcolor="#FFFFFF" class="legend">Umpire Coach's
		Match Report</td>
	</tr>
	<tr>
		<td colspan="2" width="90%" class="contentDark" colspan="2"
			align="right"><b><%=loginUserId%>&nbsp;&nbsp;&nbsp;DATE :</b> <%=sdf1.format(new Date())%></td>
	</tr>

	<tr class="contentLight">
		<td width="15%"><b>MATCH ID:</b></td>
		<td align="left"><%=match_id%></td>
	</tr>
	<tr class="contentLight">
		<td width="15%"><b>MATCH:</b></td>
		<td align="left"><%=matchType%></td>
	</tr>

</table>


<table width="100%" border="1" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<%
		String strId = null;
			boolean init = false;
			if (crsObjUmpires.size() == 0) {
	%>
	<font size="3" color="#003399">Umpire not assigned for this
	match</font>
	<%
		} else {

				if (crsObjUmpires.size() > 0) {
					while (crsObjUmpires.next()) {

						strId = crsObjUmpires.getString("id");
						String username = crsObjUmpires.getString("user_name");
						//crsObjUmpires.getString("id")
						//
	%>



	<%
		//start
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
	%>



	<%
		if (strId != null) {
	%>

	<tr align="left">
		<td><b> Umpire </b></td>
		<td align="left"><%=username%></td>
		<td colspan="3"></td>
	</tr>

	<tr align="left">
		<td colspan="3">
		<hr />
		</td>
	</tr>

	<tr align="left">
		<td><b> Description</b></td>
		<td colspan="2"><b> Rating by Umpire Coach</b></td>
		<td><b>Self Rating by Umpire</b></td>
		<td><b>Remark</b></td>
	</tr>
	<%
		}
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
	%>
	<tr>

		<TD><%=crsObjViewData.getString("description")%></TD>

		<TD>
		<%
			if (crsObjViewData.getString("scoring_required").equalsIgnoreCase("Y")) {
									String[] strArr = crsObjViewData.getString("cnames").toString().split(",");
									int length = Integer.parseInt(crsObjViewData.getString("score_max").toString());
									String value = "";

									int selectedVal = Integer.parseInt(crsObjViewData.getString("selected")) - 1;

									for (int count = length - 1; count >= 0; count--) {
										if (strArr.length > count) {
											if (selectedVal == count) {
												value = strArr[count];
											}

										} else if (strArr.length <= count) {
											if (selectedVal == count) {
												value = (count + 1) + "";
											}
										}
									}
		%>
		</td>



		<td>
		<%
			if (crsObjViewData.getString("remark").trim().equalsIgnoreCase("")) {
		%> <%=crsObjViewData.getString("remark").trim()%> <%
 	} else {
 %> <%=crsObjViewData.getString("remark").trim()%> <%
 	}
 							//remark
 						} else {
 %>
 
 </td>
		<td>
		<%
			if (crsObjViewData.getString("remark").trim().equalsIgnoreCase("")) {
		%> <%=crsObjViewData.getString("remark").trim()%> <%
 	} else {
 %> <%=crsObjViewData.getString("remark").trim()%> <%
 	}

 						}
 %>
		</TD>

		<td>
		<%
			if (crsObjUmpireData.getString("scoring_required").equalsIgnoreCase("Y")) {
									String[] valueArr = crsObjUmpireData.getString("cnames").toString().split(",");
									for (int count = valueArr.length; count > 0; count--) {
										if (crsObjUmpireData.getString("selected").equalsIgnoreCase("" + count)) {
		%> <label><%=valueArr[count - 1]%></label> <%
 	} else {
 									out.println(" - ");
 								}
 							}
 						} else {
 							out.println(" - ");
 						}
 %>
		</td>
		<td>
		<%
			if (crsObjUmpireData.getString("remark") != null) {
		%><%=crsObjUmpireData.getString("remark")%>
		<%
			} else {
									out.println(" - ");
								}
		%>
		</td>
	</TR>
	<%
		}
	%>


	<tr align="left">
		<td colspan="5"></b></td>
	</tr>

	<tr align="left">
		<td colspan="5"></b></td>
	</tr>



	<%
		}//end while
				}

			}
	%>
</table>




NOTE : Please enter maximum 500 characters for remark.


</body>

</html>
<%
	} catch (SQLException e) {
		//System.out.println(e.toString());
		e.printStackTrace();
		//throw e;
	} catch (Exception e) {
		//System.out.println(e.toString());
		e.printStackTrace();
		//throw e;
	}
%>
