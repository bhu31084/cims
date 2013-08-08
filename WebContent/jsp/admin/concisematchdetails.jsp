<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%
		Common commonUtil= new Common();
		 LogWriter log = new LogWriter();
        CachedRowSet  crsObjUmpire1 = null;
		CachedRowSet  crsObjUmpireCoach = null;
		CachedRowSet  crsObjMatchReferee = null;
		CachedRowSet  crsObjScorer = null;
		CachedRowSet  crsObjTeam1 = null;
		CachedRowSet  crsObjTeam2 = null;
		CachedRowSet  crsObjTournamentNm = null;
		CachedRowSet  crsObjvenueNm = null;
		CachedRowSet  crsObjMatchType = null;
		CachedRowSet  crsObjMatchCategory = null;
		CachedRowSet  crsObjMatchId = null;
		CachedRowSet  crsObjDisplayMatchData = null;
		CachedRowSet  crsObjSeason = null;
		CachedRowSet  crsObjZone = null;
		Vector<Object> vparam =  new Vector<Object>();
		Hashtable htteamid = new java.util.Hashtable();
		Hashtable htteamname = new java.util.Hashtable();
		Hashtable htumpireid  = new java.util.Hashtable();
		Hashtable htumpirename = new java.util.Hashtable();
		Hashtable htscorerid = new java.util.Hashtable();
		Hashtable htscorername = new java.util.Hashtable();
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
		String msg = "";
		String hdid = request.getParameter("hdid")==null?"0":request.getParameter("hdid");
		String tournament = request.getParameter("seltournament")==null?"0":request.getParameter("seltournament");
		String zone = request.getParameter("selzone")==null?"0":request.getParameter("selzone");
		String team1 = request.getParameter("selteam1")==null?"0":request.getParameter("selteam1");
		String team2 = request.getParameter("selteam2")==null?"0":request.getParameter("selteam2");
		String tosswonby = request.getParameter("seltosswonby")==null?"0":request.getParameter("seltosswonby");
		String venu = request.getParameter("selvenue")==null?"0":request.getParameter("selvenue");
		String matchwonby = request.getParameter("selmatchwonby")==null?"0":request.getParameter("selmatchwonby");
		String firstbatting = request.getParameter("selfirstbatting")==null?"0":request.getParameter("selfirstbatting");
		String umpire1 = request.getParameter("selumpire1")==null?"0":request.getParameter("selumpire1");		
		String umpire2 = request.getParameter("selumpire2")==null?"0":request.getParameter("selumpire2");		
		String umpire3 = request.getParameter("selthirdumpire")==null?"0":request.getParameter("selthirdumpire");		
		String umpirecoach = request.getParameter("selumpirecoach")==null?"0":request.getParameter("selumpirecoach");		
		String matchreferee = request.getParameter("selmatchreferee")==null?"0":request.getParameter("selmatchreferee");		
		String scorer1 = request.getParameter("selscorer1")==null?"0":request.getParameter("selscorer1");		
		String scorer2 = request.getParameter("selscorer2")==null?"0":request.getParameter("selscorer2");
		String starttime = request.getParameter("txtstarttime")==null?"0":request.getParameter("txtstarttime");		
		String endtime = request.getParameter("txtclosetime")==null?"0":request.getParameter("txtclosetime");		
		String wonbyrun = request.getParameter("txtwonbyrun")==null?"0":request.getParameter("txtwonbyrun");		
		String wonbywkt = request.getParameter("txtwonbywicket")==null?"0":request.getParameter("txtwonbywicket");
		String wonbyinning =request.getParameter("txtwonbyinning")==null?"0":request.getParameter("txtwonbyinning");
		String season =request.getParameter("selseason")==null?"0":request.getParameter("selseason");
		String matchtype =request.getParameter("selmatchtype")==null?"0":request.getParameter("selmatchtype");
		String category =request.getParameter("selcategory")==null?"0":request.getParameter("selcategory");
		if(hdid.equalsIgnoreCase("1")){
		try{
			vparam.add("1"); // flag
			vparam.add(tournament);
			vparam.add(season);
			vparam.add(matchtype);
			vparam.add(category);
			vparam.add(team1);
			vparam.add(team2);
			vparam.add(tosswonby);
			vparam.add(venu);
			vparam.add(matchwonby);	
			vparam.add(umpire1);
			vparam.add(umpire2);
			vparam.add(umpire3);
			vparam.add(umpirecoach);
			vparam.add(matchreferee);
			vparam.add(scorer1);
			vparam.add(scorer2);
			vparam.add(commonUtil.formatDate(starttime));
			vparam.add(commonUtil.formatDate(endtime));
			vparam.add(wonbyrun);
			vparam.add(wonbywkt);
			vparam.add(wonbyinning);
			crsObjMatchId	= lobjGenerateProc.GenerateStoreProcedure(
			"esp_amd_concisematch",vparam,"ScoreDB");
			
			vparam.removeAllElements();
			while(crsObjMatchId.next()){
				msg = crsObjMatchId.getString("result");
			}
		}catch(Exception e){
			e.printStackTrace();
			log.writeErrLog(e.toString());
		}
		}
		
		try{
			vparam.add("2");
			crsObjTournamentNm = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_concise_series_ms",vparam,"ScoreDB");
			vparam.removeAllElements();
		}catch(Exception e){
			log.writeErrLog(e.toString());
		}
		
		try{
			vparam.add("2");
			crsObjTeam1 = lobjGenerateProc.GenerateStoreProcedure(
        	"esp_dsp_team_ms",vparam,"ScoreDB");
        	vparam.removeAllElements();
		}catch(Exception e){
			log.writeErrLog(e.toString());
		}
		try{
			if(crsObjTeam1!=null){
				int i=0;
				while(crsObjTeam1.next()){
				  htteamid.put(i,crsObjTeam1.getString("id"));
				  htteamname.put(i,crsObjTeam1.getString("team_name"));
				  i++;		
				}
			}
		}catch(Exception e){
			log.writeErrLog(e.toString());
		}
		try{
		  vparam.add("2");
		  crsObjvenueNm = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_venue_ms",vparam,"ScoreDB");
		  vparam.removeAllElements();		
		}catch(Exception e){
		  log.writeErrLog(e.toString());	
		}
		try{
		  vparam.add("2");
		  crsObjUmpire1 = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_official_umpire",vparam,"ScoreDB");
		  vparam.removeAllElements();	
		  if(crsObjUmpire1!=null){
		  	int i = 0;
		  	while(crsObjUmpire1.next()){
		  		htumpireid.put(i,crsObjUmpire1.getString("id"));
		  		htumpirename.put(i,crsObjUmpire1.getString("name"));
		  		i++;
		  	}
		  }	
		}catch(Exception e){
		  log.writeErrLog(e.toString());	
		}
		try{
		  vparam.add("6");
		  crsObjUmpireCoach = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_official_umpire",vparam,"ScoreDB");
		  vparam.removeAllElements();	
		}catch(Exception e){
		  log.writeErrLog(e.toString());	
		}
		try{
		 vparam.add("2");
		 crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");
		 vparam.removeAllElements();	
		}catch(Exception e){
		  log.writeErrLog(e.toString());	
		}
		try{
		  vparam.add("4");
		  crsObjMatchReferee = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_official_umpire",vparam,"ScoreDB");
		  vparam.removeAllElements();	
		}catch(Exception e){
		  log.writeErrLog(e.toString());	
		}
		
		try{
		  vparam.add("3");
		  crsObjScorer = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_official_umpire",vparam,"ScoreDB");
		  vparam.removeAllElements();	
		  if(crsObjScorer!=null){
		  	int i = 0;
		  	while(crsObjScorer.next()){
		  		htscorerid.put(i,crsObjScorer.getString("id"));
		  		htscorername.put(i,crsObjScorer.getString("name"));
		  		i++;
		  	}
		  }	
		}catch(Exception e){
		  log.writeErrLog(e.toString());	
		}
		try{
		  vparam.add("");
		  crsObjZone = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_zone",vparam,"ScoreDB");
		  vparam.removeAllElements();	
		}catch(Exception e){
		  log.writeErrLog(e.toString());	
		}
		try{
		  vparam.add("2");
		  crsObjMatchType = lobjGenerateProc.GenerateStoreProcedure(
		  "esp_dsp_matchtype_ms",vparam,"ScoreDB");
		  vparam.removeAllElements();
		}catch(Exception e){
		  log.writeErrLog(e.toString());	
		}
		try{
		  vparam.add("2");
		  crsObjMatchCategory = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_matchcategory_ms",vparam,"ScoreDB");
			vparam.removeAllElements();
		}catch(Exception e){
		  log.writeErrLog(e.toString());	
		}	
		
		
		
%>
<html>
  <head>
    <title>Bowling Details</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="../../js/datetimepicker.js" type="text/javascript"></script>
	
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
  <script>
  	function createMatch(){
  		if(document.getElementById("seltournament").value=="0"){
  			alert("Please Select Tournament");
  			document.getElementById("seltournament").focus();
  			document.getElementById("seltournament").select();
  			return false;
  		}else if(document.getElementById("selteam1").value=="0"){
  			alert("Please Select Team 1");
  			document.getElementById("selteam1").focus();
  			document.getElementById("selteam1").select();
  			return false;
  		}else if(document.getElementById("selteam2").value=="0"){
  			alert("Please Select Team 2");
  			document.getElementById("selteam2").focus();
  			document.getElementById("selteam2").select();
  			return false;
  		}else if(document.getElementById("txtstarttime").value==""){
  			alert("Please Enter Start Time");
  			document.getElementById("txtstarttime").focus();
  			document.getElementById("txtstarttime").select();
  			return false;
  		}else if(document.getElementById("txtclosetime").value==""){
  			alert("Please Select End Time");
  			document.getElementById("txtclosetime").focus();
  			document.getElementById("txtclosetime").select();
  			return false;
  		}else if(document.getElementById("selseason").value==""){
  			alert("Please Select Season");
  			document.getElementById("selseason").focus();
  			document.getElementById("selseason").select();
  			return false;
  		}else if(document.getElementById("selmatchtype").value==""){
  			alert("Please Select Match Type");
  			document.getElementById("selmatchtype").focus();
  			document.getElementById("selmatchtype").select();
  			return false;
  		}
  		else{
  			document.getElementById("hdid").value="1";
  			document.getElementById("frmconcisematch").action="/cims/jsp/admin/concisematchdetails.jsp";
  			document.getElementById("frmconcisematch").submit();
  		}
  		
  	}
  	function changeColour(which) {
			if (which.value.length > 0) {   // minimum 2 characters
				which.style.background = "#FFFFFF"; // white
			}
			else {
				which.style.background = "";  // yellow
			}
		}
  </script>	
  </head>
  <body>
<div class="container">
  	<jsp:include page="../admin/Menu.jsp"></jsp:include>
    <form name="frmconcisematch" id="frmconcisematch" method="post" >
<div class="leg">Match Details Entry Module</div>
<%--    Venue Master--%>
<div class="portletContainer">
    <table width="100%"  border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
     
      <tr height="20%">
        <td colspan="6" height="20%" width="100%">
          <center><font color="red"><b><%=msg%></b></font></center>
        </td>
      </tr>
      
      <tr height="15%" width="100%" class="contentLight">
        <td align="right" width="10%"><b><font color="black">Tournament:</font></b></td>
        <td align="left" width="10%">
        	<select id="seltournament" name="seltournament" tabindex="1" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%		  try{ 
	      if(crsObjTournamentNm!=null){		
		   while(crsObjTournamentNm.next()){	
%>        	   <option value="<%=crsObjTournamentNm.getString("seriseid")%>"><%=crsObjTournamentNm.getString("name")%></option>
<%		   }// end of while	
		   }// end of if	
		  }catch(Exception e){
		  	log.writeErrLog(e.toString());
		  }
%>	
        	</select>	
        </td>
        <td align="right" width="10%"><b><font color="black">Match No:</font></b></td>
        <td>
        	<input type="text" name="txtmatchno" id="txtmatchno" value="" class="textBoxAdminMatchSetup" tabindex="2" disabled="disabled">
        </td>	
        <td align="right" width="10%"><b><font color="black">Zone:</font></b></td>
        <td align="left" width="10%">
        	<select id="selzone" name="selzone" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">zone</option>
<%		  try{ 
	      if(crsObjZone!=null){		
		   while(crsObjZone.next()){	
%>        	   <option value="<%=crsObjZone.getString("id")%>"><%=crsObjZone.getString("name")%></option>
<%		   }// end of while	
		   }// end of if	
		  }catch(Exception e){
		  	log.writeErrLog(e.toString());
		  }
%>	        	  
        	</select>	
        </td>
      </tr>
      
      
       <tr class="contentDark" height="15%" width="100%">
        <td align="right" width="10%"><b><font color="black">Season: </font></b></td>
        <td align="left" width="10%">
        	<select id="selseason" name="selseason" tabindex="3" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%		  try{ 
	      if(crsObjSeason!=null){		
		   while(crsObjSeason.next()){	
%>        	   <option value="<%=crsObjSeason.getString("id")%>"><%=crsObjSeason.getString("name")%></option>
<%		   }// end of while	
		   }// end of if	
		  }catch(Exception e){
		  	log.writeErrLog(e.toString());
		  }
%>	
        	</select>	
        </td>
        <td align="right" width="10%"><b><font color="black">Match Type:</font></b></td>
        <td>
 		  <select id="selmatchtype" name="selmatchtype" tabindex="4" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%		  try{ 
	      if(crsObjMatchType!=null){		
		   while(crsObjMatchType.next()){	
%>        	   <option value="<%=crsObjMatchType.getString("id")%>"><%=crsObjMatchType.getString("name")%></option>
<%		   }// end of while	
		   }// end of if	
		  }catch(Exception e){
		  	log.writeErrLog(e.toString());
		  }
%>	      </select>        	
        </td>	
        <td align="right" width="10%"><b> <font color="black">Match Category: </font></b></td>
        <td align="left" width="10%">
        	<select id="selcategory" name="selcategory" tabindex="5" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%		  try{ 
	      if(crsObjMatchCategory!=null){		
		   while(crsObjMatchCategory.next()){	
%>        	   <option value="<%=crsObjMatchCategory.getString("id")%>"><%=crsObjMatchCategory.getString("name")%></option>
<%		   }// end of while	
		   }// end of if	
		  }catch(Exception e){
		  	log.writeErrLog(e.toString());
		  }
%>	        	  
        	</select>	
        </td>
      </tr>
      
      
      
      <tr class="contentLight" height="15%" width="100%">
        <td align="right" width="10%"><b> <font color="black">Team1:</font></b></td>
        <td align="left" width="10%">
        	<select id="selteam1" name="selteam1" tabindex="6" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	 <option value="0">select</option>
<%			try{
			 for(int i=0; i<htteamid.size();i++){
%>        	 <option value="<%=htteamid.get(i)%>"><%=htteamname.get(i)%></option>
<%			 }
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>      	</select>	
        </td>
        <td align="right" width="10%"><b> <font color="black">Team2: </font></b></td>
        <td align="left" width="10%">
        	<select id="selteam2" name="selteam2" tabindex="7" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%			try{
			 for(int i=0; i<htteamid.size();i++){
%>        	 <option value="<%=htteamid.get(i)%>"><%=htteamname.get(i)%></option>
<%			 }
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>        	  
        	</select>	
        </td>
        <td align="right" width="10%"><b> <font color="black">Toss Won By: </font></b></td>
        <td align="left" width="10%">
        	<select id="seltosswonby" name="seltosswonby" tabindex="8" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%			try{
			 for(int i=0; i<htteamid.size();i++){
%>        	 <option value="<%=htteamid.get(i)%>"><%=htteamname.get(i)%></option>
<%			 }
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>           	  
        	</select>	
        </td>
      </tr> 
      <tr class="contentDark" height="15%" width="100%">
        <td align="right" width="10%"><b> <font color="black">Venue:</font></b></td>
        <td align="left" width="10%">
          <select id="selvenue" name="selvenue" tabindex="9" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	<option value="0">select</option>
<%		   try{
			if(crsObjvenueNm != null){
			while(crsObjvenueNm.next()){
%>			<option value="<%=crsObjvenueNm.getString("id")%>"><%=crsObjvenueNm.getString("name")%></option>
<%			}
			}
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>  
       	  </select>	
        </td>
        <td align="right" width="10%"><b><font color="black">Match WonBy:</font></b></td>
           <td align="left" width="10%">
        	<select id="selmatchwonby" name="selmatchwonby" tabindex="10" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%			try{
			 for(int i=0; i<htteamid.size();i++){
%>        	 <option value="<%=htteamid.get(i)%>"><%=htteamname.get(i)%></option>
<%			 }
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>           	  
        	</select>	
        </td>
        <td align="right" width="10%"><b><font color="black">Team Batting First:</font></b></td>
        <td align="left" width="10%">
        	<select id="selfirstbatting" name="selfirstbatting" tabindex="11" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%			try{
			 for(int i=0; i<htteamid.size();i++){
%>        	 <option value="<%=htteamid.get(i)%>"><%=htteamname.get(i)%></option>
<%			 }
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>             	  
        	</select>	
        </td>
      </tr>
      <tr   class="contentLight" height="15%" width="100%">
        <td align="right" width="10%"><b><font color="black">Umpire1:</font></b></td>
        <td align="left" width="10%">
        	<select id="selumpire1" name="selumpire1" tabindex="12" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%			try{
			 for(int i=0; i<htumpireid.size();i++){
%>        	 <option value="<%=htumpireid.get(i)%>"><%=htumpirename.get(i)%></option>
<%			 }
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>          	  
        	</select>	
        </td>
        <td align="right" width="10%"><b><font color="black">Umpire2:</font></b></td>
        <td align="left" width="10%">
        	<select id="selumpire2" name="selumpire2" tabindex="13" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%			try{
			 for(int i=0; i<htumpireid.size();i++){
%>        	 <option value="<%=htumpireid.get(i)%>"><%=htumpirename.get(i)%></option>
<%			 }
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>          	  
        	</select>	
        </td>
        <td align="right" width="10%"><b><font color="black">Third Umpire:</font></b></td>
        <td align="left" width="10%">
        	<select id="selthirdumpire" name="selthirdumpire" tabindex="14" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%			try{
			 for(int i=0; i<htumpireid.size();i++){
%>        	 <option value="<%=htumpireid.get(i)%>"><%=htumpirename.get(i)%></option>
<%			 }
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>          	  
        	</select>	
        </td>
      </tr>   
      <tr class="contentDark" height="15%" width="100%">
        <td align="right" width="10%"><b><font color="black">Umpire Coach:</font></b></td>
        <td align="left" width="10%">
          <select id="selumpirecoach" name="selumpirecoach" tabindex="15" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%		   try{
			if(crsObjUmpireCoach != null){
			while(crsObjUmpireCoach.next()){
%>			<option value="<%=crsObjUmpireCoach.getString("id")%>"><%=crsObjUmpireCoach.getString("name")%></option>
<%			}
			}
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>  
            	  
        	</select>
        </td>
        <td align="right" width="10%"><b><font color="black">Match Referee:</font></b></td>
        <td align="left" width="10%">
        	<select id="selmatchreferee" name="selmatchreferee" tabindex="16" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%		   try{
			if(crsObjMatchReferee != null){
			while(crsObjMatchReferee.next()){
%>			
			<option value="<%=crsObjMatchReferee.getString("id")%>">
				<%=crsObjMatchReferee.getString("name")%>
			</option>
<%			}
			}
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>          	  
        	</select>	
        </td>
        <td align="right" width="10%"><b><font color="black">Scorrer1:</font></b></td>
        <td align="left" width="10%">
        	<select id="selscorer1" name="selscorer1" tabindex="17" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%			try{
			 for(int i=0; i<htscorerid.size();i++){
%>        	 <option value="<%=htscorerid.get(i)%>"><%=htscorername.get(i)%></option>
<%			 }
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>         	  
        	</select>	
        </td>
      </tr>   
      <tr class="contentLight"  height="15%" >
        <td align="right" width="10%"><b><font color="black">Scorrer2:</font></b></td>
        <td align="left" width="10%">
          <select id="selscorer2" name="selscorer2" tabindex="18" onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup">
        	  <option value="0">select</option>
<%			try{
			 for(int i=0; i<htscorerid.size();i++){
%>        	 <option value="<%=htscorerid.get(i)%>"><%=htscorername.get(i)%></option>
<%			 }
			}catch(Exception e){
			  log.writeErrLog(e.toString());	
			}
%>         	  
        	</select>
        </td>
        <td align="right" width="10%"><b><font color="black">Start Time:</font></b></td>
        <td align="left" width="10%" nowrap="nowrap">
        	<input type="text" name="txtstarttime" id="txtstarttime" value="" class="textBoxAdminMatchSetup" tabindex="19" >	
        	<a id="imganchor" name="imganchor" href="javascript:NewCal('txtstarttime','ddmmyyyy',true,24)">
          <IMG src="/cims/images/cal.gif" border="0"></a>
        </td>
        <td align="right" width="10%"><b><font color="black"> End Time: </font></b></td>
        <td align="left" width="10%">
			<input type="text" name="txtclosetime" id="txtclosetime" value="" class="textBoxAdminMatchSetup" tabindex="20" >
			<a id="imganchor" name="imganchor" href="javascript:NewCal('txtclosetime','ddmmyyyy',true,24)">
          <IMG src="/cims/images/cal.gif" border="0"></a>	
        </td>
      </tr>   
      <tr class="contentDark" height="15%" width="100%">
         <td align="right" width="10%"><b> <font color="black"> Won By Runs: </font></b></td>
        <td align="left" width="10%">
        	<input type="text" name="txtwonbyrun" id="txtwonbyrun" value="" class="textBoxAdminMatchSetup" tabindex="21" >	
        </td>
        <td align="right" width="10%"><b> <font color="black"> Won By Wicket: </font></b></td>
        <td align="left" width="10%">
        	<input type="text" name="txtwonbywicket" id="txtwonbywicket" value="" class="textBoxAdminMatchSetup" tabindex="22" >	
        </td>
        <td align="right" width="10%"><b> <font color="black"> Won By Inning: </font></b></td>
        <td align="left" width="10%">
        	<input type="text" name="txtwonbyinning" id="txtwonbyinning" value="" class="textBoxAdminMatchSetup" tabindex="23" >	
        </td>
      </tr> 
      <tr>
      	<td colspan="6">
     		<center>
     			<input type="button" name="btnadd" id="btnadd" value="Create Match" class="btn btn-warning" tabindex="24" onclick="createMatch();">
     			<input type="hidden" name="hdid" id="hdid" value="0">
     		</center>
      	</td>
      </tr>          
    </table>
</div>
   </form>
	<jsp:include page="Footer.jsp"></jsp:include>
	</div> 
  </body>
</html>     