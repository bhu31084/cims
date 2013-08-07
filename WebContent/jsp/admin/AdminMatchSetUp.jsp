<!--
Page Name    : AdminMatchSetUp.jsp
Created By 	 : Archana Dongre.
Created Date : 19th sep 2008
Description  : Admin Match Setup Master Page
Company 	 : Paramatrix Tech Pvt Ltd.
Modified On 130109 by Archana Paging implemented.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ include file="/jsp/AuthZ.jsp" %>
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
		
		//For the search from playersearch.jsp page.
		String getPlayerMatchId = request.getParameter("matchId")==null?"":request.getParameter("matchId");
		//End of playersearch.
		%>		
		<script>
			function getfromplayersearch(){
				if(document.getElementById("txtMatchID").value != null && document.getElementById("txtMatchID").value != ''){
					searchMatches('1');
				}
			}
		</script>

	<%	Common commonUtil= new Common();
		CachedRowSet  crsObjTournamentNm = null;
		CachedRowSet  crsObjMatchData = null;
		CachedRowSet  crsObjMatchId = null;
		CachedRowSet  crsObjInsertRecord = null;
		CachedRowSet  crsObjCountRecords = null;

		Vector vparam =  new Vector();
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

		String 	GSFromDate			=	sdf.format(new Date());
		String 	GSToDate			=	sdf.format(new Date());
		String 	gsFromDate = "";
		String 	gsToDate = "";
		String  gsCheckBox = "";
		String 	gsConvertFromDate = "";
		String 	gsConvertToDate = "";
		String gsSeries = null;
		String message = "";
		String gsSearchByMatch = "";
		String gsSearchByPageNo = "";
		
		//To get all Series Name
		try{
			vparam.add("1");
			crsObjTournamentNm = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_series_ms",vparam,"ScoreDB");
			vparam.removeAllElements(); 
		}catch(Exception e){
			System.out.println("*************AdminMatchSetUp.jsp*****************"+e);
		}%>
				
		<%if(request.getParameter("hdsearch")!= null && request.getParameter("txtMatchID")!= null && request.getParameter("hdsearch").equalsIgnoreCase("searchbyMatchID")){
			pageNo = request.getParameter("hdpageNo");
			gsSearchByMatch = request.getParameter("txtMatchID");
			try{
				vparam.add(gsSearchByMatch);
				crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchidsearch",vparam,"ScoreDB");
				crsObjCountRecords = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchidsearch",vparam,"ScoreDB");
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
			gsCheckBox = request.getParameter("chckseries")==null?"":request.getParameter("chckseries");
			gsConvertToDate = request.getParameter("hdtodate");
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
				crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_getmatchesbydate_series_modified",vparam,"ScoreDB");
				crsObjCountRecords = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_getmatchesbydate_series_modified",vparam,"ScoreDB");
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
				crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_getmatchesbydate_modified",vparam,"ScoreDB");
				crsObjCountRecords = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_getmatchesbydate_modified",vparam,"ScoreDB");
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
	<title> Match Search </title>
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
	<script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>

	<script language="javascript">
		
	/*To validate the date */
	function fromToDateValidate(fromDate,toDate){
		fromDay   = fromDate.substring(0, fromDate.indexOf("/"));
		fromMonth = fromDate.substring (fromDate.indexOf ("/")+1, fromDate.lastIndexOf ("/"));
		fromYear  = fromDate.substring (fromDate.lastIndexOf("/")+1, fromDate.length); 
		
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
	/*To search matches */
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
			 		alert("Please select Fromdate less than or equal to Todate");
			 		return false;
				}
			}
			if(document.getElementById("txtMatchID").value != null && document.getElementById("txtMatchID").value != "0" && document.getElementById("txtMatchID").value != ""){
				document.getElementById("hdpageNo").value = pageNo;
				document.getElementById("hdsearch").value = "searchbyMatchID";
				document.frmAdminMatchSetUp.action = "/cims/jsp/admin/AdminMatchSetUp.jsp";
				document.frmAdminMatchSetUp.submit();
			}else if(document.getElementById("txtFromdate").value != null && document.getElementById("txtTodate").value != null && document.getElementById("dptournament").value != "0"){
				document.getElementById("hdpageNo").value = pageNo;
				document.getElementById("hdfromdate").value = document.getElementById("txtFromdate").value;
				document.getElementById("hdtodate").value = document.getElementById("txtTodate").value;
				document.getElementById("hdseriesName").value = document.getElementById("dptournament").value;
				document.getElementById("hdsearch").value = "searchbyDateandSeries";
				document.frmAdminMatchSetUp.action = "/cims/jsp/admin/AdminMatchSetUp.jsp";
				document.frmAdminMatchSetUp.submit();
			}else if(document.getElementById("txtFromdate").value != null && document.getElementById("txtTodate").value != null ){
				document.getElementById("hdpageNo").value = pageNo;
				document.getElementById("hdfromdate").value = document.getElementById("txtFromdate").value;
				document.getElementById("hdtodate").value = document.getElementById("txtTodate").value;
				document.getElementById("hdsearch").value = "searchbyDate";
				document.frmAdminMatchSetUp.action = "/cims/jsp/admin/AdminMatchSetUp.jsp";
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

		//To get all official's name.
		function GetUmpiresData(matchId){
			document.getElementById("btnSave"+matchId).disabled = false;
			document.getElementById("hdPre"+matchId).value = document.getElementById("dpPre"+matchId).value;
			document.getElementById("hdPost"+matchId).value = document.getElementById("dpPost"+matchId).value;
			var hdUmp1 = document.getElementById("hdUmp1"+matchId).value;
			var hdUmp1Nm = document.getElementById("hdUmp1Nm"+matchId).value;
	       	var hdUmp2 = document.getElementById("hdUmp2"+matchId).value;
	       	var hdUmp2Nm = document.getElementById("hdUmp2Nm"+matchId).value;
	       	var hdUmp3 = document.getElementById("hdUmp3"+matchId).value;
	       	var hdUmp3Nm = document.getElementById("hdUmp3Nm"+matchId).value;	        
	       	var hdUmpCoach = document.getElementById("hdUmpCoach"+matchId).value;
	       	var hdUmpCoachNm = document.getElementById("hdUmpCoachNm"+matchId).value;
	       	var hdreferee = document.getElementById("hdreferee"+matchId).value;
	       	var hdrefereeNm = document.getElementById("hdrefereeNm"+matchId).value;	       	
	       	var Preval = document.getElementById("dpPre"+matchId).value;
	       	var Postval = document.getElementById("dpPost"+matchId).value;
	       	if(document.getElementById("hddivmatchid").value == 0){
				document.getElementById("hddivmatchid").value = matchId;
				xmlHttp=GetXmlHttpObject();
				if (xmlHttp==null){
					alert ("Browser does not support HTTP Request");
					return;
				}else{
					var url ;
					url="/cims/jsp/admin/AdminMatchSetUpResponse.jsp?matchId="+matchId+"&Preval="+Preval+"&Postval="+Postval;
					//url="AdminMatchSetUpResponse.jsp?matchId="+matchId+"&Preval="+Preval+"&Postval="+Postval+"&hdUmp1="+hdUmp1+"&hdUmp2="+hdUmp2+"&hdUmpCoach="+hdUmpCoach+"&hdreferee="+hdreferee+"&hdUmp1Nm="+hdUmp1Nm+"&hdUmp2Nm="+hdUmp2Nm+"&hdUmpCoachNm="+hdUmpCoachNm+"&hdrefereeNm="+hdrefereeNm;
					document.getElementById("MatchUmp1Div"+matchId).style.display='';
					document.getElementById("MatchUmp2Div"+matchId).style.display='';
					document.getElementById("MatchUmp3Div"+matchId).style.display='';					
					document.getElementById("MatchUmpCoachDiv"+matchId).style.display='';
					document.getElementById("MatchrefereeDiv"+matchId).style.display='';
					document.getElementById("Ump1Div"+matchId).style.display='none';
					document.getElementById("Ump2Div"+matchId).style.display='none';
					document.getElementById("Ump3Div"+matchId).style.display='none';					
					document.getElementById("UmpCoachDiv"+matchId).style.display='none';
					document.getElementById("refereeDiv"+matchId).style.display='none';					
					//xmlHttp.onreadystatechange=stateChangedUmpResponse;
					xmlHttp.open("post",url,false);
		            xmlHttp.send(null);
		            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
		            {
						var responseResult = trimAll(xmlHttp.responseText);			
						var cmbbox = responseResult.split("<br>");
						var matchId = document.getElementById("hddivmatchid").value;
						var mdivump1 = document.getElementById("MatchUmp1Div"+matchId);
						var mdivump2 = document.getElementById("MatchUmp2Div"+matchId);	
						var mdivump3 = document.getElementById("MatchUmp3Div"+matchId);			
						var mdivcoach = document.getElementById("MatchUmpCoachDiv"+matchId);
						var mdivreferee = document.getElementById("MatchrefereeDiv"+matchId);
						mdivump1.innerHTML = cmbbox[0];
						mdivump2.innerHTML = cmbbox[1];
						mdivump3.innerHTML = cmbbox[2];				
						mdivcoach.innerHTML = cmbbox[3];
						mdivreferee.innerHTML = cmbbox[4];
					}
				}
	       	}else{
	       		
	       			//SaveMatchData(document.getElementById("hddivmatchid").value)
		       		document.getElementById("hddivmatchid").value = matchId;
				   	xmlHttp=GetXmlHttpObject();
			        if (xmlHttp==null){
						alert ("Browser does not support HTTP Request");
						return;
					}else{
			          	hdUmp1 = document.getElementById("hdUmp1"+matchId).value;
			          	hdUmp1Nm = document.getElementById("hdUmp1Nm"+matchId).value;
						hdUmp2 = document.getElementById("hdUmp2"+matchId).value;
						hdUmp2Nm = document.getElementById("hdUmp2Nm"+matchId).value;
						hdUmp3 = document.getElementById("hdUmp3"+matchId).value;
						hdUmp3Nm = document.getElementById("hdUmp3Nm"+matchId).value;						
						hdUmpCoach = document.getElementById("hdUmpCoach"+matchId).value;
						hdUmpCoachNm = document.getElementById("hdUmpCoachNm"+matchId).value;
						hdreferee = document.getElementById("hdreferee"+matchId).value;
						hdrefereeNm = document.getElementById("hdrefereeNm"+matchId).value;						
			           	//var url ;			           
						//url="/cims/jsp/admin/AdminMatchSetUpResponse.jsp?matchId="+matchId+"&Preval="+Preval+"&Postval="+Postval;
						var url ="/cims/jsp/admin/AdminMatchSetUpResponse.jsp?matchId="+matchId+"&Preval="+Preval+"&Postval="+Postval+"&hdUmp1="+hdUmp1+"&hdUmp2="+hdUmp2+"&hdUmp3="+hdUmp3+"&hdUmpCoach="+hdUmpCoach+"&hdreferee="+hdreferee+"&hdUmp1Nm="+hdUmp1Nm+"&hdUmp2Nm="+hdUmp2Nm+"&hdUmp3Nm="+hdUmp3Nm+"&hdUmpCoachNm="+hdUmpCoachNm+"&hdrefereeNm="+hdrefereeNm;
						document.getElementById("MatchUmp1Div"+matchId).style.display='';
						document.getElementById("MatchUmp2Div"+matchId).style.display='';
						document.getElementById("MatchUmp3Div"+matchId).style.display='';						
						document.getElementById("MatchUmpCoachDiv"+matchId).style.display='';
						document.getElementById("MatchrefereeDiv"+matchId).style.display='';						
						document.getElementById("Ump1Div"+matchId).style.display='none';
						document.getElementById("Ump2Div"+matchId).style.display='none';
						document.getElementById("Ump3Div"+matchId).style.display='none';						
						document.getElementById("UmpCoachDiv"+matchId).style.display='none';
						document.getElementById("refereeDiv"+matchId).style.display='none';						
						//xmlHttp.onreadystatechange=stateChangedUmpResponse;
						xmlHttp.open("post",url,false);
			            xmlHttp.send(null);
			            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
							var responseResult = trimAll(xmlHttp.responseText);			
							var cmbbox = responseResult.split("<br>");
							var matchId = document.getElementById("hddivmatchid").value;
							var mdivump1 = document.getElementById("MatchUmp1Div"+matchId);
							var mdivump2 = document.getElementById("MatchUmp2Div"+matchId);	
							var mdivump3 = document.getElementById("MatchUmp3Div"+matchId);			
							var mdivcoach = document.getElementById("MatchUmpCoachDiv"+matchId);
							var mdivreferee = document.getElementById("MatchrefereeDiv"+matchId);
							mdivump1.innerHTML = cmbbox[0];
							mdivump2.innerHTML = cmbbox[1];
							mdivump3.innerHTML = cmbbox[2];				
							mdivcoach.innerHTML = cmbbox[3];
							mdivreferee.innerHTML = cmbbox[4];
						}
					
		       	}
	       	}
		}
		
		function SaveMatchData(matchId,status){
			var flag = true;
			var ump1 = document.getElementById('dpUmpire1'+matchId).value;
			var ump2 = document.getElementById('dpUmpire2'+matchId).value;
			var ump3 = document.getElementById('dpUmpire3'+matchId).value;
			if(ump1=='null'){
				ump1 = 0;
			}
			if(ump2=='null'){
				ump2 = 0;
			}
			if(ump3=='null'){
				ump3 = 0;
			}
			if(ump1 != "" && ump2 != ""){
				if(ump1 == ump2 || ump2 == ump3 || ump3 == ump1){
					alert("Please Choose Different Umpires.Both Can not be same");
					document.getElementById('dpUmpire1'+matchId).focus();
					flag = false;
					return false;
				}else{
					flag = true;
				}
			}			
			if(flag){
				var umpCoach= document.getElementById("dpUmpireCoach"+matchId).value;
				var referee= document.getElementById("dpreferee"+matchId).value;	
				if(umpCoach=='null'){
					umpCoach = 0;
				}	
				if(referee=='null'){
					referee = 0;
				}	
				document.getElementById("dpUmpire1"+matchId).disabled = true;
				document.getElementById("dpUmpire2"+matchId).disabled = true;
				document.getElementById("dpUmpire3"+matchId).disabled = true;				
				document.getElementById("dpUmpireCoach"+matchId).disabled = true;
				document.getElementById("dpreferee"+matchId).disabled = true;				
				xmlHttp=GetXmlHttpObject();
	            if (xmlHttp==null){
					alert ("Browser does not support HTTP Request");
	                return;
				}else{
					var url ;	                
	                url="/cims/jsp/admin/AdminSaveDataResponse.jsp?matchId="+matchId+"&ump1="+ump1+"&ump2="+ump2+"&ump3="+ump3+"&umpCoach="+umpCoach+"&referee="+referee+"&status="+status;
					//xmlHttp.onreadystatechange=stateChangedAdminResponse;
					xmlHttp.open("post",url,false);
	               	xmlHttp.send(null);
	               	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
						var responseResult= xmlHttp.responseText;
						if(status=="P"){
							document.getElementById("tr_"+matchId).style.backgroundColor ="#F9ECE8";
							document.getElementById("btnApprove"+matchId).disabled=true;
						}else{
							document.getElementById("tr_"+matchId).style.backgroundColor ="#FFFFFF";
							document.getElementById("btnApprove"+matchId).disabled=false;
						}	
					}
	             }
			}
		}	

		function validate(matchId){
			var ump1 = document.getElementById('dpUmpire1'+matchId).value;
			var ump2 = document.getElementById('dpUmpire2'+matchId).value;
			if(ump1 != "" || ump2 != "" ){
				if(ump1 == ump2){
					alert("Please Choose Different Umpires.");
					return;
				}
			}
		}

		function AddScorers(matchId,stdate){
			var startdate = stdate.split("-");					
			var date = startdate[2]+"/"+startdate[1]+"/"+startdate[0];
			if(currentDateValidate(date) == false){
				alert('Data Can Not Be Modify For The Completed Matches.')
				return false;
			}else{
				var r = confirm("Do you Want to Edit Match ?");
				if (r == true){
					window.open("/cims/jsp/admin/MatchSetUpMaster.jsp?editmatchId="+matchId,"CIMS","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=100,left=100,width=850,height=550");
				}
				else{
					document.frmAdminMatchSetUp.action = "/cims/jsp/admin/AdminMatchSetUp.jsp";					
				}
			}  
		}
		
		function DeleteMatch(matchId){		
			var r = confirm("Do you Really Want to Delete This Match ?");
			if (r == true){				
				xmlHttp=GetXmlHttpObject();
	            if (xmlHttp==null){
					alert ("Browser does not support HTTP Request");    
	                return;
				}else{ 				
					var url ;  	                
	                url="/cims/jsp/admin/DeleteMatchDetailResponse.jsp?matchId="+matchId;
					document.getElementById("divReturnMessage").style.display='';					
					//xmlHttp.onreadystatechange=stateChangedDeleteResponse;
					xmlHttp.open("post",url,false);
	               	xmlHttp.send(null);	
	               	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
						var responseResult= xmlHttp.responseText;
						document.getElementById("divReturnMessage").innerHTML = responseResult;				
					}               	
				}
			}
			else{
				document.frmAdminMatchSetUp.action = "/cims/jsp/admin/AdminMatchSetUp.jsp";
			}
		}
		
		//To open a new window of all official's list 
		function PrintMatchOfficialsOfferLetters(matchId){			
			//var r = confirm("Do you Want to View AppointMent Letters? OR Send SMS");
			//if (r == true){
				window.open("/cims/jsp/admin/PrintOfficialsAppointMentLetter.jsp?matchId="+matchId,"CIMS1","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=100,left=100,width=880,height=500");
			//}
			//else{
			//	document.frmAdminMatchSetUp.action = "AdminMatchSetUp.jsp";				
			//}			
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
		
		function sendSms(){
			window.open("/cims/jsp/sms/MultipleSMSPush.jsp","sendmultiplesms","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,top=10,left=10,width="+(window.screen.availWidth-50)+",height="+(window.screen.availHeight-50));
		}
	</script>
</head>
<body onload="getfromplayersearch()">
<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="frmAdminMatchSetUp" id="frmAdminMatchSetUp" method="post">
<div class="leg">Assign Officials</div>

<div>
<IFRAME id="download_reports" src="" width="0" height="0" ></IFRAME>
<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
	<tr align="left" class="contentDark">		
		<input type="hidden" id="hdmatchid" name="hdmatchid" value="<%=editMatchId%>">
		<input type="hidden" id="hdMatchFlag" name="hdMatchFlag" value="">
		<td >&nbsp;&nbsp;Tournament Name:</td>
		<td colspan="3">
			<select class="inputFieldMatchSetup" name="dptournament" id="dptournament">
				<option value="0" >Select </option>
<%				if(crsObjTournamentNm != null){ 
					while(crsObjTournamentNm.next()){
%><%					if(crsObjTournamentNm.getString("id").equalsIgnoreCase(gsSeries)){%>
				<option value="<%=crsObjTournamentNm.getString("id")%>" selected="selected"><%=crsObjTournamentNm.getString("name")%></option>
<%						}else{%>
				<option value="<%=crsObjTournamentNm.getString("id")%>" ><%=crsObjTournamentNm.getString("name")%></option>
<%						}
					}
				}
%>
				<input type="hidden" id="hdseriesName" name="hdseriesName" value="<%=hdseriesName%>">
			</select>&nbsp;&nbsp;&nbsp;&nbsp;Match Id:&nbsp;
		<%	if(getPlayerMatchId != null || getPlayerMatchId != "" ){%>
			<input class="inputFieldMatchSetup" type="text" id="txtMatchID" name="txtMatchID" value="<%=getPlayerMatchId%>" >
			
		<%}else{%>
			<input class="inputFieldMatchSetup" type="text" id="txtMatchID" name="txtMatchID" value="<%=gsSearchByMatch%>" >
			<%}%>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<% if(gsCheckBox.equalsIgnoreCase("on")) {%>
			<input type="checkbox" name="chckseries" id="chckseries" checked="checked"/> 
			<%} else { %>
			<input type="checkbox" name="chckseries" id="chckseries"/> 
			<%}  %>Search by tournament only
			</td>

			<td align="center"><input class="btn btn-warning"id="btnSms" name="btnSms" type="button" align="center" value="Send SMS" onclick="javascript:sendSms()">
			</td>
	</tr>
	<tr width="90%" class="contentLight">
		<td >&nbsp;&nbsp;From:</td>			
		<%if(gsConvertFromDate != ""){%>
		<td>
			<a href="javascript:showCal('FrCalendarFrom','StartDate','txtFromdate','frmAdminMatchSetUp')">
			<input type="text" class="textBoxAdminMatchSetup" name="txtFromdate" id="txtFromdate" readonly
				value="<%=gsConvertFromDate%>">
			<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="hidden" id="hdfromdate" name="hdfromdate" value="<%=hdfromdate%>">
		</td>
		<%}else {%>
		<td>
			<a href="javascript:showCal('FrCalendarFrom','StartDate','txtFromdate','frmAdminMatchSetUp')">
		   	<input type="text" class="textBoxAdminMatchSetup" name="txtFromdate" id="txtFromdate" readonly
				value="<%=GSFromDate%>" >
			<IMG src="/cims/images/cal.gif" border="0" alt="" ></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="hidden" id="hdfromdate" name="hdfromdate" value="<%=hdfromdate%>">
		</td>
		<%}%>
   		<td>To :</td>			
   		<%if(gsConvertToDate != ""){%>
		<td>
			<a href="javascript:showCal('FrCalendarTo','EndDate','txtTodate','frmAdminMatchSetUp')">
			<input type="text" class="textBoxAdminMatchSetup" name="txtTodate" id="txtTodate" readonly
				value="<%=gsConvertToDate%>">
			<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="hidden" id="hdtodate" name="hdtodate" value="<%=hdtodate%>">
	    </td>
	    <%}else {%>
		<td>
			<a href="javascript:showCal('FrCalendarTo','EndDate','txtTodate','frmAdminMatchSetUp')">
			<input type="text" class="textBoxAdminMatchSetup" name="txtTodate" id="txtTodate" readonly
				value="<%=GSToDate%>">
			<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="hidden" id="hdtodate" name="hdtodate" value="<%=hdtodate%>">
	    </td>
		<%}%>
	    <td align="center">
	    	<input class="btn btn-warning"  type="button" id="btnsearch" name="btnsearch" value="Search" onclick="searchMatches('1')">
	    	<input type="hidden" id="hdsearch" name="hdsearch" value="<%=hdsearch%>">
	    </td>
	</tr>
</table>
<div id="divReturnMessage" style="display: none; color:red;font-size: 15" align="center"></div>
<%	if(request.getParameter("hdsearch")!= null){%>
	<table border="0" width="100%">
		<tr>
			<td align="right" colspan="10"><input type=button value="ExportToExcel" onclick="exportToExcel()" class="btn btn-warning" ></td>
		</tr>
	</table>
<%}%>
	
	<table width="100%" align="center" >		
		<tr>
			<td>
				<fieldset><legend class="legend1">Match Details</legend>
				<table align="center" width="100%">					
					<tr>
						<ul class="pagination">
							<li>Current Page : <%=pageNo%> Of <%=TotalPageCount%></li>
							<li><a id="btnBack" name="btnBack" class="btn btn-small" style="text-decoration:none;"  href="javascript:getLastTenMatches('<%=Integer.parseInt(pageNo)%>')"><<</a></li> <!--1st para flag for paging,2 nd para for navigateBack-->
							<li><a id="btnNext" name="btnNext" class="btn btn-small" style="text-decoration:none;"  href="javascript:getFirstTenMatches('<%=Integer.parseInt(pageNo)%>')">>></a></li> <!--1st para flag for paging,2 nd para for navigateNext-->
						</ul>						
						<td colspan="19"></td>	
					</tr></table>
		 		<table id="tablematches">			 			
						<tr class="contentDark">
							<td class="colheadinguser" >Pre:</td>
							<td class="colheadinguser" >Post:</td>
							<td class="colheadinguser" >M.Id</td>
							<td class="colheadinguser" >Tournament</td>
							<td class="colheadinguser" >Venue</td>
							<td class="colheadinguser" >Start Date</td>
							<td class="colheadinguser" >End Date</td>
							<td class="colheadinguser" >Team 1</td>
							<td class="colheadinguser" >Team 2</td>
							<td class="colheadinguser" >Umpire 1</td>
							<td class="colheadinguser" >Umpire 2 </td>
							<td class="colheadinguser" >Umpire 3 </td>			
							<td class="colheadinguser" >Umpire Coach </td>
							<td class="colheadinguser" >Referee </td>							
							<td class="colheadinguser" >Save </td>
							<td class="colheadinguser" >Edit </td>
							<td class="colheadinguser" >Delete </td>
							<td class="colheadinguser" >App.Letter/Send SMS</td>
							<td class="colheadinguser" >Approve</td>
						</tr>

<%		if(crsObjMatchData != null){
			if(crsObjMatchData.size() == 0){				
				message = " No Data Available ";
			}else{
				while(crsObjMatchData.next()){					
					TotalNoOfPages = crsObjMatchData.getString("noofpages");
					 if(!crsObjMatchData.getString("ump1_confirmed").equalsIgnoreCase("I")){ %>
					<tr bgcolor="#F9ECE8" id="tr_<%=crsObjMatchData.getString("match_id")%>">
					<%}else{ %>
					<tr id="tr_<%=crsObjMatchData.getString("match_id")%>">
					<%} %>
						<td>
							<select name="dpPre<%=crsObjMatchData.getString("match_id")%>" id="dpPre<%=crsObjMatchData.getString("match_id")%>">
<%				for(int i = 0;i<=2;i++){ 
					if(i == 0){
%>
								<option selected="selected" value="<%=i%>"><%=i%></option>
<%					}else{%>
								<option value="<%=i%>"><%=i%></option>
					<%}
				}%>
							</select>
							<input type="hidden" id="hdPre<%=crsObjMatchData.getString("match_id")%>" name="hdPre<%=crsObjMatchData.getString("match_id")%>" value="">
						</td>
						<td>
							<select name="dpPost<%=crsObjMatchData.getString("match_id")%>" id="dpPost<%=crsObjMatchData.getString("match_id")%>">
<%				for(int j=0;j<=2;j++){
					if(j == 0){
					%>
								<option selected="selected" value="<%=j%>"><%=j%></option> 
				<%  }else{%>
								<option value="<%=j%>"><%=j%></option>
					<%}
				}%>					
							</select>
							<input type="hidden" id="hdPost<%=crsObjMatchData.getString("match_id")%>" name="hdPost<%=crsObjMatchData.getString("match_id")%>" value="">
						</td>
						<td align="left" width="3"><font size="2">
							<input type="radio" id="rdadmin" name="rdadmin" value="" onclick='javascript:GetUmpiresData(<%=crsObjMatchData.getString("match_id")%>)'>
						<%=crsObjMatchData.getString("match_id")%></td>
							<td align="left" width="50" ><font size="2"><%=crsObjMatchData.getString("series_name")%></font></td>
						<%if(crsObjMatchData.getString("venue_name") != null){%>
							<td align="center" width="10"><font size="2"><%=crsObjMatchData.getString("venue_name")%></font></td>
						<%}else{%>
							<td align="center" width="10"><font size="2">----</font></td>
						<%}%>
							<td align="left" width="55"><font size="2"><%=crsObjMatchData.getString("start_ts").substring(0,11).trim()%></font></td>

							<td align="left" width="55">
							<font size="2">
							<%if(crsObjMatchData.getString("end_ts") != null){%>
							<%=crsObjMatchData.getString("end_ts").substring(0,11).trim()%>
							<%} %>
							</font></td>
							<td align="left" width="10"><font size="2"><%=crsObjMatchData.getString("team_one")%></font></td>
							<td align="left" width="10"><font size="2"><%=crsObjMatchData.getString("team_two")%></font></td>
							<td align="center"><font size="2">
								<div id="Ump1Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire1")%></div></font>
								<div id="MatchUmp1Div<%=crsObjMatchData.getString("match_id")%>" style="display: none;"></div>
								<input type="hidden" id="hdUmp1Nm<%=crsObjMatchData.getString("match_id")%>" name="hdUmp1Nm<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1")%>" >
								<input type="hidden" id="hdUmp1<%=crsObjMatchData.getString("match_id")%>" name="hdUmp1<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire1id")%>" >
							</td>
							<td align="center"><font size="2">
								<div id="Ump2Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire2")%></div></font>
								<div id="MatchUmp2Div<%=crsObjMatchData.getString("match_id")%>" style="display: none;"></div>
								<input type="hidden" id="hdUmp2Nm<%=crsObjMatchData.getString("match_id")%>" name="hdUmp2Nm<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2")%>" >
								<input type="hidden" id="hdUmp2<%=crsObjMatchData.getString("match_id")%>" name="hdUmp2<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire2id")%>" >
							</td>
							
							<td align="center"><font size="2">
								<div id="Ump3Div<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpire3")%></div></font>
								<div id="MatchUmp3Div<%=crsObjMatchData.getString("match_id")%>" style="display: none;"></div>
								<input type="hidden" id="hdUmp3Nm<%=crsObjMatchData.getString("match_id")%>" name="hdUmp3Nm<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3")%>" >
								<input type="hidden" id="hdUmp3<%=crsObjMatchData.getString("match_id")%>" name="hdUmp3<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpire3id")%>" >
							</td>	
															
							<td align="center"><font size="2">
								<div id="UmpCoachDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("umpirecoach")%></div></font>
								<div id="MatchUmpCoachDiv<%=crsObjMatchData.getString("match_id")%>" style="display: none;"></div>
								<input type="hidden" id="hdUmpCoachNm<%=crsObjMatchData.getString("match_id")%>" name="hdUmpCoachNm<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoach")%>" >
								<input type="hidden" id="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" name="hdUmpCoach<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("umpirecoachid")%>" >
							</td>
							<td align="center"><font size="2">
								<div id="refereeDiv<%=crsObjMatchData.getString("match_id")%>"><%=crsObjMatchData.getString("matchreferee")%></div></font>
								<div id="MatchrefereeDiv<%=crsObjMatchData.getString("match_id")%>" style="display: none;"></div>
								<input type="hidden" id="hdrefereeNm<%=crsObjMatchData.getString("match_id")%>" name="hdrefereeNm<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchreferee")%>" >
								<input type="hidden" id="hdreferee<%=crsObjMatchData.getString("match_id")%>" name="hdreferee<%=crsObjMatchData.getString("match_id")%>" value="<%=crsObjMatchData.getString("matchrefereeid")%>" >
							</td>															
							<td align="center" >								
								<input class="btn btn-warning" type="button" id="btnSave<%=crsObjMatchData.getString("match_id")%>" align="center" value="Save" disabled="disabled" onclick="javascript:SaveMatchData('<%=crsObjMatchData.getString("match_id")%>','I')">
							</td>
							<td align="center" >
								<input class="btn btn-warning" type="button"  id="btnEdit<%=crsObjMatchData.getString("match_id")%>" align="center" value="Edit" onclick="javascript:AddScorers('<%=crsObjMatchData.getString("match_id")%>','<%=crsObjMatchData.getString("start_ts").substring(0,11).trim()%>')">
							</td>
							<td align="center">
								<input class="btn btn-warning" type="button" id="btnDelete<%=crsObjMatchData.getString("match_id")%>" align="center" value="Del" onclick="javascript:DeleteMatch('<%=crsObjMatchData.getString("match_id")%>')">
							</td>
							<td align="center" >
								<input class="btn btn-warning" type="button"  id="btnPrintOfficial<%=crsObjMatchData.getString("match_id")%>" align="center" value="Get App.Letter/Send SMS" onclick="javascript:PrintMatchOfficialsOfferLetters('<%=crsObjMatchData.getString("match_id")%>')">
							</td>	
							<td align="center" >
								
								<input class="btn btn-warning" type="button"  id="btnApprove<%=crsObjMatchData.getString("match_id")%>" <%=crsObjMatchData.getString("ump1_confirmed").equalsIgnoreCase("I")?"":"disabled"%> align="center" value="Approved" onclick="javascript:SaveMatchData('<%=crsObjMatchData.getString("match_id")%>','P')">
							</td>						
<%				}//end of while
			}%>
		
	<%	}//end of outer if
%>						</tr>
					</table>
				</fieldset>				
			</td>
		</tr>
		
		<tr>
			<td colspan="9"></td>				
				<input type="hidden" name="hdTotalNoOfPages" id="hdTotalNoOfPages" align="center" value="<%=TotalNoOfPages%>">	
				<input type="hidden" id="hdpageNo" name="hdpageNo" value="" >
				<input type="hidden" id="hddivmatchid" name="hddivmatchid" value="0">
				<input type="hidden" id="hdsubmit" name="hdsubmit" value="" >					
		</tr>		
	</table>
	<table width="100%" align="center"><tr style="color:red;font-size: 15" align="center"><td colspan="6" ><label><%=message%></label></td></tr></table>
</div>	
	
<%	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
	 
	}
%>
</FORM>
<jsp:include page="Footer.jsp"></jsp:include>
</body>
<script>
	function exportToExcel() 
	 {
	 	var fromdate = document.getElementById('txtFromdate').value ;
		var todate = document.getElementById('txtTodate').value ;
		var tournamentid = document.getElementById('dptournament').value ;
		var MatchID = document.getElementById('txtMatchID').value ;
		var flag = '1';
		document.getElementById("download_reports").src= "/cims/jsp/admin/ExportToExcelMatches.jsp?fromdate="+fromdate+"&todate="+todate+"&tournamentid="+tournamentid+"&flag="+flag;	
	 }
</script>
</html>