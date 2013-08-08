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
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
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
%>
<%		String reportId = "3";
		String role = "4"; //For refree
		String matchId = null;
		String userID = null;
		String loginUserName = null;
		String flag = "false";
		String message = null;
		String refree_user_id = null;
		String refree_off_id = null;
		String umpireOfficialId = null;
		
		ReplaceApostroph replaceApos = new ReplaceApostroph();
		LogWriter log = new LogWriter();
		StringBuffer sbIds = new StringBuffer();

		matchId = session.getAttribute("matchid").toString();
		loginUserName = session.getAttribute("usernamesurname").toString();
		userID = session.getAttribute("userid").toString();
		String userRole = session.getAttribute("role").toString();
		
		CachedRowSet matchSummeryCrs = null;
		CachedRowSet submitCrs = null;
		CachedRowSet displayCrs = null;
		CachedRowSet umpiresCrs = null;
		CachedRowSet useridCrs = null;
		CachedRowSet refreeidCrs = null;
		CachedRowSet messageCrs = null;

		GenerateStoreProcedure generateStProc = new GenerateStoreProcedure(matchId);
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");
		java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat(
			"dd/MM/yyyy");
				
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
				System.out.println("*************PitchOutfieldReportOneDay.jsp*****************"+e);
				log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		
		if (userRole.equals("9")){
			System.out.println("Role is admin");
			spParamVec = new Vector<String>();
			spParamVec.add(matchId);
			spParamVec.add(role);
			
			try{
			refreeidCrs = generateStProc.GenerateStoreProcedure(
					"esp_dsp_getMatchConcerns", spParamVec, "ScoreDB");
			}catch (Exception e) {
				System.out.println("*************PitchOutfieldReportOneDay.jsp*****************"+e);
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

			String[] retrieve_ids = request.getParameter("hidden_ids").split(",");
			int retrieve_ids_length = retrieve_ids.length;
			umpireOfficialId = request.getParameter("umpire");
			
			for (int count = 0; count < retrieve_ids_length; count = count + 2) {
			
				if(retrieve_ids[count].equalsIgnoreCase("null")){
					retrieve_ids[count] = "0";
				}	
				
				System.out.println(retrieve_ids[count]
						+ " : " + retrieve_ids[count + 1]);//gives value-text or selected value of combo
				
				spParamVec = new Vector();
				spParamVec.add(matchId);
				spParamVec.add(userID);
				spParamVec.add(retrieve_ids[count]);

				if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {//combo
					System.out.println("....."+request.getParameter(retrieve_ids[count]));
					spParamVec.add(request.getParameter(retrieve_ids[count])==null?"0":request.getParameter(retrieve_ids[count]));//score
					//spParamVec.add(request.getParameter("rem_"+retrieve_ids[count]==null?"0":"rem_"+retrieve_ids[count]));
					System.out.println("..@@COMb..."+request.getParameter("rem_"+retrieve_ids[count]));
					if(request.getParameter("rem_"+retrieve_ids[count]) == null){
						spParamVec.add("0");
					}else{
						spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter("rem_"+retrieve_ids[count])));
					}
				} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")){//text
					spParamVec.add("0");
					System.out.println("..@@@..."+request.getParameter(retrieve_ids[count]));
					if(request.getParameter(retrieve_ids[count]) == null){
						spParamVec.add("0");
					}else{
						spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter(retrieve_ids[count])));
					}
				}
				spParamVec.add(""); // admin remark
				spParamVec.add(reportId);
								
				try{
					messageCrs = generateStProc.GenerateStoreProcedure("esp_amd_pitchoutfield",spParamVec, "ScoreDB");
				}catch (Exception e) {
					System.out.println("*************PitchOutfieldReportOneDay.jsp*****************"+e);
					log.writeErrLog(page.getClass(),matchId,e.toString());
				}		
			}//end for
			
			if (messageCrs.next()) {//to display message saved/updated
				message = messageCrs.getString("retval");
				flag = "true";
			}
		}//end if

		//For Display Table Data
		spParamVec.removeAllElements();
		spParamVec.add(matchId); // match_id
		spParamVec.add(userID);
		
		try{
			umpiresCrs = generateStProc.GenerateStoreProcedure(
			"esp_dsp_getmatchofficialid", spParamVec, "ScoreDB");//to get official id of umpire
		}catch (Exception e) {
			System.out.println("*************PitchOutfieldReportOneDay.jsp*****************"+e);
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}	
			
		if (umpiresCrs.next()) {
			umpireOfficialId = umpiresCrs.getString("official");
		}
		
		spParamVec.add(reportId); // report id
		
		try{
			displayCrs = generateStProc.GenerateStoreProcedure(
			"esp_dsp_pitchoutfieldoneday", spParamVec, "ScoreDB");
		}catch (Exception e) {
			System.out.println("*************PitchOutfieldReportOneDay.jsp*****************"+e);
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}		
%>
<html>
<head>
	<title>PITCH AND OUTFIELD REPORT-ONE DAY</title>
	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/trim.js"></script>
</head>
	<script>
		function parentTrig( parent, trigger, chield ){
			this.parent = function(){
				return parent;
			}
			this.trigger = function(){
				return trigger;
			}
			this.chield = function(){
				return chield;
			}
		}

		var deptArray = new Array();

		function mapParentTrig( parent, trigger, chield ){
			deptArray[deptArray.length] = new parentTrig( parent, trigger, chield );
			var parentObj = document.getElementById(parent );
			parentObj.onchange = function(){
				enebleDisableQue( parent );
			}
		}

		function enebleDisableQue( myId ){
			for( var i=0; i<deptArray.length; i++ ){
				if( myId == deptArray[i].parent() ){
					enebleDisableObject(deptArray[i].chield(), true );
					var parentObj = document.getElementById(myId );
					if(parentObj.options[parentObj.selectedIndex].value == (deptArray[i].trigger())) {
							enebleDisableObject(deptArray[i].chield(), false );
					}
				}
			}
		}

		function enebleDisableObject( id, disable ){
			document.getElementById(id).disabled = disable;
			if(document.getElementById("remAnch_"+id ).innerHTML != " "){
				document.getElementById("remAnch_"+id ).disabled = disable;//to disable anchor tag
				document.getElementById("rem_"+id ).disabled = disable;//to disable textarea tag
			}
		}

		function doOnLoad(){
			for( var i=0; i<deptArray.length; i++ ){
				enebleDisableQue( deptArray[i].parent() );
			}
		}
			
		function validate(){
			var isComplete = true;
			var elem = document.getElementById('frmPitchOutfieldReportLimited').elements;
			var message=""
					
			for(var i = 0; i < elem.length; i++){
				if(elem[i].type == 'select-one') {
					if(elem[i].disabled == false && elem[i].value == '0'){//not selected cmb
						var id = elem[i].id;
						var removeTag = document.getElementById( 'que_'+id ).innerHTML.replace('<B>','')
						removeTag = removeTag.replace('<BR>&nbsp;&nbsp;','')
						removeTag = removeTag.replace('</B>','')
						removeTag = removeTag.replace('&nbsp;','')
						removeTag = removeTag.replace('<BR>&nbsp;&nbsp;','')
						message = message +"\n"+ removeTag
						isComplete = false;
					}
				}
			}
			
			if(isComplete){
				document.getElementById("hid").value = "1";
				document.frmPitchOutfieldReportLimited.submit();
			}else{
				alert( "Please select answers for following questions : \n"+ message ) ;
				setFocus();
				return false
			}
			
		}
		
		function setFocus(){
			var elem = document.getElementById('frmPitchOutfieldReportLimited').elements;
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
		
		function enterRemark(id){//hide / unhide div on click of remark
			var remarkDiv = document.getElementById( 'remDiv_'+id );
			var remarkTextArea = document.getElementById( 'rem_'+id );
			if( remarkDiv.style.display == 'none' ){
				remarkDiv.style.display = ''
				remarkTextArea.focus();
			}else{
				if(remarkTextArea.value == ""){
					remarkDiv.style.display = 'none'
				}
			}
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
<jsp:include page="Menu.jsp"></jsp:include>
	<form name="frmPitchOutfieldReportLimited" id="frmPitchOutfieldReportLimited" method="post">
	<br>
	<br>
	<br>
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
			<tr>
				<td colspan="9" bgcolor="#FFFFFF" class="legend">
					 Pitch and Outfield Report - One Day Game
				</td>
			</tr>
			<tr>
				<td colspan="2" width="90%" class="contentDark" colspan="2" align="right"><b><%=loginUserName%>&nbsp;&nbsp;&nbsp;DATE :</b> <%=sdf.format(new Date())%></td>
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
<%			if (matchSummeryCrs.getString("displaymatchdate") == null || matchSummeryCrs.getString("displaymatchdate").equals("")) {%>
				<td align="left">-</td>
<%			} else {
		String displayDate = null;
		java.util.Date date = ddmmyyyy.parse(matchSummeryCrs.getString("displaymatchdate"));
		displayDate = sdf.format(date);%>
<%--				<td width="80%" ><%=sdf.format(new Date(matchSummeryCrs.getString("displaymatchdate")))%></td>--%>
				<td width="80%" ><%=displayDate%></td>
<%			}%>
		    </tr>
		    <tr class="contentDark">
		        <td width="15%"><b>Venue:</b></td>
		        <td width="80%" ><%=matchSummeryCrs.getString("venue")%></td>
		    </tr>
<%		}//end while
	}//end if
%>		</table>
		<br>
		<br>

<%	if(flag.equalsIgnoreCase("true")){
%>		<table>
			<tr>
				<td class="message">
					<%=message%>
				</td>
			</tr>
		</table>			
<%	}//end if	
%>		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">

<%   if (displayCrs != null) {
		int counter = 1;
		while (displayCrs.next()) {
			sbIds.append(displayCrs.getString("facilityid"));
			sbIds.append(",");
			sbIds.append(displayCrs.getString("scoring_required"));
			sbIds.append(",");

			ids.add(displayCrs.getString("facilityid"));
			ids.add(displayCrs.getString("scoring_required"));
			
			if(counter % 2 != 0){	
%>				<tr class="contentDark">
<%			}else{
%>				<tr class="contentLight">
<%			}
%>					<td id="que_<%=displayCrs.getString("facilityid")%>">
						.&nbsp;<b><%=displayCrs.getString("description")%></b>
					</td>
					<td>
<%			if (displayCrs.getString("scoring_required").equalsIgnoreCase("Y")) {//for combo
				String[] valueArr = displayCrs.getString("cnames").toString().split(",");
%> 					<select style="width:3cm" name="<%=displayCrs.getString("facilityid")%>" 
							id="<%=displayCrs.getString("facilityid")%>">
<%				if(displayCrs.getString("selected").equalsIgnoreCase("0")){%>
						<option value="0" selected="selected">- Select -</option>
<%				}else{
%>						<option value="0">- Select -</option>
<%				}
	
				for (int count = valueArr.length; count > 0; count--) {//to fill combo box options
					if(displayCrs.getString("selected").equalsIgnoreCase(""+count)){
%>						<option value="<%=count%>" selected="selected"><%=valueArr[count - 1]%></option>
<%					}else{
%>						<option value="<%=count%>"><%=valueArr[count - 1]%></option>
<%					}
				}
%>					</select>
<%				
				if(displayCrs.getString("remark").trim().equalsIgnoreCase("")){
					
%>					<div id="remDiv_<%=displayCrs.getString("facilityid")%>" 
						 name="remDiv_<%=displayCrs.getString("facilityid")%>" style="display:none">
						<textarea class="textArea" id="rem_<%=displayCrs.getString("facilityid")%>" name="rem_<%=displayCrs.getString("facilityid")%>" maxlength="500"  onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
					</div>
<%				}else{
%>					<div id="remDiv_<%=displayCrs.getString("facilityid")%>"
						 name="remDiv_<%=displayCrs.getString("facilityid")%>" >
						<textarea class="textArea" id="rem_<%=displayCrs.getString("facilityid")%>" name="rem_<%=displayCrs.getString("facilityid")%>"  maxlength="500"  onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
					</div>	
<%				}
			} else {//for text
				
				if(displayCrs.getString("remark") != null){
%>					<textarea  class="textArea" id="<%=displayCrs.getString("facilityid")%>" name="<%=displayCrs.getString("facilityid")%>"  maxlength="500"  onblur="imposeMaxLength(this,500,event,'<%=displayCrs.getString("facilityid")%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'<%=displayCrs.getString("facilityid")%>','2')" ><%=displayCrs.getString("remark").trim()%></textarea>
<%				}else{
%>					<textarea class="textArea" id="<%=displayCrs.getString("facilityid")%>" name="<%=displayCrs.getString("facilityid")%>"  maxlength="500" onblur="imposeMaxLength(this,500,event,'<%=displayCrs.getString("facilityid")%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'<%=displayCrs.getString("facilityid")%>','2')"></textarea>
<%				}
%>					<div id="remDiv_<%=displayCrs.getString("facilityid")%>" 
						  name="remDiv_<%=displayCrs.getString("facilityid")%>" style="display:none">
						  
<%				if(!(userRole.equals("9"))){		
%>					<textarea class="textArea" id="rem_<%=displayCrs.getString("facilityid")%>" name="rem_<%=displayCrs.getString("facilityid")%>" maxlength="500" onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
<%				}else{
%>				  	<textarea disabled="disabled" textArea" id="rem_<%=displayCrs.getString("facilityid")%>" name="rem_<%=displayCrs.getString("facilityid")%>" maxlength="500"  onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
<%				}
%>					</div>
<%			}//end else
%>					</td>
<%			if(!(userRole.equals("9"))){
%>					<td>
<%				if (displayCrs.getString("scoring_required").equalsIgnoreCase("Y")) {//combo
%>						<a href="javascript:void('')" id="remAnch_<%=displayCrs.getString("facilityid")%>" 
						name="remAnch_<%=displayCrs.getString("facilityid")%>" 
						onmouseover="callTooltip('<%=displayCrs.getString("facilityid")%>')"
						onclick="enterRemark('<%=displayCrs.getString("facilityid")%>')">Remark</a>
<%				}else{
%>						<a href="javascript:void('')" id="remAnch_<%=displayCrs.getString("facilityid")%>" 
						name="remAnch_<%=displayCrs.getString("facilityid")%>"
						onclick="enterRemark('<%=displayCrs.getString("facilityid")%>')"></a>
<%				}
%>					</td>
<%			}
%>						
<%			if(Integer.parseInt(displayCrs.getString("parent")) != 0 ){
%>				<script>
						mapParentTrig(<%=displayCrs.getString("parent")%>,
						<%=displayCrs.getString("trig")%>,<%=displayCrs.getString("facilityid")%>);
				</script>
<%			}
%>				
			</tr>
<%		counter++;
		}//end while
	}//end if
%>		<input type="hidden" id="hid" name="hid" />
		<input type="hidden" id="hidden_ids" name="hidden_ids" value="<%=sbIds%>" />
		</table>
		NOTE : Please enter maximum 500 characters for remark.
		<br>
<%		if(!(userRole.equals("9"))){
%>		<br>
		<center><input class="contentDark" type="button" align="center" value="Submit" onclick="validate()">
		<input type="hidden" id="umpire" name="umpire" value="<%=umpireOfficialId%>" />
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
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
	doOnLoad()//to keep disabled fields after refresh.
	</script>
<%		}
%>
</html>

