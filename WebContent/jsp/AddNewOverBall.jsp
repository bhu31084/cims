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
	
	
	
	String matchId = (String)session.getAttribute("matchId1");
	System.out.println("matchId"+matchId);
	String overNumber = request.getParameter("overno");
	String inningId = request.getParameter("inningid");
	String nonstriker = request.getParameter("nonstriker");
	String striker = request.getParameter("striker");
	String bowler = request.getParameter("bowler");
	String starttime = request.getParameter("starttime");
	String ballRun = request.getParameter("ballRun");
	String widenoball = request.getParameter("widenoball");
	//String ballNoBall = request.getParameter("ballNoBall");
	//String ballLegByes = request.getParameter("ballLegByes");
	String byesLegbyes = request.getParameter("byesLegbyes");
	String runType = request.getParameter("runType");
		
//System.out.println("overNumber:::::::>"+overNumber);
//System.out.println("inningId:::::::>"+inningId+"striker///"+striker+"nonstriker"+nonstriker);	
//System.out.println("bowler:::::::>"+bowler);	

	CachedRowSet deleteCrs = null;
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
	Vector spParam = new Vector();
	LogWriter log = new LogWriter();
			
	try{
	
		spParam.add(starttime);
		spParam.add(bowler); 
		spParam.add(nonstriker); 
		spParam.add(striker); 
		spParam.add(inningId); 
		spParam.add(overNumber); 
		spParam.add(ballRun); 
		spParam.add(widenoball); 
		spParam.add(byesLegbyes); 
		spParam.add(runType);  
		deleteCrs = spGenerate.GenerateStoreProcedure("esp_amd_newball",spParam,"ScoreDB");
		spParam.removeAllElements();
	}catch (Exception e) {
	    e.printStackTrace();
	    log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>