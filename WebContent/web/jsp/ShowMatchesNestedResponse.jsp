<!--
Page Name 	 : ShowMatchPointsResponse.jsp
Created By 	 : Archana Dongre.
Created Date : 23rd Jan 2009
Description  : To get the match points.
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires",0);
%>
<%		
	String teamId = request.getParameter("teamId")==null?"0":request.getParameter("teamId");
	String seriesId = request.getParameter("seriesId")==null?"0":request.getParameter("seriesId");		
				
	System.out.println("teamId "+teamId);
	System.out.println("seriesId "+seriesId);
	
	CachedRowSet  crsObjMatchPts = null;		
	Vector vParam =  new Vector();	
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	String getmatchId = null;
		try{
			vParam.add(seriesId);
			vParam.add(teamId);
			crsObjMatchPts = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_teammatchdetails",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
	 		e.printStackTrace();
		}	
	%>
<DIV id="ShowMatchPtDetailsDiv1<%=teamId%>" >
	<table width="100%" border="1" align="center" cellpadding="2" cellspacing="1" class="contenttable">
   		<tr >
<%--       		<td  align="center" ><b>Association </b></td>--%>
       		<td  align="center" ><b>Match </b></td>
       		<td  align="center"  ><b>Team 1 </b></td>
       		<td  align="center" ><b>Points </b></td>
       		<td  align="center" ><b>Team 2 </b></td>
       		<td  align="center" ><b>Points </b></td>     			       		
		</tr>
			<%if(crsObjMatchPts != null ){
			int counter = 1;
				while(crsObjMatchPts.next()){
				getmatchId = crsObjMatchPts.getString("id");
				if(counter % 2 != 0){%>
		<tr bgcolor="#f0f7fd">
    		<%}else{%>
    		<tr bgcolor="#e6f1fc">	
    		<%}%>   
<%--						<td id="<%=counter++%>" align="center" ><%=crsObjMatchPts.getString("association")%></td>--%>
						<td align="left" id="<%=counter++%>"><a href="javascript:ShowFullScoreCard('<%=getmatchId%>')" ><%=crsObjMatchPts.getString("match")%></a></td>
						<td align="left" ><%=crsObjMatchPts.getString("team1")%></td>
						<td align="center" >&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjMatchPts.getString("team1point")%></td>
						<td align="left" ><%=crsObjMatchPts.getString("team2")%></td>
						<td align="center" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjMatchPts.getString("team2point")%></td>
				</tr>
			<%	}
			}%>
	</table>
</div>
