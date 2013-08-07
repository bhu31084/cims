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
<DIV id="ShowMatchPtDetailsDiv<%=teamId%>">
	<table width="880" border="1" align="center" cellpadding="2" cellspacing="1" class="table">
   		<tr class="contentLight" >
       		<td  align="center" width="3%"><font color="#840084">Match Id </font></td>
       		<td  align="center" width="10%"><font color="#840084">Match </font></td>
       		<td  align="center" width="2%"><font color="#840084">Team 1 </font></td>
       		<td  align="center" width="2%"><font color="#840084">Points </font></td>
       		<td  align="center" width="2%"><font color="#840084">Team 2 </font></td>
       		<td  align="center" width="2%"><font color="#840084">Points </font></td>     			       		
		</tr>
			<%if(crsObjMatchPts != null ){
			int counter = 1;
				while(crsObjMatchPts.next()){
				if(counter % 2 != 0){%>
		<tr class="contentDark">
<%				}else{
%>		<tr class="contentLight">
<%				}%>
						<td id="<%=counter++%>" width="5%" align="center"><%=crsObjMatchPts.getString("id")%></td>
						<td width="5%" align="left"><%=crsObjMatchPts.getString("match")%></td>
						<td width="5%" align="left"><%=crsObjMatchPts.getString("team1")%></td>
						<td width="5%" align="center"><%=crsObjMatchPts.getString("team1point")%></td>
						<td width="5%" align="left"><%=crsObjMatchPts.getString("team2")%></td>
						<td width="5%" align="center"><%=crsObjMatchPts.getString("team2point")%></td>
				</tr>
			<%	}
			}%>
	</table>
</div>
