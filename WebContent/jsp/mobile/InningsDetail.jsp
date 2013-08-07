<!--
	Author 		 : Swapnil Gupta
	Created Date : 25/09/2008
	Description  : Display  top 3 batsman and bowler innings detail for that match 
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
		int count2 = 1;
		int id = 1;
		String matchid = (String) session.getAttribute("matchId");
		HashMap hp = new HashMap();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		CachedRowSet crsObjResultinningbatting = null;
		CachedRowSet crsObjResultmatchinings = null;
		CachedRowSet crsObjResultinningbowling = null;

		Vector vparam = new Vector();
		String buttonid = request.getParameter("button");
		if (buttonid != null) {
			id = Integer.parseInt(buttonid);
		}
		try {
			vparam.add(matchid);
			crsObjResultmatchinings = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_mobileinning ", vparam, "ScoreDB");
			vparam.removeAllElements();
		} catch (Exception e) {
			e.printStackTrace();
		}

		while (crsObjResultmatchinings.next()) {

			Vector vinningname = new Vector();
			vinningname.add(crsObjResultmatchinings.getString("id"));
			vinningname.add(crsObjResultmatchinings.getString("batting"));
			vinningname.add(crsObjResultmatchinings.getString("bowling"));
			hp.put(count2, vinningname);

			count2++;
		}
		//System.out.println((Vector)hp.get(id));
		Vector ininDetail = (Vector) hp.get(id);
		String inning = (String) ininDetail.get(0);

		if (inning != null) {
			try {
				vparam.add(inning);
				vparam.add("0");//
				crsObjResultinningbatting = lobjGenerateProc
						.GenerateStoreProcedure(
								"esp_dsp_batsmanrunsinningsdetail", vparam,
								"ScoreDB");
				vparam.removeAllElements();
				vparam.add(inning);
				vparam.add(matchid);//
				crsObjResultinningbowling = lobjGenerateProc
						.GenerateStoreProcedure(
								"esp_dsp_bowlingscorecardinningdetailsmoblie",
								vparam, "ScoreDB");
				vparam.removeAllElements();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">		
<html>
<head>
<meta http-equiv="Content-Type"
	content="application/xhtml+xml; charset=UTF-8" />
<meta http-equiv="Cache-Control" content="no-cache" />

<title><%=(String) ininDetail.get(1)%>Vs.<%= (String) ininDetail.get(2)%></title>

</head>
<body>
<jsp:include page="MobileMenu.jsp"></jsp:include>
<form name="inningsdetail" action="/cims/jsp/mobile/InningsDetail.jsp" method="post">
Inning > <%
		int count1 = 1;
		while (count2 > count1) {
%> <INPUT type="submit" id="button" name="button" value="<%=count1%>" />
<%
			count1++;
		}
%>

<HR>

<fieldset id="fldsetresult"><legend> <font size="2.5" color="brown"><b>Batting:
<%=(String) ininDetail.get(1)%></b></font> </legend>
<table style="width: 100%;" border="1" title="Live Score"
	cellspacing="1" cellpadding="1">

	<tr align="center" style="font-weight: bold">
		<td>Batsman</td>
		<td>Runs</td>
		<td>Balls</td>
	</tr>

	<%
		if (crsObjResultinningbatting != null) {
			while (crsObjResultinningbatting.next()) {
				%>
	<TR>
		<td align="left"><%=crsObjResultinningbatting.getString("batsman")%></td>
		<td align="right"><%=crsObjResultinningbatting.getString("runs")%></td>
		<td align="right"><%=crsObjResultinningbatting.getString("balls")%></td>
	</tr>
	<TR>
		<%}
		}%>
</table>
</fieldset>
<hr>
<fieldset id="fldsetresult"><legend> <font size="2.5" color="brown"><b>Bowling
:<%=(String) ininDetail.get(2)%></b></font> </legend>

<table style="width: 100%" border="1" title="Live Score" cellspacing="1"
	cellpadding="1">


	<tr align="center" style="font-weight: bold">
		<td>Bowlers</td>
		<td>Over</td>
		<td>Wkt</td>
		<td>Runs</td>
	</tr>
	<%
		if (crsObjResultinningbowling != null) {
			while (crsObjResultinningbowling.next()) {
				%>
	<TR>
		<td align="left"><%=crsObjResultinningbowling.getString("bowler_name")%></td>
		<td align="right"><%=crsObjResultinningbowling.getString("noofover")%></td>
		<td align="right"><%=crsObjResultinningbowling.getString("wicket")%></td>
		<td align="right"><%=crsObjResultinningbowling.getString("runs")%></td>

	</TR>
	<%}
		}%>

</table>
</fieldset>

</form>
</body>
</html>
