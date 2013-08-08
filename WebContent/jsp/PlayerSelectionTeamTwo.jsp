<!--
Page Name 	 : playerSelectionteam2.jsp
Created By 	 : Avadhut Joshi
Created Date : 27th Aug 2008
Description  : Selection of players for team 2
Company 	 : Paramatrix Tech Pvt Ltd.
Updated on: 05.57 pm 11/09/2008
Updated on: 03.25 pm 13/09/2008 by Avadhut
Updated on: 03.25 pm 14/10/2008 by Avadhut
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"%>
<%  	response.setHeader("Pragma","private");
		response.setHeader("Pragma", "No-cache");
	    response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");  
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
%>

<%

		try{					
                CachedRowSet  teamPlayersCachedRowSet 	= null;										
				CachedRowSet  crsTeamName				= null;
				CachedRowSet  crsmatchId				= null;
				Vector 			vparam 			= new Vector();
				int		 		flag			= 2;
				String   		team1			= null; 
				String   		team2			= null; 
				String   		captain			= null; 
				String   		wicketkeeper 	= null;
				String   		extraplayer 	= null;
				String 	 		palyerId		= null;	
				String 	 		extras			= null;	
				String 			team2name 		= null;	
				String 			scoring_type    = null;
//DECLARATIon						
     					 team1 			= request.getParameter("hdteam1");		
						 team2 			= request.getParameter("hdteam2");
						 captain 		= request.getParameter("hdCaptain");//request.getParameter("strCaptain");
						 wicketkeeper 	= request.getParameter("hdWicketKeeper");//request.getParameter("strWicketkeeper");hdWicketKeeper
 						 extraplayer 	= request.getParameter("hd12thMan");
					 	 palyerId		= request.getParameter("hdteamPlayers");	
					 	 extras			= request.getParameter("hdteamPlayersextra");		
					    	
//CALLING SP
//INSERTINg Team1 Players in the DB
					String MatchId = (String)session.getAttribute("matchId1");
 					
 					
 					GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(MatchId);
 					/*vparam.add(MatchId);
 					vparam.add(team1);
					vparam.add(palyerId);
					vparam.add(captain);
					vparam.add(wicketkeeper); 
					vparam.add(extraplayer); 
					vparam.add(extras); 					
					teamPlayersCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_teamplayers1",vparam,"ScoreDB");													
					vparam.removeAllElements();*/ 				
 				if(flag == 2){	//TO DISPLAY TEAM2 PLAYERS IN THE LIST BOX
					
					vparam.add(MatchId);
					vparam.add(team2);
					teamPlayersCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchteamplayers",vparam,"ScoreDB");																					
					vparam.removeAllElements();
				}
%>

<%				vparam.add(team2);
				crsTeamName = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamname",vparam,"ScoreDB");																					
				vparam.removeAllElements();	
				while(crsTeamName.next()){				
						team2name = crsTeamName.getString("team_name");
				}
				
				vparam.add(MatchId);
				crsmatchId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concisematch",vparam,"ScoreDB");																					
				vparam.removeAllElements();	
				while(crsmatchId.next()){				
						scoring_type = crsmatchId.getString("scoring_type");
				}
%>	
<html>
  <head>    
    <title>'Player Selection'</title> 
    <script language="JavaScript" src="../js/playerCombo.js" type="text/javascript"></script>    
    <link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">    
	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">   
<script>
var MAXPLAYERS = 16; 

 	 		 
		 
function callMain(){
			
			var strExtraPlayers	= "";
			var MAXPLAYERSExtra = 0;
			var selctPlayerExtraObjArr =""; 
			var flagExtra = true;
		 	selctPlayerExtraObjArr=document.getElementById('lbSelectedPlayersExtra').options
		 	///
		 	for(var i=0;i< selctPlayerExtraObjArr.length;i++){	
		 	strExtraPlayers = strExtraPlayers + selctPlayerExtraObjArr[i].value + "~";			
				if((selctPlayerExtraObjArr[i].value == document.getElementById('cmbCaptain').value)||
					(selctPlayerExtraObjArr[i].value == document.getElementById('cmbWicketKeeper').value)||
					(document.getElementById('cmb12thMan').value == selctPlayerExtraObjArr[i].value)){
					alert("Extra Player cannot be 12th Man or Captain or Wicket Keeper");
					flagExtra = false;
				}
			}		
			//added on 14/10
	var selLength = document.getElementById('lbSelectedPlayers').length;
		if(selLength == 12){	
		MAXPLAYERSExtra = 0; 				
	}else if(selLength == 13){	
		MAXPLAYERSExtra = 1; 				
	}else if(selLength == 14){	
		MAXPLAYERSExtra = 2; 				
	}else if(selLength == 15){	
		MAXPLAYERSExtra = 3; 				
	}else if(selLength == 16){	
		MAXPLAYERSExtra = 4; 				
	}
	var selLengthextra = document.getElementById('lbSelectedPlayersExtra').length;	 			 	
			//added on 14/10 end 	
			if(flagExtra == true){				
			var selLength = document.getElementById('lbSelectedPlayers').length;
			var selLengthextra = document.getElementById('lbSelectedPlayersExtra').length;				
			if((document.getElementById('cmb12thMan').value == document.getElementById('cmbCaptain').value)||
			(document.getElementById('cmb12thMan').value == document.getElementById('cmbWicketKeeper').value)){
			alert("12th Man cannot be Captain or Wicket Keeper");
			}else if(selLength<12){
					alert("Please select minimum 12 players!");
				}else if(selLengthextra<MAXPLAYERSExtra){
					alert("Please select "+MAXPLAYERSExtra+" extra players!");
				}else{
			var strConfirm = confirm("Do you want to select these players");
			if(strConfirm == true){
		 	var strCaptain		= document.getElementById('cmbCaptain').value; // Combo Value	 	
		 	var strWicketkeeper	= document.getElementById('cmbWicketKeeper').value; // Combo Value	
			var str12thMan	= document.getElementById('cmb12thMan').value; // Combo Value						 			 		 			 	
		 	var strTeam2Players	= "";
		 	var selctPlayerObjArr=document.getElementById('lbSelectedPlayers').options
		 	for(var i=0;i< selctPlayerObjArr.length;i++){
			 strTeam2Players = strTeam2Players + selctPlayerObjArr[i].value + "~";
		 	}
			var flag			= "1";
			var hdflag			= "2"	
			document.getElementById('hdteamPlayers').value 	=	strTeam2Players;
			document.getElementById('hdCaptain').value 	   	=	strCaptain;
			document.getElementById('hdWicketKeeper').value =	strWicketkeeper;
			document.getElementById('hd12thMan').value 		=	str12thMan;	
			document.getElementById('hdteamPlayersextra').value	=   strExtraPlayers;							
	 		
	 		var scoring_type  = document.getElementById("hdscoring_type").value;
	 		if(scoring_type=="C"){
	 		  var conciseflag = confirm("You are entering concise match. Do you want to continue")	
	 		  if(conciseflag){
	 		  	document.frmPlayersSelection2.action = "/cims/jsp/concise/ConciseMatchTab.jsp";
				document.frmPlayersSelection2.submit();	
	 		  }
	 		}else{
	 		 document.frmPlayersSelection2.action = "/cims/jsp/selectbatsmanbowlers.jsp";
			 document.frmPlayersSelection2.submit();	
			}
		  }else{
		   	 		//document.frmPlayersSelection2.action = "PlayerSelectionTeamTwo.jsp";
					//document.frmPlayersSelection2.submit();	  	
		     }	 
     	   }	
     	   }
		 }
		 
function cancelSelection(){		 	
		 	document.frmPlayersSelection2.action = "/cims/jsp/PlayerSelectionTeamTwo.jsp";
			document.frmPlayersSelection2.submit();	 
		 }
</script>
  </head>
  
  <body>
  	<form id="frmPlayersSelection2" name="frmPlayersSelection2" action="Post">
  	<table width="100%">
	<tr>
		<td>	
			<jsp:include page="Banner.jsp"></jsp:include>
		</td>	
	</tr>
	</table>
	<table border="0" width="100%" height="40%">
	<tr>
		<td colspan="3" class="legend" align="center">Select Players for Team   <%=team2name%></td>
	</tr>
	<tr>
		<td colspan="3"><hr></td>
	</tr>
		<tr>
		<td align="center"><b>Available Players<b>
		<td></td>
		<td align="center"> <b>Selected Players:</b>
		<input type="text" name="txtselectedpl" id="txtselectedpl" value="" style="font-weight: bolder;" disabled="disabled" size="2" >	 </td>
	</tr>
	
	
		<tr>
		<td align="center">
			<select	id="lbChoosePlayersFrom" multiple="multiple" size="10" STYLE="width: 350px; height: 240px; overflow: scroll" >
<%
					while(teamPlayersCachedRowSet.next()){				
%>
					<option value="<%=teamPlayersCachedRowSet.getString("player_id")%>">
								 	<%=teamPlayersCachedRowSet.getString("playername")%></option>
<%
					}
%>
			</select>
		</td>
		<td align="center">
			<input type="button" class="btn btn-small" name="add" id="add" value=">>" size="5"
				onClick="addToCombo('lbChoosePlayersFrom','lbChoosePlayersFrom','lbSelectedPlayers');">
				<br>		
		 	<input type="button" class="btn btn-small" name="del" id="del" value="<<" size="5"
		 		onClick="fillCombo('lbSelectedPlayers','lbSelectedPlayers','lbChoosePlayersFrom');beforeRemoveOptions('lbSelectedPlayers');"> 	
		</td>		
		<td align="center"> 
			<select	id="lbSelectedPlayers" multiple="multiple" size="10" STYLE="width: 350px; height: 240px; overflow: scroll" >
				
			</select>
		</td>		
		</tr>
		<tr>
		<td colspan="3"><hr></td>
	</tr>	
	</table>
	
	<table width="100%" border="0">
		<tr>
			<td align="right"><b><font size="3">
				Captain:
			</font></b></td>
			<td width="15%">
				<select name="cmbCaptain" id="cmbCaptain">
				<!--<option value="0">- Select -</option>-->	
				</select>				
			</td>
			<td align="right"><b><font size="3">Wicket Keeper:</font></b></td>
			<td width="13%">
				<select name="cmbWicketKeeper" id="cmbWicketKeeper">
				<!--<option value="0">- Select -</option>-->
				</select>			
				
			</td>			
		</tr>
		<tr>
			<td align="right"><b><font size="3">
				12th Man:
			</font></b></td>
			<td width="13%">
				<select name="cmb12thMan" id="cmb12thMan">
				<!--<option value="0">- Select -</option>-->
				</select>			
				
			</td>	
		</tr>
<tr>
			<td align="right">&nbsp;</td>
			<td width="13%">&nbsp;</td>	
		</tr>
		</table>
		<table width="100%">	
		<tr>
			<td class="legend" colspan="3" align="center">Select Extra Players from Team : <%=team2name%></td>
		</tr>
		<tr>
			<td colspan="3"><hr></td>
		</tr>						
			<tr>
			<td align="center">
				<select	id="lbChoosePlayersFromExtra" multiple="multiple" size="10" STYLE="width: 350px; height: 85px; overflow: scroll"  >
						
				</select>	
			</td>
			<td align="center">
				<input type="button" class="btn btn-small" name="add" id="add" value=">>" size="5"
					onClick="addToComboextra('lbChoosePlayersFromExtra','lbChoosePlayersFromExtra','lbSelectedPlayersExtra');" >
					<br>		
			 	<input type="button" class="btn btn-small" name="del" id="del" value="<<" size="5"
			 		onClick="fillCombo('lbSelectedPlayersExtra','lbSelectedPlayersExtra','lbChoosePlayersFromExtra');beforeRemoveOptionsextra('lbSelectedPlayersExtra');"> 	
			</td>		
			<td align="center">
				<select	id="lbSelectedPlayersExtra" multiple="multiple" size="10"  STYLE="width: 350px; height: 85px; overflow: scroll">
					
				</select>
			</td>		
		</tr>
		<tr>
			<td colspan="3"><hr></td>
		</tr>
		<tr align="center">	
			<td align="center" colspan="3">
				<input class="btn btn-warning" type="button" name="btnNext" id="btnNext" value="NEXT" onclick="callMain();" disabled="disabled">									
			</td>	
			<td align="center" >&nbsp;
				<input type="hidden" name="hdflag" id="hdflag" value="">
				<input type="hidden" name="hdteam2" id="hdteam2" value="<%=team2%>">
				<input type="hidden" name="hdteamPlayers" id="hdteamPlayers" value="">
				<input type="hidden" name="hdCaptain" id="hdCaptain" value="">
				<input type="hidden" name="hd12thMan" id="hd12thMan" value="">					
				<input type="hidden" name="hdWicketKeeper" id="hdWicketKeeper" value="">
				<input type="hidden" name="hdteamPlayersextra" id="hdteamPlayersextra" value="">
				<input type="hidden" name="hdscoring_type" id="hdscoring_type" value="<%=scoring_type%>">				
			</td>
												
		</tr>
		</table>
<%
		}catch(Exception e){
		e.printStackTrace();
	}
%>
  	</form>
  </body>
</html>
