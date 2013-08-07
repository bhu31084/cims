<%@ page import="sun.jdbc.rowset.CachedRowSet,
         in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
         java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"	
         %>
<%  response.setHeader("Cache-Control", "private");
            response.setHeader("Pragma", "private");
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Cache-Control", "must-revalidate");
            response.setHeader("Pragma", "must-revalidate");
            response.setDateHeader("Expires", 0);
%>

<%   //cachedrowset declaration
            CachedRowSet officialScoresheetCrs = null;
            CachedRowSet matchHatTrickCrs = null;
            CachedRowSet inningIdCrs = null;
            CachedRowSet officialResultCrs = null;
            CachedRowSet refereeIdCrs = null;            

            Vector vparam = new Vector();

// variable declaration
            String tournamentName = "";
            String matchNo = "";
            String zone = "";
            String teamOne = "";
            String teamTwo = "";
            String toss = "";
            String ground = "";
            String city = "";
            String date = "";
            String result = "";
            String umpireOne = "";
            String umpireTwo = "";
            String umpireThree = "";
            String umpireFour = "";
            String matchReferee = "";
            String scorerOne = "";
            String scorerTwo = "";
            String captainOne = "";
            String captainTwo = "";
            String wicketKeeperOne = "";
            String wicketKeeperTwo = "";
            String decision = "";
            String point = "";
            String hatTrickBowler = "";
            String victim = "";
            String inningIdOne = "";
            String inningIdTwo = "";
            String inningIdThree = "";
            String inningIdFour = "";            
            String matchWinner = "";
            String umpireOneAsscn = "";
            String umpireTwoAsscn = "";
            String umpireThreeAsscn = "";
            String umpireFourAsscn = "";
            String teamBattingFirst = "";
            String matchRefassn = "";
            String electedto = "";
            String isPrint = "";
            String firstInningName = "";
            String firstinningbattingteam = "";
            String secondinningbattingteam = "";
            String matchId = "";
            String remarks = "";
            String refereeId = "";
            String userId = "";
            String hid = "";
            String userRoleId = "";
            String userRole = "";
            String resultPoint = "";
			String totalMatchTime = "";
			String testmatchInningsId ="";
            String flag = "";
            String[] refereeIDArr = null;
            boolean refereeFlag = false;
			Long timeBeforePageExecute = null;
			Long timeAfterPageExecute = null;
%>
<%  	timeBeforePageExecute = System.currentTimeMillis();
		System.out.println("timeBeforePageExecute" +timeBeforePageExecute);
%>
<%          long timeBefore = System.currentTimeMillis();
            session.setAttribute("starttime", timeBefore);
            matchId = (String) session.getAttribute("matchid");
            userId = (String) session.getAttribute("userid");
            userRole = session.getAttribute("role").toString();
            GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
            LogWriter log = new LogWriter();
            vparam.add(matchId);
            inningIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getInningIdForTest", vparam, "ScoreDB");
            vparam.removeAllElements();
            if (inningIdCrs != null) {
                try {
                    while (inningIdCrs.next()) {
                        inningIdOne = inningIdCrs.getString("inn1") != null ? inningIdCrs.getString("inn1") : "";
                        inningIdThree = inningIdCrs.getString("inn2") != null ? inningIdCrs.getString("inn2") : "";                        
                        inningIdTwo = inningIdCrs.getString("inn3") != null ? inningIdCrs.getString("inn3") : "";                        
                        inningIdFour = inningIdCrs.getString("inn4") != null ? inningIdCrs.getString("inn4") : "";
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                } finally {
                    inningIdCrs = null;
                }
            }
%>
<%  // check referee for match
            vparam.add(matchId);
            vparam.add("");
            vparam.add("3");
            refereeIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpireid", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (refereeIdCrs != null) {
                    while (refereeIdCrs.next()) {
                        refereeId = refereeId + refereeIdCrs.getString("id") + "~";
                        refereeIDArr = refereeId.split("~");
                    }
                }                
                if (refereeIDArr != null) {
                    for (int i = 0; i < refereeIDArr.length; i++) {
                        if (userId.equals(refereeIDArr[i])) {
                            refereeFlag = true;
                        }
                    }
                }                
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
%>	
<%//To Get UserRoleId
            vparam.add("");
            vparam.add(userId);
            vparam.add("2");
            refereeIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpireid", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (refereeIdCrs != null) {
                    while (refereeIdCrs.next()) {
                        userRoleId = refereeIdCrs.getString("user_role_id") != null ? refereeIdCrs.getString("user_role_id") : "";
                    }
                }                
            } catch (Exception e) {                
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
%>
<%// Make entry in wfitem
            try {
                hid = request.getParameter("hid") != null ? request.getParameter("hid") : "";
                if (userRole.equals("4") && refereeFlag == true) {
                    if (!(hid.equalsIgnoreCase("1"))) {                        
                        vparam.add("5");//wftypes of scoresheet
                        vparam.add("2");//doctype overrate calculation
                        vparam.add(userRoleId);//actor
                        vparam.add("");
                        vparam.add("");
                        vparam.add("");
                        vparam.add("");
                        vparam.add("");
                        vparam.add("");
                        vparam.add(matchId);
                        vparam.add("0");
                        vparam.add(userRole);
                        vparam.add("");
                        refereeIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scoresheetworkflow", vparam, "ScoreDB");
                        vparam.removeAllElements();
                        if (refereeIdCrs != null) {
                            while (refereeIdCrs.next()) {
                                remarks = refereeIdCrs.getString("Retval") != null ? refereeIdCrs.getString("Retval") : "";
                                flag = refereeIdCrs.getString("flag") != null ? refereeIdCrs.getString("flag") : "";
                            }
                        }                        
                    }
                }                
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
%>
<%// code to send report for approval 	
            try {
                hid = request.getParameter("hid") != null ? request.getParameter("hid") : "";
                if (userRole.equals("4") && refereeFlag == true) {
                    if (hid != null && hid.equalsIgnoreCase("1")) {
                        remarks = request.getParameter("refereeRemark") != null ? request.getParameter("refereeRemark") : "";                        
                        vparam.add("5");//wftypes of scoresheet
                        vparam.add("2");//doctype overrate calculation
                        vparam.add(userRoleId);//actor
                        vparam.add("");
                        vparam.add("");
                        vparam.add("");
                        vparam.add("");
                        vparam.add("");
                        vparam.add("");
                        vparam.add(matchId);
                        vparam.add("1");
                        vparam.add(userRole);
                        vparam.add(remarks);
                        refereeIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scoresheetworkflow", vparam, "ScoreDB");
                        vparam.removeAllElements();
                        if (refereeIdCrs != null) {
                            while (refereeIdCrs.next()) {
                                remarks = refereeIdCrs.getString("Retval") != null ? refereeIdCrs.getString("Retval") : "";
                                flag = refereeIdCrs.getString("flag") != null ? refereeIdCrs.getString("flag") : "";
                            }
                        }                        
                    }
                }                
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
%>
<%			vparam.add(matchId);
            officialScoresheetCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialscoresheetfortest", vparam, "ScoreDB");
            vparam.removeAllElements();
            if (officialScoresheetCrs != null) {
                try {
                    while (officialScoresheetCrs.next()) {
                        tournamentName = officialScoresheetCrs.getString("tournament") != null ? officialScoresheetCrs.getString("tournament") : "";
                        //matchNo 			 = officialScoresheetCrs.getString("match_no")!=null?officialScoresheetCrs.getString("match_no"):"";
                        electedto = officialScoresheetCrs.getString("electedto") != null ? officialScoresheetCrs.getString("electedto") : "";
                        zone = officialScoresheetCrs.getString("zone") != null ? officialScoresheetCrs.getString("zone") : "";
                        teamOne = officialScoresheetCrs.getString("team1") != null ? officialScoresheetCrs.getString("team1") : "";
                        teamTwo = officialScoresheetCrs.getString("team2") != null ? officialScoresheetCrs.getString("team2") : "";
                        toss = officialScoresheetCrs.getString("tosswinner") != null ? officialScoresheetCrs.getString("tosswinner") : "";
                        ground = officialScoresheetCrs.getString("ground") != null ? officialScoresheetCrs.getString("ground") : "";
                        city = officialScoresheetCrs.getString("city") != null ? officialScoresheetCrs.getString("city") : "";
                        date = officialScoresheetCrs.getString("start_date") != null ? officialScoresheetCrs.getString("start_date") : "";
                        matchWinner = officialScoresheetCrs.getString("match_winner") != null ? officialScoresheetCrs.getString("match_winner") : "";
                        //result			 = officialScoresheetCrs.getString("result")!=null?officialScoresheetCrs.getString("result"):"";
                        umpireOne = officialScoresheetCrs.getString("umpire1") != null ? officialScoresheetCrs.getString("umpire1") : "";
                        umpireTwo = officialScoresheetCrs.getString("umpire2") != null ? officialScoresheetCrs.getString("umpire2") : "";
                        umpireThree = officialScoresheetCrs.getString("umpire3") != null ? officialScoresheetCrs.getString("umpire3") : "";
                        umpireFour = officialScoresheetCrs.getString("umpire4") != null ? officialScoresheetCrs.getString("umpire4") : "";
                        matchReferee = officialScoresheetCrs.getString("matchref") != null ? officialScoresheetCrs.getString("matchref") : "";
                        scorerOne = officialScoresheetCrs.getString("scorer1") != null ? officialScoresheetCrs.getString("scorer1") : "";
                        scorerTwo = officialScoresheetCrs.getString("scorer2") != null ? officialScoresheetCrs.getString("scorer2") : "";
                        captainOne = officialScoresheetCrs.getString("captain1") != null ? officialScoresheetCrs.getString("captain1") : "";
                        captainTwo = officialScoresheetCrs.getString("captain2") != null ? officialScoresheetCrs.getString("captain2") : "";
                        wicketKeeperOne = officialScoresheetCrs.getString("wkeeper1") != null ? officialScoresheetCrs.getString("wkeeper1") : "";
                        wicketKeeperTwo = officialScoresheetCrs.getString("wkeeper2") != null ? officialScoresheetCrs.getString("wkeeper2") : "";                        
                        umpireOneAsscn = officialScoresheetCrs.getString("umpire1assn") != null ? officialScoresheetCrs.getString("umpire1assn") : "";                        
                        umpireTwoAsscn = officialScoresheetCrs.getString("umpire2assn") != null ? officialScoresheetCrs.getString("umpire2assn") : "";
                        umpireThreeAsscn = officialScoresheetCrs.getString("umpire3assn") != null ? officialScoresheetCrs.getString("umpire3assn") : "";
                        umpireFourAsscn = officialScoresheetCrs.getString("umpire4assn") != null ? officialScoresheetCrs.getString("umpire4assn") : "";
                        matchRefassn = officialScoresheetCrs.getString("matchrefassn") != null ? officialScoresheetCrs.getString("matchrefassn") : "";
                        teamBattingFirst = officialScoresheetCrs.getString("battingteam") != null ? officialScoresheetCrs.getString("battingteam") : "";
                        point = officialScoresheetCrs.getString("point") != null ? officialScoresheetCrs.getString("point") : "";                        
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                } finally {
                    officialScoresheetCrs = null;
                }
            }
%>
<%	 vparam.add(matchId);
            officialResultCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_reportresult", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (officialResultCrs != null) {
                    while (officialResultCrs.next()) {
                        result = officialResultCrs.getString("result") != null ? officialResultCrs.getString("result") : "";
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
%>
<%          vparam.add(matchId);
            vparam.add("");
            vparam.add("1");
            officialResultCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_resultpoint", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {                
                if (officialResultCrs != null) {
                    while (officialResultCrs.next()) {
                        resultPoint = officialResultCrs.getString("result") != null ? officialResultCrs.getString("result") : "0";
                    }
                }
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title> </title>  
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
    <link rel="stylesheet" type="text/css" href="../css/menu.css">    
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">  
	<script language="javascript" src="../js/xp_progress.js"></script>
    <script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>  
     <script>
		function RefreeApprove(){
			var remark 			= document.getElementById('refereeRemark').value;
			var remarkLength	= remark.length;
			if (remarkLength > 255){
			alert("Remark Length should be less than 255 characters");
			return false;
		}
			document.getElementById('hid').value = 1;
			document.TestSchoreSheet.submit();
		}
	</script>
	 <script>
			// load progress bar
			var windowHandle = null;
			windowHandle =  window.open("/cims/jsp/ProgressBar.jsp","ProgressBar","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,titlebar = no,hotkeys=no,alwaysRaised=yes,z-lock=true,top=300,left=100,width =300,height = 50,visible =false,status=0");
			function window_popup()
			{
			  windowHandle =  window.open("/cims/jsp/ProgressBar.jsp","ProgressBar","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,titlebar = no,hotkeys=no,alwaysRaised=yes,z-lock=true,top=300,left=100,width =400,height = 50,visible =false,status=0");
			}
			
			function refreshpage(){
				document.TestSchoreSheet.action ="/cims/jsp/TestMatchScoreSheetVersion3.jsp";
				document.TestSchoreSheet.submit();
			}
     </script>
	
    <STYLE TYPE="text/css">
        P.breakhere {page-break-before: always}
        .styling{
                   background-color:black;
                   color:red;
                   font: bold 24px MS Sans Serif;
                   padding:6px
           }
    </STYLE>
</head>
<body>
<%  isPrint = request.getParameter("isprint") != null ? request.getParameter("isprint") : "";
//isPrint = "true";
    if (!(isPrint.equalsIgnoreCase("show"))) {
%>
<%--<jsp:include page="Menu.jsp" />
//Added refresh button by Archana and gave link to the Back button on ReportMain.jsp
--%><div align=left>Page Setup: Landscape,Legal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/cims/jsp/ReportMain.jsp"><b>BACK</b></a></div><center> <%=matchId%> <input type=button value="Print" onClick='window.open("/cims/jsp/TestMatchScoreSheetVersion3.jsp?isprint=show","CIMS","location=no,directories=no,status=Yes,menubar=Yes,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth-20)+",height="+(window.screen.availHeight-30))'>&nbsp;<input type=button value="Refresh" onClick="refreshpage();"></center>

<div align=left><font color=red><%=remarks%></font></div>
<%	}
%>	
<center>
    <span id = "a" class = "styling"></span>
</center>
<form name="TestSchoreSheet" id="TestSchoreSheet">
<input type=hidden name="hid" id="hid" value=""/>
<font align=left> </font>
<center><font color="#003399" size=2>THE BOARD OF CONTROL FOR CRICKET IN INDIA</font> </b></center>
<table border="0" cellpadding="4" cellspacing="0" width="100%" bordercolor="#111111" style="border-collapse: collapse" border="1">
<div> 
<table cellspacing=1 align=center height=10% width="100%" style=border-collapse:collapse border=1 >
<tr class=firstrow>
    <td align=left nowrap width="1%"><font size=1>TOURNAMENT/VISTING TEAM</td>
    <td align=left nowrap width="1%"><font color="#003399" size=1><b> <%=tournamentName%></b></font></td>
    <td align=left nowrap width="1%"><font size=1>MATCH BETWEEN </font><font color="#003399" size=1>&nbsp;<b><%=teamOne%></b></font> <font size=1>AND </font><font color="#003399" size=1><b><%=teamTwo%></b></font></td>
    <td align=left nowrap width="1%"><font size=1>PLAYED ON </font></td>
    <td align=left nowrap width="1%"><font color="#003399" size=1><b><%=date%></b></td>
</tr>	 
<tr class=firstrow>
    <td align=left nowrap width="1%"><font size=1>PLAYED AT GROUND/STADIUM</td>
    <td align=left nowrap width="1%"><font color="#003399" size=1><b><%=ground%></b> </td>
    <td align=left nowrap width="1%"><font size=1>CITY</font> <font color="#003399" size=1>&nbsp;<b><%=city%></b> </td>
    <td align=left nowrap width="1%"><font size=1>TOSS WON BY</font> <font color="#003399" size=1>&nbsp;<b><%=toss%></b> </td>
    <td align=left nowrap width="1%"><font size=1>AND ELECTED TO </font><font color="#003399" size=1><b><%=electedto%></b> </td>
</tr>
<tr class=firstrow>
    <td align=left nowrap width="1%"><font size=1>RESULT</td>
    <% if (resultPoint.equals("0")) {
    %>	<td align=center nowrap width="1%"><font color="#003399" size=1>--</td>
    <%} else {%>
    <td align=left nowrap width="1%"><font color="#003399" size=1><b><%=result%></b></td>
    <%}%>
    <td align=left nowrap width="1%"><font size=1>[POINT <font color="#003399" size=1><b><%=point%></b></font>]</td>
    <td align=left nowrap width="1%"><font size=1>1.UMPIRES: Mr&nbsp;&nbsp;</font><font color="#003399" size=1><b><%=umpireOne%></b></td>
    <td align=left nowrap width="1%"><font size=1>3.UMPIRES: Mr&nbsp;&nbsp;</font><font color="#003399" size=1><b><%=umpireThree%></b></td>
    <%--<td align=center nowrap width="1%"><font size=1>ASSOCIATION</td>
                                                                        <td align=center nowrap width="1%"><font color="#003399"><font color="#003399"><%=umpireOneAsscn%></td>
    --%>
</tr>
<tr class=firstrow>
<td align=left nowrap width="1%"><font size=1>CAPTAIN&nbsp;</td>
<td align=left nowrap width="1%"><font color="#003399" size=1><b><%=captainOne%> &nbsp;</font>&</b>&nbsp;<font color="#003399" size=1><b><%=captainTwo%></b></td>
<td align=left nowrap width="1%"><font size=1>REFEREE : Mr</font><font color="#003399" size=1>&nbsp;<b><%=matchReferee%></b></b></td>
<td align=left nowrap width="1%"><font size=1>2.UMPIRES: Mr&nbsp;&nbsp;</font><font color="#003399" size=1><b><%=umpireTwo%></b></td>
<td align=left nowrap width="1%"><font size=1>4.UMPIRE COACH: Mr&nbsp;&nbsp;</font><font color="#003399" size=1><b><%=umpireFour%></b></td>
<%--<td align=center nowrap width="1%"><font size=1>ASSOCIATION</td>
                                                                                <td align=left nowrap width="1%"><font color="#003399"><%=umpireTwoAsscn%></td>
--%>
</tr>
<tr class=firstrow>
    <td align=left nowrap width="1%"><font size=1>WICKET KEEPERS&nbsp;</td>
    <td align=left nowrap width="1%"><font color="#003399" size=1><b><%=wicketKeeperOne%></b> &nbsp;</font><b>&</b>&nbsp;<font color="#003399" size=1><b><%=wicketKeeperTwo%></b></td>
    <%--<td align=center nowrap width="1%"><font size=1>REF ASSOCIATION</td>
                                                                        <td align=center nowrap width="1%"><font color="#003399"><%=matchRefassn%></td>
    --%>
    <td align=left nowrap width="1%">&nbsp;</td>
    <td align=left nowrap width="1%">&nbsp;</td>
    <td align=left nowrap width="1%">&nbsp;</td>
</tr>
</table>
</div>
<br>
<% try {
                if (electedto.equalsIgnoreCase("Bat")) {
                    firstInningName = toss;
                }
                if (firstInningName.equalsIgnoreCase(teamOne)) {
                    firstinningbattingteam = teamOne;
                    secondinningbattingteam = teamTwo;
                } else {
                    secondinningbattingteam = teamOne;
                    firstinningbattingteam = teamTwo;
                }
                session.setAttribute("firstinningbattingteam", firstinningbattingteam);
                session.setAttribute("secondinningbattingteam", secondinningbattingteam);
            } catch (Exception e) {
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
%>								
<%--Main <TABLE> and <DIV> for batting first start here	--%>
<div id="teamOneBatting">
    
</div>

<%-- Main <Table> and <DIV> for batting  first ends here--%>
<br>
<P CLASS="breakhere">
<div id="teamTwoBatting">
</div>
<%-- Main <Table> and <DIV> for batting  second ends here--%>
<br>
<P CLASS="breakhere">
<table height=0.1%>
    <tr>
        <td><b><%=firstinningbattingteam%> 1st Inning</b></td>
    </tr>	
</table>
<div id="teamOneFirstInning"> 
</div>	
<br>
<div id="teamOneFirstInningHundred"> 
</div>
<br>
<table height=0.1%>
    <tr>
        <td><b><%=firstinningbattingteam%> 2nd Inning</b></td>
    </tr>	
</table>
<div id="teamOneSecondInning"> 
</div>
<br>
<div id="teamOneSecondInningHundred"> 
</div>
<br>								
<%-- Main <Table> and <DIV> for hundred partnership end here--%>
</table><!--first table tag end here-->
<br>
<div>	
    <table width=100% border=1>
        <tr>
            <td align=center>
                <table border="1" width=100%  style=border-collapse:collapse>
					<tr>
						<td colspan=10>SCORES AT END OF DAY</td>
					</tr>
                    <tr class=firstrow>
                        <td align=center><font size=1>Inning</font></td>
                        <td align=center><font size=1>Start Time</font></td>
                        <td align=center><font size=1>End Time</font></td>
                        <td align=center>
                            <table border=1 width=50%>
                                <tr>
                                    <td colspan=2>
                                        <font size=1>Stoppages</font>
                                    </td>
                                </tr>		
                                <tr>
                                    <td>
                                        <font size=1>Time</font>
                                    </td>
                                    <td>
                                        <font size=1>Mins</font>
                                    </td>
                                </tr>		
                            </table>	
                        </td>
                   
                        <td align=center><font size=1>Over Lost</font></td>
                        <td align=center><font size=1>Reason</font></td>
                        <td align=center><font size=1>Team</font></td>
                        <td align=center><font size=1>Score<br>(Runs/Wkts/Overs/Mins)</font></td>
                        <td align=center><font size=1>Batsman at<br>Crease/Score</font></td>
                        <td align=center><font size=1>Extras</font></td>
                    </tr>
 <%        vparam.add(inningIdOne);
           officialScoresheetCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_stoppages", vparam, "ScoreDB");
           vparam.removeAllElements();
            try {
                if (officialScoresheetCrs != null) {
                while (officialScoresheetCrs.next()) {
 %>
                    <tr>
                        <td align=center>Inning 1</td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("start_ts")	!=null?officialScoresheetCrs.getString("start_ts"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("end_ts")	!=null?officialScoresheetCrs.getString("end_ts"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%= officialScoresheetCrs.getString("hour")	!=null?officialScoresheetCrs.getString("hour"):""%>/<%=officialScoresheetCrs.getString("min")!=null?officialScoresheetCrs.getString("min"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("overlost")	!=null?officialScoresheetCrs.getString("overlost"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("interval")	!=null?officialScoresheetCrs.getString("interval"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("teamname")	!=null?officialScoresheetCrs.getString("teamname"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("total_runs")!=null?officialScoresheetCrs.getString("total_runs"):""%>/<%=officialScoresheetCrs.getString("total_wkt")!=null?officialScoresheetCrs.getString("total_wkt"):""%>/<%=officialScoresheetCrs.getString("overs")!=null?officialScoresheetCrs.getString("overs"):""%>/<%=officialScoresheetCrs.getString("total_min")!=null?officialScoresheetCrs.getString("total_min"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("batsman1") != null ? officialScoresheetCrs.getString("batsman1") : ""%>/<%=officialScoresheetCrs.getString("bat1_score") != null ? officialScoresheetCrs.getString("bat1_score") : ""%>&<%=officialScoresheetCrs.getString("batsman2") != null ? officialScoresheetCrs.getString("batsman2") : ""%>/<%=officialScoresheetCrs.getString("bat2_score") != null ? officialScoresheetCrs.getString("bat2_score") : ""%></font></td>
                        <td align=center><font color="#003399" size=1></font></td>
                    </tr>
<%				}
			}
		}catch (Exception e) {
               // log.writeErrLog(page.getClass(), matchId, e.toString());
        }
%>
<%         vparam.add(inningIdTwo);
           officialScoresheetCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_stoppages", vparam, "ScoreDB");
           vparam.removeAllElements();
            try {
                if (officialScoresheetCrs != null) {
                while (officialScoresheetCrs.next()) {
 %>
                    <tr>
                        <td align=center>Inning 2</td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("start_ts")	!=null?officialScoresheetCrs.getString("start_ts"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("end_ts")	!=null?officialScoresheetCrs.getString("end_ts"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%= officialScoresheetCrs.getString("hour")	!=null?officialScoresheetCrs.getString("hour"):""%>/<%=officialScoresheetCrs.getString("min")!=null?officialScoresheetCrs.getString("min"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("overlost")	!=null?officialScoresheetCrs.getString("overlost"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("interval")	!=null?officialScoresheetCrs.getString("interval"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("teamname")	!=null?officialScoresheetCrs.getString("teamname"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("total_runs")!=null?officialScoresheetCrs.getString("total_runs"):""%>/<%=officialScoresheetCrs.getString("total_wkt")!=null?officialScoresheetCrs.getString("total_wkt"):""%>/<%=officialScoresheetCrs.getString("overs")!=null?officialScoresheetCrs.getString("overs"):""%>/<%=officialScoresheetCrs.getString("total_min")!=null?officialScoresheetCrs.getString("total_min"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("batsman1") != null ? officialScoresheetCrs.getString("batsman1") : ""%>/<%=officialScoresheetCrs.getString("bat1_score") != null ? officialScoresheetCrs.getString("bat1_score") : ""%>&<%=officialScoresheetCrs.getString("batsman2") != null ? officialScoresheetCrs.getString("batsman2") : ""%>/<%=officialScoresheetCrs.getString("bat2_score") != null ? officialScoresheetCrs.getString("bat2_score") : ""%></font></td>
                        <td align=center><font color="#003399" size=1></font></td>
                    </tr>
<%				}
			}
		}catch (Exception e) {
               // log.writeErrLog(page.getClass(), matchId, e.toString());
        }
%>
<%         vparam.add(inningIdThree);
           officialScoresheetCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_stoppages", vparam, "ScoreDB");
           vparam.removeAllElements();
            try {
                if (officialScoresheetCrs != null) {
                while (officialScoresheetCrs.next()) {
 %>
                    <tr>
                        <td align=center>Inning 3</td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("start_ts")	!=null?officialScoresheetCrs.getString("start_ts"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("end_ts")	!=null?officialScoresheetCrs.getString("end_ts"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%= officialScoresheetCrs.getString("hour")	!=null?officialScoresheetCrs.getString("hour"):""%>/<%=officialScoresheetCrs.getString("min")!=null?officialScoresheetCrs.getString("min"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("overlost")	!=null?officialScoresheetCrs.getString("overlost"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("interval")	!=null?officialScoresheetCrs.getString("interval"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("teamname")	!=null?officialScoresheetCrs.getString("teamname"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("total_runs")!=null?officialScoresheetCrs.getString("total_runs"):""%>/<%=officialScoresheetCrs.getString("total_wkt")!=null?officialScoresheetCrs.getString("total_wkt"):""%>/<%=officialScoresheetCrs.getString("overs")!=null?officialScoresheetCrs.getString("overs"):""%>/<%=officialScoresheetCrs.getString("total_min")!=null?officialScoresheetCrs.getString("total_min"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("batsman1") != null ? officialScoresheetCrs.getString("batsman1") : ""%>/<%=officialScoresheetCrs.getString("bat1_score") != null ? officialScoresheetCrs.getString("bat1_score") : ""%>&<%=officialScoresheetCrs.getString("batsman2") != null ? officialScoresheetCrs.getString("batsman2") : ""%>/<%=officialScoresheetCrs.getString("bat2_score") != null ? officialScoresheetCrs.getString("bat2_score") : ""%></font></td>
                        <td align=center><font color="#003399" size=1></font></td>
                    </tr>
<%				}
			}
		}catch (Exception e) {
               // log.writeErrLog(page.getClass(), matchId, e.toString());
        }
%>

<%         vparam.add(inningIdFour);
           officialScoresheetCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_stoppages", vparam, "ScoreDB");
           vparam.removeAllElements();
            try {
                if (officialScoresheetCrs != null) {
                while (officialScoresheetCrs.next()) {
 %>
                    <tr>
                        <td align=center>Inning 4</td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("start_ts")	!=null?officialScoresheetCrs.getString("start_ts"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("end_ts")	!=null?officialScoresheetCrs.getString("end_ts"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%= officialScoresheetCrs.getString("hour")	!=null?officialScoresheetCrs.getString("hour"):""%>/<%=officialScoresheetCrs.getString("min")!=null?officialScoresheetCrs.getString("min"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("overlost")	!=null?officialScoresheetCrs.getString("overlost"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("interval")	!=null?officialScoresheetCrs.getString("interval"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("teamname")	!=null?officialScoresheetCrs.getString("teamname"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("total_runs")!=null?officialScoresheetCrs.getString("total_runs"):""%>/<%=officialScoresheetCrs.getString("total_wkt")!=null?officialScoresheetCrs.getString("total_wkt"):""%>/<%=officialScoresheetCrs.getString("overs")!=null?officialScoresheetCrs.getString("overs"):""%>/<%=officialScoresheetCrs.getString("total_min")!=null?officialScoresheetCrs.getString("total_min"):""%></font></td>
                        <td align=center><font color="#003399" size=1><%=officialScoresheetCrs.getString("batsman1") != null ? officialScoresheetCrs.getString("batsman1") : ""%>/<%=officialScoresheetCrs.getString("bat1_score") != null ? officialScoresheetCrs.getString("bat1_score") : ""%>&<%=officialScoresheetCrs.getString("batsman2") != null ? officialScoresheetCrs.getString("batsman2") : ""%>/<%=officialScoresheetCrs.getString("bat2_score") != null ? officialScoresheetCrs.getString("bat2_score") : ""%></font></td>
                        <td align=center><font color="#003399" size=1></font></td>
                    </tr>
<%				}
			}
		}catch (Exception e) {
               // log.writeErrLog(page.getClass(), matchId, e.toString());
        }
%>
                </table>
            </td>
            
            <td align=center style=border-collapse:collapse>
                <table border="1"  width=100% style=border-collapse:collapse>
                    <tr>
                        <td align=center nowrap><font size=1>1. HAT-TRICK BY</font></td>
                        <td align=center nowrap><font size=1>VICTIMS</font></td>
                    </tr>
                    <%		vparam.add(inningIdOne);
            matchHatTrickCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch", vparam, "ScoreDB");            
            vparam.removeAllElements();
            if (matchHatTrickCrs != null) {
                try {
                    while (matchHatTrickCrs.next()) {
                        hatTrickBowler = matchHatTrickCrs.getString("hattrick_bowler") != null ? matchHatTrickCrs.getString("hattrick_bowler") : "";
                        victim = matchHatTrickCrs.getString("hattrick_victims") != null ? matchHatTrickCrs.getString("hattrick_victims") : "";
                    %>						
                    <tr>
                        <td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
                        <td align=center nowrap><font color="#003399"><%=victim%></td>
                    </tr>
                    <%                        
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }                
            }
                    %>
                    <%		vparam.add(inningIdTwo);
            matchHatTrickCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch", vparam, "ScoreDB");            
            vparam.removeAllElements();
            if (matchHatTrickCrs != null) {
                try {
                    while (matchHatTrickCrs.next()) {
                        hatTrickBowler = matchHatTrickCrs.getString("hattrick_bowler") != null ? matchHatTrickCrs.getString("hattrick_bowler") : "";
                        victim = matchHatTrickCrs.getString("hattrick_victims") != null ? matchHatTrickCrs.getString("hattrick_victims") : "";
                    %>						
                    <tr>
                        <td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
                        <td align=center nowrap><font color="#003399"><%=victim%></td>
                    </tr>
                    <%                        
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }                
            }
                    %>
                    <%		vparam.add(inningIdThree);
            matchHatTrickCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch", vparam, "ScoreDB");            
            vparam.removeAllElements();
            if (matchHatTrickCrs != null) {
                try {
                    while (matchHatTrickCrs.next()) {
                        hatTrickBowler = matchHatTrickCrs.getString("hattrick_bowler") != null ? matchHatTrickCrs.getString("hattrick_bowler") : "";
                        victim = matchHatTrickCrs.getString("hattrick_victims") != null ? matchHatTrickCrs.getString("hattrick_victims") : "";
                    %>						
                    <tr>
                        <td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
                        <td align=center nowrap><font color="#003399"><%=victim%></td>
                    </tr>
                    <%                        
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }                
            }
                    %>
                    <%		vparam.add(inningIdFour);
            matchHatTrickCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch", vparam, "ScoreDB");            
            vparam.removeAllElements();
            if (matchHatTrickCrs != null) {
                try {
                    while (matchHatTrickCrs.next()) {
                        hatTrickBowler = matchHatTrickCrs.getString("hattrick_bowler") != null ? matchHatTrickCrs.getString("hattrick_bowler") : "";
                        victim = matchHatTrickCrs.getString("hattrick_victims") != null ? matchHatTrickCrs.getString("hattrick_victims") : "";
                    %>						
                    <tr>
                        <td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
                        <td align=center nowrap><font color="#003399"><%=victim%></td>
                    </tr>
                    <%                        
                    }
                } catch (Exception e) {
                    log.writeErrLog(page.getClass(), matchId, e.toString());
                }                
            }
                    %>
                    <tr>
                        <td align=center nowrap><font size=1>2. ANY SPECIAL STATISTIACAL<br> HIGHLIGHT OF THE MATCH</font></td>
                        <td colspan="3" align=center nowrap><textarea ></textarea></td>
                    </tr>
                    <tr>
                        <td align=center nowrap><font size=1>3. DEBUTANTS</font></td>
                        <td colspan="3" align=center nowrap><textarea ></textarea></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
<br>
<!-- Main <DIV> and <TABLE> batting second ends here -->
<br>
<table width=0.1%>
    <tr>
        <td><b><%=secondinningbattingteam%> 1st Inning</b></td>
    </tr>	
</table>
<div id="teamTwoFirstinning"> 			
    
</div>
<br>
<div id="teamTwoFirstInningHundred"> 
    
</div>
<table width=0.1%>
    <tr>
        <td><b><%=secondinningbattingteam%> 2 nd Inning</b>
        </td>
    </tr>	
</table>
<div id="teamTwoSecondinning"> 			
    
</div>
<br>
<div id="teamTwoSecondInningHundred"> 
</div>
<br>
<%-- Main <Table> and <DIV> for individual scorers batting  second start here--%>
                
<%--Main table end here--%>
        
<%--Individual score for team two--%>
<P CLASS="breakhere">
<table border="1" width="100%">
    
	<%--<tr class=firstrow>
	<td align=center>ASSOCIATION</td>
	<td align=center>Innings</td>
	<td align=center>Runs/Wickets</td>
	<td align=center>Overs Played</td>
	<td align=center>Time Taken</td>
	<td align=center>Overs Short By Oppn.</td>
	<td align=center>Total Overs Short</td>
	<td align=center>Points League Level</td>
	<td align=center>Remarks</td>
	</tr>
    --%>
    <%	vparam.add(matchId);
            officialScoresheetCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_referee_match_report", vparam, "ScoreDB");
            vparam.removeAllElements();
    %>
    <tr class="contentLight">
        <td><b>Name of Association</b></td>
        <td><b>Innings.</b></td>
        <td><b>Runs/Wickets</b></td>
        <td><b>Overs Played</b></td>
        <td><b>Overs Short By Oppn..</b></td>
        <td><b>Time Taken</b></td>
        <td><b>Total Overs Short</b></td>
        <td><b>Points League Level</b></td>
        <td><b>Remarks</b></td>
    </tr>
    <%	Map ovShortMap = new HashMap();
        int i = 1;
        int flagOne = 0;
        int toOvShort = 0;
        int firstInn = 0;
        int secondInn = 0;
        while (officialScoresheetCrs.next()) {               
            String ovShort = officialScoresheetCrs.getString("overbowledshort") != null ? officialScoresheetCrs.getString("overbowledshort") : "0";
            if(i == 1 || i == 2){
               firstInn = firstInn + Integer.parseInt(ovShort);;
            }else if(i == 3 || i == 4){
                secondInn = secondInn + Integer.parseInt(ovShort);;
            }

			totalMatchTime = officialScoresheetCrs.getString("totalmatchtime") != null ? officialScoresheetCrs.getString("totalmatchtime") : "" ;
			
			testmatchInningsId = officialScoresheetCrs.getString("innings_id") != null ? officialScoresheetCrs.getString("innings_id") : "" ; 	


    %>	
<tr>
        <td align=left><font color="#003399"><%=officialScoresheetCrs.getString("nameofasscn") != null ? officialScoresheetCrs.getString("nameofasscn") : ""%></font></td>
        <td align=left><font color="#003399"><%=officialScoresheetCrs.getString("innings") != null ? officialScoresheetCrs.getString("innings") : ""%></font></td>
        <td align=right><font color="#003399"><%=officialScoresheetCrs.getString("runsscored") != null ? officialScoresheetCrs.getString("runsscored") : ""%>/<%=officialScoresheetCrs.getString("noofwkt") != null ? officialScoresheetCrs.getString("noofwkt") : ""%></font></td>
        <td align=right><font color="#003399"><%=officialScoresheetCrs.getString("overbowled") != null ? officialScoresheetCrs.getString("overbowled") : ""%></font></td>
        <td align=right><font color="#003399"><%=officialScoresheetCrs.getString("overbowledshort") != null ? officialScoresheetCrs.getString("overbowledshort") : ""%></font></td>
        <td align=right><font color="#003399"><a href="javascript:showMatchTimeDetail('<%=testmatchInningsId%>')"><%=totalMatchTime%></a></font></td>
<%       if(i == 1){
%>          <td align=right id="inningone<%=i%>" name="inningone<%=i%>"><font color="#003399"><%=firstInn%></font></td>
<%      }else if(i == 3){
%>          <td align=right id="inningtwo<%=i%>" name="inningtwo<%=i%>"><font color="#003399"><%=secondInn%></font></td>
<%       }   
%>
        <td align=right><font color="#003399"><%=officialScoresheetCrs.getString("matchpoint") != null ? officialScoresheetCrs.getString("matchpoint") : ""%></font></td>
        <td><b>&nbsp;</b></td>	
    </tr>	
    <%	i ++;
        }// end of while 
    %>
    
    <tr class=firstrow>
        <td colspan="9" align=center>
            PLEASE ENSURE THAT SCORE SHEET IS COMPLETE IN ALL RESPECT. ALSO ENSURE THAT THE SCORES ARE TALLIED.
        </td>
    </tr>
    <tr>
        <td align=center> UMPIRE</td>
        <td colspan="4" align=left><font color="#003399"><%=umpireOne%></td>
        <td colspan="4">&nbsp;</td>
    </tr>
    <tr>
        <td align=center>UMPIRE</td>
        <td colspan="4" align=left><font color="#003399"><%=umpireTwo%></td>
        <td colspan="4">&nbsp;</td>
    </tr>
    
    <tr>
        <td align=center>SCORER</td>
        <td colspan="4" align=left> <font color="#003399"><%=scorerOne%></td>
        <td colspan="4">&nbsp;</td>
    </tr>
    <tr>
        <td align=center>SCORER</td>
        <td colspan="4" align=left><font color="#003399"><%=scorerTwo%></td>
        <td colspan="4">&nbsp;</td>
    </tr>
</table>

</table>
<center><b>Match Remark</b></td>
<table width=100% border=1>
    <%
            vparam.add(inningIdOne);
            vparam.add(inningIdTwo);
            vparam.add(inningIdThree);
            vparam.add(inningIdFour);
            officialScoresheetCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_remarks", vparam, "ScoreDB");
            vparam.removeAllElements();
            try {
                if (officialScoresheetCrs != null) {
                    while (officialScoresheetCrs.next()) {
                        remarks = officialScoresheetCrs.getString("description") != null ? officialScoresheetCrs.getString("description") : "";
                        if (!(officialScoresheetCrs.getString("description").equalsIgnoreCase("default"))) {
                            if (!(remarks.equals(""))) {
    %>
    <tr>
        <td align=left><font color="#003399"><%=remarks%></font></td>
    </tr>
    <%
                            }                            
                        }
                    }
                }                
            } catch (Exception e) {
            } finally {
                officialScoresheetCrs = null;
                matchHatTrickCrs = null;
                hatTrickBowler = null;
                victim = null;
                remarks = null;
                tournamentName = null;
                electedto = null;
                zone = null;
                teamOne = null;
                teamTwo = null;
                toss = null;
                ground = null;
                city = null;
                date = null;
                matchWinner = null;
                result = null;
                umpireOne = null;
                umpireTwo = null;
                umpireThree = null;
                umpireFour = null;
                matchReferee = null;
                scorerOne = null;
                scorerTwo = null;
                captainOne = null;
                captainTwo = null;
                wicketKeeperOne = null;
                wicketKeeperTwo = null;
                umpireOneAsscn = null;
                umpireTwoAsscn = null;
                umpireThreeAsscn = null;
                umpireFourAsscn = null;
                matchRefassn = null;
            }            
    %>
</table>
<br>
<% if (refereeFlag == true) {
                if (!flag.equals("1")) {
%>			<table align=center>
    <tr>
        <td align=center><b>Remarks</b><textarea cols="40" rows="3" name="refereeRemark" id="refereeRemark" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz 1234567890');"></textarea></td>
    </tr>
    <tr>
        <td align=center><input type=button name=Approve value="Approve" onclick="RefreeApprove()"></td>					
    </tr>
</table>
<%	}
            }
%>		
<input type=hidden name="firstInningName"  id ="firstInningName"  value="<%=firstinningbattingteam%>"/>
<input type=hidden name="secondInningName" id ="secondInningName" value="<%=secondinningbattingteam%>"/>

</form>
</body>
<script language="javascript" >
//
function GetXmlHttpObject(){
var xmlHttp=null;
try{
xmlHttp=new XMLHttpRequest();
}
catch (e){
// Internet Explorer
try{
xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
}
catch (e){
xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
}
}
return xmlHttp;
}
        
// Getting Data for TeamOne Batting	 
function SubmitRemarks(){
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null){
alert ("Browser does not support HTTP Request") ;
return;
}
else{
var remark = document.getElementById('refereeRemark').value;
// alert("remark" +remark);
var url="/cims/jsp/ScoreSheet.jsp";
xmlHttp.onreadystatechange=stateChangedLASRemark;
xmlHttp.open("get",url,false);
xmlHttp.send(null);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
var responseResult= xmlHttp.responseText ;
var mdiv = document.getElementById("teamOneBatting");
mdiv.innerHTML = responseResult;
}
}
}
                        
// Getting Data for TeamOne Batting	 
function doGetTeamOneBattingData(inningIdOne,inningIdTwo,firstinningbattingteam){
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null){
alert ("Browser does not support HTTP Request") ;
return;
}
else{
var url="/cims/jsp/TeamSummeryVersion3.jsp?inningIdOne="+inningIdOne+"&inningIdTwo="+inningIdTwo+"&firstinningbattingteam="+firstinningbattingteam;
xmlHttp.onreadystatechange=stateChangedLAS1;
xmlHttp.open("get",url,false);
xmlHttp.send(null);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
var responseResult= xmlHttp.responseText ;
var mdiv = document.getElementById("teamOneBatting");
mdiv.innerHTML = responseResult;
}
}
}
                
function stateChangedLAS1(){
}
                 
// Getting Data for TeamTwo Batting	 
function doGetTeamTwoBattingData(inningIdOne,inningIdTwo,secondinningbattingteam){
// alert("Team 2"+inningIdOne);
// alert("Team 2" +inningIdTwo);
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null){
alert ("Browser does not support HTTP Request") ;
return;
}
else{
var url="/cims/jsp/TeamSummeryVersion3.jsp?inningIdOne="+inningIdOne+"&inningIdTwo="+inningIdTwo+"&secondinningbattingteam="+secondinningbattingteam;
xmlHttp.onreadystatechange=stateChangedLAS2;
xmlHttp.open("get",url,false);
xmlHttp.send(null);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
var responseResult= xmlHttp.responseText ;
var mdiv = document.getElementById("teamTwoBatting");
mdiv.innerHTML = responseResult;
}
}
}
                
function stateChangedLAS2(){
}
                
// Get individual data for team one
function doGetTeamOneFirstInningIndividualData(inningIdOne){
//alert(inningIdOne);
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null){
alert ("Browser does not support HTTP Request") ;
return;
}
else{
var flag=1;
// alert(inningIdOne);
var url="/cims/jsp/TestTeamPlayerScore.jsp?inningIdOne="+inningIdOne;
xmlHttp.onreadystatechange=stateChangedLAS3;
xmlHttp.open("get",url,false);
xmlHttp.send(null);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
var responseResult= xmlHttp.responseText ;
var mdiv = document.getElementById("teamOneFirstInning");
mdiv.innerHTML = responseResult;
}
}
}
                
function stateChangedLAS3(){
}
                
function doGetTeamOneSecondInningIndividualData(inningIdOne){
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null){
alert ("Browser does not support HTTP Request") ;
return;
}
else{
                        
var url="/cims/jsp/TestTeamPlayerScore.jsp?inningIdOne="+inningIdOne;
xmlHttp.onreadystatechange=stateChangedLAS4;
xmlHttp.open("get",url,false);
xmlHttp.send(null);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
var responseResult= xmlHttp.responseText ;
var mdiv = document.getElementById("teamOneSecondInning");
mdiv.innerHTML = responseResult;
}
}
}
                
function stateChangedLAS4(){
}
                
function doGetTeamTwoFirstInningIndividualData(inningIdOne){
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null){
alert ("Browser does not support HTTP Request") ;
return;
}
else{
var url="/cims/jsp/TestTeamPlayerScore.jsp?inningIdOne="+inningIdOne;
xmlHttp.onreadystatechange=stateChangedLAS5;
xmlHttp.open("get",url,false);
xmlHttp.send(null);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
var responseResult= xmlHttp.responseText ;
var mdiv = document.getElementById("teamTwoFirstinning");
mdiv.innerHTML = responseResult;
}
}
}
                
function stateChangedLAS5(){
}
                
function doGetTeamTwoSecondInningIndividualData(inningIdOne){
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null){
alert ("Browser does not support HTTP Request") ;
return;
}
else{
                        
var url="/cims/jsp/TestTeamPlayerScore.jsp?inningIdOne="+inningIdOne;
xmlHttp.onreadystatechange=stateChangedLAS6;
xmlHttp.open("get",url,false);
xmlHttp.send(null);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
var responseResult= xmlHttp.responseText ;
var mdiv = document.getElementById("teamTwoSecondinning");
mdiv.innerHTML = responseResult;
}
}
}
                
function stateChangedLAS6(){
}
                
// Get Hundred partnership data for team one	
                
function doGetTeamOneFirstInningHundredPartnership(inningIdOne){
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null){
alert ("Browser does not support HTTP Request") ;
return;
}
else{
var url="/cims/jsp/TestPartnership.jsp?inningIdOne="+inningIdOne;
xmlHttp.onreadystatechange=stateChangedLAS7;
xmlHttp.open("get",url,false);
xmlHttp.send(null);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
var responseResult= xmlHttp.responseText ;
var mdiv = document.getElementById("teamOneFirstInningHundred");
mdiv.innerHTML = responseResult;
}
}
}
                
function stateChangedLAS7(){
}
                
function doGetTeamOneSecondInningHundredPartnership(inningIdOne){
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null){
alert ("Browser does not support HTTP Request") ;
return;
}
else{
var url="/cims/jsp/TestPartnership.jsp?inningIdOne="+inningIdOne;
xmlHttp.onreadystatechange=stateChangedLAS8;
xmlHttp.open("get",url,false);
xmlHttp.send(null);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
var responseResult= xmlHttp.responseText ;
var mdiv = document.getElementById("teamOneSecondInningHundred");
mdiv.innerHTML = responseResult;
}
}
}
                
function stateChangedLAS8(){
} 
                
function doGetTeamTwoFirstInningHundredPartnership(inningIdOne){
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
	alert ("Browser does not support HTTP Request") ;
	return;
	}
	else{
		var url="/cims/jsp/TestPartnership.jsp?inningIdOne="+inningIdOne;
		xmlHttp.onreadystatechange=stateChangedLAS9;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText ;
			var mdiv = document.getElementById("teamTwoFirstInningHundred");
			mdiv.innerHTML = responseResult;
		}
	}
}
            
function stateChangedLAS9(){
}
                
function doGetTeamTwoSecondInningHundredPartnership(inningIdOne){
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null){
alert ("Browser does not support HTTP Request") ;
return;
}
else{
var url="/cims/jsp/TestPartnership.jsp?inningIdOne="+inningIdOne;
xmlHttp.onreadystatechange=stateChangedLAS;
xmlHttp.open("get",url,false);
xmlHttp.send(null);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
var responseResult= xmlHttp.responseText ;
var mdiv = document.getElementById("teamTwoSecondInningHundred");
mdiv.innerHTML = responseResult;
}
}
}
                
function stateChangedLAS(){
}
function getTotalShortOver(){
	document.getElementById("inningone1").innerHTML='<font color="#003399"><%=firstInn%></font>';
    document.getElementById("inningtwo3").innerHTML='<font color="#003399"><%=secondInn%></font>';
}      
//Get TeamOne Data
doGetTeamOneBattingData('<%=inningIdOne%>','<%=inningIdThree%>','<%=firstinningbattingteam%>');

//Get TeamTwo Data  
doGetTeamTwoBattingData('<%=inningIdTwo%>','<%=inningIdFour%>','<%=secondinningbattingteam%>');

//Get Individual Score data for all inning
doGetTeamOneFirstInningIndividualData('<%=inningIdOne%>');	
doGetTeamOneSecondInningIndividualData('<%=inningIdThree%>');	
doGetTeamTwoFirstInningIndividualData('<%=inningIdTwo%>');	
doGetTeamTwoSecondInningIndividualData('<%=inningIdFour%>');	
   getTotalShortOver();                             
//Get hundred partnership for all innings
        
doGetTeamOneFirstInningHundredPartnership('<%=inningIdOne%>');	                    
doGetTeamOneSecondInningHundredPartnership('<%=inningIdThree%>'); 	
doGetTeamTwoFirstInningHundredPartnership('<%=inningIdTwo%>');
doGetTeamTwoSecondInningHundredPartnership('<%=inningIdFour%>');
                          
// onRefresh();

// To show Match innings time details
function showMatchTimeDetail(inningId)
{
	var flag = 1;
	window.open("/cims/jsp/MatchTimeDetail.jsp?inningId="+inningId + "&flag="+flag, "MatchInningTimeDetails","location=no,directories=no,status=no,men//ubar=no,scrollbars=Yes,resizable=Yes,top=100,left=100,width=800,height=450");	
}

function showPlayerTimeDetail(batsmanId,inningId)
{
	//alert("batsmanId" +batsmanId);
	//alert("inningId" +inningId);
	var flag = 2;
	window.open("/cims/jsp/MatchTimeDetail.jsp?batsManId="+batsmanId + "&inningId="+inningId + "&flag="+flag, "MatchInningTimeDetails","location=no,directories=no,status=no,men//ubar=no,scrollbars=Yes,resizable=Yes,top=100,left=100,width=800,height=450");	
}



//close progress bar window
if (windowHandle)
{
	 windowHandle .close();
}
</script>
</html>

