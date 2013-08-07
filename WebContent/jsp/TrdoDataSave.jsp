<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
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
	String gsMatchId = request.getParameter("matchid")==null?"0":request.getParameter("matchid");
	String gsPlayerId = request.getParameter("playerId")==null?"0":request.getParameter("playerId");
	String gsRoleId = request.getParameter("RoleId")==null?"0":request.getParameter("RoleId");
	String gsPropertyId = request.getParameter("PropertyId")==null?"0":request.getParameter("PropertyId");
	String gsStrengthId = request.getParameter("StrengthId")==null?"0":request.getParameter("StrengthId");
	String gsRemark = request.getParameter("Remark")==null?"0":request.getParameter("Remark");
	String flag = "1";

	System.out.println("gsMatchId "+gsMatchId);
	System.out.println("gsPlayerId "+gsPlayerId);
	System.out.println("gsRoleId "+gsRoleId);
	System.out.println("gsPropertyId "+gsPropertyId);
	System.out.println("gsStrengthId "+gsStrengthId);
	System.out.println("gsRemark "+gsRemark);

	CachedRowSet  crsObjBreaches = null;
	CachedRowSet  crsObjDisplayOffence = null;

	Vector vparam =  new Vector();
	Vector showvparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	
		//To save Breaches Data.
		if(request.getParameter("matchid")!= null){
			try{			
				vparam.add(gsMatchId);
				vparam.add(gsPlayerId);
				vparam.add(gsRoleId);
				vparam.add(gsPropertyId);
				vparam.add(gsStrengthId);
				vparam.add(gsRemark);						
				System.out.println("vector is "+vparam);
				crsObjBreaches = lobjGenerateProc.GenerateStoreProcedure(
					"esp_amd_trdo_properties_fb",vparam,"ScoreDB");
				vparam.removeAllElements();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}			
		showvparam.add(gsMatchId);
		showvparam.add(gsPlayerId);
		showvparam.add(flag);	
		System.out.println("vector is "+showvparam);
		crsObjDisplayOffence = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_players_trdo",showvparam,"ScoreDB");
		showvparam.removeAllElements();
			
%>
<div id="SavedStrengthDiv"> 
	<table width="880" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr class="contentDark">
			<td align="left"><font size="2"><b>Match Players</b></font></td>			
			<td align="left"><font size="2"><b>Role</b></font></td>
			<td align="left"><font size="2"><b>Property</b></font></td>
			<td align="left"><font size="2"><b>Strengths/Weakness </b></font></td>
			<td align="left"><font size="2"><b>Remark </b></font></td>
		</tr>
		<%if(crsObjDisplayOffence != null){
		int counter = 1;
				while(crsObjDisplayOffence.next()){
		if(counter % 2 != 0){%>
		<tr class="contentLight">
<%				}else{
%>		<tr class="contentDark">
<%				}
%>
			<td align="left" id="<%=counter++%>"><%=crsObjDisplayOffence.getString("playername")%></td>
			<%if(crsObjDisplayOffence.getString("player_role").equalsIgnoreCase("1")){%>
				<td align="left">Batting</td>			
			<%}else if(crsObjDisplayOffence.getString("player_role").equalsIgnoreCase("2")){%>				
					<td align="left">Bowling</td>					
			<%}else if(crsObjDisplayOffence.getString("player_role").equalsIgnoreCase("3")){%>
					<td align="left">Fielding</td>				
			<%}else if(crsObjDisplayOffence.getString("player_role").equalsIgnoreCase("4")){%>
				<td align="left">Wicket Keeping</td>
			<%}%>
			<%if(crsObjDisplayOffence.getString("property").equalsIgnoreCase("1")){%>
				<td align="left">Strength</td>
			<%}else{%>
				<td align="left">Weakness</td>
			<%}	%>
			<td align="left"><%=crsObjDisplayOffence.getString("description")%></td>
			<td align="left"><%=crsObjDisplayOffence.getString("remark")%></td>		
<%			
}//end of while
		}//end of outer if
%>		</tr>
	</table>
</div>
