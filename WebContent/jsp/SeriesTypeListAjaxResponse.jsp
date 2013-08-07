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
		
		String name = request.getParameter("seriesName");
		
		try {
			vparam.add(name);
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getseriestypes", vparam, "ScoreDB");
			vparam.removeAllElements();
			if(crsObjResult != null && crsObjResult.size() > 0) {
%>
		<SELECT name="series_id" id="series_id" onkeyup="updateSeriesType(event)" onclick="updateSeriesType(event)" onkeypress="updateSeriesType(event)" class="inputsearch" style="width:5.5cm" size="5">
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
			<font color=red>No Series Found</font>
<%
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
		
 