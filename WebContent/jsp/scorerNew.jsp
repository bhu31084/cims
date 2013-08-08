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
                 java.util.*"%>
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
    try {
		String BowlerName = "";	
		String BowlerId ="";
		String BName ="";
		String BatsMan1Name ="";
		String BatsMan1Id ="";
		String BatsMan2Name ="";
		String BatsMan2Id  ="";
		if( request.getParameter("bowlerName")!=null){
        BowlerName = request.getParameter("bowlerName");
    	BowlerId = request.getParameter("BowlerId").trim();
    	BName = request.getParameter("BPlayer");
	   	String[] BatsMan1NameArr = request.getParameter("BatsMan1").split("~");
	   	String[] BatsMan2NameArr = request.getParameter("BatsMan2").split("~");
		BatsMan1Name = BatsMan1NameArr[0].trim();// name of striker
	   	BatsMan1Id = BatsMan1NameArr[1].trim();// id of striker
	   	BatsMan2Name = BatsMan2NameArr[0].trim();//name of non striker
	   	BatsMan2Id = BatsMan2NameArr[1].trim();//id of non striker
	   	}
	   	int match_status = 0;
	   //	session.setAttribute("InningId","1");
	   	//session.setAttribute("matchId1","1");
	   	if(request.getParameter("flg") != null && request.getParameter("flg").equalsIgnoreCase("P")){
	   		String inningIdPre = request.getParameter("InningIdPre");
	  		session.setAttribute("InningId",inningIdPre);
	  	}
	   	String inningId = (String)session.getAttribute("InningId");
		String runId=null;
		String runName = null;
		String runs = null;
		String isExtra = null;
		String overs="";
		String ballperover ="";
		String overperbowler ="";
		String powerplay ="";
		String id = "";
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
		String scoreteam1Inning1 ="";
		String scoreteam1Inning2 ="";
		String scoreteam2Inning1 ="";
		String scoreteam2Inning2 ="";
		String retireId = ""; //this flag for retire 
        CachedRowSet lobjCachedRowSet = null;
        CachedRowSet bowlerCachedRowSet = null;
        CachedRowSet penaltiesCachedRowSet = null;
        CachedRowSet dismissalTypeCachedRowSet = null;
        CachedRowSet RunTypeCachedRowSet = null;
        CachedRowSet newBatsmanCachedRowSet = null;
        CachedRowSet matchDetailCachedRowSet = null;
        CachedRowSet totalScoreCachedRowSet = null;
        CachedRowSet battingSummaryCachedRowSet = null;
        CachedRowSet pauseInningCachedRowSet = null;
        boolean flag=false;
        String total = (request.getParameter("Total") == null) ? "" : request.getParameter("Total");// These For 2nd Inning Only
        GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
        Vector vparam = new Vector();
        /*Start code for check page is refresh or not*/
        	vparam.add(inningId);
       		lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_checkmatchstatus", vparam, "ScoreDB"); // Batsman List
       		 while(lobjCachedRowSet.next()){
       			 match_status = lobjCachedRowSet.getInt("ball_id");
       		 }
        	vparam.removeAllElements();
        /*End Code for check page is refresh or not*/
        
        if(match_status > 0){
			 response.sendRedirect("/cims/jsp/scorerRefreshNew.jsp");
        }else{
            vparam.add(inningId);
	        lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenlist", vparam, "ScoreDB"); // Batsman List
	        newBatsmanCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenlist", vparam, "ScoreDB"); // Batsman List
			bowlerCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_bowlinglist",vparam,"ScoreDB");
	        vparam.removeAllElements();
	        
	        vparam.add("1"); // default value 1 Flag 1 for Dismisal
    	    dismissalTypeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_types", vparam, "ScoreDB"); // Dismisal Type List
        	vparam.removeAllElements();
	        vparam.add("2"); // default value 2 Flag 2 for Dismaisaal list
    	    RunTypeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_types", vparam, "ScoreDB"); // Dismisal Type List
        	vparam.removeAllElements();
	        while(RunTypeCachedRowSet.next()){
    	    	runId = runId + RunTypeCachedRowSet.getString("id") + "~";
        		runName = runName + RunTypeCachedRowSet.getString("name") + "~";
        		runs = runs + RunTypeCachedRowSet.getString("runs") + "~";
	        	powerplay = isExtra + RunTypeCachedRowSet.getString("is_extra") + "~";
	
    	    }
        	vparam.add("3"); // default value 3 Flag 3 for penalties
	        RunTypeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_types", vparam, "ScoreDB"); // penalties Type List
    	    vparam.removeAllElements();
        	
        	vparam.add("4"); //default value 4 Flag 4 for Interval
		    pauseInningCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_types", vparam, "ScoreDB"); // Interval Type List
        	vparam.removeAllElements();
        	
        	vparam.add((String)session.getAttribute("matchId1")); // // for match details
	        matchDetailCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchtypedetail", vparam, "ScoreDB"); // penalties Type List
    	    vparam.removeAllElements();
        	while(matchDetailCachedRowSet.next()){
        		overs = matchDetailCachedRowSet.getString("overs_max");
	        	ballperover = matchDetailCachedRowSet.getString("balls_per_over");
    	    	overperbowler = matchDetailCachedRowSet.getString("overs_per_bowler");
        		powerplay = matchDetailCachedRowSet.getString("powerplay");
	        }
    	    vparam.add((String)session.getAttribute("matchId1")); // // for match details
        	totalScoreCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_totalscore", vparam, "ScoreDB"); // penalties Type List
       		 vparam.removeAllElements();
	         if(totalScoreCachedRowSet.next()){
    	     while(totalScoreCachedRowSet.next()){
        	 	id = id + totalScoreCachedRowSet.getString("id")+"~"; 
         		battingteam = battingteam + totalScoreCachedRowSet.getString("batting_team")+"~"; 
	         	totalruns = totalruns + totalScoreCachedRowSet.getString("runs")+"~"; 
    	     }
        	 /*This logic is use for Total score for Both the team*/
	         String[] idarr = id.split("~");
	         String[] battingteamarr = battingteam.split("~");
	         String[] totalrunsarr = totalruns.split("~");
	         int rowlength = idarr.length;// find out how many inning is over
	         if(rowlength==2){ 
			 	scoreteam1Inning1 = totalrunsarr[0];
			 }else if(rowlength==3){
			 	scoreteam1Inning1 = totalrunsarr[0];
			 	scoreteam2Inning1 = totalrunsarr[1];
			 	if(battingteamarr[1].equals(battingteamarr[2])){
			 		scoreteam2Inning2 = totalrunsarr[2];
			 	}else{
			 		scoreteam1Inning2 = totalrunsarr[2];
			 	}	
			 }else if(rowlength==4){
			 	scoreteam1Inning1 = totalrunsarr[0];
			 	scoreteam2Inning1 = totalrunsarr[1];
			 	if(battingteamarr[1].equals(battingteamarr[2])){
			 		scoreteam2Inning2 = totalrunsarr[2];
			 		scoreteam1Inning2 = totalrunsarr[3];
			 	}else{
			 		scoreteam1Inning2 = totalrunsarr[2];
			 		scoreteam2Inning2 = totalrunsarr[3];
			 	}	
			 }
			}// end of main if
		}// end else;


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>::- ScorerNew -::</title>
<script type="text/javascript">
<!--
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
	hideState('wideplusmenu');
	hideState('wideplussubmenu');
    hideState('noballbatplusmenu');
    hideState('noballbatplussubmenu');
    hideState('morenoballbatplusmenu');
    hideState('morenoballbatplussubmenu');
    hideState('byesplusmenu');
    hideState('byesplussubmenu');
    hideState('legbyesplusmenu');
    hideState('legbyessubmenu');
    hideState('penaltymenu');
    hideState('Dismissalmenu');
    hideState('morerunsmenu');
    hideState('Intervalmenu');
    hideState('extramenu');
    hideState('extrasubmenu');
    hideState('moresixrunsmenu');	
}

//-->
</script>
<link href="../css/csms.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../css/scorermenu.css">
<script language="JavaScript" src="../js/menu.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/wz_jsgraphics.js" 	type="text/javascript"></script>
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
<script language="JavaScript" src="../js/addrow.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/timer.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/fillcmbo.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">    
</head>

<body bottomMargin="0" leftMargin="0" topMargin="0"  rightMargin="0" onLoad="MM_preloadImages('images/DotBall_H.jpg','images/OneRun_H.jpg','images/TwoRuns_H.jpg','images/ThreeRuns_H.jpg','images/FourRuns_H.jpg','images/SixRuns_H.jpg','images/NoBallBallRun_H.jpg','images/NoBallBatRun_H.jpg','images/Wide_H.jpg','images/Byes_H.jpg','images/LegByes_H.jpg','images/PenaltyRuns_H.jpg','images/Wicket_H.jpg','images/Retires_H.jpg','images/ForceEndOver_H.jpg','images/PauseInnings_H.jpg','images/EndInnings_H.jpg','images/SwitchBatsman_H.jpg','images/ChangeBowler_H.jpg','images/OverWicket_H.jpg','images/NewBall_H.jpg','images/PowerPlay_H.jpg','images/Extra_H.jpg','images/Start_H.jpg');checkBrowser();">
<form name="main" id="main" method=""post action="" >
<div style="height:100%;width:100%">
<table width="100%" height="100%%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#bbbbbb">
<tr>
    <td height="45">
    <!-- Top Menu Buttons Start here -->
    
    <!--Top menu Buttons End Here -->
    </td>
</tr>
<tr>
	<td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="218" valign="top">
        <table width="218" border="0" cellspacing="0" cellpadding="0">
          <tr>
			<td>
            <!--WAGON WHEEL TABLE STARTS HERE-->
            <table width="218" border="0" cellspacing="0" cellpadding="0"  background="../images/WagonWheelBG.jpg" >
			<tr>
                <td>&nbsp;</td>
                <td width="139" height="237">
                    <div id="groundCanvas" onclick="showLine(event,'show')">
                    <img src="../images/WagonWheel.jpg" width="218" height="350" id="wagon" border="0" usemap="#wagonwheelmap"/>
                    <map name="wagonwheelmap">
                    <area shape="poly" coords="92,239,83,303,136,303,124,240" alt="Bowler" onclick="callFun.addGround('1');"/>
                    <area shape="poly" coords="89,268,74,348,45,336,24,317,62,247,73,261" alt="Long Off" onclick="callFun.addGround('2');" />
                    <area shape="poly" coords="6,220,55,196,57,235,62,247,24,317,9,290,6,265" alt="Deep Mid Off" onclick="callFun.addGround('3');" />
                    <area shape="poly" coords="55,196,56,146,61,134,8,97,5,114,5,221" alt="Deep Cover" onclick="callFun.addGround('4');" />
                    <area shape="poly" coords="8,98,60,135,72,120,88,110,73,37,33,56" alt="Third Man" onclick="callFun.addGround('5');" />
                    <area shape="poly" coords="163,156,213,156,213,109,209,94,155,126,161,136" alt="Deep Square Leg" onclick="callFun.addGround('6');" />
                    <area shape="poly" coords="129,269,150,258,163,236,190,266,169,294,138,313" alt="Deep Mid On" onclick="callFun.addGround('7');" />
                    <area shape="poly" coords="138,313,145,348,180,332,202,306,211,286,190,266,169,294" alt="Long On" onclick="callFun.addGround('8');" />
                    <area shape="poly" coords="162,236,140,190,123,196,124,242,129,269,150,260" alt="Mid On" onclick="callFun.addGround('9');"/>
                    <area shape="poly" coords="140,190,124,160,123,197" alt="Silly Mid On" onclick="callFun.addGround('10');" />
                    <area shape="poly" coords="124,161,164,157,163,236" alt="Mid Wicket" onclick="callFun.addGround('11');" />
                    <area shape="poly" coords="213,157,213,275,210,287,163,237,164,156" alt="Deep Mid Wicket" onclick="callFun.addGround('12');" />
                    <area shape="poly" coords="123,145,139,137,142,142,144,159,124,161" alt="Short Leg" onclick="callFun.addGround('13');" />
                    <area shape="poly" coords="138,137,155,127,161,136,163,157,143,160,142,142" alt="Square Leg" onclick="callFun.addGround('14');" />
                    <area shape="poly" coords="127,108,123,133,123,146,155,126,144,115" alt="Leg Sleep" onclick="callFun.addGround('15');" />
                    <area shape="poly" coords="56,195,75,183,83,204,92,209,93,239,88,268,73,261,61,248,57,234" alt="Mid Off" onclick="callFun.addGround('16');" />
                    <area shape="poly" coords="75,183,92,156,92,209,82,204" alt="Silly Mid Off" onclick="callFun.addGround('17');" />
                    <area shape="poly" coords="61,135,79,141,78,156,56,160,55,147" alt="Point(Square Cover)" onclick="callFun.addGround('18');" />
                    <area shape="poly" coords="77,156,75,182,55,195,55,160" alt="Silly Mid Off" onclick="callFun.addGround('19');" />
                    <area shape="poly" coords="80,141,93,143,93,156,76,181,76,158" alt="Silly Point" onclick="callFun.addGround('20');" />
                    <area shape="rect" coords="92,145,124,239" alt="Pitch" onclick="callFun.addGround('21');" />
                    <area shape="poly" coords="127,106,141,35,185,56,209,95,155,128,143,116" alt="Deep Fine Leg" onclick="callFun.addGround('22');" />
                    <area shape="poly" coords="93,144,90,109,128,109,122,144" alt="Wicket keeper" onclick="callFun.addGround('23');" />
                    <area shape="poly" coords="61,135,72,119,88,111,93,145" alt="Slips" onclick="callFun.addGround('24');" />
                    <area shape="poly" coords="83,303,135,304,145,350,73,350" alt="Straight Long" onclick="callFun.addGround('25');" />
                    <area shape="poly" coords="72,38,83,34,133,33,142,34,125,110,88,111" alt="Long Stop" onclick="callFun.addGround('26');" />
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
            <table width="218" border="0" cellspacing="0" cellpadding="0" background="../images/PitchBG.jpg">
			<tr>
				<td>&nbsp;</td>
				<td width="139" height="237">
                   <div id="pitchCanvas">
                    <img src="../images/Pitch.jpg" width="139" height="237" border="0" usemap="#pitch" onclick="showCir(event)" />
                    <map name="pitch" >
                    <area shape="rect" coords="21,95,70,126" alt="pitch position 1-1"   onclick="callFun.addPitch('1');" />
                    <area shape="rect" coords="70,95,119,126" alt="pitch position 1-2"  onclick="callFun.addPitch('2');" />
                    <area shape="rect" coords="21,126,70,162" alt="pitch position 2-1"  onclick="callFun.addPitch('3');"/>
                    <area shape="rect" coords="70,125,119,163" alt="pitch position 2-2" onclick="callFun.addPitch('4');" />
                    <area shape="rect" coords="20,162,70,203" alt="pitch position 3-1"  onclick="callFun.addPitch('5');"/>
                    <area shape="rect" coords="70,163,119,203" alt="pitch position 3-2" onclick="callFun.addPitch('6');"/>
                    <area shape="rect" coords="20,202,70,214" alt="pitch position 4-1"  onclick="callFun.addPitch('7');"/>
                    <area shape="rect" coords="70,202,119,214" alt="pitch position 4-2" onclick="callFun.addPitch('8');"/>
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
		    <td><input type="radio" name="bowlerside" id="bowlerside" value="Y" checked="checked"  onclick="callFun.overthewicket('Y');" > Over the wicket
		    	<input type="radio" name="bowlerside" id="bowlerside" value="N" onclick="callFun.overthewicket('N');"> Round the wicket
		    </td>
		<!--LEGEND TABLE END-->
        </tr>
		</table>
        </td>
		<td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center"><img src="../images/BatsmanHeading.jpg" width="524" height="30"></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td>
                    <table width="590" border="1" cellspacing="0" cellpadding="0" id="BATT_TABLE" name="BATT_TABLE" class="lefttd">
                       <tr>
                            <td width="28" bgcolor="#ABA9AA"><img src="../images/BatsmanLeft.jpg" width="6" height="25"><img src="../images/BatsmanNo.jpg" width="22" height="25"></td>
                            <td width="40" bgcolor="#ABA9AA"><img src="../images/BatsmanInTime.jpg" width="40" height="25"></td>
                            <td width="90" bgcolor="#ABA9AA"><img src="../images/BatsmanName.jpg" width="92" height="25"></td>
                            <td width="30" bgcolor="#ABA9AA"><img src="../images/BatsmanOut.jpg" width="27" height="25"></td>
                            <td width="182" bgcolor="#ABA9AA"><img src="../images/BatsmanBowler.jpg" width="95" height="25"></td>
                            <td width="33" bgcolor="#ABA9AA"><img src="../images/BatsmanRuns.jpg" width="33" height="25"></td>
                            <td width="35" bgcolor="#ABA9AA"><img src="../images/BatsmanBalls.jpg" width="35" height="25"></td>
                            <td width="35" bgcolor="#ABA9AA"><img src="../images/BatsmanMins.jpg" width="35" height="25"></td>
                            <td width="24" bgcolor="#ABA9AA"><img src="../images/BatsmanFours.jpg" width="24" height="25"></td>
                            <td width="24" bgcolor="#ABA9AA"><img src="../images/BatsmanSixes.jpg" width="24" height="25"></td>
                            <td width="37" bgcolor="#ABA9AA"><img src="../images/BatsmanSR.jpg" width="32" height="25"><img src="../images/BatsmanRight.jpg" width="5" height="25"></td>
                       </tr>
                      <tr id='<%=BatsMan1Id%>' name='<%=BatsMan1Id%>' class="contentLight" class="lefttd">
                        <td></td>
                        <td align="center" valign="middle" class="lefttd"><img border="0" width="16px" height="16px" src="../images/Clock.jpg"><BR>
							<div style="background:#ADADAD;position:absolute;z-index=2;display:none" id='time_<%=BatsMan1Id%>' name='time_<%=BatsMan1Id%>'><lable id='time<%=BatsMan1Id%>'><lable></div>
						</td>
                        <td id='<%=BatsMan1Name%>' name='<%=BatsMan1Name%>' align="left"><%=BatsMan1Name%></td>
                        <td class="lefttd" align="right" nowrap="nowrap"></td>
                        <td class="lefttd" align="left"></td>
                        <td>0</td>
                        <td>0</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>0.00</td>
                      </tr>
                      <tr id='<%=BatsMan2Id%>' name='<%=BatsMan2Id%>' class="contentDark" >
                        <td></td>
                        <td align="center" valign="middle" class="lefttd"><img border="0" width="16px" height="16px" src="../images/Clock.jpg"><BR>
							<div style="background:#ADADAD;position:absolute;z-index=2;display:none" id='time_<%=BatsMan2Id%>' name='time_<%=BatsMan2Id%>'><lable id='time<%=BatsMan2Id%>'><lable></div>
						</td>
                        <td id='<%=BatsMan2Name%>' name='<%=BatsMan2Name%>' align="left"> <%=BatsMan2Name%></td>
                        <td class="lefttd" align="right" nowrap="nowrap"></td>
                        <td class="lefttd" align="left"></td>
                        <td>0</td>
                        <td>0</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>0.00</td>
                      </tr>
<%
         int i=2;
         while (lobjCachedRowSet.next()) {
         if(lobjCachedRowSet.getString("id").equals(BatsMan1Id) ||lobjCachedRowSet.getString("id").equals(BatsMan2Id)){
         }else{
	     if(i%2==0){
%>
                      <tr id='<%=lobjCachedRowSet.getString("id")%>' name='<%=lobjCachedRowSet.getString("id")%>' class="contentLight">
<%
         } else{
%>

			          <tr id='<%=lobjCachedRowSet.getString("id")%>' name='<%=lobjCachedRowSet.getString("id")%>' class="contentDark">
<%
          }
%>                     <td ></td>

						<td>
							<div style="background:#000000;position:absolute;z-index=2;display:none" id='time_<%=lobjCachedRowSet.getString("id")%>' name='time_<%=lobjCachedRowSet.getString("id")%>'><lable id='time<%=lobjCachedRowSet.getString("id")%>'><lable></div>
						</td>
                        <td id='<%=lobjCachedRowSet.getString("playername").trim()%>' name='<%=lobjCachedRowSet.getString("playername")%>' align="left" class="lefttd">
                            <%=lobjCachedRowSet.getString("playername")%>
                        </td>
                        <td class="lefttd" align="right" nowrap="nowrap"></td>
                        <td class="lefttd" align="left"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td colspan="1"></td>
                      </tr>
                         <input type="hidden" name="hd_match_player_id" id="hd_match_player_id" value='<%=lobjCachedRowSet.getString("match_id")%>'>
					     <input type="hidden" name="hd_team_id" id="hd_team_id" value='<%=lobjCachedRowSet.getString("team_id")%>'>
<%

                i=i+1;
             }
           }
%>
                      <tr class="contentDark">
                        <td></td>
                        <td></td>
                        <td align="Center" class="lefttd">Extras : </td>
                        <td colspan="8" align="center">
                          <span id="Extratotal" name="Extratotal">&nbsp;</span>( <span id="nb" name="nb">&nbsp;</span>
                          nb&nbsp;<span id="w" name="w">&nbsp;</span>w &nbsp;<span id="lb" name="lb">&nbsp;</span>lb&nbsp;<span id="b" name="b">&nbsp;</span>b &nbsp; <span id="open" name="open">&nbsp;</span>pen)
                        </td>
                      </tr>
                      <tr>
                      	<td></td>
                      	<td></td>
                      	<td align="left" class="lefttd" ><label>Total </label></td>
                      	<td colspan="2">
                      		( <span id="batsmanscorerewkt"></span> wickets;<span id="Batstotalover"></span> overs)
                      	</td>
                      	<td id="battotalruns"></td>
                      	<td colspan="6">(<span id="totlarunrate"></span> runs per overs)</td>
                      	
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
                <td align="center"><img src="../images/BowlerHeading.jpg" width="524" height="27"></td>
              </tr>
              <tr>
                <td><table width="590" border="0" align="center" cellpadding="0" cellspacing="0" id="BALL_TABLE">
                   <tr>
                    <td width="34" height="25" bgcolor="#ABA9AA"><img src="../images/BatsmanLeft.jpg" width="6" height="25"><img src="../images/BowlerNo.jpg" width="27" height="25"></td>
                    <td width="100%" height="25" bgcolor="#ABA9AA"><img src="../images/BowlerName.jpg" width="137" height="25"></td>
                    <td width="39" height="25" bgcolor="#ABA9AA"><img src="../images/BowlerOver.jpg" width="39" height="25"></td>
                    <td width="50" height="25" bgcolor="#ABA9AA"><img src="../images/BowlerMaiden.jpg" width="50" height="25"></td>
                    <td width="47" height="25" bgcolor="#ABA9AA"><img src="../images/BowlerRuns.jpg" width="47" height="25"></td>
                    <td width="55" height="25" bgcolor="#ABA9AA"><img src="../images/BowlerWickets.jpg" width="55" height="25"></td>
                    <td width="34" height="25" bgcolor="#ABA9AA"><img src="../images/BowlerWides.jpg" width="34" height="25"></td>
                    <td width="34" height="25" bgcolor="#ABA9AA"><img src="../images/BowlerNoBalls.jpg" width="40" height="25"></td>
                    <td width="33" height="25" bgcolor="#ABA9AA"><img src="../images/BowlerSR.jpg" width="33" height="25"></td>
                    <td width="55" height="25" bgcolor="#ABA9AA"><img src="../images/BowlerEco.jpg" width="48" height="25"><img src="../images/BatsmanRight.jpg" width="5" height="25"></td>
                  </tr>
                  <tr  id="<%=BowlerId%>" name="<%=BowlerId%>" class="contentLight" >
                    <td></td>
                    <td align="left" class="lefttd" alt="bhushan"><%=BowlerName%></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                  </tr>
				<script>
              	for( var i=0; i<10; i++ ){
					document.writeln( "<tr class='"+ (i%2!=0? 'contentLight' : 'contentDark') +"'>" );
					document.writeln( "<td>&nbsp;</td>" );
					document.writeln( "<td align='left' class='lefttd'>&nbsp;</td>" );
					document.writeln( "<td>&nbsp;</td>" );
					document.writeln( "<td>&nbsp;</td>" );
					document.writeln( "<td>&nbsp;</td>" );
					document.writeln( "<td>&nbsp;</td>" );
					document.writeln( "<td>&nbsp;</td>" );
					document.writeln( "<td>&nbsp;</td>" );
					document.writeln( "<td>&nbsp;</td>" );
					document.writeln( "<td>&nbsp;</td>" );
					document.writeln( "</tr>" );
              	}
              </script>
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
                    <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd" id="No11"><b>Batsman A<b></td>
                    <td background="../images/ScoreBoardReading.jpg" width="56" height="26" class="totallefttd" id="No1" name="No1"></td>
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
                    <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd" id="No22"><b>Batsman B</b></td>
                    <td background="../images/ScoreBoardReading.jpg" width="56" height="26" id="No2" name="No2" class="totallefttd" >&nbsp;</td>
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
                    <td background="../images/ScoreBoardReading.jpg" width="56" height="26" id="total" name="total" class="totallefttd">&nbsp;</td>
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
                    <td background="../images/ScoreBoardReading.jpg" width="56" height="26" name="lastMan" id="lastMan" class="totallefttd">&nbsp;</td>
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
                  <td background="../images/ScoreBoardReading.jpg" width="56" height="26" name="Wickt" id="Wickt" class="totallefttd">&nbsp;</td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd"><b>Overs</b></td>
                  <td background="../images/ScoreBoardReading.jpg" width="56" height="26" id="SBOver" name="SBOver" class="totallefttd">&nbsp;</td>
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
                  <td background="../images/ScoreBoardReading.jpg" width="56" height="26" name="lstWicket" id="lstWicket" class="totallefttd">&nbsp;</td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd"><b>Runs Req</b></td>
                  <td background="../images/ScoreBoardReading.jpg" width="56" height="26" id="runreq" name="runreq" class="totallefttd">&nbsp;</td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardName.jpg" width="113" height="26" class="totallefttd"><b>Remaining</b></td>
                  <td background="../images/ScoreBoardReading.jpg" width="56" height="26" id="RemOver" name="RemOver" class="totallefttd">&nbsp;</td>
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
                  <td background="../images/ScoreBoardTeamName.jpg" width="86" height="26">&nbsp;</td>
                  <td background="../images/ScoreBoardScore1.jpg" width="39" height="26"><%=scoreteam1Inning1%></td>
                  <td width="7" height="26"><img src="../images/ScoreBoardCenter.jpg" width="7" height="26"></td>
                  <td background="../images/ScoreBoardScore2.jpg"  width="39" height="26"><%=scoreteam1Inning2%></td>
                  <td align="right" width="19" height="26"><img src="../images/ScoreBoardRight.jpg" width="19" height="26"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="5" height="26"><img src="../images/ScoreBoardTeamLeft.jpg" width="5" height="26"></td>
                  <td background="../images/ScoreBoardTeamName.jpg" width="86" height="26"><%=scoreteam2Inning1%></td>
                  <td background="../images/ScoreBoardScore1.jpg" width="39" height="26"></td>
                  <td width="7" height="26"><img src="../images/ScoreBoardCenter.jpg" width="7" height="26"></td>
                  <td background="../images/ScoreBoardScore2.jpg" width="39" height="26"><%=scoreteam2Inning2%></td>
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
            <td><img src="../images/LastTen.jpg" width="193" height="19"></td>
        </tr>
        <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="../images/LastOver.jpg" width="26" height="31"></td>
                <td><img src="../images/LastBowler.jpg" width="41" height="31"></td>
                <td> <img src="../images/LastRun.jpg" width="30" height="31"></td>
                <td><img src="../images/LastWicket.jpg" width="51" height="31"></td>
                <td><img src="../images/LastTotal.jpg" width="45" height="31"></td>
              </tr>
              <tr>
                <td class="contentLastLight"><span id="over1">&nbsp;</span></td>
                <td class="contentLastLight"><span id="bwlr1">&nbsp;</span></td>
                <td class="contentLastLight"><span id="runs1">&nbsp;</span></td>
                <td class="contentLastLight"><span id="wkt1">&nbsp;</span></td>
                <td class="contentLastLight"><span id="total1">&nbsp;</span></td>
              </tr>
              <tr>
                <td class="contentLastDark"><span id="over2">&nbsp;</span></td>
                <td class="contentLastDark"><span id="bwlr2">&nbsp;</span></td>
                <td class="contentLastDark"><span id="runs2">&nbsp;</span></td>
                <td class="contentLastDark"><span id="wkt2">&nbsp;</span></td>
                <td class="contentLastDark"><span id="total2">&nbsp;</span></td>
              </tr>
              <tr>
                <td class="contentLastLight"><span id="over3">&nbsp;</span></td>
                <td class="contentLastLight"><span id="bwlr3">&nbsp;</span></td>
                <td class="contentLastLight"><span id="runs3">&nbsp;</span></td>
                <td class="contentLastLight"><span id="wkt3">&nbsp;</span></td>
                <td class="contentLastLight"><span id="total3">&nbsp;</span></td>
              </tr>
              <tr>
                <td class="contentLastDark"><span id="over4">&nbsp;</span></td>
                <td class="contentLastDark"><span id="bwlr4">&nbsp;</span></td>
                <td class="contentLastDark"><span id="runs4">&nbsp;</span></td>
                <td class="contentLastDark"><span id="wkt4">&nbsp;</span></td>
                <td class="contentLastDark"><span id="total4">&nbsp;</span></td>
              </tr>
              <tr>
				<td class="contentLastLight"><span id="over5">&nbsp;</span></td>
                <td class="contentLastLight"><span id="bwlr5">&nbsp;</span></td>
                <td class="contentLastLight"><span id="runs5">&nbsp;</span></td>
                <td class="contentLastLight"><span id="wkt5">&nbsp;</span></td>
                <td class="contentLastLight"><span id="total5">&nbsp;</span></td>
              </tr>
              <tr>
                <td class="contentLastDark"><span id="over6">&nbsp;</span></td>
                <td class="contentLastDark"><span id="bwlr6">&nbsp;</span></td>
                <td class="contentLastDark"><span id="runs6">&nbsp;</span></td>
                <td class="contentLastDark"><span id="wkt6">&nbsp;</span></td>
                <td class="contentLastDark"><span id="total6">&nbsp;</span></td>
              </tr>
              <tr>
                <td class="contentLastLight"><span id="over7">&nbsp;</span></td>
                <td class="contentLastLight"><span id="bwlr7">&nbsp;</span></td>
                <td class="contentLastLight"><span id="runs7">&nbsp;</span></td>
                <td class="contentLastLight"><span id="wkt7">&nbsp;</span></td>
                <td class="contentLastLight"><span id="total7">&nbsp;</span></td>
              </tr>
              <tr>
                <td class="contentLastDark"><span id="over8">&nbsp;</span></td>
                <td class="contentLastDark"><span id="bwlr8">&nbsp;</span></td>
                <td class="contentLastDark"><span id="runs8">&nbsp;</span></td>
                <td class="contentLastDark"><span id="wkt8">&nbsp;</span></td>
                <td class="contentLastDark"><span id="total8">&nbsp;</span></td>
              </tr>
              <tr>
                <td class="contentLastLight"><span id="over9">&nbsp;</span></td>
                <td class="contentLastLight"><span id="bwlr9">&nbsp;</span></td>
                <td class="contentLastLight"><span id="runs9">&nbsp;</span></td>
                <td class="contentLastLight"><span id="wkt9">&nbsp;</span></td>
                <td class="contentLastLight"><span id="total9">&nbsp;</span></td>
              </tr>
              <tr>
                <td class="contentLastDark"><span id="over10">&nbsp;</span></td>
                <td class="contentLastDark"><span id="bwlr10">&nbsp;</span></td>
                <td class="contentLastDark"><span id="runs10">&nbsp;</span></td>
                <td class="contentLastDark"><span id="wkt10">&nbsp;</span></td>
                <td class="contentLastDark"><span id="total10">&nbsp;</span></td>
              </tr>
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
<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv">
</div>

<div id="PopupDiv" class="popupdiv">
</div>
<div id="BatList" name="BatList" class="divlist">
<table align="center" >
	<tr>
		<td colspan="2">New Batsman  List</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>	
	</tr>
	<tr>
		<td>Select Batsman :</td>
		<td><select name="selbat" id="selbat">
			<option value="">--Select Batsman Name--</option>
<%
			while(newBatsmanCachedRowSet.next()){
			if(BatsMan1Id.equalsIgnoreCase(newBatsmanCachedRowSet.getString("id")) || BatsMan2Id.equalsIgnoreCase(newBatsmanCachedRowSet.getString("id"))){
			}else{	
%>
			<option value="<%=newBatsmanCachedRowSet.getString("id")+"~"+newBatsmanCachedRowSet.getString("playername")%>"><%=newBatsmanCachedRowSet.getString("playername")%></option>
<%
			}// end of else
			}
%>
		</select></td>
	</tr>
	<tr>
		<td colspan="2" align="center">&nbsp;<input type="hidden" name="popupid" id="popupid" value=""></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="button" align="center"
			id="btnbatsubmit" name="btnbatsubmit" value="Submit"
			onclick="insRow('BATT_TABLE');callFun.hideblockmaindiv('BackgroundDiv');"></input>
		</td>
	</tr>
</table>
</div>
<div id="BowlList" name="BowlList" class="bowlerdivlist">
<table align="center">
	<tr>
		<td colspan="2">New Bowler List</td>
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
				value='<%=bowlerCachedRowSet.getString("playername")+'~'+ bowlerCachedRowSet.getString("id")%>'><%=bowlerCachedRowSet.getString("playername")%></option>
			<%
					}
%>
		</select></td>
	</tr>
	<tr>
		<td colspan="2" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="button" align="center"
			id="btnsubmit" name="btnsubmit" value="Submit"
			onclick="ballObj.getLastTenOvers();addRow('BALL_TABLE')"></input></td>
	</tr>
</table>
</div>
<div id="remarkList" name="remarkList" class="divlist">
	<table align="center">
		<tr>
			<td colspan="2" align="center"> Remark  
			</td>
		</tr>
		<tr>
			<td>Enter Remark :</td>
			<td><textarea NAME="txtremark" id="txtremark" ROWS="2" COLS="20"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Add Remark" 	onclick="callFun.getRemark();callFun.closeBowlList('remarkList')"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancle" onclick="callFun.closeBowlList('remarkList')"></input>
			</td>
		</tr>
	</table>
</div>
<div id="penaltyremarkList" name="penaltyremarkList" class="divlist">
	<table align="center">
		<tr>
			<td colspan="2" align="center"> Remark  
			</td>
		</tr>
		<tr>
			<td>Enter Remark :</td>
			<td><textarea NAME="txtpenaltyremark" id="txtpenaltyremark" ROWS="2" COLS="20"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Add Remark" 	onclick="callFun.getRemark();closePopup('BackgroundDiv','penaltyremarkList')"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancle" onclick="closePopup('BackgroundDiv','penaltyremarkList')"></input>
			</td>
		</tr>
	</table>
</div>
<div id="swapBowlerRemarkList" name="swapBowlerRemarkList" class="divlist">
	<table align="center">
		<tr>
			<td colspan="2" align="center"> Remark  
			</td>
		</tr>
		<tr>
			<td>Enter Remark :</td>
			<td><textarea NAME="txtbowlerremark" id="txtbowlerremark" ROWS="2" COLS="20"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Add Remark" 	onclick="callFun.getswapBowlerRemark();callFun.closeBowlList('swapBowlerRemarkList')"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancle" onclick="closePopup('BackgroundDiv','swapBowlerRemarkList')"></input>
			</td>
		</tr>
	</table>
</div>
<div id="retireRemarkList" name="retireRemarkList" class="divlist">
	<table align="center">
		<tr>
			<td colspan="2" align="center"> Remark  
			</td>
		</tr>
		<tr>
			<td>Enter Remark :</td>
			<td><textarea NAME="txtretireremark" id="txtretireremark" ROWS="2" COLS="20"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" align="center" id="btnsubmit" name="btnsubmit" value="Add Remark" 	onclick="callFun.getretired();callFun.closeBowlList('retireRemarkList')"></input>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input align="center" type="button" value="Cancle" onclick="callFun.closeBowlList('retireRemarkList')"></input>
			</td>
		</tr>
	</table>
</div>
<div id="landmark" name="landmark" class="divlist">
	<table width="100%">
		<tr>
			<td><center><font style="color:red"><span id="landmarkrun" name="landmarkrun"></span></font></center></td>
		</tr>
		<br>
		<br>
		<tr>
			<td><center><input align="center" type="button" value="Close" onclick="closePopup('BackgroundDiv','landmark')"></center></input>
		</tr>
	</table>
</div>
<div id="wagondiv" id="wagondiv" class="divwagon" >
</div>
<div style="display:none">
	<input type="hidden" name="hdbatsmanstriker" id="hdbatsmanstriker" value="1">
	<input type="hidden" name="hdbatsmannonstriker" id="hdbatsmannonstriker" value="2">
	<input type="hidden" name="hdbowlerstriker" id="hdbowlerstriker" value="1">
	<input type="hidden" id="hidOvers" name="hidOvers" value="">	
	<input type="hidden" name="hdtotalcount" id="hdtotalcount" value="0">
	<input type="hidden" name="hdscorercardstriker" id="hdscorercardstriker" value="No1">
	<input type="hidden" name="hdscorercardnonstriker" id="hdscorercardnonstriker" value="No2">
	<input type="hidden" id="hidstrikerbowler" name="hidstrikerbowler" value="0">
	<input type="hidden" name="hdmatchtime" id="hdmatchtime" value="0">
</div>
<!-- This is for demo purpose Score card -->

</div>
</form>
</body>
<% } catch (Exception e) {
    e.printStackTrace();
}
%>
</html>
