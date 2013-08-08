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
	String GSDate =	sdf.format(new Date());
	String query = request.getParameter("query");
	String HidId = request.getParameter("HidId")==null?"0":request.getParameter("HidId");
	String MatchId = (String)session.getAttribute("matchId1");
	String cmbinning = request.getParameter("selinning")==null?"0":request.getParameter("selinning");
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	Common commonUtil = new Common();
	LogWriter log = new LogWriter();
	Vector<String> vparam = new Vector<String>();
	CachedRowSet crsObjinning = null;
	CachedRowSet crsObjAddInning = null;
	CachedRowSet crsObjrate = null;
	CachedRowSet crsObjrunrate = null;
	String msg = "";
	
	String __inningId = "0";
	
	String Runs = request.getParameter("txtRuns")==null?"0":request.getParameter("txtRuns");
	String Overs = request.getParameter("txtOvers")==null?"0":request.getParameter("txtOvers");
	String wickets = request.getParameter("txtwickets")==null?"0":request.getParameter("txtwickets");
	String runrate = request.getParameter("txtRunRates")==null?"0":request.getParameter("txtRunRates");
	
	if(HidId!=null && HidId.equalsIgnoreCase("1")){
		try{
			vparam.add(cmbinning);
		 	vparam.add(Overs);
		 	vparam.add(Runs);
		 	vparam.add(wickets);
		 	vparam.add(runrate);
		 	vparam.add("1"); //1 flag insert
		 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_runratebyover",vparam,"ScoreDB");
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
		 	vparam.add(Overs);
		 	vparam.add(Runs);
		 	vparam.add(wickets);
		 	vparam.add(runrate);
		 	vparam.add("2"); //2 flag update
		 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_runratebyover",vparam,"ScoreDB");
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
		 	 vparam.add(Overs);
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("0.0");
		 	 vparam.add("3"); //3 flag delete
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_runratebyover",vparam,"ScoreDB");
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
		 vparam.add(Overs);
		 vparam.add("1");
		 crsObjrunrate = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_runrate_by_over",vparam,"ScoreDB");
	  	 vparam.removeAllElements();
	  	 if(crsObjrunrate!=null){
	  	 	while(crsObjrunrate.next()){
		  	 	cmbinning = crsObjrunrate.getString("inning")==null?"0":crsObjrunrate.getString("inning");
		  	 	Runs	  = crsObjrunrate.getString("runs")==null?"0": crsObjrunrate.getString("runs");
			  	Overs   = crsObjrunrate.getString("overnum")==null?"0": crsObjrunrate.getString("overnum");
			  	wickets  = crsObjrunrate.getString("wickets")==null?"": crsObjrunrate.getString("wickets");
		  	 	runrate   = crsObjrunrate.getString("run_rate")==null?"0": crsObjrunrate.getString("run_rate");

	  	 	}
	  	 }
		}catch(Exception e){
		  log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}

	if(HidId!=null && (HidId.equalsIgnoreCase("1") || HidId.equalsIgnoreCase("2") || HidId.equalsIgnoreCase("3"))){
		response.sendRedirect("/cims/jsp/concise/ConciseMatchTab.jsp?tab=9&inning="+cmbinning);
		return;
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
    <title>Run Rate Details</title>
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
	
		<!--  ******************** Entry panel ********************  -->
		<div style="height:10em">
    		<table style="width:70em;" border="0"  cellspacing="1" cellpadding="3">
	  			<tr>
        			<td colspan="6" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          				<center>Run Rate Details Entry Module</center>
	        		</td>
	      		</tr>
	       		<tr>
					<td colspan="6" width="100%" >
	          			<center><font color="red"><b><%=msg%></b></font></center>
	        		</td>
	      		</tr>
	      		<tr bgcolor="#f0f7ff" height="15%">
			        <td align="center" width="10%">Innings</td>
			        <td align="center" width="10%">Overs</td>
			        <td align="center" width="10%">Runs</td>
			        <td align="center" width="10%">Wickets</td>
					<td align="center" width="10%">RunRate</td>
			        <td align="center" width="10%">&nbsp;</td>
	      		</tr>
	      		<tr bgcolor="#e6f1fc" height="5%">
	        		<td align="center">
						<select id="selinning" name="selinning" tabindex="1" onchange="scoreingrunrate('5');" >
		<%try{	
		 	if(crsObjinning != null){
		 		if(cmbinning.equals("0")){
		 			for(int i = 1; crsObjinning.next(); i++){%>
							<option value="<%=crsObjinning.getString("id")%>">Inning <%=i%></option>
		 			<%
		 				if(i == 1){
							__inningId = crsObjinning.getString("id");
						}
		 			}
		 		} else {
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
			        <td align="center">
			          <input type="text" name="txtOvers" id="txtOvers"  onfocus="clearTextBox('txtOvers')" onblur="fillZero('txtOvers')"  class="textBox" value="<%=Overs%>" tabindex="2" onKeyPress="return keyRestrict(event,'1234567890.');">
			        </td>
					<td align="center">
			          	<input type="text" name="txtRuns" id="txtRuns"  onfocus="clearTextBox('txtRuns')" onblur="fillZero('txtRuns')"  class="textBox" tabindex="3" value="<%=Runs%>" onKeyPress="return keyRestrict(event,'1234567890');">
        			</td>
					<td align="center">
          				<input type="text" name="txtwickets" id="txtwickets"  onfocus="clearTextBox('txtwickets')" onblur="fillZero('txtwickets')"  class="textBox" tabindex="4" value="<%=wickets%>" onKeyPress="return keyRestrict(event,'1234567890');">
        			</td>
		 			<td align="center">
          				<input type="text" name="txtRunRates" id="txtRunRates"  onfocus="clearTextBox('txtRunRates')" onblur="fillZero('txtRunRates')"  class="textBox" tabindex="5" value="<%=runrate%>" onKeyPress="return keyRestrict(event,'1234567890.');">
        			</td>
         			<td align="center">
			<%if(HidId!=null && HidId.equalsIgnoreCase("4")){%>			
						<input type="button" name="btnadd" id="btnadd" value=" SAVE " class="btn" tabindex="6" onclick="scoringrunrateadd(2);">
			<%}else{%>			
						<input type="button" name="btnadd" id="btnadd" value=" ADD " class="btn" tabindex="6" onclick="scoringrunrateadd(1);">
			<%}%>
		 			</td>
      			</tr>
    		</table>
		</div>
		
		<%

		
	    try{
		 	vparam.add(__inningId);
		 	vparam.add("0.0");
		 	vparam.add("2"); 
		 	crsObjrate = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_runrate_by_over",vparam,"ScoreDB");
		  	vparam.removeAllElements();
		}catch(Exception e){
		  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
		%>
		
		<!--  ******************** Display panel ********************  -->
    	<div id="viewdiv" style="overflow: auto; height:15em;" >
    		<table style="width:70em" border="0"  cellspacing="1" cellpadding=3"">
	  			<tr height="15%">
        			<td colspan="7"  width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          				<center>View Data</center>
        			</td>
      			</tr>
      			<tr bgcolor="#f0f7ff">
			        <td align="right" width="10%"><b>Innings</b></td>
			        <td align="right" width="10%"><b>Overs</b></td>
			        <td align="right" width="10%"><b>Runs</b></td>
			        <td align="right" width="10%"><b>Wickets</b></td>
					<td align="right" width="10%"><b>RunRate</b></td>
			        <td align="center" width="10%"><b>Edit</b></td>
			        <td align="center" width="10%"><b>Delete</b></td>
      			</tr>
    		<%try{
	  			if(crsObjrate!=null){
	  				while(crsObjrate.next()){	
	  					int i = 1;
	  					if(i%2==0){%>    
	  			<tr bgcolor="#f0f7ff">
						<%}else{%>	  
				<tr bgcolor="#e6f1fc">	
						<%}%>
					<td align="right"><%=crsObjrate.getString("inning")==null?"-":crsObjrate.getString("inning")%></td>
			        <td align="right"><%=crsObjrate.getString("overnum")==null?"-":crsObjrate.getString("overnum")%></td>
			        <td align="right"><%=crsObjrate.getString("runs")==null?"-":crsObjrate.getString("runs")%></td>
			        <td align="right"><%=crsObjrate.getString("wickets")==null?"-":crsObjrate.getString("wickets")%></td>
			        <td align="right"><%=crsObjrate.getString("run_rate")==null?"-":crsObjrate.getString("run_rate")%></td>
			        <td align="center"><a href="/cims/jsp/concise/ConciseMatchTab.jsp?tab=9&inning=<%=crsObjrate.getString("inning")%>&HidId=4&txtOvers=<%=crsObjrate.getString("overnum")%>">Edit</a></td>
			        <td align="center" ><a href="/cims/jsp/concise/ConciseRunRate.jsp?selinning=<%=crsObjrate.getString("inning")%>&HidId=3&txtOvers=<%=crsObjrate.getString("overnum")%>">Delete</a></td>
      			</tr>
						<%i++;	 
					}		
     			}// end of if
     		}catch(Exception e){
	  			log.writeErrLog(page.getClass(),MatchId,e.toString());
			}%>
    		</table>
    		<input type="hidden" name="HidId" id="HidId" value="0" />
    	</div>
  	</body>	
</html>