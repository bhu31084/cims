<!--
Page Name 	 : TeamPlayersResponse.jsp
Created By 	 : Avadhut Joshi
Created Date : 22nd Oct 2008
Description  : Displaying Players of selected Team Response Page
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
			
		CachedRowSet  TeamscrsObj = null;				
		Vector vparam =  new Vector();
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();	

		try{
			String strTeam = null;
			strTeam = request.getParameter("teamId");
			vparam.add(strTeam); //display teams
			TeamscrsObj = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamplayers_map",vparam,"ScoreDB");
		    vparam.removeAllElements();					
			
		}catch(Exception e){
			e.printStackTrace();
		}
%>
			<div id="divteamplayers">
			<table>
			<tr>
							<td>
			<%if(TeamscrsObj != null){%>							
							
							<select	id="lbSelectedPlayersFrom" multiple="multiple" size="40"  STYLE="width: 360px; height: 550px;overflow:scroll"  >
								<%while(TeamscrsObj.next()){%>
									<option value="<%=TeamscrsObj.getString("user_id")%>"> <%=TeamscrsObj.getString("playername")%></option>
								<%}%>
							</select>
							</td>
							</tr>
			<%}%>
				</table>
			</div>