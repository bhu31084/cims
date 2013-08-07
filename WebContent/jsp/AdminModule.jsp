<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String username = request.getParameter("username");
response.sendRedirect("/cims/jsp/admin/Menu.jsp?username="+username);
%>