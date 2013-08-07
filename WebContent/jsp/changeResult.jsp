<!--
Page Name 	 : changeResult.jsp
Created By 	 : Dipti Shinde.
Created Date : 27-Oct-2009
Description  : To update matchResult
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 27-Oct-2009
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>

<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="java.util.*"%>
<%
	String role=null;	
	String userID = null;
	userID = session.getAttribute("userid").toString();
	session.setAttribute("userId",userID);
	String matchId = request.getParameter("matchId");
	String flag = request.getParameter("flag")==null?"0":request.getParameter("flag");
	String gsmessage = "";	
	
	if(matchId == null){
		matchId = request.getParameter("hidMatchId");
		//session.setAttribute("matchId1",matchId);
	}
	CachedRowSet roleCrs = null;
	CachedRowSet resultCrs = null;
	CachedRowSet teamNameCrs = null;
	CachedRowSet displayDetailsCrs = null;
	CachedRowSet matchResultCrs = null;
	CachedRowSet testResultCrs = null;
	CachedRowSet changeResultCrs = null;
	
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure();
	Vector spParam = new Vector();
	LogWriter log = new LogWriter();
	String team2 = null;
	String team1id = null;
	String team2id = null;
	String team1 = null;
	String testResult = null;
	String gshid = request.getParameter("hidChange")==null?"0":request.getParameter("hidChange");
	String hidChangeResult = request.getParameter("hidChangeResult")==null?"0":request.getParameter("hidChangeResult");
	
	/***********/
		spParam.removeAllElements();
        spParam.add(userID);
		roleCrs = spGenerate.GenerateStoreProcedure("esp_adm_loginrole", spParam, "ScoreDB");

		if(roleCrs!=null){
			while(roleCrs.next()){
				role=roleCrs.getString("role");
				System.out.println("role is "+role);
			}
		}
		
		if(role != null && role.equals("9")){
			session.setAttribute("role",role);
			String r = (String)session.getAttribute("role");
			System.out.println("role....."+r);
		}else{
			session.setAttribute("role",role);//if not admin
		}
	/***********/
	if(gshid.equalsIgnoreCase("1")){
		try{
			String winningTeam = request.getParameter("selectWinTeam")==null?"0": request.getParameter("selectWinTeam");
			String wonByInnings = request.getParameter("selwinbyinning")==null?"0": request.getParameter("selwinbyinning");
			String wonByWickets = request.getParameter("txtWickets")==null?"0": request.getParameter("txtWickets");
			String wonByRuns = request.getParameter("txtRuns")==null?"0": request.getParameter("txtRuns");
			String chkVjdResult = request.getParameter("chkvjdsystem")==null?"-1": request.getParameter("chkvjdsystem");
			String matchResult = request.getParameter("selresult")==null?"0":request.getParameter("selresult");
			spParam.removeAllElements();
			spParam.add(matchId);
			spParam.add(winningTeam);
			spParam.add(wonByInnings);
			spParam.add(wonByWickets);
			spParam.add(wonByRuns);
			spParam.add(chkVjdResult);
			spParam.add(matchResult);
			matchResultCrs = spGenerate.GenerateStoreProcedure("esp_amd_enterendmatchdetail",spParam,"ScoreDB");
			spParam.removeAllElements();
			if(matchResultCrs != null){
				while(matchResultCrs.next()){
					if(matchResultCrs.getString("retval").equalsIgnoreCase("Data Updated")){
						gsmessage = "Result has been updated";
						System.out.println("message :"+gsmessage);
					}else{
						gsmessage = " ";	
					}
				}			
			}
		}catch(Exception e){
		  	log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}
	try{
		spParam.removeAllElements();
		spParam.add(matchId);
		teamNameCrs = spGenerate.GenerateStoreProcedure("esp_dsp_match_teams",spParam,"ScoreDB");
		spParam.removeAllElements();
		if(teamNameCrs!=null){
		  	while(teamNameCrs.next()){
		  		team1id = teamNameCrs.getString("team1id");
		  		team2id = teamNameCrs.getString("team2id");
		  		team1 = teamNameCrs.getString("team1name");
		  		team2 = teamNameCrs.getString("team2name");
			}
		}
	}catch(Exception e){
	  	log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	/*************************************Display Data********************************************/
	String selectedTeam = null;
	String selectedInning = null;
	String enteredWonByRuns = null;
	String enteredWonByWkts = null;
	try{
		spParam.removeAllElements();
		spParam.add(matchId);
		displayDetailsCrs =  spGenerate.GenerateStoreProcedure("esp_dsp_endmatchdetails",spParam,"ScoreDB");
		spParam.removeAllElements();
		if(displayDetailsCrs!=null){
		  	while(displayDetailsCrs.next()){
		  		selectedTeam = displayDetailsCrs.getString("match_winner");
		  		selectedInning = displayDetailsCrs.getString("won_by_innings");
		  		enteredWonByRuns = displayDetailsCrs.getString("won_by_runs");
		  		enteredWonByWkts = displayDetailsCrs.getString("won_by_wickets");
			}
		}
		
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	/*************************************Display Data********************************************/
	/*************************************Display Result********************************************/
	
	try{
		spParam.removeAllElements();
		spParam.add(matchId);
		testResultCrs =  spGenerate.GenerateStoreProcedure("esp_dsp_reportresult",spParam,"ScoreDB");
		spParam.removeAllElements();
		if(testResultCrs!=null){
		  	while(testResultCrs.next()){
		  		testResult = testResultCrs.getString("result");
			}
		}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	/*************************************Display Result********************************************/
	if(hidChangeResult.equalsIgnoreCase("1")){
		try{
			String result = request.getParameter("selresult")==null?"0":request.getParameter("selresult");
			String match_winner = request.getParameter("selectWinTeam")==null?"0":request.getParameter("selectWinTeam");
			spParam.removeAllElements();
			spParam.add(matchId);
			spParam.add(result);
			spParam.add(match_winner);
			changeResultCrs =  spGenerate.GenerateStoreProcedure("esp_amd_updateresult",spParam,"ScoreDB");			
			spParam.removeAllElements();
			if(changeResultCrs!=null){
				while(changeResultCrs.next()){
					gsmessage = changeResultCrs.getString("result");
				}
			}
			
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Update Result</title>
	<link href="../css/csms.css" rel="stylesheet" type="text/css">
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>
	<script type="text/javascript" >
		function updateResult(){			
			if(document.getElementById("selresult").value== "1"){
				if(document.getElementById("selectWinTeam").value== "0"){
					alert("Please select Winner of the match");
					return false;
				}
			}
			document.getElementById("hidChange").value="1";
			document.getElementById("frmchenageResult").action="/cims/jsp/changeResult.jsp";
			document.getElementById("frmchenageResult").submit();
		}

		function previousPage(){
			try{
				var role = document.getElementById('hdRole').value
				if(role == 9){
					document.getElementById("frmchenageResult").action="../jsp/admin/EditMatch.jsp";//dipti 19 05 2009
				}else{
					document.getElementById("frmchenageResult").action="/cims/jsp/TeamSelection.jsp";
				}
				document.getElementById("frmchenageResult").submit();
				//self.close();
				
//				EditMatch.jsp
				/*if (winhandle != null){
					window.opener="";
			        window.close();
				}*/
			}catch(err){
				alert(err.description + 'changeResult.jsp.previousPage()');
			}
		} 

		function changeResult(){			
			if(document.getElementById("selresult").value== "1"){
				if(document.getElementById("selectWinTeam").value== "0"){
					alert("Please select Winner of the match");
					return false;
				}
			}
			document.getElementById("hidChange").value="1";
			document.getElementById("frmchenageResult").action="/cims/jsp/changeResult.jsp";
			document.getElementById("frmchenageResult").submit();
		}	
	</script>
</head>
<body>
	<% if(flag.equalsIgnoreCase("0")){%>
		<jsp:include page="MenuScorer.jsp"></jsp:include>
	<%} %> 
	<br />
	<br />
	<form id="frmchenageResult" name="frmchenageResult" method="post">
	<table style="width:90%"  border="0" cellspacing="1" cellpadding="3">
		<tr>
			<td width="100%" colspan="8">
				<table  align="center" width="100%">
					<% if(flag.equalsIgnoreCase("0")){%>
					<tr>
						<td  align="left">
							<input type="button" value="Back" onclick="previousPage()">
						</td>
					</tr>	
					<%} %>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr class="tenoverupdateball">
						<th align="center" ><b>Match Id : <%=matchId%></b></th>
					</tr>
				</table>
			</td>
		</tr>
      	<tr>
      		<td>
      			&nbsp;
      		</td>
      	</tr>
		<tr>
		      		
<%				if(testResult == null){
%>		      		<td cellpadding="5" nowrap="nowrap" class="contentLastDark" align="left" colspan="4"><b>Result: ---</b>	
		      		</td>
<%				}else{			
%>		      		<td cellpadding="5" nowrap="nowrap" class="contentLastDark" align="left" colspan="4"><b>Result: -	<%=testResult%></b>
		      		</td>
<%				}
%>
		 </tr>
		 <%------------------------    Added by Supriya Thakur 03/12/2010 ----------------%>
		 <tr>
			 <td class="contentLastDark" colspan="4">
			 <b>Select Match Winner </b>
			  <select id="selectWinTeam" name="selectWinTeam">
			  <option value="0" >Select </option>			
		      	<option value=<%=team1id%> ><%=team1%> </option>
				<option value=<%=team2id%> ><%=team2%> </option>		      	
		      </select> 
			 </td>
		</tr>
		 <%-------------------------------------------------------------------------------%>
		 <tr>
		    <td class="contentLastDark" colspan="4">
		      <b>Change match result to 
		      <select id="selresult" name="selresult">
		      	<option value="0">Continue </option>
				<option value="1">Won </option>
		      	<option value="2">Drawn</option>
		      	<option value="5">Cancel</option>
		      	<option value="5">Match Abandoned </option>
		      </select> 
		   </td>
	  	</tr>
		<tr>
		    <td class="contentLastDark" colspan="4">
		      <b>Won By Wickets </b>
				<input type="text" id="txtWickets" name="txtWickets" value="">
			 </td>
	  	</tr>
		<tr>
		    <td class="contentLastDark" colspan="4">
		      <b>Won By Runs </b>
				<input type="text" id="txtRuns" name="txtRuns" value="">
		    </td>
	  	</tr>
		<tr>
			 <td class="contentLastDark" colspan="4">
			 <b>Won By Innings </b>
			  <select id="selwinbyinning" name="selwinbyinning">
			  <option value="0" >Select </option>			
		      	<option value="1" >Yes </option>
				<option value="0" >No</option>		      	
		      </select>
			 </td>
		</tr>
		<tr>
		    <td class="contentLastDark" colspan="4">
		      <b>Won By VJD System </b>
				<input type="checkbox" id="chkvjdsystem_id" name="chkvjdsystem" value="1">
			  <input type="button" value="Change Result" class="btn" tabindex="4" onclick="changeResult();"></input>
		      <input type="hidden" id="hidChange" name="hidChange" value=""> 
		    </td>
	  	</tr>
      	<tr>
      		<td colspan="4">
      			&nbsp;
      		</td>
      	</tr>
      	<tr>
      		<td align="center" width="10%" colspan="8">
      			<input type="hidden" name="selInning" id="selInning" value="0">
      			<input type="hidden" name="hidChange" id="hidChange" value="0">
      			<input type="hidden" name="hidMatchId" id="hidMatchId" value="<%=matchId%>">
	      		<!-- <input type="button" value="ADD" class="btn" tabindex="4" onclick="updateResult();"></input>-->      		 </td>
      		
      	</tr>
      	<tr>
      		<td align="center" width="10%" colspan="8"><b><%=gsmessage %></b></td>
      	</tr>
    </table>
    <input type="hidden" id="hdRole" name="hdRole" value="<%=role%>">
   </form> 
</body>
</html>