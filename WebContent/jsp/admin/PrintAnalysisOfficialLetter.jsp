
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
<%@ page import="in.co.paramatrix.csms.common.Common"%>

<%  response.setHeader("Pragma", "private");
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
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy/MM/dd");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
					"dd/MM/yyyy");

			Vector vparam =  new Vector();
			GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
			CachedRowSet  crsObjMatchData = null;
			String applicationUrl = "/cims";
			if(Common.getUrl() != null){
				applicationUrl = Common.getUrl(); 	
			}
			String mId = new String();
			String team1Id = new String();
			String team2Id = new String();
			String team1name = new String();
			String team2name = new String();
			String team1nickname = new String();
			String team2nickname = new String();
			String umpire1_id = "";
			String umpire1 = "";
			String umpire2_id = "";
			String umpire2 ="";
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
			String pre_date = "";
			String clubname ="";
			String email="";
			String matchtypeflag = null;	
			
			vparam.add(matchId);//display teams
			crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure(
		       	"esp_dsp_modifymatch",vparam,"ScoreDB");
		    vparam.removeAllElements();
			while(crsObjMatchData.next()){
				mId = crsObjMatchData.getString("match_id");
				team1Id = crsObjMatchData.getString("team1_id");
				team2Id = crsObjMatchData.getString("team2_id");
				team1nickname = crsObjMatchData.getString("team_one_nickname");
				team2nickname = crsObjMatchData.getString("team_two_nickname");
				team1name = crsObjMatchData.getString("team_one");
				team2name = crsObjMatchData.getString("team_two");
				matchDate = crsObjMatchData.getString("from_date").substring(0,12).trim();
				matchendDate = crsObjMatchData.getString("to_date").substring(0,12).trim();
				clubname = crsObjMatchData.getString("club_name");
				matchVenue = crsObjMatchData.getString("venue_name");
				seriesname = 	crsObjMatchData.getString("series_name");
				scorer1_id = 	crsObjMatchData.getString("scorer_id");
				scorer1 = 	crsObjMatchData.getString("scorer");
				scorer2_id = 	crsObjMatchData.getString("scorer2_id");
				scorer2 = 	crsObjMatchData.getString("scorer2");
				analysis_id = 	crsObjMatchData.getString("analyst_id");
				analysis = 	crsObjMatchData.getString("analyst");
				analysis1_id = 	crsObjMatchData.getString("analyst1_id");
				analysis1 = 	crsObjMatchData.getString("analyst1");
				pre_date = crsObjMatchData.getString("pre_date").substring(0,12).trim();
				matchtypeflag = crsObjMatchData.getString("matchtypeflag");
				email = 	crsObjMatchData.getString("email");
			}
%>

<html>
<head>
    <title> Match Analysis Detail </title>
	<link rel="stylesheet" type="text/css" href="../../css/common.css">
	<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../../css/menu.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/Styles.css">
	<link href="../../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../../css/formtest.css" rel="stylesheet" type="text/css" />
    <script language="javascript">
    	function printLetters(flag){
        		var matchId = document.getElementById('hdmid').value
        		var matchpre_date = document.getElementById('hdpre_date').value
				var matchdate = document.getElementById('hddate').value
				var matchenddate = document.getElementById('hdenddate').value
				var team1 = document.getElementById('hdteam1').value
				var team2 = document.getElementById('hdteam2').value
				var team1nickname = document.getElementById('hdteam1nck').value
				var team2nickname = document.getElementById('hdteam2nck').value
				var venue = document.getElementById('hdvenue').value
				var seriesname = document.getElementById('hdseriesname').value
				var analysis_id = document.getElementById('hdanalysisId').value
				var analysis = document.getElementById('hdanalysis').value
				var analysis1_id = document.getElementById('hdanalysisId1').value
				var analysis1 = document.getElementById('hdanalysis1').value
				var matchtypeflag = document.getElementById('hdmatchtypeflag').value
				var clubname = document.getElementById('hdvenueclubname').value
				var email = document.getElementById('hdemail').value
				if((flag == "a1")&&(document.getElementById('analysis').innerHTML != "")){
	    			winhandle = window.open("ScorerAnalysisAppointMentLetter.jsp?flag="+ flag +"&matchpre_date="+matchpre_date+
	    	    			"&seriesname="+seriesname+"&matchtypeflag="+matchtypeflag+"&clubname="+clubname+
	    	    			"&matchId="+matchId+"&analysis_id="+analysis_id+"&analysis="+analysis+"&analysis1_id="+analysis1_id+"&analysis1="+analysis1+
	    	    			"&matchdate="+matchdate+"&matchenddate="+matchenddate+"&team1="+team1+
	    	    			"&team2="+team2+"&venue="+venue+"&team1nickname="+team1nickname+
	    	    			"&email="+email+
	    	    			"&team2nickname="+team2nickname,"battingreport","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-40)+",height="+(window.screen.availHeight-20));
	    		}else if((flag == "a2")&&(document.getElementById('analysis1').innerHTML != "")){
	    			winhandle = window.open("ScorerAnalysisAppointMentLetter.jsp?flag="+ flag +"&matchpre_date="+matchpre_date+
	    	    			"&seriesname="+seriesname+"&matchtypeflag="+matchtypeflag+"&clubname="+clubname+
	    	    			"&matchId="+matchId+"&analysis_id="+analysis_id+"&analysis="+analysis+"&analysis1_id="+analysis1_id+"&analysis1="+analysis1+
	    	    			"&matchdate="+matchdate+"&matchenddate="+matchenddate+"&team1="+team1+
	    	    			"&team2="+team2+"&venue="+venue+"&team1nickname="+team1nickname+
	    	    			"&email="+email+
	    	    			"&team2nickname="+team2nickname,"battingreport","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-40)+",height="+(window.screen.availHeight-20));
	    		}else{ //scorer's  appointment letters page name should be changed.
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
					var matchId = document.getElementById('hdmid').value
			    	var matchpre_date = document.getElementById('hdpre_date').value
					var matchdate = document.getElementById('hddate').value
					var matchenddate = document.getElementById('hdenddate').value
					var team1nickname = document.getElementById('hdteam1nck').value
					var team2nickname = document.getElementById('hdteam2nck').value
					var team1 = document.getElementById('hdteam1').value
					var team2 = document.getElementById('hdteam2').value
					var venue = document.getElementById('hdvenue').value
					var clubname = document.getElementById('hdvenueclubname').value
					var email = document.getElementById('hdemail').value
					var scorer1id = "";
					var scorer1nm = "";
					var scorer2id = "";
					var scorer2nm = "";
					var analysis_id = document.getElementById('hdanalysisId').value
					var analysis = document.getElementById('hdanalysis').value
					var analysis1_id = document.getElementById('hdanalysisId1').value
					var analysis1 = document.getElementById('hdanalysis1').value
					var seriesname = document.getElementById('hdseriesname').value
					var matchtypeflag = document.getElementById('hdmatchtypeflag').value
					var appendUrl = "seriesname="+seriesname+
					"&matchtypeflag="+matchtypeflag+
					"&clubname="+clubname+
					"&matchId="+matchId+
					"&scorer1id="+scorer1id+
					"&scorer1nm="+scorer1nm+
					"&scorer2id="+scorer2id+
					"&scorer2nm="+scorer2nm+
					"&analysis_id="+analysis_id+
					"&analysis="+analysis+
					"&analysis1_id="+analysis1_id+
					"&analysis1="+analysis1+
					"&team1="+team1+
					"&team2="+team2+
					"&venue="+venue+
					"&email="+email+
					"&matchpre_date="+matchpre_date+
					"&matchdate="+matchdate+
					"&matchenddate="+matchenddate+
					"&team1nickname="+team1nickname+
					"&team2nickname="+team2nickname+
					"&gsflag=analysis";
					

	                url = "/cims/AjaxSendOfficialEmail?"+appendUrl;	               
					xmlHttp.open("GET",url,false);				
	               	xmlHttp.send(null);
	               	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
						var responseResult= xmlHttp.responseText;
						alert(responseResult)
					}
				}    		
    		
    		}else{
    			return false;
    		}	
        			
    	}	
    	function previousPage(){
    		window.close();
    	}

    	function sendSmstoall(scorer1Id,scorer2Id,analysis,analysis1,matchId,team1,team2,matchdate,venue,seriesname){
    		window.open("../sms/SMSAnalysisPushAll.jsp?analysis="+analysis+"&analysis1="+analysis1+"&seriesname="+seriesname+"&matchId="+matchId+"&matchdate="+matchdate+"&team1="+team1+"&team2="+team2+"&venue="+venue,"sendsms","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=250,left=450,width="+(window.screen.availWidth-600)+",height="+(window.screen.availHeight-500));
        }
    	
</script>
</head>
<body>
<br>
<FORM name="frmrefereeAptLetter" id="frmrefereeAptLetter" method="post"><br>	
		<table width="780" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td colspan="9" bgcolor="#FFFFFF" class="legend">
				Match Analysis Detail
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
	<td ><input type="hidden" id="hdmid" name="hdmid" value="<%=mId%>" ></td>	
</tr>
<tr class="contentLight"><!--From System-->  
	<td >Match Between :</td>
	<td id="team1"><%=team1name%>&nbsp;&nbsp;&nbsp;&nbsp;vs&nbsp;&nbsp;&nbsp;&nbsp;<%=team2name%></td>
	<td ><input type="hidden" id="hdteam1" name="hdteam1" value="<%=team1name%>" >
	<input type="hidden" id="hdteam2" name="hdteam2" value="<%=team2name%>">
<input type="hidden" id="hdteam1nck" name="hdteam1nck" value="<%=team1nickname%>" >
			<input type="hidden" id="hdteam2nck" name="hdteam2nck" value="<%=team2nickname%>">
			</td>	
</tr>
<tr class="contentDark"><!--From System-->  
	<td >Match Date : </td>
	<td id="stdate"><%=matchDate%> </td>
	<td ><input type="hidden" id="hddate" name="hddate" value="<%=matchDate%>">
	<input type="hidden" id="hdpre_date" name="hdpre_date" value="<%=pre_date%>">
	<input type="hidden" id="hdenddate" name="hdenddate" value="<%=matchendDate%>"></td>	
</tr>
<tr class="contentLight"><!--From System-->  
	<td >Venue : </td>
	<td id="venue" ><%=matchVenue%></td>
	<td ><input type="hidden" id="hdvenue" name="hdvenue" value="<%=matchVenue%>" >
	<input type="hidden" id="hdvenueclubname" name="hdvenueclubname" value="<%=clubname%>" >
	<input type="hidden" id="hdemail" name="hdemail" value="<%=email%>" >
	</td>	
</tr>
<tr class="contentDark"><!--From System-->  
	<td >Series : </td>
	<td id="series"><%=seriesname%></td>
	<td><input class="contentDark" type="button" align="center" value="Send Email And SMS To All" onclick="javascript:sendEmailToAllOffical();sendSmstoall('<%=scorer1_id+":s1"%>','<%=scorer2_id+":s2"%>','<%=analysis_id+":a1"%>','<%=analysis1_id+":a2"%>','<%=mId%>','<%=team1name%>','<%=team2name%>','<%=matchDate%>','<%=matchVenue%>','<%=seriesname%>');">
	<input type="hidden" id="hdseriesname" name="hdseriesname" value="<%=seriesname%>" ></td>	
</tr>			
<tr class="contentDark"><!--From System-->
	<td >Main Analysis : </td>
 	<%if(analysis != null){%>
 	<td id="analysis"><%=analysis%></td>
 	<%}else{%>
 	<td id="analysis"></td>
 	<%}%>
 	<td ><input class="contentDark" type="button" align="center" value="Print Preview" onclick="printLetters('a1')">
 	<input type="hidden" id="hdanalysis" name="hdanalysis" value="<%=analysis%>" >
 	<input type="hidden" id="hdanalysisId" name="hdanalysisId" value="<%=analysis_id%>" ></td>		

</tr>

<tr class="contentDark"><!--From System-->
	<td >Assistant Analyst  : </td>
 	<%if(analysis1 != null){%>
 	<td id="analysis1"><%=analysis1%></td>
 	<%}else{%>
 	<td id="analysis1"></td>
 	<%}%>
 	<td ><input class="contentDark" type="button" align="center" value="Print Preview" onclick="printLetters('a2')">
 	<input type="hidden" id="hdanalysis1" name="hdanalysis1" value="<%=analysis1%>" >
 	<input type="hidden" id="hdanalysisId1" name="hdanalysisId1" value="<%=analysis1_id%>" ></td>		

</tr>
</table>
<table width="780" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
<tr><td align="center" > 
</td>
</tr>
<tr><td align="center" > 
<input type="button" name="btnback" id="btnback" value="Cancel" onclick="previousPage()">
<input type="hidden" id="hdmatchtypeflag" name="hdmatchtypeflag" value="<%=matchtypeflag%>" >
</td>
</tr>
</table>
</body>

<% } catch (Exception e) {
	out.println(" Exception"+e);
    e.printStackTrace();
}
%>    
</html> 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   