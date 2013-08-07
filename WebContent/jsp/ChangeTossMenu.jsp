
<!--
	Author 		 		: Avadhut Joshi
	Created Date 		: 01/10/2008
	Description  		: Menu for pages related to match flow.
	Company 	 		: Paramatrix Tech Pvt Ltd.

-->
<%@ 
	page import="sun.jdbc.rowset.CachedRowSet,
		java.text.SimpleDateFormat,java.text.NumberFormat,
		in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
		java.util.*"
%>
<%
	String match_Id = null;	
	if((String)session.getAttribute("matchId1") != null){
		match_Id = (String)session.getAttribute("matchId1");
	}	
	GenerateStoreProcedure  lobjGenerateProc	= new GenerateStoreProcedure(match_Id);	
	CachedRowSet 			matchinnings 		= null;
	Vector					vparam 				= new Vector();
	String inningid = "";
	if(match_Id !=null){
	
		vparam.add(match_Id);
		matchinnings 	= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getinningscount",vparam,"ScoreDB");
		vparam.removeAllElements();	
		System.out.println("match id "+match_Id);
	}
	//System.out.println("match id id from session "+match_Id);
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
    float: left;
    font-weight: bold;
    list-style-type: none;
    padding: 0.2em 0.3em;
}
</style>
<script>
	function TossChange(match){									
	window.open("/cims/jsp/TossChange.jsp?match="+match,"CIMS3","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=300,left=300,width=500,height=300");
	}
</script>

</head>
<body >

<table width="100%">	
<tr align="left">
	<td align="left">
	<%if(matchinnings!= null){
		while(matchinnings.next()){
			inningid = matchinnings.getString("row");
		}
		System.out.println("inningid count "+inningid);	
		if(inningid.equals("1")){%>
	<ul>
		<li><a href="javascript:TossChange('<%=match_Id%>')" >Edit Toss</a></li>
		<li><a href="/cims/jsp/EditTeam1Players.jsp"  >Edit Team One </a></li>
		<li><a href="/cims/jsp/EditTeam2Players.jsp" >Edit Team Two </a></li>
	</ul>
	<%}
		
	}	%>
	
	</td>
</tr>
</table>

</body>
</html>