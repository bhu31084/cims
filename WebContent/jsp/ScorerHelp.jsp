<!--
Page Name 	 : Under17.jsp
Created By 	 : Dipti Shinde.
Created Date : 17th Dec 2008
Description  : Under 17 report
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 17/12/2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<%
String userId = (String)session.getAttribute("userid"); 
session.setAttribute("userid",userId);

%>
<html>
<head>
<title>SCORE HELP</title>

<link href="../css/form.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
<style type="text/css">
li {
<%--    border: 1px solid;--%>
    float: right ;
    font-weight: bold;
    list-style-type: none;
    padding: 0.2em 0.3em;
}
</style>
<script>
function callHelp(){
	//window.open("../helpdoc/CIMSUSERMANUAL.pdf","HELP1","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=220,left=100,width="+(window.screen.availWidth - 200)+",height="+(window.screen.availHeight - 200));
           document.getElementById("frmHelp").action="/cims/jsp/PdfReport.jsp?ReportId=CSUM01";
           document.getElementById("frmHelp").submit();
		
	}
	
	function previousPage(){
		 document.getElementById("frmHelp").action="/cims/jsp/TeamSelection.jsp";
           document.getElementById("frmHelp").submit();
	}
</script>

</head>
	<body>

		<form name="frmHelp" id="frmHelp" method="post">	
			
			<table width="100%" >
				<tr>
					<td>	
						<jsp:include page="Banner.jsp"></jsp:include>
					</td>	
				</tr>
				<tr>
					<td align="right">
						<ul>
							<li><a href="/cims/jsp/Logout.jsp" >Log Out</a></li>	
							<li><a href="javascript:previousPage()">Back</a></li>	
						</ul>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td>						
						<center>Depending upon the speed of the connection,</center>
						<center>It may take some couple of minutes to download the file.</center>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						<center><b>Click on the following link to see the score manual.</b></center>
					</td>
				</tr>
				<tr>
					<td align="center">
						<h4><a  href="javascript:callHelp()"><u>Score Module Manual</u></a><h4>
					</td>
				</tr>
			</table>
		</form>	
	</body>
</html>					