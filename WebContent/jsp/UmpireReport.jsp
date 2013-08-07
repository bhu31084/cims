<!--
Page Name 	 : UmpireReport.jsp
Created By 	 : Avadhut Joshi
Created Date : 28th Aug 2008
Description  : Umpires Report on overall match
Company 	 : Paramatrix Tech Pvt Ltd.
Modified on  : 14th October 2008	
Modified on  : 16th October 2008		
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*"%>
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
%>
<%		String reportId = "4";
		String matchId = null;
		String userID = null;
		String loginUserId = null;		
		String umpireOfficialId = null;
		StringBuffer sbIds = new StringBuffer();
		String series_name 	= null;				
		String team1_name		= null;						
		String team2_name		= null;				
		String zone			= null;				
		String captain1		= null;				
		String captain2		= null;				
		String umpire1			= null;				
		String umpire2			= null;	
		String umpire_name		= null;	
		String strMessage		= null;
		String match_no		= null;
		
		matchId = session.getAttribute("matchid").toString();
		String user = (String)session.getAttribute("userid");
		loginUserId = (String)session.getAttribute("usernamesurname").toString();
		String userRole = session.getAttribute("role").toString();
		
		CachedRowSet  matchInfoCachedRowSet 	= null;
     	CachedRowSet  crsObjmatchreport	= null;   
		CachedRowSet submitCrs = null;
		CachedRowSet displayCrs = null;
		CachedRowSet umpiresCrs = null;
		CachedRowSet useridCrs = null;
		CachedRowSet messageCrs = null;
		Vector spParamVec = new Vector();
		ReplaceApostroph replaceApos = new ReplaceApostroph();
		GenerateStoreProcedure generateStProc = new GenerateStoreProcedure();
		
		spParamVec.add(matchId);//(String)session.getAttribute("matchId"));
		spParamVec.add(user);
		matchInfoCachedRowSet 	= generateStProc.GenerateStoreProcedure("esp_dsp_umpires_report",spParamVec,"ScoreDB");
				
		while(matchInfoCachedRowSet.next()){
			series_name = matchInfoCachedRowSet.getString("series_name");
			team1_name =  matchInfoCachedRowSet.getString("team1_name");
			team2_name =  matchInfoCachedRowSet.getString("team2_name");
			match_no =  matchInfoCachedRowSet.getString("match_no");					
			zone 	   =  matchInfoCachedRowSet.getString("zone");
			captain1   =  matchInfoCachedRowSet.getString("captain1");
			captain2   =  matchInfoCachedRowSet.getString("captain2");
			umpire1    =  matchInfoCachedRowSet.getString("umpire1");
			umpire2    =  matchInfoCachedRowSet.getString("umpire2");
			umpire_name=  matchInfoCachedRowSet.getString("umpire_name");
		}
		spParamVec.removeAllElements();
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");
		Vector ids = new Vector();
		
		//for match details in top table
		spParamVec.add(matchId); // match_id		
		useridCrs = generateStProc.GenerateStoreProcedure(
				"esp_dsp_getmatchuserid", spParamVec, "ScoreDB");
				
		 if (useridCrs != null) {		
			if (useridCrs.next()) {
				userID = useridCrs.getString("id");
			}		
		}		

		if (request.getParameter("hid") != null
				&& request.getParameter("hid").equalsIgnoreCase("1")) {

			System.out.println("ids : " + request.getParameter("hidden_ids"));
			String[] retrieve_ids = request.getParameter("hidden_ids").split(",");
			int retrieve_ids_length = retrieve_ids.length;
			umpireOfficialId = request.getParameter("umpire");
			
			for (int count = 0; count < retrieve_ids_length; count = count + 2) {
				System.out.println(request.getParameter(retrieve_ids[count])
						+ " : " + retrieve_ids[count + 1]);
				spParamVec = new Vector();
				spParamVec.add(matchId);
				spParamVec.add(userID);
				spParamVec.add(retrieve_ids[count]);

				if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {//combo
					spParamVec.add(request.getParameter(retrieve_ids[count]));
					//spParamVec.add(request.getParameter("rem_"+retrieve_ids[count]));
					spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter("rem_"+retrieve_ids[count])));
					//replaceApos.replacesingleqt((String)
				} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {//text
					spParamVec.add("0");
					//spParamVec.add(request.getParameter("rem_"+retrieve_ids[count]));
					spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter("rem_"+retrieve_ids[count])));
				}
				
				spParamVec.add(replaceApos.replacesingleqt((String)request.getParameter("authorityrem_"+retrieve_ids[count])));
				spParamVec.add(reportId);

				messageCrs = generateStProc.GenerateStoreProcedure("esp_amd_pitchoutfield",
						spParamVec, "ScoreDB");
					while(messageCrs.next()){
						strMessage = messageCrs.getString("RetVal");
					}	
			}
		}

		//For Display Table Data
		spParamVec.removeAllElements();
		spParamVec.add(matchId); // match_id
		spParamVec.add(userID);
		umpiresCrs = generateStProc.GenerateStoreProcedure(
				"esp_dsp_getmatchofficialid", spParamVec, "ScoreDB");//to get official id of umpire
		if (umpiresCrs.next()) {
			umpireOfficialId = umpiresCrs.getString("official");
		}
		
		spParamVec.add(reportId); // report id
		displayCrs = generateStProc.GenerateStoreProcedure(
				"esp_dsp_pitchoutfieldoneday", spParamVec, "ScoreDB");
	
		spParamVec.removeAllElements();		
		spParamVec.add(matchId);
		crsObjmatchreport = generateStProc.GenerateStoreProcedure("esp_dsp_referee_match_report",spParamVec,"ScoreDB");
		spParamVec.removeAllElements();				
				
%>
<html>
<head>
	<title>Feedback REPORT submitted by Umpire </title>
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
			if(document.getElementById("anchrem_"+id ).innerHTML != " "){
				document.getElementById("anchrem_"+id ).disabled = disable;
			}
		}

		function doOnLoad(){
			for( var i=0; i<deptArray.length; i++ ){
				enebleDisableQue( deptArray[i].parent() );
			}
		}
		

		function validate(){
			var isComplete = true;
			var elem = document.getElementById('frmUmpiresReport').elements;
			var message=""
			
			
			for(var i = 0; i < elem.length; i++){
				if(elem[i].type == 'select-one') {
					if(elem[i].disabled == false && elem[i].value == '0'){//not selected cmb
						var id = elem[i].id;
						var removeTag = document.getElementById('que_'+id).innerHTML.replace('<B>','');
						emoveTag = removeTag.replace('<BR>&nbsp;&nbsp;','');
						removeTag = removeTag.replace('</B>','');
						removeTag = removeTag.replace('&nbsp;','');
						removeTag = removeTag.replace('<BR>&nbsp;&nbsp;','');
						removeTag = removeTag.replace('<b>.&nbsp;','');
						message = message +", "+ removeTag;
						isComplete = false;
					}
				}
			}
			
			if(isComplete){
				document.getElementById("hid").value = "1";
				document.frmUmpiresReport.submit();
			}else{
				message.replace('<b>. --', '');  
				alert( "Please select answers for following questions :"+ message ) ;
				setFocus();
				return false
			}
			
		}
		
		function setFocus(){
			var elem = document.getElementById('frmUmpiresReport').elements;
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
			var remarkDiv = document.getElementById('remDiv_'+id );
			var remarkTextArea = document.getElementById( 'rem_'+id );
			if( remarkDiv.style.display == 'none' ){
				remarkDiv.style.display = ''
				remarkDiv.focus();
				remarkTextArea.focus();					
			}
			else{				
				if(remarkTextArea.value == ""){
					remarkDiv.style.display = 'none';
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
		function callTooltip(anchorid,textareaid){
			document.getElementById(anchorid).title = document.getElementById(textareaid).innerHTML
		}	
	</script>
<body>
<table align="center" style="width: 84.5em;">
    <tr>
    	<td align="center">
<div style="width: 84.5em" align="center">

<jsp:include page="AuthZ.jsp"></jsp:include>
<jsp:include page="Menu.jsp"></jsp:include>
<br>
<br>
	<form name="frmUmpiresReport" id="frmUmpiresReport" method="post">
		<table width="100%" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
			<tr>
				<td colspan="9" bgcolor="#FFFFFF" class="legend">Umpire's Report</td>
			</tr>
			<tr>
				<td colspan="9" align="right">
				Export : 
					<a href="/cims/jsp/PDFUmpireReport.jsp" target="_blank">
						<img src="/cims/images/pdf.png" height="20" width="20" />
					</a>
					<a href="/cims/jsp/EXCELUmpireReport.jsp" target="_blank">
						<img src="/cims/images/excel.jpg" height="20" width="20" />
					</a>
				</td>
			</tr>

			<tr>
				<td colspan="2" width="90%" class="contentDark" align="right"><b><%=loginUserId%>&nbsp;&nbsp;&nbsp;DATE :</b> <%=sdf.format(new Date())%></td>
			</tr>
			<tr class="contentLight">
				<td width="15%">
					Tournament: 
				</td>
				<td width="80%"><%=series_name%></td>				
 			</tr>
			<tr class="contentDark">
				<td  width="15%">Match:</td>
				<td  width="80%"><%=team1_name%> v/s <%=team2_name%></td>
			</tr>
			<tr class="contentLight">
				<td  width="15%">Match No.:</td>
				<td  width="80%"><%=match_no%></td>
			</tr>			
			<tr class="contentLight">
				<td width="15%">Captain Team1:</td>
								
				<td width="80%"><%=captain1%>	- (<%=team1_name%>)</td>
			</tr>
			<tr tr class="contentDark">
				<td width="15%">Captain Team2 :</td>
				<td width="85%"><%=captain2%> - (<%=team2_name%>)</td>
			</tr>			
			<tr class="contentLight">
				<td  width="15%">Umpires:</td>
				<td width="85%"><%=umpire1%> and <%=umpire2%></td>
			</tr>
			<tr align="left">
				<td class="message" >				<%if(messageCrs != null){%>
					<b style="color: red"> <%=strMessage%> </b>
					<%}%>  
				</td>	
			</tr>
		</table>
		<br>		
				
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">

		<tr>
			<td></td>
			<td></td>
<% 		if(!(userRole.equals("9"))){%>
			<td></td>
<%		}
%>
			<td> Admin Remark</td>
		</tr>
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
%>
			<tr class="contentDark">
<%				}else{
%>			<tr class="contentLight">
<%				}
%>	
			<td id="que_<%=displayCrs.getString("facilityid")%>"><b>.&nbsp;<%=displayCrs.getString("description")%></b></td>

				<td>
<%				if (displayCrs.getString("scoring_required").equalsIgnoreCase("Y")) {//for combo
					String[] valueArr = displayCrs.getString("cnames").toString().split(",");
%> 					<select name="<%=displayCrs.getString("facilityid")%>" id="<%=displayCrs.getString("facilityid")%>">
<%					if(displayCrs.getString("selected").equalsIgnoreCase("0")){%>
						<option value="0" selected="selected">- Select -</option>
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
					
<%					if(displayCrs.getString("remark").trim().equalsIgnoreCase("")){
%>						<div id="remDiv_<%=displayCrs.getString("facilityid")%>" name="remDiv_<%=displayCrs.getString("facilityid")%>" style="display:none">
							<textarea id="rem_<%=displayCrs.getString("facilityid")%>" name="rem_<%=displayCrs.getString("facilityid")%>" maxlength="500" class="textarea" onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
						</div>
<%					}else{
%>						<div id="remDiv_<%=displayCrs.getString("facilityid")%>" name="remDiv_<%=displayCrs.getString("facilityid")%>" >
							<textarea id="rem_<%=displayCrs.getString("facilityid")%>" name="rem_<%=displayCrs.getString("facilityid")%>" maxlength="500" class="textarea" onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
						</div>	
<%					}
				} 
				else {
				
					%>
		<a id="remAnch_<%=displayCrs.getString("facilityid")%>"
			name="remAnch_<%=displayCrs.getString("facilityid")%>"
			href="javascript:void(0)"
			onmouseover="callTooltip('remAnch_<%=displayCrs.getString("facilityid")%>','rem_<%=displayCrs.getString("facilityid")%>')"
			onclick="enterRemark('<%=displayCrs.getString("facilityid")%>')">Remark</a>	<%		
					if (displayCrs.getString("remark").trim()
								.equalsIgnoreCase("")) {
%>		
		<div id="remDiv_<%=displayCrs.getString("facilityid")%>"
			name="remDiv_<%=displayCrs.getString("facilityid")%>" style="display:none"><textarea
			class="textArea" id="rem_<%=displayCrs.getString("facilityid")%>"
			name="rem_<%=displayCrs.getString("facilityid")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
		</div>
		<%
						} else {
							%>
		<div id="remDiv_<%=displayCrs.getString("facilityid")%>"
			name="remDiv_<%=displayCrs.getString("facilityid")%>"><textarea
			class="textArea" id="rem_<%=displayCrs.getString("facilityid")%>"
			name="rem_<%=displayCrs.getString("facilityid")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=displayCrs.getString("facilityid")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
		</div>
		<%
						}
					
				
				}//end else
%>				</td>
<%				if(!(userRole.equals("9"))){%>
				<td>
<%					if (displayCrs.getString("scoring_required").equalsIgnoreCase("Y")) {//combo
%>					<div>
						<a id="anchrem_<%=displayCrs.getString("facilityid")%>" name="anchrem_<%=displayCrs.getString("facilityid")%>" onmouseover="callTooltip('anchrem_<%=displayCrs.getString("facilityid")%>','rem_<%=displayCrs.getString("facilityid")%>')"  href="javascript:enterRemark('<%=displayCrs.getString("facilityid")%>')">Remark</a>
					</div>
<%					}else{
%>					<div >
						<a id="anchrem_<%=displayCrs.getString("facilityid")%>" name="anchrem_<%=displayCrs.getString("facilityid")%>" href="javascript:enterRemark('<%=displayCrs.getString("facilityid")%>')"></a>
					</div>
<%					}
%>					
				</td>
<%				}
%>
<%			if((userRole.equals("9"))){			
%>			<td><textarea rows="2" cols="5" maxlength="500" class="textarea" id="authorityrem_<%=displayCrs.getString("facilityid")%>" name="authorityrem_<%=displayCrs.getString("facilityid")%>"><%=displayCrs.getString("adminremark")==null? "" : displayCrs.getString("adminremark") %></textarea>	</td>
<%			}else{
%>			<td><textarea rows="2" cols="5" maxlength="500" class="textarea" id="authorityrem_<%=displayCrs.getString("facilityid")%>" name="authorityrem_<%=displayCrs.getString("facilityid")%>" readonly="readonly"><%=displayCrs.getString("adminremark")==null? "" : displayCrs.getString("adminremark") %></textarea>	</td>
<% 			}
%>
			</tr>
<%			
		counter++;
		}//end while
	}//end if
%>		<input type="hidden" id="hid" name="hid" />
		<input type="hidden" id="hidden_ids" name="hidden_ids" value="<%=sbIds%>" />
		</table>
		
		<br><br><br>

<center><u><b>REPORT ON THE MATCH</b></u></center>
<table align="center" cellpadding="6" cellspacing="1" class="table tableBorder" >
	<tr class="contentLight">
		<td><b>Name of Asscn.</b></td>
		<td><b>Innings.</b></td>
		<td><b>Runs Scored by the Asscn.</b></td>
		<td><b>No. of Wickets fallen </b></td>
		<td><b>Total Time taken by Asscn.</b></td>
		<td><b>Overs Bowled by Opponent Asscn.</b></td>
		<td><b>Overs Bowled Short by Opponent Asscn.</b></td>
		<td><b>Financial Penalty on Opponent Asscn.</b></td>
		<td><b>Match Points(league level)</b></td>
		<td><b>Match Result(Knock Out Level)</b></td>
	</tr>
<%	while(crsObjmatchreport.next()){ 
%>	<tr>
		<td align="left"><%=crsObjmatchreport.getString("nameofasscn")%></td>
		<td align="right" ><%=crsObjmatchreport.getString("innings")%></td>
		<td align="right" ><%=crsObjmatchreport.getString("runsscored")%></td>
		<td align="right" ><%=crsObjmatchreport.getString("noofwkt")%></td>
		<td align="right" ><%=crsObjmatchreport.getString("totaltime")%></td>
		<td align="right" ><%=crsObjmatchreport.getString("overbowled")%></td>
		<td align="right"><%=crsObjmatchreport.getString("overbowledshort")%></td>
		<td align="right"><b>Rs.</b></td>
		<td align="right"><%=crsObjmatchreport.getString("matchpoint")%></td>
		<td align="left"><%=crsObjmatchreport.getString("matchresult")%></td>	
	</tr>	
<%	}// end of while 
%>
</table>
NOTE : Please enter maximum 500 characters for remark.
<br>
<br>

		<center><input class="btn btn-warning" type="button" align="center" value="Submit" onclick="validate()"></center>	
		
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
</html>

