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
			System.out.println("*************Login.jsp*****************"+e);			
		}
		%>
<DIV id="secondpageDiv">
<table border="1" width="100%" align="center" cellpadding="2" cellspacing="1" class="contenttable">		
		<tr>
			<td background = "../Image/top_bluecen.jpg" colspan="11" valign="top" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" ><%=seriesName%></td>															
		</tr>
		<tr >
   		<td  align="center"  >&nbsp;</td>
   		<td width="15%" align="right" ><b>Team</b></td>	       		
   		<td  align="center"><b>Played </b></td>
   		<td  align="center" ><b>Points </b></td>
   		<td  align="center" ><b>Win </b></td>
    	<td  align="center" ><b>Draw </b></td>
       	<td align="center" ><b>Tie </b></td>	       		
       	<td  align="center" ><b>Loss </b></td>
   		<td align="center" ><b>Live </b></td>
   		<td align="center" ><b>Quotient</b></td>
	</tr>							
	<%if(crsObjGetMatchPt != null ){
			int counter = 1;
			if(crsObjGetMatchPt.size() == 0){				
				message = " Data Not Available ";%>
			<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
			<%}else{%>
			<%while(crsObjGetMatchPt.next()){
				gsteamId = crsObjGetMatchPt.getString("team_id");
			%>
			<%  if(counter % 2 == 0 ){%>
    		<tr bgcolor="#f0f7fd">
    		<%}else{%>
    		<tr bgcolor="#e6f1fc">	
    		<%}%>   
		<td align="center" id="<%=counter++%>" ><IMG id="plusImage<%=gsteamId%>" name="plusImage<%=gsteamId%>" alt="" src="../Image/star.gif" /></td>
		<td align="center" nowrap="nowrap" ><a href="javascript:ShowTeamPositionDetailDiv1('<%=gsteamId%>','<%=crsObjGetMatchPt.getString("series")%>')"><%=crsObjGetMatchPt.getString("team_name")%></a></td>
		<td style="text-align: right;padding-right: 15px;"><%=crsObjGetMatchPt.getString("Played")%></td>	
		<td style="text-align: right;padding-right: 15px;" ><%=crsObjGetMatchPt.getString("points")%></td>
		<td style="text-align: right;padding-right: 15px;"><%=crsObjGetMatchPt.getString("Win")%></td>
		<td style="text-align: right;padding-right: 15px;" ><%=crsObjGetMatchPt.getString("Draw")%></td>
		<td style="text-align: right;padding-right: 15px;"><%=crsObjGetMatchPt.getString("Tie")%></td>														
		<td style="text-align: right;padding-right: 15px;" ><%=crsObjGetMatchPt.getString("Loss")%></td>
		<td style="text-align: right;padding-right: 15px;" ><%=crsObjGetMatchPt.getString("Live")%></td>
		<td style="text-align: right;padding-right: 15px;" ><%=crsObjGetMatchPt.getString("Quotient")%></td>													
	</tr>
	<tr>
		<td colspan="10">
			<div id="ShowMatchPtDetailsDiv1<%=gsteamId%>" style="display:none" ></div>
		</td>
	</tr>
		<%}%>
<%				}
}
%>		</table>
</DIV>
<%} catch (Exception e) {
			System.err.println(e.toString());
		}
%>