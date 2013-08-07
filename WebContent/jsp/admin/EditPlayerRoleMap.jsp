<!--
	Author 		 : Dipti Shinde
	Created Date : 18-12-2008
	Description  : Edit.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%
		
	try{
			
                        String User_Name = (String)session.getAttribute("username");
			CachedRowSet crsObjPlayerList = null;
                        CachedRowSet crsObjTeamPlayerList = null;
			CachedRowSet crsObjMatches = null;
                        String playerName = null;
                        
                        GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
			Vector vparam = new Vector();

			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy/MM/dd");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
					"dd/MM/yyyy");

			String match_id = "0";
                        String team_id = "0";
                        String teamPlayerId="";
                        String teamPlayerName ="";
            //String oldCaptain = null;
			//String oldWicketKeeper = null;
			Common common = new Common();
			String date_one = sdf2.format(new Date());
			String date_two = sdf2.format(new Date());

                        if (request.getParameter("hid") != null) {
				if (request.getParameter("hid").equalsIgnoreCase("0") || request.getParameter("hid").equalsIgnoreCase("1") ) {
					date_one = request.getParameter("txtDateFrom").toString();
					date_two = request.getParameter("txtDateTo").toString();
					vparam.add(common.formatDate(date_one));
					vparam.add(common.formatDate(date_two));
					crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getmatches", vparam, "ScoreDB");
					vparam.removeAllElements();							
                                        if( request.getParameter("hid").equalsIgnoreCase("1") ) {
                                            match_id = request.getParameter("matchid")==null?"0":request.getParameter("matchid");
                                            team_id =  request.getParameter("team")==null?"0":request.getParameter("team");
                                            vparam.add(team_id);    
                                            vparam.add(match_id);
                                            crsObjPlayerList = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_match_team_player", vparam, "ScoreDB");
                                             vparam.removeAllElements();
                                            
                                             vparam.add(team_id);
                                             crsObjTeamPlayerList = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_team_player", vparam, "ScoreDB");
                                             vparam.removeAllElements();
                                             if(crsObjTeamPlayerList!=null){
                                                 while(crsObjTeamPlayerList.next()){
                                                   teamPlayerId = teamPlayerId + crsObjTeamPlayerList.getString("team_player_id") + "~";
                                                   teamPlayerName = teamPlayerName +  crsObjTeamPlayerList.getString("playername") + "~";
                                                 }
                                                
                                             }
                                             
                                         }   
                                  }    
                                
                            }        
%>
<html>
<head>
<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
<title>Edit Player Map</title>
<script>
	function GetXmlHttpObject() {
        var xmlHttp = null;
        try{
            // Firefox, Opera 8.0+, Safari
            xmlHttp = new XMLHttpRequest();
        }
        catch (e){
            // Internet Explorer
            try{
                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e){
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        return xmlHttp;
    }
    
    
     function getTeamNames(){
        try {
         	  xmlHttp = this.GetXmlHttpObject();
         	  if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	          }else{
	         	  var matchid = document.getElementById("matchid").value
	              var url = "/cims/jsp/admin/EditTeams.jsp?matchid="+matchid+"&flag=1";
	              xmlHttp.onreadystatechange = receiveTeamNames
	          	  xmlHttp.open("post", url, false);
			   	  xmlHttp.send(null);   
	   		  }
	   	} catch(err) {
           	alert(err.description + 'getTeamNames()');
        }
    }
    
    function receiveTeamNames(){
    	if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
       		try {
            	var responseResult = xmlHttp.responseText ;
            	document.getElementById('twoTeamsDiv').innerHTML = responseResult
            	//document.getElementById('selectedOverBallsDiv').scrollIntoView(true);	
       		} catch(err) {
	            alert(err.description + 'receiveTeamNames()');
       		}
        }
    }
    
    function savePlayer(match_team_player_id,team_player_id,team_id,playerIds,PlayerNames){
 
	   var playerIdsArr = playerIds.split("~")
	   var PlayerNamesArr = PlayerNames.split("~")
	   var selectPlayerId = document.getElementById("cmbteamplayer"+match_team_player_id).value
	   var selectPlayerName 
	   
	   for(i=0;i<playerIdsArr.length;i++){
	   	if(selectPlayerId == playerIdsArr[i]){
	   	selectPlayerName = PlayerNamesArr[i]
	   	}
	   }
	   	
	   var curPlayerName = document.getElementById("curPlayerName"+match_team_player_id).innerHTML
	   if(curPlayerName.indexOf("<") != -1){
	   	var ind = curPlayerName.indexOf("<")
	   	curPlayerName = curPlayerName.substring(0,ind)
	   }

		var saveconfirm = confirm("Do you want to replace batsman "+curPlayerName+" by "+ selectPlayerName)
		if((!saveconfirm)){
			return false 
		}else{
			try {
			        xmlHttp = this.GetXmlHttpObject();
			        if (xmlHttp == null) {
				   alert("Browser does not support HTTP Request");
				   return;
				}else{
		            var matchid = document.getElementById("matchid").value
		           	var new_team_player_id = document.getElementById("cmbteamplayer"+match_team_player_id).value;  
			  		var url = "/cims/jsp/admin/EditTeams.jsp?matchid="+matchid+"&match_team_player_id="+match_team_player_id+
		                     "&team_player_id="+team_player_id+"&team_id="+team_id+"&new_team_player_id="+new_team_player_id+"&flag=2";
			   		xmlHttp.onreadystatechange = receivePlayer
		            xmlHttp.open("post", url, false);
			    	xmlHttp.send(null);   
				}
		     } catch(err) {
		        alert(err.description + 'getTeamNames()');
		     }
		 }  
		 
   }
   function AddPlayer(matchId){
       try {
            xmlHttp = this.GetXmlHttpObject();
            if (xmlHttp == null) {
               alert("Browser does not support HTTP Request");
               return;
            }else{
               
                var new_team_player_id = document.getElementById("cmbteamplayeradd").value;  
                var url = "/cims/jsp/admin/EditTeams.jsp?matchid="+matchId+"&match_team_player_id=0&team_player_id=0&team_id=0&new_team_player_id="+new_team_player_id+"&flag=3";
                xmlHttp.onreadystatechange = receivePlayer
                xmlHttp.open("post", url, false);
                xmlHttp.send(null);   
            }
	} catch(err) {
	    alert(err.description + 'AddPlayer()');
	}
   }    
   function receivePlayer(){
       if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
           try {
                var responseResult = xmlHttp.responseText ;
                alert(responseResult);
                getPlayerList();
           }catch(err) {
                alert(err.description + 'receiveTeamNames()');
            }
        }
    } 
    function getMatches(){
		document.getElementById("hid").value = "0";
        document.frmEditPlayerRole.action = "/cims/jsp/admin/EditPlayerRoleMap.jsp"
		document.frmEditPlayerRole.submit();	
    }
    function getPlayerList(){
	    document.getElementById("hid").value = "1";
		document.frmEditPlayerRole.action = "/cims/jsp/admin/EditPlayerRoleMap.jsp";
		document.frmEditPlayerRole.submit();	
    }    
    
    /*function selectCaptain(id,matchid,teamid){
       /// var oldCap = document.getElementById("hdOldCap").value
       //  var oldWkerp = document.getElementById("hdOldWkepr").value
       // alert(oldCap+"--"+id)
       //   alert(oldWkerp)
       //alert(id)
    	try {
            xmlHttp = this.GetXmlHttpObject();
            if (xmlHttp == null) {
               alert("Browser does not support HTTP Request");
               return;
            }else{
                var url = "UpdateRole.jsp?playerid="+id+"&matchid="+matchid+"&teamid="+teamid+"&isCaptain=Y";
                xmlHttp.onreadystatechange = receiveCaptain
                xmlHttp.open("post", url, false);
                xmlHttp.send(null);   
            }
		} catch(err) {
		    alert(err.description + 'selectCaptain()');
		}
    }*/
    
    
    
    function setPlayerRole(playerId,teamPlayerId,teamId,matchId){
 		    	//alert("playerId "+playerId)
    	    	//alert("teamPlayerId "+teamPlayerId)
    	    	//alert("teamId "+ teamId)
    	    	//alert("teamId "+matchId)
    	    	var isBatsman = null
    	    	var isBowler = null
    	    	var isCaptain = null
    	    	var isWkepr = null
    	    	var isLarmBowler = null
    	    	var isLarmBatsman = null
    	    	var isSpinner = null
    	    	var isMpacer = null
    	    	var isPacer = null
    	    	
    	    	if(document.getElementById("chkBatsman"+playerId).checked){
    	    		isBatsman = "Y"
   	    		}else{
   	    			isBatsman = "N"
   	    		}
   	    		
   	    		if(document.getElementById("chkBowler"+playerId).checked){
    	    		isBowler = "Y"
   	    		}else{
   	    			isBowler = "N"
   	    		}
   	    		
   	    		if(document.getElementById("rdCap"+playerId).checked){
    	    		isCaptain = "Y"
   	    		}else{
   	    			isCaptain = "N"
   	    		}
   	    		
   	    		if(document.getElementById("rdWkpr"+playerId).checked){
    	    		isWkepr = "Y"
   	    		}else{
   	    			isWkepr = "N"
   	    		}
   	    		
   	    		if(document.getElementById("chkLarmBowler"+playerId).checked){
    	    		isLarmBowler = "Y"
   	    		}else{
   	    			isLarmBowler = "N"
   	    		}
   	    		
   	    		if(document.getElementById("chkLarmBatsman"+playerId).checked){
    	    		isLarmBatsman = "Y"
   	    		}else{
   	    			isLarmBatsman = "N"
   	    		}
   	    		
   	    		if(document.getElementById("chkSpinner"+playerId).checked){
    	    		isSpinner = "Y"
   	    		}else{
   	    			isSpinner = "N"
   	    		}
   	    		
   	    		if(document.getElementById("chkMpacer"+playerId).checked){
    	    		isMpacer = "Y"
   	    		}else{
   	    			isMpacer = "N"
   	    		}
   	    		
   	    		if(document.getElementById("chkPacer"+playerId).checked){
    	    		isPacer = "Y"
   	    		}else{
   	    			isPacer = "N"
   	    		}
   	    		 alert("7 - "+document.getElementById("chkSpinner"+playerId).checked)
    	   alert("8 - "+document.getElementById("chkMpacer"+playerId).checked)
    	    alert("9 - "+document.getElementById("chkPacer"+playerId).checked)
   	    		
   	    try {
   	    
   	        xmlHttp = this.GetXmlHttpObject();
            if (xmlHttp == null) {
               alert("Browser does not support HTTP Request");
               return;
            }else{
            //playerId,teamPlayerId,teamId,matchId)
                var url = "/cims/jsp/admin/UpdateRole.jsp?playerId="+playerId+"&teamPlayerId="+teamPlayerId
                									+"&teamId="+teamId+"&matchId="+matchId
                									+"&isBatsman="+isBatsman+"&isBowler="+isBowler
                									+"&isCaptain="+isCaptain+"&isWkepr="+isWkepr
                									+"&isLarmBowler="+isLarmBowler+"&isLarmBatsman="+isLarmBatsman
                									+"&isSpinner="+isSpinner+"&isMpacer="+isMpacer
                									+"&isPacer="+isPacer
                xmlHttp.onreadystatechange = receivePlayerRole
                xmlHttp.open("post", url, false);
                xmlHttp.send(null);   
            }
		} catch(err) {
		    alert(err.description + 'setPlayerRole()');
		}
   	    		
   	    		
   	    		
   	    		
   	    	/*	alert("isBatsman -- "+isBatsman)
   	    		alert("isBowler -- "+isBowler)
   	    		alert("isCaptain -- "+isCaptain)
   	    		alert("isWkepr -- "+isWkepr)
   	    		alert("isLarmBowler -- "+isLarmBowler)
   	    		alert("isLarmBatsman -- "+isLarmBatsman)
   	    		alert("isSpinner -- "+isSpinner)
   	    		alert("isMpacer -- "+isMpacer)
   	    		alert("isPacer -- "+isPacer)*/
    	   // alert("1  -"+document.getElementById("chkBatsman"+playerId).checked)
    	   // alert("2 - "+document.getElementById("chkBowler"+playerId).checked)
    	   // alert("3 - "+document.getElementById("rdCap"+playerId).checked)
    	   // alert("4 - "+document.getElementById("rdWkpr"+playerId).checked)
    	   /// alert("5 - "+document.getElementById("chkLarmBowler"+playerId).checked)
    	  //  alert("6 - "+document.getElementById("chkLarmBatsman"+playerId).checked)
    	  // alert("7 - "+document.getElementById("chkSpinner"+playerId).checked)
    	  // alert("8 - "+document.getElementById("chkMpacer"+playerId).checked)
    	  //  alert("9 - "+document.getElementById("chkPacer"+playerId).checked)
    }
    
    function receivePlayerRole(){
    	if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
           try {
                var responseResult = xmlHttp.responseText ;
           }catch(err) {
                alert(err.description + 'receivePlayerRole()');
           }
        }
    }
	
</script>
</head>

<body>

<jsp:include page="Menu.jsp"></jsp:include>
<FORM action="" name="frmEditPlayerRole" id="frmEditPlayerRole" method="post">
<br>
<br>
<br>
<table width="780" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
	<tr align="center">
		 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">
	                Edit Player Map
	    <INPUT type="hidden" id="hid" name="hid" value="0"/> </td>
	</tr>
	
	<tr>
		<td colspan="3">
		<fieldset><legend class="legend1">Select Dates
			</legend> <br><br>
			<table width="90%" border="0" align="center" cellpadding="2"
				cellspacing="1" class="table" >
				<tr class="contentDark">	
				
					
				    <TD colspan="3" width="30%" nowrap align="left" valign="top" >
				        From Date :<input maxlength="10" size="10" type="text" class="FlatTextBox150"
				        name="txtDateFrom" id="txtDateFrom" readonly value="<%=date_one%>"
				        onclick="showCal('FrCalendarFrom','DateFrom','txtDateFrom','frmEditPlayerRole')">
				            <a href="javascript:showCal('FrCalendarFrom','DateFrom','txtDateFrom','frmEditPlayerRole')">
				            <IMG src="../../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
				    </TD>
				    <TD  width="30%" nowrap align="left">	
				        To Date :<input type="text" maxlength="10" size="10" class="FlatTextBox150"
				        name="txtDateTo" id="txtDateTo" readonly value="<%=date_two%>"
				        onclick="showCal('FrCalendarTo','DateTo','txtDateTo','frmEditPlayerRole')">
				        <a href="javascript:showCal('FrCalendarTo','DateTo','txtDateTo','frmEditPlayerRole')">
				        <IMG src="../../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
				    </TD>
				    <TD width="30%" align="left" colspan="2"><input type="button" class="button1" name="btnmatch" id="btnmatch" value="Get Matches" onclick="getMatches()"> 
				    </TD>
				    
				   <TD colspan="2" align="center" > 
					     <SELECT onchange="getTeamNames()" name="matchid" id="matchid">
					        <OPTION value="0">-Select Match -</OPTION>
					<%   if (crsObjMatches != null) {
					     while (crsObjMatches.next()) {
					%>    
						<OPTION value='<%=crsObjMatches.getString("matches_id")%>' <%=match_id.equalsIgnoreCase(crsObjMatches.getString("matches_id"))?"selected":"" %> ><%=crsObjMatches.getString("matches_id")%>.
						<%=crsObjMatches.getString("team_one")%> Vs. <%=crsObjMatches.getString("team_two")%></OPTION>
					<%  
					     }// end of while
					     }// end of main if
					%>
					     </SELECT>
		    		</TD>
		    
		   
		    	</tr>
		    </table>
		    <br>
		   </fieldset> 
		   </td>
	 </TR>
  <tr><td>&nbsp;</td></tr>
 <TR class="contentDark">    
    
    <td align="right">Teams:</td>   
    <td> 
        <div id="twoTeamsDiv" name="twoTeamsDiv">
	<select id="team" name="team">
            <option value="0">--select--</option>
	</select>	
	</div>	
    </td>
     <TD align="left"> <INPUT TYPE="button"  class="button1" value="Get Team List"
        onclick="getPlayerList()"> 
    </TD>
</TR>
</TABLE>
<br><br>
<table align="center" width="90%" border="1">
	
     
<%  if(crsObjPlayerList!=null){
%>
<tr align="center" class="contentDark">
		<td>Display Name</td>
		<td>Player Name</td>
		<td>Bats<br>man</td>
		<td>Bow<br>ler</td>
		<td>Capt<br>ain</td>
		<td>Wkt<br>Keeper</td>
		<td>Left<br>Arm<br>Bow<br>ler</td>
		<td>Left<br>Arm<br>Bats<br>man</td>
		<td>Spi<br>nner</td>
		<td>Mpa<br>cer</td>
		<td>Pac<br>er</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
<% 
	while(crsObjPlayerList.next()){
%>  
	
			  
    <tr>
   		 <td>
			<%=crsObjPlayerList.getString("displayname")%>
		</td>
        <td nowrap id="curPlayerName<%=crsObjPlayerList.getString("id")%>" name="curPlayerName<%=crsObjPlayerList.getString("id")%>">
<%     playerName = crsObjPlayerList.getString("playername");
		if(crsObjPlayerList.getString("player_status").equalsIgnoreCase("T")){
            playerName = playerName+" "+"<span class='colheadinguser'>12th Player</span>";
        }else if(crsObjPlayerList.getString("player_status").equalsIgnoreCase("R")){
            playerName = playerName+" "+"<span class='colheadinguser'>Extra Player</span>";
        }else{
            playerName = playerName;
        }

%>
            <%=playerName%>&nbsp;
        </td>
         <td>
<%		if(crsObjPlayerList.getString("is_batsman").equalsIgnoreCase("Y")){
%> 			<input type="checkbox"  id="chkBatsman<%=crsObjPlayerList.getString("id")%>" name="chkBatsman" value="Y" checked="checked"/>
<%		}else{
%>			<input type="checkbox"  id="chkBatsman<%=crsObjPlayerList.getString("id")%>" name="chkBatsman" value="N" />
<%		}
%>
        </td>
        <td>
<%		if(crsObjPlayerList.getString("is_bowler").equalsIgnoreCase("Y")){
%>        
			<input type="checkbox"  id="chkBowler<%=crsObjPlayerList.getString("id")%>" name="chkBowler" value="Y" checked="checked"/>
<%		}else{
%>			<input type="checkbox"  id="chkBowler<%=crsObjPlayerList.getString("id")%>" name="chkBowler" value="N" />
<%		}
%>
        </td>
        <td>
<%			if(crsObjPlayerList.getString("is_captain").equalsIgnoreCase("Y")){
%>
				<input type="radio"  id="rdCap<%=crsObjPlayerList.getString("id")%>" name="rdCap" value="Y" checked="checked"/>
 
<%			}else{
%>
<%--				<input type="radio"  id="rdCap" name="rdCap" onclick="selectCaptain('<%=crsObjPlayerList.getString("id")%>','<%=match_id%>','<%=team_id%>')" />--%>
					<input type="radio"  id="rdCap<%=crsObjPlayerList.getString("id")%>" name="rdCap" value="N" />
<%			}
%>
        </td>
        <td>
<%			if(crsObjPlayerList.getString("is_wkeeper").equalsIgnoreCase("Y")){
%>
				<input type="radio"  id="rdWkpr<%=crsObjPlayerList.getString("id")%>" name="rdWkpr" value="Y" checked="checked"/>

<%			}else{
%>
				<input type="radio"  id="rdWkpr<%=crsObjPlayerList.getString("id")%>" name="rdWkpr" value="N"/>
<%			}
%>
        </td>
        <td>
<%		if(crsObjPlayerList.getString("is_larm_bowler").equalsIgnoreCase("Y")){
%>        
			<input type="checkbox"  id="chkLarmBowler<%=crsObjPlayerList.getString("id")%>" name="chkLarmBowler" value="Y" checked="checked"/>
<%		}else{
%>			<input type="checkbox"  id="chkLarmBowler<%=crsObjPlayerList.getString("id")%>" name="chkLarmBowler" value="N" />
<%		}
%>
        </td>
        <td>
<%		if(crsObjPlayerList.getString("is_larm_batman").equalsIgnoreCase("Y")){
%>        
			<input type="checkbox"  id="chkLarmBatsman<%=crsObjPlayerList.getString("id")%>" name="chkLarmBatsman" value="Y" checked="checked"/>
<%		}else{
%>			<input type="checkbox"  id="chkLarmBatsman<%=crsObjPlayerList.getString("id")%>" name="chkLarmBatsman" value="N" />
<%		}
%>
        </td>
        <td>
<%		if(crsObjPlayerList.getString("is_spinner").equalsIgnoreCase("Y")){
%>        
			<input type="checkbox"  id="chkSpinner<%=crsObjPlayerList.getString("id")%>" name="chkSpinner" value="Y" checked="checked"/>
<%		}else{
%>			<input type="checkbox"  id="chkSpinner<%=crsObjPlayerList.getString("id")%>" name="chkSpinner" value="N" />
<%		}
%>
        </td>
        <td>
<%		if(crsObjPlayerList.getString("is_mpacer").equalsIgnoreCase("Y")){
%>        
			<input type="checkbox"  id="chkMpacer<%=crsObjPlayerList.getString("id")%>" name="chkMpacer" value="Y" checked="checked"/>
<%		}else{
%>			<input type="checkbox"  id="chkMpacer<%=crsObjPlayerList.getString("id")%>" name="chkMpacer" value="N" />
<%		}
%>
        </td>
        <td>
<%		if(crsObjPlayerList.getString("is_pacer").equalsIgnoreCase("Y")){
%>        
			<input type="checkbox"  id="chkPacer<%=crsObjPlayerList.getString("id")%>" name="chkPacer" value="Y" checked="checked"/>
<%		}else{
%>			<input type="checkbox"  id="chkPacer<%=crsObjPlayerList.getString("id")%>" name="chkPacer" value="N" />
<%		}
%>
        </td>
        <td><input type="button" class="button1" name="btnSet" id="btnSet" value="Set" 
            onclick="setPlayerRole('<%=crsObjPlayerList.getString("id")%>','<%=crsObjPlayerList.getString("team_player_id")%>','<%=crsObjPlayerList.getString("team_id")%>','<%=match_id%>')"></td>
            
        <td><select name="cmbteamplayer<%=crsObjPlayerList.getString("id")%>" id="cmbteamplayer<%=crsObjPlayerList.getString("id")%>">
<%   if(!teamPlayerId.equalsIgnoreCase("")){
     String teamPlayerIdArr[] = teamPlayerId.split("~");
     String teamPlayerNameArr[] = teamPlayerName.split("~");
        for(int i=0;i<teamPlayerIdArr.length;i++){           
%>           <option value="<%= teamPlayerIdArr[i]%>"><%=teamPlayerNameArr[i]%> </option>   
<%      }// end of for
%>
            </select>
        </td>
        <td><input type="button" class="button1" name="btnsave" id="btnsave" value="save" 
            onclick="savePlayer('<%=crsObjPlayerList.getString("id")%>','<%=crsObjPlayerList.getString("team_player_id")%>','<%=crsObjPlayerList.getString("team_id")%>','<%=teamPlayerId%>','<%=teamPlayerName%>')"></td>
            
    </tr>   
<%  }// end of while
    }// end of if
    }
%>    
</table> 
<% if((request.getParameter("hid")!= null) && request.getParameter("hid").equalsIgnoreCase("1")){
%>
<table align="center" width="90%">
    <tr>
        <td>
         <select name="cmbteamplayeradd" id="cmbteamplayeradd">
<%       if(!teamPlayerId.equalsIgnoreCase("")){
            String teamPlayerIdArr[] = teamPlayerId.split("~");
            String teamPlayerNameArr[] = teamPlayerName.split("~");
            for(int i=0;i<teamPlayerIdArr.length;i++){           
%>           <option value="<%= teamPlayerIdArr[i]%>"><%=teamPlayerNameArr[i]%> </option>   
<%          }// end of for
         }   
%>       </select>
        &nbsp;&nbsp;<input type="button" class="button1" name="btnadd" id="btnadd" value="Add" 
            onclick="AddPlayer('<%=match_id%>')"></td>
    </tr>
</table>    

<%  }
%>
<%if( request.getParameter("hid").equalsIgnoreCase("1") ) {
%>
<script>
    getTeamNames();
</script>
<%}
%>
<table>
    <tr><td>
<%--    	<input type="hidden" id="hdOldCap" name="hdOldCap" value="<%=oldCaptain%>">--%>
<%--        <input type="hidden" id="hdOldWkepr" name="hdOldWkepr" value="<%=oldWicketKeeper%>">--%>
        <INPUT type="hidden" id="hdteamId" name="hdteamId"  value="<%=team_id%>"/></td>
    </tr>
</table>

</FORM>
<br><br><br><br><br><br><br>

</body>

</html>	
<%	}catch (Exception e) {
	  e.printStackTrace();
	}
%>
<br><br><br><br>
<jsp:include page="Footer.jsp"></jsp:include>