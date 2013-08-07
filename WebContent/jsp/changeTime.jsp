<!--
Page Name 	 : changeTime.jsp
Created By 	 : Dipti Shinde.
Created Date : 28-Oct-2009
Description  : To update match inning time
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 28-Oct-2009
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="java.util.*,java.util.*,in.co.paramatrix.csms.common.Common"%>
<%
	Common commonUtil= new Common();	
	Calendar cal = 	Calendar.getInstance();
	String role=null;	
	String userID = null;
	CachedRowSet roleCrs = null;
	CachedRowSet timeCrs = null;
	CachedRowSet timeChangeCrs = null;
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure();
	Vector spParam = new Vector();
	LogWriter log = new LogWriter();
	
	userID = session.getAttribute("userid").toString();
	session.setAttribute("userId",userID);	
	String matchId = request.getParameter("matchId");
	String hidChangeTime = request.getParameter("hidChangeTime")==null?"0":request.getParameter("hidChangeTime");
	
	if(matchId == null){
		matchId = request.getParameter("hidMatchId");
	}
	/*******************************************************************************************/
	spParam.removeAllElements();
    spParam.add(userID);
	roleCrs = spGenerate.GenerateStoreProcedure("esp_adm_loginrole", spParam, "ScoreDB");

	if(roleCrs!=null){
		while(roleCrs.next()){
			role=roleCrs.getString("role");
			System.out.println("role is "+role);
		}
	}
	
	if(role != null && role.equals("9")){
		session.setAttribute("role",role);
		String r = (String)session.getAttribute("role");
		System.out.println("role....."+r);
	}else{
		session.setAttribute("role",role);//if not admin
	}
	/*****************************************UPDATE******************************************/
	if(hidChangeTime.equalsIgnoreCase("1")){//update last innings end time(either set to null or update)
		String innId = request.getParameter("hidInningId")==null?"0":request.getParameter("hidInningId");
		String innStartTime = request.getParameter("txtstarttime")==null?"0":request.getParameter("txtstarttime");
		String innEndTime = request.getParameter("txtendtime")==""?"":request.getParameter("txtendtime");
		
		if(request.getParameter("txtendtime").trim().equalsIgnoreCase("null")){
			innEndTime = "";
		}
		try{
			spParam.removeAllElements();
			spParam.add(innId);
			spParam.add(innStartTime);
			spParam.add(innEndTime);
		
			timeChangeCrs = spGenerate.GenerateStoreProcedure("esp_amd_changeinningstime",spParam,"ScoreDB");
			spParam.removeAllElements();
			
		}catch(Exception e){
		  	log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		
	}
	/*****************************************DISPLAY**************************************************/
	try{
		spParam.removeAllElements();
		spParam.add(matchId);
		timeCrs = spGenerate.GenerateStoreProcedure("esp_dsp_inningstime",spParam,"ScoreDB");
		spParam.removeAllElements();
		
	}catch(Exception e){
	  	log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	/*******************************************************************************************/
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Update Match Time</title>
	<script language="JavaScript" src="../js/datetimepicker.js" type="text/javascript"></script>
       <script language="JavaScript" src="../js/Calender.js" type="text/javascript"></script>
       <script language="JavaScript" src="../js/common.js" type="text/javascript"></script>
       <script language="JavaScript" src="../js/timer.js" type="text/javascript"></script>
	<link href="../css/csms.css" rel="stylesheet" type="text/css">
	<script language="JavaScript" src="<%=request.getContextPath()%>../js/jsKeyRestrictvalidation.js"></script>
	<script type="text/javascript" >
	function previousPage(){
		try{
			var role = document.getElementById('hdRole').value
			if(role == 9){
				document.getElementById("frmchenagetime").action="../jsp/admin/EditMatch.jsp";//dipti 19 05 2009
			}else{
				document.getElementById("frmchenagetime").action="/cims/jsp/TeamSelection.jsp";
			}
			document.getElementById("frmchenagetime").submit();
		}catch(err){
			alert(err.description + 'changeResult.jsp.previousPage()');
		}
	} 
	function updateTime(innid){
		var starttime = document.getElementById('txtstarttime').value
		var endtime = document.getElementById('txtendtime').value
		document.getElementById("hidChangeTime").value="1"
		document.getElementById("hidInningId").value = innid
			
		starttime = convertdatetimewithdash(starttime)
		document.getElementById('txtstarttime').value = starttime
		if(endtime == ""){
			document.getElementById('txtendtime').value = "null"
		}else{
			endtime = convertdatetimewithdash(endtime)
			document.getElementById('txtendtime').value = endtime
		}
		document.getElementById("frmchenagetime").action="/cims/jsp/changeTime.jsp";
		document.getElementById("frmchenagetime").submit();
	}	
	</script>
</head>
<body>
	<jsp:include page="MenuScorer.jsp"></jsp:include> 
	<br>
	<br>
	<form id="frmchenagetime" name="frmchenagetime" method="post">
		<table style="width:90%"  border="0" cellspacing="1" cellpadding="3">
			<tr>
				<td width="100%" colspan="8">
					<table  align="center" width="100%">
						<tr>
							<td  align="left">
								<input type="button" value="Back" onclick="previousPage()">
							</td>
						</tr>	
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
						<tr class="tenoverupdateball">
							<th align="center" ><b>Match Id : <%=matchId%></b></th>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
				<%
				if(timeCrs!=null){
				  	while(timeCrs.next()){
				%>
			<tr>
				<td class="contentLastDark">
					<b>Start Time : </b><input type="Text" id="txtstarttime"  name="txtstarttime" maxlength="25" size="25" value="<%=timeCrs.getString("start_ts") == null ? "" : commonUtil.formatDateTimeNewSlash(timeCrs.getString("start_ts"))%>" readonly >&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtstarttime','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>				
				</td>
				<td class="contentLastDark">
					<b>End Time : </b><input type="Text" id="txtendtime"  name="txtendtime" maxlength="25" size="25" value="<%=timeCrs.getString("end_ts") == null ? "" : commonUtil.formatDateTimeNewSlash(timeCrs.getString("end_ts"))%>"  >&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtendtime','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>
				</td>
				<td class="contentLastDark">
					<input type="button" value="Save" class="btn" tabindex="4" onclick="updateTime('<%=timeCrs.getString("id") %>');"></input>
				</td>
			</tr>	
				<%
				  	}
				}  	
				%>
	      	<tr>
	      		<td>
	      			&nbsp;
	      		</td>
	      	</tr>
		</table>
		<input type="hidden" name="hidMatchId" id="hidMatchId" value="<%=matchId%>">
		<input type="hidden" name="hidChangeTime" id="hidChangeTime" value="">
		<input type="hidden" name="hidInningId" id="hidInningId" value="">
		<input type="hidden" id="hdRole" name="hdRole" value="<%=role%>">	
	</form>      	