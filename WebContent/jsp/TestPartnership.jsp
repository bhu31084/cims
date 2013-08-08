<!--
	Author 		 :Saudagar Mulik
	Created Date : 02/09/2008
	Description  : Test Hundred Partnership Detail.
	Company 	 : Paramatrix Tech Pvt Ltd.
	Modified	 : On 
-->
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="java.sql.SQLException"%>
<%
		String inningId = "";
		String matchId = "";
		String totalminutes = "";
		String overallball = "";
		matchId = session.getAttribute("matchid").toString();
		inningId = (String) request.getParameter("inningIdOne") != null ? request
				.getParameter("inningIdOne")
				: "";
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(
				matchId);
		CachedRowSet crsObjDetails = null;
		Vector vparam = new Vector();
		vparam.add(inningId);
		crsObjDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_hundred_partnershipdtls", vparam, "ScoreDB");
		%>
<html>
<body>
<table border="1" width=100% align=center>
	<TR>
		<TD colspan="3" align=center><font size=1>HUNDRED PARTNERSHIP<br>
		(FOR BOTH TEAMS)</font></TD>
		<TD colspan="2" align=center><font size=1>For 50</font></TD>
		<TD colspan="2" align=center><font size=1>For 100</font></TD>
		<TD colspan="2" align=center><font size=1>For 150</font></TD>
		<TD colspan="2" align=center><font size=1>For 200</font></TD>
		<TD colspan="2" align=center><font size=1>For 250</font></TD>
		<TD colspan="2" align=center><font size=1>For 300</font></TD>
		<TD colspan="2" align=center><font size=1>For 350</font></TD>
		<TD colspan="2" align=center><font size=1>For 400</font></TD>
		<TD colspan="2" align=center><font size=1>For 450</font></TD>
		<TD colspan="2" align=center><font size=1>For 500</font></TD>
		<TD colspan="2" align=center><font size=1>For 550</font></TD>
		<TD colspan="2" align=center><font size=1>ENTIRE</font></TD>
	</TR>
	<TR>
		<TD colspan="1" align=center><font size=1>Wkt.</TD>
		<TD colspan="1" align=center><font size=1>Runs</TD>
		<TD colspan="1" align=center><font size=1>Batsman</TD>
		<TD colspan="1" align=center><font size=1>Mins</TD>
		<TD colspan="1" align=center><font size=1>Balls</TD>
		<TD colspan="1" align=center><font size=1>Mins</TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<TD colspan="1" align=center><font size=1>Mins</font></TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<TD colspan="1" align=center><font size=1>Mins</font></TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<TD colspan="1" align=center><font size=1>Mins</font></TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<TD colspan="1" align=center><font size=1>Mins</font></TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<TD colspan="1" align=center><font size=1>Mins</font></TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<TD colspan="1" align=center><font size=1>Mins</font></TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<TD colspan="1" align=center><font size=1>Mins</font></TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<TD colspan="1" align=center><font size=1>Mins</font></TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<TD colspan="1" align=center><font size=1>Mins</font></TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<TD colspan="1" align=center><font size=1>Mins</font></TD>
		<TD colspan="1" align=center><font size=1>Balls</font></TD>
		<%int total_balls = 0;
		int total_mins = 0;
		int count = 11;
		boolean flag = false;
		boolean isAnyRecord = false;
		if (crsObjDetails != null) {
			while (crsObjDetails.next()) {
				isAnyRecord = true;
				if (crsObjDetails.getInt("run_range") == 50) {
					for (; count < 11; count++) { %>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					<%}
					count = 1;
					if (!flag) {
						flag = true;
					} else { %>
						<TD align=right><font color="#003399"><%=total_mins%></font></TD>
						<TD align=right><font color="#003399"><%=total_balls%></font></TD>
					<%}
					//total_mins = crsObjDetails.getInt("totalminutes");
					//total_balls = crsObjDetails.getInt("overallball");
	%>
	</tr>
	<tr>
		<TD align=right><font color="#003399">
			<%=crsObjDetails.getString("wkt") != null ? crsObjDetails.getString("wkt"):"0"%></font>
		</TD>
		<TD align=right><font color="#003399">
				<%=crsObjDetails.getString("totalruns") != null ? crsObjDetails.getString("totalruns"):"0"%></font>
		</TD>
		<TD align=left><font color="#003399">
		<%=crsObjDetails.getString("batsman1") != null ? crsObjDetails.getString("batsman1"):""%>/<%=crsObjDetails.getString("batsman2") != null ? crsObjDetails.getString("batsman2"):""%></font></TD>
		<TD align=right><font color="#003399"><%=crsObjDetails.getString("minutes") != null ? crsObjDetails.getString("minutes"): "0"%></font></TD>
		<TD align=right><font color="#003399"><%=crsObjDetails.getString("totalball") != null ? crsObjDetails.getString("totalball"): "0"%></font></TD>
		<% } else {
					count = count + 1;
					//total_balls = crsObjDetails.getInt("overallball")!=null?crsObjDetails.getInt("overallball"):"0";	
					//total_mins  = crsObjDetails.getInt("totalminutes")!=null?crsObjDetails.getInt("totalminutes"):"0";
					%>
		<TD align=right><font color="#003399">
			<%=crsObjDetails.getString("minutes") != null ? crsObjDetails.getString("minutes"):"0"%></font>
		</TD>
		<TD align=right><font color="#003399">
			<%=crsObjDetails.getString("totalball") != null ? crsObjDetails.getString("totalball"):"0"%></font>
		</TD>
		<%}
			total_mins  =  crsObjDetails.getInt("totalminutes");
			total_balls = crsObjDetails.getInt("overallball");
			}
		}
		for (; count < 11; count++) {%>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<%}
		count = 0;
		%>
		<%if (isAnyRecord) {
		%>
		<TD align=right><font color="#003399"><%=total_mins%></TD>
		<TD align=right><font color="#003399"><%=total_balls%></TD>
		<%}%>
	</tr>
</table>
</body>
</html>
