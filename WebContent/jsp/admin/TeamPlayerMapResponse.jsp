<!--
Page Name 	 : TeamPlayerMapResponse.jsp
Created By 	 : Avadhut Joshi
Created Date : 07th Oct 2008
Description  : Mapping of players to team Response Page
Company 	 : Paramatrix Tech Pvt Ltd.
-->


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
	
	String gsPlayerId = request.getParameter("userid")==null?"0":request.getParameter("userid");
	String gsTeamId = request.getParameter("teamId")==null?"0":request.getParameter("teamId");
	String gsStatusId = request.getParameter("statusId")==null?"0":request.getParameter("statusId");

	
	CachedRowSet  TeamscrsObj = null;	
	CachedRowSet  crsObjInsertRecord = null;			
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	String strMessage = "";
	
	
			try{
			
				vparam.add(gsPlayerId);
				vparam.add(gsTeamId);
				vparam.add(gsStatusId);			
	System.out.println(vparam);				
				crsObjInsertRecord = lobjGenerateProc.GenerateStoreProcedure(
					"dbo.esp_amd_teamplayermap",vparam,"ScoreDB");
				vparam.removeAllElements();
				while(crsObjInsertRecord.next()){
					strMessage = crsObjInsertRecord.getString("RetVal");
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}	
			
		try{
			vparam.add(gsTeamId); //display teams
			TeamscrsObj = lobjGenerateProc.GenerateStoreProcedure(
		       	"esp_dsp_teamplayers_map",vparam,"ScoreDB");
		    vparam.removeAllElements();					

			
		}catch(Exception e){
			e.printStackTrace();
		}				
		
%>		

<html>
<head>
	<script>
		function user(){
			alert("")
			var optionval = document.getElementById('lbSelectedPlayersFrom').value;
			alert("optionval" +document.getElementById('lbSelectedPlayersFrom').value);
		}	
		
	</script>

</head>
<body>
		<div id = "divMessage">
			<label><%=strMessage%></label>
		</div>
		<br>
					<div id="divteamplayers">
			<table>
			<tr>
							<td>
			<%if(TeamscrsObj != null){%>							
							
							<select	id="lbSelectedPlayersFrom" multiple="multiple" size="40" STYLE="width: 360px; overflow: auto"  >
<%--							<label> <%=TeamscrsObj.getString("playername")%></label>--%>
								<%while(TeamscrsObj.next()){%>
									<option value="<%=TeamscrsObj.getString("user_id")%>"> <%=TeamscrsObj.getString("playername")%></option>								
							<input type="hidden" name="hduser" id="hduser" value="<%=TeamscrsObj.getString("user_id")%>">							
								<%}%>
							</select>

							
							</td>
							</tr>
	
				
					
								
			<%}%>
				</table>
			</div>
</body>			
</html>	