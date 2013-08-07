<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.Math.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%
	Common commonUtil		  	 =  new Common();
    CachedRowSet  intervalsCrs	 =  null;
    CachedRowSet  updateTimeCrs	 =  null;
    CachedRowSet  inningTimeCrs	 =  null;
    CachedRowSet  inningIdCrs	 =  null;
   	SimpleDateFormat sdf		 =  new SimpleDateFormat("dd/MM/yyyy");
    Vector vparam 			     =  new Vector();
    String startLTime			 =  new String();
    String endLTime				 =  new	String();
 
	String intrName 		 	 = "";
	String interuption  	 	 = "";
	String teamOne 			 	 = "";
	String teamTwo			 	 = "";
	String startInningTime	 	 = "";
	String endInningTime	  	 = "";
	String inningDuration	  	 = "";
	String duration	 		 	 = "";
	String intermissionName  	 = "";
	String startTime		  	 = "";
	String endTime			  	 = "";
	String hour				  	 = "";
	String min				  	 = "";
	String startInning		  	 = "";
	String matchId			  	 = "";
	String inningsId		 	 = "";
	String retvalue			  	 = "";
	String remark			  	 = "";	
	String date				  	 = "";
	String hourmin			  	 = "";
	String second			  	 = "";
	String hourminsec		  	 = "";	
	String startDateParam	  	 = "";
	String endDateParam		  	 = "";
	String matchDate		  	 = "";	
	String bowlingteam		  	 = "";	
	String wkt				  	 = "";
	String paramDate		  	 = "";
	String paramDay			  	 = "";
	String param			  	 = "";	
	String teamName				 = "";
	String[] teamArr			 = null;
	String bowlingTeamOne		 = "";
	String bowlingTeamTwo		 = "";
	String loginUserName		 = "";			
	int counter 				 = 0;
	int intervalTime 		  	 = 0;
	int    wkts  			  	 = 0;
	int    totalWkt 		  	 = 0;
	int    overBowl			  	 = 0;
	double roundOverBowl	  	 = 0;
	int    startTimeMin		  	 = 0; 	
	int	   lunchMin			  	 = 0;
	int	   drinkMin			  	 = 0;
	int    teaMin			  	 = 0;
	int    rainMin			  	 = 0;
	int    badLightMin		  	 = 0;		
	int	   totalMin			  	 = 0;	
	int    lengthInning		  	 = 0;	
	int	   i 				   	 = 0;
	int	   j 				  	 = 0;
	int interuptionTime 	  	 = 0;
	SimpleDateFormat sdfBefore 		  = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sdfAfter  		  = new SimpleDateFormat("dd/MM/yyyy");
	java.text.SimpleDateFormat sdFormat = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	java.util.Date 	convertStartDate  = new Date();
	java.util.Date 	convertEndDate    = new Date();
	Calendar cal 					  =	Calendar.getInstance();
	String 	startDate	 			  =	"";
	String	endDate       	 		  =	"";
	cal.add(Calendar.DATE,0);
    LogWriter log 			= new LogWriter();
    GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	//session.setAttribute("matchid","118");
	matchId   = (String)session.getAttribute("matchid"); 
	loginUserName = session.getAttribute("usernamesurname").toString();
	inningsId = request.getParameter("inningIdOne")!=null?request.getParameter("inningIdOne"):"";
	paramDate = request.getParameter("date")!=null?request.getParameter("date"):"";
	paramDay  = request.getParameter("day")!=null?request.getParameter("day"):"";
	param	  = request.getParameter("param")!=null?request.getParameter("param"):"";
	
	if (param.equalsIgnoreCase("date")){
		// To get startts,endts,duration,team1,team2,bowlingteam,wkts based on date
		vparam.add(matchId);
		vparam.add(paramDate);
		vparam.add("");
		vparam.add("1");
		inningTimeCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchdetail_ondate",vparam,"ScoreDB");
		vparam.removeAllElements();
		try{
			if (inningTimeCrs!=null){
				while(inningTimeCrs.next()){
					startInningTime = inningTimeCrs.getString("startts")!=null?inningTimeCrs.getString("startts"):"";
					if(startInningTime!=""){
							//date		= startInningTime.substring(0,10);
							//startInning = startInningTime.substring(11,startInningTime.length());
							//hour		= startInning.substring(0,2);
							//min  		= startInning.substring(3,5);
							//second 		= startInning.substring(6,startInning.length());
							//startTimeMin= Integer.parseInt(hour)*60+Integer.parseInt(min);
					}
					endInningTime	= inningTimeCrs.getString("endts")!=null?inningTimeCrs.getString("endts"):"";	
					inningDuration	= inningTimeCrs.getString("duration")!=null?inningTimeCrs.getString("duration"):"0";	
					teamOne			= inningTimeCrs.getString("team1")!=null?inningTimeCrs.getString("team1"):"";		
					teamTwo			= inningTimeCrs.getString("team2")!=null?inningTimeCrs.getString("team2"):"";
					matchDate		= inningTimeCrs.getString("matchdate")!=null?inningTimeCrs.getString("matchdate"):"";
					//bowlingteam	= inningTimeCrs.getString("bowlingteam")!=null?inningTimeCrs.getString("bowlingteam"):"";
					wkt				= inningTimeCrs.getString("wkts")!=null?inningTimeCrs.getString("wkts"):"0";
				}
			}	
		}catch(Exception e)	{
		  log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}else{
		// To get startts,endts,duration,team1,team2,bowlingteam,wkts based on innings
	    vparam.add(matchId);
		vparam.add(inningsId);
		vparam.add("1");
		inningTimeCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_over_rate_match_details",vparam,"ScoreDB");
		vparam.removeAllElements();
		try{
			if (inningTimeCrs!=null){
				while(inningTimeCrs.next()){
					startInningTime = inningTimeCrs.getString("startts")!=null?inningTimeCrs.getString("startts"):"";
					if(startInningTime!=""){
							//date		= startInningTime.substring(0,10);
							//startInning = startInningTime.substring(11,startInningTime.length());
							//hour		= startInning.substring(0,2);
							//min  		= startInning.substring(3,5);
							//second 		= startInning.substring(6,startInning.length());
							//startTimeMin= Integer.parseInt(hour)*60+Integer.parseInt(min);
					}
					endInningTime	= inningTimeCrs.getString("endts")!=null?inningTimeCrs.getString("endts"):"";	
					inningDuration	= inningTimeCrs.getString("duration")!=null?inningTimeCrs.getString("duration"):"0";	
					teamOne			= inningTimeCrs.getString("team1")!=null?inningTimeCrs.getString("team1"):"";		
					teamTwo			= inningTimeCrs.getString("team2")!=null?inningTimeCrs.getString("team2"):"";
					matchDate		= inningTimeCrs.getString("matchdate")!=null?inningTimeCrs.getString("matchdate"):"";
					bowlingteam	    = inningTimeCrs.getString("bowlingteam")!=null?inningTimeCrs.getString("bowlingteam"):"";
					wkt				= inningTimeCrs.getString("wkts")!=null?inningTimeCrs.getString("wkts"):"0";
				}
			}	
		}catch(Exception e)	{
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}	
%>
<html>
<head>
<script language="JavaScript" src="../js/datetimepicker.js" type="text/javascript"></script>
<script>
	function validateData(){
			document.getElementById('hid').value=1
			document.frmOverRate.action="/cims/jsp/OverRateCalculation.jsp";
			document.frmOverRate.submit();
	}		
	
</script>
</head>
<body>
<input type=hidden name="hidOverRate" id="hidOverRate" value=""/>
<table width="100%" align=center class="table" border="0">
			<tr class="contentDark">
				<td align=right colspan=3><b><%=loginUserName%>&nbsp;&nbsp;&nbsp;DATE
			:</b> <%=sdFormat.format(new Date())%></td>
			</tr>
			<tr class="contentLight"> 
				<td><b>Match Details :</b>&nbsp;&nbsp;<%=teamOne%>&nbsp;&nbsp;<b>Vs</b>&nbsp;&nbsp;<%=teamTwo%></td>
				<td><b>Date :&nbsp;&nbsp; </b><%=matchDate%></td>
				<td>&nbsp;</td>
			</tr>
			<tr class="contentDark">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="contentLight">	
				<td><b>Bowling Team :</b>&nbsp;
<%	if (param.equalsIgnoreCase("date")){
	// To get startts,endts,duration,team1,team2,bowlingteam,wkts based on innings
	    vparam.add(matchId);
		vparam.add(paramDate);
		vparam.add("");
		vparam.add("2");
		inningTimeCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchdetail_ondate",vparam,"ScoreDB");
		vparam.removeAllElements();
		try{
			if (inningTimeCrs!=null){
				while(inningTimeCrs.next()){
					teamName = 	teamName + inningTimeCrs.getString("team_name")+"~";
				}	
					teamArr = teamName.split("~");
					if (teamArr!=null){
						if (teamArr.length == 1){	
							bowlingTeamOne = teamArr[0]!=null?teamArr[0]:"";
						}else if(teamArr.length == 2){
							bowlingTeamOne = teamArr[0]!=null?teamArr[0]:"";
							bowlingTeamTwo = teamArr[1]!=null?teamArr[1]:"";
						}
					}
				
			}
		}catch(Exception e)	{
				log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		if (bowlingTeamTwo!=""){
%>			<%=bowlingTeamOne%> &nbsp;&&nbsp; <%=bowlingTeamTwo%>
<%		}else{
%>			<%=bowlingTeamOne%>
<%		}
	}else{				
%>				&nbsp;&nbsp;<%=bowlingteam%>
<%	}
%>						
				</td>
				<td>&nbsp;</td>
<%	if (param.equalsIgnoreCase("date")){				
%>			<td><b>Day of the Match :</b>	
<% }else{
%>			<td><b>Inning of the Match :</b>				
<%}
%>
					&nbsp;&nbsp;<%=paramDay%>
				</td>
			</tr>
			<tr class="contentDark">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr class="contentLight">
				<td align=center colspan=3>
<%				if (startInningTime!=""){
%>				<b>Actual Start Time of innings on above day :</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=startInningTime.substring(0,16)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[A]</td>
<%				}else{
				}
%>			</tr>
	</table>
	<br>
	<br>
	<table width="100%" align="center" >
	<tr>
		<td align=center colspan=3 class="headinguser">RECORD OF ALLOWANCES (Intervals and Interruptions)&nbsp;&nbsp;&nbsp;<b><%=paramDay%></b></td>								
	</tr>
	</table>		
	<table width=100% align=center border=0 class="table tableBorder">
	<tr class="contentDark">
		<td align=center width=width=20% class="colheadinguser"><b>Event</b></td>
		<td align=center width=30% class="colheadinguser"><b>Start</b></td>
		<td align=center width=30% class="colheadinguser"><b>End</b></td>
		<td align=center width=20% class="colheadinguser"><b>Length(Mins)</b></td>
	</tr>

	<tr>
		<td colspan=4><u><font size="2" ><b>INTERVALS</b></font></u></td>
	</tr>
<%  if (param.equalsIgnoreCase("date")){
			counter = 1;
			vparam.add(matchId);
			vparam.add("");
			vparam.add(paramDate);
			vparam.add("3");
			intervalsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_intervals",vparam,"ScoreDB");
			vparam.removeAllElements();	
			try{
			 	if(intervalsCrs != null){	
			 			while(intervalsCrs.next()){	
			 					interuption = intervalsCrs.getString("name")!=null?intervalsCrs.getString("name"):"";
			 					startTime	= intervalsCrs.getString("start_ts")!=null?intervalsCrs.getString("start_ts").substring(0,16):"";
			 					endTime		= intervalsCrs.getString("end_ts")!=null?intervalsCrs.getString("end_ts").substring(0,16):"";
			 					duration	= intervalsCrs.getString("duration")!=null?intervalsCrs.getString("duration"):"0";	
					if(counter % 2 != 0){			 			
%>						<tr class="contentDark">
<%					}else{
%>						<tr class="contentLight">
<%
					}
%>
<%					if(!interuption.equalsIgnoreCase(intrName)){
						intrName = interuption;
%>							 <td align=center><b><%=interuption%></b></td>
<%					}else{
%>							 <td>&nbsp;</td>
<%
					}
%>							<td align=center><%=startTime%></td>
							<td align=center><%=endTime%></td>
							<td align=center><%=duration%></td>
						</tr>
<%	 				intervalTime = intervalTime + Integer.parseInt(duration);
					counter ++;
					}
				}
			}catch(Exception e){	
			 	log.writeErrLog(page.getClass(),matchId,e.toString());
			}
		}else{
			counter = 1;
			vparam.add("");
			vparam.add(inningsId);
			vparam.add("");
			vparam.add("1");
			intervalsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_intervals",vparam,"ScoreDB");
			vparam.removeAllElements();	
			try{
			 	if(intervalsCrs != null){	
			 		while(intervalsCrs.next()){	
			 					interuption = intervalsCrs.getString("name")!=null?intervalsCrs.getString("name"):"";
			 					startTime	= intervalsCrs.getString("start_ts")!=null?intervalsCrs.getString("start_ts").substring(0,16):"";
			 					endTime		= intervalsCrs.getString("end_ts")!=null?intervalsCrs.getString("end_ts").substring(0,16):"";
			 					duration	= intervalsCrs.getString("duration")!=null?intervalsCrs.getString("duration"):"0";	
					if(counter % 2 != 0){			 			
%>						<tr class="contentDark">
<%					}else{
%>						<tr class="contentLight">
<%					}
%>						
<%							if(!interuption.equalsIgnoreCase(intrName)){
								intrName = interuption;
%>				
								<td align=center><b><%=interuption%></b></td>
<%
							}else{
%>					
								<td>&nbsp;</td>
<%
							}
%>								
								<td align=center><%=startTime%></td>
								<td align=center><%=endTime%></td>
								<td align=center><%=duration%></td>
						</tr>
<%	 				intervalTime = intervalTime + Integer.parseInt(duration);
					counter ++;	
					}
				}
			}catch(Exception e){	
			 	log.writeErrLog(page.getClass(),matchId,e.toString());
			}
		}	
%>		
	<tr>
		<td colspan=4><u><font size="2" ><b>INTERRUPTION</b></font></u></td>
	</tr>
<% if (param.equalsIgnoreCase("date")){
			counter = 1;
			vparam.add(matchId);
			vparam.add("");
			vparam.add(paramDate);
			vparam.add("4");
			interuptionTime = 0;
			intervalsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_intervals",vparam,"ScoreDB");
			vparam.removeAllElements();	
			try{
			 	if(intervalsCrs != null){	
			 			while(intervalsCrs.next()){	
			 					interuption = intervalsCrs.getString("name")!=null?intervalsCrs.getString("name"):"";
			 					startTime	= intervalsCrs.getString("start_ts")!=null?intervalsCrs.getString("start_ts").substring(0,16):"";
			 					endTime		= intervalsCrs.getString("end_ts")!=null?intervalsCrs.getString("end_ts").substring(0,16):"";
			 					duration	= intervalsCrs.getString("duration")!=null?intervalsCrs.getString("duration"):"";	
						if(counter % 2 != 0){			 			
%>							<tr class="contentDark">
<%						}else{
%>							<tr class="contentLight">
<%						}
%>					
<%							if(!interuption.equalsIgnoreCase(intrName)){
								intrName = interuption;
%>				
								<td align=center><b><%=interuption%></b></td>
<%
							}else{
%>					
								<td>&nbsp;</td>
<%
							}
%>								
								<td align=center><%=startTime%></td>
								<td align=center><%=endTime%></td>
								<td align=center><%=duration%></td>
						</tr>
<%	 				interuptionTime = interuptionTime + Integer.parseInt(duration);
					counter ++;
				}
			}
		}catch(Exception e){	
		 	log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}else{
			counter = 1;
			vparam.add("");
			vparam.add(inningsId);
			vparam.add("");
			vparam.add("2");
			intervalsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_intervals",vparam,"ScoreDB");
			vparam.removeAllElements();	
			try{
			 	if(intervalsCrs != null){	
			 			while(intervalsCrs.next()){	
			 					interuption = intervalsCrs.getString("name")!=null?intervalsCrs.getString("name"):"";
			 					startTime	= intervalsCrs.getString("start_ts")!=null?intervalsCrs.getString("start_ts").substring(0,16):"";
			 					endTime		= intervalsCrs.getString("end_ts")!=null?intervalsCrs.getString("end_ts").substring(0,16):"";
			 					duration	= intervalsCrs.getString("duration")!=null?intervalsCrs.getString("duration"):"";	
					if(counter % 2 != 0){			 			
%>						<tr class="contentDark">
					<%}else{%>
						<tr class="contentLight">
					<%}%>
<%							if(!interuption.equalsIgnoreCase(intrName)){
								intrName = interuption;
%>				
								<td align=center><b><%=interuption%></b></td>
<%
							}else{
%>					
						 		<td>&nbsp;</td>
<%						      }
%>								
								<td align=center><%=startTime%></td>
								<td align=center><%=endTime%></td>
								<td align=center><%=duration%></td>
						</tr>
<%	 			interuptionTime = interuptionTime + Integer.parseInt(duration);
				counter ++;
				}
			}
		}catch(Exception e){	
		 	log.writeErrLog(page.getClass(),matchId,e.toString());
		} 
	}
	 
	 wkts      = new Integer(wkt);
	 totalWkt = wkts*2;
	 totalMin = interuptionTime + intervalTime + totalWkt;
%>						
						<tr>
							<td colspan="4">&nbsp;</td>
						</tr>
						<tr class="contentLight">
							<td colspan=4><font size="2" ><b>ALLOWANCES FOR WICKET TAKEN</b></font></td>
						</tr>
						<tr>
							<td colspan=4>&nbsp;&nbsp;<b><%=wkt%></b>&nbsp;wicket taken @ 2 minutes for each wicket &nbsp; <b><%=totalWkt%></b> &nbsp; mins</td>
						</tr>
						<tr>
							<td align=center>&nbsp;</td>
							<td align=center>&nbsp;</td>
							<td align=center>&nbsp;</td>
							<td align=right><b>TOTAL</b><b>&nbsp;&nbsp;&nbsp;&nbsp;<%=totalMin%></b>&nbsp;&nbsp;&nbsp;&nbsp;[B]</td>
						</tr>
					</table>
					<br>
					<table align=center width=100% style=border-collapse:collapse >
						<tr>
							<td align=right colspan=2><b>End of the innings or close of play on above day</b></td>
							<td align=right colspan=2>
						<%if(endInningTime!=""){%>
								<%=endInningTime.substring(0,16)%>&nbsp;&nbsp;&nbsp;&nbsp;<b>p.m[C]</b>							
						<%}else{%>
								&nbsp;
						<%	}%>
							</td>
						</tr>
<%
	lengthInning = Integer.parseInt(inningDuration) - totalMin;
%>					
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align=right colspan=2><b>Time Elapsed (before allowances)[C]-[A]</b></td>
							<td align=right><%=inningDuration%></td>
							<td align=right ><b>mins[D]</b></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align=right colspan=2><b>Total Allowances (including all intervals)[B]</b></td>
							<td align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=totalMin%></td>
							<td align=right ><b>mins[E]</b></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align=right colspan=2><b>Length of the innings (after allowances)[D]-[E]</b></td>
							<td align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=lengthInning%></td>
							<td align=right ><b>mins[F]</b></td>
						</tr>
<%	
	float length	=(int)lengthInning;
	overBowl 		= lengthInning / 4;
	roundOverBowl 	= Math.round(length/4);
%>						
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align=right colspan=2><b>Expected Over Bowled (ignore fractons)[F]/4</b></td>
							<td align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=overBowl%></td>
							<td align=right ><b>[G]</b></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align=right colspan=2><b>Actuals Overs Bowled (round up to next whole numbers)</b></td>
							<td align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=roundOverBowl%></td>
							<td align=right><b>[H]</b></td>
						</tr>
<%	
	int difference = 0;
	int roverBall  = (int)roundOverBowl;
	difference 	   = roverBall - overBowl;
%>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align=right colspan=2><b>Difference[H] - [G]</b></td>
							<td align=right><%=difference%></td>
						</tr>
					</table>
					<br>
			</table>
		</body>
</html>
