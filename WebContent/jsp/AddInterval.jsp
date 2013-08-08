<!--
Page Name 	 : AddInterval.jsp
Created By 	 : Dipti Shinde.
Created Date : 14/04/2009
Description  : To add new interval
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.csms.common.Common"
%>
<%	
	String matchId = (String)session.getAttribute("matchId1");
	String inningId = request.getParameter("inningId");
	String intervalId = request.getParameter("intervalId");
	String flag = request.getParameter("flag");
	String date= null;
	String startTime = null;
	String endTime = null;
		
	CachedRowSet addIntervalCrs = null;
	CachedRowSet deleteIntervalCrs = null;
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
	Vector spParam = new Vector();
	LogWriter log = new LogWriter();
	Common commonUtil= new Common();
	
	startTime = request.getParameter("startTime")== null?"": commonUtil.formatDatewithTime(request.getParameter("startTime"));
	endTime = request.getParameter("endTime")== null?"": commonUtil.formatDatewithTime(request.getParameter("endTime"));

	if(flag != null){	
		try{
			spParam.add(inningId);
			spParam.add(intervalId); 
			spParam.add(startTime); 
			spParam.add(endTime); 
			spParam.add(flag); 
			addIntervalCrs = spGenerate.GenerateStoreProcedure("esp_amd_adddeleteinterval",spParam,"ScoreDB");
			spParam.removeAllElements();
		}catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}
%>