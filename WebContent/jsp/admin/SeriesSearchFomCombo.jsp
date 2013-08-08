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
		
		String name=null;		
		String desc=null;
		String id= request.getParameter("id");
		try {
			vparam.add(id);
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_seriessearch", vparam, "ScoreDB");
			vparam.removeAllElements();

			while (crsObjResult.next()) {
             name= crsObjResult.getString("name"); 
             desc =crsObjResult.getString("description");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}%>
    <%=id%><br><%=name%><br><%=desc%>
 