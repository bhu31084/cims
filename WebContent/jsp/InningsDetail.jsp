<!--
	Author 		 : Swapnil Gupta
	Created Date : 25/09/2008
	Description  : Display  top 3 batsman and bowler innings detail for that match 
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%

		int count2 = 1;
		int id = 1;
		String matchid = (String) session.getAttribute("matchid");
		HashMap hp = new HashMap();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchid);
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
<meta http-equiv="refresh" content="120" />
<link rel="stylesheet" type="text/css" href="../css/common.css">
<meta http-equiv="Content-Type"
	content="application/xhtml+xml; charset=UTF-8" />
<meta http-equiv="Cache-Control" content="no-cache" />

<title><%=(String) ininDetail.get(1)%>Vs.<%= (String) ininDetail.get(2)%></title>
	<link href="../css/adminForm.css" rel="stylesheet" type="text/css" />
	<script>
	function callRefresh(){
	document.inningsdetail.submit()
	}
	</script>
</head>
<body>
<jsp:include page="Menu.jsp"></jsp:include>
<form name="inningsdetail" action="InningsDetail.jsp" method="post" >
<br>
<br>
<table width="100%" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
		<tr align="center">
			 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">
		                 <%=(String) ininDetail.get(1)%>Vs.<%= (String) ininDetail.get(2)%> 
		     </td>
		</tr>
</table>		
<%--<label style="font-size: large;font-weight: bold;" ><%=(String) ininDetail.get(1)%>Vs.<%= (String) ininDetail.get(2)%></label>--%>
	<table align="center" width="100%">
		<tr>
			<td align="center" class="contentDark" width="100%">
				<font size="3" color="#8C86BD">Inning ></font>
			
	<%
			int count1 = 1;		
			while (count2 > count1) {
	%>     <INPUT type="submit" class="btn btn-small" id="button" name="button" value="<%=count1%>" />
	<%
				count1++;
			}
	%>
			</td>
		</tr>
	 	<tr>
	 		<td align="center">
				<fieldset><legend class="legend1">Batting:<%=(String) ininDetail.get(1)%></legend> <br>
				
				<br>
				<table style="width: 100%;" class="table" align="center" border="0" title="Live Score"
					cellspacing="1" cellpadding="1">
				
					<tr class="contentDark">
						<td class="colheadinguser">Batsman</td>
						<td class="colheadinguser">Runs</td>
						<td class="colheadinguser">Balls</td>
					</tr>
				
					<%
						if (crsObjResultinningbatting != null) {
							while (crsObjResultinningbatting.next()) {
								%>
					<TR class="contentLight">
						<td><%=crsObjResultinningbatting.getString("batsman")%></td>
						<td><%=crsObjResultinningbatting.getString("runs")%></td>
						<td><%=crsObjResultinningbatting.getString("balls")%></td>
					</tr>
					<TR>
						<%}
						}%>
				</table>
				<BR>
				</fieldset>
			</td>
		</tr>
		<tr>
			<td align="center">
				<fieldset><legend class="legend1">Bowling:<%=(String) ininDetail.get(2)%></legend> <br>
								
				<table style="width: 100%;" class="table" align="center"  border="0" title="Live Score" cellspacing="1"
					cellpadding="1" >
				
				
					<tr class="contentDark">
						<td class="colheadinguser">Bowlers</td>
						<td class="colheadinguser">Over</td>	
						<td class="colheadinguser">Runs</td>
						<td class="colheadinguser">Wkt</td>		
					</tr>
					<%
						if (crsObjResultinningbowling != null) {
							while (crsObjResultinningbowling.next()) {
								%>
					<TR class="contentLight">
						<td><%=crsObjResultinningbowling.getString("bowler_name")%></td>
						<td><%=crsObjResultinningbowling.getString("noofover")%></td>
						<td><%=crsObjResultinningbowling.getString("runs")%></td>
						<td><%=crsObjResultinningbowling.getString("wicket")%></td>		
				
					</TR>
					<%}
						}%>
				
				</table>
				<br>
				</fieldset>
			</td>
		</tr>	

	</table>
	<table style="width: 80%;" align="center">
		<tr>
			<td align="center"><INPUT type="button" class="btn btn-warning" id="button" name="button" value="Refresh" onclick="callRefresh()"/></td>
		</tr>	
		<tr>
			<td >NOTE : This page gets autometically refreshed in every 2 minutes.</td>
		</tr>
	<table>
</form>
</body>
</html>
