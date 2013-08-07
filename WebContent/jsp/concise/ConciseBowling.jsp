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
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String GSDate = sdf.format(new Date());
	String query = request.getParameter("query");
	String HidId = request.getParameter("HidId")==null?"0":request.getParameter("HidId");
	String MatchId = (String)session.getAttribute("matchId1");
	String cmbinning = request.getParameter("selinning")==null?"0":request.getParameter("selinning");
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	Common commonUtil = new Common();
	LogWriter log = new LogWriter();
	Vector<String> vparam = new Vector<String>();
	CachedRowSet crsObjinning = null;
	CachedRowSet fielderNameCrs	= null;
	CachedRowSet bowlerstaticsticCrs = null;
	CachedRowSet crsObjAddInning = null;
	CachedRowSet crsObjbatsmandetails =	null;
	String msg = "";

	String __inningId = "0";
	
	String Bowler = request.getParameter("selBowler")==null?"0":request.getParameter("selBowler");	
	String bowlingNo = request.getParameter("selbowlingNo")==null?"0":request.getParameter("selbowlingNo");
	String Overs = request.getParameter("txtOvers")==null?"0":request.getParameter("txtOvers");
	String Maidens = request.getParameter("txtMaidens")==null?"0":request.getParameter("txtMaidens");
	String Runs = request.getParameter("txtRuns")==null?"0":request.getParameter("txtRuns");
	String Wickets = request.getParameter("txtWickets")==null?"0":request.getParameter("txtWickets");
	String noball = request.getParameter("txtnoball")==null?"0":request.getParameter("txtnoball");
	String wideball = request.getParameter("txtwideball")==null?"0":request.getParameter("txtwideball");
	if(HidId!=null && HidId.equalsIgnoreCase("1")){
		try{
		 	vparam.add(cmbinning);
		 	vparam.add(Bowler);
		 	vparam.add(bowlingNo);
		 	vparam.add(Overs);
		 	vparam.add(Maidens);
		 	vparam.add(Runs);
		 	vparam.add(Wickets);
		 	vparam.add(noball);
		 	vparam.add(wideball);
		 	vparam.add("1"); //1 flag insert
		 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_bolwerstaticstic",vparam,"ScoreDB");
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
		try{
		 	vparam.add(cmbinning);
		 	vparam.add(Bowler);
		 	vparam.add(bowlingNo);
		 	vparam.add(Overs);
		 	vparam.add(Maidens);
		 	vparam.add(Runs);
		 	vparam.add(Wickets);
		 	vparam.add(noball);
		 	vparam.add(wideball);
		 	vparam.add("2"); //2flag update
		 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_bolwerstaticstic",vparam,"ScoreDB");
			vparam.removeAllElements();
			if(crsObjAddInning!=null){
			  	while(crsObjAddInning.next()){
			  		msg = crsObjAddInning.getString("result");
				}
			}
		}catch(Exception e){
		  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}else if(HidId!=null && HidId.equalsIgnoreCase("3")){
		try{
		 	vparam.add(cmbinning);
		 	vparam.add(Bowler);
		 	vparam.add("");
		 	vparam.add("0.0");
		 	vparam.add("");
		 	vparam.add("");
		 	vparam.add("");
		 	vparam.add("");
		 	vparam.add("");
		 	vparam.add("3"); //3 for delete
		 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_bolwerstaticstic",vparam,"ScoreDB");
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
			vparam.add(Bowler); //1 flag for display match wise data
	 	 	crsObjbatsmandetails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_bowler_report",vparam,"ScoreDB");
	  	 	vparam.removeAllElements();
	  	 	if(crsObjbatsmandetails!=null){
	  	 		while(crsObjbatsmandetails.next()){
			  	 	cmbinning = crsObjbatsmandetails.getString("inning")==null?"0":crsObjbatsmandetails.getString("inning");
			  	 	Bowler	  = crsObjbatsmandetails.getString("bowler")==null?"0": crsObjbatsmandetails.getString("bowler");
				  	bowlingNo   = crsObjbatsmandetails.getString("bowling_order")==null?"0": crsObjbatsmandetails.getString("bowling_order");
				  	Overs  = crsObjbatsmandetails.getString("overs")==null?"0": crsObjbatsmandetails.getString("overs");
			  	 	Maidens  = crsObjbatsmandetails.getString("maidens")==null?"": crsObjbatsmandetails.getString("maidens");
			  	 	Runs  = crsObjbatsmandetails.getString("runs_given")==null?"0": crsObjbatsmandetails.getString("runs_given");
			  	 	Wickets  = crsObjbatsmandetails.getString("no_balls")==null?"0": crsObjbatsmandetails.getString("no_balls");
			  	 	noball  = crsObjbatsmandetails.getString("wide_balls")==null?"0": crsObjbatsmandetails.getString("wide_balls");
			  	 	wideball  = crsObjbatsmandetails.getString("num_wickets")==null?"0": crsObjbatsmandetails.getString("num_wickets");
	  	 		}
	  	 	}
		}catch(Exception e){
		  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}	
	
	try{
	 	vparam.add(MatchId);
	 	vparam.add("1"); //1 flag for display match wise data
	 	crsObjinning = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_innings",vparam,"ScoreDB");
	  	vparam.removeAllElements();
	}catch(Exception e){
	  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
	}
%>	
<html>
  <head>
    <title>Bowling Details</title>
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
  	<body>
  	
  	
  	<!-- *************** Entry module *************** -->
		<div style="height:10em">
   			<table style="width:70em;" border="0"  cellspacing="1" cellpadding="3">
	  			<tr>
			        <td colspan="10" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
			          	<center>Bowling Details Entry Module</center>
			        </td>
      			</tr> 
       			<tr>
			        <td colspan="10" width="100%" >
			          	<center><font color="red"><b><%=msg%></b></font></center>
			        </td>
      			</tr>
				<tr bgcolor="#f0f7ff">
			        <td align="center" width="10%">Innings</td>
			        <td align="center" width="10%">Bowler</td>
			        <td align="center" width="10%">Bowler Order</td>
			        <td align="center" width="10%">Overs</td>
			        <td align="center" width="10%">Maidens</td>
			        <td align="center" width="10%">Runs</td>
			        <td align="center" width="10%">No Balls</td>
			        <td align="center" width="10%">Wide Balls</td>
					<td align="center" width="10%">Wickets</td>
			        <td align="center" width="10%">&nbsp;</td>
      			</tr>
      			<tr bgcolor="#e6f1fc">
      			
      			
      				<!-- *************** Innings in drop down list *************** -->
        			<td align="center">
						<select id="selinning" name="selinning" tabindex="1" onchange="inningbowling('5');">
						
		 				
		 				
		 				<%try{	
		 					if(crsObjinning!=null){
		 						if(cmbinning.equals("0")){
		 							for(int i = 1; crsObjinning.next(); i++){
		 								if(i == 1){
		 									__inningId = crsObjinning.getString("id");
		 								}
		 							%>		 							
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
        			
        			// Getting Bowler/fielder list from database. 
        			try{
        			 	vparam.add(__inningId);
        			 	fielderNameCrs = lobjGenerateProc.GenerateStoreProcedure("dsp_fieldlist",vparam,"ScoreDB");
        			  	vparam.removeAllElements();
        			}catch(Exception e){
        			  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
        			}
        			
        			try{
        			 	vparam.add(__inningId);
        			 	bowlerstaticsticCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowler_staticsticreport",vparam,"ScoreDB");
        			  	vparam.removeAllElements();
        			}catch(Exception e){
        			  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
        			}
        			if(HidId!=null && (HidId.equalsIgnoreCase("1") || HidId.equalsIgnoreCase("2") || HidId.equalsIgnoreCase("3"))){
        				response.sendRedirect("/cims/jsp/concise/ConciseMatchTab.jsp?tab=4&inning="+cmbinning);
        				return;
        			} %>
        			
        			
					<!-- *************** Bowlers in drop down list *************** -->        			
        			<td align="center">
          				<select id="selBowler" name="selBowler" tabindex="2">
<%	  	  try{
	  		if(fielderNameCrs!=null){
	  		while(fielderNameCrs.next()){%>
							<option value="<%=fielderNameCrs.getString("id")%>" <%= fielderNameCrs.getString("id").equalsIgnoreCase(Bowler)?"selected":"" %>>
			<%=fielderNameCrs.getString("playername")%></option>
					<%	}
					}
		 		}catch(Exception e){
	 				log.writeErrLog(page.getClass(),MatchId,e.toString());
		 		}%>
						</select>
        			</td>
       				<td align="center">
						<select id="selbowlingNo" name="selbowlingNo" tabindex="3">
				<%for(int i=1;i<12;i++){%>
							<option value="<%=i%>" <%=bowlingNo.equalsIgnoreCase(""+i+"")?"selected":""%>><%=i%></option>
				<%}%>
          				</select>
        			</td>
			        <td align="center">
			          	<input type="text" name="txtOvers" id="txtOvers" value="<%=Overs%>" class="textBox" tabindex="4" onKeyPress="return keyRestrict(event,'1234567890.');" onfocus="clearTextBox('txtOvers')" onblur="fillZero('txtOvers')">
			        </td>
			        <td align="center">
			          	<input type="text" name="txtMaidens" id="txtMaidens" value="<%=Maidens%>" class="textBox" tabindex="5" onKeyPress="return keyRestrict(event,'1234567890');" onfocus="clearTextBox('txtMaidens')" onblur="fillZero('txtMaidens')">
			        </td>
					 <td align="center">
			          	<input type="text" name="txtRuns" id="txtRuns" value="<%=Runs%>" class="textBox" tabindex="6" onKeyPress="return keyRestrict(event,'1234567890');" onfocus="clearTextBox('txtRuns')" onblur="fillZero('txtRuns')">
			        </td>
			        <td align="center">
			          	<input type="text" name="txtWickets" id="txtWickets" value="<%=Wickets%>" class="textBox" tabindex="7" onKeyPress="return keyRestrict(event,'1234567890');" onfocus="clearTextBox('txtWickets')" onblur="fillZero('txtWickets')">
			        </td>
			        <td align="center">
			          	<input type="text" name="txtnoball" id="txtnoball" value="<%=noball%>" class="textBox" tabindex="8" onKeyPress="return keyRestrict(event,'1234567890');" onfocus="clearTextBox('txtnoball')" onblur="fillZero('txtnoball')">
			        </td>
					<td align="center">
			          	<input type="text" name="txtwideball" id="txtwideball" value="<%=wideball%>" class="textBox" tabindex="9" onKeyPress="return keyRestrict(event,'1234567890');" onfocus="clearTextBox('txtwideball')" onblur="fillZero('txtwideball')">
			        </td>
        			<td align="center">
			<%if(HidId!=null && HidId.equalsIgnoreCase("4")){%>
						<input type="button" name="btnadd" id="btnadd" value="Edit" class="btn" tabindex="10" onclick="addbowlingdetails(2);">
			<%}else{%>
						<input type="button" name="btnadd" id="btnadd" value="Add" class="btn" tabindex="10" onclick="addbowlingdetails(1);">
			<%}%>
        			</td>
      			</tr>
    		</table>
     	</div>
     	
     	
     	
		<!-- *************** Static data : Bowler detail for selected inning *************** -->
     	
    	<div id="viewdiv" style="overflow: auto; height:20em;" >
			<table style="width:70em;" border="0"  cellspacing="1" cellpadding="3" >
			  	<tr>
			        <td colspan="11" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
			          	<center>View Data</center>
			        </td>
		      	</tr>
		      	<tr bgcolor="#f0f7ff">
			        <td align="right"><b>Innings</b></td>
			        <td align="center"><b>Bowler</b></td>
			        <td align="right"><b>Order</b></td>
			        <td align="right"><b>Overs</b></td>
			        <td align="right"><b>Maidens</b></td>
			        <td align="right"><b>Runs</b></td>
			        <td align="right"><b>No Ball </b></td>
					<td align="right"><b>Wide Ball</b></td>
					<td align="right"><b>Wickets</b></td>
			        <td align="center"><b>Edit</b></td>
			        <td align="center"><b>Delete</b></td>
		      	</tr>
		<%try{
	  if(bowlerstaticsticCrs!=null){
	  int i = 1;
	  	while(bowlerstaticsticCrs.next()){		
	  		if(i%2==0){%>    		
	  			<tr bgcolor="#f0f7ff">
		<%}else{%>	  
				<tr bgcolor="#e6f1fc">	
		<%}%>
			        <td align="center"><%=bowlerstaticsticCrs.getString("inning")==null?"-":bowlerstaticsticCrs.getString("inning")%></td>
			        <td align="center"><%=bowlerstaticsticCrs.getString("displayname")==null?"-":bowlerstaticsticCrs.getString("displayname")%></td>
			        <td align="right"><%=bowlerstaticsticCrs.getString("bowling_order")==null?"-":bowlerstaticsticCrs.getString("bowling_order")%></td>
			        <td align="right"><%=bowlerstaticsticCrs.getString("overs")==null?"-":bowlerstaticsticCrs.getString("overs")%></td>
			        <td align="right"><%=bowlerstaticsticCrs.getString("maidens")==null?"-":bowlerstaticsticCrs.getString("maidens")%></td>
			        <td align="right"><%=bowlerstaticsticCrs.getString("runs_given")==null?"-":bowlerstaticsticCrs.getString("runs_given")%></td>
			        <td align="right"><%=bowlerstaticsticCrs.getString("no_balls")==null?"-":bowlerstaticsticCrs.getString("no_balls")%></td>
			        <td align="right"><%=bowlerstaticsticCrs.getString("wide_balls")==null?"-":bowlerstaticsticCrs.getString("wide_balls")%></td>
			        <td align="right"><%=bowlerstaticsticCrs.getString("num_wickets")==null?"-":bowlerstaticsticCrs.getString("num_wickets")%></td>
			        <td align="center"><a href="/cims/jsp/concise/ConciseMatchTab.jsp?tab=4&inning=<%=bowlerstaticsticCrs.getString("inning")%>&HidId=4&selBowler=<%=bowlerstaticsticCrs.getString("bowler")%>">Edit</a></td>
        			<td align="center" ><a href="/cims/jsp/concise/ConciseBowling.jsp?selinning=<%=bowlerstaticsticCrs.getString("inning")%>&HidId=3&selBowler=<%=bowlerstaticsticCrs.getString("bowler")%>">Delete</a></td>
				</tr>
<%	 i++;		
	 }
     }// end of if
     }catch(Exception e){
	  log.writeErrLog(page.getClass(),MatchId,e.toString());
	}
%>      
        
    		</table>
    	</div>
    	<input type="hidden" name="HidId" id="HidId" value="0">
	</body>
</html>