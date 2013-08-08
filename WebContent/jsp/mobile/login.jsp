<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" errorPage="../response/error_page.jsp"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="java.sql.SQLException"%>

<%
		if(session.getAttribute("userid") != null){
			session.removeAttribute("userid");
		}
		if(session.getAttribute("matchid") != null){
			session.removeAttribute("matchid");
		}		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MMM-dd");
		java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("yyyy-MMM-dd hh:mm");
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		CachedRowSet crsObjViewData = null;
		Vector vParam = null;
		if (request.getMethod().equalsIgnoreCase("POST")) {
			vParam = new Vector();
			vParam.add(request.getParameter("user"));
			vParam.add(request.getParameter("pass"));
			crsObjViewData = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_authentication", vParam, "ScoreDB");
		}
		%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html>
<head>
<title>Report login</title>
	<link rel="stylesheet" type="text/css" href="../../css/common.css">
	<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">
</head>
<body>
<BR>
<%if (crsObjViewData != null && crsObjViewData.next()
				&& !crsObjViewData.getString("id").equals("0")) {
			session.setAttribute("userid", crsObjViewData.getString("id"));
%>
<jsp:forward page="/cims/jsp/mobile/SelectMatch.jsp"></jsp:forward>
<%} else {%>
<FORM action="" method="post">
<TABLE border=0 width=100% align="center">
	<tr>
		<td align="left" style="background-color:gainsboro;"><font size="4"
			color="#003399"> <b>Login</b></font></td>
	</tr>
	<TR>
		<TD align="right">Date: <B><%= sdf1.format(new Date())%> </B></TD>
	</TR>
</TABLE>

<TABLE align="center" width="100%" border="1" cellspacing="2">
	<TR>
		<TD align="right" width="40%" >Username &nbsp; </TD>
		<TD align="left" width="60%"><INPUT type="text" name="user" maxlength="100%" value="BCCI"></TD>
	</TR>
	<TR>
		<TD align="right" width="40%">Password &nbsp;</TD>
		<TD align="left" width="60%"><INPUT type="password" name="pass" maxlength="100%" value="Bcci"></TD>
	</TR>
</TABLE>
<BR>
<CENTER><INPUT type="submit" value="Login"></CENTER>
</FORM>
<HR>
<label>Powered By BCCI.</label>
<%}%>
</body>
</html>
