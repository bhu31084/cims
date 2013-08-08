<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>

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
	String gsPlayerRoleId = request.getParameter("playerRoleId")==null?"0":request.getParameter("playerRoleId");
	String gsOffenceId = request.getParameter("OffenceId")==null?"0":request.getParameter("OffenceId");
	String gsPenaltyId = request.getParameter("PenaltyId")==null?"0":request.getParameter("PenaltyId");
	String gsRemark = request.getParameter("Remark")==null?"0":request.getParameter("Remark");	
	String gsAddFlag = request.getParameter("addflag")==null?"0":request.getParameter("addflag");
	
	String flag = "2";	//To display all records
	String ReprmindValue = "25000";		
	
	
	CachedRowSet  crsObjBreaches = null;
	CachedRowSet  crsObjDisplayOffence = null;
	
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	
		
		//To save Breaches Data.
		if(request.getParameter("addflag")!= null && request.getParameter("addflag").equalsIgnoreCase("1")){
			try{
				vparam.add(gsMatchId);
				vparam.add(gsPlayerRoleId);
				vparam.add(gsOffenceId);
				if(gsPenaltyId.equalsIgnoreCase("1")){
					vparam.add(gsPenaltyId);
					vparam.add("");
					vparam.add(gsRemark);
				}else if(gsPenaltyId.equalsIgnoreCase("2")){
					vparam.add("");
					vparam.add(gsPenaltyId);
					vparam.add(gsRemark);
				}else{
					vparam.add("");
					vparam.add(gsPenaltyId);
					vparam.add(ReprmindValue);
				}
				vparam.add(gsAddFlag);								
				crsObjBreaches = lobjGenerateProc.GenerateStoreProcedure(
					"esp_amd_referee_breachs_fb",vparam,"ScoreDB");
				vparam.removeAllElements();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(request.getParameter("addflag")!= null && request.getParameter("addflag").equalsIgnoreCase("2") ){
			try{
				vparam.add(gsMatchId);
				vparam.add(gsPlayerRoleId);
				vparam.add(gsOffenceId);
				vparam.add("");
				vparam.add("");
				vparam.add("");				
				vparam.add(gsAddFlag);								
				crsObjBreaches = lobjGenerateProc.GenerateStoreProcedure(
					"esp_amd_referee_breachs_fb",vparam,"ScoreDB");
				vparam.removeAllElements();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		vparam.removeAllElements();
		vparam.add(gsMatchId);
		vparam.add(gsPlayerRoleId);
		vparam.add(flag);
		crsObjDisplayOffence = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_referee_breachs_fb",vparam,"ScoreDB");
				vparam.removeAllElements();
%>
<div id="BreachesDiv"> 
	<table width="1000" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr class="contentDark">
			<td align="left" class="colheadinguser">Player Name</td>
			<td align="left" class="colheadinguser">Level</td>
			<td align="left" class="colheadinguser">Offence</td>
			<td align="left" class="colheadinguser">Penalty</td>
			<td align="left" class="colheadinguser">&nbsp; </td>
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
			<td align="center"><%=crsObjDisplayOffence.getString("breach_level")%></td>
			<td align="left"><%=crsObjDisplayOffence.getString("description")%></td>
			<%if(crsObjDisplayOffence.getString("reason").equals("25000")){%>
				<td align="left">Reprimind</td>			
			<%}else{
					if(crsObjDisplayOffence.getString("fee_percentage").equals("0")){%>
						<td align="left">Banned For &nbsp;<%=crsObjDisplayOffence.getString("reason")%>&nbsp;Matches</td>	
					<%}else{%>
						<td align="left">&nbsp;<%=crsObjDisplayOffence.getString("reason")%>%&nbsp;Fees </td>			
				<%}%>				
<%			}%>
			<td align="left" class="colheadinguser">
			<input class="button1"  type="button" id="btnDelBreaches" name="btnDelBreaches" value="Delete" onclick="DeleteRecord('<%=crsObjDisplayOffence.getString("user_role_id")%>','<%=crsObjDisplayOffence.getString("breach_id")%>')" >
			 </td>
<%}//end of while
		}//end of outer if
%>		</tr>
	</table>
</div>
