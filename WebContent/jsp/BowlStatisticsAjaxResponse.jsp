<!--
	Page Name 	 : BowlStatisticsAjaxResponse.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 22th Nov 2008
	Description  : Ajax Response for Bts Statistics
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
        CachedRowSet crsObjPlayerBowlingRecord = null;
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		String pid = request.getParameter("pid");
		String seasonId = request.getParameter("seasonId");
		String seriseId = request.getParameter("seriseId")==null?"0":request.getParameter("seriseId");
		
		try {
			vparam.add(pid);
			vparam.add(seasonId);
			//vparam.add(seriseId);
			crsObjPlayerBowlingRecord = lobjGenerateProc.GenerateStoreProcedure("dsp_player_wise_bowling_statistics", vparam, "ScoreDB");
			vparam.removeAllElements();

%>
<html>
<title>
	<head>
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
		<link rel="stylesheet" type="text/css" href="../css/menu.css">
    	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
   	    <link rel="stylesheet" type="text/css" href="../CSS/form.css">
		<link href="../css/form.css" rel="stylesheet" type="text/css" />
		<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
	</head>
</title>
	<body>
				<table align="top" border="0" width="100%">
					<tr>
						<td>
							<table align="top" border="0" width="100%">
								<tr>
									<td class="headinguser"><b>Bowling Averages</b></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<br>
							<table width="60%" border="0" align="left" cellpadding="2" cellspacing="1" class="table">
								<tr class="contentDark" rowspan="3">
									<th colspan="2" align="right" class="colheadinguser"><b>Matches</b></th>
									<th align="right" class="colheadinguser"><b>Inns</b></th>
									<th align="right" class="colheadinguser"><b>Balls</b></th>
									<th align="right" class="colheadinguser"><b>Runs</b></th>
									<th align="right" class="colheadinguser"><b>Wkts</b></th>
									<th align="right" class="colheadinguser"><b>BBI</b></th>
									<th align="right" class="colheadinguser"><b>BBM</b></th>
									<th align="right" class="colheadinguser"><b>Ave</b></th>
									<th align="right" class="colheadinguser"><b>Econ</b></th>
									<th align="right" class="colheadinguser"><b>SR</b></th>
									<th align="right" class="colheadinguser"><b>5w</b></th>
									<th align="right" class="colheadinguser"><b>10w</b></th>
								</tr>
									<tr class="contentLight">
							<%
									if(crsObjPlayerBowlingRecord != null && crsObjPlayerBowlingRecord.size() > 0) {
										while (crsObjPlayerBowlingRecord.next()) {
											if(!(crsObjPlayerBowlingRecord.getString("bowlers_total_matches")).equalsIgnoreCase("0")){
											
							%>
									  <td align="center"><a title="Click to get all played matches" href="javascript:getAllBowlMatches('<%=pid%>')"><b>+</b></a></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("bowlers_total_matches")%></td>
<%											}else{
									
%>									  <td>&nbsp;</td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("bowlers_total_matches")%></td>
<%											}
%>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("bowlers_total_innings")%></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("Bowlers_Total_Bowled_Balls")%></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("bowlers_total_runs")%></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("bowlers_wicket_count")%></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("best_bowling_inning")%></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("best_Bowling_Match")%></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("bowlers_average")%></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("bowlers_Economy")%></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("bowlers_strike_rate")%></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("Innings_Five_Wickets_Count")%></td>
									  <td align="right"><%=crsObjPlayerBowlingRecord.getString("Innings_Ten_Wickets_Count")%></td>
									 
						<%
									 	 }
									 }
						%>
									</tr>
									<tr>
										<td colspan="12">
											<div name="DivBowlAllMatch" id="DivBowlAllMatch" style="display:none">
											</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
				</table>
		</body>
<%
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
		
 