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
		
		String resultname=null;		
		String resultdesc=null;
		String resultid= request.getParameter("Resultid");
		try {
			vparam.add(resultid);
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_resultsearch", vparam, "ScoreDB");
			vparam.removeAllElements();

			while (crsObjResult.next()) {
             resultname= crsObjResult.getString("name"); 
             resultdesc =crsObjResult.getString("description");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
	
    <%=resultid%><br><%=resultname%><br><%=resultdesc%>