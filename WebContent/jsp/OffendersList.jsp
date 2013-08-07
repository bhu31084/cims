<!--
	Author 		 : Archana Dongre
	Created Date : 09/12/2008
	Description  : Display Offender's List.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>

<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	%>

<%
	CachedRowSet crsObjOffenders             = null;
	GenerateStoreProcedure lobjGenerateProc  = new GenerateStoreProcedure();
	Vector vparam                            = new Vector();
	CachedRowSet  crsObjSeason = null;
	CachedRowSet  crsObjCurrentSeason = null;
	String flag = "1";
	String gsSeason = null;
	
%>
<%
	try {
		vparam.add(flag);
		crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");
		vparam.removeAllElements();	
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e);
	}
	
	crsObjCurrentSeason = crsObjSeason;
	if(crsObjSeason!=null){
		while(crsObjSeason.next()){
			gsSeason = crsObjSeason.getString("id");
		}
	}
	 crsObjSeason.beforeFirst();
	try {
		//if(request.getParameter("dpseason")!= null && request.getParameter("dpseason") != ""){				
			gsSeason =	request.getParameter("dpseason")==null?gsSeason:request.getParameter("dpseason");
			vparam.add(gsSeason);
			crsObjOffenders = lobjGenerateProc.GenerateStoreProcedure(
			"ESP_DSP_OFFENDERS_LIST", vparam, "ScoreDB");						
			vparam.removeAllElements();
		//}	
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e);
	}		
%>

<html>
<head>
<title> Offenders List</title>
<link rel="stylesheet" type="text/css" href="../css/menu.css"/>
<link href="../css/form.css" rel="stylesheet" type="text/css" />
<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/sortable.js" type="text/javascript"></script>

<script >
	function getoffenderlist(){
		//var getseason = document.getElementById("dpseason").value
		
		//document.getElementById("hdSubmit").value = "submit";
		//alert(getseason)
		document.frmoffenderlist.action = "/cims/jsp/OffendersList.jsp";		        
        document.frmoffenderlist.submit();
	}
</script>

</head>
<body >
	<jsp:include page="Menu.jsp"></jsp:include>
<table width="100%" align="center">
    <tr>
    	<td align="center">
<div>

<br><br>
<%--<div id="body">--%>

<form  id="frmoffenderlist" name="frmoffenderlist" method="post" >
	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td colspan="10" bgcolor="#FFFFFF" class="legend">Offender's List</td>
		</tr>		
	</table>
	<br>	
	<table width="100%" border="0" align="center" class="table" >
		<tr>
			<td align="left" width="50" nowrap="nowrap" style="font-weight: bold;padding-right: 20px;" >Season:</td>
		   	<td align="left" style="padding-left: 10px;" >
				<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="dpseason" id="dpseason" onchange="getoffenderlist()">
					<option >Select </option>
					<option value="0" selected="selected">All </option>
					<%if(crsObjSeason != null){
						
						while(crsObjSeason.next()){
					%>
					<%if(crsObjSeason.getString("id").equalsIgnoreCase(gsSeason)){%>
					<option value="<%=crsObjSeason.getString("id")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>
					<%}else{%>
					<option value="<%=crsObjSeason.getString("id")%>" ><%=crsObjSeason.getString("name")%></option>
					<%}%>
					<%}
					 }
					%>	
				</select>
			</td>	
		</tr>		
	</table>
	<br>
	<div style="height: 900px;width:100%" >
	<table width="100%" class="table" border="0"  cellpadding="2" cellspacing="1" ><tr class="contentLight"><td colspan="7" class="colheadinguser">Please click on Player name,Association ......to sort the list.</td></tr></table>
	<% if(crsObjOffenders != null){%>
	<table width="100%" border="0" class="table tableBorder" cellpadding="2" cellspacing="1" class="sortable" name="sortTable" id="sortTable">			
		
		<tr class="contentDark" >
			<th align="left" class="colheadinguser"><b>Player Name</th>			
			<th align="left" class="colheadinguser"><b>Association</th>
			<th align="left" class="colheadinguser">Tournament</th>
			<th align="left" class="colheadinguser" width="10%">Match Date</th>
			<th align="left" width="5%" class="colheadinguser" >Match Between</th>
			<th align="left" class="colheadinguser">Penalty</th>						
			<th align="left" class="colheadinguser">Referee Name</th>
			<th align="left" class="colheadinguser">Level</th>
		</tr>
		<tr>	
	<%while(crsObjOffenders.next()){ %>
			<td align="left"><%=crsObjOffenders.getString("Player_Name")%></td>
			<td align="left"><%=crsObjOffenders.getString("association")%></td>
			<td align="left"><%=crsObjOffenders.getString("series_nsme")%></td>
			<td align="left"><%=crsObjOffenders.getString("expected_start").substring(0,11).toString()%></td>
			<td align="left"><%=crsObjOffenders.getString("team1name")%>&nbsp;&nbsp;VS&nbsp;&nbsp;<%=crsObjOffenders.getString("team2name")%>(<%=crsObjOffenders.getString("match_id")%>)</td>
			<%if(crsObjOffenders.getString("Matches_Banned").equalsIgnoreCase("0")){%>
				<td align="left"><%=crsObjOffenders.getString("reason")+"%"%></td>
			<%}else if(crsObjOffenders.getString("Matches_Banned").equalsIgnoreCase("2")){%>
				<td align="left">Banned for <%=crsObjOffenders.getString("reason")+" matches"%></td>
			<%}else{%>
				<td align="left">Reprimind</td>
			<%}%>
	<td align="left"><%=crsObjOffenders.getString("refereename")%>
<%--	<input  type="hidden" id="hdSubmit" name="hdSubmit" value="">--%>
	</td>
	<td>-</td>
	</tr>
		<%}}%>	
</table>
<br>
<jsp:include page="admin/Footer.jsp"></jsp:include>
</div>
</form>

<br>
</div>
</td>
</tr>
</table>
</body>
</html>