<!--
Page Name 	 : updateWicket.jsp
Created By 	 : Dipti Shinde.
Created Date : 22-Oct-2008
Description  : To update wicket details i.e wicket type ,dismissed by fielder1,dissmised by fielder 2
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 23-Oct-2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<%	
	CachedRowSet deleteCrs = null;
	String matchId = (String)session.getAttribute("matchId1");
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
	Vector spParam = new Vector();
	LogWriter log = new LogWriter();
	
	
	String ballId	= request.getParameter("ballId");
	
		
try{	
	spParam.add(ballId); 
	deleteCrs = spGenerate.GenerateStoreProcedure("esp_amd_updateballstatus",spParam,"ScoreDB");
	spParam.removeAllElements();
}catch (Exception e) {
    e.printStackTrace();
    log.writeErrLog(page.getClass(),matchId,e.toString());
}
%>