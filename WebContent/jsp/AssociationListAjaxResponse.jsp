<!--
	Page Name 	 : PlayerListAjaxResponse.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 22th Nov 2008
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
		
		String name = request.getParameter("assoName");
		
		try {
			vparam.add(name);
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_clubs_playerlist", vparam, "ScoreDB");
			vparam.removeAllElements();
			if(crsObjResult != null && crsObjResult.size() > 0) {
%>
		<SELECT name="club_id" id="club_id" onkeyup="updateAsso(event)" onclick="updateAsso(event)" onkeypress="updateAsso(event)" class="inputsearch"	style="width:5.5cm" size="10">
<%

				while (crsObjResult.next()) {
%>
			<option value="<%=crsObjResult.getString("id")%>-<%=crsObjResult.getString("name")%>"><%=crsObjResult.getString("name")%></option>
<%
				}
			
%>
		</SELECT>
		
<%
		} else {%>
				<font color=red>No Association Found</font>
		<%}
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
		
 