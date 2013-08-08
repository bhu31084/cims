<!--
	Page Name 	 : BowlWktDetail.jsp
	Created By 	 : Dipti
	Created Date : 23rd Apr 2009
	Description  : Ajax Response to display all wickets.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>

<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);

%>
<%
	String matchId= null; 
	String bowlingTeamId= null;
	String playerId = null;
	String flag = null;
	
	matchId = request.getParameter("matchid")!=null?request.getParameter("matchid"):"";
	bowlingTeamId = request.getParameter("bowlingteam")!=null?request.getParameter("bowlingteam"):"";
	playerId = request.getParameter("playerid")!=null?request.getParameter("playerid"):"";
	flag = request.getParameter("flag")!=null?request.getParameter("flag"):"";
	
    CachedRowSet wicketDetailCrs = null;
	Vector vparam = new Vector();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		try {
			vparam.add(matchId);
			vparam.add(bowlingTeamId);
			vparam.add(playerId);//club id
			vparam.add(flag);
			wicketDetailCrs = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_inningwise_bowlerswickets", vparam, "ScoreDB");
			vparam.removeAllElements();

%>
<html>
	<head>
		<title>Wickets</title>
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
		<link rel="stylesheet" type="text/css" href="../css/menu.css">
    	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
   	    <link rel="stylesheet" type="text/css" href="../CSS/form.css">
		<link href="../css/form.css" rel="stylesheet" type="text/css" />
		<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
	</head>

	<body>
		<div id="divBowlWickts" name="divBowlWickts" align="center" style="align:top;overflow:auto;width:500px;height:230px">
		<table valign="top" border="0" width="100%">
			<tr>      
				<td>
					<table width="100%" height="90%" border="0" cellpadding="3" cellspacing="1" class="table">
						<tr class="contentDark" rowspan="3">
							<th align="left" ><font color="#524D9C"><b>Wickets</b></font></th>
							<th align="left"><font color="#524D9C"><b>Description</b></font></th>
						</tr>
<%						if(wicketDetailCrs != null && wicketDetailCrs.size() > 0) {
							while (wicketDetailCrs.next()) {
%>					    <tr class="contentLight">
					    	<td><%=wicketDetailCrs.getString("wicket")%></td>
					    	<td><%=wicketDetailCrs.getString("description")%></td>
					  	</tr>
<%							}
						}
%>					  	
					</table>
				</td>
			</tr>
		</table>
		</div>
	</body>
<%
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
		