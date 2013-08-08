
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="response/error_page.jsp"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="java.sql.SQLException"%>

<%		//session.setAttribute("userid", "1");
		//session.setAttribute("matchid", "1");

		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MM-dd hh:mm:ss");
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");
		java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd hh:mm");
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		CachedRowSet crsObjViewData = null;
		Vector vParam = null;
		if (request.getMethod().equalsIgnoreCase("POST")) {
			vParam = new Vector();
			vParam.add(request.getParameter("user"));
			vParam.add(request.getParameter("pass"));
			crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_authentication", vParam, "ScoreDB");
		}

		%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">



<title>Report login</title>

</head>

<body>

<BR>
<BR>

<%if (crsObjViewData != null && crsObjViewData.next()
				&& !crsObjViewData.getString("id").equals("0")) {
			out.println("Login Successful");
			session.setAttribute("userid", crsObjViewData.getString("id"));
			session.setAttribute("matchid", "31");			
%>
<jsp:forward page="SelectMatch.jsp"></jsp:forward>
<%} else {%>

<FORM action="" method="post">
<TABLE border=0 width=100% align="center">
	<tr>
		<td align="center" style="background-color:gainsboro;"><font size="5"
			color="#003399"> <b>Authentication for Reports</b></font></td>
	</tr>
	<TR>
		<TD align="right">Date: <B><%= sdf1.format(new Date())%> </B></TD>
	</TR>
</TABLE>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<TABLE align="center" width="25%" border="5" bgcolor="SILVER"
	cellspacing="5">
	<TR>
		<TD align="center">User Name</TD>
		<TD align="center"><INPUT type="text" name="user" maxlength="20"></TD>
	</TR>
	<TR>
		<TD align="center">Password</TD>
		<TD align="center"><INPUT type="password" name="pass" maxlength="20"></TD>
	</TR>
</TABLE>
<BR>
<BR>
<CENTER><INPUT type="submit" value="Login"></CENTER>
</FORM>
<br>
<%}%>
</body>
</html>
