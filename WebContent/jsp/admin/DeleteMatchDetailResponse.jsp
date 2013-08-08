<!-- Admin match set up delete record response page to get return value after record deletion.-->
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
%>
<% 
	String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");	
	String gsUmp1 = "";
	String gsUmp2 = "";
	String gsUmp3 = "";
	String gsUmpCoach = "";
	String gsReferee = "";
	String gsAnalyst = "";
	String gsAnalyst1 = "";
	String gsScorer = "";
	String gsScorer2 = "";
	String gsFlag = "2";
	String remark = "";
	System.out.println("matchid " +matchId);	
	CachedRowSet  crsObjDeleteRecord = null;			
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
			//vparam.add(gsAnalyst1);
			vparam.add(gsScorer);
			vparam.add(gsScorer2);
			vparam.add(gsFlag);										
			crsObjDeleteRecord = lobjGenerateProc.GenerateStoreProcedure("esp_amd_prematch_details_modified1",vparam,"ScoreDB");
			vparam.removeAllElements();
			if(crsObjDeleteRecord != null){
				while(crsObjDeleteRecord.next()){
					remark = crsObjDeleteRecord.getString("remark");						
				}
			}	
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>
	<div id="divReturnMessage" ><%=remark%>
	</div>		