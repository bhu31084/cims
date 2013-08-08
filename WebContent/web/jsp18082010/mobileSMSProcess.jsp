<!--
	Page Name 	 : mobileSMSProcess.jsp
	Created By 	 : Dipti Shinde.
	Created Date : 17th Mar 2009.
	Description  : SMS Processing.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.sms.SmsSender"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,java.io.*,java.lang.*"%>

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
    	String message 	 = request.getParameter("message");
    	String contactNumber	 = request.getParameter("mobileNo");
    	String url = null;
    	    	       	   	
    	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
    	CachedRowSet  crsSendMessage = null;
    	Vector vparam =  new Vector();
    				
		try{
			SmsSender smssender = new SmsSender();
			url = smssender.buildUrl(contactNumber,message);//retrieved url from java class
System.out.println(":::::::url"+url);
			vparam.removeAllElements();
		}catch(Exception e){
			System.out.println("Exception : "+e);
			e.printStackTrace();
		}	
 %>
<html>
  <head>
  
  </head>
  <title>SMS Process</title> 
  <body>
<%="$"+url+"$"%>
  </body>
</html>
