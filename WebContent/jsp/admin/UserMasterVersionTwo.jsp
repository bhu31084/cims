<!--
Page name: MasterUser.jsp
Replaced By  : Vaibhav Gaikar.
Created Date : 17th Sep 2008
Description  : To add User details in Database
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<html>
	<head>
			<title> Official Data </title>    
			<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
	</head>
	<body>
			<jsp:include page="Menu.jsp"></jsp:include>
			<br>
			<br>
			<br>
			<div id="userdetail" name="userdetail">
				<%@include file="UserVersionTwo.jsp"%>
			</div>		
			<div id="searchUser" name="searchUser">
			</div>
	</body>
</html>