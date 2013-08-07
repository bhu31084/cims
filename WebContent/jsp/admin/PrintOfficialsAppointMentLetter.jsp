<!--
	Page Name 	 : PrintOfficialsAppointMentLetter.jsp
	Created By 	 : Archana Dongre.
	Created Date : 4th Nov 2008.
	Description  : Print Officials Appointment Letters
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
		String team1nickname = new String();
		String team2nickname = new String();
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
		String pre_date = "";
		String clubname ="";
		String email = "";
		String matchtypeflag = null;

		vparam.add(matchId);//display teams
		crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_modifymatch",vparam,"ScoreDB");
	    vparam.removeAllElements();
		while(crsObjMatchData.next()){
			mId = crsObjMatchData.getString("match_id");
			team1nickname = crsObjMatchData.getString("team_one_nickname");
			team2nickname = crsObjMatchData.getString("team_two_nickname");
			team1name = crsObjMatchData.getString("team_one");
			team2name = crsObjMatchData.getString("team_two");
			pre_date = crsObjMatchData.getString("pre_date").substring(0,12).trim();			
			matchDate = crsObjMatchData.getString("from_date").substring(0,12).trim();
			matchendDate = crsObjMatchData.getString("to_date").substring(0,12).trim();
			clubname = crsObjMatchData.getString("club_name");
			//email = crsObjMatchData.getString("email");
			matchVenue = crsObjMatchData.getString("venue_name");
			if(crsObjMatchData.getString("venue_name") == null || crsObjMatchData.getString("venue_name") == ""){
				matchVenue = "----";
			}else{				
				matchVenue = crsObjMatchData.getString("venue_name");
			}
			
			umpire1_id = crsObjMatchData.getString("umpire1_id");
			umpire1 = crsObjMatchData.getString("umpire1");
			umpire2_id = crsObjMatchData.getString("umpire2_id");
			umpire2 = crsObjMatchData.getString("umpire2");
			umpire3_id = crsObjMatchData.getString("umpire3_id");
			umpire3 = crsObjMatchData.getString("umpire3");
			umpirecoach_id = crsObjMatchData.getString("umpirecoach_id");
			umpirecoach = crsObjMatchData.getString("umpirecoach");
			referee_id = crsObjMatchData.getString("referee_id");
			matchreferee = crsObjMatchData.getString("matchreferee");
			seriesname = 	crsObjMatchData.getString("series_name");
			scorer1_id = 	crsObjMatchData.getString("scorer_id");
			scorer1 = 	crsObjMatchData.getString("scorer");
			scorer2_id = 	crsObjMatchData.getString("scorer2_id");
			scorer2 = 	crsObjMatchData.getString("scorer2");
			matchtypeflag = crsObjMatchData.getString("matchtypeflag");
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
	function printLetters(flag){
    	var matchId = document.getElementById('hdmid').value;
    	var matchpre_date = document.getElementById('hdpre_date').value;
		var matchdate = document.getElementById('hddate').value;
		var matchenddate = document.getElementById('hdenddate').value;
		var team1nickname = document.getElementById('hdteam1nck').value;
		var team2nickname = document.getElementById('hdteam2nck').value;
		var team1 = document.getElementById('hdteam1').value;
		var team2 = document.getElementById('hdteam2').value;		  
		var venue = document.getElementById('hdvenue').value;
		var clubname = document.getElementById('hdvenueclubname').value;
		var ump1_id = document.getElementById('hdumpire1Id').value;
		var ump2_id = document.getElementById('hdumpire2Id').value;
		var ump3_id = document.getElementById('hdumpire3Id').value;
		var referee_id = document.getElementById('hdmatchreferee_id').value;
		var umpcoach_id = document.getElementById('hdumpirecoach_id').value;
		var ump1 = document.getElementById('hdumpire1').value;
		var ump2 = document.getElementById('hdumpire2').value;
		var ump3 = document.getElementById('hdumpire3').value;
		var referee = document.getElementById('hdmatchreferee').value;
		var umpcoach = document.getElementById('hdumpirecoach').value;
		var seriesname = document.getElementById('hdseriesname').value;
		var matchtypeflag = document.getElementById('hdmatchtypeflag').value;
		var email = document.getElementById('hdemail').value;

   		if((flag == "1") && (document.getElementById('UMP1').innerHTML != "")){
			winhandle = window.open("/cims/jsp/admin/UmpireAppointmentLetter.jsp?seriesname="+seriesname+
			"&matchtypeflag="+matchtypeflag+
			"&clubname="+clubname+
			"&email="+email+
			"&matchId="+matchId+
			"&ump1_id="+ump1_id+
			"&ump1="+ump1+
			"&ump2_id="+ump2_id+
			"&ump2="+ump2+
			"&ump3_id="+ump3_id+
			"&ump3="+ump3+
			"&team1="+team1+
			"&team2="+team2+
			"&venue="+venue+
			"&matchpre_date="+matchpre_date+
			"&matchdate="+matchdate+
			"&matchenddate="+matchenddate+
			"&team1nickname="+team1nickname+
			"&team2nickname="+team2nickname,"battingreport","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-40)+",height="+(window.screen.availHeight-20));
		}else if((flag == "u1")&&(document.getElementById('UMP2').innerHTML != "")){
			winhandle = window.open("/cims/jsp/admin/UmpireAppointmentLetter.jsp?seriesname="+seriesname+"&matchtypeflag="+matchtypeflag+"&clubname="+clubname+"&email="+email+"&matchId="+matchId+"&ump1_id="+ump1_id+"&ump1="+ump1+"&ump2_id="+ump2_id+"&ump2="+ump2+"&ump3_id="+ump3_id+"&ump3="+ump3+"&team1="+team1+"&team2="+team2+"&venue="+venue+"&matchpre_date="+matchpre_date+"&flg="+flag+"&matchdate="+matchdate+"&matchenddate="+matchenddate+"&team1nickname="+team1nickname+"&team2nickname="+team2nickname,"battingreport","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-40)+",height="+(window.screen.availHeight-20));
		}else if((flag == "u3")&&(document.getElementById('UMP3').innerHTML != "")){
			winhandle = window.open("/cims/jsp/admin/UmpireAppointmentLetter.jsp?seriesname="+seriesname+"&matchtypeflag="+matchtypeflag+"&clubname="+clubname+"&email="+email+"&matchId="+matchId+"&ump1_id="+ump1_id+"&ump1="+ump1+"&ump2_id="+ump2_id+"&ump2="+ump2+"&ump3_id="+ump3_id+"&ump3="+ump3+"&team1="+team1+"&team2="+team2+"&venue="+venue+"&matchpre_date="+matchpre_date+"&flg="+flag+"&matchdate="+matchdate+"&matchenddate="+matchenddate+"&team1nickname="+team1nickname+"&team2nickname="+team2nickname,"battingreport","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-40)+",height="+(window.screen.availHeight-20));
		}else if((flag == "2")&&(document.getElementById('referee').innerHTML != "")){
			winhandle = window.open("/cims/jsp/admin/RefereeAppointMentLetter.jsp?seriesname="+seriesname+"&matchtypeflag="+matchtypeflag+"&clubname="+clubname+"&email="+email+"&matchId="+matchId+"&referee_id="+referee_id+"&referee="+referee+"&matchdate="+matchdate+"&matchenddate="+matchenddate+"&team1="+team1+"&team2="+team2+"&venue="+venue+"&matchpre_date="+matchpre_date+"&team1nickname="+team1nickname+"&team2nickname="+team2nickname,"battingreport","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-40)+",height="+(window.screen.availHeight-20));
		}else if((flag == "3")&&(document.getElementById('coach').innerHTML != "")){
	    	winhandle = window.open("/cims/jsp/admin/UmpireCoachAppointMentLetter.jsp?seriesname="+seriesname+"&matchtypeflag="+matchtypeflag+"&clubname="+clubname+"&email="+email+"&matchId="+matchId+"&umpcoach_id="+umpcoach_id+"&umpcoach="+umpcoach+"&matchdate="+matchdate+"&matchenddate="+matchenddate+"&team1="+team1+"&team2="+team2+"&venue="+venue+"&matchpre_date="+matchpre_date+"&team1nickname="+team1nickname+"&team2nickname="+team2nickname,"battingreport","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-40)+",height="+(window.screen.availHeight-20));
	    }else{
	    	alert("Data Not Available");
	    }
    }
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

    function sendEmailToAllOffical(){
    	var r = confirm("Do you want to send email to all official ?");
		if (r == true){	    	
	    		xmlHttp=GetXmlHttpObject();
	    		if (xmlHttp==null){
					alert ("Browser does not support HTTP Request");
	                return;
				}else{					
					var url ;					             
					var matchId = document.getElementById('hdmid').value;
			    	var matchpre_date = document.getElementById('hdpre_date').value;
					var matchdate = document.getElementById('hddate').value;
					var matchenddate = document.getElementById('hdenddate').value;
					var team1nickname = document.getElementById('hdteam1nck').value;
					var team2nickname = document.getElementById('hdteam2nck').value;
					var team1 = document.getElementById('hdteam1').value;
					var team2 = document.getElementById('hdteam2').value;		  
					var venue = document.getElementById('hdvenue').value;
					var clubname = document.getElementById('hdvenueclubname').value;
					var ump1_id = document.getElementById('hdumpire1Id').value;
					var ump2_id = document.getElementById('hdumpire2Id').value;
					var ump3_id = document.getElementById('hdumpire3Id').value;
					var referee_id = document.getElementById('hdmatchreferee_id').value;
					var umpcoach_id = document.getElementById('hdumpirecoach_id').value;
					var ump1 = document.getElementById('hdumpire1').value;
					var email = document.getElementById('hdemail').value;
					var ump2 = document.getElementById('hdumpire2').value;
					var ump3 = document.getElementById('hdumpire3').value;
					var referee = document.getElementById('hdmatchreferee').value;
					var umpcoach = document.getElementById('hdumpirecoach').value;
					var seriesname = document.getElementById('hdseriesname').value;
					var matchtypeflag = document.getElementById('hdmatchtypeflag').value;
					
					var appendUrl = "seriesname="+seriesname+
					"&matchtypeflag="+matchtypeflag+
					"&clubname="+clubname+
					"&matchId="+matchId+
					"&ump1_id="+ump1_id+
					"&ump1="+ump1+
					"&ump2_id="+ump2_id+
					"&ump2="+ump2+
					"&ump3_id="+ump3_id+
					"&ump3="+ump3+
					"&team1="+team1+
					"&team2="+team2+
					"&venue="+venue+
					"&email="+email+
					"&matchpre_date="+matchpre_date+
					"&matchdate="+matchdate+
					"&matchenddate="+matchenddate+
					"&team1nickname="+team1nickname+
					"&team2nickname="+team2nickname+
					"&referee_id="+referee_id+
					"&referee="+referee+
					"&umpcoach_id="+umpcoach_id+
					"&umpcoach="+umpcoach;

	                url="/cims/AjaxSendEmail?"+appendUrl;	               
				    xmlHttp.open("GET",url,false);				
	               	xmlHttp.send(null);
	               	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
						var responseResult= xmlHttp.responseText;
					}
				}    		
	    	
	    }else{
	    	return false;
	    }	      	
    }
    
    function previousPage(){
    	window.close();
    }
    
    function sendSms(receiverId,matchId,team1,team2,matchdate,venue,seriesname,userrole){    	
    	window.open("/cims/jsp/sms/SMSPush.jsp?receiverId="+receiverId+"&seriesname="+seriesname+"&matchId="+matchId+"&matchdate="+matchdate+"&team1="+team1+"&team2="+team2+"&venue="+venue+"&userrole="+userrole+"&flag=1","sendsms","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=250,left=250,width="+(window.screen.availWidth-400)+",height="+(window.screen.availHeight-400));
    }
    
    function sendSmstoall(ump1Id,ump2Id,ump3Id,refId,umpCoachId,matchId,team1,team2,matchdate,venue,seriesname){
		window.open("/cims/jsp/sms/SMSPushAll.jsp?ump1Id="+ump1Id+"&ump2Id="+ump2Id+"&ump3Id="+ump3Id+"&refId="+refId+"&umpCoachId="+umpCoachId+"&seriesname="+seriesname+"&matchId="+matchId+"&matchdate="+matchdate+"&team1="+team1+"&team2="+team2+"&venue="+venue,"sendsms","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=250,left=450,width="+(window.screen.availWidth-600)+",height="+(window.screen.availHeight-500));
    }
</script>
</head>
<body>
<br>
<FORM name="frmrefereeAptLetter" id="frmrefereeAptLetter" method="post"><br>	
	<table width="780" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td colspan="9" bgcolor="#FFFFFF" class="legend">
				Match Official's Detail
			</td>
		</tr>
	</table>
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
			<td colspan="2">
			<input type="hidden" id="hdteam1nck" name="hdteam1nck" value="<%=team1nickname%>" >
			<input type="hidden" id="hdteam2nck" name="hdteam2nck" value="<%=team2nickname%>">
			<input type="hidden" id="hdteam1" name="hdteam1" value="<%=team1name%>" >
			<input type="hidden" id="hdteam2" name="hdteam2" value="<%=team2name%>"></td>	
		</tr>
		<tr class="contentDark"><!--From System-->  
			<td >Match Date : </td>
			<td id="stdate"><%=matchDate%> </td>
			<td colspan="2">
			<input type="hidden" id="hdpre_date" name="hdpre_date" value="<%=pre_date%>">
			<input type="hidden" id="hddate" name="hddate" value="<%=matchDate%>">
			<input type="hidden" id="hdenddate" name="hdenddate" value="<%=matchendDate%>"></td>	
		</tr>
		<tr class="contentLight"><!--From System-->  
			<td >Venue : </td>
			<td id="venue" ><%=matchVenue%></td>
			<td colspan="2">
			<input type="hidden" id="hdvenue" name="hdvenue" value="<%=matchVenue%>" >
			<input type="hidden" id="hdvenueclubname" name="hdvenueclubname" value="<%=clubname%>" >
			<input type="hidden" id="hdemail" name="hdemail" value="<%=email%>" >
			</td>	
		</tr>
		<tr class="contentDark"><!--From System-->  
			<td >Series : </td>
			<td id="series"><%=seriesname%></td>
			<td><input type="hidden" id="hdseriesname" name="hdseriesname" value="<%=seriesname%>" ></td>
			<td colspan="1"><input class="contentDark" type="button" align="center" value="Send Email And SMS To All" onclick="javascript:sendEmailToAllOffical();sendSmstoall('<%=umpire1_id+":U1"%>','<%=umpire2_id+":U2"%>','<%=umpire3_id+":U3"%>','<%=referee_id+":RF"%>','<%=umpirecoach_id+":UC"%>','<%=mId%>','<%=team1name%>','<%=team2name%>','<%=matchDate%>','<%=matchVenue%>','<%=seriesname%>');"></td>
<%--	dipti 20 05 2009		--%>
<%--			<td colspan="1"><input type="hidden" id="hdseriesname" name="hdseriesname" value="<%=seriesname%>" ></td>--%>
<%--			<td> <input class="contentDark" id="btnSms" name="btnSms" type="button" align="center" value="Send SMS to ALL" onclick="javascript:sendSmstoall('<%=umpire1_id+":U1"%>','<%=umpire2_id+":U2"%>','<%=referee_id+":RF"%>','<%=umpirecoach_id+":UC"%>','<%=mId%>','<%=team1name%>','<%=team2name%>','<%=matchDate%>','<%=matchVenue%>','<%=seriesname%>')"></td>	--%>
		</tr>			
		<tr class="contentLight"><!--From System-->
		 	<td >Umpire 1 :</td>
		 	<%if(umpire1 != null){%>
	 			<td id="UMP1"><%=umpire1%></td>
		 	<%}else{%>
 				<td id="UMP1"></td>
 			<%}%>
 			<td ><input class="contentDark" type="button" align="center" value="Print Preview" onclick="javascript:printLetters('1')">
 			<input type="hidden" id="hdumpire1" name="hdumpire1" value="<%=umpire1%>" >
			<input type="hidden" id="hdumpire1Id" name="hdumpire1Id" value="<%=umpire1_id%>" ></td>	
			<%if(umpire1 != null){%>
			<td><input class="contentDark" id="btnSms" name="btnSms" type="button" align="center" value="Send SMS" onclick="javascript:sendSms('<%=umpire1_id%>','<%=mId%>','<%=team1name%>','<%=team2name%>','<%=matchDate%>','<%=matchVenue%>','<%=seriesname%>','umpire1')"></td>	
			<%}else{%>
		 	<td>&nbsp;</td>
		 	<%}%>			
		</tr>
		<tr class="contentDark"><!--From System-->	
			<td >Umpire 2 :</td>
			<%if(umpire2 != null){%>
		 		<td id="UMP2" ><%=umpire2%></td>
		 	<%}else{%>
		 		<td id="UMP2"></td>
		 	<%}%>
		 	<td ><input class="contentDark" type="button" align="center" value="Print Preview" onclick="javascript:printLetters('u1')">
		 	<input type="hidden" id="hdumpire2" name="hdumpire2" value="<%=umpire2%>" >
		 	<input type="hidden" id="hdumpire2Id" name="hdumpire2Id" value="<%=umpire2_id%>" >
		 	</td>
		 	<%if(umpire2 != null){%>
		 	<td><input class="contentDark" id="btnSms" name="btnSms" type="button" align="center" value="Send SMS" onclick="javascript:sendSms('<%=umpire2_id%>','<%=mId%>','<%=team1name%>','<%=team2name%>','<%=matchDate%>','<%=matchVenue%>','<%=seriesname%>','umpire2')"></td>		
		 	<%}else{%>
		 	<td>&nbsp;</td>
		 	<%}%>
		</tr>
		<tr class="contentDark"><!--From System-->	
			<td >Umpire 3 :</td>
			<%if(umpire3 != null){%>
		 		<td id="UMP3" ><%=umpire3%></td>
		 	<%}else{%>
		 		<td id="UMP3"></td>
		 	<%}%>
		 	<td ><input class="contentDark" type="button" align="center" value="Print Preview" onclick="javascript:printLetters('u3')">
		 	<input type="hidden" id="hdumpire3" name="hdumpire3" value="<%=umpire3%>" >
		 	<input type="hidden" id="hdumpire3Id" name="hdumpire3Id" value="<%=umpire3_id%>" >
		 	</td>
		 	<%if(umpire2 != null){%>
		 		<td><input class="contentDark" id="btnSms" name="btnSms" type="button" align="center" value="Send SMS" onclick="javascript:sendSms('<%=umpire3_id%>','<%=mId%>','<%=team1name%>','<%=team2name%>','<%=matchDate%>','<%=matchVenue%>','<%=seriesname%>','umpire3')"></td>		
		 	<%}else{%>
		 		<td>&nbsp;</td>
		 	<%}%>
		</tr>
		<tr class="contentLight"><!--From System-->	
			<td >Match Referee : </td>
		 	<%if(matchreferee != null){%>
		 	<td id="referee"><%=matchreferee%></td>
		 	<%}else{%>
		 	<td id="referee"></td>
		 	<%}%>
		 	<td ><input class="contentDark" type="button" align="center" value="Print Preview" onclick="javascript:printLetters('2')">
		 	<input type="hidden" id="hdmatchreferee" name="hdmatchreferee" value="<%=matchreferee%>" >
		 	<input type="hidden" id="hdmatchreferee_id" name="hdmatchreferee_id" value="<%=referee_id%>" ></td>	
		 	<%if(matchreferee != null){%>
		 	<td><input class="contentDark" id="btnSms" name="btnSms" type="button" align="center" value="Send SMS" onclick="javascript:sendSms('<%=referee_id%>','<%=mId%>','<%=team1name%>','<%=team2name%>','<%=matchDate%>','<%=matchVenue%>','<%=seriesname%>','referee')"></td>	
		    <%}else{%>
		 	<td>&nbsp;</td>
		 	<%}%>
		</tr>
		<tr class="contentDark"><!--From System-->
			<td >Umpire Coach : </td>
		 	<%if(umpirecoach != null){%>
		 	<td id="coach"><%=umpirecoach%></td>
		 	<%}else{%>
		 	<td id="coach"></td>
		 	<%}%>
		 	<td ><input class="contentDark" type="button" align="center" value="Print Preview" onclick="javascript:printLetters('3')" >
		 	<input type="hidden" id="hdumpirecoach" name="hdumpirecoach" value="<%=umpirecoach%>" >
		 	<input type="hidden" id="hdumpirecoach_id" name="hdumpirecoach_id" value="<%=umpirecoach_id%>" ></td>		
			<%if(umpirecoach != null){%>
		 	<td><input class="contentDark" id="btnSms" name="btnSms" type="button" align="center" value="Send SMS" onclick="javascript:sendSms('<%=umpirecoach_id%>','<%=mId%>','<%=team1name%>','<%=team2name%>','<%=matchDate%>','<%=matchVenue%>','<%=seriesname%>','umpirecoach')"></td>
		 	<%}else{%>
		 	<td>&nbsp;</td>
		 	<%}%>
		</tr>
	</table>
	<table width="780" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td align="center" > 
			</td>
		</tr>
		<tr>
			<td align="center" > 
				<input type="button" name="btnback" id="btnback" value="Cancel" onclick="previousPage()">
				<input type="hidden" id="hdmatchtypeflag" name="hdmatchtypeflag" value="<%=matchtypeflag%>" >
			</td>
		</tr>
	</table>
	</FORM>
</body>
<% } catch (Exception e) {
    e.printStackTrace();
}
%>    
</html> 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   