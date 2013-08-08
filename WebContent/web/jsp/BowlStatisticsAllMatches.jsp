<!--
	Page Name 	 : BowlStatisticsAllMatches.jsp
	Created By 	 : Dipti
	Created Date : 25th Feb 2009
	Description  : Ajax Response to display all matches of clicked top bowler.
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
	String seriesId= null; 
	String seasonId= null;
	String pid = null;
	String pageFlag = null;
	
	seriesId = request.getParameter("seriesId")!=null?request.getParameter("seriesId"):"";
	seasonId = request.getParameter("seasonId")!=null?request.getParameter("seasonId"):"";
	pid = request.getParameter("pid")!=null?request.getParameter("pid"):"";
	pageFlag = request.getParameter("flag")!=null?request.getParameter("flag"):"";
	
    CachedRowSet crsObjPlayerBowlingRecord = null;
	Vector vparam = new Vector();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		try {
			vparam.add(seriesId);
			vparam.add(seasonId);
			vparam.add("");//club id
			vparam.add(pid);
			if(pageFlag != null && pageFlag.equalsIgnoreCase("2")){			
				vparam.add("7");
			}else{
				vparam.add("6");
			}
			crsObjPlayerBowlingRecord = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");
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
					<br>
					<table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" class="table">
						<tr class="contentDark" rowspan="3">
<%						if(pageFlag != null && (pageFlag.equalsIgnoreCase("2"))){			
%>
							<th align="left" ><font color="#524D9C"><b>Match Between</b></font></th>
							<th align="left"><font color="#524D9C"><b>Venue</b></font></th>
							<th width="12%" align="left" ><font color="#524D9C"><b>Match Date</b></font></th>
							<th width="10%" align="right"><font color="#524D9C"><b>I st Inning</b></font></th>
							<th width="10%" align="right"><font color="#524D9C"><b>II nd Inning</b></th>
							<th width="12%" align="right" ><font color="#524D9C"><b>Wickets</b></font></th>
<%						}else{
%>	
							<th align="left" class="colheadinguser"><b>Match Between</b></th>
							<th align="left" class="colheadinguser"><b>Venue</b></th>
							<th width="12%" align="left" class="colheadinguser"><b>Match Date</b></th>
							<th width="10%" align="right" class="colheadinguser"><b>I st Inning</b></th>
							<th width="11%" align="right" class="colheadinguser"><b>II nd Inning</b></th>
							<th width="12%" align="right" class="colheadinguser"><b>Wickets</b></th>
<%						}
%>							
						</tr>
						
<%		int total = 0;
		int row = 1;
		int indTotal = 0;
		String flag="false";
		String seriesIdColumn =null;
		if(crsObjPlayerBowlingRecord != null && crsObjPlayerBowlingRecord.size() > 0) {
			while (crsObjPlayerBowlingRecord.next()) {
			String matchdate = crsObjPlayerBowlingRecord.getString("expected_start");
			total = total + Integer.parseInt(crsObjPlayerBowlingRecord.getString("total_wicktes"));
			
				if(flag.equalsIgnoreCase("false") &&  seriesIdColumn == null){
					seriesIdColumn = crsObjPlayerBowlingRecord.getString("seriesid");
%>
					 <tr>
					   	<td nowrap colspan="4"><%=crsObjPlayerBowlingRecord.getString("description")%></td>
					 </tr>
<%				}
				if(seriesIdColumn != null){
						if(flag.equalsIgnoreCase("false") && !(seriesIdColumn.equalsIgnoreCase(crsObjPlayerBowlingRecord.getString("seriesid")))){
						
						seriesIdColumn = crsObjPlayerBowlingRecord.getString("seriesid");%>
					 <tr>

					 	<td class="colheadinguser" align="right" colspan="5">Total</td>
					 	<td class="colheadinguser" align="right"><%=indTotal%></td>
					 </tr>
					 <tr>

					   	<td><%=crsObjPlayerBowlingRecord.getString("description")%></td>
					 </tr>
									 
<%					indTotal = 0;				
					}//end inner if
			   	}//end outer if
							
%>						
				    <tr class="contentLight">
					  <td nowrap align="left"><%=crsObjPlayerBowlingRecord.getString("matchbtwn")%></td>
					  <td nowrap align="left"><%=crsObjPlayerBowlingRecord.getString("venuename")%></td>
					  <td nowrap width="12%" align="left"><%=matchdate.substring(0,10)%></td>
<%--					  <td nowrap width="12%" align="right" onmouseover="runWicketDetails('<%=row%>','<%=crsObjPlayerBowlingRecord.getString("matches")%>','<%=crsObjPlayerBowlingRecord.getString("id")%>','2')" onmouseout="document.getElementById('runwicket_<%=row%>').style.display = 'none'"><%=crsObjPlayerBowlingRecord.getString("total_wicktes")%>--%>
<%--					  	<div style="background:#ADADAD;left:620px;position:absolute;z-index=0.5;display:none;width=100%;nowrap;" id='runwicket_<%=row%>' name='runwicket_<%=row%>'></div>--%>
<%--					  </td>--%>
					  <td align="right"><%=crsObjPlayerBowlingRecord.getString("wkt_inn1")%></td>
					  <td align="right"><%=crsObjPlayerBowlingRecord.getString("wkt_inn2")%></td>
					  <td align="right"><%=crsObjPlayerBowlingRecord.getString("total_wicktes")%></td>
					</tr> 
<%					indTotal = indTotal + Integer.parseInt(crsObjPlayerBowlingRecord.getString("total_wicktes"));
					row = row +1;
				 }
			 }
%>
							<tr>

							 	<td class="colheadinguser" align="right" colspan="5">Total</td>
							 	<td class="colheadinguser" align="right"><%=indTotal%></td>
							</tr>
<%						if(!(pageFlag != null && (pageFlag.equalsIgnoreCase("2")))){			
%>								
							<tr>

								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td class="colheadinguser" align="right">Gr Total : </td>
								<td class="colheadinguser" align="right"><%=total%></td>
							</tr>
<%						}
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
		