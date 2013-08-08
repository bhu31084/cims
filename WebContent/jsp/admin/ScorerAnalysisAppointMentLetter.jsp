<!--
	Page Name 	 : UmpireCoachAppointMentLetter.jsp
	Created By 	 : Archana Dongre.
	Created Date : 4th Nov 2008
	Description  : Match Umpire Coach's Appointment Letter
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.io.*,com.lowagie.text.pdf.*"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="in.co.paramatrix.csms.common.EMailSender"%>
<%@ page import="in.co.paramatrix.csms.common.ReadOfficialCount"%>
<%@ page import="in.co.paramatrix.csms.common.ScorerAttachment"%>
<%@ page import="in.co.paramatrix.csms.common.VedioAnalysis"%>

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
	EMailSender	smail =	null;
	CachedRowSet  crsObjMatchData = null;
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy/MM/dd");
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");
	java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
					"dd/MM/yyyy");
	ByteArrayOutputStream outputStream = null;		
	ReadOfficialCount setCount = new ReadOfficialCount();
	String applicationUrl = "/cims";
	if(Common.getUrl() != null){
		applicationUrl = Common.getUrl(); 	
	}
	String usertype = "";
	String personName = "";
	String officialId= "";
	String reamrk ="";
	String matchId = request.getParameter("matchId");
	String flag = request.getParameter("flag");
	String analysis_id = request.getParameter("analysis_id");
	String analysis = request.getParameter("analysis");
	String analysis1_id = request.getParameter("analysis1_id");
	String analysis1 = request.getParameter("analysis1");
	String scorer1id = request.getParameter("scorer1id");
	String scorer1nm = request.getParameter("scorer1nm");
	String scorer2id = request.getParameter("scorer2id");
	String scorer2nm = request.getParameter("scorer2nm");
	String email = request.getParameter("email");
	String official = "";
	String subName = "";
	CachedRowSet  crsObjRemarkData = null;
	if(flag.equalsIgnoreCase("s1")){
		personName	= scorer1nm;
		usertype = "scorer1";			
		official = "Scorer Name";
		subName = "Scorer";
		officialId = scorer1id;
	}else if(flag.equalsIgnoreCase("s2")){
		personName	= scorer2nm;
		usertype = "scorer2";
		official = "Scorer Name";
		subName = "Scorer";
		officialId = scorer2id;
	}else if(flag.equalsIgnoreCase("a1")){
		personName	= analysis;
		usertype = "analysis";
		official = "Analyst Name";
		subName = "Video Analyst";
		officialId = analysis_id;
	}else if(flag.equalsIgnoreCase("a2")){
		personName	= analysis;
		usertype = "analysis";
		official = "Analyst Name";
		subName = "Asistance Analyst";
		officialId = analysis1_id;
	}
	String count = setCount.getProxy(usertype);
	if(count.length() == 1){
		count = "0"+count;
	}
	String matchdate = request.getParameter("matchdate");
	String team1nck = request.getParameter("team1nickname")==null?"":request.getParameter("team1nickname");
	String team2nck = request.getParameter("team2nickname")==null?"":request.getParameter("team2nickname");	
	String team1id = request.getParameter("team1id")==null?"":request.getParameter("team1id");
	String team2id = request.getParameter("team2id")==null?"":request.getParameter("team2id");
	String clubname = request.getParameter("clubname")==null?"":request.getParameter("clubname");
	String matchtypeflag = 	request.getParameter("matchtypeflag")==null?"":request.getParameter("matchtypeflag");
	String team1 = request.getParameter("team1");
	String team2 = request.getParameter("team2");
	String venue = request.getParameter("venue");
	String seriesname =	request.getParameter("seriesname");	
	String matchenddate =	request.getParameter("matchenddate");	
	String matchpredate = request.getParameter("matchpre_date")==null?"":request.getParameter("matchpre_date");
	String mailumpirecoachname = "";
	String mailflag = request.getParameter("mailflag")==null?"":request.getParameter("mailflag");			
	
	String userEmailAddress = "bhu31084@gmail.com";
	CachedRowSet  crsObjEmail = null;
	String Association = "";
	String AssociationEmailAddress = "";
	CachedRowSet  crsObjAssociation = null;
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	
	try{
		vparam.add(officialId);//display all series name.
		crsObjAssociation = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialassociation",vparam,"ScoreDB");
		
		vparam.removeAllElements();
		}catch(Exception e){
			e.printStackTrace();
		}			
		if(crsObjAssociation != null){	
			while(crsObjAssociation.next()){					  					  
				  if(crsObjAssociation.getString("name") == null || crsObjAssociation.getString("name").equals("")){
				  	Association = "Not Specified";					  	
				  }else{
				  	Association = crsObjAssociation.getString("name");
				  	AssociationEmailAddress = crsObjAssociation.getString("email_address");
				  	reamrk = crsObjAssociation.getString("remark");
				  }
			}
		}
		try{
		vparam.add(officialId);//display all series name.			
		crsObjEmail =  lobjGenerateProc.GenerateStoreProcedure("esp_dsp_get_users_email_address",vparam,"ScoreDB");
		vparam.removeAllElements();
		}catch(Exception e){
			e.printStackTrace();
		}				
		if(crsObjEmail != null){			
			while(crsObjEmail.next()){					  					  
				  if(crsObjEmail.getString("email") == null || crsObjEmail.getString("email").equals("")){
				  	userEmailAddress = "";	
				  }else{
				  	userEmailAddress = crsObjEmail.getString("email");
				  }					
			}			
		}
		vparam.add(matchId);//display teams
		crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_modifymatch",vparam,"ScoreDB");
	    vparam.removeAllElements();
	    String msg = "";
	    String emailMsg = "";
		while(crsObjMatchData.next()){
			email = crsObjMatchData.getString("email");
			emailMsg ="<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
			 "<tr class='refereeContentDark'>"+
			 "<td colspan='1'><b>Dear Sir,</b></td>"+
			 "<td colspan='4'></td></tr>"+
			
			 "<tr class='refereeContentDark'>"+
			 "<td colspan='5'>&nbsp;</td></tr>"+
			
			 "<tr class='refereeContentLight'>"+
			 "<td colspan='3'>Please read the attached appointment and select, one of the below given "+
			 "link to confirm your status. </td>"+
			 "<td colspan='1'></td></tr>" +
			 "<tr class='refereeContentDark'>"
			 + "<td colspan='1'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+officialId+"&status=Y'>Accept</a></b>"
			 + "<td colspan='3'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+officialId+"&status=N'>Reject</a></b>"
			 + "</tr>" +
			 "<tr class='refereeContentDark'>"+
			 "<td ></td><td colspan='4'>"+
			 "</tr></table>"+
			 "<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
			 "<tr class='refereeContentLight'><td>Thanking you,</td></tr>"+
			 "<tr class='refereeContentDark'><td>Yours Faithfully,</td></tr>"+
			 "<tr class='refereeContentDark'><td>&nbsp;</td></tr>"+
			 "<tr class='refereeContentLight'><td>Prof. Ratnakar. S. Shetty</td></tr>"+
			 "<tr class='refereeContentLight'><td>Chief Administrative Officer, BCCI</td></tr>"+
			 "</table>" +
			 "<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
			 "<tr class='refereeContentLight'><td>&nbsp;</td></tr>"+
			 "<tr class='refereeContentLight'><td>(This is an electronically generated document & does not require a signature)</td></tr>"+
			 "</table>";
			 if(flag!=null && (flag.equalsIgnoreCase("a1")|| flag.equalsIgnoreCase("a2")) ){
				 msg ="<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentDark'><td colspan='9' align='center'>THE BOARD OF CONTROL FOR CRICKET IN INDIA</td></tr>"+
					"</table>"+
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentDark'>"+		
					"<td height='15%' width='70% valign='top' align='center><IMG alt='' src='../../images/BCCI_Logo_.jpg'></td>"+
					"</tr></table>"+
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr><td colspan='2'>&nbsp;</td></tr>"+
					"<tr class='refereeContentLight'>"+
					"<TD align='left' >BCCI/HQ/"+matchId+"/"+crsObjMatchData.getString("season_name")+"</TD>"+
					"<TD align='center' ><B>Date :"+sdf2.format(new Date()) +"</B></TD>"+
					"</TR><tr class='refereeContentLight'>	<TD align='left' ></TD>	</TR>"+
					"<tr class='refereeContentLight'>"+
					"<TD align='center' > <b><u>Sub: Letter of Appointment of Video Analyst for Domestic Season " +crsObjMatchData.getString("season_name")+". </u></b>" +
					"</TD></TR></table>"+
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentDark'>"+
					"<td colspan='4'>&nbsp;</td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='1'><b>Dear Sir,</b></td>"+
					"<td colspan='3'></td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4'>&nbsp;</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='4'>You have been appointed to officiate in the following match:-</td>"+
					"</tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>1.	Tournament Name : <b></td>"+
					"<td colspan='3'align='left'>"+ crsObjMatchData.getString("series_name") +"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>2.	Team1 : <b></td>"+
					"<td colspan='3'align='left'>"+ crsObjMatchData.getString("team_one") +"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>3.	Team2 : <b></td>"+
					"<td colspan='3'align='left'>"+ crsObjMatchData.getString("team_two") +"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>4.	Date From : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("from_date").substring(0,12).trim()+"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>5.	Date To : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("to_date").substring(0,12).trim()+"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>6.	Venue : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("venue_name")+"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>7.	Match Type  : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("matchtype_name")+ "</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='2'></td>"+
					"<td colspan='2'></td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='3'>Video Analyst Names:-</td>"+
					"<td colspan='1'></td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b> Main Analyst  : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("analyst")+"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>Assistant Analyst  : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("analyst1")+"</td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>&nbsp;</td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>You will be reporting to the Hony. Secretary of "+crsObjMatchData.getString("club_name")+"</td></tr>"+
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>&nbsp;</td></tr>"+
					
					"<tr class='refereeContentDark'><td  colspan='4' align='left'>You will be paid Match fees & TA/DA by the staging association as applicable to you.</td>"+
					"</tr>"+
					
					"<tr class='refereeContentDark'><td  colspan='4' align='left'>The reporting pattern of the Video Analysts will be one day prior to the first match, till one day after the last match, except for those matches which are telecasted live, wherein the appointment will be only for the match days.</td>"+
					"</tr>"+
					"<tr class='refereeContentDark'><td  colspan='4' align='left'>&nbsp;</td></tr>" +
					"<tr class='refereeContentDark'>"
					+ "<td colspan='1'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+officialId+"&status=Y'>Accept</a></b>"
					+ "<td colspan='3'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+officialId+"&status=N'>Reject</a></b>"
					+ "</tr>" +
					"<tr class='refereeContentDark'>"+
					"<td ></td><td colspan='4'>"+
					"</tr></table>"+
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentLight'><td>Thanking you,</td></tr>"+
					"<tr class='refereeContentDark'><td>Yours Faithfully,</td></tr>"+
					"<tr class='refereeContentDark'><td>&nbsp;</td></tr>"+
					"<tr class='refereeContentLight'><td>Prof. Ratnakar. S. Shetty</td></tr>"+
					"<tr class='refereeContentLight'><td>Chief Administrative Officer, BCCI</td></tr>"+
					"</table>" +
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentLight'><td>&nbsp;</td></tr>"+
					"<tr class='refereeContentLight'><td>(This is an electronically generated document & does not require a signature)</td></tr>"+
					"</table>";
					
					
				 	outputStream = new ByteArrayOutputStream();
					String path = (String)getServletContext().getRealPath("");
					String filePath =path+"/images/BCCI_Logo_.jpg";
					VedioAnalysis.vedioAnalysis(filePath,matchId, crsObjMatchData, outputStream,reamrk);
			 }else{
					 msg ="<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentDark'><td colspan='9' align='center'>THE BOARD OF CONTROL FOR CRICKET IN INDIA</td></tr>"+
					"</table>"+
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentDark'>"+		
					"<td height='15%' width='70% valign='top' align='center><IMG alt='' src='../../images/BCCI_Logo_.jpg'></td>"+
					"</tr></table>"+
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr><td colspan='2'>&nbsp;</td></tr>"+
					"<tr class='refereeContentLight'>"+
					"<TD align='left' >BCCI/HQ/"+matchId+"/"+crsObjMatchData.getString("season_name")+"</TD>"+
					"<TD align='center' ><B>Date :"+sdf2.format(new Date()) +"</B></TD>"+
					"</TR><tr class='refereeContentLight'>	<TD align='left' ></TD>	</TR>"+
					"<tr class='refereeContentLight'>"+
					"<TD align='center' > <b><u>Sub: Letter of Appointment of Scorers for Domestic Season "+crsObjMatchData.getString("season_name")+". </u></b>" +
					"</TD></TR></table>"+
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentDark'>"+
					"<td colspan='4'>&nbsp;</td></tr>"+
					"<tr class='refereeContentDark'>"+
					"<td colspan='1'><b>Dear Sir,</b></td>"+
					"<td colspan='3'></td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4'>&nbsp;</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='3'>You have been appointed to officiate in the following match:-</td>"+
					"<td colspan='1'></td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>1.	Tournament Name : <b></td>"+
					"<td colspan='3'align='left'>"+ crsObjMatchData.getString("series_name") +"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>2.	Team1 : <b></td>"+
					"<td colspan='3'align='left'>"+ crsObjMatchData.getString("team_one") +"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>3.	Team2 : <b></td>"+
					"<td colspan='3'align='left'>"+ crsObjMatchData.getString("team_two") +"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>4.	Date From : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("from_date").substring(0,12).trim()+"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>5.	Date To : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("to_date").substring(0,12).trim()+"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>6.	Venue : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("venue_name")+"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>7.	Match Type  : <b></td>"+
					"<td colspan='3'align='left'>" +crsObjMatchData.getString("matchtype_name")+"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='2'></td>"+
					"<td colspan='2'></td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='3'>Scorers  Names:-</td>"+
					"<td colspan='1'></td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>1.	Online Scorer : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("scorer")+"</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='1'><b>2.	Manual Scorer : <b></td>"+
					"<td colspan='3'align='left'>"+crsObjMatchData.getString("scorer2")+"</td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>&nbsp;</td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>You will be reporting to the Hony. Secretary of "+crsObjMatchData.getString("club_name")+"</td></tr>"+
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>&nbsp;</td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>You are requested to strictly follow the instructions given below:</td></tr>"+
					
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>&nbsp;&nbsp;&nbsp;<b>1.  You shall check the name of the players provided by the Team Manager and verify it with the names entered in the Online Registration System.</b></td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>&nbsp;&nbsp;&nbsp;<b>2.  The name entered in the Online Registration System should be considered as final.</b></td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>&nbsp;&nbsp;&nbsp;<b>3.  Any name which is provided by the Team Manager, not found registered in the Online System, should be brought to the notice of the Match Referee and the concerned Team Manager.</b></td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>&nbsp;&nbsp;&nbsp;<b>4.  Any player who complains that his name entered in the Online registration system is incorrect, should be asked to write to BCCI through his Association.</b></td></tr>"+
				
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='4' align='left'>&nbsp;</td></tr>"+
					"<tr class='refereeContentDark'><td  colspan='4' align='left'>You will be paid Match fees & TA/DA as per BCCI norms. </td>"+
					"</tr>"+
					
					"<tr class='refereeContentDark'><td  colspan='4' align='center'>&nbsp; </td>"+
					"</tr>"+
					"<tr class='refereeContentDark'><td  colspan='4' align='center'><b>Reporting pattern</b> </td>"+
					"</tr>"+
					
					"<tr class='refereeContentDark'><td  colspan='4' align='left'>Online Scorer  :    One day before the first match, till last day of the last match.</td>"+
					"</tr>"+
					"<tr class='refereeContentDark'><td  colspan='4' align='left'>Manual Scorer : On the day of the match, till last day of the last match.</td>"+
					"</tr>"+
					"<tr class='refereeContentDark'><td  colspan='4' align='left'>&nbsp;</td></tr>" +
					"<tr class='refereeContentDark'>"
					+ "<td colspan='1'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+officialId+"&status=Y'>Accept</a></b>"
					+ "<td colspan='3'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+officialId+"&status=N'>Reject</a></b>"
					+ "</tr>" +
					"<tr class='refereeContentDark'>"+
					"<td ></td><td colspan='4'>"+
					"</tr></table>"+
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentLight'><td>Thanking you,</td></tr>"+
					"<tr class='refereeContentDark'><td>Yours Faithfully,</td></tr>"+
					"<tr class='refereeContentDark'><td>&nbsp;</td></tr>"+
					"<tr class='refereeContentLight'><td>Prof. Ratnakar. S. Shetty</td></tr>"+
					"<tr class='refereeContentLight'><td>Chief Administrative Officer, BCCI</td></tr>"+
					"</table>" +
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentLight'><td>&nbsp;</td></tr>"+
					"<tr class='refereeContentLight'><td>(This is an electronically generated document & does not require a signature)</td></tr>"+
					"</table>";
					    outputStream = new ByteArrayOutputStream();
						String path = (String)getServletContext().getRealPath("");
						String filePath =path+"/images/BCCI_Logo_.jpg";
						ScorerAttachment.scorerAttachment(filePath,matchId, crsObjMatchData, outputStream,reamrk);
			 }
		
		}	
											
%>

<html>
<head>
<title>Match Official Letter</title>
<%--	<link rel="stylesheet" type="text/css" href="../../css/common.css">--%>
<%--	<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">--%>
<%--	<link rel="stylesheet" type="text/css" href="../../css/menu.css">--%>
<%--    <link rel="stylesheet" type="text/css" href="../../CSS/Styles.css">--%>
<link href="../../css/form.css" rel="stylesheet" type="text/css" />
<link href="../../css/formtest.css" rel="stylesheet" type="text/css" />
<script language="javascript">	
	/*function PrintPage(flag){    	
    	if(flag == "1"){    		
    		document.getElementById("btnDiv").style.display= 'none';
    		window.print();
    	}      	
	} */
	
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
    
    function PrintPage(flag){
    	if(flag == "1"){    		
    		var usertype = "umpch";
    		document.getElementById("btnDiv").style.display= 'none';
    		document.getElementById("btnmaildiv").style.display= 'none';
    		xmlHttp=GetXmlHttpObject();
    		if (xmlHttp==null){
				alert ("Browser does not support HTTP Request");
                return;
			}else{					
				var url ;					             
                url="/cims/jsp/admin/IncreaseOfficialsCountResponse.jsp?usertype="+usertype;	               
				//xmlHttp.onreadystatechange=stateChangedAdminResponse;
				xmlHttp.open("post",url,false);				
               	xmlHttp.send(null);
               	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;					
				}
				window.print();
             }       		
    	}       	
    }
	   
    function mail(){    		
	   	document.getElementById("frmUmpCoachAptLetter").action="/cims/jsp/admin/ScorerAnalysisAppointMentLetter.jsp?mailflag=1";
       	document.getElementById("frmUmpCoachAptLetter").submit();
   	}
	</script>
</head>
<body>
<br>
<FORM name="frmUmpCoachAptLetter" id="frmUmpCoachAptLetter" method="post"><br>
<%=msg%>
<div id="btnDiv">
<table width="700" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<tr align="center">
		<td align="center" colspan="4"><input type="button"
			name="btnprint" id="btnprint" value="Print" onclick="PrintPage(1)">
		</td>
	</tr>
</table>
</div>
<table>
	<tr>
		<td align="center" colspan="2">
		<div id="btnmaildiv">
			<input type="button" name="btnemail" id="btnemail" value="Send Mail" onclick="mail();">
		</div>
			<input type="hidden" name="matchId" id="matchId" value="<%=matchId%>">
			<input type="hidden" id="scorer1nm" name="scorer1nm" value="<%=scorer1nm%>" >
 			<input type="hidden" id="scorer1id" name="scorer1id" value="<%=scorer1id%>">
			<input type="hidden" id="scorer2nm" name="scorer2nm" value="<%=scorer2nm%>" >
 			<input type="hidden" id="scorer2id" name="scorer2id" value="<%=scorer2id%>">
			<input type="hidden" id="analysis" name="analysis" value="<%=analysis%>" >
 			<input type="hidden" id="analysis_id" name="analysis_id" value="<%=analysis_id%>" >
			<input type="hidden" id="analysis1" name="analysis1" value="<%=analysis1%>" >
 			<input type="hidden" id="analysis1_id" name="analysis1_id" value="<%=analysis1_id%>" >
			<input type="hidden" name="matchdate" id="matchdate" value="<%=matchdate%>">
			<input type="hidden" name="team1nck" id="team1nck" value="<%=team1nck%>">
			<input type="hidden" name="team2nck" id="team2nck" value="<%=team2nck%>">
			<input type="hidden" name="venue" id="venue" value="<%=venue%>">
			<input type="hidden" name="email" id="email" value="<%=email%>">
			<input type="hidden" name="seriesname" id="seriesname" value="<%=seriesname%>">
			<input type="hidden" name="matchenddate" id="matchenddate" value="<%=matchenddate%>">
			<input type="hidden" name="umpAssociation" id="umpAssociation" value="<%=Association%>">
			<input type="hidden" name="flag" id="flag" value="<%=flag%>">		
	</tr>
</table>

<%
	if(mailflag!=null && mailflag.equalsIgnoreCase("1")){
		String appointmentLetter = "";
		if(reamrk.equalsIgnoreCase("")){
			appointmentLetter = "Appointment Letter";
		}else{
			appointmentLetter = "Revised Appointment Letter (Revised on "+ sdf2.format(new Date()) +" )";
		}
	
		if(AssociationEmailAddress.equalsIgnoreCase("") || AssociationEmailAddress==null){
			AssociationEmailAddress = "cims@bcci.tv";
		}
		if(email.equalsIgnoreCase("") || email==null){
			email = "cims@bcci.tv";
		}
	   AssociationEmailAddress = AssociationEmailAddress +"," + email;
	   smail.sendMail(userEmailAddress,AssociationEmailAddress,emailMsg,outputStream,appointmentLetter);
	   vparam.removeAllElements();
	   
       /*vparam.add("3");//display teams
       vparam.add(matchId);//display teams
       vparam.add(officialId);//display teams
       crsObjRemarkData = lobjGenerateProc.GenerateStoreProcedure("esp_amd_officialremark",vparam,"ScoreDB");
	   vparam.removeAllElements(); */
	}	 
%>
</body>
</html>