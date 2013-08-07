<!--
Page Name 	 : jsp/Concisecreatedinning.jsp
Created By 	 : Bhushan Fegade.
Created Date : 073 April 2009
Description  : Data Entry for Concise Matches.
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
	String GSDate = sdf.format(new Date());
	String query = request.getParameter("query");
	String inning = request.getParameter("inning") == null? "0" : request.getParameter("inning");
	String HidId = request.getParameter("HidId") == null? "0" : request.getParameter("HidId");
	//String starttime = request.getParameter("txtstarttime") == null ? GSDate : request.getParameter("txtstarttime");
	//String endtime = request.getParameter("txtendtime") == null? GSDate : request.getParameter("txtendtime");
	String starttime = request.getParameter("txtstarttime") == null ? smf.format(new Date()) : request.getParameter("txtstarttime");
	String endtime = request.getParameter("txtendtime") == null? smf.format(new Date()) : request.getParameter("txtendtime");
	String battingteam = request.getParameter("selbattingteam") == null? "0" : request.getParameter("selbattingteam");
	String bowlingteam = "0";
	String MatchId = (String)session.getAttribute("matchId1");

	// Variable declarations
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(MatchId);
	Vector<Object> vparam = new Vector<Object>();
	Common  commonUtil = new Common();
	LogWriter log = new LogWriter();
	CachedRowSet crsObjTeam	= null;
	CachedRowSet crsObjAddInning = null;
	CachedRowSet crsObjinning = null;
	CachedRowSet crsObjinningdeatils = null;
	String msg = "";
	String battingid = "0";
	String bowlingid = "0";
	Hashtable<Integer, String> htteamid = new java.util.Hashtable<Integer, String>();
	Hashtable<Integer, String> htteamname = new java.util.Hashtable<Integer, String>();
	
	
	// Read team names and their corresponding team id.
	try{
	 	vparam.add(MatchId);
	 	crsObjTeam = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchwiseteam",vparam,"ScoreDB");
	  	vparam.removeAllElements();
	}catch(Exception e){
	  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
	}
	try{
	   	if(crsObjTeam!=null){
		 	for(int count = 0; crsObjTeam.next(); count++){
		  		htteamid.put(count, crsObjTeam.getString("id"));
		  		htteamname.put(count, crsObjTeam.getString("team_name"));
		  		
		  		// Assing value to bowling team.
		  		if(!battingteam.trim().equals(crsObjTeam.getString("id"))){
		  			bowlingteam = crsObjTeam.getString("id");
		  		}
		 	}
	   	}
	}catch(Exception e){
	  	log.writeErrLog(page.getClass(), MatchId, e.toString());
	}
	
	if(HidId!=null && HidId.equalsIgnoreCase("1")){
	 		try{
		 	 	vparam.add(inning);
				vparam.add(commonUtil.formatDate(starttime));
			 	vparam.add(commonUtil.formatDate(endtime));
			 	vparam.add(battingteam);
			 	vparam.add(bowlingteam);
			 	vparam.add(MatchId);
			 	vparam.add("1"); //1 flag insert
			 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_concise_innings",vparam,"ScoreDB");
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
		 	 vparam.add(inning);
		 	 vparam.add(commonUtil.formatDate(starttime));
		 	 vparam.add(commonUtil.formatDate(endtime));
		 	 vparam.add(battingteam);
		 	 vparam.add(bowlingteam);
		 	 vparam.add(MatchId);
		 	 vparam.add("2"); //2 flag update
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_concise_innings",vparam,"ScoreDB");
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
		 	 vparam.add(inning);
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("3"); //3 flag delete
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_concise_innings",vparam,"ScoreDB");
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
			vparam.add(inning);
		 	vparam.add("2"); //1 flag for display match wise data
	 	 	crsObjinningdeatils = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_innings",vparam,"ScoreDB");
	  	 	vparam.removeAllElements();
	  	 	if(crsObjinningdeatils!=null){
	  	 		while(crsObjinningdeatils.next()){
			  	 	inning = crsObjinningdeatils.getString("id")==null?"0":crsObjinningdeatils.getString("id");
			  	 	starttime = crsObjinningdeatils.getString("start_ts")==null?"": crsObjinningdeatils.getString("start_ts");			  	 	
				  	endtime = crsObjinningdeatils.getString("end_ts")==null?"": crsObjinningdeatils.getString("end_ts");
				  	battingid = crsObjinningdeatils.getString("batting_team_id")==null?"0": crsObjinningdeatils.getString("batting_team_id");
			  	 	bowlingid = crsObjinningdeatils.getString("bowling_team_id")==null?"0": crsObjinningdeatils.getString("bowling_team_id");
		  	 	}
	  	 		starttime = Common.changeDate(starttime);
	  	 		endtime = Common.changeDate(endtime);
	  	 		
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
	
	if(HidId!=null && (HidId.equalsIgnoreCase("1") || HidId.equalsIgnoreCase("2") || HidId.equalsIgnoreCase("3"))){
		response.sendRedirect("/cims/jsp/concise/ConciseMatchTab.jsp?tab=1");
		return;
	}
%>


<%@page import="java.text.DateFormat"%>
<html>
	<head>
    <title>Inning Details</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

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
	  	<div style="height: 10em">
		    <table style="width:70em;" border="0"  cellspacing="1" cellpadding="3">
				<tr>
			        <td colspan="10" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
			          <center>Inning Create Entry Module</center>
			        </td>
			    </tr>
		    	<tr>
			        <td colspan="10" width="70em" >
			          <center><font color="red"><b><%=msg%></b></font></center>
			        </td>
				</tr>
			    <tr bgcolor="#f0f7ff">
			        <td align="center"><b>Start Time </b></td>
			        <td align="center"><b>End Time </b></td>
			        <td align="center"><b>Batting Team </b></td>
			        <td align="center">&nbsp;</td>
			    </tr>
				<tr bgcolor="#e6f1fc">
					<td align="center">
						<input type="text" name="txtstarttime" id="txtstarttime" value="<%=starttime%>" class="textBox" tabindex="2" readonly>
			          	<a id="imganchor" name="imganchor" href="javascript:NewCal('txtstarttime','ddmmyyyy',true,24)">
			          	<IMG src="../../images/cal.gif" border="0"></a>
			        </td>
			        <td align="center">
			          	<input type="text" name="txtendtime" id="txtendtime" value="<%=endtime%>"  class="textBox" tabindex="3" readonly>
			           	<a id="imganchor" name="imganchor" href="javascript:NewCal('txtendtime','ddmmyyyy',true,24)">
			          	<IMG src="../../images/cal.gif" border="0"></a>
			        </td>
			        <td align="center" >
			        	<select id="selbattingteam" name="selbattingteam" tabindex="4">
						<%
						try{
							for(int i=0; i<htteamid.size();i++){%>        	 
							<option value="<%=htteamid.get(i)%>" <%= htteamid.get(i).toString().equalsIgnoreCase(battingid)?"selected":"" %>><%=htteamname.get(i)%></option>
						<%}
							}catch(Exception e){
						 		log.writeErrLog(page.getClass(),MatchId,e.toString());	
							}%>      	
						</select>	
			        </td>
		         	<td align="center">
					<%if(HidId!=null && HidId.equalsIgnoreCase("4")){%>			
						<input type="button" name="btnadd" id="btnadd" value=" SAVE " class="btn" tabindex="6" onclick="createinning(2);">
					<%}else{%>
						<input type="button" name="btnadd" id="btnadd" value=" ADD " class="btn" tabindex="6" onclick="createinning(1);">
					<%}%>
						<input type="hidden" name="HidId" id="HidId" value="0">
					</td>
			    </tr>
		    </table>
	    </div>
		<div id="viewdiv" style="overflow: auto; height:15em;" >
    <table style="width:70em" border="0"  cellspacing="1" >
	  <tr>
        <td colspan="11" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          <center>View Data</center>
        </td>
      </tr>
      <tr bgcolor="#f0f7fd">
        <td align="center" width="5%"><b>Innings</b></td>
        <td align="center" width="15%"><b>Start Time</b></td>
        <td align="center" width="15%"><b>End Time</b></td>
        <td align="center" width="15%"><b>Batting Team</b></td>
        <td align="center" width="15%"><b>Bowling Team</b></td>
        <td align="center" width="5%">&nbsp;</td>
        <td align="center" width="5%">&nbsp;</td>
      </tr>
<%	  try{
	  if(crsObjinning!=null){
	  int i = 1;
	  while(crsObjinning.next()){	
	  if(i%2==0){	
%>    <tr bgcolor="#f0f7ff">
<%	  }else{	
%>	  <tr bgcolor="#e6f1fc">	
<%	  }%>	

        <td align="center">Inning <%=i%></td>
        <td align="center"><%=crsObjinning.getObject("start_ts")%></td>
        <td align="center"><%=crsObjinning.getObject("end_ts")%></td>
        <td align="center"><%=crsObjinning.getString("batting_team_name")%></td>
        <td align="center"><%=crsObjinning.getString("bowling_team_name")%></td>
        <td align="center"><a href="/cims/jsp/concise/ConciseMatchTab.jsp?tab=1&inning=<%=crsObjinning.getString("id")%>&HidId=4">Edit</a></td>
        <td align="center" ><a href="/cims/jsp/concise/concisecreateinning.jsp?inning=<%=crsObjinning.getString("id")%>&HidId=3">Delete</a></td>
      </tr>
<%	 i++;	 
	}
     }// end of if
     }catch(Exception e){
	  log.writeErrLog(page.getClass(),MatchId,e.toString());
	}
%>      
     
    	</table>
    	<input type="hidden" id="inning" name="inning" value="<%=inning%>">
  	</body>
</html>