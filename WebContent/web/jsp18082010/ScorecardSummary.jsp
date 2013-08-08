<!--
	Author 		 :Archana Dongre
	Created Date : 25/01/2009
	Description  : Display current match score summry.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="response/error_page.jsp"%>
<%
		try {		
		String match_id = request.getParameter("matchid").toString();
		System.out.println("match_id "+match_id);		
		CachedRowSet crsObjDetails = null;
		CachedRowSet crsObjInning = null;
		
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		Vector val = new Vector();		
		crsObjInning = null;
		val = new Vector();
		val.add(match_id);
		crsObjDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_scorercard_summary",val, "ScoreDB");
				if(crsObjDetails != null && crsObjDetails.next()){
		%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Match : <%=crsObjDetails.getString("Team1")%> Vs. <%=crsObjDetails.getString("Team2")%></title>
<meta http-equiv="refresh" content="120">

<link rel="stylesheet" type="text/css" href="../../css/common.css">
<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
</head>

<body  style="background-color: white">
<BR>
<form action="ScorecardSummary.jsp" method="post">
<br><br>
<table width="425" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
		<tr align="center">
			 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">
		                 Scorecard Summary 
		     </td>
		</tr>
</table>		
<MARQUEE behavior="alternate">
<H3>Match : <I><U><%=crsObjDetails.getString("Team1")%> Vs. <%=crsObjDetails.getString("Team2")%></U></I></H3>
</MARQUEE>


<DIV style="width: 80%" title="Match Summary">
<table title="Live Score" width="400px" border="2" cellpadding="5"
	cellspacing="1">
	<TR class="contentDark" align="left">
	<%if(crsObjDetails.getInt("resultmark") == 0 ){%>
		<TD>Match Status</TD>
		<TD><%=crsObjDetails.getString("result")%></TD>
	<%}else{%>
		<TD>Match Result</TD>
		<TD><%=crsObjDetails.getString("result")%></TD>
	<%}%>
		
	</TR>
	
	<TR class="contentLight" align="left">
		<%if (crsObjDetails.getString("inning").equals("0")) {%>
		<TD align="center" colspan="2"><LABEL style="font-weight: bold;background-color: transparent;"><B>Inning has to start.</B></LABEL></TD>
		<%} else {%>
		<TD align="center" colspan="2"><B><LABEL style=" background-color: transparent; font-weight: bold;">* <%=crsObjDetails.getString("batting")%>
		- Inning <%=crsObjDetails.getString("inning")%></LABEL></B></TD>
		<%}%>
	</TR>
	<TR class="contentDark" align="left">
		<TD align="left">Score</TD>
		<TD align="right"><LABEL style="font-weight: bold;background-color: transparent;"><B><%=crsObjDetails.getString("total")%> / <%=crsObjDetails.getString("wkts")%>
		in <%=crsObjDetails.getString("overs")%> Overs</B></LABEL></TD>
	</TR>
		<%
					if (crsObjDetails.getString("change_strike") != null && crsObjDetails.getString("change_strike").equals("0")) {%>
	<TR class="contentLight" align="left">
		<TD align="left">* <%=crsObjDetails.getString("striker")%></TD>
		<TD align="right"><LABEL style="font-weight: bold;background-color: transparent;"><B><%=crsObjDetails
												.getString("Striker_Score")%> Runs</B></LABEL></TD>
	</TR>
	<TR class="contentDark" align="left">
		<TD align="left"><%=crsObjDetails.getString("nonstriker")%></TD>
		<TD align="right"><LABEL style="font-weight: bold;background-color: transparent;"><B><%=crsObjDetails.getString("NonStriker_Score")%>
		Runs</B></LABEL></TD>
	</TR>

		<%} else if (crsObjDetails.getString("change_strike") != null && crsObjDetails.getString("change_strike").equals("1")) {%>
	<TR class="contentLight" align="left">
		<TD align="left"><%=crsObjDetails.getString("striker")%></TD>
		<TD align="right"><LABEL style="font-weight: bold;background-color: transparent;"><B><%=crsObjDetails
												.getString("Striker_Score")%> Runs</B></LABEL></TD>
	</TR>
	<TR class="contentDark" align="left">
		<TD align="left">* <%=crsObjDetails.getString("nonstriker")%></TD>
		<TD align="right"><LABEL style="font-weight: bold;background-color: transparent;"><B><%=crsObjDetails.getString("NonStriker_Score")%>
		Runs</B></LABEL></TD>
	</TR>

		<%}else{%>
	<TR class="contentLight" align="left">
		<TD align="left"></TD>
		<TD align="right"><LABEL style="font-weight: bold;background-color: transparent;"><B><%=crsObjDetails
												.getString("Striker_Score")%> Runs</B></LABEL></TD>
	</TR>
	<TR class="contentDark" align="left">
		<TD align="left"></TD>
		<TD align="right"><LABEL style="font-weight: bold;background-color: transparent;"><B><%=crsObjDetails.getString("NonStriker_Score")%>
		Runs</B></LABEL></TD>
	</TR>
		<%}%>
</table>
<br>
</DIV>

<center><input class="button1" type="submit" value="Refresh" /> <input type="hidden"
	name="matchid" value="<%=match_id%>" /></center><br>

	<table>
		<tr>
			<td>
				NOTE : This page gets autometically refreshed in every 2 minutes.
			</td>
		</tr>
	</table>
</form>


</body>
</html>
<%}
		} catch (Exception e) {
			System.err.println(e.toString());
		}
%>