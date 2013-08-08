<!--
	Page Name 	 : BtsStatisticsAjaxResponse.jsp
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
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
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
        CachedRowSet crsObjPlayerBattingRecord = null;
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		String pid = request.getParameter("pid");
		String seasonId = request.getParameter("seasonId");
		//String seriseId = request.getParameter("seriseId")==null?"0":request.getParameter("seriseId");
		String serverMessageForBts = null;
		
		try {
			vparam.add(pid);
			vparam.add(seasonId);
			//vparam.add(seriseId);
			crsObjPlayerBattingRecord = lobjGenerateProc.GenerateStoreProcedure("dsp_player_wise_batting_statistics", vparam, "ScoreDB");
			vparam.removeAllElements();

%>
<html>
<title>
	<head>
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
		<link rel="stylesheet" type="text/css" href="../css/menu.css">
	    <link rel="stylesheet" type="text/css" href="../CSS/form.css">
    	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
		<link href="../css/form.css" rel="stylesheet" type="text/css" />
		<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
	</head>
</title>
	<body>
				<table align="top" border="0" width="100%">
						<tr>
							<td>
								<table align="top" border="0">
									<tr>
										<td class="headinguser"><b>Batting Averages</b></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
							<br>
								<table width="60%" border="0" align="left" cellpadding="2" cellspacing="1" class="table">
									<tr class="contentDark" rowspan="3">
										<th align="right" class="colheadinguser" colspan="2"><b>Matches</b></th>
										<th align="right" class="colheadinguser"><b>Inns</b></th>
										<th align="right" class="colheadinguser"><b>NO</b></th>
										<th align="right" class="colheadinguser"><b>Runs</b></th>
										<th align="right" class="colheadinguser"><b>HS</b></th>
										<th align="right" class="colheadinguser"><b>Ave</b></th>
										<th align="right" class="colheadinguser"><b>SR</b></th>
										<th align="right" class="colheadinguser"><b>100</b></th>
										<th align="right" class="colheadinguser"><b>50</b></th>
										<th align="right" class="colheadinguser"><b>4s</b></th>
										<th align="right" class="colheadinguser"><b>6s</b></th>
									</tr>
										<tr class="contentLight">
<%
										if(crsObjPlayerBattingRecord != null && crsObjPlayerBattingRecord.size() > 0) {
											while (crsObjPlayerBattingRecord.next()) {
												if(!(crsObjPlayerBattingRecord.getString("batsmans_total_matches").equalsIgnoreCase("0"))){
%>

										  <td align="center"><a title="Click to get all played matches" href="javascript:getAllBtsMatches('<%=pid%>')"><b>+</b></a></td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_total_matches")%></td>
<%												}else{
%>										  
										  <td>&nbsp;</td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_total_matches")%></td>
<%												}
%>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_total_innings")%></td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_Total_Not_Outs")%></td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_total_runs")%></td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_highest_innings_runs")%></td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_average")%></td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_strike_rate")%></td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_centuries")%></td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_half_centuries")%></td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_boundaries_four")%></td>
										  <td align="right"><%=crsObjPlayerBattingRecord.getString("batsmans_boundaries_six")%></td>
							<%
										 	 }
										 }
							%>
										</tr>
										<tr>
										<td colspan="12">
											<div name="DivBtsAllMatch" id="DivBtsAllMatch" style="display:none">
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
		
 