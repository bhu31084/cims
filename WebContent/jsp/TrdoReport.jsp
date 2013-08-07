<!--
	Page Name 	 : TrdoReport.jsp
	Created By 	 : Archana Dongre.
	Created Date : 4th Dec 2008
	Description  : TRDO report on Players Strengths and weaknesses.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
            in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
            java.util.*"%>

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
<%
	
	String role = "4";
	String FLAG = "2";
	
	String match_id = session.getAttribute("matchid").toString();
	String user_id = session.getAttribute("userid").toString();
	String loginUserId = session.getAttribute("usernamesurname").toString();
	String user_role = session.getAttribute("role").toString();
	//String refereeReportId = "8";//report id of referee report	
	
	CachedRowSet crsObjplayerDetail = null;
	
	CachedRowSet crsObjPropertyDetail = null;		

	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	Vector vparam = new Vector();
	Vector ids = new Vector();	
		
	//To display the userrole id's of players
	try{
			vparam.add(match_id);
			crsObjplayerDetail = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_userroleid_for_breaches",vparam,"ScoreDB");
			vparam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
    		e.printStackTrace();
		}
	//To dispaly the player records
	try{
			vparam.add(match_id);//Match id
			vparam.add("");//UserRole id
			vparam.add(FLAG);//Flag for display 2.
			crsObjPropertyDetail = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_referee_breachs_fb",vparam,"ScoreDB");
			vparam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
    		e.printStackTrace();
		}%>		

<html>
<head>
	<title> TRDO Report On Players</title>
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />	
	<script language="javascript">

	function GetXmlHttpObject(){//ajax code to get the div from other page.
		var xmlHttp=null;
		try{
	    	// Firefox, Opera 8.0+, Safari
			xmlHttp=new XMLHttpRequest();
		}catch (e){
			// Internet Explorer
			try{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}catch (e){
	           	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}	

	function GetStrengthOrWeakness(){		
		var Property = document.getElementById("dpProperty").value;
		var player_role = document.getElementById("dpRole").value;
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			var url ;
	    	url="/cims/jsp/GetPlayersStrengthWeakness.jsp?Property="+Property+"&player_role="+player_role;
			document.getElementById("StrengthDiv").style.display='';
			document.getElementById("tempDev").style.display='none';
			xmlHttp.onreadystatechange=stChgStrengthsResponse;
			xmlHttp.open("post",url,false);
		   	xmlHttp.send(null);
		}
	}
	
	function stChgStrengthsResponse(){
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("StrengthDiv").innerHTML = responseResult;
		}
	}	
	
	
	//To be called by Breaches add button.
	function AddBreaches(){
		if(document.getElementById("dpPlayer").value == 0){
			alert("Please select Player");
			document.getElementById("dpPlayer").focus();
			return false;			
		}else if(document.getElementById("dpRole").value == 0){
			alert("Please select Role");
			document.getElementById("dpRole").focus();
			return false;			
		}else if(document.getElementById("dpProperty").value == 0){
			alert("Please select Property");
			document.getElementById("dpProperty").focus();
			return false;
		}else if(document.getElementById("dpStrength").value == 0){
			alert("Please select Strength or weakness");
			document.getElementById("dpStrength").focus();
			return false;						
		}else{
			var matchid = document.getElementById("hdmatchid").value;
			var playerId = document.getElementById("dpPlayer").value;
			var RoleId = document.getElementById("dpRole").value;
			var PropertyId = document.getElementById("dpProperty").value;
			var StrengthId = document.getElementById("dpStrength").value;
			var Remark = document.getElementById("txtremark").value;		
			
			xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null){
				alert ("Browser does not support HTTP Request");
		        return;
			}else{
				var url ;
		    	url="/cims/jsp/TrdoDataSave.jsp?matchid="+matchid+"&playerId="+playerId+"&RoleId="+RoleId+"&PropertyId="+PropertyId+"&StrengthId="+StrengthId+"&Remark="+Remark;				
				document.getElementById("SavedStrengthDiv").style.display='';
				xmlHttp.onreadystatechange=stChgBreachesResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			    document.getElementById("dpRole").value = "0";
			    document.getElementById("dpProperty").value = "0";
			    document.getElementById("dpStrength").value = "0";
			    document.getElementById("txtremark").value = "";		   	
			}
		}	
		
	}

	function stChgBreachesResponse(){
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("SavedStrengthDiv").innerHTML = responseResult;
			
		}
	}		
	
</script>
</head>
<body >
<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="frmTrdoReport" id="frmTrdoReport" method="post"><br>
	<table width="880" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td colspan="2" bgcolor="#FFFFFF" class="legend">TRDO Report on Players</td>
		</tr>
		<tr class="contentDark">			
			<td colspan="2" style="color: red "><font size="3" ></td>				
		</tr>
</table>
<br>
<!--table for breaches field. -->	
<table width="880" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
	<tr>
		<td colspan="6" align="center" ><font color="#840084" size="3"><b>Summary of Strengths & weaknesses of the Players.</b></font></td>
		
	</tr>
	<tr><td><br></td></tr>
	<tr class="contentLight" >
		<td  align="left" >Match Players</td>
		<td  align="left" >Role </td>
		<td  align="left" >Property </td>
		<td  align="left" >Strengths/Weakness </td>
		<td  align="left" >Remark </td>			
	</tr>
	<tr class="contentDark">
		<td >
			<select name="dpPlayer" id="dpPlayer" >
				<option value="0" >Select </option>
<%					if(crsObjplayerDetail != null){
						while(crsObjplayerDetail.next()){%>
				<option value="<%=crsObjplayerDetail.getString("userroleid")%>" ><%=crsObjplayerDetail.getString("playername")%></option>
<%						}
					}
%>					<input type="hidden" id="hdPlayerName" name="hdPlayerName" value="">
				</select>
			</td>
			<td>      			       			
				<select name="dpRole" id="dpRole" >
					<option value="0">-Select-</option>
					<option value="1">Batting</option>
	       			<option value="2">Bowling</option>
	       			<option value="3">Fielding</option>
	       			<option value="4">WicketKeeping</option>
				</select>
			</td>			
			<td >	
				<select name="dpProperty" id="dpProperty" onchange="GetStrengthOrWeakness()">
						<option value="0">-Select-</option>
       				<option value="1">Strengths</option>
       				<option value="2">Weakness</option>
       			</select>
			</td>		
			<td width="20%">
       			<div id="tempDev">
       			<select>
       				<option>-Select-</option>
       			</select>
       			</div>
	       		<div id="StrengthDiv" style="display: none;">  												
				</div>
				<input type="hidden" id="hdOffence" name="hdOffence" value="">
			</td>			
			<td><input type="text" id="txtremark" name="txtremark" value=""></td>
       		<td align="left" >
       			<input class="button1" type="button" id="btnAddBreaches" name="btnAddBreaches" value="Add" onclick="AddBreaches()" >
       			<input type="hidden" id="hdmatchid" name="hdmatchid" value="<%=match_id%>">
   		</td>
	</tr>
</table>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="admin/Footer.jsp"></jsp:include> 
<br>
<br>
<!--end of table breaches field. -->
<div id="SavedStrengthDiv" style="display: none; color:red;font-size: 15" align="center"></div>

	
	
</form>	

</body>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="admin/Footer.jsp"></jsp:include>  
</html>   
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         