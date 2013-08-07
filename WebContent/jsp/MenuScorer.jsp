
<!--
	Author 		 		: Avadhut Joshi
	Created Date 		: 01/10/2008
	Description  		: Menu for pages related to match flow.
	Company 	 		: Paramatrix Tech Pvt Ltd.

-->
<%
	String User_Name = (String)session.getAttribute("username");
	String role="";
%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title> Menu</title>
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
	function changePage(username){									
	window.open("/cims/jsp/ChangePWForSecurity.jsp?userName="+username,"CIMS3","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=300,left=300,width=400,height=200");
	}
	function changeProfile(){									
			window.open("/cims/jsp/admin/UpdateProfile.jsp","cims","location=no,directories=no, status=no,menubar=no, scrollbars=Yes,resizable=Yes,top=100,left=100,width=850,height=500");
	}
</script>
</head>
<body >
<table width="100%">	
<tr>
	<td>
	<ul class="nav">
		<li>
		<a href="javascript:changeProfile()">UpdateProfile</a></li>			
		<li><a href="javascript:changePage('<%=User_Name%>')" >ChangePassword</a></li>			
		<li><a href="/cims/jsp/Logout.jsp" >Log Out</a></li>	
		<li><a href="/cims/jsp/ScorerHelp.jsp">Help</a></li>	
	</ul>
	</td>
</tr>
</table>
</body>
</html>