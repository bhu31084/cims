<%--
  Created by IntelliJ IDEA.
  User: bhushanf
  Date: Aug 13, 2008
  Time: 12:01:56 PM
  To change this template use File | Settings | File Templates.
  modifyed Date:12-09-2008
--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,
                 in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
                 java.util.*,
                 java.lang.*"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>                 
                 
<% response.setHeader("Pragma", "private");
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "must-revalidate");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setDateHeader("Expires", 0);
%>
<%
	String Inning ="";
	try{
			Inning = request.getParameter("InningIdPre");
%>
<html>
<head>
	<link href="../css/csms.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="../css/scorermenu.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">   
<script>
function srrate(){
	var over = (document.getElementById('Batstotalover').innerHTML).split(".");
// To Split Ball And Overs, TO Store All Over From Over Field
	var totalover = over[0];
    var ball = over[1];
    var totalball = parseInt((totalover * 6)) + parseInt(ball);
    var run = parseInt(document.getElementById('battotalruns').innerHTML);
    var srRate = (run/ totalball)*6;
    document.getElementById('totlarunrate').innerHTML = srRate.toFixed(2);
    if (document.getElementById('totlarunrate').innerHTML == "Infinity" ||isNaN(document.getElementById('totlarunrate').innerHTML)) { // if Strike Rate In Infinity than we set it blank
    	document.getElementById('totlarunrate').innerHTML = "";
    }
}
function changeImageSrc(id, type){
	document.getElementById('pitch_report').style.display = "none";
	document.getElementById("responsepage").src = "";
	document.getElementById("WagonWheel").style.display = "none";
	document.getElementById("responseWagon").src = "";	
	//setTimeout("display("+id+")",500);
	displayPitchPad(id, type);
	displayWagon(id, type);
}
function displayWagon(id, type){
	document.getElementById("responseWagon").src = "/cims/jsp/response/ResponseWagonWheel.jsp?id="+id+"&type="+type;
	document.getElementById('WagonWheel').style.display = "";
}
function displayPitchPad(id, type){
	document.getElementById("responsepage").src = "/cims/jsp/response/ResopnseBallPitched.jsp?id="+id+"&type="+type;
	//document.getElementById("responsepage").style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src = response/ResopnseBallPitched.jsp?id=" + id + ")";
	document.getElementById('pitch_report').style.display = "";
}
function srrate(){
	var over = (document.getElementById('Batstotalover').innerHTML).split(".");
	// To Split Ball And Overs, TO Store All Over From Over Field
	var totalover = over[0];
	var ball = over[1];
	var totalball = parseInt((totalover * 6)) + parseInt(ball);
	var run = parseInt(document.getElementById('battotalruns').innerHTML);
	var srRate = (run/ totalball)*6;
	document.getElementById('totlarunrate').innerHTML = srRate.toFixed(2);
	if (document.getElementById('totlarunrate').innerHTML == "Infinity" ||isNaN(document.getElementById('totlarunrate').innerHTML)) { // if Strike Rate In Infinity than we set it blank
    	document.getElementById('totlarunrate').innerHTML = "";
	}
}
</script>	
</head>
<body>
<jsp:include page="previousInningScorecard.jsp">
	<jsp:param name="InningIdPre" value="<%=Inning%>" />
	<jsp:param name="flg" value="P" />
</jsp:include>
  
</body>	
<%}catch(Exception e){
	e.printStackTrace();
}
%>
</html>