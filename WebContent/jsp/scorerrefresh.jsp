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
 <%@ page import="in.co.paramatrix.csms.common.Common"%>                   
<% response.setHeader("Pragma", "private");
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "must-revalidate");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setDateHeader("Expires", 0);
%>
<%		Common common = new Common();
        LogWriter log = new LogWriter();
	   	String inningId = (String)session.getAttribute("InningId");
  	    String matchId = (String)session.getAttribute("matchId1");
	    String userid = (String)session.getAttribute("userid");
  	    if (matchId==null){
	   		response.sendRedirect("/cims/jsp/Logout.jsp");
	   		return;
	   	}
  	    String runId=null;
		String runName = null;
		String runs = null;
		String isExtra = null;
		String overs="";
		String ballperover ="";
		String overperbowler ="";
		String powerplay ="";
		String id = "";
		String  retireIdrefresh = "";
		String battingteam ="";
		String totalruns="";	
		String totalscoreid1 ="";
		String totalscoreid2 ="";
		String totalscoreid3 ="";		
		String totalscoreid4 ="";	
		String totalbattingteam1 ="";
		String totalbattingteam2 ="";
		String totalbattingteam3 ="";
		String totalbattingteam4 ="";
		String totalruns1="";
		String totalruns2="";
		String totalruns3="";
		String totalruns4="";
		String retireId = "";
		String scoreteam1Inning1 ="";
		String scoreteam1Inning2 ="";
		String scoreteam2Inning1 ="";
		String scoreteam2Inning2 ="";
		String batsmanA = "";
		String batsmanB = "";
		String batsmanA_name = "";
		String batsmanB_name ="";
		String lastmanbatsmanName = "";
		String scorerCardTotal = "";
		String lastManRun = "";
		String wkts = "";
		int totalovers = 0;
		String currentover = "";
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
		int runtype =0;
		int strikerbowlerball = 0;
		int totalball = 0;
		int todaytotalball = 0;
		int matchMinits = 0;
		int maxovers  = 0;
		int lastwkt = 0;
		int team1run = 0;
		int team2run = 0;
		int remainingrun = 0;
		int rowlength = 0;
		String[] preInningId = null;
		String inning_Id = "";
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
		String inningflag ="0";
		String totalreviserunsflag = "";
		String totalreviseruns ="";
		String outscorercardRow = "";
		String overrate = "0";
		String IntervalId = "";
        String IntervalName = "";
        String Team1totalscore1 = "0";
        String Team1tota1score2 = "0";
        String Team2totalscore1 = "0";
        String Team2totalscore2 = "0";
        String IsSuperover = "N";
        String allball = "";
		int inningNo = 0;
		int totalInningMint = 0;
		int intervalleng = 0;
		String batterCount = null;//dipti 27 05 2009
		String intervalidarr[]=null;
		String intervalnamearr[]=null;
		int patenershipball = 0;
        CachedRowSet lobjCachedRowSet = null;
        CachedRowSet bowlerCachedRowSet = null;
        CachedRowSet penaltiesCachedRowSet = null;
        CachedRowSet dismissalTypeCachedRowSet = null;
        CachedRowSet RunTypeCachedRowSet = null;
        CachedRowSet newBatsmanCachedRowSet = null;
        CachedRowSet matchDetailCachedRowSet = null;
        CachedRowSet totalScoreCachedRowSet = null;
        CachedRowSet battingSummaryCachedRowSet = null;
        CachedRowSet battingscorercardCachedRowSet = null;
        CachedRowSet bowlerscoreeCachedRowSet = null;
        CachedRowSet strikernonstrikerCachedRowSet = null;
        CachedRowSet extrarunCachedRowSet = null;
        CachedRowSet pauseInningCachedRowSet = null;
        CachedRowSet intervalCachedRowSet = null;
        CachedRowSet overrateCachedRowSet = null;
        CachedRowSet crsInningId = null;
        boolean flag=false;
        GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
        Vector vparam = new Vector();
    try {
        String total = (request.getParameter("Total") == null) ? "" : request.getParameter("Total");// These For 2nd Inning Only
        
        /*this logic for get batting table*/
      	try{
	      	vparam.add(inningId);
		    battingSummaryCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingscorercard", vparam, "ScoreDB"); // Batsman List
	    	vparam.removeAllElements();
		}catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		/*This logic scorer card */
		try{
			vparam.add(inningId);
			vparam.add(matchId); 
		    battingscorercardCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scorercard", vparam, "ScoreDB"); // Batsman List
	    	vparam.removeAllElements();	
			while(battingscorercardCachedRowSet.next()){
				batsmanA = battingscorercardCachedRowSet.getString("bastmanA");
				batsmanA_name = battingscorercardCachedRowSet.getString("batsmanA_name");
				batsmanB = battingscorercardCachedRowSet.getString("batsmanB");
				batsmanB_name = battingscorercardCachedRowSet.getString("batsmanB_name");
				scorerCardTotal = battingscorercardCachedRowSet.getString("total");
				totalball = battingscorercardCachedRowSet.getInt("totalball");
				todaytotalball = battingscorercardCachedRowSet.getInt("todaytotalball");
				lastManRun = battingscorercardCachedRowSet.getString("lastmanrun");
				wkts = battingscorercardCachedRowSet.getString("wkts");
				currentover = battingscorercardCachedRowSet.getString("overs");
				lastWktTotal = battingscorercardCachedRowSet.getString("lastwkt");
				remainingOver = battingscorercardCachedRowSet.getString("remaining");
				patenershipball = battingscorercardCachedRowSet.getInt("patenershipball");
				lastmanbatsmanName = battingscorercardCachedRowSet.getString("lastmanbatsmanName");
				allball = battingscorercardCachedRowSet.getString("allball1");
			}
			if(batsmanA_name.equalsIgnoreCase(lastmanbatsmanName)){
				outscorercardRow = "No1";
				retireIdrefresh = "1";
			}else if(batsmanB_name.equalsIgnoreCase(lastmanbatsmanName)){
				outscorercardRow = "No2";
				retireIdrefresh="2";
			}
		}catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		try{	 	
			vparam.add(inningId);
			vparam.add(matchId); 
		    bowlerscoreeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowlingscorecard", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();		
		}catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}    
		/*Interval Popup*/
		try{
			vparam.add(inningId);
		    intervalCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_intervalstatus", vparam, "ScoreDB"); // Batsman List
	    	vparam.removeAllElements();		
			while(intervalCachedRowSet.next()){
				intervalid = intervalCachedRowSet.getString("id");
				intervalname = intervalCachedRowSet.getString("name");
				intervalcount = "1";
			}
		}catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		/*this logic is use for get striker and non strierk id */
		try{
			vparam.add(inningId);
		    strikernonstrikerCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_striker_nonstriker_batsman", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();			
			while(strikernonstrikerCachedRowSet.next()){
				strikerId = strikernonstrikerCachedRowSet.getString("striker");
				nonStrikerId = strikernonstrikerCachedRowSet.getString("nonstriker");	
				bowlerStrikerId = strikernonstrikerCachedRowSet.getString("bowler");	
				runtype = strikernonstrikerCachedRowSet.getInt("runtype");	
				strikerbowlerball = strikernonstrikerCachedRowSet.getInt("ballsbowler");	 
				matchMinits = strikernonstrikerCachedRowSet.getInt("totalminits");
				totalInningMint = strikernonstrikerCachedRowSet.getInt("totalrunsminutes");
				maxovers = strikernonstrikerCachedRowSet.getInt("over_num");
				lastwkt	 = strikernonstrikerCachedRowSet.getInt("lastwkt");	
				previousStrikerbowler = strikernonstrikerCachedRowSet.getString("previous_bowler");	
				authentic = strikernonstrikerCachedRowSet.getString("authentic").trim();
				starttime = strikernonstrikerCachedRowSet.getString("starttime")==null?"":strikernonstrikerCachedRowSet.getString("starttime");	
				batterCount =  strikernonstrikerCachedRowSet.getString("battercount").trim();//dipti 27 05 2009
			}
			if(authentic.equalsIgnoreCase("Y")){
				starttime ="";
			}
			if(runtype >= 0 && runtype <11){
				if( (runtype) % 2 !=0){
					temp = strikerId;
					strikerId = nonStrikerId;
					nonStrikerId = temp;
					// for scorer card
				}else{
				scorecardflag = true;
				}
			}
		}catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}	
		/*end */
		
		/*Extra runs sp start*/
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
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}	 
		/*Extra runs sp end*/
		try{
			vparam.add(inningId);
		    lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenlist", vparam, "ScoreDB"); // Batsman List
		    newBatsmanCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_refreshbatsmenlist", vparam, "ScoreDB"); // Batsman List
			bowlerCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_bowlinglist",vparam,"ScoreDB");
		    vparam.removeAllElements();
		}catch(Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		try{		
        	vparam.add("1"); //default value 1 Flag 1 for Dismisal
        	dismissalTypeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_types", vparam, "ScoreDB"); // Dismisal Type List
        	vparam.removeAllElements();
        }catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		try{	
	        vparam.add("2"); //default value 2 Flag 2 for Dismaisaal list
	        RunTypeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_types", vparam, "ScoreDB"); // Dismisal Type List
	        vparam.removeAllElements();
	        while(RunTypeCachedRowSet.next()){
	        	runId = runId + RunTypeCachedRowSet.getString("id") + "~";
	        	runName = runName + RunTypeCachedRowSet.getString("name") + "~";
	        	runs = runs + RunTypeCachedRowSet.getString("runs") + "~";
	        	powerplay = isExtra + RunTypeCachedRowSet.getString("is_extra") + "~";
	
	        }
	    }catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		try{    
	        vparam.add("3"); //default value 3 Flag 3 for penalties
	        RunTypeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_types", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
        }catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		try{
			vparam.add("4"); // default value 4 Flag 4 for Interval
	        pauseInningCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_types", vparam, "ScoreDB"); // Interval Type List
	        while(pauseInningCachedRowSet.next()){
	        	IntervalId = IntervalId +  pauseInningCachedRowSet.getString("id") + "~";
	        	IntervalName = IntervalName + pauseInningCachedRowSet.getString("name") + "~";
	        }
	        if(IntervalId!="" && IntervalId!=null){
		        intervalidarr = IntervalId.split("~");
	    	    intervalnamearr = IntervalName.split("~");
	    	}  
	    	intervalleng = intervalidarr.length;  
	        vparam.removeAllElements();		
       	}catch (Exception e) {
    		e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
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
		   log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		try{
	        vparam.add(matchId); // // for match details
	       	vparam.add(inningId);// // for Inning details 05/10/208
	        matchDetailCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchtypedetail", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
	        while(matchDetailCachedRowSet.next()){
	        	overs = matchDetailCachedRowSet.getString("overs_max");
	        	ballperover = matchDetailCachedRowSet.getString("balls_per_over");
	        	overperbowler = matchDetailCachedRowSet.getString("overs_per_bowler");
	        	powerplay = matchDetailCachedRowSet.getString("powerplay");
	        	match_type = matchDetailCachedRowSet.getString("match_type");
	        	battingteamname = matchDetailCachedRowSet.getString("battingteam");
	        	bowlingteamname = matchDetailCachedRowSet.getString("bowlingteam");
	        	totalreviserunsflag = matchDetailCachedRowSet.getString("totalrunsflag");
	        	totalreviseruns = matchDetailCachedRowSet.getString("totalruns");
	        	IsSuperover = matchDetailCachedRowSet.getString("is_superover");
	        }
	    }catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		try{    
        	vparam.add(matchId);					
			crsInningId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getInningId",vparam,"ScoreDB");																					
			vparam.removeAllElements();	
			if(crsInningId!=null){
				while(crsInningId.next()){
				inning_Id = inning_Id + crsInningId.getString("id")+ "~";
				preInningId = inning_Id.split("~");
				}
			}
		}catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		
	    vparam.add(matchId); // // for match details
	    totalScoreCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_totalscore", vparam, "ScoreDB"); // penalties Type List
	    vparam.removeAllElements();
	    if(totalScoreCachedRowSet!=null){
			while(totalScoreCachedRowSet.next()){
		    	id = id + totalScoreCachedRowSet.getString("id")+"~"; 
		        battingteam = battingteam + totalScoreCachedRowSet.getString("batting_team")+"~"; 
		        totalruns = totalruns + totalScoreCachedRowSet.getString("runs")+"~";
		        inningNo =  totalScoreCachedRowSet.getInt("inning_no"); 
		     }
	     /*This logic is use for Total score for Both the team*/
         String[] idarr = id.split("~");
         String[] battingteamarr = battingteam.split("~");
         String[] totalrunsarr = totalruns.split("~");
         rowlength = idarr.length;// find out how many inning is over
         if(rowlength==2){ 
		 	scoreteam1Inning1 = totalrunsarr[0];
		 	Team1totalscore1 = totalrunsarr[0];
		 }else if(rowlength==3){
		 	scoreteam1Inning1 = totalrunsarr[0];
		 	Team1totalscore1 = totalrunsarr[0];
		 	scoreteam2Inning1 = totalrunsarr[1];
		 	Team2totalscore1 = scoreteam2Inning1;
		 	if(battingteamarr[1].equals(battingteamarr[2])){
		 		scoreteam2Inning2 = totalrunsarr[2];
		 		Team2totalscore2 ="0";
		 		scoreteam1Inning2="0";
		 		Team1tota1score2="0";
		 	}else{
		 		scoreteam1Inning2 = totalrunsarr[2];
		 		Team2totalscore2 ="0";
		 		scoreteam2Inning2="0";
		 		Team1tota1score2="0";
		 	}	
		 }else if(rowlength==4){
		 	scoreteam1Inning1 = totalrunsarr[0];
		 	Team1totalscore1 = totalrunsarr[0];
		 	scoreteam2Inning1 = totalrunsarr[1];
		 	Team2totalscore1 = totalrunsarr[1];
		 	if(battingteamarr[1].equals(battingteamarr[2])){
		 		scoreteam2Inning2 = totalrunsarr[2];
		 		Team2totalscore2 = totalrunsarr[2];
		 		scoreteam1Inning2=totalrunsarr[3];
		 		Team1tota1score2 ="0";
		 		inningflag = "2"; // this flag indicate 2 and 3 inning play by one team
		 		//scoreteam1Inning2 = totalrunsarr[3];
		 	}else{
		 		scoreteam1Inning2 = totalrunsarr[2];
		 		Team1tota1score2 =totalrunsarr[2];
		 		scoreteam2Inning2=totalrunsarr[3];
		 		Team2totalscore2 = "0";
		 		inningflag = "1";// this flag indicate 2 and 3 inning play by diffrent team
		 		//scoreteam2Inning2 = totalrunsarr[3];
		 	}	
		 }
		}// end of main if
		if(match_type.equalsIgnoreCase("test") && inningNo==4){
			team1run = Integer.parseInt(scoreteam1Inning1) + Integer.parseInt(scoreteam1Inning2);
			team2run = Integer.parseInt(scoreteam2Inning1) + Integer.parseInt(scoreteam2Inning2);
			if(inningflag.equalsIgnoreCase("1")){ 
				remainingrun = team1run - team2run + 1;
			}else{
				remainingrun =  team2run - team1run  + 1;
			}
			reqrunflag = "true";
		}else if(match_type.equalsIgnoreCase("oneday") && inningNo==2){
			if(totalreviserunsflag.equalsIgnoreCase("Y")){
				team1run = Integer.parseInt(totalreviseruns);
			}else{
				team1run = Integer.parseInt(scoreteam1Inning1);
			}	
			remainingrun = team1run - Integer.parseInt(scorerCardTotal) + 1;
			reqrunflag = "true";			
		} else if(match_type.equalsIgnoreCase("oneday") && inningNo==2){
			reqrunflag = "true";			
		} 
		teamName =(String)session.getAttribute("teamName");
		firstBattingName =(String)session.getAttribute("firstBattingName");	
		secondBattingName=(String)session.getAttribute("secondBattingName");


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>-::-<%=teamName%>-::-</title>
<script>

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function extratype(val) {
  document.getElementById("selType").value = val;
}
function hideMenu(){
	hideState('wideplussubmenu');
    hideState('noballbatplusmenu');
    hideState('noballbatplussubmenu');
    hideState('morenoballbatplusmenu');
    hideState('morenoballbatplussubmenu');
    hideState('byesplussubmenu');
    hideState('legbyessubmenu');
    hideState('penaltymenu');
    hideState('Dismissalmenu');
    hideState('morerunsmenu');
    hideState('Intervalmenu');
    hideState('extramenu');
    hideState('extrasubmenu');
    hideState('moresixrunsmenu');	
    hideState('noballbatplussubmenuboudry');	
    
    
}
//-->
</script>
<link href="../css/csms.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../css/scorermenu.css">
<script language="JavaScript" src="../js/menu.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/jsDraw2D.js" 	type="text/javascript"></script>
<script language="JavaScript" src="../js/common.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/graph.js" 	type="text/javascript"></script>
<script language="JavaScript" src="../js/interval.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/batsman.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/bowler.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/scorecard.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/ajax.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/popup.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/penailtyrule.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/menu.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/hashtable.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>

<script language="JavaScript" src="../js/timer.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/fillcmbo.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/addrow.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/datetimepicker.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">    
</head>

<body bottomMargin="0" leftMargin="0" topMargin="0"  rightMargin="0" onLoad="MM_preloadImages('../images/DotBall_H.jpg','../images/OneRun_H.jpg','../images/TwoRuns_H.jpg','../images/ThreeRuns_H.jpg','../images/FourRuns_H.jpg','../images/TopMenuArrowBottom_H.jpg','../images/SixRuns_H.jpg','../images/NoBallBallRun_H.jpg','../images/NoBallBatRun_H.jpg','../images/MoreRuns_H.jpg','../images/Wide_H.jpg','../images/Byes_H.jpg','../images/LegByes_H.jpg','../images/PenaltyRuns_H.jpg','../images/Wicket_H.jpg','../images/Retires_H.jpg','../images/ForceEndOver_H.jpg','../images/PauseInnings_H.jpg','../images/EndInnings_H.jpg','../images/SwitchBatsman_H.jpg','../images/ChangeBowler_H.jpg','../images/OverWicket_H.jpg','../images/NewBall_H.jpg','../images/PowerPlay_H.jpg','../images/Extra_H.jpg','../images/TopMenuArrowCenter_H.jpg');" onkeypress="callFun.mousemove(event);">
<form name="main" id="main" method="post" action="" >
<div id = "pbar" name="pbar" class="divlist">
	<table>
		<br>
		<br>
		<br>
		<tr>
			<td><font color="red"><b>Loading ...! Please Wait.</b></font></td>
		</tr>
	</table>
</div>
<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv" >
</div>
<script>showPopup('BackgroundDiv','pbar')</script>
<div style="height:100%;width:100%">
<table width="100%" height="100%%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#bbbbbb">
<tr>
    <td height="45">
    <!-- Top Menu Buttons Start here -->
    <table width="100%" height="45" border="0" cellspacing="0" cellpadding="0" background="../images/TopMenuBG.jpg">
	<tr>
		<td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
            <td>&nbsp;<input type="hidden" name="selType" id="selType" value=""></td>
            <td width="25" height="32">&nbsp;</td>
            <td width="10">&nbsp;</td>
            <td width="25" height="32">
<a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Dot Ball','','../images/DotBall_H.jpg',1);hideMenu()" href="javascript:callFun.callFunction('ball','0')"><img src="../images/DotBall.jpg" title="Dot Ball" alt="Dot Ball" name="Dot Ball" width="25" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td width="25" height="32">
<a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('One Run','','../images/OneRun_H.jpg',1);hideMenu()" href="javascript:callFun.callFunction('ball','1')"><img src="../images/OneRun.jpg" title="One Run" alt="One Run" name="One Run" width="25" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Two Runs','','../images/TwoRuns_H.jpg',1);hideMenu()" href="javascript:callFun.callFunction('ball','2')"><img src="../images/TwoRuns.jpg" title="Two Run" alt="Two Runs" name="Two Runs" width="25" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Three Runs','','../images/ThreeRuns_H.jpg',1);hideMenu()" href="javascript:callFun.callFunction('ball','3')"><img src="../images/ThreeRuns.jpg"  title="Three Run" alt="Three Runs" name="Three Runs" width="25" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td width="34" height="32">
<a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Four Runs','','../images/FourRuns_H.jpg',1);hideMenu();showState('morerunsmenu')" href="javascript:callFun.callFunction('ball','4')"><img src="../images/FourRuns.jpg" title="Four Run" alt="Four Runs" name="Four Runs" width="34" height="32" border="0"></a>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <div name="morerunsmenu" id="morerunsmenu" style="display:none">
	                            <a href="javascript:callFun.callFunction('nofour','4')">4</a>
                                <br>   
                                <a href="javascript:callFun.callFunction('ball','5')">5</a>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10">&nbsp;</td>
            <td width="33" height="32">
<a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Six Runs','','../images/SixRuns_H.jpg',1);hideMenu();showState('moresixrunsmenu')" href="javascript:callFun.callFunction('ball','6')"><img src="../images/SixRuns.jpg" title="Six Run" alt="Six Runs" name="Six Runs" width="33" height="32" border="0"></a>
            	<table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <div name="moresixrunsmenu" id="moresixrunsmenu" style="display:none">
                                <a href="javascript:callFun.callFunction('sixruns','6')">6</a>
                                <br>   
                                <a href="javascript:callFun.callFunction('ball','7')">7</a>
								<br>	                            
                                <a href="javascript:callFun.callFunction('ball','8')">8</a>
                                <br>
                                <a href="javascript:callFun.callFunction('ball','9')">9</a>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10">&nbsp;
                <div id="txt" style="display:none"></div>
		        <input type="hidden" name="text" id="text" value="">
                <input type="hidden" id="txtTime" name="txtTime" value="">
                <input type="hidden" name="clock" id="clock" size="4" value="">
            </td>
           <td><img src="../images/TopMenuSeperator.jpg" width="5" height="43"></td>
           <td width="10">&nbsp;</td>
                <td width="32" height="32">
<a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Wide','','../images/Wide_H.jpg',1);hideMenu();showState('wideplussubmenu');callFun.showmenu('wideplussubmenu',event)" href="javascript:callFun.callFunction('wide','0')"><img src="../images/Wide.jpg" title="Wide" alt="Wide" name="Wide" width="32" height="32" border="0"></a>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                        <div name="wideplussubmenu" id="wideplussubmenu" style="display:none">
                           <a href="javascript:callFun.callFunction('wideplusemenu','1')">&nbsp;&nbsp;1&nbsp;&nbsp;</a>
                           <br>
                           <a href="javascript:callFun.callFunction('wideplusemenu','2')">&nbsp;&nbsp;2&nbsp;&nbsp;</a>
                           <br>
                           <a href="javascript:callFun.callFunction('wideplusemenu','3')">&nbsp;&nbsp;3&nbsp;&nbsp;</a>
                           <br>
                           <a href="javascript:callFun.callFunction('wideplusemenu','4')">&nbsp;&nbsp;4&nbsp;&nbsp;</a>
                           <br>
                           <a href="javascript:callFun.callFunction('wideplusemenu','5')">&nbsp;&nbsp;5&nbsp;&nbsp;</a>
                           <br>
                           <a href="javascript:callFun.callFunction('wideplusemenu','6')">&nbsp;&nbsp;6&nbsp;&nbsp;</a>
                           <br>
                           <a href="javascript:callFun.callFunction('wideplusemenu','7')">&nbsp;&nbsp;7&nbsp;&nbsp;</a>
                           <br>
							<a href="javascript:callFun.callFunction('wideplusemenu','8')">&nbsp;&nbsp;8&nbsp;&nbsp;</a>
                        </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10">&nbsp;</td>
            <td width="38" height="32">
<a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('No Ball','','../images/NoBallBallRun_H.jpg',1);hideMenu();showState('morenoballbatplusmenu');callFun.showmenu('morenoballbatplusmenu',event)"  href="javascript:callFun.callFunction('noball','0')"><img src="../images/NoBallBallRun.jpg" title="No Ball" alt="No Ball" name="No Ball" width="38" height="32" border="0"></a></td>
                <div name="morenoballbatplusmenu" id="morenoballbatplusmenu" style="display:none">
                      <a href="javascript:callFun.callFunction('noballbye','0');callFun.showsubmenu('morenoballbatplusmenu','morenoballbatplussubmenu',event)">No Ball + Extra</a>
               </div>
               <div name="morenoballbatplussubmenu" id="morenoballbatplussubmenu" style="display:none">
                      <a href="javascript:callFun.callFunction('noballsubmenu','1')">&nbsp;&nbsp;1&nbsp;&nbsp;</a>
                      <br>
 	                  <a href="javascript:callFun.callFunction('noballsubmenu','2')">&nbsp;&nbsp;2&nbsp;&nbsp;</a>
                      <br>
                      <a href="javascript:callFun.callFunction('noballsubmenu','3')">&nbsp;&nbsp;3&nbsp;&nbsp;</a>
                      <br>
                      <a href="javascript:callFun.callFunction('noballsubmenu','4')">&nbsp;&nbsp;4&nbsp;&nbsp;</a>
 	                  <br>
 	                  <a href="javascript:callFun.callFunction('noballsubmenu','5')">&nbsp;&nbsp;5&nbsp;&nbsp;</a>
                      <br>
                      <a href="javascript:callFun.callFunction('wideplusemenu','6')">&nbsp;&nbsp;6&nbsp;&nbsp;</a>
 					  <br>	
                      <a href="javascript:callFun.callFunction('noballsubmenu','7')">&nbsp;&nbsp;7&nbsp;&nbsp;</a>
 					  <br>		
                      <a href="javascript:callFun.callFunction('noballsubmenu','8')">&nbsp;&nbsp;8&nbsp;&nbsp;</a>
              </div>
            <td width="10">&nbsp;</td>
            <td><img src="../images/TopMenuSeperator.jpg" width="5" height="43"></td>
            <td width="10">&nbsp;</td>
             <td width="50" height="32">
<a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('noballbat','','../images/NoBallBatRun_H.jpg',1);hideMenu();showState('noballbatplusmenu');callFun.showmenu('noballbatplusmenu',event)"><img src="../images/NoBallBatRun.jpg" title="No Ball (Bat Runs)" alt="No Ball (Bat Runs)" name="noballbat" id="noballbat" width="41" height="32" border="0"></a></td>
			     <div name="noballbatplusmenu" id="noballbatplusmenu" style="display:none" >
	                  <a href="javascript:callFun.callFunction('noballrun','0');callFun.showsubmenu('noballbatplusmenu','noballbatplussubmenu',event)" >No Ball + Run</a>
	                  <br>
	                  <a href="javascript:callFun.callFunction('noballboundryrun','0');callFun.showsubmenu('noballbatplusmenu','noballbatplussubmenuboudry',event)">No Ball + Boundry</a>
	             </div>
                 <div name="noballbatplussubmenu" id="noballbatplussubmenu" style="display:none">
                      <a href="javascript:callFun.callFunction('noballsubmenu','1')">&nbsp;&nbsp;1&nbsp;&nbsp;</a>
                      <br>        
                      <a href="javascript:callFun.callFunction('noballsubmenu','2')">&nbsp;&nbsp;2&nbsp;&nbsp;</a>
                      <br>                                     
                      <a href="javascript:callFun.callFunction('noballsubmenu','3')">&nbsp;&nbsp;3&nbsp;&nbsp;</a>
                      <br>          
                      <a href="javascript:callFun.callFunction('noballsubmenunoboundry','4')">4&nbsp;&nbsp;</a>
                      <br>         
                      <a href="javascript:callFun.callFunction('noballsubmenu','5')">&nbsp;&nbsp;5&nbsp;&nbsp;</a>
                      <br>         
					  <a href="javascript:callFun.callFunction('noballbatsubmenunosix','6')">&nbsp;&nbsp;6&nbsp;&nbsp;</a>
                      <br>          
                      <a href="javascript:callFun.callFunction('noballsubmenu','7')">&nbsp;&nbsp;7&nbsp;&nbsp;</a>
                      <br>          
					  <a href="javascript:callFun.callFunction('noballsubmenu','8')">&nbsp;&nbsp;8&nbsp;&nbsp;</a>
                               
                 </div>
                 <div name="noballbatplussubmenuboudry" id="noballbatplussubmenuboudry" style="display:none">
                      <a href="javascript:callFun.callFunction('noballbatsubmenunoboundry','4')">&nbsp;&nbsp;4&nbsp;&nbsp;</a>
                      <br>         
                      <a href="javascript:callFun.callFunction('noballsubmenunosix','6')">&nbsp;&nbsp;6&nbsp;&nbsp;</a>
                 </div>
            <td width="10">&nbsp;</td>
            <td width="40" height="32"><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Byes','','../images/Byes_H.jpg',1);hideMenu();showState('byesplussubmenu');callFun.showmenu('byesplussubmenu',event)"><img src="../images/Byes.jpg" title="Byes" alt="Byes" name="Byes" width="40" height="32" border="0"></a>
               <table border="0" cellpadding="0" cellspacing="0">
               <tr>
               		<td>
	                <div name="byesplussubmenu" id="byesplussubmenu" style="display:none">
	                  <a href="javascript:callFun.callFunction('byessubmenu','1')">&nbsp;&nbsp;1&nbsp;&nbsp;</a>
	                  <br>
	                  <a href="javascript:callFun.callFunction('byessubmenu','2')">&nbsp;&nbsp;2&nbsp;&nbsp;</a>
	                  <br>           
	                  <a href="javascript:callFun.callFunction('byessubmenu','3')">&nbsp;&nbsp;3&nbsp;&nbsp;</a>
	                  <br>        
	                  <a href="javascript:callFun.callFunction('byessubmenu','4')">&nbsp;&nbsp;4&nbsp;&nbsp;</a>
	                  <br>         
	                  <a href="javascript:callFun.callFunction('byessubmenu','5')">&nbsp;&nbsp;5&nbsp;&nbsp;</a>
	                  <br>           
	                  <a href="javascript:callFun.callFunction('byessubmenu','6')">&nbsp;&nbsp;6&nbsp;&nbsp;</a>
					  <br>	
	                  <a href="javascript:callFun.callFunction('byessubmenu','7')">&nbsp;&nbsp;7&nbsp;&nbsp;</a>
					  <br>	
					  <a href="javascript:callFun.callFunction('byessubmenu','8')">&nbsp;&nbsp;8&nbsp;&nbsp;</a>
	               </div>
	               </td>
	           </tr>
	           </table>       
             </td>  
            <td width="10">&nbsp;</td>
            <td width="41" height="32"><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Leg Byes','','../images/LegByes_H.jpg',1);hideMenu();showState('legbyessubmenu');callFun.showmenu('legbyessubmenu',event)"><img src="../images/LegByes.jpg" title="Leg Byes" alt="Leg Byes" name="Leg Byes" width="41" height="32" border="0"></a></td>
               <div name="legbyessubmenu" id="legbyessubmenu" style="display:none">
                 <a href="javascript:callFun.callFunction('legbyessubmenu','1')">&nbsp;&nbsp;1&nbsp;&nbsp;</a>
                 <br>
                 <a href="javascript:callFun.callFunction('legbyessubmenu','2')">&nbsp;&nbsp;2&nbsp;&nbsp;</a>
                 <br>
                 <a href="javascript:callFun.callFunction('legbyessubmenu','3')">&nbsp;&nbsp;3&nbsp;&nbsp;</a>
                 <br>
                 <a href="javascript:callFun.callFunction('legbyessubmenu','4')">&nbsp;&nbsp;4&nbsp;&nbsp;</a>
                 <br>
               	 <a href="javascript:callFun.callFunction('legbyessubmenu','5')">&nbsp;&nbsp;5&nbsp;&nbsp;</a>
               	 <br>
                 <a href="javascript:callFun.callFunction('legbyessubmenu','6')">&nbsp;&nbsp;6&nbsp;&nbsp;</a>
                 <br>
                 <a href="javascript:callFun.callFunction('legbyessubmenu','7')">&nbsp;&nbsp;7&nbsp;&nbsp;</a>
                 <br>
                 <a href="javascript:callFun.callFunction('legbyessubmenu','8')">&nbsp;&nbsp;8&nbsp;&nbsp;</a>
                </div>
                    
                    
            <td width="10">&nbsp;</td>
            <td><img src="../images/TopMenuSeperator.jpg" width="5" height="43"></td>
            <td width="10">&nbsp;</td>
            <td width="40" height="32"><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Penalty Runs','','../images/PenaltyRuns_H.jpg',1);hideMenu();showState('penaltymenu')"><img src="../images/PenaltyRuns.jpg" title="Penalty Runs" alt="Penalty Runs" name="Penalty Runs" width="40" height="32" border="0"></a>
               <table>
                 <tr>
                    <td>
                        <div name="penaltymenu" id="penaltymenu" style="display:none">
                        <ul>
<%                      while(RunTypeCachedRowSet.next()){ // For Panalty Menu
%>                          <li><a href="javascript:callFun.penalty('<%=RunTypeCachedRowSet.getString("id")%>','<%=RunTypeCachedRowSet.getString("penalty_runs")%>','<%=RunTypeCachedRowSet.getString("name")%>','<%=RunTypeCachedRowSet.getString("ball_cnt")%>')"><% out.println(RunTypeCachedRowSet.getString("name"));%></a></li>
<%                      }
%>                      </ul>
                        </div>
                    </td>
                 </tr>
               </table>
            </td>
            <td width="10">&nbsp;</td>
            <td><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Dismissal','','../images/Wicket_H.jpg',1);hideMenu();showState('Dismissalmenu')"><img src="../images/Wicket.jpg"  title="Wicket" alt="Wicket" name="Dismissal" id="Dismissal" width="25" height="32" border="0"></a>
                <table>
                    <tr>
                        <td>
                            <div name="Dismissalmenu" id="Dismissalmenu" style="display:none">
                            <ul>
<%                          while(dismissalTypeCachedRowSet.next()){
							if(dismissalTypeCachedRowSet.getString("description").equalsIgnoreCase("retires")){
								retireId = dismissalTypeCachedRowSet.getString("id");
							}else{	
%>                          <li><a href="javascript:callFun.callDismissal('<%=dismissalTypeCachedRowSet.getString("description").trim()%>','<%=dismissalTypeCachedRowSet.getString("id")%>')">
		                    <%= dismissalTypeCachedRowSet.getString("description").trim()%></a></li>
<%                          }
							}
%>                          </ul>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10">&nbsp;</td>
            <td><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retires','','../images/Retires_H.jpg',1);hideMenu()" href="javascript:callFun.callDismissal('retires','<%=retireId%>')"><img src="../images/Retires.jpg" title="Retires" alt="Retires" name="Retires" width="25" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td width="37" height="32"><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Force End of Over','','../images/ForceEndOver_H.jpg',1);hideMenu()" href="javascript:callFun.callFunction('ForceEndOfOver','0')"><img src="../images/ForceEndOver.jpg" title="Force End of Over" alt="Force End of Over" name="Force End of Over" width="37" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Pause Innings','','../images/PauseInnings_H.jpg',1);hideMenu();showState('Intervalmenu')" href="javascript:callFun.callFunction('pauseinnings','0')"><img src="../images/PauseInnings.jpg" title="Pause Innings" alt="Pause Innings" name="Pause Innings" width="25" height="32" border="0"></a>
            	<table>
                    <tr>
                        <td>
                            <div name="Intervalmenu" id="Intervalmenu" style="display:none">
                            <ul>
<%                          for(int i=0;i<intervalleng;i++){
%>                          <li><a href="javascript:callFun.Interval('<%=intervalnamearr[i]%>','<%=intervalidarr[i]%>')">
		                    <%=intervalnamearr[i]%></a></li>
<%                          }
%>                          </ul>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10">&nbsp;</td>
            <td width="25" height="32"><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('End Innings','','../images/EndInnings_H.jpg',1);hideMenu()" href="javascript:callFun.callFunction('endinnings','0')"><img src="../images/EndInnings.jpg" title="End Innings" alt="End Innings" name="End Innings" width="25" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td width="28" height="32"><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Switch Batsman','','../images/SwitchBatsman_H.jpg',1);hideMenu()" href="javascript:callFun.callFunction('switchbatsman','0')"><img src="../images/SwitchBatsman.jpg" title="Switch Batsman" alt="Switch Batsman" name="Switch Batsman" width="25" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td width="28" height="32"><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Change Bowler','','../images/ChangeBowler_H.jpg',1);hideMenu()" href="javascript:callFun.callFunction('changebowler','0')"><img src="../images/ChangeBowler.jpg" title="Change Bowler" alt="Change Bowler" name="Change Bowler" width="25" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td width="25" height="32"><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('New Ball','','../images/NewBall_H.jpg',1);hideMenu()" href="javascript:callFun.callFunction('newball','0')"><img src="../images/NewBall.jpg" title="New Ball" alt="New Ball" name="New Ball" width="25" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td><img src="../images/TopMenuSeperator.jpg" width="5" height="45"></td>
            <td width="10">&nbsp;</td>
            <td width="25" height="32"><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Power Play','','../images/PowerPlay_H.jpg',1);hideMenu()" href="javascript:callFun.callFunction('powerplay','0')"><img src="../images/PowerPlay.jpg" title="Power Play" alt="Power Play" name="Power Play" width="25" height="32" border="0"></a></td>
            <td width="10">&nbsp;</td>
            <td width="28" height="32"><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Extra','','../images/Extra_H.jpg',1);hideMenu();showState('extramenu');callFun.showextramenu('extramenu',event)"><img src="../images/Extra.jpg" title="Extra" alt="Extra" name="Extra" width="28" height="32" border="0"></a></td>
             <div name="extramenu" id="extramenu" style="display:none">
               <!-- <a href="javascript:callFun.extraFunction('shortrun','0')">short run </a>
                <br>-->
                <a href="javascript:callFun.extraFunction('undo','0')">undo</a>
                <br>
                <a href="javascript:callFun.extraFunction('moreundo','0')">more undo</a>
                <br>
                <a href="javascript:callFun.extraFunction('newbatsman','0')">New Batsman</a>
                <br>
                <a href="javascript:callFun.extraFunction('staticremark','0')">Add Remark</a>
                <br>
                <a href="javascript:callFun.extraFunction('setmaxover','0')">Days minimum Over</a>
                <br>
                <a href="javascript:callFun.extraFunction('online','0')">OnLine</a>
                <br>
                <a href="javascript:callFun.showinningreport('endmatch','<%=matchId%>')">Previous Innings</a>
                <br>
                <a href="javascript:callFun.editinterval()">Edit Interval </a>
                <br>
                <a href="javascript:callFun.extraFunction('setstrikernonstriker','0')">Striker-NonStriker</a>
                <br>
                <a href="javascript:callFun.viewPlayers('<%=matchId%>')">View Player List</a>
                <br>
                <a href="javascript:callFun.endMatch('drwamatch','<%=matchId%>')" style="color: red">End Match</a>
                <br>
                <a href="javascript:callFun.exit()">Exit</a>
             </div>
             <div name="extrasubmenu" id="extrasubmenu" style="display:none">
                <a href="javascript:callFun.extraFunction('extrasubmenu','1')">&nbsp;&nbsp;1&nbsp;&nbsp;</a>
                <br>
                <a href="javascript:callFun.extraFunction('extrasubmenu','2')">&nbsp;&nbsp;2&nbsp;&nbsp;</a>
                <br>
                <a href="javascript:callFun.extraFunction('extrasubmenu','3')">&nbsp;&nbsp;3&nbsp;&nbsp;</a>
                <br>
               	<a href="javascript:callFun.extraFunction'extrasubmenu','4')">&nbsp;&nbsp;4&nbsp;&nbsp;</a>
               	<br>
               	<a href="javascript:callFun.extraFunction('extrasubmenu','5')">&nbsp;&nbsp;5&nbsp;&nbsp;</a>
               	<br>
               	<a href="javascript:callFun.extraFunction('extrasubmenu','6')">&nbsp;&nbsp;6&nbsp;&nbsp;</a>
               	<br>
               	<a href="javascript:callFun.extraFunction('extrasubmenu','7')">&nbsp;&nbsp;7&nbsp;&nbsp;</a>
               	<br>
              	<a href="javascript:callFun.extraFunction('extrasubmenu','8')">&nbsp;&nbsp;8&nbsp;&nbsp;</a>
              	<br>
              </div>
            <td width="20">&nbsp;
                      <input type="hidden" name="runid" id="runid" value="<%=runId%>">
			          <input type="hidden" name="runname" id="runname" value="<%=runName%>">
			          <input type="hidden" name="runs" id="runs" value="<%=runs%>">
			          <input type="hidden" name="isExtra" id="isExtra" value="<%=isExtra%>">
			          <input type="hidden" name="inningId" id="inningId" value="<%=inningId%>">
			          <input type="hidden" name="hdovers" id="hdovers" value="<%=overs%>">
			          <input type="hidden" name="hdballperover" id="hdballperover" value="<%=ballperover%>">
			          <input type="hidden" name="hdoverperbowler" id="hdoverperbowler" value="<%=overperbowler%>">
			          <input type="hidden" name="hdpowerplay" id="hdpowerplay" value="<%=powerplay%>">
			          <input type="hidden" name="hdmatchtype" id="hdmatchtype" value="<%=match_type%>">
			          <input type="hidden" name="hdmatchid" id="hdmatchid" value="<%=matchId%>">
            </td>
        </tr>
		</table>
        </td>
	</tr>
	</table>
    <!--Top menu Buttons End Here -->
    </td>
</tr>
<tr onmouseover="hideMenu()">
	<td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="250" valign="top">
        <table width="250" border="0" cellspacing="0" cellpadding="0">
                <tr>
			<td>
            <!--WAGON WHEEL TABLE STARTS HERE-->
            <table width="250" border="0" cellspacing="0" cellpadding="0"  background="../images/WagonWheelBG.jpg" >
			<tr height="363">
                <td>&nbsp;</td>
                <td width="139" height="363">
                    <div id="groundCanvas" onclick="showLine(event,'show')">
                    <img src="/cims/images/wagon_wheel.jpg" id="wagon_wheel_id" width="228" height="348" border="0" usemap="#wagonwheelmap"/>
                    <map name="wagonwheelmap">
					<area shape="poly" coords="96,225,96,274,128,274,128,225" title="Bowler" alt="Bowler" onclick="callFun.addGround('1');"  />
					<area shape="poly" coords="95,253,93,336,49,321,28,302,66,232,77,246" title="Long Off" alt="Long Off" onclick="callFun.addGround('2');" />
					<area shape="poly" coords="11,207,60,183,62,222,66,234,28,302,14,277,11,252" title="Deep Mid Off" alt="Deep Mid Off" onclick="callFun.addGround('3');" />
					<area shape="poly" coords="59,182,60,132,65,120,14,86,12,101,12,207" title="Deep Cover" alt="Deep Cover" onclick="callFun.addGround('4');" />
					<area shape="poly" coords="167,144,217,144,217,97,213,82,159,114,165,124" title="Deep Square Leg" alt="Deep Square Leg" onclick="callFun.addGround('5');" />
					<area shape="poly" coords="128,260,153,245,166,223,193,253,172,281,127,301" title="Deep Mid On" alt="Deep Mid On" onclick="callFun.addGround('6');" />
					<area shape="poly" coords="166,221,141,176,127,181,128,227,129,258,154,245" title="Mid On" alt="Mid On" onclick="callFun.addGround('7');" />
					<area shape="poly" coords="142,174,126,148,128,180" title="Silly Mid On" alt="Silly Mid On" onclick="callFun.addGround('8');" />
					<area shape="poly" coords="126,148,168,147,167,226" title="Mid Wicket" alt="Mid Wicket" onclick="callFun.addGround('9');" />
					<area shape="poly" coords="217,144,217,262,215,276,167,224,168,143" title="Deep Mid Wicket" alt="Deep Mid Wicket" onclick="callFun.addGround('10');" />
					<area shape="poly" coords="127,133,143,125,146,130,148,147,127,147" title="Short Leg" alt="Short Leg" onclick="callFun.addGround('11');" />
					<area shape="poly" coords="127,97,127,120,127,133,159,113,148,102" title="Leg Slip" alt="Leg Slip" onclick="callFun.addGround('12');" />
					<area shape="poly" coords="60,182,80,169,88,186,97,191,96,221,95,253,78,245,66,230,62,216" title="Mid Off" alt="Mid Off" onclick="callFun.addGround('13');" />
					<area shape="poly" coords="80,171,97,144,97,196,89,189" title="Silly Mid Off"  alt="Silly Mid Off" onclick="callFun.addGround('14');" />
					<area shape="poly" coords="65,123,83,129,82,144,60,148,59,135" title="Point(Square Cover)" alt="Point(Square Cover)" onclick="callFun.addGround('15');" />
					<area shape="poly" coords="82,144,80,156,60,168,60,148" title="Silly Mid Off" alt="Silly Mid Off" onclick="callFun.addGround('16');" />
					<area shape="poly" coords="84,131,97,133,97,146,80,171,80,148" title="Silly Point" alt="Silly Point" onclick="callFun.addGround('17');" />
					<area shape="rect" coords="96,131,128,225" title="Pitch" alt="Pitch" onclick="callFun.addGround('18');" />
					<area shape="poly" coords="95,275,128,275,128,335,93,335" title="Straight Long" alt="Straight Long" onclick="callFun.addGround('19');" />
					<area shape="poly" coords="62,123,74,107,96,99,96,111,86,117,76,128" title="Slips" alt="Slips" onclick="callFun.addGround('20');" />
					<area shape="poly" coords="79,124,87,115,97,112,96,131,84,130,78,128" title="Gully" alt="Gully" onclick="callFun.addGround('21');" />
					<area shape="poly" coords="60,166,59,184,81,168,80,155"  title="Extra Cover" alt="Extra Cover" onclick="callFun.addGround('22');" />
					<area shape="poly" coords="146,134,165,128,167,144,146,146" title="Square Leg" alt="Square Leg" onclick="callFun.addGround('23');" />
					<area shape="poly" coords="143,123,158,114,165,122,167,129,148,133" title="Backward Square" alt="Backward Square" onclick="callFun.addGround('24');" />
					<area shape="poly" coords="217,145,217,95,212,83,227,72,227,147" title="Deep Square Leg Boundry" alt="Deep Square Leg Boundry" onclick="callFun.addGround('25');" />
					<area shape="poly" coords="129,335,93,335,94,347,129,347" title="Straight Boundry" alt="Straight Boundry" onclick="callFun.addGround('26');" />
					<area shape="poly" coords="97,346,96,336,81,333,53,322,31,301,0,348,5,346" title="Long Off Boundry" alt="Long Off Boundry" onclick="callFun.addGround('27');" />
					<area shape="poly" coords="0,347,0,214,11,207,11,269,21,294,29,301" title="Deep Mid Off Boundry" alt="Deep Mid Off Boundry" onclick="callFun.addGround('28');" />
					<area shape="poly" coords="0,213,0,77,14,84,13,99,13,205" title="Deep Cover Boundry" alt="Deep Cover Boundry" onclick="callFun.addGround('29');" />
					<area shape="rect" coords="97,82,127,132" title="Wicket Keeper" alt="Wicket Keeper" onclick="callFun.addGround('30');" />
					<area shape="rect" coords="97,22,127,82" title="Long Stop" alt="Long Stop" onclick="callFun.addGround('31');" />
					<area shape="rect" coords="97,0,128,22" title="Long Stop Boundry" alt="Long Stop Boundry" onclick="callFun.addGround('32');" />
					<area shape="poly" coords="226,72,226,0,128,0,128,21,151,23,175,33,190,47,206,65,214,80" title="Deep Fine Leg Boundry" alt="Deep Fine Leg Boundry" onclick="callFun.addGround('33');" />
					<area shape="poly" coords="128,22,127,97,148,102,154,107,159,114,214,80,208,67,183,40,175,33,148,24" title="Deep fine leg" alt="Deep fine leg" onclick="callFun.addGround('34');" />
					<area shape="poly" coords="14,84,65,121,75,106,89,100,98,98,98,21,80,23,59,32,41,43,23,65" title="Third Man" alt="Third Man" onclick="callFun.addGround('35');" />
					<area shape="poly" coords="0,76,0,0,97,0,97,23,77,23,41,41,17,75,15,86" title="Third man boundry" alt="Third man boundry" onclick="callFun.addGround('36');" />
					<area shape="poly" coords="216,143,226,144,226,287,214,275,216,264" title="Deep Mid Wicket Boundry" alt="Deep Mid Wicket Boundry" onclick="callFun.addGround('37');" />
					<area shape="poly" coords="128,301,128,337,157,332,182,320,200,301,215,275,194,253,173,281" title="Long On" alt="Long On" onclick="callFun.addGround('38');" />
					<area shape="poly" coords="129,346,227,346,227,288,215,275,202,299,181,322,157,332,129,336" title="Long On Boundry" alt="Long On Boundry" onclick="callFun.addGround('39');" />
                    </map>
                    </div>
                </td>
                <td>&nbsp;</td>
			</tr>
			</table>
            <!--WAGON WHEEL TABLE ENDS HERE-->
            </td>
		</tr>
		<tr>
			<td>
            <!-- PITCH TABLE STARTS HERE-->
            <table width="250" border="0" cellspacing="0" cellpadding="0" background="../images/PitchBG.jpg">
			<tr>
				<td>&nbsp;</td>
				<td width="139" height="237">
                   <div id="pitchCanvas" onclick="showCir(event)">
                    <img src="/cims/images/Pitch.jpg"  id="pitch_id" width="139" height="237" border="0" usemap="#pitch" />
                    <map name="pitch" >
                    <area shape="rect" coords="20,37,30,47"  onclick="callFun.addPitch('1');" />
					<area shape="rect" coords="30,37,40,47"  onclick="callFun.addPitch('2');" />
					<area shape="rect" coords="40,37,50,47"  onclick="callFun.addPitch('3');" />
					<area shape="rect" coords="50,37,60,47"  onclick="callFun.addPitch('4');" />
					<area shape="rect" coords="60,37,70,47"  onclick="callFun.addPitch('5');" />
					<area shape="rect" coords="70,37,80,47"  onclick="callFun.addPitch('6');" />
					<area shape="rect" coords="80,37,90,47"  onclick="callFun.addPitch('7');" />
					<area shape="rect" coords="90,37,100,47"  onclick="callFun.addPitch('8');" />
					<area shape="rect" coords="100,37,110,47"  onclick="callFun.addPitch('9');" />
					<area shape="rect" coords="110,37,120,47"  onclick="callFun.addPitch('10');" />
					<area shape="rect" coords="20,47,30,57"  onclick="callFun.addPitch('11');" />
					<area shape="rect" coords="30,47,40,57"  onclick="callFun.addPitch('12');" />
					<area shape="rect" coords="40,47,50,57"  onclick="callFun.addPitch('13');" />
					<area shape="rect" coords="50,47,60,57"  onclick="callFun.addPitch('14');" />
					<area shape="rect" coords="60,47,70,57"  onclick="callFun.addPitch('15');" />
					<area shape="rect" coords="70,47,80,57"  onclick="callFun.addPitch('16');" />
					<area shape="rect" coords="80,47,90,57"  onclick="callFun.addPitch('17');" />
					<area shape="rect" coords="90,47,100,57"  onclick="callFun.addPitch('18');" />
					<area shape="rect" coords="100,47,110,57"  onclick="callFun.addPitch('19');" />
					<area shape="rect" coords="110,47,120,57"  onclick="callFun.addPitch('20');" />
					<area shape="rect" coords="20,57,30,67"  onclick="callFun.addPitch('21');" />
					<area shape="rect" coords="30,57,40,67"  onclick="callFun.addPitch('22');" />
					<area shape="rect" coords="40,57,50,67"  onclick="callFun.addPitch('23');" />
					<area shape="rect" coords="50,57,60,67"  onclick="callFun.addPitch('24');" />
					<area shape="rect" coords="60,57,70,67"  onclick="callFun.addPitch('25');" />
					<area shape="rect" coords="70,57,80,67"  onclick="callFun.addPitch('26');" />
					<area shape="rect" coords="80,57,90,67"  onclick="callFun.addPitch('27');" />
					<area shape="rect" coords="90,57,100,67"  onclick="callFun.addPitch('28');" />
					<area shape="rect" coords="100,57,110,67"  onclick="callFun.addPitch('29');" />
					<area shape="rect" coords="110,57,120,67"  onclick="callFun.addPitch('30');" />
					<area shape="rect" coords="20,67,30,77"  onclick="callFun.addPitch('31');" />
					<area shape="rect" coords="30,67,40,77"  onclick="callFun.addPitch('32');" />
					<area shape="rect" coords="40,67,50,77"  onclick="callFun.addPitch('33');" />
					<area shape="rect" coords="50,67,60,77"  onclick="callFun.addPitch('34');" />
					<area shape="rect" coords="60,67,70,77"  onclick="callFun.addPitch('35');" />
					<area shape="rect" coords="70,67,80,77"  onclick="callFun.addPitch('36');" />
					<area shape="rect" coords="80,67,90,77"  onclick="callFun.addPitch('37');" />
					<area shape="rect" coords="90,67,100,77"  onclick="callFun.addPitch('38');" />
					<area shape="rect" coords="100,67,110,77"  onclick="callFun.addPitch('39');" />
					<area shape="rect" coords="110,67,120,77"  onclick="callFun.addPitch('40');" />
					<area shape="rect" coords="20,77,30,87"  onclick="callFun.addPitch('41');" />
					<area shape="rect" coords="30,77,40,87"  onclick="callFun.addPitch('42');" />
					<area shape="rect" coords="40,77,50,87"  onclick="callFun.addPitch('43');" />
					<area shape="rect" coords="50,77,60,87"  onclick="callFun.addPitch('44');" />
					<area shape="rect" coords="60,77,70,87"  onclick="callFun.addPitch('45');" />
					<area shape="rect" coords="70,77,80,87"  onclick="callFun.addPitch('46');" />
					<area shape="rect" coords="80,77,90,87"  onclick="callFun.addPitch('47');" />
					<area shape="rect" coords="90,77,100,87"  onclick="callFun.addPitch('48');" />
					<area shape="rect" coords="100,77,110,87"  onclick="callFun.addPitch('49');" />
					<area shape="rect" coords="110,77,120,87"  onclick="callFun.addPitch('50');" />
					<area shape="rect" coords="20,87,30,97"  onclick="callFun.addPitch('51');" />
					<area shape="rect" coords="30,87,40,97"  onclick="callFun.addPitch('52');" />
					<area shape="rect" coords="40,87,50,97"  onclick="callFun.addPitch('53');" />
					<area shape="rect" coords="50,87,60,97"  onclick="callFun.addPitch('54');" />
					<area shape="rect" coords="60,87,70,97"  onclick="callFun.addPitch('55');" />
					<area shape="rect" coords="70,87,80,97"  onclick="callFun.addPitch('56');" />
					<area shape="rect" coords="80,87,90,97"  onclick="callFun.addPitch('57');" />
					<area shape="rect" coords="90,87,100,97"  onclick="callFun.addPitch('58');" />
					<area shape="rect" coords="100,87,110,97"  onclick="callFun.addPitch('59');" />
					<area shape="rect" coords="110,87,120,97"  onclick="callFun.addPitch('60');" />
					<area shape="rect" coords="20,97,30,107"  onclick="callFun.addPitch('61');" />
					<area shape="rect" coords="30,97,40,107"  onclick="callFun.addPitch('62');" />
					<area shape="rect" coords="40,97,50,107"  onclick="callFun.addPitch('63');" />
					<area shape="rect" coords="50,97,60,107"  onclick="callFun.addPitch('64');" />
					<area shape="rect" coords="60,97,70,107"  onclick="callFun.addPitch('65');" />
					<area shape="rect" coords="70,97,80,107"  onclick="callFun.addPitch('66');" />
					<area shape="rect" coords="80,97,90,107"  onclick="callFun.addPitch('67');" />
					<area shape="rect" coords="90,97,100,107"  onclick="callFun.addPitch('68');" />
					<area shape="rect" coords="100,97,110,107"  onclick="callFun.addPitch('69');" />
					<area shape="rect" coords="110,97,120,107"  onclick="callFun.addPitch('70');" />
					<area shape="rect" coords="20,107,30,117"  onclick="callFun.addPitch('71');" />
					<area shape="rect" coords="30,107,40,117"  onclick="callFun.addPitch('72');" />
					<area shape="rect" coords="40,107,50,117"  onclick="callFun.addPitch('73');" />
					<area shape="rect" coords="50,107,60,117"  onclick="callFun.addPitch('74');" />
					<area shape="rect" coords="60,107,70,117"  onclick="callFun.addPitch('75');" />
					<area shape="rect" coords="70,107,80,117"  onclick="callFun.addPitch('76');" />
					<area shape="rect" coords="80,107,90,117"  onclick="callFun.addPitch('77');" />
					<area shape="rect" coords="90,107,100,117"  onclick="callFun.addPitch('78');" />
					<area shape="rect" coords="100,107,110,117"  onclick="callFun.addPitch('79');" />
					<area shape="rect" coords="110,107,120,117"  onclick="callFun.addPitch('80');" />
					<area shape="rect" coords="20,117,30,127"  onclick="callFun.addPitch('81');" />
					<area shape="rect" coords="30,117,40,127"  onclick="callFun.addPitch('82');" />
					<area shape="rect" coords="40,117,50,127"  onclick="callFun.addPitch('83');" />
					<area shape="rect" coords="50,117,60,127"  onclick="callFun.addPitch('84');" />
					<area shape="rect" coords="60,117,70,127"  onclick="callFun.addPitch('85');" />
					<area shape="rect" coords="70,117,80,127"  onclick="callFun.addPitch('86');" />
					<area shape="rect" coords="80,117,90,127"  onclick="callFun.addPitch('87');" />
					<area shape="rect" coords="90,117,100,127"  onclick="callFun.addPitch('88');" />
					<area shape="rect" coords="100,117,110,127"  onclick="callFun.addPitch('89');" />
					<area shape="rect" coords="110,117,120,127"  onclick="callFun.addPitch('90');" />
					<area shape="rect" coords="20,127,30,137"  onclick="callFun.addPitch('91');" />
					<area shape="rect" coords="30,127,40,137"  onclick="callFun.addPitch('92');" />
					<area shape="rect" coords="40,127,50,137"  onclick="callFun.addPitch('93');" />
					<area shape="rect" coords="50,127,60,137"  onclick="callFun.addPitch('94');" />
					<area shape="rect" coords="60,127,70,137"  onclick="callFun.addPitch('95');" />
					<area shape="rect" coords="70,127,80,137"  onclick="callFun.addPitch('96');" />
					<area shape="rect" coords="80,127,90,137"  onclick="callFun.addPitch('97');" />
					<area shape="rect" coords="90,127,100,137"  onclick="callFun.addPitch('98');" />
					<area shape="rect" coords="100,127,110,137"  onclick="callFun.addPitch('99');" />
					<area shape="rect" coords="110,127,120,137"  onclick="callFun.addPitch('100');" />
					<area shape="rect" coords="20,137,30,147"  onclick="callFun.addPitch('101');" />
					<area shape="rect" coords="30,137,40,147"  onclick="callFun.addPitch('102');" />
					<area shape="rect" coords="40,137,50,147"  onclick="callFun.addPitch('103');" />
					<area shape="rect" coords="50,137,60,147"  onclick="callFun.addPitch('104');" />
					<area shape="rect" coords="60,137,70,147"  onclick="callFun.addPitch('105');" />
					<area shape="rect" coords="70,137,80,147"  onclick="callFun.addPitch('106');" />
					<area shape="rect" coords="80,137,90,147"  onclick="callFun.addPitch('107');" />
					<area shape="rect" coords="90,137,100,147"  onclick="callFun.addPitch('108');" />
					<area shape="rect" coords="100,137,110,147"  onclick="callFun.addPitch('109');" />
					<area shape="rect" coords="110,137,120,147"  onclick="callFun.addPitch('110');" />
					<area shape="rect" coords="20,147,30,157"  onclick="callFun.addPitch('111');" />
					<area shape="rect" coords="30,147,40,157"  onclick="callFun.addPitch('112');" />
					<area shape="rect" coords="40,147,50,157"  onclick="callFun.addPitch('113');" />
					<area shape="rect" coords="50,147,60,157"  onclick="callFun.addPitch('114');" />
					<area shape="rect" coords="60,147,70,157"  onclick="callFun.addPitch('115');" />
					<area shape="rect" coords="70,147,80,157"  onclick="callFun.addPitch('116');" />
					<area shape="rect" coords="80,147,90,157"  onclick="callFun.addPitch('117');" />
					<area shape="rect" coords="90,147,100,157"  onclick="callFun.addPitch('118');" />
					<area shape="rect" coords="100,147,110,157"  onclick="callFun.addPitch('119');" />
					<area shape="rect" coords="110,147,120,157"  onclick="callFun.addPitch('120');" />
					<area shape="rect" coords="20,157,30,167"  onclick="callFun.addPitch('121');" />
					<area shape="rect" coords="30,157,40,167"  onclick="callFun.addPitch('122');" />
					<area shape="rect" coords="40,157,50,167"  onclick="callFun.addPitch('123');" />
					<area shape="rect" coords="50,157,60,167"  onclick="callFun.addPitch('124');" />
					<area shape="rect" coords="60,157,70,167"  onclick="callFun.addPitch('125');" />
					<area shape="rect" coords="70,157,80,167"  onclick="callFun.addPitch('126');" />
					<area shape="rect" coords="80,157,90,167"  onclick="callFun.addPitch('127');" />
					<area shape="rect" coords="90,157,100,167"  onclick="callFun.addPitch('128');" />
					<area shape="rect" coords="100,157,110,167"  onclick="callFun.addPitch('129');" />
					<area shape="rect" coords="110,157,120,167"  onclick="callFun.addPitch('130');" />
					<area shape="rect" coords="20,167,30,177"  onclick="callFun.addPitch('131');" />
					<area shape="rect" coords="30,167,40,177"  onclick="callFun.addPitch('132');" />
					<area shape="rect" coords="40,167,50,177"  onclick="callFun.addPitch('133');" />
					<area shape="rect" coords="50,167,60,177"  onclick="callFun.addPitch('134');" />
					<area shape="rect" coords="60,167,70,177"  onclick="callFun.addPitch('135');" />
					<area shape="rect" coords="70,167,80,177"  onclick="callFun.addPitch('136');" />
					<area shape="rect" coords="80,167,90,177"  onclick="callFun.addPitch('137');" />
					<area shape="rect" coords="90,167,100,177"  onclick="callFun.addPitch('138');" />
					<area shape="rect" coords="100,167,110,177"  onclick="callFun.addPitch('139');" />
					<area shape="rect" coords="110,167,120,177"  onclick="callFun.addPitch('140');" />
					<area shape="rect" coords="20,177,30,187"  onclick="callFun.addPitch('141');" />
					<area shape="rect" coords="30,177,40,187"  onclick="callFun.addPitch('142');" />
					<area shape="rect" coords="40,177,50,187"  onclick="callFun.addPitch('143');" />
					<area shape="rect" coords="50,177,60,187"  onclick="callFun.addPitch('144');" />
					<area shape="rect" coords="60,177,70,187"  onclick="callFun.addPitch('145');" />
					<area shape="rect" coords="70,177,80,187"  onclick="callFun.addPitch('146');" />
					<area shape="rect" coords="80,177,90,187"  onclick="callFun.addPitch('147');" />
					<area shape="rect" coords="90,177,100,187"  onclick="callFun.addPitch('148');" />
					<area shape="rect" coords="100,177,110,187"  onclick="callFun.addPitch('149');" />
					<area shape="rect" coords="110,177,120,187"  onclick="callFun.addPitch('150');" />
					<area shape="rect" coords="20,187,30,197"  onclick="callFun.addPitch('151');" />
					<area shape="rect" coords="30,187,40,197"  onclick="callFun.addPitch('152');" />
					<area shape="rect" coords="40,187,50,197"  onclick="callFun.addPitch('153');" />
					<area shape="rect" coords="50,187,60,197"  onclick="callFun.addPitch('154');" />
					<area shape="rect" coords="60,187,70,197"  onclick="callFun.addPitch('155');" />
					<area shape="rect" coords="70,187,80,197"  onclick="callFun.addPitch('156');" />
					<area shape="rect" coords="80,187,90,197"  onclick="callFun.addPitch('157');" />
					<area shape="rect" coords="90,187,100,197"  onclick="callFun.addPitch('158');" />
					<area shape="rect" coords="100,187,110,197"  onclick="callFun.addPitch('159');" />
					<area shape="rect" coords="110,187,120,197"  onclick="callFun.addPitch('160');" />
					<area shape="rect" coords="20,197,30,207"  onclick="callFun.addPitch('161');" />
					<area shape="rect" coords="30,197,40,207"  onclick="callFun.addPitch('162');" />
					<area shape="rect" coords="40,197,50,207"  onclick="callFun.addPitch('163');" />
					<area shape="rect" coords="50,197,60,207"  onclick="callFun.addPitch('164');" />
					<area shape="rect" coords="60,197,70,207"  onclick="callFun.addPitch('165');" />
					<area shape="rect" coords="70,197,80,207"  onclick="callFun.addPitch('166');" />
					<area shape="rect" coords="80,197,90,207"  onclick="callFun.addPitch('167');" />
					<area shape="rect" coords="90,197,100,207"  onclick="callFun.addPitch('168');" />
					<area shape="rect" coords="100,197,110,207"  onclick="callFun.addPitch('169');" />
					<area shape="rect" coords="110,197,120,207"  onclick="callFun.addPitch('170');" />
					<area shape="rect" coords="20,207,30,217"  onclick="callFun.addPitch('171');" />
					<area shape="rect" coords="30,207,40,217"  onclick="callFun.addPitch('172');" />
					<area shape="rect" coords="40,207,50,217"  onclick="callFun.addPitch('173');" />
					<area shape="rect" coords="50,207,60,217"  onclick="callFun.addPitch('174');" />
					<area shape="rect" coords="60,207,70,217"  onclick="callFun.addPitch('175');" />
					<area shape="rect" coords="70,207,80,217"  onclick="callFun.addPitch('176');" />
					<area shape="rect" coords="80,207,90,217"  onclick="callFun.addPitch('177');" />
					<area shape="rect" coords="90,207,100,217"  onclick="callFun.addPitch('178');" />
					<area shape="rect" coords="100,207,110,217"  onclick="callFun.addPitch('179');" />
					<area shape="rect" coords="110,207,120,217"  onclick="callFun.addPitch('180');" />
                    </map>
                   </div>
                </td>
				<td>&nbsp;</td>
			</tr>
			</table>
            <!--PITCH TABLE ENDS HERE-->
            </td>
	</tr>
	<tr>
        <!--LEGEND TABLE-->
	    <td><input type="radio" name="bowlerside" id="bowlerside" value="Y" checked="checked"  onclick="callFun.overthewicket('Y');" >Over the wicket
	    	<input type="radio" name="bowlerside" id="bowlerside" value="N" onclick="callFun.overthewicket('N');"> Round the wicket
	    </td>
		<!--LEGEND TABLE END-->
        </tr>
        <tr>
		<td>Server Time:<span id="serverTime" name="serverTime"></span>
                    <input type="button" name="btnrefresh" id="btnrefresh" value="Refresh" onclick="ajexObj.sendServerTime('1')" />
                </td>
	</tr>
        </table>
        </td>
		<td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
               <td align="center" background="../images/BatsmanHeading.jpg" width="524" height="25" class="totallefttd"><%=battingteamname%></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="BATT_TABLE" name="BATT_TABLE" >
                       <tr>
                            <td class="colheading" width="20px">No</td>
                            <td class="colheading" width="45px">Time</td>
                            <td class="colheading" width="245px">Batsman</td>
                            <td class="colheading" width="50px">H.Out</td>
                            <td class="colheading" width="250px">Bowler</td>
                            <td class="colheading" width="50px">Runs</td>
                            <td class="colheading" width="30px">Balls</td>
                            <td class="colheading" width="45px">Min</td>
                            <td class="colheading" width="30px">4</td>
                            <td class="colheading" width="30px">6</td>
                            <td class="colheading" width="70px">SR</td>
                       </tr>
<%       int i=2; 
         int rownum = 1;
         while (battingSummaryCachedRowSet.next()) {
         if(battingSummaryCachedRowSet.getString("batsmanid").equals(strikerId)){
         	strikerrownumber = rownum;
         }else if(battingSummaryCachedRowSet.getString("batsmanid").equals(nonStrikerId)){
         	nonstrikerrownumber = rownum;
         }
         
         if(i%2==0){
%>                    <tr id='<%=battingSummaryCachedRowSet.getString("batsmanid")%>' name='<%=battingSummaryCachedRowSet.getString("batsmanid")%>' class="contentLight">
<%
         } else{
%>

			          <tr id='<%=battingSummaryCachedRowSet.getString("batsmanid")%>' name='<%=battingSummaryCachedRowSet.getString("batsmanid")%>' class="contentDark">
<%
          }
%>                     <td></td>
<%						if(battingSummaryCachedRowSet.getString("timein").equals(null) || battingSummaryCachedRowSet.getString("timein").equals(" ")){
%>						<td>						
<%						}else{	
%>						<td align="center" valign="middle" class="lefttd" onmouseover="document.getElementById('time_<%=battingSummaryCachedRowSet.getString("batsmanid")%>').style.display = 'block'" onmouseout="document.getElementById('time_<%=battingSummaryCachedRowSet.getString("batsmanid")%>').style.display = 'none'" >
							<img border="0" width="16px" height="16px" src="../images/Clock.jpg"><BR>
<%						}
%>
							
							<div style="background:#ADADAD;position:absolute;z-index:2;display:none" id='time_<%=battingSummaryCachedRowSet.getString("batsmanid")%>' name='time_<%=battingSummaryCachedRowSet.getString("batsmanid")%>'><b>In Time:-</b><lable id='time<%=battingSummaryCachedRowSet.getString("batsmanid")%>'><%=battingSummaryCachedRowSet.getString("timein")%></lable></div>
						</td>
                        <td id='<%=battingSummaryCachedRowSet.getString("batsman").trim()%>' name='<%=battingSummaryCachedRowSet.getString("batsman")%>' nowrap="nowrap" align="left" class="lefttd">
                           <%=battingSummaryCachedRowSet.getString("batsman")%> 
                        </td>
                        <td class="lefttd" align="left" nowrap="nowrap"><%=battingSummaryCachedRowSet.getString("batsmanout")%></td>
                        <td class="lefttd" align="left"  nowrap="nowrap"><%=battingSummaryCachedRowSet.getString("batsmanoutdiv")%></td>
                        <td align="right"><%=battingSummaryCachedRowSet.getString("runs").equals("-1")?"":battingSummaryCachedRowSet.getString("runs")%></td>
                        <td align="right"><%=battingSummaryCachedRowSet.getString("balls").equals("-1")?"":battingSummaryCachedRowSet.getString("balls")%></td>
                        <td align="right"><%=battingSummaryCachedRowSet.getString("mins").equals("-1")?"":battingSummaryCachedRowSet.getString("mins")%></td>
                        <td align="right"><%=battingSummaryCachedRowSet.getString("fours").equals("-1")?"":battingSummaryCachedRowSet.getString("fours")%></td>
                        <td align="right"><%=battingSummaryCachedRowSet.getString("six").equals("-1")?"":battingSummaryCachedRowSet.getString("six")%></td>
                        <td colspan="1" align="right"><%=battingSummaryCachedRowSet.getString("strike").equals("-1.00")?"":battingSummaryCachedRowSet.getString("strike")%></td>
                      </tr>
                         <input type="hidden" name="hd_match_player_id" id="hd_match_player_id" value='1'>
					     <input type="hidden" name="hd_team_id" id="hd_team_id" value='1'>
<%

                i=i+1;
                rownum = rownum + 1; // this is for count rw number	
           }
%>					
                     <tr>
                        <td></td>
                        <td></td>
                        <td align="right" class="lefttd" nowrap>Extras : </td>
                        <td colspan="2" align="left">&nbsp;&nbsp;
                          <b>&nbsp;( B&nbsp;-&nbsp;<span id="b" name="b"><%=bye%></span>,&nbsp;Lb&nbsp;-&nbsp;<span id="lb" name="lb"><%=legbye%></span>,&nbsp;Nb&nbsp;-&nbsp;<span id="nb" name="nb"><%=noball%></span>,
                         	 &nbsp;W&nbsp;-&nbsp;<span id="w" name="w"><%=wide%></span>&nbsp;)</b>
                        </td>
                        <td><span id="Extratotal" name="Extratotal"><%=extratotal%></span></td>
                     </tr>
                     <tr>
                        <td></td>
                        <td></td>
                        <td align="right" class="lefttd" nowrap>Penalty: </td>
                        <td colspan="2" align="left"></td>
                        <td><span id="open" name="open"><%=penlaty%></span></td>
                        <td align="right" colspan="2"  class="lefttd" nowrap>OverRate : </td>
                        <td colspan="2" align="left">&nbsp;&nbsp;
                          <span id="overrate" name="overrate"><%=overrate%></span>
                        </td>
                     </tr>
                     <tr>
	                    <td></td>
    	                <td></td>
        	            <td align="right" class="lefttd" nowrap>Total :</td>
            	        <td colspan="2" align="left">&nbsp;&nbsp; 
                	  		( <span id="batsmanscorerewkt"></span>&nbsp; wickets; &nbsp;<span id="Batstotalover"></span>&nbsp; overs)
                    	</td>
                    	<td id="battotalruns" ></td>
                      	<td colspan="5" align="left">(<span id="totlarunrate"></span> runs per over)</td>
                    </tr>
                    <tr>
                    	<td colspan="11" class="lefttd" align="left">Fall Of Wkt:
            	        <span id="fallofwicket"></span></td>
                    </tr>
                    </table>
                   </td>
                  </tr>
                </table></td>
              </tr>
              <tr>
               <td align="center" bgcolor="#ABA9AA"><img src="../images/TableBottom.jpg" width="522" height="14"></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center" background="../images/BatsmanHeading.jpg" width="524" height="30" class="totallefttd"><%=bowlingteamname%></td>
              </tr>
              <tr>
                <td><table width="558" border="0" align="center" cellpadding="0" cellspacing="0" id="BALL_TABLE">
               	  <tr>
                    <td width="34" class="colheading" align="center">No</td>
                    <td width="175" class="colheading" align="center">Bowler</td>
                    <td width="39" class="colheading" align="right">&nbsp;Over</td>
                    <td width="30" class="colheading" align="right">&nbsp;&nbsp;Maiden</td>
                    <td width="37" class="colheading" align="right">Runs</td>
                    <td width="35" class="colheading" align="right">&nbsp;Wkt</td>
                    <td width="20" class="colheading" align="right">&nbsp;Wd</td>
                    <td width="20" class="colheading" align="right">&nbsp;Nb</td>
                    <td width="40" class="colheading" align="right">SR</td>
                    <td width="48" class="colheading" align="right">Eco</td>
                  </tr>
<%
				int j = 2;
				int bowlerrowleng = bowlerscoreeCachedRowSet.size();
				int remainingrowleng = 12 - bowlerrowleng;
				int bowlerrownum = 1;
				while(bowlerscoreeCachedRowSet.next()){	
				if(bowlerStrikerId.equals(bowlerscoreeCachedRowSet.getString("bowler_id"))){
						bowlerrownumber = bowlerrownum;
				}
				if(j%2!=0){
%>                <tr  id="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>" name="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>" class="contentLight" >
<%				}else{
%>                <tr  id="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>" name="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>" class="contentDark" >
<%				}
%>
                    <td></td>
                    <td align="left" class="lefttd" ><%=bowlerscoreeCachedRowSet.getString("bowler_name")%></td>
                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("noofover")%></td>
                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("maiden")%></td>
                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("runs")%></td>
                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("wicket")%></td>
                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("wideball")%></td>
                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("noball")%></td>
                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("sr")%></td>
                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("eco")%></td>
                  </tr>
<%
				j=j+1;
				bowlerrownum = bowlerrownum + 1;
				}		
				for(int k=0;k<remainingrowleng;k++){ // this logic for add row which is not in database
				if(k%2!=0){
%>			
				<tr class="contentLight" >
<%
				}else{
%>                <tr class="contentDark" >
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
                    <td>&nbsp;</td>
                  </tr>
<%				}
%>

                </table></td>
              </tr>
              <tr>
                <td align="center"><img src="../images/TableBottom.jpg" width="522" height="14"></td>
              </tr>
            </table></td>
          </tr>
        </table>
        </td>
		<td width="193" valign="top">
        <table width="193" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
            <!--SCORECARD TABLE STARTS HERE-->
            <table width="193" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td><img src="../images/ScoreBoardTop.jpg" width="193" height="33"></td>
            </tr>
            <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                    <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd" id="No11" nowrap="nowrap"><b><%=batsmanA_name%></b></td>
                    <td background="../images/ScoreBoardReading.jpg" width="56" height="26" class="totallefttd" id="No1" name="No1"><%=batsmanA%></td>
                    <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                  </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                    <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd" id="No22" nowrap="nowrap"><b><%=batsmanB_name%></b></td>
                    <td background="../images/ScoreBoardReading.jpg" width="56" height="26" id="No2" name="No2" class="totallefttd" ><%=batsmanB%></td>
                    <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                    <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd"><b>Total</b></td>
                    <td background="../images/ScoreBoardReading.jpg" width="56" height="26" id="total" name="total" class="totallefttd"><%=scorerCardTotal%></td>
                    <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td width="193" height="13"><img src="../images/ScoreBoardSeperator.jpg" width="193" height="13"></td>
            </tr>
            <tr>
              <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                    <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd"><b>Last Man</b></td>
                    <td background="../images/ScoreBoardReading.jpg" width="56" height="26" name="lastMan" id="lastMan" class="totallefttd"><%=lastManRun%></td>
                    <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table>
              </td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd"><b>Wkts</b></td>
                  <td background="../images/ScoreBoardReading.jpg" width="56" height="26" name="Wickt" id="Wickt" class="totallefttd"><%=wkts%></td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd"><b>Overs</b></td>
                  <td background="../images/ScoreBoardReading.jpg" width="56" height="26" id="SBOver" name="SBOver" class="totallefttd"><%=currentover%></td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td width="193" height="13"><img src="../images/ScoreBoardSeperator.jpg" width="193" height="13"></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd"><b>Last Wkt</b></td>
                  <td background="../images/ScoreBoardReading.jpg" width="56" height="26" name="lstWicket" id="lstWicket" class="totallefttd"><%=lastWktTotal%></td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd"><b>Runs Req</b></td>
                  <td background="../images/ScoreBoardReading.jpg" width="56" height="26" id="runreq" name="runreq" class="totallefttd">
                  <% if(IsSuperover.equals("N")){ %>
                  <%=remainingrun%>
				  <%} %>
				   </td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd"><b>Remaining</b></td>
                  <td background="../images/ScoreBoardReading.jpg" width="56" height="26" id="RemOver" name="RemOver" class="totallefttd">&nbsp;<%=remainingOver%></td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><img src="../images/ScoreBoardTeamScore.jpg" width="193" height="16"></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardTeamLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardTeamName.jpg" width="86" height="26" class="totallefttd"><b><%=firstBattingName%></b></td>
                  <td background="../images/ScoreBoardScore1.jpg" width="39" height="26" class="totallefttd"><b><%=Team1totalscore1%></<b></td>
                  <td width="7" height="26"><img src="../images/ScoreBoardCenter.jpg" width="7" height="26"></td>
                  <td background="../images/ScoreBoardScore2.jpg"  width="39" height="26" class="totallefttd"><b><%=Team1tota1score2%></b></td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardTeamLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardTeamName.jpg" width="86" height="26" class="totallefttd"><b><%=secondBattingName%></b></td>
                  <td background="../images/ScoreBoardScore1.jpg" width="39" height="26" class="totallefttd"><b><%=Team2totalscore1%></b></td>
                  <td width="7" height="26"><img src="../images/ScoreBoardCenter.jpg" width="7" height="26"></td>
                  <td background="../images/ScoreBoardScore2.jpg" width="39" height="26" class="totallefttd"><b><%=Team2totalscore2%></b></td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><img src="../images/ScoreBoardFooter.jpg" width="193" height="5"></td>
            </tr>
            </table>
            <!--SCORECARD TABLE ENDS HERE-->
            </td>
        </tr>
        <tr>
            <td><img src="../images/LastTen.jpg" width="150" height="20"></td>
        </tr>
        <tr>
            <td><input type="button" id="btnBack" name="btnBack" value="<<"  onclick="ballObj.getLastTenOvers('1','1')"></input> <!--1st para flag for paging,2 nd para for navigateBack-->
            <input type="button" id="btnNext" name="btnNext" value=">>" onclick="ballObj.getLastTenOvers('1','2')"></input><!--1st para flag for paging,2 nd para for navigateNext-->
            <input type="button" id="btnrefresh" name="btnrefresh" value="Refresh" onclick="ballObj.getLastTenOvers('0','0');ajexObj.sendupdateoverrate(1)"></input>
            <input type="button" id="btngoto" name="btngoto" value="Go To" onclick="ballObj.goto()" ></input></td>
        </tr>
        <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
              		<td bgcolor="#ABA9AA" background="../images/ScoreBoardName.jpg" width="22" height="31" class="totallefttd">O</td>
              		<td bgcolor="#ABA9AA" background="../images/ScoreBoardName.jpg" width="110" height="31" class="totallefttd">Bwlr</td>
	          		<td bgcolor="#ABA9AA" background="../images/ScoreBoardName.jpg" width="40" height="31" class="totallefttd">Run</td>
              		<td bgcolor="#ABA9AA" background="../images/ScoreBoardName.jpg" width="40" height="31" class="totallefttd">Wkt</td>
              </tr>
<%			for(int t=1;t<=10;t++){
				if(!(t%2==0)){
%>
              <tr>
                <td class="contentLastLight"><span id="over<%=t%>">&nbsp;</span></td>
                <td class="contentLastLight" onmouseover="callFun.overDetails('<%=t%>')" onmouseout="document.getElementById('over_<%=t%>').style.display = 'none'" align="left"><span id="bwlr<%=t%>">&nbsp;</span>
                	<div style="background:#ADADAD;left:750px;position:absolute;z-index=0.5;display:none" id='over_<%=t%>' name='over_<%=t%>'><lable id='over<%=t%>'><lable></div>
                </td>
                <td class="contentLastLight"><span id="runs<%=t%>">&nbsp;</span></td>
                <td class="contentLastLight"><span id="wkt<%=t%>">&nbsp;</span></td>
                <td class="contentLastLight"><span id="total<%=t%>">&nbsp;</span><input type="hidden" name="achorover_num<%=t%>" id="achorover_num<%=t%>" value=""></td>
              </tr>
<%				}else{
%>              
              <tr>
                <td class="contentLastDark"><span id="over<%=t%>">&nbsp;</span></td>
                <td class="contentLastDark" onmouseover="callFun.overDetails('<%=t%>')" onmouseout="document.getElementById('over_<%=t%>').style.display = 'none'" align="left"><span id="bwlr<%=t%>">&nbsp;</span>
                	<div style="background:#ADADAD;left:750px;position:absolute;z-index=0.5;display:none" id='over_<%=t%>' name='over_<%=t%>'><lable id='over<%=t%>'><lable></div>
                </td>
                <td class="contentLastDark"><span id="runs<%=t%>">&nbsp;</span></td>
                <td class="contentLastDark"><span id="wkt<%=t%>">&nbsp;</span></td>
                <td class="contentLastDark"><span id="total<%=t%>">&nbsp;</span><input type="hidden" name="achorover_num<%=t%>" id="achorover_num<%=t%>" value=""></td>
              </tr>
<%				}// end of else
			}// end of for
%>                        
            </table></td>
        </tr>
        </table>
        </td>
    </tr>
    </table>
    </td>
</tr>
<tr>
    <td>&nbsp;</td>
</tr>
</table>
<div id="PopupDiv" class="popupdiv" onmouseover = "callFun.setdivid('popupdiv')">
</div>
<div id="BatList" name="BatList" class="divlist" onmouseover = "callFun.setdivid('BatList')">
<table align="center" >
	<tr>
		<td colspan="2"> <lable><b>New Batsman  List</b></lable> </td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>	
	</tr>
	<tr>
		<td><lable><b>Select Batsman :</b></td>
		<td><select name="selbat" id="selbat">
			<option value="">--Select Batsman Name--</option>
<%
			while(newBatsmanCachedRowSet.next()){
			
%>
			<option value="<%=newBatsmanCachedRowSet.getString("id")+"~"+newBatsmanCachedRowSet.getString("playername")%>"><%=newBatsmanCachedRowSet.getString("playername")%></option>
<%
			
			}
%>
		</select></td>
	</tr>
	<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center"><input type="button" align="center"
			id="btnbatsubmit" name="btnbatsubmit" value="Submit"
			onclick="callFun.newBatsmanSelection('selbat')"></input>
		</td>
		<td><input type="button" align="center"
			id="btnbatintervaltime" name="btnbatintervaltime" value="Interval Time"
			onclick="callFun.intervalpopup('BackgroundDiv','BatList','linkintervaldiv')"></td>
	</tr>
</table>
</div>
<div id="BowlList" name="BowlList" class="bowlerdivlist" onmouseover = "callFun.setdivid('BowlList')">
<table align="center">
	<tr>
		<td colspan="2"><lable><b> New Bowler List</b></lable> </td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>	
	</tr>
	<tr>
		<td>Select Bowler :</td>
		<td><select name="selBowler" id="selBowler">
			<option value="">-----Select Bowler Name-----</option>
			<%
					while(bowlerCachedRowSet.next()){
%>
			<option
				value='<%=bowlerCachedRowSet.getString("playername")+'~'+ bowlerCachedRowSet.getString("id")+'~'+ bowlerCachedRowSet.getString("is_wkeeper")%>' <%=previousStrikerbowler.equalsIgnoreCase(bowlerCachedRowSet.getString("id"))?"selected":""%>><%=bowlerCachedRowSet.getString("playername")%></option>
			<%
					}
%>
		</select>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center"><input type="button" align="center"
			id="btnsubmit" name="btnsubmit" value="Submit"
			onclick="addRow('BALL_TABLE')"></input>
		</td>
		<td><input type="button" align="center"
			id="btnbatintervaltime" name="btnbatintervaltime" value="Interval Time"
			onclick="callFun.intervalpopup('BackgroundDiv','BowlList','linkintervaldiv');"></td>
	</tr>
</table>
</div>
<div id="remarkList" name="remarkList" class="divlist" onmouseover = "callFun.setdivid('remarkList')">
	<table align="center">
		<tr>
			<td colspan="2" align="center"><lable><b>Remark</b></lable>  
			</td>
		</tr>
		<tr>
			<td>Enter Remark :</td>
			<td><textarea NAME="txtremark" id="txtremark" ROWS="2" COLS="15"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Add Remark" 	onclick="callFun.getRemark();callFun.closeBowlList('remarkList')"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancel" onclick="callFun.closeBowlList('remarkList')"></input>
			</td>
		</tr>
	</table>
</div>
<div id="penaltyremarkList" name="penaltyremarkList" class="divlist" onmouseover = "callFun.setdivid('penaltyremarkList')" >
	<table align="center">
		<tr>
			<td colspan="2" align="center"><lable><b>Remark</b></lable>  
			</td>
		</tr>
		<tr>
			<td>Enter Remark :</td>
			<td><textarea NAME="txtpenaltyremark" id="txtpenaltyremark" ROWS="2" COLS="20"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Add Remark" 	onclick="callFun.getpenaltyRemark();closePopup('BackgroundDiv','penaltyremarkList')"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancel" onclick="closePopup('BackgroundDiv','penaltyremarkList')"></input>
			</td>
		</tr>
	</table>
</div>
<div id="swapBowlerRemarkList" name="swapBowlerRemarkList" class="divlist" onmouseover = "callFun.setdivid('swapBowlerRemarkList')">
	<table align="center">
		<tr>
			<td colspan="2" align="center"><lable><b>Remark</b></lable>  
			</td>
		</tr>
		<tr>
			<td>Enter Remark :</td>
			<td><textarea NAME="txtbowlerremark" id="txtbowlerremark" ROWS="2" COLS="20"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Add Remark" 	onclick="callFun.getswapBowlerRemark();callFun.closeBowlList('swapBowlerRemarkList')"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancel" onclick="closePopup('BackgroundDiv','swapBowlerRemarkList')"></input>
			</td>
		</tr>
	</table>
</div>
<div id="retireRemarkList" name="retireRemarkList" class="divlist" onmouseover = "callFun.setdivid('retireRemarkList')">
	<table align="center">
		<tr>
			<td colspan="2" align="center"><lable><b>Remark</b></lable>  
			</td>
		</tr>
		<tr>
			<td>Enter Remark :</td>
			<td><textarea NAME="txtretireremark" id="txtretireremark" ROWS="2" COLS="20"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Add Remark" 	onclick="callFun.getretired();callFun.closeBowlList('retireRemarkList')"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancel" onclick="closePopup('BackgroundDiv','retireRemarkList')"></input>
			</td>
		</tr>
	</table>
</div>
<div id="totallandmark" name="totallandmark" class="divlist" onmouseover = "callFun.setdivid('totallandmark')">
	<table width="100%">
		<tr>
			<td><center><font style="color:red"><lable><b>Total Runs Landmark </b></lable> </font></center></td>
		</tr>
		<tr>
			<td><center><font style="color:red"><span id="totallandmarkkrun" name="totallandmarkkrun"></span></font></center></td>
		</tr>
		<br>
		<tr>
			<td><center><input align="center" type="button" value="Close" onclick="closePopup('BackgroundDiv','totallandmark')"></center></input>
		</tr>
	</table>
</div>
<div id="batsmanlandmark" name="batsmanlandmark" class="divlist" onmouseover = "callFun.setdivid('batsmanlandmark')">
	<table width="100%">
		<tr>
			<td><center><font style="color:red"><lable><b>Batsman Runs Landmark</b></lable> </center></td>
		</tr>
		<tr>
			<td><center><font style="color:red"><span id="batsmanlandmarkrun" name="batsmanlandmarkrun"></span></font></center></td>
		</tr>
		<br>
		<tr>
			<td><center><input align="center" type="button" value="Close" onclick="closePopup('BackgroundDiv','batsmanlandmark')"></center></input>
		</tr>
	</table>
</div>
<div id="bowlerlandmark" name="bowlerlandmark" class="divlist" onmouseover = "callFun.setdivid('bowlerlandmark')">
	<table width="100%">
		<tr>
			<td><center><font style="color:red"><lable><b>Bowler Landmark</b></lable></center></td>
		</tr>
		<tr>
			<td><center><font style="color:red"><span id="bowlerlandmarkwkt" name="bowlerlandmarkwkt"></span></font></center></td>
		</tr>
		<br>
		<tr>
			<td><center><input align="center" type="button" value="Close" onclick="closePopup('BackgroundDiv','bowlerlandmark')"></center></input>
		</tr>
	</table>
</div>
<div id="partnershiplandmark" name="partnershiplandmark" class="patenershipdivlist" onmouseover = "callFun.setdivid('partnershiplandmark')">
	<table width="100%">
		<tr>
			<td><center><font style="color:red"><lable><b>Partnership Landmark </b></lable></center></td>
		</tr>
		<tr>
			<td><center><font style="color:red"><span id="partnershiprun" name="partnershiprun"></span></font></center></td>
		</tr>
		<br>
		<tr>
			<td><center><input align="center" type="button" value="Close" onclick="closePopup('BackgroundDiv','partnershiplandmark')"></center></input>
		</tr>
	</table>
</div>
<div id="wagondiv" id="wagondiv" class="divwagon" >
</div>
<div id="modifiedtime" name="modifiedtime" class="divlist" onmouseover = "callFun.setdivid('modifiedtime')">
	<table align="center">
		<tr>
			<td colspan="2" align="center"><lable><b> Set Day Minimum  Over </b></lable>
			</td>
		</tr>
		<tr>
			<td>Set Max Overs :</td>
			<td><textarea NAME="txtmaxremark" id="txtmaxremark" ROWS="1" COLS="5" onKeyPress="return keyRestrict(event,'1234567890');"></textarea></td>
		</tr>
		<tr>
			<td>Set Target Run :</td>
			<td><textarea NAME="txttarget" id="txttarget" ROWS="1" COLS="5" onKeyPress="return keyRestrict(event,'1234567890');">0</textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Set Max Over" 	onclick="callFun.setmaxOver()"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancel" onclick="closePopup('BackgroundDiv','modifiedtime')" ></input>
			</td>
		</tr>
	</table>
</div>
<div id="changestrikerPosition" name="changestrikerPosition" class="divlist" onmouseover = "callFun.setdivid('changestrikerPosition')">
	<table align="center">
		<tr>
			<td colspan="2" align="center"><lable><b> Change Batsman Position</b></lable>
			</td>
		</tr>
		<tr>
			<td>Striker Batsman Order No:-</td>
			<td><textarea NAME="txtstrikerbatsman" id="txtstrikerbatsman" ROWS="1" COLS="5" onKeyPress="return keyRestrict(event,'1234567890');"></textarea></td>
		</tr>
		<tr>
			<td>NonStriker Batsman Order No:-</td>
			<td><textarea NAME="txtnonstrikerbatsman" id="txtnonstrikerbatsman" ROWS="1" COLS="5" onKeyPress="return keyRestrict(event,'1234567890');"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Swap Batsman" onclick="bastmenObj.setswapStrikerNonStriker();"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancel" onclick="closePopup('BackgroundDiv','changestrikerPosition')" ></input>
			</td>
		</tr>
	</table>
</div>
<div id="endmatchdiv" name="endmatchdiv" class="divresult" onmouseover = "callFun.setdivid('endmatchdiv')">
	<table align="center">
		<tr>
			<td><span id="resultspan" name="resultspan"> </span></td>
		</tr>
		<tr><td align="center"> <font color="red">If the match is drawn, <br>please use the End Match option to end the match!</font> </td></tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="  Continue  " onclick="callFun.setresult()"></input>
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="  Match Point  " onclick="callFun.setmatchpoint()"></input>
                <input type="button" align="center" id="btnbatintervaltime" name="btnbatintervaltime" value="Interval Time" onclick="callFun.intervalpopup('BackgroundDiv','BowlList','linkintervaldiv');">
				<input type="button" align="center" id="btnsupperover" name="btnsupperover" value="  Supper Over  " onclick="callFun.setsupperover();"></input>
				<input type="button" align="center" id="btnupdatematchresult" name="btnupdatematchresult" value="  Update Match Result  " onclick="callFun.updatematchresult()"></input>
			</td>
                          
		</tr>		
	</table>	
</div>
<div id="moreundo" name="moreundo" class="divlist" onmouseover = "callFun.setdivid('moreundo')">
	<table align="center">
		<tr>
			<td colspan="2" align="center"><lable><b> Number of overs to undo</b></lable>
			</td>
		</tr>
		<tr>
			<td>Enter Overs :</td>
			<td><textarea NAME="txtundoover" id="txtundoover" ROWS="2" COLS="20" onKeyPress="return keyRestrict(event,'1234567890');"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Undo" 	onclick="callFun.moreundo()"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancel" onclick="closePopup('BackgroundDiv','moreundo')"></input>
			</td>
		</tr>
	</table>
</div>
<div id="selectedOverBallsDiv" name="selectedOverBallsDiv" class="divupdateover" style='position: absolute;overflow:auto;' onmouseover = "callFun.setdivid('selectedOverBallsDiv')">
	
</div>
<div id="updateRunsDiv" name="updateRunsDiv"  class="divupdateruns" style='position: absolute' onmouseover = "callFun.setdivid('updateRunsDiv')">
</div>
<div id="updateWicketDiv" name="updateWicketDiv"  class="divupdatewicket" style='position: absolute' onmouseover = "callFun.setdivid('updateWicketDiv')">
</div>
<div id="gotoDiv" name="gotoDiv"  class="divlist" style='position: absolute' onmouseover = "callFun.setdivid('gotoDiv') ">
		<br>
		<br>
		<table align = "center">
			<tr>
				<td align = "center">
					Enter over number : <input type="text" id="txtOverNumber" size="5" name="txtOverNumber" value="">
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td align = "center">
					<input type="button" value="OK" onclick="ballObj.getLastTenOvers('1','3');"><!--closePopup('BackgroundDiv','gotoDiv')dipti 06062009-->
					<input type="button" value="Cancel" onclick="closePopup('BackgroundDiv','gotoDiv')">
				</td>
			</tr>
		</table>
		
		
</div>
<div id="linkintervaldiv" name="linkintervaldiv" class="divlist" onmouseover = "callFun.setdivid('linkintervaldiv')">
	<table align="center">
		<tr>
			<td><lable><b> Interval</b></lable> </td>
		</tr>
		<tr>
			<td><select name="selinterval" id="selinterval">
			<option value="">--Select Interval Type--</option>
<%		 for(int a=0;a<intervalleng;a++){
%>			 <option value="<%=intervalnamearr[a]%>~<%=intervalidarr[a]%>"><%=intervalnamearr[a]%></option>
<%		}
%>			<option value="drwamatch~<%=matchId%>">End Match </option>	
		</select></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btninterval" name="btninterval" value="  Interval  " 	onclick="callFun.callinterval('selinterval')"></input>
			</td>
		</tr>		
	</table>	
</div>
<div id ="selectpreviousinning" name="selectpreviousinning" class="divlist" onmouseover = "callFun.setdivid('selectpreviousinning')">
	<table align="center" width="80%" class="TDData" >
<%		if(preInningId!=null){
			for(int k=0;k<preInningId.length;k++){
				String str1=preInningId[k];
%>				<input type="hidden" name="str<%=k+1%>" id="str<%=k+1%>" value="<%=str1%>">
<%
			}
		for(int b=0;b<preInningId.length;b++){	
%>		<tr>
			<td>
				<a href="javascript:callFun.DiplayReportForInningOne('<%=b+1%>')" class="lefttd">Inning <%=b+1%></a>
			</td>
		</tr>
<%	
	   }
	}// end of if
%>
   </table>		
						 
</div>
<div id="offlinediv" name="offlinediv" class="divlist" onmouseover = "callFun.setdivid('offlinediv')">
	<table align="center">
		<tr>
			<td colspan="2"><lable><b> set OnLine / OffLine </b></lable></td>
			
		</tr>
		<tr>
			<td colspan="2"><input type="checkbox"  name="chkonline" id= "chkonline" onclick="callFun.chkoffline('chkonline','txtofflinedate')">&nbsp;&nbsp;Select for Online Entry</td>
		</tr>
		<tr>
			<td>Enter Date:</td>
			<td><input type="Text" id="txtofflinedate"  name="txtofflinedate" maxlength="25" size="20" value="<%=starttime%>" readonly="readonly"><a id="imganchor" name="imganchor" href="javascript:NewCal('txtofflinedate','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>
				<input type="hidden" id="hdofflinedate" name="hdofflinedate" value="<%=starttime%>">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnoffline" name="btnoffline" value="  Set Time  " 	onclick="callFun.offline('BackgroundDiv','offlinediv')"></input>
			</td>
		</tr>		
	</table>	
</div>
<div id="updateIntervalDiv"  class="divupdateInterval" style='position: absolute;' onmouseover = "callFun.setdivid('updateIntervalDiv')">
</div>
<div id="confirmOnline" name="confirmOnline"  class="divlist" onmouseover = "callFun.setdivid('confirmOnline')"><%--Dipti--%>
	<table align="center">
		<tr>
			<td colspan="2"><lable><b> Do you want to play offline? </b></lable></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="&nbsp;Yes&nbsp;" onclick="callFun.callConfirmOfflineDiv();closePopup('BackgroundDiv','confirmOnline')"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="&nbsp;No&nbsp;" onclick="closePopup('BackgroundDiv','confirmOnline')" ></input>
			</td>
		</tr>
	</table>		
</div>
<div style="display:none">
<%		
		int firstCount = 0;
		bowlerCachedRowSet.first();
		while(bowlerCachedRowSet.next()){
		  if(firstCount==0){
			  bowlerCachedRowSet.first();
			  firstCount++;
		  }
%>
		<input type="hidden" name="bowling_right<%=bowlerCachedRowSet.getString("id")%>" id="bowling_right<%=bowlerCachedRowSet.getString("id")%>" value='<%=bowlerCachedRowSet.getString("bowling_right")%>'>
<%		}
%>

<%		int firstBattingCount = 0;
		battingSummaryCachedRowSet.first();
		while(battingSummaryCachedRowSet.next()){
  		if(firstBattingCount==0){
  			battingSummaryCachedRowSet.first();
	 	 	firstBattingCount++;
        }
%>
	   <input type="hidden" name="bastman_right<%=battingSummaryCachedRowSet.getString("batsmanid")%>" id="bastman_right<%=battingSummaryCachedRowSet.getString("batsmanid")%>" value='<%=battingSummaryCachedRowSet.getString("batting_right")%>'>
<%		}
%>

	<input type="hidden" name="hdbatsmanstriker" id="hdbatsmanstriker" value="<%=strikerrownumber%>">
	<input type="hidden" name="hdbatsmannonstriker" id="hdbatsmannonstriker" value="<%=nonstrikerrownumber%>">
	<input type="hidden" name="hdbowlerstriker" id="hdbowlerstriker" value="<%=bowlerrownumber%>">
	<input type="hidden" id="hidOvers" name="hidOvers" value="">
	<input type="hidden" id="hidToolTip" name="hidToolTip" value="">
	<input type="hidden" id="hidstrikerbowler" name="hidstrikerbowler" value="<%=strikerbowlerball%>">	
	<input type="hidden" name="hdtotalcount" id="hdtotalcount" value="<%=totalball%>">
	<input type="hidden" name="hdchangetotalcount" id="hdchangetotalcount" value="<%=todaytotalball%>">
	<input type="hidden" name="hdscorercardflag" id="hdscorercardflag" value="<%=scorecardflag%>">
	<input type="hidden" name="hdmatchtime" id="hdmatchtime" value="<%=matchMinits%>">
	<input type="hidden" name="hdbowlercounter" id="hdbowlercounter" value="<%=maxovers%>">	
	<input type="hidden" name="hdcheckwkt" id="hdcheckwkt" value="<%=lastwkt%>">	
	<input type="hidden" name="hdlastrun" id="hdlastrun" value="<%=runtype%>">
	<input type="hidden" name="hdintervalstatusid" id="hdintervalstatusid" value="<%=intervalid%>">
	<input type="hidden" name="hdintervalstatusname" id="hdintervalstatusname" value="<%=intervalname%>">	
	<input type="hidden" name="hdintervalstatuscount" id="hdintervalstatuscount" value="<%=intervalcount%>">
	<input type="hidden" name="hdreqrunflag" id="hdreqrunflag" value="<%=reqrunflag%>">
	<input type="hidden" name="hdcurrentpatnershipball" id="hdcurrentpatnershipball" value="<%=patenershipball%>">
	<input type="hidden" name="hdauthentic" id="hdauthentic" value="<%=authentic%>">
	<input type="hidden" name="hdtotalInningMint" id="hdtotalInningMint" value="<%=totalInningMint%>">
	<input type="hidden" name="hdpageNumber" id="hdpageNumber" value="">
	<input type="hidden" name="hdMaxPageNumber" id="hdMaxPageNumber" value="">
	<input type="hidden" name="inningNo" id="inningNo" value="<%=inningNo%>">
	<input type="hidden" name="outscorercardRow" id="outscorercardRow" value="<%=outscorercardRow%>">
	<input type="hidden" name="retireIdrefresh" id="retireIdrefresh" value="<%=retireIdrefresh%>">
	<input type="text" name="allball" id="allball" value="<%=allball%>"><!--//dipti 22 05 2009-->
	<input type="hidden" name="batterCount" id="batterCount" value="<%=batterCount%>"><!--//dipti 27 05 2009-->
	<table>
		<tr>
			<td id="hdtodaySBOver" name="hdtodaySBOver"></td>
		</tr>
	</table>
</div>
  <script>	
    bastmenObj.setstrikernonstriker();
	bastmenObj.checkRetirecolumn(); // check retire batsman playing or not
	ballObj.setstrikerbowler();
	callFun.runVariable();
	callFun.rowNumber();
	//  callFun.strikerNonStrikerInTime();
    //bastmenObj.playerTime();
    initBastmanMinuts();
    ballObj.setballcount();
    scoreObj.updateBatsmanTableTotalRun();
    ballObj.getLastTenOvers('0','0');
   // ballObj.updateScorerOver();
    if($$('hdscorercardflag')=="false"){ // this logic is for set striker non striker for scorer card
	    scoreObj.swapBatsmen()
	}
	bastmenObj.setbatsmancss();
	ballObj.setbowlercss();
	ballObj.setmaxOver();
	scoreObj.setStrikerCss();
	if($$('hdauthentic')=="Y"){
		$("chkonline").checked=true;
		callFun.setonlineflag("online");
	}else if($$('hdauthentic')=="N"){
		$("chkonline").checked=false;
		callFun.setonlineflag("ofline"); 
		callFun.refreshofflinedate();	
	}
	//dipti 27 05 2009
	//callFun.checkbastman();
	var batterCount = parseInt($$('batterCount'));
	//if(batterCount <= '1'){// dipti 29 05 2009
	callFun.checkbastman();
	//}
	//dipti 27 05 2009
	callFun.setpatenership();
	ballObj.setlastbowlerover();
	closePopup('BackgroundDiv','pbar')
	callFun.checkintervalrefreshstatus();
	ajexObj.sendfallofwicket();
    ajexObj.sendServerTime("1");
	scoreObj.setoutcol($$('outscorercardRow'));
	bastmenObj.setOutFlag($$('retireIdrefresh'));
	callFun.msg();
	//bastmenObj.setstrikernonstrikervalue();
	//callFun.setmaxRowNumber();
  </script>
</div>
</form>
</body>
<% } catch (Exception e) {
    e.printStackTrace();
   log.writeErrLog(page.getClass(),matchId,e.toString());
}finally{
	try{
		 runId=null;
		 runName = null;
		 runs = null;
		 isExtra = null;
		 overs=null;
		 ballperover =null;
		 overperbowler =null;
		 powerplay =null;
		 id = null;
		 battingteam =null;
		 totalruns=null;	
		 totalscoreid1 =null;
		 totalscoreid2 =null;
		 totalscoreid3 =null;		
		 totalscoreid4 =null;	
		 totalbattingteam1 =null;
		 totalbattingteam2 =null;
		 totalbattingteam3 =null;
		 totalbattingteam4 =null;
		 totalruns1=null;
		 totalruns2=null;
		 totalruns3=null;
		 totalruns4=null;
		 retireId = null;
		 scoreteam1Inning1 =null;
		 scoreteam1Inning2 =null;
		 scoreteam2Inning1 =null;
		 scoreteam2Inning2 =null;
		 batsmanA = null;
		 batsmanB = null;
		 scorerCardTotal = null;
		 lastManRun = null;
		 wkts = null;
		 totalovers = 0;
		 currentover =null;
		 lastWktTotal = null;
		 remainingOver = null;
		 strikerId =null;
		 strikerrownumber =0;
		 nonstrikerrownumber =0 ;
		 nonStrikerId = null;
		 bowlerStrikerId=null;
		 bowlerrownumber = 0;
		 previousStrikerbowler = null;
		 scorecardflag = false;
		 temp=null;
		 runtype =0;
		 strikerbowlerball = 0;
		 totalball = 0;
		 todaytotalball = 0;
		 matchMinits = 0;
		 maxovers  = 0;
		 lastwkt = 0;
		 team1run = 0;
		 team2run = 0;
		 remainingrun = 0;
		 rowlength = 0;
		 patenershipball = 0;
		 bye=null;
		 legbye=null;
		 noball =null;
		 wide =null;
		 penlaty =null;
		 extratotal =null;
		 match_type = null;
		 teamName =null;
		 intervalid = null;
		 intervalname =null;
		 intervalcount = null;
		 firstBattingName = null;
		 secondBattingName = null;
		 reqrunflag = null;
         lobjCachedRowSet = null;
         bowlerCachedRowSet = null;
         penaltiesCachedRowSet = null;
         dismissalTypeCachedRowSet = null;
         RunTypeCachedRowSet = null;
         newBatsmanCachedRowSet = null;
         matchDetailCachedRowSet = null;
         totalScoreCachedRowSet = null;
         battingSummaryCachedRowSet = null;
         battingscorercardCachedRowSet = null;
         bowlerscoreeCachedRowSet = null;
         strikernonstrikerCachedRowSet = null;
         extrarunCachedRowSet = null;
         pauseInningCachedRowSet = null;
         intervalCachedRowSet = null;
         flag=false;
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>
</html>
