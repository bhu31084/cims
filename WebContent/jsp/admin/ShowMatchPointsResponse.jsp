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
	String teamId = request.getParameter("teamId")==null?"0":request.getParameter("teamId");
	String seriesId = request.getParameter("seriesId")==null?"0":request.getParameter("seriesId");	
	//String roleid = request.getParameter("roleid")==null?"0":request.getParameter("roleid");
	
	String retval = null;				
	
	String matchId = "";
	String team1pt = "";
	String team2pt = "";
	CachedRowSet  crsObjMatchPts = null;		
	Vector vParam =  new Vector();	
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	
		try{
			vParam.add(seriesId);
			vParam.add(teamId);
			crsObjMatchPts = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teammatchdetails",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
	 		e.printStackTrace();
		}	
	%>
<DIV id="ShowMatchPtDetailsDiv<%=teamId%>">
	<table width="880" border="1" align="center" cellpadding="2" cellspacing="1" class="table">
   		<tr class="contentLight" >
       		<td  align="center" width="3%"><font color="#840084">Match Id </font></td>
       		<td  align="center" width="10%"><font color="#840084">Match </font></td>
       		<td  align="center" width="2%"><font color="#840084">Team 1 </font></td>
       		<td  align="center" width="2%"><font color="#840084">Points </font></td>
       		<td  align="center" width="2%"><font color="#840084">Team 2 </font></td>
       		<td  align="center" width="2%"><font color="#840084">Points </font></td>    
       		<td  align="center" width="2%"><font color="#840084">Edit Points </font></td> 			       		
		</tr>
			<%if(crsObjMatchPts != null ){
			int counter = 1;
				while(crsObjMatchPts.next()){
				matchId = crsObjMatchPts.getString("id");
				team1pt = crsObjMatchPts.getString("team1point");
				team2pt = crsObjMatchPts.getString("team2point");				
				if(counter % 2 != 0){%>
		<tr class="contentDark">
<%				}else{
%>		<tr class="contentLight">
<%				}%>
						<td id="<%=counter++%>" width="2%" align="center"><%=matchId%></td>
						<td width="5%"><%=crsObjMatchPts.getString("match")%></td>
						<td width="5%"><%=crsObjMatchPts.getString("team1")%></td>
						<td align="center"><input size="2" type="text" id="team1Points<%=matchId%>" name="team1Points" value="<%=team1pt%>" onKeyPress="return keyRestrict(event,'-1234567890')"></td>
						<td width="5%" ><%=crsObjMatchPts.getString("team2")%></td>
						<td align="center"><input size="2" type="text" id="team2Points<%=matchId%>" name="team2Points" value="<%=team2pt%>" onKeyPress="return keyRestrict(event,'-1234567890')"></td>						
						<td  align="center" width="5%"><INPUT class="button1" type="button" id="btnsave<%=matchId%>" name="btnsave" value="Save" onclick="adminEdit('<%=matchId%>')"></td> 			       		
				</tr>
			<%	}
			}%>
	</table>
</div>