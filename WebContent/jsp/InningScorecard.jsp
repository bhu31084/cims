<%--
  User: bhushanf
  Date: Aug 13, 2008
  Time: 12:01:56 PM
  To change this template use File | Settings | File Templates.
  modifyed Date:12-09-2008
--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
		LogWriter log = new LogWriter();
		String matchId = (String) session.getAttribute("matchId1");
		if (matchId.equalsIgnoreCase(null)) {
			matchId = request.getParameter("hdmatchid");
		}
		/* modified date 23-10-2008 ; creatting problem in scorecard
		if (request.getParameter("InningIdPre") != null) {
			session.setAttribute("inning_id", request
					.getParameter("InningIdPre"));
			session.setAttribute("InningId", request
					.getParameter("InningIdPre"));
		}
		*/
		
		String inningId = request.getParameter("InningIdPre") != null ? request
				.getParameter("InningIdPre") : request.getParameter("hdinning_id");
		String id = "";
		String battingteam = "";
		String totalruns = "";
		String totalscoreid1 = "";
		String totalscoreid2 = "";
		String totalscoreid3 = "";
		String totalscoreid4 = "";
		String totalbattingteam1 = "";
		String totalbattingteam2 = "";
		String totalbattingteam3 = "";
		String totalbattingteam4 = "";
		String totalruns1 = "";
		String totalruns2 = "";
		String totalruns3 = "";
		String totalruns4 = "";
		String retireId = "";
		String scoreteam1Inning1 = "";
		String scoreteam1Inning2 = "";
		String scoreteam2Inning1 = "";
		String scoreteam2Inning2 = "";
		String maxInningId ="";

		String scorerCardTotal = "";

		int totalovers = 0;
		String currentover = "";
		String lastWktTotal = "";
		String remainingOver = "";
		String strikerId = "";
		int strikerrownumber = 1;
		int nonstrikerrownumber = 1;
		String nonStrikerId = "";
		String bowlerStrikerId = "";
		int bowlerrownumber = 1;
		String previousStrikerbowler = "";
		String remainingOvrs = "";
		boolean scorecardflag = false;
		String temp = "";

		int lastwkt = 0;
		int team1run = 0;
		int team2run = 0;
		int remainingrun = 0;
		int rowlength = 0;
		String[] preInningId = null;
		String inning_Id = "";
		String flag = "1";
		String runs = "";
		String Srno = "";
		String result = "";
		String bye = "";
		String legbye = "";
		String noball = "";
		String wide = "";
		String penlaty = "";
		String extratotal = "";
		String match_type = "";
		String teamName = "";
		String intervalid = "";
		String intervalname = "";
		String intervalRemark = "";
		String intervalcount = "0";
		String firstBattingName = "";
		String secondBattingName = "";
		String reqrunflag = "false";
		String battingteamname = "";
		String bowlingteamname = "";
		String authentic = "";
		String starttime = "";
		String series = "";
		String venue = "";
		String toss_winner = "";
		String hometeam ="";
		String umpire1 = "";
		String umpire2 ="";
		String umpire3 = "";
		String score1 = "";
		String score2 ="";
		String matchdate = "";
		String elected = "";
		String wkts = "";
		String overrate = "";
		String overs="";
		String tournamentName 			= "";
		String matchNo 					= "";
		String zone						= "";
		String teamOne					= "";
		String teamTwo					= "";
		String toss						= "";
		String ground					= "";
		String city						= "";
		String date						= "";
		String umpireOne				= "";
		String umpireTwo				= "";
		String umpireThree				= "";
		String umpireFour				= "";
		String matchReferee				= "";
		String scorerOne				= "";
		String scorerTwo				= "";
		String captainOne				= "";
		String captainTwo				= "";
		String wicketKeeperOne			= "";
		String wicketKeeperTwo			= "";
		String decision					= "";
		String point					= null;
		String hatTrickBowler			= "";
		String victim					= "";
		String inningIdOne				= "";
		String inningIdTwo				= "";
		String inningIdThree			= "";
		String inningIdFour				= "";	
		String matchWinner				= "";
		String umpireOneAsscn    	    = "";
		String umpireTwoAsscn			= "";
		String umpireThreeAsscn			= "";
		String umpireFourAsscn			= "";
		String teamBattingFirst			= "";
		String matchRefassn				= "";
		String electedto				= "";
		String isPrint					= "";
		String result1					= "";
		String matchStatusFlag			="";
		
		
		int totalInningMint = 0;
		int intervalleng = 0;
		String intervalidarr[] = null;
		String intervalnamearr[] = null;
		int patenershipball = 0;
		int totalball = 0;
		int todaytotalball = 0;
		//String overs = "";
		String ballperover = "";
		String overperbowler = "";
		String powerplay = "";
		//String wkts = "";
		String over ="";
		CachedRowSet lobjCachedRowSet = null;
		CachedRowSet bowlerCachedRowSet = null;
		CachedRowSet crs = null;
		CachedRowSet matchDetailCachedRowSet = null;
		CachedRowSet totalScoreCachedRowSet = null;
		CachedRowSet battingSummaryCachedRowSet = null;
		CachedRowSet battingscorercardCachedRowSet = null;
		CachedRowSet bowlerscoreeCachedRowSet = null;
		CachedRowSet strikernonstrikerCachedRowSet = null;
		CachedRowSet extrarunCachedRowSet = null;
		CachedRowSet pauseInningCachedRowSet = null;
		CachedRowSet intervalCachedRowSet = null;
		CachedRowSet crsInningId = null;
		CachedRowSet teamNameCatachedRowSet = null;
		CachedRowSet officialScoresheetCrs = null;
		CachedRowSet resultCrs = null;

		try {
			String total = (request.getParameter("Total") == null) ? ""
					: request.getParameter("Total");// These For 2nd Inning Only
			GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
			Vector vparam = new Vector();
			session.setAttribute("InningId",inningId);	
			/*this logic for get batting table*/
			vparam.add(inningId);
			battingSummaryCachedRowSet = lobjGenerateProc
					.GenerateStoreProcedure("esp_dsp_battingscorercard",
							vparam, "ScoreDB"); // Batsman List
			vparam.removeAllElements();

			/*This logic scorer card */
			vparam.add(inningId);
			vparam.add(matchId);
			bowlerscoreeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_bowlingscorecard", vparam, "ScoreDB"); // Batsman List
			vparam.removeAllElements();

			/*Interval Popup*/
			vparam.add(inningId);
			intervalCachedRowSet = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_intervalstatus", vparam, "ScoreDB"); // Batsman List
			vparam.removeAllElements();
			while (intervalCachedRowSet.next()) {
				intervalid = intervalCachedRowSet.getString("id");
				intervalname = intervalCachedRowSet.getString("name");
				intervalRemark = intervalCachedRowSet.getString("remark");
				intervalcount = "1";
			}

			/*this logic is use for get striker and non strierk id */

			/*end */
			vparam.add(matchId); // // for match details
			vparam.add(inningId);// // for Inning details 05/10/208
			matchDetailCachedRowSet = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_matchtypedetail", vparam, "ScoreDB"); // penalties Type List
			vparam.removeAllElements();
			while (matchDetailCachedRowSet.next()) {
				overs = matchDetailCachedRowSet.getString("overs_max");
				ballperover = matchDetailCachedRowSet
						.getString("balls_per_over");
				overperbowler = matchDetailCachedRowSet
						.getString("overs_per_bowler");
				powerplay = matchDetailCachedRowSet.getString("powerplay");
				match_type = matchDetailCachedRowSet.getString("match_type");
				battingteamname = matchDetailCachedRowSet
						.getString("battingteam");
				bowlingteamname = matchDetailCachedRowSet
						.getString("bowlingteam");
			}
			try{	
				vparam.add(inningId);
			    strikernonstrikerCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_striker_nonstriker_batsman", vparam, "ScoreDB"); // Batsman List
			    vparam.removeAllElements();			
				while(strikernonstrikerCachedRowSet.next()){
					strikerId = strikernonstrikerCachedRowSet.getString("striker");
					nonStrikerId = strikernonstrikerCachedRowSet.getString("nonstriker");	
				}
			 }catch (Exception e) {
	 		   e.printStackTrace();
			 }
			/*Extra runs sp start*/
			vparam.add(inningId);
			extrarunCachedRowSet = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_battingsummary_total", vparam, "ScoreDB"); // Batsman List
			vparam.removeAllElements();
			while (extrarunCachedRowSet.next()) {
				bye = extrarunCachedRowSet.getString("byes") == null ? ""
						: extrarunCachedRowSet.getString("byes");
				legbye = extrarunCachedRowSet.getString("legbyes") == null ? ""
						: extrarunCachedRowSet.getString("legbyes");
				noball = extrarunCachedRowSet.getString("noballs") == null ? ""
						: extrarunCachedRowSet.getString("noballs");
				wide = extrarunCachedRowSet.getString("wides") == null ? ""
						: extrarunCachedRowSet.getString("wides");
				penlaty = extrarunCachedRowSet.getString("penalty") == null ? ""
						: extrarunCachedRowSet.getString("penalty");
				extratotal = extrarunCachedRowSet.getString("total_extra") == null ? ""
						: extrarunCachedRowSet.getString("total_extra");
			}
			vparam.add(inningId);
			vparam.add(matchId); 
		    battingscorercardCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scorercard", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();	
			while(battingscorercardCachedRowSet.next()){
				scorerCardTotal = battingscorercardCachedRowSet.getString("total");
				wkts = battingscorercardCachedRowSet.getString("wkts");
				currentover = battingscorercardCachedRowSet.getString("overs");
				remainingOvrs		 = battingscorercardCachedRowSet.getString("remaining");
				maxInningId		= battingscorercardCachedRowSet.getString("max_inning_id");
				matchStatusFlag = battingscorercardCachedRowSet.getString("match_status_flag");
			}
			if (flag.equalsIgnoreCase("1")) {
				vparam.add(inningId);
				crs = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_fallwicket", vparam, "ScoreDB");
				vparam.removeAllElements();
				while (crs.next()) {
					Srno = Srno + crs.getString("srno") + "~";
					runs = runs + crs.getString("runs") + "~";
					over = over + crs.getString("overs") +"~";
				}
				String SrnoArr[] = Srno.split("~");
				String runsArr[] = runs.split("~");
				String oversArr[] = over.split("~");
				for(int i=0;i<SrnoArr.length;i++){
					result = result +  SrnoArr[i]+"-"+runsArr[i] +"( "+oversArr[i]+" ovrs ),";
				}
			}

			/*Extra runs sp end*/

			/*vparam.add(matchId); // // for match details
			totalScoreCachedRowSet = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_totalscore", vparam, "ScoreDB"); // penalties Type List
			vparam.removeAllElements();
			if (totalScoreCachedRowSet != null) {
				while (totalScoreCachedRowSet.next()) {
					id = id + totalScoreCachedRowSet.getString("id") + "~";
					battingteam = battingteam
							+ totalScoreCachedRowSet.getString("batting_team")
							+ "~";
					totalruns = totalruns
							+ totalScoreCachedRowSet.getString("runs") + "~";
				}*/
				/*This logic is use for Total score for Both the team*/
				/*String[] idarr = id.split("~");
				String[] battingteamarr = battingteam.split("~");
				String[] totalrunsarr = totalruns.split("~");
				rowlength = idarr.length;// find out how many inning is over
				if (rowlength == 2) {
					scoreteam1Inning1 = totalrunsarr[0];
				} else if (rowlength == 3) {
					scoreteam1Inning1 = totalrunsarr[0];
					scoreteam2Inning1 = totalrunsarr[1];
					if (battingteamarr[1].equals(battingteamarr[2])) {
						scoreteam2Inning2 = totalrunsarr[2];
					} else {
						scoreteam1Inning2 = totalrunsarr[2];
					}
				} else if (rowlength == 4) {
					scoreteam1Inning1 = totalrunsarr[0];
					scoreteam2Inning1 = totalrunsarr[1];
					if (battingteamarr[1].equals(battingteamarr[2])) {
						scoreteam2Inning2 = totalrunsarr[2];
						//scoreteam1Inning2 = totalrunsarr[3];
					} else {
						scoreteam1Inning2 = totalrunsarr[2];
						//scoreteam2Inning2 = totalrunsarr[3];
					}
				}
			}// end of main if
			if (match_type.equalsIgnoreCase("test") && rowlength == 4) {
				team1run = Integer.parseInt(scoreteam1Inning1)
						+ Integer.parseInt(scoreteam1Inning2);
				team2run = Integer.parseInt(scoreteam2Inning1)
						+ Integer.parseInt(scorerCardTotal);
				remainingrun = team1run - team2run;
				reqrunflag = "true";
			} else if (match_type.equalsIgnoreCase("oneday") && rowlength == 2) {
				team1run = Integer.parseInt(scoreteam1Inning1);
				remainingrun = team1run - Integer.parseInt(scorerCardTotal);
				reqrunflag = "true";
			} else if (match_type.equalsIgnoreCase("oneday") && rowlength >= 1) {
				reqrunflag = "true";
			}*/
			vparam.add(matchId);
			teamNameCatachedRowSet = lobjGenerateProc.GenerateStoreProcedure(
					"dsp_teamsname", vparam, "ScoreDB");
			vparam.removeAllElements();
			while (teamNameCatachedRowSet.next()) {
				teamName = teamNameCatachedRowSet.getString("teamsname");
				firstBattingName = teamNameCatachedRowSet
						.getString("team1name");
				secondBattingName = teamNameCatachedRowSet
						.getString("team2name");
			}
			
		 vparam.add(matchId);
		 resultCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_reportresult",vparam,"ScoreDB");
		 vparam.removeAllElements();
		 if(resultCrs!=null && resultCrs.size() > 0){
			 try{
			
				while(resultCrs.next()){ 
				result1 =  resultCrs.getString("result")==null?"-":resultCrs.getString("result");
				}
			 }catch(Exception e){
				 e.printStackTrace();
				log.writeErrLog(page.getClass(),matchId,e.toString());
			 }
		 }	
			
			
			
			
			
		 vparam.add(matchId);
		 officialScoresheetCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialscoresheetfortest",vparam,"ScoreDB");
		 vparam.removeAllElements();
		 if(officialScoresheetCrs!=null){
		 try{
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
				//result1				 = officialScoresheetCrs.getString("result")!=null?officialScoresheetCrs.getString("result"):"";
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
				teamBattingFirst	 = officialScoresheetCrs.getString("battingteam")!=null?officialScoresheetCrs.getString("battingteam"):"";
				point				 = officialScoresheetCrs.getString("point")!=null?officialScoresheetCrs.getString("point"):"-";
			}
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}finally{
			officialScoresheetCrs = null;
		 }
		}
%>

<div style="height:100%;width:100%">
<table cellspacing=0 align=center height=10% width="100%" class="table" border="0" >
<tr >
	<td class="labelname" align=left>TOURNAMENT/VISTING TEAM :
<%--	</td>--%>
<%--	<td class="labelname" align=left>--%>
	<font color="blue" > <%=tournamentName.equalsIgnoreCase("") ? "-" :tournamentName%></td>
	<td class="labelname" align=left nowrap width="1%" colspan="1">MATCH BETWEEN :<font color="blue">&nbsp;<%=teamOne.equalsIgnoreCase("") ? "-" :teamOne%></font> AND <font color="blue"><%=teamTwo.equalsIgnoreCase("") ? "-" :teamTwo%></font></td>
	
</tr>	 
<tr>
	<td class="labelname" align=left nowrap width="1%">PLAYED ON :
		<font color="blue"><%=date.equalsIgnoreCase("") ? "-" :date%>
<%		if(intervalcount.equalsIgnoreCase("1")){
%>			<font color="red">(<%=intervalname%> <%=intervalRemark%> )
<%		} 
%>
	</td>
	<td class="labelname" align=left nowrap width="1%">PLAYED AT GROUND/STADIUM : <font color="blue"><%=ground.equalsIgnoreCase("") ? "-" :ground%></font></td>
</tr>
<tr>
	<td class="labelname" align=left nowrap width="1%">CITY :<font color="blue">&nbsp;<%=city.equalsIgnoreCase("") ? "-" :city%> 
<%--	</td>--%>
<%--	<td class="labelname" align=left nowrap width="1%" >--%>&nbsp;
	TOSS WON BY :<font color="blue">&nbsp;<%=toss.equalsIgnoreCase("") ? "-" :toss%> </font></td>
		<td class="labelname" align=left nowrap width="1%">ELECTED TO :&nbsp;<font color="blue"><%=electedto.equalsIgnoreCase("") ? "-" :electedto%> </td>
</tr>

<tr>
	<td class="labelname"  align=left nowrap width="1%">RESULT : 
<%--	</td>--%>
<%	if( matchStatusFlag.equals("A")){
%>	
<font color="blue"><%=result1.equalsIgnoreCase("") ? "-" :result1%></td>
<%	}else{
%>	

<font color="blue"><%=result1.equalsIgnoreCase("") ? "-" :result1%></td>
<%	}
%>
<%--</tr>--%>
<%--<tr>--%>
<%	if(maxInningId.equals(inningId) && matchStatusFlag.equals("A")){
%>	<td class="labelname" align=left nowrap width="1%" colspan ="2">
[POINT : <font color="blue"><%=point.equalsIgnoreCase("") ? "-" : point%></font>]
<%--</td>--%>
<%--	<td  class="labelname" align=left nowrap width="1%" >--%>
	Remaining Overs : <font color="blue"><%=remainingOvrs%></font>
	</td>
<%  }else{
%>	
<td class="labelname" align=left nowrap width="1%" colspan ="3">
[POINT : <font color="blue"><%=point.equalsIgnoreCase("") ? "-" : point%></font>]
</td>
<%	}
%>
</tr>
<tr>
	<td class="labelname" align=left nowrap width="1%">1.UMPIRE :&nbsp;&nbsp;<font color="blue"><%=umpireOne.equalsIgnoreCase("") ? "-" :umpireOne%></font>
<%--	</td>--%>
<%--	<td class="labelname" align=left nowrap width="1%">--%>
	2.UMPIRE :&nbsp;&nbsp;<font color="blue"><%=umpireTwo.equalsIgnoreCase("") ? "-" :umpireTwo%> </font> </td>
	<td class="labelname" align=left nowrap width="1%">3.UMPIRE :&nbsp;&nbsp;<font color="blue"><%=umpireThree.equalsIgnoreCase("") ? "-" :umpireThree%></td>
<%--		<td class="labelname" align=left nowrap width="1%">2.UMPIRE: Mr/Ms/Mrs :&nbsp;&nbsp;<font color="blue"><%=umpireTwo.equalsIgnoreCase("") ? "-" :umpireTwo%> </font> </td>--%>
<%--	<td class="labelname" align=left nowrap width="1%">CAPTAIN : &nbsp;--%>
<%--	<font color="blue"><%=captainOne.equalsIgnoreCase("") ? "-" :captainOne%> &nbsp;</font>&&nbsp;<font color="blue"><%=captainTwo.equalsIgnoreCase("") ? "-" :captainTwo%></td>--%>
</tr>
<tr>
<%--	<td class="labelname" align=left nowrap width="1%">2.UMPIRE: Mr/Ms/Mrs :&nbsp;&nbsp;<font color="blue"><%=umpireTwo.equalsIgnoreCase("") ? "-" :umpireTwo%> </font> </td>--%>
	<td class="labelname" align=left nowrap width="1%">CAPTAIN :&nbsp;
	<font color="blue"><%=captainOne.equalsIgnoreCase("") ? "-" :captainOne%> &nbsp;</font>&&nbsp;<font color="blue"><%=captainTwo.equalsIgnoreCase("") ? "-" :captainTwo%>
<%--	</td>--%>
<%--	<td class="labelname" align=left nowrap width="1%">--%>
	UMPIRE COACH :&nbsp;&nbsp;<font color="blue"><%=umpireFour.equalsIgnoreCase("") ? "-" :umpireFour%></font></td>
	<td class="labelname" align=left nowrap width="1%">REFEREE :<font color="blue">&nbsp;<%=matchReferee.equalsIgnoreCase("") ? "-" :matchReferee%> </font> </td>
</tr>
<tr>
	<td class="labelname" align=left nowrap width="1%">Scorer1 :<font color="blue">&nbsp;<%=scorerOne.equalsIgnoreCase("") ? "-" :scorerOne%> </font> 
<%--	</td>--%>
<%--	<td class="labelname" align=left nowrap width="1%">--%>
	Scorer2 :&nbsp;&nbsp;<font color="blue"><%=scorerTwo.equalsIgnoreCase("") ? "-" :scorerTwo%> </font> </td>
	<td class="labelname" align=left nowrap width="1%">WICKET KEEPERS : &nbsp;
	<font color="blue"><%=wicketKeeperOne.equalsIgnoreCase("") ? "-" :wicketKeeperOne%> &nbsp;</font>&&nbsp;<font color="blue"><%=wicketKeeperTwo.equalsIgnoreCase("") ? "-" :wicketKeeperTwo%> </font>
	</td>
</tr>
<tr>
	<td>&nbsp;
</tr>
</table>
<table width="100%" height="100%%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="250" valign="top">
				<table width="250" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><!--WAGON WHEEL TABLE STARTS HERE-->
						<table width="250" border="0" cellspacing="0" cellpadding="0"
							background="../images/WagonWheelBG.jpg">
							<tr>
								<td>&nbsp;</td>
								<td width="139" height="237">
								<div id="groundCanvas" style="position:relative;">
									<img src="../images/wagon_wheel.jpg" width="228" height="350" id="wagon" border="0"/> 
									<div id="WagonWheel" style="display:none; position:absolute; top:0; left:0; border:'1'">
										<img id="responseWagon" name="responseWagon" width="228"
										height="348" border="0" align="left" />
										</div>
								</div>
								</td>
								<td> &nbsp;</td>
							</tr>
						</table>
						<!--WAGON WHEEL TABLE ENDS HERE--></td>
					</tr>
					<tr>
						<td><!-- PITCH TABLE STARTS HERE-->
						<table width="250" border="0" cellspacing="0" cellpadding="0"
							background="../images/PitchBG.jpg">
							<tr>
								<td>&nbsp;</td>
								<td width="139" height="237">
								<div id="pitchCanvas" style="position:relative;" ><img src="../images/Pitch.jpg" width="139"
									height="237" border="0" usemap="#pitch" />
								<div id="pitch_report"
									style="display:none; position:absolute; top: 0; left: 0; border:'1'">
								<img id="responsepage" name="responsepage" width="139"
									height="237" border="0" align="left" /></div>
								</div>
								</td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<!--PITCH TABLE ENDS HERE--></td>
					</tr>
					<tr>
						<!--LEGEND TABLE-->
						<td></td>
						<!--LEGEND TABLE END-->
					</tr>
				</table>
				</td>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center"	width="524" height="25"><%=battingteamname%></td>
							</tr>
							<tr>
								<td>
								<table  width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
										<table class="table tableBorder" width="100%" border="0" cellspacing="0" cellpadding="0"
											id="BATT_TABLE" name="BATT_TABLE">
											 <tr>
                            					<td  width="20px" align="center">No</td>
					                            <td  width="45px" align="center">Time</td>
					                            <td  width="245px" align="left">Batsman</td>
					                            <td  width="50px" align="left">H.Out</td>
					                            <td  width="250px" align="left">Bowler</td>
					                            <td  width="50px" align="right">Runs</td>
					                            <td  width="30px" align="right">Balls</td>
					                            <td  width="45px" align="right">Min</td>
					                            <td  width="30px" align="right">4</td>
					                            <td  width="30px" align="right">6</td>
					                            <td  width="70px" align="right">aSR</td>
 						                     </tr>		
<%
			int i = 2;
			int rownum = 1;

			while (battingSummaryCachedRowSet.next()) {
				if (battingSummaryCachedRowSet.getString("batsmanid").equals(
						strikerId)) {
					strikerrownumber = rownum;
				} else if (battingSummaryCachedRowSet.getString("batsmanid")
						.equals(nonStrikerId)) {
					nonstrikerrownumber = rownum;
				}

				if (i % 2 == 0) {
%>
											<tr
												id='<%=battingSummaryCachedRowSet.getString("batsmanid")%>'
												name='<%=battingSummaryCachedRowSet.getString("batsmanid")%>'
												class="contentLight">
												<%
				} else {
%>
											<tr
												id='<%=battingSummaryCachedRowSet.getString("batsmanid")%>'
												name='<%=battingSummaryCachedRowSet.getString("batsmanid")%>'
												class="contentDark">
												<%
				}
				%>
												<td align="right" style="padding-right: 3px;"><%=rownum%></td>
												<%if (battingSummaryCachedRowSet.getString("timein").equals(null)
						|| battingSummaryCachedRowSet.getString("timein")
								.equals(" ")) {
				%>
												<td><%} else {
					%>
												<td align="center" valign="middle" class="lefttd"
													onmouseover="document.getElementById('time_<%=battingSummaryCachedRowSet.getString("batsmanid")%>').style.display = 'block'"
													onmouseout="document.getElementById('time_<%=battingSummaryCachedRowSet.getString("batsmanid")%>').style.display = 'none'">
												<img border="0" width="16px" height="16px"
													src="../images/Clock.jpg"><BR>
												<%
				}
%>
												<div
													style="background:#ADADAD;position:absolute;z-index:2;display:none"
													id='time_<%=battingSummaryCachedRowSet.getString("batsmanid")%>'
													name='time_<%=battingSummaryCachedRowSet.getString("batsmanid")%>'><b>In
												Time:-</b><lable
													id='time<%=battingSummaryCachedRowSet.getString("batsmanid")%>'><%=battingSummaryCachedRowSet.getString("timein")%></lable></div>
												</td>
<%												if(battingSummaryCachedRowSet.getString("batsmanid").equals(strikerId) || battingSummaryCachedRowSet.getString("batsmanid").equals(nonStrikerId)){
						                        if((battingSummaryCachedRowSet.getString("batsmanout").equalsIgnoreCase("Retires") || battingSummaryCachedRowSet.getString("batsmanout").equalsIgnoreCase("Retires"))
							                        		&& battingSummaryCachedRowSet.getString("batsmanoutdiv").equalsIgnoreCase("")){
%>													<td
													id='<%=battingSummaryCachedRowSet.getString("batsman").trim()%>'
													name='<%=battingSummaryCachedRowSet.getString("batsman")%>'
													align="left" class="lefttd" nowrap="nowrap"><a
													href="javascript:changeImageSrc('<%=battingSummaryCachedRowSet.getString("batsmanid")%>','0')"><%=battingSummaryCachedRowSet.getString("batsman")%></a>
													</td>
													<td class="lefttd" align="left" nowrap="nowrap">Not Out</td>
													<td class="lefttd" align="left">&nbsp;</td>
<%													}else{
%>													<td
													id='<%=battingSummaryCachedRowSet.getString("batsman").trim()%>'
													name='<%=battingSummaryCachedRowSet.getString("batsman")%>'
													align="left" class="lefttd" nowrap="nowrap"><a
													href="javascript:changeImageSrc('<%=battingSummaryCachedRowSet.getString("batsmanid")%>','0')"><%=battingSummaryCachedRowSet.getString("batsman")%></a>
												    </td>
							                        <td class="lefttd" align="left" nowrap="nowrap"><%=battingSummaryCachedRowSet.getString("howout")%></td>
							                        <td class="lefttd" align="left"><%=battingSummaryCachedRowSet.getString("batsmanoutdiv")%></td>
<%													}}else{
%>													<td
													id='<%=battingSummaryCachedRowSet.getString("batsman").trim()%>'
													name='<%=battingSummaryCachedRowSet.getString("batsman")%>'
													align="left" class="lefttd" nowrap="nowrap"><a
													href="javascript:changeImageSrc('<%=battingSummaryCachedRowSet.getString("batsmanid")%>','0')"><%=battingSummaryCachedRowSet.getString("batsman")%></a>
													</td>
							                        <td class="lefttd" align="left" nowrap="nowrap"><%=battingSummaryCachedRowSet.getString("howout")%></td>
							                        <td class="lefttd" align="left"><%=battingSummaryCachedRowSet.getString("batsmanoutdiv")%></td>
<%													}
%>
												<td align="right" nowrap="nowrap"><%=battingSummaryCachedRowSet.getString("runs").equals(
								"-1") ? "" : battingSummaryCachedRowSet.getString("runs")%></td>
												<td align="right"><%=battingSummaryCachedRowSet.getString("balls").equals(
								"-1") ? "" : battingSummaryCachedRowSet
						.getString("balls")%></td>
												<td align="right"><%=battingSummaryCachedRowSet.getString("mins").equals(
								"-1") ? "" : battingSummaryCachedRowSet
						.getString("mins")%></td>
												<td align="right"><%=battingSummaryCachedRowSet.getString("fours").equals(
								"-1") ? "" : battingSummaryCachedRowSet
						.getString("fours")%></td>
												<td align="right"><%=battingSummaryCachedRowSet.getString("six").equals(
								"-1") ? "" : battingSummaryCachedRowSet
						.getString("six")%></td>
												<td colspan="1" align="right"><%=battingSummaryCachedRowSet.getString("strike")
								.equals("-1.00") ? "" 
						: battingSummaryCachedRowSet.getString("strike")%></td>
											</tr>
											<input type="hidden" name="hd_match_player_id"
												id="hd_match_player_id" value='1'>
											<input type="hidden" name="hd_team_id" id="hd_team_id"
												value='1'>
											<%
				i = i + 1;
				rownum = rownum + 1; // this is for count rw number	
			}
%>
											<tr>
												<td></td>
												<td></td>
												<td align="right" class="lefttd" nowrap>Extras :</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td colspan="6" align="left">&nbsp;&nbsp; <b><span
													id="Extratotal" name="Extratotal"><%=extratotal%></span></b>&nbsp;&nbsp;(
												<span id="nb" name="nb"><%=noball%></span> nb &nbsp;<span
													id="w" name="w"><%=wide%></span> w &nbsp;<span id="lb"
													name="lb"><%=legbye%></span>&nbsp;lb&nbsp;<span id="b"
													name="b"><%=bye%></span>b &nbsp;)</td>
											</tr>
											<tr>
												<td></td>
												<td></td>
												<td align="right" class="lefttd" nowrap>Penalty :</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td colspan="6" align="left">&nbsp;&nbsp; <span id="open"
													name="open"><%=penlaty%></span></td>
											</tr>
											 <tr>
								                    <td></td>
							    	                <td></td>
							        	            <td align="right" class="lefttd" nowrap>Total :</td>
							            	        <td colspan="2">
							                	  		( <span id="batsmanscorerewkt"><%=wkts%></span> wickets;<span id="Batstotalover"><%=currentover%></span> overs)
							                    	</td>
							                    	<td id="battotalruns" align="center"><%=scorerCardTotal%></td>
							                      	<td colspan="5" align="left">(<span id="totlarunrate"></span> runs per over)</td>
                    						</tr>
											<tr>
											<tr>
                    								<td colspan="11" class="lefttd" align="left">Fall Of Wkt:
							            	        <span id="fallofwicket"><%=result%></span>
							            	        </td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table  width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center" width="524" height="30"><%=bowlingteamname%></td>
							</tr>
							<tr>
								<td>
								<table class="table tableBorder" width="558" border="0" align="center" cellpadding="0"
									cellspacing="0" id="BALL_TABLE">
									<tr>
					                    
						                    <td style="text-align: right;padding-right:5px;width: 5%" >No</td>
						                    <td style="text-align: left;padding-left:5px;width: 30%" >Bowler</td>
						                    <td style="text-align: right;padding-right:5px;width: 7%" >Over</td>
						                    <td style="text-align: right;padding-right:5px;width: 7%">Maiden</td>
						                    <td style="text-align: right;padding-right:5px;width: 7%" >Runs</td>
						                    <td style="text-align: right;padding-right:5px;width: 7%" >Wkt</td>
						                    <td style="text-align: right;padding-right:5px;width: 7%" >Wd</td>
						                    <td style="text-align: right;padding-right:5px;width: 7%" >Nb</td>
						                    <td style="text-align: right;padding-right:5px;width: 11%">SR</td>
						                    <td style="text-align: right;padding-right:5px;width: 11%">Eco</td>
									</tr>
									<%
			int j = 2;
			int bowlerrowleng = bowlerscoreeCachedRowSet.size();
			int remainingrowleng = 12 - bowlerrowleng;
			int bowlerrownum = 1;
			while (bowlerscoreeCachedRowSet.next()) {
				if (bowlerStrikerId.equals(bowlerscoreeCachedRowSet
						.getString("bowler_id"))) {
					bowlerrownumber = bowlerrownum;
				}
				if (j % 2 != 0) {
%>
									<tr id="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>"
										name="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>"
										class="contentLight">
										<%
				} else {
%>
									<tr id="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>"
										name="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>"
										class="contentDark">
										<%
				}
%>
										<td></td>
										<td style="text-align: left;padding-left:5px;" class="lefttd"><a
											href="javascript:changeImageSrc('<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>','1')"><%=bowlerscoreeCachedRowSet.getString("bowler_name")%></a></td>
										<td style="text-align: right;padding-right:5px;"><%=bowlerscoreeCachedRowSet.getString("noofover")%></td>
					                    <td style="text-align: right;padding-right:5px;"><%=bowlerscoreeCachedRowSet.getString("maiden")%></td>
					                    <td style="text-align: right;padding-right:5px;"><%=bowlerscoreeCachedRowSet.getString("runs")%></td>
					                    <td style="text-align: right;padding-right:5px;"><%=bowlerscoreeCachedRowSet.getString("wicket")%></td>
					                    <td style="text-align: right;padding-right:5px;"><%=bowlerscoreeCachedRowSet.getString("wideball")%></td>
					                    <td style="text-align: right;padding-right:5px;"><%=bowlerscoreeCachedRowSet.getString("noball")%></td>
					                    <td style="text-align: right;padding-right:5px;"><%=bowlerscoreeCachedRowSet.getString("sr")%></td>
					                    <td style="text-align: right;padding-right:5px;"><%=bowlerscoreeCachedRowSet.getString("eco")%></td>
									</tr>
									<%
				j = j + 1;
				bowlerrownum = bowlerrownum + 1;
			}
			for (int k = 0; k < remainingrowleng; k++) { // this logic for add row which is not in database
				if (k % 2 != 0) {
%>
									<tr class="contentLight">
										<%
				} else {
%>
									<tr class="contentDark">
										<%
				}
			%>
										<td>&nbsp;</td>
										<td align="left" class="lefttd">&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<%}
		%>

								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>

			</tr>
			<tr>
				<td>&nbsp;<input type="hidden" name="hdinning_id" id="hdinning_id" value="<%=inningId%>"></td> 
			</tr>
		</table>
<script>
	
</script>


<%} catch (Exception e) {
			e.printStackTrace();
			log.writeErrLog(page.getClass(), matchId, e.toString());
		} finally {
			try {

				id = null;
				battingteam = null;
				totalruns = null;
				totalscoreid1 = null;
				totalscoreid2 = null;
				totalscoreid3 = null;
				totalscoreid4 = null;
				totalbattingteam1 = null;
				totalbattingteam2 = null;
				totalbattingteam3 = null;
				totalbattingteam4 = null;
				totalruns1 = null;
				totalruns2 = null;
				totalruns3 = null;
				totalruns4 = null;
				retireId = null;
				scoreteam1Inning1 = null;
				scoreteam1Inning2 = null;
				scoreteam2Inning1 = null;
				scoreteam2Inning2 = null;
				scorerCardTotal = null;

				totalovers = 0;
				currentover = null;
				lastWktTotal = null;
				remainingOver = null;
				strikerId = null;
				strikerrownumber = 0;
				nonstrikerrownumber = 0;
				nonStrikerId = null;
				bowlerStrikerId = null;
				bowlerrownumber = 0;
				previousStrikerbowler = null;
				scorecardflag = false;
				temp = null;

				totalball = 0;
				todaytotalball = 0;

				lastwkt = 0;
				team1run = 0;
				team2run = 0;
				remainingrun = 0;
				rowlength = 0;
				patenershipball = 0;
				bye = null;
				legbye = null;
				noball = null;
				wide = null;
				penlaty = null;
				extratotal = null;
				match_type = null;
				teamName = null;
				intervalid = null;
				intervalname = null;
				intervalcount = null;
				firstBattingName = null;
				secondBattingName = null;
				reqrunflag = null;
				lobjCachedRowSet = null;
				bowlerCachedRowSet = null;

				matchDetailCachedRowSet = null;
				totalScoreCachedRowSet = null;
				battingSummaryCachedRowSet = null;
				battingscorercardCachedRowSet = null;
				bowlerscoreeCachedRowSet = null;
				strikernonstrikerCachedRowSet = null;
				extrarunCachedRowSet = null;
				pauseInningCachedRowSet = null;
				intervalCachedRowSet = null;
				intervalRemark = null;

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
%>

