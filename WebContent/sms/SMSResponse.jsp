
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'SMS Response.jsp' starting page</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is SMS Response page">
    
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
  </head>
  
  <body>
    This is SMS Response page. <br>
    <%
    	String lsmsisdn 	 = request.getParameter("msisdn");
    	String lsmessage	 = request.getParameter("message");
    	String lsshortCode   = request.getParameter("shortCode");
    	String lsoperator    = request.getParameter("operator");
    	String lscircle      = request.getParameter("circle");
    	
    	System.out.println("In SMS Response.jsp \t:"+new Date()+"\t:"+request.getRemoteAddr());
    	
    	//http://203.193.185.18:8081/cims/sms/SMSResponse.jsp?msisdn=99670xxxxx&message=BCCI&shortCode=12345&operator=Airtel&circle=Mumbai
    	System.out.println("\t msisdn \t:"+lsmsisdn+"\t:"+lsmessage+"\t:"+lsshortCode+"\t:"+lsoperator+"\t:"+lscircle);
    	    	    	
    %>
  </body>
</html>
