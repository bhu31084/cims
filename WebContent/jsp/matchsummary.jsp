<!--
	Author 		 : Saudagar Mulik
	Created Date : 17/09/2008
	Description  : Display current match score summry.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="/cims/jsp/response/error_page.jsp"%>
<%
	String match_id ="";
	CachedRowSet crsResultDsp = null;
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	Vector vecParam = new Vector();
		try{
			match_id = request.getParameter("match");	
			vecParam.add(match_id);
			crsResultDsp = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_reportresult", vecParam, "ScoreDB");
			vecParam.removeAllElements();			
		}catch(Exception e){
			System.out.println(e);
		}

		try {		
		match_id = request.getParameter("match");		
		
		CachedRowSet crsObjDetails = null;
		CachedRowSet crsObjInning = null;
					System.out.println("match-----" + match_id);
		lobjGenerateProc = new GenerateStoreProcedure(match_id);
		
		Vector val = new Vector();		
		crsObjInning = null;
		//added for team name batting
		CachedRowSet crsObjTeam = null;
	val.add(match_id);
		crsObjTeam = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_battingteam", val, "ScoreDB");
	String bat_team = null;
			while(crsObjTeam.next()){
				bat_team = crsObjTeam.getString("batting_team");
				}
	val.removeAllElements();
	//end batting team
		val = new Vector();
		val.add(match_id);
		crsObjDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_scorercard_summary", val, "ScoreDB");
				if(crsObjDetails != null && crsObjDetails.next()){
		%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
<%--<link rel="stylesheet" type="text/css" href="../css/menu.css">--%>
<%--<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">--%>
</head>

<body>
<form action="/cims/jsp/ScorecardSummary.jsp" method="post">
<TABLE align="left" width="100%" border="1" cellspacing="0"  cellpadding="5" bgcolor="#E6F1FC" bordercolor="#fff" >
	<TR align="left">
	<%if(crsObjDetails.getInt("resultmark") == 0 ){			
	%>
	
		<TD width="30%" align="center"><font size="2" color="#003399">Team Batting</font></TD>
	<%}else{%>		
		<TD width="30%" align="center"><font size="2" color="#003399">Match Result</font></TD>
	<%}%>
		<TD align="center" width="10%"><font size="2" color="#003399">Score</font></TD>
		<TD align="center" width="10%"><font size="2" color="#003399">Overs</font></TD>
<%		if (crsObjDetails.getString("change_strike") != null && crsObjDetails.getString("change_strike").equals("0")) {
%>		<TD align="center"width="20%"><font size="2" color="#003399">* <%=crsObjDetails.getString("striker")%></font></TD>		
		<TD align="center" width="20%"><font size="2" color="#003399"><%=crsObjDetails.getString("nonstriker")%></font></TD>
<%		}else{
%>		<TD align="center" width="20%"><font size="2" color="#003399"><%=crsObjDetails.getString("striker")%></font></TD>		
		<TD align="center" width="20%"><font size="2" color="#003399">*<%=crsObjDetails.getString("nonstriker")%></font></TD>
<%		}
%>		
	
	</TR>
	
	<TR align="center">
		<%if(crsObjDetails.getInt("resultmark") == 0 ){	%>
			<td><%=crsObjDetails.getString("batting")%></td>
			<%}else{
			if(crsResultDsp!=null){
				while(crsResultDsp.next()){

			%>
		<td><%=crsResultDsp.getString("result")%></td>
		<%}}}%>
		<TD align="center"><%=crsObjDetails.getString("total")%> / <%=crsObjDetails.getString("wkts")%></TD>
		<TD align="center"><%=crsObjDetails.getString("overs")%></TD>
		<TD align="center"><%=crsObjDetails.getString("Striker_Score")%> Runs</TD>
		<TD align="center"><%=crsObjDetails.getString("NonStriker_Score")%> Runs</TD>										
	</TR>
	<TR align="center">
		<TD align="center"><font size="2" color="#003399">Inning:1</font></TD>
		<TD align="center"><font size="2" color="#003399">Inning:2</font></TD>
		<TD align="center"><font size="2" color="#003399">Inning:3</font></TD>
		<TD align="center"><font size="2" color="#003399">Inning:4</font></TD>
		<TD align="center"></TD>
	</TR>
	<TR align="center">
		<TD align="center">&nbsp;
<%			if(crsObjDetails.getString("inn1")!="null"){ 			
%>			
			<b><%=crsObjDetails.getString("inn1")%></b>: <%=crsObjDetails.getString("inn1_score")%>
<%			}
%> 
		</TD>
		<TD align="center">&nbsp;
<%			if(crsObjDetails.getString("inn2")!=null){ 			
%>			
			<b><%=crsObjDetails.getString("inn2")%></b>: <%=crsObjDetails.getString("inn2_score")%>
<%			}
%> 
		</TD>
		<TD align="center">&nbsp;
<%			if(crsObjDetails.getString("inn3")!=null){ 			
%>			
			<b><%=crsObjDetails.getString("inn3")%></b>: <%=crsObjDetails.getString("inn3_score")%>
<%			}
%> 
		</TD>
		<TD align="center">&nbsp;
<%			if(crsObjDetails.getString("inn4")!=null){ 			
%>			
			<b><%=crsObjDetails.getString("inn4")%></b>: <%=crsObjDetails.getString("inn4_score")%>
<%			}
%> 
		</TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</table>

<input type="hidden" name="matchid" value="<%=match_id%>" />
</form>


</body>
</html>
<%}
		} catch (Exception e) {
			System.err.println(e.toString());
		}
%>