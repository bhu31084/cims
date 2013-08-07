<!--
	Page Name 	 : BowlWktsTypeStatisticsAjaxResponse.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 22th Nov 2008
	Description  : Ajax Response for Bowl Wkts Type Statistics
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
        CachedRowSet crsObjBowlerWktTypeStaistics = null;
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		String pid = request.getParameter("pid");
		String seasonId = request.getParameter("seasonId");
		String seriseId = request.getParameter("seriseId")==null?"0":request.getParameter("seriseId");
		
		try {
			vparam.add(pid);
			//vparam.add(seasonId);
			//vparam.add(seriseId);
			crsObjBowlerWktTypeStaistics = lobjGenerateProc.GenerateStoreProcedure("dsp_bowler_wickets_type_staistics", vparam, "ScoreDB");
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
				<table align="top" border="0" width="60%">
					<tr>
						<td>
							<table align="top" border="0" width="60%">
								<tr>
									<td class="headinguser"><b>Bowler Wickets Type Statistics</b></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<br>
							<table width="40%" border="0" align="left" cellpadding="2" cellspacing="1" class="table">
								<tr class="contentDark">
									<th align="left" class="colheadinguser"><b>Dismissal Type</b></th>
									<th align="right" class="colheadinguser"><b>Dismissal Count</b></th>
								</tr>
									<tr class="contentLight1">
							<%
									if(crsObjBowlerWktTypeStaistics != null && crsObjBowlerWktTypeStaistics.size() > 0) {
										while (crsObjBowlerWktTypeStaistics.next()) {
											
							%>
									  <td align="left" class="contentLight1"><%=crsObjBowlerWktTypeStaistics.getString("dismissal_type")%></td>
									  <td align="right" class="contentLight1"><%=crsObjBowlerWktTypeStaistics.getString("dismissal_count")%></td>
									 	  </tr>											 
						<%
									 	 }
									 }
						%>
									
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
		
 