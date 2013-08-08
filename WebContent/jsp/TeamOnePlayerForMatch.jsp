<!--
Page Name 	 : playerSelectionTeamOne.jsp
Created By 	 : Avadhut Joshi
Created Date : 27th Aug 2008
Description  : Selection of players
Company 	 : Paramatrix Tech Pvt Ltd.
Updated on: 05.57 pm 11/09/2008
Updated on: 03.25 pm 13/09/2008 by Avadhut
Updated on: 03.25 pm 14/10/2008 by Avadhut
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"%>
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
try{									
	String matchId = (String)session.getAttribute("matchId1"); 
	CachedRowSet  teamPlayersCachedRowSet 	= null;						
	CachedRowSet  matchIdCachedRowSet		= null;
	CachedRowSet  crsInningId				= null;						
	CachedRowSet  crsTeamName				= null;	
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);				
	Vector 	vparam =  new Vector();
					//DECLARATIon
	String matchCat		= request.getParameter("category");
	String team1 		= request.getParameter("hdteam1");
	String team2 		= request.getParameter("hdteam2");
	String venue 		= request.getParameter("location");
	String location		= request.getParameter("homeSide");
	String matchtype	= request.getParameter("matchtype");				
	String param		= request.getParameter("flag");
	String series		= request.getParameter("series");						
	int		flag		= 2;	 
	String match_id 	= null;	
	String inningId 	=null;
	String team1name 	= null;
				//Archana To insert the record in database.
					
					//String matchId = request.getParameter("hdmatch");//(String)session.getAttribute("matchId");//From Session.	
	vparam.add(team1);
	crsTeamName = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamname",vparam,"ScoreDB");																					
	vparam.removeAllElements();	
	while(crsTeamName.next()){				
		team1name = crsTeamName.getString("team_name");
	}
	
	vparam.add(matchId);					
	crsInningId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getInningId",vparam,"ScoreDB");																					
	vparam.removeAllElements();	
	while(crsInningId.next()){				
		inningId = crsInningId.getString("id");
	 	crsInningId.getString("bowling_team");
	 	crsInningId.getString("batting_team");
	}
					//System.out.println("Inning Id is :::::::"+inningId);
	session.setAttribute("InningId",inningId);
		 			//CALLING SP				
	if(flag==2){	
		vparam.add(team1);	
		teamPlayersCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamplayers",vparam,"ScoreDB");																					
		vparam.removeAllElements();	
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
function cancelSelection(){		 	
 	document.frmPlayersSelection.action = "/cims/jsp/PlayerSelectionTeamOne.jsp";
	document.frmPlayersSelection.submit();	 
} 	 
function GetXmlHttpObject(){
	var xmlHttp=null;
    try{
        xmlHttp=new XMLHttpRequest();
    }
    catch (e){
    	try{
           xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e){
        	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
   }
  return xmlHttp;
}
function nextTeamInning(){
	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
		document.getElementById("btnNext").disabled = false;
    	var responseResult = xmlHttp.responseText ;
    	document.frmPlayersSelection.action	="/cims/jsp/PlayerSelectionTeamTwo.jsp";		 				  		
		document.frmPlayersSelection.submit();	          
    }
}


function callMain(){
	var strExtraPlayers	= "";
	var MAXPLAYERSExtra = 0;	
	var selctPlayerExtraObjArr =""; 
	var flagExtra = true;
	selctPlayerExtraObjArr=document.getElementById('lbSelectedPlayersExtra').options
 	for(var i=0;i< selctPlayerExtraObjArr.length;i++){	
		strExtraPlayers = strExtraPlayers + selctPlayerExtraObjArr[i].value + "~";
		if((selctPlayerExtraObjArr[i].value == document.getElementById('cmbCaptain').value)||
			(selctPlayerExtraObjArr[i].value == document.getElementById('cmbWicketKeeper').value)||
			(document.getElementById('cmb12thMan').value == selctPlayerExtraObjArr[i].value)){
					alert("Extra Player cannot be 12th Man or Captain or Wicket Keeper");
					flagExtra = false;
		}
	}			
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
	
	if(flagExtra == true){			
		if((document.getElementById('cmb12thMan').value == document.getElementById('cmbCaptain').value)||
			(document.getElementById('cmb12thMan').value == document.getElementById('cmbWicketKeeper').value)){
				alert("12th Man cannot be Captain or Wicket Keeper");			
		}else if((selLength<12)){//||(selLength<MAXPLAYERS)){
				alert("Please select minimum 12 players!");
		}else if(selLengthextra<MAXPLAYERSExtra){//MAXPLAYERSExtra){
				alert("Please select maximum "+MAXPLAYERSExtra+" extra players!");
		}else{
			document.getElementById("btnNext").disabled = true;
			var strConfirm = confirm("Are you Sure!You want to select these"+selLength+" players");
			if(strConfirm == true){
				
			 	var strCaptain		= document.getElementById('cmbCaptain').value; // Combo Value	 	
		 		var strWicketkeeper	= document.getElementById('cmbWicketKeeper').value; // Combo Value			 		 	
			 	var str12thMan	= document.getElementById('cmb12thMan').value; // Combo Value	
			 	document.getElementById('hdteam2').value; // Combo Value
				 	var strTeam2Players	= "";
		 		var selctPlayerObjArr=document.getElementById('lbSelectedPlayers').options
			 	for(var i=0;i< selctPlayerObjArr.length;i++){
					 strTeam2Players = strTeam2Players + selctPlayerObjArr[i].value + "~";
		 		}
				var flag			= "1";
				var hdflag			= "2"
				xmlHttp=GetXmlHttpObject();
				if (xmlHttp==null){
			       alert ("Browser does not support HTTP Request") ;
			       return;
			    }
			    else{
			    	document.getElementById('hdteamPlayers').value 		=	strTeam2Players;
					document.getElementById('hdCaptain').value 	   		=	strCaptain;
					document.getElementById('hdWicketKeeper').value 	=	strWicketkeeper;		
					document.getElementById('hd12thMan').value			=	str12thMan;	
					document.getElementById('hdteamPlayersextra').value	=   strExtraPlayers;			
					var hdteam1 = document.getElementById('hdteam1').value;
					var hdteam2 = document.getElementById('hdteam2').value;
			        var url = "/cims/jsp/ajaxPlayerSelectionTeamTwo.jsp?hdteamPlayers="+strTeam2Players+"&hdCaptain="+strCaptain+"&hdWicketKeeper="+strWicketkeeper+"&hd12thMan="+
			        str12thMan+"&hdteamPlayersextra="+strExtraPlayers+"&hdteam1="+hdteam1+"&hdteam2"+hdteam2;
			        //xmlHttp.onreadystatechange = nextTeamInning;
			        xmlHttp.open("get",url,false);
			        xmlHttp.send(null);
			        if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	                	try {
	                	  if( xmlHttp.status == 200 && xmlHttp.statusText == "OK" ){
	                		  document.getElementById("btnNext").disabled = false;
	                	      var responseResult = xmlHttp.responseText ;
	                	      document.frmPlayersSelection.action	="/cims/jsp/PlayerSelectionTeamTwo.jsp";		 				  		
	                		  document.frmPlayersSelection.submit();	   
	                	  }
	                	} catch(err) {
	                          alert(err.description + 'PlayerSelectionTeam()');
	                      }	  
			       }		
						
			 }else{
				 document.getElementById("btnNext").disabled = false;
				//document.frmPlayersSelection.action				=   "PlayerSelectionTeamOne.jsp";		 				  		
				//document.frmPlayersSelection.submit();	
			 }// end of else 	
		}// end of main else
	}// end of extra id
	
}// end of function

</script>
</head>
<body>
	<form id="frmPlayersSelection" name="frmPlayersSelection" method="post" style="height: 100% ">
	<table width="100%" >
	<tr>	
		<td>			 
			<jsp:include page="Banner.jsp"></jsp:include>
		</td>	
	</tr>
	</table>
	<table  width="100%" height="35%" >
	<tr>
		<td colspan="3" align="center" style="background-color:gainsboro;"><font size="4" color="#003399"><b>Select Players for Team <%=team1name%></b></font></td>
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
			<select	id="lbChoosePlayersFrom" multiple="multiple" size="10" STYLE="width: 350px; height: 240px; overflow: scroll"  >
<%			 while(teamPlayersCachedRowSet.next()){				
%>				<option value="<%=teamPlayersCachedRowSet.getString("player_id")%>">
			 	<%=teamPlayersCachedRowSet.getString("playername")%></option>
<%			}
%>			</select>	
		</td>
		<td align="center">
			<input type="button" name="add" id="add" value=">>" size="5"
			onClick="addToCombo('lbChoosePlayersFrom','lbChoosePlayersFrom','lbSelectedPlayers')">
			<br>		
		 	<input type="button" name="del" id="del" value="<<" size="5"
			onClick="fillCombo('lbSelectedPlayers','lbSelectedPlayers','lbChoosePlayersFrom');beforeRemoveOptions('lbSelectedPlayers');"> 	
		</td>		
		<td align="center">
			<select	id="lbSelectedPlayers" multiple="multiple" size="10"  STYLE="width: 350px; height: 240px; overflow: scroll">
			</select>
		</td>		
	</tr>
	<tr>
		<td colspan="3"><hr></td>
	</tr>
	</table>
		
	<table width="100%" border="0">
	<tr>
		<td align="right"><b><font size="3">Captain:</font></b>
		</td>
		<td width="15%">
			<select name="cmbCaptain" id="cmbCaptain">
			</select>				
		</td>
		<td align="right"><b><font size="3">Wicket Keeper:</font></b>
		</td>
		<td width="13%">
			<select name="cmbWicketKeeper" id="cmbWicketKeeper">
			</select>
		</td>			
	</tr>
	<tr>
		<td align="right"><b><font size="3">	12th Man:</font></b></td>
		<td width="13%">
			<select name="cmb12thMan" id="cmb12thMan">
			</select>			
		</td>	
	</tr>
	<tr>
		<td colspan="4"><hr></td>
	</tr>
	</table> 
	<table width="100%" border="0">
	<tr>
		<td colspan="3" align="center" style="background-color:gainsboro;"><font size="2" color="#003399"><b>Select Extra Players from Team : <%=team1name%></b></font></td>
	</tr>
	<tr>
		<td align="center">
			<select	id="lbChoosePlayersFromExtra" multiple="multiple" size="10" STYLE="width: 350px; height: 85px; overflow: scroll"  >
			</select>	
		</td>
		<td align="center">
			<input type="button" name="add" id="add" value=">>" size="5"
			onClick="addToComboextra('lbChoosePlayersFromExtra','lbChoosePlayersFromExtra','lbSelectedPlayersExtra');" >
			<br>		
			<input type="button" name="del" id="del" value="<<" size="5"
			onClick="fillCombo('lbSelectedPlayersExtra','lbSelectedPlayersExtra','lbChoosePlayersFromExtra');beforeRemoveOptionsextra('lbSelectedPlayersExtra');"> 	
		</td>		
		<td align="center">
			<select	id="lbSelectedPlayersExtra" multiple="multiple" size="10"  STYLE="width: 350px; height: 85px; overflow: scroll">
			</select>
		</td>		
	</tr>
	<tr>
		<td colspan="4"><hr></td>
	</tr>
	<tr>	
		<td align="center" colspan="3">
			<input type="button" name="btnNext" id="btnNext" value="NEXT" onclick="callMain();" disabled="disabled">								
		</td>																	
		<td align="center" >&nbsp;</td>
			<input type="hidden" name="hdflag" id="hdflag" value="">
			<input type="hidden" name="hdteam1" id="hdteam1" value="<%=team1%>">				
			<input type="hidden" name="hdteam2" id="hdteam2" value="<%=team2%>">
			<input type="hidden" name="hdteamPlayers" id="hdteamPlayers" value="">
			<input type="hidden" name="hdCaptain" id="hdCaptain" value="">
			<input type="hidden" name="hdWicketKeeper" id="hdWicketKeeper" value="">
			<input type="hidden" name="hd12thMan" id="hd12thMan" value="">	
			<input type="hidden" name="hdteamPlayersextra" id="hdteamPlayersextra" value="">			
			<input type="hidden" name="hdmatch" id="hdmatch" value="<%=matchId%>">
	</tr>
	</table>
<%
		}catch(Exception e){
		out.println("Exception:"+e);
		e.printStackTrace();
	}
%>

  	</form>
  </body>
</html>
