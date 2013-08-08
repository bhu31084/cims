<!--
Page Name 	 : TeamResponse.jsp
Created By 	 : Avadhut Joshi
Created Date : 07th Oct 2008
Description  : Displaying Teams Response Page
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
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
			
		CachedRowSet  crsObjTeams = null;				
		Vector vparam =  new Vector();
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();	
		
		try{
			String user_id = session.getAttribute("userid").toString();
			vparam.add(user_id);//display teams
			crsObjTeams = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teams_playermap",vparam,"ScoreDB");
		    vparam.removeAllElements();					
		}catch(Exception e){
			e.printStackTrace();
		}
%>
		<div id="TeamsDiv">
		<%if(crsObjTeams != null){%>						
				<select onfocus = "this.style.background = '#FFFFCC'" class="inputField" name="cmbTeam" id="cmbTeam">									
					<option value="0" >select</option>
					<%while(crsObjTeams.next()){%>
					<option value="<%=crsObjTeams.getString("id")%>" ><%=crsObjTeams.getString("team_name")%></option>
					<%}%>
				</select>																
		<%}%>
		</div>