<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%// to get teams based on club-- by  dipti
	String matchId = (String)session.getAttribute("matchid")==null?"0":(String)session.getAttribute("matchid");
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	LogWriter log 		= new LogWriter();
	Vector vparam 			     =  new Vector();
	 CachedRowSet  crsObjTeamsCrs =  null;
	 String clubId	= "";
	 clubId	   = request.getParameter("clubId")!=null?request.getParameter("clubId").trim():"";
	 String teamId = request.getParameter("teamid")!=null?request.getParameter("teamid").trim():"";
	try{
		
		vparam.add(clubId);
		crsObjTeamsCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getclubteams",vparam,"ScoreDB");
		vparam.removeAllElements();
%>			<select class="input" name="selTeam" id="selTeam" >
				<option value="0">--select--</option>
<%			if(crsObjTeamsCrs != null){	
			while(crsObjTeamsCrs.next()){	
%>				<option value="<%=crsObjTeamsCrs.getString("id")%>" <%=teamId.equals(crsObjTeamsCrs.getString("id"))?"selected":""%>><%=crsObjTeamsCrs.getString("team_name")%></option>
<%			}
		    }
%>	
				</select>	
<%	}catch(Exception e){
		e.printStackTrace();
	}
%>