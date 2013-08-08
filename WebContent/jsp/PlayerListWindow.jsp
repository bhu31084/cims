<!--
	Page Name 	 : PlayerListAjaxResponse.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 22th Nov 2008
	Description  : Ajax Response for Player List 
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
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>

<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);

%>
<HTML>
<HEAD>
	<title>Player List</title>
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
    
    <script language="javascript">
    
    	function previousPagingRecords(){
			var val = document.getElementById('hidpaging').value;
			if (document.getElementById('hidpaging').value != 1){
				document.getElementById('hidpaging').value = parseInt(val) - 1;
				var clubId=document.playerListWindow.clubId.value;
				var teamId=document.playerListWindow.teamlist.value;
   	        	getPlayerList(clubId, teamId, document.getElementById('hidpaging').value);
       			document.getElementById('next').style.display = "";
			}else{
				alert("These Are First Records");
        		//document.getElementById('previous').style.display = "none";
				//return false;
			}
		}
		
		function nextPagingRecords(){
				var pageNo	= document.getElementById('pageNo').value;
				if (((document.getElementById('hidpaging').value) < parseInt(pageNo))){
					var val 	= document.getElementById('hidpaging').value;
					document.getElementById('hidpaging').value = parseInt(val) + 1;
					
				  	        		
   	        		var clubId=document.playerListWindow.clubId.value;
   	        		var teamId=document.playerListWindow.teamlist.value;
   	        		getPlayerList(clubId, teamId, document.getElementById('hidpaging').value);
   	        		document.getElementById('previous').style.display = "";
				} else {
					alert("These Are Last Records");
	        		//document.getElementById('next').style.display = "none";
					//return false;	
				}
			}
      
    
		function setPlayerListWindow(obj) {
//			alert('setPlayerListWindow ' + obj);
			window.returnValue = obj;
			window.close();
		}
		
		var xmlHttp=null;
		
		function GetXmlHttpObject() { 
		      try{
		         //Firefox, Opera 8.0+, Safari
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
	 	
	 	function displayData() {
			
		}
		
		function getPlayerList(clubId, teamId, pageNo) {
	        xmlHttp = GetXmlHttpObject();  
	    	                 
            if(clubId!= "" && pageNo != "") {
		        var url = "/cims/jsp/PlayerListAjaxResponse.jsp?pageNo="+pageNo+"&clubId="+clubId+"&teamId="+teamId;
			    //xmlHttp.onreadystatechange = displayData;
				xmlHttp.open("get",url,false);
				xmlHttp.send(null);
				if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					   var responseResult = xmlHttp.responseText ;
			   		      
			   		      try //Internet Explorer
						  {
							  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
							  xmlDoc.async="false";
							  xmlDoc.loadXML(responseResult);
							  var mess = responseResult;
							  document.getElementById('playerList').innerHTML = mess;

			              } catch(e) {
						 
						  try //Firefox, Mozilla, Opera, etc.
						  {
						    //parser=new DOMParser();
						   // xmlDoc=parser.parseFromString(text,"text/xml");
						   
						    } catch(e) {
						    	alert(e.message)
						    }
						 }
				}
	      	}
		   
      }
      
      function getPlayerListOnChange() {
	        xmlHttp = GetXmlHttpObject();
	        
	       	var clubId= document.playerListWindow.clubId.value;
   	        var teamId= document.playerListWindow.teamlist.value;
   	        document.getElementById('hidpaging').value="1";
	        var pageNo = document.getElementById('hidpaging').value;      
           
            if(clubId!= "" && pageNo != "") {
		        var url = "/cims/jsp/PlayerListAjaxResponse.jsp?pageNo="+pageNo+"&clubId="+clubId+"&teamId="+teamId;
			    //xmlHttp.onreadystatechange = displayData;
				xmlHttp.open("get",url,false);
				xmlHttp.send(null);
				if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					   var responseResult = xmlHttp.responseText ;
			   		      
			   		      try //Internet Explorer
						  {
							  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
							  xmlDoc.async="false";
							  xmlDoc.loadXML(responseResult);
							  var mess = responseResult;
							  document.getElementById('playerList').innerHTML = mess;

			              } catch(e) {
						 
						  try //Firefox, Mozilla, Opera, etc.
						  {
						    //parser=new DOMParser();
						   // xmlDoc=parser.parseFromString(text,"text/xml");
						   
						    } catch(e) {
						    	alert(e.message)
						    }
						 }
					}
	      	}
		   
      }
		
		
	</script>
</HEAD>

<%
        CachedRowSet crsObjResult = null;
        CachedRowSet crsObjTeamResult = null;
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		String clubId = request.getParameter("clubId");
		Integer pageNo = null; 
		
		try {
			vparam.add(clubId);
			crsObjTeamResult = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_clubteams", vparam, "ScoreDB");
			vparam.removeAllElements();
			
			vparam.add(clubId);
			vparam.add("0");
			vparam.add("1");
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_playerListPaging", vparam, "ScoreDB");
			
%>
<body>
<form name="playerListWindow" id="playerListWindow">
<input type="hidden" name="clubId" id="clubId" value='<%=clubId%>'>
<input type="hidden" name="hidpaging" id="hidpaging" value="1">
<table width="100%" align="center" border="0">
	<tr>
		<td>
			<table width="90%" border="0" align="center">
				<tr>
					<td width="100%" colspan="3" align="center" class="legend"><font size=4><b>Player List</b></font></td>
				</tr>	
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="90%" border="0" align="center">
				<tr>
					<td>
						Team Name :
					</td>
					<td>
						<select id="teamlist" name="teamlist" onchange="getPlayerListOnChange();">
						<option value="0" selected>Select Team</option>
						<%
						if(crsObjTeamResult != null && crsObjTeamResult.size() > 0) {
							while (crsObjTeamResult.next()) {
						%>
								<option value="<%=crsObjTeamResult.getString("id")%>"><%=crsObjTeamResult.getString("team_name")%></option>
						<%
							}
						}
						%>
						</select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table border="0">
				<tr>
					<td>
						<DIV id="previous" name="previous" style="display:none" >
							<a href="javascript:previousPagingRecords();"><FONT color="blue"><U>Previous</U></a>
						</DIV>
					</td>
					<td>
						<DIV id="next" name="next">
							<a href="javascript:nextPagingRecords();"><FONT color="blue"><U>Next</U></a>
						</DIV>
					</td>
				</tr>	
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<DIV id="playerList" name="playerList">
				<table width="100%" border="0" align="center" >
					<tr class="contentDark">
						<th class="colheadinguser">Player Name</th>
						<th class="colheadinguser">Team Name</th>
					</tr>
					<tr class="contentLight1">
						
	<%
				if(crsObjResult != null && crsObjResult.size() > 0) {
					while (crsObjResult.next()) {
							pageNo = crsObjResult.getInt("usernoofpages");
							
							//System.out.println("pageNo " + pageNo);

	%>
						<td nowrap><font size=2><a onclick="javascript:setPlayerListWindow('<%=crsObjResult.getString("id")%>|<%=crsObjResult.getString("name")%>');"><%=crsObjResult.getString("name")%></a></font></td>
						<td nowrap><font size=2><%=crsObjResult.getString("team")%></font></td>
					</tr>	
				
	<%
					}
				
	%>
				</table>
			</DIV>
			</td>
		</tr>
	</table>
		
<%
		} else {
		%>
			
			<font color=red>No Player Found</font>
		
		<%
		} 
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
<input type="hidden" name="pageNo" id="pageNo" value='<%=pageNo%>'>
</form>
</body>
 