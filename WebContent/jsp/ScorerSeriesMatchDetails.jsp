<!--
	Page Name	 : ScorerSeriesMatchDetails.jsp
	Author 		 : Archana Dongre
	Created Date : 10/12/2008
	Description  : Display match details of scorer.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%
	String match_id = session.getAttribute("matchid").toString();
	String user_id =session.getAttribute("userid").toString();
	String loginUserId = session.getAttribute("usernamesurname").toString();
	String user_role = session.getAttribute("role").toString();
	System.out.println("user_id "+ user_id + " loginUserId " + loginUserId);
	System.out.println("user_role "+ user_role );
	
	LogWriter log = new LogWriter();
	
	CachedRowSet crsObjGetMatchPt = null;
	CachedRowSet  crsObjTournamentNm = null;	
	CachedRowSet crsObjSeason   = null;
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(match_id);
	Vector vparam = new Vector();
	Common common = new Common();
	String series_name = "";
	String season_name = "";
	String flag = "1";
	String seasonId = "";
	String pageNo = "";
	String gsScorerId = "";
%>
<%
	try{
		vparam.add("0");//display all series name.
		crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");
		vparam.removeAllElements();
	}catch(Exception e){
		System.out.println("*************ScorerSeriesMatchDetails.jsp*****************"+e);
		log.writeErrLog(page.getClass(),match_id,e.toString());
	}

	if (request.getMethod().equalsIgnoreCase("POST")) {
		if(request.getParameter("dpseason") != null && !request.getParameter("dpseason").equals("")) {
			seasonId = request.getParameter("dpseason");
			System.out.println("seasonId ");
			vparam.removeAllElements();
			vparam.add(seasonId);
			vparam.add(user_id);
			vparam.add(flag);
			try {
				crsObjGetMatchPt = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_scorermatches", vparam, "ScoreDB");
				vparam.removeAllElements();
			} catch (Exception e) {
				System.out.println("*************ScorerSeriesMatchDetails.jsp*****************"+e);
				log.writeErrLog(page.getClass(),match_id,e.toString());
			}
		}
	}
%>
<html>
<head>
<title>Match Points Table</title>
    <script language="JavaScript" src="../js/tabber.js" type="text/javascript"></script>
    <script language="JavaScript" src="../js/sortable.js" type="text/javascript"></script>
    <script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="../css/tabexample.css"> 
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/csms1.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
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
		
	function validate() {
		if(document.getElementById("dpseason").value == "" ) {
			alert('Season Can Not Be Blank!');
			document.getElementById("dpseason").focus();
			return false;
		} else {
			document.frmScorerpoints.action = "ScorerSeriesMatchDetails.jsp";
			frmScorerpoints.submit();
		}
	}

	/***********************To Show Match Points Detail Div Using AJAX***********************/
    function stChgMatchPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("ShowScorerMatchDetailsDiv"+scorer).style.display='';
			document.getElementById("ShowScorerMatchDetailsDiv"+scorer).innerHTML = responseResult;
			scorer = null;
		}
	}
		
	function ShowDetailDiv(scorerId,seasonId){
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{
			if(document.getElementById("ShowScorerMatchDetailsDiv"+scorerId).style.display==''){
				document.getElementById("plusImage"+scorerId).src = "../images/plusdiv.jpg";
				document.getElementById("ShowScorerMatchDetailsDiv"+scorerId).style.display='none';
				return;
			}else{
				var url;
		    	url="ShowScorerMatchDetailResponse.jsp?scorerId="+scorerId+"&seasonId="+seasonId;
		    	document.getElementById("plusImage"+scorerId).src = "../images/minus.jpg";
		    	scorer = scorerId;
				xmlHttp.onreadystatechange=stChgMatchPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
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
				document.getElementById("ScoplusImage"+userid+seriesId).src = "../images/plusdiv.jpg";
				document.getElementById("ShowMatchDetailsDiv"+userid+seriesId).style.display='none';
				return;
			}else{				
		    	document.getElementById("ShowMatchDetailsDiv"+userid+seriesId).style.display='';
		    	document.getElementById("ScoplusImage"+userid+seriesId).src = "../images/minus.jpg";
		    	//series = userid+seriesId;
		    	
		   	}
		}
	
	</script>      
</head>
<body  style="background-color: white">
<jsp:include page="Menu.jsp"></jsp:include>
<form  id="frmScorerpoints" name="frmScorerpoints" method="post">

	<table width="870" border="0" align="center">
				<tr>
					<td width="100%" colspan="3" align="center" class="legend">Matches Scored by Scorer</td>
				</tr>
			</table>
	<table width="700"  align="center"  class="table">
		<TR class="contentLight" >
			<TH align="left"><b>Season :</b></TH>
			<td colspan="1">
				<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="dpseason" id="dpseason" onchange="validate();">
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
	<br>

	<DIV id="MatchTeamPoints" align="right" style="">
		<table width="870" border="1" align="center" cellpadding="2" cellspacing="1" class="table">
	   		<tr class="contentDark" ><td colspan="10" ><b>Note: Please Click On + To get The Match Details </b></td></tr>
	   		<tr class="contentLight" >
	       		<td width="2%" align="center" >&nbsp;</td>
	       		<td width="15%" align="center" class="headinguser">Scorer Name</td>
	       		<td width="2%" align="center" class="headinguser" >No of Matches</td>
			</tr>

				<%if(crsObjGetMatchPt != null ){
					int counter = 1;
					while(crsObjGetMatchPt.next()){
						gsScorerId = crsObjGetMatchPt.getString("scoreruserid");						
					if(counter % 2 != 0){%>
		<tr class="contentDark">
<%				}else{
%>		<tr class="contentLight">
<%				}%>
						<td align="center" id="<%=counter++%>"><a onclick="ShowDetailDiv('<%=gsScorerId%>','<%=seasonId%>')"><IMG id="plusImage<%=gsScorerId%>" name="plusImage<%=gsScorerId%>" title="Click On + To Get The Details." alt="" src="../images/plusdiv.jpg" /></a></td>
						<td align="left"><%=crsObjGetMatchPt.getString("ScorerName")%></td>
						<td align="right"><%=crsObjGetMatchPt.getString("matches")%></td>
					</tr>
					<tr><td colspan="10"><div id="ShowScorerMatchDetailsDiv<%=gsScorerId%>" style="display:none" ></div></td></tr>
				<%}%>
<%				}
%>						
		</table>
	</div>	
</form>
</body>
</html>