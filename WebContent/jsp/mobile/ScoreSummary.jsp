<!--
	Author 		 : Saudagar Mulik
	Created Date : 17/09/2008
	Description  : Display current match score summry.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%if(request.getParameter("matchid")!= null){
	System.out.println("getting match id is "+ request.getParameter("matchid"));
		String MatchId = request.getParameter("matchid");
		session.setAttribute("matchId",MatchId);
	}
		try {

			String match_id = (String) session.getAttribute("matchId");
			CachedRowSet crsObjDetails = null;
			CachedRowSet crsObjInning = null;

			GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(
					match_id);

			Vector val = new Vector();
			val = new Vector();
			val.add(match_id);
			crsObjDetails = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_scorercard_summary", val, "ScoreDB");
			if (crsObjDetails != null && crsObjDetails.next()) {
%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="application/xhtml+xml; charset=UTF-8" />
<meta http-equiv="Cache-Control" content="no-cache" />
<title><%=crsObjDetails.getString("Team1")%> Vs. <%=crsObjDetails.getString("Team2")%></title>

</head>
<body>
<jsp:include page="MobileMenu.jsp"></jsp:include>
<form action="/cims/jsp/mobile/ScoreSummary.jsp" method="post">

<B>Live Scorecard</B>&nbsp; &nbsp; &nbsp;<input type="submit" value="Refresh" />
<HR>
<MARQUEE behavior="alternate"><B><u><%=crsObjDetails.getString("Team1")%>
Vs. <%=crsObjDetails.getString("Team2")%></U></B></MARQUEE>
<HR>
<DIV style="width: 100%" title="Match Summary">
<table style="width: 100%;" border="1" title="Live Score"
	cellspacing="1" cellpadding="1">
	<TR align="left">
		<%if (crsObjDetails.getString("inning").equals("0")) {%>
		<TD align="center" colspan="2"><B>Inning is not started.</B></TD>
		<%} else {%>
		<TD align="center" colspan="2"><B>* <%=crsObjDetails.getString("batting")%>
		- Inning <%=crsObjDetails.getString("inning")%></B></TD>
		<%}%>
	<TR>
	<TR align="left">
		<TD align="left">Score</TD>
		<TD align="right"><B><%=crsObjDetails.getString("total")%>/<%=crsObjDetails.getString("wkts")%>
		in <%=crsObjDetails.getString("overs")%> Overs</B></TD>
	<TR>
		<%if (crsObjDetails.getString("change_strike") != null
						&& crsObjDetails.getString("change_strike").equals("0")) {%>
	<TR align="left">
		<TD align="left">* <%=crsObjDetails.getString("striker")%></TD>
		<TD align="right"><B><%=crsObjDetails.getString("Striker_Score")%>
		Runs</B></TD>
	<TR>
	<TR align="left">
		<TD align="left"><%=crsObjDetails.getString("nonstriker")%></TD>
		<TD align="right"><B><%=crsObjDetails.getString("NonStriker_Score")%>
		Runs</B></TD>
	<TR>
		<%} else if (crsObjDetails.getString("change_strike") != null
						&& crsObjDetails.getString("change_strike").equals("1")) {%>
	<TR align="left">
		<TD align="left"><%=crsObjDetails.getString("striker")%></TD>
		<TD align="right"><B><%=crsObjDetails.getString("Striker_Score")%>
		Runs</B></TD>
	<TR>
	<TR align="left">
		<TD align="left">* <%=crsObjDetails.getString("nonstriker")%></TD>
		<TD align="right"><B><%=crsObjDetails.getString("NonStriker_Score")%>
		Runs</B></TD>
	<TR>
		<%} else {%>
	<TR align="left">
		<TD align="left"></TD>
		<TD align="right"><B><%=crsObjDetails.getString("Striker_Score")%>
		Runs</B></TD>
	<TR>
	<TR align="left">
		<TD align="left"></TD>
		<TD align="right"><B><%=crsObjDetails.getString("NonStriker_Score")%>
		Runs</B></TD>
	<TR>
		<%}%>
</table>
</DIV>
<HR>
<input type="hidden" name="matchid" value="<%=match_id%>" /></form>
<%}
			//}
		} catch (Exception e) {
			out.println("<B>Match Completed.</B>");
			System.err.println(e.toString());
		}
%>
</body>
</html>
