<!--
Page Name: pitchWeatherTossSelection.jsp
Created By 	 : Archana Dongre.
Created Date : 28th Aug 2008
Description  : Pitch Condition,toos Won,Choose To Mapping 
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ 
	page import="sun.jdbc.rowset.CachedRowSet,
		java.text.SimpleDateFormat,java.text.NumberFormat,
		in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
		java.util.*"
%>

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
		String 	GSDate			= "";
		String 	gsActDate		= "";
		String matchId = (String)session.getAttribute("matchId1"); 										
		String 	gsTeam1 		= request.getParameter("team1");		
		String 	gsTeam2 		= request.getParameter("team2");
		String gsweatherType 	= request.getParameter("tournamentid");
		String gspitchCondition = request.getParameter("venueId");
		String gsTossWinner 	= request.getParameter("team1Id");						
		GenerateStoreProcedure  lobjGenerateProc	= new GenerateStoreProcedure(matchId);								               
        CachedRowSet 			WeatherDayRepo 		= null;
		CachedRowSet 			PitchCondition 		= null;
		CachedRowSet 			selectedTeam 		= null;
		CachedRowSet  			crsweatherPitchDetail 	= null;
		CachedRowSet  			crsmatchId 	= null;
		
		Vector					vparam 				= new Vector();
		Calendar		 		cal 				= Calendar.getInstance();
		cal.add(Calendar.DATE,0);
		gsActDate 		=	new SimpleDateFormat("dd/MM/yyyy").format(cal.getTime());
		cal.add(Calendar.DATE,8);				
        vparam.add(matchId);                
		selectedTeam 	= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_select_teams",vparam,"ScoreDB");
		WeatherDayRepo 	= lobjGenerateProc.GenerateStoreProcedure("dsp_weathertypes",vparam,"ScoreDB");
		PitchCondition 	= lobjGenerateProc.GenerateStoreProcedure("dsp_pitchtypes",vparam,"ScoreDB");							
		vparam.removeAllElements();	
		
		if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit")){
			//Archana To insert the record in database.										 	
				String weatherDayId		= request.getParameter("dpWeatherDay");
				String pchCondId 		= request.getParameter("dppitchCondition");
				String tossId 			= request.getParameter("dpTossWon");
				String chooseToId 		= request.getParameter("dpChooseTo");
				String 	scoring_type    = null;
				
				System.out.println("matchId	"+matchId);   
    			System.out.println("weatherDayId "+weatherDayId);   
    			System.out.println("tossId "+tossId);   
    			System.out.println("pchCondId "+pchCondId);   
    			System.out.println("chooseToId "+chooseToId);   
				try{
					vparam.add(matchId);
					crsmatchId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concisematch",vparam,"ScoreDB");																					
					vparam.removeAllElements();	
					if(crsmatchId!=null){
					while(crsmatchId.next()){				
							scoring_type = crsmatchId.getString("scoring_type");
					}
					}
					vparam.removeAllElements();
				}catch(Exception e){
					e.printStackTrace();
				}	
				if(!scoring_type.equalsIgnoreCase("C")){
					vparam.add(matchId);	
					vparam.add(weatherDayId);
					vparam.add(pchCondId);
					vparam.add(tossId);
					vparam.add(chooseToId);					
					crsweatherPitchDetail = lobjGenerateProc.GenerateStoreProcedure("esp_amd_weather_toss_pitch",vparam,"ScoreDB");																					
					vparam.removeAllElements();	
				}
				response.sendRedirect("/cims/jsp/PlayerSelectionTeamOne.jsp?hdteam1="+gsTeam1+"&hdteam2="+gsTeam2);
				//end Archana 					
%>
<%
		  }				
%>
<html>
	<head>
    	<title>Toss Selection </title>
		<script language="JavaScript" src="../js/Calender.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
		<link rel="stylesheet" type="text/css" href="../css/menu.css">    
	    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	    <link rel="stylesheet" type="text/css" href="../css/tabexample.css">   
		<script language="javascript">
			function callNextPage(){//to pass the values of variables on player selection page.	
				if(document.getElementById('dpChooseTo').value == "" || document.getElementById('dpWeatherDay').value == ""
					|| document.getElementById('dppitchCondition').value == "" || document.getElementById('dpTossWon').value == ""){
					alert("Please Select Each Field ");
					return false;
				}else{			 					
				 	document.getElementById('hdSubmit').value = "submit"
				 	document.frmPchCondition.submit();	 											 							 	
				}			 					 	
	 		}
	 		function cancellation(){		 	
	 					document.frmPchCondition.action = "/cims/jsp/WeatherPitchTossSelection.jsp"
						document.frmPchCondition.submit();	 
	 		}		 
		</script>
	</head>
	<body>
		<FORM name="frmPchCondition" id="frmPchCondition" method="post">
		<table width="100%">
		<tr>
			<td>	
				
				<jsp:include page="Banner.jsp"></jsp:include>
				<jsp:include page="MenuScorer.jsp"></jsp:include> 
			</td>	
		</tr>
		</table>
		<br>
		<table width="100%" align="center">
		<tr align="center">				
			<td class="legend" align="center" > Toss Selection</td>
			<td><input type="hidden" name="hdmatch_id" id="hdmatch_id" value=""></td>						
		</tr>
		</table>
		<br>
		<table width="100%" align="center" style="border-top: 1cm;">
		<tr>
			<td>
				<fieldset id="fldsetExtraData" class="background">
				<legend class="">
					<a class="aheading">Playing Conditions</a>
				</legend>
				<table align="center" class="table"  width="0%">
				<tr>
					<td><font size="2"> <b>Weather Day :</b></font></td>
			   		<td>
						<select name="dpWeatherDay" id="dpWeatherDay">
							<option value="">Select </option>
<%							while(WeatherDayRepo.next()){
%>							<option value="<%=WeatherDayRepo.getString("id")%>"><%=WeatherDayRepo.getString("name")%></option>
<%							}
%>
					    </select>
					</td>&nbsp;&nbsp;&nbsp;&nbsp;
	 			 </tr> 
				 <br>
				 <br>
				 <tr> 
					<td><font size="2"> <b>Pitch Condition:</b></font></td> 
					<td>
						<select name="dppitchCondition" id="dppitchCondition">
							<option value="">Select </option>
<%							while(PitchCondition.next()){					
%>							<option value="<%=PitchCondition.getString("id")%>"><%=PitchCondition.getString("name")%></option>
<%						}
%>					    </select>
					</td> 			    
				 </tr> 		
				</table> 
				<br>
				</fieldset> 	
			</td>
		 </tr>
		 <tr>
			<td>
				<fieldset id="fldsetToss" class="background secondFieldset">
				<legend class="">
					<a class="aheading">Toss </a>
				</legend> 
				<table align="center" width="50%">
				<tr>
					<td><b>Toss Won by:</b></td>
			   		<td>
						<select name="dpTossWon" id="dpTossWon" >
							<option value="">Select </option>
<%							while(selectedTeam.next()){
%>							<option value="<%=selectedTeam.getString("id")%>"><%=selectedTeam.getString("team_name")%></option>
<%							}
%>					    </select>
					</td>
					<td><b>Choose To :</b></td> 
					<td>
						<select name="dpChooseTo" id="dpChooseTo">						
							<option value="">Choose To</option>
					    	<option value="0">Bat</option>
					        <option value="1">Field</option>				        
					    </select>
					</td> 		  
				 </tr> 		
				 </table> 
				 </fieldset> 	
			  </td>
			</tr>
			<tr>
	       		<td align="right">
	       			<input type="button" class="btn btn-warning" id="btnNext" name="btnNext" value=" Next >" onclick="callNextPage()" >
	      			<input type="button" class="btn btn-warning" id="btnCancel" name="btnCancel" value="Reset" onclick="cancellation()" >
					<input type="hidden" name="hdmatch" id="hdmatch" value="<%=matchId%>">
					<input type="hidden" name="hdSubmit" id="hdSubmit" value="" >
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

