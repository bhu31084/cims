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
	String suspectRole = request.getParameter("suspectactionrole");
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	CachedRowSet crsObjplayerDetail = null;
	CachedRowSet crsObjDisplaySuspectAction = null;
	CachedRowSet crsUmpireSuspectAction = null;
	CachedRowSet crsUmpireCoachSuspectAction = null;
	CachedRowSet crsRefereeSuspectAction = null;
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

		//if (user_role.equals("9")) {
		//	vdspparam.add(suspectRole);
		//}else{
			vdspparam.add(user_role);
		//}
		vdspparam.add(user_id);
		crsObjDisplaySuspectAction = lobjGenerateProc.GenerateStoreProcedure(
				//"esp_dsp_officialplayerremark",vdspparam,"ScoreDB");
				"esp_dsp_officialplayersuspectremark",vdspparam,"ScoreDB");
		
		vdspparam.removeAllElements();
	}catch (Exception e) {
		System.out.println("*************UmpCoachSuspectActionReport.jsp*****************"+e);
		log.writeErrLog(page.getClass(),match_id,e.toString());
	}
	/************************************************************************************************/
	if (user_role.equals("9")) {//  
		try{
			vdspparam.add(flag);
			vdspparam.add(match_id);
			vdspparam.add(seasson_id);
			vdspparam.add("6");//Ump coach
			vdspparam.add(user_id);
			
			crsUmpireCoachSuspectAction = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_officialplayersuspectremark",vdspparam,"ScoreDB");
			
			vdspparam.removeAllElements();
		}catch (Exception e) {
			System.out.println("*************SuspectActionReport.jsp********Ump coach*********"+e);
			log.writeErrLog(page.getClass(),match_id,e.toString());
		}
		
		try{
			vdspparam.add(flag);
			vdspparam.add(match_id);
			vdspparam.add(seasson_id);
			vdspparam.add("4");//referee
			vdspparam.add(user_id);
			
			crsRefereeSuspectAction = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_officialplayersuspectremark",vdspparam,"ScoreDB");
			
			vdspparam.removeAllElements();
		}catch (Exception e) {
			System.out.println("*************SuspectActionReport.jsp******referee***********"+e);
			log.writeErrLog(page.getClass(),match_id,e.toString());
		}
		
		try{
			vdspparam.add(flag);
			vdspparam.add(match_id);
			vdspparam.add(seasson_id);
			vdspparam.add("2");//Umpire
			vdspparam.add(user_id);
			
			crsUmpireSuspectAction = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_officialplayersuspectremark",vdspparam,"ScoreDB");
			
			vdspparam.removeAllElements();
		}catch (Exception e) {
			System.out.println("*************SuspectActionReport.jsp*******Umpire**********"+e);
			log.writeErrLog(page.getClass(),match_id,e.toString());
		}
		
	}
	/************************************************************************************************/
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
			function getSeason(suspectRole){
				//document.getElementById("hdsuspectRole").value = suspectRole
				//alert(document.getElementById("hdsuspectRole").value)
				//document.getElementById("frmSuspectActionReport").action="UmpCoachSuspectactionReport.jsp?hId=1&suspectRole="+(document.getElementById("hdsuspectRole").value);
				document.getElementById("frmSuspectActionReport").action="/cims/jsp/SuspectAction.jsp?hId=1&suspectactionrole="+suspectRole;
				document.getElementById("frmSuspectActionReport").submit();
			}
			
		</script>

	</head>
<body>
<div class="container">
<jsp:include page="Menu.jsp"></jsp:include>
<table style="width:100%">
    <tr>
    	<td align="center">
<div>

<br>
<FORM name="frmSuspectActionReport" id="frmSuspectActionReport" method="post"><br>
	<table width="100%" align="center" cellpadding="2" cellspacing="3" class="table">
		<tr>
		<%if (user_role.equals("6")) {  %>
			<td colspan="2" bgcolor="#FFFFFF" class="legend">Suspect Action Report By Umpire Coach </td>
		<%}else if(user_role.equals("4")){ %>
			<td colspan="2" bgcolor="#FFFFFF" class="legend">Suspect Action Report By Referee </td>
		<%}else if(user_role.equals("2")){ %>
			<td colspan="2" bgcolor="#FFFFFF" class="legend">Suspect Action Report By Umpire </td>
		<%}else if(user_role.equals("9")){ %>	
		<td colspan="2" bgcolor="#FFFFFF" class="legend">Suspect Action Report</td>
		<%}%>
		</tr>
		<tr style="border-bottom:2px solid #ccc;">							
			<td>
<%				if (user_role.equals("9")) { 
%>				
				<select id="selseason" name="selseason" onchange="getSeason('<%=suspectRole%>');">
					<option >----select------</option>
					<option value="0" selected>All</option>

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
			<td align="right">DATE :</b> <%=sdf.format(new Date())%></td>
		</tr>
	</table>
	
	<%
		//For Admin role is 9
	if (user_role.equals("9")) { 
	
	%>
		<table width="100%" cellpadding="5" cellspacing="2" class="table tableBorder">
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
<%		
		int counter = 1;
		if(crsUmpireSuspectAction != null){
			
				while(crsUmpireSuspectAction.next()){
			if(counter % 2 != 0){
%>
		<tr class="contentLight">
<%				}else{
%>		<tr class="contentDark">
<%				} //player,name,remark,match_id,Team1Name,Team2Name,start_date,end_date,tournament_name,playing_team
%>			<td align="left" id="<%=counter++%>"><%=crsUmpireSuspectAction.getString("name")%></td>
			<td align="left" id="<%=counter++%>"><%=crsUmpireSuspectAction.getString("remark")%></td>
			<td align="left"><%=crsUmpireSuspectAction.getString("Team1Name") +" vs " + crsUmpireSuspectAction.getString("Team2Name")%></td>
			<td align="left"><%=crsUmpireSuspectAction.getString("start_date")%></td>
			<td align="left"><%=crsUmpireSuspectAction.getString("end_date")%></td>
			<td align="left"><%=crsUmpireSuspectAction.getString("tournament_name")%></td>
			<td align="left"><%=crsUmpireSuspectAction.getString("playing_team")%></td>
			<td align="left"><%=crsUmpireSuspectAction.getString("officialname")%></td>
			<td align="left"><%=crsUmpireSuspectAction.getString("role")%></td>
		
<%			}//end of while
 		}//end of if
%>		</tr>

<%		if(crsUmpireCoachSuspectAction != null){
			//int counter = 1;
				while(crsUmpireCoachSuspectAction.next()){
			if(counter % 2 != 0){
%>
		<tr class="contentLight">
<%				}else{
%>		<tr class="contentDark">
<%				} //player,name,remark,match_id,Team1Name,Team2Name,start_date,end_date,tournament_name,playing_team
%>			<td align="left" id="<%=counter++%>"><%=crsUmpireCoachSuspectAction.getString("name")%></td>
			<td align="left" id="<%=counter++%>"><%=crsUmpireCoachSuspectAction.getString("remark")%></td>
			<td align="left"><%=crsUmpireCoachSuspectAction.getString("Team1Name") +" vs " + crsUmpireCoachSuspectAction.getString("Team2Name")%></td>
			<td align="left"><%=crsUmpireCoachSuspectAction.getString("start_date")%></td>
			<td align="left"><%=crsUmpireCoachSuspectAction.getString("end_date")%></td>
			<td align="left"><%=crsUmpireCoachSuspectAction.getString("tournament_name")%></td>
			<td align="left"><%=crsUmpireCoachSuspectAction.getString("playing_team")%></td>
			<td align="left"><%=crsUmpireCoachSuspectAction.getString("officialname")%></td>
			<td align="left"><%=crsUmpireCoachSuspectAction.getString("role")%></td>
		
<%			}//end of while
 		}//end of if
%>		</tr>

<%		if(crsRefereeSuspectAction != null){
			//int counter = 1;
				while(crsRefereeSuspectAction.next()){
			if(counter % 2 != 0){
%>
		<tr class="contentLight">
<%				}else{
%>		<tr class="contentDark">
<%				} //player,name,remark,match_id,Team1Name,Team2Name,start_date,end_date,tournament_name,playing_team
%>			<td align="left" id="<%=counter++%>"><%=crsRefereeSuspectAction.getString("name")%></td>
			<td align="left" id="<%=counter++%>"><%=crsRefereeSuspectAction.getString("remark")%></td>
			<td align="left"><%=crsRefereeSuspectAction.getString("Team1Name") +" vs " + crsRefereeSuspectAction.getString("Team2Name")%></td>
			<td align="left"><%=crsRefereeSuspectAction.getString("start_date")%></td>
			<td align="left"><%=crsRefereeSuspectAction.getString("end_date")%></td>
			<td align="left"><%=crsRefereeSuspectAction.getString("tournament_name")%></td>
			<td align="left"><%=crsRefereeSuspectAction.getString("playing_team")%></td>
			<td align="left"><%=crsRefereeSuspectAction.getString("officialname")%></td>
			<td align="left"><%=crsRefereeSuspectAction.getString("role")%></td>
		
<%			}//end of while
 		}//end of if
%>		</tr>
	</table>
	
	<%}else{%>
	<table width="100%" border="0" cellpadding="2" cellspacing="1" class="table">			
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
						<textarea id="txtRemarkDiv" name="txtRemarkDiv" class="textArea" rows="4" value = "Add Comments' cols="20" maxlength="500" onblur="imposeMaxLength(this,500,event,'txtRemarkDiv','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),restrict(document.frmSuspectActionReport.txtRemarkDiv),imposeMaxLength(this,500,event,'txtRemarkDiv','2')" ></textarea>
					</div>
				</td>
				<td align="left" width="10%">
       			<input type="button" id="btnAddSAction" name="btnAddSAction" value="Add" onclick="AddSuspectAction()" >
       			<input type="hidden" id="hdmatchid" name="hdmatchid" value="<%=match_id%>">
       			<input type="hidden" id="hdloginuserId" name="hdloginuserId" value="<%=user_id%>">
       			<input type="hidden" id="hdUserRole" name="hdUserRole" value="<%=user_role%>">
       			
       			<input type="hidden" id="hdsuspectRole" name="hdsuspectRole" value="">
       		</td>				
			</tr>					      		
	</table>	
	<br>
	<div id="tempDiv" >
		<table width="100%" border="1" cellpadding="2" cellspacing="1" class="table">
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
			<td align="left"><a id="deletelink" name="deletelink" href="javascript:DeleteSuspectAction('<%=crsObjDisplaySuspectAction.getString("player")%>')">Delete</td>
<%			}//end of while	
 }//end of if
%>		</tr>
	</table>
	</div>	
<%}%>		

<br>
<div id="SavedSuspectActionDiv" style="display: none; color:red;font-size: 15" align="center"></div>	
</form>	
	<table width="100%" border="0"  cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td>
				<jsp:include page="admin/Footer.jsp"></jsp:include>
			</td>
		</tr>
	</table>
	</div>
	</td>
	</tr>
	</table>
</div>
</body>
</html>   	

