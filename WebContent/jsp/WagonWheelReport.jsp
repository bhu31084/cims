<!--
	Author 				: Saudagar Mulik
	Created Date		: 02/09/2008
	Description 		: Umpire coach report.
	Company 	 		: Paramatrix Tech Pvt Ltd.
	Modification Date	: 12/09/2008
-->

<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="response/error_page.jsp"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="java.sql.SQLException"%>
<%
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MM-dd hh:mm:ss");
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");
		java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd hh:mm");

		String inning_id = "0";
		String selected_player1 = "0";
		String selected_player2 = "0";
		String selected_type = "0";
		String match_id = session.getAttribute("matchid").toString();

		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();

		CachedRowSet crsObjInnings = null;
		CachedRowSet crsObjPlayers = null;
		CachedRowSet crsObjPlayers2 = null;

		Vector vparam = new Vector();

		if (request.getParameter("hid") != null) {
			if (request.getParameter("hid").equalsIgnoreCase("1")) {
				inning_id = request.getParameter("inning_id");
				vparam = new Vector();
				vparam.add(inning_id);
				crsObjPlayers = lobjGenerateProc.GenerateStoreProcedure(
						"dsp_batsmenlist", vparam, "ScoreDB");
				crsObjPlayers2 = lobjGenerateProc.GenerateStoreProcedure(
						"dsp_batsmenlist", vparam, "ScoreDB");
			}
		}

		vparam = new Vector();
		vparam.add(match_id);
		crsObjInnings = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_getInnings", vparam, "ScoreDB");
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">

<script type="text/javascript"> 

var tmpXmlHttpObject; 

function createRequestObject() {	   
    if (window.XMLHttpRequest) { 
        tmpXmlHttpObject = new XMLHttpRequest();	
    } else if (window.ActiveXObject) { 
        tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
    }
    
	var inning_id = document.getElementById("inning_id").value;
	var player1 = document.getElementById("player1").value;
	var player2 = document.getElementById("player2").value;
	var type = document.getElementById("type").value;
	
    var url = "?inningid="+inning_id+"&player1="+player1+"&player2="+player2+"&type="+type;
    tmpXmlHttpObject.open("get", "/cims/jsp/response/WagonWheelReport.jsp"+url);
    tmpXmlHttpObject.onreadystatechange = processResponse;
    tmpXmlHttpObject.send(null);
}


function processResponse() {
    if(tmpXmlHttpObject.readyState == 4){
        document.getElementById('val').innerHTML = tmpXmlHttpObject.responseText;
   }
}	
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
			//document.getElementById("hid").value = "2";
			createRequestObject()
		}else{
			alert("Select inning.");
		}
}	
</script>

<title>Wagon wheel</title>
</head>
<body>
<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="frmWagonWheel" action="/cims/jsp/WagonWheelReport.jsp" method="post"><br>
<TABLE border=0 width=100% align="center">
	<tr>
		<td align="center" style="background-color:gainsboro;"><font size="5"
			color="#003399"> <b>Wagon wheel report.</b></font></td>
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
			<OPTION value="0" selected="selected">Batsman</OPTION>
			<%} else {%>
			<OPTION value="0">Batsman</OPTION>
			<%}%>
			<%if (selected_type.equalsIgnoreCase("1")) {%>
			<OPTION value="1" selected="selected">Bowler</OPTION>
			<%} else {%>
			<OPTION value="1">Bowler</OPTION>
			<%}%>
			<%if (selected_type.equalsIgnoreCase("2")) {%>
			<OPTION value="2" selected="selected">Partnertship</OPTION>
			<%} else {%>
			<OPTION value="2">Partnertship</OPTION>
			<%}%>
		</SELECT></TD>
		<TD align="Center"><SELECT name="player1" id="player1">
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
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD align="right"><INPUT type="button" value="Show"
			onclick="getViewData()"></TD>
	</TR>
</TABLE>

<div style="position:absolute; top: 23%; left: 32%; border:1"
	id="wagonwheel"><img src="../images/WagonWheel.jpg" width="330"
	height="480" border="1" align="left" /> <BR>
<div id="val">
</div>
</div>
<INPUT type="hidden" id="hid" name="hid" /></FORM>
</body>
</html>
