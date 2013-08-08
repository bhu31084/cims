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
		String hdsearch = request.getParameter("hdsearch")==null?"":request.getParameter("hdsearch");
		String hdfromdate = request.getParameter("hdfromdate")==null?"":request.getParameter("hdfromdate");
		String hdtodate = request.getParameter("hdtodate")==null?"":request.getParameter("hdtodate");
		String hdseriesName = request.getParameter("hdseriesName")==null?"":request.getParameter("hdseriesName");
		String hdTempFlag = request.getParameter("hdTempFlag")==null?"0":request.getParameter("hdTempFlag");
		String popup = request.getParameter("popup")==null?"0":request.getParameter("popup");
		String userId = null;
		String flag = "";
		String userRoleId = "";
		userRoleId = session.getAttribute("user_role_id").toString();
		userId = session.getAttribute("userid").toString();
		
		//System.out.println("userRoleId is "+userRoleId);
		//System.out.println("userId is "+userId);
		
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
		String 	gsConvertFromDate = "";
		String 	gsConvertToDate="";
		String  gsCheckBox = "";
		String gsSeries = null;
		String message = "";
		String role="0";
		String gsSearchByMatch = "";
		String gsSearchByPageNo = "";
		try{
	        vparam.add(userId);
	       // out.println("userId "+userId);
			 crsObj = lobjGenerateProc.GenerateStoreProcedure("esp_adm_loginrole", vparam, "ScoreDB");

			if(crsObj!=null){
				while(crsObj.next()){
					role=crsObj.getString("role");
					System.out.println("role is "+role);
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
			gsCheckBox = request.getParameter("chckseries")==null?"":request.getParameter("chckseries");
			gsFromDate =commonUtil.formatDate(request.getParameter("hdfromdate"));
			gsToDate =commonUtil.formatDate(request.getParameter("hdtodate"));
			gsSeries = request.getParameter("hdseriesName");					
			try{
				vparam.add(pageNo);
				if(gsCheckBox.equalsIgnoreCase("on")){
					vparam.add("");
					vparam.add("");
				}else{
					vparam.add(gsFromDate);
					vparam.add(gsToDate);		
				}
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
		}else if(request.getParameter("hdsearch")!= null && request.getParameter("hdsearch").equalsIgnoreCase("searchbyDate")){						
			pageNo = request.getParameter("hdpageNo");
			gsConvertFromDate = request.getParameter("hdfromdate");
			gsConvertToDate = request.getParameter("hdtodate");
			gsFromDate =commonUtil.formatDate(request.getParameter("hdfromdate"));
			gsToDate =commonUtil.formatDate(request.getParameter("hdtodate"));			
			try{
				vparam.add(pageNo);
				vparam.add(gsFromDate);
				vparam.add(gsToDate);
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
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
	<script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="../../css/menu.css">
	<script language="javascript">
		
		var checkval = null; 
		function fromToDateValidate(fromDate,toDate)
			{		
			fromDay   = fromDate.substring(0, fromDate.indexOf("/"));
			fromMonth = fromDate.substring (fromDate.indexOf ("/")+1, fromDate.lastIndexOf ("/"));
			fromYear  = fromDate.substring (fromDate.lastIndexOf("/")+1, fromDate.length); 
		
		//  enterYear  = strDate.substring (strDate.lastIndexOf ("/")+1, strDate.length); 
		
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
	function searchMatches(pageNo){
		var fromdate = document.getElementById("txtFromdate").value;
		var todate = document.getElementById("txtTodate").value;
		var checkseriesvalue = document.getElementById("chckseries").checked;
		if(document.getElementById("dptournament").value != null){
			if(checkseriesvalue==false){
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
		}		
		if(document.getElementById("txtMatchID").value != null && document.getElementById("txtMatchID").value != "0" && document.getElementById("txtMatchID").value != ""){
			document.getElementById("hdpageNo").value = pageNo;
			document.getElementById("hdsearch").value = "searchbyMatchID";
			document.frmAdminMatchSetUp.action = "/cims/jsp/admin/UmpiresMatchSetUp.jsp";
			document.frmAdminMatchSetUp.submit();
		}else if(document.getElementById("txtFromdate").value != null && document.getElementById("txtTodate").value != null && document.getElementById("dptournament").value != "0"){
			document.getElementById("hdpageNo").value = pageNo;
			document.getElementById("hdfromdate").value = document.getElementById("txtFromdate").value;
			document.getElementById("hdtodate").value = document.getElementById("txtTodate").value;
			document.getElementById("hdseriesName").value = document.getElementById("dptournament").value;
			document.getElementById("hdsearch").value = "searchbyDateandSeries";
			document.frmAdminMatchSetUp.action = "/cims/jsp/admin/UmpiresMatchSetUp.jsp";
			document.frmAdminMatchSetUp.submit();
		}else if(document.getElementById("txtFromdate").value != null && document.getElementById("txtTodate").value != null ){
			document.getElementById("hdpageNo").value = pageNo;
			document.getElementById("hdfromdate").value = document.getElementById("txtFromdate").value;
			document.getElementById("hdtodate").value = document.getElementById("txtTodate").value;
			document.getElementById("hdsearch").value = "searchbyDate";
			document.frmAdminMatchSetUp.action = "/cims/jsp/admin/UmpiresMatchSetUp.jsp";
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
		
	// to change textfield color		
	function changeColour(which) {
		if (which.value.length > 0) {   // minimum 2 characters
			which.style.background = "#FFFFFF"; // white
		}
		else {
			which.style.background = "";  // yellow		
		}
	}	
	
	function acceptByAdmin(matchId){			
		window.open("/cims/jsp/admin/AcceptOfficialsByAdmin.jsp?matchId="+matchId,"CIMS","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=100,left=100,width=880,height=500");
	}
</script>
</head>
<body>
<div>
<% if(!(popup.trim()).equalsIgnoreCase("A")){  %>
<jsp:include page="Menu.jsp"></jsp:include>
<% } %>
<FORM name="frmAdminMatchSetUp" id="frmAdminMatchSetUp" method="post">
<div class="leg">Approval By Official's Of Match</div>
<%--    Venue Master--%>
<div>
<table width="1000" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
		
		<tr align="left" class="contentDark">
			<input type="hidden" id="hdmatchid" name="hdmatchid" value="<%=editMatchId%>">
			<input type="hidden" id="hdMatchFlag" name="hdMatchFlag" value="">
			<td >&nbsp;&nbsp;Tournament Name:</td>
			<td colspan="4">
				<select class="inputFieldMatchSetup" name="dptournament" id="dptournament">
					<option value="0" selected="selected">Select </option>
	<%				if(crsObjTournamentNm != null){
						while(crsObjTournamentNm.next()){
	%>
	<%if(crsObjTournamentNm.getString("id").equalsIgnoreCase(gsSeries)){%>
					<option value="<%=crsObjTournamentNm.getString("id")%>" selected="selected"><%=crsObjTournamentNm.getString("name")%></option>
	<%}else{%>
					<option value="<%=crsObjTournamentNm.getString("id")%>" ><%=crsObjTournamentNm.getString("name")%></option>
	<%	}
						}
					}	
	%>								
					<input type="hidden" id="hdseriesName" name="hdseriesName" value="<%=hdseriesName%>">
				</select>&nbsp;&nbsp;&nbsp;&nbsp;Match Id:&nbsp;<input class="inputFieldMatchSetup" type="text" id="txtMatchID" name="txtMatchID" value="" >
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<% if(gsCheckBox.equalsIgnoreCase("on")) {%>
			<input type="checkbox" name="chckseries" id="chckseries" checked="checked"/> 
			<%} else { %>
			<input type="checkbox" name="chckseries" id="chckseries"/> 
			<%}  %>Search by tournament only
			</td>
		</tr>
		<tr width="90%" class="contentLight">
			<td >&nbsp;&nbsp;From:</td>		
				<%if(gsConvertFromDate != ""){%> 
			<td>
				<a href="javascript:showCal('FrCalendarFrom','StartDate','txtFromdate','frmAdminMatchSetUp')">
				<input type="text" class="textBoxAdminMatchSetup" name="txtFromdate" id="txtFromdate" readonly
					value="<%=gsConvertFromDate%>">&nbsp;&nbsp;
				<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="hidden" id="hdfromdate" name="hdfromdate" value="<%=hdfromdate%>">
			</td>
			<%}else {%>
			<td>
		   		<a href="javascript:showCal('FrCalendar','StartDate','txtFromdate','frmAdminMatchSetUp')">
		   		<input type="text" class="textBoxAdminMatchSetup" name="txtFromdate" id="txtFromdate" readonly
				value="<%=GSFromDate%>" >&nbsp;&nbsp;				
				<IMG src="/cims/images/cal.gif" border="0" alt="" ></a>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="hidden" id="hdfromdate" name="hdfromdate" value="<%=hdfromdate%>">																
			</td>
			<%}%> 	
   			<td>To :</td>	
			<%if(gsConvertToDate != ""){%>
			<td>
				<a href="javascript:showCal('FrCalendarTo','EndDate','txtTodate','frmAdminMatchSetUp')">
				<input type="text" class="textBoxAdminMatchSetup" name="txtTodate" id="txtTodate" readonly
					value="<%=gsConvertToDate%>">&nbsp;&nbsp;
				<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="hidden" id="hdtodate" name="hdtodate" value="<%=hdtodate%>">
	    	</td>
	    	<%}else {%>
			<td>
				<a href="javascript:showCal('FrCalendarTo','EndDate','txtTodate','frmAdminMatchSetUp')">
				<input type="text" class="textBoxAdminMatchSetup" name="txtTodate" id="txtTodate" readonly
					value="<%=GSToDate%>">&nbsp;&nbsp;
				<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="hidden" id="hdtodate" name="hdtodate" value="<%=hdtodate%>">
			</td>
			<%}%>
			<td align="center"> 			    	
	    		<input class="btn btn-warning" type="button" id="btnsearch" name="btnsearch" value=" Search " onclick="searchMatches('1')">
	    		<input type="hidden" id="hdsearch" name="hdsearch" value="<%=hdsearch%>">
	    	</td>	    	    	
		</tr>
	</table>		
	<table width="100%" align="center">
		<tr>
			<td>
				<fieldset><legend class="legend1">Match Details
					</legend> 
					<table align="center" width="100%">
					<tr>
						<td align="left">
							<ul class="pagination">
								<li>Current Page : <%=pageNo%> Of <%=TotalPageCount%></b></li>
								<li><a  id="btnBack" name="btnBack" class="btn btn-small" style="text-decoration:none;" href="javascript:getLastTenMatches('<%=Integer.parseInt(pageNo)%>')"><<</a></li> <!--1st para flag for paging,2 nd para for navigateBack-->
								<li><a  id="btnNext" name="btnNext" class="btn btn-small" style="text-decoration:none;" href="javascript:getFirstTenMatches('<%=Integer.parseInt(pageNo)%>')">>></a></li><!--1st para flag for paging,2 nd para for navigateNext-->
							</ul>
						</td>
						<td colspan="5" style="color: blue">Pending</td>
						<td colspan="5" style="color: red"> Rejected</td>
						<td colspan="5" style="color: Green">Accepted</td>	
					</tr></table>
			 		<table id="tablematches">
							<tr class="contentDark">
								<td class="colheadinguser" nowrap="nowrap">M_Id</td>
								<td class="colheadinguser" nowrap="nowrap">Tournament</td>
								<td class="colheadinguser" nowrap="nowrap">Venue</td>
								<td class="colheadinguser" nowrap="nowrap">Start Date</td>
								<td class="colheadinguser" nowrap="nowrap">End Date</td>
								<td class="colheadinguser" nowrap="nowrap">Team_1</td>
								<td class="colheadinguser" nowrap="nowrap">Team_2</td>
								<td class="colheadinguser" nowrap="nowrap">Umpire 1 </td>
								<td class="colheadinguser" nowrap="nowrap">Umpire 2 </td>
								<td class="colheadinguser" nowrap="nowrap">Umpire 3 </td>
								<td class="colheadinguser" nowrap="nowrap">Coach </td>
								<td class="colheadinguser" nowrap="nowrap" >Referee </td>
								<td class="colheadinguser" nowrap="nowrap" >Scorer 1</td>
								<td class="colheadinguser" nowrap="nowrap" >Scorer 2</td>
								<td class="colheadinguser" nowrap="nowrap" >Main Analyst</td>
								<td class="colheadinguser" nowrap="nowrap" >Assistance Analyst</td>
								<td class="colheadinguser" nowrap="nowrap">Choose Officials </td>
							</tr>						
						
<%						if(crsObjMatchData != null){													
							if(crsObjMatchData.size() == 0){
								message = " No Data Available ";%>	
								
						<%	
							}else{		
							int i=0;
							while(crsObjMatchData.next()){
							TotalNoOfPages = crsObjMatchData.getString("noofpages");%>
						<tr id="<%=i%>" >
							<td align="left" width="10"><font size="2">
								<input type="radio" id="rdadmin" name="rdadmin" value="">
								<%=crsObjMatchData.getString("match_id")%>
								<td align="left" width="50"><font size="2"><%=crsObjMatchData.getString("series_name")%></font></td>
								<%if(crsObjMatchData.getString("venue_name") != null){%>
								<td align="center" width="10"><font size="2"><%=crsObjMatchData.getString("venue_name")%></font></td>
								<%}else{%>
								<td align="center" width="10"><font size="2">----</font></td>
								<%}%>
								<td align="left" width="55"><font size="2"><%=crsObjMatchData.getString("start_ts").substring(0,11).toString()%></font></td>
								<td align="left" width="55"><font size="2">
									<%if(crsObjMatchData.getString("end_ts") != null){%>
									<%=crsObjMatchData.getString("end_ts").substring(0,11).toString()%>
									<%} %>		
								</font></td>
								<td align="left" width="10"><font size="2"><%=crsObjMatchData.getString("team_one")%></font></td>
								<td align="left" width="10"><font size="2"><%=crsObjMatchData.getString("team_two")%></font></td>
						
								<%if(crsObjMatchData.getString("ump1_confirmed").equalsIgnoreCase("Y")){%>
								<td align="center" style="color: green">
									<font size="2">
										<div id="Ump1Div<%=crsObjMatchData.getString("match_id")%>" ><%=crsObjMatchData.getString("umpire1")%>
										<input type="hidden" name="txtchk<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" value="$">
										<input type="hidden" id="hdchk1<%=crsObjMatchData.getString("match_id")%>" name="hdchk1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >
										<input type="hidden" id="hdUmp1<%=crsObjMatchData.getString("match_id")%>" name="hdUmp1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >																		
								</td>
								<%}else if(crsObjMatchData.getString("ump1_confirmed").equalsIgnoreCase("P")){%>
								<td align="center" style="color: blue"><font size="2">
								<div id="Ump1Div<%=crsObjMatchData.getString("match_id")%>" ><%=crsObjMatchData.getString("umpire1")%>
									<div id="div<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk1<%=crsObjMatchData.getString("match_id")%>" name="hdchk1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >
									<input type="hidden" id="hdUmp1<%=crsObjMatchData.getString("match_id")%>" name="hdUmp1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >																		
								</td>
								<%}else if(crsObjMatchData.getString("ump1_confirmed").equalsIgnoreCase("I")){%>
								<td align="center" style="color: blue"><font size="2">
								<div id="Ump1Div<%=crsObjMatchData.getString("match_id")%>" ><%=crsObjMatchData.getString("umpire1")%>
									<div id="div<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk1<%=crsObjMatchData.getString("match_id")%>" name="hdchk1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >
									<input type="hidden" id="hdUmp1<%=crsObjMatchData.getString("match_id")%>" name="hdUmp1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >																		
								</td>
								<%}else{%>
								<td align="center" style="color: red"><font size="2">
									<div id="Ump1Div<%=crsObjMatchData.getString("match_id")%>" ><%=crsObjMatchData.getString("umpire1")%>
									<div id="div<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire1id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk1<%=crsObjMatchData.getString("match_id")%>" name="hdchk1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >
									<input type="hidden" id="hdUmp1<%=crsObjMatchData.getString("match_id")%>" name="hdUmp1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >																		
								</td>
								<%}%>
																								
								<%if(crsObjMatchData.getString("ump2_confirmed").equalsIgnoreCase("Y")){%>
								<td align="center" style="color: green"><font size="2">
									<div id="Ump2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire2")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdchk2<%=crsObjMatchData.getString("match_id")%>" name="hdchk2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
									<input type="hidden" id="hdUmp2<%=crsObjMatchData.getString("match_id")%>" name="hdUmp2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("ump2_confirmed").equalsIgnoreCase("P")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="Ump2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire2")%>
									<div id="div<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk2<%=crsObjMatchData.getString("match_id")%>" name="hdchk2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
									<input type="hidden" id="hdUmp2<%=crsObjMatchData.getString("match_id")%>" name="hdUmp2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("ump2_confirmed").equalsIgnoreCase("I")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="Ump2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire2")%>
									<div id="div<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk2<%=crsObjMatchData.getString("match_id")%>" name="hdchk2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
									<input type="hidden" id="hdUmp2<%=crsObjMatchData.getString("match_id")%>" name="hdUmp2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
								</td>	
								<%}else{%>
								<td align="center" style="color: red"><font size="2">
									<div id="Ump2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire2")%>
									<div id="div<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk2<%=crsObjMatchData.getString("match_id")%>" name="hdchk2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
									<input type="hidden" id="hdUmp2<%=crsObjMatchData.getString("match_id")%>" name="hdUmp2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
								</td>
								<%}%>
								
								<%if(crsObjMatchData.getString("ump3_confirmed").equalsIgnoreCase("Y")){%>
								<td align="center" style="color: green"><font size="2">
									<div id="Ump3Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire3")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("umpire3id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire3id")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdchk3<%=crsObjMatchData.getString("match_id")%>" name="hdchk3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
									<input type="hidden" id="hdUmp3<%=crsObjMatchData.getString("match_id")%>" name="hdUmp3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("ump3_confirmed").equalsIgnoreCase("P")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="Ump3Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire3")%>
									<div id="div<%=crsObjMatchData.getString("umpire3id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpire3id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire3id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk3<%=crsObjMatchData.getString("match_id")%>" name="hdchk3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
									<input type="hidden" id="hdUmp3<%=crsObjMatchData.getString("match_id")%>" name="hdUmp3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("ump3_confirmed").equalsIgnoreCase("I")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="Ump3Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire3")%>
									<div id="div<%=crsObjMatchData.getString("umpire3id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpire3id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire3id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk3<%=crsObjMatchData.getString("match_id")%>" name="hdchk3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
									<input type="hidden" id="hdUmp3<%=crsObjMatchData.getString("match_id")%>" name="hdUmp3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
								</td>	
								<%}else{%>
								<td align="center" style="color: red"><font size="2">
									<div id="Ump3Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire3")%>
									<div id="div<%=crsObjMatchData.getString("umpire2id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpire3id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpire3id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk3<%=crsObjMatchData.getString("match_id")%>" name="hdchk3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
									<input type="hidden" id="hdUmp3<%=crsObjMatchData.getString("match_id")%>" name="hdUmp3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
								</td>
								<%}%>
								
								<%if(crsObjMatchData.getString("umpch_confirmed").equalsIgnoreCase("Y")){%>
								<td align="center" style="color: green"><font size="2">
									<div id="UmpCoachDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpirecoach")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdchk3<%=crsObjMatchData.getString("match_id")%>" name="hdchk3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
									<input type="hidden" id="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" name="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("umpch_confirmed").equalsIgnoreCase("P")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="UmpCoachDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpirecoach")%>
									<div id="div<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk3<%=crsObjMatchData.getString("match_id")%>" name="hdchk3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
									<input type="hidden" id="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" name="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("umpch_confirmed").equalsIgnoreCase("I")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="UmpCoachDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpirecoach")%>
									<div id="div<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk3<%=crsObjMatchData.getString("match_id")%>" name="hdchk3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
									<input type="hidden" id="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" name="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
								</td>
								<%}else{%>
								<td align="center" style="color: red"><font size="2">
									<div id="UmpCoachDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpirecoach")%>
									<div id="div<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("umpirecoachid")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk3<%=crsObjMatchData.getString("match_id")%>" name="hdchk3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
									<input type="hidden" id="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" name="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
								</td>
								<%}%>
								
								<%if(crsObjMatchData.getString("ref_confirmed").equalsIgnoreCase("Y")){%>
								<td align="center" style="color: green"><font size="2">
									<div id="refereeDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("matchreferee")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdreferee<%=crsObjMatchData.getString("match_id")%>" name="hdreferee<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
									<input type="hidden" id="hdchk4<%=crsObjMatchData.getString("match_id")%>" name="hdchk4<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("ref_confirmed").equalsIgnoreCase("P")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="refereeDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("matchreferee")%>
									<div id="div<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk4<%=crsObjMatchData.getString("match_id")%>" name="hdchk4<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
									<input type="hidden" id="hdreferee<%=crsObjMatchData.getString("match_id")%>" name="hdreferee<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("ref_confirmed").equalsIgnoreCase("I")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="refereeDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("matchreferee")%>
									<div id="div<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk4<%=crsObjMatchData.getString("match_id")%>" name="hdchk4<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
									<input type="hidden" id="hdreferee<%=crsObjMatchData.getString("match_id")%>" name="hdreferee<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
								</td>
								<%}else{%>
								<td align="center" style="color: red"><font size="2">
									<div id="refereeDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("matchreferee")%>
									<div id="div<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("matchrefereeid")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk4<%=crsObjMatchData.getString("match_id")%>" name="hdchk4<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
									<input type="hidden" id="hdreferee<%=crsObjMatchData.getString("match_id")%>" name="hdreferee<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
								</td>
								<%}%>
								
								<%if(crsObjMatchData.getString("scorer1_confirmed").equalsIgnoreCase("Y")){%>
								<td align="center" style="color: green"><font size="2">
									<div id="ScorerDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("scorer")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("scorerid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("scorerid")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdscorer<%=crsObjMatchData.getString("match_id")%>" name="hdscorer<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorerid")%>" >
									<input type="hidden" id="hdchk5<%=crsObjMatchData.getString("match_id")%>" name="hdchk5<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorerid")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("scorer1_confirmed").equalsIgnoreCase("P")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="ScorerDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("scorer")%>
									<div id="div<%=crsObjMatchData.getString("scorerid")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("scorerid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("scorerid")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk5<%=crsObjMatchData.getString("match_id")%>" name="hdchk5<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorerid")%>" >
									<input type="hidden" id="hdscorer<%=crsObjMatchData.getString("match_id")%>" name="hdscorer<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorerid")%>" >
								</td>
								<%}else{%>
								<td align="center" style="color: red"><font size="2">
									<div id="ScorerDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("scorer")%>
									<div id="div<%=crsObjMatchData.getString("scorerid")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("scorerid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("scorerid")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk5<%=crsObjMatchData.getString("match_id")%>" name="hdchk5<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorerid")%>" >
									<input type="hidden" id="hdscorer<%=crsObjMatchData.getString("match_id")%>" name="hdscorer<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorerid")%>" >
								</td>
								<%}%>								
								
								<%if(crsObjMatchData.getString("scorer2_confirmed").equalsIgnoreCase("Y")){%>
								<td align="center" style="color: green"><font size="2">
									<div id="Scorer2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("scorer2")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("scorer2id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("scorer2id")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdchk6<%=crsObjMatchData.getString("match_id")%>" name="hdchk6<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2id")%>" >
									<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2id")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("scorer2_confirmed").equalsIgnoreCase("P")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="Scorer2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("scorer2")%>
									<div id="div<%=crsObjMatchData.getString("scorer2id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("scorer2id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("scorer2id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk6<%=crsObjMatchData.getString("match_id")%>" name="hdchk6<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2id")%>" >
									<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2id")%>" >
								</td>
								<%}else{%>
								<td align="center" style="color: red"><font size="2">
									<div id="Scorer2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("scorer2")%>
									<div id="div<%=crsObjMatchData.getString("scorer2id")%><%=crsObjMatchData.getString("match_id")%>" style="display: none;"><input type="text" name="txtchk<%=crsObjMatchData.getString("scorer2id")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("scorer2id")%><%=crsObjMatchData.getString("match_id")%>" value="" onKeyPress="return keyRestrict(event,'0123456789., abcdefghijklmnopqrstuvwxyz')"></div>
									<input type="hidden" id="hdchk6<%=crsObjMatchData.getString("match_id")%>" name="hdchk6<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2id")%>" >
									<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2id")%>" >
								</td>
								<%}%>


								<%if(crsObjMatchData.getString("analyst_confirmed").equalsIgnoreCase("Y")){%>
								<td align="center" style="color: green"><font size="2">
									<div id="Scorer2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("analyst")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("analystid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("analystid")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdchk6<%=crsObjMatchData.getString("match_id")%>" name="hdchk6<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid")%>" >
									<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("analyst_confirmed").equalsIgnoreCase("P")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="Scorer2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("analyst")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("analystid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("analystid")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdchk6<%=crsObjMatchData.getString("match_id")%>" name="hdchk6<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid")%>" >
									<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid")%>" >
								</td>
								<%}else{%>
								<td align="center" style="color: red"><font size="2">
									<div id="Scorer2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("analyst")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("analystid")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("analystid")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdchk6<%=crsObjMatchData.getString("match_id")%>" name="hdchk6<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid")%>" >
									<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid")%>" >
								</td>
								<%}%>

								<%if(crsObjMatchData.getString("analyst1_confirmed").trim().equalsIgnoreCase("Y")){%>
								<td align="center" style="color: green"><font size="2">
									<div id="Scorer2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("analyst1")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("analystid1")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("analystid1")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdchk6<%=crsObjMatchData.getString("match_id")%>" name="hdchk6<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid1")%>" >
									<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid1")%>" >
								</td>
								<%}else if(crsObjMatchData.getString("analyst1_confirmed").equalsIgnoreCase("P")){%>
								<td align="center" style="color: blue"><font size="2">
									<div id="Scorer2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("analyst1")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("analystid1")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("analystid1")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdchk6<%=crsObjMatchData.getString("match_id")%>" name="hdchk6<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid1")%>" >
									<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid1")%>" >
								</td>
								<%}else{%>
								<td align="center" style="color: red"><font size="2">
									<div id="Scorer2Div<%=crsObjMatchData.getString("match_id")%>"> <%=crsObjMatchData.getString("analyst1")%>
									<input type="hidden" name="txtchk<%=crsObjMatchData.getString("analystid1")%><%=crsObjMatchData.getString("match_id")%>" id="txtchk<%=crsObjMatchData.getString("analystid1")%><%=crsObjMatchData.getString("match_id")%>" value="$">
									<input type="hidden" id="hdchk6<%=crsObjMatchData.getString("match_id")%>" name="hdchk6<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid1")%>" >
									<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("analystid1")%>" >
								</td>
								<%}%>




								

								<td align="left" width="3">
									<input class="btn btn-warning" type="button"  id="btnAccept<%=crsObjMatchData.getString("match_id")%>" onclick="acceptByAdmin('<%=crsObjMatchData.getString("match_id")%>')" value="Select Officials">
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
				<input type="hidden" id="hdUserId" name="hdUserId" value="<%=userId%>">
		</tr>
	</table>
	<div id="divReturnMessage" style="display: none; color: blue;font-size: 27" align="center" ></div>		
</div>			
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally {

	}
%>
</FORM>
<jsp:include page="Footer.jsp"></jsp:include>
</div>
</body>
</html>