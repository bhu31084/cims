<%-- 
    Document   : serverTime
    Created on : Jan 3, 2009, 11:46:59 AM
    Author     : bhushanf
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*"%>
<%  	response.setHeader("Pragma","private");
		response.setHeader("Pragma", "No-cache");
	    response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");  
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
       String type=request.getParameter("type")==null?"":request.getParameter("type");
       if(type.equalsIgnoreCase("1")){ 
            GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();				
            Vector vparam =  new Vector();
            CachedRowSet  lobjCachedRowSet		= null;	
            String	time =	null;
            vparam.add("1");
            lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_time",vparam,"ScoreDB");
            vparam.removeAllElements();
            while(lobjCachedRowSet.next()){	
                    time =lobjCachedRowSet.getString("currentdate");
            }
            out.println(time);
      }  
%>

