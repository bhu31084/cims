<!--
	Page Name	 : SeriesMatchDetailsByOfficials.jsp
	Author 		 : Archana Dongre
	Created Date : 12/05/2009
	Description  : Display match details of all Officials in web page.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*"%>
<%@ include file="loginvalidate.jsp" %>
<%
	//String match_id = session.getAttribute("matchid").toString();
	//String user_id =session.getAttribute("userid").toString();34290
	String user = "34290";
	//String loginUserId = session.getAttribute("usernamesurname").toString();
	//String user_role = session.getAttribute("role").toString();
	String user_role = "9";
	//System.out.println("user_id "+ user_id + " loginUserId " + loginUserId);
	//System.out.println("user_role "+ user_role );

	//LogWriter log = new LogWriter();
	 

	CachedRowSet crsObjGetMatchPt = null;
	CachedRowSet  crsObjTournamentNm = null;
	CachedRowSet crsObjSeason   = null;
	CachedRowSet crsObjZone   = null;
	//GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	//Vector vparam = new Vector();
	//Common common = new Common();
	String series_name = "";
	String season_name = "";
	String flag = "1";
	String officialflag = "2";
	String seasonId = "";
	String roleId = "";
	String pageNo = "";
	String zoneId = "";
	String gsScorerId = "";
	String hdrole = "";
%>
<%
	try{
		vparam.add("0");//display all Tournament name.
		crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");
		vparam.removeAllElements();
	}catch(Exception e){
		System.out.println("*************ScorerSeriesMatchDetails.jsp*****************"+e);
		//log.writeErrLog(page.getClass(),match_id,e.toString());
	}
	
	try{
		vparam.add("1");//display all Tournament name.
		vparam.add("");
		crsObjZone = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_zone_club_role",vparam,"ScoreDB");
		vparam.removeAllElements();
	}catch(Exception e){
		System.out.println("*************ScorerSeriesMatchDetails.jsp*****************"+e);
		//log.writeErrLog(page.getClass(),match_id,e.toString());
	}
	//String checked = request.getParameter("chkallrole");
	//System.out.println("checked  "+checked);
	//if(user_role.equalsIgnoreCase("9")){
		if (request.getMethod().equalsIgnoreCase("POST")) {
		// if(request.getParameter("chkallrole"))			
			if(request.getParameter("dprole") != null && !request.getParameter("dprole").equals("")) {
				seasonId = request.getParameter("dpseason");
				roleId = request.getParameter("dprole");
				zoneId = request.getParameter("dpZone");				
				System.out.println("seasonId "+seasonId);//esp_dsp_officialmatches 'season','userid','flag','role','zone'
				System.out.println("roleId "+roleId);
				vparam.removeAllElements();
				vparam.add(seasonId);//1	
				vparam.add(user);//admin-34290			
				vparam.add(flag);//1
				vparam.add(roleId);//for scorer-3,umpire-2,umpire coach-6,referee-4
				vparam.add(zoneId);				
				
				try {
					crsObjGetMatchPt = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_officialmatches", vparam, "ScoreDB");
					vparam.removeAllElements();
				} catch (Exception e) {
					System.out.println("*************SeriesMatchDetailsByOfficials.jsp*****************"+e);
					//log.writeErrLog(page.getClass(),match_id,e.toString());
				}
			}else{
				seasonId = request.getParameter("dpseason");				
				zoneId = request.getParameter("dpZone");
				roleId = "";
				//if(request.getParameter("hdrole").equalsIgnoreCase("all")){
					System.out.println("seasonId "+seasonId);//esp_dsp_officialmatches 'season','userid','flag','role','zone'
					//System.out.println("roleId "+roleId);
					vparam.removeAllElements();
					vparam.add(seasonId);//1	
					vparam.add(user);//admin-34290			
					vparam.add(flag);//1
					vparam.add(roleId);//for scorer-3,umpire-2,umpire coach-6,referee-4
					vparam.add(zoneId);							
				try {
					crsObjGetMatchPt = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_officialmatches", vparam, "ScoreDB");
					vparam.removeAllElements();
				} catch (Exception e) {
					System.out.println("*************SeriesMatchDetailsByOfficials.jsp*****************"+e);
					//log.writeErrLog(page.getClass(),match_id,e.toString());
				}
				//}				
			}
		}	
	
%>
<html>
<head>
<title>Match Points Table</title>
    <link href="../css/Main.css" rel="stylesheet" type="text/css" />
	<link href="../css/commonSpry.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="../js/otherFeedback.js"></script>
	<script language="JavaScript" src="../js/popup.js"></script>
	<script type="text/javascript" src="../js/common.js"></script>
	<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>
	<script language="JavaScript">
	
	var scorer = null;
	var series = null;
	var user =null;		
	var xmlHttp=null;
	
	function GetXmlHttpObject() {
		try{
			//Firefox, Opera 8.0+, Safari
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
	
	function callSubmit(){		
			try{
				document.getElementById('hdSubmit').value = "submit"			
				if(document.getElementById('txtUserName').value == ""){
					alert(" User Name can not be left Blank !");
					frmScorerpoints.txtUserName.focus();
				}else if(document.getElementById('password').value == ""){
					alert(" Password can not be left Blank !");
					frmScorerpoints.password.focus();
				}else{
					document.frmScorerpoints.submit();			
				}	
		}catch(err){
				alert("callSubmit"+err.description); 
		}
	}
	
	function validate() {
		if(document.getElementById("dpseason").value == "" ) {
			alert('Season Can Not Be Blank!');
			document.getElementById("dpseason").focus();
			return false;
		} else {
			document.frmScorerpoints.action = "/cims/web/jsp/SeriesMatchDetailsByOfficials.jsp";
			frmScorerpoints.submit();
		}
	}	
	
	function Adminvalidate() {		
		if(document.getElementById('chkallrole').checked){			
			document.getElementById('hdrole').value="all";
			//alert(document.getElementById('hdrole').value)
			if(document.getElementById("dpseason").value == "" ) {
				alert('Season Can Not Be Blank!');
				document.getElementById("dpseason").focus();
				return false;			
			}else if(document.getElementById("dpZone").value == "" ) {
				alert('Please Select Zone!');
				document.getElementById("dpZone").focus();
				return false;
			}else {			
				document.frmScorerpoints.action = "/cims/web/jsp/SeriesMatchDetailsByOfficials.jsp";
				frmScorerpoints.submit();
				document.getElementById("dprole").value.selected = true; 
			}			
		}else{		
			if(document.getElementById("dpseason").value == "" ) {
				alert('Season Can Not Be Blank!');
				document.getElementById("dpseason").focus();
				return false;
			}else if(document.getElementById("dprole").value == "" ) {
				alert('Please Select Role!');
				document.getElementById("dprole").focus();
				return false;
			}else if(document.getElementById("dpZone").value == "" ) {
				alert('Please Select Zone!');
				document.getElementById("dpZone").focus();
				return false;
			}else {			
				document.frmScorerpoints.action = "/cims/web/jsp/SeriesMatchDetailsByOfficials.jsp";
				frmScorerpoints.submit();
				document.getElementById("dprole").value.selected = true; 
			}
		}
	}


	/*function stChgMatchPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("ShowScorerMatchDetailsDiv"+scorer).style.display='';
			document.getElementById("ShowScorerMatchDetailsDiv"+scorer).innerHTML = responseResult;
			scorer = null;
		}
	}*/
		
	function ShowDetailDiv(scorerId,seasonId){
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{
			if(document.getElementById("ShowScorerMatchDetailsDiv"+scorerId).style.display==''){
				document.getElementById("plusImage"+scorerId).src = src="../Image/Arrow.gif";
				document.getElementById("ShowScorerMatchDetailsDiv"+scorerId).style.display='none';
				return;
			}else{
				var url;
		    	url="/cims/web/jsp/ShowMatchDetailsByOfficialsResponse.jsp?scorerId="+scorerId+"&seasonId="+seasonId;
		    	document.getElementById("plusImage"+scorerId).src = "../Image/ArrowCurve.gif";
		    	scorer = scorerId;
				//xmlHttp.onreadystatechange=stChgMatchPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("ShowScorerMatchDetailsDiv"+scorer).style.display='';
					document.getElementById("ShowScorerMatchDetailsDiv"+scorer).innerHTML = responseResult;
					scorer = null;
				}			   	
		   	}
		}
	}
	
	/***********************To Show Match Points Detail Div Using AJAX***********************/
    /*function stChgMatchPtAdminResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("ShowScorerMatchDetailsDiv"+scorer).style.display='';
			document.getElementById("ShowScorerMatchDetailsDiv"+scorer).innerHTML = responseResult;
			scorer = null;
		}
	}*/
	
	
	function ShowFullScoreCard(matchid){		
		window.open("/cims/web/jsp/FullScoreCard.jsp?matchid="+matchid,"fullscorecard",'top= 50,left = 50,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=920,height=920');
	}
	
		
	function ShowDetailByAdminDiv(scorerId,seasonId){				
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{
			if(document.getElementById("ShowScorerMatchDetailsDiv"+scorerId).style.display==''){
				document.getElementById("plusImage"+scorerId).src = src="../Image/Arrow.gif";
				document.getElementById("ShowScorerMatchDetailsDiv"+scorerId).style.display='none';
				return;
			}else{
				var url;
		    	url="/cims/web/jsp/ShowMatchDetailsByOfficialsResponse.jsp?scorerId="+scorerId+"&seasonId="+seasonId;
		    	document.getElementById("plusImage"+scorerId).src ="../Image/ArrowCurve.gif";
		    	scorer = scorerId;
				//xmlHttp.onreadystatechange=stChgMatchPtAdminResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("ShowScorerMatchDetailsDiv"+scorer).style.display='';
					document.getElementById("ShowScorerMatchDetailsDiv"+scorer).innerHTML = responseResult;
					scorer = null;
				}
		   	}
		}
	}
	
	/*function stChgMatchDetailResponse(){
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("ShowMatchDetailsDiv"+user).style.display='';
			document.getElementById("ShowMatchDetailsDiv"+user).innerHTML = responseResult;
			user = null;
		}
	}*/
	
	function ShowMatchDetailDiv(userid,seriesId){
			//alert(userid+seriesId)
			if(document.getElementById("ShowMatchDetailsDiv"+userid+seriesId).style.display==''){
				document.getElementById("ScoplusImage"+userid+seriesId).src = src="../Image/Arrow.gif";
				document.getElementById("ShowMatchDetailsDiv"+userid+seriesId).style.display='none';
				return;
			}else{				
		    	document.getElementById("ShowMatchDetailsDiv"+userid+seriesId).style.display='';
		    	document.getElementById("ScoplusImage"+userid+seriesId).src = "../Image/ArrowCurve.gif";
		    	//series = userid+seriesId;
		    	
		   	}
		}
	
	</script>      
</head>
<body  style="margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-right: 0px;" >
<form  id="frmScorerpoints" name="frmScorerpoints" method="post">
<jsp:include page="Header.jsp"></jsp:include>	
<div id = "pbar" name="pbar" class="divlist" style="left: 450px;top: 300px;" align="center">
<table style="background: transparent;">			
	<tr>
<%--		<td align="center" valign="middle" ><b><img src="../Image/loading.gif" /></b></td>--%>
<td align="center" valign="middle"><b><img src="../Image/wait24trans.gif" />&nbsp;<font color="red" size="3"> Loading ......</b></font></td>
	</tr>
</table>
</div>
<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv" >
</div>
<script>showPopup('BackgroundDiv','pbar')</script>
<div id="outerDiv" style="width: 1003px;height: 1000px;">	
	<table style="width: 1003px;">
		<tr>
			<td valign="top">
				<table width="150" border="0" >
				   <tr>
					<td valign="top"><%@ include file="commiteeinfo.jsp" %> 	    	   	 
 	    	   		</td>
				    </tr>				   							  												  												          		
				</table>
			</td>
			<td width="700" border="0" valign="top">
				<div id="FutureSeriesDiv" style="width: 650px;height: 1000px;">	
				<table width="700" border="0" >	
			   		<tr>
				 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Matches Scored by Official Users</td>
				   </tr>				
				</table>					
			<%//if(user_role.equalsIgnoreCase("9")){ %>
				<table width="650" border="0" style="border-left: none;border-top: none;border-right: none;border-bottom: none;" class="contenttable">
				<TR class="contentLight" >
					<td align="left" nowrap="nowrap"><b>Season : </b>
						<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="dpseason" id="dpseason" >
							<option>Select </option>
				<%if(crsObjSeason != null){
					while(crsObjSeason.next()){
				%>
				<%		if(crsObjSeason.getString("id").equalsIgnoreCase(seasonId)){%>
									<option value="<%=crsObjSeason.getString("id")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>
				<%		}else{%>
									<option value="<%=crsObjSeason.getString("id")%>" ><%=crsObjSeason.getString("name")%></option>
				<%		}
					}
}
%>				</select>
				<INPUT type="hidden" name="seriesId" id="seriesId" value="">
				<INPUT type="hidden" name="seasonId" id="seasonId" value="">
			</td>
			<td align="left" nowrap="nowrap"><b>User Role :</b>
				<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="dprole" id="dprole" >
					<option value="">Select </option>
<%--					<option value="1"> Captain </option>--%>
					<option value="2"> Umpire </option>
					<option value="3"> Scorer </option>
					<option value="4"> Match Referee </option>
					<option value="6"> Umpire Coach </option>
				</select>								
			<b>All Role :</b>
				<input type= "checkbox" id="chkallrole" value="All Roles" >							
			</td>
			
			<td align="left" nowrap="nowrap"><b>Zone :</b>
				
				<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="dpZone" id="dpZone" >
					<option>Select </option>
<%if(crsObjZone != null){
	while(crsObjZone.next()){
%>
<%		if(crsObjZone.getString("id").equalsIgnoreCase(zoneId)){%>
					<option value="<%=crsObjZone.getString("id")%>" selected="selected"><%=crsObjZone.getString("name")%></option>
<%		}else{%>
					<option value="<%=crsObjZone.getString("id")%>" ><%=crsObjZone.getString("name")%></option>
<%		}
	}
}
%>				</select>	
			<input type="hidden" id="hdrole" name="hdzone" value="" >	
			</td>
			
			<td align="center">
		   		<input class="button1"  type="button" align="center" class="contentDark" id="btnSubmit" name="btnSubmit" value="Get Matches" onclick="Adminvalidate();">
		   	</td>
		</TR>
		<TR>
			<td></td>
			<td>
				<DIV align="left" style="width:250px;">
				<DIV id="seriesList" name="seriesList" style="display:none;position:absolute;z-index:+5;"></DIV>
				</DIV>
			</td>
			<td></td>
			<td>
				<DIV align="left" style="width:250px">
				<DIV id="seasonList" name="seasonList" style="display:none;position:absolute;z-index:+5;"></DIV>
				</DIV>
			</td>
		</TR>
	</table>
	
	<%//}else{ %>
	<br>
	<DIV id="MatchTeamPoints" align="right" style="">
		<table width="700" border="1" align="center" cellpadding="2" cellspacing="1" class="contenttable">
	   		<tr class="commityRow" ><td colspan="10" ><b>Note: Please Click On -> To get The Match Details </b></td></tr>
	   		<tr class="commityRowAlt" >
	       		<td width="2%" align="center" >&nbsp;</td>
	       		<td width="15%" align="center" style="font-weight: bold;">Officials Name</td>
	       		<td width="15%" align="center" style="font-weight: bold;">Association</td>
	       		<td width="2%" align="center" style="font-weight: bold;" >No of Matches</td>
			</tr>

				<%if(crsObjGetMatchPt != null ){
					int counter = 1;
					while(crsObjGetMatchPt.next()){
						gsScorerId = crsObjGetMatchPt.getString("scoreruserid");
					if(counter % 2 != 0){%>
		<tr class="commityRow">
<%				}else{
%>		<tr class="commityRowAlt">
<%				}%>
						<td align="center" id="<%=counter++%>"><a onclick="ShowDetailByAdminDiv('<%=gsScorerId%>','<%=seasonId%>')"><IMG id="plusImage<%=gsScorerId%>" name="plusImage<%=gsScorerId%>" title="Click On -> To Get The Details." alt="" src="../Image/Arrow.gif" /></a></td>
						<td align="left" style="padding-left: 5px;"><%=crsObjGetMatchPt.getString("ScorerName")%></td>
						<td align="left" style="padding-left: 5px;"><%=crsObjGetMatchPt.getString("association")%></td>
						<td align="right" style="padding-right: 5px;"><%=crsObjGetMatchPt.getString("matches")%></td>
					</tr>
					<tr><td colspan="10"><div id="ShowScorerMatchDetailsDiv<%=gsScorerId%>" style="display:none" ></div></td></tr>
				<%}%>
<%				}
%>						
		</table>
	</div>
	</div>
	</td>
			<td width="100" border="0" valign="top"></td>
		</tr>
	</table>
</div>
	<table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" >
	<tr>
  		<td>						          	
    	

   	</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
	</tr>
</table>
<jsp:include page="Footer.jsp"></jsp:include>	
</form>	
<script>    	
	closePopup('BackgroundDiv','pbar');	
 </script>
</body>
</html>