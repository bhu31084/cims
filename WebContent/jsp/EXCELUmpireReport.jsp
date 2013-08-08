<%@ page contentType="application/vnd.ms-excel"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.common.*"%>

<%
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
				//spParamVec.add(request.getParameter("rem_"+retrieve_ids[count]));
				spParamVec.add(replaceApos.replacesingleqt((String) request.getParameter("rem_" + retrieve_ids[count])));
				//replaceApos.replacesingleqt((String)
			} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {//text
				spParamVec.add("0");
				//spParamVec.add(request.getParameter("rem_"+retrieve_ids[count]));
				spParamVec.add(replaceApos.replacesingleqt((String) request.getParameter("rem_" + retrieve_ids[count])));
			}
			spParamVec.add(""); // admin remark
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
%>
<html>
<head>
<title>Feedback REPORT submitted by Umpire</title>
</head>
<body>
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<tr>
		<td colspan="9" bgcolor="#FFFFFF" class="legend">Umpire's Report</td>
	</tr>

	<tr>
		<td colspan="2" width="90%" class="contentDark" align="right"><b><%=loginUserId%>&nbsp;&nbsp;&nbsp;DATE
		:</b> <%=sdf.format(new Date())%></td>
	</tr>
	<tr class="contentLight">
		<td width="15%">Tournament:</td>
		<td width="80%"><%=series_name%></td>
	</tr>
	<tr class="contentDark">
		<td width="15%">Match:</td>
		<td width="80%"><%=team1_name%> v/s <%=team2_name%></td>
	</tr>
	<tr class="contentLight">
		<td width="15%">Match No.:</td>
		<td width="80%"><%=match_no%></td>
	</tr>
	<tr class="contentDark">
		<td width="15%">Zone:</td>
		<td width="80%">
		<%
			if (zone != null) {
		%> <%=zone%> <%
 	} else {
 %> <input type="text" name="txtZone" id="txtZone" value=""
			readonly="readonly"> <%
 	}
 %>
		</td>
	</tr>
	<tr class="contentLight">
		<td width="15%">Captain Team1:</td>

		<td width="80%"><%=captain1%> - (<%=team1_name%>)</td>
	</tr>
	<tr tr class="contentDark">
		<td width="15%">Captain Team2 :</td>
		<td width="85%"><%=captain2%> - (<%=team2_name%>)</td>
	</tr>
	<tr class="contentLight">
		<td width="15%">Umpires:</td>
		<td width="85%"><%=umpire1%> and <%=umpire2%></td>
	</tr>
	<tr align="left">
		<td class="message">
		<%
			if (messageCrs != null) {
		%> <b style="color: red"> <%=strMessage%> </b> <%
 	}
 %>
		</td>
	</tr>
</table>
<br>

<table width="100%" border="1" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<%
		if (displayCrs != null) {
			int counter = 1;
			while (displayCrs.next()) {
				sbIds.append(displayCrs.getString("facilityid"));
				sbIds.append(",");
				sbIds.append(displayCrs.getString("scoring_required"));
				sbIds.append(",");

				ids.add(displayCrs.getString("facilityid"));
				ids.add(displayCrs.getString("scoring_required"));

				if (counter % 2 != 0) {
	%>
	<tr class="contentDark">
		<%
			} else {
		%>
		<tr class="contentLight">
			<%
				}
			%>
			<td id="que_<%=displayCrs.getString("facilityid")%>"><b>.&nbsp;<%=displayCrs.getString("description")%></b></td>

			<td>
			<%
				if (displayCrs.getString("scoring_required").equalsIgnoreCase("Y")) {//for combo
							String[] valueArr = displayCrs.getString("cnames").toString().split(",");
							String value = "";

							for (int count = valueArr.length; count > 0; count--) {
								if (displayCrs.getString("selected").equalsIgnoreCase("" + count)) {
									value = valueArr[count - 1];
								}
							}
			%> <%=value%> <%
 	if (displayCrs.getString("remark").trim().equalsIgnoreCase("")) {
 %> <%=""%> <%
 	} else {
 %> <%=displayCrs.getString("remark")%> <%
 	}
 			} else {

 				if (displayCrs.getString("remark").trim().equalsIgnoreCase("")) {
 %> <%=""%> <%
 	} else {
 %><%=displayCrs.getString("remark").trim()%> <%
 	}

 			}
 %>
			</td>
			<%
				if (!(userRole.equals("9"))) {
						}
			%>
		</tr>
		<%
			counter++;
				}
			}
		%>
	
</table>

<br>
<br>
<br>

<center><u><b>REPORT ON THE MATCH</b></u></center>
<table width="780" border="1" align="center" cellpadding="6"
	cellspacing="1" class="table">
	<tr class="contentLight">
		<td><b>Name of Asscn.</b></td>
		<td><b>Innings.</b></td>
		<td><b>Runs Scored by the Asscn.</b></td>
		<td><b>No. of Wickets fallen </b></td>
		<td><b>Total Time taken by Asscn.</b></td>
		<td><b>Overs Bowled by Opponent Asscn.</b></td>
		<td><b>Overs Bowled Short by Opponent Asscn.</b></td>
		<td><b>Financial Penalty on Opponent Asscn.</b></td>
		<td><b>Match Points(league level)</b></td>
		<td><b>Match Result(Knock Out Level)</b></td>
	</tr>
	<%
		while (crsObjmatchreport.next()) {
	%>
	<tr>
		<td align="left"><%=crsObjmatchreport.getString("nameofasscn")%></td>
		<td align="right"><%=crsObjmatchreport.getString("innings")%></td>
		<td align="right"><%=crsObjmatchreport.getString("runsscored")%></td>
		<td align="right"><%=crsObjmatchreport.getString("noofwkt")%></td>
		<td align="right"><%=crsObjmatchreport.getString("totaltime")%></td>
		<td align="right"><%=crsObjmatchreport.getString("overbowled")%></td>
		<td align="right"><%=crsObjmatchreport.getString("overbowledshort")%></td>
		<td align="right"><b>Rs.</b></td>
		<td align="right"><%=crsObjmatchreport.getString("matchpoint")%></td>
		<td align="left"><%=crsObjmatchreport.getString("matchresult")%></td>
	</tr>
	<%
		}// end of while
	%>
</table>
NOTE : Please enter maximum 500 characters for remark.
<br>

</body>
</html>

