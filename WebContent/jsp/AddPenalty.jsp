<!--
Page Name 	 : AddPenalty.jsp
Created By 	 : Dipti Shinde.
Created Date : 18/01/2009
Description  : To add new ball in db
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 30/12/2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.csms.common.Common"
%>
<%	
	String matchId = (String)session.getAttribute("matchId1");
	String inningId = request.getParameter("inningId");
	String penaltyId = request.getParameter("penaltyId");
	String flag = request.getParameter("flag");
	String date= null;
	String penaltydate = null;
		
	CachedRowSet addPenaltyCrs = null;
	CachedRowSet deletePenaltyCrs = null;
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
	Vector spParam = new Vector();
	LogWriter log = new LogWriter();
	Common commonUtil= new Common();
	
	if(flag.equalsIgnoreCase("1")){	//for add//penaltydate
	penaltydate = request.getParameter("penaltydate")== null?"": commonUtil.formatDatewithTime(request.getParameter("penaltydate"));
	
		try{
			spParam.add(inningId);
			spParam.add(penaltyId); 
			spParam.add(penaltydate); 
			addPenaltyCrs = spGenerate.GenerateStoreProcedure("esp_amd_addpenalty",spParam,"ScoreDB");
			spParam.removeAllElements();
		}catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}else if(flag.equalsIgnoreCase("2")){
		date = request.getParameter("date");
		try{
			spParam.add(penaltyId);
			spParam.add(date); 
			spParam.add(inningId);
			deletePenaltyCrs = spGenerate.GenerateStoreProcedure("esp_amd_deletepenalty",spParam,"ScoreDB");
			spParam.removeAllElements();
		}catch (Exception e){
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}	
%>