<!--
	Author 		 : Archana Dongre
	Created Date : 31/01/09
	Description  : Display match Ranking summry.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="error_page.jsp"%>
<%
		try {		
		String seriesId = "";   		
		String seriesName = "";
		seriesId = request.getParameter("seriesId")==null?"":request.getParameter("seriesId");		
		seriesName = request.getParameter("name")==null?"":request.getParameter("name");
		//topPerformerflag = request.getParameter("topPerformerflag")==null?"":request.getParameter("topPerformerflag");
		
		CachedRowSet 			crsObjGetMatches        =	null;
		GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
		Vector 					vparam 					=  	new Vector();
		String message = "";
		String gsteamId = "";
		String topPerformerflag = "";
		vparam.removeAllElements();
		
		
		try {
			vparam.add("2"); // flag to get the matches under selected series.
			vparam.add(seriesId);
			crsObjGetMatches = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_futureseries", vparam, "ScoreDB");								
			vparam.removeAllElements();			
		} catch (Exception e) {
			System.out.println("*************FutureSeriesDetailsAjaxResponse*****************"+e);			
		}
		%>
<DIV id="MatchesDiv" style="height: 400px;overflow: auto;">
<table border="0" width="300" align="center" >				
		<tr>
			<td background = "../Image/top_bluecen.jpg" colspan="2" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;height: 30px;" ><%=seriesName%></td>
		</tr>
		<%if(crsObjGetMatches != null){
			int counter = 1;
			if(crsObjGetMatches.size() == 0){
			message = " Data Not Available ";%>
			<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
			<%}else{
				while(crsObjGetMatches.next()){ 
				if(counter % 2 == 0 ){%>
				<tr bgcolor="#e6f1fc">
        		<%}else{%>
        		<tr bgcolor="#f0f7fd">	
        		<%}%>
				<td id="<%=counter++%>" nowrap="nowrap">
						<div><b>Start Date :</b> <%=crsObjGetMatches.getString("expected_start").substring(0,11)%></div>
						<div><b>End Date : </b><%=crsObjGetMatches.getString("expected_end").substring(0,11)%></div>
						<div><b>Match Between :</b> <%=crsObjGetMatches.getString("team1")%> Vs <%=crsObjGetMatches.getString("team2")%></div>
						<div><b>Venue : </b><%=crsObjGetMatches.getString("venue")%></div>
					</td>
				</tr>	
		<%		}
			}
		}%>
			
</table>
</DIV>
<%} catch (Exception e) {
			System.err.println(e.toString());
		}
%>