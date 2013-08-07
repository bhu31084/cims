<!--
Page Name 	 : jsp/ConciseBatting.jsp
Created By 	 : Bhushan Fegade.
Created Date : 07 April 2009
Description  : Data Entry for batting details.
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	SimpleDateFormat smf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String 	GSDate			=	sdf.format(new Date());
	String query = request.getParameter("query");
	String HidId = request.getParameter("HidId")==null?"0":request.getParameter("HidId");
	String MatchId = (String)session.getAttribute("matchId1");
	String cmbinning = request.getParameter("selinning")==null?"0":request.getParameter("selinning");
	
	String __inningId = "0";
	String __order = request.getParameter("order")==null?"0":request.getParameter("order");
	
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	Common commonUtil = new Common();
	LogWriter log = new LogWriter();
	Vector<Object> vparam = new Vector<Object>();
	CachedRowSet lobjCachedRowSet = null;
	CachedRowSet crsObjinning = null;
	CachedRowSet crsObjbattinglist = null;
	CachedRowSet wicketTypesCrs = null;
	CachedRowSet fielderNameCrs = null;
	CachedRowSet crsObjinningdeyails = null;
	CachedRowSet crsObjAddInning = null;
	CachedRowSet crsObjbatsmandetails = null;
	String msg = "";
	String Batsmen = request.getParameter("selBatsmen")==null?"0":request.getParameter("selBatsmen");
	String BattingNo = request.getParameter("selBattingNo")==null?"0":request.getParameter("selBattingNo");
	String starttime = request.getParameter("txtstarttime")==null? smf.format(new Date()) : request.getParameter("txtstarttime");
	String endtime = request.getParameter("txtendtime")==null? smf.format(new Date()) : request.getParameter("txtendtime");
	String HowOut = request.getParameter("selHowOut")==null?"0":request.getParameter("selHowOut");
	String FielderOne = request.getParameter("selFielderOne")==null?"0":request.getParameter("selFielderOne");
	String FielderTwo = request.getParameter("selFielderTwo")==null?"0":request.getParameter("selFielderTwo");
	String Bowler = request.getParameter("selBowler")==null?"0":request.getParameter("selBowler");
	String Mins = request.getParameter("txtMins")==null?"0":request.getParameter("txtMins");
	String Fours = request.getParameter("txtFours")==null?"0":request.getParameter("txtFours");
	String Six = request.getParameter("txtSix")==null?"0":request.getParameter("txtSix");
	String Balls = request.getParameter("txtBalls")==null?"0":request.getParameter("txtBalls");
	String Runs = request.getParameter("txtRuns")==null?"0":request.getParameter("txtRuns");
	
	if(HidId!=null && HidId.equalsIgnoreCase("1")){
		try{
			vparam.add(cmbinning);
		 	vparam.add(Batsmen);
		 	vparam.add(BattingNo);
		 	vparam.add(commonUtil.formatDate(starttime));
		 	vparam.add(commonUtil.formatDate(endtime));
		 	vparam.add(HowOut);
		 	vparam.add(Bowler);
		 	vparam.add(FielderOne);
		 	vparam.add(FielderTwo);
		 	vparam.add(Mins);
		 	vparam.add(Balls);
		 	vparam.add(Runs);
		 	vparam.add(Fours);
		 	vparam.add(Six);
		 	vparam.add("1"); //1 flag insert
		 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_concise_staticreport",vparam,"ScoreDB");
			vparam.removeAllElements();
			if(crsObjAddInning!=null){
				while(crsObjAddInning.next()){
			  		msg = crsObjAddInning.getString("result");
			  	}
			}
		}catch(Exception e){
		  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}else if(HidId!=null && HidId.equalsIgnoreCase("2")){
		// Insert player detail.
		
		/*
		2	st	Stumped
		3	st	Wide + Stumped
		4	ct	Caught		
		6	ct wk	Caught by WicketKeeper
		21	run out	Run Out
		22	run out	Wide + Run Out
		23	run out	No Ball + Run Out
		27	run out	Byes + Run Out
		28	run out	LegByes + Run Out		
		
		----- fielders not required -----
		1	b	Bowled
		5	ct&b	Caught by Bowler
		7	Hit The Ball Twice	Hit The Ball Twice
		8	hit wkt	Hit Wicket
		9	lbw	Leg Before Wicket
		10	Handled the Ball	Handled the Ball
		11	Obstructing The Field	Obstructing The Field
		12	Timed Out	Timed Out
		13	Handled the Ball	Wide + Handled the Ball
		14	Obstructing The Field	Wide + Obstructing The Field
		15	Handled the Ball	No Ball +  Handled the Ball
		18	Obstructing The Field	No Ball + Obstructing The Field
		19	hit wkt	Wide + Hit Wicket
		20	Hit The Ball Twice	No Ball + Hit The Ball Twice
		24	retires	retires
		25	Retired Out	Retired Out
		26	Absent Hurt 	Absent Hurt		
		
		----- Bowler not required ------
		12	Timed Out	Timed Out
		
		*/
		try{
			vparam.add(cmbinning);
		 	vparam.add(Batsmen);
		 	vparam.add(BattingNo);
	 	    vparam.add(commonUtil.formatDate(starttime));
		 	vparam.add(commonUtil.formatDate(endtime));
		 	vparam.add(HowOut);
		 	if(HowOut.equals("12") || HowOut.equals("0")){
		 		vparam.add("");
		 	}else{
		 		vparam.add(Bowler);	
		 	}
		    
		 	if(HowOut.equals("1") || HowOut.equals("5") || HowOut.equals("7") || HowOut.equals("8")  || HowOut.equals("9")
		 			 || HowOut.equals("10") || HowOut.equals("11") || HowOut.equals("12") || HowOut.equals("13")
		 			 || HowOut.equals("14") || HowOut.equals("15") || HowOut.equals("18") || HowOut.equals("19")
		 			 || HowOut.equals("20") || HowOut.equals("24") || HowOut.equals("25") || HowOut.equals("26") 
		 			 || HowOut.equals("0")){
		 		vparam.add("");
		 		vparam.add("");
		 	} else {
		 		vparam.add(FielderOne);
		 		vparam.add(FielderTwo);
		 	}
		 	vparam.add(Mins);
		 	vparam.add(Balls);
		 	vparam.add(Runs);
		 	vparam.add(Fours);
		 	vparam.add(Six);
		 	vparam.add("2"); //1 flag update
		 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_concise_staticreport",vparam,"ScoreDB");
			vparam.removeAllElements();
			if(crsObjAddInning!=null){
				while(crsObjAddInning.next()){
			  		msg = crsObjAddInning.getString("result");
				}
			}
		}catch(Exception e){
		  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}
	else if(HidId!=null && HidId.equalsIgnoreCase("3")){
		 try{
			 vparam.add(cmbinning);
		 	 vparam.add(Batsmen);
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("3"); //1 flag insert
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_concise_staticreport",vparam,"ScoreDB");
			 vparam.removeAllElements();
			 if(crsObjAddInning!=null){
			  		while(crsObjAddInning.next()){
			  			msg = crsObjAddInning.getString("result");
			  		}
			 }
		 }catch(Exception e){
		  log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}else if(HidId!=null && HidId.equalsIgnoreCase("4")){
		try{
		 vparam.add(cmbinning);
		 vparam.add(Batsmen); //1 flag for display match wise data
	 	 crsObjbatsmandetails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concisebatsmandetails",vparam,"ScoreDB");
	  	 vparam.removeAllElements();
		  	 if(crsObjbatsmandetails!=null && crsObjbatsmandetails.next()){
			  	 	cmbinning = crsObjbatsmandetails.getString("inning")==null?"0":crsObjbatsmandetails.getString("inning");
			  	 	Batsmen  = crsObjbatsmandetails.getString("batter")==null?"": crsObjbatsmandetails.getString("batter");
				  	BattingNo  = crsObjbatsmandetails.getString("batting_order")==null?"": crsObjbatsmandetails.getString("batting_order");
				  	starttime = crsObjbatsmandetails.getString("time_in")==null?"": crsObjbatsmandetails.getString("time_in");
			  	 	endtime = crsObjbatsmandetails.getString("time_out")==null?"": crsObjbatsmandetails.getString("time_out");
			  	 	HowOut = crsObjbatsmandetails.getString("dismissal_type")==null?"0": crsObjbatsmandetails.getString("dismissal_type");
			  	 	FielderOne = crsObjbatsmandetails.getString("dismissal_fielder1")==null?"0": crsObjbatsmandetails.getString("dismissal_fielder1");
			  	 	FielderTwo = crsObjbatsmandetails.getString("dismissal_fielder2")==null?"0": crsObjbatsmandetails.getString("dismissal_fielder2");
			  	 	Bowler = crsObjbatsmandetails.getString("dismissal_bowler")==null?"0": crsObjbatsmandetails.getString("dismissal_bowler");
			  	 	Mins = crsObjbatsmandetails.getString("minutes")==null?"0": crsObjbatsmandetails.getString("minutes");
			  	 	Fours = crsObjbatsmandetails.getString("fours")==null?"0": crsObjbatsmandetails.getString("fours");
			  	 	Six = crsObjbatsmandetails.getString("sixes")==null?"0": crsObjbatsmandetails.getString("sixes");
		 			Balls = crsObjbatsmandetails.getString("balls_played")==null?"0": crsObjbatsmandetails.getString("balls_played");
			  	 	Runs = crsObjbatsmandetails.getString("runs_made")==null?"0": crsObjbatsmandetails.getString("runs_made");
			}
		  	starttime = Common.changeDate(starttime);
  	 		endtime = Common.changeDate(endtime);
		}catch(Exception e){
		  log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}
	
	if(HidId!=null && (HidId.equalsIgnoreCase("1") || HidId.equalsIgnoreCase("2") || HidId.equalsIgnoreCase("3"))){
		response.sendRedirect("/cims/jsp/concise/ConciseMatchTab.jsp?tab=3&inning="+cmbinning);
		return;
	}
	
	
	// Fetch all inning ids for given match id.
	try{
		vparam.add(MatchId);
	 	vparam.add("1"); //1 flag for display match wise data
	 	crsObjinning = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_innings",vparam,"ScoreDB");
	  	vparam.removeAllElements();
	}catch(Exception e){
	  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
	}
	
	// Wicket type
	try{
	 	vparam.add("1");
	 	wicketTypesCrs = lobjGenerateProc.GenerateStoreProcedure("dsp_types",vparam,"ScoreDB");
	  	vparam.removeAllElements();
	}catch(Exception e){
	  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
	}
	
%>


<html>
  	<head>
    	<title>Batting Details</title>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="../../css/concise.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
			  A { text-decoration:none;}
			  A:link	{color:black;}
			  A:visited{color: blue;}
			  A:hover	{color: red;background-color:#66ffff;}
			 .tab { font-weight:bold;font-size:9px; font-family:Arial,Helvetica;color:olive;}
			 .tabc { font-weight:bold; font-size:9px; text-align:center; font-family:Arial,Helvetica;color:navy;}
			 .tabb { font-weight:bold; font-size:9px; font-family:Arial,Helvetica;}
			 .tanc {FONT-WEIGHT: bold;FONT-SIZE: 9px; COLOR: navy; FONT-FAMILY: Arial,Helvetica; TEXT-ALIGN: center;}
			 .tabt { font-weight:bold; font-size:9px; font-family:Arial,Helvetica;TEXT-ALIGN: center;}
	  	</style>		
  <%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
	</head>
	
	
<!--  	<body onload="wicketTypeChanged()">-->
  	<body>
  	
	  	<!-- ************************************ Entry Module ************************************ -->
  
		<div style="overflow:auto;height:12em;width:82em;">
    		<table style="width:82em;" border="0"  cellspacing="1" cellpadding="3">
	  			<tr>
        			<td colspan="15"  width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          				<center>Batting Details Entry Module</center>
        			</td>
      			</tr>
       			<tr>
        			<td colspan="15" width="100%" >
          				<center><font color="red"><b><%=msg%></b></font></center>
        			</td>
      			</tr>
      			
				<!-- Static content -->
      			<tr bgcolor="#f0f7ff">
			        <td align="center" width="8%">Innings</td>
			        <td align="center" width="18%">Batsmen</td>
			        <td align="center" width="3%">Order</td>
			        <td align="center" width="12%">Time In</td>
			        <td align="center" width="12%">Time Out</td>
			        <td align="center" width="8%">How Out</td>
					<td align="center" width="8%">Fielder 1</td>
					<td align="center" width="8%">Fielder 2</td>
					<td align="center" width="8%">Bowler</td>
					<td align="center" width="4%">Mins</td>
					<td align="center" width="3%">4</td>
					<td align="center" width="3%">6</td>
					<td align="center" width="6%">Balls</td>
					<td align="center" width="6%">Runs</td>
					<td align="center" width="6%">&nbsp;</td>
      			</tr>
      			
				<!--  -->
      			<tr bgcolor="#e6f1fc">
        			<td align="center">
         				<select id="selinning" name="selinning" tabindex="1" onchange="inningbatting('5');">
			<%try{
		 		if(crsObjinning!=null){
		 			if(cmbinning.equals("0")){		 				
		  				for(int i = 1; crsObjinning.next(); i++){
		  					if(i == 1){
		  						__inningId = crsObjinning.getString("id");
		  					}%>
  							<option value="<%=crsObjinning.getString("id")%>">Inning <%=i%></option>
  						<%}		 				
		 			}else{
		  				for(int i = 1; crsObjinning.next(); i++){%>
  							<option value="<%=crsObjinning.getString("id")%>" <%= crsObjinning.getString("id").equalsIgnoreCase(cmbinning)?"selected":""%>>Inning <%=i%></option>
  						<%}
		  				__inningId = cmbinning;
		 			}
		 		}
		 	}catch(Exception e){
		 		log.writeErrLog(page.getClass(),MatchId,e.toString());
		 	}%>
          				</select>
        			</td>
        			
        			<%        			
        			// Fetch Player Statistics
        			try{
        				vparam.add(__inningId);
        			 	crsObjinningdeyails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_playerstaticstic",vparam,"ScoreDB");
        			  	vparam.removeAllElements();
        			}catch(Exception e){
        			  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
        			}
        			
        			List<ArrayList<String>> playerList = new ArrayList<ArrayList<String>>();
        			List<String> usedOrder = new ArrayList<String>();
        			List<String> usedPlayerId = new ArrayList<String>();
        			
        			while(crsObjinningdeyails.next()){
        				ArrayList<String> playerDetail = new ArrayList<String>();
        				playerDetail.add(crsObjinningdeyails.getString("inning") == null? "-" : crsObjinningdeyails.getString("inning"));
        				playerDetail.add(crsObjinningdeyails.getString("battername") == null? "-" : crsObjinningdeyails.getString("battername"));
        				playerDetail.add(crsObjinningdeyails.getString("batting_order") == null? "-" : crsObjinningdeyails.getString("batting_order"));
        				playerDetail.add(crsObjinningdeyails.getString("time_in")==null? "-" : crsObjinningdeyails.getString("time_in"));
        				playerDetail.add(crsObjinningdeyails.getString("time_out")==null? "-" : crsObjinningdeyails.getString("time_out"));
        				playerDetail.add(crsObjinningdeyails.getString("dismissal_typename")==null?"Not Out":crsObjinningdeyails.getString("dismissal_typename"));
        				playerDetail.add(crsObjinningdeyails.getString("dismissal_fielder1name")==null?"-":crsObjinningdeyails.getString("dismissal_fielder1name"));
        				playerDetail.add(crsObjinningdeyails.getString("dismissal_fielder2name")==null?"-":crsObjinningdeyails.getString("dismissal_fielder2name"));
        				playerDetail.add(crsObjinningdeyails.getString("dismissal_bowlername")==null?"-":crsObjinningdeyails.getString("dismissal_bowlername"));
        				playerDetail.add(crsObjinningdeyails.getString("minutes")==null?"-":crsObjinningdeyails.getString("minutes"));
        				playerDetail.add(crsObjinningdeyails.getString("fours")==null?"-":crsObjinningdeyails.getString("fours"));
        				playerDetail.add(crsObjinningdeyails.getString("sixes")==null?"-":crsObjinningdeyails.getString("sixes"));
        				playerDetail.add(crsObjinningdeyails.getString("balls_played")==null?"-":crsObjinningdeyails.getString("balls_played"));
        				playerDetail.add(crsObjinningdeyails.getString("runs_made")==null?"-":crsObjinningdeyails.getString("runs_made"));
        				playerDetail.add(crsObjinningdeyails.getString("batter"));		
        				playerList.add(playerDetail);
        				
        				usedPlayerId.add(playerDetail.get(14));
        				usedOrder.add(playerDetail.get(2));
        			}
        			
        			/***************** Inning wise data ******************/
        			
        			// Batting team player list for selected inning id
        			try{
        			 	vparam.add(__inningId);
        			 	crsObjbattinglist = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenList",vparam,"ScoreDB");
        			  	vparam.removeAllElements();
        			}catch(Exception e){
        			  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
        			}
        			
        			// Bowling team player list for selected inning id.
        			try{
        			 	vparam.add(__inningId);
        			 	fielderNameCrs = lobjGenerateProc.GenerateStoreProcedure("dsp_fieldlist",vparam,"ScoreDB");
        			  	vparam.removeAllElements();
        			}catch(Exception e){
        			  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
        			}%>
        			
        			<!-- Batsman List -->
        			<td align="center">
        			<%if(!Batsmen.equals("0")){%>
        					
			<%try{
	  			if(crsObjbattinglist!=null){
	  				while(crsObjbattinglist.next()){
	  					if(crsObjbattinglist.getString("id").equals(Batsmen)){%>
	  						<label><%=crsObjbattinglist.getString("playername")%></label>
	  					<%}
	  				}
		    	}
		 	}catch(Exception e){
	 			log.writeErrLog(page.getClass(),MatchId,e.toString());
		 	}%>
						<input type="hidden" value="<%=Batsmen%>" id="selBatsmen" name="selBatsmen" />
        			<%} else {%>
        				<select id="selBatsmen" name="selBatsmen" tabindex="2">
			<%try{
	  			if(crsObjbattinglist!=null){
	  				while(crsObjbattinglist.next()){
	  					if(!usedPlayerId.contains(crsObjbattinglist.getString("id"))){%>
	  						<option value="<%=crsObjbattinglist.getString("id")%>" <%= crsObjbattinglist.getString("id").equalsIgnoreCase(Batsmen)?"selected":"" %>>
						<%=crsObjbattinglist.getString("playername")%></option>
	  					<%}
	  				}
		    	}
		 	}catch(Exception e){
	 			log.writeErrLog(page.getClass(),MatchId,e.toString());
		 	}%>
          				</select>
        			<%}%>
          				
        			</td>
        			
        			<!-- Batting Order -->
					<td align="center">
          				<select id="selBattingNo" name="selBattingNo" tabindex="3">
			<%for(int i = 1; i <= 11; i++){
				if(!usedOrder.contains("" + i) || BattingNo.equals("" + i)){%>
					<option value="<%=i%>" <%=BattingNo.equalsIgnoreCase(""+i+"")?"selected":""%>><%=i%></option>
				<%}
				}%>
          				</select>
        			</td>
        			
        			<!-- In Time -->
					<td align="center" nowrap="nowrap">
	           			<input type="text" name="txtstarttime" id="txtstarttime" value="<%=starttime%>" class="textBox" tabindex="4">
	          			<a id="imganchor" name="imganchor" href="javascript:NewCal('txtstarttime','ddmmyyyy',true,24)">
	          			<IMG src="../../images/cal.gif" border="0"></a>
	       			</td>
	       			
	       			<!-- Out Time -->
					<td align="center" nowrap="nowrap">
	          			<input type="text" name="txtendtime" id="txtendtime" value="<%=endtime%>" class="textBox" tabindex="5">
	          			<a id="imganchor" name="imganchor" href="javascript:NewCal('txtendtime','ddmmyyyy',true,24)">
	          			<IMG src="../../images/cal.gif" border="0"></a>
	       			</td>
	       			
	       			<!-- Wicket type -->
					<td align="center">
	          			<select id="selHowOut" name="selHowOut" tabindex="6" onchange="wicketTypeChanged()">
	          				<option value="0">Not Out</option>
			<%try{
	  			if(wicketTypesCrs!=null){
	  				while(wicketTypesCrs.next()){%>
	  						<option value="<%=wicketTypesCrs.getString("id")%>" 
					<%=wicketTypesCrs.getString("id").equalsIgnoreCase(HowOut)?"selected":""%>>
			<%=wicketTypesCrs.getString("description")%></option>
					<%}// end of while
		    	}
		 	}catch(Exception e){
	 			log.writeErrLog(page.getClass(),MatchId,e.toString());
		 	}%>
	          			</select>
					</td>
					
					<!-- First fielder -->
					<td align="center">
						<select id="selFielderOne" name="selFielderOne" tabindex="7" >
			<%try{
	  			if(fielderNameCrs!=null){
	  				while(fielderNameCrs.next()){%>
							<option value="<%=fielderNameCrs.getString("id")%>"
							<%=fielderNameCrs.getString("id").equalsIgnoreCase(FielderOne)?"selected":""%>>
			<%=fielderNameCrs.getString("playername")%></option>
					<%}// end of while
					fielderNameCrs.first();
		    	}
		 	}catch(Exception e){
	 			log.writeErrLog(page.getClass(),MatchId,e.toString());
		 	}%>
						</select>
	        		</td>
	        		
	        		<!-- Second Fielder -->
	        		<td align="center">
	          			<select id="selFielderTwo" name="selFielderTwo" tabindex="8">
	          				<option value = "0">Select</option>
			<%try{
	  			if(fielderNameCrs!=null){
	  				int i = 0;
	  				while(fielderNameCrs.next()){    
	  					if(i==0){
	 						fielderNameCrs.first();
	  					}%>
  							<option value="<%=fielderNameCrs.getString("id")%>" <%=fielderNameCrs.getString("id").equalsIgnoreCase(FielderTwo)?"selected":""%>><%=fielderNameCrs.getString("playername")%></option>
						<%i++;
					}
					fielderNameCrs.first();
		    	}
		 	}catch(Exception e){
	 			log.writeErrLog(page.getClass(),MatchId,e.toString());
		 	}%>             
						</select>
	        		</td>
	        		
	        		<!-- Bowler -->
					<td align="center">
						<select id="selBowler" name="selBowler" tabindex="9">
			<%try{
	  			if(fielderNameCrs!=null){
	  				int i = 0;
	  				while(fielderNameCrs.next()){    
	  					if(i==0){
	 						fielderNameCrs.first();
	  					}%>          
							<option value="<%=fielderNameCrs.getString("id")%>" <%=fielderNameCrs.getString("id").equalsIgnoreCase(Bowler)?"selected":""%>><%=fielderNameCrs.getString("playername")%></option>
					<%i++;
					}// end of while
		    	}
		 	}catch(Exception e){
	 			log.writeErrLog(page.getClass(),MatchId,e.toString());
		 	}%>
						</select>
					</td>
					
					
	        		<td align="center">
	          			<input type="text" name="txtMins" id="txtMins" onfocus="clearTextBox('txtMins')" onblur="fillZero('txtMins')" value="<%=Mins%>" class="smalltextBox" tabindex="10" onKeyPress="return keyRestrict(event,'1234567890');">
	        		</td>
					<td align="center">
		          		<input type="text" name="txtFours" id="txtFours" onfocus="clearTextBox('txtFours')" onblur="fillZero('txtFours')"  value="<%=Fours%>" class="smalltextBox" tabindex="11" onKeyPress="return keyRestrict(event,'1234567890');">
	    	    	</td>
					<td align="center">
		          		<input type="text" name="txtSix" id="txtSix" onfocus="clearTextBox('txtSix')" onblur="fillZero('txtSix')"  value="<%=Six%>" class="smalltextBox" tabindex="12" onKeyPress="return keyRestrict(event,'1234567890');">
		        	</td>
					<td align="center">
		          		<input type="text" name="txtBalls" id="txtBalls" onfocus="clearTextBox('txtBalls')" onblur="fillZero('txtBalls')"  value="<%=Balls%>" class="smalltextBox" tabindex="13" onKeyPress="return keyRestrict(event,'1234567890');">
		        	</td>
					<td align="center">
		          		<input type="text" name="txtRuns" id="txtRuns" onfocus="clearTextBox('txtRuns')" onblur="fillZero('txtRuns')"  value="<%=Runs%>" class="smalltextBox" tabindex="14" onKeyPress="return keyRestrict(event,'1234567890');">
		        	</td>
		        	<td align="center">
		<%if(HidId!=null && HidId.equalsIgnoreCase("4")){%>				
						<input type="button" name="btnadd" id="btnadd" value=" SAVE " class="btn" tabindex="15" onclick="addinningdetails(2);">
		<%}else{%>				
						<input type="button" name="btnadd" id="btnadd" value=" ADD " class="btn" tabindex="15" onclick="addinningdetails(1);">
		<%}%>
					</td>
      			</tr>
   			</table>
		</div>
    
    
    <!-- ************************************ Batsman's detail view ************************************ -->
    
	    <div id="viewdiv" style="overflow:auto;height:20em;width:82em;">
	    <table style="width:82em" border="0"  cellspacing="1" >
	  		<tr>
				<td colspan="16"  width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
	          		<center>Batsman's Detail</center>
	        	</td>
	      </tr>
	      <tr bgcolor="#f0f7ff">
<!--	        	<td align="center" width="5%"><b>Inning</b></td>-->
	        	<td align="center" width="10%"><b>Batsmen</b></td>
	        	<td align="right" width="3%"><b>Order</b></td>
	        	<td align="center" width="15%"><b>In Time</b></td>
	        	<td align="center" width="15%"><b>Out Time</b></td>
	        	<td align="center" width="8%"><b>How Out</b></td>
				<td align="center" width="12%"><b>Fielder 1</b></td>
				<td align="center" width="12%"><b>Fielder 2</b></td>
				<td align="center" width="8%"><b>Bowler</b></td>
				<td align="right" width="4%"><b>Mins</b></td>
				<td align="right" width="3%"><b>4</b></td>
				<td align="right" width="3%"><b>6</b></td>
				<td align="center" width="6%"><b>Balls</b></td>
				<td align="center" width="6%"><b>Runs</b></td>
				<td align="center"><b></b></td>
	        	<td align="center"><b></b></td>
	      </tr>
	      
	      <%try{
				int i = 1;
				for(ArrayList<String> playerDetail : playerList){
					if(i%2==0){%>
			<tr bgcolor="#f0f7ff">
					<%}else{%>	  
			<tr bgcolor="#e6f1fc">	
					<%}%>
<!--				<td align="center"><%=playerDetail.get(0)%></td>-->
       			<td align="right"><%=playerDetail.get(1)%></td>
        		<td align="center"><%=playerDetail.get(2)%></td>
		        <td align="center"><%=playerDetail.get(3)%></td>
		        <td align="center"><%=playerDetail.get(4)%></td>
		        <td align="center"><%=playerDetail.get(5)%></td>
		        <td align="center"><%=playerDetail.get(6)%></td>
		        <td align="center"><%=playerDetail.get(7)%></td>
		        <td align="right"><%=playerDetail.get(8)%></td>
		        <td align="right"><%=playerDetail.get(9)%></td>
		        <td align="right"><%=playerDetail.get(10)%></td>
		        <td align="right"><%=playerDetail.get(11)%></td>
		        <td align="right"><%=playerDetail.get(12)%></td>
		        <td align="right"><%=playerDetail.get(13)%></td>
				<td align="center">
					<a href="/cims/jsp/concise/ConciseMatchTab.jsp?tab=3&inning=<%=playerDetail.get(0)%>&HidId=4&selBatsmen=<%=playerDetail.get(14)%>&order=<%=playerDetail.get(2)%>">Edit</a>
				</td>
		        <td align="center" >
		        	<a href="/cims/jsp/concise/ConciseBatting.jsp?selinning=<%=playerDetail.get(0)%>&HidId=3&selBatsmen=<%=playerDetail.get(14)%>&order=<%=playerDetail.get(2)%>">Delete</a>
	        	</td>
      		</tr>
      				<%i++;
				}
     	}catch(Exception e){
	  		log.writeErrLog(page.getClass(),MatchId,e.toString());
		}%>
  
    		</table>
    		<input type="hidden" name="HidId" id="HidId" value="0" />
    	</div>        
  	</body>  
</html>