<!--
	Page Name 	 : PlayerListAssoAjaxResponse.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 07th Jan 2009
	Description  : Ajax Response for Player List 
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>

<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);

%>

<%
        CachedRowSet crsObjResult = null;
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		String name = request.getParameter("pname");
		String clubId = request.getParameter("clubId");
		
		System.out.println("name@@ " + name + " clubId@@ " + clubId);
		if(name != null && clubId != null && clubId != "") { 
		
				try {
					vparam.add(clubId);
					vparam.add(name);
					crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getplayerlist", vparam, "ScoreDB");
					vparam.removeAllElements();
					if(crsObjResult != null && crsObjResult.size() > 0) {
		%>
				<SELECT name="player_id" id="player_id" onkeyup="updatePlayer(event)" onclick="updatePlayer(event)" onkeypress="updatePlayer(event)" style="width:6.0cm" size="10">
		<%
		
						while (crsObjResult.next()) {
		%>
					<option value="<%=crsObjResult.getString("id")%>|<%=crsObjResult.getString("name")%>"><%=crsObjResult.getString("name")%></option>
		<%
						}
					
		%>
				</SELECT>
				
		<%
					} else {
				%>
					
<%--					<font color=red>No Player Found</font>--%>
				
				<%
				} 
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
	%>		
 