<!--
Page Name    : MatchScorerSelection.jsp
Created By 	 : Archana Dongre.
Created Date : 5th nov 2008
Description  : Scorer selection for the match
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ include file="../AuthZ.jsp" %>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
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
		String pageNo = "1";
		String TotalNoOfPages = null;
		String TotalPageCount = "1";
		String editMatchId = request.getParameter("hdmatchid")==null?"0":request.getParameter("hdmatchid");
		String hdsearch = request.getParameter("hdsearch")==null?"":request.getParameter("hdsearch");
		String hdfromdate = request.getParameter("hdfromdate")==null?"":request.getParameter("hdfromdate");
		String hdtodate = request.getParameter("hdtodate")==null?"":request.getParameter("hdtodate");
		String hdseriesName = request.getParameter("hdseriesName")==null?"":request.getParameter("hdseriesName");
		String hdTempFlag = request.getParameter("hdTempFlag")==null?"0":request.getParameter("hdTempFlag");					
		Common commonUtil= new Common();
		CachedRowSet  crsObjTournamentNm = null;
		CachedRowSet  crsObjMatchData = null;
		CachedRowSet  crsObjCountRecords = null;

		Vector vparam =  new Vector();
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");		

		String 	GSFromDate	=	sdf.format(new Date());
		String 	GSToDate	=	sdf.format(new Date());
		String 	gsFromDate = "";
		String  gsCheckBox = "";
		String 	gsToDate = "";
		String 	gsConvertFromDate = "";
		String 	gsConvertToDate = "";
		String gsSeries = null;		
		String message = "";	
		String gsSearchByMatch = "";	
		String gsSearchByPageNo = "";
		
		try{
			vparam.add("1");//display all series name.
			crsObjTournamentNm = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_series_ms",vparam,"ScoreDB");
			vparam.removeAllElements();
		}catch(Exception e){
			e.printStackTrace();
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
				vparam.add("");
				vparam.add(ADMIN_FLAG);
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
				vparam.add("");
				vparam.add(ADMIN_FLAG);
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
	<title> Scorer Selection </title>
	<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
	<script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
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

	}  // end of  fromToDateValidate
	/// method to validate with  current date , entered date should not be less than current date	
		
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
				document.frmScorerMatchSetUp.action = "/cims/jsp/admin/MatchScorerSelection.jsp";
				document.frmScorerMatchSetUp.submit();
			}else if(document.getElementById("txtFromdate").value != null && document.getElementById("txtTodate").value != null && document.getElementById("dptournament").value != "0"){
				document.getElementById("hdpageNo").value = pageNo;
				document.getElementById("hdfromdate").value = document.getElementById("txtFromdate").value;
				document.getElementById("hdtodate").value = document.getElementById("txtTodate").value;
				document.getElementById("hdseriesName").value = document.getElementById("dptournament").value;
				document.getElementById("hdsearch").value = "searchbyDateandSeries";
				document.frmScorerMatchSetUp.action = "/cims/jsp/admin/MatchScorerSelection.jsp";
				document.frmScorerMatchSetUp.submit();
			}else if(document.getElementById("txtFromdate").value != null && document.getElementById("txtTodate").value != null ){
				document.getElementById("hdpageNo").value = pageNo;
				document.getElementById("hdfromdate").value = document.getElementById("txtFromdate").value;
				document.getElementById("hdtodate").value = document.getElementById("txtTodate").value;
				document.getElementById("hdsearch").value = "searchbyDate";
				document.frmScorerMatchSetUp.action = "/cims/jsp/admin/MatchScorerSelection.jsp";
				document.frmScorerMatchSetUp.submit();
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
	    
		function GetUmpiresData(matchId){								
			document.getElementById("btnSave"+matchId).disabled = false;						
	       	if(document.getElementById("hddivmatchid").value == 0){
	       		document.getElementById("hddivmatchid").value = matchId;
	       		xmlHttp=GetXmlHttpObject();
				if (xmlHttp==null){
					alert ("Browser does not support HTTP Request");
					return;
				}else{ 
					var url ;									
					url="/cims/jsp/admin/MatchScorerSelectionResponse.jsp?matchId="+matchId;					
					document.getElementById("MatchScorerDiv"+matchId).style.display='';
					document.getElementById("MatchScorer2Div"+matchId).style.display='';
					document.getElementById("ScorerDiv"+matchId).style.display='none';
					document.getElementById("Scorer2Div"+matchId).style.display='none';
					//xmlHttp.onreadystatechange=stateChangedUmpResponse;
					xmlHttp.open("post",url,false);
		            xmlHttp.send(null);
		            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
						var responseResult = trimAll(xmlHttp.responseText);
						var cmbbox = responseResult.split("<br>");
						var matchId = document.getElementById("hddivmatchid").value;
						var mdivscorer = document.getElementById("MatchScorerDiv"+matchId);
						var mdivscorer2 = document.getElementById("MatchScorer2Div"+matchId);
						mdivscorer.innerHTML = cmbbox[0];
						mdivscorer2.innerHTML = cmbbox[1];
					}
				}
	       	}else{
	       		if(SaveMatchData(document.getElementById("hddivmatchid").value)==false){
	       			return ;
	       		}else{
	       			SaveMatchData(document.getElementById("hddivmatchid").value)
		       		document.getElementById("hddivmatchid").value = matchId;
				   	xmlHttp=GetXmlHttpObject();
			        if (xmlHttp==null){
						alert ("Browser does not support HTTP Request");
						return;
					}else{
						hdscorer = document.getElementById("hdscorer"+matchId).value;
						hdscorerNm = document.getElementById("hdscorerNm"+matchId).value;
						hdscorer2	= document.getElementById("hdscorer2"+matchId).value;
						hdscorer2Nm	= document.getElementById("hdscorer2Nm"+matchId).value;
			           	var url ;
						url="/cims/jsp/admin/MatchScorerSelectionResponse.jsp?matchId="+matchId;						
						document.getElementById("MatchScorerDiv"+matchId).style.display='';
						document.getElementById("MatchScorer2Div"+matchId).style.display='';
						document.getElementById("ScorerDiv"+matchId).style.display='none';
						document.getElementById("Scorer2Div"+matchId).style.display='none';
						//xmlHttp.onreadystatechange=stateChangedUmpResponse;
						xmlHttp.open("post",url,false);
			            xmlHttp.send(null);
			            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
							var responseResult = trimAll(xmlHttp.responseText);
							var cmbbox = responseResult.split("<br>");
							var matchId = document.getElementById("hddivmatchid").value;
							var mdivscorer = document.getElementById("MatchScorerDiv"+matchId);
							var mdivscorer2 = document.getElementById("MatchScorer2Div"+matchId);
							mdivscorer.innerHTML = cmbbox[0];
							mdivscorer2.innerHTML = cmbbox[1];
						}
					}
		       	}
	       	}
		}

	/*	function stateChangedUmpResponse(){
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				var responseResult = trimAll(xmlHttp.responseText);
				var cmbbox = responseResult.split("<br>");
				var matchId = document.getElementById("hddivmatchid").value;
				var mdivAnalyst = document.getElementById("MatchAnalystDiv"+matchId);
				var mdivscorer = document.getElementById("MatchScorerDiv"+matchId);
				var mdivscorer2 = document.getElementById("MatchScorer2Div"+matchId);
				mdivAnalyst.innerHTML = cmbbox[0];
				mdivscorer.innerHTML = cmbbox[1];
				mdivscorer2.innerHTML = cmbbox[2];
			}
		}*/
		function SaveMatchData(matchId){				
				//var analyst= document.getElementById("dpAnalyst"+matchId).value;
				//var analyst1= document.getElementById("dpAnalyst1"+matchId).value;
				var analyst= "0";
				var analyst1= "0";
				var scorer= document.getElementById("dpScorer"+matchId).value;				
				var scorer2= document.getElementById("dpScorer2"+matchId).value;	
				if(analyst == "null"){
					analyst = "0";
				}
				if(analyst1 == "null"){
					analyst1 = "0";
				}
				if(scorer == "null"){
					scorer = "0";
				}
				if(scorer2 == "null"){			
					scorer2 = "0";
				}						
				//document.getElementById("dpAnalyst"+matchId).disabled = true;				
				//document.getElementById("dpAnalyst1"+matchId).disabled = true;
				document.getElementById("dpScorer"+matchId).disabled = true;
				document.getElementById("dpScorer2"+matchId).disabled = true;
				xmlHttp=GetXmlHttpObject();
	            if (xmlHttp==null){
					alert ("Browser does not support HTTP Request");
	                return;
				}else{
					var url ;	                
	                url="/cims/jsp/admin/MatchScorerSaveRecordResponse.jsp?matchId="+matchId+"&analyst="+analyst+"&analyst1="+analyst1+"&scorer="+scorer+"&scorer2="+scorer2+"&gsflag=scorer";
					//xmlHttp.onreadystatechange=stateChangedScorerResponse;
					xmlHttp.open("post",url,false);
	               	xmlHttp.send(null);
	               	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
						var responseResult= xmlHttp.responseText;
					}
				}
			}

	/*	function stateChangedScorerResponse(){
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				var responseResult= xmlHttp.responseText;
			}
		}*/
		function PrintMatchOfficialsOfferLetters(matchId){			
			var r = confirm("Do you Want to view AppointMent Letters ?");
				if (r == true){
					window.open("/cims/jsp/admin/PrintScorersOfficialLetter.jsp?matchId="+matchId,"CIMS","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=100,left=100,width=880,height=500");
				}
				else{
					document.frmScorerMatchSetUp.action = "/cims/jsp/admin/MatchScorerSelection.jsp";
					
				}			
		}
		function currentDateValidate(enteredDate){			
			enteredDay   = enteredDate.substring(0, enteredDate.indexOf("/"));
			enteredMonth = enteredDate.substring (enteredDate.indexOf ("/")+1, enteredDate.lastIndexOf ("/"));
			enteredYear  = enteredDate.substring (enteredDate.lastIndexOf("/")+1, enteredDate.length);
			objEnteredDate = new Date()
			objEnteredDate.setDate(enteredDay);
		    objEnteredDate.setMonth(enteredMonth - 1);
		    objEnteredDate.setYear(enteredYear);
			objCurrDate = new Date()
			enteredDateTime = objEnteredDate.getTime()
			currentDateTime = objCurrDate.getTime()
			diffTime = (enteredDateTime - currentDateTime)
			if( diffTime < 0 ) {
				return false
			}
			else {
				return true
			}		
		}  // end of  currentDateValidate
		
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
<div class="container">
<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="frmScorerMatchSetUp" id="frmScorerMatchSetUp" method="post">
<div class="leg">Scorer Selection</div>
<%--    Venue Master--%>
<div class="portletContainer">
<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
	<tr align="left" class="contentDark">
		<input type="hidden" id="hdmatchid" name="hdmatchid" value="<%=editMatchId%>">
		<input type="hidden" id="hdMatchFlag" name="hdMatchFlag" value="">
		<td >&nbsp;&nbsp;Tournament Name:</td>
		<td colspan="4">
			<select class="inputFieldMatchSetup" name="dptournament" id="dptournament">
				<option value="0" >Select </option>
<%			 	if(crsObjTournamentNm != null){
					while(crsObjTournamentNm.next()){
%><%					if(crsObjTournamentNm.getString("id").equalsIgnoreCase(gsSeries)){%>
				<option value="<%=crsObjTournamentNm.getString("id")%>" selected="selected"><%=crsObjTournamentNm.getString("name")%></option>
<%						}else{%>
				<option value="<%=crsObjTournamentNm.getString("id")%>"><%=crsObjTournamentNm.getString("name")%></option>
<%						}
					}
				}
%>				<input type="hidden" id="hdseriesName" name="hdseriesName" value="<%=hdseriesName%>">
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
			<a href="javascript:showCal('FrCalendarFrom','StartDate','txtFromdate','frmScorerMatchSetUp')">
			<input type="text" class="textBoxAdminMatchSetup" name="txtFromdate" id="txtFromdate" readonly
				value="<%=gsConvertFromDate%>">
			<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="hidden" id="hdfromdate" name="hdfromdate" value="<%=hdfromdate%>">
		</td>
		<%}else {%>
		<td>
	   		<a href="javascript:showCal('FrCalendarFrom','StartDate','txtFromdate','frmScorerMatchSetUp')">
	   		<input type="text" class="textBoxAdminMatchSetup" name="txtFromdate" id="txtFromdate" readonly
			value="<%=GSFromDate%>" >
			<IMG src="/cims/images/cal.gif" border="0" alt="" ></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="hidden" id="hdfromdate" name="hdfromdate" value="<%=hdfromdate%>">
		</td>
		<%}%>
   		<td >To:</td>	
		<%if(gsConvertToDate != ""){%>
		<td>
			<a href="javascript:showCal('FrCalendarTo','EndDate','txtTodate','frmScorerMatchSetUp')">
			<input type="text" class="textBoxAdminMatchSetup" name="txtTodate" id="txtTodate" readonly
				value="<%=gsConvertToDate%>">
			<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="hidden" id="hdtodate" name="hdtodate" value="<%=hdtodate%>">	    	
	   	</td>
	   	<%}else {%>
		<td>
			<a href="javascript:showCal('FrCalendarTo','EndDate','txtTodate','frmScorerMatchSetUp')">
			<input type="text" class="textBoxAdminMatchSetup" name="txtTodate" id="txtTodate" readonly
				value="<%=GSToDate%>">
			<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="hidden" id="hdtodate" name="hdtodate" value="<%=hdtodate%>">	    	
		</td>
		<%}%>
		<td align="center"> 		    	
	   		<input class="btn btn-warning" type="button"  id="btnsearch" name="btnsearch" title="Search Matches Between Given Date" class="contentDark" value=" Search " onclick="searchMatches('1')">
	   		<input type="hidden" id="hdsearch" name="hdsearch" value="<%=hdsearch%>">
	   	</td>
	</tr>
</table>
<div id="divReturnMessage" style="display: none; color:red;font-size: 15" align="center" ></div>
<table width="100%" align="center">		
	<tr>
		<td>
			<fieldset>
				<legend class="legend1">Match Details</legend> 
			 	<table align="center" width="100%">
					<tr>
								<ul class="pagination">
											<li>Current Page : <%=pageNo%> Of <%=TotalPageCount%></li>
											<li><a id="btnBack" name="btnBack"  class="btn btn-small" style="text-decoration:none;" href="javascript:getLastTenMatches('<%=Integer.parseInt(pageNo)%>')"><<</a></li>
											<li><a id="btnNext" name="btnNext"  class="btn btn-small" style="text-decoration:none;" href="javascript:getFirstTenMatches('<%=Integer.parseInt(pageNo)%>')">>></a></li>
						
								</ul>
						
						<td colspan="15"></td>	
					</tr></table>
			 	<table  id="tablematches">
					<tr class="contentDark">
						<td class="colheadinguser" >Match Id </td>
						<td class="colheadinguser">Tournament</td>
						<td class="colheadinguser">Venue</td>
						<td class="colheadinguser">Start Date</td>
						<td class="colheadinguser">End Date</td>
						<td class="colheadinguser">Team 1</td>
						<td class="colheadinguser">Team 2</td>
						<td class="colheadinguser">Scorer 1</td>
						<td class="colheadinguser">Scorer 2</td>
						<td class="colheadinguser">Save</td>
						<td class="colheadinguser">App.Letter</td>
					</tr>
<%				if(crsObjMatchData != null){							
					if(crsObjMatchData.size() == 0){
						message = " No Data Available ";	%>						
				<%	}else{								
						while(crsObjMatchData.next()){
						TotalNoOfPages = crsObjMatchData.getString("noofpages");
					//System.out.println("TotalNoOfPages "+TotalNoOfPages);
						String frmDate = crsObjMatchData.getString("start_ts").substring(0,11).trim();
				%>
					<tr >
						<td align="center" width="3"><font size="2">
						<input type="radio" id="rdadmin" name="rdadmin" value="" title="Please Click To Select The Match." onclick='javascript:GetUmpiresData(<%=crsObjMatchData.getString("match_id")%>)'>
						<%=crsObjMatchData.getString("match_id")%></td>
						<td align="center" width="50" ><font size="2"><%=crsObjMatchData.getString("series_name")%></font></td>
						<%if(crsObjMatchData.getString("venue_name") != null){%>
						<td align="center" width="10"><font size="2"><%=crsObjMatchData.getString("venue_name")%></font></td>
						<%}else{%>
						<td align="center" width="10"><font size="2">----</font></td>
						<%}%>
						<td align="center" width="65"><font size="2"><%=frmDate%></font></td>
						<td align="center" width="65"><font size="2"><%=crsObjMatchData.getString("end_ts").substring(0,11).trim()%></font></td>
						<td align="center" width="10"><font size="2"><%=crsObjMatchData.getString("team_one")%></font></td>
						<td align="center" width="10"><font size="2"><%=crsObjMatchData.getString("team_two")%></font></td>
						<td align="center"><font size="2">
							<div id="ScorerDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("scorer")%></div></font>
							<div id="MatchScorerDiv<%=crsObjMatchData.getString("match_id")%>" style="display: none;"></div>				
							<input type="hidden" id="hdscorerNm<%=crsObjMatchData.getString("match_id")%>" name="hdscorerNm<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer")%>" >
							<input type="hidden" id="hdscorer<%=crsObjMatchData.getString("match_id")%>" name="hdscorer<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorerid")%>" >
						</td>
						<td align="center"><font size="2">
							<div id="Scorer2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("scorer2")%></div></font>
							<div id="MatchScorer2Div<%=crsObjMatchData.getString("match_id")%>" style="display: none;"></div>					
							<input type="hidden" id="hdscorer2Nm<%=crsObjMatchData.getString("match_id")%>" name="hdscorerNm2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2")%>" >
							<input type="hidden" id="hdscorer2<%=crsObjMatchData.getString("match_id")%>" name="hdscorer2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("scorer2id")%>" >
						</td>								
						<td width="3">
							
							<input class="btn btn-small" type="button"  id="btnSave<%=crsObjMatchData.getString("match_id")%>" align="center" value="Save" disabled="disabled" onclick="javascript:SaveMatchData('<%=crsObjMatchData.getString("match_id")%>')">
						</td>
						<td align="right" width="3">
							<input  class="btn btn-small" type="button"  id="btnPrintOfficial<%=crsObjMatchData.getString("match_id")%>" align="right" value="Get App. letter" title="Get Appointment Letter" onclick="javascript:PrintMatchOfficialsOfferLetters('<%=crsObjMatchData.getString("match_id")%>')">
						</td><%														
						}							
					}//end of while
				}//end of outer if
%>					</tr>
				</table>
			</fieldset>
		</td>
	</tr>
	<tr>
		<input type="hidden" name="hdTotalNoOfPages" id="hdTotalNoOfPages" align="center" value="<%=TotalNoOfPages%>">
		<input type="hidden" id="hdpageNo" name="hdpageNo" value="" >
		<input type="hidden" id="hddivmatchid" name="hddivmatchid" value="0">
		<input type="hidden" id="hdsubmit" name="hdsubmit" value="" >					
	</tr>
</table>
<table width="100%" align="center"><tr style="color:red;font-size: 15" align="center"><td colspan="6" ><label><%=message%></label></td></tr></table>
<br><br><br><br><br><br>

<%
	}catch(Exception e){
		e.printStackTrace();
	}finally {
	}
%>
</div>
</FORM>
<jsp:include page="Footer.jsp"></jsp:include>
</div>
</body>

</html>