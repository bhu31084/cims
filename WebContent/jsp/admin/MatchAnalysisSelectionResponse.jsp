<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires",0);
	final String SCORER_ROLE = "3";
	final String ANALYST_ROLE = "29";
	CachedRowSet  crsObjScorer = null;
	CachedRowSet  crsObjScorer2 = null;
	CachedRowSet  crsObjTeamsId = null;
	CachedRowSet  crsObjAnalyst = null;
	CachedRowSet  crsObjAnalyst1 = null;
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

	String mId = new String();
	String team1Id = new String();
	String team2Id = new String();		
	String analyst_id = "";
	String analyst = "";
	String analyst1_id = "";
	String analyst1 = "";
	String scorer_id = "";
	String scorer = "";
	String scorer2_id = "";
	String scorer2 = "";
				
	//String scorerId = new String();
	String match_id = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
	String Preval = "0";
	String Postval = "0";
	try{
		vparam.add(match_id);//display teams
		crsObjTeamsId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_modifymatch",vparam,"ScoreDB");
	    vparam.removeAllElements();
		while(crsObjTeamsId.next()){
			mId = crsObjTeamsId.getString("match_id");
			team1Id = crsObjTeamsId.getString("team1_id");
			team2Id = crsObjTeamsId.getString("team2_id");
			scorer_id = crsObjTeamsId.getString("scorer_id");
			scorer = crsObjTeamsId.getString("scorer");
			scorer2_id = crsObjTeamsId.getString("scorer2_id");
			scorer2 = crsObjTeamsId.getString("scorer2");
			analyst_id = crsObjTeamsId.getString("analyst_id");
			analyst = crsObjTeamsId.getString("analyst");
			analyst1_id = crsObjTeamsId.getString("analyst1_id");
			analyst1 = crsObjTeamsId.getString("analyst1");
		}
	}catch(Exception e){
		e.printStackTrace();
	}		

	try{	
		vparam.add(ANALYST_ROLE);//To insert Umpire Coach id's in Combo box.
		vparam.add(team1Id);
		vparam.add(team2Id);
		vparam.add(mId);
		vparam.add(Preval);
		vparam.add(Postval);
		crsObjAnalyst = lobjGenerateProc.GenerateStoreProcedure("dsp_scorerlist1",vparam,"ScoreDB");
	    vparam.removeAllElements();	
	}catch(Exception e){
		e.printStackTrace();
	}
	
	try{	
		vparam.add(ANALYST_ROLE);//To insert Umpire Coach id's in Combo box.
		vparam.add(team1Id);
		vparam.add(team2Id);
		vparam.add(mId);
		vparam.add(Preval);
		vparam.add(Postval);
		crsObjAnalyst1 = lobjGenerateProc.GenerateStoreProcedure("dsp_scorerlist1",vparam,"ScoreDB");
	    vparam.removeAllElements();	
	}catch(Exception e){
		e.printStackTrace();
	}
%>		
<div id="MatchAnalystDiv">
	<%if(crsObjAnalyst != null){%>
	<select name="dpAnalyst" id="dpAnalyst<%=mId%>">
		<%if(analyst == null){%>
		<option value=""></option>
		<%}else{%>
		<option value="<%=analyst_id%>"><%=analyst%></option>
		<%}%>					
		<option value=""></option>
			<%while(crsObjAnalyst.next()){%>
				<%if(crsObjAnalyst.getString("analystid").equalsIgnoreCase(analyst_id)){%>
		<option value="<%=crsObjAnalyst.getString("analystid")%>" selected="selected"><%=crsObjAnalyst.getString("analystname")%></option>
				<%}else{%>
		<option value="<%=crsObjAnalyst.getString("analystid")%>"><%=crsObjAnalyst.getString("analystname")%></option>
			<%}	%>
		<%}%>
	</select>
	<%}%>
</div>
<br>
<div id="MatchAnalyst1Div">
	<%if(crsObjAnalyst1 != null){%>
	<select name="dpAnalyst1" id="dpAnalyst1<%=mId%>">
		<%if(analyst1 == null){%>
		<option value=""></option>
		<%}else{%>
		<option value="<%=analyst1_id%>"><%=analyst1%></option>
		<%}%>					
		<option value=""></option>
			<%while(crsObjAnalyst1.next()){%>
				<%if(crsObjAnalyst1.getString("analystid").equalsIgnoreCase(analyst1_id)){%>
		<option value="<%=crsObjAnalyst1.getString("analystid")%>" selected="selected"><%=crsObjAnalyst1.getString("analystname")%></option>
				<%}else{%>
		<option value="<%=crsObjAnalyst1.getString("analystid")%>"><%=crsObjAnalyst1.getString("analystname")%></option>
			<%}	%>
		<%}%>
	</select>
	<%}%>
</div>