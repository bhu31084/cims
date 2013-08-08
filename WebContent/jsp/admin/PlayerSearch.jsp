<!--
Page name	 : PlayerSearch.jsp
Replaced By  : Vaibhav Gaikar.
Created Date : 31 dec 2008
Description  : To get player detail.
Company 	 : Paramatrix Tech Pvt Ltd. 
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>  
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
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
	response.setDateHeader("Expires", 0);
%>
<%  Common commonUtil		  	 =  new Common();
    CachedRowSet  crsObjRolesCrs =  null;
    CachedRowSet  crsObjStateCrs =  null;
    CachedRowSet  userRoleCrs	 =  null;
    CachedRowSet  playerDataCrs	 =  null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
    Vector vparam 			     =  new Vector();
    GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
%>
<% String hid 		   = "";
   String role		   = "";
   String retVal	   = "";
   String officialName = "";
   String playerName   = "";
   int cssCounter	   = 1;	
%>
<% hid = request.getParameter("hid")!=null?request.getParameter("hid"):"";
   if (hid!=null && hid.equalsIgnoreCase("2")){
   		String hidUserId = request.getParameter("hidUserId")!=null?request.getParameter("hidUserId"):"";
   		//vparam.add(hidUserId);
		//vparam.add("");
		//vparam.add("");
		//vparam.add("");
		//vparam.add("");
		//vparam.add("");
		//vparam.add("3");
		//vparam.add("");
		//userRoleCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_playermatches",vparam,"ScoreDB");
		//vparam.removeAllElements();	
		//if (userRoleCrs!=null && userRoleCrs.size() > 0){
			//while (userRoleCrs.next()){
			//	role = userRoleCrs.getString("role")!=null?userRoleCrs.getString("role"):"";	
			//}
		//}
		vparam.add(hidUserId);
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("2");
		vparam.add(role);	
		playerDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_playermatches",vparam,"ScoreDB");
		System.out.println("playerDataCrs" +playerDataCrs.size());
		vparam.removeAllElements();	
   }
%>

<html>
	<head>
			<title> Player Data </title>    
			<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
			<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" /> 
			<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>  
			<script>
					// ajax function call to search record
					function userSearch(){
						document.getElementById('hidpaging').value = 1;
						doGetUserData();
					}

					function GetXmlHttpObject(){
				        var xmlHttp=null;
				        try{
				            xmlHttp=new XMLHttpRequest();
				        }
				        catch (e){
				              // Internet Explorer
				           try{
				               xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
				           }
				           catch (e){
				                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
				           }
				          }
				            return xmlHttp;
					 }

					// Getting User Data
					 function doGetUserData(){
					 	  xmlHttp=GetXmlHttpObject();
				          if (xmlHttp==null){
				              alert ("Browser does not support HTTP Request") ;
				              return;
				          }
				          else{
				          		var param		  = 2 ;
				          	  	var nickName  	  = document.getElementById('searchNickName').value;
								var firstName 	  = document.getElementById('searchFirstName').value;
								var middleName	  = document.getElementById('searchMiddleName').value;
								var lastName  	  = document.getElementById('searchLastName').value;
								var displayName	  = document.getElementById('searchDisName').value;	
								var userRole  	  = document.getElementById('hidUserRole').value;	
								var roleId  	  = document.getElementById('selRoleId').value;	
								if (document.getElementById('hidpageid').value == 1){
									var hidpaging = document.getElementById('pagingno').value
								}else{
									var hidpaging = document.getElementById('hidpaging').value;	
								}
								var url= "/cims/jsp/admin/SearchUser.jsp?nickName="+nickName +  "&firstName="+firstName + "&middleName="+middleName + "&lastName="+lastName + "&userRole="+userRole + "&userRoleId="+roleId + "&displayName="+displayName + "&hidpaging="+hidpaging + "&param="+param;
								//var url= "SearchUser.jsp?nickName="+nickName +  "&firstName="+firstName + "&middleName="+middleName + "&lastName="+lastName + "&userRole="+userRole + "&userRoleId="+roleId + "&displayName="+displayName + "&hidpaging="+hidpaging + "&param="+param;
				                xmlHttp.onreadystatechange=stateChangedLAS1;
				                xmlHttp.open("get",url,false);
				                xmlHttp.send(null);
				                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				                   var responseResult= xmlHttp.responseText ;
				                   document.getElementById('userdetail').innerHTML = "";
				                   var mdiv = document.getElementById("searchUser");
				                   mdiv.innerHTML= responseResult;
				                }
				           }
				    	}

					 function stateChangedLAS1(){
			  		 }
	
					// to change textfield color		
						function changeColour(which) {
							if (which.value.length > 0) {   // minimum 2 characters
								which.style.background = "#FFFFCC"; // white
							}
							else {
								which.style.background = "";  // yellow
								//alert ("This box must be filled!");
								//which.focus();
								//return false;
							}
						}

						
					 
					//set firstname , middlename , lastname in search option		
						function searchName(){
							var firstName = document.getElementById('searchFirstName').value;
							var splitName = firstName.split(" ");
							if (splitName.length==3){
								var fName = splitName[0];		
								var sName = splitName[1];
								var lName = splitName[2];		
								document.getElementById('searchFirstName').value = fName;
								document.getElementById('searchMiddleName').value = sName;
								document.getElementById('searchLastName').value = lName;
							}else if (splitName.length==2){
								var fName = splitName[0];		
								var sName = splitName[1];
								document.getElementById('searchFirstName').value = fName;
								document.getElementById('searchMiddleName').value = "";
								document.getElementById('searchLastName').value = sName;
							}
						}

					function passUserData(userId){
							document.getElementById('hiduserId').value=userId;
							document.getElementById('hid').value = 2;
							document.getElementById('hidOnload').value = 2;
							document.getElementById('hidUpdate').value = "update";
							var hidUpdate = document.getElementById('hidUpdate').value;
							var hidUserId = document.getElementById('hiduserId').value;
							document.frmUser.action="/cims/jsp/admin/PlayerSearch.jsp?hidUpdate="+hidUpdate+"&hidUserId="+hidUserId;
							document.frmUser.submit();
					}	

					function nextPagingRecords(){
						if (document.getElementById('hidpageid').value ==1){
							document.getElementById('hidpaging').value = document.getElementById('hidpagingno').value
						}
						document.getElementById('hidpageid').value = 2
						var pageNo = document.getElementById('pageNo').value
						if (((document.getElementById('hidpaging').value) < parseInt(pageNo))){
							var val 	= document.getElementById('hidpaging').value;
							document.getElementById('hidpaging').value = parseInt(val) + 1;
							doGetUserData();
						}else{
							alert("These are last records.");
							//return false;	
						}
					}
					
					function previousPagingRecords(){
						if (document.getElementById('hidpageid').value ==1){
							document.getElementById('hidpaging').value = document.getElementById('hidpagingno').value
						}	
						document.getElementById('hidpageid').value = 2
						var val = document.getElementById('hidpaging').value;
						if (document.getElementById('hidpaging').value != 1){
							document.getElementById('hidpaging').value = parseInt(val) - 1;
							doGetUserData();
						}else{
							alert("These are first records.");
							//return false;
						}
					}

					function pagingRecords(){
						if (document.getElementById('pagingno').value==""){
							alert("Enter pageno");
							return false;
						}else{
							document.getElementById('hidpageid').value =1;
							document.getElementById('hidpagingno').value = document.getElementById('pagingno').value;
							doGetUserData();
						}
					}
			</script>
	</head>
	<body>
<div class="container">
			<jsp:include page="Menu.jsp"></jsp:include>
			<IFRAME id="download_reports" src="" width="0" height="0" ></IFRAME>
			<div class="leg">Player Detail Form</div>
			<div id="search" class="portletContainer">
					<jsp:include page="Search.jsp"/>
				</div>
				<div id="userdetail" name="userdetail">
				</div>		
				<div id="searchUser" name="searchUser">
				</div>
			<form id="frmPlayerSearch" name="frmPlayerSearch" method=post>
			<div id="playerdetail" name="playerdetail">
<%  if (hid!=null && hid.equalsIgnoreCase("2")){
	System.out.println("playerDataCrs" +playerDataCrs.size());
			if (playerDataCrs!=null && playerDataCrs.size() > 0){
				while(playerDataCrs.next()){
					retVal = playerDataCrs.getString("retVal")!=null?playerDataCrs.getString("retVal"):"";
					//System.out.println("retVal" +retVal);
			}	
		}
	}		
%>
<% if (hid!=null && hid.equalsIgnoreCase("2")){
	if (playerDataCrs!=null && playerDataCrs.size() > 0){
			playerDataCrs.beforeFirst();  	
				while(playerDataCrs.next()){
					playerName = playerDataCrs.getString("PlayerName")!=null?playerDataCrs.getString("PlayerName"):"" ;
				}
			if (retVal.equalsIgnoreCase("1")){
%>				<table border=1 width=100%>	
						<tr>
							<td colspan=7 align=center bgcolor="#FFFFFF" class="contentDark"><b>Player played in match detail</b></td>
						</tr>
						<tr>
							<td colspan=7 align=left >
								<table border=0>
										<tr>
											<td align=left colspan=1 class="colheadinguser">Name : </td>
											<td><%=playerName%></td>
										</tr>
								</table>
							</td> 
						</tr>
						<tr class="contentDark">
							<td align=center class="colheadinguser">Player team</td>
							<td align=center class="colheadinguser">Match id</td>
							<td align=center class="colheadinguser">Seriesname</td>
							<td align=center class="colheadinguser">Matchbetween</td>
							<td align=center class="colheadinguser">Venue</td>
							<td align=center class="colheadinguser">StartDate</td>
							<td align=center class="colheadinguser">EndDate</td>
						</tr>	
<%  			playerDataCrs.beforeFirst(); 
				while(playerDataCrs.next()){
					retVal = playerDataCrs.getString("retVal")!=null?playerDataCrs.getString("retVal"):"";
					if (cssCounter%2!=0)
					{
						
%>						<tr class="contentLight">
<%					}
					else
					{		
%>
						<tr class="contentDark">
<%					}
%>
							<td><%=playerDataCrs.getString("playerteam")!=null?playerDataCrs.getString("playerteam"):""%></td>
				   			<td align=center><a href="javascript:callAdminMatchSetUp('<%=playerDataCrs.getString("match_id")!=null?playerDataCrs.getString("match_id"):""%>')"><%=playerDataCrs.getString("match_id")!=null?playerDataCrs.getString("match_id"):""%></a></td>
				   			<td><%=playerDataCrs.getString("seriesname")!=null?playerDataCrs.getString("seriesname"):""%></td>
				   			<td><%=playerDataCrs.getString("matchbetween")!=null?playerDataCrs.getString("matchbetween"):""%></td>
							<td><%=playerDataCrs.getString("venue")!=null?playerDataCrs.getString("venue"):""%></td>
				   			<td align=center><%=playerDataCrs.getString("start_date")!=null?playerDataCrs.getString("start_date"):""%></td>
				   			<td align=center><%=playerDataCrs.getString("end_date")!=null?playerDataCrs.getString("end_date"):""%></td>
				   		</tr>
<% 				cssCounter ++;
				}
			}
%>   		</table>
<%			if (retVal.equalsIgnoreCase("2")){
				playerDataCrs.beforeFirst();  	
				while(playerDataCrs.next()){
					officialName = playerDataCrs.getString("PlayerName")!=null?playerDataCrs.getString("PlayerName"):"" ;
				}
%>				<table border=1 width=100%>	
				<tr>
					<td colspan=8 align=center><b>Officials match detail</b></td>
				</tr>
				<tr>
					<td colspan=7 align=left >
						<table border=0>
								<tr>
									<td align=left colspan=1 class="colheadinguser">Name : </td>
									<td><%=officialName%></td>
								</tr>
						</table>
					</td> 
				</tr>
				<tr class="contentDark">
					<td align=center class="colheadinguser">Match id</td>
					<td align=center class="colheadinguser">Seriesname</td>
					<td align=center class="colheadinguser">Matchbetween</td>
					<td align=center class="colheadinguser">Venue</td>
					<td align=center class="colheadinguser">StartDate</td>
					<td align=center class="colheadinguser">EndDate</td>
				</tr>	
<%  			playerDataCrs.beforeFirst();  	
				while(playerDataCrs.next()){
					retVal = playerDataCrs.getString("retVal")!=null?playerDataCrs.getString("retVal"):"";
					if (cssCounter%2!=0)
					{
						
%>						<tr class="contentLight">
<%					}
					else
					{		
%>
						<tr class="contentDark">
<%					}
%>
				
						<td align=center><a href="javascript:callAdminMatchSetUp('<%=playerDataCrs.getString("match_id")!=null?playerDataCrs.getString("match_id"):""%>')"><%=playerDataCrs.getString("match_id")!=null?playerDataCrs.getString("match_id"):""%></a></td>
			   			<td><%=playerDataCrs.getString("seriesname")!=null?playerDataCrs.getString("seriesname"):""%></td>
			   			<td><%=playerDataCrs.getString("team_one")!=null?playerDataCrs.getString("team_one"):""%> v/s <%=playerDataCrs.getString("team_two")!=null?playerDataCrs.getString("team_two"):""%></td>
						<td><%=playerDataCrs.getString("venue")!=null?playerDataCrs.getString("venue"):""%></td>
			   			<td align=center><%=playerDataCrs.getString("start_date")!=null?playerDataCrs.getString("start_date"):""%></td>
			   			<td align=center><%=playerDataCrs.getString("end_date")!=null?playerDataCrs.getString("end_date"):""%></td>
			   		</tr>
<%			cssCounter ++;
			}
		 }
%>			</table>
<%   }else{			
%>			<table align="center"><tr><td><font color=red>Record not found</font></td></tr></table>
<%	}
}
%>
    </div>
</form>
    <br><jsp:include page="Footer.jsp"></jsp:include>
</div>	
</body>

	<script>
	 function exportToExcel() 
	 {
		var roleId = document.getElementById('selRoleId').value ;
		if (roleId=='0')
		{
			alert("select role");
			return false;
		}
		document.getElementById("download_reports").src= "/cims/jsp/admin/ExcelReport.jsp?roleId="+roleId;
	}

	function callAdminMatchSetUp(matchId)
	{	
		document.frmPlayerSearch.action="/cims/jsp/admin/AdminMatchSetUp.jsp?matchId="+matchId;
		document.frmPlayerSearch.submit();
	}
	</script>

</html>