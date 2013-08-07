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
	String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
	String gsUmp1 = request.getParameter("ump1")==null?"0":request.getParameter("ump1");
	String gsUmp2 = request.getParameter("ump2")==null?"0":request.getParameter("ump2");
	String gsUmp3 = request.getParameter("ump3")==null?"0":request.getParameter("ump3");
	String gsUmpCoach = request.getParameter("umpCoach")==null?"0":request.getParameter("umpCoach");
	String gsReferee = request.getParameter("referee")==null?"0":request.getParameter("referee");
	String gsScorer = request.getParameter("scorer")==null?"0":request.getParameter("scorer");
	String gsScorer2 = request.getParameter("scorer2")==null?"0":request.getParameter("scorer2");
	String gsFlag = "1";
	CachedRowSet  crsObjInsertInfraFascility = null;
	CachedRowSet  crsObjGroundEquipment = null;
	
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	
		//To save InfraStructural Fascilities.
		if(request.getParameter("matchId")!= null){
			try{
				//Changes done by AD
				/*vparam.add(matchId);							
				vparam.add(gsReferee);
				vparam.add(gsScorer);
				vparam.add(gsScorer2);
				vparam.add(gsFlag);*/
				
				vparam.add(matchId);
				vparam.add(gsUmp1);
				vparam.add(gsUmp2);
				vparam.add(gsUmp3);
				vparam.add(gsUmpCoach);
				vparam.add(gsReferee);
				vparam.add("");
				vparam.add(gsScorer);
				vparam.add(gsScorer2);
				vparam.add(gsFlag);
				
				crsObjInsertInfraFascility = lobjGenerateProc.GenerateStoreProcedure("esp_amd_prematch_details_modified1",vparam,"ScoreDB");
				vparam.removeAllElements();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		//To save ground equipments.
		if(request.getParameter("matchId")!= null){
			try{
				//Changes done by AD
				/*vparam.add(matchId);
				vparam.add(gsReferee);
				vparam.add(gsScorer);
				vparam.add(gsScorer2);
				vparam.add(gsFlag);*/
				vparam.add(matchId);
				vparam.add(gsUmp1);
				vparam.add(gsUmp2);
				vparam.add(gsUmp3);
				vparam.add(gsUmpCoach);
				vparam.add(gsReferee);
				vparam.add("");
				vparam.add(gsScorer);
				vparam.add(gsScorer2);
				vparam.add(gsFlag);
				crsObjGroundEquipment = lobjGenerateProc.GenerateStoreProcedure("esp_amd_prematch_details_modified1",vparam,"ScoreDB");
				vparam.removeAllElements();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
%>

<div id="InfraStuFascilityDiv">
	<table border="1" align="center">
		<tr>
			<td align="center">Infra Fascility</td>
			<td align="center">Infra Fascility Name</td>
		</tr>
		<%if(crsObjInsertInfraFascility != null){
				while(crsObjInsertInfraFascility.next()){%>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>							
<%				}//end of while
		}//end of outer if
%>		</tr>
	</table>
</div>
<div id="GroundEquipmentDiv">
	<table border="1" align="center">
		<tr>
			<td align="center">Ground Equipment</td>
			<td align="center">Ground Equipment Name</td>
		</tr>
		<%if(crsObjGroundEquipment != null){
				while(crsObjGroundEquipment.next()){%>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>							
<%				}//end of while
		}//end of outer if
%>		</tr>
	</table>
</div>
