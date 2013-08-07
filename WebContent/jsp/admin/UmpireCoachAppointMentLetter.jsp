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
<%@ page language="java" import="java.io.*"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="in.co.paramatrix.csms.common.EMailSender"%>
<%@ page import="in.co.paramatrix.csms.common.ReadOfficialCount"%>
<%@ page import="in.co.paramatrix.csms.common.MatchOfficialAttachment"%>

<%  response.setHeader("Pragma", "private");
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "private");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "must-revalidate");
response.setHeader("Cache-Control", "must-revalidate");
response.setDateHeader("Expires", 0);
try { 
			
			EMailSender				smail					=	null;
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy/MM/dd");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
					"dd/MM/yyyy");
			
			ReadOfficialCount setCount = new ReadOfficialCount();
			CachedRowSet  crsObjMatchData = null;
			ByteArrayOutputStream outputStream = null;
			CachedRowSet  crsObjRemarkData = null;
			String reamrk ="";
			String applicationUrl = "/cims";
			if(Common.getUrl() != null){
				applicationUrl = Common.getUrl(); 	
			}
			String usertype = "";
			usertype = "umpch";			
			String umpchcount = setCount.getProxy(usertype);
			if(umpchcount.length() == 1){
				umpchcount = "0"+umpchcount;
			}
			
			String matchId = request.getParameter("matchId");
			String umpcoach_id = request.getParameter("umpcoach_id");
			String umpcoach = request.getParameter("umpcoach");
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
			String email = request.getParameter("email");
			String seriesname =	request.getParameter("seriesname");	
			String matchenddate =	request.getParameter("matchenddate");	
			String matchpredate = request.getParameter("matchpre_date")==null?"":request.getParameter("matchpre_date");
			String mailumpirecoachname = "";
			String mailflag = request.getParameter("mailflag")==null?"":request.getParameter("mailflag");			
			mailumpirecoachname = umpcoach;
		
			String userEmailAddress = "bhu31084@gmail.com";
			CachedRowSet  crsObjEmail = null;
			
			String Association = "";
			String AssociationEmailAddress = "";
			CachedRowSet  crsObjAssociation = null;
			Vector vparam =  new Vector();
			GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
						
			try{
			vparam.add(umpcoach_id);//display all series name.
			crsObjAssociation = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialassociation",vparam,"ScoreDB");
			vparam.removeAllElements();
			}catch(Exception e){
				e.printStackTrace();
			}
			if(crsObjAssociation != null){	
				while(crsObjAssociation.next()){
					  Association = crsObjAssociation.getString("name");
					  //AssociationEmailAddress = crsObjAssociation.getString("email_address");
					  //reamrk = crsObjAssociation.getString("remark");
					  //AssociationEmailAddress = AssociationEmailAddress;
				}
			}
			
			try{
			vparam.add(umpcoach_id);//display all series name.	umpcoach_id		
			crsObjEmail =  lobjGenerateProc.GenerateStoreProcedure("esp_dsp_get_users_email_address",vparam,"ScoreDB");
			vparam.removeAllElements();
			}catch(Exception e){
				e.printStackTrace();
			}
			if(crsObjEmail != null){	
				while(crsObjEmail.next()){					  					  
					  if(crsObjEmail.getString("email") == null || crsObjEmail.getString("email").equals("")){
					  	userEmailAddress = " ";						  						  	
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
			 + "<td colspan='1'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+umpcoach_id+"&status=Y'>Accept</a></b>"
			 + "<td colspan='3'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+umpcoach_id+"&status=N'>Reject</a></b>"
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
			while(crsObjMatchData.next()){
				 msg ="<table width='700' border='0 align='center' cellpadding='2' cellspacing='1' class='table'>"+
				"<tr class='refereeContentLight'><td colspan='9' align='center'>THE BOARD OF CONTROL FOR CRICKET IN INDIA</td></tr>"+
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
				"<TD align='center' > <b><u>Sub: Letter of Appointment of Match Officials for Domestic Season "+ crsObjMatchData.getString("season_name")+". </u></b>" +
				"</TD></TR></table>"+
				"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
				"<tr class='refereeContentDark'>"+
				"<td colspan='1'><b>Dear Sir,</b></td>"+
				"<td colspan='4'></td></tr>"+
				
				"<tr class='refereeContentDark'>"+
				"<td colspan='5'>&nbsp;</td></tr>"+
				
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
				"<td colspan='3'align='left'>"+crsObjMatchData.getString("matchtype_name")+"</td></tr>"+
				
				"<tr class='refereeContentLight'>"+
				"<td colspan='2'></td>"+
				"<td colspan='2'></td></tr>"+
				
				"<tr class='refereeContentLight'>"+
				"<td colspan='3'>Match Official Names:-</td>"+
				"<td colspan='1'></td></tr>"+
				
				"<tr class='refereeContentLight'>"+
				"<td colspan='1'><b>1.	Umpire 1 : <b></td>"+
				"<td colspan='3'align='left'>"+crsObjMatchData.getString("umpire1")+"</td></tr>"+
				
				"<tr class='refereeContentLight'>"+
				"<td colspan='1'><b>2.	Umpire 2 : <b></td>"+
				"<td colspan='3'align='left'>"+crsObjMatchData.getString("umpire2")+"</td></tr>"+
				
				"<tr class='refereeContentLight'>"+
				"<td colspan='1'><b>3.	Umpire 3 : <b></td>"+
				"<td colspan='3'align='left'>"+crsObjMatchData.getString("umpire3")+"</td></tr>"+
				
				"<tr class='refereeContentLight'>"+
				"<td colspan='1'><b>4.	Match Referee : <b></td>"+
				"<td colspan='3'align='left'>"+crsObjMatchData.getString("matchreferee")+"</td></tr>"+
				
				"<tr class='refereeContentLight'>"+
				"<td colspan='1'><b>5.	Umpire Coach  : <b></td>"+
				"<td colspan='3'align='left'>"+crsObjMatchData.getString("umpirecoach")+"</td></tr>"+
				
				"<tr class='refereeContentDark'>"+
				"<td colspan='4' align='left'>&nbsp;</td></tr>"+
				
				"<tr class='refereeContentDark'>"+
				"<td colspan='4' align='left'>You will be reporting to the Hony. Secretary of "+crsObjMatchData.getString("club_name")+"</td></tr>"+
				
				"<tr class='refereeContentDark'><td  colspan='4' align='left'>You will be paid Match fees & TA/DA as per BCCI norms. </td>"+
				"</tr>"+
				
				"<tr class='refereeContentDark'><td  colspan='4' align='center'>&nbsp; </td>"+
				"</tr>"+
				"<tr class='refereeContentDark'><td  colspan='4' align='center'><b><u>Reporting Pattern of Match Officials:-</u></b> </td>"+
				"</tr>"+
				
				"<tr class='refereeContentDark'><td  colspan='4' align='left'><b><u>Mens Tournament:-</u></b> </td>"+
				"</tr>"+
				
				"<tr class='refereeContentDark'><td  colspan='4' align='left'>1.	For Multiday matches - Arrives two days before the match & leaves one day after the match.</td>"+
				"</tr>"+
				
				"<tr class='refereeContentDark'><td  colspan='4' align='left'>2.	For One Day & T20 matches-Arrives one day before the match & leaves one day after the match.</td>"+
				"</tr>"+
				
				"<tr class='refereeContentDark'><td  colspan='4' align='left'>&nbsp;</td>"+
				"</tr>"+
				
				"<tr class='refereeContentDark'><td  colspan='4' align='left'><b><u>Womens Tournament:--</u></b> </td>"+
				"</tr>"+
				
				"<tr class='refereeContentDark'><td  colspan='4' align='left'>Arrives one day before the match & leaves one day after the match.</td>"+
				"</tr>"+
				
				"<tr class='refereeContentDark'><td  colspan='4' align='left'>&nbsp;</td></tr>" +
				"<tr class='refereeContentDark'>"
				+ "<td colspan='2'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+umpcoach_id+"&status=Y'>Accept</a></b>"
				+ "<td colspan='2'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+umpcoach_id+"&status=N'>Reject</a></b>"
				+ "</tr>"
				
				+"<tr class='refereeContentDark'><td  colspan='4' align='left'>&nbsp;</td></tr>" 
				+"<tr class='refereeContentDark'>"+
				"<td ></td><td colspan='3'>"+
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
				MatchOfficialAttachment.matchOfficialAttachment(filePath,matchId, crsObjMatchData, outputStream);
			
			}
											
%>

<html>
<head>
    <title> Match Umpire Coach's Appointment Letter </title>
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
		var umpcoachid = document.getElementById("umpcoach_id").value;    		
       	document.getElementById("frmUmpCoachAptLetter").action="/cims/jsp/admin/UmpireCoachAppointMentLetter.jsp?mailflag=1&umpcoach_id="+umpcoachid;
       	document.getElementById("frmUmpCoachAptLetter").submit();
   	}
	</script>
</head>
<body >
<br>
<FORM name="frmUmpCoachAptLetter" id="frmUmpCoachAptLetter" method="post"><br>	
<%=msg %>
<div id="btnDiv">
<table width="700" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
<tr align="center">
<td align="center" colspan="4"> 
<input type="button" name="btnprint" id="btnprint" value="Print" onclick="PrintPage(1)">
</td>
</tr>
</table>
</div>
<table>
	<tr>
		<td align="center" colspan="2"> 
			<div id="btnmaildiv" >
			<input type="button" name="btnemail" id="btnemail" value="Send Mail" onclick="mail();">
			</div>
			<input type="hidden" name="matchId" id="matchId" value="<%=matchId%>">
			<input type="hidden" name="umpCoach_id" id="umpCoach_id" value="<%=umpcoach_id%>">			
			<input type="hidden" name="umpcoach" id="umpcoach" value="<%=umpcoach%>">			
			<input type="hidden" name="matchdate" id="matchdate" value="<%=matchdate%>">
			<input type="hidden" name="team1nck" id="team1nck" value="<%=team1nck%>">
			<input type="hidden" name="team2nck" id="team2nck" value="<%=team2nck%>">
			<input type="hidden" name="venue" id="venue" value="<%=venue%>">
			<input type="hidden" name="email" id="email" value="<%=email%>">
			<input type="hidden" name="seriesname" id="seriesname" value="<%=seriesname%>">
			<input type="hidden" name="matchenddate" id="matchenddate" value="<%=matchenddate%>">
			<input type="hidden" name="umpAssociation" id="umpAssociation" value="<%=Association%>">			
		</td>
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
		AssociationEmailAddress = AssociationEmailAddress +","+	email+","+ Common.joinSecetoryEmail();
	 	smail.sendMail(userEmailAddress,AssociationEmailAddress,emailMsg,outputStream, appointmentLetter);
	 	vparam.removeAllElements();
        
	 	/*vparam.add("3");//display teams
        vparam.add(matchId);//display teams
        vparam.add(umpcoach_id);//display teams
        crsObjRemarkData = lobjGenerateProc.GenerateStoreProcedure("esp_amd_officialremark",vparam,"ScoreDB");
	    vparam.removeAllElements(); */
	}	 
%>

</body>

<% } catch (Exception e) {
	out.println(" Exception"+e);
    e.printStackTrace();
}
%>    
</html> 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   