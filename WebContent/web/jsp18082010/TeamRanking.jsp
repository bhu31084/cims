<!--
	Author 		 : Archana Dongre
	Created Date : 31/01/09
	Description  : Display match Ranking summry.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" %>
<%
		try {		
		String seriesId = "";
   		String seasonId = "";	
		String seriesName = "";
		seriesId = request.getParameter("seriesId")==null?"":request.getParameter("seriesId");
		seasonId = request.getParameter("seasonId")==null?"":request.getParameter("seasonId");
		seriesName = request.getParameter("name")==null?"":request.getParameter("name");
		//topPerformerflag = request.getParameter("topPerformerflag")==null?"":request.getParameter("topPerformerflag");
		
		CachedRowSet 			crsObjGetMatchPt        =	null;
		GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
		Vector 					vparam 					=  	new Vector();
		String message = "";
		String gsteamId = "";
		String topPerformerflag = "";
		vparam.removeAllElements();
		vparam.add(seriesId);
		vparam.add(seasonId);
		try {
			crsObjGetMatchPt = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_matchpointstally", vparam, "ScoreDB");								
			vparam.removeAllElements();			
		} catch (Exception e) {
			System.out.println("*************TeamRanking.jsp*****************"+e);			
		}
		%>
<DIV id="MatchPointsDiv" >
<table border="0" width="282" align="center" >
		
		<tr>
			<td colspan="5"><b><%=seriesName%></b></td>
		</tr>
		
		<tr >
   		<td >&nbsp;</td>
   		<td ><b>Team</b></td>
   		<td ><b>Played </b></td>
   		<td ><b>Points </b></td>
   		<td ><b>Win </b></td>
		<td ><b>Quotient</b></td>
	</tr>							
	<%if(crsObjGetMatchPt != null ){
			int counter = 1;
			if(crsObjGetMatchPt.size() == 0){				
				message = " Data Not Available ";%>
			<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
			<%}else{%>
			<%while(crsObjGetMatchPt.next()){
				gsteamId = crsObjGetMatchPt.getString("team_id");
			if(counter % 2 == 0 ){%>
        		<tr bgcolor="#f0f7fd">
        		<%}else{%>
        		<tr bgcolor="#e6f1fc">	
        		<%}%>				
		<td align="center" id="<%=counter++%>" ><IMG id="plusImage<%=gsteamId%>" name="plusImage<%=gsteamId%>" alt="" src="../Image/Arrow.gif" /></td>
		<td align="center" ><a href="javascript:ShowTeamPositionDetailDiv('<%=gsteamId%>','<%=crsObjGetMatchPt.getString("series")%>')" style="text-decoration: none;"><%=crsObjGetMatchPt.getString("team_name")%></a></td>
		<td align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjGetMatchPt.getString("Played")%></td>	
		<td align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjGetMatchPt.getString("points")%></td>
		<td align="right" >&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjGetMatchPt.getString("Win")%></td>
		<td align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjGetMatchPt.getString("Quotient")%>
		</td>												
	</tr>
	<tr>
		<td colspan="7">
			<div id="ShowMatchPtDetailsDiv<%=gsteamId%>" style="display:none" ></div>
		</td>
	</tr>
		<%}%>
<%				}
}
%>		
<tr>
			<td colspan="7" ><b><label id="setfocuslabel">Click On Team Name To get The Match Details </label></b></td>
		</tr>
</table>
</DIV>
<%} catch (Exception e) {
			System.err.println(e.toString());
		}
%>