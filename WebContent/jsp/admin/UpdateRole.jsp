<!--
Page Name 	 : AddNewOverBall.jsp
Created By 	 : Dipti Shinde.
Created Date : 30/12/2008
Description  : To add new ball in db
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 30/12/2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<%	
	String matchId = request.getParameter("matchId");
	String playerId = request.getParameter("playerId");
	String teamPlayerId = request.getParameter("teamPlayerId");
	String teamId = request.getParameter("teamId");
	String isBatsman = request.getParameter("isBatsman");
	String isBowler = request.getParameter("isBowler");
	String isCaptain = request.getParameter("isCaptain");
	String isWkepr = request.getParameter("isWkepr");
	String isLarmBowler = request.getParameter("isLarmBowler");
	String isLarmBatsman = request.getParameter("isLarmBatsman");
	String isSpinner = request.getParameter("isSpinner");
	String isMpacer = request.getParameter("isMpacer");
	String isPacer = request.getParameter("isPacer");
	
	CachedRowSet setCaptainCrs = null;
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
	Vector spParam = new Vector();
	LogWriter log = new LogWriter();
			
	try{
		spParam.add(matchId);  
		spParam.add(teamPlayerId);  
		spParam.add(teamId); 
		spParam.add(isBatsman); 
		spParam.add(isBowler); 
		spParam.add(isCaptain);
		spParam.add(isWkepr);
		spParam.add(isLarmBowler); 
		spParam.add(isLarmBatsman); 
		spParam.add(isSpinner); 
		spParam.add(isMpacer); 
		spParam.add(isPacer); 
		setCaptainCrs = spGenerate.GenerateStoreProcedure("dbo.esp_amd_match_teamplayer",spParam,"ScoreDB");
		spParam.removeAllElements();
	}catch (Exception e) {
	    e.printStackTrace();
	    log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>