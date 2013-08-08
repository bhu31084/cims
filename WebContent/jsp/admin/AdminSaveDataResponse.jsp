<!-- Admin match set up save record response page to get return value after record insertion.-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires",0);
	
	String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
	String gsUmp1 = request.getParameter("ump1")==null?"0":request.getParameter("ump1");
	String gsUmp2 = request.getParameter("ump2")==null?"0":request.getParameter("ump2");
	String gsUmp3 = request.getParameter("ump3")==null?"0":request.getParameter("ump3");
	String gsUmpCoach = request.getParameter("umpCoach")==null?"0":request.getParameter("umpCoach");
	String gsReferee = request.getParameter("referee")==null?"0":request.getParameter("referee");
	String gsAnalyst = request.getParameter("analyst")==null?"0":request.getParameter("analyst");
	String gsAnalyst1 = request.getParameter("analyst1")==null?"0":request.getParameter("analyst1");
	String gsScorer = request.getParameter("scorer")==null?"0":request.getParameter("scorer");
	String gsScorer2 = request.getParameter("scorer2")==null?"0":request.getParameter("scorer2");
	String gsStatus = request.getParameter("status")==null?"0":request.getParameter("status");
	String gsFlag = "1";
	if(gsStatus.equalsIgnoreCase("I")){
		gsFlag = "4";
	}
	CachedRowSet  crsObjInsertRecord = null;
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

	if(request.getParameter("matchId")!= null){
		try{
			vparam.add(matchId);
			vparam.add(gsUmp1);
			vparam.add(gsUmp2);
			vparam.add(gsUmp3);
			vparam.add(gsUmpCoach);
			vparam.add(gsReferee);
			vparam.add(gsAnalyst);
			vparam.add(gsAnalyst1);
			vparam.add(gsScorer);
			vparam.add(gsScorer2);
			vparam.add(gsFlag);				
			crsObjInsertRecord = lobjGenerateProc.GenerateStoreProcedure("esp_amd_prematch_details_modified1",vparam,"ScoreDB");
			vparam.removeAllElements();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>