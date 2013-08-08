<!--Page Name: CreateDemoMatch.jsp
Created By 	 : Archana Dongre.
Created Date : 19th Nov 2008
Description  : Match SetUp Page For Scorers.
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
		
		String scorer1Id = request.getParameter("scorer1Id");
		String scorer1name = request.getParameter("scorer1name");
		String userRoleId = (String)session.getAttribute("user_role_id");
		System.out.println("scorerid and name "+scorer1Id+"****"+scorer1name+"*********"+userRoleId );
		String team1name = "DDCA";
		String team2name = "HPCA";
		String seriesid = "12";
		String scorer2Id = "532";
		
		
		Common commonUtil= new Common();       
		CachedRowSet  crsObjScorer1 = null;
		CachedRowSet  crsObjScorer2 = null;	
		CachedRowSet  crsObjTeam1 = null;
		CachedRowSet  crsObjTeam2 = null;	
		CachedRowSet  crsObjTournamentNm = null;
		CachedRowSet  crsObjvenueNm = null;
		CachedRowSet  crsObjMatchType = null;
		CachedRowSet  crsObjMatchCategory = null;
		CachedRowSet  crsObjMatchSchedule = null;
		CachedRowSet  crsObjSeason = null;
		CachedRowSet  crsObjconuserid = null;
					
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Vector vparam =  new Vector();
		
		String 	GSFromDate			=	sdf.format(new Date());
		String 	GSToDate			=	sdf.format(new Date());
		String 	gsActDate			=	"";
		String 	gsFromDate="";
		String 	gsToDate="";
		String retval = "";
		String fromDate =new String();
		String toDate =new String();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE,0);
		gsActDate =	new SimpleDateFormat("dd/MM/yyyy").format(cal.getTime());
		cal.add(Calendar.DATE,8);
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
		//String userRoleId = null;		
		
		/*vparam.add(scorer1Id);
		crsObjconuserid = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_getuserroleid_tobedeleted",vparam,"ScoreDB");//Display
		vparam.removeAllElements();	
		if(crsObjconuserid != null){
			while(crsObjconuserid.next()){
			userRoleId = crsObjconuserid.getString("user_role_id");
			}
		}*/		
		
		String mflag ="";
		String gsGettingMatchId = "";
		String gsMatchTypeId =	"";
		String gsMatchName =	"";
		String gsTournamentId =	"";		
		String gsMtchCategory =	"";
		String gsteam1Id =	"";
		String gsteam2Id =	"";
		String gsvenueId =	"";
		String gsSeasonId = "";		
		
		String gsUmpire1 =	"";
		String gsUmpire2 =	"";
		String gsUmpire3 =	"";
		String gsUmpireCoach =	"";
		String gsReferee =	"";
		
		String gsScorer1 =	"";
		String gsScorer2 =	"";
		
		
		vparam.add("0");//
        crsObjTeam1 = lobjGenerateProc.GenerateStoreProcedure(
        	"esp_dsp_team_ms",vparam,"ScoreDB");
		crsObjTeam2 = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_team_ms",vparam,"ScoreDB");
			
		crsObjTournamentNm = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_series_ms",vparam,"ScoreDB");
		crsObjvenueNm = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_venue_ms",vparam,"ScoreDB");
		
		crsObjMatchType = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_matchtype_ms",vparam,"ScoreDB");
			
		crsObjMatchCategory = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_matchcategory_ms",vparam,"ScoreDB");
			
		crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");		
		vparam.removeAllElements();			
		vparam.removeAllElements();		
		
		
		vparam.add("3");//Role of Scorer		
		crsObjScorer1 = lobjGenerateProc.GenerateStoreProcedure(
			"dsp_Scorerlist",vparam,"ScoreDB");//Display
		crsObjScorer2 = lobjGenerateProc.GenerateStoreProcedure(
			"dsp_Scorerlist",vparam,"ScoreDB");//Display
		vparam.removeAllElements();	
		
			
		
		if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit")){
		/*For insertion of record in database.*/		
		mflag ="2";
		gsGettingMatchId = "0";				
		gsMatchTypeId =	request.getParameter("MtchTypeId");
		gsMatchName =	request.getParameter("txtmchName");			
		gsTournamentId =	request.getParameter("tournamentid");
		gsFromDate =commonUtil.formatDate(request.getParameter("hdfromdate"));
		gsToDate =commonUtil.formatDate(request.getParameter("hdtodate"));
		gsMtchCategory =	request.getParameter("MtchCategoryId");
		gsteam1Id =	request.getParameter("team1Id");
		gsteam2Id =	request.getParameter("team2Id");
		gsvenueId =	request.getParameter("venueId");
		gsSeasonId = request.getParameter("seasonId");		
		System.out.println("gsSeasonId   "+gsSeasonId);
		gsUmpire1 =	request.getParameter("UmpirId1")==null?"":request.getParameter("UmpirId1");
		gsUmpire2 =	request.getParameter("UmpirId2")==null?"":request.getParameter("UmpirId2");
		gsUmpire3 =	request.getParameter("UmpirId3")==null?"":request.getParameter("UmpirId3");
		gsUmpireCoach =	request.getParameter("UmpirIdCoach")==null?"":request.getParameter("UmpirIdCoach");
		gsReferee =	request.getParameter("Referee")==null?"":request.getParameter("Referee");
		
		gsScorer1 =	request.getParameter("Scorer1")==null?"":request.getParameter("Scorer1");
		gsScorer2 =	request.getParameter("Scorer2")==null?"":request.getParameter("Scorer2");			
			
		vparam.add(mflag);
		vparam.add(gsGettingMatchId);
		vparam.add(gsMatchTypeId);
		vparam.add(gsMatchName);
		vparam.add(gsTournamentId); 
		vparam.add(gsFromDate); 
        vparam.add(gsToDate);     			       
        vparam.add(gsMtchCategory);
        vparam.add(gsSeasonId);  
        vparam.add(gsteam1Id); 
       	vparam.add(gsteam2Id);           
        vparam.add(gsvenueId);
        
       	vparam.add(gsUmpire1); 
       	vparam.add(gsUmpire2); 
       	vparam.add(gsUmpire3);  
		vparam.add(gsUmpireCoach); 
       	vparam.add(gsReferee); 
     	
     	vparam.add(gsScorer1); 
       	vparam.add(gsScorer2); 
       	//out.println("vector "+vparam);               
		crsObjMatchSchedule = lobjGenerateProc.GenerateStoreProcedure(
			"esp_amd_prematch_details_modified",vparam,"ScoreDB");			
		vparam.removeAllElements();//End of Insertion		
		
		if(crsObjMatchSchedule != null){
			while(crsObjMatchSchedule.next()){
				retval = crsObjMatchSchedule.getString("RetVal");
				System.out.println("retval"+retval);
			}
		}
	}
%>
<html>
<head>
	<title> Match Set Up</title>    
	<script language="JavaScript" src="../js/Calender.js" type="text/javascript"></script>
	
	<script language="javascript">
		
		function fromToDateValidate(fromDate , toDate)
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
	
	function currentDateValidate(enteredDate)
	{
	//alert("currentDateValidate   "+enteredDate);
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
	}  // end of currentDateValidate   
	    
	 
	 function displayMatchId(){  	 
	    	if(document.getElementById("hdSubmit").value != ""){
	    		var ans = document.getElementById("hdSubmit").value ;	    		    		
	    			var r = confirm("Your Match Id "+ans+" Has Been Generated");
            		if (r == true)
            		{           			         
                		document.frmScorerMatchSetUp.action = "/cims/jsp/TeamSelection.jsp";
                		document.frmScorerMatchSetUp.submit();
                		window.opener.location.reload();
						window.close();	
                		
	                }
			}
		}
		function callNextPage(){			
			var fromdate = document.getElementById("txtFromdate").value;
			var todate = document.getElementById("txtTodate").value;
			if(document.getElementById('dpseason').value == "" ){
				alert("Please Select Season");
				document.getElementById('dpseason').focus();
			} else if(document.getElementById('dptournament').value == "" ){
				alert("Please Select Tournament");
				document.getElementById('dptournament').focus();
			} else if(document.getElementById('dpvenue').value == "" ){
				alert("Please Select venue");
				document.getElementById('dpvenue').focus();		
			} else if(document.getElementById('dpmchCategory').value == ""){
				alert("Please Select Match Category");
				document.getElementById('dpmchCategory').focus();
			}else if(document.getElementById('dpmchType').value == ""){
				alert("Please Select Match Type");
				document.getElementById('dpmchType').focus();				
			}else if(document.getElementById('dpteam1').value == ""){
				alert("Please Select Teams 1");
				document.getElementById('dpteam1').focus();
			}else if(document.getElementById('dpteam2').value == ""){
				alert("Please Select Teams 2");
				document.getElementById('dpteam2').focus();
			}else if(document.getElementById('dpteam1').value == document.getElementById('dpteam2').value){
				alert("Please Choose Different Team.Both Can not be same");
				return false;
			}else if(currentDateValidate(fromdate) == false){
			 	alert("Please select Fromdate greater than or equal to current date");
			 	return false;
			}else if(currentDateValidate(todate) == false){
			 	alert("Please select Todate greater than or equal to Fromdate ");
			 	return false;
			}else if(fromToDateValidate(fromdate,todate) == false){
			 	alert("Please select Fromdate less than or equal to Todate ");
			 	return false;
			}else if(document.getElementById('dpScorer1').value == document.getElementById('dpScorer2').value){
				alert("Please Choose Different Scorers.Both Can not be same");
				document.getElementById('dpScorer2').focus();
			}else{	
				document.getElementById("hdfromdate").value= document.getElementById("txtFromdate").value;
			 	document.getElementById("hdtodate").value= document.getElementById("txtTodate").value;							
				var TournamentArr = (document.getElementById('dptournament').value).split("~"); // Combo Value
				var venueArr = (document.getElementById('dpvenue').value).split("~"); // Combo Value
				var team1Arr = (document.getElementById('dpteam1').value).split("~"); // Combo Value
				var team2Arr = (document.getElementById('dpteam2').value).split("~"); // Combo Value			 					 	
				var MtchCategoryArr = (document.getElementById('dpmchCategory').value).split("~"); // Combo Value		 				 	
				var MtchTypeArr = (document.getElementById('dpmchType').value).split("~"); // Combo Value		 				 	
	<%-- 		var UmpireArr1 = (document.getElementById('dpUmpire1').value).split("~"); // Combo Value--%>
	<%--		var UmpireArr2 = (document.getElementById('dpUmpire2').value).split("~"); // Combo Value--%>
	<%--		var UmpireArr3 = (document.getElementById('dpUmpire3').value).split("~"); // Combo Value--%>
	<%--		var UmpireArr4 = (document.getElementById('dpUmpireCoach').value).split("~"); // Combo Value--%>
				var seasonArr = (document.getElementById('dpseason').value).split("~"); // Combo Value
				//var ScorerArr1 = (document.getElementById('dpScorer1').value).split("~"); // Combo Value
				//var ScorerArr2 = (document.getElementById('dpScorer2').value).split("~"); // Combo Value
				
				var ScorerId1 = (document.getElementById('dpScorer1').value)// Combo Value
				var ScorerId2 = (document.getElementById('dpScorer2').value) // Combo Value
				//alert(ScorerId1)
				//alert(ScorerId2)
	<%--		var UId1 = UmpireArr1[0]; // Set umpire1 Id;--%>
	<%--		var UName1 = UmpireArr1[1]; // Set umpire1 Name;--%>
	<%--		var UId2 = UmpireArr2[0]; // Set umpire2 Id;--%>
	<%--		var UName2 = UmpireArr2[1]; // Set umpire2 Name;--%>
	<%--		var UId3 = UmpireArr3[0]; // Set umpire3 Id;--%>
	<%--		var UName3 = UmpireArr3[1]; // Set umpire3 Name;--%>
	<%--		var UId4 = UmpireArr4[0]; // Set umpire4 Id;--%>
	<%--		var UName4 = UmpireArr4[1]; // Set umpire4 Name;			 					 	--%>
				var MtchCategoryId = MtchCategoryArr[0]; // Set match category Id;
				var MtchCategoryName = MtchCategoryArr[1]; // Set match category Name;
				var MtchTypeId = MtchTypeArr[0]; // Set umpire4 Id;
				var MtchTypeName = MtchTypeArr[1]; // Set umpire4 Name;			 	
				var TournamentId = TournamentArr[0]; // Set tournament Id;
				var TournamentName = TournamentArr[1]; // Set tournament Name;
				var venueId = venueArr[0]; // Set venue Id;
				var venueName = venueArr[1]; // Set venue Name;
				var team1Id = team1Arr[0]; // Set team1 Id;
				var team1Name = team1Arr[1]; // Set team1 Name;
				var team2Id = team2Arr[0]; // Set team2 Id;
				var team2Name = team2Arr[1]; // Set team2 Name;			 	
					
				var seasonId = seasonArr[0]; // Set referee Id;
				var seasonName = seasonArr[1]; // Set referee Name;
				
				//var ScorerId1 = ScorerArr1[0]; // Set scorer1 Id;
				//var ScorerName1 = ScorerArr1[1]; // Set scorer1 Name;
				//var ScorerId2 = ScorerArr2[0]; // Set scorer2 Id;
				//var ScorerName2 = ScorerArr2[1]; // Set scorer2 Name;		 		 			 	
				document.getElementById("hdSubmit").value = "submit"; 					
				document.frmScorerMatchSetUp.action ="/cims/jsp/CreateDemoMatch.jsp?Scorer1="+ScorerId1+"&Scorer2="+ScorerId2+"&tournamentid="+TournamentId+"&venueId="+venueId+"&team1Id="+team1Id+"&team2Id="+team2Id+"&MtchCategoryId="+MtchCategoryId+"&MtchTypeId="+MtchTypeId+"&seasonId="+seasonId;
				document.frmScorerMatchSetUp.submit();
				
				/*document.frmScorerMatchSetUp.action ="MatchSetUpMaster.jsp?UmpirId1="+UId1+"&UmpirId2="+UId2+"&UmpirId3="+UId3+"&UmpirIdCoach="+UId4+"&Referee="+RefereeId
				+"&Scorer1="+ScorerId1+"&Scorer2="+ScorerId2+"&tournamentid="+TournamentId+"&venueId="+venueId+"&team1Id="+team1Id+"&team2Id="+team2Id+"&MtchCategoryId="+MtchCategoryId+"&MtchTypeId="+MtchTypeId;
				document.frmScorerMatchSetUp.submit();*/		 							
			
		}					 			 	 		 		
}
		function cancellation(){
			window.close();
		}
			 
	</script>
</head>
<body onload="displayMatchId()" >
	<FORM name="frmScorerMatchSetUp" id="frmScorerMatchSetUp" method="post">	
	<br>
		<table width="90%" align="center" style="border-top: 1cm;">
			<tr>
				<td colspan="10" align="center" style="background-color: #dde2f2"><font size="5" color="#003399"><b>Match Detail Form</b></font></td>				
			</tr>
			<tr>
				<td><hr></td>				
			</tr>
			<tr>
				
				<td><input type="hidden" id="txtcurrDate" name="txtcurrDate" value="<%=sdf.format(new Date())%>">
					<fieldset id="fldsetvenue" >
						<legend >
							<font size="4" color="#003399" ><b>Add Match Details </b></font>							
						</legend> 
						<br>
			 		<table align="center" width="90%" class="TDData" >
						<tr >																					
							<td><label><font color="#003399" size="3"><b>Match Name :</b></font></label></td>							
							<td>
								<input type="text" name="txtmchName" id="txtmchName" value="">								
							</td>
							<td><label><font color="#003399" size="3"><b>Season:</b></font></label></td>							
						   	<td>
								<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="dpseason" id="dpseason">
<%--								<option>Select </option>--%>
<%if(crsObjSeason != null){
	while(crsObjSeason.next()){
%>
<%if(crsObjSeason.getString("name").equalsIgnoreCase("")){%>
									<option value="<%=crsObjSeason.getString("id")+"~"+crsObjSeason.getString("name")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>
<%}else{%>
									<option value="<%=crsObjSeason.getString("id")+"~"+crsObjSeason.getString("name")%>" ><%=crsObjSeason.getString("name")%></option>
				<%}
							}
						}
%>							    </select>
							</td>		 
						</tr>
						<tr>
							<td><br></td>
						</tr>
						<tr>	
							<td><label><font color="#003399" size="3"><b>Tournament Name :</b></font></label></td>							
						   	<td>
								<select name="dptournament" id="dptournament">
<%--								<option>Select </option>--%>
<%if(crsObjTournamentNm != null){
	while(crsObjTournamentNm.next()){					
%>
<%if(crsObjTournamentNm.getString("id").equals(seriesid)){%>
									<option value="<%=crsObjTournamentNm.getString("id")+"~"+crsObjTournamentNm.getString("name")%>" selected="selected"><%=crsObjTournamentNm.getString("name")%></option>
<%}else{%>
									<option value="<%=crsObjTournamentNm.getString("id")+"~"+crsObjTournamentNm.getString("name")%>" ><%=crsObjTournamentNm.getString("name")%></option>
				<%}
			}
		}	
%>
							    </select>
							</td> 
						   	<td><label><font color="#003399" size="3"><b>Venue :</b></font></label></td>						   	
							<td>
								<select name="dpvenue" id="dpvenue" >
<%--								<option>Select </option>--%>
<%if(crsObjvenueNm != null){
	while(crsObjvenueNm.next()){					
%>
	<option value="<%=crsObjvenueNm.getString("id")+"~"+crsObjvenueNm.getString("name")%>" ><%=crsObjvenueNm.getString("name")%></option>
<%
		}
	}	
%>							    </select>
							</td> 
						</tr> 
						<tr>
							<td><br></td>
						</tr>
						<tr >
			   				<td><label><font color="#003399" size="3"><b>Match Category :</b></font></label></td>			   				
							<td>
								<select name="dpmchCategory" id="dpmchCategory">
<%--								<option>Select </option>--%>
<%if(crsObjMatchCategory != null){
	while(crsObjMatchCategory.next()){					
%>									<option value="<%=crsObjMatchCategory.getString("id")+"~"+crsObjMatchCategory.getString("name")%>"><%=crsObjMatchCategory.getString("name")%></option>
<%
							}
						}
							
%>
							    </select>
							</td>
							<td><label><font color="#003399" size="3"><b>Match Type :</b></font></label></td>							
							<td>
								<select name="dpmchType" id="dpmchType">
<%--								<option>Select </option>--%>
<%if(crsObjMatchType != null){
	while(crsObjMatchType.next()){					
%>

									<option value="<%=crsObjMatchType.getString("id")+"~"+crsObjMatchType.getString("name")%>" ><%=crsObjMatchType.getString("name")%></option>
<%
							}
						}
							
%>
							    </select>
							</td> 
							
						</tr> 
						<tr>
							<td><br></td>
						</tr>
						<tr >
							<td><label><font color="#003399" size="3"><b>From Date :</b></font></label></td>													   
						  	<td>
						   		<input type="text" class="FlatTextBox150" name="txtFromdate" id="txtFromdate" readonly
								value="<%=GSFromDate%>">&nbsp;&nbsp;
								<a href="javascript:showCal('FrCalendar','StartDate','txtFromdate','frmScorerMatchSetUp')">
								<IMG src="../images/cal.gif" border="0" alt="" ></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="hidden" id="hdfromdate" name="hdfromdate" value="" >																
							</td>										
			   				<td><label><font color="#003399" size="3"><b>To Date :</b></font></label></td>						
							<td>
								<input type="text" class="FlatTextBox150" name="txtTodate" id="txtTodate" readonly
								value="<%=GSToDate%>">&nbsp;&nbsp;
								<a href="javascript:showCal('FrCalendar1','EndDate','txtTodate','frmScorerMatchSetUp')">
								<IMG src="../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="hidden" id="hdtodate" name="hdtodate" value="">										
							</td>								
						</tr> 
						<tr>
							<td><br></td>
						</tr>
						<tr >
							<td><label><font color="#003399" size="3"><b>Team 1 :</b></font></label></td>							
			   				<td>
								<select name="dpteam1" id="dpteam1"  >
<%--								<option>Select </option>--%>
<%if(crsObjTeam1 != null){	
	while(crsObjTeam1.next()){					
%>
<%if(crsObjTeam1.getString("team_name").equalsIgnoreCase(team1name)){%>
								<option value="<%=crsObjTeam1.getString("id")+"~"+crsObjTeam1.getString("team_name")%>" selected="selected"><%=crsObjTeam1.getString("team_name")%></option>
<%}else{%>

									<option value="<%=crsObjTeam1.getString("id")+"~"+crsObjTeam1.getString("team_name")%>" ><%=crsObjTeam1.getString("team_name")%></option>
<%}

							}
						}	
%>
				
					
				
							    </select>
							</td> 
						   	<td><label><font color="#003399" size="3"><b>Team 2 :</b></font></label></td>						   
							<td>
								<select name="dpteam2" id="dpteam2" >
<%--								<option>Select </option>--%>
<%if(crsObjTeam2 != null){
	while(crsObjTeam2.next()){					
%>
<%if(crsObjTeam2.getString("team_name").equalsIgnoreCase(team2name)){%>
								<option value="<%=crsObjTeam2.getString("id")+"~"+crsObjTeam2.getString("team_name")%>" selected="selected"><%=crsObjTeam2.getString("team_name")%></option>
<%}else{%>

									<option value="<%=crsObjTeam2.getString("id")+"~"+crsObjTeam2.getString("team_name")%>" ><%=crsObjTeam2.getString("team_name")%></option>
<%}

							}
						}	
%>			    </select>
							</td> 
						</tr> 
						<tr>
							<td><br></td>
						</tr>
						<tr >
							<td><label><font color="#003399" size="3"><b>Scorer 1  :</b></font></label></td>							
						   	<td>
								<select name="dpScorer1" id="dpScorer1" disabled="disabled">
								<option>Select </option>
<%if(crsObjScorer1 != null){
	while(crsObjScorer1.next()){					
%>
<%if(crsObjScorer1.getString("scorerid").equalsIgnoreCase(userRoleId)){%>
									<option value="<%=crsObjScorer1.getString("scorerid")%>" selected="selected" ><%=crsObjScorer1.getString("scorername")%></option>
<%}else{%>
									<option value="<%=crsObjScorer1.getString("scorerid")%>" ><%=crsObjScorer1.getString("scorername")%></option>
				<%}

							}
						}	
%>		
							    </select>
							</td> 
						   	<td><label><font color="#003399" size="3"><b>Scorer 2 :</b></font></label></td>						   	
							<td>
								<select name="dpScorer2" id="dpScorer2">
<%--								<option>Select </option>--%>
<%if(crsObjScorer2 != null){
	while(crsObjScorer2.next()){					
%>
<%if(crsObjScorer2.getString("scorerid").equals(scorer2Id)){%>
									<option value="<%=crsObjScorer2.getString("scorerid")%>" selected="selected"><%=crsObjScorer2.getString("scorername")%></option>
<%}else{%>
									<option value="<%=crsObjScorer2.getString("scorerid")%>" ><%=crsObjScorer2.getString("scorername")%></option>
<%
	}%>
<%
}
						}	
%>		
							    </select>
							</td> 
						</tr> 
						<tr>
							<td><br></td>
						</tr>																		
												
					</table> 
					<br>
					</fieldset> 	
				</td>
			</tr>												
			<tr>
				<td><hr></td>
			</tr>	
			<tr>
	       		<td align="center">	       			
	       			<input type="button" class="button" id="btnsubmit" name="btnsubmit" value=" Submit" onclick="callNextPage()">	       			
	      			<input type="button" class="button" id="btnCancel" name="btnCancel" value="Cancel" onclick="cancellation()" >	      				      			
	      			<input type="hidden" id="hdSubmit" name="hdSubmit" value="<%=retval%>">	      			
	       		</td>
	    	</tr>
	    </table>    	    
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
	</form>
</body>
</html>

