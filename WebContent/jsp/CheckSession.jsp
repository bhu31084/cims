<%--
  @Author: Vishwajeet Khot
  Date: Oct 22, 2008
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<html>
  <head>

    <title>Check Session</title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    
 </head>
 <body>
    <%
    	String sessionUserId = (String) session.getAttribute("userid");    	
    	if(sessionUserId == null) {
    	System.out.println("in ");
	%>    	
     	<jsp:forward page="/jsp/Logout.jsp">
			<jsp:param name="message" value="Your are not logged in." />
		</jsp:forward>
	<%
    	}
    %>
 </body>
</html>
