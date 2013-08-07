
<%@ page language="java" pageEncoding="UTF-8" isErrorPage="true"%>
<%
		String errMsg = null;
		if (session.getAttribute("message") != null) {
			errMsg = session.getAttribute("message").toString();
			session.removeAttribute("message");
		}%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>Error</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" type="text/css" href="../../css/common.css">
<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">
<link rel="stylesheet" type="text/css" href="../../css/menu.css">
<link rel="stylesheet" type="text/css" href="../../CSS/Styles.css">
</head>

<body>
<BR>
<BR>
<H1 style="color: red;">Error encounter!!!</H1>
<HR>
<b> Sorry for incovenience. <BR>
We will try to solve this error as early as possible.<BR>
<br>
<hr>
Error message:<BR>
<LABEL> <%if (errMsg != null) {%> <%=errMsg%> <%} else {%> <I>Unknown error.</I>
<%}%> </LABEL> </b>

</body>
</html>
