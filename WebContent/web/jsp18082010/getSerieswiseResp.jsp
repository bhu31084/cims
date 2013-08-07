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
		clubid = request.getParameter("clubID")==null?"":request.getParameter("clubID");
		seasonId = request.getParameter("season")==null?"":request.getParameter("season");
		SeriesTypeID = request.getParameter("SeriesTypeID")==null?"":request.getParameter("SeriesTypeID");
		//topPerformerflag = request.getParameter("topPerformerflag")==null?"":request.getParameter("topPerformerflag");
		
		CachedRowSet 			crsObjGetAssocSeries        =	null;
		GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
		Vector 					vParam 					=  	new Vector();
		String message = null;
		String teamid = null;
			
		String topPerformerflag = "";
		vParam.removeAllElements();
		
		
		try{
			//to get the association list points,club_name,club_id
			vParam.add(seasonId);//season id
			vParam.add(clubid);//@club int, 
			vParam.add(SeriesTypeID);//@seriestype int,
			vParam.add("");//@teamid int,	
			vParam.add("3");//@flag int on third step
			System.out.println("vParam  ***  "+vParam);
			crsObjGetAssocSeries = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_associationwise_points",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("*************AssociationDetails.jsp*****************"+e);
		}	
	%>
<DIV id="ShowseriesPtDetailsDiv<%=SeriesTypeID%>">
	<table width="100%" border="0" align="center" class="contenttable">
   		<tr >
<%--       		<td width="20"></td>--%>
       		<td></td>
       		<td style="text-align: left;font-size: 13px;" ><b>Team Name </b></td>
       		<td style="text-align:right;padding-right:10px;font-size: 12px;" width="30"><b>Pts</b></td>       		   			       		
		</tr>
			<%if(crsObjGetAssocSeries != null ){			
				int colorcounter = 1;
				while(crsObjGetAssocSeries.next()){
				teamid = crsObjGetAssocSeries.getString("team_id");
if(colorcounter % 2 == 0 ){%>
	<tr bgcolor="#f0f7fd">
	<%}else{%>
	<tr bgcolor="#e6f1fc">	
	<%}%>
<%--			<td width="20"></td>--%>
			<td style="text-align:left;padding-right:10px;font-size: 13px;" id="<%=colorcounter++%>"><IMG id="plusImage<%=teamid%>" name="plusImage<%=teamid%>" alt="" src="../Image/Arrow.gif" /></td>
			<td><a href="javascript:ShowTeamPointsDetailDiv('<%=clubid%>','<%=SeriesTypeID%>','<%=seasonId%>','<%=teamid%>')" style="text-decoration: none;"><%=crsObjGetAssocSeries.getString("team_name")%></a>
 			</td>		
			<td style="text-align: right;padding-right:10px;font-size: 12px;" width="30"><%=crsObjGetAssocSeries.getString("points")%></td>						
		</tr>
		<tr style="width: 100%">
			<td colspan="3" width="100%">
				<div id="ShowTeamMatchDetailsDiv<%=teamid%>" style="display:none;width: 100%" ></div>
			</td>
		</tr>
			<%	}
			}%>
	</table>
</div>
<%} catch (Exception e) {
			System.err.println(e.toString());
		}
%>