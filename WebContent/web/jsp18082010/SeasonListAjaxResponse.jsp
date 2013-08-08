<!--
	Page Name 	 : SeasonListAjaxResponse.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 22th Nov 2008
	Description  : Ajax Response for Season List
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
		
		String name = request.getParameter("seasonName");
		
		try {
			vparam.add(name);
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_seasonlist", vparam, "ScoreDB");
			vparam.removeAllElements();
			if(crsObjResult != null && crsObjResult.size() > 0) {
%>
		<SELECT name="season_id" id="season_id" onkeyup="updateSeason(event)" onclick="updateSeason(event)" onkeypress="updateSeason(event)" class="inputsearch" style="width:2.0cm;font-size: 11px;" size="5">
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
			<font color=red>No Season Found</font>		
<%
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
		
 