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
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%
		try {			
		
		//String match_id = request.getParameter("matchid").toString();
		String matchid = request.getParameter("matchid")==null?(String)session.getAttribute("match_id"):request.getParameter("matchid");
	  	String match_id = (String)session.getAttribute("match_id");
	  	if(matchid == match_id){
	  		match_id = (String)session.getAttribute("match_id");
	  	}else{
	  		session.setAttribute("match_id",matchid);
	  	}
	  	//if(match_id==null || match_id==""){		
		//	session.setAttribute("match_id",matchid);			
		//}	  	
		match_id = (String)session.getAttribute("match_id");
		System.out.println("match_id "+match_id);		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy-MMM-dd");
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MMM-dd");
		java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat("DD/MM/yyyy");
		//String match_id = "709";
		CachedRowSet crsObjbatDetails = null;
		CachedRowSet crsObjballDetails = null;
		
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		Vector val = new Vector();		
		//crsObjInning = null;
		val = new Vector();
		val.add(match_id);
		crsObjbatDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_miniscorercard_summary_batsman",val, "ScoreDB");
		
			
		//crsObjInning = null;
		val = new Vector();
		val.add(match_id);
		crsObjballDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_miniscorercard_summary_bowler",val, "ScoreDB");		
				
		if(crsObjbatDetails != null && crsObjbatDetails.next()){
		%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Match : <%=crsObjbatDetails.getString("Team1")%> Vs. <%=crsObjbatDetails.getString("Team2")%></title>
<meta http-equiv="refresh" content="20">
<link rel="stylesheet" type="text/css" href="../../css/common.css">
<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">
</head>
<body  style="background-color: white">
<form action="liveScoreCard.jsp" method="post">
<br>	
<DIV style="width: 180px;height: 180px;" id="MatchSummery">
<table title="Live Score" width="180px" border="1"  class="contenttable">
<%--	<tr align="center">--%>
<%--			 <td align="left" colspan="5" bgcolor="#FFFFFF" class="leg">Desktop Scorecard</td>--%>
<%--	</tr>--%>
	<tr bgcolor="#BBDFF7"><td colspan="5" align="center" style="font-weight: bold;size: 1px;"><%=sdf.format(new Date())%></td></tr>
	<tr bgcolor="#8CC8F0"><td colspan="5" align="center" style="font-weight: bold;size: 1px;"><%=crsObjbatDetails.getString("Team1")%> Vs. <%=crsObjbatDetails.getString("Team2")%></td></tr>
	<tr bgcolor="#e6f1fc"><td colspan="5" align="center" style="font-weight: bold;size: 1px;">Status:<%=crsObjbatDetails.getString("result")%> </td></tr>
	<tr bgcolor="#BBDFF7">
		<td colspan="3" align="center" style="font-weight: bold;size: 1px;"><%=crsObjbatDetails.getString("BATTING")%></td>
		<td colspan="2" align="center" style="font-weight: bold;size: 1px;"><%=crsObjbatDetails.getString("BOWLING")%></td>
	</tr>
	<tr bgcolor="#8CC8F0"><td align="center" style="font-weight: bold;">Batsman</td>
		<td align="center" style="font-weight: bold;size: 1px;">R</td>
		<td align="center" style="font-weight: bold;size: 1px;">B</td>
		<td align="center" style="font-weight: bold;size: 1px;">4s</td>
		<td align="center" style="font-weight: bold;size: 1px;">6s</td>
	</tr>
	
	<tr bgcolor="#e6f1fc">
	<!--batting,bowling,Team1,Team2,inning,striker,Striker_Score,Striker_balls,Striker_fours,Striker_six,nonstriker,NonStriker_Score,NonStriker_balls,NonStriker_fours,NonStriker_six,wkts,overs,total,change_strike,status,result,resultmark-->
		<td style="size: 1px;" align="left"><%=crsObjbatDetails.getString("striker")%> *</td>
		<td style="size: 1px;text-align: right;padding-right: 5px;"><%=crsObjbatDetails.getString("Striker_Score")%></td>
		<td style="size: 1px;text-align: right;padding-right: 5px;"><%=crsObjbatDetails.getString("Striker_balls")%></td>
		<td style="size: 1px;text-align: right;padding-right: 5px;"><%=crsObjbatDetails.getString("Striker_fours")%></td>
		<td style="size: 1px;text-align: right;padding-right: 5px;"><%=crsObjbatDetails.getString("Striker_six")%></td>
	</tr>	
	<tr bgcolor="#e6f1fc">
		<td style="size: 1px;" align="left"><%=crsObjbatDetails.getString("nonstriker")%> </td>
		<td style="size: 1px;text-align: right;padding-right: 5px;"><%=crsObjbatDetails.getString("NonStriker_Score")%></td>
		<td style="size: 1px;text-align: right;padding-right: 5px;"><%=crsObjbatDetails.getString("NonStriker_balls")%></td>
		<td style="size: 1px;text-align: right;padding-right: 5px;"><%=crsObjbatDetails.getString("NonStriker_fours")%></td>
		<td style="size: 1px;text-align: right;padding-right: 5px;"><%=crsObjbatDetails.getString("NonStriker_six")%></td>
	</tr>
	<%}
	%>
	<tr bgcolor="#8CC8F0"><td align="center" style="font-weight: bold;">Bowler</td>
		<td align="center" style="font-weight: bold;size: 1px;">O</td>
		<td align="center" style="font-weight: bold;size: 1px;">M</td>		
		<td align="center" style="font-weight: bold;size: 1px;">W</td>		
		<td align="center" style="font-weight: bold;size: 1px;">R</td>
		
	</tr>
	<!--batting,bowling,Team1,Team2,inning,bowlername,runs,maiden,wicket,overs,status,result,resultmark -->
<%	if(crsObjballDetails != null && crsObjballDetails.next()){%>
	<tr bgcolor="#e6f1fc">
		<td align="left"><%=crsObjballDetails.getString("bowlername")%> *</td>
		<td style="text-align: right;padding-right: 5px;"><%=crsObjballDetails.getString("overs")%></td>
		<td style="text-align: right;padding-right: 5px;"><%=crsObjballDetails.getString("maiden")%></td>
		<td style="text-align: right;padding-right: 5px;"><%=crsObjballDetails.getString("wicket")%></td>
		<td style="text-align: right;padding-right: 5px;"><%=crsObjballDetails.getString("runs")%></td>
		
		
	</tr>
	<%}%>
</table>
</DIV>
<input class="button1" type="submit" value="Refresh" /> <input type="hidden"
	name="matchid" value="<%=match_id%>" /><br>	
</form>
</body>
</html>
<%
		} catch (Exception e) {
			System.err.println(e.toString());
		}
%>
					