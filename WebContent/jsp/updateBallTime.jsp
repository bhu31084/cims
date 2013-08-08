<!--
Page Name 	 : updateBallTime.jsp
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
	String batsmanid	= request.getParameter("batsmanid");//
	String inningid	= request.getParameter("inningid");
	//String ballid	= request.getParameter("ballid");
	String wicketBallTime = request.getParameter("wicketBallTime")==null?"":commonUtil.formatDatewithTime(request.getParameter("wicketBallTime"));
	//String nextballid = request.getParameter("nextballid");
	String wicketNextBallTime = request.getParameter("wicketNextBallTime")==null?"":commonUtil.formatDatewithTime(request.getParameter("wicketNextBallTime"));
	String hidwicketBallTime = request.getParameter("hidwicketBallTime")==null?"":commonUtil.formatDatewithTime(request.getParameter("hidwicketBallTime"));
	String hidwicketNextBallTime = request.getParameter("hidwicketNextBallTime")==null?"":commonUtil.formatDatewithTime(request.getParameter("hidwicketNextBallTime"));
	
	spParam.removeAllElements();	
	spParam.add(batsmanid); 
	spParam.add(inningid);
	spParam.add(wicketBallTime); 
	spParam.add(wicketNextBallTime);
	spParam.add(hidwicketBallTime);
	spParam.add(hidwicketNextBallTime);
	updateWicketBallCrs = spGenerate.GenerateStoreProcedure("esp_amd_updateWicketBatsmanTime",spParam,"ScoreDB");
}catch (Exception e) {
    e.printStackTrace();
    log.writeErrLog(page.getClass(),matchId,e.toString());
}
%>