<!--
Page Name 	 : TeamPlayerMap.jsp
Created By 	 : Avadhut Joshi
Created Date : 07th Oct 2008
Description  : Mapping of players to team Main Page
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"
%> 
<jsp:include page="../AuthZ.jsp"></jsp:include>
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
		String strfname	="";
		String strmname	="";
		String flag		="";		
		String strsname	="";


              		
		try{	
				CachedRowSet  playerCachedRowSet		= null;
				CachedRowSet  teamsCachedRowSet		= null;				
				GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();				
				Vector vparam =  new Vector();					
				strfname = request.getParameter("hdFname");				
				strmname = request.getParameter("hdMname");				
				strsname = request.getParameter("hdSname");				
				
				if(strfname!=null){		
	                vparam.add(strfname);
	                vparam.add(strmname);
	                vparam.add(strsname);                                 
	                playerCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_playersearch",vparam,"ScoreDB");               								
	                vparam.removeAllElements();  		
                }
                String user_id = session.getAttribute("userid").toString();
                vparam.add(user_id);
                teamsCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_teams_playermap",vparam,"ScoreDB"); 				            								
                vparam.removeAllElements(); 
                System.out.println("asssssssssssssssssssssssssssssssssss");
%>
<html>
  <head>
    <title>Team Player Map</title>
    <link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
    <script>
    		function fnSearch(){
//    			document.getElementById("divTeamMap").style.display=''; 
				document.getElementById('hdFname').value=document.getElementById('txtFname').value;
				//alert(document.getElementById('hdFname').value);
				document.getElementById('hdMname').value=document.getElementById('txtMname').value;
				//alert(document.getElementById('hdMname').value);				
				document.getElementById('hdSname').value=document.getElementById('txtSname').value;								
				//alert(document.getElementById('hdSname').value);	
				if((isBlank(document.getElementById('hdFname').value)==false)||(isBlank(document.getElementById('hdMname').value)==false)||(isBlank(document.getElementById('hdSname').value)==false)){
					document.frmTeamPlayerMap.submit();	  
				}else{
					alert("Please Enter First Name or Second Name or Last Name of the Player for Search");
				}
    		}
    		
    		function searchName(){
						var firstName = document.getElementById('txtFname').value;
						var splitName = firstName.split(" ");
						if (splitName.length==3){
							var fName = splitName[0];		
							var sName = splitName[1];
							var lName = splitName[2];		
							//alert("first" +fName);
							//alert("second" +sName);
							//alert("last" +lName);
							document.getElementById('txtFname').value = fName;
							document.getElementById('txtMname').value = sName;
							document.getElementById('txtSname').value = lName;
						}else if (splitName.length==2){
							var fName = splitName[0];		
							var sName = splitName[1];
							document.getElementById('txtFname').value = fName;
							document.getElementById('txtMname').value = "";
							document.getElementById('txtSname').value = sName;
						}
					}
    </script>
    <script>
var flagAMD = 1;
    		function GetXmlHttpObject()//ajax code to get the div from other page.
		{
	    	var xmlHttp=null;
	        	try
	            {
	            	// Firefox, Opera 8.0+, Safari
	                xmlHttp=new XMLHttpRequest();
	            }
	            catch (e)
	            {
	                	// Internet Explorer
	                	try
	                   	{
	                   		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	                   	}
	                 	catch (e)
	                   	{
	                   		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	                   	}
                }
                return xmlHttp;
           	}
           	
           	function GetTeamsData(userid)
	       	{	  	
	       	document.getElementById('hduserid').value=userid;
	       				if(flagAMD == 1){
				    	xmlHttp=GetXmlHttpObject();
		                if (xmlHttp==null)
		                	{
		                	 alert ("Browser does not support HTTP Request");
		                        return;
		                    }else{ 
		                    	var url ;  
		                     	url="TeamsResponse.jsp?flagAMD="+flagAMD; 	                                    	  
								document.getElementById("TeamsDiv"+userid).style.display='';
								xmlHttp.onreadystatechange=stateChangedUmpResponse;
								xmlHttp.open("post",url,false);								
		                        xmlHttp.send(null); 		  		
		                        
						}	
	       			}else{
	       			//("11")
	       				Save(userid);
	       				//alert("12")
				    	xmlHttp=GetXmlHttpObject();
				    	//alert("13")
		                if (xmlHttp==null)
		                	{
		                    	alert ("Browser does not support HTTP Request");
		                        return;
		                    }else{
		                    //alert("14") 
		                    	var url ;  
		                    	//alert("15")
		                     	url="TeamsResponse.jsp?flagAMD="+flagAMD; 	                                    	  
		                     	//alert("16")
								document.getElementById("TeamsDiv"+userid).style.display='';
								xmlHttp.open("post",url,false);
		                        xmlHttp.send(null); 		  	
		                        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
			                	{
			                		var userid = document.getElementById('hduserid').value;
			                	   	var responseResult= trimAll(xmlHttp.responseText);
									//alert("response is "+responseResult)
									var cmbbox = responseResult;
									//alert(cmbbox);
			                        var mdivteams = document.getElementById("TeamsDiv"+userid);	                        
			                        mdivteams.innerHTML = cmbbox;

			                    }	
						}	
	       			}	        					        		        				
				}	 	
      	
			function Save(userid){	

				var teamId = document.getElementById('cmbTeam').value;		
				var statusId = document.getElementById('cmbStatus').value;					

				xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                	{
                    	alert ("Browser does not support HTTP Request");
                        return;
                    }else{ 
                    	var url ;  
                     	url="/cims/jsp/admin/TeamPlayerMapResponse.jsp?userid="+userid+"&teamId="+teamId+"&statusId="+statusId; 	                                    	  							
						//alert(url)
						document.getElementById("divMessage").style.display='';
						
						xmlHttp.open("post",url,false);
                        xmlHttp.send(null);
                        document.getElementById('hduserid').value = document.getElementById('cmbTeam').value;
    	        		var userid = document.getElementById('hduserid').value;
    	            	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    	                	{
    	                	   	var responseResult= xmlHttp.responseText;
    	                	   	var splitres = responseResult.split('<br>');
    	                	   	//alert(responseResult);
    	                	   	document.getElementById("divMessage").innerHTML = splitres[0];
    	                	   	document.getElementById("divteamplayers").innerHTML = splitres[1];
    	                	   	//document.getElementByid("divMessage").style.display='';
    	                	   //	alert("responseResult "+responseResult);
    	                    } 		  		
				}				
			}
			
           	function playerdisplay(){
				var teamId = document.getElementById('cmbTeams').value;		
				xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                	{
                    	alert ("Browser does not support HTTP Request");
                        return;
                    }else{ 
                    	var url ;  
                     	url="/cims/jsp/admin/TeamPlayersResponse.jsp?teamId="+teamId; 	                                    	  							
						//alert(url)
						document.getElementById("divteamplayers").style.display='';
						
						xmlHttp.open("post",url,false);
                        xmlHttp.send(null);
                        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	                	{
	                		
	                	   	var responseResult= xmlHttp.responseText;
							document.getElementById("divteamplayers").innerHTML = responseResult;
	                    } 		  		
				}				
				

           	}
			
	
function user(){
//var user = "";
//user = document.getElementById('lbSelectedPlayersFrom').selected.value;
		/*var player = document.getElementById('lbSelectedPlayersFrom').options
		for(i = 0; i< player.length;i++){
			if(player[i].selected){
				alert(player[i].text)
			}
		}*/
		//alert(document.getElementById('lbSelectedPlayersFrom').value)	
			var optionval = document.getElementById('lbSelectedPlayersFrom').value;	
			window.open("UserMaster.jsp?userid="+optionval,'users','location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,height=1000,width=1000')
}
 
 // to change textfield color		
		function changeColour(which) {
			if (which.value.length > 0) {   // minimum 2 characters
				which.style.background = "#FFFFFF"; // white
			}
			else {
				which.style.background = "";  // yellow
				//alert ("This box must be filled!");
				//which.focus();
				//return false;
			}
		}             	
    </script>
  </head>
  
<body>
<jsp:include page="Menu.jsp"></jsp:include>
	<form name="frmTeamPlayerMap" id="frmTeamPlayerMap" class="MainBodyTrans" method="post">	

	<table width="95%" align="left" border="0" class="table">
	<tr align="center">	
		<td colspan="2" align="left" bgcolor="#FFFFFF" class="leg"> Team Player Map</td>
		<td><input type="hidden" name="hdmatch_id" id="hdmatch_id" value=""></td>						
	</tr>
	<tr>
		<td align="left" valign="top" colspan="1"  >
			<fieldset id="fldsetMchTypeCategory" style="width: 600px; height: 150px;"> 
				<legend class="legend1">
<%--				<font size="3" color="#003399" ><b>Player Search </b></font>--%>
						Player Search
				</legend>
			<br>
			<table align="center" style="border-top: 1cm; width:100%;" border="0" class="table" >
				<tr align="left" class="contentDark">
					<td class="colheadinguser1" align="Center" colspan="1" >First Name <input type="hidden" name="hdmatch_id" id="hdmatch_id" value=""></td>	
					<td class="colheadinguser1" align="CENTER" colspan="1">Middle Name</td>	
					<td class="colheadinguser1" align="CENTER" colspan="1">Surname</td>			
				</tr>
				<tr align="center" class="contentLight">
					<td colspan="1" align="CENTER">
						<input onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" class="input" class="textBoxAdmin" type="text" name="txtFname" id="txtFname"  onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz ');" onblur="searchName()">				
						<input type="hidden" name="hdFname" id="hdFname" value="">						
					</td>				
					<td colspan="1" align="CENTER">
						<input onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" class="input" class="textBoxAdmin" type="text" name="txtMname" id="txtMname"  onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz ');" >				
						<input type="hidden" name="hdMname" id="hdMname" value="">											
					</td>
					<td colspan="1" align="CENTER">
						<input confocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" lass="input" class="textBoxAdmin" type="text" name="txtSname" id="txtSname"  onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz ');">	
						<input type="hidden" name="hdSname" id="hdSname" value="">														
					</td>
				</tr>
				<tr align="right" class="contentDark">
					<td colspan="3"><input class="btn btn-warning" type="button" name = "btnSearch" id ="btnSearch" value= "Search" onclick="fnSearch()"> </td>
				</tr>			
			 </table>	
			 </fieldset>
		<div id="divMessage" style="display: none; font-style: italic; color: blue;font-size: 15;font-weight: bold;" align="left" >
		</div>		
		<table>
				<tr align="center" class="contentDark">				
					<td align="center" colspan="7" class="contentDark">Map Player to The Team
					<input type="hidden" name="hdmatch_id" id="hdmatch_id" value=""></td>						
				</tr>
				<tr class="contentDark">
					<td class="	" >Select</td>				
					<td class="colheadinguser">First Name</td>
					<td class="colheadinguser">Middle Name</td>
					<td class="colheadinguser">Surname</td>		
					<td class="colheadinguser">Status</td>						
					<td class="colheadinguser">Select Team</td>	
					<td class="colheadinguser">Save</td>									
				</tr>			
<%
			if(playerCachedRowSet!=null){
			while(playerCachedRowSet.next()){
%>		
				<tr class="contentLight" >
					<td>
						<input type="radio" id="<%=playerCachedRowSet.getString("user_role_id")%>" name="rdedit" value="" onclick='javascript:GetTeamsData(<%=playerCachedRowSet.getString("user_role_id")%>)'>
					</td>	
						<input type="hidden" name="hdUser" id="hdUser" value="<%= playerCachedRowSet.getString("user_role_id") %>">	
					<td>
							<%= playerCachedRowSet.getString("fname") %>					
					</td>
					<td>
							<%= playerCachedRowSet.getString("mname") %>		
					</td>
					<td>
							<%= playerCachedRowSet.getString("sname") %>		
					</td>
					<td>
					  		<select onfocus = "this.style.background = '#FFFFCC'" style="width:2cm" class="inputField" name="cmbStatus" id="cmbStatus">									
							<option value="0" >select</option>
							<option value="1" >Active</option>
							<option value="2" >Inactive</option>
							<option value="3" >Delete</option>														
						</select>
					</td>
					<td align="left">
						<div id="TeamsDiv<%=playerCachedRowSet.getString("user_role_id")%>" style="display: none;">
						</div>
					</td>
					<td align="center">
						<b><a href="#" onclick="Save(<%=playerCachedRowSet.getString("user_role_id")%>)" class="btn btn-small" style="text-decoration:none;"> Save  </a></b>
					</td>										
						<input type="hidden" id="hduserid" value=""> 			
				</tr>
<%			}
			}
%>			
			</table>		
		<td valign="top" width="30%">
			<fieldset id="fldsetMchTypeCategory"  style="width: 369px; height: 580px"> 
			<legend class="legend1">
				Team Player Search 
			</legend> 				
			<select onfocus = "this.style.background = '#FFFFCC'" style="width:6.2cm" class="inputField" name="cmbTeams" id="cmbTeams"  onchange="playerdisplay()">
				<option>--Select Team--</option>
<%				if(teamsCachedRowSet!=null){
				while(teamsCachedRowSet.next()){
%>
				<option value="<%=teamsCachedRowSet.getString("id") %>"><%=teamsCachedRowSet.getString("team_name") %> </option>						
<%				}}
%>
			</select>						
			<div id="divteamplayers" ondblclick="user();" style="display: none;"></div>
			</fieldset>			
		</td>	
	</tr>
	<tr >
	<td colspan="2"><jsp:include page="Footer.jsp"></jsp:include>
		</td>	

	</tr>
</table>	
<br>
<%
	}catch(Exception e){
		e.printStackTrace();
		out.println(e);
	}
%>					
				
				
  </form>
  </body>

</html>
