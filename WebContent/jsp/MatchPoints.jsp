<!--
Page Name: MatchPoints.jsp
Author 		 : Avadhut Joshi.
Created Date : 19th Sep 2008
Description  : Entry of Points 
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
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
	response.setDateHeader("Expires", 0);
%>
<%
	String matchId = null;  
	String msg ="";
	if(request.getParameter("matchid")!=null)	{
		matchId = request.getParameter("matchid");	
	}	
try{	
	CachedRowSet  crsObjPoints = null;
	CachedRowSet  crsObjDisplay = null;
	if(request.getParameter("matchid")==null)	{
		matchId = (String)session.getAttribute("matchId1");	//
	}
	String battingTeam1 = (String)session.getAttribute("firstBattingName");	//"65";
	String battingTeam2 = (String)session.getAttribute("secondBattingName");//"71";
	
	Vector vparam =  new Vector();		
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	
	if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit")){
		/*For insertion of record in database.*/
		String strptsteam1 =	request.getParameter("txtptsteam1");
		String strptsteam2 =	request.getParameter("txtptsteam2");		
		vparam.add(request.getParameter("matchid"));//
		vparam.add(strptsteam1);//
		vparam.add(strptsteam2);//
		crsObjPoints = lobjGenerateProc.GenerateStoreProcedure(
			"esp_amd_matchpoints",vparam,"ScoreDB");			
		vparam.removeAllElements();	
		msg ="Match point is updated successfully.";
	}
	vparam.add(matchId);
	crsObjDisplay = lobjGenerateProc.GenerateStoreProcedure(
			"dsp_teamsname_display",vparam,"ScoreDB");
	vparam.removeAllElements();	
%>

<head><title>Rounds Master</title>
 <script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">    
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">    
    <script>
    function callNextPage(){
    		document.getElementById('hdSubmit').value = "submit";
			document.frmRound.action = "/cims/jsp/MatchPoints.jsp";
			document.frmRound.submit();				
			//window.close();
					
		}	
	 function cancellation(){
	 		document.getElementById('txtptsteam1').value="";
	 		document.getElementById('txtptsteam2').value="";
			document.frmRound.action = "/cims/jsp/MatchPoints.jsp";			
		}	
    </script>
</head>

<body>
<FORM name="frmRound" id="frmRound" method="post">
			<br>
			<br>
		<table width="50%" align="center" style="border-top: 1cm;">
			<tr>
				<td colspan="10" align="center" style="background-color:gainsboro;"><font size="5" color="#003399"><b>Match Points</b></font></td>
			</tr>
			<tr>
				<td class="message"> <%=msg%></td>
			</tr>
			<tr>
				<td>
					<fieldset id="fldsetRound"> 
						<legend >
							<font size="3" color="#003399" ><b>Match Points </b></font>
						</legend> 
						<br>
			 		<table align="center" width="90%" class="TDData">
			 		<%if(crsObjDisplay!=null){
			 		   while(crsObjDisplay.next()){	%>
						<tr >
							<td><b>Match Name :</b></td>
						   	<td>
<%--								<input type="text" name="txtmatch" id="txtroundname" value="<%=crsObjDisplay.getString("teamsname")%>" >--%>
			                 <label><%=crsObjDisplay.getString("teamsname")%> </label>
							</td> 
						</tr>
						<tr>							
						   	<td><b>Team 1:</b></td> 
							<td>
<%--								<input type="text" name="txtteam1" id="txtteam1" value="<%=crsObjDisplay.getString("team1name")%>" >--%>
								<label><%=crsObjDisplay.getString("team1name")%> </label>
							</td> 
						</tr>		
						<tr>							
						   	<td><b>Points:</b></td> 
							<td>
<%--								<%if(crsObjDisplayPts!=null){%>--%>
								<input type="text" name="txtptsteam1" id="txtptsteam1" value="<%=crsObjDisplay.getString("team1pts")%>"  onKeyPress="return keyRestrict(event,'0123456789-');">
<%--								<%}else{%>--%>
<%--								<input type="text" name="txtptsteam1" id="txtptsteam1" value=""  onKeyPress="return keyRestrict(event,'0123456789-');">--%>
<%--								<%}%>																--%>
							</td> 
						</tr>
						<tr>							
						   	<td><b>Team 2:</b></td> 
							<td>
<%--								<input type="text" name="txtteam2" id="txtteam2" value="<%=crsObjDisplay.getString("team2name")%>" >--%>
								<label><%=crsObjDisplay.getString("team2name")%> </label>
							</td> 
						</tr>	

						<tr>							
						   	<td><b>Points:</b></td> 
							<td>
<%--								<%if(crsObjDisplayPts!=null){%>							--%>
							<input type="text" name="txtptsteam2" id="txtptsteam2" value="<%=crsObjDisplay.getString("team2pts")%>" onKeyPress="return keyRestrict(event,'0123456789-');">
<%--								<%}else{%>--%>
<%--							<input type="text" name="txtptsteam2" id="txtptsteam2" value="" onKeyPress="return keyRestrict(event,'0123456789-');">--%>
<%--								<%}%>								--%>
															
<%--								<select name="cmbptsteam2" id="cmbptsteam2">--%>
<%--									<option> 1</option>--%>
<%--									<option> 2</option>--%>
<%--									<option> 3</option>--%>
<%--									<option> 4</option>--%>
<%--									<option> 5</option>--%>
<%--								</select>--%>
							</td> 
						</tr>	
										<%}}%>																						
					</table> 					
					<br>
					</fieldset>
					<hr> 	
				</td>
			</tr>
			<tr>				
	       		<td align="right">
	       			<input type="button" id="btnsubmit" name="btnsubmit" value=" Submit" onclick="callNextPage()">
	      			<input type="button" id="btnCancel" name="btnCancel" value="Reset" onclick="cancellation()" >	 
	      			<input type="hidden" id="hdSubmit" name="hdSubmit" value="">      			     			     			
	      			<input type="hidden" id="matchid" name="matchid" value=<%=matchId%> />
	       		</td>
	    	</tr>
		</TABLE>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</form>
</body>			


