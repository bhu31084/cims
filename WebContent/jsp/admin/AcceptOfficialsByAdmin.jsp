<!--
	Page Name 	 : AcceptOfficialsByAdmin.jsp
	Created By 	 : Archana Dongre.
	Created Date : 12 june  2008.
	Description  : Acceptance of match on behalf of Officials By Admin.jsp
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>

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

	try {
	
		String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy/MM/dd");
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
				"yyyy-MM-dd");
		java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
				"dd/MM/yyyy");
		Vector vparam =  new Vector();
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
		CachedRowSet  crsObjMatchData = null;
		String mId = new String();
		String team1Id = new String();
		String team2Id = new String();
		String team1name = new String();
		String team2name = new String();
		String umpire1_id = "";
		String umpire1 = "";
		String umpire2_id = "";
		String umpire2 ="";
		String umpire3_id = "";
		String umpire3 ="";
		String umpirecoach_id = "";
		String umpirecoach = "";
		String referee_id = "";
		String matchreferee = "";
		String matchDate = "";
		String matchendDate = "";
		String seriesname = "";
		String matchVenue = "";
		String scorer1 = "";
		String scorer1_id = "";
		String scorer2 = "";
		String scorer2_id = "";
		String analysis = "";
		String analysis_id = "";
		String analysis1 = "";
		String analysis1_id = "";
		
		String ump1_confirmed = "";
		String ump2_confirmed = "";
		String ump3_confirmed = "";
		String umpch_confirmed = "";
		String ref_confirmed = "";
		String scorer1_confirmed = "";
		String scorer2_confirmed = "";
		String analysis_confirmed = "";
		String analysis1_confirmed = "";

		vparam.add(matchId);//display teams
		crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure(
	       	"esp_dsp_matchidsearch",vparam,"ScoreDB");
	    vparam.removeAllElements();	    
		while(crsObjMatchData.next()){
			mId = crsObjMatchData.getString("match_id");//
			team1Id = crsObjMatchData.getString("team1_id");//
			team2Id = crsObjMatchData.getString("team2_id");//
			team1name = crsObjMatchData.getString("team_one");//
			team2name = crsObjMatchData.getString("team_two");//
			matchDate = crsObjMatchData.getString("start_ts").substring(0,11).trim();//
			matchendDate = crsObjMatchData.getString("end_ts").substring(0,11).trim();//
			matchVenue = crsObjMatchData.getString("venue_name");//
			umpire1_id = crsObjMatchData.getString("umpire1id");
			umpire1 = crsObjMatchData.getString("umpire1");
			ump1_confirmed = 	crsObjMatchData.getString("ump1_confirmed");
			umpire2_id = crsObjMatchData.getString("umpire2id");
			umpire2 = crsObjMatchData.getString("umpire2");
			ump2_confirmed = 	crsObjMatchData.getString("ump2_confirmed");
			umpire3_id = crsObjMatchData.getString("umpire3id");
			umpire3 = crsObjMatchData.getString("umpire3");
			ump3_confirmed = 	crsObjMatchData.getString("ump3_confirmed");
			umpirecoach_id = crsObjMatchData.getString("umpirecoachid");
			umpirecoach = crsObjMatchData.getString("umpirecoach");
			umpch_confirmed = 	crsObjMatchData.getString("umpch_confirmed");
			referee_id = crsObjMatchData.getString("matchrefereeid");
			matchreferee = crsObjMatchData.getString("matchreferee");
			ref_confirmed = 	crsObjMatchData.getString("ref_confirmed");
			seriesname = 	crsObjMatchData.getString("series_name");//
			scorer1_id = 	crsObjMatchData.getString("scorerid");
			scorer1 = 	crsObjMatchData.getString("scorer");
			scorer1_confirmed = 	crsObjMatchData.getString("scorer1_confirmed");
			scorer2_id = 	crsObjMatchData.getString("scorer2id");
			scorer2 = 	crsObjMatchData.getString("scorer2");
			scorer2_confirmed = crsObjMatchData.getString("scorer2_confirmed");
			analysis_id = 	crsObjMatchData.getString("analystid");
			analysis = 	crsObjMatchData.getString("analyst");
			analysis_confirmed  = crsObjMatchData.getString("analyst_confirmed");
			
			analysis1_id = 	crsObjMatchData.getString("analystid1");
			analysis1 = 	crsObjMatchData.getString("analyst1");
			analysis1_confirmed  = crsObjMatchData.getString("analyst1_confirmed");
			
			
		}
%>

<html>
<head>
<title> Match Official's Detail </title>
<link rel="stylesheet" type="text/css" href="../../css/common.css">
<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">
<link rel="stylesheet" type="text/css" href="../../css/menu.css">
<link rel="stylesheet" type="text/css" href="../../CSS/Styles.css">
<link href="../../css/form.css" rel="stylesheet" type="text/css" />
<link href="../../css/formtest.css" rel="stylesheet" type="text/css" />
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
function Approvematch(matchId,userId,status,userflag){		
	var remark = document.getElementById("txt"+userId).value	
	xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null){
		alert ("Browser does not support HTTP Request");
        return;
	}else{
       	var url ;
        url="/cims/jsp/admin/UmpireStatusResponse.jsp?matchId="+matchId+"&status="+status+"&userId="+userId+"&userflag="+userflag+"&remark="+remark;     
        if(status == "Y"){
        	document.getElementById("imgdiv"+userId).style.display='';        
        }else{
        	document.getElementById("imgRejectdiv"+userId).style.display='';   
        }
		xmlHttp.open("post",url,false);
        xmlHttp.send(null);
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("divReturnMessage").innerHTML = responseResult;
		}
	}	
}

function showDiv(userid){
		//alert(userid)
		if(document.getElementById("div"+userid).style.display == 'none'){
			document.getElementById("div"+userid).style.display = '';
		}else{
			document.getElementById("div"+userid).style.display = 'none';
			//document.getElementById("txt"+userid).value = "";
		}		
	}

function closewindow(){
	window.opener.location.reload();
	window.close();	
}	

</script>
</head>
<body>
<div class="container">
<div class="leg">Match Official's Detail</div>
<FORM name="frmrefereeAptLetter" id="frmrefereeAptLetter" method="post"><br>	
<table width="780" border="0" align="center" cellpadding="2" cellspacing="1" class="table">		
		<tr class="contentLight">			
			<td></td>
			<TD align="right" ><B>Date : <%= sdf1.format(new Date())%> </B></TD>
	</TR>		
</table>				
<table width="780" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
	<tr class="contentDark"><!--From System-->  
<td >Match Id   :-</td>
<td id="mId" ><%=mId%></td>
<td colspan="2"><input type="hidden" id="hdmid" name="hdmid" value="<%=mId%>" ></td>	
</tr>
<tr class="contentLight"><!--From System-->  
<td >Match Between :</td>
<td id="team1"><%=team1name%>&nbsp;&nbsp;&nbsp;&nbsp;vs&nbsp;&nbsp;&nbsp;&nbsp;<%=team2name%></td>
<td colspan="2"><input type="hidden" id="hdteam1" name="hdteam1" value="<%=team1name%>" >
<input type="hidden" id="hdteam2" name="hdteam2" value="<%=team2name%>"></td>	
</tr>
<tr class="contentDark"><!--From System-->  
<td >Match Date : </td>
<td id="stdate"><%=matchDate%> </td>
<td colspan="2"><input type="hidden" id="hddate" name="hddate" value="<%=matchDate%>">
<input type="hidden" id="hdenddate" name="hdenddate" value="<%=matchendDate%>"></td>	
</tr>
<tr class="contentLight"><!--From System-->  
<td >Venue : </td>
<td id="venue" ><%=matchVenue%></td>
<td colspan="2"><input type="hidden" id="hdvenue" name="hdvenue" value="<%=matchVenue%>" ></td>	
</tr>
<tr class="contentDark"><!--From System-->  
<td >Series : </td>
<td id="series"><%=seriesname%></td>
<td colspan="2"><input type="hidden" id="hdseriesname" name="hdseriesname" value="<%=seriesname%>" ></td>
<%--	dipti 20 05 2009		--%>
<%--			<td colspan="1"><input type="hidden" id="hdseriesname" name="hdseriesname" value="<%=seriesname%>" ></td>--%>
<%--			<td> <input class="contentDark" id="btnSms" name="btnSms" type="button" align="center" value="Send SMS to ALL" onclick="javascript:sendSmstoall('<%=umpire1_id+":U1"%>','<%=umpire2_id+":U2"%>','<%=referee_id+":RF"%>','<%=umpirecoach_id+":UC"%>','<%=mId%>','<%=team1name%>','<%=team2name%>','<%=matchDate%>','<%=matchVenue%>','<%=seriesname%>')"></td>	--%>
</tr>			
<tr class="contentLight"><!--From System-->
	<td >Umpire 1 :</td>	
	<%if(!umpire1_id.equalsIgnoreCase("0")){ %>
	<td id="UMP1"><%=umpire1%>&nbsp;&nbsp;
	<div id="imgdiv<%=umpire1_id%>" style="display: none;"><img src="../../images/accepted.jpg" id="img<%=umpire1_id%>"/>
	</div>
	<div id="imgRejectdiv<%=umpire1_id%>" style="display: none;"><img src="../../images/rejected.jpg" height="20" width="20" id="imgReject<%=umpire1_id%>"/>
	</div></td>
	<td nowrap="nowrap"><a id="lnk<%=umpire1_id%>" href="javascript:showDiv('<%=umpire1_id%>')">Remark</a>
	<div id="div<%=umpire1_id%>" style="display: none;"><input type="text" id="txt<%=umpire1_id%>" name="txt<%=umpire1_id%>" value="" maxlength="255"></div>
	</td>	
	<td >
	<%if(ump1_confirmed.equalsIgnoreCase("P")){%>
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpire1_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpire1_id%>','Y','3')" >		
	<%}else if(ump1_confirmed.equalsIgnoreCase("Y")){ %>
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpire1_id%>','N','3')" >		
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpire1_id%>','Y','3')" disabled="disabled">		
	<%}else{ %>
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpire1_id%>','Y','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpire1_id%>','N','3')" disabled="disabled">
	<%}%></td>		
	<%}else{%>
	<td id="UMP1" colspan="3"></td>
	<%}%>	
	<input type="hidden" id="hdumpire1" name="hdumpire1" value="<%=umpire1%>" >
	<input type="hidden" id="hdumpire1Id" name="hdumpire1Id" value="<%=umpire1_id%>" >
</tr>
<tr class="contentDark"><!--From System-->	
<td >Umpire 2 :</td>
<%if(!umpire2_id.equalsIgnoreCase("0")){%>
	<td id="UMP2" ><%=umpire2%>&nbsp;&nbsp;
	<div id="imgdiv<%=umpire2_id%>" style="display: none;"><img src="../../images/accepted.jpg" id="img<%=umpire2_id%>"/></div>
	<div id="imgRejectdiv<%=umpire2_id%>" style="display: none;"><img src="../../images/rejected.jpg" height="20" width="20" id="imgReject<%=umpire2_id%>"/>
	</div></td>
	<td nowrap="nowrap"><a id="lnk<%=umpire2_id%>" href="javascript:showDiv('<%=umpire2_id%>')">Remark</a>
	<div id="div<%=umpire2_id%>" style="display: none;"><input type="text" id="txt<%=umpire2_id%>" name="txt<%=umpire2_id%>" value="" maxlength="255"></div>
	</td>
	<td >	
	<%if(ump2_confirmed.equalsIgnoreCase("P")){%>
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpire2_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpire2_id%>','Y','3')" >		
	<%}else if(ump2_confirmed.equalsIgnoreCase("Y")){%>		
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpire2_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpire2_id%>','Y','3')" disabled="disabled">		
	<%}else{%>
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpire2_id%>','Y','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpire2_id%>','N','3')" disabled="disabled">		
	<%}%>
	</td>		
	<%}else{%>
	<td id="UMP2" colspan="3"></td>
	<%}%>
	<input type="hidden" id="hdumpire2" name="hdumpire2" value="<%=umpire2%>" >
	<input type="hidden" id="hdumpire2Id" name="hdumpire2Id" value="<%=umpire2_id%>" >	
</tr>
<tr class="contentDark"><!--From System-->	
<td >Umpire 3 :</td>
<%if(!umpire3_id.equalsIgnoreCase("0")){%>
	<td id="UMP3" ><%=umpire3%>&nbsp;&nbsp;
	<div id="imgdiv<%=umpire3_id%>" style="display: none;"><img src="../../images/accepted.jpg" id="img<%=umpire3_id%>"/></div>
	<div id="imgRejectdiv<%=umpire3_id%>" style="display: none;"><img src="../../images/rejected.jpg" height="20" width="20" id="imgReject<%=umpire3_id%>"/>
	</div></td>
	<td nowrap="nowrap"><a id="lnk<%=umpire3_id%>" href="javascript:showDiv('<%=umpire3_id%>')">Remark</a>
	<div id="div<%=umpire3_id%>" style="display: none;"><input type="text" id="txt<%=umpire3_id%>" name="txt<%=umpire3_id%>" value="" maxlength="255"></div>
	</td>
	<td >	
	<%if(ump2_confirmed.equalsIgnoreCase("P")){%>
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpire3_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpire3_id%>','Y','3')" >		
	<%}else if(ump2_confirmed.equalsIgnoreCase("Y")){%>		
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpire3_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpire3_id%>','Y','3')" disabled="disabled">		
	<%}else{%>
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpire3_id%>','Y','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpire3_id%>','N','3')" disabled="disabled">		
	<%}%>
	</td>		
	<%}else{%>
	<td id="UMP2" colspan="3"></td>
	<%}%>
	<input type="hidden" id="hdumpire3" name="hdumpire3" value="<%=umpire3%>" >
	<input type="hidden" id="hdumpire3Id" name="hdumpire3Id" value="<%=umpire3_id%>" >	
</tr>
<tr class="contentLight"><!--From System-->	
<td >Match Referee : </td>
	<%if(!referee_id.equalsIgnoreCase("0")){%>
	<td id="referee"><%=matchreferee%>&nbsp;&nbsp;<div id="imgdiv<%=referee_id%>" style="display: none;"><img src="../../images/accepted.jpg" id="img<%=referee_id%>"/></div>
	<div id="imgRejectdiv<%=referee_id%>" style="display: none;"><img src="../../images/rejected.jpg" height="20" width="20" id="imgReject<%=referee_id%>"/>
	</div></td>
	<td nowrap="nowrap"><a  id="lnk<%=referee_id%>" href="javascript:showDiv('<%=referee_id%>')">Remark</a>
	<div id="div<%=referee_id%>" style="display: none;"><input type="text" id="txt<%=referee_id%>" name="txt<%=referee_id%>" value="" maxlength="255"></div>
	</td>
	<td >
	<%
	if(ref_confirmed.equalsIgnoreCase("P")){%>
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=referee_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=referee_id%>','Y','3')" >		
	<%}else if(ref_confirmed.equalsIgnoreCase("Y")){%>		
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=referee_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=referee_id%>','Y','3')" disabled="disabled">		
	<%}else{%>
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=referee_id%>','Y','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=referee_id%>','N','3')" disabled="disabled">		
	<%}%></td>	
	<%}else{%>
	<td id="referee" colspan="3"></td>
	<%}%>	
	<input type="hidden" id="hdmatchreferee" name="hdmatchreferee" value="<%=matchreferee%>" >
	<input type="hidden" id="hdmatchreferee_id" name="hdmatchreferee_id" value="<%=referee_id%>" >	
</tr>
<tr class="contentDark"><!--From System-->
<td >Umpire Coach : </td>
	<%if(!umpirecoach_id.equalsIgnoreCase("0")){%>
	<td id="coach"><%=umpirecoach%>&nbsp;&nbsp;
	<div id="imgdiv<%=umpirecoach_id%>" style="display: none;"><img src="../../images/accepted.jpg" id="img<%=umpirecoach_id%>"/></div>
	<div id="imgRejectdiv<%=umpirecoach_id%>" style="display: none;"><img src="../../images/rejected.jpg" height="20" width="20" id="imgReject<%=umpirecoach_id%>"/>
	</div></td>
	<td nowrap="nowrap"><a  id="lnk<%=umpirecoach_id%>" href="javascript:showDiv('<%=umpirecoach_id%>')">Remark</a>
	<div id="div<%=umpirecoach_id%>" style="display: none;"><input type="text" id="txt<%=umpirecoach_id%>" name="txt<%=umpirecoach_id%>" value="" maxlength="255"></div>
	</td>
	<td >
		<%
		if(umpch_confirmed.equalsIgnoreCase("P")){%>
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpirecoach_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpirecoach_id%>','Y','3')" >		
	<%}else if(umpch_confirmed.equalsIgnoreCase("Y")){%>		
			<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpirecoach_id%>','N','3')" >
			<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpirecoach_id%>','Y','3')" disabled="disabled">
		<%}else{%>
			<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=umpirecoach_id%>','Y','3')" >		
			<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=umpirecoach_id%>','N','3')" disabled="disabled" >
		<%}%>
	</td>	
	<%}else{%>	
	<td id="coach" colspan="3"></td>
	<%}%>
	<input type="hidden" id="hdumpirecoach" name="hdumpirecoach" value="<%=umpirecoach%>" >
	<input type="hidden" id="hdumpirecoach_id" name="hdumpirecoach_id" value="<%=umpirecoach_id%>" >
</tr>
<tr class="contentLight"><!--From System-->
<td >Scorer 1 : </td>
	<%if(!scorer1_id.equalsIgnoreCase("0")){%>
	<td id="scorer1" nowrap="nowrap"><%=scorer1%>&nbsp;&nbsp;
	<div id="imgdiv<%=scorer1_id%>" style="display: none;"><img src="../../images/accepted.jpg" id="img<%=scorer1_id%>"/></div>
	<div id="imgRejectdiv<%=scorer1_id%>" style="display: none;"><img src="../../images/rejected.jpg" height="20" width="20" id="imgReject<%=scorer1_id%>"/>
	</div></td>
	<td nowrap="nowrap"><a  id="lnk<%=scorer1_id%>" href="javascript:showDiv('<%=scorer1_id%>')">Remark</a>
	<div id="div<%=scorer1_id%>" style="display: none;"><input type="text" id="txt<%=scorer1_id%>" name="txt<%=scorer1_id%>" value="" maxlength="255"></div>
	</td>
	<td >
	<%
	if(scorer1_confirmed.equalsIgnoreCase("P")){%>
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=scorer1_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=scorer1_id%>','Y','3')" >
	<%}else if(scorer1_confirmed.equalsIgnoreCase("Y")){%>		
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=scorer1_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=scorer1_id%>','Y','3')" disabled="disabled">
	<%}else{%>
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=scorer1_id%>','Y','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=scorer1_id%>','N','3')" disabled="disabled">
	<%}%></td>
	<%}else{%>
	<td id="scorer1" colspan="3"></td>
	<%}%>	
	<input type="hidden" id="hdscorer1" name="hdscorer1" value="<%=scorer1%>">
	<input type="hidden" id="hdscorer1_id" name="hdscorer1_id" value="<%=scorer1_id%>">
</tr>
<tr class="contentDark"><!--From System-->
<td >Scorer 2 : </td>
	<%if(!scorer2_id.equalsIgnoreCase("0")){%>
	<td id="scorer2"><%=scorer2%>&nbsp;&nbsp;<div id="imgdiv<%=scorer2_id%>" style="display: none;"><img src="../../images/accepted.jpg" id="img<%=scorer2_id%>"/></div>
	<div id="imgRejectdiv<%=scorer2_id%>" style="display: none;"><img src="../../images/rejected.jpg" height="20" width="20" id="imgReject<%=scorer2_id%>"/>
	</div></td>
	<td nowrap="nowrap"><a  id="lnk<%=scorer2_id%>" href="javascript:showDiv('<%=scorer2_id%>')">Remark</a>
	<div id="div<%=scorer2_id%>" style="display: none;"><input type="text" id="txt<%=scorer2_id%>" name="txt<%=scorer2_id%>" value="" maxlength="255"></div>
	</td>
	<td >
	<%
	if(scorer2_confirmed.equalsIgnoreCase("P")){%>
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=scorer2_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=scorer2_id%>','Y','3')" >		
	<%}else if(scorer2_confirmed.equalsIgnoreCase("Y")){%>		
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=scorer2_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=scorer2_id%>','Y','3')" disabled="disabled">
	<%}else{%>
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=scorer2_id%>','Y','3')" >		
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=scorer2_id%>','N','3')" disabled="disabled" >
	<%}%></td>
	<%}else{%>
	<td id="scorer2" colspan="3"></td>
	<%}%>	
	<input type="hidden" id="hdscorer2" name="hdscorer2" value="<%=scorer2%>">
	<input type="hidden" id="hdscorer2_id" name="hdscorer2_id" value="<%=scorer2_id%>">	
</tr>






<tr class="contentDark"><!--From System-->
<td >Main Analyst : </td>
	<%if(!analysis_id.equalsIgnoreCase("0")){%>
	<td id="analysis"><%=analysis%>&nbsp;&nbsp;<div id="imgdiv<%=analysis_id%>" style="display: none;"><img src="../../images/accepted.jpg" id="img<%=analysis_id%>"/></div>
	<div id="imgRejectdiv<%=analysis_id%>" style="display: none;"><img src="../../images/rejected.jpg" height="20" width="20" id="imgReject<%=analysis_id%>"/>
	</div></td>
	<td nowrap="nowrap"><a  id="lnk<%=analysis_id%>" href="javascript:showDiv('<%=analysis_id%>')">Remark</a>
	<div id="div<%=analysis_id%>" style="display: none;"><input type="text" id="txt<%=analysis_id%>" name="txt<%=analysis_id%>" value="" maxlength="255"></div>
	</td>
	<td >
	<%
	if(analysis_confirmed.equalsIgnoreCase("P")){%>
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=analysis_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=analysis_id%>','Y','3')" >		
	<%}else if(analysis_confirmed.equalsIgnoreCase("Y")){%>		
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=analysis_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=analysis_id%>','Y','3')" disabled="disabled">
	<%}else{%>
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=analysis_id%>','Y','3')" >		
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=analysis_id%>','N','3')" disabled="disabled" >
	<%}%></td>

	<%}else{%>
	<td id="analysis" colspan="3"></td>
	<%}%>	
	<input type="hidden" id="hdanalysis" name="hdanalysis" value="<%=analysis%>">
	<input type="hidden" id="hdanalysis_id" name="hdanalysis_id" value="<%=analysis_id%>">	
</tr>






<tr class="contentDark"><!--From System-->
<td >Asst Analyst : </td>
	<%if(!analysis1_id.equalsIgnoreCase("0")){%>
	<td id="analysis1"><%=analysis1%>&nbsp;&nbsp;<div id="imgdiv<%=analysis1_id%>" style="display: none;"><img src="../../images/accepted.jpg" id="img<%=analysis1_id%>"/></div>
	<div id="imgRejectdiv<%=analysis1_id%>" style="display: none;"><img src="../../images/rejected.jpg" height="20" width="20" id="imgReject<%=analysis1_id%>"/>
	</div></td>
	<td nowrap="nowrap"><a id="lnk<%=analysis1_id%>" href="javascript:showDiv('<%=analysis1_id%>')">Remark</a>
	<div id="div<%=analysis1_id%>" style="display: none;"><input type="text" id="txt<%=analysis1_id%>" name="txt<%=analysis1_id%>" value="" maxlength="255"></div>
	</td>
	<td >
	<%
	if(analysis1_confirmed.equalsIgnoreCase("P")){%>
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=analysis1_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=analysis1_id%>','Y','3')" >		
	<%}else if(analysis1_confirmed.equalsIgnoreCase("Y")){%>		
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=analysis1_id%>','N','3')" >
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=analysis1_id%>','Y','3')" disabled="disabled">
	<%}else{%>
		<input class="btn btn-warning" type="button" align="center" value="Accept" onclick="javascript:Approvematch('<%=mId%>','<%=analysis1_id%>','Y','3')" >		
		<input class="btn btn-warning" type="button" align="center" value="Reject" onclick="javascript:Approvematch('<%=mId%>','<%=analysis1_id%>','N','3')" disabled="disabled" >
	<%}%></td>

	<%}else{%>
	<td id="analysis1" colspan="3"></td>
	<%}%>	
	<input type="hidden" id="hdanalysis1" name="hdanalysis1" value="<%=analysis1%>">
	<input type="hidden" id="hdanalysis1_id" name="hdanalysis1_id" value="<%=analysis1_id%>">	
</tr>




	</table>
	<table width="780" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td align="center"><div id="divReturnMessage" style="display: none; color: blue;font-size: 27" align="center" ></div>	 
			</td>
		</tr>
		<tr>
			<td align="center">
				<input type="button" name="btnback" id="btnback" value="Close" class="btn btn-warning" onclick="closewindow()">
			</td>
		</tr>
	</table>
	</FORM>
</div>
</body>
<% } catch (Exception e) {
	System.out.println(" Exception"+e);
    e.printStackTrace();
}
%>    
</html> 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   