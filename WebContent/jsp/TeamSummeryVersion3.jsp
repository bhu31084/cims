<%@ page import="sun.jdbc.rowset.CachedRowSet,
         in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
         java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"	
 %>
<%          response.setHeader("Cache-Control", "private");
            response.setHeader("Pragma", "private");
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Cache-Control", "must-revalidate");
            response.setHeader("Pragma", "must-revalidate");
            response.setDateHeader("Expires", 0);
%>
<% //cachedrowset declaration
            CachedRowSet firstBatsInningFirstCrs = null;
            CachedRowSet firstBatsInningSecondCrs = null;
            CachedRowSet bowledAnalysisCrs = null;
            CachedRowSet penaltyReasonCrs = null;
            CachedRowSet firstInningFirstBatsFallWicketCrs = null;
            CachedRowSet secondInningFirstBatsFallWicketCrs = null;
            CachedRowSet fallOfWicketInningOne = null;
            CachedRowSet fallOfWicketInningTwo = null;
            CachedRowSet reservePlayerCrs = null;
            CachedRowSet playerScoreTeamOneFirstInningCrs = null;
            CachedRowSet playerScoreTeamOneSecondInningCrs = null;
            CachedRowSet playerScoreTeamTwoFirstInningCrs = null;
            CachedRowSet playerScoreTeamTwoSecondInningCrs = null;

//GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
            Vector vparam = new Vector();

// variable declaration
            String timeIn = "";
            String timeOut = "";
            String srNo = "";
            String batsman = "";
            String howOut = "";
            String fielder = "";
            String bowler = "";
            String mins = "";
            String four = "";
            String six = "";
            String balls = "";
            String runs = "";
            String byes = "";
            String legByes = "";
            String noBall = "";
            String wide = "";
            String battingSubTotal = "";
            String totalExtras = "";
            String penaltyExtras = "";
            String totalOvers = "";
            String twelveman = "";
            String shortOvers = "";
            String secondNewBallOver = "";
            String thirdNewBallOver = "";
            String secondNewBallScore = "";
            String thirdNewBallScore = "";
            String secondNewBallBats = "";
            String thirdNewBallBats = "";
            String thirdNewBallBowl = "";
            String secondNewBallBowl = "";
            String bowlerName = "";
            String bowlerOver = "";
            String bowlerMaiden = "";
            String bowlerRunrate = "";
            String bowlerWicket = "";
            String bowlerNB = "";
            String bowlerWB = "";
            String wktRun = "";
            String wktOvers = "";
            String wktPartMin = "";
            String wktNoBats = "";
            String wktBatsOut = "";
            String wktPartBall = "";
            String firstTeamScoreOver = "";
            String secondTeamScoreOver = "";
            String matchTotalRun = "";
            String matchTotalWkt = "";
            String matchTotalOver = "";
            String reservePlayerOne = "";
            String reservePlayerTwo = "";
            String reservePlayerThree = "";
            String reservePlayerFour = "";
            String inningIdOne = "";
            String inningIdTwo = "";
            String penaltyDescription = "";
            String batsmanId = "";
            String batsSrNo = "";
            String bowlerId = "";
            String firstInningScoreMins = "";
            String secondInningMatchTotalWkt = "";
            String firstInningScoreRunrange = "";
            String secondInningScoreMins = "";
            String secondInningByes = "";
            String secondInningLegByes = "";
            String secondInningPenaltyExtras = "";
            String secondBowlerOver = "";
            String secondBowlerMaiden = "";
            String secondBowlerRunrate = "";
            String secondBowlerWicket = "";
            String secondBowlerNB = "";
            String secondBowlerWB = "";
            String nonstkrun = "";
            String matchId = "";
            String firstinningbattingteam = "";
            String secondinningbattingteam = "";
            String reservePlayer = "";
            String inningTime = "";
            String secondInningmatchTotalOver = "";
            String flag = "";
            String intermissionPoint = "";
            String teamOneName = "";
            String teamTwoName = "";
			String batterId = "";
            int extraPlusTotalRun = 0;
            int secondExtraPlusTotalRun = 0;
            int firstInningExtrasTotal = 0;
            int secondInningExtrasTotal = 0;
            int k = 0;
            int subTotal = 0;
            int tExtras = 0;
            int grandTotal = 0;
            float totalOver = 0;
            int totalMaiden = 0;
            int totalRun = 0;
            int totalWkt = 0;
            int totalNB = 0;
            int totalWB = 0;
            int crsSize = 0;
            int rowGrowLength = 0;
            int bowlerSrNo = 1;
            int no = 1;
            HashMap fallWktMap = new HashMap();
            HashMap matchSummeryMap = new HashMap();
%>
<%          matchId = (String) session.getAttribute("matchid");
            inningIdOne = request.getParameter("inningIdOne") != null ? request.getParameter("inningIdOne") : "";
            inningIdTwo = request.getParameter("inningIdTwo") != null ? request.getParameter("inningIdTwo") : "";
            flag = request.getParameter("flag") != null ? request.getParameter("flag") : "";
            firstinningbattingteam = request.getParameter("firstinningbattingteam");
            secondinningbattingteam = request.getParameter("secondinningbattingteam");
            LogWriter log = new LogWriter();
            GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
// firstinningbattingteam  = (String) session.getAttribute("firstinningbattingteam");
// secondinningbattingteam = (String)session.getAttribute("secondinningbattingteam");
%>
<%	vparam.add(matchId);
            firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamname_scoresheet", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (firstBatsInningFirstCrs != null && firstBatsInningFirstCrs.size() > 0) {
                    while (firstBatsInningFirstCrs.next()) {
                        teamOneName = firstBatsInningFirstCrs.getString("team1") != null ? firstBatsInningFirstCrs.getString("team1") : "";
                        teamTwoName = firstBatsInningFirstCrs.getString("team2") != null ? firstBatsInningFirstCrs.getString("team2") : "";
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningSecondCrs = null;
            }
%>
<% if (firstinningbattingteam != null) {
%>			<table align=left  width="100%" height="0.1%" style=border-collapse:collapse>
    <tr>
        <td><b><%=teamOneName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1st Inning</b></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td><b>2nd Inning</b></td>
    </tr>
</table>	
<br>
<%}
%>
<% if (secondinningbattingteam != null) {
%>				<br>
<table align=left  width="100%" height="0.1%" style=border-collapse:collapse>
    <tr>
        <td><b><%=teamTwoName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1st Inning</b></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td><b>2nd Inning</b></td>
    </tr>
</table>	
<br>
<%
            }
%>
<br>
<table align=center width=100% style=border-collapse:collapse>
<tr>
<%--First <TD> start here	--%>
<td width=50%>
    <table width="100%" align=center border=1 style=border-collapse:collapse>
    <tr class=firstrow><%--
						<td rowspan="2" colspan="2" align=center nowrap ><font size=1>BATTING<br> ORDER</td>
        --%>
        <td rowspan="2" align=center nowrap width=1%><font size=1>SR.</td>
    </tr>
    <tr class=firstrow>
        <td colspan="1" align=center nowrap width=1%><font size=1>TIME</td>
        <td rowspan="2" align=center nowrap><font size=1>BATSMEN</td>
        <td rowspan="2" align=center nowrap><font size=1>HOW<br>OUT</td>
        <td colspan="2" align=center nowrap><font size=1>NAME OF</td>
        <td rowspan="2" align=center nowrap width=1%><font size=1>MINS</td>
        <td colspan="3" align=center nowrap width=1%><font size=1>TOTAL<br>NO OF</td>
        <td rowspan="2" align=center nowrap width=1%><font size=1>RUNS</td>
    </tr>
    <tr class=firstrow>
        <td align=center nowrap><font size=1>1ST</td>
        <%--<td align=center><font size=1>2ND </td>
        --%><td align=center nowrap width=1%><font size=1>IN</td>
        <%--<td align=center><font size=1>OUT </td>
        --%><td align=center nowrap ><font size=1>FIELDER</font></td>
        <td align=center nowrap><font size=1>BOWLER</font></td>
        <td align=center nowrap width=1%><font size=1>4s</td>
        <td align=center nowrap width=1%><font size=1>6s</td>
        <td align=center nowrap width=1%><font size=1>Balls</td>
    </tr>
    <%  vparam.add(inningIdTwo);
            firstBatsInningSecondCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scoreshett_battingscorercard", vparam, "ScoreDB");
            vparam.removeAllElements();
            subTotal = 0;
            try {
                if (firstBatsInningSecondCrs != null && firstBatsInningSecondCrs.size() > 0) {
                    while (firstBatsInningSecondCrs.next()) {
                        if (!(firstBatsInningSecondCrs.getString("howout").equalsIgnoreCase("DNB"))) {
                            matchSummeryMap.put(firstBatsInningSecondCrs.getString("batsmanid"), no);
                            no = no + 1;
                        }
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningSecondCrs = null;
            }
    %>												
    <% vparam.add(inningIdOne);
            firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scoreshett_battingscorercard", vparam, "ScoreDB");
            vparam.removeAllElements();
            no = 1;
            try {
                if (firstBatsInningFirstCrs != null && firstBatsInningFirstCrs.size() > 0) {
                    while (firstBatsInningFirstCrs.next()) {
                        timeIn = firstBatsInningFirstCrs.getString("timein") != null ? firstBatsInningFirstCrs.getString("timein") : "";
                        if (!timeIn.equals("")) {
                            String splitTime[] = timeIn.split(":");
                            String hourTimeIn = splitTime[0];
                            String minTimeIn = splitTime[1];
                            if (minTimeIn.length() == 1) {
                                String minits = "0" + minTimeIn;
                                timeIn = hourTimeIn + ":" + minits;
                            }
                        }
                        timeOut = firstBatsInningFirstCrs.getString("timeout") != null ? firstBatsInningFirstCrs.getString("timeout") : "";
                        srNo = firstBatsInningFirstCrs.getString("srno") != null ? firstBatsInningFirstCrs.getString("srno") : "";
                        batsman = firstBatsInningFirstCrs.getString("batsman") != null ? firstBatsInningFirstCrs.getString("batsman") : "";
                        howOut = firstBatsInningFirstCrs.getString("howout") != null ? firstBatsInningFirstCrs.getString("howout") : "";
                        fielder = firstBatsInningFirstCrs.getString("fielder") != null ? firstBatsInningFirstCrs.getString("fielder") : "";
                        bowler = firstBatsInningFirstCrs.getString("bowler") != null ? firstBatsInningFirstCrs.getString("bowler") : "";
                        mins = firstBatsInningFirstCrs.getString("mins").trim() != null || (!(firstBatsInningFirstCrs.getString("mins").trim().equalsIgnoreCase("-1"))) ? firstBatsInningFirstCrs.getString("mins").trim() : "";
                        four = firstBatsInningFirstCrs.getString("fours") != null || (!(firstBatsInningFirstCrs.getString("fours").trim().equalsIgnoreCase("-1"))) ? firstBatsInningFirstCrs.getString("fours") : "";
                        six = firstBatsInningFirstCrs.getString("six") != null || (!(firstBatsInningFirstCrs.getString("six").trim().equalsIgnoreCase("-1"))) ? firstBatsInningFirstCrs.getString("six") : "";
                        balls = firstBatsInningFirstCrs.getString("balls") != null || (!(firstBatsInningFirstCrs.getString("balls").trim().equalsIgnoreCase("-1"))) ? firstBatsInningFirstCrs.getString("balls") : "";
                        runs = firstBatsInningFirstCrs.getString("runs") != null || (!(firstBatsInningFirstCrs.getString("runs").trim().equalsIgnoreCase("-1"))) ? firstBatsInningFirstCrs.getString("runs") : "0";
                        fallWktMap.put(firstBatsInningFirstCrs.getString("batsmanid"), no);
                        batterId = firstBatsInningFirstCrs.getString("batsmanid") != null ? firstBatsInningFirstCrs.getString("batsmanid") : "";
                        if (matchSummeryMap.containsKey(batsmanId)) {
                            batsSrNo = matchSummeryMap.get(batsmanId).toString();
                        } else {
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
        <%--<td  nowrap align=center><font color="#003399" size=1><%=batsSrNo%></td>
        --%><td  nowrap align=right width=1%><font color="#003399" size=1><%=timeIn%></td>
        <%--<td  nowrap align=right><font color="#003399" size=1><%=timeOut%></td>
        --%><td  nowrap ><font color="#003399" size=1><%=batsman%></td>
        <%
                        if (howOut.equalsIgnoreCase("N.O.")) {
        %>											
        <td  nowrap ><font color="red" size=1><%=howOut%></td>
        <%
        } else {
        %>											
        <td  nowrap ><font color="#003399" size=1><%=howOut%></td>
        <%
                        }
        %>											
        <td  nowrap ><font color="#003399" size=1><%=howOut.trim().equalsIgnoreCase("ct&b")?"":fielder%></td>
        <td  nowrap ><font color="#003399" size=1><%=howOut.equalsIgnoreCase("r.o.")?"":bowler%></td>
        <td  nowrap align=right width=1%><font color="#003399" size=1><a href="javascript:showPlayerTimeDetail('<%=batterId%>','<%=inningIdOne%>')"><%=mins%></a></td>
        <td  nowrap align=right width=1%><font color="#003399" size=1><%=four%></td>
        <td  nowrap align=right width=1%><font color="#003399" size=1><%=six%></td>
        <td  nowrap align=right width=1%><font color="#003399" size=1><%=balls%></td>
        <td  nowrap align=right width=1%><font color="#003399" size=1><%=runs%></td>
    </tr>
    <%				no = no + 1;
                }
            } else {
                for (k = 0; k <= 10; k++) {

    %>
    <tr>
        <td  nowrap >&nbsp;</td>
        <%--<td  nowrap ></td>
        --%><td  nowrap >&nbsp;</td><%--
            <td  nowrap ></td>
        --%><td  nowrap >&nbsp;</td>
        <td  nowrap >&nbsp;</td>
        <td  nowrap >&nbsp;</td>
        <td  nowrap >&nbsp;</td>
        <td  nowrap ></td>
        <td  nowrap >&nbsp;</td>
        <td  nowrap >&nbsp;</td>
        <td  nowrap >&nbsp;</td>
        <td  nowrap >&nbsp;</td>
    </tr>
    <%	 			}
    %>			
    <%		 }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningFirstCrs = null;

            }
    %>	
    <%      vparam.add(inningIdOne);
            firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total", vparam, "ScoreDB");
            vparam.removeAllElements();
            int firstInningWkt = 0;
            try {
                if (firstBatsInningFirstCrs != null) {
                    while (firstBatsInningFirstCrs.next()) {
                        byes = firstBatsInningFirstCrs.getString("byes") != null ? firstBatsInningFirstCrs.getString("byes") : "0";
                        legByes = firstBatsInningFirstCrs.getString("legbyes") != null ? firstBatsInningFirstCrs.getString("legbyes") : "0";
                        noBall = firstBatsInningFirstCrs.getString("noballs") != null ? firstBatsInningFirstCrs.getString("noballs") : "0";
                        wide = firstBatsInningFirstCrs.getString("wides") != null ? firstBatsInningFirstCrs.getString("wides") : "0";
                        battingSubTotal = firstBatsInningFirstCrs.getString("subtotal") != null ? firstBatsInningFirstCrs.getString("subtotal") : "0";
                        totalExtras = firstBatsInningFirstCrs.getString("total_extra") != null ? firstBatsInningFirstCrs.getString("total_extra") : "0";
                        penaltyExtras = firstBatsInningFirstCrs.getString("penalty") != null ? firstBatsInningFirstCrs.getString("penalty") : "0";
                        matchTotalRun = firstBatsInningFirstCrs.getString("total_score") != null ? firstBatsInningFirstCrs.getString("total_score") : "0";
                        matchTotalWkt = firstBatsInningFirstCrs.getString("wicket") != null ? firstBatsInningFirstCrs.getString("wicket") : "0";
                        matchTotalOver = firstBatsInningFirstCrs.getString("overs") != null ? firstBatsInningFirstCrs.getString("overs") : "0";
                        //penaltyReason = firstBatsInningFirstCrs.getString("penaltyreason")!=null?firstBatsInningFirstCrs.getString("penaltyreason"):"";

                        firstInningWkt = Integer.parseInt(matchTotalWkt);
                        firstInningExtrasTotal = Integer.parseInt(byes) +
                                Integer.parseInt(legByes) +
                                Integer.parseInt(penaltyExtras);
                        tExtras = Integer.parseInt(byes) +
                                Integer.parseInt(legByes) +
                                Integer.parseInt(penaltyExtras) +
                                Integer.parseInt(wide) +
                                Integer.parseInt(noBall);
                        grandTotal = Integer.parseInt(battingSubTotal) + tExtras;
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningFirstCrs = null;
            }

    %>
    <%	vparam.add(inningIdTwo);
            firstBatsInningSecondCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total", vparam, "ScoreDB");
            vparam.removeAllElements();
            int secondInningWkt = 0;
            try {
                if (firstBatsInningSecondCrs != null) {
                    while (firstBatsInningSecondCrs.next()) {
                        secondInningByes = firstBatsInningSecondCrs.getString("byes") != null ? firstBatsInningSecondCrs.getString("byes") : "0";
                        secondInningLegByes = firstBatsInningSecondCrs.getString("legbyes") != null ? firstBatsInningSecondCrs.getString("legbyes") : "0";
                        secondInningPenaltyExtras = firstBatsInningSecondCrs.getString("penalty") != null ? firstBatsInningSecondCrs.getString("penalty") : "0";
                        secondInningMatchTotalWkt = firstBatsInningSecondCrs.getString("wicket") != null ? firstBatsInningSecondCrs.getString("wicket") : "0";
                        secondInningmatchTotalOver = firstBatsInningSecondCrs.getString("overs") != null ? firstBatsInningSecondCrs.getString("overs") : "0";
                        //penaltyReason = firstBatsInningFirstCrs.getString("penaltyreason")!=null?firstBatsInningFirstCrs.getString("penaltyreason"):"";
                        //secondInningWkt		    = Integer.parseInt(matchTotalWkt);
                        secondInningExtrasTotal = Integer.parseInt(secondInningByes) +
                                Integer.parseInt(secondInningLegByes) +
                                Integer.parseInt(secondInningPenaltyExtras);
                        secondInningWkt = Integer.parseInt(secondInningMatchTotalWkt);
                        secondInningExtrasTotal = Integer.parseInt(secondInningByes) +
                                Integer.parseInt(secondInningLegByes) +
                                Integer.parseInt(secondInningPenaltyExtras);
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningSecondCrs = null;
            }

    %>
    <%  vparam.add(inningIdOne);
            reservePlayerCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_twelthnreserveplayers", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (reservePlayerCrs != null) {
                    while (reservePlayerCrs.next()) {
                        if (reservePlayerCrs.getString("player_status").trim().equalsIgnoreCase("R")) {
                            reservePlayer = reservePlayer + reservePlayerCrs.getString("reserve_player") + "~";
                        }
                        if (reservePlayerCrs.getString("player_status").trim().equalsIgnoreCase("T")) {
                            twelveman = reservePlayerCrs.getString("reserve_player") != null ? reservePlayerCrs.getString("reserve_player") : "";
                        }
                    }
                    String reservebatsman[] = reservePlayer.split("~");
                    for (int count1 = 0; count1 < reservebatsman.length; count1++) {
                    }
                    if (reservebatsman != null) {
                        if (reservebatsman.length == 4) {
                            reservePlayerOne = reservebatsman[0];
                            reservePlayerTwo = reservebatsman[1];
                            reservePlayerThree = reservebatsman[2];
                            reservePlayerFour = reservebatsman[3];
                        }
                        if (reservebatsman.length == 3) {
                            reservePlayerOne = reservebatsman[0];
                            reservePlayerTwo = reservebatsman[1];
                            reservePlayerThree = reservebatsman[2];
                        } else if (reservebatsman.length == 2) {
                            reservePlayerOne = reservebatsman[0];
                            reservePlayerTwo = reservebatsman[1];
                        } else if (reservebatsman.length == 1) {
                            reservePlayerOne = reservebatsman[0];
                        }
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                reservePlayerCrs = null;
            }


    %>
    <%
            vparam.add(inningIdOne);
            firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_newballtakenfortestmatch", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (firstBatsInningFirstCrs != null) {
                    while (firstBatsInningFirstCrs.next()) {
                        if (firstBatsInningFirstCrs.getString("srno").equalsIgnoreCase("1")) {
                            secondNewBallOver = firstBatsInningFirstCrs.getString("over_num") != null ? firstBatsInningFirstCrs.getString("over_num") : "";
                            secondNewBallScore = firstBatsInningFirstCrs.getString("runs") != null ? firstBatsInningFirstCrs.getString("runs") : "";
                            secondNewBallBats = firstBatsInningFirstCrs.getString("batsman") != null ? firstBatsInningFirstCrs.getString("batsman") : "";
                            secondNewBallBowl = firstBatsInningFirstCrs.getString("bowler") != null ? firstBatsInningFirstCrs.getString("bowler") : "";
                        }
                        if (firstBatsInningFirstCrs.getString("srno").equalsIgnoreCase("2")) {
                            thirdNewBallOver = firstBatsInningFirstCrs.getString("over_num") != null ? firstBatsInningFirstCrs.getString("over_num") : "";
                            thirdNewBallScore = firstBatsInningFirstCrs.getString("runs") != null ? firstBatsInningFirstCrs.getString("runs") : "";
                            thirdNewBallBats = firstBatsInningFirstCrs.getString("batsman") != null ? firstBatsInningFirstCrs.getString("batsman") : "";
                            thirdNewBallBowl = firstBatsInningFirstCrs.getString("bowler") != null ? firstBatsInningFirstCrs.getString("bowler") : "";
                        }
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningFirstCrs = null;
            }
    %>
    <%
            vparam.add(inningIdOne);
            firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_inningtime", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (firstBatsInningFirstCrs != null) {
                    while (firstBatsInningFirstCrs.next()) {
                        inningTime = firstBatsInningFirstCrs.getString("inningtime") != null ? firstBatsInningFirstCrs.getString("inningtime") : "";
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningFirstCrs = null;
            }

    %>
    <%
            vparam.add("");
            vparam.add(inningIdOne);
            vparam.add("2");
            firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_resultpoint", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (firstBatsInningFirstCrs != null) {
                    while (firstBatsInningFirstCrs.next()) {
                        intermissionPoint = firstBatsInningFirstCrs.getString("intermission") != null ? firstBatsInningFirstCrs.getString("intermission") : "0";
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
    %>
    
    
    <tr>
    <td colspan=4 nowrap ><font size=1>12th Man</b> <font color="#003399"><%=twelveman%></td>
    </tr>
    <tr>	
    <td colspan=4 nowrap ><font size=1>Penalty Extras</b> :<font color="#003399"><%=penaltyExtras%></font></td>
        <td colspan=2 nowrap align=right><font size=1>Byes:</b>
        <font color="#003399"><%=byes%></td>
        <td nowrap align=right></td>
        <td colspan=3 nowrap align=right ><font size=1>SubTotal</td>
        <td align=right nowrap><font color="#003399"  ><%=battingSubTotal%></td>
    </tr>
    <tr>	
        <td colspan=4 nowrap align=left><font size=1>Reserves:<font color="#003399" size=1><%=reservePlayerOne%></font></td>
    <td colspan=2 nowrap align=right><font size=1>LegByes:</b> <font color="#003399"><%=legByes%></td>
        <td nowrap align=right></td>
    <td colspan=3 nowrap align=right ><font size=1>Total Extras:</b></td>
        <td align=right nowrap ><font color="#003399"><%=tExtras%></td>
    </tr>
    <tr>	
        <td colspan=4 nowrap align=left ><font color="#003399" size=1><%=reservePlayerTwo%></font></td>
    <td colspan=2 nowrap align=right ><font size=1>NoBalls:</b><font color="#003399"><%=noBall%></td>
        <td nowrap align=right ></td>
    <td colspan=3 rowspan=2 align=right nowrap><font size=1>Grand Total</b></td>
        <% if(intermissionPoint.equals("0")){
        %>  <td align=right rowspan=2 nowrap><font color="#003399"><%=grandTotal%></td>
        <%}else{
        %>   <td align=right rowspan=2 nowrap><font color="#003399"><%=grandTotal%>(D)</td>
         <%}%>
    </tr>
    <tr>
        <td colspan=4 align=left nowrap><font color="#003399" size=1><%=reservePlayerThree%></td>
    <td colspan=2 align=right nowrap><font size=1>Wides</b> :<font color="#003399"><%=wide%></td>
        <td align=right nowrap></td>
    </tr>
    <tr>
        <td colspan=4 align=left nowrap><font color="#003399" size=1><%=reservePlayerFour%></td>
        <td colspan=2 align=right nowrap>&nbsp;</td>
        <td align=right nowrap>&nbsp;</td>
    </tr>
    <tr>
    <td colspan=7 nowrap ><font size=1>Total time taken for 1st innings</font></b>
    <font color="#003399"><%=inningTime%>
</font><font size=1>mins</font></b> ;</font>
<font size=1>Overs</font></b> <font color="#003399"><%=matchTotalOver%></td>
<td colspan=3 nowrap align=right ><font size=1>Wickets Lost</b></td>
<td nowrap align=right><font color="#003399"  ><%=matchTotalWkt%></td>
</tr>
<tr>
<td colspan=7 nowrap ><font size=1>2nd New ball claimed at Overs:</font></b>
    <font color="#003399"><%=secondNewBallOver%></font>
    <font size=1>Score </font></b>
<font color="#003399"><%=secondNewBallScore%></td>
<td colspan=3 nowrap align=right ><font size=1>Overs Short</b></td>
    <td  nowrap align=right><font color="#003399"><%=shortOvers%></td>
    </tr>
    <tr>
    <td colspan=7 nowrap><font size=1>3rd New ball claimed at Overs:</b></font>
        <font color="#003399" size=1>
        <%=thirdNewBallOver%></font> <font size=1> Score</font></b>
    <font color="#003399" size=1><%=thirdNewBallScore%></font></td>
    <td colspan=3 nowrap align=center></td>
    <td></td>
</tr>
</table>
<table width=100% >
<tr>
    <td colspan=13 nowrap ><font size=1>2nd New ball Batsman:</font>
        </b><font color="#003399" size=1><%=secondNewBallBats%></font>
        <font size=1>Bowler:</font></b>  <font color="#003399" size=1><%=secondNewBallBowl%>;</font>
        <font size=1>3rd New ball Batsman:</font></b>
        <font color="#003399" size=1><%=thirdNewBallBats%>
        </font>
    <font size=1>Bowlers:</font></b><font color="#003399" size=1><%=thirdNewBallBowl%></font></td>
</tr>	
<tr>
<td colspan=13>
    <table width=100% border=1> 
    <tr>
    <td nowrap><font size=1>Penalty Reason</b></td>
    </tr>
    <%
            vparam.add(inningIdOne);
            penaltyReasonCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_penaltyreason", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (penaltyReasonCrs != null) {
                    while (penaltyReasonCrs.next()) {
                        penaltyDescription = penaltyReasonCrs.getString("description") != null ? penaltyReasonCrs.getString("description") : "";
    %>							
    <tr>
        <td nowrap ><font color="#003399"><%=penaltyDescription%></font></td>
    </tr>
    <%
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
            }

    %>
    </table>
</td>
</tr>
</table>

<table width="80%" height=100% border="1" style=border-collapse:collapse>
<table border=1 width=100%>
    <tr class=firstrow>
        <td colspan=2 align=center nowrap><font size=1>BOWLING<br>ORDER</td>
        <td colspan=1 align=center nowrap><font size=1>BOWLER</td>
        <td colspan=6 align=center nowrap><font size=1><b>1ST INNINGS</b></td>
        <td align=center  nowrap><font size=1>&nbsp;&nbsp;</td>
        <td colspan=6 align=center nowrap><font size=1><b>2ND INNINGS</b></td>
    </tr>
    <tr>
        <td align=center  nowrap><font size=1>1ST</td>
        <td align=center  nowrap><font size=1>2ND</td><%--
           <td align=center  nowrap><font size=1>Type</td>
        --%><td align=center  nowrap><font size=1>Names</td>
        <td align=center  nowrap><font size=1>Overs</td>
        <td align=center  nowrap><font size=1>Mdns.</td>
        <td align=center  nowrap><font size=1>Runs</td>
        <td align=center  nowrap><font size=1>Wkts</td>
        <td align=center  nowrap><font size=1>NB</td>
        <td align=center  nowrap><font size=1>WB</td>
        <td align=center  nowrap><font size=1>&nbsp;&nbsp;</td>
        <td align=center  nowrap><font size=1>Overs</td>
        <td align=center  nowrap><font size=1>Mdns.</td>
        <td align=center  nowrap><font size=1>Runs</td>
        <td align=center  nowrap><font size=1>Wkts</td>
        <td align=center  nowrap><font size=1>NB</td>
        <td align=center  nowrap><font size=1>WB</td>
    </tr>
    <%	vparam.add(matchId);
            vparam.add(inningIdOne);
            vparam.add(inningIdTwo);
            bowledAnalysisCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowlinganalysisfortestmatch", vparam, "ScoreDB");
            vparam.removeAllElements();
            crsSize = bowledAnalysisCrs.size();
            rowGrowLength = 11 - crsSize;
            float secondTotalOver = 0;
            int secondTotalMaiden = 0;
            int secondTotalRun = 0;
            int secondTotalWkt = 0;
            int secondTotalNB = 0;
            int secondTotalWB = 0;
            int firstInningBowlerWicket = 0;
            int secondInningBowlerWicket = 0;
            int firstInningTotalWicket = 0;
            int secondInningTotalWicket = 0;

            try {
                if (bowledAnalysisCrs != null) {
                    while (bowledAnalysisCrs.next()) {
                        bowlerName = bowledAnalysisCrs.getString("bowlername") != null ? bowledAnalysisCrs.getString("bowlername") : "";
                        bowlerId = bowledAnalysisCrs.getString("inningtwo") != null ? bowledAnalysisCrs.getString("inningtwo") : "";
                        bowlerOver = bowledAnalysisCrs.getString("noofover") != null ? bowledAnalysisCrs.getString("noofover") : "0";
                        bowlerMaiden = bowledAnalysisCrs.getString("maiden") != null ? bowledAnalysisCrs.getString("maiden") : "0";
                        bowlerRunrate = bowledAnalysisCrs.getString("runs") != null ? bowledAnalysisCrs.getString("runs") : "0";
                        bowlerWicket = bowledAnalysisCrs.getString("wicket") != null ? bowledAnalysisCrs.getString("wicket") : "0";
                        bowlerNB = bowledAnalysisCrs.getString("noball") != null ? bowledAnalysisCrs.getString("noball") : "0";
                        bowlerWB = bowledAnalysisCrs.getString("wideball") != null ? bowledAnalysisCrs.getString("wideball") : "0";

                        secondBowlerOver = bowledAnalysisCrs.getString("noofover_1") != null ? bowledAnalysisCrs.getString("noofover_1") : "0";
                        secondBowlerMaiden = bowledAnalysisCrs.getString("maiden_1") != null ? bowledAnalysisCrs.getString("maiden_1") : "0";
                        secondBowlerRunrate = bowledAnalysisCrs.getString("runs_1") != null ? bowledAnalysisCrs.getString("runs_1") : "0";
                        secondBowlerWicket = bowledAnalysisCrs.getString("wicket_1") != null ? bowledAnalysisCrs.getString("wicket_1") : "0";
                        secondBowlerNB = bowledAnalysisCrs.getString("noball_1") != null ? bowledAnalysisCrs.getString("noball_1") : "0";
                        secondBowlerWB = bowledAnalysisCrs.getString("wideball_1") != null ? bowledAnalysisCrs.getString("wideball_1") : "0";

                        totalOver = totalOver + Float.parseFloat(bowlerOver);
                        totalMaiden = totalMaiden + Integer.parseInt(bowlerMaiden);
                        totalRun = totalRun + Integer.parseInt(bowlerRunrate);
                        totalWkt = totalWkt + Integer.parseInt(bowlerWicket);
                        totalNB = totalNB + Integer.parseInt(bowlerNB);
                        totalWB = totalWB + Integer.parseInt(bowlerWB);

                        firstInningBowlerWicket = firstInningWkt - totalWkt;

                        secondTotalOver = secondTotalOver + Float.parseFloat(secondBowlerOver);
                        secondTotalMaiden = secondTotalMaiden + Integer.parseInt(secondBowlerMaiden);
                        secondTotalRun = secondTotalRun + Integer.parseInt(secondBowlerRunrate);
                        secondTotalWkt = secondTotalWkt + Integer.parseInt(secondBowlerWicket);
                        secondTotalNB = secondTotalNB + Integer.parseInt(secondBowlerNB);
                        secondTotalWB = secondTotalWB + Integer.parseInt(secondBowlerWB);

                        secondInningBowlerWicket = secondInningWkt - secondTotalWkt;
                        if (bowlerId.equalsIgnoreCase("12")) {
                            bowlerId = "";
                        }
    %>   
            
    <tr>
        <td align=center  nowrap><font color="#003399"  size=1><%=bowlerSrNo%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=bowlerId%></td>
        <%--<td align=right  nowrap><font size=1></td>
        --%><td nowrap><font color="#003399" font size=1><%=bowlerName%></td>
        <td align=right  nowrap><font color="#003399"  size=1><%=bowlerOver%></td>
        <td align=right  nowrap><font color="#003399"  size=1><%=bowlerMaiden%></td>
        <td align=right  nowrap><font color="#003399"  size=1><%=bowlerRunrate%></td>
        <td align=right  nowrap><font color="#003399"  size=1><%=bowlerWicket%></td>
        <td align=right  nowrap><font color="#003399"  size=1><%=bowlerNB%></td>
        <td align=right  nowrap><font color="#003399"  size=1><%=bowlerWB%></td>
        <td align=right  nowrap><font color="#003399"  size=1>&nbsp;</td>
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
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                bowledAnalysisCrs = null;
            }

    %>
    <%
            for (k = 0; k < rowGrowLength; k++) {
    %>
    
    <tr>
        <td align=center  nowrap><font color="#003399"  size=1><%=bowlerSrNo%></td>
        <td align=center  nowrap><font color="#003399"></td>
        <%--<td align=center  nowrap><font color="#003399"></td>
        --%><td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399">&nbsp;</td>
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
        <%--<td align=center  nowrap><font color="#003399"></td>
        --%><td align=center  nowrap><font color="#003399" size=1>SubTotal</td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=totalRun%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=totalWkt%></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399">&nbsp;&nbsp;</td>
        <td align=center  nowrap><font color="#003399"  size=1></td>
        <td align=center  nowrap><font color="#003399"  size=1></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=secondTotalRun%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=secondTotalWkt%></td>
        <td align=center  nowrap><font color="#003399"  size=1></td>
        <td align=center  nowrap><font color="#003399"  size=1></td>
    </tr>		
    
    <tr>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <%--<td align=center  nowrap><font color="#003399"></td>
        --%><td align=center  nowrap><font color="#003399"  size=1>Byes/LegByes/Wkt</td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=firstInningExtrasTotal%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=firstInningBowlerWicket%></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399">&nbsp;&nbsp;</td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=secondInningExtrasTotal%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=secondInningBowlerWicket%></td>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
    </tr>											
    
    <%	extraPlusTotalRun = totalRun + firstInningExtrasTotal;
            firstInningTotalWicket = firstInningBowlerWicket + totalWkt;
    %>	
    <%
            secondExtraPlusTotalRun = secondTotalRun + secondInningExtrasTotal;
            secondInningTotalWicket = secondInningBowlerWicket + secondTotalWkt;
    %>													
    <tr>
        <td align=center  nowrap><font color="#003399"></td>
        <td align=center  nowrap><font color="#003399"></td>
        <%--<td align=center  nowrap><font color="#003399"></td>
        --%><td align=center  nowrap><font color="#003399"  size=1>GrandTotal</td>
        <td align=center  nowrap><font color="#003399"  size=1><%=matchTotalOver%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=totalMaiden%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=extraPlusTotalRun%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=firstInningTotalWicket%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=totalNB%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=totalWB%></td>
        <td align=center  nowrap><font color="#003399">&nbsp;&nbsp;</td>
        <td align=center  nowrap><font color="#003399"><%=secondInningmatchTotalOver%></td>
        <td align=center  nowrap><font color="#003399"><%=secondTotalMaiden%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=secondExtraPlusTotalRun%></td>
        <td align=center  nowrap><font color="#003399"  size=1><%=secondInningTotalWicket%></td>
        <td align=center  nowrap><font color="#003399"><%=secondTotalNB%></td>
        <td align=center  nowrap><font color="#003399"><%=secondTotalWB%></td>
    </tr>			
</table>
</td>
<%-- First <TD> ends here	--%>
<%-- Second <TD> start here --%>
<td width=50%>
    <table width="100%"  border="1" style=border-collapse:collapse>
    <tr class=firstrow>
        <td colspan="1" align=center width=1%><font size=1>TIME</td>
        <td rowspan="2" align=center ><font size=1>BATSMEN</td>
        <td rowspan="2" align=center ><font size=1>HOW<br>OUT</td>
        <td colspan="2" align=center ><font size=1>NAME OF</td>
        <td rowspan="2" align=center width=1%><font size=1>MINS</td>
        <td colspan="3" align=center width=1%><font size=1>TOTAL<br>NO OF</td>
        <td rowspan="2" align=center width=1%><font size=1>RUNS</td>
    </tr>
    <tr class=firstrow>
        <td align=center width=1%><font size=1>IN</td>
        <%--<td align=center ><font size=1>OUT </td>
        --%>
        <td align=center ><font size=1>FIELDER</td>
        <td align=center ><font size=1>BOWLER</td>
        <td align=center width=1%><font size=1 >4s</td>
        <td align=center width=1%><font size=1 >6s</td>
        <td align=center width=1%><font size=1 >Balls</td>
    </tr>
    <%	//vparam.add(matchId);
        // vparam.add(inningIdOne);
            vparam.add(inningIdTwo);
            firstBatsInningSecondCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scoreshett_battingscorercard", vparam, "ScoreDB");
		    vparam.removeAllElements();
            subTotal = 0;
            k = 0;
            try {
                if (firstBatsInningSecondCrs != null && firstBatsInningSecondCrs.size() > 0) {
		             while (firstBatsInningSecondCrs.next()) {
                        timeIn = firstBatsInningSecondCrs.getString("timein") != null ? firstBatsInningSecondCrs.getString("timein") : "";
                        if (!timeIn.equals("")) {
                            String splitTime[] = timeIn.split(":");
                            String hourTimeIn = splitTime[0];
                            String minTimeIn = splitTime[1];
                            if (minTimeIn.length() == 1) {
                                String minits = "0" + minTimeIn;
                                timeIn = hourTimeIn + ":" + minits;
                            }
                        }
			            timeOut = firstBatsInningSecondCrs.getString("timeout") != null ? firstBatsInningSecondCrs.getString("timeout") : "";
                        srNo = firstBatsInningSecondCrs.getString("srno") != null ? firstBatsInningSecondCrs.getString("srno") : "";
                        batsman = firstBatsInningSecondCrs.getString("batsman") != null ? firstBatsInningSecondCrs.getString("batsman") : "";
                        howOut = firstBatsInningSecondCrs.getString("howout") != null ? firstBatsInningSecondCrs.getString("howout") : "";
                        fielder = firstBatsInningSecondCrs.getString("fielder") != null ? firstBatsInningSecondCrs.getString("fielder") : "";
                        bowler = firstBatsInningSecondCrs.getString("bowler") != null ? firstBatsInningSecondCrs.getString("bowler") : "";
                        mins = firstBatsInningSecondCrs.getString("mins").trim() != null || (!(firstBatsInningSecondCrs.getString("mins").trim().equalsIgnoreCase("-1"))) ? firstBatsInningSecondCrs.getString("mins").trim() : "";
                        four = firstBatsInningSecondCrs.getString("fours") != null || (!(firstBatsInningSecondCrs.getString("fours").trim().equalsIgnoreCase("-1"))) ? firstBatsInningSecondCrs.getString("fours") : "";
                        six = firstBatsInningSecondCrs.getString("six") != null || (!(firstBatsInningSecondCrs.getString("six").trim().equalsIgnoreCase("-1"))) ? firstBatsInningSecondCrs.getString("six") : "";
                        balls = firstBatsInningSecondCrs.getString("balls") != null || (!(firstBatsInningSecondCrs.getString("balls").trim().equalsIgnoreCase("-1"))) ? firstBatsInningSecondCrs.getString("balls") : "";
                        runs = firstBatsInningSecondCrs.getString("runs") != null || (!(firstBatsInningSecondCrs.getString("runs").trim().equalsIgnoreCase("-1"))) ? firstBatsInningSecondCrs.getString("runs") : "0";
						batterId = firstBatsInningSecondCrs.getString("batsmanid") != null ? firstBatsInningSecondCrs.getString("batsmanid") : "";
                      //subTotal   = subTotal + Integer.parseInt(runs);
                      	
                      	if(firstBatsInningSecondCrs.getString("mins").trim().equals("-1")){
							mins = "";
						}
						if(firstBatsInningSecondCrs.getString("fours").trim().equals("-1")){
							four = "";
						}
						if(firstBatsInningSecondCrs.getString("six").trim().equals("-1")){
							six = "";
						}
						if(firstBatsInningSecondCrs.getString("balls").trim().equals("-1")){
							balls = "";
						}
						if(firstBatsInningSecondCrs.getString("runs").trim().equals("-1")){
							runs = "";
						}
    %>		
    <tr>
        <td align=right nowrap width=1%><font color="#003399"  size=1><%=timeIn%></td>
        <%--<td align=right nowrap ><font color="#003399"  size=1><%=timeOut%></td>
        --%>
        <td align=left nowrap ><font color="#003399"  size=1><%=batsman%></td>
        <%
                        if (howOut.equalsIgnoreCase("N.O.")) {
        %>											
        <td  nowrap ><font color="red" size=1><%=howOut%></td>
        <%
        } else {
        %>											
        <td  nowrap ><font color="#003399" size=1><%=howOut%></td>
        <%
          }
        %>											
        <td nowrap><font color="#003399"  size=1><%=fielder%></td>
        <td nowrap><font color="#003399"  size=1><%=bowler%></td>
        <td align=right nowrap width=1%> <font color="#003399" size=1><a href="javascript:showPlayerTimeDetail('<%=batterId%>','<%=inningIdTwo%>')"><%=mins%></a></td>
        <td align=right nowrap width=1%><font color="#003399"  size=1><%=four%></td>
        <td align=right nowrap width=1%><font color="#003399"  size=1><%=six%></td>
        <td align=right nowrap width=1%><font color="#003399"  size=1><%=balls%></td>
        <td align=right nowrap width=1%><font color="#003399"  size=1><%=runs%></td>
    </tr>
    <%

                }
            } else {
                for (k = 0; k <= 10; k++) {
    %>
    <tr>
        <td align=center nowrap>&nbsp;</td><%--
        <td align=center nowrap ></td>
        --%>
        <td align=center nowrap>&nbsp;</td>
        <td align=center nowrap>&nbsp;</td>
        <td align=center nowrap>&nbsp;</td>
        <td align=center nowrap>&nbsp;</td>
        <td align=center nowrap>&nbsp;</td>
        <td align=center nowrap>&nbsp;</td>
        <td align=center nowrap>&nbsp;</td>
        <td align=center nowrap>&nbsp;</td>
        <td align=center nowrap>&nbsp;</td>
    </tr>
    <%                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningSecondCrs = null;
            }

    %>	
    <%
            vparam.add(inningIdTwo);
            firstBatsInningSecondCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total", vparam, "ScoreDB");
            vparam.removeAllElements();
            tExtras = 0;
            grandTotal = 0;
            try {
                if (firstBatsInningSecondCrs != null) {
                    while (firstBatsInningSecondCrs.next()) {
                        byes = firstBatsInningSecondCrs.getString("byes") != null ? firstBatsInningSecondCrs.getString("byes") : "0";
                        legByes = firstBatsInningSecondCrs.getString("legbyes") != null ? firstBatsInningSecondCrs.getString("legbyes") : "0";
                        noBall = firstBatsInningSecondCrs.getString("noballs") != null ? firstBatsInningSecondCrs.getString("noballs") : "0";
                        wide = firstBatsInningSecondCrs.getString("wides") != null ? firstBatsInningSecondCrs.getString("wides") : "0";
                        battingSubTotal = firstBatsInningSecondCrs.getString("subtotal") != null ? firstBatsInningSecondCrs.getString("subtotal") : "0";
                        totalExtras = firstBatsInningSecondCrs.getString("total_extra") != null ? firstBatsInningSecondCrs.getString("total_extra") : "0";
                        penaltyExtras = firstBatsInningSecondCrs.getString("penalty") != null ? firstBatsInningSecondCrs.getString("penalty") : "0";
                        matchTotalRun = firstBatsInningSecondCrs.getString("total_score") != null ? firstBatsInningSecondCrs.getString("total_score") : "0";
                        matchTotalWkt = firstBatsInningSecondCrs.getString("wicket") != null ? firstBatsInningSecondCrs.getString("wicket") : "0";
                        matchTotalOver = firstBatsInningSecondCrs.getString("overs") != null ? firstBatsInningSecondCrs.getString("overs") : "0";
                        //penaltyReason = firstBatsInningFirstCrs.getString("penaltyreason")!=null?firstBatsInningFirstCrs.getString("penaltyreason"):"";

                        tExtras = Integer.parseInt(byes) +
                                Integer.parseInt(legByes) +
                                Integer.parseInt(penaltyExtras) +
                                Integer.parseInt(wide) +
                                Integer.parseInt(noBall);
                        grandTotal = Integer.parseInt(battingSubTotal) + tExtras;
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningSecondCrs = null;
            }

    %>
    <%	secondNewBallOver = "";
            secondNewBallScore = "";
            secondNewBallBats = "";
            secondNewBallBowl = "";
            thirdNewBallOver = "";
            thirdNewBallScore = "";
            thirdNewBallBats = "";
            thirdNewBallBowl = "";
            vparam.add(inningIdTwo);
            firstBatsInningSecondCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_newballtakenfortestmatch", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (firstBatsInningSecondCrs != null) {
                    while (firstBatsInningSecondCrs.next()) {
                        if (firstBatsInningSecondCrs.getString("srno").equalsIgnoreCase("1")) {
                            secondNewBallOver = firstBatsInningSecondCrs.getString("over_num") != null ? firstBatsInningSecondCrs.getString("over_num") : "";
                            secondNewBallScore = firstBatsInningSecondCrs.getString("runs") != null ? firstBatsInningSecondCrs.getString("runs") : "";
                            secondNewBallBats = firstBatsInningSecondCrs.getString("batsman") != null ? firstBatsInningSecondCrs.getString("batsman") : "";
                            secondNewBallBowl = firstBatsInningSecondCrs.getString("bowler") != null ? firstBatsInningSecondCrs.getString("bowler") : "";
                        }
                        if (firstBatsInningSecondCrs.getString("srno").equalsIgnoreCase("2")) {
                            thirdNewBallOver = firstBatsInningSecondCrs.getString("over_num") != null ? firstBatsInningSecondCrs.getString("over_num") : "";
                            thirdNewBallScore = firstBatsInningSecondCrs.getString("runs") != null ? firstBatsInningSecondCrs.getString("runs") : "";
                            thirdNewBallBats = firstBatsInningSecondCrs.getString("batsman") != null ? firstBatsInningSecondCrs.getString("batsman") : "";
                            thirdNewBallBowl = firstBatsInningSecondCrs.getString("bowler") != null ? firstBatsInningSecondCrs.getString("bowler") : "";
                        }
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningSecondCrs = null;
            }
    %>
    <%
            vparam.add(inningIdTwo);
            firstBatsInningSecondCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_inningtime", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (firstBatsInningSecondCrs != null) {
                    while (firstBatsInningSecondCrs.next()) {
                        inningTime = firstBatsInningSecondCrs.getString("inningtime") != null ? firstBatsInningSecondCrs.getString("inningtime") : "";
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                firstBatsInningSecondCrs = null;
            }

    %>
     <%
            vparam.add("");
            vparam.add(inningIdTwo);
            vparam.add("2");
            firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_resultpoint", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (firstBatsInningFirstCrs != null) {
                    while (firstBatsInningFirstCrs.next()) {
                        intermissionPoint = firstBatsInningFirstCrs.getString("intermission") != null ? firstBatsInningFirstCrs.getString("intermission") : "0";
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
    %>
    <tr>
        <td colspan=5 nowrap>&nbsp;</td>
    </tr>
    <tr>	
    <td colspan=4 nowrap ><font size=1>Penalty Extras</b> :<font color="#003399"><%=penaltyExtras%></td>
        <td nowrap align=right ><font size=1>Byes:</b> 
        <font color="#003399"><%=byes%></font></td>
    <td colspan=4 nowrap align=right><font size=1>SubTotal</b></td>
        <td align=right nowrap><font color="#003399"><%=battingSubTotal%></font></td>
    </tr>
    <tr>	
        <td colspan=4 nowrap></td>
    <td nowrap align=right><font size=1>Leg Byes:</b><font color="#003399"><%=legByes%></font></td>
    <td nowrap align=right colspan=4><font size=1>Total Extras:</b></td>
        <td align=right nowrap><font color="#003399"><%=tExtras%></font></td>
    </tr>
    <tr>	
        <td colspan=4 nowrap align=center ></td>
    <td nowrap align=right><font size=1>No Balls:</b> <font color="#003399"><%=noBall%></font></td>
    <td rowspan=2 colspan=4 align=right><font size=1 >Grand Total</b></td>
        <%if (intermissionPoint.equals("0")){
        %><td align=right nowrap rowspan=2><font color="#003399"><%=grandTotal%></font></td>
        <%}else{
        %><td align=right nowrap rowspan=2><font color="#003399"><%=grandTotal%>(D)</font></td>
        <%}%>
    </tr>
    <tr>
        <td colspan=2 align=center></td>
        <td colspan=2 align=center></td>
    <td align=right><font size=1>Wides:</b><font color="#003399"><%=wide%></font></td>
        <td></td>
    </tr>
    <tr>
        <td colspan=5 nowrap>&nbsp;</td> 
    </tr>
    <tr>
        <td colspan=5 ><font size=1>Total time for 2nd innings:</font></b>
            <font color="#003399"><%=inningTime%>
            </font><font size=1>mins</font></b> ;
        <font size=1>Overs </font></b><font color="#003399"><%=matchTotalOver%></font></td>
    <td colspan=4 nowrap align=right><font size=1>Wickets Lost</b></td>
        <td nowrap align=right><font color="#003399"><%=matchTotalWkt%></font></td>
    </tr>
    <tr>
        <td colspan=5 nowrap ><font size=1>2nd New ball claimed at Overs:</font></b>
            <font color="#003399"><%=secondNewBallOver%></font>
            <font size=1>Score</font></b>
        <font color="#003399"><%=secondNewBallScore%></font></td>
    <td colspan=4 nowrap align=right ><font size=1>Overs Short</b></td>
        <td  nowrap><font color="#003399"><%=shortOvers%></font></td>
    </tr>
    <tr>
        <td colspan=5 ><font size=1>3rd New ball claimed at Overs:</font></b>
            <font color="#003399">
            <%=thirdNewBallOver%></font> <font size=1>Score</font></b>
        <font color="#003399"><%=thirdNewBallScore%></font></td>
        <td colspan=4 nowrap align=center font size=1 ></td>
    </tr>
    </table>
    <table width=100% border=1>	
    <tr>
        <td colspan=13 nowrap ><font size=1>2nd New ball Batsman:</font>
            <font color="#003399" size=1><%=secondNewBallBats%> </font> 
            <font size=1>Bowler:</font></b> ; <font color="#003399" size=1><%=secondNewBallBowl%></font>
            <font size=1>3rd New ball Batsman:</font></b>
            <font color="#003399" size=1><%=thirdNewBallBats%> </font>
        <font size=1>Bowlers:</font></b><font color="#003399" size=1><%=thirdNewBallBowl%></font></td>
    </tr>
    <tr>
        <td colspan=13>
        <table width=100%> 
            <tr>
        <td><font size=1>Penalty Reason</b></td>
        </tr>
        <%
            vparam.add(inningIdTwo);
            penaltyReasonCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_penaltyreason", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (penaltyReasonCrs != null) {
                    while (penaltyReasonCrs.next()) {
                        penaltyDescription = penaltyReasonCrs.getString("description") != null ? penaltyReasonCrs.getString("description") : "";
        %>							
        <tr>
            <td nowrap><font color="#003399" size=1><%=penaltyDescription%></font></td>
        </tr>
        <%
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
        %>
    </table>
</td>
</tr>
</table>

<table width="100%"  height="100%"  border="1" style="border-collapse:collapse">
    <td>
        <table width="100%"  height="20%" border="1" style="border-collapse:collapse">
            <tr class=firstrow>
                <td colspan="12" align=center><font size=1><b>FALL OF WICKETS</b></td>
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
            firstInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch", vparam, "ScoreDB");
            fallOfWicketInningOne = firstInningFirstBatsFallWicketCrs;
            crsSize = firstInningFirstBatsFallWicketCrs.size();
            rowGrowLength = 10 - crsSize;
            vparam.removeAllElements();
            try {
                if (firstInningFirstBatsFallWicketCrs != null) {
                    while (firstInningFirstBatsFallWicketCrs.next()) {
                        wktRun = firstInningFirstBatsFallWicketCrs.getString("runs") != null ? firstInningFirstBatsFallWicketCrs.getString("runs") : "";
                %>
                <td align=right><font color="#003399"  size=1><%=wktRun%></td>
                <%
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }


                %>
                <%
            for (k = 0; k < rowGrowLength; k++) {
                %>
                <td></td>
                <%            }
                %>
            </tr>
            <tr>
                <td align=center align=center><font size=1>Overs</td>
                <%  //vparam.add(inningIdOne);
            //firstInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
            //vparam.removeAllElements();
            crsSize = firstInningFirstBatsFallWicketCrs.size();
            rowGrowLength = 10 - crsSize;
            fallOfWicketInningOne.beforeFirst();
            if (fallOfWicketInningOne != null) {
                try {
                    while (fallOfWicketInningOne.next()) {
                        wktOvers = fallOfWicketInningOne.getString("overs") != null ? fallOfWicketInningOne.getString("overs") : "";
                        if (!wktOvers.equals("")) {
                            String[] splitOver = null;
                            String overNo = "";
                            String overBalls = "";
                            int pos = 0;
                            pos = wktOvers.indexOf(".");
                            if (pos != -1) {
                                splitOver = wktOvers.split("\\.");
                                overNo = splitOver[0];
                                overBalls = splitOver[1];
                                // commented for ball fraction.
                                /*if (overBalls.equalsIgnoreCase("6")) {
                                    int totOvers = 0;
                                    totOvers = Integer.parseInt(overNo) + 1;
                                    wktOvers = java.lang.String.valueOf(totOvers);
                                }*/
                            }
                        }

                %>
                <td align=right><font color="#003399" size=1><%=wktOvers%></td>
                <%
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }
            }
                %>
                <%
            for (k = 0; k < rowGrowLength; k++) {
                %>
                <td></td>
                <%            }
                %>
                
        
            </tr>
            <tr>
                <td align=center align=center><font size=1>Batsman Out</td>
                
                <%  // vparam.add(inningIdOne);
            // firstInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
            // vparam.removeAllElements();
            crsSize = firstInningFirstBatsFallWicketCrs.size();
            rowGrowLength = 10 - crsSize;
            fallOfWicketInningOne.beforeFirst();
            if (fallOfWicketInningOne != null) {
                try {

                    while (fallOfWicketInningOne.next()) {
                        wktBatsOut = fallOfWicketInningOne.getString("striker") != null ? fallOfWicketInningOne.getString("striker") : "";
                        if (fallWktMap.containsKey(wktBatsOut)) {
                            wktOvers = fallWktMap.get(wktBatsOut).toString();

                        }
                %>
                <td align=right><font color="#003399" size=1><%=wktOvers%></td>
                <%			}
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }
            }

                %>
                <%
            for (k = 0; k < rowGrowLength; k++) {
                %>
                <td></td>
                <%            }
                %>
            </tr>
            <tr>
                <td align=center align=center><font size=1>No. of Batsman/Score</td>
                
                <%  // vparam.add(inningIdOne);
            // firstInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
            // vparam.removeAllElements();
            crsSize = firstInningFirstBatsFallWicketCrs.size();
            rowGrowLength = 10 - crsSize;
            fallOfWicketInningOne.beforeFirst();
            if (fallOfWicketInningOne != null) {
                try {
                    while (fallOfWicketInningOne.next()) {
                        wktNoBats = fallOfWicketInningOne.getString("nonstriker") != null ? fallOfWicketInningOne.getString("nonstriker") : "";
                        nonstkrun = fallOfWicketInningOne.getString("nonstkrun") != null ? fallOfWicketInningOne.getString("nonstkrun") : "";
                        if (fallWktMap.containsKey(wktNoBats)) {
                            wktOvers = fallWktMap.get(wktNoBats).toString();

                        }

                %>
                <td align=right><font color="#003399" size=1><%=wktOvers%>/<%=nonstkrun%></td>
                <%
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }
            }
                %>
                <%
            for (k = 0; k < rowGrowLength; k++) {
                %>
                <td></td>
                <%            }
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
            firstInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_partnershipdtls_withtime", vparam, "ScoreDB");
            vparam.removeAllElements();
            crsSize = firstInningFirstBatsFallWicketCrs.size();
            rowGrowLength = 10 - crsSize;
            fallOfWicketInningOne.beforeFirst();
            if (firstInningFirstBatsFallWicketCrs != null) {
                try {
                    while (firstInningFirstBatsFallWicketCrs.next()) {
                        wktPartMin = firstInningFirstBatsFallWicketCrs.getString("mins") != null ? firstInningFirstBatsFallWicketCrs.getString("mins") : "";
                        wktPartBall = firstInningFirstBatsFallWicketCrs.getString("balls") != null ? firstInningFirstBatsFallWicketCrs.getString("balls") : "";
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
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());

                }
            }
                %>
            </tr>
            <tr>
                <td rowspan="5" align=center><font size=1>2 <br>nd<br>I<br>n<br>n<br>i<br>n<br>g<br>s</td>
                <td align=center align=center><font size=1>Runs</td>
                
                <%  vparam.add(inningIdTwo);
            secondInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch", vparam, "ScoreDB");
            fallOfWicketInningTwo = secondInningFirstBatsFallWicketCrs;
            vparam.removeAllElements();
            crsSize = 0;
            crsSize = secondInningFirstBatsFallWicketCrs.size();
            rowGrowLength = 10 - crsSize;
            if (secondInningFirstBatsFallWicketCrs != null) {
                try {
                    while (secondInningFirstBatsFallWicketCrs.next()) {
                        wktRun = secondInningFirstBatsFallWicketCrs.getString("runs") != null ? secondInningFirstBatsFallWicketCrs.getString("runs") : "";
                %>
                <td align=right><font color="#003399" size=1><%=wktRun%></td>
                <%
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }
            }
                %>
                <%
            for (k = 0; k < rowGrowLength; k++) {
                %>
                <td></td>
                <%            }
                %>
            </tr>
            <tr>
                
                <td align=center align=center><font size=1>Overs</td>
                <%  // vparam.add(inningIdTwo);
            // secondInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
            // vparam.removeAllElements();
            crsSize = secondInningFirstBatsFallWicketCrs.size();
            rowGrowLength = 10 - crsSize;
            fallOfWicketInningTwo.beforeFirst();
            if (fallOfWicketInningTwo != null) {
                try {
                    while (fallOfWicketInningTwo.next()) {
                        wktOvers = fallOfWicketInningTwo.getString("overs") != null ? fallOfWicketInningTwo.getString("overs") : "";
                        if (!wktOvers.equals("")) {
                            String[] splitOver = null;
                            String overNo = "";
                            String overBalls = "";
                            int pos = 0;
                            pos = wktOvers.indexOf(".");
                            if (pos != -1) {
                                splitOver = wktOvers.split("\\.");
                                overNo = splitOver[0];
                                overBalls = splitOver[1];
                                /*if (overBalls.equalsIgnoreCase("6")) {
                                    int totOvers = 0;
                                    totOvers = Integer.parseInt(overNo) + 1;
                                    wktOvers = java.lang.String.valueOf(totOvers);
                                }*/
                            }
                        }
                %>
                <td align=right><font color="#003399" size=1><%=wktOvers%></td>
                <%
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }
            }
                %>
                <%
            for (k = 0; k < rowGrowLength; k++) {
                %>
                <td></td>
                <%            }
                %>
                
            </tr>
            <tr>
                <td align=center align=center><font size=1>Batsman Out</td>
                
                <%  // vparam.add(inningIdTwo);
            // secondInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
            // vparam.removeAllElements();
            crsSize = secondInningFirstBatsFallWicketCrs.size();
            rowGrowLength = 10 - crsSize;
            fallOfWicketInningTwo.beforeFirst();
            if (fallOfWicketInningTwo != null) {
                try {
                    while (fallOfWicketInningTwo.next()) {
                        wktBatsOut = fallOfWicketInningTwo.getString("striker") != null ? fallOfWicketInningTwo.getString("striker") : "";

                        if (matchSummeryMap.containsKey(wktBatsOut)) {
                            wktOvers = matchSummeryMap.get(wktBatsOut).toString();

                        }
                %>
                <td align=right><font color="#003399" font size=1><%=wktOvers%></td>
                <%
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }
            }
                %>
                <%
            for (k = 0; k < rowGrowLength; k++) {
                %>
                <td></td>
                <%            }
                %>
                
            </tr>
            
            <tr>
                <td align=center align=center><font size=1>No. of Batsman/Score</td>
                
                <%  // vparam.add(inningIdTwo);
            // secondInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket_testmatch",vparam,"ScoreDB");
            // vparam.removeAllElements();
            crsSize = secondInningFirstBatsFallWicketCrs.size();
            rowGrowLength = 10 - crsSize;
            fallOfWicketInningTwo.beforeFirst();
            if (fallOfWicketInningTwo != null) {
                try {
                    while (fallOfWicketInningTwo.next()) {
                        wktNoBats = fallOfWicketInningTwo.getString("nonstriker") != null ? fallOfWicketInningTwo.getString("nonstriker") : "";
                        nonstkrun = fallOfWicketInningTwo.getString("nonstkrun") != null ? fallOfWicketInningTwo.getString("nonstkrun") : "";
                        if (matchSummeryMap.containsKey(wktNoBats)) {
                            wktOvers = matchSummeryMap.get(wktNoBats).toString();
                        }
                %>
                <td align=right><font color="#003399"  size=1><%=wktOvers%>/<%=nonstkrun%></td>
                <%
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }
            }
                %>
                <%
            for (k = 0; k < rowGrowLength; k++) {
                %>
                <td></td>
                <%            }
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
                
                <%   vparam.add(inningIdTwo);
            secondInningFirstBatsFallWicketCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_partnershipdtls_withtime", vparam, "ScoreDB");
            vparam.removeAllElements();
            crsSize = secondInningFirstBatsFallWicketCrs.size();
            rowGrowLength = 10 - crsSize;
            if (secondInningFirstBatsFallWicketCrs != null) {
                try {
                    while (secondInningFirstBatsFallWicketCrs.next()) {
                        wktPartMin = secondInningFirstBatsFallWicketCrs.getString("mins") != null ? secondInningFirstBatsFallWicketCrs.getString("mins") : "";
                        wktPartBall = secondInningFirstBatsFallWicketCrs.getString("balls") != null ? secondInningFirstBatsFallWicketCrs.getString("balls") : "";
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
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }
            }
                %>
            </tr>
        </table>
    </td>
    <td>
        <table>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
    </td>
    <td>
        <table width="100%" height="100%"  border="1" style=border-collapse:collapse>
            <tr class=firstrow>
                <td colspan="5" align=center ><FONT SIZE=1><b>Team's Score Details</b></td>
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
            firstBatsInningFirstCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamscoredetailsfortestmatch", vparam, "ScoreDB");
            int runSize = 0;
            crsSize = firstBatsInningFirstCrs.size();
            rowGrowLength = 12 - crsSize;
            vparam.removeAllElements();
            try {
                if (firstBatsInningFirstCrs != null) {
                    while (firstBatsInningFirstCrs.next()) {
                        firstInningScoreRunrange = firstBatsInningFirstCrs.getString("run") != null ? firstBatsInningFirstCrs.getString("run") : "";
                        firstInningScoreMins = firstBatsInningFirstCrs.getString("minutes") != null ? firstBatsInningFirstCrs.getString("minutes") : "";
                        firstTeamScoreOver = firstBatsInningFirstCrs.getString("overs") != null ? firstBatsInningFirstCrs.getString("overs") : "";
                        if (!firstTeamScoreOver.equals("")) {
                            String[] splitOver = null;
                            String overNo = "";
                            String overBalls = "";
                            int pos = 0;
                            pos = firstTeamScoreOver.indexOf(".");
                            if (pos != -1) {
                                splitOver = firstTeamScoreOver.split("\\.");
                                overNo = splitOver[0];
                                overBalls = splitOver[1];
                                /*if (overBalls.equalsIgnoreCase("6")) {
                                    int totOvers = 0;
                                    totOvers = Integer.parseInt(overNo) + 1;
                                    firstTeamScoreOver = java.lang.String.valueOf(totOvers);
                                }*/
                            }
                        }
                        secondInningScoreMins = firstBatsInningFirstCrs.getString("minutes_1") != null ? firstBatsInningFirstCrs.getString("minutes_1") : "";
                        secondTeamScoreOver = firstBatsInningFirstCrs.getString("overs_1") != null ? firstBatsInningFirstCrs.getString("overs_1") : "";
                        if (!secondTeamScoreOver.equals("")) {
                            String[] splitOver = null;
                            String overNo = "";
                            String overBalls = "";
                            int pos = 0;
                            pos = secondTeamScoreOver.indexOf(".");
                            if (pos != -1) {
                                splitOver = secondTeamScoreOver.split("\\.");
                                overNo = splitOver[0];
                                overBalls = splitOver[1];
                                /*if (overBalls.equalsIgnoreCase("6")) {
                                    int totOvers = 0;
                                    totOvers = Integer.parseInt(overNo) + 1;
                                    secondTeamScoreOver = java.lang.String.valueOf(totOvers);
                                }*/
                            }

                        }
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
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            } finally {
                timeIn = null;
                timeOut = null;
                srNo = null;
                batsman = null;
                howOut = null;
                fielder = null;
                bowler = null;
                mins = null;
                four = null;
                six = null;
                balls = null;
                runs = null;
                firstBatsInningFirstCrs = null;
                firstInningScoreRunrange = null;
                firstInningScoreMins = null;
                firstTeamScoreOver = null;
                secondInningScoreMins = null;
                secondTeamScoreOver = null;
                wktPartMin = null;
                wktPartBall = null;
                wktNoBats = null;
                nonstkrun = null;
                wktOvers = null;
                secondNewBallOver = null;
                secondNewBallScore = null;
                secondNewBallBats = null;
                secondNewBallBowl = null;
                thirdNewBallOver = null;
                thirdNewBallScore = null;
                thirdNewBallBats = null;
                thirdNewBallBowl = null;
                secondInningByes = null;
                secondInningLegByes = null;
                secondInningPenaltyExtras = null;
                secondInningMatchTotalWkt = null;
                reservePlayer = null;
                twelveman = null;
                reservePlayerOne = null;
                reservePlayerTwo = null;
                reservePlayerThree = null;
                bowlerName = null;
                bowlerId = null;
                bowlerOver = null;
                bowlerMaiden = null;
                bowlerRunrate = null;
                bowlerWicket = null;
                bowlerNB = null;
                bowlerWB = null;
                secondBowlerOver = null;
                secondBowlerMaiden = null;
                secondBowlerRunrate = null;
                secondBowlerWicket = null;
                secondBowlerNB = null;
                secondBowlerWB = null;
                penaltyReasonCrs = null;
                byes = null;
                legByes = null;
                noBall = null;
                wide = null;
                battingSubTotal = null;
                totalExtras = null;
                penaltyExtras = null;
                matchTotalRun = null;
                matchTotalWkt = null;
                matchTotalOver = null;
                inningTime = null;
            }
            %>
            <%
            for (k = 0; k < rowGrowLength; k++) {
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
</td>
</table>	
</tr>
</table>
<%-- Main <Table> and <DIV> for batting  first ends here--%>
<%
            long timeAfter = System.currentTimeMillis();
            long startTime = (Long) session.getAttribute("starttime");
            long elapsed = timeAfter - startTime;
%>
