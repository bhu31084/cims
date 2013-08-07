<!--
Page Name 	 : updateInningStartEndTime.jsp
Created By 	 : Dipti Shinde.
Created Date : 22-Oct-2008
Description  : To update wicket ball time
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 23-Oct-2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				in.co.paramatrix.csms.common.Common,
				java.text.SimpleDateFormat,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<%	
	CachedRowSet updateWicketBallCrs = null;
	String matchId = (String)session.getAttribute("matchId1");
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
	Vector spParam = new Vector();
	LogWriter log = new LogWriter();
	Common commonUtil= new Common();
try{
	String inningid	= request.getParameter("inningid");
	//String ballid	= request.getParameter("ballid");
	String inningStartTime = request.getParameter("inningStartTime")==null?"":commonUtil.formatDatewithTime(request.getParameter("inningStartTime"));
	//String nextballid = request.getParameter("nextballid");
	String inningEndTime = request.getParameter("inningEndTime")==null?"":commonUtil.formatDatewithTime(request.getParameter("inningEndTime"));
	
	
	spParam.removeAllElements();	
	spParam.add(inningid);
	spParam.add(inningStartTime); 
	spParam.add(inningEndTime); 
	updateWicketBallCrs = spGenerate.GenerateStoreProcedure("esp_amd_inningStartTimeEndTime",spParam,"ScoreDB");
}catch (Exception e) {
    e.printStackTrace();
    log.writeErrLog(page.getClass(),matchId,e.toString());
}
%>