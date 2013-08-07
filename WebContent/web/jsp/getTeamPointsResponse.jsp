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
	try {		
		String clubid = "";
   		String seasonId = "";	
		String SeriesTypeID = null;
		String teamid = "";	
		clubid = request.getParameter("clubID")==null?"":request.getParameter("clubID");
		seasonId = request.getParameter("season")==null?"":request.getParameter("season");
		SeriesTypeID = request.getParameter("SeriesTypeID")==null?"":request.getParameter("SeriesTypeID");
		teamid = request.getParameter("teamid")==null?"":request.getParameter("teamid");
		
		CachedRowSet 			crsObjGetTeamPoints        =	null;
		GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
		Vector 					vParam 					=  	new Vector();
		String message = null;
			
		
		vParam.removeAllElements();
		
		
		try{
			//to get the association list points,club_name,club_id
			vParam.add(seasonId);//season id
			vParam.add(clubid);//@club int, 
			vParam.add(SeriesTypeID);//@seriestype int,
			vParam.add(teamid);//@teamid int,	
			vParam.add("4");//@flag int on third step
			System.out.println("vParam  ***  "+vParam);
			crsObjGetTeamPoints = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_associationwise_points",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("*************AssociationDetails.jsp*****************"+e);
		}	
	%>
<DIV id="ShowTeamMatchDetailsDiv<%=teamid%>" style="width: 100%;">
	<table border="0" align="center" width="100%"  class="contenttable" >
   		<tr>       		       		
       		<td style="text-align: center;padding-right:10px;font-size: 12px;" ><b>Match Between </b></td>
       		<td style="text-align: center;padding-right:10px;font-size: 12px;" ><b>Pts</b></td>       		   			       		
		</tr>
			<%if(crsObjGetTeamPoints != null ){			
				int colorcounter =1;
				while(crsObjGetTeamPoints.next()){								
if(colorcounter % 2 == 0 ){%>
	<tr bgcolor="#f0f7fd">
	<%}else{%>
	<tr bgcolor="#e6f1fc">	
	<%}%>	
			<td style="text-align:left ;font-size: 12px;" id="<%=colorcounter++%>" ><a href="javascript:ShowFullScoreCard('<%=crsObjGetTeamPoints.getString("match_id")%>')" ><%=crsObjGetTeamPoints.getString("matchbtwn")%></a>
			</td>		
			<td style="text-align: right;padding-right:25px;font-size: 12px;"><%=crsObjGetTeamPoints.getString("points")%></td>						
		</tr>		
			<%	}
			}%>
	</table>
</div>
<%} catch (Exception e) {
			System.err.println(e.toString());
		}
%>