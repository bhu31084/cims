<!--
	Author 		 : Saudagar Mulik
	Created Date : 02/09/2008
	Description  : Umpire coach report.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="response/error_page.jsp"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>

<%
try{
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MM-dd hh:mm:ss");
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");
		java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd hh:mm");

		String selected_team = "0";
		String selected_player = "0";
		String match_id = session.getAttribute("matchid").toString();
		String user_id = session.getAttribute("userid").toString();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();

		CachedRowSet crsObjViewData = null;
		CachedRowSet crsObjInnings = null;
		CachedRowSet crsObjPlayers = null;
		CachedRowSet crsObjPlayers2 = null;
		
		Vector vparam = new Vector();


%>
<%
		String inning_id = "0";
		String selected_player1 = "0";
		String selected_player2 = "0";
		String selected_type = "0";
		
		if (request.getParameter("hid") != null) {

			if (request.getParameter("hid").equalsIgnoreCase("1")) {

				inning_id = request.getParameter("inning_id");
				vparam = new Vector();
				vparam.add(inning_id);
				crsObjPlayers = lobjGenerateProc.GenerateStoreProcedure(
						"dsp_bowlinglist", vparam, "ScoreDB");
				crsObjPlayers2 = lobjGenerateProc.GenerateStoreProcedure(
						"dsp_bowlinglist", vparam, "ScoreDB");

			} else if (request.getParameter("hid").equalsIgnoreCase("2")) {

				inning_id = request.getParameter("inning_id");
				selected_player1 = request.getParameter("player1");
				selected_player2 = request.getParameter("player2");
				selected_type = request.getParameter("type");

				vparam = new Vector();
				vparam.add(inning_id);
				crsObjPlayers = lobjGenerateProc.GenerateStoreProcedure(
						"dsp_bowlinglist", vparam, "ScoreDB");
				crsObjPlayers2 = lobjGenerateProc.GenerateStoreProcedure(
						"dsp_bowlinglist", vparam, "ScoreDB");
				
				vparam = new Vector();
				vparam.add(match_id);
				vparam.add(inning_id);
				vparam.add(selected_player1);
				vparam.add(selected_player2);
				vparam.add(selected_type);
				vparam.add(user_id);
				crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_ball_pitchedpositions", vparam, "ScoreDB");
			}
		}

		vparam = new Vector();		
		vparam.add(match_id);
		crsObjInnings = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_getInnings", vparam, "ScoreDB");
		
		System.out.println(match_id+":"+inning_id+":"+selected_player1+":"+selected_player2+":"+selected_type);
		%>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
<script>
	function validate(){
		if(document.getElementById("inning_id").value != 0){		
			document.getElementById("hid").value = "1";
			document.frmWagonWheel.submit();
		}		
	}
	
	function getViewData(){		
		if(document.getElementById("type").value == 2){
		if(document.getElementById("player1").value == document.getElementById("player2").value){
			alert("Please select 2 different batsman for parternership wagon wheel.");
		}
		}
		if(document.getElementById("inning_id").value != 0){
			document.getElementById("hid").value = "2";
			document.frmWagonWheel.submit();		
		}else{
			alert("Select inning.");
		}
	}	
	
</script>
<TITLE>Ball pitched report</TITLE>
</HEAD>
<BODY>
<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="frmWagonWheel" method="post"><BR>
<TABLE border=0 width=100% align="center">
	<TR>
		<TD align=center style="background-color:gainsboro;"><font size="5"
			color="#003399"> <b>Pitch report</b></font></td>
	</tr>
	<TR>
		<TD align="right">Date: <B><%= sdf1.format(new Date())%> </B></TD>
	</TR>
</TABLE>
<TABLE border=2 width=50% align="center">
	<THEAD>
		<TH>Inning</TH>
		<TH>Type</TH>
		<TH>Player Name</TH>
		<TH>Partnership with</TH>
	</THEAD>
	<TR>
		<TD align="Center"><SELECT name="inning_id" onchange="validate()"
			id="inning_id">
			<OPTION value="0">- Select Team -</OPTION>
			<%if (crsObjInnings != null) {%>
			<%while (crsObjInnings.next()) {%>
			<%if (crsObjInnings.getString("inning").equals(inning_id)) {%>
			<OPTION value="<%=crsObjInnings.getString("inning")%>"
				selected="selected"><%=crsObjInnings.getString("battingteam")%></OPTION>
			<%} else {%>
			<OPTION value="<%=crsObjInnings.getString("inning")%>"><%=crsObjInnings.getString("battingteam")%></OPTION>
			<%}%>
			<%}%>
			<%}%>
		</SELECT></TD>
		<TD align="Center"><SELECT name="type" id="type">
		
			<OPTION value="-1">- Select -</OPTION>
			
			<%if (selected_type.equalsIgnoreCase("0")) {%>
			<OPTION value="0" selected="selected">Bowler</OPTION>
			<%} else {%>
			<OPTION value="0">Bowler</OPTION>
			<%}%>
			<%if (selected_type.equalsIgnoreCase("1")) {%>
			<OPTION value="1" selected="selected">Batsman</OPTION>
			<%} else {%>
			<OPTION value="1">Batsman</OPTION>
			<%}%>
			<%if (selected_type.equalsIgnoreCase("2")) {%>
			<OPTION value="2" selected="selected">Partnertship</OPTION>
			<%} else {%>
			<OPTION value="2">Partnertship</OPTION>
			<%}%>
			</SELECT></TD>			
		<TD align="Center"><SELECT name="player1"  id="player1">
			<OPTION value="0">- All -</OPTION>
			<%
			if (crsObjPlayers != null) {%>
			<%while (crsObjPlayers.next()) {%>
			<%if (selected_player1.equals(crsObjPlayers.getString("id"))) {%>

			<OPTION value="<%=crsObjPlayers.getString("id")%>"
				selected="selected"><%=crsObjPlayers.getString("playername")%></OPTION>
			<%} else {%>
			<OPTION value="<%=crsObjPlayers.getString("id")%>"><%=crsObjPlayers.getString("playername")%></OPTION>
			<%}
			}
		}%>
		</SELECT></TD>		
		<TD align="Center"><SELECT name="player2" id="player2">
			<OPTION value="0">- All -</OPTION>
			<%if (crsObjPlayers2 != null) {%>
			<%while (crsObjPlayers2.next()) {%>
			<%if (selected_player2.equals(crsObjPlayers2.getString("id"))) {%>

			<OPTION value="<%=crsObjPlayers2.getString("id")%>"
				selected="selected"><%=crsObjPlayers2.getString("playername")%></OPTION>
			<%} else {%>
			<OPTION value="<%=crsObjPlayers2.getString("id")%>"><%=crsObjPlayers2.getString("playername")%></OPTION>
			<%}
			}
		}%>
		</SELECT></TD>
	</TR>
	<TR>
	<TD></TD><TD></TD><TD></TD>
	<TD align="right"><INPUT type="button" value="Show" onclick="getViewData()"></TD>
	</TR>
</TABLE>
<BR>
<BR>
<BR>
<%
		HashMap hm = new HashMap();
		for (int count = 1; count <= 8; count++) {
			hm.put("" + count, "");
		}
		if (crsObjViewData != null) {
			while (crsObjViewData.next()) {
				hm.put(crsObjViewData.getString("pitched_at"), crsObjViewData
						.getString("pitched_at_count"));
			}
			//System.out.println(hm);
		}
%>
<DIV style="position:absolute; top: 25%; left: 35%; border:1"><img
	src="../images/Pitch.jpg" width="250" height="400" border="1"
	align="left" /> <BR>
<LABEL style="position:absolute; top: 45%; left: 30%;"><%= hm.get("1") %></LABEL>
<LABEL style="position:absolute; top: 45%; left: 65%;"><%= hm.get("2") %></LABEL>
<LABEL style="position:absolute; top: 60%; left: 30%;"><%= hm.get("3") %></LABEL>
<LABEL style="position:absolute; top: 60%; left: 65%;"><%= hm.get("4") %></LABEL>
<LABEL style="position:absolute; top: 75%; left: 30%;"><%= hm.get("5") %></LABEL>
<LABEL style="position:absolute; top: 75%; left: 65%;"><%= hm.get("6") %></LABEL>
<LABEL style="position:absolute; top: 90%; left: 30%;"><%= hm.get("7") %></LABEL>
<LABEL style="position:absolute; top: 90%; left: 65%;"><%= hm.get("8") %></LABEL>
</DIV>
<INPUT type="hidden" id="hid" name="hid" /></FORM>
</BODY>
</HTML>

<%}catch(Exception e){
	e.printStackTrace();
	System.err.println(e.toString());
	throw e;
}%>