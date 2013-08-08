<!--
Page Name    : UmpiresMatchSetUp.jsp
Created By 	 : Archana Dongre.
Created Date : 10th Oct 2008
Description  : Umpire's Match Setup Master 
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
 

<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>

<%
	try{
		
		final String ADMIN_FLAG = "1";
		final String UMP_FLAG = "2";
		String pageNo = "1";
		String TotalNoOfPages = null;
		String TotalPageCount = "1";
		String editMatchId = request.getParameter("hdmatchid")==null?"0":request.getParameter("hdmatchid");
		String popup = request.getParameter("popup")==null?"0":request.getParameter("popup");
		String hdsearch = request.getParameter("hdsearch")==null?"":request.getParameter("hdsearch");
		String hdfromdate = request.getParameter("hdfromdate")==null?"":request.getParameter("hdfromdate");
		String hdtodate = request.getParameter("hdtodate")==null?"":request.getParameter("hdtodate");
		String hdseriesName = request.getParameter("hdseriesName")==null?"":request.getParameter("hdseriesName");
		String hdTempFlag = request.getParameter("hdTempFlag")==null?"0":request.getParameter("hdTempFlag");			
		String userId = null;
		String userRole = request.getParameter("userrole") == null ? "0":request.getParameter("userrole");
		System.out.println("!!!!!!!!!!-!!!!!!!!!!"+userRole);
		String flag = "";		
		String userRoleId = "";
		userRoleId = session.getAttribute("user_role_id").toString();
		userId = session.getAttribute("userid").toString();
		
		System.out.println("userRoleId is "+userRoleId);
		System.out.println("userId is "+userId);
		Common commonUtil= new Common();
		CachedRowSet  crsObjTournamentNm = null;
		CachedRowSet  crsObjMatchData = null;
		CachedRowSet  crsObjMatchId = null;
		CachedRowSet  crsObjInsertRecord = null;
		CachedRowSet  crsObj= null;
		CachedRowSet  crsObjCountRecords = null;
		
		Vector vparam =  new Vector();
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String 	GSFromDate			=	sdf.format(new Date());
		String 	GSToDate			=	sdf.format(new Date());
		String 	gsFromDate="";
		String 	gsToDate="";
		String 	gsConvertFromDate = "01/11/2008";
		//String start_date = "01/11/2008";
		String 	gsConvertToDate="";
		String gsSeries = null;
		String message = "";
		String role="0";
		String gsSearchByMatch = "";
		String gsSearchByPageNo = "";
		String loginUserName = null;
		loginUserName = session.getAttribute("usernamesurname").toString();
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");
		
		try{
	        vparam.add(userId);
	       // out.println("userId "+userId);
			 crsObj = lobjGenerateProc.GenerateStoreProcedure("esp_adm_loginrole", vparam, "ScoreDB");

			if(crsObj!=null){
				while(crsObj.next()){
					role=crsObj.getString("role");
					System.out.println("role is "+role);
					if(userRole.equalsIgnoreCase("0")){
						userRole = role;
					}
				}
			}
			vparam.removeAllElements();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		try{
			vparam.add("1");//display all series name.
			crsObjTournamentNm = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_series_ms",vparam,"ScoreDB");
			vparam.removeAllElements();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(role.equalsIgnoreCase("9")){
			flag = "1";
		}else{
			flag = "2";
		}
		
		if(request.getParameter("hdseriesName") == null){//first time show all matches assigned to this user
			try{
				vparam.add("1");//page no
				vparam.add("");
				vparam.add("");
				vparam.add(userId);//official id.
				vparam.add("2");//to get all matches of official when flag is 2 and date parameter blank						
				crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure(
					"dbo.esp_dsp_getapprovaldetails",vparam,"ScoreDB");
				crsObjCountRecords = lobjGenerateProc.GenerateStoreProcedure(
					"dbo.esp_dsp_getapprovaldetails",vparam,"ScoreDB");
				vparam.removeAllElements();
				
				if(crsObjCountRecords != null){
					while(crsObjCountRecords.next()){
						TotalPageCount = crsObjCountRecords.getString("noofpages");					
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(request.getParameter("hdsearch")!= null && request.getParameter("txtMatchID")!= null && request.getParameter("hdsearch").equalsIgnoreCase("searchbyMatchID")){
			pageNo = request.getParameter("hdpageNo");
			gsSearchByMatch = request.getParameter("txtMatchID");
			try{
				vparam.add(gsSearchByMatch);
				crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_matchidsearch",vparam,"ScoreDB");
				crsObjCountRecords = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_matchidsearch",vparam,"ScoreDB");
				vparam.removeAllElements();
				
				if(crsObjCountRecords != null){
					while(crsObjCountRecords.next()){
						TotalPageCount = crsObjCountRecords.getString("noofpages");					
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}else if(request.getParameter("hdsearch")!= null && request.getParameter("hdseriesName")!= null && request.getParameter("hdsearch").equalsIgnoreCase("searchbyDateandSeries")){			
			pageNo = request.getParameter("hdpageNo");
			gsConvertFromDate = request.getParameter("hdfromdate");
			gsConvertToDate = request.getParameter("hdtodate");
			gsFromDate =commonUtil.formatDate(request.getParameter("hdfromdate"));
			gsToDate =commonUtil.formatDate(request.getParameter("hdtodate"));
			gsSeries = request.getParameter("hdseriesName");					
			try{
				vparam.add(pageNo);
				vparam.add(gsFromDate);
				vparam.add(gsToDate);
				vparam.add(gsSeries);
				vparam.add(userId);//Referee official id.
				vparam.add(flag);	
				crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure(
					"dbo.esp_dsp_getmatchesbydate_series_modified",vparam,"ScoreDB");
				crsObjCountRecords = lobjGenerateProc.GenerateStoreProcedure(
					"dbo.esp_dsp_getmatchesbydate_series_modified",vparam,"ScoreDB");
				vparam.removeAllElements();
				
				if(crsObjCountRecords != null){
					while(crsObjCountRecords.next()){
						TotalPageCount = crsObjCountRecords.getString("noofpages");					
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}else if(request.getParameter("hdsearch")!= null){						
			pageNo = request.getParameter("hdpageNo");
			gsConvertFromDate = request.getParameter("hdfromdate");
			gsConvertToDate = request.getParameter("hdtodate");
			gsFromDate =commonUtil.formatDate(request.getParameter("hdfromdate"));
			gsToDate =commonUtil.formatDate(request.getParameter("hdtodate"));			
			try{
				vparam.add(pageNo);
				vparam.add("");
				vparam.add("");
				vparam.add(userId);//Referee official id.
				vparam.add(flag);						
				crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure(
					"dbo.esp_dsp_getmatchesbydate_modified",vparam,"ScoreDB");
				crsObjCountRecords = lobjGenerateProc.GenerateStoreProcedure(
					"dbo.esp_dsp_getmatchesbydate_modified",vparam,"ScoreDB");
				vparam.removeAllElements();
				
				if(crsObjCountRecords != null){
					while(crsObjCountRecords.next()){
						TotalPageCount = crsObjCountRecords.getString("noofpages");					
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}		
%>
<html>
<head>
	<title> Match Search For Officials</title>
	<link href="../css/adminForm.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="../js/Calender.js" type="text/javascript"></script>
	<script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
<%--	<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">--%>
	<script language="javascript">
		
		function fromToDateValidate(fromDate,toDate)
			{		
			fromDay   = fromDate.substring(0, fromDate.indexOf("/"));
			fromMonth = fromDate.substring (fromDate.indexOf ("/")+1, fromDate.lastIndexOf ("/"));
			fromYear  = fromDate.substring (fromDate.lastIndexOf("/")+1, fromDate.length); 
		
		//   enterYear  = strDate.substring (strDate.lastIndexOf ("/")+1, strDate.length); 
		
			objFromDate = new Date()
		
		
			objFromDate.setDate(fromDay);
		    objFromDate.setMonth(fromMonth - 1);
		    objFromDate.setYear(fromYear);
		
		
			toDay   = toDate.substring(0, toDate.indexOf("/"));
			toMonth = toDate.substring (toDate.indexOf ("/")+1, toDate.lastIndexOf ("/"));
			toYear  = toDate.substring (toDate.lastIndexOf ("/")+1, toDate.length); 
		
			objToDate = new Date()
		
		   
		    objToDate.setDate(toDay);
		    objToDate.setMonth(toMonth - 1);
		    objToDate.setYear(toYear);
		
		
			fromDateTime  = objFromDate.getTime();
			toDateTime    = objToDate.getTime();
		
		
			// calculating difference in time //
			diffTime =(toDateTime - fromDateTime);
		
		
			if(diffTime < 0) {			
				return false	
			}
			else {
				return true
			}
	
		}  // end of fromToDateValidate
	
	
		/// method to validate with  current date ,entered date should not be less than current date	
		
	function getFirstTenMatches(nextPage){
		if(document.getElementById("hdTotalNoOfPages").value == "null"){
			alert("Please Search Matches");
		}else{
			var lastpage = document.getElementById("hdTotalNoOfPages").value;			
			nextPage++		
			if(nextPage > lastpage){
				alert("You have reached on last page");
				return false;
			}else{
				searchMatches(nextPage)
			}
		}		
	}
	
	function getLastTenMatches(prePage){
		if(document.getElementById("hdTotalNoOfPages").value == "null"){
			alert("Please Search Matches");
		}else{
			prePage--	
			if(prePage == "0"){
				alert("You have reached on first page ! ");
				return false;
			}else{			
				searchMatches(prePage)
			}
		}
	}
	
	function getAllMatches(pageNo){
		document.getElementById("hdpageNo").value = pageNo;
		document.getElementById("hdsearch").value = null;
		document.frmAdminMatchSetUp.action = "UmpiresMatchSetUp.jsp";
		document.frmAdminMatchSetUp.submit();
	}
	
	function searchMatches(pageNo){
		/*var fromdate = document.getElementById("txtFromdate").value;
		var todate = document.getElementById("txtTodate").value;
		if(document.getElementById("dptournament").value != null){
			if(document.getElementById("txtFromdate").value == ""){
				alert("Please Select From Date For Search")
				return false;
			}else if(document.getElementById("txtTodate").value == ""){
				alert("Please Select To Date For Search");
				return false;
			}else if(fromToDateValidate(fromdate,todate) == false){
		 		alert("Please select Fromdate less than or equal to Todate ");
		 		return false;
			}
		}else {
			if(document.getElementById("txtFromdate").value == ""){
				alert("Please Select From Date For Search")
				return false;
			}else if(document.getElementById("txtTodate").value == ""){
				alert("Please Select To Date For Search");
				return false;
			}else if(fromToDateValidate(fromdate,todate) == false){
		 		alert("Please select Fromdate less than or equal to Todate ");
		 		return false;
			}
		}	*/	
		if(document.getElementById("txtMatchID").value != null && document.getElementById("txtMatchID").value != "0" && document.getElementById("txtMatchID").value != ""){
			document.getElementById("hdpageNo").value = pageNo;
			document.getElementById("hdsearch").value = "searchbyMatchID";
			document.frmAdminMatchSetUp.action = "UmpiresMatchSetUp.jsp";
			document.frmAdminMatchSetUp.submit();
		}else if(document.getElementById("txtFromdate").value != null && document.getElementById("txtTodate").value != null){
			document.getElementById("hdpageNo").value = pageNo;
			document.getElementById("hdfromdate").value = document.getElementById("txtFromdate").value;
			document.getElementById("hdtodate").value = document.getElementById("txtTodate").value;
			//document.getElementById("hdseriesName").value = document.getElementById("dptournament").value;
			//document.getElementById("hdsearch").value = "searchbyDateandSeries";
			document.getElementById("hdsearch").value = "searchbyDate";
			document.frmAdminMatchSetUp.action = "UmpiresMatchSetUp.jsp";
			document.frmAdminMatchSetUp.submit();
		}else if(document.getElementById("txtFromdate").value != null && document.getElementById("txtTodate").value != null ){
			document.getElementById("hdpageNo").value = pageNo;
			document.getElementById("hdfromdate").value = document.getElementById("txtFromdate").value;
			document.getElementById("hdtodate").value = document.getElementById("txtTodate").value;
			document.getElementById("hdsearch").value = "searchbyDate";
			document.frmAdminMatchSetUp.action = "UmpiresMatchSetUp.jsp";
			document.frmAdminMatchSetUp.submit();
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
	
	function MatchStatusOfUmpires(matchId,status,id){
		var userId = document.getElementById("hdUserId").value;
		if(status == "Y"){
			var row = document.getElementById(id);
			row.className = 'rejectRecord';
			document.getElementById("btnAccept"+matchId).disabled = true;
			document.getElementById("btnReject"+matchId).disabled = true;
		}else{
			var row = document.getElementById(id);
			row.className = 'acceptRecord';
			document.getElementById("btnAccept"+matchId).disabled = true;
			document.getElementById("btnReject"+matchId).disabled = true;
		}
		xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
            return;
		}else{
           	var url ;
            url="UmpireStatusResponse.jsp?matchId="+matchId+"&status="+status+"&userId="+userId;
          	document.getElementById("divReturnMessage").style.display='';
			//xmlHttp.onreadystatechange=stateChangedAcceptResponse;
			xmlHttp.open("post",url,false);
            xmlHttp.send(null);
            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				var responseResult= xmlHttp.responseText;
				if(status == 'N'){
					document.getElementById("divReturnMessage").innerHTML = "Match has been Rejected";
					getAllMatches('1');
				}else{
					document.getElementById("divReturnMessage").innerHTML = "Match has been Accepted";
					getAllMatches('1');
				}				
			}
		}			
	}
	// to change textfield color
	function changeColour(which) {
		if (which.value.length > 0) {   // minimum 2 characters
			which.style.background = "#FFFFFF"; // white
		}
		else {
			which.style.background = "";  // yellow			
		}
	}
</script>
</head>
<body>
<% 
	
	if(!popup.equalsIgnoreCase("A")) {%>
	<jsp:include page="Menu.jsp"></jsp:include>
<% }
%>
<FORM name="frmAdminMatchSetUp" id="frmAdminMatchSetUp" method="post">
<br><br>
<br>
	<table width="900" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">		
		<tr align="center">
			 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">Approval By Official's Of Match 
	          </td>
	    </tr>
	    
	    <tr width="90%" class="contentLight">
			<td colspan="9" align="right"><b><%=loginUserName%>&nbsp;&nbsp;&nbsp;DATE
			:</b> <%=sdf1.format(new Date())%></td>
		</tr>
		<tr align="left" class="contentDark">
			<input type="hidden" id="hdmatchid" name="hdmatchid" value="<%=editMatchId%>">
			<input type="hidden" id="hdMatchFlag" name="hdMatchFlag" value="">
			<td colspan="4">
				&nbsp;&nbsp;&nbsp;&nbsp;Match Id:&nbsp;<input class="inputFieldMatchSetup" type="text" id="txtMatchID" name="txtMatchID" value="" >
				<input class="button1" type="button" id="btnsearch" name="btnsearch" value=" Search " onclick="searchMatches('1')">
	    		<input type="hidden" id="hdsearch" name="hdsearch" value="<%=hdsearch%>">
	    		<input class="button1" type="button" id="btngetall" name="btngetall" value=" Get All Matches " onclick="getAllMatches('1')">
				
			</td>
		</tr>
		<tr width="90%" class="contentLight">
<%--			<td >&nbsp;&nbsp;From:</td> --%>
				<%if(gsConvertFromDate != ""){%>
			<td>
				<a href="javascript:showCal('FrCalendarFrom','StartDate','txtFromdate','frmAdminMatchSetUp')">
				<input type="hidden" class="textBoxAdminMatchSetup" name="txtFromdate" id="txtFromdate" readonly
					value="<%=gsConvertFromDate%>">&nbsp;&nbsp;
<%--				<IMG src="../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;--%>
				<input type="hidden" id="hdfromdate" name="hdfromdate" value="<%=hdfromdate%>">
			</td>
			<%}else {%>
			<td>
		   		<a href="javascript:showCal('FrCalendar','StartDate','txtFromdate','frmAdminMatchSetUp')">
		   		<input type="hidden" class="textBoxAdminMatchSetup" name="txtFromdate" id="txtFromdate" readonly
				value="<%=GSFromDate%>" >&nbsp;&nbsp;				
<%--				<IMG src="../images/cal.gif" border="0" alt="" ></a>&nbsp;&nbsp;&nbsp;&nbsp;--%>
				<input type="hidden" id="hdfromdate" name="hdfromdate" value="<%=hdfromdate%>">																
			</td>
			<%}%> 	
<%--   			<td>To :</td>	--%>
			<%if(gsConvertToDate != ""){%>
			<td>
				<a href="javascript:showCal('FrCalendarTo','EndDate','txtTodate','frmAdminMatchSetUp')">
				<input type="hidden" class="textBoxAdminMatchSetup" name="txtTodate" id="txtTodate" readonly
					value="<%=gsConvertToDate%>">&nbsp;&nbsp;
<%--				<IMG src="../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;--%>
				<input type="hidden" id="hdtodate" name="hdtodate" value="<%=hdtodate%>">
	    	</td>
	    	<%}else {%>
			<td>
				<a href="javascript:showCal('FrCalendarTo','EndDate','txtTodate','frmAdminMatchSetUp')">
				<input type="hidden" class="textBoxAdminMatchSetup" name="txtTodate" id="txtTodate" readonly
					value="<%=GSToDate%>">&nbsp;&nbsp;
<%--				<IMG src="../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;--%>
				<input type="hidden" id="hdtodate" name="hdtodate" value="<%=hdtodate%>">
			</td>
			<%}%>
		</tr>
	</table>		
	<table width="90%" align="center">
		<tr>
			<td>
				<fieldset><legend class="legend1">Match Details
					</legend> 
					<table align="center" width="90%">
					<tr>
						<td align="left"><b>Current Page : <%=pageNo%> Of <%=TotalPageCount%></b>&nbsp;&nbsp;
							<a href="#" id="btnBack" name="btnBack" onclick="getLastTenMatches('<%=Integer.parseInt(pageNo)%>')"><<</a> <!--1st para flag for paging,2 nd para for navigateBack-->
							&nbsp;<a href="#" id="btnNext" name="btnNext" onclick="getFirstTenMatches('<%=Integer.parseInt(pageNo)%>')">>></a><!--1st para flag for paging,2 nd para for navigateNext-->
						&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
<!--						<td colspan="5" style="color: red">Pending</td>-->
<!--						<td colspan="5" style="color: blue"> Rejected</td>-->
<!--						<td colspan="5" style="color: Green">Accepted</td>-->
					</tr></table>
					<div id="divReturnMessage" style="display: none; color: blue;font-size: 10" align="center" ></div>
			 		<table align="center" width="100%" id="tablematches" border="1">
							<tr class="contentDark">
								<td class="colheadingforadminuser" nowrap="nowrap">M_Id</td>
								<td class="colheadingforadminuser" nowrap="nowrap">Tournament</td>
								<td class="colheadingforadminuser" nowrap="nowrap">Venue</td>
								<td class="colheadingforadminuser" nowrap="nowrap">Start Date</td>
								<td class="colheadingforadminuser" nowrap="nowrap">End Date</td>
								<td class="colheadingforadminuser" nowrap="nowrap">Team_1</td>
								<td class="colheadingforadminuser" nowrap="nowrap">Team_2</td>
								
								
<%
int irole = Integer.parseInt(userRole);
switch (irole) {
    case 4:
%>
		<td align="center" class="colheadingforadminuser" nowrap="nowrap" >Referee </td>
<%
    break;
    case 3:
    	%>
    	<td align="center" class="colheadingforadminuser" nowrap="nowrap" >Scorer </td>
    	<%
    break;
    case 29:
    	%>
    	<td align="center" class="colheadingforadminuser" nowrap="nowrap" >Analyst </td>
    	<%
    break;	
    case 2:
%>
		<td align="center" class="colheadingforadminuser" nowrap="nowrap">Umpire</td>
<% 		break;

    case 6:
%>    	
    	<td align="center" class="colheadingforadminuser" nowrap="nowrap">Coach </td> 
<%	break;
	} %>
		<td class="colheadingforadminuser" nowrap="nowrap">Accept</td>
		<td class="colheadingforadminuser" nowrap="nowrap">Reject</td>
	</tr>
<%	
	if(crsObjMatchData != null){													
		if(crsObjMatchData.size() == 0){
			message = " No Data Available ";
%>									
<%		}else{
			int i=0;
			while(crsObjMatchData.next()){
				TotalNoOfPages = crsObjMatchData.getString("noofpages");
%>
	<tr id="<%=i%>">
		<td align="left" width="3"><font size="2">
		<input type="radio" id="rdadmin" name="rdadmin" value="">
		<%=crsObjMatchData.getString("match_id")%>
		<td align="left" width="50"><font size="2"><%=crsObjMatchData.getString("series_name")%></font></td>
		<%if(crsObjMatchData.getString("venue_name") != null){%>
		<td align="center" width="10"><font size="2"><%=crsObjMatchData.getString("venue_name")%></font></td>
		<%}else{%>
		<td align="center" width="10"><font size="2">----</font></td>
		<%}%>
		<td align="left" width="55"><font size="2"><%=crsObjMatchData.getString("start_ts").substring(0,11).toString()%></font></td>
		<td align="left" width="55"><font size="2"><%=crsObjMatchData.getString("end_ts").substring(0,11).toString()%></font></td>
		<td align="left" width="10"><font size="2"><%=crsObjMatchData.getString("team_one")%></font></td>
		<td align="left" width="10"><font size="2"><%=crsObjMatchData.getString("team_two")%></font></td>
<%
switch (irole) {
    case 4://referee
%>
		<%if(crsObjMatchData.getString("ref_confirmed").equalsIgnoreCase("Y")){%>
		<td align="center" style="color: green"><font size="2">
			<div id="refereeDiv<%=crsObjMatchData.getString("match_id")%>">Accepted</div></font>									
			<input type="hidden" id="hdreferee<%=crsObjMatchData.getString("match_id")%>" name="hdreferee<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
		</td>
		<%}else if(crsObjMatchData.getString("ref_confirmed").equalsIgnoreCase("P") ||
				crsObjMatchData.getString("ref_confirmed").equalsIgnoreCase("I")){%>
		<td align="center" style="color: red"><font size="2">
			<div id="refereeDiv<%=crsObjMatchData.getString("match_id")%>">Pending</div></font>									
			<input type="hidden" id="hdreferee<%=crsObjMatchData.getString("match_id")%>" name="hdreferee<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
		</td>
		<%}else if(crsObjMatchData.getString("ref_confirmed").equalsIgnoreCase("N")){%>
		<td align="center" style="color: blue"><font size="2">
			<div id="refereeDiv<%=crsObjMatchData.getString("match_id")%>">Rejected</div></font>									
			<input type="hidden" id="hdreferee<%=crsObjMatchData.getString("match_id")%>" name="hdreferee<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
		</td>
		<%}else{%>
		<td>&nbsp;</td>
		<%}%>
<%
    break;
    case 3://scorer
    	%>
<%				if(userRoleId.equalsIgnoreCase(crsObjMatchData.getString("scorerid"))){
					if(crsObjMatchData.getString("scorer1_confirmed").equalsIgnoreCase("Y")){%>
	    			<td align="center" style="color: green"><font size="2">
	    				<div id="scorer1Div<%=crsObjMatchData.getString("match_id")%>">Accepted</div></font>									
	    				<input type="hidden" id="hdscorer1<%=crsObjMatchData.getString("match_id")%>" name="hdscorer1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorerid")%>" >
	    			</td>
	    			<%}else if(crsObjMatchData.getString("scorer1_confirmed").equalsIgnoreCase("P")){%>
	    			<td align="center" style="color: blue"><font size="2">
	    			    <div id="scorer1Div<%=crsObjMatchData.getString("match_id")%>">Pending</div></font>									
	    				<input type="hidden" id="hdscorer1<%=crsObjMatchData.getString("match_id")%>" name="hdscorer1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorerid")%>" >
	    			</td>
	    			<%}else if(crsObjMatchData.getString("scorer1_confirmed").equalsIgnoreCase("N")){%>
	    			<td align="center" style="color: red"><font size="2">
	    				<div id="scorer1Div<%=crsObjMatchData.getString("match_id")%>">Rejected</div></font>									
	    				<input type="hidden" id="hdscorer1<%=crsObjMatchData.getString("match_id")%>" name="hdscorer1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorerid")%>" >
	    			</td>
	    			<%}else{%>
	    			<td>&nbsp;</td>
	    			<%}
				}	
%>

<%				if(userRoleId.equalsIgnoreCase(crsObjMatchData.getString("scorer2id"))){
					if(crsObjMatchData.getString("scorer2_confirmed").equalsIgnoreCase("Y")){%>
	    			<td align="center" style="color: green"><font size="2">
	    				<div id="scorer2Div<%=crsObjMatchData.getString("match_id")%>">Accepted</div></font>									
	    				<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2id")%>" >
	    			</td>
	    			<%}else if(crsObjMatchData.getString("scorer2_confirmed").equalsIgnoreCase("P")){%>
	    			<td align="center" style="color: blue"><font size="2">
	    			    <div id="scorer2Div<%=crsObjMatchData.getString("match_id")%>">Pending</div></font>									
	    				<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2id")%>" >
	    			</td>
	    			<%}else if(crsObjMatchData.getString("scorer2_confirmed").equalsIgnoreCase("N")){%>
	    			<td align="center" style="color: red"><font size="2">
	    				<div id="scorer2Div<%=crsObjMatchData.getString("match_id")%>">Rejected</div></font>									
	    				<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2id")%>" >
	    			</td>
	    			<%}else{%>
	    			<td>&nbsp;</td>
	    			<%}
				}	
%>

<%
	 break;
    
    case 29://analyst
%>
<%				if(userRoleId.equalsIgnoreCase(crsObjMatchData.getString("analystid"))){
					if(crsObjMatchData.getString("analyst_confirmed").equalsIgnoreCase("Y")){%>
	    			<td align="center" style="color: green"><font size="2">
	    				<div id="analyst1Div<%=crsObjMatchData.getString("match_id")%>">Accepted</div></font>									
	    				<input type="hidden" id="hdanalyst1<%=crsObjMatchData.getString("match_id")%>" name="hdanalyst1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid")%>" >
	    			</td>
	    			<%}else if(crsObjMatchData.getString("analyst_confirmed").equalsIgnoreCase("P")){%>
	    			<td align="center" style="color: blue"><font size="2">
	    			    <div id="analyst1Div<%=crsObjMatchData.getString("match_id")%>">Pending</div></font>									
	    				<input type="hidden" id="hdanalyst1<%=crsObjMatchData.getString("match_id")%>" name="hdanalyst1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid")%>" >
	    			</td>
	    			<%}else if(crsObjMatchData.getString("analyst_confirmed").equalsIgnoreCase("N")){%>
	    			<td align="center" style="color: red"><font size="2">
	    				<div id="analyst1Div<%=crsObjMatchData.getString("match_id")%>">Rejected</div></font>									
	    				<input type="hidden" id="hdanalyst1<%=crsObjMatchData.getString("match_id")%>" name="hdanalyst1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid")%>" >
	    			</td>
	    			<%}else{%>
	    			<td>&nbsp;</td>
<%					}
				}	
%>

<%				if(userRoleId.equalsIgnoreCase(crsObjMatchData.getString("analystid1"))){
					if(crsObjMatchData.getString("analyst1_confirmed").equalsIgnoreCase("Y")){%>
	    			<td align="center" style="color: green"><font size="2">
	    				<div id="analyst2Div<%=crsObjMatchData.getString("match_id")%>">Accepted</div></font>									
	    				<input type="hidden" id="hdanalyst2<%=crsObjMatchData.getString("match_id")%>" name="hdanalyst2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid1")%>" >
	    			</td>
	    			<%}else if(crsObjMatchData.getString("analyst1_confirmed").equalsIgnoreCase("P")){%>
	    			<td align="center" style="color: blue"><font size="2">
	    			    <div id="analyst2Div<%=crsObjMatchData.getString("match_id")%>">Pending</div></font>									
	    				<input type="hidden" id="hdanalyst2<%=crsObjMatchData.getString("match_id")%>" name="hdanalyst2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid1")%>" >
	    			</td>
	    			<%}else if(crsObjMatchData.getString("analyst1_confirmed").equalsIgnoreCase("N")){%>
	    			<td align="center" style="color: red"><font size="2">
	    				<div id="analyst2Div<%=crsObjMatchData.getString("match_id")%>">Rejected</div></font>									
	    				<input type="hidden" id="hdanalyst2<%=crsObjMatchData.getString("match_id")%>" name="hdanalyst2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid1")%>" >
	    			</td>
	    			<%}else{%>
	    			<td>&nbsp;</td>
<%					}
				}
%>

    	<%
    break; 	
    	
    	
    case 2://umpires
%>
<%				if(userRoleId.equalsIgnoreCase(crsObjMatchData.getString("umpire1id"))){
					if(crsObjMatchData.getString("ump1_confirmed").equalsIgnoreCase("Y")){
%>
					<td align="center" style="color: green"><font size="2">									
						<div id="Ump1Div<%=crsObjMatchData.getString("match_id")%>" >Accepted</div></font>									
						<input type="hidden" id="hdUmp1<%=crsObjMatchData.getString("match_id")%>" name="hdUmp1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >																		
					</td>
					<%}else if(crsObjMatchData.getString("ump1_confirmed").equalsIgnoreCase("P") || 
							crsObjMatchData.getString("ump1_confirmed").equalsIgnoreCase("I")){%>
					<td align="center" style="color: blue"><font size="2">									
						<div id="Ump1Div<%=crsObjMatchData.getString("match_id")%>" >Pending</div></font>									
						<input type="hidden" id="hdUmp1<%=crsObjMatchData.getString("match_id")%>" name="hdUmp1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >																		
					</td>
					<%}else if(crsObjMatchData.getString("ump1_confirmed").equalsIgnoreCase("N")){%>
					<td align="center" style="color: red"><font size="2">									
						<div id="Ump1Div<%=crsObjMatchData.getString("match_id")%>" >Rejected</div></font>									
						<input type="hidden" id="hdUmp1<%=crsObjMatchData.getString("match_id")%>" name="hdUmp1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >																		
					</td>
					<%}else{%>
					<td>&nbsp;</td>
<%					}
			 	 }		
%>
													
<%				if(userRoleId.equalsIgnoreCase(crsObjMatchData.getString("umpire2id"))){
					if(crsObjMatchData.getString("ump2_confirmed").equalsIgnoreCase("Y")){
%>
					<td align="center" style="color: green"><font size="2">
						<div id="Ump2Div<%=crsObjMatchData.getString("match_id")%>">Accepted</div></font>									
						<input type="hidden" id="hdUmp2<%=crsObjMatchData.getString("match_id")%>" name="hdUmp2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
					</td>
					<%}else if(crsObjMatchData.getString("ump2_confirmed").equalsIgnoreCase("P") || 
							crsObjMatchData.getString("ump2_confirmed").equalsIgnoreCase("I")){%>
					<td align="center" style="color: blue"><font size="2">
						<div id="Ump2Div<%=crsObjMatchData.getString("match_id")%>">Pending</div></font>									
						<input type="hidden" id="hdUmp2<%=crsObjMatchData.getString("match_id")%>" name="hdUmp2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
					</td>
					<%}else if(crsObjMatchData.getString("ump2_confirmed").equalsIgnoreCase("N")){%>
					<td align="center" style="color: red"><font size="2">
						<div id="Ump2Div<%=crsObjMatchData.getString("match_id")%>">Rejected</div></font>									
						<input type="hidden" id="hdUmp2<%=crsObjMatchData.getString("match_id")%>" name="hdUmp2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
					</td>
					<%}else{%>
					<td>&nbsp;</td>
<%					}
				}	
%>
<%				if(userRoleId.equalsIgnoreCase(crsObjMatchData.getString("umpire3id"))){
					if(crsObjMatchData.getString("ump3_confirmed").equalsIgnoreCase("Y")){
%>
					<td align="center" style="color: green"><font size="2">
						<div id="Ump3Div<%=crsObjMatchData.getString("match_id")%>">Accepted</div></font>									
						<input type="hidden" id="hdUmp3<%=crsObjMatchData.getString("match_id")%>" name="hdUmp3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
					</td>
					<%}else if(crsObjMatchData.getString("ump3_confirmed").equalsIgnoreCase("P") ||
							crsObjMatchData.getString("ump3_confirmed").equalsIgnoreCase("I")){%>
					<td align="center" style="color: blue"><font size="2">
						<div id="Ump3Div<%=crsObjMatchData.getString("match_id")%>">Pending</div></font>									
						<input type="hidden" id="hdUmp3<%=crsObjMatchData.getString("match_id")%>" name="hdUmp3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
					</td>
					<%}else if(crsObjMatchData.getString("ump3_confirmed").equalsIgnoreCase("N")){%>
					<td align="center" style="color: red"><font size="2">
						<div id="Ump3Div<%=crsObjMatchData.getString("match_id")%>">Rejected</div></font>									
						<input type="hidden" id="hdUmp3<%=crsObjMatchData.getString("match_id")%>" name="hdUmp3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
					</td>
					<%}else{%>
					<td>&nbsp;</td>
<%					}
				}	
%>



<% 	break;
    case 6://umpire coach
%>    	
				<%if(crsObjMatchData.getString("umpch_confirmed").equalsIgnoreCase("Y")){%>
				<td align="center" style="color: green"><font size="2">
					<div id="UmpCoachDiv<%=crsObjMatchData.getString("match_id")%>">Accepted</div></font>									
					<input type="hidden" id="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" name="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
				</td>
				<%}else if(crsObjMatchData.getString("umpch_confirmed").equalsIgnoreCase("P") ||
						crsObjMatchData.getString("umpch_confirmed").equalsIgnoreCase("I")){%>
				<td align="center" style="color: blue"><font size="2">
					<div id="UmpCoachDiv<%=crsObjMatchData.getString("match_id")%>">Pending</div></font>									
					<input type="hidden" id="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" name="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
				</td>
				<%}else if(crsObjMatchData.getString("umpch_confirmed").equalsIgnoreCase("N")){%>
				<td align="center" style="color: red"><font size="2">
					<div id="UmpCoachDiv<%=crsObjMatchData.getString("match_id")%>">Rejected</div></font>									
					<input type="hidden" id="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" name="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
				</td>
				<%}else{%>
				<td>&nbsp;</td>
				<%}%>
											 
<%	break;
	} 
%>
								<td align="left" width="3">
									<input class="button1" type="button"  id="btnAccept<%=crsObjMatchData.getString("match_id")%>" onclick="MatchStatusOfUmpires('<%=crsObjMatchData.getString("match_id")%>','Y',<%=i%>)" value="Accept">
								</td>
								<td align="left" width="3">
									<input class="button1" type="button"  id="btnReject<%=crsObjMatchData.getString("match_id")%>"  onclick="MatchStatusOfUmpires('<%=crsObjMatchData.getString("match_id")%>','N',<%=i%>)" value="Reject">									
								</td>
<%								i=i+1;
							}
							}//end of while
						}//end of outer if
%>
						</tr>
					</table>
				</fieldset>
			</td>
		</tr>
		<tr>
			<td colspan="9"></td>
				<input type="hidden" name="hdTotalNoOfPages" id="hdTotalNoOfPages" align="center" value="<%=TotalNoOfPages%>">
				<input type="hidden" id="hdpageNo" name="hdpageNo" value="" >
				<input type="hidden" id="hddivmatchid" name="hddivmatchid" value="0">
				<input type="hidden" id="hdsubmit" name="hdsubmit" value="">
				<input type="hidden" id="popup" name="popup" value="<%=popup%>">
				<input type="hidden" id="hdUserId" name="hdUserId" value="<%=userId%>">
		</tr>
	</table>
	<table width="90%" align="center"><tr style="color:red;font-size: 15" align="center"><td colspan="6" ><label><%=message%></label></td></tr></table>
			
			
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally {

	}
%>
</FORM>
<br><br><br>
<jsp:include page="admin/Footer.jsp"></jsp:include>
</body>

</html>