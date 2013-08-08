<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>

<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);

        CachedRowSet crsObjResult = null;
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
			
		String stateid= request.getParameter("StateId");
		try {
			vparam.add(stateid);
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_citysearch", vparam, "ScoreDB");
			vparam.removeAllElements();
			%>
			<select class="input"  style="width:6cm" id="itemlist5" name="itemlist5" size="5"
				onclick="update5(event)"	onkeypress="update5(event)">
<%
			while (crsObjResult.next()) {
			%>
			<option value="<%=crsObjResult.getString("id")%>" ><%=crsObjResult.getString("name")%> </option>
			
			<%
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
        </select>