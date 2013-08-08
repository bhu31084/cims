<!--
	Author 		 : Saudagar Mulik
	Created Date : 02/09/2008
	Description  : Umpire coach report.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" errorPage="../response/error_page.jsp"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%
		try {
			if (session.getAttribute("userid") == null) {
				session.setAttribute("message", "You have not logged in.");
				throw new Exception();
			}
			CachedRowSet crsObjViewData = null;
			CachedRowSet crsObjMatches = null;

			GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
			Vector vparam = new Vector();

			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy/MM/dd");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("dd/MM/yyyy");

			String match_id = "0";

			Common common = new Common();

			String date_one = sdf2.format(new Date());
			String date_two = sdf2.format(new Date());
			vparam = new Vector();
			vparam.add(common.formatDate(date_one));
			vparam.add(common.formatDate(date_two));
			crsObjMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_mob_getmatches", vparam, "ScoreDB");
			%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html>
<head>
<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../../css/common.css">
<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">
<link rel="stylesheet" type="text/css" href="../../css/menu.css">
<link rel="stylesheet" type="text/css" href="../../CSS/Styles.css">
<title>Select match</title>

</head>

<body>
<BR>
<FORM action="/cims/jsp/mobile/ScoreSummary.jsp" name="selectmatch" method="post">
<TABLE border=0 width=80% align="center">
	<tr>
		<td align="center" style="background-color:gainsboro;"><font size="5"
			color="#003399"> <b>Match</b></font></td>
	</tr>
	<TR>
		<TD align="right">Date: <B><%= sdf1.format(new Date())%> </B></TD>
	</TR>
</TABLE>
<FIELDSET style="width: 95%;"><LEGEND>Select Match</LEGEND> <BR>
<TABLE align="center" width="95%" border="0" bgcolor="WHITE"
	cellspacing="1" cellpadding="1">

	<TR>
		<TD align="center"><SELECT name="matchid">
			<OPTION value="0">- Select Match -</OPTION>
			<%
			if (crsObjMatches != null) {
				while (crsObjMatches.next()) {
					if (crsObjMatches.getString("matches_id").equals(match_id)) {
						%>
			<OPTION selected="selected"
				value="<%=crsObjMatches.getString("matches_id")%>"><%=crsObjMatches.getString("matches_id")%>.
			<%=crsObjMatches.getString("team_one")%> Vs. <%=crsObjMatches.getString("team_two")%></OPTION>
			<%
					} else {%>
			<OPTION value="<%=crsObjMatches.getString("matches_id")%>"><%=crsObjMatches.getString("matches_id")%>.
			<%=crsObjMatches.getString("team_one")%> Vs. <%=crsObjMatches.getString("team_two")%></OPTION>
			<%}
				}
			}%>
		</SELECT></TD>
	</TR>
</TABLE>
<BR>
</FIELDSET>

<BR>
<BR>
<CENTER>
<INPUT type="submit" value="Continue">
<a href="/cims/jsp/mobile/login.jsp"> Logout</A>
<INPUT type="hidden" id="hid" name="hid" />
</CENTER>
</FORM>
</body>
</html>
<%
		} catch (Exception e) {
			//session.setAttribute("message",e.toString());
			e.printStackTrace();
			throw e;
		}
%>
