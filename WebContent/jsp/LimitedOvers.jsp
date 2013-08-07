<!--
	Author 		 		: Vaibhav Gaikar
	Created Date 		: 04/09/2008
	Description  		: Limited Over Scoreshit Report.
	Company 	 		: Paramatrix Tech Pvt Ltd.
	Modification Date	: 11/09/2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<%  response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<%	
	CachedRowSet  firstBatsCrs 				= null;
	CachedRowSet  secondBatsCrs				= null;
	CachedRowSet  officialScoresheetCrs 	= null;
	CachedRowSet  overRunrateCrs			= null;
	CachedRowSet  partnershipsCrs			= null;
	CachedRowSet  reserveplayerCrs			= null;
	CachedRowSet  bowledAnalysisCrs			= null;
	CachedRowSet  stoppageSummeryCrs   	 	= null;
	CachedRowSet  scoringRateBatFirstCrs	= null;
	CachedRowSet  firstBatFallWicketCrs		= null;
	CachedRowSet  secondBatFallWicketCrs	= null;
	CachedRowSet  firstInningDurationCrs  	= null;
	CachedRowSet  secondInningDurationCrs  	= null;
	CachedRowSet  individualBatsmanScoreCrs	= null;
	CachedRowSet  inningIdCrs				= null;		
	CachedRowSet  overShortCrs				= null;
	CachedRowSet  penaltyReasonCrs			= null;
	CachedRowSet  reservePlayerCrs 			= null;
	CachedRowSet  officialResultCrs			= null;
	Vector vparam 							= new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	String timeIn 					  = "";
	String timeOut 					  = "";
	String srNo 					  = "";
	String batsman					  = "";
	String howout					  = "";     
	String fielder				 	  = "";   
	String bowler				 	  = "";      
	String mins					 	  = "";      
	String four 					  = "";   
	String six 						  = ""; 
	String balls 					  = "";      
	String runs 					  = "";       
	String byes 				 	  = "";      
	String legByes 				 	  = "";      
	String noBall 				 	  = "";                                
	String wide 				 	  = "";   
	String matchNo 				 	  = "";
	String zone 					  = "";
	String teamOne 					  = "";
	String teamTwo 					  = "";
	String toss 					  = "";
	String ground					  = "";
	String city 					  = "";
	String date 					  = "";
	String result					  = "";
	String wonByWkt 				  = "";
	String wonByRrun 				  = "";
	String umpireOne				  = "";
	String umpireTwo 			 	  = "";
	String umpireThree				  = "";
	String umpireFour 			 	  = "";
	String matchReferee 			  = "";
	String scorerOne				  = "";
	String scorerTwo			 	  = "";
	String captainOne			 	  = "";
	String captainTwo 				  = "";
	String matchTotalRun		 	  = "";
	String matchTotalWkt		 	  = "";
	String matchTotalOver			  = "";
	String wkt  				 	  = "";
	String wktRuns 				 	  = "";
	String wktOvers 			 	  = "";		
	String wicketKeeperOne		 	  = "";
	String wicketKeeperTwo		 	  = "";
	String overs 				 	  = "";
	String run  				 	  = "";
	String wicket 					  = "";
	String battingSubTotal		 	  = "";   
	String totalExtras 			 	  = ""; 
	String penaltyExtras 		 	  = "";
	String tournamentName 			  = "";
	String runRate					  = "";
	String reservePlayer			  = "";
	String reservePlayerOne		 	  = "";
	String reservePlayerTwo			  = "";
	String reservePlayerThree	 	  = "";
	String bowlerName 			 	  = "";
	String bowlerOver			 	  = "";
	String bowlerMaiden			 	  = "";
	String bowlerRunrate		 	  = "";
	String bowlerWicket			 	  = "";
	String bowlerNB 			 	  = "";
	String bowlerWB				 	  = "";
	String batsmanOne 			 	  = "";
	String batsmanTwo			 	  = "";
	String totalRuns 			 	  = "";
	String minute  				 	  = "";
	String totalballs				  = "";
	String batsmanMin				  = "";
	String batsmanScore				  = "";
	String batsmanBall			 	  = "";
	String batsmanfour			 	  = "";
	String batsmansix			 	  = "";  
	String fromTime				      = "";
	String toTime					  = "";
	String totalMin					  = "";
	String ol						  = "";
	String reason				 	  = "";
	String teamBattingFirst 	 	  = "";
	String StartTimeBattingFirst 	  = "";
	String endTimeBattingFirst	 	  = "";
	String durationBattingFirst  	  = "";      
	String minsBattingFirst      	  = ""; 
	String teamBattingSecond 	 	  = "";
	String StartTimeBattingSecond	  = "";
	String endTimeBattingSecond  	  = "";
	String durationBattingSecond 	  = "";      
	String minsBattingSecond	 	  = "";
	String summeryOvers	 		 	  = "";
	String summeryRun 	 		 	  = "";
	String summeryWicket 		 	  = "";
	String summeryRunRate		 	  = "";
	String summeryShortOver		 	  = "";
	String summeryPoint				  = "";
	String summeryOver 			 	  = "";
	String scoringRateRun		 	  = "";
	String scoringRateBall		 	  = "";
	String scoringRateMins			  = "";
	String inningsId				  = "";
	String inningIdOne				  = "";
	String inningIdTwo			 	  = "";
	String inningIdThree			  = "";
	String inningIdFour				  = "";		 	
	String umpireOneAsscn			  = "";
	String umpireTwoAsscn			  = "";
	String umpireThreeAsscn			  = "";
	String umpireFourAsscn		 	  = "";
	String matchRefassn			 	  = "";
	String battingTeam			 	  = "";
	String startTime			 	  = "";
	String endTime					  = "";
	String duration				 	  = "";
	String matchWinner			 	  = "";
	String firstInningTotal		 	  = "";
	String secondInningTotal	 	  = "";
	String firstInningOvers		 	  = "";
	String secondInningOvers	 	  = "";
	String penaltyReason		 	  = "";
	String matchType				  = "";
	String overMax					  = "";	
	String umpireOneContact		 	  = "";
	String umpireTwoContact		 	  = "";
	String umpireThreeContact		  = "";
	String umpireFourContact		  = "";
	String matchRefereeContact		  = "";
	String penaltyDescription	 	  = "";
	String firstInningScoringRunrange = "";	
	String firstInningScoringMin	  = "";
	String firstInningScoringOvers	  = "";
	String firstBatsName			  = "";	
	String batFirstInningFirstBats	  = "";
	String batFirstInningFirstMin     = "";
	String batFirstInningFirstFour    = "";
	String batFirstInningFirstSix     = "";
	String batFirstInningFirstBalls   = "";
	String matchId					  = "";
	String electedto				  = "";	
	String twelveman				  = "";
	String remarks					  = "";	
	String isPrint					  = "";
	String totalMatchTime			  = "";	
	String inningId					  = "";	
	int firstInningWkt			  	  = 0;
	int secondInningSecond		  	  = 0;			
	int targetScore				 	  = 1;
	int revisedTargetScore		 	  = 1;
	int subTotal					  = 0;
	int tExtras					 	  = 0;
	int grandTotal				      = 0;			
	int totalScoreTeamOne		 	  = 0;
	int totalScoreTeamTwo			  = 0;
	int totalWktTeamTwo			 	  = 0;
	float totalOversTeamTwo		 	  = 0;	
	int wonResult				 	  = 0;
	int crsSize					 	  = 0;
	int rowGrowLength			 	  = 0;
	int k						 	  = 0;
	float totalOver				 	  = 0;	
	int totalMaiden				 	  = 0;
	int totalRunrate			 	  = 0;
	int totalWkt					  = 0;
	int totalNB					 	  = 0;
	int totalWB					 	  = 0;
	int rowLength				 	  = 0; 
	float firstInningTotalOver	 	  = 0;
	float secondInningTotalOver	 	  = 0;
	float firstInningShortOver	 	  = 0;
	float secondInningShortOver	 	  = 0;
	int   byesTotal				 	  = 0;	
	int   byesPlusTotalrun		 	  = 0;	
	int   no 					 	  = 1;
	int   wktCount				 	  = 0;	
	int   count 				 	  = 0;
	int   remainingWkt			 	  = 0;	
	int   totalFirstInningWkt    	  = 0;	
	int   totalSecondInningWkt	 	  = 0; 
%>

<%	matchId = (String)session.getAttribute("matchid");
	lobjGenerateProc = new GenerateStoreProcedure(matchId);
	LogWriter log =  new LogWriter();
	
	vparam.add(session.getAttribute("matchid"));
	inningIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getinningsid",vparam,"ScoreDB");
	vparam.removeAllElements();
	if (inningIdCrs != null){
		try{
			while (inningIdCrs.next()){
				inningsId = inningsId + inningIdCrs.getString("id") + "~";
			}
			String splitInningsId[] = inningsId.split("~");
			
			if (splitInningsId !=null){
					if(splitInningsId.length == 4){
						inningIdOne   = splitInningsId[0];
						inningIdTwo	  = splitInningsId[1];
						inningIdThree = splitInningsId[2];
						inningIdFour  = splitInningsId[3];
					}else if(splitInningsId.length == 3){
						inningIdOne   = splitInningsId[0];
						inningIdTwo	  = splitInningsId[1];
						inningIdOne   = splitInningsId[2];
					}else if(splitInningsId.length == 2){
						inningIdOne   = splitInningsId[0];
						inningIdTwo   = splitInningsId[1];
					}else if(splitInningsId.length == 1){
						inningIdOne   = splitInningsId[0];
					}
				}
		 }catch(Exception e){
		 		log.writeErrLog(page.getClass(),matchId,e.toString());
		 }
	}
%>
<%  vparam.add(session.getAttribute("matchid"));
	officialScoresheetCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialscoresheetfortest",vparam,"ScoreDB");
	vparam.removeAllElements();
	try{
		if(officialScoresheetCrs!=null && officialScoresheetCrs.size() > 0){
			while (officialScoresheetCrs.next()){
				tournamentName       = officialScoresheetCrs.getString("tournament")!=null?officialScoresheetCrs.getString("tournament"):"";
				//matchNo 			 = officialScoresheetCrs.getString("match_no")!=null?officialScoresheetCrs.getString("match_no"):"";
				electedto 			 = officialScoresheetCrs.getString("electedto")!=null?officialScoresheetCrs.getString("electedto"):"";
				zone				 = officialScoresheetCrs.getString("zone")!=null?officialScoresheetCrs.getString("zone"):"";
				teamOne				 = officialScoresheetCrs.getString("team1")!=null?officialScoresheetCrs.getString("team1"):"";
				teamTwo				 = officialScoresheetCrs.getString("team2")!=null?officialScoresheetCrs.getString("team2"):"";
				toss				 = officialScoresheetCrs.getString("tosswinner")!=null?officialScoresheetCrs.getString("tosswinner"):"";
				ground				 = officialScoresheetCrs.getString("ground")!=null?officialScoresheetCrs.getString("ground"):"";
				city				 = officialScoresheetCrs.getString("city")!=null?officialScoresheetCrs.getString("city"):"";
				date				 = officialScoresheetCrs.getString("start_date")!=null?officialScoresheetCrs.getString("start_date"):"";
				matchWinner			 = officialScoresheetCrs.getString("match_winner")!=null?officialScoresheetCrs.getString("match_winner"):"";
				//result				 = officialScoresheetCrs.getString("result")!=null?officialScoresheetCrs.getString("result"):"";
				umpireOne			 = officialScoresheetCrs.getString("umpire1")!=null?officialScoresheetCrs.getString("umpire1"):"";
				umpireTwo			 = officialScoresheetCrs.getString("umpire2")!=null?officialScoresheetCrs.getString("umpire2"):"";
				umpireThree			 = officialScoresheetCrs.getString("umpire3")!=null?officialScoresheetCrs.getString("umpire3"):"";
				umpireFour			 = officialScoresheetCrs.getString("umpire4")!=null?officialScoresheetCrs.getString("umpire4"):"";
				matchReferee		 = officialScoresheetCrs.getString("matchref")!=null?officialScoresheetCrs.getString("matchref"):"";
				scorerOne			 = officialScoresheetCrs.getString("scorer1")!=null?officialScoresheetCrs.getString("scorer1"):"";
				scorerTwo			 = officialScoresheetCrs.getString("scorer2")!=null?officialScoresheetCrs.getString("scorer2"):"";
				captainOne			 = officialScoresheetCrs.getString("captain1")!=null?officialScoresheetCrs.getString("captain1"):"";
				captainTwo			 = officialScoresheetCrs.getString("captain2")!=null?officialScoresheetCrs.getString("captain2"):"";
				wicketKeeperOne		 = officialScoresheetCrs.getString("wkeeper1")!=null?officialScoresheetCrs.getString("wkeeper1"):"";
				wicketKeeperTwo		 = officialScoresheetCrs.getString("wkeeper2")!=null?officialScoresheetCrs.getString("wkeeper2"):"";	
			    umpireOneAsscn		 = officialScoresheetCrs.getString("umpire1assn")!=null?officialScoresheetCrs.getString("umpire1assn"):"";	
				umpireTwoAsscn		 = officialScoresheetCrs.getString("umpire2assn")!=null?officialScoresheetCrs.getString("umpire2assn"):"";
			    umpireThreeAsscn	 = officialScoresheetCrs.getString("umpire3assn")!=null?officialScoresheetCrs.getString("umpire3assn"):"";
            	umpireFourAsscn		 = officialScoresheetCrs.getString("umpire4assn")!=null?officialScoresheetCrs.getString("umpire4assn"):"";
				matchRefassn		 = officialScoresheetCrs.getString("matchrefassn")!=null?officialScoresheetCrs.getString("matchrefassn"):"";
				//teamBattingFirst	 = officialScoresheetCrs.getString("battingteam")!=null?officialScoresheetCrs.getString("battingteam"):"";
			}
		  }
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}finally{
			officialScoresheetCrs = null;
		}
%>
<%	 vparam.add(matchId);
	 officialResultCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_reportresult",vparam,"ScoreDB");
	 vparam.removeAllElements();
		try{
			 if(officialResultCrs!=null){
				while (officialResultCrs.next()){
					result = officialResultCrs.getString("result")!=null?officialResultCrs.getString("result"):"";
				}
			}
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
%>
<%	vparam.add(inningIdOne);
	firstBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total",vparam,"ScoreDB");
	vparam.removeAllElements();
			if (firstBatsCrs!=null){
				try{
					while (firstBatsCrs.next()){
						firstInningTotal  = firstBatsCrs.getString("total_score")!=null?firstBatsCrs.getString("total_score"):"0";
						totalScoreTeamOne = totalScoreTeamOne + Integer.parseInt(firstInningTotal); 
					}
				}catch(Exception e){
					log.writeErrLog(page.getClass(),matchId,e.toString());
				}
			}	
%>
<%	vparam.add(inningIdTwo);
	secondBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total",vparam,"ScoreDB");
	vparam.removeAllElements();
			if (secondBatsCrs!=null){
				try{
					while (secondBatsCrs.next()){
						secondInningTotal = secondBatsCrs.getString("total_score")!=null? secondBatsCrs.getString("total_score"):"0";
						totalScoreTeamTwo = totalScoreTeamTwo + Integer.parseInt(secondInningTotal);
						totalWktTeamTwo	  =	Integer.parseInt(secondBatsCrs.getString("wicket"));
						secondInningOvers = secondBatsCrs.getString("overs")!=null?secondBatsCrs.getString("overs"):"0";
						totalOversTeamTwo =	Float.parseFloat(secondInningOvers);						
					}
				}catch(Exception e){
					log.writeErrLog(page.getClass(),matchId,e.toString());
				}
			}	
%>
<% 
	totalScoreTeamOne = totalScoreTeamOne + 1;
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
		<link rel="stylesheet" type="text/css" href="../css/menu.css">
		<script language="javascript" src="../js/xp_progress.js"></script>
		<script>
			
		</script>
  </head>
	<body>
<%  isPrint = request.getParameter("isprint")!=null?request.getParameter("isprint"):"";
	if (!(isPrint.equalsIgnoreCase("show"))){
%>
				<jsp:include page="Menu.jsp" />
				<%=matchId%> <input class="btn btn-warning btn-small" type=button value="print" onClick='window.open("/cims/jsp/LimitedOvers.jsp?isprint=show","CIMS","location=no,directories=no,status=Yes,menubar=Yes,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth-20)+",height="+(window.screen.availHeight-30))'>
<%	}
%>	
	<input type="hidden" name="hid" value="hid" />
			<table align=center width=100% class="table tableBorder">
				<tr>
					<td align=left>
						<%--<input type=button value="print" onClick="window.open('OneDayScoresheet.jsp','mywindow','width=1000,height=1000,toolbar=yes,location=yes,directories=yes,status=yes,menubar=yes,scrollbars=yes,copyhistory=yes,resizable=yes')"> 
					--%></td>	
 				</tr>
				<tr>
					<td align=center><b><font color="#003399" size=3>Official ScoreSheet For Limited Overs Match</font></b></td>
				</tr>
			</table>
			<table width=100% class="table tableBorder" align="center"  style="border-collapse:collapse">
						<tr  class=firstrow>
							<td align=center nowrap width="15%"><b>Tournament</b></td>
							<td align=center nowrap width="15%"><font color="#003399"><%=tournamentName%></font></td>
							<td align=center nowrap width="15%"><b>Match No</b></td>
							<td align=center nowrap width="15%"><font color="#003399"><%=matchNo%></font></td>
							<td align=center nowrap width="15%"><font color="#003399"><%=zone%></font></td>
							<td align=center nowrap width="15%"><b>Zone</b></td>
							<td align=center nowrap width="15%">&nbsp;</td>
						</tr>
						<tr  class=firstrow>
							<td align=center nowrap width="15%"><b>Match between</b></td>
							<td align=center nowrap width="15%"><font color="#003399"><%=teamOne%></font></td>
							<td align=center nowrap width="15%"><b>and</b></td>
							<td align=center nowrap width="15%"><font color="#003399"><%=teamTwo%></font></td>
							<td align=center nowrap width="15%"><b>Toss</b></td>
							<td align=center nowrap width="15%"><font color="#003399"><%=toss%></font></td>
							<td align=center nowrap width="15%">&nbsp;</td>
						</tr>
						<tr  class=firstrow>
							<td align=center nowrap width="15%"><b>Played at(Ground)</b></td>
							<td align=center nowrap width="15%"><font color="#003399"><%=ground%></font></td>
							<td align=center nowrap width="15%"><b>City</b></td>
							<td align=center><font color="#003399"><%=city%></font></td>
							<td align=center nowrap width="15%">&nbsp;</td>
							<td align=center nowrap width="15%">&nbsp;</td>
							<td align=center nowrap width="15%">&nbsp;</td>
							<td align=center nowrap width="15%">&nbsp;</td>
						</tr>
						<tr  class=firstrow>
							<td align=center nowrap width="15%"><b>Date</b></td>
							<td align=center nowrap width="15%"><font color="#003399"><%=date%></font></td>
							<td align=center nowrap width="15%"><b>Result</b></td>
							<td align=center nowrap width="15%"><font color="#003399"><%=result%></font></td>
							
<%	 if (( totalScoreTeamTwo == (totalScoreTeamOne-1))&&(totalWktTeamTwo < 10) && (totalOversTeamTwo < 50)){
%>
	<%--<td align=center nowrap width="15%"><font color="#003399">Tie</td>--%>
							<td align=center nowrap width="15%"><font color="#003399">&nbsp;</font></td>
<%
	}else if ( totalScoreTeamTwo < totalScoreTeamOne){	
%>
	<%--<td align=center nowrap width="15%"><font color="#003399"><%=teamOne%></td>--%>
							<td align=center nowrap width="15%"><font color="#003399">&nbsp;</font></td>
<%
	}else if ( totalScoreTeamTwo > totalScoreTeamOne){	
%>
				<%--<td align=center nowrap width="15%"><font color="#003399"><%=teamTwo%></td>--%>
							<td align=center nowrap width="15%"><font color="#003399">&nbsp;</font></td>
<%
	}else{
%><td align=center nowrap width="15%">&nbsp;</td>
<%
	}
%>
							
<%	 if ( totalScoreTeamTwo == (totalScoreTeamOne-1)){
%>
							<td align=center nowrap width="15%"><font color="#003399"></font></td>
<%	}else if ( totalScoreTeamTwo < totalScoreTeamOne){
			wonResult = totalScoreTeamOne - totalScoreTeamTwo;
			wonResult = wonResult - 1;
%>
<%
	}else if ( totalScoreTeamTwo > totalScoreTeamOne){
			totalWktTeamTwo = 10 - totalWktTeamTwo;
%>
<%
	}
%>
					</tr>	
					<tr>
						<td colspan=7>&nbsp;</td>
					</tr>
					<tr >
						<td colspan=8 ><b>If the result achieved by Duckworth & Lewis method, write the the sequence of revised target / overs:</b></td>
					</tr>
					<tr>
						<td colspan=8 ></td>
					</tr>
			</table>
			
			<table class="table tableBorder" width=100% align=center border=1 style=border-collapse:collapse>
						<tr>
							<td nowrap width=25% align=center><b>Umpires: 1.</b></td>
							<td nowrap width=25% ><font color="#003399"><%=umpireOne%> </font></td>
							<td nowrap width=25%  align=center><b>2.</b></td>
							<td nowrap width=25% ><font color="#003399"><%=umpireTwo%></font></td>
						</tr>
						<tr>
							<td nowrap width=25%  align=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;
							<b>&nbsp;&nbsp;&nbsp;3.</b></td>
							<td nowrap width=25% ><font color="#003399"><%=umpireThree%></font></td>
							<td nowrap width=25%  align=center><b>4.</b></td>
							<td nowrap width=25%> <font color="#003399"><%=umpireFour%></font></td>
						</tr>
						<tr>
							<td colspan=4 >&nbsp;</td>
						</tr>
						<tr>	
							<td nowrap width=25% align=center><b>Match Referee</b></td>
							<td nowrap width=25% ><font color="#003399"><%=matchReferee%></font></td>
							<td nowrap width=25% align=center><b>Scorer</b></td>
							<td nowrap width=25% ><font color="#003399"><%=scorerOne%></font></td>
						</tr>
						<tr>
							<td width=20% align=center><b>Captains:1.</b></td>
							<td nowrap width=25% ><font color="#003399"><%=captainOne%></font></td>
							<td width=20% align=center><b>2.</b></td>
							<td nowrap width=25% ><font color="#003399"><%=captainTwo%></font></td>
						</tr>
						<tr>
							<td width=20% align=center><b>Wicket Keepers:1.</b></td>
							<td nowrap width=25% > <font color="#003399"><%=wicketKeeperOne%></font></td>
							<td width=20% align=center><b>2.</b></td>
							<td nowrap width=25% ><font color="#003399"><%=wicketKeeperTwo%></font></td>
						</tr>
			</table>
			<br>
<%	vparam.add(inningIdOne);
	firstInningDurationCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsecondtime",vparam,"ScoreDB");
	vparam.removeAllElements();
	if(firstInningDurationCrs!=null){
		 try{
				while (firstInningDurationCrs.next()){
					teamBattingFirst		= firstInningDurationCrs.getString("battingteam")!=null?firstInningDurationCrs.getString("battingteam"):"";
					StartTimeBattingFirst	= firstInningDurationCrs.getString("startts")!=null?firstInningDurationCrs.getString("startts"):"";
					endTimeBattingFirst		= firstInningDurationCrs.getString("endts")!=null?firstInningDurationCrs.getString("endts"):"";
					durationBattingFirst	= firstInningDurationCrs.getString("duration")!=null?firstInningDurationCrs.getString("duration"):"";
				}
		 }catch(Exception e){
		 			log.writeErrLog(page.getClass(),matchId,e.toString());
		 }
	}
%>			
			<table class="table tableBorder" align="center" border=1 width=100% style=border-collapse:collapse>	
					<tr>
						<td nowrap width=10% align="center"> <b>Team Batting First</b></td>
						<td nowrap width=10% align="left"><font color="#003399"><%=teamBattingFirst%></font></td>
						<td nowrap width=15% align="center"><b>Start :</b></td>
						<td nowrap width=10% align="right">
<%if (StartTimeBattingFirst!=""){
%>			
						<font color="#003399"><%=StartTimeBattingFirst.substring(11,StartTimeBattingFirst.length())%></font>
<%
}else{
%>
						&nbsp;
<%
	}
%>						
						</td>
						<td nowrap width=10% align="center"><b>Close :</b></td>
						<td nowrap width=10% align="right">
<%if (endTimeBattingFirst!=""){
%>		
						<font color="#003399"><%=endTimeBattingFirst.substring(11,
						endTimeBattingFirst.length())%></font>
<%
}else{
%>		
						&nbsp;
<%
}
%>								
						</td>
						<td nowrap width=10% align="center"><b>Duration</b></td>
						<td nowrap width=10% align="right"><font color="#003399"><%=durationBattingFirst%></font></td>
						<td nowrap width=10% align="center"><b>Mins</b></td>
					</tr>
			</table>
			<br>
		<!-- first Div-->
			
			<table class="table tableBorder" align=center border=1 width=100% style=border-collapse:collapse>
		<!-- first <TR> start here -->		
				<tr>
		<!-- first <TD> start here -->			
					<td align=center>
		<!--code for first inning batting summery start here-->
						<table align=center border=1 width=100% height=100% style=border-collapse:collapse>
							  <tr>
								<td nowrap width=5%  align=center><b>Time<br>In</b></td>
								<td nowrap width=5%  align=center><b>Time<br>Out</b></td>
								<td nowrap width=5%  align=center><b>No.</b></td>
								<td nowrap width=20% align=center><b>Batsman</b></td>
								<td nowrap width=10% align=center><b>How<br>Out</b></td>
								<td nowrap width=15% align=center><b>Fielder</b></td>
								<td nowrap width=15% align=center><b>Bowler</b></td>
								<td nowrap width=5%  align=center><b>Mins</b></td>
								<td nowrap width=5%  align=center><b>4</b></td>
								<td nowrap width=5%  align=center><b>6</b></td>
								<td nowrap width=5%  align=center><b>Balls</b></td>
								<td nowrap width=5%  align=center><b>Runs</b></td>
							</tr>	

<%	vparam.add(inningIdOne);
	firstBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scoreshett_battingscorercard",vparam,"ScoreDB");
	vparam.removeAllElements();
	try{
		if(firstBatsCrs!=null && firstBatsCrs.size() > 0){
			while (firstBatsCrs.next()){
				 timeIn		= firstBatsCrs.getString("timein")!=null?firstBatsCrs.getString("timein"):"";
				  if (!timeIn.equals("")) {
						String splitTime[] = timeIn.split(":");
						String hourTimeIn = splitTime[0];
						String minTimeIn = splitTime[1];
						if (minTimeIn.length() == 1) {
							String minits = "0" + minTimeIn;
							timeIn = hourTimeIn + ":" + minits;
						}
                  }
				  timeOut 	= firstBatsCrs.getString("timeout")!=null?firstBatsCrs.getString("timeout"):"";
				  if (!timeOut.equals("")) {
						String splitTime[] = timeOut.split(":");
						String hourTimeIn = splitTime[0];
						String minTimeIn = splitTime[1];
						if (minTimeIn.length() == 1) {
							String minits = "0" + minTimeIn;
							timeOut = hourTimeIn + ":" + minits;
						}
                 }
				 srNo		= firstBatsCrs.getString("srno")!=null?firstBatsCrs.getString("srno"):"";
				 batsman	= firstBatsCrs.getString("batsman")!=null?firstBatsCrs.getString("batsman"):"" ;
				 howout		= firstBatsCrs.getString("howout")!=null?firstBatsCrs.getString("howout"):"" ;   
				 fielder 	= firstBatsCrs.getString("fielder")!=null?firstBatsCrs.getString("fielder"):"";  
				 bowler		= firstBatsCrs.getString("bowler")!=null?firstBatsCrs.getString("bowler"):"";
				 mins 		= firstBatsCrs.getString("mins")!=null || (!(firstBatsCrs.getString("mins").trim().equals("-1"))) ? firstBatsCrs.getString("mins"):"";    
				 four		= firstBatsCrs.getString("fours")!=null || (!(firstBatsCrs.getString("fours").trim().equals("-1"))) ? firstBatsCrs.getString("fours"):"";  
				 six		= firstBatsCrs.getString("six")!=null || (!(firstBatsCrs.getString("six").trim().equals("-1"))) ?firstBatsCrs.getString("six"):""; 
				 balls 		= firstBatsCrs.getString("balls")!=null || (!(firstBatsCrs.getString("balls").trim().equals("-1"))) ?firstBatsCrs.getString("balls"):"";  
				 runs 		= firstBatsCrs.getString("runs")!=null || (!(firstBatsCrs.getString("runs").trim().equals("-1"))) ?firstBatsCrs.getString("runs"):"";   
				 //subTotal   = subTotal + Integer.parseInt(firstBatsCrs.getString("runs"));
				if(firstBatsCrs.getString("mins").trim().equals("-1")){
					mins = "";
				}
				if(firstBatsCrs.getString("fours").trim().equals("-1")){
					four = "";
				}
				if(firstBatsCrs.getString("six").trim().equals("-1")){
					six = "";
				}
				if(firstBatsCrs.getString("balls").trim().equals("-1")){
					balls = "";
				}
				if(firstBatsCrs.getString("runs").trim().equals("-1")){
					runs = "";
				}
%>		
							<tr>
									<td align=right nowrap width=5%><font color="#003399"><%=timeIn%></font></td>
									<td align=right nowrap width=5%><font color="#003399"><%=timeOut%></font></td>
									<td align=center nowrap width=5%><font color="#003399"><%=no%></font></td>
									<td nowrap width=20%><font color="#003399"><%=batsman%></font></td>
									<td nowrap width=10% ><font color="#003399"><%=howout%></font></td>
									<td nowrap width=15% ><font color="#003399"><%=howout.trim().equalsIgnoreCase("ct&b")?"":fielder%></font></td>
									<td nowrap width=15% ><font color="#003399"><%=howout.equalsIgnoreCase("r.o.")?"":bowler%></font></td>
									<td nowrap width=5% align=right><font color="#003399">
								<a href="javascript:showPlayerTimeDetail('<%=firstBatsCrs.getString("batsmanid")!=null?firstBatsCrs.getString("batsmanid"):"0"%>','<%=inningIdOne%>')"><%=mins%></a></font></td>
									<td nowrap width=5% align=right><font color="#003399"><%=four%></font></td>
									<td nowrap width=5% align=right><font color="#003399"><%=six%></font></td>
									<td nowrap width=5% align=right><font color="#003399"><%=balls%></font></td>
									<td nowrap width=5% align=right><font color="#003399"><%=runs%></font></td>
							</tr>
<%
		  no++;
		  }
		}else{
		  		for (k=0 ; k<=10 ; k++){			
%>
							<tr>	
									<td  nowrap >&nbsp;</td>
									<td  nowrap ></td>
									<td  nowrap >&nbsp;</td>
									<td  nowrap ></td>
									<td  nowrap >&nbsp;</td>
									<td  nowrap >&nbsp;</td>
									<td  nowrap >&nbsp;</td>
									<td  nowrap >&nbsp;</td>
									<td  nowrap ></td>
									<td  nowrap >&nbsp;</td>
									<td  nowrap >&nbsp;</td>
									<td  nowrap >&nbsp;</td>
							</tr>
<%		  		}
		  }
	}catch(Exception e)	{
			log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>

<%	vparam.add(inningIdOne);
	firstBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total",vparam,"ScoreDB");
	vparam.removeAllElements();
	if (firstBatsCrs!=null){
		try{
			while (firstBatsCrs.next()){
				byes 			 = firstBatsCrs.getString("byes")!=null?firstBatsCrs.getString("byes"):"0";      
				legByes			 = firstBatsCrs.getString("legbyes")!=null?firstBatsCrs.getString("legbyes"):"0";      
				noBall 			 = firstBatsCrs.getString("noballs")!=null?firstBatsCrs.getString("noballs"):"0"; 
				wide			 = firstBatsCrs.getString("wides")!=null?firstBatsCrs.getString("wides"):"0";   
				battingSubTotal  = firstBatsCrs.getString("subtotal")!=null?firstBatsCrs.getString("subtotal"):"0"; 
				totalExtras 	 = firstBatsCrs.getString("total_extra")!=null?firstBatsCrs.getString("total_extra"):"0" ; 
				penaltyExtras 	 = firstBatsCrs.getString("penalty")!=null?firstBatsCrs.getString("penalty"):"0";   
				firstInningTotal = firstBatsCrs.getString("total_score")!=null?firstBatsCrs.getString("total_score"):"0"; 
				matchTotalWkt	 = firstBatsCrs.getString("wicket")!=null?firstBatsCrs.getString("wicket"):"0"; 
				firstInningOvers = firstBatsCrs.getString("overs")!=null?firstBatsCrs.getString("overs"):"0";
				
				byesTotal = Integer.parseInt(byes)+Integer.parseInt(legByes);
				//firstInningTotalOver = firstInningTotalOver + Float.parseFloat(firstInningOvers);
				//tExtras              =  tExtras + Integer.parseInt(byes)+Integer.parseInt(legByes)+Integer.parseInt(noBall)+Integer.parseInt(wide);
				//grandTotal           =  tExtras + subTotal + Integer.parseInt(penaltyExtras);
//				remainingWkt = 10 - Integer.parseInt(matchTotalWkt);
				firstInningWkt  = Integer.parseInt(matchTotalWkt);
				
		   }
		}catch(Exception e)	{
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}
%>

<%-- code to get reserve player 	--%>
<%--<%
		vparam.add("1");
		reserveplayerCrs = lobjGenerateProc.GenerateStoreProcedure("dsp_reserve",vparam,"ScoreDB");
		vparam.removeAllElements();
		String reserveplayerCrs = "";
		String reservePlayerOne = "";
		String reservePlayerTwo = "";
		String reservePlayerThree = "";
			if (reserveplayerCrs!=null){														
				try{	
						while (reserveplayerCrs.next()){
						 reserveplayerCrs =reserveplayerCrs + reserveplayerCrs.getString("playername")+"~";
						}
				}catch(Exception e){
				 }
			}
		String reservebatsman[] = reserveplayerCrs.split("~");
		for (int i = 0 ; i < reservebatsman.length ; i++){
			reservePlayerOne = reservebatsman[0];
			reservePlayerTwo = reservebatsman[1];
			reservePlayerThree = reservebatsman[2];
			
		}
%>
--%>
<%  vparam.add(inningIdOne);
	reservePlayerCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_twelthnreserveplayers",vparam,"ScoreDB");
	vparam.removeAllElements();
	try{
		if (reservePlayerCrs!=null){
				while (reservePlayerCrs.next()){
					if (reservePlayerCrs.getString("player_status").trim().equalsIgnoreCase("R")){
						reservePlayer = reservePlayer + reservePlayerCrs.getString("reserve_player")+ "~";
					}
					if (reservePlayerCrs.getString("player_status").trim().equalsIgnoreCase("T")){
						twelveman = reservePlayerCrs.getString("reserve_player")!=null?reservePlayerCrs.getString("reserve_player"):"";
					}
				}
				String reservebatsman[] = reservePlayer.split("~");
				for(int count1 = 0; count1 < reservebatsman.length; count1++){
					
				}
				if (reservebatsman !=null){
					if(reservebatsman.length == 3){
						reservePlayerOne 	= reservebatsman[0];
						reservePlayerTwo 	= reservebatsman[1];
						reservePlayerThree  = reservebatsman[2];
					}else if(reservebatsman.length == 2){
						reservePlayerOne 	= reservebatsman[0];
						reservePlayerTwo 	= reservebatsman[1];
					}else if(reservebatsman.length == 1){
						reservePlayerOne 	= reservebatsman[0];
					}
				}
			}
		}catch(Exception e)	{
				 log.writeErrLog(page.getClass(),matchId,e.toString());
		}finally{
			reservePlayerCrs = null;
		}
				
%>
<%--end 	--%>
			
							<tr>
								<td colspan="5" nowrap><b>Reserves:</b></td>
								<td align=right nowrap><b>Byes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=byes%></font></td>
								<td colspan="5" align=center nowrap><b>Batting Sub Total</b></td>
								<td align=right nowrap><font color="#003399"><%=battingSubTotal%></font></td>
							</tr>
							<tr>
								<td colspan="5" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;<font color="#003399"><%=reservePlayerOne%></font>
								</td>
								<td align=right nowrap><b>Leg Byes&nbsp;&nbsp;&nbsp;</b>
									<font color="#003399"><%=legByes%></font>
								</td>
								<td colspan="5" align=center nowrap><b>Total Extras</b></td>
								<td align=right nowrap><font color="#003399"><%=totalExtras%></font></td>
							</tr>
							<tr>
								<td colspan="5" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<font color="#003399"><%=reservePlayerTwo%></font>
								</td>
								<td align=right nowrap><b>No Balls&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><font 	color="#003399"><%=noBall%></font>
								</td>
								<td colspan="5" align=center nowrap><b>Penalty Extras</b></td>
								<td align=right nowrap><font color="#003399"><%=penaltyExtras%></font></td>
							</tr>
							<tr>
								<td colspan="5" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;<font color="#003399"><%=reservePlayerThree%></font>
								</td>
								<td align=right nowrap><b>Wides&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=wide%></font>
								</td>
								<td colspan="5" align=right nowrap><b>TotalFor &nbsp;&nbsp;</b><font color="#003399"><%=firstInningTotal%></font>&nbsp;&nbsp;<b>Wkts</b>
								&nbsp;&nbsp;<font color="#003399"><%=matchTotalWkt%></font>&nbsp;&nbsp;&nbsp;&nbsp;<b>Overs</b>&nbsp;&nbsp;
								</td>
								<td align=right nowrap><font color="#003399"><%=firstInningOvers%></font></td>
							</tr>
						</table>	
						
		<!--end here-->
						
		<!--Code for first inning fall wicket,partnership and bowling analysis start here	-->
				<table align=center  width=100% border=1 height=100% style=border-collapse:collapse>
					<tr>
						<td  align="center" nowrap width=10%>
							<table align=center border=1 width=100%>
											<tr>
												<td colspan="3" align=center><b>Fall of Wickets</b></td>
											</tr>	
											<tr>
												<td align=center nowrap ><b>Wkt</b></td>
												<td align=center nowrap ><b>Runs</b></td>
												<td align=center nowrap ><b>Overs</b></td>
											</tr>	
<%		vparam.add(inningIdOne);
		firstBatFallWicketCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
		vparam.removeAllElements();
		crsSize = firstBatFallWicketCrs.size();
		rowGrowLength = 10 - crsSize;
		if(firstBatFallWicketCrs!=null){
			try{
				while (firstBatFallWicketCrs.next()){
						wkt      = firstBatFallWicketCrs.getString("srno")!=null?firstBatFallWicketCrs.getString("srno"):"";
						wktRuns  = firstBatFallWicketCrs.getString("runs")!=null?firstBatFallWicketCrs.getString("runs"):"";
						wktOvers = firstBatFallWicketCrs.getString("overs")!=null?firstBatFallWicketCrs.getString("overs"):"";
						wktCount = Integer.parseInt(wkt);

%>	

												<tr>
													<td align=center nowrap ><font color="#003399"><%=wkt%></font></td>
													<td align=right nowrap ><font color="#003399"><%=wktRuns%></font></td>
													<td align=right nowrap ><font color="#003399"><%=wktOvers%></font></td>
												</tr>

<%
					
					
				}
			  }catch(Exception e){
			  	log.writeErrLog(page.getClass(),matchId,e.toString());
			  }
		}
%>	


<%		for (k =0 ; k < rowGrowLength ; k++){
				wktCount++;
			
%>

												<tr>
													<td align=center><font color="#003399"><%=wktCount%></font></td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
<%
		}
%>					
												<tr>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>	
								</table>						
						</td>
						<td  align="center" nowrap width=45%>
							<table align=center border=1 width=100%>
											<tr>
												<td colspan="4" align="center"><b>Partnerships</b></td>
											</tr>
											<tr>
												<td align=center nowrap ><b>Batsmen</b></td>
												<td align=center nowrap ><b>Runs</b></td>
												<td align=center nowrap ><b>Mins</b></td>
												<td align=center nowrap ><b>Balls</b></td>	
											</tr>

<%		vparam.add(inningIdOne);
		partnershipsCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_partnershipdtls",vparam,"ScoreDB");
		vparam.removeAllElements();
		crsSize = partnershipsCrs.size();
		rowGrowLength = 10 - crsSize;
		if (partnershipsCrs!=null){
			try{
				while (partnershipsCrs.next()){
					batsmanOne = partnershipsCrs.getString("batsman")!=null?partnershipsCrs.getString("batsman"):"";
					totalRuns  = partnershipsCrs.getString("runs")!=null?partnershipsCrs.getString("runs"):"0";
					minute     = partnershipsCrs.getString("mins")!=null?partnershipsCrs.getString("mins"):"0";
					totalballs = partnershipsCrs.getString("balls")!=null?partnershipsCrs.getString("balls"):"0";
												
%>	
								  			 <tr>
												<td nowrap><font color="#003399" ><%=batsmanOne%></font></td>
												<td align=right nowrap><font color="#003399"><%=totalRuns%></font></td>
												<td align=right nowrap><font color="#003399"><%=minute%></font></td>
												<td align=right nowrap><font color="#003399"><%=totalballs%></font></td>
											 </tr>

<%			  }
			}catch(Exception e)	{
				log.writeErrLog(page.getClass(),matchId,e.toString());
			}
		}

%>


<%		for (k =0 ; k<rowGrowLength ; k++){
%>

										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>

<%
		}
%>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>	
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>	
							</table>	
						</td>
						<td  align="center" nowrap width=45%>
							<table align=center border=1 width=100%>
											<tr>
												<td colspan=7 align=center><b>Bowling Analysis</b></td>
											</tr>
											<tr>					
												<td align=center nowrap ><b>Bowlers</b></td>
												<td align=center nowrap ><b>O</b></td>
												<td align=center nowrap ><b>M</b></td>
												<td align=center nowrap ><b>R</b></td>
												<td align=center nowrap ><b>W</b></td>
												<td align=center nowrap ><b>nb</b></td>
												<td align=center nowrap ><b>wb</b></td>
											</tr>
<%	//vparam.add();
	vparam.add(session.getAttribute("matchid"));
	vparam.add(inningIdOne);
	vparam.add("");
	totalOver		= 0;
	totalMaiden		= 0;
	totalRunrate	= 0;
	totalWkt		= 0;
	totalNB			= 0;
	totalWB			= 0;
	bowledAnalysisCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowlinganalysisfortestmatch",vparam,"ScoreDB");	
	vparam.removeAllElements();
	crsSize = bowledAnalysisCrs.size();
	rowGrowLength = 10 - crsSize;
	if(bowledAnalysisCrs!=null){
		try{
			while (bowledAnalysisCrs.next()){
				bowlerName		= bowledAnalysisCrs.getString("bowlername")!=null?bowledAnalysisCrs.getString("bowlername"):"";
				bowlerOver  	= bowledAnalysisCrs.getString("noofover")!=null?bowledAnalysisCrs.getString("noofover"):"0";
				bowlerMaiden	= bowledAnalysisCrs.getString("maiden")!=null?bowledAnalysisCrs.getString("maiden"):"0";
				bowlerRunrate	= bowledAnalysisCrs.getString("runs")!=null?bowledAnalysisCrs.getString("runs"):"0";
				bowlerWicket	= bowledAnalysisCrs.getString("wicket")!=null?bowledAnalysisCrs.getString("wicket"):"0";
				bowlerNB		= bowledAnalysisCrs.getString("noball")!=null?bowledAnalysisCrs.getString("noball"):"0";
				bowlerWB		= bowledAnalysisCrs.getString("wideball")!=null?bowledAnalysisCrs.getString("wideball"):"0";
%>	
												
									<tr>			
											<td nowrap width=40%><font color="#003399"><%=bowlerName%></font></td>
											<td nowrap width=10% align=right><font color="#003399"><%=bowlerOver%></font></td>
											<td nowrap width=10% align=right><font color="#003399"><%=bowlerMaiden%></font></td>
											<td nowrap width=10% align=right><font color="#003399"><%=bowlerRunrate%></font></td>	
											<td nowrap width=10% align=right><font color="#003399"><%=bowlerWicket%></font></td>	
											<td nowrap width=10% align=right><font color="#003399"><%=bowlerNB%></font></td>	
											<td nowrap width=10% align=right><font color="#003399"><%=bowlerWB%></font></td>	
									</tr>
<%
			totalOver	= totalOver   + Float.parseFloat(bowlerOver);
			totalMaiden	= totalMaiden + Integer.parseInt(bowlerMaiden);
			totalRunrate= totalRunrate+ Integer.parseInt(bowlerRunrate); 
			totalWkt	= totalWkt    + Integer.parseInt(bowlerWicket);
			totalNB		= totalNB     + Integer.parseInt(bowlerNB);
			totalWB		= totalWB     + Integer.parseInt(bowlerWB); 		
			remainingWkt= firstInningWkt - Integer.parseInt(bowlerWicket);		
		 }
	  }catch(Exception e){
	  	log.writeErrLog(page.getClass(),matchId,e.toString());
	  }
	}
										
%>
<%		for (k =0 ; k<rowGrowLength ; k++){
%>
									<tr>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
									</tr>
<%
		}
%>									
									
									<tr>			
											<td align=center nowrap width=40%><b>Sub Total</b></td>
											<td align=center nowrap width=10%><font color="#003399"><%=totalOver%></font></td>
											<td align=center nowrap width=10%><font color="#003399"><%=totalMaiden%></font></td>
											<td align=center nowrap width=10%><font color="#003399"><%=totalRunrate%></font></td>	
											<td align=center nowrap width=10%><font color="#003399"><%=totalWkt%></font></td>	
											<td align=center nowrap width=10%><font color="#003399"><%=totalNB%></font></td>	
											<td align=center nowrap width=10%><font color="#003399"><%=totalWB%></font></td>	
									</tr>
									<tr>
											<td align=center nowrap width=40%><b>Byes/LegByes</b></td>
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</font></td>
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</font></td>
											<td align=center nowrap width=10%><font color="#003399"><%=byesTotal%></font></td>	
											<td align=center nowrap width=10%><font color="#003399"></font></td>	
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</font></td>	
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</font></td>	
									</tr>
<%
	byesPlusTotalrun = byesTotal + totalRunrate;
	totalFirstInningWkt		 = remainingWkt + totalWkt; 		
%>									
									<tr>
											<td align=center nowrap width=40%><b>GrandTotal</b></td>
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</font></td>
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</font></td>
											<td align=center nowrap width=10%><font color="#003399"><%=byesPlusTotalrun%></font></td>	
											<td align=center nowrap width=10%><font color="#003399"></font></td>	
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</font></td>	
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</font></td>	
									</tr>
			
								</table>
						</td>
					</tr>
			</table>
		<!-- end here -->
		
		<%--Reason for penalty Run for first innings--%>
		<table align=center  width=100% height=100% style=border-collapse:collapse>
							<tr>
								<td colspan="3" align=center nowrap><b>Reason for penalty Runs if any:  &nbsp;&nbsp;&nbsp;&nbsp;<font color="#003399"><%=penaltyReason%></font></b></td>
							</tr>
							<tr>
								<td colspan=6 align=center>
										<table border=1 width=100% >
<%
	vparam.add(inningIdOne);
	penaltyReasonCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_penaltyreason",vparam,"ScoreDB");
	vparam.removeAllElements();	
	try{
		if(penaltyReasonCrs!=null){
			while(penaltyReasonCrs.next()){
				penaltyDescription = penaltyReasonCrs.getString("description")!=null?penaltyReasonCrs.getString("description"):"";
%>							
											<tr>
												<td nowrap><font color="#003399"><%=penaltyDescription%></font></td>
											</tr>
<%
	  		}
  		}	 
  	}catch(Exception e)	{
  		log.writeErrLog(page.getClass(),matchId,e.toString());
	}  	
  	
%>									
									</table>								
								</td>
						 </tr>
		</table>
		<%--End here--%>
		<BR>
		<!-- code for scoring rate ,individual batsman run,partnership start here --> 
		<table align=center  width=100% border=1 height=100% style=border-collapse:collapse>
					<tr>
						<td align="center" nowrap>
							<table width=100% border=1>
									<tr>
										<td colspan=3 nowrap align=center><b>Scoring Rate</b></td>
									</tr>
									<tr>
										<td nowrap align=center><b>Runs</b></td>
										<td nowrap align=center><b>Overs</b></td>
										<td nowrap align=center><b>Mins</b></td>
									</tr>
									
<%	vparam.add(inningIdOne);
	firstBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamscoredetails_for_testmatch",vparam,"ScoreDB");
	vparam.removeAllElements();
	int runSize = 0;
	crsSize = firstBatsCrs.size();
	rowGrowLength = 10 - crsSize;
	if (firstBatsCrs!=null) {
	  try{
		 while (firstBatsCrs.next()){
		 			if (firstBatsCrs.getString("run_range") !=null){
			 			firstInningScoringRunrange	= firstBatsCrs.getString("run_range")!=null?firstBatsCrs.getString("run_range"):"";
						firstInningScoringMin		= firstBatsCrs.getString("minutes")!=null?firstBatsCrs.getString("minutes"):"";
						firstInningScoringOvers		= firstBatsCrs.getString("overs")!=null?firstBatsCrs.getString("overs"):"";
						runSize 					= Integer.parseInt(firstInningScoringRunrange);
					//runSize = Integer.parseInt(secondTeamScoreMins);
%>
									<tr>
										<td nowrap align=right><font color="#003399"><%=firstInningScoringRunrange%></font></td>
										<td nowrap align=right><font color="#003399"><%=firstInningScoringOvers%></font></td>
										<td nowrap align=right><font color="#003399"><%=firstInningScoringMin%></font></td>
									</tr>	
<%					}
		}
	}catch(Exception e)	{
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
  }	
%>	
<%
	for (k=0 ; k <rowGrowLength ; k++ ){
	runSize = runSize + 50;
%>
									<tr>
										<td nowrap align=right><font color="#003399"><%=runSize%></font></td>
										<td nowrap align=center>&nbsp;</td>
										<td nowrap align=center>&nbsp;</td>
									</tr>	
<%
	}
%>

							

							</table>
						</td>	
						<td align="center" nowrap>
						<table width=100% border=1>
						<tr>
							<td align=center nowrap><font size=1><b>INDIVIDUAL SCORES</b></font></td>
							<td align=center nowrap colspan=4><font size=1><b>For 50</b></font></td>
							<td align=center nowrap colspan=4><font size=1><b>For 100</b></font></td>
						</tr>
						<tr>
							<td align=center nowrap><font size=1><b>Batsman</b></font></td>
							<td nowrap align=center><font size=1><b>Min's</b></font></td>
							<td nowrap align=center><font size=1><b>4's</b></font></td>
							<td nowrap align=center><font size=1><b>6's</b></font></td>
							<td nowrap align=center><font size=1><b>Balls</b></font></td>
							<td nowrap align=center><font size=1><b>Min's</b></font></td>
							<td nowrap align=center><font size=1><b>4's</b></font></td>
							<td nowrap align=center><font size=1><b>6's</b></font></td>
							<td nowrap align=center><font size=1><b>Balls</b></font></td>
						</tr> 
			<%  vparam.add(inningIdOne);
				//vparam.add(inningIdTwo);
				firstBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_individualscores_for_testmatch",vparam,"ScoreDB");
				vparam.removeAllElements();
				try{
					if (firstBatsCrs!=null ) {
					 	 while (firstBatsCrs.next()){
			%>									<tr>
													<td align=left nowrap><font color="#003399" size=1><%=firstBatsCrs.getString("batsman")!=null?firstBatsCrs.getString("batsman"):""%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("fifty_Min")!=null?firstBatsCrs.getString("fifty_Min"):"0"%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("fifty_four")!=null?firstBatsCrs.getString("fifty_four"):"0"%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("fifty_six")!=null?firstBatsCrs.getString("fifty_six"):"0"%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("fifty_ball")!=null?firstBatsCrs.getString("fifty_ball"):"0"%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("hundred_Min")!=null?firstBatsCrs.getString("hundred_Min"):""%></font></td>
			<%	if(!firstBatsCrs.getString("hundred_Min").equals("0")){
			%>
													<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(firstBatsCrs.getString("hundred_four")!=null?firstBatsCrs.getString("hundred_four"):"0")+Integer.parseInt(firstBatsCrs.getString("fifty_four")!=null?firstBatsCrs.getString("fifty_four"):"0")%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(firstBatsCrs.getString("hundred_six")!=null?firstBatsCrs.getString("hundred_six"):"0") + Integer.parseInt(firstBatsCrs.getString("fifty_six")!=null?firstBatsCrs.getString("fifty_six"):"0")%></font></td>
			<%}else{
			%>	
													<td align=right><font color="#003399" size=1>0</font></td>		
													<td align=right><font color="#003399" size=1>0</font></td>
			<%}
			%>										<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("hundred_ball")!=null?firstBatsCrs.getString("hundred_ball"):"0"%></font></td>
											</tr>			
			<%		 	 }
					}
				}catch(Exception e)	{
					log.writeErrLog(page.getClass(),matchId,e.toString());
				} 	 
			%>	 	 
										</table>
						</td>
					</tr>
			  </table>
			  <table border=1 width=100% align=center style=border-collapse:collapse>
					<tr >
							<td nowrap align=center width=20%><b>From</b></td>
							<td nowrap align=center width=20%><b>To</b></td>
							<td nowrap align=center width=20%><b>Hour/Min</b></td>
							<td nowrap align=center width=20%><b>ol</b></td>
							<td nowrap align=center width=20%><b>Stoppage/reason</b></td>
					</tr>
<%        vparam.add(inningIdOne);
           officialScoresheetCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_stoppages", vparam, "ScoreDB");
           vparam.removeAllElements();
            try {
                if (officialScoresheetCrs != null) {
                while (officialScoresheetCrs.next()) {
 %>
                    <tr>
                        <td align=center width=20%><font color="#003399" size=1><%=officialScoresheetCrs.getString("start_ts")	!=null?officialScoresheetCrs.getString("start_ts").substring(0,16):""%></font></td>
                        <td align=center width=20%><font color="#003399" size=1><%=officialScoresheetCrs.getString("end_ts")	!=null?officialScoresheetCrs.getString("end_ts").substring(0,16):""%></font></td>
                        <td align=center width=20%><font color="#003399" size=1><%= officialScoresheetCrs.getString("hour")	!=null?officialScoresheetCrs.getString("hour"):""%>/<%=officialScoresheetCrs.getString("min")!=null?officialScoresheetCrs.getString("min"):""%></font></td>
                        <td align=center width=20%><font color="#003399" size=1><%=officialScoresheetCrs.getString("overlost")	!=null?officialScoresheetCrs.getString("overlost"):""%></font></td>
                        <td align=center width=20%><font color="#003399" size=1><%=officialScoresheetCrs.getString("interval")	!=null?officialScoresheetCrs.getString("interval"):""%></font></td>
                    </tr>
<%				}
			}
		}catch (Exception e) {
               // log.writeErrLog(page.getClass(), matchId, e.toString());
        }
%>			</table>
</td>

		<!--First <TD> End here-->
		
		<!-- Second <TD> Start here -->
		<td align=center>
			<table border="1" width=100% height=100% style=border-collapse:collapse>
					<tr>
						<td colspan="4" nowrap align=center><b>Run Rate</b></td>
					</tr>
					<tr>	
						<td nowrap align=center width=25%><b>Ov</b></td>
						<td nowrap align=center width=25%><b>Runs</b></td>
						<td nowrap align=center width=25%><b>W</b></td>
						<td nowrap align=center width=25%><b>Runrate</b></td>
					</tr>
					
<%	vparam.add(inningIdOne);
	overRunrateCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_runratedtls",vparam,"ScoreDB");
	vparam.removeAllElements();
	crsSize = overRunrateCrs.size();
	rowGrowLength = 50 - crsSize;
	rowLength = rowGrowLength;
	if(overRunrateCrs!=null){
		try{
			while (overRunrateCrs.next()){  
				overs   = overRunrateCrs.getString("overs")!=null?overRunrateCrs.getString("overs"):"0";
				run	    = overRunrateCrs.getString("runs")!=null?overRunrateCrs.getString("runs"):"0";;	
				wicket  = overRunrateCrs.getString("wicket")!=null?overRunrateCrs.getString("wicket"):"0";;
				runRate = overRunrateCrs.getString("runrate")!=null?overRunrateCrs.getString("runrate"):"0";
%>	
						<tr>
							<td align=right nowrap width=25%><font color="#003399"><%=overs%></font></td>
							<td align=right nowrap width=25%><font color="#003399"><%=run%></font></td>
							<td align=right nowrap width=25%><font color="#003399"><%=wicket%></font></td>
							<td align=right nowrap width=25%><font color="#003399"><%=runRate%></font></td>
						</tr>
<%						
			}
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}
%>		
<%
	for (k=0 ; k < rowGrowLength ; k++){
		crsSize++;
%>
						<tr> 
							<td nowrap align=right width=25%><font color="#003399"><%=crsSize%></font></td>
							<td nowrap align=center width=25%>&nbsp;</td>
							<td nowrap align=center width=25%>&nbsp;</td>
							<td nowrap align=center width=25%>&nbsp;</td>
						</tr>
<%
		
	}
%>
				</table>	
			 </td>
			<!-- second <TD> end here -->
		   </tr>
		<!-- first<TR> ends  here -->
		</table>
	<!--fisrt div End-->
<%
	targetScore 	   = targetScore + Integer.parseInt(firstInningTotal) ;
	revisedTargetScore = revisedTargetScore + Integer.parseInt(firstInningTotal) ;
	vparam.add("");
	vparam.add(session.getAttribute("matchid"));
	overShortCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchtype",vparam,"ScoreDB");
	vparam.removeAllElements();
	if(overShortCrs!=null){
		try{
			while (overShortCrs.next()){  
				overMax  = overShortCrs.getString("overs_max")!=null?overShortCrs.getString("overs_max"):"0";
			}
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}			
%>

		<table class="table tableBorder"  align="center" border=0 width=100% style=border-collapse:collapse>
					<tr>
						<td align=center nowrap width=10%><b>Target</b></td>
						<%--<td nowrap width=10% align=center><font color="#003399"><%=targetScore%></td>
						--%>
						<td nowrap width=10% align=center><font color="#003399"><textarea></textarea></font></td>
						<td align=center nowrap width=10%><b>Runs in</b></td>
						<td nowrap width=10% align=center><font color="#003399"><textarea></textarea></font></td>
						<td align=center nowrap width=10%><b>Overs</b></td>
						<td align=center nowrap width=10%><b>Revised target:</b></td>
						<td nowrap width=10% align=center><font color="#003399"><textarea></textarea></font></td>
						<td align=center nowrap width=10%><b>Runs in</b></td>
						<td nowrap width=10% align=center><font color="#003399"><textarea></textarea></font></td>
						<td align=center nowrap width=10%><b>Overs</b></td>
					</tr>
		</table>
		
<%	vparam.add(inningIdTwo);
	secondInningDurationCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsecondtime",vparam,"ScoreDB");
	vparam.removeAllElements();
	if(secondInningDurationCrs!=null){
		 try{
				while (secondInningDurationCrs.next()){
					teamBattingSecond		=secondInningDurationCrs.getString("battingteam")!=null?secondInningDurationCrs.getString("battingteam"):"";
					StartTimeBattingSecond	=secondInningDurationCrs.getString("startts")!=null?secondInningDurationCrs.getString("startts"):"";
					endTimeBattingSecond	=secondInningDurationCrs.getString("endts")!=null?secondInningDurationCrs.getString("endts"):"";
					durationBattingSecond	=secondInningDurationCrs.getString("duration")!=null?secondInningDurationCrs.getString("duration"):"";
				}
		 }catch(Exception e){
		 		log.writeErrLog(page.getClass(),matchId,e.toString());
		 }
	}
%>
		<br>
			<table class="table tableBorder" align="center" border=1 width=100% style=border-collapse:collapse>	
					<tr>
						<td nowrap width=10% align="center"> <b>Team Batting Second</b></td>
						<td nowrap width=10% align=center> <font color="#003399"><%=teamBattingSecond%></font></td>
						<td nowrap width=10% align="center"><b>Start :</b></td>
						<td nowrap width=15% align=right>
<% if (StartTimeBattingSecond!= ""){
%>
						<font color="#003399"><%=StartTimeBattingSecond.substring(11,StartTimeBattingSecond.length())%></font>
<%
	}else{
%>	
						&nbsp;		
<%
	}
%>
			
						</td>
						<td nowrap width=10% align="center"><b>Close :</b></td>
						<td nowrap width=15% align=right>
<% if (endTimeBattingSecond!= ""){
%>
						<font color="#003399"><%=endTimeBattingSecond.substring(11,endTimeBattingSecond.length())%></font>
<%
}else{
%>	
						&nbsp;	
<%
	}
%>				
						</td>
						<td nowrap width=10% align="center"><b>Duration</b></td>
						<td nowrap width=10% align=center><font color="#003399"><%=durationBattingSecond%></font></td>
						<td nowrap width=10% align="center"><b>Mins</b></td>
					</tr>
			</table>
		<br>	
	
		
			<table class="table tableBorder" align=center border=0 width=100% style=border-collapse:collapse>
				<tr>
					<td align=center>
						<table align=center border=1 width=100% height=100% style=border-collapse:collapse>
							 <tr>
								<td nowrap width=5%  align=center><b>Time<br>In</b></td>
								<td nowrap width=5%  align=center><b>Time<br>Out</b></td>
								<td nowrap width=5%  align=center><b>No.</b></td>
								<td nowrap width=20% align=center><b>Batsman</b></td>
								<td nowrap width=10% align=center><b>How<br>Out</b></td>
								<td nowrap width=15% align=center><b>Fielder</b></td>
								<td nowrap width=15% align=center><b>Bowler</b></td>
								<td nowrap width=5%  align=center><b>Mins</b></td>
								<td nowrap width=5%  align=center><b>4</b></td>
								<td nowrap width=5%  align=center><b>6</b></td>
								<td nowrap width=5%  align=center><b>Balls</b></td>
								<td nowrap width=5%  align=center><b>Runs</b></td>
							</tr>	
	
<%  vparam.add(inningIdTwo);
	secondBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scoreshett_battingscorercard",vparam,"ScoreDB");
	vparam.removeAllElements();
	subTotal = 0;
	no		 = 1;
	try{
	if(secondBatsCrs!=null && secondBatsCrs.size() > 0){
		while (secondBatsCrs.next()){
				 timeIn	  = secondBatsCrs.getString("timein")!=null?secondBatsCrs.getString("timein"):"";
				 if (!timeIn.equals("")) {
						String splitTime[] = timeIn.split(":");
						String hourTimeIn = splitTime[0];
						String minTimeIn = splitTime[1];
						if (minTimeIn.length() == 1) {
							String minits = "0" + minTimeIn;
							timeIn = hourTimeIn + ":" + minits;
						}
                  }
				 timeOut  = secondBatsCrs.getString("timeout")!=null?secondBatsCrs.getString("timeout"):"";
			     if (!timeOut.equals("")) {
						String splitTime[] = timeOut.split(":");
						String hourTimeIn = splitTime[0];
						String minTimeIn = splitTime[1];
						if (minTimeIn.length() == 1) {
							String minits = "0" + minTimeIn;
							timeOut = hourTimeIn + ":" + minits;
						}
                 }
			
				 srNo	  = secondBatsCrs.getString("srno")!=null?secondBatsCrs.getString("srno"):"";
				 batsman  = secondBatsCrs.getString("batsman")!=null?secondBatsCrs.getString("batsman"):"";
				 howout	  = secondBatsCrs.getString("howout")!=null?secondBatsCrs.getString("howout"):"" ;     
				 fielder  = secondBatsCrs.getString("fielder")!=null?secondBatsCrs.getString("fielder"):"" ;   
				 bowler   = secondBatsCrs.getString("bowler")!=null?secondBatsCrs.getString("bowler"):"";      
				 mins 	  = secondBatsCrs.getString("mins")!=null || (!(secondBatsCrs.getString("mins").trim().equalsIgnoreCase("-1"))) ?secondBatsCrs.getString("mins"):"";      
				 four	  = secondBatsCrs.getString("fours")!=null || (!(secondBatsCrs.getString("fours").trim().equalsIgnoreCase("-1"))) ?secondBatsCrs.getString("fours"):"";   
				 six	  = secondBatsCrs.getString("six")!=null || (!(secondBatsCrs.getString("six").trim().equalsIgnoreCase("-1"))) ?secondBatsCrs.getString("six"):""; 
				 balls    = secondBatsCrs.getString("balls")!=null || (!(secondBatsCrs.getString("balls").trim().equalsIgnoreCase("-1"))) ?secondBatsCrs.getString("balls"):"";      
				 runs 	  = secondBatsCrs.getString("runs")!=null || (!(secondBatsCrs.getString("runs").trim().equalsIgnoreCase("-1"))) ?secondBatsCrs.getString("runs"):""; 
				 if(secondBatsCrs.getString("mins").trim().equals("-1")){
					mins = "";
				}
				if(secondBatsCrs.getString("fours").trim().equals("-1")){
					four = "";
				}
				if(secondBatsCrs.getString("six").trim().equals("-1")){
					six = "";
				}
				if(secondBatsCrs.getString("balls").trim().equals("-1")){
					balls = "";
				}
				if(secondBatsCrs.getString("runs").trim().equals("-1")){
					runs = "";
				}
		
				//subTotal = subTotal + Integer.parseInt(secondBatsCrs.getString("runs"));
%>		
								<tr>
									<td align=right nowrap width=5%><font color="#003399"><%=timeIn%></font></td>
									<td align=right nowrap width=5%><font color="#003399"><%=timeOut%></font></td>
									<td align=center nowrap width=5%><font color="#003399"><%=no%></font></td>
									<td nowrap width=20%><font color="#003399"><%=batsman%></font></td>
									<td nowrap width=10% ><font color="#003399"><%=howout%></font></td>
									<td nowrap width=15% ><font color="#003399"><%=howout.trim().equalsIgnoreCase("ct&b")?"":fielder%></font></td>
									<td nowrap width=15% ><font color="#003399"><%=howout.equalsIgnoreCase("r.o.")?"":bowler%></font></td>
									<td nowrap width=5% align=right><font color="#003399">
								<a href="javascript:showPlayerTimeDetail('<%=secondBatsCrs.getString("batsmanid")!=null?secondBatsCrs.getString("batsmanid"):"0"%>','<%=inningIdTwo%>')"><%=mins%></a></font></td>
									<td nowrap width=5% align=right><font color="#003399"><%=four%></font></td>
									<td nowrap width=5% align=right><font color="#003399"><%=six%></font></td>
									<td nowrap width=5% align=right><font color="#003399"><%=balls%></font></td>
									<td nowrap width=5% align=right><font color="#003399"><%=runs%></font></td>
								</tr>
<%
			no++;
	  	 }
	  	}else{
		  		for (k=0 ; k<=10 ; k++){			
%>
									<tr>
											<td  nowrap >&nbsp;</td>
											<td  nowrap ></td>
											<td  nowrap >&nbsp;</td>
											<td  nowrap ></td>
											<td  nowrap >&nbsp;</td>
											<td  nowrap >&nbsp;</td>
											<td  nowrap >&nbsp;</td>
											<td  nowrap >&nbsp;</td>
											<td  nowrap ></td>
											<td  nowrap >&nbsp;</td>
											<td  nowrap >&nbsp;</td>
											<td  nowrap >&nbsp;</td>
										</tr>
<%		  		}
		  } 
       }catch(Exception e)	{
       		log.writeErrLog(page.getClass(),matchId,e.toString());
       }
  	
  	
%>

<%
	vparam.add(inningIdTwo);
	secondBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total",vparam,"ScoreDB");
	vparam.removeAllElements();
	tExtras      = 0;
	grandTotal   = 0;
	byesTotal    = 0;
	remainingWkt = 0;
	if (secondBatsCrs!=null){
	  try{
		while (secondBatsCrs.next()){
			byes		      = secondBatsCrs.getString("byes")!=null?secondBatsCrs.getString("byes"):"0"; 
			legByes		      = secondBatsCrs.getString("legbyes")!=null?secondBatsCrs.getString("legbyes"):"0"; 
			noBall 		      = secondBatsCrs.getString("noballs")!=null?secondBatsCrs.getString("noballs"):"0"; 
			wide		      = secondBatsCrs.getString("wides")!=null?secondBatsCrs.getString("wides"):"0";   
			battingSubTotal   = secondBatsCrs.getString("subtotal")!=null?secondBatsCrs.getString("subtotal"):"0"; 
			totalExtras       = secondBatsCrs.getString("total_extra")!=null?secondBatsCrs.getString("total_extra"):"0"; 
			penaltyExtras     = secondBatsCrs.getString("penalty")!=null?secondBatsCrs.getString("penalty"):"0"; 
			secondInningTotal = secondBatsCrs.getString("total_score")!=null?secondBatsCrs.getString("total_score"):"0"; 
			matchTotalWkt     = secondBatsCrs.getString("wicket")!=null?secondBatsCrs.getString("wicket"):"0"; 
			secondInningOvers = secondBatsCrs.getString("overs")!=null?secondBatsCrs.getString("overs"):"0";
			
			secondInningTotalOver = secondInningTotalOver + Float.parseFloat(secondInningOvers);
			//tExtras   			  = Integer.parseInt(byes)+Integer.parseInt(legByes)+Integer.parseInt(noBall)+Integer.parseInt(wide);
			//grandTotal			  = tExtras + subTotal + Integer.parseInt(penaltyExtras);
			byesTotal 			  = Integer.parseInt(byes)+Integer.parseInt(legByes);
			//remainingWkt = 10 - Integer.parseInt(matchTotalWkt);
			secondInningSecond = Integer.parseInt(matchTotalWkt);
		}
	  }catch(Exception e)	{
	  		log.writeErrLog(page.getClass(),matchId,e.toString());
	  }
	}
%>

<%-- code to get reserve player 	--%>
<%  reservePlayerCrs = null;
	vparam.add(inningIdTwo);
	reservePlayer = "";
	reservePlayerOne = "";
	reservePlayerTwo = "";
	reservePlayerThree = "";
	reservePlayerCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_twelthnreserveplayers",vparam,"ScoreDB");
	vparam.removeAllElements();
	try{
		if (reservePlayerCrs!=null){
				while (reservePlayerCrs.next()){
					if (reservePlayerCrs.getString("player_status").trim().equalsIgnoreCase("R")){
						reservePlayer = reservePlayer + reservePlayerCrs.getString("reserve_player")+ "~";
					}
					if (reservePlayerCrs.getString("player_status").trim().equalsIgnoreCase("T")){
						twelveman = reservePlayerCrs.getString("reserve_player")!=null?reservePlayerCrs.getString("reserve_player"):"";
					}
				}
				String reservebatsman[] = reservePlayer.split("~");
				for(int count1 = 0; count1 < reservebatsman.length; count1++){
					
				}
				if (reservebatsman !=null){
					if(reservebatsman.length == 3){
						reservePlayerOne 	= reservebatsman[0];
						reservePlayerTwo 	= reservebatsman[1];
						reservePlayerThree  = reservebatsman[2];
					}else if(reservebatsman.length == 2){
						reservePlayerOne 	= reservebatsman[0];
						reservePlayerTwo 	= reservebatsman[1];
					}else if(reservebatsman.length == 1){
						reservePlayerOne 	= reservebatsman[0];
					}
				}
			}
		}catch(Exception e)	{
				 log.writeErrLog(page.getClass(),matchId,e.toString());
		}finally{
			reservePlayerCrs = null;
		}
				
%><%--end 	--%>
	

						<tr>
							<td nowrap colspan="5"><b>Reserves:</b></td>
							<td nowrap align=right><b>Byes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=byes%></font>
							</td>
							<td nowrap colspan="5" align=center><b>Batting Sub Total</b></td>
							<td nowrap align=center><font color="#003399"><%=battingSubTotal%></font></td>
						</tr>
						<tr>
							<td nowrap colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp; <font color="#003399"><%=reservePlayerOne%></font></td>
							<td nowrap align=right ><b>Leg Byes&nbsp;&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=legByes%></font></td>
							<td nowrap colspan="5" align=center><b>Total Extras</b></td>
							<td nowrap align=center><font color="#003399"><%=totalExtras%></font></td>
						</tr>
						<tr>
							<td nowrap colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											 <font color="#003399"><%=reservePlayerTwo%></font></td>
							<td nowrap align=right><b>No Balls&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=noBall%></font></td>
							<td nowrap colspan="5" align=center> <b>Penalty Extras</b></td>
							<td nowrap align=center><font color="#003399"><%=penaltyExtras%></font></td>
						</tr>
						<tr>
							<td nowrap colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp; <font color="#003399"><%=reservePlayerThree%></font></td>
							<td nowrap align=right><b>Wides&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=wide%></font></td>
							<td nowrap colspan="5"><b>TotalFor &nbsp;&nbsp;<font color="#003399"><%=secondInningTotal%></font> &nbsp;&nbsp;<b>Wkts</b>&nbsp;&nbsp;<font color="#003399"><%=matchTotalWkt%> </font>&nbsp;&nbsp;<b>Overs</b>&nbsp;&nbsp;</b></td>
							<td nowrap align=center><font color="#003399"><%=secondInningOvers%></td>
						</tr>
			</table>	
			<br>
			<table align=center  width=100% border=1 height=100% style=border-collapse:collapse>
					<tr>
						<td  align="center" nowrap width=10%>
							<table align=center border=1 width=100%>
											<tr>
												<td colspan="3" align=center><b>Fall of Wickets</td>
											</tr>	
											<tr>
												<td align=center nowrap ><b>Wkt</td>
												<td align=center nowrap ><b>Runs</td>
												<td align=center nowrap ><b>Overs</td>
											</tr>	
<%		vparam.add(inningIdTwo);
		firstBatFallWicketCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
		vparam.removeAllElements();
		crsSize 	  = 0;
		rowGrowLength = 0;
		wktCount 	  = 0;	
		crsSize = firstBatFallWicketCrs.size();
		rowGrowLength = 10 - crsSize;
		if(firstBatFallWicketCrs!=null){
			try{
				while (firstBatFallWicketCrs.next()){
						wkt      = firstBatFallWicketCrs.getString("srno")!=null?firstBatFallWicketCrs.getString("srno"):"";
						wktRuns  = firstBatFallWicketCrs.getString("runs")!=null?firstBatFallWicketCrs.getString("runs"):"";
						wktOvers = firstBatFallWicketCrs.getString("overs")!=null?firstBatFallWicketCrs.getString("overs"):"";
						wktCount = Integer.parseInt(wkt);
%>	

												<tr>
													<td align=center nowrap ><font color="#003399"><%=wkt%></td>
													<td align=right nowrap ><font color="#003399"><%=wktRuns%></td>
													<td align=right nowrap ><font color="#003399"><%=wktOvers%></td>
												</tr>

<%					
				}
			  }catch(Exception e){
			  	log.writeErrLog(page.getClass(),matchId,e.toString());
			  }
		}
%>	


<%		for (k =0 ; k < rowGrowLength ; k++){
			 wktCount++;
%>

												<tr>
													<td align=center nowrap ><font color="#003399"><%=wktCount%></td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
<%
		}
%>		
												<tr>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
													
								</table>						
							</td>
						<td  align="center" nowrap width=45%>
							<table align=center border=1 width=100%>
											<tr>
												<td colspan="4" align="center"><b>Partnerships</td>
											</tr>
											<tr>
												<td align=center nowrap ><b>Batsmen</td>
												<td align=center nowrap ><b>Runs</td>
												<td align=center nowrap ><b>Mins</td>
												<td align=center nowrap ><b>Balls</td>	
											</tr>
<%		vparam.add(inningIdTwo);
		partnershipsCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_partnershipdtls",vparam,"ScoreDB");
		vparam.removeAllElements();
		crsSize = partnershipsCrs.size();
		rowGrowLength = 10 - crsSize;
		if (partnershipsCrs!=null){
			try{
				while (partnershipsCrs.next()){
					batsmanOne = partnershipsCrs.getString("batsman")!=null?partnershipsCrs.getString("batsman"):"";
					totalRuns  = partnershipsCrs.getString("runs")!=null?partnershipsCrs.getString("runs"):"0";
					minute     = partnershipsCrs.getString("mins")!=null?partnershipsCrs.getString("mins"):"0";
					totalballs = partnershipsCrs.getString("balls")!=null?partnershipsCrs.getString("balls"):"0";
												
%>	
								  			 <tr>
												<td nowrap><font color="#003399" ><%=batsmanOne%></td>
												<td align=center nowrap><font color="#003399" ><%=totalRuns%></td>
												<td align=center nowrap><font color="#003399" align=center><%=minute%></td>
												<td align=center nowrap><font color="#003399" ><%=totalballs%></td>
											 </tr>

<%			  }
			}catch(Exception e)	{
				log.writeErrLog(page.getClass(),matchId,e.toString());
			}
		}

%>


<%		for (k =0 ; k<rowGrowLength ; k++){
%>

										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>

<%
		}
%>	
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
											
							</table>	
						</td>
						<td  align="center" nowrap width=45%>
							<table align=center border=1 width=100%>
											<tr>
												<td colspan=7 align=center><b>Bowling Analysis</td>
											</tr>
											<tr>					
												<td align=center nowrap ><b>Bowlers</td>
												<td align=center nowrap ><b>O</td>
												<td align=center nowrap ><b>M</td>
												<td align=center nowrap ><b>R</td>
												<td align=center nowrap ><b>W</td>
												<td align=center nowrap ><b>nb</td>
												<td align=center nowrap ><b>wb</td>
											</tr>
<%	//vparam.add();
	vparam.add(session.getAttribute("matchid"));
	vparam.add("");
	vparam.add(inningIdTwo);
	totalOver		= 0;
	totalMaiden		= 0;
	totalRunrate	= 0;
	totalWkt		= 0;
	totalNB			= 0;
	totalWB			= 0;
	remainingWkt    = 0;
	bowledAnalysisCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowlinganalysisfortestmatch",vparam,"ScoreDB");	
	vparam.removeAllElements();
	crsSize = bowledAnalysisCrs.size();
	rowGrowLength = 10 - crsSize;
	if(bowledAnalysisCrs!=null){
		try{
			while (bowledAnalysisCrs.next()){
//noofover_1           maiden_1    runs_1      wicket_1    noball_1    wideball_1 			
				bowlerName		= bowledAnalysisCrs.getString("bowlername")!=null?bowledAnalysisCrs.getString("bowlername"):"";
				bowlerOver  	= bowledAnalysisCrs.getString("noofover_1")!=null?bowledAnalysisCrs.getString("noofover_1"):"0";
				bowlerMaiden	= bowledAnalysisCrs.getString("maiden_1")!=null?bowledAnalysisCrs.getString("maiden_1"):"0";
				bowlerRunrate	= bowledAnalysisCrs.getString("runs_1")!=null?bowledAnalysisCrs.getString("runs_1"):"0";
				bowlerWicket	= bowledAnalysisCrs.getString("wicket_1")!=null?bowledAnalysisCrs.getString("wicket_1"):"0";
				bowlerNB		= bowledAnalysisCrs.getString("noball_1")!=null?bowledAnalysisCrs.getString("noball_1"):"0";
				bowlerWB		= bowledAnalysisCrs.getString("wideball_1")!=null?bowledAnalysisCrs.getString("wideball_1"):"0";
%>	
												
									<tr>			
											<td nowrap width=40%><font color="#003399"><%=bowlerName%></td>
											<td nowrap width=10% align = right><font color="#003399"><%=bowlerOver%></td>
											<td nowrap width=10% align = right><font color="#003399"><%=bowlerMaiden%></td>
											<td nowrap width=10% align = right><font color="#003399"><%=bowlerRunrate%></td>	
											<td nowrap width=10% align = right><font color="#003399"><%=bowlerWicket%></td>	
											<td nowrap width=10% align = right><font color="#003399"><%=bowlerNB%></td>	
											<td nowrap width=10% align = right><font color="#003399"><%=bowlerWB%></td>	
									</tr>
<%
			totalOver	= totalOver   + Float.parseFloat(bowlerOver);
			totalMaiden	= totalMaiden + Integer.parseInt(bowlerMaiden);
			totalRunrate= totalRunrate+ Integer.parseInt(bowlerRunrate); 
			totalWkt	= totalWkt    + Integer.parseInt(bowlerWicket);
			totalNB		= totalNB     + Integer.parseInt(bowlerNB);
			totalWB		= totalWB     + Integer.parseInt(bowlerWB); 	
			remainingWkt= secondInningSecond - Integer.parseInt(bowlerWicket);			
		 }
	  }catch(Exception e){
	  	log.writeErrLog(page.getClass(),matchId,e.toString());
	  }
	}
										
%>
<%		for (k =0 ; k<rowGrowLength ; k++){
%>
									<tr>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
										<td nowrap width=10%>&nbsp;</td>
									</tr>
<%
		}
%>									
								
									<tr>			
											<td align=center nowrap width=40%><b>SubTotal</td>
											<td align=center nowrap width=10%><font color="#003399"><%=totalOver%></td>
											<td align=center nowrap width=10%><font color="#003399"><%=totalMaiden%></td>
											<td align=center nowrap width=10%><font color="#003399"><%=totalRunrate%></td>	
											<td align=center nowrap width=10%><font color="#003399"><%=totalWkt%></td>	
											<td align=center nowrap width=10%><font color="#003399"><%=totalNB%></td>	
											<td align=center nowrap width=10%><font color="#003399"><%=totalWB%></td>	
									</tr>
									<tr>			
											<td align=center nowrap width=40%><b>Byes/LegByes</td>
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</td>
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</td>
											<td align=center nowrap width=10%><font color="#003399"><%=byesTotal%></td>	
											<td align=center nowrap width=10%><font color="#003399"></td>	
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</td>	
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</td>	
									</tr>
									
<%
	byesPlusTotalrun = 0;
	byesPlusTotalrun = byesTotal + totalRunrate;
	totalSecondInningWkt = remainingWkt + totalWkt;
%>									
									<tr>
											<td align=center nowrap width=40%><b>GrandTotal</td>
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</td>
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</td>
											<td align=center nowrap width=10%><font color="#003399"><%=byesPlusTotalrun%></td>	
											<td align=center nowrap width=10%><font color="#003399"></td>	
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</td>	
											<td align=center nowrap width=10%><font color="#003399">&nbsp;</td>	
									</tr>
			
								</table>
						</td>
					</tr>
			</table>
			
		<table align=center  width=100% height=100% style=border-collapse:collapse>
				<tr>
					<td nowrap colspan="3" align=center><b>Reason for penalty Runs if any:</td>
					<td><font color="#003399" align=center><%=penaltyReason%></font></td>
				</tr>
				<tr>
								<td colspan=6 align=center>
										<table border=1 width=100% >
<%
	vparam.add(inningIdTwo);
	penaltyReasonCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_penaltyreason",vparam,"ScoreDB");
	vparam.removeAllElements();	
	if(penaltyReasonCrs!=null){
		 try{
			while(penaltyReasonCrs.next()){
					penaltyDescription = penaltyReasonCrs.getString("description")!=null?penaltyReasonCrs.getString("description"):"";
%>							
											<tr>
												<td nowrap><font color="#003399"><%=penaltyDescription%></font></td>
											</tr>
<%
		    }
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
    }	  		
%>									
									</table>								
								</td>
						 </tr>
			</table>
		 	<br>
			<!-- code for scoring rate ,individual batsman run,partnership start here --> 
				<table align=center  width=100% border=1 height=100% style=border-collapse:collapse>
					<tr>
						<td align="center" nowrap>
							<table width=100% border=1>
									<tr>
										<td colspan=3 nowrap align=center><b>Scoring Rate</b></td>
									</tr>
									<tr>
										<td nowrap align=center><b>Runs</b></td>
										<td nowrap align=center><b>Overs</b></td>
										<td nowrap align=center><b>Mins</b></td>
									</tr>
									
<%	vparam.add(inningIdTwo);
	firstBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamscoredetails_for_testmatch",vparam,"ScoreDB");
	vparam.removeAllElements();
	runSize = 0;
	crsSize = firstBatsCrs.size();
	rowGrowLength = 10 - crsSize;
	if (firstBatsCrs!=null) {
	  try{
		 while (firstBatsCrs.next()){
		 	if (firstBatsCrs.getString("run_range")!=null){
		 			firstInningScoringRunrange	= firstBatsCrs.getString("run_range")!=null?firstBatsCrs.getString("run_range"):"";
					firstInningScoringMin		= firstBatsCrs.getString("minutes")!=null?firstBatsCrs.getString("minutes"):"";
					firstInningScoringOvers		= firstBatsCrs.getString("overs")!=null?firstBatsCrs.getString("overs"):"";
					runSize 					= Integer.parseInt(firstInningScoringRunrange);
					//runSize = Integer.parseInt(secondTeamScoreMins);
%>
									<tr>
										<td nowrap align=right><font color="#003399"><%=firstInningScoringRunrange%></td>
										<td nowrap align=right><font color="#003399"><%=firstInningScoringOvers%></td>
										<td nowrap align=right><font color="#003399"><%=firstInningScoringMin%></td>
									</tr>	
<%			}
		}
	}catch(Exception e)	{
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
  }	
%>	
<%
	for (k=0 ; k <rowGrowLength ; k++ ){
	runSize = runSize + 50;
%>
									<tr>
										<td nowrap align=right><font color="#003399"><%=runSize%></td>
										<td nowrap align=right>&nbsp;</td>
										<td nowrap align=right>&nbsp;</td>
									</tr>	
<%
	}
%>							</table>
						</td>	
						<td align="center" nowrap>
							<table width=100% border=1>
						<tr>
							<td align=center nowrap><font size=1><b>INDIVIDUAL SCORES</b></font></b></td>
							<td align=center nowrap colspan=4><font size=1><b>For 50</b></font></td>
							<td align=center nowrap colspan=4><font size=1><b>For 100</b></font></td>
						</tr>
						<tr>
							<td align=center nowrap><font size=1><b>Batsman</b></font></td>
							<td nowrap align=center><font size=1><b>Min's</b></font></td>
							<td nowrap align=center><font size=1><b>4's</b></font></td>
							<td nowrap align=center><font size=1><b>6's</b></font></td>
							<td nowrap align=center><font size=1><b>Balls</b></font></td>
							<td nowrap align=center><font size=1><b>Min's</b></font></td>
							<td nowrap align=center><font size=1><b>4's</b></font></td>
							<td nowrap align=center><font size=1><b>6's</b></font></td>
							<td nowrap align=center><font size=1><b>Balls</b></font></td>
						</tr> 
			<%  vparam.add(inningIdTwo);
				//vparam.add(inningIdTwo);
				firstBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_individualscores_for_testmatch",vparam,"ScoreDB");
				vparam.removeAllElements();
				try{
					if (firstBatsCrs!=null ) {
					 	 while (firstBatsCrs.next()){
			%>									<tr>
													<td align=left nowrap><font color="#003399" size=1><%=firstBatsCrs.getString("batsman")!=null?firstBatsCrs.getString("batsman"):""%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("fifty_Min")!=null?firstBatsCrs.getString("fifty_Min"):"0"%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("fifty_four")!=null?firstBatsCrs.getString("fifty_four"):"0"%></font></td>	
													<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("fifty_six")!=null?firstBatsCrs.getString("fifty_six"):"0"%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("fifty_ball")!=null?firstBatsCrs.getString("fifty_ball"):"0"%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("hundred_Min")!=null?firstBatsCrs.getString("hundred_Min"):""%></font></td>
			<%	if(!firstBatsCrs.getString("hundred_Min").equals("0")){
			%>
													<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(firstBatsCrs.getString("hundred_four")!=null?firstBatsCrs.getString("hundred_four"):"0")+Integer.parseInt(firstBatsCrs.getString("fifty_four")!=null?firstBatsCrs.getString("fifty_four"):"0")%></font></td>
													<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(firstBatsCrs.getString("hundred_six")!=null?firstBatsCrs.getString("hundred_six"):"0") + Integer.parseInt(firstBatsCrs.getString("fifty_six")!=null?firstBatsCrs.getString("fifty_six"):"0")%></font></td>
			<%}else{
			%>	
													<td align=right><font color="#003399" size=1>0</font></td>		
													<td align=right><font color="#003399" size=1>0</font></td>
			<%}
			%>										<td nowrap align=right><font color="#003399" size=1><%=firstBatsCrs.getString("hundred_ball")!=null?firstBatsCrs.getString("hundred_ball"):"0"%></font></td>
											</tr>			
			<%		 	 }
					}
				}catch(Exception e)	{
					log.writeErrLog(page.getClass(),matchId,e.toString());
				} 	 
			%>	 	 
										</table>
						</td>
					</tr>
			  </table>
				 <table border=1 width=100% align=center style=border-collapse:collapse>
					<tr >
							<td nowrap align=center width=20%><b>From</td>
							<td nowrap align=center width=20%><b>To</td>
							<td nowrap align=center width=20%><b>Hour/Min</td>
							<td nowrap align=center width=20%><b>ol</td>
							<td nowrap align=center width=20%><b>Stoppage/reason</td>
					</tr>
<%        vparam.add(inningIdTwo);
           officialScoresheetCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_stoppages", vparam, "ScoreDB");
           vparam.removeAllElements();
            try {
                if (officialScoresheetCrs != null) {
                while (officialScoresheetCrs.next()) {
 %>
                    <tr>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("start_ts")	!=null?officialScoresheetCrs.getString("start_ts").substring(0,16):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("end_ts")	!=null?officialScoresheetCrs.getString("end_ts").substring(0,16):""%></font></td>
                        <td align=center><font color="#003399" size=1><%= officialScoresheetCrs.getString("hour")	!=null?officialScoresheetCrs.getString("hour"):""%>/<%=officialScoresheetCrs.getString("min")!=null?officialScoresheetCrs.getString("min"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("overlost")	!=null?officialScoresheetCrs.getString("overlost"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("interval")	!=null?officialScoresheetCrs.getString("interval"):""%></font></td>
                    </tr>
<%				}
			}
		}catch (Exception e) {
               // log.writeErrLog(page.getClass(), matchId, e.toString());
        }
%>			</table>		
		  </td>	
			<td align=center>
					<table border="1" width=100% height=100% style=border-collapse:collapse>
						<tr> 
							<td colspan="4" align="center"><b>Run Rate</td>
						</tr>
						<tr>	
							<td align=center nowrap width=25%><b>Ov</td>
							<td align=center nowrap width=25%><b>Runs</td>
							<td align=center nowrap width=25%><b>W</td>
							<td align=center nowrap width=25%><b>Runrate </td>
						</tr>
						
<%	vparam.add(inningIdTwo);
	overRunrateCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_runratedtls",vparam,"ScoreDB");
	vparam.removeAllElements();
	crsSize = overRunrateCrs.size();
	rowGrowLength = 50 - crsSize;
	rowLength = rowGrowLength;
	if(overRunrateCrs!=null){
		try{
			while (overRunrateCrs.next()){  
				overs   = overRunrateCrs.getString("overs")!=null?overRunrateCrs.getString("overs"):"0";
				run	    = overRunrateCrs.getString("runs")!=null?overRunrateCrs.getString("runs"):"0";	
				wicket  = overRunrateCrs.getString("wicket")!=null?overRunrateCrs.getString("wicket"):"0";
				runRate = overRunrateCrs.getString("runrate")!=null?overRunrateCrs.getString("runrate"):"0";
%>	
							<tr>
								<td nowrap width=25% align=right><font color="#003399"><%=overs%></td>
								<td nowrap width=25% align=right><font color="#003399"><%=run%></td>
								<td nowrap width=25% align=right><font color="#003399"><%=wicket%></td>
								<td nowrap width=25% align=right><font color="#003399"><%=runRate%></td>
							</tr>
<%						
			}
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}
%>		
<%
	for (k=0 ; k < rowGrowLength ; k++){
		crsSize++;
%>
							<tr> 
								<td nowrap width=25% align=right><font color="#003399"><%=crsSize%></font></td>
								<td nowrap width=25%>&nbsp;</td>
								<td nowrap width=25%>&nbsp;</td>
								<td nowrap width=25%>&nbsp;</td>
							</tr>
<%
		
	}
%>
					</table>	
				</td>
			</tr>
		</table>
		<table border=1 width=90% style=border-collapse:collapse>
				<tr>
					<td nowrap width=2% align="center"><font size=2><b>ASSOCIATION</font>
					<td nowrap width=2% align="center"><font size=2><b>RUNS SCORED</td></font>
					<td nowrap width=2% align="center"><font size=2><b>OVERS PLAYED</td></font>
					<td nowrap width=2% align="center"><font size=2><b>TIME TAKEN</td></font>
					<td nowrap width=2% align="center"><font size=2><b>OVERS SHORT BY OPPN</td></font>
					<td nowrap width=2% align="center"><font size=2><b>POINTS</td></font>
					<td nowrap width=2% align="center"><font size=2><b>REMARKS</td></font>
				</tr>
<%	vparam.add(matchId);
    officialScoresheetCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_referee_match_report", vparam, "ScoreDB");
    vparam.removeAllElements();
	try{
    	if (officialScoresheetCrs!=null){
				while(officialScoresheetCrs.next()){
					totalMatchTime	= officialScoresheetCrs.getString("totalmatchtime") != null ?       officialScoresheetCrs.getString("totalmatchtime") : "" ;
					inningId = officialScoresheetCrs.getString("innings_Id") != null ?       officialScoresheetCrs.getString("innings_Id") : "" ;
%>		<tr>
			<td align=left><font color="#003399"><%=officialScoresheetCrs.getString("nameofasscn") != null ? officialScoresheetCrs.getString("nameofasscn") : ""%></font></td>
        	<td align=right><font color="#003399"><%=officialScoresheetCrs.getString("runsscored") != null ? officialScoresheetCrs.getString("runsscored") : ""%>/<%=officialScoresheetCrs.getString("noofwkt") != null ? officialScoresheetCrs.getString("noofwkt") : ""%></font></td>
        	<td align=right><font color="#003399"><%=officialScoresheetCrs.getString("overbowled") != null ? officialScoresheetCrs.getString("overbowled") : ""%></font></td>
         	<td align=right><font color="#003399"><a href="javascript:showMatchTimeDetail('<%=inningId%>')"><%=totalMatchTime%></a></font></td>
        	<td align=right><font color="#003399"><%=officialScoresheetCrs.getString("overbowledshort") != null ? officialScoresheetCrs.getString("overbowledshort") : ""%>&nbsp;</font></td>
			<td align=right><font color="#003399"><%=officialScoresheetCrs.getString("matchpoint") != null ? officialScoresheetCrs.getString("matchpoint") : ""%>&nbsp;</font></td>
			<td align=left>&nbsp;</td>
        </tr>	

		
<%     
			}
		}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>
<%	
	int difference = 0 ;
	float maxOver  = 0;	
	vparam.add("");
	//vparam.add();
	vparam.add(session.getAttribute("matchid"));
	overShortCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchtype",vparam,"ScoreDB");
	vparam.removeAllElements();
	if(overShortCrs!=null){
		try{
			while (overShortCrs.next()){  
				overMax  			  = overShortCrs.getString("overs_max")!=null?overShortCrs.getString("overs_max"):"0";
				matchType			  = overShortCrs.getString("name")!=null?overShortCrs.getString("name"):"";	
				firstInningShortOver  = Float.parseFloat(overMax) - firstInningTotalOver;
				secondInningShortOver = Float.parseFloat(overMax) - secondInningTotalOver;
			}
	 	}catch(Exception e){
	 			log.writeErrLog(page.getClass(),matchId,e.toString());
	 	}
	}	
%>		
			</table>
			<table  align=center width="90%" border=1 style=border-collapse:collapse>
				<tr >
					<td nowrap width=15%><b>Umpire&nbsp;(1)</td>
					<td nowrap width=20%><font color="#003399"><%=umpireOne%></td>
					<td nowrap width=15%  align=center><b>Sign</td>
					<td nowrap width=15%></td>
					<td nowrap width=15% align=center><b>ContactNo</td>
					<td nowrap width=20% align=center><%=umpireOneContact%></td>
				</tr>
				<tr>
					<td nowrap width=15%><b>Umpire&nbsp;(2)</td>
					<td nowrap width=20%><font color="#003399"><%=umpireTwo%></td>
					<td nowrap width=15% align=center><b>Sign</td>
					<td nowrap width=15%>&nbsp;</td>
					<td nowrap width=15% align=center><b>ContactNo</td>
					<td nowrap width=20% align=center><%=umpireTwoContact%></td>
				</tr>
				<tr>
					<td nowrap width=15%><b>Match Referee&nbsp;(1)</td>
					<td nowrap width=20%><font color="#003399"><%=matchReferee%></td>
					<td nowrap width=15% align=center><b>Sign</td>
					<td nowrap width=15% align=center></td>
					<td nowrap width=15% align=center><b>ContactNo</td>
					<td nowrap width=20% align=center><%=matchRefereeContact%></td>
				</tr>
				<tr>
					<td nowrap width=15%><b>Scorer&nbsp;(1)</td>
					<td nowrap width=20%><font color="#003399"><%=scorerOne%></td>
					<td nowrap width=15% align=center><b>Sign</td>
					<td nowrap width=15% align=center>&nbsp;</td>
					<td nowrap width=15% align=center><b>ContactNo</td>
					<td nowrap width=15% align=center><%=matchRefereeContact%></td>
				</tr>
				<tr>
					<td nowrap width=15%><b>Scorer&nbsp;(2)</td>
					<td nowrap width=20%><font color="#003399"><%=scorerTwo%></td>
					<td nowrap width=15% align=center><b>Sign</td>
					<td nowrap width=15%>&nbsp;</td>
					<td nowrap width=15% align=center><b>ContactNo</td>
					<td nowrap width=15% align=center><%=matchRefereeContact%></td>
				</tr>
			</table>


		
		
			<center><b>Remark</b></td>
			<table width=90% border=1>
<%
vparam.add(inningIdOne);
vparam.add(inningIdTwo);
vparam.add(inningIdThree);
vparam.add(inningIdFour);
officialScoresheetCrs	= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_remarks",vparam,"ScoreDB");
vparam.removeAllElements();
	try{
		if(officialScoresheetCrs!=null){
			while (officialScoresheetCrs.next()){
				remarks       = officialScoresheetCrs.getString("description")!=null?officialScoresheetCrs.getString("description"):"";
				if (!(officialScoresheetCrs.getString("description").equalsIgnoreCase("default"))){
					if (!(remarks.equals(""))){
%>
					<tr>
						<td align=left><font color="#003399"><%=remarks%></font></td>
					</tr>
<%
					}		
				}
			}
		}	
	}catch(Exception e){
	}
%>
			
	</body>
	<script>
			function showPlayerTimeDetail(batsmanId,inningId)
			{
				//alert("batsmanId" +batsmanId);
				//alert("inningId" +inningId);
				var flag = 2;
				window.open("/cims/jsp/MatchTimeDetail.jsp?batsManId="+batsmanId + "&inningId="+inningId + "&flag="+flag, "MatchInningTimeDetails","location=no,directories=no,status=no,men//ubar=no,scrollbars=Yes,resizable=Yes,top=100,left=100,width=800,height=450");	
			}

			
			// To show Match innings time details
			function showMatchTimeDetail(inningId)
			{
				var flag=1;
				window.open("/cims/jsp/MatchTimeDetail.jsp?inningId="+inningId + "&flag="+flag, "MatchInningTimeDetails","location=no,directories=no,status=no,men//ubar=no,scrollbars=Yes,resizable=Yes,top=100,left=100,width=800,height=450");	
			}
	</script>
</html>


