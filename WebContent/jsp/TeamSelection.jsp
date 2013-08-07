<%@ page import="sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*"%>

<%  	response.setHeader("Pragma","private");
		response.setHeader("Pragma", "No-cache");
	    response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");  
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);

%>
<%@ include file="AuthZ.jsp" %>
<%
		String match_id	="";
		String matchId="";
		String Status="";
		String flag	=	"";		
		String cmbMatch = "";
		String getInningId="";
		String getballcount = "";
		String userId="";	
		String MatchScoreId = "";
		Vector vecUserId = new Vector();
		String days = "";
		CachedRowSet dateCachedRowSet = null;
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();	
		String scorer_Id = request.getParameter("scorer_Id");//(String)session.getAttribute("scorer_Id");  
		if(scorer_Id != null){
			session.setAttribute("userid",scorer_Id);
		}else{
		scorer_Id = (String)session.getAttribute("userid");
		}
		String teamName = "";
		String strTossPage = "";
		String loginname = (String)session.getAttribute("username");
		String loginId = (String)session.getAttribute("userid");
		try{	
				CachedRowSet  matchCachedRowSet		= null;
				CachedRowSet  matchCatCachedRowSet	= null;
                CachedRowSet  detailsCatCachedRowSet= null;
				CachedRowSet  crsCheckScorerInning  = null;		
				CachedRowSet teamNameCatachedRowSet	= null;		
				CachedRowSet matchresetCatCachedRowSet  = null; 
				CachedRowSet  lobjCachedRowSet		= null;
				CachedRowSet  editCachedRowSet		= null;		
				CachedRowSet  crsCheckconcisematch	= null;		
														
				//Added by archana for timer
				Date servertime = new Date();
				String Hour = Integer.toString(servertime.getHours());
				String min = Integer.toString(servertime.getMinutes());
				String sec = Integer.toString(servertime.getSeconds());
				//String Hour = "23";
				//String min =  "59";
				//String sec = "50";	
				System.out.println("total time is  "+Hour+":"+min+":"+sec);
				String time =  Hour+":"+min+":"+sec;
				//end Archana				
				
				String editopt = "";
				String conciseinning = "";
				String scoringtype = "";
				boolean concise =  false;
				Vector vparam =  new Vector();				
				String inningResult = null;
				if(scorer_Id!=null){
                vparam.add(scorer_Id);
                matchCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match",vparam,"ScoreDB");               								
                vparam.removeAllElements();  
				}
				vparam.add("1");
				lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_time",vparam,"ScoreDB");
				vparam.removeAllElements();
				while(lobjCachedRowSet.next()){	
					time =lobjCachedRowSet.getString("currentdate");
				}
		if(request.getMethod().equalsIgnoreCase("Post")){
				match_id = request.getParameter("hdmatch_id");//
				
				cmbMatch = request.getParameter("cmbMatch");//				
				//System.out.println("**cmbMatch****"+cmbMatch+"**********match_id hidden "+match_id);				
				session.setAttribute("matchId1",match_id);
                matchId = (String)session.getAttribute("matchId1");              
                System.out.println("****matchId"+matchId);    
				 flag =request.getParameter("hdflag");
				if(flag!=null){
				if(flag.equals("2")){				
					//Added by archana for inning check.
					vparam.add(match_id);
					crsCheckconcisematch = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_checkconcisematch",vparam,"ScoreDB");
					vparam.removeAllElements();
					if(crsCheckconcisematch!=null){	
						while(crsCheckconcisematch.next()){	
							conciseinning = crsCheckconcisematch.getString("inning");
							scoringtype = crsCheckconcisematch.getString("scoring_type");
							concise = true;
						}
					}			
					
						vparam.add(match_id);
						vparam.add(scorer_Id);					
						//crsCheckScorerInning = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_checkscorerinning",vparam,"ScoreDB");	//Nitin 16/08/2008
						crsCheckScorerInning = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_checkscorerinningTestMatch",vparam,"ScoreDB");
						vparam.removeAllElements();
						if(crsCheckScorerInning!=null){	
						while(crsCheckScorerInning.next()){
							inningResult = crsCheckScorerInning.getString("result");						
							if(inningResult.equalsIgnoreCase("Previous")){
								getInningId = crsCheckScorerInning.getString("id");
								getballcount = crsCheckScorerInning.getString("ballpresent");														
							}else if(inningResult.equalsIgnoreCase("tmplayer")){
								strTossPage = "Next";
							}
							//added by nitin 19/09/2008
							session.setAttribute("InningId",getInningId);
						}
						}					
						session.setAttribute("InningId",getInningId);				 		 
						//end -archana.		
						
		                vparam.add("1");
		                vparam.add(match_id);	
						matchCatCachedRowSet 	= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchcategory",vparam,"ScoreDB");					
	                 	vparam.removeAllElements();
						vparam.add(match_id);	
	                    detailsCatCachedRowSet  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getprematchtype",vparam,"ScoreDB");					
						vparam.removeAllElements();
						//added for disabling edit option
						vparam.add(match_id);	
						vparam.add(scorer_Id);
	                    editCachedRowSet  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_editoption",vparam,"ScoreDB");					
						vparam.removeAllElements();
						if(editCachedRowSet!=null){
						while(editCachedRowSet.next()){
							editopt = editCachedRowSet.getString("RetVal");
							MatchScoreId = editCachedRowSet.getString("userId");
							Status = editCachedRowSet.getString("Status");
						}
						}
						if(Status.trim().equalsIgnoreCase("A") && MatchScoreId.equalsIgnoreCase(scorer_Id)){
							editopt="yes";
						}
				 }// end of flag 2				
			 }	
			}
			String hdflag = request.getParameter("hdresetflag")==null?"0":request.getParameter("hdresetflag");
			if(hdflag.equalsIgnoreCase("1")){
				 match_id = (String)session.getAttribute("matchId1");
				 vparam.add(match_id);	
				 matchresetCatCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_resetmatch",vparam,"ScoreDB");					
                 vparam.removeAllElements();

			}  
			if(hdflag.equalsIgnoreCase("2")){
				 match_id = (String)session.getAttribute("matchId1");
				 vparam.add(match_id);	
				 matchresetCatCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_matchabounded",vparam,"ScoreDB");					
                 vparam.removeAllElements();

			}  
%>
<html>
  <head>    
    <title>Match Selection</title>
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">	  
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css"> 
    <link rel="stylesheet" type="text/css" href="../css/tabexample.css">
<link rel="stylesheet" type="text/css" href="../css/tabexample.css">
	<script language="javascript">	

	var mine = window.open('','','width=1,height=1,left=0,top=0,scrollbars=no');
	 if(mine)
    	var popUpsBlocked = false
	 else
    	var popUpsBlocked = true
	 mine.close()
 

		 function callMain(){
			//Added by archana for inning check.
			var inId = document.getElementById('hdinningId').value;
			var inId11 = document.getElementById('hdinningresult').value;
 			var matchId = document.getElementById('hdmatch').value;
			var flg = "P";
		 	if(document.getElementById('cmbMatch').value == "0"){
		 		alert("Please select Match");
		 	}
		 	else{
		 		if(document.getElementById('hdinningresult').value == "Previous"){
					if(document.getElementById('hdballcount').value <= 0){
						document.frmTeamSelection.action = "/cims/jsp/selectbatsmanbowlers.jsp?InningId="+inId+"&matchId="+matchId;
						document.frmTeamSelection.submit();	
					}
					else{ 			 
						var winhandle = window.open("/cims/jsp/scorer.jsp?InningIdPre="+inId+"&flg="+flg,"CIMS","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-20)+",height="+(window.screen.availHeight-30));	
				 		if (winhandle != null){
					        window.opener="";
					        window.close();
					     }   
					}
				}else if(document.getElementById('hdinningresult').value == "Next"){
					document.frmTeamSelection.action = "/cims/jsp/SetSecondInning.jsp";
					document.frmTeamSelection.submit();
				}else if(document.getElementById('hdinningresult').value == "first"){//end archana's part.			
					var strConfirm = confirm("Do you want to select this match");
					if(strConfirm){
			 			var team1		= document.getElementById('cmbTeam1').value; // Combo Value		 	
			 			var team2 		= document.getElementById('cmbTeam2').value; // Combo Value
			 			var match		= document.getElementById('cmbMatch').value; // Combo Value	
			 			document.getElementById('hdmatch_id').value = document.getElementById('cmbMatch').value;
			 			var matchid =  document.getElementById('cmbMatch').value;	 	
						var flag		= "1";
						document.frmTeamSelection.action = "/cims/jsp/WeatherPitchTossSelection.jsp?team1="+team1+"&team2="+team2;
						document.frmTeamSelection.submit();
					}else{
						document.frmTeamSelection.action ="/cims/jsp/TeamSelection.jsp";
						document.frmTeamSelection.submit();
					}
				}else if(document.getElementById('hdinningresult').value == "Completed"){
						alert("Completed");
				}else if(document.getElementById('hdinningresult').value == "tmplayer"){
						var strConfirm = confirm("Do you want to select this match");
						if(strConfirm){
					 		var team1		= document.getElementById('cmbTeam1').value; // Combo Value		 	
					 		var team2 		= document.getElementById('cmbTeam2').value; // Combo Value
					 		var match		= document.getElementById('cmbMatch').value; // Combo Value	
					 		document.getElementById('hdmatch_id').value = document.getElementById('cmbMatch').value;
					 		var matchid =  document.getElementById('cmbMatch').value;	 	
							var flag		= "1";				
				 			document.frmTeamSelection.action = "/cims/jsp/WeatherPitchTossSelection.jsp?team1="+team1+"&team2="+team2;
							document.frmTeamSelection.submit();	
				 		}
				}	
			}	 						 			 	
		 }
		 function conciseMain(){
		 	document.frmTeamSelection.action = "/cims/jsp/concise/ConciseMatchTab.jsp";
			document.frmTeamSelection.submit();	
		 }
		 function updateOver(){
			 try{
				var inId = document.getElementById('hdinningId').value;
				var matchId = document.getElementById('hdmatch').value;
				
				if(document.getElementById('cmbMatch').value == "0"){
				 		alert("Please select match");
				}else{
					winhandle = window.open("/cims/jsp/updateMatchInnings.jsp?inningsId="+inId+"&matchId="+matchId,"CIMSINNINGS","location=no,directories=no,status=Yes,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth)+",height="+(window.screen.availHeight))
					// window.close();
					/*if (winhandle != null){
						window.opener="";
				        window.close();
	    			}*/
	   		 }
			}catch(err){
				alert(err.description + 'Teamselection.jsp.updateOver()');
			}		
		 }
		/* function updateResult(){
			 var matchId = document.getElementById('hdmatch').value;
			 winhandle = window.open("/cims/jsp/changeResult.jsp?&matchId="+matchId,"CIMSINNINGS","location=no,directories=no,status=Yes,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth)+",height="+(window.screen.availHeight))
		 }	*/ 
		 function call(){
		 	document.frmTeamSelection.action = "/cims/jsp/InningsDetails.jsp";
		 	document.frmTeamSelection.submit();
		 }
		 function viewlist(){
		 	var isok = validate()
		 	if(isok){
			 	var match = document.getElementById('hdmatch').value
			 	var team1 = document.getElementById('cmbTeam1').value; // Combo Value		 	
				var team2 = document.getElementById('cmbTeam2').value; // Combo Value
			
				if(document.getElementById('cmbMatch').value == "0"){
					 		alert("Please select match");
				}else{	
			 		window.open("/cims/jsp/playerlist.jsp?match="+match+"&team1="+team1+"&team2="+team2,"playerlist","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=Yes,top=50,left=10,width=990,height=600");	
			 	}
		 	}
		 }
		 
		 function validate(){
		 	var select = document.getElementById('cmbMatch').value
		 	if(select == "0"){
		 		alert("Please select match");
		 		return false
			}else{
				return true
			}
		 }
		 
		  function resetMatch(){
	  	   var r = confirm("Do you want to reset this match?");
           if (r) {
			  	document.getElementById('hdmatch_id').value = document.getElementById('cmbMatch').value;
			 	document.getElementById('hdresetflag').value = "1";		
			 	document.frmTeamSelection.action = "/cims/jsp/TeamSelection.jsp";
				document.frmTeamSelection.submit();
		   }		
		 }
		 function cancelSelection(){		 	
		 	document.frmTeamSelection.action = "/cims/jsp/TeamSelection.jsp";
			document.frmTeamSelection.submit();
		 }
		 function matchid(){			 	
		 	document.getElementById('hdmatch_id').value = document.getElementById('cmbMatch').value;			 
			 	document.getElementById('hdflag').value	= "2";		 	 
				document.frmTeamSelection.action = "/cims/jsp/TeamSelection.jsp";
				document.frmTeamSelection.submit();		 
			
		 }
		 function updateMatchRemark(){
			 username=window.prompt("Please enter interval deatils",""); 
			 
		 }	 
		 function matchaboundent(){
			 var r = confirm("Do you want to aboundent selected match?");
	           if (r) {
				  	document.getElementById('hdmatch_id').value = document.getElementById('cmbMatch').value;
				 	document.getElementById('hdresetflag').value = "2";		
				 	document.frmTeamSelection.action = "/cims/jsp/TeamSelection.jsp";
					document.frmTeamSelection.submit();
			   }
		 }		 

		 function CreateMatch(){	
		 	//if(popUpsBlocked)
  			//	alert('We have detected that you are using popup blocking software.Please allow popup blocker. See the help Enable popup blocker.');
  			//}
			callPopup()
			 
			var scorer1Id = document.getElementById("hduserID").value;
			var scorer1name = document.getElementById("hduserName").value;
			var r = confirm("Do you Want to Create Match ?");
			if (r == true){
				var openwin = window.open("/cims/jsp/CreateDemoMatch.jsp?scorer1Id="+scorer1Id+"&scorer1name="+scorer1name,"CIMS","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=100,left=100,width=850,height=550");
				if(!openwin){
					alert('Pop Up Blocker Installed. Allow popup from this site.')
				}
			}
			//else{
				//document.frmAdminMatchSetUp.action = "AdminMatchSetUp.jsp";
				//document.frmAdminMatchSetUp.submit();
			//}	 	
		 }
		 
		 /*Added by Archana : To display running timer/clock*/
		 function getservertime(){		
			var time = document.getElementById("time").value;
			var str= time.split(":");
			var hre = str[0];
			var mins = str[1];
			var sec = str[2];
			setvalues(hre,mins,sec);			
			}
			
			function setvalues(h1,m1,s1){
				s1++;
				if(s1 == 60){
					m1++;
					var s1 = 00;
					if(m1 == 60){
						h1++;
						var m1 = 00; 
						if(h1 == 24){
							var h1 = 00;
						}
					}
				}
				if(s1<10){
					s1 = 0+""+s1;		
				}
				if(m1<10){
					m1 = 0+""+m1;		
				}
				if(h1<10){
					h1 = 0+""+h1;		
				}
				document.getElementById("time").value = h1+":"+m1+":"+s1;
				timerId = setTimeout("setvalues("+h1+","+m1+","+s1+")",1000);	
			}	
			/*End of Archana*/	 
	</script>        
</head>

<script type="text/JavaScript" language="JavaScript">
	function callPopup()
	{
	if(popUpsBlocked)
	  alert('We have detected that you are using popup blocking software.\nThis easy article can show you how to detect this using Javascript...');
	} 
</script>

<body onload="getservertime()">

<form name="frmTeamSelection" id="frmTeamSelection" class="MainBodyTrans" method="post">	
	<table width="100%">
	<tr>	
		<td>	
			<jsp:include page="Banner.jsp"></jsp:include>
			<jsp:include page="MenuScorer.jsp"></jsp:include> 
		</td>	
	</tr>
	</table>
	<br>			
	<table align="center" width="100em">
	<tr>
		<td nowrap="nowrap">Server Time:</td>
	   	<td>
			<input type="text" name="time" id="time" value="<%=time%>" readonly style="width:150px;"/>
		 </td>
		 <td><input class="btn btn-warning btn-small" type="button" name="btnrefresh" id="btnrefresh" value="Refresh" onclick="cancelSelection();" /></td>
	</tr>
	</table>
	<table width="100%" align="center">
	<tr align="center">				
		<td align="center" class="legend">Match Selection</td>
		<td><input type="hidden" name="hdmatch_id" id="hdmatch_id" value=""></td>						
	</tr>
	</table>	
	<table width="100%" align="center" cellpadding="1" border="1">
	<tr>
		<td align="center">
		<fieldset id="fldsetMchTypeCategory" class="background" > 
		<legend  class="">
			<a class="aheading">Current Match  </a>			
		</legend> 		
			<table width="100%" align="center" border="0" class="table">
			<tr align="center">
				<input type="hidden" name="hdmatch_id" id="hdmatch_id" value=""><input type="hidden" name="hduserID" id="hduserID" value="<%=loginId%>">
				<input type="hidden" name="hduserName" id="hduserName" value="<%=loginname%>">			
			</tr>				
			<tr align="center" >
				<td align="CENTER" colspan="2"><b>Match:</b></td>					
				<td colspan="3" align="CENTER">
				<select name="cmbMatch" id="cmbMatch" onchange="matchid()"  style="width: 300px">
					<option value="0" >Select</option>
<%					if(matchCachedRowSet!=null){
					while(matchCachedRowSet.next()){
					if(matchCachedRowSet.getString("matchid").equalsIgnoreCase(cmbMatch)){%>
					<option value="<%=matchCachedRowSet.getString("matchid")%>" selected="selected">
								 	<%=matchCachedRowSet.getString("teams")%></option>
<%					}else{
%>
					<option value="<%=matchCachedRowSet.getString("matchid")%>"><%=matchCachedRowSet.getString("teams")%></option>
<%					}
					}// end of while
					}// end of if
%>					
				</select>
					<input type="hidden" name="hdflag" id="hdflag" value="">
				</td>
			</tr>
			</table>
			<br>		
		</fieldset>
		</td>
	</tr>
<%		if(flag!=null && flag!=""){	
%>
	<tr>
		<td>
		<fieldset id="fldsetMchTypeCategory" class="background"> 
		<legend  class="" >
			<a class="aheading">Match Details </a>
		</legend> 		
		<table width="100%" class="table">				
		<tr class="contentDark" height="10%">
			<td><font size="2" color="#003399"><b>Match Category:</b></font></td>
			<td>
<%				if(matchCatCachedRowSet!=null){
				while(matchCatCachedRowSet.next()){				
%>					<%=matchCatCachedRowSet.getString("name")%>
<%				}
				}
%>			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<%if(detailsCatCachedRowSet!=null && detailsCatCachedRowSet.next()){%>				
		<tr class="contentLight" height="10%">
			<td><font size="2" color="#003399"><b>Series:</b></font></td>					
			<td>
				 <%=detailsCatCachedRowSet.getString("series")%>
			</td>		
			<td><font size="2" color="#003399"><b>Match Type:</b></font></td>
			<td colspan="2">
				 <%=detailsCatCachedRowSet.getString("matchtype")%>
			</td>								
		</tr>
		<br>
		<tr class="contentDark" height="10%">
			<td><font size="2" color="#003399"><b>Team1:</b></font></td>
			<td>
				<%=detailsCatCachedRowSet.getString("team1name")%>
				<input type="hidden" value="<%=detailsCatCachedRowSet.getString("team1id")%>" name="cmbTeam1" id="cmbTeam1">
			</td>	
			<td><font size="2" color="#003399"><b>Team2:</b></font></td>					
			<td colspan="2">
				<input type="hidden" value="<%=detailsCatCachedRowSet.getString("team2id")%>" name="cmbTeam2" id="cmbTeam2">
				<%=detailsCatCachedRowSet.getString("team2name")%> 
			</td>					
		 </tr>
		 <br>
		<tr class="contentLight" height="10%">
			<td><font size="2" color="#003399"><b>Venue</b></font></td>					
			<td>
				<%=detailsCatCachedRowSet.getString("venue")%>
			</td>		
			<td><font size="2" color="#003399"><b>City:</b></font></td>					
			<td colspan="2">
				<%=detailsCatCachedRowSet.getString("city")%>
<%			}	
%>			</td>				
		</tr>
		</table>
		</fieldset>
		<input type="hidden" name="scorer_Id" id="scorer_Id" value="<%=scorer_Id%>">
		</td>
	</tr>
<%		}
%>
	<tr align="center" height="10%">
		<td align="center" >
<%			if(!concise){	
%>				<input class="btn btn-warning" type="button" name="btnNext" id="btnNext" value="NEXT" onclick="callMain();" >				
				<input class="btn btn-warning" type="button" name="btnConti" id="btnConti" value="CONTI..." onclick="callMain();" disabled="disabled">						
				<input class="btn btn-warning" type="button" name="btnCancel" id="btnCancel" value="RESET" onclick="cancelSelection()">
				<input class="btn btn-warning" type="button" name="btnupdateMatchRemark" id="btnupdateMatchRemark" value="Enter Interval" onclick="updateMatchRemark();">			
<%			}else{
				if(conciseinning.equalsIgnoreCase("0")){
%>				<input class="btn btn-warning" type="button" name="btnNext" id="btnNext" value="NEXT" onclick="callMain();" >				
				<input class="btn btn-warning" type="button" name="btnConti" id="btnConti" value="CONTI..." onclick="conciseMain();" disabled="disabled">
<%				}else{
%>				<input class="btn btn-warning" type="button" name="btnNext" id="btnNext" value="NEXT" onclick="callMain();" disabled="disabled" >				
				<input class="btn btn-warning" type="button" name="btnConti" id="btnConti" value="CONTI..." onclick="conciseMain();" >				
<%				}
			}
			int port = 0;
			port = request.getServerPort();
			//System.out.println("port||||||||||||||||||||||||||||||||||||" +port);
			if (port != 80 && port !=  8084)
			{
%>
				<input class="btn btn-warning" type="button" name="btnCreateMatch" id="btnCreateMatch" value="Create Match" onclick="CreateMatch()" >				
<%
			}
			
%>		
	<!--	<input type="button" name="btnreset" id="btnreset" value="ResetMatch" onclick="resetMatch();">-->
			<input class="btn btn-warning" type="button" name="btnviwelist" id="btnviwelist" value="View Player List" onclick="viewlist();">
			<% 
			if(editopt.equalsIgnoreCase("yes")){%>
			<input class="btn btn-warning" type="button" name="btnedit" id="btnedit" value="Edit" onclick="updateOver();">
			<%}%>
			<input class="btn btn-warning" type="button" name="btnmatchabondoned" id="btnmatchabondoned" value="Match Abondoned" onclick="matchaboundent();" >
<!--			<input type="button" name="btnresult" id="btnresult" value="Update Result" onclick="updateResult();" disabled="disabled">-->
			
			
		</td>
		<td>
			<input type="hidden" name="hdmatch" id="hdmatch" value="<%=matchId%>">
			<input type="hidden" name="hdinningresult" id="hdinningresult" value="<%=inningResult%>">
			<input type="hidden" name="hdballcount" id="hdballcount" value="<%=getballcount%>">				
			<input type="hidden" name="hdinningId" id="hdinningId" value="<%=getInningId%>">
			<input type="hidden" name="matchName" id="matchName" value="<%=teamName%>">
			<input type="hidden" name="hdresetflag" id="hdresetflag" value="0">
		</td>
	</tr>
	</table>
<%			if(!concise){	
%>
	<script language="javascript">
		try{
			var	getInningResult="";
			getInningResult=document.getElementById('hdinningresult');
			if(getInningResult!=null && getInningResult!=""){
				if(document.getElementById('hdinningresult').value == "Previous"){
					document.getElementById('btnConti').disabled=false;
					document.getElementById('btnNext').disabled=true;
				}else if(document.getElementById('hdinningresult').value == "Next"){
					document.getElementById('btnConti').disabled=true;
				}else if(document.getElementById('hdinningresult').value == "first"){
					document.getElementById('btnConti').disabled=true;
				}else if(document.getElementById('hdinningresult').value == "Completed"){
					alert("Match Completed!Please Select Current Match ");
						//document.getElementById('btnNext').disabled=false;
					document.getElementById('btnNext').disabled=true;
					document.getElementById('btnConti').disabled=true;
					//document.getElementById('btnresult').disabled=false;
					
					//document.getElementById('btnView').disabled=false;
				}
			}
		}catch(err){
    		alert(err.description);
    	}
	</script>
<%		}
%>
<%
	}catch(Exception e){
		e.printStackTrace();
		out.println(e);
	}
			//System.out.println("session.getAttribute" +session.getAttribute("popup"));
	try
	{
		/* vecUserId.add((String)session.getAttribute("userid"));
		 dateCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_profile_date",vecUserId,"ScoreDB");        vecUserId.removeAllElements();  
		
		 if (dateCachedRowSet!=null)
		 {
			 while (dateCachedRowSet.next())
			 {
				 days = dateCachedRowSet.getString("days")!=null?dateCachedRowSet.getString("days"):"0";
				
			 }
		 }*/
	}
	catch(Exception e)
	{
		System.out.println("Exception 4" +e.getMessage());
	}
	 if (days=="")
	 {
		 days="0";
	 }
	// System.out.println("days++++++++++++++++++++++++++++" +days);
	if (Integer.parseInt(days) <= 15)
	{
		if (session.getAttribute("popup")==null)
		{
%>
		<script>
			window.open("/cims/jsp/admin/UpdateProfile.jsp","cims","location=no,directories=no, status=no,menubar=no, scrollbars=Yes,resizable=Yes,top=100,left=100,width=850,height=500");
		</script>
<%		}
		session.setAttribute("popup","showpopup");
	}
%>
			
</form>
</body>
</html>