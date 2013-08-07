<!--
	Author 		 : Archana Dongre
	Created Date : 17/09/2008
	Description  : Display current match Player's Report.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
		try {
			String gsmatchid = (String) session.getAttribute("matchId");
			String gsinningId = null;

			String gsplayer = new String();

			String runs = "";
			CachedRowSet crsObjBowlerDetails = null;
			CachedRowSet crsObjBatsmanDetails = null;
			CachedRowSet crsObjInning = null;

			GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
			Vector val = new Vector();
			val.add(gsmatchid);
			crsObjInning = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getInnings", val, "ScoreDB");
			val.removeAllElements();
			gsplayer = request.getParameter("dpPlayer");
			if (request.getParameter("dpPlayer") != null) {
				if (request.getParameter("dpPlayer").equalsIgnoreCase("0")) {
					gsinningId = request.getParameter("dpinning");
					runs = "0";
					val.add(gsinningId);
					val.add(runs);
					crsObjBatsmanDetails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_batsmanruns", val,"ScoreDB");
					val.removeAllElements();
				}
				if (request.getParameter("dpPlayer").equalsIgnoreCase("1")) {
					gsinningId = request.getParameter("dpinning");
					val.add(gsinningId);
					val.add(gsmatchid);
					crsObjBowlerDetails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowlerwicket",val, "ScoreDB");
					val.removeAllElements();

				}
			}
			%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="application/xhtml+xml; charset=UTF-8" />
	<meta http-equiv="Cache-Control" content="no-cache" />
<title>Player Report</title>
</head>
<body>
<jsp:include page="MobileMenu.jsp"></jsp:include>
<form action="/cims/jsp/mobile/PlayerReport.jsp" method="post">
<table border="0" align="center" width="100%">
	<tr>
		<td align="center"><b>Inning Summary</b></td>
	</tr>
	<tr>
		<td>
		<hr>
		</td>
	</tr>
	<tr>
		<td align="center"><select id="dpinning" name="dpinning">
			<%if (crsObjInning != null) {
				while (crsObjInning.next()) {
					%>
			<%if (crsObjInning.getString("inning").equalsIgnoreCase(
							gsinningId)) {%>
			<option value="<%=crsObjInning.getString("inning")%>"
				selected="selected"><%=crsObjInning.getString("battingteam")%></option>
			<%} else {%>
			<option value="<%=crsObjInning.getString("inning")%>"><%=crsObjInning.getString("battingteam")%></option>
			<%
					}
				}
			}
%>
		</select><select id="dpPlayer" name="dpPlayer">						
			<option value="0" selected="selected">Batsman</option>
			<option value="1">Bowler</option>
		</select> <input type="submit" id="btnsearch" name="btnsearch"
			value="show"></td>
	</tr>
</table>
<%if (crsObjBatsmanDetails != null) {%> <BR>
<div id="batsmanDiv">
<table border="1" align="center" width="100%">
	<tr >
		<td><font size="2" ><b>Batsman</b></td>
		<td><font size="2" ><b>Runs</b></td>
		<td><font size="2" ><b>Balls</b></td>
		<td><font size="2" ><b>S/R</b></td>
	</tr>
	<%
				while (crsObjBatsmanDetails.next()) {
%>
	<tr>
		<td><font size="1" ><%=crsObjBatsmanDetails.getString("batsman")%></td>
		<td><font size="1" ><%=crsObjBatsmanDetails.getString("runs")%></td>
		<td><font size="1" ><%=crsObjBatsmanDetails.getString("balls")%></td>
		<td><font size="1" ><%=crsObjBatsmanDetails.getString("strike")%>%</td>
	</tr>
	<%
				}%>
</table>
</div>
<%}
			if (crsObjBowlerDetails != null) {%> <BR>
<div id="bowlerDiv">
<table border="1" align="center" width="100%">
	
	<tr>
		<td><font size="2" ><b>Bowler</b></td>
		<td><font size="2" ><b>Overs</b></td>
		<td><font size="2" ><b>Wickets</<b></td>
		<td><font size="2" ><b>Eco.</td></b>
	</tr>	
	<%while (crsObjBowlerDetails.next()) {%>
	<tr>
		<td><font size="1" ><%=crsObjBowlerDetails
											.getString("bowler_name")%></td>
		<td><font size="1" ><%=crsObjBowlerDetails.getString("noofover")%></td>
		<td><font size="1" ><%=crsObjBowlerDetails.getString("wicket")%></td>
		<td><font size="1" ><%=crsObjBowlerDetails.getString("eco")%>%</td>
	</tr>
	<%}%>
</table>
</div>
<%}%></form>
</body>
</html>
<%} catch (Exception e) {
			System.out.println(e);
		}%>
