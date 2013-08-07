<!-- Scorer selection save record response page to get return value after record insertion.-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%--<%@ include file="AuthZ.jsp" %>--%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires",0);
%>
<%
	String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
	String gsUmp1 = "";
	String gsUmp2 = "";
	String gsUmp3 = "";
	String gsUmpCoach = "";
	String gsReferee = "";
	String gsAnalyst = request.getParameter("analyst")==null?"0":request.getParameter("analyst");
	String flag = request.getParameter("gsflag")==null?"0":request.getParameter("gsflag");
	String spName = "";
	if(flag.equalsIgnoreCase("scorer")){
		spName = "esp_amd_prematch_details_modified1";
	}else if(flag.equalsIgnoreCase("analysis")){
		spName = "esp_amd_prematch_analysis_details_modified1";
	}else{
		spName = "esp_amd_prematch_details_modified1";
	}
	String gsAnalyst1 = request.getParameter("analyst1")==null?"0":request.getParameter("analyst1");
	String gsScorer = request.getParameter("scorer")==null?"0":request.getParameter("scorer");
	String gsScorer2 = request.getParameter("scorer2")==null?"0":request.getParameter("scorer2");
	String gsFlag = "3";
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
				if(!flag.equalsIgnoreCase("scorer")){
					vparam.add(gsAnalyst1);
				}else{
					vparam.add("");
				}
				vparam.add(gsScorer);
				vparam.add(gsScorer2);
				vparam.add(gsFlag);
				crsObjInsertRecord = lobjGenerateProc.GenerateStoreProcedure(spName,vparam,"ScoreDB");
				vparam.removeAllElements();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
%>