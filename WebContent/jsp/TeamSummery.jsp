<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"	
%>
	
<%  response.setHeader("Cache-Control", "private");
    response.setHeader("Pragma","private");
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Pragma", "must-revalidate");
    response.setDateHeader("Expires", 0);
%>
<% //cachedrowset declaration
	CachedRowSet  firstBatsInningFirstCrs		     = null;
	CachedRowSet  firstBatsInningSecondCrs			 = null;
	CachedRowSet  bowledAnalysisCrs					 = null;
	CachedRowSet  penaltyReasonCrs					 = null;
	CachedRowSet  firstInningFirstBatsFallWicketCrs  = null;
	CachedRowSet  secondInningFirstBatsFallWicketCrs = null;
	CachedRowSet  fallOfWicketInningOne				 = null;
	CachedRowSet  fallOfWicketInningTwo				 = null;

 	//GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	Vector vparam =  new Vector();
	
	// variable declaration
		String timeIn 						= "";
		String timeOut 						= "";
		String srNo 						= "";
		String batsman						= "";
		String howOut						= "";     
		String fielder						= "";   
		String bowler						= "";      
		String mins							= "";      
		String four 						= "";   
		String six 							= ""; 
		String balls 						= "";      
		String runs 						= "";       
		String byes 						= "";      
		String legByes 						= "";      
		String noBall 						= "";                                
		String wide 						= "";   
		String battingSubTotal				= "";   
		String totalExtras 					= ""; 
		String penaltyExtras 				= "";
		String totalOvers					= "";
		String twelveman					= "";
		String shortOvers					= "";
		String secondNewBallOver			= ""; 
		String thirdNewBallOver				= "";
		String secondNewBallScore			= "";
		String thirdNewBallScore			= "";
		String secondNewBallBats			= "";
		String thirdNewBallBats				= "";
		String secondNewBallBowl			= "";
		String bowlerName					= "";
		String bowlerOver					= "";
		String bowlerMaiden					= "";
		String bowlerRunrate				= "";
		String bowlerWicket					= "";
		String bowlerNB						= "";
		String bowlerWB						= "";
		String type							= "";
		String wktRun						= "";
		String wktOvers						= "";
		String wktPartMin					= "";
		String wktNoBats					= "";
		String wktBatsOut					= "";
		String wktPartBall					= "";
		String firstTeamScoreOver			= "";
		String secondTeamScoreOver			= "";
		String matchTotalRun				= "";
		String matchTotalWkt				= "";
		String matchTotalOver				= "";
		String reservePlayerOne				= "";
		String reservePlayerTwo				= "";
		String reservePlayerThree			= "";
		String inningIdOne					= "";
		String inningIdTwo					= "";
		String penaltyDescription			= "";
		String batsmanId					= "";
		String batsSrNo 					= "";
		String bowlerId						= "";		
		String firstInningScoreMins 		= "";
		String secondInningMatchTotalWkt 	= "";
		String firstInningScoreRunrange 	= "";
		String secondInningScoreMins		= "";
		String secondInningByes 			= "";
		String secondInningLegByes			= "";
		String secondInningPenaltyExtras	= "";
		String secondBowlerOver				= "";
		String secondBowlerMaiden			= ""; 
		String secondBowlerRunrate			= "";
		String secondBowlerWicket			= "";
		String secondBowlerNB				= "";
		String secondBowlerWB				= "";
		String nonstkrun					= "";
		String matchId						= "";
		String firstinningbattingteam		= "";
		String secondinningbattingteam		= "";
		
		int extraPlusTotalRun				= 0;
		int secondExtraPlusTotalRun 		= 0;
		int firstInningExtrasTotal			= 0;
		int secondInningExtrasTotal			= 0;
		int k								= 0;
		int subTotal						= 0;
		int tExtras							= 0;
		int grandTotal						= 0;
		float totalOver						= 0;
		int totalMaiden						= 0;
		int totalRun						= 0;
		int totalWkt						= 0;
		int totalNB							= 0;
		int totalWB							= 0;
		int crsSize							= 0;
		int rowGrowLength					= 0;
		int bowlerSrNo						= 1;
		int no								= 1;
		HashMap fallWktMap					= new HashMap();
		HashMap matchSummeryMap 			= new HashMap();
		String inningName = "";
%>
<% 	// session.setAttribute("matchid","117");
	 matchId = (String)session.getAttribute("matchid");
	 GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	 inningIdOne = request.getParameter("inningIdOne");
	 inningIdTwo = request.getParameter("inningIdTwo");
	 firstinningbattingteam  = request.getParameter("firstinningbattingteam");
	 secondinningbattingteam  = request.getParameter("secondinningbattingteam");
	 LogWriter log =  new LogWriter();
	// firstinningbattingteam  = (String) session.getAttribute("firstinningbattingteam");
	// secondinningbattingteam = (String)session.getAttribute("secondinningbattingteam");
%>
<% if (firstinningbattingteam!=null){
%>
				<table align=left height=0.1%>
					<tr>
						<td>FirstInning: <%=firstinningbattingteam%></td>
					</tr>
				</table>	
<%
	}
%>
<% if (secondinningbattingteam!=null){
%>
				<table align=left height=0.1%>
					<tr>
						<td>SecondInning: <%=secondinningbattingteam%></td>
					</tr>
				</table>	
<%
	}
%>
<br>
<table align=center border=1 width=100% style=border-collapse:collapse>
						<tr>
							<%--First <TD> start here	--%>
							<td>
									<table width="100%"  height="20%" border=1 style=border-collapse:collapse>
										<tr class=firstrow>
											<td rowspan="2" colspan="2" align=center nowrap ><font size=1>BATTING<br> ORDER</td>
										</tr>
										<tr class=firstrow>
											<td colspan="2" align=center ><font size=1>TIME</td>
											<td rowspan="2" align=center ><font size=1>BATSMEN <br>NAMES</td>
											<td rowspan="2" align=center ><font size=1>HOW <br>OUT</td>
											<td colspan="2" align=center ><font size=1>NAME OF </td>
											<td rowspan="2" align=center ><font size=1>Mins</td>
											<td colspan="3" align=center ><font size=1>TOTAL <br>NO OF</td>
											<td rowspan="2" align=center ><font size=1>Runs</td>
										</tr>
										<tr class=firstrow>
											<td align=center><font size=1>1ST</td>
											<td align=center><font size=1>2ND </td>
											<td align=center><font size=1>IN</td>
											<td align=center><font size=1>OUT </td>
											<td align=center><font size=1>FIELDER</td>
											<td align=center><font size=1>BOWLER</td>
											<td align=center><font size=1>4s</td>
											<td align=center><font size=1>6s</td>
											<td align=center><font size=1>Balls</td>
										</tr>
<%  vparam.add(inningIdTwo);
	firstBatsInningSecondCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scoreshett_battingscorercard",vparam,"ScoreDB");
	vparam.removeAllElements();
	subTotal = 0;
	try{
		if(firstBatsInningSecondCrs!=null  && firstBatsInningSecondCrs.size() > 0 ){
			while (firstBatsInningSecondCrs.next()){	
				if (!(firstBatsInningSecondCrs.getString("howout").equalsIgnoreCase("DNB")))	{
					matchSummeryMap.put(firstBatsInningSecondCrs.getString("batsmanid"),no);
					no = no + 1;
				}	
			}
		}
	}catch(Exception e)	{
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>												
<%	
	vparam.add(inningIdOne);
	firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scoreshett_battingscorercard",vparam,"ScoreDB");
	vparam.removeAllElements();
	no = 1;
	try{
		if(firstBatsInningFirstCrs!=null && firstBatsInningFirstCrs.size() > 0){
			while (firstBatsInningFirstCrs.next()){
				 timeIn		= firstBatsInningFirstCrs.getString("timein")!=null?firstBatsInningFirstCrs.getString("timein"):"";
				 timeOut 	= firstBatsInningFirstCrs.getString("timeout")!=null?firstBatsInningFirstCrs.getString("timeout"):"";
				 srNo		= firstBatsInningFirstCrs.getString("srno")!=null?firstBatsInningFirstCrs.getString("srno"):"";
				 batsman	= firstBatsInningFirstCrs.getString("batsman")!=null?firstBatsInningFirstCrs.getString("batsman"):"";
				 howOut		= firstBatsInningFirstCrs.getString("howout")!=null?firstBatsInningFirstCrs.getString("howout"):"";     
				 fielder 	= firstBatsInningFirstCrs.getString("fielder")!=null?firstBatsInningFirstCrs.getString("fielder"):"";   
				 bowler		= firstBatsInningFirstCrs.getString("bowler")!=null?firstBatsInningFirstCrs.getString("bowler"):"";      
				 mins 		= firstBatsInningFirstCrs.getString("mins")!=null || (!(firstBatsInningFirstCrs.getString("mins").trim().equalsIgnoreCase("-1"))) ?firstBatsInningFirstCrs.getString("mins"):"";      
				 four		= firstBatsInningFirstCrs.getString("fours")!=null || (!(firstBatsInningFirstCrs.getString("fours").trim().equalsIgnoreCase("-1"))) ?firstBatsInningFirstCrs.getString("fours"):"";   
				 six		= firstBatsInningFirstCrs.getString("six")!=null || (!(firstBatsInningFirstCrs.getString("six").trim().equalsIgnoreCase("-1")))?firstBatsInningFirstCrs.getString("six"):""; 
				 balls 		= firstBatsInningFirstCrs.getString("balls")!=null || (!(firstBatsInningFirstCrs.getString("balls").trim().equalsIgnoreCase("-1")))?firstBatsInningFirstCrs.getString("balls"):"";      
				 runs 		= firstBatsInningFirstCrs.getString("runs")!=null || (!(firstBatsInningFirstCrs.getString("runs").trim().equalsIgnoreCase("-1")))?firstBatsInningFirstCrs.getString("runs"):"0";   
				 fallWktMap.put(firstBatsInningFirstCrs.getString("batsmanid"),no);
				 batsmanId  = firstBatsInningFirstCrs.getString("batsmanid")!=null?firstBatsInningFirstCrs.getString("batsmanid"):"";
				 if (matchSummeryMap.containsKey(batsmanId) ){
							batsSrNo = matchSummeryMap.get(batsmanId).toString();
				 }
				 else{
				 			batsSrNo = "";
				 }
			 	// subTotal   = subTotal + Integer.parseInt(runs);
			 	
			 	if(firstBatsInningFirstCrs.getString("mins").trim().equals("-1")){
					mins = "";
				}
				if(firstBatsInningFirstCrs.getString("fours").trim().equals("-1")){
					four = "";
				}
				if(firstBatsInningFirstCrs.getString("six").trim().equals("-1")){
					six = "";
				}
				if(firstBatsInningFirstCrs.getString("balls").trim().equals("-1")){
					balls = "";
				}
				if(firstBatsInningFirstCrs.getString("runs").trim().equals("-1")){
					runs = "";
				}

%>		
										<tr>
											<td  nowrap align=center><font color="#003399" size=1><%=no%></td>
											<td  nowrap align=center><font color="#003399" size=1><%=batsSrNo%></td>
											<td  nowrap align=right><font color="#003399" size=1><%=timeIn%></td>
											<td  nowrap align=right><font color="#003399" size=1><%=timeOut%></td>
											<td  nowrap ><font color="#003399" size=1><%=batsman%></td>
<%
	if (howOut.equalsIgnoreCase("N.O.")){
%>											
											<td  nowrap ><font color="red" size=1><%=howOut%></td>
<%
	}else{
%>											
											<td  nowrap ><font color="#003399" size=1><%=howOut%></td>
<%
	}
%>											
											<td  nowrap ><font color="#003399" size=1><%=fielder%></td>
											<td  nowrap ><font color="#003399" size=1><%=bowler%></td>
											<td  nowrap align=right><font color="#003399" size=1><%=mins%></td>
											<td  nowrap align=right><font color="#003399" size=1><%=four%></td>
											<td  nowrap align=right><font color="#003399" size=1><%=six%></td>
											<td  nowrap align=right><font color="#003399" size=1><%=balls%></td>
											<td  nowrap align=right><font color="#003399" size=1><%=runs%></td>
										</tr>
<%				no = no+1;
			}
		  }
		  else{	
	 			for (k=0 ; k<=10 ; k++){													
	 						
%>
										<tr>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
											<td  nowrap ></td>
										</tr>
<%	 		
	 			}					
	 	 
%>			
<%		 }
	 }	catch(Exception e){
		  log.writeErrLog(page.getClass(),matchId,e.toString());
	 	}
%>	
<%
	vparam.add(inningIdOne);
	firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total",vparam,"ScoreDB");
	vparam.removeAllElements();
	int firstInningWkt = 0;
		try{
			if (firstBatsInningFirstCrs!=null){
				while (firstBatsInningFirstCrs.next()){
					byes 			= firstBatsInningFirstCrs.getString("byes")!=null?firstBatsInningFirstCrs.getString("byes"):"0";      
					legByes			= firstBatsInningFirstCrs.getString("legbyes")!=null?firstBatsInningFirstCrs.getString("legbyes"):"0" ;     
					noBall 			= firstBatsInningFirstCrs.getString("noballs")!=null?firstBatsInningFirstCrs.getString("noballs"):"0" ;
					wide			= firstBatsInningFirstCrs.getString("wides")!=null?firstBatsInningFirstCrs.getString("wides"):"0" ;  
					battingSubTotal = firstBatsInningFirstCrs.getString("subtotal")!=null?firstBatsInningFirstCrs.getString("subtotal"):"0";
					totalExtras 	= firstBatsInningFirstCrs.getString("total_extra")!=null?firstBatsInningFirstCrs.getString("total_extra"):"0";
					penaltyExtras 	= firstBatsInningFirstCrs.getString("penalty")!=null?firstBatsInningFirstCrs.getString("penalty"):"0" ; 
					matchTotalRun	= firstBatsInningFirstCrs.getString("total_score")!=null?firstBatsInningFirstCrs.getString("total_score"):"0" ;
					matchTotalWkt	= firstBatsInningFirstCrs.getString("wicket")!=null?firstBatsInningFirstCrs.getString("wicket"):"0" ;
					matchTotalOver	= firstBatsInningFirstCrs.getString("overs")!=null?firstBatsInningFirstCrs.getString("overs"):"0" ;	
					//penaltyReason = firstBatsInningFirstCrs.getString("penaltyreason")!=null?firstBatsInningFirstCrs.getString("penaltyreason"):"";
				
					firstInningWkt			  = Integer.parseInt(matchTotalWkt);
					firstInningExtrasTotal    = Integer.parseInt(byes)+
				   				     		    Integer.parseInt(legByes)+	
							  			        Integer.parseInt(penaltyExtras);
					tExtras    				  = Integer.parseInt(byes)+
		  				     					Integer.parseInt(legByes)+	
		 						  			    Integer.parseInt(penaltyExtras) +
											    Integer.parseInt(wide)+
										     	Integer.parseInt(noBall);
					grandTotal = Integer.parseInt(battingSubTotal) + tExtras;
					//System.out.println("grandTotal" +grandTotal);
				}
			}
		}catch(Exception e)	{
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	
%>
<%
	vparam.add(inningIdTwo);
	firstBatsInningSecondCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total",vparam,"ScoreDB");
	vparam.removeAllElements();
	int secondInningWkt = 0;
	
		if (firstBatsInningSecondCrs!=null){
			try{
				while (firstBatsInningSecondCrs.next()){
					secondInningByes 			= firstBatsInningSecondCrs.getString("byes")!=null?firstBatsInningSecondCrs.getString("byes"):"0";      
					secondInningLegByes			= firstBatsInningSecondCrs.getString("legbyes")!=null?firstBatsInningSecondCrs.getString("legbyes"):"0";        
					secondInningPenaltyExtras 	= firstBatsInningSecondCrs.getString("penalty")!=null?firstBatsInningSecondCrs.getString("penalty"):"0";     
					secondInningMatchTotalWkt	= firstBatsInningSecondCrs.getString("wicket")!=null?firstBatsInningSecondCrs.getString("wicket"):"0" ;
					//penaltyReason = firstBatsInningFirstCrs.getString("penaltyreason")!=null?firstBatsInningFirstCrs.getString("penaltyreason"):"";
					//secondInningWkt			    = Integer.parseInt(matchTotalWkt);
					secondInningExtrasTotal     = Integer.parseInt(secondInningByes)+
				   				     		      Integer.parseInt(secondInningLegByes)+	
							  			          Integer.parseInt(secondInningPenaltyExtras);
					secondInningWkt 		    = Integer.parseInt(secondInningMatchTotalWkt);
					secondInningExtrasTotal 	= Integer.parseInt(secondInningByes)+
				   				     		      Integer.parseInt(secondInningLegByes)+	
							  			          Integer.parseInt(secondInningPenaltyExtras);
				
				}
			}catch(Exception e)	{
				 log.writeErrLog(page.getClass(),matchId,e.toString());
			}
		}
%>

										<tr>
											<td colspan=5 nowrap ><font size=1>12th Man</b> <font color="#003399"><%=twelveman%></td>
										</tr>
										<tr>	
											<td colspan=5 nowrap ><font size=1>Reserves</td>
											<td colspan=2 nowrap ><font size=1>Penalty Extras</b> :<font color="#003399"><%=penaltyExtras%></font></td>
											<td nowrap align=right><font size=1> Byes:</b>
											<font color="#003399"><%=byes%></td>
											<td></td>
											<td colspan=3 nowrap align=center ><font size=1>SubTotal</td>
											<td align=right nowrap><font color="#003399"  ><%=battingSubTotal%></td>
										</tr>
										<tr>	
											<td colspan=5 nowrap align=center ><font color="#003399"><%=reservePlayerOne%></td>
											<td colspan=2 nowrap>
											</td>
											<td nowrap align=right><font size=1>Leg Byes:</b> <font color="#003399"><%=legByes%></td>
											<td></td>
											<td colspan=3 nowrap align=center ><font size=1>Total Extras:</b></td>
											<td align=right nowrap ><font color="#003399"><%=tExtras%></td>
										</tr>
										<tr>	
											<td colspan=5 nowrap align=center ><font color="#003399"><%=reservePlayerTwo%></td>
											<td colspan=2 nowrap align=center ></td>
											<td nowrap align=right ><font size=1>No Balls :</b><font color="#003399"><%=noBall%></td>
											<td></td>
											<td colspan=3 rowspan=2 align=center nowrap><font size=1>Grand Total</b></td>
											<td align=right rowspan=2 nowrap><font color="#003399"><%=grandTotal%></td>
										</tr>
										<tr>
											<td colspan=5 align=center nowrap><font color="#003399"><%=reservePlayerThree%></td>
											<td colspan=2 align=center nowrap></td>
											<td align=right nowrap><font size=1>Wides</b> :<font color="#003399"><%=wide%></td>
											<td></td>
										</tr>
										<tr>
											<td colspan=8 nowrap ><font size=1>Total time taken for 1st innings</font></b><font color="#003399">
											</font><font size=1>mins</font></b> ;</font>
											<font size=1>Overs</font></b> <font color="#003399"><%=matchTotalOver%></td>
											<td></td>
											<td colspan=3 nowrap align=center ><font size=1>Wickets Lost</b></td>
											<td nowrap align=right><font color="#003399"  ><%=matchTotalWkt%></td>
										</tr>
										<tr>
											<td colspan=8 nowrap ><font size=1>2nd New ball claimed at Overs:</font></b>
											<font color="#003399"><%=secondNewBallOver%></font>
											<font size=1>Score </font></b>
											<font color="#003399"><%=secondNewBallScore%></td>
											<td></td>
											<td colspan=3 nowrap align=center ><font size=1>Overs Short</b></td>
											<td  nowrap align=right><font color="#003399"><%=shortOvers%></td>
										</tr>
										<tr>
											<td colspan=8 nowrap><font size=1>3rd New ball claimed at Overs:</b></font>
											<font color="#003399">
											<%=thirdNewBallOver%></font> <font size=1> Score</font></b>
											<font color="#003399"><%=thirdNewBallScore%></font></td>
											<td></td>
											<td colspan=3 nowrap align=center></td>
											<td></td>
										</tr>
									</table>
									<table width=100% >
										<tr>
											<td colspan=13 nowrap ><font size=1>2nd New ball Batsman:</font>
											</b>
										
											<font color="#003399"><%=secondNewBallBats%></font>
											<font size=1>Bowler:</font></b>  <font color="#003399"><%=secondNewBallBowl%></font>
											
											<font size=1>3rd New ball Batsman:</font></b>
											<font color="#003399"><%=thirdNewBallBats%>
											</font>
											
											<font size=1>Bowlers:</font></b>;<font color="#003399"><%=thirdNewBallBats%></font></td>
										</tr>	
										<tr>
											<td colspan=13>
												<table width=100% border=1> 
														<tr>
															<td nowrap><font size=1>Penalty Reason</b></td>
														</tr>
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
															<td nowrap ><font color="#003399"><%=penaltyDescription%></font></td>
														</tr>
<%
		  }
  		}
  	}catch(Exception e){
  		log.writeErrLog(page.getClass(),matchId,e.toString());
  	}
%>
												</table>
											</td>
										</tr>
								 	</table>
							 	
								 	<table width="50%"  border="1" style=border-collapse:collapse>
												<table border=1 width=100%>
														<tr class=firstrow>
															<td colspan=2 align=center nowrap><font size=1>BOWLING ORDER</td>
															<td colspan=2 align=center nowrap><font size=1>BOWLER</td>
															<td colspan=6 align=center nowrap><font size=1>1ST INNINGS</td>
															<td colspan=6 align=center nowrap><font size=1>2ND INNINGS</td>
														</tr>
														<tr>
															<td align=center  nowrap><font size=1>1ST</td>
															<td align=center  nowrap><font size=1>2ND</td>
															<td align=center  nowrap><font size=1>Type</td>
															<td align=center  nowrap><font size=1>Names</td>
															<td align=center  nowrap><font size=1>Overs</td>
															<td align=center  nowrap><font size=1>Mdns.</td>
															<td align=center  nowrap><font size=1>Runs</td>
															<td align=center  nowrap><font size=1>Wkts</td>
															<td align=center  nowrap><font size=1>NB</td>
															<td align=center  nowrap><font size=1>WB</td>
															<td align=center  nowrap><font size=1>Overs</td>
															<td align=center  nowrap><font size=1>Mdns.</td>
															<td align=center  nowrap><font size=1>Runs</td>
															<td align=center  nowrap><font size=1>Wkts</td>
															<td align=center  nowrap><font size=1>NB</td>
															<td align=center  nowrap><font size=1>WB</td>
														</tr>
														
<%	//vparam.add("133");
	vparam.add(session.getAttribute("matchid"));
	vparam.add(inningIdOne);
	vparam.add(inningIdTwo);
	bowledAnalysisCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowlinganalysisfortestmatch",vparam,"ScoreDB");	
	vparam.removeAllElements();
	crsSize = bowledAnalysisCrs.size();
	rowGrowLength = 11 - crsSize;
	float secondTotalOver   		= 0;
	int secondTotalMaiden 		= 0;
	int secondTotalRun	  		= 0;
	int secondTotalWkt    		= 0;
	int secondTotalNB 	  		= 0;
    int secondTotalWB     		= 0;
    int firstInningBowlerWicket = 0;
    int secondInningBowlerWicket= 0;  
	int firstInningTotalWicket  = 0;
	int secondInningTotalWicket	= 0;
	if(bowledAnalysisCrs!=null){
	try{
		while (bowledAnalysisCrs.next()){
			bowlerName 			= bowledAnalysisCrs.getString("bowlername")!=null?bowledAnalysisCrs.getString("bowlername"):"";
			bowlerId			= bowledAnalysisCrs.getString("inningtwo")!=null?bowledAnalysisCrs.getString("inningtwo"):"";
			bowlerOver  		= bowledAnalysisCrs.getString("noofover")!=null?bowledAnalysisCrs.getString("noofover"):"0";
			bowlerMaiden		= bowledAnalysisCrs.getString("maiden")!=null?bowledAnalysisCrs.getString("maiden"):"0";
			bowlerRunrate		= bowledAnalysisCrs.getString("runs")!=null?bowledAnalysisCrs.getString("runs"):"0";
			bowlerWicket		= bowledAnalysisCrs.getString("wicket")!=null?bowledAnalysisCrs.getString("wicket"):"0";
			bowlerNB			= bowledAnalysisCrs.getString("noball")!=null?bowledAnalysisCrs.getString("noball"):"0";
			bowlerWB			= bowledAnalysisCrs.getString("wideball")!=null?bowledAnalysisCrs.getString("wideball"):"0";
			
			secondBowlerOver	= bowledAnalysisCrs.getString("noofover_1")!=null?bowledAnalysisCrs.getString("noofover_1"):"0";
			secondBowlerMaiden	= bowledAnalysisCrs.getString("maiden_1")!=null?bowledAnalysisCrs.getString("maiden_1"):"0";
			secondBowlerRunrate	= bowledAnalysisCrs.getString("runs_1")!=null?bowledAnalysisCrs.getString("runs_1"):"0";
			secondBowlerWicket	= bowledAnalysisCrs.getString("wicket_1")!=null?bowledAnalysisCrs.getString("wicket_1"):"0";
			secondBowlerNB		= bowledAnalysisCrs.getString("noball_1")!=null?bowledAnalysisCrs.getString("noball_1"):"0";
			secondBowlerWB		= bowledAnalysisCrs.getString("wideball_1")!=null?bowledAnalysisCrs.getString("wideball_1"):"0";
			
			totalOver 			= totalOver  + Float.parseFloat(bowlerOver);
			totalMaiden			= totalMaiden+ Integer.parseInt(bowlerMaiden);
			totalRun	    	= totalRun   + Integer.parseInt(bowlerRunrate);
			totalWkt			= totalWkt   + Integer.parseInt(bowlerWicket);
			totalNB 			= totalNB    + Integer.parseInt(bowlerNB);
			totalWB 			= totalWB    + Integer.parseInt(bowlerWB);
			
			firstInningBowlerWicket = firstInningWkt - totalWkt ;
			
			secondTotalOver 	= secondTotalOver   + Float.parseFloat(secondBowlerOver);
			secondTotalMaiden	= secondTotalMaiden + Integer.parseInt(secondBowlerMaiden);
			secondTotalRun	    = secondTotalRun    + Integer.parseInt(secondBowlerRunrate);
			secondTotalWkt		= secondTotalWkt    + Integer.parseInt(secondBowlerWicket);
			secondTotalNB 		= secondTotalNB     + Integer.parseInt(secondBowlerNB);
			secondTotalWB 		= secondTotalWB     + Integer.parseInt(secondBowlerWB);
			
			secondInningBowlerWicket = secondInningWkt - secondTotalWkt ;
			
			

%>  
												
													
														<tr>
															<td align=center  nowrap><font color="#003399"  size=1><%=bowlerSrNo%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=bowlerId%></td>
															<td align=right  nowrap><font size=1></td>
															<td nowrap><font color="#003399" font size=1><%=bowlerName%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=bowlerOver%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=bowlerMaiden%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=bowlerRunrate%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=bowlerWicket%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=bowlerNB%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=bowlerWB%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=secondBowlerOver%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=secondBowlerMaiden%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=secondBowlerRunrate%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=secondBowlerWicket%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=secondBowlerNB%></td>
															<td align=right  nowrap><font color="#003399"  size=1><%=secondBowlerWB%></td>
														</tr>

<%
			bowlerSrNo++;
			}
		  }	
		  catch(Exception e){ 
			 log.writeErrLog(page.getClass(),matchId,e.toString());
		  }
		}
%>
<%
	for (k=0 ; k<rowGrowLength ; k++){													
%>
			
														<tr>
															<td align=center  nowrap><font color="#003399"  size=1><%=bowlerSrNo%></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
														</tr>
<%
		bowlerSrNo++;	
	}
%>														
														<tr>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap ><font color="#003399"  size=1>SubTotal</td>
															<td align=center  nowrap><font color="#003399"   size=1><%=totalOver%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=totalMaiden%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=totalRun%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=totalWkt%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=totalNB%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=totalWB%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=secondTotalOver%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=secondTotalMaiden%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=secondTotalRun%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=secondTotalWkt%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=secondTotalNB%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=secondTotalWB%></td>
														</tr>		
															
														<tr>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"  size=1>Byes/LegByes/Wkt</td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=firstInningExtrasTotal%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=firstInningBowlerWicket%></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=secondInningExtrasTotal%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=secondInningBowlerWicket%></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
														</tr>											
														
<%	extraPlusTotalRun	   = totalRun + firstInningExtrasTotal;
	firstInningTotalWicket = firstInningBowlerWicket + totalWkt ;
%>	
<%
	secondExtraPlusTotalRun     = secondTotalRun + secondInningExtrasTotal;
	secondInningTotalWicket     = secondInningBowlerWicket + secondTotalWkt;
%>													
														<tr>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"  size=1>GrandTotal</td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=extraPlusTotalRun%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=firstInningTotalWicket%></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=secondExtraPlusTotalRun%></td>
															<td align=center  nowrap><font color="#003399"  size=1><%=secondInningTotalWicket%></td>
															<td align=center  nowrap><font color="#003399"></td>
															<td align=center  nowrap><font color="#003399"></td>
														</tr>			
												</table>
								</td>
					<%-- First <TD> ends here	--%>
					<%-- Second <TD> start here --%>
							<td>
								<table width="100%"  border="1" style=border-collapse:collapse>
										<tr class=firstrow>
											<td colspan="2" align=center ><font size=1>TIME</td>
											<td rowspan="2" align=center ><font size=1>HOW <br>OUT</td>
											<td colspan="2" align=center ><font size=1>NAME OF </td>
											<td rowspan="2" align=center ><font size=1>Mins</td>
											<td colspan="3" align=center ><font size=1>TOTAL <br> NO OF</td>
											<td rowspan="2" align=center ><font size=1>Runs</td>
										</tr>
										<tr class=firstrow>
											<td align=center ><font size=1>IN</td>
											<td align=center ><font size=1>OUT </td>
											<td align=center ><font size=1>FIELDER</td>
											<td align=center ><font size=1>BOWLER</td>
											<td align=center ><font size=1>4s</td>
											<td align=center ><font size=1>6s</td>
											<td align=center ><font size=1>Balls</td>
										</tr>
<%	vparam.add(session.getAttribute("matchid"));
	vparam.add(inningIdOne);
	vparam.add(inningIdTwo);
	firstBatsInningSecondCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battinganalysisfortestmatch",vparam,"ScoreDB");
	vparam.removeAllElements();
	subTotal = 0;
	k = 0;
	try{
		if(firstBatsInningSecondCrs!=null  && firstBatsInningSecondCrs.size() > 0 ){
			while (firstBatsInningSecondCrs.next()){
				 timeIn		= firstBatsInningSecondCrs.getString("timein_2")!=null?firstBatsInningSecondCrs.getString("timein_2"):"";
				 timeOut 	= firstBatsInningSecondCrs.getString("timeout_2")!=null?firstBatsInningSecondCrs.getString("timeout_2"):"";
				// srNo		= firstBatsInningSecondCrs.getString("srno")!=null?firstBatsInningSecondCrs.getString("srno"):"";
				 batsman	= firstBatsInningSecondCrs.getString("batsman")!=null?firstBatsInningSecondCrs.getString("batsman"):"";
				 howOut		= firstBatsInningSecondCrs.getString("howout_2")!=null?firstBatsInningSecondCrs.getString("howout_2"):"";
				 fielder 	= firstBatsInningSecondCrs.getString("fielder_2")!=null?firstBatsInningSecondCrs.getString("fielder_2"):"";
				 bowler		= firstBatsInningSecondCrs.getString("bowler_2")!=null?firstBatsInningSecondCrs.getString("bowler_2"):""; 
				 mins 		= firstBatsInningSecondCrs.getString("mins_2")!=null?firstBatsInningSecondCrs.getString("mins_2"):"";
				 four		= firstBatsInningSecondCrs.getString("fours_2")!=null?firstBatsInningSecondCrs.getString("fours_2"):"";
				 six		= firstBatsInningSecondCrs.getString("six_2")!=null?firstBatsInningSecondCrs.getString("six_2"):"";
				 balls 		= firstBatsInningSecondCrs.getString("balls_2").trim()!=null?firstBatsInningSecondCrs.getString("balls_2").trim():"";
				 runs 		= firstBatsInningSecondCrs.getString("runs_2")!=null?firstBatsInningSecondCrs.getString("runs_2"):"0";  
				 //subTotal   = subTotal + Integer.parseInt(runs);
				    
%>		
										<tr>
											<td align=right nowrap ><font color="#003399"  size=1><%=timeIn%></td>
											<td align=right nowrap ><font color="#003399"  size=1><%=timeOut%></td>
<%
	if (howOut.equalsIgnoreCase("N.O.")){
%>											
											<td  nowrap ><font color="red" size=1><%=howOut%></td>
<%
	}else{
%>											
											<td  nowrap ><font color="#003399" size=1><%=howOut%></td>
<%
	}
%>											
											
											<td nowrap ><font color="#003399"  size=1><%=fielder%></td>
											<td nowrap ><font color="#003399"  size=1><%=bowler%></td>
											<td align=right nowrap ><font color="#003399"  size=1><%=mins%></td>
											<td align=right nowrap ><font color="#003399"  size=1><%=four%></td>
											<td align=right nowrap ><font color="#003399"  size=1><%=six%></td>
											<td align=right nowrap ><font color="#003399"  size=1><%=balls%></td>
											<td align=right nowrap ><font color="#003399"  size=1><%=runs%></td>
										</tr>
<%
						
			}
		}else{	
	 			for (k=0 ; k<=10 ; k++){													
%>
										<tr>
											<td align=center nowrap ></td>
											<td align=center nowrap ></td>
											<td align=center nowrap ></td>
											<td align=center nowrap ></td>
											<td align=center nowrap ></td>
											<td align=center nowrap ></td>
											<td align=center nowrap ></td>
											<td align=center nowrap ></td>
											<td align=center nowrap ></td>
											<td align=center nowrap ></td>
											
										</tr>
<%
				}
		  }
		}catch(Exception e){
		 	 log.writeErrLog(page.getClass(),matchId,e.toString());
		  }
	 	 
%>	
<%
	vparam.add(inningIdTwo);
	firstBatsInningSecondCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total",vparam,"ScoreDB");
	vparam.removeAllElements();
	tExtras = 0;
	grandTotal = 0;
		if (firstBatsInningSecondCrs!=null){
			try{
				while (firstBatsInningSecondCrs.next()){
					byes 			= firstBatsInningSecondCrs.getString("byes")!=null?firstBatsInningSecondCrs.getString("byes"):"0";      
					legByes			= firstBatsInningSecondCrs.getString("legbyes")!=null?firstBatsInningSecondCrs.getString("legbyes"):"0";        
					noBall 			= firstBatsInningSecondCrs.getString("noballs")!=null?firstBatsInningSecondCrs.getString("noballs"):"0";    
					wide			= firstBatsInningSecondCrs.getString("wides")!=null?firstBatsInningSecondCrs.getString("wides"):"0";    
					battingSubTotal = firstBatsInningSecondCrs.getString("subtotal")!=null?firstBatsInningSecondCrs.getString("subtotal"):"0";    
					totalExtras 	= firstBatsInningSecondCrs.getString("total_extra")!=null?firstBatsInningSecondCrs.getString("total_extra"):"0";     
					penaltyExtras 	= firstBatsInningSecondCrs.getString("penalty")!=null?firstBatsInningSecondCrs.getString("penalty"):"0";     
					matchTotalRun	= firstBatsInningSecondCrs.getString("total_score")!=null?firstBatsInningSecondCrs.getString("total_score"):"0";    
					matchTotalWkt	= firstBatsInningSecondCrs.getString("wicket")!=null?firstBatsInningSecondCrs.getString("wicket"):"0";    
					matchTotalOver	= firstBatsInningSecondCrs.getString("overs")!=null?firstBatsInningSecondCrs.getString("overs"):"0";    
					//penaltyReason = firstBatsInningFirstCrs.getString("penaltyreason")!=null?firstBatsInningFirstCrs.getString("penaltyreason"):"";
				
					tExtras    = Integer.parseInt(byes)+
							     Integer.parseInt(legByes)+	
				  			     Integer.parseInt(penaltyExtras) +
							     Integer.parseInt(wide)+
							     Integer.parseInt(noBall);
					grandTotal = Integer.parseInt(battingSubTotal) + tExtras;
				}
			}catch(Exception e)	{
				 log.writeErrLog(page.getClass(),matchId,e.toString());
			}
		}
%>

										
										<tr>
											<td colspan=5 nowrap >&nbsp;</td>
										</tr>
										<tr>	
												<td colspan=4 nowrap  ><font size=1 >Penalty Extras</b> :<font color="#003399"><%=penaltyExtras%></td>
												<td nowrap align=right ><font size=1 >Byes:</b> 
												<font color="#003399"><%=byes%></font></td>
												<td></td>
												<td colspan=3 nowrap align=center ><font size=1 >SubTotal</b></td>
												<td align=right nowrap><font color="#003399"><%=battingSubTotal%></font></td>
										</tr>
										<tr>	
												<td colspan=4 nowrap ></td>
												<td nowrap align=right><font size=1 >Leg Byes:</b><font color="#003399"><%=legByes%></font></td>
												<td></td>
												<td nowrap align=center colspan=3 ><font size=1 >Total Extras:</b></td>
												<td align=right nowrap><font color="#003399"><%=tExtras%></font></td>
										</tr>
										<tr>	
												<td colspan=4 nowrap align=center ></td>
												<td nowrap align=right><font size=1 >No Balls :</b> <font color="#003399"><%=noBall%></font></td>
												<td></td>
												<td rowspan=2 colspan=3 align=center ><font size=1 >Grand Total</b></td>
												<td align=right nowrap rowspan=2><font color="#003399"><%=grandTotal%></font></td>
										</tr>
										<tr>
												<td colspan=2 align=center ></td>
												<td colspan=2 align=center ></td>
												<td align=right ><font size=1 >Wides</b> :<font color="#003399"><%=wide%></font></td>
												<td></td>
										</tr>
										<tr>
												<td colspan=5 ><font size=1>Total time for 2nd innings:</font></b><font color="#003399">
												</font><font size=1>mins</font></b> ;</font>
												Overs </b><font color="#003399"><%=matchTotalOver%></font></td>
												<td></td>
												<td colspan=3 nowrap align=center ><font size=1 >Wickets Lost</b></td>
												<td align=right nowrap><font color="#003399"><%=matchTotalWkt%></font></td>
										</tr>
										<tr>
												<td colspan=5 nowrap ><font size=1>2nd New ball claimed at Overs:</font></b>
												
												<font color="#003399"><%=secondNewBallOver%></font>
												
												<font size=1>Score </font></b>
												<font color="#003399"><%=secondNewBallScore%></font></td>
												<td></td>
												<td colspan=3 nowrap align=center ><font size=1 >Overs Short</b></td>
												<td align=right nowrap><font color="#003399"><%=shortOvers%></font></td>
										</tr>
										<tr>
												<td colspan=5 ><font size=1>3rd New ball claimed at Overs:</font></b>
												<font color="#003399">
												<%=thirdNewBallOver%></font> <font size=1>Score</font></b>
												<font color="#003399"><%=thirdNewBallScore%></font></td>
												<td></td>
												<td colspan=3 nowrap align=center font size=1 ></td>
										</tr>
									</table>
									<table width=100% border=1>	
										<tr>
												<td colspan=13 nowrap ><font size=1>2nd New ball Batsman:</font>
												</b>
												<font color="#003399"><%=secondNewBallBats%> </font> 
												<font size=1>Bowler:</font></b> ; <font color="#003399"><%=secondNewBallBowl%></font>
												
												<font size=1>3rd New ball Batsman:</font></b>
												<font color="#003399"><%=thirdNewBallBats%> </font>
												
												<font size=1>Bowlers:</font></b><font color="#003399"><%=thirdNewBallBats%></font></td>
										</tr>
										<tr>
											<td colspan=13>
												<table width=100%> 
														<tr>
															<td ><font size=1 >Penalty Reason</b></td>
														</tr>
<%
	vparam.add(inningIdTwo);
	penaltyReasonCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_penaltyreason",vparam,"ScoreDB");
	vparam.removeAllElements();	
	try{
		if(penaltyReasonCrs!=null){
			while(penaltyReasonCrs.next()){
					penaltyDescription = penaltyReasonCrs.getString("description")!=null?penaltyReasonCrs.getString("description"):"";
%>							
														<tr>
															<td nowrap ><font color="#003399" size=1><%=penaltyDescription%></font></td>
														</tr>
<%
	 	 }
 	 }
   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
   }		  		
%>
												</table>
											</td>
										</tr>
								 	</table>
								 	
								 	<table width="100%"  height="20%" border="1" style="border-collapse:collapse">
								 		<tr class=firstrow>
								 			<td colspan="12" align=center><font size=1>FALL OF WICKETS</td>
								 		</tr>
								 		<tr class=firstrow>
								 			<td colspan="2"></td>
											<td align=center><font size=1>1</td>
											<td align=center><font size=1>2</td>
											<td align=center><font size=1>3</td>
											<td align=center><font size=1>4</td>
											<td align=center><font size=1>5</td>
											<td align=center><font size=1>6</td>
											<td align=center><font size=1>7</td>
											<td align=center><font size=1>8</td>
											<td align=center><font size=1>9</td>
											<td align=center><font size=1>10</td>
								 		</tr>
								 		<tr>
								 			<td rowspan="5" align=center><font size=1>1 <br>st<br>I<br>n<br>n<br>i<br>n<br>g<br>s</td>
								 			<td align=center align=center><font size=1>Runs</td>
							
							<%  vparam.add(inningIdOne);
								firstInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
								fallOfWicketInningOne = firstInningFirstBatsFallWicketCrs;
								crsSize = firstInningFirstBatsFallWicketCrs.size();
								rowGrowLength =  10 - crsSize ;
								vparam.removeAllElements();
								if (firstInningFirstBatsFallWicketCrs !=null){
									try{
										while (firstInningFirstBatsFallWicketCrs.next()){
											wktRun = firstInningFirstBatsFallWicketCrs.getString("runs")!=null?firstInningFirstBatsFallWicketCrs.getString("runs"):"";
							%>
								 			<td align=right><font color="#003399"  size=1><%=wktRun%></td>
							<%
										}
									}catch(Exception e){
										log.writeErrLog(page.getClass(),matchId,e.toString());
									}
								}

							%>
							<%
								for (k = 0 ; k < rowGrowLength ; k++){
							%>
										<td></td>
							<%
								}
							%>
							
				
								  		</tr>
								  		<tr>
								 			<td align=center align=center><font size=1>Overs</td>
							<%  //vparam.add(inningIdOne);
								//firstInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
								//vparam.removeAllElements();
								crsSize = firstInningFirstBatsFallWicketCrs.size();
								rowGrowLength =  10 - crsSize ;
								fallOfWicketInningOne.beforeFirst();
								if (fallOfWicketInningOne !=null){
									try{
										while (fallOfWicketInningOne.next()){
											wktOvers = fallOfWicketInningOne.getString("overs")!=null?fallOfWicketInningOne.getString("overs"):"";
							%>
								 			<td align=right><font color="#003399" size=1><%=wktOvers%></td>
							<%
										}
									}catch(Exception e){
										log.writeErrLog(page.getClass(),matchId,e.toString());
									}	
								}
							%>
							<%
								for (k = 0 ; k < rowGrowLength ; k++){
							%>
										<td></td>
							<%
								}
							%>
							
						
								  		</tr>
								  		<tr>
								 			<td align=center align=center><font size=1>Batsman Out</td>
							
							<%  // vparam.add(inningIdOne);
								// firstInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
								// vparam.removeAllElements();
								 crsSize = firstInningFirstBatsFallWicketCrs.size();
								 rowGrowLength =  10 - crsSize ;
								 fallOfWicketInningOne.beforeFirst();
								 if (fallOfWicketInningOne !=null){
									try{

										 while (fallOfWicketInningOne.next()){
											wktBatsOut = fallOfWicketInningOne.getString("striker")!=null?fallOfWicketInningOne.getString("striker"):"";
											if(fallWktMap.containsKey(wktBatsOut)){
												wktOvers = fallWktMap.get(wktBatsOut).toString();												

											}
							%>
											<td align=right><font color="#003399" size=1><%=wktOvers%></td>
							<%			}
									}catch(Exception e){
										log.writeErrLog(page.getClass(),matchId,e.toString());
									}
								 }
								
							%>
							<%
								for (k = 0 ; k < rowGrowLength ; k++){
							%>
										<td></td>
							<%
								}
							%>
							
							
								  		</tr>
								  		<tr>
								 			<td align=center align=center><font size=1>No. of Batsman/Score</td>
							
							<%  // vparam.add(inningIdOne);
								// firstInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
								// vparam.removeAllElements();
								 crsSize = firstInningFirstBatsFallWicketCrs.size();
								 rowGrowLength =  10 - crsSize ;
								 fallOfWicketInningOne.beforeFirst();
								 if (fallOfWicketInningOne !=null){
									try{
										 while (fallOfWicketInningOne.next()){
											wktNoBats = fallOfWicketInningOne.getString("nonstriker")!=null?fallOfWicketInningOne.getString("nonstriker"):"";
											nonstkrun = fallOfWicketInningOne.getString("nonstkrun")!=null?fallOfWicketInningOne.getString("nonstkrun"):"";
											if(fallWktMap.containsKey(wktNoBats)){
												wktOvers = fallWktMap.get(wktNoBats).toString();												
												
											}
											
							%>
								 			<td align=right><font color="#003399" size=1><%=wktOvers%>/<%=nonstkrun%></td>
							<%
										 }
									}catch(Exception e)	{
										log.writeErrLog(page.getClass(),matchId,e.toString());
									}
								 }
							%>
							<%
								for (k = 0 ; k < rowGrowLength ; k++){
							%>
										<td></td>
							<%
								}
							%>
							
								  	
								  		</tr>
								  		<tr>
								 			<td align=center>
													<table border=1 width=100% height=100% style=border-collapse:collapse>
														<tr>
															<td rowspan="2" align=center><font size=1>PartnerShip</td>
															<td align=center colspan=10><font size=1>Mins</td>
														</tr>
														<tr>
															<td align=center colspan=10><font size=1>Balls</td>
														</tr>
													</table>
											</td>
							
							<%   vparam.add(inningIdOne);
								 firstInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_partnershipdtls",vparam,"ScoreDB");
								 vparam.removeAllElements();
								 crsSize = firstInningFirstBatsFallWicketCrs.size();
								 rowGrowLength =  10 - crsSize ;
								 fallOfWicketInningOne.beforeFirst();
								 if (firstInningFirstBatsFallWicketCrs !=null){
									try{
										 while (firstInningFirstBatsFallWicketCrs.next()){
											wktPartMin  = firstInningFirstBatsFallWicketCrs.getString("mins")!=null?firstInningFirstBatsFallWicketCrs.getString("mins"):"";
											wktPartBall = firstInningFirstBatsFallWicketCrs.getString("balls")!=null?firstInningFirstBatsFallWicketCrs.getString("balls"):"";


							%>
							
							
								 			
								 			<td align=center>
												<table border=1 width=100% height=100% style=border-collapse:collapse>
														<tr>
															<td align=right><font color="#003399" size=1><%=wktPartMin%></td>
														</tr>
														<tr>
															<td align=right><font color="#003399" size=1><%=wktPartBall%></td>
														</tr>
														
												</table>
											</td>
								
							<%
										 }
									}catch(Exception e)	{
										log.writeErrLog(page.getClass(),matchId,e.toString());
										
									}
								}
							%>
							
							
									
										</tr>
								  	
										<tr>
								 			<td rowspan="5" align=center><font size=1>2 <br>nd<br>I<br>n<br>n<br>i<br>n<br>g<br>s</td>
								 			<td align=center align=center><font size=1>Runs</td>
							
							<%  vparam.add(inningIdTwo);
								secondInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
								fallOfWicketInningTwo = secondInningFirstBatsFallWicketCrs;
								vparam.removeAllElements();
								crsSize = 0;
								crsSize = secondInningFirstBatsFallWicketCrs.size();
								rowGrowLength =  10 - crsSize ;
								if (secondInningFirstBatsFallWicketCrs !=null){
									try{
										while (secondInningFirstBatsFallWicketCrs.next()){
											wktRun = secondInningFirstBatsFallWicketCrs.getString("runs")!=null? secondInningFirstBatsFallWicketCrs.getString("runs"):"";
							%>
								 			<td align=right><font color="#003399" size=1><%=wktRun%></td>
							<%		
										}
									}catch(Exception e){
										log.writeErrLog(page.getClass(),matchId,e.toString());
									}
								}
							%>
							<%
								for (k = 0 ; k < rowGrowLength ; k++){
							%>
										<td></td>
							<%
								}
							%>
							
							
								  		
								  		</tr>
							  		<tr>

								 			<td align=center align=center><font size=1>Overs</td>
							<%  // vparam.add(inningIdTwo);
								// secondInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
								// vparam.removeAllElements();
								 crsSize = secondInningFirstBatsFallWicketCrs.size();
								 rowGrowLength =  10 - crsSize ;
								 fallOfWicketInningTwo.beforeFirst();
								 if (fallOfWicketInningTwo !=null){
									try{
											while (fallOfWicketInningTwo.next()){
												wktOvers = fallOfWicketInningTwo.getString("overs")!=null?fallOfWicketInningTwo.getString("overs"):"";
							%>
								 				<td align=right><font color="#003399" size=1><%=wktOvers%></td>
							<%
											}
									}catch(Exception e){
										log.writeErrLog(page.getClass(),matchId,e.toString());
									}
								 }
							%>
							<%
								for (k = 0 ; k < rowGrowLength ; k++){
							%>
										<td></td>
							<%
								}
							%>
							
								 			
								  		
								  		</tr>
								  		<tr>
								 			<td align=center align=center><font size=1>Batsman Out</td>
						
							<%  // vparam.add(inningIdTwo);
								// secondInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
								// vparam.removeAllElements();
								 crsSize = secondInningFirstBatsFallWicketCrs.size();
								 rowGrowLength =  10 - crsSize ;
								 fallOfWicketInningTwo.beforeFirst();
								 if (fallOfWicketInningTwo !=null){
									try{
										 while (fallOfWicketInningTwo.next()){
											wktBatsOut = fallOfWicketInningTwo.getString("striker")!=null?fallOfWicketInningTwo.getString("striker"):"";
											
											if(matchSummeryMap.containsKey(wktBatsOut)){
												wktOvers = matchSummeryMap.get(wktBatsOut).toString();												
												
											}
							%>
								 			<td align=right><font color="#003399" font size=1><%=wktOvers%></td>
							<%
										}
									}catch(Exception e){
										log.writeErrLog(page.getClass(),matchId,e.toString());
									}
								 }
							%>
							<%
								for (k = 0 ; k < rowGrowLength ; k++){
							%>
										<td></td>
							<%
								}
							%>
							
								  		
								  		</tr>

								  		<tr>
								 			<td align=center align=center><font size=1>No. of Batsman/Score</td>
							
							<%  // vparam.add(inningIdTwo);
								// secondInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
								// vparam.removeAllElements();
								 crsSize = secondInningFirstBatsFallWicketCrs.size();
								 rowGrowLength =  10 - crsSize ;
								 fallOfWicketInningTwo.beforeFirst();
								 if (fallOfWicketInningTwo !=null){
									try{
										 while (fallOfWicketInningTwo.next()){
											wktNoBats = fallOfWicketInningTwo.getString("nonstriker")!=null?fallOfWicketInningTwo.getString("nonstriker"):"";
											nonstkrun = fallOfWicketInningTwo.getString("nonstkrun")!=null?fallOfWicketInningTwo.getString("nonstkrun"):"";
											if(matchSummeryMap.containsKey(wktNoBats)){
												wktOvers = matchSummeryMap.get(wktNoBats).toString();												
												
											}
							%>
								 			<td align=right><font color="#003399"  size=1><%=wktOvers%>/<%=nonstkrun%></td>
							<%
									   }
									}catch(Exception e){
										log.writeErrLog(page.getClass(),matchId,e.toString());
									}
								 }
							%>
							<%
								for (k = 0 ; k < rowGrowLength ; k++){
							%>
										<td></td>
							<%
								}
							%>
							
								  		
								  		</tr>
								  		<tr>
								 			<td align=center>
													<table border=1 width=100% height=100% style="border-collapse:collapse">
														<tr>
															<td rowspan="2" align=center><font size=1>PartnerShip</td>
															<td align=center colspan=10><font size=1>Mins</td>
														</tr>
														<tr>
															<td align=center colspan=10><font size=1>Balls</td>
														</tr>
													</table>
											</td>
							
							<%    vparam.add(inningIdTwo);
								 secondInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_partnershipdtls",vparam,"ScoreDB");
								 vparam.removeAllElements();
								 crsSize = secondInningFirstBatsFallWicketCrs.size();
								 rowGrowLength =  10 - crsSize ;
								 if (secondInningFirstBatsFallWicketCrs !=null){
									try{
										 while (secondInningFirstBatsFallWicketCrs.next()){
											wktPartMin = secondInningFirstBatsFallWicketCrs.getString("mins")!=null?secondInningFirstBatsFallWicketCrs.getString("mins"):"";
											wktPartBall = secondInningFirstBatsFallWicketCrs.getString("balls")!=null?secondInningFirstBatsFallWicketCrs.getString("balls"):"";


							%>
							
							
								 		
								 			<td align=center>
												<table border=1 width=100% height=100% style="border-collapse:collapse">
														<tr>
															
															<td align=right><font color="#003399" size=1><%=wktPartMin%></td>
							
														</tr>
														<tr>
															<td align=right><font color="#003399"  size=1><%=wktPartBall%></td>
													
														</tr>
														
												</table>
											</td>
							<%
										  }	
									}catch(Exception e){
										log.writeErrLog(page.getClass(),matchId,e.toString());
									}
								 }
							%>
							
										
										</tr>
								  	</table>
								</td>
					<%-- Second <TD> ends here	--%>
					<%-- Third <TD> start here--%>
					
								<td>
									<table width="100%" height="100%"  border="1" style=border-collapse:collapse>
										<tr class=firstrow>
											<td colspan="5" align=center ><FONT SIZE=1>Team's Score Details</td>
										</tr>
										<tr class=firstrow border=1>
											<td rowspan="2" align=center><font size=1>Runs</td>
											<td colspan="2" align=center><font size=1>1st<br>innings</td>
											<td colspan="2" align=center><font size=1>2st<br>innings</td>
										</tr> 
										<tr class=firstrow>
											<td align=center ><font size=1>Mins.</td>
											<td align=center ><font size=1>Overs</td>
											<td align=center ><font size=1>Mins.</td>
											<td align=center ><font size=1>Overs</td>
										</tr>	
										
<%	vparam.add(inningIdOne);
	vparam.add(inningIdTwo);
	firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamscoredetailsfortestmatch",vparam,"ScoreDB");
	int runSize = 0;
	crsSize = firstBatsInningFirstCrs.size();
	rowGrowLength = 19 - crsSize;
	vparam.removeAllElements();
	if (firstBatsInningFirstCrs!=null ) {
	  try{
		 while (firstBatsInningFirstCrs.next()){
					firstInningScoreRunrange = firstBatsInningFirstCrs.getString("run")!=null?firstBatsInningFirstCrs.getString("run"):"";
					firstInningScoreMins	 = firstBatsInningFirstCrs.getString("minutes")!=null?firstBatsInningFirstCrs.getString("minutes"):"";
					firstTeamScoreOver	     = firstBatsInningFirstCrs.getString("overs")!=null?firstBatsInningFirstCrs.getString("overs"):"";
					secondInningScoreMins	 = firstBatsInningFirstCrs.getString("minutes_1")!=null?firstBatsInningFirstCrs.getString("minutes_1"):"";
					secondTeamScoreOver	     = firstBatsInningFirstCrs.getString("overs_1")!=null?firstBatsInningFirstCrs.getString("overs_1"):"";
					
					
				    runSize = Integer.parseInt(firstInningScoreRunrange);
%>
										<tr>
											<td align=right><font color="#003399" size=1><%=firstInningScoreRunrange%></td>
											<td align=right><font color="#003399" size=1><%=firstInningScoreMins%></td>
											<td align=right><font color="#003399" size=1><%=firstTeamScoreOver%></td>
											<td align=right><font color="#003399" size=1><%=secondInningScoreMins%></td>
											<td align=right><font color="#003399" size=1><%=secondTeamScoreOver%></td>
										</tr>	
<%
		}
	}catch(Exception e)	{
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
  }	
%>
<%
	for (k=0; k<rowGrowLength; k++){
	runSize = runSize + 50;
%>
											<tr>
												<td align=right><font color="#003399" size=1><%=runSize%></td>
												<td align="center"></td>
												<td align="center"></td>
												<td align="center"></td>
												<td align="center"></td>
											</tr>								
<%
	}
%>
										
									</table>
								</td>
								<%-- Third <TD> ends here
						--%>
						</tr>
					</table>
					<%-- Main <Table> and <DIV> for batting  first ends here--%>
<%
		long timeAfter = System.currentTimeMillis();
		System.out.println("timeAfter" +timeAfter);
		long startTime = (Long)session.getAttribute("starttime");
		long elapsed = timeAfter - startTime;
		System.out.println("Elapsed time in milliseconds: " + elapsed);
		System.out.println("Elapsed time in second: " + elapsed/1000);
		System.out.println("Elapsed time in minute: " + elapsed/60000);
	
%>
<script>
		function onRefresh(){
			if(window.event && window.event.keyCode == 116)
		     { 
			    window.event.keyCode = 505;
			 }
			if(window.event && window.event.keyCode == 505)
	         { 
	            return true;
			 }
		 }
		 alert("call onrefresh");
		//onRefresh();
</script>
		