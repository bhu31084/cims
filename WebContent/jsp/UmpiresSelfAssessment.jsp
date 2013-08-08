<!--
Page Name 	 : UmpiresSelfAssessment.jsp
Created By 	 : Dipti Shinde.
Created Date : 9th sept 2008
Description  : Pitch and outfield report
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 16/09/2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.common.*"%>
<%
		
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
		String reportId = "7";
		String matchId = null;
		String userID = null;
		String loginUserName = null;
		String message = null;
		String messageFlag = null;
		String appruval = null;
		String umpireOfficialId = null;
		String flag = "false";//for displaying message
		String appruvalFlag = "false";
		String appMessageFlag = null;
		String appMessage = null;
		String user_role = "";
		int noUmpMessage = 0;

		String role = "2"; //For umpire
		LogWriter log = new LogWriter();
		StringBuffer sbIds = new StringBuffer();
		ReplaceApostroph replaceApos = new ReplaceApostroph();

		if(session.getAttribute("matchid") == null){
			System.out.println("sdfgsdfgsdfdffas");
		}
		String gsflag = request.getParameter("flag")!=null?request.getParameter("flag"):"0";
		if(gsflag.equalsIgnoreCase("1")){
			matchId = request.getParameter("match");
			//loginUserName = request.getParameter("umpire");
			//userID = request.getParameter("umpire_id");
			loginUserName = session.getAttribute("usernamesurname").toString();
			userID = session.getAttribute("userid").toString();
			user_role = session.getAttribute("role").toString();
		}else{
			matchId = session.getAttribute("matchid").toString();
			loginUserName = session.getAttribute("usernamesurname").toString();
			userID = session.getAttribute("userid").toString();
			user_role = session.getAttribute("role").toString();
		}	


		CachedRowSet matchSummeryCrs = null;
		CachedRowSet submitCrs = null;
		CachedRowSet displayCrs = null;
		CachedRowSet umpiresCrs = null;
		CachedRowSet useridCrs = null;
		CachedRowSet messageCrs = null;
		CachedRowSet appruvalCrs = null;
		CachedRowSet AdminUmp1 = null;
		CachedRowSet AdminUmp2 = null;

		String umpireName1 = null;
		String umpireName2 = null;
	
		GenerateStoreProcedure generateStProc = new GenerateStoreProcedure(
				matchId);
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");

		Vector ids = new Vector();
		Vector spParamVec = new Vector();
		String score = request.getParameter("hdSelectedValue");//e.g."1:1~2:2~3:0"		
		String scoreRequired = (String) request.getParameter("hdScoreRequired");//e.g."1:1~2:2~3:0"		

		//for match details in top table
		spParamVec.add(matchId); // match_id
		try{
			matchSummeryCrs = generateStProc.GenerateStoreProcedure(
				"esp_dsp_matchdetails_pitchreport", spParamVec, "ScoreDB");
		}catch (Exception e) {
				System.out.println("*************UmpiresSelfAssessment.jsp*****************"+e);
				log.writeErrLog(page.getClass(),matchId,e.toString());
		}		

		if (user_role.equals("9")) {
			spParamVec = new Vector<String>();
			spParamVec.add(matchId);
			spParamVec.add(role);
			try{
				umpiresCrs = generateStProc.GenerateStoreProcedure(
					"esp_dsp_getMatchConcerns", spParamVec, "ScoreDB");
				noUmpMessage = 	umpiresCrs.size();	
			}catch (Exception e) {
				System.out.println("*************UmpiresSelfAssessment.jsp*****************"+e);
				log.writeErrLog(page.getClass(),matchId,e.toString());
			}
		if(noUmpMessage > 0){		
			if(umpiresCrs.next()){
				umpireName1 = umpiresCrs.getString("namesurname");
				spParamVec.removeAllElements();
				spParamVec.add(matchId); // match_id
				spParamVec.add(umpiresCrs.getString("id"));
				spParamVec.add(umpiresCrs.getString("official"));
				spParamVec.add(reportId); // report id
			try{
				AdminUmp1 = generateStProc.GenerateStoreProcedure(
						"esp_dsp_umpirereports", spParamVec, "ScoreDB");
			}catch (Exception e) {
				System.out.println("*************UmpiresSelfAssessment.jsp*****************"+e);
				log.writeErrLog(page.getClass(),matchId,e.toString());
			}				
			}
			
			if(noUmpMessage > 1){	
				if(umpiresCrs.next()){
					umpireName2 = umpiresCrs.getString("namesurname");
					spParamVec.removeAllElements();
					spParamVec.add(matchId); // match_id
					spParamVec.add(umpiresCrs.getString("id"));
					spParamVec.add(umpiresCrs.getString("official"));
					spParamVec.add(reportId); // report id
					
					try{					
						AdminUmp2 = generateStProc.GenerateStoreProcedure(
							"esp_dsp_umpirereports", spParamVec, "ScoreDB");				
					}catch (Exception e) {
						System.out.println("*************UmpiresSelfAssessment.jsp*****************"+e);
						log.writeErrLog(page.getClass(),matchId,e.toString());
					}			
				}
			}	//end if noUmpMessage > 1
		}//end if noUmpMessage > 0
			
		} else {
			if (request.getParameter("hid") != null
					&& request.getParameter("hid").equalsIgnoreCase("1")) {

				System.out.println("ids : "
						+ request.getParameter("hidden_ids"));

				String[] retrieve_ids = request.getParameter("hidden_ids")
						.split(",");
				int retrieve_ids_length = retrieve_ids.length;

				umpireOfficialId = request.getParameter("umpire");

				for (int count = 0; count < retrieve_ids_length; count = count + 2) {
					System.out.println(request
							.getParameter(retrieve_ids[count])
							+ " : " + retrieve_ids[count + 1]);
					spParamVec = new Vector();
					spParamVec.add(matchId);
					spParamVec.add(userID);
					spParamVec.add(umpireOfficialId);
					spParamVec.add(retrieve_ids[count]);

					if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {//combo
						spParamVec.add(request.getParameter(retrieve_ids[count]));
						spParamVec.add(replaceApos.replacesingleqt((String) request.getParameter("rem_"+ retrieve_ids[count])));
					} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {//text
						spParamVec.add("0");
						spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter("rem_"+retrieve_ids[count])));
					}

					spParamVec.add(reportId);
					try{
						messageCrs = generateStProc.GenerateStoreProcedure(
							"esp_amd_userappraisal", spParamVec, "ScoreDB");
					}catch (Exception e) {
						System.out.println("*************UmpiresSelfAssessment.jsp*****************"+e);
						log.writeErrLog(page.getClass(),matchId,e.toString());
					}			
						
				}
				
				if (messageCrs.next()) {
					messageFlag = messageCrs.getString("retflag");//number 1,2,3
					message = messageCrs.getString("retval");//message string
					flag = "true";//to display messg or not
					appruvalFlag ="true";//for appruval button
				}
				
				if (request.getParameter("hidAppruve") != null
					&& request.getParameter("hidAppruve").equalsIgnoreCase("1")) {		
						spParamVec.removeAllElements();
						spParamVec.add(umpireOfficialId);
						spParamVec.add(userID);
						spParamVec.add(matchId);
						spParamVec.add("1");	
						try{	
							appruvalCrs = generateStProc.GenerateStoreProcedure(
								"esp_amd_umpirecoachapproval", spParamVec, "ScoreDB");	
						}catch (Exception e) {
							System.out.println("*************UmpiresSelfAssessment.jsp*****************"+e);
							log.writeErrLog(page.getClass(),matchId,e.toString());
						}			
							
						if (appruvalCrs.next()) {
							appMessageFlag = appruvalCrs.getString("retval");
							appMessage = appruvalCrs.getString("remark");
							
							if(appMessageFlag.trim().equalsIgnoreCase("1")){//Ump coach exists
								message = "";	
								appruvalFlag ="false";//to hide approval button
							}else{//No Ump coach 
								message = appMessage;	
								appruvalFlag ="true";//to show approval button
							}
						}
				}
			}

			//For Display Table Data
			spParamVec.removeAllElements();
			spParamVec.add(matchId); // match_id
			spParamVec.add(userID);
			try{
				umpiresCrs = generateStProc.GenerateStoreProcedure(
					"esp_dsp_getmatchofficialid_umpire", spParamVec, "ScoreDB");//to get official id of umpire
			}catch (Exception e) {
					System.out.println("*************UmpiresSelfAssessment.jsp*****************"+e);
					log.writeErrLog(page.getClass(),matchId,e.toString());
			}			
			if (umpiresCrs.next()) {
				umpireOfficialId = umpiresCrs.getString("official");
			}
			spParamVec.add(umpireOfficialId);
			spParamVec.add(reportId); // report id
			try{
				displayCrs = generateStProc.GenerateStoreProcedure(
					"esp_dsp_umpirereports", spParamVec, "ScoreDB");
			}catch (Exception e) {
				System.out.println("*************UmpiresSelfAssessment.jsp*****************"+e);
				log.writeErrLog(page.getClass(),matchId,e.toString());
			}			
		}

		%>
<html>
<head>
<title>UMPIRES SELF - ASSESSMENT</title>
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
<link href="../css/form.css" rel="stylesheet" type="text/css" />
<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
<script language="JavaScript"
	src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>
<script language="JavaScript"
	src="<%=request.getContextPath()%>/js/trim.js"></script>
</head>
<script>
		function validate(){
			var isComplete = true;
			var elem = document.getElementById('frmUmpiresAssessment').elements;
			var message=""
					
			for(var i = 0; i < elem.length; i++){
				if(elem[i].type == 'select-one') {
					if(elem[i].disabled == false && elem[i].value == '0'){//not selected cmb
						var id = elem[i].id;
						var removeTag = document.getElementById( 'que_'+id ).innerHTML.replace('<B>','')
						removeTag = removeTag.replace('</B>','')
						removeTag = removeTag.replace('&nbsp;','')
						message = message +"\n"+ removeTag
						isComplete = false;
					}
				}
			}
			
			if(isComplete){
				document.getElementById("hid").value = "1";
				document.frmUmpiresAssessment.submit();
			}else{
				alert( "Please select answers for following questions : \n"+ message ) ;
				setFocus();
				return false
			}
		}
		
		function setFocus(){
			var elem = document.getElementById('frmUmpiresAssessment').elements;
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
			var remarkDiv = document.getElementById( 'remDiv_'+id );
			var remarkTextArea = document.getElementById( 'rem_'+id );
			if( remarkDiv.style.display == 'none' ){
				remarkDiv.style.display = ''
				remarkTextArea.focus();
			}else{
				if(remarkTextArea.innerHTML == ""){
					remarkDiv.style.display = 'none'
				}
			}
		}
		
		function appruve(){
			document.getElementById("hid").value = "1";
			document.getElementById("hidAppruve").value = "1";
			document.frmUmpiresAssessment.submit();
			//document.getElementById('appruvalDiv').style.display='none'
		}

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
<body>
<table align="center" style="width: 84.5em;">
    <tr>
    	<td align="center">
<div style="width:84.5em">
<% 	if(!gsflag.equalsIgnoreCase("1")){
%>		<jsp:include page="Menu.jsp"></jsp:include>
		<br><br>
		
<%	} %>
<form name="frmUmpiresAssessment" id="frmUmpiresAssessment"
	method="post">
	<%//if(!(noUmpMessage == 0)){
%>
	
	
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
		<tr>
			<td colspan="9" bgcolor="#FFFFFF" class="legend">Umpire's Self Assessment Report</td>
		</tr>
		<%if (user_role.equals("9")) { %>
		<tr>
			<td colspan="9" align="right">
			Export : 
				<a href="/cims/jsp/PDFUmpiresSelfAssessment.jsp">
					<img src="/cims/images/pdf.png" height="20" width="20" />
				</a>
				<a href="/cims/jsp/ExcelUmpiresSelfAssessment.jsp">
					<img src="/cims/images/excel.jpg" height="20" width="20" />
				</a>
			</td>
		</tr>
		<%} %>
		<tr>
<%if (user_role.equals("9")) {
%>			<td colspan="2" width="100%" class="contentLight" align="right"><b><%=loginUserName%>&nbsp;&nbsp;&nbsp;DATE
			:</b> <%=sdf.format(new Date())%></td>
<%}else{%>
			<td colspan="2" width="100%" class="contentDark" align="right"><b><%=loginUserName%>&nbsp;&nbsp;&nbsp;DATE
			:</b> <%=sdf.format(new Date())%></td>
<%}%>			
		</tr>
	
<%
		if (matchSummeryCrs != null) {
		String umpire2name = null;
		String umpire1name = null;
			while (matchSummeryCrs.next()) {
			if (!user_role.equals("9")) {
			
				if(userID.equalsIgnoreCase(matchSummeryCrs.getString("umpire1Id"))){
					umpire2name = matchSummeryCrs.getString("umpire2");
					if(umpire2name == null){
						umpire2name = "-";
					}
				}			
%>			

		<tr class="contentLight">
			<td width="20%"><b>Partner Name: <b></td>
<%--			<td width="80%"><%=matchSummeryCrs.getString("umpire2").trim().equalsIgnoreCase("null") || matchSummeryCrs.getString("umpire2").trim().equalsIgnoreCase("")? "-" : matchSummeryCrs.getString("umpire2")%></td>--%>
				<td width="80%"><%=umpire2name%></td>
		</tr>
<%				}else{
					umpire1name = matchSummeryCrs.getString("umpire1");
					if(umpire1name == null){
						umpire1name = "-";
					}
%>		

		
		<tr class="contentLight">
			<td width="15%"><b>Partner Name: <b></td>
			<td width="80%"><%=umpire1name%></td>
		</tr>
	
<%				}//end else
			
%>
		<tr class="contentDark">
			<td width="15%"><b>Teams :</b></td>
			<td width="80%"><%=matchSummeryCrs.getString("team1").trim().equalsIgnoreCase("null")? "-" : matchSummeryCrs.getString("team1")%>
			&nbsp;&nbsp;&nbsp;Vs&nbsp;&nbsp;&nbsp; <%=matchSummeryCrs.getString("team2").trim().equalsIgnoreCase("null")? "-" : matchSummeryCrs.getString("team2")%>
			</td>
		</tr>
		<tr class="contentLight">
			<td width="15%"><b>Venue : <b></td>
			<td width="80%"><%=matchSummeryCrs.getString("venue").trim().equalsIgnoreCase("null")? "-" : matchSummeryCrs.getString("venue")%></td>
		</tr>
		<tr class="contentDark">
			<td width="15%"><b>Type Of Match : <b></td>
			<td width="80%"><%=matchSummeryCrs.getString("matchtype").trim().equalsIgnoreCase("null")? "-" : matchSummeryCrs.getString("matchtype")%></td>
		</tr>
<%	if(umpireName1 == null || umpireName2 == null){		
%>
		<tr class="contentLight">
			<td width="15%"><b>Umpires :<b></td>
			<td width="80%" colspan="3">Umpires not assigned for this match </td>
		</tr>	
		
		
<%	}
%>		<tr class="contentLight">
			<td width="15%"><b>Match Id: <b></td>
			<td width="80%"><%=matchId%></td>
		</tr>
		<tr class="contentDark">
				<td width="15%" align="left">Name Of Tournament :</td>
				<%
					if (matchSummeryCrs.getString("tournament") == null
											|| matchSummeryCrs.getString(
													"tournament").equals("")) {
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
<%
			}//end while
		}//end if
%>
	</table>


<%if (user_role.equals("9")) {
%>
<br>
<br>
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
<%	if(umpireName1 != null || umpireName2 != null){
%>	
	<tr class="contentLight">
		<td colspan="3" class="headinguser">Umpire's self-ratings & comments on their
		performance  <td>
	</tr>
	
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr class="contentLight">
		<td align="right">Umpires : </td>
		<td align="center"><%=umpireName1 == null ? "-" : umpireName1%></td>
		<td align="center"><%=umpireName2 == null ? "-" : umpireName2%></td>
	</tr>
<%	}//else{
%>	
	
<%	//}	
%>
	</td>
	<%
		if ((AdminUmp1!= null) && (AdminUmp2!= null)) {	
			if ((AdminUmp1.size() > 0) && (AdminUmp2.size() > 0)) {
				int counter = 1;
				while (AdminUmp1.next() && AdminUmp2.next()) {

					if (counter % 2 != 0) {%>
	<tr class="contentDark">
		<%} else {%>
	<tr class="contentLight">
		<%}%>

		<td><b>.&nbsp;<%=AdminUmp1.getString("description")%></b></td>
		<td align="center"><%
					if (AdminUmp1.getString("scoring_required")
							.equalsIgnoreCase("Y")) {
						String[] valueArr = AdminUmp1.getString("cnames")
								.toString().split(",");
						for (int count = valueArr.length; count > 0; count--) {
							if (AdminUmp1.getString("selected")
									.equalsIgnoreCase("" + count)) {
%>					 		<font color="#216EE2"><%=valueArr[count - 1]%></font> <%
							}
						}
								
						if (!(AdminUmp1.getString("remark").trim().equalsIgnoreCase(""))) {//to display remark for combo for entered values(for admin)
%>							 <textarea disabled="disabled" class="textArea" rows="4" cols="20"
								maxlength="500"><%=AdminUmp1.getString("remark").trim()%></textarea>
<%						}
					} else {
						if (AdminUmp1.getString("remark") != null) {
%>						 <textarea disabled="disabled" class="textArea" rows="4" cols="20"
							maxlength="500"><%=AdminUmp1.getString("remark").trim()%></textarea>
<%						} else {%> <textarea disabled="disabled" class="textArea" rows="4"
							cols="20" maxlength="500"><%=AdminUmp1.getString("remark").trim()%></textarea>
<%						}
					}
%>      </td>

		
<%		//AdminUmp2		
			if(AdminUmp2 != null){	
			if(AdminUmp2.size() > 0){		
%>			<td align="center">
<%						if (AdminUmp2.getString("scoring_required")
							.equalsIgnoreCase("Y")) {
						String[] valueArr = AdminUmp2.getString("cnames")
								.toString().split(",");
						for (int count = valueArr.length; count > 0; count--) {
							if (AdminUmp2.getString("selected")
									.equalsIgnoreCase("" + count)) {
%> 							<font color="#216EE2"><%=valueArr[count - 1]%></font> <%
							}
						}
						if (!(AdminUmp2.getString("remark").trim().equalsIgnoreCase(""))) {//to display remark for combo for entered values(for admin)
%> 								<textarea disabled="disabled" class="textArea" rows="4" cols="20"
								maxlength="500"><%=AdminUmp2.getString("remark").trim()%></textarea>
<%						}
					} else {
						if (AdminUmp2.getString("remark") != null) {
%> 								<textarea disabled="disabled" class="textArea" rows="4" cols="20"
								maxlength="500"><%=AdminUmp2.getString("remark").trim()%></textarea>
<%						} else {%> <textarea disabled="disabled" class="textArea" rows="4"
								cols="20" maxlength="500"><%=AdminUmp2.getString("remark").trim()%></textarea>
<%						}
		
					}
%>					
			</td>		
<%			}	else {
%>
			<td>&nbsp;
			</td>
<%	
			}	
			}//AdminUmp2!=null		
%>	


	</tr>
	<%
	counter++;
				}//end while
			}//end if
		}//chk for null	
			%>
</table>

<%} else {%>
<br>
<br>
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<tr class="contentLight" >
		<td colspan="2" class="headinguser">My Self-Ratings & My comments on my
		performance</td>
	</tr>
	<tr>
		<td colspan="2">
			&nbsp;
		</td>
	</tr>
	<tr align="center">
<%		if(flag.equalsIgnoreCase("true")){
%>		<td align="center" colspan="2">
			<table align="center">
				<tr>
					<td class="message">
						<%=message%>
					</td>
				</tr>
			</table>			
		</td>	
<%				
		}	
%>	
	</tr>
	</td>
	<%
			if (displayCrs != null) {
				int counter = 1;
				while (displayCrs.next()) {
					sbIds.append(displayCrs.getString("id"));
					sbIds.append(",");
					sbIds.append(displayCrs.getString("scoring_required"));
					sbIds.append(",");

					ids.add(displayCrs.getString("id"));
					ids.add(displayCrs.getString("scoring_required"));

					if (counter % 2 != 0) {
					%>
	<tr class="contentDark">
		<%} else {
					%>
	<tr class="contentLight">
		<%}
%>
		<td id="que_<%=displayCrs.getString("id")%>"><b>.&nbsp;<%=displayCrs.getString("description")%></b></td>
		<td><%
					if (displayCrs.getString("scoring_required")
							.equalsIgnoreCase("Y")) {
						String[] valueArr = displayCrs.getString("cnames")
								.toString().split(",");
%> <select style="width:2.5cm" name="<%=displayCrs.getString("id")%>" id="<%=displayCrs.getString("id")%>">
<%					if(displayCrs.getString("selected").equalsIgnoreCase("0")){%><option value="0" selected="selected">- Select -</option>
<%					}else{
%>						<option value="0">- Select -</option>
<%					}
					for (int count = valueArr.length; count > 0; count--) {
						if(displayCrs.getString("selected").equalsIgnoreCase(""+count)){
%>						<option value="<%=count%>" selected="selected"><%=valueArr[count - 1]%></option>
<%						}else{
%>						<option value="<%=count%>"><%=valueArr[count - 1]%></option>
<%						}
					}
%>					</select>

		<a id="remAnch_<%=displayCrs.getString("id")%>"
			name="remAnch_<%=displayCrs.getString("id")%>"
			href="javascript:void('')"
			onmouseover="callTooltip('<%=displayCrs.getString("id")%>')"
			onclick="enterRemark('<%=displayCrs.getString("id")%>')">Remark</a> <%
						if (displayCrs.getString("remark").trim()
								.equalsIgnoreCase("")) {
%>
		<div id="remDiv_<%=displayCrs.getString("id")%>"
			name="remDiv_<%=displayCrs.getString("id")%>" style="display:none"><textarea
			class="textArea" id="rem_<%=displayCrs.getString("id")%>"
			name="rem_<%=displayCrs.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("id")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
		</div>
		<%
						} else {
							%>
		<div id="remDiv_<%=displayCrs.getString("id")%>"
			name="remDiv_<%=displayCrs.getString("id")%>"><textarea
			class="textArea" id="rem_<%=displayCrs.getString("id")%>"
			name="rem_<%=displayCrs.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("id")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
		</div>
		<%
						}
					} else {%>
		<a id="remAnch_<%=displayCrs.getString("id")%>"
			name="remAnch_<%=displayCrs.getString("id")%>"
			href="javascript:void('')"
			onmouseover="callTooltip('<%=displayCrs.getString("id")%>')"
			onclick="enterRemark('<%=displayCrs.getString("id")%>')">Remark</a>	<%		
					if (displayCrs.getString("remark").trim()
								.equalsIgnoreCase("")) {
%>
		<div id="remDiv_<%=displayCrs.getString("id")%>"
			name="remDiv_<%=displayCrs.getString("id")%>" style="display:none"><textarea
			class="textArea" id="rem_<%=displayCrs.getString("id")%>"
			name="rem_<%=displayCrs.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("id")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
		</div>
		<%
						} else {
							%>
		<div id="remDiv_<%=displayCrs.getString("id")%>"
			name="remDiv_<%=displayCrs.getString("id")%>"><textarea
			class="textArea" id="rem_<%=displayCrs.getString("id")%>"
			name="rem_<%=displayCrs.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("id")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
		</div>
		<%
						}
					}//end else
				%></td>
	</tr>
	<%
	counter++;
	}//end while
			}//end if
			%>
	<input type="hidden" id="hid" name="hid" />
	<input type="hidden" id="hidAppruve" name="hidAppruve" />
	<input type="hidden" id="hidden_ids" name="hidden_ids" value="<%=sbIds%>" />
</table>
<%}%> 
NOTE : Please enter maximum 500 characters for remark.
<br>
<br>
<%if (!user_role.equals("9")){%>
	<table align="center">
		<tr>
			<td>
				<div id="submitDiv" name="submitDiv" >
				<input class="btn btn-warning" type="button" align="center"	value="Submit" onclick="validate()">
				</div>
			</td>
			<td>&nbsp;</td>	
			
<%			if(appruvalFlag.equalsIgnoreCase("true")){//when submit button is clicked and Approval button should be displayed.
				if(!(messageFlag.trim().equalsIgnoreCase("3"))){//messageFlag =1 for save, 2 for update,3 for can't be updated
%>			<td>	
				<div id="appruvalDiv" name="appruvalDiv" >	
				<input class="button1" type="button" align="center"	value="Send For Approval" onclick="appruve()"/>
				</div>
			</td>
<%				}
			}
%>				
		</tr>
	</table>
	
<%}%>
<input type="hidden" id="umpire" name="umpire" value="<%=umpireOfficialId%>" />
<%//}else{
%>
<%//}//end else of No umpire exists
%>

<jsp:include page="admin/Footer.jsp"></jsp:include>
</form>
</div>
</td>
</tr>
</table>
</body>
</html>
