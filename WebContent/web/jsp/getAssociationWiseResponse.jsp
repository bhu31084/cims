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
		String clubid = "";
   		String seasonId = "";	
		String AssociationName = "";
		String clublogo ="";
		clubid = request.getParameter("clubId")==null?"":request.getParameter("clubId");
		seasonId = request.getParameter("currentseason")==null?"":request.getParameter("currentseason");
		AssociationName = request.getParameter("clubname")==null?"":request.getParameter("clubname");
		clublogo = request.getParameter("clublogo")==null?"":request.getParameter("clublogo");
		//topPerformerflag = request.getParameter("topPerformerflag")==null?"":request.getParameter("topPerformerflag");
		
		CachedRowSet 			crsObjGetAssocSeries        =	null;
		GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
		Vector 					vParam 					=  	new Vector();
		String message = null;
		String seriestypeid = null;		
		String topPerformerflag = "";
		vParam.removeAllElements();
		
		
		try{
			//to get the association list points,club_name,club_id
			vParam.add(seasonId);//season id
			vParam.add(clubid);//@club int, 
			vParam.add("");//@seriestype int,
			vParam.add("");//@teamid int,	
			vParam.add("2");//@flag int on second step
			crsObjGetAssocSeries = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_associationwise_points",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("*************AssociationDetails.jsp*****************"+e);
		}		
		%>
<div id="loadPageDiv">
<table width="310" border="0" style="height: 210px;">
		<tr>
			<td colspan="3" ></td>
		</tr>	
		<tr>
			<td colspan="1" style="text-align: right;font-size: 14px;" valign="top"><IMG src="../Image/<%=clublogo%>"></td>
			<td colspan="2" style="text-align: left;padding-right:10px;font-size: 14px;"><b><%=AssociationName%></b></td>
		</tr>
	<tr>
	<!-- club_name,series_name,points,club_id,seriestype_id,series_id-->		
		<td></td>
		<td style="text-align: left;padding-right:10px;font-size: 12px;"><b>Tournament Name</b></td>
		<td style="text-align: center;padding-right:10px;font-size: 12px;" width="30"><b>Pts</b></td>
	</tr>
	<%if(crsObjGetAssocSeries != null){%>													
<%	int colorcounter = 1;
	while(crsObjGetAssocSeries.next()){
	seriestypeid = crsObjGetAssocSeries.getString("seriestype_id");
	if(colorcounter % 2 == 0 ){%>
	<tr bgcolor="#f0f7fd">
	<%}else{%>
	<tr bgcolor="#e6f1fc">	
	<%}%>	
 <td style="text-align:left;font-size: 12px;" id="<%=colorcounter++%>"><IMG id="plusImage<%=seriestypeid%>" name="plusImage<%=seriestypeid%>" alt="" src="../Image/Arrow.gif" align="right" /></td><td><a href="javascript:ShowSeriesPositionDetailDiv('<%=crsObjGetAssocSeries.getString("club_id")%>','<%=seriestypeid%>','<%=seasonId%>')" style="text-decoration: none;color: black" ><%=crsObjGetAssocSeries.getString("series_name")%></a>
 </td>
 <td style="text-align: right;padding-right:10px;font-size: 12px;"><%=crsObjGetAssocSeries.getString("points")%>
 </td>
</tr>
<tr>
	<td colspan="3">
		<div id="ShowseriesPtDetailsDiv<%=seriestypeid%>" style="display:none" ></div>
	</td>
</tr>	
<%   }
}%>	
	
</table>
</div>

<%} catch (Exception e) {
			System.err.println(e.toString());
		}
%>