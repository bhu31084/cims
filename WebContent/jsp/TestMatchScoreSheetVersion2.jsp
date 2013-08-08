
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
	CachedRowSet  officialScoresheetCrs 			 = null;
	CachedRowSet  matchHatTrickCrs					 = null;
	CachedRowSet  inningIdCrs						 = null;

	Vector vparam =  new Vector();
	
	// variable declaration
		String tournamentName 			= "";
		String matchNo 					= "";
		String zone						= "";
		String teamOne					= "";
		String teamTwo					= "";
		String toss						= "";
		String ground					= "";
		String city						= "";
		String date						= "";
		String result					= "";
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
		String point					= "";
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
		String firstInningName     		= "";
		String firstinningbattingteam 	= "";
		String secondinningbattingteam 	= "";
		String matchId					= "";
%>

<% // session.getAttribute("matchid");
	long timeBefore = System.currentTimeMillis();
	session.setAttribute("starttime",timeBefore);
	System.out.println("timeBefore" +timeBefore);
	//session.setAttribute("matchid","117");
	matchId = (String)session.getAttribute("matchid");
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	LogWriter log =  new LogWriter();
	vparam.add(session.getAttribute("matchid"));
	inningIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getInningIdForTest",vparam,"ScoreDB");
	vparam.removeAllElements();
	if (inningIdCrs != null){
		try
		{
			while (inningIdCrs.next()){
					inningIdOne		= inningIdCrs.getString("inn1")!=null?inningIdCrs.getString("inn1"):"";
					inningIdThree	= inningIdCrs.getString("inn2")!=null?inningIdCrs.getString("inn2"):"";	
					inningIdTwo		= inningIdCrs.getString("inn3")!=null?inningIdCrs.getString("inn3"):"";	
					inningIdFour	= inningIdCrs.getString("inn4")!=null?inningIdCrs.getString("inn4"):"";
			}
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}
%>

<%  vparam.add(session.getAttribute("matchid"));
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
				result				 = officialScoresheetCrs.getString("result")!=null?officialScoresheetCrs.getString("result"):"";
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
				
			}
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
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
		<STYLE TYPE="text/css">
				     P.breakhere {page-break-before: always}
		</STYLE> 
  </head>
  <body>
   	
<%   isPrint = request.getParameter("isprint")!=null?request.getParameter("isprint"):"";
	 System.out.println("isPrint" +isPrint);
		 if (!(isPrint.equalsIgnoreCase("true"))){
		  	out.println("MatchId" +session.getAttribute("matchid"));
%>
			  	 <a href="/cims/jsp/SelectMatch.jsp"><b>BACK</b></a>
				 <jsp:include page="Menu.jsp" />
				 <input type=button value="print" onClick='window.open("/cims/jsp/TestMatchScoreSheetVersion2.jsp?isprint=true","CIMS","location=no,directories=no,status=Yes,menubar=Yes,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth-20)+",height="+(window.screen.availHeight-30))'>
<%
		}
	
%>	
		 <form>
   				<center><font color="#003399" size=2>THE BOARD OF CONTROL FOR CRICKET IN INDIA</font></b></center>
   				<table border="0" cellpadding="4" cellspacing="0" width="100%" bordercolor="#111111" style="border-collapse: collapse" border="1">
   					<div> 
						<table cellspacing=1 align=center height=10% width="100%" style=border-collapse:collapse border=1 >
							  <tr class=firstrow>
							  		<td align=center nowrap width="1%"><font size=1>TOURNAMENT/VISTING TEAM</td>
							  		<td align=center nowrap width="1%"><font color="#003399" > <%=tournamentName%></font></td>
							  		<td align=center nowrap width="1%"><font size=1>MATCH BETWEEN </font><font color="#003399">&nbsp;<%=teamOne%></font> <font size=1>AND </font><font color="#003399"><%=teamTwo%></font></td>
						  	  		<td align=center nowrap width="1%"><font size=1>PLAYED ON </font></td>
						  	  		<td align=center nowrap width="1%"><font color="#003399"><%=date%></td>
						  	  		<td align=center nowrap width="1%">&nbsp;</td>
							  </tr>	 
							 
							  <tr class=firstrow>
								  	<td align=center nowrap width="1%"><font size=1>PLAYED AT GROUND/STADIUM</td>
							  		<td align=center nowrap width="1%"><font color="#003399"><%=ground%> </td>
							   		<td align=center nowrap width="1%"><font size=1>CITY</font> <font color="#003399">&nbsp;<%=city%> </td>
							   		<td align=center nowrap width="1%"><font size=1>TOSS WON BY</font> <font color="#003399">&nbsp;<%=toss%> </td>
							   		<td align=center nowrap width="1%"><font size=1>AND ELECTED TO </font><font color="#003399"><%=electedto%> </td>
							   		<td align=center nowrap width="1%"><font color="#003399"><%=decision%> </td>
							   		
							  </tr>
							 
							  <tr class=firstrow>
							  		<td align=center nowrap width="1%"><font size=1>RESULT</td>
							  		<td align=center nowrap width="1%"><font color="#003399"><%=result%></td>
							  		<td align=center nowrap width="1%"><font size=1>[POINT <font color="#003399"><%=point%></font>]</td>
							  		<td align=center nowrap width="1%"><font size=1>UMPIRES(1) MR:</font><font color="#003399"><%=umpireOne%></td>
							  		<td align=center nowrap width="1%"><font size=1>ASSOCIATION</td>
							  		<td align=center nowrap width="1%"><font color="#003399"><font color="#003399"><%=umpireOneAsscn%></td>
							  </tr>
							  
							  <tr class=firstrow>
							  		<td align=center nowrap width="1%"><font size=1>CAPTAIN (1)&nbsp;</td>
							  		<td align=center nowrap width="1%"><font color="#003399"><%=captainOne%> &nbsp;</font>&(2)</b>&nbsp;<font color="#003399"><%=captainTwo%></td>
							  		<td align=center nowrap width="1%"><font size=1>REFEREE : MR</font><font color="#003399">&nbsp;<%=matchReferee%></b></td>
							  		<td align=center nowrap width="1%"><font size=1>UMPIRES(2) MR:</font><font color="#003399"><%=umpireTwo%></td>
							  		<td align=center nowrap width="1%"><font size=1>ASSOCIATION</td>
							  		<td align=center nowrap width="1%"><font color="#003399"><%=umpireTwoAsscn%></td>
							  		
							  </tr>
							 
							  <tr class=firstrow>
							  		<td align=center nowrap width="1%">&nbsp;<font size=1>WICKET KEEPERS (1)</td>
							  		<td align=center nowrap width="1%">&nbsp;<font color="#003399"><%=wicketKeeperOne%></font>&nbsp;(2)</b>&nbsp;<font color="#003399"><%=wicketKeeperTwo%></td>
							  		<td align=center nowrap width="1%"><font size=1>REF ASSOCIATION</td>
							  		<td align=center nowrap width="1%"><font color="#003399"><%=matchRefassn%></td>
							  		<td align=center nowrap width="1%">&nbsp;</td>
							  		<td align=center nowrap width="1%">&nbsp;</td>
							  </tr>
						</table>
					</div>
					<br>
<% if (electedto.equalsIgnoreCase("Bat")){
		firstInningName = toss;
	}
	if(firstInningName.equalsIgnoreCase(teamOne)){
		firstinningbattingteam = teamOne;
		secondinningbattingteam = teamTwo;
	}else{
		secondinningbattingteam = teamOne;
		firstinningbattingteam = teamTwo;
	}
	session.setAttribute("firstinningbattingteam",firstinningbattingteam);
	session.setAttribute("secondinningbattingteam",secondinningbattingteam);
%>					
						<%--Main <TABLE> and <DIV> for batting first start here	--%>
								<div id="teamOneBatting">
									
								</div>
								
							<%-- Main <Table> and <DIV> for batting  first ends here--%>
						
					<%-- Main <Table> and <DIV> for individual scorers batting  first start here--%>
						<table>
							<tr>
								<td></td>
							</tr>
						</table>
						<br>
<%	if (!(isPrint.equalsIgnoreCase("true"))){	
%>				
						<div id="teamOneFirstInning"> 
							<table width=100% border=1>
								<tr>
										<td align=center nowrap><font size=1>INDIVIDUAL SCORES</b></td>
										<td align=center nowrap ><font size=1>For 50</b></td>
										<td align=center nowrap ><font size=1>For 100</b></td>
										<td align=center nowrap ><font size=1>For 150</b></td>
										<td align=center nowrap ><font size=1>For 200</b></td>
										<td align=center nowrap ><font size=1>For 250</b></td>
										<td align=center nowrap ><font size=1>For 300</b></td>
										<td align=center nowrap ><font size=1>For 350</b></td>
										<td align=center nowrap ><font size=1>ENTIRE INNINGS</b></td>
									</tr>
									<tr>
										<td>
											<table border=1 width=100%>	
													<tr>
														<td align=center nowrap>BATSMAN</b></td>
													</tr>
													<tr>
														<td align=center nowrap><font color="#003399"></td>
													</tr>													
													<tr>
														<td>&nbsp;</td>
													</tr>	
												</table>
											</td>	
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>

												</table>
											</td>
											<td>
												<table border=1 width=100%>	
													<tr>		
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>	
													</tr>
	
													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
													
												</table>
											</td>
											<td nowrap align=center >
														<table border=1 width=100%>	
															<tr>	
																<td nowrap align=center>Min's</td>
																<td nowrap align=center>4's</td>
																<td nowrap align=center>6's</td>
																<td nowrap align=center>Balls</td>
															</tr>
															<tr>
																<td align=center><font color="#003399"></td>
																<td align=center><font color="#003399"></td>
																<td align=center><font color="#003399"></td>
																<td align=center><font color="#003399"></td>
															</tr>
											
															<tr>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
															</tr>
											         </table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
										
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>
	
													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
										
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>
													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>

												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
												   <tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
												   <tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
									</tr>
								
							</table>
						</div>		
						
						
						<div id="teamOneSecondInning"> 
								
						</div>
												
					<%-- Main <Table> and <DIV> for individual scores batting  first ends here--%>
					
					<%-- Main <Table> and <DIV> for hundred partnership start here--%>
						<table>
							<tr>
								<td></td>
							</tr>
						</table>
						<br>
						<div id="teamOneFirstInningHundred"> 
								<table width=100% border=1>
									<tr class="firstrow">
										<td align=center nowrap><font size=1>HUNDRED PARTNERSHIP(Batting first 1ST inning)</b></td>
										<td align=center nowrap >For 50</b></td>
										<td align=center nowrap >For 100</b></td>
										<td align=center nowrap >For 150</b></td>
										<td align=center nowrap >For 200</b></td>
										<td align=center nowrap >For 250</b></td>
										<td align=center nowrap >For 300</b></td>
										<td align=center nowrap >For 350</b></td>
										<td align=center nowrap >Entire</b></td>
									</tr>
									<tr>
										<td>
											<table border=1 width=100%>	
													<tr>
														<td align=center>Wkt</b></td>
														<td align=center>Runs</b></td>
														<td align=center nowrap>BATSMAN</b></td>
													</tr>

													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td align=center nowrap><font color="#003399">&nbsp;</td>
													</tr>													

												</table>
											</td>	
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>

												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
													
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
													
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>
												   <tr>
														<td align=center><font color="#003399"></td>
														
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>
										    	 </table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														
														<td align=center><font color="#003399"></td>
													</tr>
									
													<tr>
														<td>&nbsp;</td>
														
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
												
														<td align=center><font color="#003399"></td>
													</tr>
												
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>
	
													<tr>
														<td align=center><font color="#003399"></td>
												
														<td align=center><font color="#003399"></td>
													</tr>
								
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>	
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>
	
													<tr>
														<td align=center><font color="#003399"></td>
												
														<td align=center><font color="#003399"></td>
													</tr>
										
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
												
														<td align=center><font color="#003399"></td>
													</tr>
												    <tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
								</tr>
								
								
								
							</table>
							</div>
								
							<table>
								<tr>
									<td></td>
								</tr>
							</table>
						<div id="teamOneSecondInningHundred"> 
								
						</div>
								
						<table>
							<tr>
								<td></td>
							</tr>
						</table>
						<div id="teamTwoFirstInningHundred"> 
								
						</div>
							
						<table>
							<tr>
								<td></td>
							</tr>
						</table>
						<div id="teamTwoSecondInningHundred"> 
								
						</div>
					<%-- Main <Table> and <DIV> for hundred partnership end here--%>
		</table><!--first table tag end here-->
		<br>
		 
<%	}
%>	
<%if (!(isPrint.equalsIgnoreCase("true"))){		
%>
		
			<div>	
			<table width=100% border=1>
						<tr>
							<td align=center>
								<table border="1" width=100%  style=border-collapse:collapse>
									<tr class=firstrow>
										<td align=center>Day</td>
										<td align=center>Start Time</td>
										<td align=center>End Time</td>
										<td align=center>
											<table border=1 width=100%>
												<tr>
													<td colspan=2>
														Stoppages
													</td>
												</tr>		
												<tr>
													<td>
														Time
													</td>
													<td>
														Mins
													</td>
												</tr>		
											</table>	
										</td>
										<td align=center>Mins</td>
										<td align=center>Lost</td>
										<td align=center>Reason</td>
										<td align=center>Team</td>
										<td align=center>Score<br>(Runs/Wkts/Overs/Mins)</td>
										<td align=center>Batsman at<br>Crease/Score</td>
										<td align=center>Extras</td>
									</tr>
	
									<tr>
										<td align=center>1</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
									</tr>
									<tr>
										<td align=center>2</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
									</tr>
									<tr>
										<td align=center>3</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
									</tr>
									<tr>
										<td align=center>4</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
									</tr>
								</table>
							</td>

							<td align=center style=border-collapse:collapse>
				
								<table border="1"  width=100% style=border-collapse:collapse>
									<tr>
										<td align=center nowrap>1. HAT-TRICK BY</td>
										<td align=center nowrap>VICTIMS</td>
									</tr>
<%		vparam.add(inningIdOne);
		matchHatTrickCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch",vparam,"ScoreDB");									
		vparam.removeAllElements();
		if (matchHatTrickCrs != null){
				try{
					while (matchHatTrickCrs.next()){
							hatTrickBowler = matchHatTrickCrs.getString ("hattrick_bowler")!=null?matchHatTrickCrs.getString ("hattrick_bowler"):"";
							victim		   = matchHatTrickCrs.getString ("hattrick_victims")!=null?matchHatTrickCrs.getString ("hattrick_victims"):"";
%>						
									<tr>
										<td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
										<td align=center nowrap><font color="#003399"><%=victim%></td>
									</tr>
<%									
						}
					}catch(Exception e){
						log.writeErrLog(page.getClass(),matchId,e.toString());
					}	
		}
%>
<%		vparam.add(inningIdTwo);
		matchHatTrickCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch",vparam,"ScoreDB");									
		vparam.removeAllElements();
		
		if (matchHatTrickCrs != null){
				try{
					while (matchHatTrickCrs.next()){
							hatTrickBowler = matchHatTrickCrs.getString ("hattrick_bowler")!=null?matchHatTrickCrs.getString ("hattrick_bowler"):"";
							victim		   = matchHatTrickCrs.getString ("hattrick_victims")!=null?matchHatTrickCrs.getString ("hattrick_victims"):"";
%>						
									<tr>
										<td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
										<td align=center nowrap><font color="#003399"><%=victim%></td>
									</tr>
<%									
						}
					}catch(Exception e){
						log.writeErrLog(page.getClass(),matchId,e.toString());
					}	
		}
%>
<%		vparam.add(inningIdThree);
		matchHatTrickCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch",vparam,"ScoreDB");									
		vparam.removeAllElements();
		
		if (matchHatTrickCrs != null){
				try{
					while (matchHatTrickCrs.next()){
							hatTrickBowler = matchHatTrickCrs.getString ("hattrick_bowler")!=null?matchHatTrickCrs.getString ("hattrick_bowler"):"";
							victim		   = matchHatTrickCrs.getString ("hattrick_victims")!=null?matchHatTrickCrs.getString ("hattrick_victims"):"";
%>						
									<tr>
										<td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
										<td align=center nowrap><font color="#003399"><%=victim%></td>
									</tr>
<%									
						}
					}catch(Exception e){
						log.writeErrLog(page.getClass(),matchId,e.toString());
					}	
		}
%>
<%		vparam.add(inningIdFour);
		matchHatTrickCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch",vparam,"ScoreDB");									
		vparam.removeAllElements();
		
		if (matchHatTrickCrs != null){
				try{
					while (matchHatTrickCrs.next()){
							hatTrickBowler = matchHatTrickCrs.getString ("hattrick_bowler")!=null?matchHatTrickCrs.getString ("hattrick_bowler"):"";
							victim		   = matchHatTrickCrs.getString ("hattrick_victims")!=null?matchHatTrickCrs.getString ("hattrick_victims"):"";
%>						
									<tr>
										<td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
										<td align=center nowrap><font color="#003399"><%=victim%></td>
									</tr>
<%									
						}
					}catch(Exception e){
						log.writeErrLog(page.getClass(),matchId,e.toString());
					}	
		}
%>
									<tr>
										<td align=center nowrap>2. ANY SPECIAL STATISTIACAL HIGHLIGHT OF THE MATCH</td>
										<td colspan="3" align=center nowrap><textarea ></textarea></td>
									</tr>
									<tr>
										<td align=center nowrap>3. DEBUTANTS</td>
										<td colspan="3" align=center nowrap><textarea ></textarea></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
<%
	}				
%>
			
				<br>
				<P CLASS="breakhere">
				<div id="teamTwoBatting">
				</div>
			<%-- Main <Table> and <DIV> for batting  second ends here--%>
					<br>

				<P CLASS="breakhere">
<%	if (isPrint.equalsIgnoreCase("true")){	
%>				
						<div id="teamOneFirstInning"> 
							<table width=100% border=1>
								<tr>
										<td align=center nowrap><font size=1>INDIVIDUAL SCORES</b></td>
										<td align=center nowrap ><font size=1>For 50</b></td>
										<td align=center nowrap ><font size=1>For 100</b></td>
										<td align=center nowrap ><font size=1>For 150</b></td>
										<td align=center nowrap ><font size=1>For 200</b></td>
										<td align=center nowrap ><font size=1>For 250</b></td>
										<td align=center nowrap ><font size=1>For 300</b></td>
										<td align=center nowrap ><font size=1>For 350</b></td>
										<td align=center nowrap ><font size=1>ENTIRE INNINGS</b></td>
									</tr>
									<tr>
										<td>
											<table border=1 width=100%>	
													<tr>
														<td align=center nowrap>BATSMAN</b></td>
													</tr>
													<tr>
														<td align=center nowrap><font color="#003399"></td>
													</tr>													
													<tr>
														<td>&nbsp;</td>
													</tr>	
												</table>
											</td>	
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>

												</table>
											</td>
											<td>
												<table border=1 width=100%>	
													<tr>		
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>	
													</tr>
	
													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
													
												</table>
											</td>
											<td nowrap align=center >
														<table border=1 width=100%>	
															<tr>	
																<td nowrap align=center>Min's</td>
																<td nowrap align=center>4's</td>
																<td nowrap align=center>6's</td>
																<td nowrap align=center>Balls</td>
															</tr>
															<tr>
																<td align=center><font color="#003399"></td>
																<td align=center><font color="#003399"></td>
																<td align=center><font color="#003399"></td>
																<td align=center><font color="#003399"></td>
															</tr>
											
															<tr>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
															</tr>
											         </table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
										
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>
	
													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
										
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>
													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>

												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
												   <tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
												   <tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
									</tr>
								
							</table>
						</div>		
						
						
						<div id="teamOneSecondInning"> 
								
						</div>
												
					<%-- Main <Table> and <DIV> for individual scores batting  first ends here--%>
					
					<%-- Main <Table> and <DIV> for hundred partnership start here--%>
						<table>
							<tr>
								<td></td>
							</tr>
						</table>
						<br>
						<div id="teamOneFirstInningHundred"> 
								<table width=100% border=1>
									<tr class="firstrow">
										<td align=center nowrap><font size=1>HUNDRED PARTNERSHIP(Batting first 1ST inning)</b></td>
										<td align=center nowrap >For 50</b></td>
										<td align=center nowrap >For 100</b></td>
										<td align=center nowrap >For 150</b></td>
										<td align=center nowrap >For 200</b></td>
										<td align=center nowrap >For 250</b></td>
										<td align=center nowrap >For 300</b></td>
										<td align=center nowrap >For 350</b></td>
										<td align=center nowrap >Entire</b></td>
									</tr>
									<tr>
										<td>
											<table border=1 width=100%>	
													<tr>
														<td align=center>Wkt</b></td>
														<td align=center>Runs</b></td>
														<td align=center nowrap>BATSMAN</b></td>
													</tr>

													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td align=center nowrap><font color="#003399">&nbsp;</td>
													</tr>													

												</table>
											</td>	
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>

												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
													
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
													
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>
												   <tr>
														<td align=center><font color="#003399"></td>
														
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>
										    	 </table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														
														<td align=center><font color="#003399"></td>
													</tr>
									
													<tr>
														<td>&nbsp;</td>
														
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
												
														<td align=center><font color="#003399"></td>
													</tr>
												
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>
	
													<tr>
														<td align=center><font color="#003399"></td>
												
														<td align=center><font color="#003399"></td>
													</tr>
								
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>	
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>
	
													<tr>
														<td align=center><font color="#003399"></td>
												
														<td align=center><font color="#003399"></td>
													</tr>
										
													<tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
												
														<td align=center><font color="#003399"></td>
													</tr>
												    <tr>
														<td>&nbsp;</td>
													
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
								</tr>
								
								
								
							</table>
							</div>
								
							<table>
								<tr>
									<td></td>
								</tr>
							</table>
						<div id="teamOneSecondInningHundred"> 
								
						</div>
								
						<table>
							<tr>
								<td></td>
							</tr>
						</table>
						<div id="teamTwoFirstInningHundred"> 
								
						</div>
							
						<table>
							<tr>
								<td></td>
							</tr>
						</table>
						<div id="teamTwoSecondInningHundred"> 
								
						</div>
					<%-- Main <Table> and <DIV> for hundred partnership end here--%>
		</table><!--first table tag end here-->
		<br>
		 
<%	}
%>	
<%if (isPrint.equalsIgnoreCase("true")){		
%>
			
			<div>	
			<table width=100% border=1>
						<tr>
							<td align=center>
								<table border="1" width=100%  style=border-collapse:collapse>
									<tr class=firstrow>
										<td align=center>Day</td>
										<td align=center>Start Time</td>
										<td align=center>End Time</td>
										<td align=center>
											<table border=1 width=100%>
												<tr>
													<td colspan=2>
														Stoppages
													</td>
												</tr>		
												<tr>
													<td>
														Time
													</td>
													<td>
														Mins
													</td>
												</tr>		
											</table>	
										</td>
										<td align=center>Mins</td>
										<td align=center>Lost</td>
										<td align=center>Reason</td>
										<td align=center>Team</td>
										<td align=center>Score<br>(Runs/Wkts/Overs/Mins)</td>
										<td align=center>Batsman at<br>Crease/Score</td>
										<td align=center>Extras</td>
									</tr>
	
									<tr>
										<td align=center>1</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
									</tr>
									<tr>
										<td align=center>2</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
									</tr>
									<tr>
										<td align=center>3</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
									</tr>
									<tr>
										<td align=center>4</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
										<td align=center>&nbsp;</td>
									</tr>
								</table>
							</td>

							<td align=center style=border-collapse:collapse>
				
								<table border="1"  width=100% style=border-collapse:collapse>
									<tr>
										<td align=center nowrap>1. HAT-TRICK BY</td>
										<td align=center nowrap>VICTIMS</td>
									</tr>
<%		vparam.add(inningIdOne);
		matchHatTrickCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch",vparam,"ScoreDB");									
		vparam.removeAllElements();
		
		if (matchHatTrickCrs != null){
				try{
					while (matchHatTrickCrs.next()){
							hatTrickBowler = matchHatTrickCrs.getString ("hattrick_bowler")!=null?matchHatTrickCrs.getString ("hattrick_bowler"):"";
							victim		   = matchHatTrickCrs.getString ("hattrick_victims")!=null?matchHatTrickCrs.getString ("hattrick_victims"):"";
%>						
									<tr>
										<td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
										<td align=center nowrap><font color="#003399"><%=victim%></td>
									</tr>
<%									
						}
					}catch(Exception e){
						log.writeErrLog(page.getClass(),matchId,e.toString());
					}	
		}
%>
<%		vparam.add(inningIdTwo);
		matchHatTrickCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch",vparam,"ScoreDB");									
		vparam.removeAllElements();
		
		if (matchHatTrickCrs != null){
				try{
					while (matchHatTrickCrs.next()){
							hatTrickBowler = matchHatTrickCrs.getString ("hattrick_bowler")!=null?matchHatTrickCrs.getString ("hattrick_bowler"):"";
							victim		   = matchHatTrickCrs.getString ("hattrick_victims")!=null?matchHatTrickCrs.getString ("hattrick_victims"):"";
%>						
									<tr>
										<td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
										<td align=center nowrap><font color="#003399"><%=victim%></td>
									</tr>
<%									
						}
					}catch(Exception e){
						log.writeErrLog(page.getClass(),matchId,e.toString());
					}	
		}
%>
<%		vparam.add(inningIdThree);
		matchHatTrickCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch",vparam,"ScoreDB");									
		vparam.removeAllElements();
		
		if (matchHatTrickCrs != null){
				try{
					while (matchHatTrickCrs.next()){
							hatTrickBowler = matchHatTrickCrs.getString ("hattrick_bowler")!=null?matchHatTrickCrs.getString ("hattrick_bowler"):"";
							victim		   = matchHatTrickCrs.getString ("hattrick_victims")!=null?matchHatTrickCrs.getString ("hattrick_victims"):"";
%>						
									<tr>
										<td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
										<td align=center nowrap><font color="#003399"><%=victim%></td>
									</tr>
<%									
						}
					}catch(Exception e){
						log.writeErrLog(page.getClass(),matchId,e.toString());
					}	
		}
%>
<%		vparam.add(inningIdFour);
		matchHatTrickCrs  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_statistics_for_testmatch",vparam,"ScoreDB");									
		vparam.removeAllElements();
		
		if (matchHatTrickCrs != null){
				try{
					while (matchHatTrickCrs.next()){
							hatTrickBowler = matchHatTrickCrs.getString ("hattrick_bowler")!=null?matchHatTrickCrs.getString ("hattrick_bowler"):"";
							victim		   = matchHatTrickCrs.getString ("hattrick_victims")!=null?matchHatTrickCrs.getString ("hattrick_victims"):"";
%>						
									<tr>
										<td align=center nowrap><font color="#003399"><%=hatTrickBowler%></td>
										<td align=center nowrap><font color="#003399"><%=victim%></td>
									</tr>
<%									
						}
					}catch(Exception e){
						log.writeErrLog(page.getClass(),matchId,e.toString());
					}	
		}
%>
									<tr>
										<td align=center nowrap>2. ANY SPECIAL STATISTIACAL HIGHLIGHT OF THE MATCH</td>
										<td colspan="3" align=center nowrap><textarea ></textarea></td>
									</tr>
									<tr>
										<td align=center nowrap>3. DEBUTANTS</td>
										<td colspan="3" align=center nowrap><textarea ></textarea></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
<%
	}				
%>
		
			<br>
					<div id="teamTwoFirstinning"> 			
							<table width=100% border=1>
								<tr>
										<td align=center nowrap>INDIVIDUAL SCORES</b></td>
										<td align=center nowrap >For 50</b></td>
										<td align=center nowrap >For 100</b></td>
										<td align=center nowrap >For 150</b></td>
										<td align=center nowrap >For 200</b></td>
										<td align=center nowrap >For 250</b></td>
										<td align=center nowrap >For 300</b></td>
										<td align=center nowrap >For 350</b></td>
										<td align=center nowrap >ENTIRE</b></td>
										
									</tr>
									<tr>
										<td>
											<table border=1 width=100%>	
													<tr>
														<td align=center nowrap>BATSMAN</b></td>
													</tr>
													<tr>
														<td align=center nowrap><font color="#003399"></td>
													</tr>													
													<tr>
														<td>&nbsp;</td>
													</tr>	
												</table>
											</td>	
											
											
											<td nowrap align=center >
														<table border=1 width=100%>	
															<tr>	
																<td nowrap align=center>Min's</td>
																<td nowrap align=center>4's</td>
																<td nowrap align=center>6's</td>
																<td nowrap align=center>Balls</td>
															</tr>
															<tr>
																<td align=center><font color="#003399"></td>
																<td align=center><font color="#003399"></td>
																<td align=center><font color="#003399"></td>
																<td align=center><font color="#003399"></td>
															</tr>
											
															<tr>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
															</tr>
											         </table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
										
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>

												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>
													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
										
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>
	
													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
										
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>
													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
											
													<tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>

												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
												   <tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
											<td nowrap align=center >
												<table border=1 width=100%>	
													<tr>	
														<td nowrap align=center>Min's</td>
														<td nowrap align=center>4's</td>
														<td nowrap align=center>6's</td>
														<td nowrap align=center>Balls</td>
													</tr>

													<tr>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
														<td align=center><font color="#003399"></td>
													</tr>
												   <tr>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
							</tr>
						</table>
					</div>
					<!-- Main <DIV> and <TABLE> batting second ends here -->
					<br>
					<table>
						<td></td>
					</table>
					<div id="teamTwoSecondinning"> 			
				
					</div>
					<%-- Main <Table> and <DIV> for individual scorers batting  second start here--%>
		
<%--Main table end here--%>
	
<%--Individual score for team two--%>
				<table border="1" width="100%">
								<tr class=firstrow>
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
								<tr>
									<td rowspan="2"><font color="#003399"></td>
									<td align=center>1ST</td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
								</tr>
								<tr>
									<td align=center>2ND</td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
								</tr>
								<tr>
									<td rowspan="2"><font color="#003399"></td>
									<td align=center>1ST</td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
								</tr>
								<tr>
									<td align=center>2ND</td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
									<td align=center><font color="#003399"></td>
								</tr>
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
		<input type=hidden name="firstInningName" id ="firstInningName"  value="<%=firstinningbattingteam%>"/>
		<input type=hidden name="secondInningName" id ="secondInningName" value="<%=secondinningbattingteam%>"/>
  </form>
  </body>
  	 <script language="javascript" >
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
    	
    		 function doGetTeamOneBattingData(inningIdOne,inningIdTwo,firstinningbattingteam){
    		// alert("Team 1" +inningIdOne);
    		// alert("Team 1" +inningIdTwo);
        	  xmlHttp=GetXmlHttpObject();
              if (xmlHttp==null){
                  alert ("Browser does not support HTTP Request") ;
                  return;
              }
              else{
			
                  var url="/cims/jsp/TeamSummeryVersion2.jsp?inningIdOne="+inningIdOne+"&inningIdTwo="+inningIdTwo+"&firstinningbattingteam="+firstinningbattingteam;
                   xmlHttp.onreadystatechange=stateChangedLAS1;
                  xmlHttp.open("get",url,false);
                  xmlHttp.send(null);
              }
        	}
        	
        	function stateChangedLAS1(){
	            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("teamOneBatting");
	                   mdiv.innerHTML = responseResult;
	             }
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
			
                  var url="/cims/jsp/TeamSummeryVersion2.jsp?inningIdOne="+inningIdOne+"&inningIdTwo="+inningIdTwo+"&secondinningbattingteam="+secondinningbattingteam;
                  xmlHttp.onreadystatechange=stateChangedLAS2;
                  xmlHttp.open("get",url,false);
                  xmlHttp.send(null);
              }
        	}
        	
        	function stateChangedLAS2(){
	            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("teamTwoBatting");
	                   mdiv.innerHTML = responseResult;
	             }
      		 }
        	
            // Get individual data for team one
            	
           	function doGetTeamOneFirstInningIndividualData(inningIdOne){
	       	  xmlHttp=GetXmlHttpObject();
              if (xmlHttp==null){
                  alert ("Browser does not support HTTP Request") ;
                  return;
              }
              else{
			
                  var url="/cims/jsp/TestTeamPlayerScore.jsp?inningIdOne="+inningIdOne;
                  xmlHttp.onreadystatechange=stateChangedLAS3;
                  xmlHttp.open("get",url,false);
                  xmlHttp.send(null);
              }
        	}
        	
        	function stateChangedLAS3(){
	            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("teamOneFirstInning");
	                   mdiv.innerHTML = responseResult;
	             }
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
              }
        	}
        	
        	function stateChangedLAS4(){
	            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("teamOneSecondInning");
	                   mdiv.innerHTML = responseResult;
	             }
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
              }
        	}
        	
        	function stateChangedLAS5(){
	            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("teamTwoFirstinning");
	                   mdiv.innerHTML = responseResult;
	             }
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
              }
        	}
        	
        	function stateChangedLAS6(){
	            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("teamTwoSecondinning");
	                   mdiv.innerHTML = responseResult;
	             }
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
              }
        	}
        	
        	function stateChangedLAS7(){
	            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("teamOneFirstInningHundred");
	                   mdiv.innerHTML = responseResult;
	             }
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
              }
        	}
        	
        	function stateChangedLAS8(){
	            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("teamOneSecondInningHundred");
	                   mdiv.innerHTML = responseResult;
	             }
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
              }
        	}
        	
        	function stateChangedLAS9(){
	            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("teamTwoFirstInningHundred");
	                   mdiv.innerHTML = responseResult;
	             }
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
              }
        	}
        	
        	function stateChangedLAS(){
	            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("teamTwoSecondInningHundred");
	                   mdiv.innerHTML = responseResult;
	             }
      		 }
              //Get TeamOne Data
              
                doGetTeamOneBattingData('<%=inningIdOne%>','<%=inningIdThree%>','<%=firstinningbattingteam%>');

              //Get TeamTwo Data  
              
				doGetTeamTwoBattingData('<%=inningIdTwo%>','<%=inningIdFour%>','<%=secondinningbattingteam%>');
				
			 //Get Individual Score data for all inning
			 
			  //  	doGetTeamOneFirstInningIndividualData('<%=inningIdOne%>');	
			  //  	doGetTeamOneSecondInningIndividualData('<%=inningIdThree%>');	
			  //	doGetTeamTwoFirstInningIndividualData('<%=inningIdTwo%>');	
			  //	doGetTeamTwoSecondInningIndividualData('<%=inningIdFour%>');	
				
			 //Get hundred partnership for all innings
	
			  //  doGetTeamOneFirstInningHundredPartnership('<%=inningIdOne%>');	                    
			  //  doGetTeamOneSecondInningHundredPartnership('<%=inningIdThree%>'); 	
			  //  doGetTeamTwoFirstInningHundredPartnership('<%=inningIdTwo%>');
			  //  doGetTeamTwoSecondInningHundredPartnership('<%=inningIdFour%>');
			  
			 // onRefresh();
     </script>
</html>
