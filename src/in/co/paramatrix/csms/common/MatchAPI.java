// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   media.java

package in.co.paramatrix.csms.common;

import in.co.paramatrix.csms.dto.MatchInfoDTO;
import in.co.paramatrix.csms.dto.MatchSummary;
import in.co.paramatrix.csms.generalamd.GenerateStoreProcedure;
import in.co.paramatrix.csms.logwriter.LogWriter;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.jdbc.rowset.CachedRowSet;

public class MatchAPI extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String matchId = "";
		matchId = request.getParameter("match");
		if(matchId==null){
			matchId = "2789";
		}
		System.out.println(matchId + "--------------------------------------------------------------");
		String inningXML = "";
		String apiCompleteFlag = "Complete";
		MatchInfoDTO matchInfoDTO = new MatchInfoDTO();
		MatchSummary matchSummary = new MatchSummary();
		response.setContentType("text/xml");
        PrintWriter out = response.getWriter();
    	GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
    	Vector 					vparam 					=  	new Vector();
    	CachedRowSet  			lobjCachedRowSet		=	null;
    	CachedRowSet  			Inning1RowSet			=	null;
    	CachedRowSet  			Inning2RowSet			=	null;
    	CachedRowSet  			Inning3RowSet			=	null;
    	CachedRowSet  			Inning4RowSet			=	null;
    	CachedRowSet  			inningIdCrs				=	null;
    	CachedRowSet  			bowlerscoreeCachedRowSet=	null;
    	CachedRowSet  			playerCachedRowSet		=	null;
    	CachedRowSet  			inningSummaryCachedRowSet=	null;
    	CachedRowSet  			overrateCachedRowSet    =	null;
    	CachedRowSet  			statusCachedRowSet    =	null;
    	CachedRowSet  			resultCachedRowSet    =	null;
    	CachedRowSet  			fallOfWicketCachedRowSet    =	null;
    	boolean inningCreated = false;    	
    	LogWriter log = new LogWriter();
    	vparam.add(matchId); 
		 
		lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getprematchtype",vparam,"ScoreDB");
		if(lobjCachedRowSet!= null){		
			try {
				if(lobjCachedRowSet.next()){		
					matchInfoDTO.setSeriesName(lobjCachedRowSet.getString("series")); 
					matchInfoDTO.setTeam1Id(lobjCachedRowSet.getString("team1id"));
					matchInfoDTO.setTeam1Name(lobjCachedRowSet.getString("team1name"));
					matchInfoDTO.setTeam2Id(lobjCachedRowSet.getString("team2id"));
					matchInfoDTO.setTeam2Name(lobjCachedRowSet.getString("team2name"));
					matchInfoDTO.setType(lobjCachedRowSet.getString("matchtype"));
					matchInfoDTO.setDate(lobjCachedRowSet.getString("matchdate"));
					matchInfoDTO.setDateEnd(lobjCachedRowSet.getString("date_end"));
					matchInfoDTO.setNoOfDays(lobjCachedRowSet.getInt("match_days"));
					matchInfoDTO.setTossWinner(lobjCachedRowSet.getString("toss_winner"));
					matchInfoDTO.setElected(lobjCachedRowSet.getString("elected"));
					matchInfoDTO.setCity(lobjCachedRowSet.getString("city"));
					matchInfoDTO.setVenue(lobjCachedRowSet.getString("venue"));
					matchInfoDTO.setUmpire1(lobjCachedRowSet.getString("umpire1"));
					matchInfoDTO.setUmpire2(lobjCachedRowSet.getString("umpire2"));
					matchInfoDTO.setUmpire3(lobjCachedRowSet.getString("umpire3"));
					matchInfoDTO.setRefereeName(lobjCachedRowSet.getString("referee"));
					matchInfoDTO.setMatchName(lobjCachedRowSet.getString("match_name"));
					matchInfoDTO.setSeriesSeason(lobjCachedRowSet.getString("season"));
					matchInfoDTO.setResultWinner(lobjCachedRowSet.getString("match_winner_team"));
					
				 }else{
					 apiCompleteFlag = "Incomplete";
				 }
			} catch (SQLException e) {
				apiCompleteFlag = "Incomplete";
				e.printStackTrace();
			}	  		
		}
		
		
		
		statusCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("rpt_esp_dsp_scorercard_summary",vparam,"ScoreDB");
		if(statusCachedRowSet!= null){		
			try {
				if(statusCachedRowSet.next()){		
					matchInfoDTO.setMatchResult(statusCachedRowSet.getString("result"));
					matchInfoDTO.setMatchstate(statusCachedRowSet.getString("status"));
					
					matchInfoDTO.setInning1BattingScore(statusCachedRowSet.getString("inn1_score"));
					matchInfoDTO.setInning2BattingScore(statusCachedRowSet.getString("inn2_score"));
					matchInfoDTO.setInning3BattingScore(statusCachedRowSet.getString("inn3_score"));
					matchInfoDTO.setInning4BattingScore(statusCachedRowSet.getString("inn4_score"));
					
				 }
			} catch (SQLException e) {
				apiCompleteFlag = "Incomplete";
				e.printStackTrace();
			}	  		
		}
		
		resultCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("rpt_esp_dsp_reportresult",vparam,"ScoreDB");
		if(resultCachedRowSet!= null){		
			try {
				if(resultCachedRowSet.next()){		
					matchInfoDTO.setMatchResult(resultCachedRowSet.getString("result"));
				 }
			} catch (SQLException e) {
				apiCompleteFlag = "Incomplete";
				e.printStackTrace();
			}	  		
		}
		
		String team1XML ="";
		String team2XML ="";
		vparam.removeAllElements();
		for(int i = 0; i <2; i++){
		  if(i == 0){
			  vparam.add(matchId); 
			  vparam.add(matchInfoDTO.getTeam1Id());
			  if(matchInfoDTO.getTeam1Name().equalsIgnoreCase("null") || matchInfoDTO.getTeam1Name().equals("")
					  || matchInfoDTO.getTeam1Name() == null){
				  apiCompleteFlag = "Incomplete";
			  }
			  team1XML = "<team name='"+ matchInfoDTO.getTeam1Name() +"' id='"+matchInfoDTO.getTeam1Id()+"'>";
		  }else{
			  if(matchInfoDTO.getTeam2Name().equalsIgnoreCase("null") || matchInfoDTO.getTeam2Name().equals("")
					  || matchInfoDTO.getTeam2Name() == null){
				  apiCompleteFlag = "Incomplete";
			  }
			  vparam.add(matchId); 
			  vparam.add(matchInfoDTO.getTeam2Id()); 
			  team2XML = "<team name='"+ matchInfoDTO.getTeam2Name() +"' id='"+matchInfoDTO.getTeam2Id()+"'>";
		  }
		
		
	     playerCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_match_teamlist",vparam,"ScoreDB");
		  vparam.removeAllElements();	
		  if(playerCachedRowSet!= null){		
				try {
					String playerName = "";
					String playerType = "";
					String playerId="";
					boolean playerFlag = false;
					while (playerCachedRowSet.next()) {
					   playerFlag = true;
					   playerName =playerCachedRowSet.getString("playername");
					  			  
					   if(playerCachedRowSet.getString("is_captain").trim().equalsIgnoreCase("Y") &&
							   playerCachedRowSet.getString("is_wkeeper").trim().equalsIgnoreCase("Y")){
							playerType ="captain and wicket";
					   }else{
							if(playerCachedRowSet.getString("is_wkeeper").trim().equalsIgnoreCase("Y")){
								playerType ="wicket";
							}else if(playerCachedRowSet.getString("is_captain").trim().equalsIgnoreCase("Y")){
								playerType ="captain";
							}
							else{
								playerType = "";
							}
					   }	
						
						playerId =playerCachedRowSet.getString("id");
						if(i == 0){
							team1XML = team1XML + "  <player name='"+playerName+"' type='"+playerType+"' id='"+playerId+"' />";
						}else{
							team2XML = team2XML + "  <player name='"+playerName+"' type='"+playerType+"' id='"+playerId+"' />";
						}
					}
					if(!playerFlag){
						apiCompleteFlag = "Incomplete";
					}
					
				} catch (SQLException e) {
					apiCompleteFlag = "Incomplete";
					e.printStackTrace();
				}	  		
		 }else{
			 apiCompleteFlag = "Incomplete"; 
		 }
	    }
		team1XML = team1XML + " </team>";
		team2XML = team2XML + " </team>";
		
		vparam.removeAllElements();
		vparam.add(matchId);
        inningIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getInningDeatils", vparam, "ScoreDB");
        vparam.removeAllElements();
        if (inningIdCrs != null) {
             try {
                 while (inningIdCrs.next()) {
                	 matchInfoDTO.setInningOne(inningIdCrs.getString("inn1") != null ? inningIdCrs.getString("inn1") : "");
                	 matchInfoDTO.setInningThree(inningIdCrs.getString("inn3") != null ? inningIdCrs.getString("inn3") : "");                        
                	 matchInfoDTO.setInningTwo(inningIdCrs.getString("inn2") != null ? inningIdCrs.getString("inn2") : "");                        
                	 matchInfoDTO.setInningFour(inningIdCrs.getString("inn4") != null ? inningIdCrs.getString("inn4") : "");
                	 matchInfoDTO.setInning1Batting(inningIdCrs.getString("battingteamidinn1") != null ? inningIdCrs.getString("battingteamidinn1") : "");
                	 matchInfoDTO.setInning1Bowling(inningIdCrs.getString("bowlingteamidinn1") != null ? inningIdCrs.getString("bowlingteamidinn1") : "");
                	 matchInfoDTO.setInning2Batting(inningIdCrs.getString("battingteamidinn2") != null ? inningIdCrs.getString("battingteamidinn2") : "");
                	 matchInfoDTO.setInning2Bowling(inningIdCrs.getString("bowlingteamidinn2") != null ? inningIdCrs.getString("bowlingteamidinn2") : "");
                	 matchInfoDTO.setInning3Batting(inningIdCrs.getString("battingteamidinn3") != null ? inningIdCrs.getString("battingteamidinn3") : "");
                	 matchInfoDTO.setInning3Bowling(inningIdCrs.getString("bowlingteamidinn3") != null ? inningIdCrs.getString("bowlingteamidinn3") : "");
                	 matchInfoDTO.setInning4Batting(inningIdCrs.getString("battingteamidinn4") != null ? inningIdCrs.getString("battingteamidinn4") : "");
                	 matchInfoDTO.setInning4Bowling(inningIdCrs.getString("bowlingteamidinn4") != null ? inningIdCrs.getString("bowlingteamidinn4") : "");
                	 
                 }
             } catch (Exception e) {
            	 apiCompleteFlag = "Incomplete";
                 log.writeErrLog(MatchAPI.class, matchId, e.toString());
             } finally {
                 inningIdCrs = null;
             }
        }else{
        	apiCompleteFlag = "Incomplete";
        }
		String inningID = "";
		String batting = "";
		String bowling = "";
		String inningsXML = "";
		boolean inningStatus = false;
		
        if(matchInfoDTO.getInningOne() != null){
        	for(int i = 0; i < 4; i ++){
              if(i==0 && (matchInfoDTO.getInningOne()!=null && matchInfoDTO.getInningOne().trim()!="" && matchInfoDTO.getInningOne()!="0")){
	        	inningID = matchInfoDTO.getInningOne();
	        	batting = matchInfoDTO.getInning1Batting();
	        	bowling = matchInfoDTO.getInning1Bowling();
	        	inningStatus = true;
	        	inningCreated = true;
        	  }	else if(i==1 && (matchInfoDTO.getInningTwo()!=null && matchInfoDTO.getInningTwo().trim()!="" && matchInfoDTO.getInningTwo()!="0")){
        		inningID = matchInfoDTO.getInningTwo();
	           	batting = matchInfoDTO.getInning2Batting();
	        	bowling = matchInfoDTO.getInning2Bowling();
	        	inningStatus = true;
	        	inningCreated = true;
        	  }	else if(i==2 && (matchInfoDTO.getInningThree()!=null && matchInfoDTO.getInningThree().trim()!="" && matchInfoDTO.getInningThree()!="0")){
	        	inningID = matchInfoDTO.getInningThree();
	        	batting = matchInfoDTO.getInning3Batting();
	        	bowling = matchInfoDTO.getInning3Bowling();
	        	inningStatus = true;
	        	inningCreated = true;
        	  }	else if(i==3 && (matchInfoDTO.getInningFour()!=null && matchInfoDTO.getInningFour().trim()!="" && matchInfoDTO.getInningFour()!="0")){
	        	inningID = matchInfoDTO.getInningFour();
	        	batting = matchInfoDTO.getInning4Batting();
	        	bowling = matchInfoDTO.getInning4Bowling();
	        	inningStatus = true;
	        	inningCreated = true;
        	  }else{
        		  inningStatus = false;  
        	  }
	          if(inningStatus){
	        	inningStatus = false;
	        	vparam.removeAllElements();
	        	vparam.add(inningID);
	        	Inning1RowSet = lobjGenerateProc.GenerateStoreProcedure("rpt_esp_dsp_scoreshett_battingscorercard", vparam, "ScoreDB");
	        	inningSummaryCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("rpt_esp_dsp_battingsummary_total", vparam, "ScoreDB");
	        	fallOfWicketCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("rpt_esp_dsp_fallwicket", vparam, "ScoreDB");
	        	boolean inningSummaryFlag = false;
	        	try {
					while(inningSummaryCachedRowSet.next()){
						inningSummaryFlag = true;
						matchSummary.setTeamRun(inningSummaryCachedRowSet.getString("total_score").trim());
						matchSummary.setTeamWicket(inningSummaryCachedRowSet.getString("wicket"));
						matchSummary.setTeamOver(inningSummaryCachedRowSet.getString("overs"));
						matchSummary.setTeamExtra(inningSummaryCachedRowSet.getString("total_extra"));
						matchSummary.setTeamWide(inningSummaryCachedRowSet.getString("wides"));
						matchSummary.setTeamNo(inningSummaryCachedRowSet.getString("noballs"));
						matchSummary.setTeamLegBye(inningSummaryCachedRowSet.getString("legbyes"));
						matchSummary.setTeamBye(inningSummaryCachedRowSet.getString("byes"));
						String[] overArray = (inningSummaryCachedRowSet.getString("overs").trim()).split("\\.");
						String totalOver = overArray[0];
						String ball = overArray[1];
						int totalBall = (Integer.parseInt(totalOver) * 6) + Integer.parseInt(ball);
						int totalRun = Integer.parseInt(matchSummary.getTeamRun());
						float srRate = (float)((float)totalRun/totalBall) * 6; 
						matchSummary.setTeamRate(String.format("%2.02f", srRate));
						
					}
					
				} catch (SQLException e1) {
					apiCompleteFlag = "Incomplete";
					e1.printStackTrace();
				}
				
				if(!inningSummaryFlag){
					apiCompleteFlag = "Incomplete";
				}
				vparam.removeAllElements();
				vparam.add(inningID);
	            vparam.add(matchId); 
	    		bowlerscoreeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("rpt_esp_dsp_bowlingscorecard", vparam, "ScoreDB"); // Batsman List
	    		vparam.removeAllElements();		
	    		
	            try {
	            	String battingXML = "";
	            	String bowlingXML = "";
	            	String fallWicketXML = "";
	            	if(matchSummary.getTeamRate().trim().equalsIgnoreCase("NaN")){
	            		matchSummary.setTeamRate("0");
	            	}
	            	
	            	inningXML = "<innings id='"+ inningID +"' battingTeam='"+ batting +"' bowlingTeam='"+ bowling +"'>" +
        			" <summary run='"+ matchSummary.getTeamRun() +"' wicket='"+ matchSummary.getTeamWicket() +
        			"' over='"+ matchSummary.getTeamOver() +"' rate='"+ matchSummary.getTeamRate() +
        			"' extra='"+ matchSummary.getTeamExtra() +"' wide='"+ matchSummary.getTeamWide() +
        			"' no='"+matchSummary.getTeamNo()+"' legbye='"+ matchSummary.getTeamLegBye() +"' bye='"+ matchSummary.getTeamBye() +"' />" +
        			" <batting>";
	            	if(matchSummary.getTeamOver().trim().equals("") || matchSummary.getTeamOver().equals("")){
	            		apiCompleteFlag = "Incomplete";
	            	}
	            	matchSummary.setTeamRun("");
					matchSummary.setTeamWicket("");
					matchSummary.setTeamOver("");
					matchSummary.setTeamExtra("");
					matchSummary.setTeamWide("");
					matchSummary.setTeamNo("");
					matchSummary.setTeamLegBye("");
					matchSummary.setTeamBye("");
					matchSummary.setTeamRate("");
					boolean battingStatus = false;
	                while (Inning1RowSet.next()) {
	                	battingStatus = true;
	                  	String batsmanId = Inning1RowSet.getString("batsmanid") != null ? Inning1RowSet.getString("batsmanid") : "";
	                  	String seqId = Inning1RowSet.getString("srno") != null ? Inning1RowSet.getString("srno") : "";
	                  	String howOut = Inning1RowSet.getString("howout") != null ? Inning1RowSet.getString("howout") : "";
	                  	if(howOut.trim().equalsIgnoreCase("DNB")){
	                  		howOut = "";
	                  	}
	                  	if(howOut.trim().equalsIgnoreCase("b")){
	                  		howOut = "";
	                  	}
	                  	String batsmanoutdiv = Inning1RowSet.getString("batsmanoutdiv") != null ? Inning1RowSet.getString("batsmanoutdiv") : "";
	                  	String statusString = howOut + " "  + batsmanoutdiv;
	                  	String run = Inning1RowSet.getString("runs") != null ? Inning1RowSet.getString("runs") : "";
	                  	String ball = Inning1RowSet.getString("balls") != null ? Inning1RowSet.getString("balls") : "";
	                  	String four = Inning1RowSet.getString("fours") != null ? Inning1RowSet.getString("fours") : "";
	                  	String six = Inning1RowSet.getString("six") != null ? Inning1RowSet.getString("six") : "";
	                  	String fow = "";
	                  	String status = howOut;
	                  	String bolwer = Inning1RowSet.getString("bowler") != null ? Inning1RowSet.getString("bowler") : "";
	                  	String assist = Inning1RowSet.getString("fielder") != null ? Inning1RowSet.getString("fielder") : "";
	                  	String strikeRate = Inning1RowSet.getString("strike") != null ? Inning1RowSet.getString("strike") : "";
	                  	String dotBall = Inning1RowSet.getString("dot_ball") != null ? Inning1RowSet.getString("dot_ball") : "";
	                  	if(run.trim().equalsIgnoreCase("-1")){
	                  		run = "";
	                  	}
	                  	if(ball.trim().equalsIgnoreCase("-1")){
	                  		ball = "";
	                  	}
	                  	if(four.trim().equalsIgnoreCase("-1")){
	                  		four = "";
	                  	}
	                  	if(six.trim().equalsIgnoreCase("-1")){
	                  		six = "";
	                  	}
	                  	if(strikeRate.trim().equalsIgnoreCase("-1") || strikeRate.trim().equalsIgnoreCase("-1.00")
	                  			|| strikeRate.trim().equalsIgnoreCase("-1.0")){
	                  		strikeRate = "";
	                  	}
	                	battingXML = battingXML + "<batsman id='"+batsmanId+"' seq = '"+ seqId +"' statusString='"+ statusString +"'"+
	                			" run='"+run+"' ball='"+ball+"' four='"+four+"' six='"+six+"'"+
	                			" fow='"+fow+"' status='"+status+"' bowler='"+bolwer+"' assist='"+assist+"'"+
	                			" strikerate='"+strikeRate+"' dotball='"+dotBall+"' />";
	                	battingXML = battingXML.replaceAll("&", "and");
	                	
	                }
	                if(!battingStatus){
	                	apiCompleteFlag = "Incomplete";
	                }
	                if(battingXML.trim().equals("") || battingXML.equals("")){
	                	apiCompleteFlag = "Incomplete";
	                }
	                int sequenceId = 1;
	                boolean bowlingFlag = false;
	                while (bowlerscoreeCachedRowSet.next()) {
	                	bowlingFlag = true;
	                  	String bowlerId = bowlerscoreeCachedRowSet.getString("bowler_id") != null ? bowlerscoreeCachedRowSet.getString("bowler_id") : "";
	                  	String seqId = ""+sequenceId;
	                  	String over = bowlerscoreeCachedRowSet.getString("noofover") != null ? bowlerscoreeCachedRowSet.getString("noofover") : "";
	                  	String maiden = bowlerscoreeCachedRowSet.getString("maiden") != null ? bowlerscoreeCachedRowSet.getString("maiden") : "";
	                  	String run = bowlerscoreeCachedRowSet.getString("runs") != null ? bowlerscoreeCachedRowSet.getString("runs") : "";
	                  	String wicket = bowlerscoreeCachedRowSet.getString("wicket") != null ? bowlerscoreeCachedRowSet.getString("wicket") : "";
	                  	String wide = bowlerscoreeCachedRowSet.getString("wideball") != null ? bowlerscoreeCachedRowSet.getString("wideball") : "";
	                  	String noball = bowlerscoreeCachedRowSet.getString("noball") != null ? bowlerscoreeCachedRowSet.getString("noball") : "";
	                  	String economy = bowlerscoreeCachedRowSet.getString("eco") != null ? bowlerscoreeCachedRowSet.getString("eco") : "";
	                  	
	                  	bowlingXML = bowlingXML + "<bowler id='"+bowlerId+"' seq='"+seqId+"' over='"+over+"' mdn='"+ maiden +"'" +
	                  			" run='"+run+"' wkt='"+wicket+"' wide='"+wide +"' no='"+noball+"' economy='"+economy+"' />";
	                	
	                	sequenceId ++;
	                	
	                }
	                if(!bowlingFlag){
	                	apiCompleteFlag = "Incomplete";
	                }
	                if(bowlingXML.trim().equals("") || bowlingXML.equals("")){
	                	apiCompleteFlag = "Incomplete";
	                }
	                fallWicketXML = "<fallofwickets>";
	                while(fallOfWicketCachedRowSet.next()){
	                	String[] overArray = (fallOfWicketCachedRowSet.getString("overs").trim()).split("\\.");
						String totalOver = overArray[0];
						String ball = overArray[1];
						int totalBall = (Integer.parseInt(totalOver) * 6) + Integer.parseInt(ball);
						int totalRun = Integer.parseInt(fallOfWicketCachedRowSet.getString("runs"));
						float srRate = (float)((float)totalRun/totalBall) * 6; 
						String runRate = String.format("%2.02f", srRate);
	                	
	                	fallWicketXML = fallWicketXML + "<fow wicketno='"+fallOfWicketCachedRowSet.getString("srno")+"' "
	                	+"runs='"+fallOfWicketCachedRowSet.getString("runs")
	                	+"' overs='"+fallOfWicketCachedRowSet.getString("overs")
	                	+"' batsman_id='"+fallOfWicketCachedRowSet.getString("batsman_id")
	                	+"' runrate='"+runRate+"' />";
	                			
	                }
	                fallWicketXML = fallWicketXML +"</fallofwickets>";
	                inningXML = inningXML + battingXML + " </batting> <bowling> "+ bowlingXML +" </bowling> "+ fallWicketXML +" </innings>";
	                inningsXML = inningsXML + inningXML;
	            } catch (Exception e) {
	            	e.printStackTrace();
	            	apiCompleteFlag = "Incomplete";
	                log.writeErrLog(MatchAPI.class, matchId, e.toString());
	            }
	          }   
           }     
        	
        }
        String mainXML = "";
        mainXML = "<cricket> ";
        
        if(matchInfoDTO.getSeriesName().equalsIgnoreCase(matchInfoDTO.getMatchName()) ){
        	matchInfoDTO.setMatchName("");
        }
        if(matchInfoDTO.getType().equalsIgnoreCase("null") || matchInfoDTO.getType().equals("null") ||
        		matchInfoDTO.getType().trim().equals("null") || matchInfoDTO.getType() == null ||
        		matchInfoDTO.getType().equals("")){
        	apiCompleteFlag = "Incomplete";
        }
        
        //Create Match Dates ... 09 Aug - 12 Aug 2012
        // DEC 26-28, 2012  .... DEC 29, 2012 - JAN 01, 2013 ...... NOV 30 - DEC 3, 2012
        SimpleDateFormat sdf_dd_MMM_yyyy = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat sdf_MMM_dd_yyyy = new SimpleDateFormat("MMM dd, yyyy");
        SimpleDateFormat sdf_dd = new SimpleDateFormat("dd");
        SimpleDateFormat sdf_MMM = new SimpleDateFormat("MMM");
        SimpleDateFormat sdf_yyyy = new SimpleDateFormat("yyyy");
        StringBuffer strMatchDates = new StringBuffer("");
		
        int iNoOfDays = matchInfoDTO.getNoOfDays();
        //Check Match duration to form a string
        if(iNoOfDays > 1){
        	String strStartDay = "";
            String strStartMonth = "";
            String strStartYear = "";
        	String strEndDay = "";
            String strEndMonth = "";
            String strEndYear = "";
            
            try {
            	if(null != matchInfoDTO.getDate() && !"".equals(matchInfoDTO.getDate())){
	            	Date dtStartDate =  sdf_dd_MMM_yyyy.parse(matchInfoDTO.getDate());
	    			strStartDay = sdf_dd.format(dtStartDate);
	    			strStartMonth = sdf_MMM.format(dtStartDate).toUpperCase();
	    			strStartYear = sdf_yyyy.format(dtStartDate);
            	}
            	if(null != matchInfoDTO.getDateEnd() && !"".equals(matchInfoDTO.getDateEnd())){
	    			Date dtEndDate =  sdf_dd_MMM_yyyy.parse(matchInfoDTO.getDateEnd());
	    			strEndDay = sdf_dd.format(dtEndDate);
	    			strEndMonth = sdf_MMM.format(dtEndDate).toUpperCase();
	    			strEndYear = sdf_yyyy.format(dtEndDate);
            	}
    		} catch (ParseException e) {
    			e.printStackTrace();
    			apiCompleteFlag = "Incomplete";
                log.writeErrLog(MatchAPI.class, matchId, e.toString());
    		}
    		
    		// DEC 26-28, 2012  .... DEC 29, 2012 - JAN 01, 2013 ...... NOV 30 - DEC 03, 2012
    		//Check for year change
    		if(strStartYear.equals(strEndYear)){
    			//Check for Month change
    			if(strStartMonth.equals(strEndMonth)){
    				// Year and month is same .. e.g. DEC 26-28, 2012
    				strMatchDates = new StringBuffer(strStartMonth +" " + strStartDay);
    				strMatchDates.append("-"+strEndDay);
    				strMatchDates.append(", "+strStartYear);
    			}else{
    				//Year is same but month is different ... e.g. NOV 30 - DEC 03, 2012
    				strMatchDates = new StringBuffer(strStartMonth +" " + strStartDay);
    				strMatchDates.append(" - "+strEndMonth +" " + strEndDay);
    				strMatchDates.append(", "+strStartYear);
    			}
    			
    		}else{
    			//DEC 29, 2012 - JAN 01, 2013
    			strMatchDates = new StringBuffer(strStartMonth +" " + strStartDay +", "+strStartYear + " - " +strEndMonth +" " + strEndDay +", "+strEndYear);
    		}
    		
        }else{
        	try {
        		//For single day matches use start day and format ... e.g DEC 21, 2012
        		if(matchInfoDTO.getDate() != null && !"".equals(matchInfoDTO.getDate())){
        			strMatchDates = new StringBuffer(sdf_dd.format(sdf_dd_MMM_yyyy.parse(matchInfoDTO.getDate())));
        		}
    		} catch (ParseException e) {
    			e.printStackTrace();
    			apiCompleteFlag = "Incomplete";
                log.writeErrLog(MatchAPI.class, matchId, e.toString());
    		}
        }
        
        
        //Create String for Match result
        
        Integer inning1BattingRuns =0;
        Integer inning2BattingRuns = 0;
        Integer inning2Wickets = 0;
        Integer inning3BattingRuns = 0;
        Integer inning4BattingRuns = 0;
        Integer inning4Wickets = 0;
        String strMatchStatus = matchInfoDTO.getResultWinner();
        //Check match state is completed and resulted 
        if(null == strMatchStatus || "".equals(strMatchStatus)){
        	strMatchStatus = matchInfoDTO.getMatchResult();
        }else if("Match Completed".equalsIgnoreCase(matchInfoDTO.getMatchstate().trim())){
	        try{
	        	if(null != matchInfoDTO.getInning1BattingScore() && !"".equals(matchInfoDTO.getInning1BattingScore())){
	        		inning1BattingRuns = Integer.parseInt(matchInfoDTO.getInning1BattingScore().split("/")[0]);
	        	}
	        	
	        	if(null != matchInfoDTO.getInning2BattingScore() && !"".equals(matchInfoDTO.getInning2BattingScore())){
			        String[] strInning2Score = matchInfoDTO.getInning2BattingScore().split("/");
			        inning2BattingRuns = Integer.parseInt(strInning2Score[0].trim());
			        if(strInning2Score.length > 1){
			        	inning2Wickets = Integer.parseInt(strInning2Score[1].trim());
			        }
	        	}
	        	
	        	if(null != matchInfoDTO.getInning3BattingScore() && !"".equals(matchInfoDTO.getInning3BattingScore())){
	        		inning3BattingRuns = Integer.parseInt(matchInfoDTO.getInning3BattingScore().split("/")[0]);
	        	}
		        
		        if(null != matchInfoDTO.getInning4BattingScore() && !"".equals(matchInfoDTO.getInning4BattingScore())){
			        String[] strInning4Score = matchInfoDTO.getInning4BattingScore().split("/");
			        inning4BattingRuns = Integer.parseInt(strInning4Score[0].trim());
			        if(strInning4Score.length > 1){
			        	inning4Wickets = Integer.parseInt(strInning4Score[1].trim());
			        }
		        }
		        
	        	//check for Multi innings matches 
	        	if(inning3BattingRuns > 0){
	        		//Check for follow on in two innings per side match
	        		if(matchInfoDTO.getInning1Batting() != matchInfoDTO.getInning3Batting()){
	        			//If Follow on given check for innings victory
	        			if(inning1BattingRuns > (inning2BattingRuns+inning3BattingRuns)){
	        				//Team batting 1st win by an innings and run after follow on
	        				strMatchStatus += " Win by Innings and" + (inning1BattingRuns - (inning2BattingRuns+inning3BattingRuns)) + " runs";
	        			}else{
	        				Integer team1Score = inning1BattingRuns+inning4BattingRuns;
		        			Integer team2Score = inning2BattingRuns+inning3BattingRuns;
		        			
		        			if(team1Score > team2Score){
		        				//Team batting first win by wicket's after follow on
		        				strMatchStatus += " Win by " + (10 - inning4Wickets) + " wickets";
		        			}else{
		        				//Team batting second win by runs after follow on
		        				strMatchStatus += " Win by " + (team2Score - team1Score) + " runs";
		        			}
	        			}
	        		}else{
	        			//Normal match 1st&3rd innings and 2nd&4th innings
	        			Integer team1Score = inning1BattingRuns+inning3BattingRuns;
	        			Integer team2Score = inning2BattingRuns+inning4BattingRuns;
	        			
	        			if(team1Score > team2Score){
	        				//Team batting 1st win by runs
		        			strMatchStatus += " Win by " + (team1Score - team2Score) + " runs";
		        		}else{
		        			//Team batting 2nd win by wicket's
		        			strMatchStatus += " Win by " + (10 - inning4Wickets) + " wickets";
		        		}
	        		}
	        		
	        	}else{
	        		//Single inning matches
	        		if(inning1BattingRuns > inning2BattingRuns){
	        			//Team batting 1st win by runs
	        			strMatchStatus += " Win by " + (inning1BattingRuns - inning2BattingRuns) + " runs";
	        		}else{
	        			//Team batting second win by wicket's
	        			strMatchStatus += " Win by " + (10 - inning2Wickets) + " wickets";
	        		}
	        	}
		        
		        
	        }catch(Exception e){
	        	e.printStackTrace();
	        	apiCompleteFlag = "Incomplete";
	            log.writeErrLog(MatchAPI.class, matchId, e.toString());
	        }
        }else if(null != matchInfoDTO.getResultWinner() && !"".equals(matchInfoDTO.getResultWinner().trim())){
        	strMatchStatus = matchInfoDTO.getResultWinner();
        }
        
        String matchInfoObject =
				"<matchInfo id='"+matchId+"' type='"+matchInfoDTO.getType()+"'" +
				" date='"+strMatchDates.toString()+"' gameType='"+matchInfoDTO.getType()+"'" +
				" dayNight='day' seriesName='"+ matchInfoDTO.getSeriesName() +"' " +
				" seriesSeason='"+matchInfoDTO.getSeriesSeason()+"' matchName='"+matchInfoDTO.getMatchName()+"' overs='50' " +
				" targetscore='"+matchInfoDTO.getMatchResult()+"' targetmethod='normal'>";
		
		String tossObject = "<toss winner='"+matchInfoDTO.getTossWinner()+"' elected='"+matchInfoDTO.getTossWinner()+" elected to "+matchInfoDTO.getElected()+"'/>";
		String resultObject = "<result winner='"+matchInfoDTO.getResultWinner()+"' playerofthematch='-' " +
				//"matchResult='"+matchInfoDTO.getMatchResult()+"' matchstate='"+matchInfoDTO.getMatchstate()+"'/>";
				"matchResult='"+strMatchStatus.trim()+"' matchstate='"+matchInfoDTO.getMatchstate()+"'/>";
		
		String locationObject = "<location city='"+matchInfoDTO.getCity()+"'> " +matchInfoDTO.getVenue()+ " </location>";
		
		String refereeObject = "<referee name='"+matchInfoDTO.getRefereeName()+"'/>";	
		
		String umpire1Object =  "<umpire1 name='"+matchInfoDTO.getUmpire1()+"'/>";
		String umpire2Object =  "<umpire2 name='"+matchInfoDTO.getUmpire2()+"'/>";
		String umpire3Object =  "<umpire3 name='"+matchInfoDTO.getUmpire3()+"'/>";
		
		String matchInfo = matchInfoObject +  tossObject + resultObject + locationObject + 
							refereeObject + umpire1Object + umpire2Object + umpire3Object  + team1XML + team2XML + "</matchInfo>";
		if(inningsXML.trim().equals("")){
			apiCompleteFlag = "Incomplete";
		}
		if(!inningCreated){
			apiCompleteFlag = "Incomplete";
		}
		String matchXMLStatus="<xmlstatus>"+apiCompleteFlag + "</xmlstatus>";
		mainXML = mainXML + matchInfo + inningsXML + matchXMLStatus + "</cricket>";
		mainXML = mainXML.replace("&", " and ");
		
		
		String output = new String(mainXML.toString().getBytes("UTF-8"), 
        "ISO-8859-1");
		out.print(output);
		
	}
	
	
}
