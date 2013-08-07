 <!--
Page Name 	 : PitchOutfieldReportLimited.jsp
Created By 	 : Dipti Shinde.
Created Date : 9th sept 2008
Description  : Pitch and outfield report
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 16/09/2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.common.*"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat,in.co.paramatrix.csms.logwriter.LogWriter"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);

		String reportId = "5";
		String role = "4"; //For refree
		String matchId = null;
		String loginUserName = null;
		String userID = null;
		String flag = "false";
		String message = null;
		String startDate = null;
		String endDate = null;
		String allDays = "";
		int days = 0;
		//String umpire_name = null;
		String umpireOfficialId = null;
		LogWriter log = new LogWriter();
		
		ReplaceApostroph replaceApos = new ReplaceApostroph();
		StringBuffer sbIds = new StringBuffer();
		StringBuffer sbIdsOccurance = new StringBuffer();

		matchId = session.getAttribute("matchid").toString();
		userID = session.getAttribute("userid").toString();
		loginUserName = session.getAttribute("usernamesurname").toString();
		String userRole = session.getAttribute("role").toString();
		
		CachedRowSet matchSummeryCrs = null;
		CachedRowSet submitCrs = null;
		CachedRowSet displayCrs = null;
		CachedRowSet umpiresCrs = null;
		CachedRowSet useridCrs = null;
		CachedRowSet messageCrs = null;
		CachedRowSet refreeidCrs = null;
		Calendar cal = Calendar.getInstance();

		GenerateStoreProcedure generateStProc = new GenerateStoreProcedure();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");
		java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat(
				"dd/MM/yyyy");
	
		Vector ids = new Vector();
		Vector spParamVec = new Vector();
		String score = request.getParameter("hdSelectedValue");//e.g."1:1~2:2~3:0"		
		String scoreRequired = (String) request.getParameter("hdScoreRequired");//e.g."1:1~2:2~3:0"		

		try{
		//for match details in top table
		spParamVec.add(matchId); // match_id
		
		matchSummeryCrs = generateStProc.GenerateStoreProcedure(
				"esp_dsp_matchdetails_pitchreport", spParamVec, "ScoreDB");
		}catch (Exception e) {
				System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
				log.writeErrLog(page.getClass(),matchId,e.toString());
		}		
		
		/*useridCrs = generateStProc.GenerateStoreProcedure(
				"esp_dsp_getmatchrefereeid", spParamVec, "ScoreDB");
		 if (useridCrs != null) {		
			if (useridCrs.next()) {
				userID = useridCrs.getString("id");
			}		
		}*/		
if (userRole.equals("9")){
			System.out.println("Role is admin");
			spParamVec = new Vector();
			spParamVec.add(matchId);
			spParamVec.add(role);
			
			try{
			refreeidCrs = generateStProc.GenerateStoreProcedure(
					"esp_dsp_getMatchConcerns", spParamVec, "ScoreDB");
			}catch (Exception e) {
				System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
				log.writeErrLog(page.getClass(),matchId,e.toString());
			}		
		if (refreeidCrs != null) {
			while (refreeidCrs.next()) {
				userID = refreeidCrs.getString("id");
			}
		}		
}
		if (request.getParameter("hid") != null
				&& request.getParameter("hid").equalsIgnoreCase("1")) {

			System.out.println("ids : " + request.getParameter("hidden_ids"));
			System.out.println("ids_occurance : " + request.getParameter("hidden_ids_occurance"));
			System.out.println("hiddenDates : " + request.getParameter("hiddenDates"));

			String[] retrieve_ids = request.getParameter("hidden_ids").split(",");
			String[] retrieve_ids_occurance = request.getParameter("hidden_ids_occurance").split(",");//for >1 occurance
			String[] retrieve_dates = request.getParameter("hiddenDates").split("~");
			
			int retrieve_ids_length = retrieve_ids.length;
			int retrieve_ids_occlength = ((retrieve_ids_occurance.length) - 1);
			int retrieve_dates_length = retrieve_dates.length;
			
			umpireOfficialId = request.getParameter("umpire");
//-----------------------------	//one occurance	
			for (int count = 0; count < retrieve_ids_length; count = count + 2) {
				spParamVec = new Vector();
				spParamVec.add(matchId);
				spParamVec.add(userID);
				spParamVec.add(retrieve_ids[count]);
				if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {//combo
					spParamVec.add(request.getParameter(retrieve_ids[count]+"_"+retrieve_dates[0]));
					spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter("rem_"+retrieve_ids[count]+"_"+retrieve_dates[0])));
				} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {//text
					spParamVec.add("0");//for score
					spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter(retrieve_ids[count]+"_"+retrieve_dates[0])));
				}
				spParamVec.add(reportId);
				spParamVec.add(retrieve_dates[0]);
				
				try{
				messageCrs = generateStProc.GenerateStoreProcedure("esp_amd_pitchoutfield_for5day ",
						spParamVec, "ScoreDB");
				}catch (Exception e) {
				System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
				log.writeErrLog(page.getClass(),matchId,e.toString());
				}		
			}
//-----------------------------	//more than one occurance		
			for (int count = 0; count < retrieve_ids_occlength; count = count + 2) {
				
				for(int count1 = 0; count1 < retrieve_dates_length; count1++ ){
					
					if (retrieve_ids_occurance[count + 1].equalsIgnoreCase("Y")) {//combo
						spParamVec.removeAllElements();
						spParamVec.add(matchId);
						spParamVec.add(userID);
						spParamVec.add(retrieve_ids_occurance[count]);
						spParamVec.add(request.getParameter(retrieve_ids_occurance[count]+"_"+retrieve_dates[count1]));
						spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter("rem_"+retrieve_ids_occurance[count]+"_"+retrieve_dates[count1])));
						spParamVec.add(reportId);
						spParamVec.add(retrieve_dates[count1]);
					} else if (retrieve_ids_occurance[count + 1].equalsIgnoreCase("N")) {//text
						spParamVec.add(matchId);
						spParamVec.add(userID);
						spParamVec.add(retrieve_ids_occurance[count]);
						spParamVec.add("0");
						spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter(retrieve_ids_occurance[count]+"_"+retrieve_dates[count1])));
						spParamVec.add(reportId);
						spParamVec.add(retrieve_dates[count1]);
					}
					
					try{
					messageCrs = generateStProc.GenerateStoreProcedure("esp_amd_pitchoutfield_for5day ",
						spParamVec, "ScoreDB");
					}catch (Exception e) {
							System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
							log.writeErrLog(page.getClass(),matchId,e.toString());
					}	
				}
				
				if (messageCrs.next()) {
					message = messageCrs.getString("retval");
					flag = "true";
				}
			}
			
//System.out.println("??????????????????????"+message);			
//----------------------------
		}

		//For Display Table Data
		spParamVec.removeAllElements();
		spParamVec.add(matchId); // match_id
		spParamVec.add(userID);
		
		try{
		umpiresCrs = generateStProc.GenerateStoreProcedure(
				"esp_dsp_getmatchofficialid", spParamVec, "ScoreDB");//to get official id of umpire
		}catch (Exception e) {
				System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
				log.writeErrLog(page.getClass(),matchId,e.toString());
		}
				
		if (umpiresCrs.next()) {
			umpireOfficialId = umpiresCrs.getString("official");
		}
		spParamVec.add(reportId); // report id
		
		try{
		displayCrs = generateStProc.GenerateStoreProcedure(
				"esp_dsp_pitchoutfield5day", spParamVec, "ScoreDB");//need to change
		}catch (Exception e) {
				System.out.println("*************PitchOutfieldReportMultipleDays.jsp*****************"+e);
				log.writeErrLog(page.getClass(),matchId,e.toString());
		}		
%>
<html>
<head>
	<title>PITCH AND OUTFIELD REPORT-MULTIPLE DAYS</title>
	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/trim.js"></script>

	<script>

		function doOnLoad(){//to hide text area having "" value
		
		var elem = document.getElementById('frmPitchOutfieldReportFiveDays').elements;
			for(var i = 0; i < elem.length; i++){
				if(elem[i].type == 'textarea'){
					if(elem[i].id.substring(0,3) == 'rem'){
						var remarkTextArea = document.getElementById( elem[i].id );
						if(remarkTextArea.innerHTML == ""){
							var divId = elem[i].id.replace('rem', 'remDiv' )
							document.getElementById(divId).style.display='none';
						}		
					}
					
				}
				
			}
		}
		
		function validate(){
			var isComplete = true;
			var elem = document.getElementById('frmPitchOutfieldReportFiveDays').elements;
			var message=""
			var removeTag=""
			var id = ""
					
			for(var i = 0; i < elem.length; i++){
				if(elem[i].type == 'select-one') {
					if(elem[i].disabled == false && elem[i].value == '0'){//not selected cmb
						if(i == 0){
							id = elem[i].id;
							id=id.substring(0,id.indexOf('_'))
							removeTag = document.getElementById( 'que_'+id ).innerHTML.replace('<B>','')
							removeTag = removeTag.replace('</B>','')
							removeTag = removeTag.replace('&nbsp;','')
							message = message +"\n"+ removeTag
						}else{
							id = elem[i].id;
							var prevId = elem[i-2].id;
							id=id.substring(0,id.indexOf('_'))
							prevId=prevId.substring(0,prevId.indexOf('_'))
							if(id != prevId){
								removeTag = document.getElementById( 'que_'+id ).innerHTML.replace('<B>','')
								removeTag = removeTag.replace('<BR>&nbsp;&nbsp;','')
								removeTag = removeTag.replace('</B>','')
								removeTag = removeTag.replace('<BR>&nbsp;&nbsp;','')
								removeTag = removeTag.replace('&nbsp;','')
								message = message +"\n"+ removeTag
							}	
						}	
						isComplete = false;
					}
				}
			}
			if(isComplete){
				document.getElementById("hid").value = "1";
				document.frmPitchOutfieldReportFiveDays.submit();
			}else{
				if(message != ""){
					alert( "Please select answers for following questions : \n"+ message ) ;
					setFocus();
					return false
				}else{
					document.getElementById("hid").value = "1";
					document.frmPitchOutfieldReportFiveDays.submit();
				}
			}
		}
		
		function setFocus(){
			var elem = document.getElementById('frmPitchOutfieldReportFiveDays').elements;
			var flag = "false"
							
			for(var i = 0; i < elem.length; i++){
				if(flag == "false"){
					if(elem[i].type == 'select-one') {
						if(elem[i].disabled == false && elem[i].value == '0'){//not selected cmb
							var id = elem[i].id;
							document.getElementById(id).focus()
							flag = "true"
						}
					}
				}
			}
		}
		
		function enterRemark(id){
			if(document.getElementById("remAnch_"+id ).disabled == false){
				
				var remarkDiv = document.getElementById( 'remDiv_'+id );
				var remarkTextArea = document.getElementById( 'rem_'+id );
				if( remarkDiv.style.display == 'none' ){
					document.getElementById("remAnch_"+id ).innerHTML="-"
					remarkDiv.style.display = ''
					remarkTextArea.focus();
				}
				else{
					document.getElementById("remAnch_"+id ).innerHTML="+"
					if(remarkTextArea.innerHTML == ""){
						remarkDiv.style.display = 'none'
					}
				}
			}	
		}

		/*function restrict(mytextarea) {  
			alert("rest");
			var maxlength = 5; // specify the maximum length  
			if (mytextarea.value.length > maxlength){  
				mytextarea.value = mytextarea.value.substring(0,maxlength); 
				alert("Max Length for remark is 500 characters")	; 
			}
		}*/
		function getKeyCode(e){
		 if (window.event)
		        return window.event.keyCode;
		 else if (e)
		    return e.which;
		 else
		    return null;
		}
		
		function imposeMaxLength(Object, MaxLen,event,id,flag){
			
		  if(flag == 1){
			  if(Object.value.length > MaxLen){
				alert("Please enter maximum 500 characters only.")
				document.getElementById(id).focus()
				return false
			  }	else{
				return true
			  }			  
		  }
		  var keyvalue = getKeyCode(event);
		  if(keyvalue==8 || keyvalue==0 || keyvalue==1){
			return true;
		  }else{
			/*  if(Object.value.length > MaxLen){
					alert("falg 2 Please enter maximum 500 characters only.")
					document.getElementById(id).focus()
					return false
			 }else{*/	
			    return (Object.value.length < MaxLen);
			// }
		  }	
		}
		
		function callTooltip(id){
			document.getElementById("remAnch_"+id).title = document.getElementById("rem_"+id).innerHTML
		}
	</script>
	</head>
<body>
<table align="center" style="width: 84.5em;">
    <tr>
    	<td align="center">

<div style="width:84.5em">
<jsp:include page="Menu.jsp"></jsp:include>

	<form name="frmPitchOutfieldReportFiveDays" id="frmPitchOutfieldReportFiveDays" method="post">
	<br>
	<br>	
		<table width="100%" border="0" cellpadding="2" cellspacing="1" class="table">
			<tr align="left">
				<td align="left" colspan="2" class="legend">Pitch and Outfield Report - Five Days Game</td>
			</tr>
			<tr>
				<td colspan="9" align="right">Export : <a
					href="/cims/jsp/PDFPitchOutfieldReportFiveDays.jsp" target="_blank">
				<img src="/cims/images/pdf.png" height="20" width="20" /> </a> 
				<a href="/cims/jsp/EXCELRefereeReportOnUmpires.jsp" target="_blank">
				<img src="/cims/images/excel.jpg" height="20" width="20" /> </a></td>
			</tr>
			<tr>
				<td colspan="2" class="contentDark" colspan="2" align="right"><b><%=loginUserName%>&nbsp;&nbsp;&nbsp;DATE :</b> <%=sdf.format(new Date())%></td>				
			</tr>
		
		
<%	if(matchSummeryCrs != null){  
			while(matchSummeryCrs.next()){				
%>			<tr class="contentLight">
				 <td width="15%" ><b>Match:</b></td>
				 <td width="80%"  ><%=matchSummeryCrs.getString("id")%></td>
			</tr>
		    <tr class="contentDark">
		        <td width="15%"  ><b>Teams :</b></td>
				<td width="80%"  class="contentDark"><%=matchSummeryCrs.getString("team1")%>
													&nbsp;&nbsp;&nbsp;Vs&nbsp;&nbsp;&nbsp;
													<%=matchSummeryCrs.getString("team2")%>
													</td>
			</tr>										
			<tr class="contentLight">										
		        <td width="15%"><b>Match Date : </b></td>
		<%if (matchSummeryCrs.getString("displaymatchdate") == null || matchSummeryCrs.getString("displaymatchdate").equals("")) {%>
				<td align="left">-</td>
		<%} else {
		String displayDate = null;
		java.util.Date date = ddmmyyyy.parse(matchSummeryCrs.getString("displaymatchdate"));
		displayDate = sdf.format(date);
		%>
			<td width="80%" ><%=displayDate%></td>
		<%}%>
					
		    </tr>
		    <tr  class="contentDark">
		        <td width="15%"><b>Venue:</b></td>
		        <td width="80%" ><%=matchSummeryCrs.getString("venue")%></td>
		    </tr>
			<tr class="contentLight">
				<!--From System-->
				<td width="15%" align="left">Name Of the Referee :</td>
				<%
					if (matchSummeryCrs.getString("referee") == null
					|| matchSummeryCrs.getString("referee").equals("")) {
				%>
				<td>----</td>
				<%
					} else {
				%>
				<td align="left"><%=matchSummeryCrs.getString("referee")%></td>
				<%
					}
				%>
				<%--			<td ></td>--%>
			</tr>
			<tr class="contentDark">
				<td width="15%" align="left">Name Of Tournament :</td>
				<%
					if (matchSummeryCrs.getString("tournament") == null
					|| matchSummeryCrs.getString("tournament").equals("")) {
				%>
				<td>----</td>
				<%
					} else {
				%>
				<td align="left"><%=matchSummeryCrs.getString("tournament")%></td>
				<%
					}
				%>
				<%--			<td ></td>--%>
			</tr>
<%	
//days = matchSummeryCrs.getInt("days");//days

		//java.util.Date 	date = sdfyyyymmdd.parse(matchSummeryCrs.getString("startdate"));
//System.out.println("date  "+date);     
//calendar.add(date, 1);
//System.out.println("date +  1"+calendar.add(Calendar.date, 1));
			 startDate = matchSummeryCrs.getString("startdate");//yyyy-mm-dd
			 endDate = matchSummeryCrs.getString("enddate");//yyyy-mm-dd
			 days = matchSummeryCrs.getInt("days");//days
			 System.out.println("days   "+days);
			 int startDay = Integer.parseInt(startDate.substring(8).trim());
 			 int startDayMonth = Integer.parseInt(startDate.substring(5,7).trim());
			 int startDayYear = Integer.parseInt(startDate.substring(0,4).trim());
			 System.out.println("startDayMonth" +   startDayMonth);
			 System.out.println("startDate" +   startDate);

		String firstDate="";
    	//String allDays = "";
		
		
		cal.set(startDayYear, (startDayMonth-1), startDay);
	    cal.add(Calendar.DATE, 0);
	    firstDate=new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	    allDays = firstDate+"~";
	    for(int i=1;i< days;i++){
			cal.add(Calendar.DATE, 1);
		    allDays = allDays + new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime())+"~";
		}
	    System.out.println("allDays "+allDays);
			
			}//end while
	}//end if
	
	
	//String matchDays = 
%>		</table>

		<br>
		<br>
<%			if(flag.equalsIgnoreCase("true")){
%>			<table>
				<tr>
					<td class="message">
						<%=message%>
					</td>
				</tr>
			</table>			
<%				
			}	
%>
<% try{ %>
			
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		
<%  String[] allDaysArr = null;	 
	if (displayCrs != null) {

			int counter = 1;
			int occurance=0;
			allDaysArr = allDays.split("~");
			
			while (displayCrs.next()) {
			String scoreValues = displayCrs.getString("score_max").toString();
			String remarkData = displayCrs.getString("remark").toString();
			String[] scoreMaxArr = scoreValues.split("~");	
			String[] remarkArr = remarkData.split("~");	
			occurance = displayCrs.getInt("occurence");
			
				
				if(counter % 2 != 0) { %>			
				<tr class="contentDark">
			<% }else{ %>			
				<tr class="contentLight">
			<% } %>
					<td width="86%" nowrap id="que_<%=displayCrs.getString("rolefacilityid")%>">.&nbsp;<b><%=displayCrs.getString("description")%></b></td>
				
<%				//}
				
				if(occurance == 1){

					sbIds.append(displayCrs.getString("rolefacilityid"));
					sbIds.append(",");
					sbIds.append(displayCrs.getString("scoring_required"));
					sbIds.append(",");

				ids.add(displayCrs.getString("rolefacilityid"));
				ids.add(displayCrs.getString("scoring_required"));
				}else{//occurance >1 (4/5)
					sbIdsOccurance.append(displayCrs.getString("rolefacilityid"));
					sbIdsOccurance.append(",");
					sbIdsOccurance.append(displayCrs.getString("scoring_required"));
					sbIdsOccurance.append(",");

				
				}
//System.out.println("sbIds  "+sbIds.toString());
//System.out.println("sbIdsOccurance "+sbIdsOccurance.toString());
				for(int i=1 ; i<=occurance ; i++){ %>
				<td valign="top">
<%				//}

				if (displayCrs.getString("scoring_required").equalsIgnoreCase("Y")) {//for combo
					String[] valueArr = displayCrs.getString("cnames").toString().split(",");%> 					
					<select style="width:3cm" name="<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" id="<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>">
<%					if(scoreMaxArr[i-1].trim().equalsIgnoreCase("0")){%>
						<option value="0" selected="selected">- Day <%=i%> -</option>
<%					}else{
%>						<option value="0">- Select -</option>
<%					}
					for (int count = valueArr.length; count > 0; count--) {
						if(scoreMaxArr[i-1].trim().equalsIgnoreCase(""+count)){
%>						<option value="<%=count%>" selected="selected"><%=valueArr[count - 1]%></option>
<%						}else{
%>						<option value="<%=count%>"><%=valueArr[count - 1]%></option>
<%						}
					}%>					
					</select>
				
<%					try{
					if(remarkArr[i-1].trim().equalsIgnoreCase("")){//remark1~remark2~remark3 so on 
%>						<div id="remDiv_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="remDiv_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" style="display:none">
							&nbsp;<textarea class="textAreaPitch" id="rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" maxlength="500" onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>','2')"><%=remarkArr[i-1].trim().equalsIgnoreCase("0")? "":remarkArr[i-1].trim()%></textarea>
						</div>
<%					}else{
%>						<div id="remDiv_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="remDiv_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" >
							&nbsp;<textarea class="textAreaPitch" id="rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>"  maxlength="500" onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>','2')"><%=remarkArr[i-1].trim().equalsIgnoreCase("0")? "":remarkArr[i-1].trim()%></textarea>
						</div>	
<%					}
					}catch( ArrayIndexOutOfBoundsException e ) { 
					
  				    }
				} else {
					try{
					if(remarkArr[i-1].trim() != null){ 
%>						&nbsp; <textarea  class="textAreaPitch" id="<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>"  maxlength="500" onblur="imposeMaxLength(this,500,event,'<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>','2')"><%=remarkArr[i-1].trim()%></textarea>

<%					}else{
%>						 &nbsp;<textarea class="textAreaPitch" id="<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>"  maxlength="500" onblur="imposeMaxLength(this,500,event,'<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>','2')"><%=remarkArr[i-1].trim()%></textarea>

<%					}		
%>						<div id="remDiv_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="remDiv_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" style="display:none">
<%						if(remarkArr[i-1].trim().equalsIgnoreCase("0")){
%>							<textarea class="textAreaPitch" id="rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" maxlength="500" onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>','2')"><%=remarkArr[i-1].trim() %></textarea>
<%						} %>	
						</div>
<%					}catch( ArrayIndexOutOfBoundsException e ) { 
					}
				}//end else
				if(occurance == 1){
				}else{
%>				&nbsp;&nbsp;&nbsp;&nbsp;
<%				}
%>
				</td>
<%		if(!(userRole.equals("9"))){
%>
				<td class="anchbold" width="2%">
<%				
				if (displayCrs.getString("scoring_required").equalsIgnoreCase("Y")) {//combo
				try{
					if(remarkArr[i-1].trim() == null || !(remarkArr[i-1].trim().equalsIgnoreCase("0"))){
%>					
						<a title="Remark" href="javascript:void('')" id="remAnch_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="remAnch_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" onmouseover="callTooltip('<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>')" onclick="enterRemark('<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>')">-</a>
<%					}else{

%>						<a title="Remark" href="javascript:void('')" id="remAnch_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="remAnch_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" onmouseover="callTooltip('<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>')" onclick="enterRemark('<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>')">+</a>
<%					}
				}catch( ArrayIndexOutOfBoundsException e ) { 
				}
%>
<%				}else{
%>						<a  href="javascript:void('')" id="remAnch_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>" name="remAnch_<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>"  onclick="enterRemark('<%=displayCrs.getString("rolefacilityid")+"_"+allDaysArr[i-1]%>')"></a>
<%				}
%>						
				</td>
<%				if(occurance == 1){%>
					<td colspan="<%=(days-1)*2%>">&nbsp;</td>
<%				}			
%>				
<%		}else if(userRole.equals("9") && occurance == 1){%>
			<td colspan="3">&nbsp;</td>
<%		}
%>		
<%			}//for end
				
%>
			</tr>
<%			counter++;
		}//end while
	}//end if
%>		<input type="hidden" id="hid" name="hid" />
		<input type="hidden" id="hidden_ids" name="hidden_ids" value="<%=sbIds%>" />
		<input type="hidden" id="hidden_ids_occurance" name="hidden_ids_occurance" value="<%=sbIdsOccurance%>" />
		<input type="hidden" id="hiddenDates" name="hiddenDates" value="<%=allDays%>" />
		
		</table>
<% }catch(Exception e){
	e.printStackTrace();
	}
%>
		<br>
		NOTE : Please enter maximum 500 characters for remark.
		<br>
		<br>
<%		if(!(userRole.equals("9"))){
%>	
		<center><input class="btn btn-warning" type="button" align="center" value="Submit" onclick="validate()">
<%		}
%>			
		<input type="hidden" id="umpire" name="umpire" value="<%=umpireOfficialId%>" />
		<table width="1000" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
			<tr>
				<td>
					<jsp:include page="admin/Footer.jsp"></jsp:include>
				</td>
			</tr>
		</table>
	</form>
	</div>
	</td>
	</tr>
	</table>
</body>
<script>
doOnLoad()
</script>
</html>

