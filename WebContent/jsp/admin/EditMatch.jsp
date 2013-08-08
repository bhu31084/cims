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

			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy/MM/dd");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("dd/MM/yyyy");

			String match_id = "0";
            String team_id = "0";
            String teamPlayerId="";
            String teamPlayerName ="";
			Common common = new Common();
			String date_one = sdf2.format(new Date());
			String date_two = sdf2.format(new Date());

           if (request.getParameter("hid") != null) {
				if (request.getParameter("hid").equalsIgnoreCase("0") || request.getParameter("hid").equalsIgnoreCase("1") ) {
					date_one = request.getParameter("txtDateFrom").toString();
					date_two = request.getParameter("txtDateTo").toString();
					vparam.add(common.formatDate(date_one));
					vparam.add(common.formatDate(date_two));
					crsObjMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getmatches", vparam, "ScoreDB");
					vparam.removeAllElements();	
											
                    if( request.getParameter("hid").equalsIgnoreCase("1") ) {
                        match_id = request.getParameter("matchid")==null?"0":request.getParameter("matchid");
                        team_id =  request.getParameter("team")==null?"0":request.getParameter("team");
                        vparam.add(team_id);    
                        vparam.add(match_id);
                        crsObjPlayerList = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_team_player", vparam, "ScoreDB");
                        vparam.removeAllElements();
                        
                         vparam.add(team_id);
                         crsObjTeamPlayerList = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_team_player", vparam, "ScoreDB");
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

<title>Edit Match</title>
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
   function receivePlayer(){
       if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
           try {
                var responseResult = xmlHttp.responseText ;
                getPlayerList();
           }catch(err) {
                alert(err.description + 'receiveTeamNames()');
            }
        }
    } 
    function getMatches(){
		document.getElementById("hid").value = "0";
        document.frmEditMatch.action = "/cims/jsp/admin/EditMatch.jsp"
		document.frmEditMatch.submit();	
    }
    function getPlayerList(){
	    document.getElementById("hid").value = "1";
		document.frmEditPlayer.action = "/cims/jsp/admin/EditPlayerMap.jsp";
		document.frmEditPlayer.submit();	
    }  
    function chk(){
    	if(document.getElementById("chksearch").checked==true){
     	  document.getElementById("txtmatchId").disabled=false;
     	  document.getElementById("txtmatchId").focus();
    	}else{
	   	  document.getElementById("txtmatchId").disabled=true;
    	}
    }
    function updateOver(){
   
   			 try{
				var inId = "";
				var matchId = ""
				if(document.getElementById("chksearch").checked==true){
					matchId = document.getElementById("txtmatchId").value
				}else{
					matchId = document.getElementById("matchid").value
				}
				if(document.getElementById('matchid').value == "0" && document.getElementById("chksearch").checked==false ){
				 		alert("Please select match");
				 		document.getElementById("matchid").focus();
				 		//document.getElementById("matchid").select();//dipti 19 05 2009
				 		return false;
				}else if(document.getElementById('txtmatchId').value=="" && document.getElementById("chksearch").checked==true ){
						alert("Please Enter match Id");
						document.getElementById("txtmatchId").focus();
						return false;	
				}else{
					//self.close();
					window.open("/cims/jsp/updateMatchInnings.jsp?inningsId="+inId+"&matchId="+matchId,"CIMSINNINGS","location=no,directories=no,status=Yes,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth)+",height="+(window.screen.availHeight))
				}
			}catch(err){
				alert(err.description + '/cims/jsp/admin/EditMatch.jsp.updateOver()');
			}		
		 }  

	function updateMatchResult(flag){
		
		try{
				var inId = "";
				var matchId = ""
				if(document.getElementById("chksearch").checked==true){
					matchId = document.getElementById("txtmatchId").value
				}else{
					matchId = document.getElementById("matchid").value
				}
				if(document.getElementById('matchid').value == "0" && document.getElementById("chksearch").checked==false ){
				 		alert("Please select match");
				 		document.getElementById("matchid").focus();
				 		return false;
				}else if(document.getElementById('txtmatchId').value=="" && document.getElementById("chksearch").checked==true ){
						alert("Please Enter match Id");
						document.getElementById("txtmatchId").focus();
						return false;	
				}else{
					self.close();
					if(flag == 1){
						window.open("/cims/jsp/changeResult.jsp?matchId="+matchId,"CIMSMATCHRESULT","location=no,directories=no,status=Yes,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth)+",height="+(window.screen.availHeight))
					}else if(flag == 2){
						window.open("/cims/jsp/changeTime.jsp?matchId="+matchId,"CIMSMATCHTIME","location=no,directories=no,status=Yes,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth)+",height="+(window.screen.availHeight))
					}	
					
				}
			}catch(err){
				alert(err.description + '/cims/jsp/admin/EditMatch.jsp.updateMatchResult()');
			}		
	}	

</script>
</head>

<body>

<jsp:include page="Menu.jsp"></jsp:include>
<FORM action="" name="frmEditMatch" id="frmEditMatch" method="post">
<br>
<br>
<br>
<table width="780" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
	<tr align="center">
		 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">
	                Edit Match
	     </td>
	</tr>
	
	<tr>
		<td colspan="3">
		<fieldset><legend class="legend1">Select Dates</legend> <br><br>
			<table width="90%" border="0" align="center" cellpadding="2" cellspacing="1" class="table" >
				<tr class="contentDark">	
				    <TD  width="30%" nowrap align="left" valign="top" >
				        From Date :<input maxlength="10" size="10" type="text" class="FlatTextBox150"
				        name="txtDateFrom" id="txtDateFrom" readonly value="<%=date_one%>"
				        onclick="showCal('FrCalendarFrom','DateFrom','txtDateFrom','frmEditMatch')">
				            <a href="javascript:showCal('FrCalendarFrom','DateFrom','txtDateFrom','frmEditMatch')">
				            <IMG src="../../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
				    </TD>
				    <TD  width="30%" nowrap align="left">	
				        To Date :<input type="text" maxlength="10" size="10" class="FlatTextBox150"
				        name="txtDateTo" id="txtDateTo" readonly value="<%=date_two%>"
				        onclick="showCal('FrCalendarTo','DateTo','txtDateTo','frmEditMatch')">
				        <a href="javascript:showCal('FrCalendarTo','DateTo','txtDateTo','frmEditMatch')">
				        <IMG src="../../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
				    </TD>
				    <TD width="30%" align="left" colspan="2"><input type="button" class="button1" name="btnmatch" id="btnmatch" value="Get Matches" onclick="getMatches()"> 
				    </TD>
				    
				   <TD colspan="2" align="center" > 
					     <SELECT name="matchid" id="matchid">
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
		    	<tr class="contentDark">
		    		<td colspan="6"><input type="checkbox" name="chksearch" id="chksearch" onclick="chk()">Search By Match Id:
		    		&nbsp;&nbsp;&nbsp;Enter Match Id:<input type="text" name="txtmatchId" id="txtmatchId" value="" class="textBoxAdminSearch" disabled="disabled"> </td>	
		   			
		    	</tr>
		    	
		    </table>
		    <br>
		   </fieldset> 
		   </td>
	 </TR>
  <tr><td>&nbsp;</td></tr>
  <tr class="contentDark">
    	<td  align="center" colspan="3"><input width="30%" type="button" class="button1" name="btnedit" id="btnedit" value="   Edit Match   " onclick="updateOver();"> 
    	<input width="30%" type="button" class="button1" name="btneditmatch" id="btneditmatch" value=" Edit Match Result " onclick="updateMatchResult('1');">
    	<input width="30%" type="button" class="button1" name="btnedittimeresult" id="btnedittimeresult" value=" Edit Match Time " onclick="updateMatchResult('2');">
    	</td>
  </tr>
</TABLE>
<br>

<INPUT type="hidden" id="hid" name="hid" />

<script>
  
</script>

</FORM>
<br><br><br><br>
<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>	
<%	}catch (Exception e) {
	  e.printStackTrace();
	}
%>