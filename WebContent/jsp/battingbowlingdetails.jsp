<%--
  Created by IntelliJ IDEA.
  User: bhushanf
  Date: Aug 13, 2008
  Time: 12:01:56 PM
  To change this template use File | Settings | File Templates.
  modifyed Date:12-09-2008
--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,
                 in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
                 java.util.*,
                 java.lang.*"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>                 
                 
<% response.setHeader("Pragma", "private");
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "must-revalidate");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setDateHeader("Expires", 0);
%>
<%
        LogWriter log = new LogWriter();
	   	String	matchId = request.getParameter("matchId");
		String inningId = request.getParameter("InningId");
		String printFlg = request.getParameter("printFlg");
		String id = "";
		String battingteam ="";
		int totalovers = 0;
		String lastWktTotal = "";
		String remainingOver = "";
		String strikerId ="";
		int strikerrownumber =1;
		int nonstrikerrownumber = 1;
		String nonStrikerId = "";
		String bowlerStrikerId="";
		int bowlerrownumber = 1;
		String previousStrikerbowler = "";
		boolean scorecardflag = false;
		String temp="";
	
		int lastwkt = 0;
		int team1run = 0;
		int team2run = 0;
		int remainingrun = 0;
		int rowlength = 0;
		String[] preInningId = null;
		String inning_Id = "";
		String flag ="1";
        String runs = "";
        String Srno = "";
        String result = "";
		String bye="";
		String legbye="";
		String noball ="";
		String wide ="";
		String penlaty ="";
		String extratotal ="";
		String match_type = "";
		String teamName ="";
		String intervalid = "";
		String intervalname ="";
		String intervalcount = "0";
		String firstBattingName = "";
		String secondBattingName = "";
		String reqrunflag = "false";
		String battingteamname = "";
		String bowlingteamname ="";
		String authentic="";
		String starttime ="";
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
		String overrate="";
		String scorerCardTotal = "";
		String wkts = "";
		String currentover = "";
		int totalInningMint = 0;
		int intervalleng = 0;
		String intervalidarr[]=null;
		String intervalnamearr[]=null;
		CachedRowSet lobjCachedRowSet = null;
        CachedRowSet bowlerCachedRowSet = null;
       	CachedRowSet crs = null;
        CachedRowSet battingSummaryCachedRowSet = null;
        CachedRowSet battingscorercardCachedRowSet = null;
        CachedRowSet bowlerscoreeCachedRowSet = null;
        CachedRowSet crsInningId = null;
        CachedRowSet extrarunCachedRowSet = null;
    	CachedRowSet matchDetailCachedRowSet = null;
		CachedRowSet prematchtype = null;
		CachedRowSet overrateCachedRowSet = null;
		CachedRowSet strikernonstrikerCachedRowSet = null;
		 GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
        Vector vparam = new Vector();
    try {
        String total = (request.getParameter("Total") == null) ? "" : request.getParameter("Total");// These For 2nd Inning Only
       
        /*this logic for get batting table*/
      	try{
      		vparam.add(inningId);
		    battingSummaryCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingscorercard", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();
		} catch (Exception e) {
 		   e.printStackTrace();
		}    
		/*This logic scorer card */
		try{
			vparam.add(inningId);
			vparam.add(matchId); 
		    bowlerscoreeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowlingscorecard", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();		
		}catch (Exception e) {
 		   e.printStackTrace();
		}
		try{
			vparam.add(matchId); // // for match details
	       	vparam.add(inningId);// // for Inning details 05/10/208
	        matchDetailCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchtypedetail", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
	        while(matchDetailCachedRowSet.next()){
	        	battingteamname = matchDetailCachedRowSet.getString("battingteam");
	        	bowlingteamname = matchDetailCachedRowSet.getString("bowlingteam");
	        }
	    }catch (Exception e) {
		    e.printStackTrace();
 		}
 		try{    
	        vparam.add(inningId);// // for Inning details 05/10/208
	        overrateCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_overrate", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
	       	while(overrateCachedRowSet.next()){
	       		overrate = overrateCachedRowSet.getString("oversRate");
	       	}
		}catch (Exception e) {
		    e.printStackTrace();
		}   
		try{	
	        vparam.add(matchId); // // for match details
	        prematchtype = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getprematchtype", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
	        while(prematchtype.next()){
	        	series = prematchtype.getString("series");
	        	venue = prematchtype.getString("venue");
	        	toss_winner = prematchtype.getString("toss_winner");
	        	hometeam = prematchtype.getString("hometeam")==null?"":prematchtype.getString("hometeam");
	        	umpire1 = prematchtype.getString("umpire1")==null?"":prematchtype.getString("umpire1");
	        	umpire2 = prematchtype.getString("umpire2")==null?"":prematchtype.getString("umpire2");
	        	umpire3 = prematchtype.getString("umpire3")==null?"":prematchtype.getString("umpire3");
	        	score1 = prematchtype.getString("score1")==null?"":prematchtype.getString("score1");
	        	score2 = prematchtype.getString("score2")==null?"":prematchtype.getString("score2");
	        	matchdate = prematchtype.getString("matchdate")==null?"":prematchtype.getString("matchdate");        	
	        	elected = prematchtype.getString("elected")==null?"":prematchtype.getString("elected");
	        }
	    }catch (Exception e) {
 		   e.printStackTrace();
		}
		try{    
	        vparam.add(inningId);
			vparam.add(matchId); 
		    battingscorercardCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scorercard", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();	
			while(battingscorercardCachedRowSet.next()){
				scorerCardTotal = battingscorercardCachedRowSet.getString("total");
				wkts = battingscorercardCachedRowSet.getString("wkts");
				currentover = battingscorercardCachedRowSet.getString("overs");
			}
		}catch (Exception e) {
		    e.printStackTrace();
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
		try{	
			vparam.add(inningId);
			extrarunCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total", vparam, "ScoreDB"); // Batsman List
			vparam.removeAllElements();
			while(extrarunCachedRowSet.next()){
				bye   =  extrarunCachedRowSet.getString("byes")==null?"":extrarunCachedRowSet.getString("byes");
				legbye =  extrarunCachedRowSet.getString("legbyes")==null?"":extrarunCachedRowSet.getString("legbyes");
				noball =  extrarunCachedRowSet.getString("noballs")==null?"":extrarunCachedRowSet.getString("noballs");	
				wide = 	  extrarunCachedRowSet.getString("wides")==null?"":extrarunCachedRowSet.getString("wides");
				penlaty = extrarunCachedRowSet.getString("penalty")==null?"":extrarunCachedRowSet.getString("penalty");	
				extratotal = extrarunCachedRowSet.getString("total_extra")==null?"":extrarunCachedRowSet.getString("total_extra");	
			}
		}catch (Exception e) {
		    e.printStackTrace();
		}	
        if(flag.equalsIgnoreCase("1")){
           vparam.add(inningId);
	       crs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket",vparam,"ScoreDB");
		   vparam.removeAllElements();
           while(crs.next()){
           	Srno = Srno + crs.getString("srno") + "~";
            runs= runs + crs.getString("runs") +"~";
           }
           String SrnoArr[] = Srno.split("~");
           String runsArr[] = runs.split("~");
           for(int i=0;i<SrnoArr.length;i++){
				result = result +  SrnoArr[i]+"-"+runsArr[i] + ",";
		   }
		}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>-::Score Card::-</title>
<link href="../css/csms.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../css/scorermenu.css">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">    
<link rel="stylesheet" type="text/css" href="../css/tabexample.css"> 
<script language="JavaScript" src="../js/tabber.js" type="text/javascript"></script> 
<script>
function srrate(){
	var over = (document.getElementById('Batstotalover').innerHTML).split(".");
// To Split Ball And Overs, TO Store All Over From Over Field
	var totalover = over[0];
    var ball = over[1];
    var totalball = parseInt((totalover * 6)) + parseInt(ball);
    var run = parseInt(document.getElementById('battotalruns').innerHTML);
    var srRate = (run/ totalball)*6;
    document.getElementById('totlarunrate').innerHTML = srRate.toFixed(2);
    if (document.getElementById('totlarunrate').innerHTML == "Infinity" ||isNaN(document.getElementById('totlarunrate').innerHTML)) { // if Strike Rate In Infinity than we set it blank
    	document.getElementById('totlarunrate').innerHTML = "";
    }
}
</script>
</head>

<body bottomMargin="0" leftMargin="0" topMargin="0"  rightMargin="0" >

<form name="main" id="main" method="post" action="" class="print" >
<%--<input type="button" name="btnprint" id="btnprint" value="Print" onclick="window.print();">--%>
<jsp:include page="battingbowling.jsp"></jsp:include>
<script>
	srrate();
</script>
</form>
</body>
<% } catch (Exception e) { 
    e.printStackTrace();
}
%>
</html>
<script>
window.print();
</script>

