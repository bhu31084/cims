<!--
	Page Name 	 : UmpCoachSuspectactionReport.jsp
	Created By 	 : Archana Dongre.
	Created Date : 12th Dec 2008
	Description  : Suspect action Report by Umpires Coach
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
            in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
            java.util.*"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
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
	String match_id = session.getAttribute("matchid").toString();
	String user_id =session.getAttribute("userid").toString();
	String loginUserId = session.getAttribute("usernamesurname").toString();
	String seasson_id = request.getParameter("selseason")==null?"0":request.getParameter("selseason");
	String flag = "1";
	String user_role = session.getAttribute("role").toString();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	CachedRowSet crsObjplayerDetail = null;
	CachedRowSet crsObjDisplaySuspectAction = null;
	CachedRowSet crsSeason = null;
	LogWriter log = new LogWriter();
	Vector vdspparam =  new Vector();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(match_id);
	Vector vparam = new Vector();
	Vector refereeids = new Vector();
	Vector groundids = new Vector();

	//To display the matchTeamPlayer id's of players
	try{
		vparam.add(match_id);
		crsObjplayerDetail = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_userroleid_for_breaches",vparam,"ScoreDB");
		vparam.removeAllElements();
	}catch (Exception e) {
		System.out.println("*************UmpCoachSuspectActionReport.jsp*****************"+e);
		log.writeErrLog(page.getClass(),match_id,e.toString());
	}
	//To display the remark if already present.
	
	if (user_role.equals("9")) {
		flag = "2";
	}
	
	try{
		vdspparam.add(flag);
		vdspparam.add(match_id);
		vdspparam.add(seasson_id);
		crsObjDisplaySuspectAction = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_officialplayerremark",vdspparam,"ScoreDB");
		vdspparam.removeAllElements();
	}catch (Exception e) {
		System.out.println("*************UmpCoachSuspectActionReport.jsp*****************"+e);
		log.writeErrLog(page.getClass(),match_id,e.toString());
	}
	try{
		vdspparam.add("1");
		crsSeason = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_season",vdspparam,"ScoreDB");
		vdspparam.removeAllElements();
	}catch (Exception e) {
		System.out.println("*************UmpCoachSuspectActionReport.jsp*****************"+e);
		log.writeErrLog(page.getClass(),match_id,e.toString());
	}
%>
<html>
	<head>
		<title> Umpire's Suspect Action Report </title>
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
		<link rel="stylesheet" type="text/css" href="../css/menu.css">
		<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
		<link href="../css/form.css" rel="stylesheet" type="text/css" />
		<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
		<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/js/trim.js"></script>
		<script language="JavaScript" src="../js/otherFeedback.js"></script>
		<script>
			function cleartxtarea(){
				//alert(document.getElementById("txtRemarkDiv").value)
				document.getElementById("RemarkDiv").style.display = '';
				//document.getElementById("txtRemarkDiv").value = '';
				document.getElementById("txtRemarkDiv").focus();
			}
			
			function restrict(mytextarea) {  
			
				var maxlength = 500; // specify the maximum length  
				if (mytextarea.value.length > maxlength){  
					mytextarea.value = mytextarea.value.substring(0,maxlength); 
					alert("Max Length for remark is 500 characters")	; 
				}
			}
			function getSeason(){
				document.getElementById("frmSuspectActionReport").action="/cims/jsp/UmpCoachSuspectactionReport.jsp?hId=1";
				document.getElementById("frmSuspectActionReport").submit();
			}
			
		</script>

	</head>
<body>
<jsp:include page="Menu.jsp"></jsp:include>
<br><br>
<FORM name="frmSuspectActionReport" id="frmSuspectActionReport" method="post"><br>
	<table width="980" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td colspan="2" bgcolor="#FFFFFF" class="legend">Suspect Action Report By Umpire Coach </td>
		</tr>
		<tr class="contentDark">							
			<td align="right">
<%				if (user_role.equals("9")) { 
%>				
				<select id="selseason" name="selseason" onchange="getSeason();">
					<option value="0">----select------</option>
<%				if(crsSeason!=null){
				while(crsSeason.next()){
%>					<option value=<%=crsSeason.getString("id")%> <%=seasson_id.equalsIgnoreCase(crsSeason.getString("id"))?"selected":""%> > <%=crsSeason.getString("name") %> </option>
<%				}// end of while
				}// end of if
%>	
				</select>
<%				}
%>
			<%=loginUserId%>
			</td>
			<td colspan="4" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>&nbsp;&nbsp;&nbsp;&nbsp;DATE :</b> <%=sdf.format(new Date())%></td>
		</tr>
	</table>
	
	<%
		//For Admin role is 9
	if (user_role.equals("9")) { 
	
	%>
		<table width="980" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr class="contentDark">
			<td align="left" class="colheadinguser">Player Name</td>
			<td align="left" class="colheadinguser">Remark</td>
			<td align="left" class="colheadinguser">Match</td>
			<td align="left" class="colheadinguser">Start Date</td>
			<td align="left" class="colheadinguser">End Date</td>
			<td align="left" class="colheadinguser">Tournament</td>
			<td align="left" class="colheadinguser">Playing Team</td>
			<td align="left" class="colheadinguser">Offical Name</td>
			<td align="left" class="colheadinguser">Role</td>
		</tr>
		<%if(crsObjDisplaySuspectAction != null){
		int counter = 1;
				while(crsObjDisplaySuspectAction.next()){
		if(counter % 2 != 0){%>
		<tr class="contentLight">
<%				}else{
%>		<tr class="contentDark">
<%				} //player,name,remark,match_id,Team1Name,Team2Name,start_date,end_date,tournament_name,playing_team
%>			<td align="left" id="<%=counter++%>"><%=crsObjDisplaySuspectAction.getString("name")%></td>
			<td align="left" id="<%=counter++%>"><%=crsObjDisplaySuspectAction.getString("remark")%></td>
			<td align="left"><%=crsObjDisplaySuspectAction.getString("Team1Name") +" vs " + crsObjDisplaySuspectAction.getString("Team2Name")%></td>
			<td align="left"><%=crsObjDisplaySuspectAction.getString("start_date")%></td>
			<td align="left"><%=crsObjDisplaySuspectAction.getString("end_date")%></td>
			<td align="left"><%=crsObjDisplaySuspectAction.getString("tournament_name")%></td>
			<td align="left"><%=crsObjDisplaySuspectAction.getString("playing_team")%></td>
			<td align="left"><%=crsObjDisplaySuspectAction.getString("officialname")%></td>
			<td align="left"><%=crsObjDisplaySuspectAction.getString("role")%></td>
		
<%			}//end of while
 }//end of if
%>		</tr>
	</table>
	
	<%}else{%>
	<table width="980" border="0" align="center" cellpadding="2" cellspacing="1" class="table">			
			<tr class="contentLight">
				<td width="40%" align="left" >Match Players :&nbsp;&nbsp;&nbsp;				
					<select name="dpPlayer" id="dpPlayer" onchange="cleartxtarea()">
						<option value="0" >Select </option>
	<%					if(crsObjplayerDetail != null){
							while(crsObjplayerDetail.next()){%>
	<%						//	if(crsObjplayerDetail.getString("userroleid").equalsIgnoreCase("")){%>
						<option value="<%=crsObjplayerDetail.getString("matchplayerid")%>" ><%=crsObjplayerDetail.getString("playername")%></option>
	<%					   //	}else{%>
	<%						//	}
							}
						}%>					
					</select>
				</td>
				<td align="left" width="10%">
				<label >Remark</label></td>
				<td><div id="RemarkDiv" style="display: none;" >
						<textarea id="txtRemarkDiv" name="txtRemarkDiv" class="textArea" rows="4" value = "Add Comments' cols="20" maxlength="500" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),restrict(document.frmSuspectActionReport.txtRemarkDiv)" ></textarea>
					</div>
				</td>
				<td align="left" width="10%">
       			<input type="button" id="btnAddSAction" name="btnAddSAction" value="Add" onclick="AddSuspectAction()" >
       			<input type="hidden" id="hdmatchid" name="hdmatchid" value="<%=match_id%>">
       			<input type="hidden" id="hdloginuserId" name="hdloginuserId" value="<%=user_id%>">
       		</td>				
			</tr>					      		
	</table>	
	<br>
	<div id="tempDiv" >
		<table width="980" border="1" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr class="contentDark">
			<td align="left" class="colheadinguser">Player Name</td>
			<td align="justify" class="colheadinguser" width="70%" >Remark</td>
			<td align="left" class="colheadinguser">Delete record</td>
		</tr>
		<%if(crsObjDisplaySuspectAction != null){
		int counter = 1;
				while(crsObjDisplaySuspectAction.next()){
		if(counter % 2 != 0){%>
		<tr class="contentLight">
<%				}else{
%>		<tr class="contentDark">
<%				}
%>			<td align="left" nowrap="nowrap" id="<%=counter++%>"><%=crsObjDisplaySuspectAction.getString("name")%></td>
			<td align="left" width="40%" align="justify"><%=crsObjDisplaySuspectAction.getString("remark")%></td>
			<td align="left">
<a id="deletelink" name="deletelink" href="javascript:DeleteSuspectAction('<%=crsObjDisplaySuspectAction.getString("player")%>')">Delete</td>
<%			}//end of while	
 }//end of if
%>		</tr>
	</table>
	</div>	
<%}%>		

<br>
<div id="SavedSuspectActionDiv" style="display: none; color:red;font-size: 15" align="center"></div>	
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</form>	
<jsp:include page="admin/Footer.jsp"></jsp:include>
</body>
</html>   	

