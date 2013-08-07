<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"
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
	CachedRowSet  secondInningDurationCrs  	= null;
	CachedRowSet  individualBatsmanScoreCrs	= null;
	CachedRowSet  inningIdCrs				= null;		
	CachedRowSet  overShortCrs				= null;
	CachedRowSet  penaltyReasonCrs			= null;
	
	Vector vparam = new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	String timeIn 				 = "";
	String timeOut 				 = "";
	String srNo 				 = "";
	String batsman				 = "";
	String howout				 = "";     
	String fielder				 = "";   
	String bowler				 = "";      
	String mins					 = "";      
	String four 				 = "";   
	String six 					 = ""; 
	String balls 				 = "";      
	String runs 				 = "";       
	String byes 				 = "";      
	String legByes 				 = "";      
	String noBall 				 = "";                                
	String wide 				 = "";   
	String matchNo 				 = "";
	String zone 				 = "";
	String teamOne 				 = "";
	String teamTwo 				 = "";
	String toss 				 = "";
	String ground				 = "";
	String city 				 = "";
	String date 				 = "";
	String result				 = "";
	String wonByWkt 			 = "";
	String wonByRrun 			 = "";
	String umpireOne			 = "";
	String umpireTwo 			 = "";
	String umpireThree			 = "";
	String umpireFour 			 = "";
	String matchReferee 		 = "";
	String scorerOne			 = "";
	String scorerTwo			 = "";
	String captainOne			 = "";
	String captainTwo 			 = "";
	String matchTotalRun		 = "";
	String matchTotalWkt		 = "";
	String matchTotalOver		 = "";
	String wkt  				 = "";
	String wktRuns 				 = "";
	String wktOvers 			 = "";		
	String wicketKeeperOne		 = "";
	String wicketKeeperTwo		 = "";
	String overs 				 = "";
	String run  				 = "";
	String wicket 				 = "";
	String battingSubTotal		 = "";   
	String totalExtras 			 = ""; 
	String penaltyExtras 		 = "";
	String tournamentName 		 = "";
	String runRate				 = "";
	String reserveplayer		 = "";
	String reservePlayerOne		 = "";
	String reservePlayerTwo		 = "";
	String reservePlayerThree	 = "";
	String bowlerName 			 = "";
	String bowlerOver			 = "";
	String bowlerMaiden			 = "";
	String bowlerRunrate		 = "";
	String bowlerWicket			 = "";
	String bowlerNB 			 = "";
	String bowlerWB				 = "";
	String batsmanOne 			 = "";
	String batsmanTwo			 = "";
	String totalRuns 			 = "";
	String minute  				 = "";
	String totalballs			 = "";
	String batsmanMin			 = "";
	String batsmanScore			 = "";
	String batsmanBall			 = "";
	String batsmanfour			 = "";
	String batsmansix			 = "";  
	String fromTime				 = "";
	String toTime				 = "";
	String totalMin				 = "";
	String ol					 = "";
	String reason				 = "";
	String teamBattingFirst 	 = "";
	String StartTimeBattingFirst = "";
	String endTimeBattingFirst	 = "";
	String durationBattingFirst  = "";      
	String minsBattingFirst      = ""; 
	String teamBattingSecond 	 = "";
	String StartTimeBattingSecond= "";
	String endTimeBattingSecond  = "";
	String durationBattingSecond = "";      
	String minsBattingSecond	 = "";
	String summeryOvers	 		 = "";
	String summeryRun 	 		 = "";
	String summeryWicket 		 = "";
	String summeryRunRate		 = "";
	String summeryShortOver		 = "";
	String summeryPoint			 = "";
	String summeryOver 			 = "";
	String scoringRateRun		 = "";
	String scoringRateBall		 = "";
	String scoringRateMins		 = "";
	String inningsId			 = "";
	String inningIdOne			 = "";
	String inningIdTwo			 = "";
	String umpireOneAsscn		 = "";
	String umpireTwoAsscn		 = "";
	String umpireThreeAsscn		 = "";
	String umpireFourAsscn		 = "";
	String matchRefassn			 = "";
	String battingTeam			 = "";
	String startTime			 = "";
	String endTime				 = "";
	String duration				 = "";
	String matchWinner			 = "";
	String firstInningTotal		 = "";
	String secondInningTotal	 = "";
	String firstInningOvers		 = "";
	String secondInningOvers	 = "";
	String penaltyReason		 = "";
	String matchType			 = "";
	String overMax				 = "";	
	String umpireOneContact		 = "";
	String umpireTwoContact		 = "";
	String umpireThreeContact	 = "";
	String umpireFourContact	 = "";
	String matchRefereeContact	 = "";
	String penaltyDescription	 = "";
	int targetScore				 = 1;
	int revisedTargetScore		 = 1;
	int subTotal				 = 0;
	int tExtras					 = 0;
	int grandTotal				 = 0;			
	int totalScoreTeamOne		 = 0;
	int totalScoreTeamTwo		 = 0;
	int totalWktTeamTwo			 = 0;
	int wonResult				 = 0;
	int crsSize					 = 0;
	int rowGrowLength			 = 0;
	int k						 = 0;
	float totalOver				 = 0;	
	int totalMaiden				 = 0;
	int totalRunrate			 = 0;
	int totalWkt				 = 0;
	int totalNB					 = 0;
	int totalWB					 = 0;
	int rowLength				 = 0; 
	float firstInningTotalOver	 = 0;
	float secondInningTotalOver	 = 0;
	float firstInningShortOver	 = 0;
	float secondInningShortOver	 = 0;
%>

<%
	vparam.add(session.getAttribute("matchid"));
	inningIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getinningsid",vparam,"ScoreDB");
	vparam.removeAllElements();
	if (inningIdCrs != null){
		try{
			while (inningIdCrs.next()){
				inningsId = inningsId + inningIdCrs.getString("id") + "~";
			}
			String splitInningsId[] = inningsId.split("~");
			for(int i = 0 ; i < splitInningsId.length ;i++){
					inningIdOne = splitInningsId[0];
					inningIdTwo	= splitInningsId[1];	
			}
		 }catch(Exception e){
		 			System.out.println("Exception : "+ e.getMessage());
		 }
	}
%>

<% 
	vparam.add(inningIdOne);
	officialScoresheetCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialscoresheet",vparam,"ScoreDB");
	vparam.removeAllElements();
	if(officialScoresheetCrs!=null){
		try{
			while (officialScoresheetCrs.next()){
				matchNo 			 = officialScoresheetCrs.getString("match_no")!=null?officialScoresheetCrs.getString("match_no"):"";
				tournamentName       = officialScoresheetCrs.getString("tournament")!=null?officialScoresheetCrs.getString("tournament"):"";
				zone				 = officialScoresheetCrs.getString("zone")!=null?officialScoresheetCrs.getString("zone"):"";
				teamOne				 = officialScoresheetCrs.getString("team1")!=null?officialScoresheetCrs.getString("team1"):"";
				teamTwo				 = officialScoresheetCrs.getString("team2")!=null?officialScoresheetCrs.getString("team2"):"";
				toss				 = officialScoresheetCrs.getString("tosswinner")!=null?officialScoresheetCrs.getString("tosswinner"):"";
				ground				 = officialScoresheetCrs.getString("ground")!=null?officialScoresheetCrs.getString("ground"):"";
				city				 = officialScoresheetCrs.getString("city")!=null?officialScoresheetCrs.getString("city"):"";
				date				 = officialScoresheetCrs.getString("date")!=null?officialScoresheetCrs.getString("date"):"";
				umpireOne			 = officialScoresheetCrs.getString("umpire1")!=null?officialScoresheetCrs.getString("umpire1"):"";
				umpireTwo			 = officialScoresheetCrs.getString("umpire2")!=null?officialScoresheetCrs.getString("umpire2"):"";
				umpireThree			 = officialScoresheetCrs.getString("umpire3")!=null?officialScoresheetCrs.getString("umpire3"):"";
				umpireFour			 = officialScoresheetCrs.getString("umpire4")!=null?officialScoresheetCrs.getString("umpire4"):"";
				matchReferee		 = officialScoresheetCrs.getString("matchref")!=null?officialScoresheetCrs.getString("matchref"):"";
				scorerOne			 = officialScoresheetCrs.getString("scorer1")!=null?officialScoresheetCrs.getString("scorer1"):"";
				scorerTwo			 = officialScoresheetCrs.getString("scorer2")!=null?officialScoresheetCrs.getString("scorer1"):"";
				captainOne			 = officialScoresheetCrs.getString("captain1")!=null?officialScoresheetCrs.getString("captain1"):"";
				captainTwo			 = officialScoresheetCrs.getString("captain2")!=null?officialScoresheetCrs.getString("captain2"):"";
				wicketKeeperOne		 = officialScoresheetCrs.getString("wkeeper1")!=null?officialScoresheetCrs.getString("wkeeper1"):"";
				wicketKeeperTwo		 = officialScoresheetCrs.getString("wkeeper2")!=null?officialScoresheetCrs.getString("wkeeper2"):"";	
			    umpireOneAsscn		 = officialScoresheetCrs.getString("umpire1assn")!=null?officialScoresheetCrs.getString("umpire1assn"):"";	
				umpireTwoAsscn		 = officialScoresheetCrs.getString("umpire2assn")!=null?officialScoresheetCrs.getString("umpire2assn"):"";
			    umpireThreeAsscn	 = officialScoresheetCrs.getString("umpire3assn")!=null?officialScoresheetCrs.getString("umpire3assn"):"";
            	umpireFourAsscn		 = officialScoresheetCrs.getString("umpire4assn")!=null?officialScoresheetCrs.getString("umpire4assn"):"";
				matchRefassn		 = officialScoresheetCrs.getString("matchrefassn")!=null?officialScoresheetCrs.getString("matchrefassn"):"";
				teamBattingFirst	 = officialScoresheetCrs.getString("battingteam")!=null?officialScoresheetCrs.getString("battingteam"):"";
				StartTimeBattingFirst= officialScoresheetCrs.getString("startts")!=null?officialScoresheetCrs.getString("startts"):"";
				endTimeBattingFirst	 = officialScoresheetCrs.getString("endts")!=null?officialScoresheetCrs.getString("endts"):"";
				durationBattingFirst = officialScoresheetCrs.getString("duration")!=null?officialScoresheetCrs.getString("duration"):"";
				umpireOneContact     = officialScoresheetCrs.getString("umpire1contact")!=null?officialScoresheetCrs.getString("umpire1contact"):""; 
				umpireTwoContact     = officialScoresheetCrs.getString("umpire2contact")!=null?officialScoresheetCrs.getString("umpire2contact"):"";
				umpireThreeContact   = officialScoresheetCrs.getString("umpire3contact")!=null?officialScoresheetCrs.getString("umpire3contact"):"";
				umpireFourContact    = officialScoresheetCrs.getString("umpire4contact")!=null?officialScoresheetCrs.getString("umpire4contact"):"";
				matchRefereeContact  = officialScoresheetCrs.getString("matchrefcontact")!=null?officialScoresheetCrs.getString("matchrefcontact"):"";
			}
		}catch(Exception e){
				System.out.println("Exception : "+ e.getMessage());
		}
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
					System.out.println("Exception : "+ e.getMessage());
				}
			}	
%>
<%	vparam.add(inningIdTwo);
	secondBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total",vparam,"ScoreDB");
	vparam.removeAllElements();
			if (secondBatsCrs!=null){
				try{
					while (secondBatsCrs.next()){
						secondInningTotal = secondBatsCrs.getString("total_score")!=null? secondBatsCrs.getString("total_score"):"";
						totalScoreTeamTwo = totalScoreTeamTwo + Integer.parseInt(secondInningTotal);
						totalWktTeamTwo	  =	Integer.parseInt(secondBatsCrs.getString("wicket"));
						System.out.println("totalWktTeamTwo" +totalWktTeamTwo);
					}
				}catch(Exception e){
					System.out.println("Exception : "+ e.getMessage());
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
</head>
		
		<table width=100% border=1>
			<table align=center width=100%>
				<tr>
					<td align=center><b><font color="#003399" size=3>Official ScoreSheet For Limited Overs Match</b></td>
				</tr>
			</table>
			
			<table width=100% align=center border="1" style=border-collapse:collapse>
						<tr class=firstrow>
							<td align=center nowrap width="15%"><b>Tournament</td>
							<td align=center nowrap width="15%"><font color="#003399"><%=tournamentName%></td>
							<td align=center nowrap width="15%"><b>Match No</td>
							<td align=center nowrap width="15%"><font color="#003399"><%=matchNo%></td>
							<td align=center nowrap width="15%"><font color="#003399"><%=zone%></td>
							<td align=center nowrap width="15%"><b>Zone</td>
							<td align=center nowrap width="15%">&nbsp;</td>
						</tr>
						<tr class=firstrow>
							<td align=center nowrap width="15%"><b>Match between</td>
							<td align=center nowrap width="15%"><font color="#003399"><%=teamOne%></td>
							<td align=center nowrap width="15%"><b>and</td>
							<td align=center nowrap width="15%"><font color="#003399"><%=teamTwo%></td>
							<td align=center nowrap width="15%"><b>Toss</td>
							<td align=center nowrap width="15%"><font color="#003399"><%=toss%></td>
							<td align=center nowrap width="15%">&nbsp;</td>
						</tr>
						<tr class=firstrow>
							<td align=center nowrap width="15%"><b>Played at(Ground)</td>
							<td align=center nowrap width="15%"><font color="#003399"><%=ground%></td>
							<td align=center nowrap width="15%"><b>City</td><td align=center><font color="#003399"><%=city%></td>
							<td align=center nowrap width="15%">&nbsp;</td>
							<td align=center nowrap width="15%">&nbsp;</td>
							<td align=center nowrap width="15%">&nbsp;</td>
						</tr>
						<tr class=firstrow>
							<td align=center nowrap width="15%"><b>Date</td>
							<td align=center nowrap width="15%"><font color="#003399"><%=date%></td>
							<td align=center nowrap width="15%"><b>Result</td>
<%	 if ( totalScoreTeamTwo == (totalScoreTeamOne-1)){
%>
							<td align=center nowrap width="15%"><font color="#003399">Tie</td>
<%
	}else if ( totalScoreTeamTwo < totalScoreTeamOne){	
%>			
							<td align=center nowrap width="15%"><font color="#003399"><%=teamOne%></td>
<%
	}else if ( totalScoreTeamTwo > totalScoreTeamOne){	
%>
							<td align=center nowrap width="15%"><font color="#003399"><%=teamTwo%></td>
<%
	}else{
%>
<%
	}
%>
							
<%	 if ( totalScoreTeamTwo == (totalScoreTeamOne-1)){
%>
							<td align=center nowrap width="15%"><font color="#003399"></td>
<%	}else if ( totalScoreTeamTwo < totalScoreTeamOne){
			wonResult = totalScoreTeamOne - totalScoreTeamTwo;
			wonResult = wonResult - 1;
%>
							<td align=center nowrap width="15%"><b>Won by</td>
							<td align=center nowrap width="15%"><font color="#003399"><%=wonResult%></td>
							<td align=center nowrap width="15%"><b>runs</td>
<%
	}else if ( totalScoreTeamTwo > totalScoreTeamOne){
			totalWktTeamTwo = 10 - totalWktTeamTwo;
%>
							<td align=center nowrap width="15%"><b>Won by</td>
							<td align=center nowrap width="15%"><font color="#003399"><%=totalWktTeamTwo%></td>
							<td align=center nowrap width="15%"><b>wkts</td>
<%
	}
%>
					</tr>	
					<tr>
						<td colspan=7>&nbsp;</td>
					</tr>
					<tr >
						<td colspan=8 ><b>If the result achieved by Duckworth & Lewis method, write the the sequence of revised target / overs:</td>
					</tr>
					<tr>
						<td colspan=8 ></td>
					</tr>
			</table>
			
			<table  width=100% align=center border=1 style=border-collapse:collapse>
						<tr class=firstrow>
							<td nowrap width=25% align=center><b>Umpires: (1)</td>
							<td nowrap width=25% ><font color="#003399"><%=umpireOne%> </font>&nbsp; /&nbsp;<font color="#003399"><%=umpireOneAsscn%></font></td>
							<td nowrap width=25%  align=center>(<b>2)</td>
							<td nowrap width=25% ><font color="#003399"><%=umpireTwo%></font>&nbsp; /&nbsp;<font color="#003399"><%=umpireTwoAsscn%></font></td>
						</tr>
						<tr class=firstrow>
							<td nowrap width=25%  align=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;
							<b>&nbsp;&nbsp;&nbsp;(3)</td>
							<td nowrap width=25% ><font color="#003399"><%=umpireThree%></font>&nbsp; /&nbsp;<font color="#003399"><%=umpireThreeAsscn%></font></td>
							<td nowrap width=25%  align=center><b>(4)</td>
							<td nowrap width=25%> <font color="#003399"><%=umpireFour%></font>&nbsp; /&nbsp;<font color="#003399"><%=umpireFourAsscn%></font></td>
						</tr>
						<tr class=firstrow>
							<td colspan=4 >&nbsp;</td>
						</tr>
						<tr class=firstrow>	
							<td nowrap width=25%  align=center><b>Match Referee</td>
							<td nowrap width=25% ><font color="#003399"><%=matchReferee%></td>
							<td nowrap width=25%  align=center><b>Scorer</td>
							<td nowrap width=25% ><font color="#003399"><%=scorerOne%></td>
						</tr>
						<tr class=firstrow>
							<td width=20% align=center><b>Captains: (1)</td>
							<td nowrap width=25% ><font color="#003399"><%=captainOne%></td>
							<td width=20% align=center><b>(2)</td>
							<td nowrap width=25% ><font color="#003399"><%=captainTwo%></td>
						</tr>
						<tr class=firstrow>
							<td width=20% align=center><b>Wicket Keepers: (1)</td>
							<td nowrap width=25% > <font color="#003399"><%=wicketKeeperOne%></td>
							<td width=20% align=center><b>(2)</td>
							<td nowrap width=25% ><font color="#003399"><%=wicketKeeperTwo%></td>
						</tr>
			</table>
			<br>
			<table align="center" border=1 width=100% style=border-collapse:collapse>	
					<tr class=firstrow>
						<td nowrap width=10% align="center"> <b>Team Batting First</td>
						<td nowrap width=10% align="center"><font color="#003399"><%=teamBattingFirst%></td>
						<td nowrap width=15% align="center"><b>Start :</td>
						<td nowrap width=10% align="center"><font color="#003399"><%=StartTimeBattingFirst%></td>
						<td nowrap width=10% align="center"><b>Close :</td>
						<td nowrap width=15% align="center"><font color="#003399"><%=endTimeBattingFirst%></td>
						<td nowrap width=10% align="center"><b>Duration</td>
						<td nowrap width=10% align="center"><font color="#003399"><%=durationBattingFirst%></td>
						<td nowrap width=10% align="center"><b>Mins</td>
					</tr>
			</table>
			<br>
		<!-- first Div-->
			<div style="height:100%;width:100%;">
			<table align=center border=1 width=100% style=border-collapse:collapse>
		<!-- first <TR> start here -->		
				<tr>
		<!-- first <TD> start here -->			
					<td align=center>
		<!--code for first inning batting summery start here-->
						<table align=center border=1 width=100% height=100% style=border-collapse:collapse>
							 <tr class=firstrow>
								<td align=center nowrap width=5%><b>Time<br>In</td>
								<td align=center nowrap width=5%><b>Time<br>Out</td>
								<td align=center nowrap width=5%><b>NO.</td>
								<td align=center nowrap width=20%><b>Batsman</td>
								<td align=center nowrap width=20%><b>How<br>Out</td>
								<td align=center nowrap width=15%><b>Fielder</td>
								<td align=center nowrap width=15%><b>Bowler</td>
								<td align=center nowrap width=5%><b>Mins</td>
								<td align=center nowrap width=5%><b>4</td>
								<td align=center nowrap width=5%><b>6</td>
								<td align=center nowrap width=5%><b>Balls</td>
								<td align=center nowrap width=5%><b>Runs</td>
							</tr>	

<%	vparam.add(inningIdOne);
	firstBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingscorercard",vparam,"ScoreDB");
	vparam.removeAllElements();
	if(firstBatsCrs!=null){
		try{		
			while (firstBatsCrs.next()){
				 timeIn		= firstBatsCrs.getString("timein")!=null?firstBatsCrs.getString("timein"):"";
				 timeOut 	= firstBatsCrs.getString("timeout")!=null?firstBatsCrs.getString("timeout"):"";
				 srNo		= firstBatsCrs.getString("srno")!=null?firstBatsCrs.getString("srno"):"";
				 batsman	= firstBatsCrs.getString("batsman")!=null?firstBatsCrs.getString("batsman"):"" ;
				 howout		= firstBatsCrs.getString("howout")!=null?firstBatsCrs.getString("howout"):"" ;   
				 fielder 	= firstBatsCrs.getString("fielder")!=null?firstBatsCrs.getString("fielder"):"";  
				 bowler		= firstBatsCrs.getString("bowler")!=null?firstBatsCrs.getString("bowler"):"";
				 mins 		= firstBatsCrs.getString("mins")!=null || (!(firstBatsCrs.getString("mins").trim().equalsIgnoreCase("-1"))) ? firstBatsCrs.getString("mins"):"";    
				 four		= firstBatsCrs.getString("fours")!=null || (!(firstBatsCrs.getString("fours").trim().equalsIgnoreCase("-1")))? firstBatsCrs.getString("fours"):"";  
				 six		= firstBatsCrs.getString("six")!=null || (!(firstBatsCrs.getString("six").trim().equalsIgnoreCase("-1"))) ? firstBatsCrs.getString("six"):""; 
				 balls 		= firstBatsCrs.getString("balls")!=null || (!(firstBatsCrs.getString("balls").trim().equalsIgnoreCase("-1"))) ? firstBatsCrs.getString("balls"):"";  
				 runs 		= firstBatsCrs.getString("runs")!=null || (!(firstBatsCrs.getString("runs").trim().equalsIgnoreCase("-1"))) ? firstBatsCrs.getString("runs"):"";   
		
				 subTotal   = subTotal + Integer.parseInt(firstBatsCrs.getString("runs"));
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
									<td align=center nowrap width=5%><font color="#003399"><%=timeIn%></td>
									<td align=center nowrap width=5%><font color="#003399"><%=timeOut%></td>
									<td align=center nowrap width=5%><font color="#003399"><%=srNo%></td>
									<td nowrap width=20%><font color="#003399"><%=batsman%></td>
									<td nowrap width=10%><font color="#003399"><%=howout%></td>
									<td nowrap width=15%><font color="#003399"><%=fielder%></td>
									<td nowrap width=15%><font color="#003399"><%=bowler%></td>
									<td align=center nowrap width=5%><font color="#003399"><%=mins%></td>
									<td align=center nowrap width=5%><font color="#003399"><%=four%></td>
									<td align=center nowrap width=5%><font color="#003399"><%=six%></td>
									<td align=center nowrap width=5%><font color="#003399"><%=balls%></td>
								 	<td align=center nowrap width=5%><font color="#003399"><%=runs%></td>
							</tr>
<%
		  }
		}catch(Exception e)	{
			System.out.println("Exception : "+ e.getMessage());
		}
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
				
				firstInningTotalOver = firstInningTotalOver + Float.parseFloat(firstInningOvers);
				tExtras              =  tExtras + Integer.parseInt(byes)+Integer.parseInt(legByes)+Integer.parseInt(noBall)+Integer.parseInt(wide);
				grandTotal           =  tExtras + subTotal + Integer.parseInt(penaltyExtras);

		   }
		}catch(Exception e)	{
			System.out.println("Exception : "+ e.getMessage());
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
<%--end 	--%>
			
							<tr>
								<td colspan="5" nowrap><b>Reserves:</td>
								<td align=center nowrap><b>Byes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=byes%></td>
								<td colspan="5" align=center nowrap><b>Batting Sub Total</td>
								<td align=center nowrap><font color="#003399"><%=subTotal%></td>
							</tr>
							<tr>
								<td colspan="5" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;<b><font color="#003399"><%=reservePlayerOne%>Rohit Sharma
								</td>
								<td align=center nowrap><b>Leg Byes&nbsp;&nbsp;&nbsp;</b>
									<font color="#003399"><%=legByes%>
								</td>
								<td colspan="5" align=center nowrap><b>Total Extras</td>
								<td align=center nowrap><font color="#003399"><%=tExtras%></td>
							</tr>
							<tr>
								<td colspan="5" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<b><font color="#003399"><%=reservePlayerTwo%>Rohit Gavascar
								</td>
								<td align=center nowrap><b>No Balls&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><font 	color="#003399"><%=noBall%>
								</td>
								<td colspan="5" align=center nowrap><b>Penalty Extras</td>
								<td align=center nowrap><font color="#003399"><%=penaltyExtras%></td>
							</tr>
							<tr>
								<td colspan="5" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;<b><font color="#003399"><%=reservePlayerThree%>Ramesh Powar
								</td>
								<td align=center nowrap><b>Wides&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=wide%>
								</td>
								<td colspan="5" align=center nowrap><b>TotalFor &nbsp;&nbsp;<font color="#003399"><%=grandTotal%></font>&nbsp;&nbsp;<b>Wkts</b>
								&nbsp;&nbsp;<font color="#003399"><%=matchTotalWkt%></font>&nbsp;&nbsp;&nbsp;&nbsp;<b>Overs</b>&nbsp;&nbsp;
								</td>
								<td align=center nowrap><font color="#003399"><%=firstInningOvers%></td>
							</tr>
						</table>	
						<table align=center  width=100% height=100% style=border-collapse:collapse>
							<tr>
								<td colspan="3" align=center nowrap><b>Reason for penalty Runs if any:  &nbsp;&nbsp;&nbsp;&nbsp;<font color="#003399"><%=penaltyReason%></font></td>
							</tr>
							<tr>
								<td colspan=6 align=center>
										<table border=1 width=100% >
<%
	vparam.add(inningIdOne);
	penaltyReasonCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_penaltyreason",vparam,"ScoreDB");
	vparam.removeAllElements();	
	if(penaltyReasonCrs!=null){
		while(penaltyReasonCrs.next()){
				penaltyDescription = penaltyReasonCrs.getString("description")!=null?penaltyReasonCrs.getString("description"):"";
%>							
											<tr>
												<td align=center nowrap><font color="#003399"><%=penaltyDescription%></font></td>
											</tr>
<%
	  }
  }	  		
%>									
									</table>								
								</td>
						 </tr>
					  </table>
		<!--end here-->
						
		<!--Code for first inning fall wicket,partnership and bowling analysis start here	-->
						<table align=center  width=100% border=1 height=100% style=border-collapse:collapse>
								<tr class=firstrow>
									<td  align="center" nowrap width=20%><b>Fall of Wickets</td>
									<td  align="center" nowrap width=40%><b>partnerships</td>
									<td  align="center" nowrap width=40%><b>Bowling Analysis</td>
								</tr>
								<tr class=firstrow>
									<td>
										<table width=100% border=1 height=100% style="border-collapse: collapse">
											<tr>
												<td align=center nowrap width=30%><b>Wkt</td>
												<td align=center nowrap width=35%><b>Runs</td>
												<td align=center nowrap width=35%><b>Overs</td>
											</tr>	
										</table>	
									</td>
									<td>
										<table width=100% border=1 height=100% style="border-collapse: collapse"> 
											<tr>
												<td align=center nowrap width=70% nowrap><b>Batsmen</td>
												<td align=center nowrap width=10% nowrap><b>Runs</td>
												<td align=center nowrap width=10% nowrap><b>Mins</td>
												<td align=center nowrap width=10% nowrap><b>Balls</td>	
											</tr>
										</table>		
									</td>
									<td> 	
										<table width=100% border=1 height=100% style="border-collapse: collapse">
											<tr>					
												<td align=center nowrap width=40%><b>Bowlers</td>
												<td align=center nowrap width=10%><b>O</td>
												<td align=center nowrap width=10%><b>M</td>
												<td align=center nowrap width=10%><b>R</td>
												<td align=center nowrap width=10%><b>W</td>
												<td align=center nowrap width=10%><b>nb</td>
												<td align=center nowrap width=10%><b>wb</td>
											</tr>
										</table>		
									</td>	
								</tr>	
								<tr>
								<div style="height:100%;width:100%;">
									<td>
										<table width=100% border=1 height=100% style="border-collapse: collapse">

<%		vparam.add(inningIdOne);
		firstBatFallWicketCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket",vparam,"ScoreDB");
		vparam.removeAllElements();
		crsSize = firstBatFallWicketCrs.size();
		rowGrowLength = 10 - crsSize;
		if(firstBatFallWicketCrs!=null){
			try{
				while (firstBatFallWicketCrs.next()){
						wkt      = firstBatFallWicketCrs.getString("srno")!=null?firstBatFallWicketCrs.getString("srno"):"";
						wktRuns  = firstBatFallWicketCrs.getString("runs")!=null?firstBatFallWicketCrs.getString("runs"):"";
						wktOvers = firstBatFallWicketCrs.getString("overs")!=null?firstBatFallWicketCrs.getString("overs"):"";

%>	

												<tr>
													<td align=center nowrap width=30% ><font color="#003399"><%=wkt%></td>
													<td align=center nowrap width=35%><font color="#003399"><%=wktRuns%></td>
													<td align=center nowrap width=35%><font color="#003399"><%=wktOvers%></td>
												</tr>

<%
				}
			  }catch(Exception e){
			  	System.out.println("Exception : "+ e.getMessage());
			  }
		}
%>	


<%		for (k =0 ; k<rowGrowLength ; k++){
%>

												<tr>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</tr>
<%
		}
%>
										</table>
									</td>
								</div>
								<div style="height:100%;width:100%;">
								<td>
									<table width=100% border=1 height=100% style="border-collapse: collapse"> 

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
										<td width=70% nowrap><font color="#003399" ><%=batsmanOne%></td>
										<td width=10% align=center nowrap><font color="#003399" ><%=totalRuns%></td>
										<td width=10% align=center nowrap><font color="#003399" align=center><%=minute%></td>
										<td width=10% align=center nowrap><font color="#003399" ><%=totalballs%></td>
									</tr>

<%			  }
			}catch(Exception e)	{
					System.out.println("Exception : "+ e.getMessage());
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

									</table>		
								</td>	
								</div>
								<div style="height:100%;width:100%;">
								<td>
									<table width=100% border=1 height=100% style="border-collapse: collapse">


<%	vparam.add(session.getAttribute("matchid"));
	vparam.add(inningIdOne);
	bowledAnalysisCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowlinganalysis",vparam,"ScoreDB");
	vparam.removeAllElements();
	crsSize = bowledAnalysisCrs.size();
	rowGrowLength = 10 - crsSize;
	if(bowledAnalysisCrs!=null){
		try{
			while (bowledAnalysisCrs.next()){
				bowlerName		= bowledAnalysisCrs.getString("bowler_name")!=null?bowledAnalysisCrs.getString("bowler_name"):"";
				bowlerOver  	= bowledAnalysisCrs.getString("noofover")!=null?bowledAnalysisCrs.getString("noofover"):"0";
				bowlerMaiden	= bowledAnalysisCrs.getString("maiden")!=null?bowledAnalysisCrs.getString("maiden"):"0";
				bowlerRunrate	= bowledAnalysisCrs.getString("runs")!=null?bowledAnalysisCrs.getString("runs"):"0";
				bowlerWicket	= bowledAnalysisCrs.getString("wicket")!=null?bowledAnalysisCrs.getString("wicket"):"0";
				bowlerNB		= bowledAnalysisCrs.getString("noball")!=null?bowledAnalysisCrs.getString("noball"):"0";
				bowlerWB		= bowledAnalysisCrs.getString("wideball")!=null?bowledAnalysisCrs.getString("wideball"):"0";
%>	
											
									<tr>			
											<td nowrap width=40%><font color="#003399"><%=bowlerName%></td>
											<td nowrap width=10%><font color="#003399"><%=bowlerOver%></td>
											<td nowrap width=10%><font color="#003399"><%=bowlerMaiden%></td>
											<td nowrap width=10%><font color="#003399"><%=bowlerRunrate%></td>	
											<td nowrap width=10%><font color="#003399"><%=bowlerWicket%></td>	
											<td nowrap width=10%><font color="#003399"><%=bowlerNB%></td>	
											<td nowrap width=10%><font color="#003399"><%=bowlerWB%></td>	
									</tr>

<%			
				totalOver 		= totalOver  + Float.parseFloat(bowlerOver);
				totalMaiden		= totalMaiden+Integer.parseInt(bowlerMaiden);
				totalRunrate	= totalRunrate+Integer.parseInt(bowlerRunrate);
				totalWkt		= totalWkt+Integer.parseInt(bowlerWicket);
				totalNB 		= totalNB+Integer.parseInt(bowlerNB);
				totalWB 		= totalWB+Integer.parseInt(bowlerWB);
		 }
	  }catch(Exception e){
	  			System.out.println("Exception : "+ e.getMessage());
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
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
<%
		}
%>
												
									<tr>			
										<td align=center nowrap width=40%><b>Total</b></td>
										<td align=center nowrap width=10%><font color="#003399"><%=totalOver%></td>
										<td align=center nowrap width=10%><font color="#003399"><%=totalMaiden%></td>
										<td align=center nowrap width=10%><font color="#003399"><%=totalRunrate%></td>	
										<td align=center nowrap width=10%><font color="#003399"><%=totalWkt%></td>	
										<td align=center nowrap width=10%><font color="#003399"><%=totalNB%></td>	
										<td align=center nowrap width=10%><font color="#003399"><%=totalWB%></td>	
									</tr>
								</table>
							</td>
							</div>
						</tr>
				</table>
		<!-- end here -->
				
		<!-- code for scoring rate ,individual batsman run,partnership start here --> 
				<table align=center  width=100% border=1 height=100% style=border-collapse:collapse>
					<tr class=firstrow>
						<td  align="center" nowrap><b>Scoring Rate</td>
						<td  align="center" nowrap><b>Individual</td>
						<td  align="center" nowrap><b>For 50</td>
						<td  align="center" nowrap><b>For 100</td>
						<td  align="center" nowrap><b>Partnership</td>
						<td  align="center" nowrap><b>50</td>
						<td  align="center" nowrap><b>100</td>
						<td  align="center" nowrap><b>150</td>
					</tr>
					<tr>
						<td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
								<tr  class=firstrow>
									<td align=center width=30% nowrap><b>Runs</td>
									<td align=center width=35% nowrap><b>Balls</td>
									<td align=center width=35% nowrap><b>Mins</td>
								</tr>	
							</table>
						</td>	
						<td>	
							<table border=1 width=100% height=100% style=border-collapse:collapse>
								<tr class=firstrow>
									<td align=center nowrap><b>Batsman</td>
								</tr>
							</table>
						</td>		
						<td>	
							<table border=1 width=100% height=100% style=border-collapse:collapse>
								<tr class=firstrow>
									<td align=center nowrap width=25%><b>M</td>
									<td align=center nowrap width=25%><b>B</td>
									<td align=center nowrap width=25%><b>4</td>
									<td align=center nowrap width=25%><b>6</td>
								</tr>
							</table>
						</td>
						<td>	
								<table border=1 width=100% height=100% style=border-collapse:collapse>
								<tr class=firstrow>		
									<td align=center nowrap width=25%><b>M</td>
									<td align=center nowrap width=25%><b>B</td>
									<td align=center nowrap width=25%><b>4</td>
									<td align=center nowrap width=25%><b>6</td>
								</tr>	
							</table>
						</td>
						<td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
								<tr class=firstrow>
									<td align=center><b>Batsmen</td>
								</tr>	
							</table>	
						</td>
						<td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
								<tr class=firstrow>
									<td align=center nowrap width=50%><b>M</td>
									<td align=center nowrap width=50%><b>B</td>
								</tr>
							</table>
						</td>
						<td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>	
								<tr class=firstrow>			
									<td align=center nowrap width=50%><b>M</td>
									<td align=center nowrap width=50%><b>B</td>
								</tr>
							</table>
						</td>
						<td>	
							<table border=1 width=100% height=100% style=border-collapse:collapse>	
								<tr class=firstrow>		
									<td align=center nowrap width=50%><b>M</td>
									<td align=center nowrap width=50%><b>B</td>
								</tr>	
							</table>
						</td>		
				</tr>
				<tr>
					<td>
						<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
		vparam.add("1");
		scoringRateBatFirstCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_scoringrate",vparam,"ScoreDB");			
		vparam.removeAllElements();
		if(scoringRateBatFirstCrs!=null){
			try{
				while (scoringRateBatFirstCrs.next()){
						String scoringRateRun  = scoringRateBatFirstCrs.getString("runs");
						String scoringRateBall = scoringRateBatFirstCrs.getString("balls");
						String scoringRateMins = scoringRateBatFirstCrs.getString("mins");
%>	
--%>							<tr>
									<td align=center width=30%><font color="#003399"><%=scoringRateRun%></td>
									<td align=center width=35%><font color="#003399"><%=scoringRateBall%></td>
									<td align=center width=35%><font color="#003399"><%=scoringRateMins%></td>
								</tr>	
<%--<%
				}
			}catch(Exception e){
			}
		}
%>
									--%>
						</table>
					</td>
					<td>
						<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
		 vparam.add("1");
		 individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");											
		vparam.removeAllElements();
		if(individualBatsmanScoreCrs!=null){
			try{
				while (individualBatsmanScoreCrs.next()){
					String batsmanScore = individualBatsmanScoreCrs.getString("batsman");
%>
									--%><tr>		
											<td align=center><font color="#003399"><%=batsmanScore%></td>
										</tr>
<%--<%			}
			}catch(Exception e){
			}
		}
%>
									
									--%>
						</table>
					 </td>
					  <td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
								<tr>		
									<td>&nbsp;</td>								
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>
					  </td>	
					  <td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%		
	 vparam.add("1");
	 individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");					
	 vparam.removeAllElements();
		if(individualBatsmanScoreCrs!=null){
			 try{
				 while (individualBatsmanScoreCrs.next()){
						 String batsmanMin = individualBatsmanScoreCrs.getString("M");
						 String batsmanBall = individualBatsmanScoreCrs.getString("B");
						 String batsmanfour = individualBatsmanScoreCrs.getString("four");
						 String batsmansix  = individualBatsmanScoreCrs.getString("six");             
%>
--%>									<tr>		
											<td align=center width=25%><font color="#003399"><%=batsmanMin%></td>
											<td align=center width=25%><font color="#003399"><%=batsmanBall%></td>
											<td align=center width=25%><font color="#003399"><%=batsmanfour%></td>
											<td align=center width=25%><font color="#003399"><%=batsmansix%></td>
										</tr>
<%--<%				}
	 		}catch(Exception e){
			 }
		}
%>
								--%>
						</table>
					 </td>	
					 <td>
						<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
	vparam.add("1");
	individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");			vparam.removeAllElements();
	if(individualBatsmanScoreCrs!=null){
			 try{
					while (individualBatsmanScoreCrs.next()){
						String batsmanScore = individualBatsmanScoreCrs.getString("batsman");
%>
--%>									<tr>		
											<td align=center><font color="#003399"><%=batsmanScore%></td>
										</tr>
<%--<%
					}
	 		}catch(Exception e){
	 		}
	}
%>
							--%>
						</table>
					</td>	
					<td>
						 <table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
	vparam.add("1");
	individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");			vparam.removeAllElements();
	if(individualBatsmanScoreCrs!=null){
		 try{
				while (individualBatsmanScoreCrs.next()){
	 					String batsmanMin = individualBatsmanScoreCrs.getString("M");
	 					String batsmanBall = individualBatsmanScoreCrs.getString("B");
%>
									--%><tr>		
											<td align=center width=50%><font color="#003399"><%=batsmanMin%></td>
											<td align=center width=50%><font color="#003399"><%=batsmanBall%></td>
										</tr>
<%--<%
				}
			}catch(Exception e){
			}
	}
%>
									
							--%>
						</table>
					</td>
					<td>
						<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
	vparam.add("1");
	individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");			vparam.removeAllElements();
	if(individualBatsmanScoreCrs!=null){
		try{
			while (individualBatsmanScoreCrs.next()){
					 String batsmanMin = individualBatsmanScoreCrs.getString("M");
					 String batsmanBall = individualBatsmanScoreCrs.getString("B");
%>
									--%><tr>		
											<td align=center width=50%><font color="#003399"><%=batsmanMin%></td>
											<td align=center width=50%><font color="#003399"><%=batsmanBall%></td>
										</tr>
<%--<%
							
			}
		}catch(Exception e){
		}
	}
%>
									
							--%>
						</table>
					</td>
					 <td>
						<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
	vparam.add("1");
	individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");		
	vparam.removeAllElements();
	if(individualBatsmanScoreCrs!=null){
		try{
			while (individualBatsmanScoreCrs.next()){
					 String batsmanMin = individualBatsmanScoreCrs.getString("M");
					 String batsmanBall = individualBatsmanScoreCrs.getString("B");
%>
									--%><tr>		
											<td align=center width=50%><font color="#003399"><%=batsmanMin%></td>
											<td align=center width=50%><font color="#003399"><%=batsmanBall%></td>
										</tr>
<%--<%
			}
		}catch(Exception e){
		}
	}
%>
							
							--%>
						</table>	
					 </td>
			     </tr>
		<%--	End		--%>
			  </table>
				<table border=1 width=50% align=center style=border-collapse:collapse>
					<tr  class=firstrow>
							<td nowrap width=20%><b>From</td>
							<td nowrap width=20%><b>To</td>
							<td nowrap width=20%><b>Min</td>
							<td nowrap width=20%><b>ol</td>
							<td nowrap width=20%><b>Stoppage/reason</td>
					</tr>
<%--<%
	vparam.add("1");
	CachedRowSet stoppageSummeryCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_interrupt",vparam,"ScoreDB");				
	vparam.removeAllElements();
	if(stoppageSummeryCrs!=null){
		try{
			while (stoppageSummeryCrs.next()){
					 String fromTime = stoppageSummeryCrs.getString("from");
					 String toTime = stoppageSummeryCrs.getString("to");
					 String totalMin = stoppageSummeryCrs.getString("min");
					 String ol = stoppageSummeryCrs.getString("ol");
					 String reason = stoppageSummeryCrs.getString("reason");
%>
							--%>
					<tr>
							<td nowrap width=20%><font color="#003399"><%=fromTime%></td>
							<td nowrap width=20%><font color="#003399"><%=toTime%></td>
							<td nowrap width=20%><font color="#003399"><%=totalMin%></td>
							<td nowrap width=20%><font color="#003399"><%=ol%></td>
							<td nowrap width=20%><font color="#003399"><%=reason%></td>
					</tr>
<%--<%
			}
		}catch(Exception e){
		}
	}
%>
				--%>
				</table>
			</tr>
		</td>
		<!--First <TD> End here-->
		
		<!-- Second <TD> Start here -->
		<td align=center>
			<table border="1" width=100% height=100% style=border-collapse:collapse>
					<tr class=firstrow>
						<td colspan="4" align="center"><b>Run Rate</td>
					</tr>
					<tr class=firstrow>	
						<td align=center nowrap width=25%><b>Ov</td>
						<td align=center nowrap width=25%><b>Runs</td>
						<td align=center nowrap width=25%><b>W</td>
						<td align=center nowrap width=25%><b>Runrate </td>
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
								<td align=center nowrap width=25%><font color="#003399"><%=overs%></td>
								<td align=center nowrap width=25%><font color="#003399"><%=run%></td>
								<td align=center nowrap width=25%><font color="#003399"><%=wicket%></td>
								<td align=center nowrap width=25%><font color="#003399"><%=runRate%></td>
							</tr>
<%						
			}
		}catch(Exception e){
			System.out.println("Exception : "+ e.getMessage());
		}
	}
%>		
<%
	for (k=0 ; k < rowGrowLength ; k++){
		crsSize++;
%>
							<tr> 
								<td align=center nowrap width=25%><font color="#003399"><%=crsSize%></font></td>
								<td nowrap width=25%>&nbsp;</td>
								<td nowrap width=25%>&nbsp;</td>
								<td nowrap width=25%>&nbsp;</td>
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
		</div>
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
			System.out.println("Exception : "+ e.getMessage());
		}
	}			
%>
		<br>
		<br>
		<table align="center" border=1 width=100% style=border-collapse:collapse>
					<tr class=firstrow>
						<td align=center nowrap width=10%><b>Target</td>
						<td nowrap width=10% align=center><font color="#003399"><%=targetScore%></td>
						<td align=center nowrap width=10%><b>Runs in</td>
						<td nowrap width=10% align=center><font color="#003399"><%=overMax%></td>
						<td align=center nowrap width=10%><b>Overs</td>
						<td align=center nowrap width=10%><b>Revised target:</td>
						<td nowrap width=10% align=center><font color="#003399"><%=revisedTargetScore%></td>
						<td align=center nowrap width=10%><b>Runs in</td>
						<td nowrap width=10% align=center><font color="#003399"><%=overMax%></td>
						<td align=center nowrap width=10%><b>Overs</td>
					</tr>
		</table>
		
<%	vparam.add(inningIdTwo);
	secondInningDurationCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsecondtime",vparam,"ScoreDB");
	System.out.println("sp10 called");
	vparam.removeAllElements();
	if(secondInningDurationCrs!=null){
		 try{
				while (secondInningDurationCrs.next()){
					teamBattingSecond		=secondInningDurationCrs.getString("battingteam")!=null?secondInningDurationCrs.getString("battingteam"):"0";
					StartTimeBattingSecond	=secondInningDurationCrs.getString("startts")!=null?secondInningDurationCrs.getString("startts"):"0";
					endTimeBattingSecond	=secondInningDurationCrs.getString("endts")!=null?secondInningDurationCrs.getString("endts"):"0";
					durationBattingSecond	=secondInningDurationCrs.getString("duration")!=null?secondInningDurationCrs.getString("duration"):"0";
				}
		 }catch(Exception e){
		 			System.out.println("Exception : "+ e.getMessage());
		 }
	}
%>
		<br>
			<table align="center" border=1 width=100% style=border-collapse:collapse>	
					<tr class=firstrow>
						<td nowrap width=10% align="center"> <b>Team Batting Second</td>
						<td nowrap width=10% align=center> <font color="#003399"><%=teamBattingSecond%></td>
						<td nowrap width=10% align="center"><b>Start :</td>
						<td nowrap width=15% align=center><font color="#003399"><%=StartTimeBattingSecond%></td>
						<td nowrap width=10% align="center"><b>Close :</td>
						<td nowrap width=15% align=center><font color="#003399"><%=endTimeBattingSecond%></td>
						<td nowrap width=10% align="center"><b>Duration</td>
						<td nowrap width=10% align=center><font color="#003399"><%=durationBattingSecond%></td>
						<td nowrap width=10% align="center"><b>Mins</td>
					</tr>
			</table>
		<br>	
			<div style="height:100%;width:100%;">
			<table align=center border=1 width=100% style=border-collapse:collapse>
				<tr>
					<td align=center>
						<table align=center border=1 width=100% height=100% style=border-collapse:collapse>
							 <tr class=firstrow>
								<td nowrap width=5%  align=center><b>Time<br>In</td>
								<td nowrap width=5%  align=center><b>Time<br>OUT</td>
								<td nowrap width=5%  align=center><b>NO.</td>
								<td nowrap width=20% align=center><b>Batsman</td>
								<td nowrap width=10% align=center><b>How<br>Out</td>
								<td nowrap width=15% align=center><b>Fielder</td>
								<td nowrap width=15% align=center><b>Bowler</td>
								<td nowrap width=5%  align=center><b>Mins</td>
								<td nowrap width=5%  align=center><b>4</td>
								<td nowrap width=5%  align=center><b>6</td>
								<td nowrap width=5%  align=center><b>Balls</td>
								<td nowrap width=5%  align=center><b>Runs</td>
							</tr>	
	
<%  vparam.add(inningIdTwo);
	secondBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingscorercard",vparam,"ScoreDB");
	vparam.removeAllElements();
	subTotal = 0;
	if(secondBatsCrs!=null){
	 	 try{		
			while (secondBatsCrs.next()){
				 timeIn	  = secondBatsCrs.getString("timein")!=null?secondBatsCrs.getString("timein"):"";
				 timeOut  = secondBatsCrs.getString("timeout")!=null?secondBatsCrs.getString("timeout"):"";
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
		
				subTotal = subTotal + Integer.parseInt(secondBatsCrs.getString("runs"));
				
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
%>		
								<tr>
									<td align=center nowrap width=5%><font color="#003399"><%=timeIn%></td>
									<td align=center nowrap width=5%><font color="#003399"><%=timeOut%></td>
									<td align=center nowrap width=5%><font color="#003399"><%=srNo%></td>
									<td nowrap width=20%><font color="#003399"><%=batsman%></td>
									<td nowrap width=10% ><font color="#003399"><%=howout%></td>
									<td nowrap width=15% ><font color="#003399"><%=fielder%></td>
									<td nowrap width=15% ><font color="#003399"><%=bowler%></td>
									<td nowrap width=5% align=center><font color="#003399"><%=mins%></td>
									<td nowrap width=5% align=center><font color="#003399"><%=four%></td>
									<td nowrap width=5% align=center><font color="#003399"><%=six%></td>
									<td nowrap width=5% align=center><font color="#003399"><%=balls%></td>
									<td nowrap width=5% align=center><font color="#003399"><%=runs%></td>
								</tr>
<%
	  	 }
       }catch(Exception e)	{
       		System.out.println("Exception : "+ e.getMessage());
       }
  	}
%>

<%
	vparam.add(inningIdTwo);
	secondBatsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total",vparam,"ScoreDB");
	vparam.removeAllElements();
	tExtras    = 0;
	grandTotal = 0;
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
			tExtras   			  = Integer.parseInt(byes)+Integer.parseInt(legByes)+Integer.parseInt(noBall)+Integer.parseInt(wide);
			grandTotal			  = tExtras + subTotal + Integer.parseInt(penaltyExtras);
		}
	  }catch(Exception e)	{
	  		System.out.println("Exception : "+ e.getMessage());
	  }
	}
%>

<%-- code to get reserve player 	--%>
<%--<%
			vparam.add("1");
			reserveplayerCrs = lobjGenerateProc.GenerateStoreProcedure("dsp_reserve",vparam,"ScoreDB");
			vparam.removeAllElements();
			if(reserveplayerCrs!=null){
				try{
					while (reserveplayerCrs.next()){
						 reserveplayerCrs =reserveplayerCrs + reserveplayerCrs.getString("playername")+"~";
					}
				 }catch(Exception e){
				 }
			}
			String secondInning[] = reserveplayerCrs.split("~");
			for (int i = 0 ; i < secondInning.length ; i++){
				reservePlayerOne = secondInning[0];
				reservePlayerTwo = secondInning[1];
				reservePlayerThree = secondInning[2];
			}
%>
--%><%--end 	--%>
	

						<tr>
							<td nowrap colspan="5"><b>Reserves:</td>
							<td nowrap align=center><b>Byes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=byes%>
							</td>
							<td nowrap colspan="5" align=center><b>Batting Sub Total</td>
							<td nowrap align=center><font color="#003399"><%=subTotal%></td>
						</tr>
						<tr>
							<td nowrap colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;<b><font color="#003399"><%=reservePlayerOne%></td>
							<td nowrap align=center ><b>Leg Byes&nbsp;&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=legByes%></td>
							<td nowrap colspan="5" align=center><b>Total Extras</td>
							<td nowrap align=center><font color="#003399"><%=totalExtras%></td>
						</tr>
						<tr>
							<td nowrap colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<b><font color="#003399"><%=reservePlayerTwo%></td>
							<td nowrap align=center><b>No Balls&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=noBall%></td>
							<td nowrap colspan="5" align=center> <b>Penalty Extras</td>
							<td nowrap align=center><font color="#003399"><%=penaltyExtras%></td>
						</tr>
						<tr>
							<td nowrap colspan="5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;<b><font color="#003399"><%=reservePlayerThree%></td>
							<td nowrap align=center><b>Wides&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><font color="#003399"><%=wide%></td>
							<td nowrap colspan="5"><b>TotalFor &nbsp;&nbsp;<font color="#003399"><%=grandTotal%></font> &nbsp;&nbsp;<b>Wkts</b>&nbsp;&nbsp;<font color="#003399"><%=matchTotalWkt%> </font>&nbsp;&nbsp;<b>Overs</b>&nbsp;&nbsp;</td>
							<td nowrap align=center><font color="#003399"><%=secondInningOvers%></td>
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
												<td nowrap align=center><font color="#003399"><%=penaltyDescription%></font></td>
											</tr>
<%
		    }
		}catch(Exception e){
			System.out.println("Exception : "+ e.getMessage());
		}
    }	  		
%>									
									</table>								
								</td>
						 </tr>
			</table>
			<br>
			<table align=center  width=100% border=1 height=100% style=border-collapse:collapse>
					<tr class=firstrow>
						<td  align="center" nowrap width=10%><b>Fall of Wickets</td>
						<td  align="center" nowrap width=45%><b>partnerships</td>
						<td  align="center" nowrap width=45%><b>Bowling Analysis</td>
					</tr>
					
					<tr>
						<td>
							<table width=100% border=1 height=100% style="border-collapse: collapse">
								<tr class=firstrow>
									<td align=center nowrap width=30%><b>Wkt</td>
									<td align=center nowrap width=35%><b>Runs</td>
									<td align=center nowrap width=35%><b>Overs</td>
								</tr>	
							</table>	
						</td>
						<td>
							<table width=100% border=1 height=100% style="border-collapse: collapse"> 
								<tr class=firstrow>
									<td align=center nowrap width=70% nowrap><b>Batsmen</td>
									<td align=center nowrap width=10% nowrap><b>Runs</td>
									<td align=center nowrap width=10% nowrap><b>Mins</td>
									<td align=center nowrap width=10% nowrap><b>Balls</td>		
								</tr>
							</table>		
						</td>
						<td> 	
							<table width=100% border=1 height=100% style="border-collapse: collapse">
								<tr class=firstrow>					
									<td align=center nowrap width=40%><b>Bowlers</td>
									<td align=center nowrap width=10%><b>O</td>
									<td align=center nowrap width=10%><b>M</td>
									<td align=center nowrap width=10%><b>R</td>
									<td align=center nowrap width=10%><b>W</td>
									<td align=center nowrap width=10%><b>nb</td>
									<td align=center nowrap width=10%><b>wb</td>
								</tr>
							</table>		
						</td>	
					</tr>	
				
					<tr>
					<div style="height:100%;width:100%;">
						<td>
							<table width=100% border=1 height=100% style="border-collapse: collapse">

<%  vparam.add(inningIdTwo);
	secondBatFallWicketCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket",vparam,"ScoreDB");
	vparam.removeAllElements();
	crsSize = secondBatFallWicketCrs.size();
	rowGrowLength = 10 - crsSize;
	if(secondBatFallWicketCrs!=null){
		try{
		  	 while (secondBatFallWicketCrs.next()){
				wkt		 = secondBatFallWicketCrs.getString("srno")!=null?secondBatFallWicketCrs.getString("srno"):"0";
				wktRuns  = secondBatFallWicketCrs.getString("runs")!=null?secondBatFallWicketCrs.getString("runs"):"0";
				wktOvers = secondBatFallWicketCrs.getString("overs")!=null?secondBatFallWicketCrs.getString("overs"):"0";

%>

											<tr>
												<td align=center nowrap width=30%><font color="#003399"><%=wkt%></td>
												<td align=center nowrap width=35%><font color="#003399"><%=wktRuns%></td>
												<td align=center nowrap width=35%><font color="#003399"><%=wktOvers%></td>
											</tr>
<%
		}
 	}catch(Exception e){
 		System.out.println("Exception : "+ e.getMessage());
 	}
  }
%>		
<%	for (k =0 ; k<rowGrowLength ; k++){
%>
											<tr>
												<td nowrap width=30%>&nbsp;</td>
												<td nowrap width=35%>&nbsp;</td>
												<td nowrap width=35%>&nbsp;</td>
											</tr>
<%
	}
%>
							</table>
						</td>
					</div>
					<div style="height:100%;width:100%;">
							<td>
								<table width=100% border=1 height=100% style="border-collapse: collapse"> 
									


<%  vparam.add(inningIdTwo);
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
									<td nowrap width=70% ><font color="#003399"><%=batsmanOne%></td>
									<td nowrap width=10% ><font color="#003399"><%=totalRuns%></td>
									<td nowrap width=10% ><font color="#003399"><%=minute%></td>
									<td nowrap width=10% ><font color="#003399"><%=totalballs%></td>
									</tr>
<%	
		  }
	    }catch(Exception e){
	    	System.out.println("Exception : "+ e.getMessage());
	    }
	  }
%>
<%	for (k =0 ; k<rowGrowLength ; k++){
%>
									<tr>
										<td nowrap >&nbsp;</td>
										<td nowrap >&nbsp;</td>
										<td nowrap >&nbsp;</td>
										<td nowrap >&nbsp;</td>
									</tr>
<%
	}
%>
								</table>		
							  </td>	
						  </div>
									
						  <div style="height:100%;width:100%;">
								<td>
									<table width=100% border=1 height=100% style="border-collapse: collapse">
<%	vparam.add(session.getAttribute("matchid"));
	vparam.add(inningIdTwo);
	totalOver		= 0;
	totalMaiden		= 0;
	totalRunrate	= 0;
	totalWkt		= 0;
	totalNB			= 0;
	totalWB			= 0;
	bowledAnalysisCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowlinganalysis",vparam,"ScoreDB");	
	vparam.removeAllElements();
	crsSize = bowledAnalysisCrs.size();
	rowGrowLength = 10 - crsSize;
	if(bowledAnalysisCrs!=null){
		try{
			while (bowledAnalysisCrs.next()){
				bowlerName		= bowledAnalysisCrs.getString("bowler_name")!=null?bowledAnalysisCrs.getString("bowler_name"):"";
				bowlerOver  	= bowledAnalysisCrs.getString("noofover")!=null?bowledAnalysisCrs.getString("noofover"):"0";
				bowlerMaiden	= bowledAnalysisCrs.getString("maiden")!=null?bowledAnalysisCrs.getString("maiden"):"0";
				bowlerRunrate	= bowledAnalysisCrs.getString("runs")!=null?bowledAnalysisCrs.getString("runs"):"0";
				bowlerWicket	= bowledAnalysisCrs.getString("wicket")!=null?bowledAnalysisCrs.getString("wicket"):"0";
				bowlerNB		= bowledAnalysisCrs.getString("noball")!=null?bowledAnalysisCrs.getString("noball"):"0";
				bowlerWB		= bowledAnalysisCrs.getString("wideball")!=null?bowledAnalysisCrs.getString("wideball"):"0";
%>	
												
									<tr>			
											<td nowrap width=40%><font color="#003399"><%=bowlerName%></td>
											<td nowrap width=10%><font color="#003399"><%=bowlerOver%></td>
											<td nowrap width=10%><font color="#003399"><%=bowlerMaiden%></td>
											<td nowrap width=10%><font color="#003399"><%=bowlerRunrate%></td>	
											<td nowrap width=10%><font color="#003399"><%=bowlerWicket%></td>	
											<td nowrap width=10%><font color="#003399"><%=bowlerNB%></td>	
											<td nowrap width=10%><font color="#003399"><%=bowlerWB%></td>	
									</tr>
<%
			totalOver	= totalOver   + Float.parseFloat(bowlerOver);
			totalMaiden	= totalMaiden + Integer.parseInt(bowlerMaiden);
			totalRunrate= totalRunrate+ Integer.parseInt(bowlerRunrate); 
			totalWkt	= totalWkt    + Integer.parseInt(bowlerWicket);
			totalNB		= totalNB     + Integer.parseInt(bowlerNB);
			totalWB		= totalWB     + Integer.parseInt(bowlerWB); 				
		 }
	  }catch(Exception e){
	  	System.out.println("Exception : "+ e.getMessage());
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
%>									<tr>			
											<td align=center nowrap width=40%>Total</td>
											<td align=center nowrap width=10%><font color="#003399"><%=totalOver%></td>
											<td align=center nowrap width=10%><font color="#003399"><%=totalMaiden%></td>
											<td align=center nowrap width=10%><font color="#003399"><%=totalRunrate%></td>	
											<td align=center nowrap width=10%><font color="#003399"><%=totalWkt%></td>	
											<td align=center nowrap width=10%><font color="#003399"><%=totalNB%></td>	
											<td align=center nowrap width=10%><font color="#003399"><%=totalWB%></td>	
									</tr>
								</table>
							</td>
						</div>
						</tr>
								<%--<tr>
									<td>
										<table border=1 width=100%>
						<tr>
						
							<td align=center>&nbsp;</td>
							<td align=center>&nbsp;</td>
							<td align=center>&nbsp;</td>
							<td align=center>&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
	--%></table>
		
			<table align=center  width=100% border=1 height=100% style=border-collapse:collapse>
			<tr  class=firstrow>
				<td  align="center" nowrap width=10%><b>Scoring Rate</td>
				<td  align="center" nowrap width=20%><b>Individual</td>
				<td  align="center" nowrap width=10%><b>For 50</td>
				<td  align="center" nowrap width=10%><b>For 100</td>
				<td  align="center" nowrap width=20%><b>Partnership</td>
				<td  align="center" nowrap width=10%><b>50</td>
				<td  align="center" nowrap width=10%><b>100</td>
				<td  align="center" nowrap width=10%><b>150</td>
			</tr>
		
			<tr>
				<td>
					<table border=1 width=100% height=100% style=border-collapse:collapse>
						<tr class=firstrow>
							<td align=center nowrap width=20%><b>Runs</td>
							<td align=center nowrap width=40%><b>Balls</td>
							<td align=center nowrap width=40%><b>Mins</td>
						</tr>	
					</table>
				</td>	
				<td>	
					<table border=1 width=100% height=100% style=border-collapse:collapse>
						<tr class=firstrow>
							<td align=center><b>Batsman</td>
						</tr>
					</table>
				</td>		
				<td>	
					<table border=1 width=100% height=100% style=border-collapse:collapse>
						<tr class=firstrow>
							<td align=center nowrap width=25%><b>M</td>
							<td align=center nowrap width=25%><b>B</td>
							<td align=center nowrap width=25%><b>4</td>
							<td align=center nowrap width=25%><b>6</td>
						</tr>
					</table>
				</td>
				<td>	
						<table border=1 width=100% height=100% style=border-collapse:collapse>
						<tr class=firstrow>		
							<td align=center nowrap width=25%><b>M</td>
							<td align=center nowrap width=25%><b>B</td>
							<td align=center nowrap width=25%><b>4</td>
							<td align=center nowrap width=25%><b>6</td>
						</tr>	
					</table>
				</td>
				<td>
					<table border=1 width=100% height=100% style=border-collapse:collapse>
						<tr class=firstrow>
							<td align=center><b>Batsmen</td>
						</tr>	
					</table>	
				</td>
				<td>
					<table border=1 width=100% height=100% style=border-collapse:collapse>
						<tr class=firstrow>
							<td align=center width=50%><b>M</td>
							<td align=center width=50%><b>B</td>
						</tr>
					</table>
				</td>
				<td>
					<table border=1 width=100% height=100% style=border-collapse:collapse>	
						<tr class=firstrow>			
							<td align=center width=50%><b>M</td>
							<td align=center width=50%><b>B</td>
						</tr>
					</table>
				</td>
				<td>	
					<table border=1 width=100% height=100% style=border-collapse:collapse>	
						<tr class=firstrow>		
							<td align=center width=50%><b>M</td>
							<td align=center width=50%><b>B</td>
						</tr>	
					</table>
				</td>		
			</tr>
			
			<tr>
				<td>
					<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
		vparam.add("1");
		scoringRateBatFirstCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_scoringrate",vparam,"ScoreDB");		
		vparam.removeAllElements();
		if(scoringRateBatFirstCrs!=null){
			 try{	
				while (scoringRateBatFirstCrs.next()){
					String scoringRateRun  = scoringRateBatFirstCrs.getString("runs");
					String scoringRateBall = scoringRateBatFirstCrs.getString("balls");
					String scoringRateMins = scoringRateBatFirstCrs.getString("mins");
%>	

												--%>	
<%--<%
				}
		 	}catch(Exception e){
			}
	 }
%>
					--%></table>
					</td>
					<td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
		vparam.add("1");
		individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");		vparam.removeAllElements();
		if(individualBatsmanScoreCrs!=null){
			try{
				while (individualBatsmanScoreCrs.next()){
					String batsmanScore = individualBatsmanScoreCrs.getString("batsman");
%>
										--%>
<%--<%	
				}
			 }catch(Exception e){
			 }
		}
%>
									
								--%>
							</table>
						</td>
						
						<td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%		
	vparam.add("1");
 	individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");		
 	vparam.removeAllElements();
 	if(individualBatsmanScoreCrs!=null){
		try{	
			 while (individualBatsmanScoreCrs.next()){
					String batsmanMin = individualBatsmanScoreCrs.getString("M");
 					String batsmanBall = individualBatsmanScoreCrs.getString("M");
 					String batsmanfour = individualBatsmanScoreCrs.getString("four");
 					String batsmansix  = individualBatsmanScoreCrs.getString("six");                  
%>
									--%>
<%--<%
				}
			}catch(Exception e){
			}
	}
%>
								--%>
							</table>
						</td>	
					  	<td>
								<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%		
	vparam.add("1");
	individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");		
	vparam.removeAllElements();
	 if(individualBatsmanScoreCrs!=null){
		 try{	
			 while (individualBatsmanScoreCrs.next()){
				 String batsmanMin = individualBatsmanScoreCrs.getString("M");
				 String batsmanBall = individualBatsmanScoreCrs.getString("B");
				 String batsmanfour = individualBatsmanScoreCrs.getString("four");
				 String batsmansix  = individualBatsmanScoreCrs.getString("six");                                        

%>
									--%>
<%--<%
		}
 		}catch(Exception e){
		 }
	}
%>
								--%>
								</table>
						</td>	
						<td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
		vparam.add("1");
		individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");		vparam.removeAllElements();
		if(individualBatsmanScoreCrs!=null){
			try{
				while (individualBatsmanScoreCrs.next()){
					String batsmanScore = individualBatsmanScoreCrs.getString("batsman");
%>
								--%>
<%--<%
				}
 			}catch(Exception e){
 			}
		}
%>
									
							--%>
							</table>
						</td>	
						<td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
	vparam.add("1");
 	individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");			vparam.removeAllElements();
 	if(individualBatsmanScoreCrs!=null){
		 try{
			while (individualBatsmanScoreCrs.next()){
				 String batsmanMin = individualBatsmanScoreCrs.getString("M");
				 String batsmanBall = individualBatsmanScoreCrs.getString("B");
%>
									--%>
<%--<%
			}
 		}catch(Exception e){
		 }
	}
%>
									
							--%>
							</table>
						</td>
						<td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
	vparam.add("1");
	individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");		
	vparam.removeAllElements();
	if(individualBatsmanScoreCrs!=null){
		try{
			while (individualBatsmanScoreCrs.next()){
					 String batsmanMin = individualBatsmanScoreCrs.getString("M");
					 String batsmanBall = individualBatsmanScoreCrs.getString("B");
%>
										--%>
<%--<%
			}
		 }catch(Exception e){
		 }
	}
%>
									
							--%>
							</table>
						</td>
						<td>
							<table border=1 width=100% height=100% style=border-collapse:collapse>
<%--<%	
	vparam.add("1");
	individualBatsmanScoreCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_individual_score",vparam,"ScoreDB");		
	vparam.removeAllElements();
	if(individualBatsmanScoreCrs!=null){
		try{
			while (individualBatsmanScoreCrs.next()){
				 String batsmanMin = individualBatsmanScoreCrs.getString("M");
				 String batsmanBall = individualBatsmanScoreCrs.getString("B");
%>
										--%>
										
<%--<%
		}
 	  }catch(Exception e){
 		}
	}
%>
									
							--%>
							</table>
						</td>
					</tr>
				</table>
				<table border=1 width=50% align=center style=border-collapse:collapse>
					
									<tr class=firstrow>
										<td nowrap width=20% ><b>From</td>
										<td nowrap width=20% ><b>To</td>
										<td nowrap width=20% ><b>Min</td>
										<td nowrap width=20% ><b>ol</td>
										<td nowrap width=20% ><b>Stoppage/reason</td>
									</tr>
<%--<%
	vparam.add("1");
	stoppageSummeryCrs  = lobjGenerateProc.GenerateStoreProcedure("dsp_interrupt",vparam,"ScoreDB");
	vparam.removeAllElements();
	if(stoppageSummeryCrs!=null){
		 try{
				while (stoppageSummeryCrs.next()){
					 String fromTime = stoppageSummeryCrs.getString("from");
					 String toTime = stoppageSummeryCrs.getString("to");
					 String totalMin = stoppageSummeryCrs.getString("min");
					 String ol = stoppageSummeryCrs.getString("ol");
					 String reason = stoppageSummeryCrs.getString("reason");
%>
							--%><tr>
									<td nowrap width=20%><font color="#003399"><%=fromTime%></td>
									<td nowrap width=20%><font color="#003399"><%=toTime%></td>
									<td nowrap width=20%><font color="#003399"><%=totalMin%></td>
									<td nowrap width=20%><font color="#003399"><%=ol%></td>
									<td nowrap width=20%><font color="#003399"><%=reason%></td>
								</tr>
<%--<%
			}
	 	}catch(Exception e){
 	  	}
	}
%>
				--%>
				</table>
			</td>	
			<td align=center>
					<table border="1" width=100% height=100% style=border-collapse:collapse>
						<tr class=firstrow> 
							<td colspan="4" align="center"><b>Run Rate</td>
						</tr>
						<tr class=firstrow>	
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
								<td nowrap width=25% align=center ><font color="#003399"><%=overs%></td>
								<td nowrap width=25% align=center><font color="#003399"><%=run%></td>
								<td nowrap width=25% align=center><font color="#003399"><%=wicket%></td>
								<td nowrap width=25% align=center><font color="#003399"><%=runRate%></td>
							</tr>
<%						
			}
		}catch(Exception e){
			System.out.println("Exception : "+ e.getMessage());
		}
	}
%>		
<%
	for (k=0 ; k < rowGrowLength ; k++){
		crsSize++;
%>
							<tr> 
								<td nowrap width=25% align=center><font color="#003399"><%=crsSize%></font></td>
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
		</div>
		
		<table  width=100% style=border-collapse:collapse ><%--
				<tr>
					<td align=center><b>Reason for penalty Runs if any:</td>
					<td align=center>
						<table border=1>
									
<%
	vparam.add(inningIdTwo);
	penaltyReasonCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_penaltyreason",vparam,"ScoreDB");
	vparam.removeAllElements();	
	if(penaltyReasonCrs!=null){
	try{
		while(penaltyReasonCrs.next()){
				penaltyDescription = penaltyReasonCrs.getString("description")!=null?penaltyReasonCrs.getString("description"):" ";
%>							
									<tr>
										<td><%=penaltyDescription%></td>
									</tr>
<%
	   }
	}catch(Exception e){
			System.out.println("Exception : "+ e.getMessage());
	}
  }	  		
%>									
									
						</table>
					</td>--%>
				</tr>
				<tr>
					<td colspan="2" align="center"></td>
				</tr>
			</table>
			
			<table border=1 width=100% style=border-collapse:collapse>
				<tr class=firstrow>
					<td nowrap width=15% align="center"><font size=2><b>ASSOCIATION</font>
					<td nowrap width=15% align="center"><font size=2><b>RUNS<br>SCORED</td></font>
					<td nowrap width=15% align="center"><font size=2><b>OVERS<br>PLAYED</td></font>
					<td nowrap width=15% align="center"><font size=2><b>TIME<br>TAKEN</td></font>
					<td nowrap width=15% align="center"><font size=2><b>OVERS<br>SHORT<br>BY OPPN</td></font>
					<td nowrap width=10% align="center"><font size=2><b>POINTS</td></font>
					<td nowrap width=15% align="center"><font size=2><b>REMARKS</td></font>
				</tr>

<%	
	int difference = 0 ;
	float maxOver  = 0;	
	vparam.add("");
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
	 			System.out.println("Exception : "+ e.getMessage());
	 	}
	}	
%>				
				<tr>
						<td nowrap width=15% align=center><font color="#003399"><%=teamOne%></td>
						<td nowrap width=15% align=center><font color="#003399"><%=firstInningTotal%></td>
						<td nowrap width=15% align=center><font color="#003399"><%=firstInningOvers%></td>
						<td nowrap width=15% align=center><font color="#003399"><%=durationBattingFirst%></td>
						<td nowrap width=15% align=center><font color="#003399"><%=firstInningShortOver%></td>
						<td nowrap width=10% align=center><font color="#003399">-</td>
						<td nowrap width=15% align=center><font color="#003399">-</td>
				</tr>
							
				<tr>
					<td nowrap width=15% align=center><font color="#003399"><%=teamTwo%></font></td>
					<td nowrap width=15% align=center><font color="#003399"><%=secondInningTotal%></td>
					<td nowrap width=15% align=center><font color="#003399"><%=secondInningOvers%></td>
					<td nowrap width=15% align=center><font color="#003399"><%=durationBattingSecond%></td>
					<td nowrap width=15% align=center><font color="#003399"><%=secondInningShortOver%></td>
					<td nowrap width=15% align=center><font color="#003399">-</td>
					<td nowrap width=15% align=center><font color="#003399">-</td>
				</tr>
			</table>
				
			<table  align=center width="100%" border=1 style=border-collapse:collapse>
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
		</table>
	</body>
</html>

