<!--
	Author 		 : Archana Dongre
	Created Date : 10/12/2008
	Description  : Display match points table.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>

<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	%>
	<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>	
<%
	String user_id =session.getAttribute("userid").toString();
	String loginUserId = session.getAttribute("usernamesurname").toString();
	String user_role = session.getAttribute("role").toString();
	System.out.println("user_id "+ user_id + " loginUserId " + loginUserId);
	System.out.println("user_role "+ user_role );	
	String match_id = session.getAttribute("matchid").toString();
	CachedRowSet crsObjGetMatchPt           = null;
	CachedRowSet  crsObjTournamentNm = null;	
	CachedRowSet crsObjSeason   = null;
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(match_id);
	Vector vparam                           = new Vector();
	Common common = new Common();
	String series_name = "";
	String season_name = "";
	String seriesId = "";
	String seasonId = "";
	String pageNo = "";
	String message = "";
	String gsteamId = "";
	LogWriter log = new LogWriter();
		
%>
<%		try{
			vparam.add("1");//display all series name.
			crsObjTournamentNm = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_series_ms",vparam,"ScoreDB");			
		}catch(Exception e) {
				System.out.println("*************TeamPosition.jsp*****************"+e);
					log.writeErrLog(page.getClass(),match_id,e.toString());
		}
		
		try{
			crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");			
		}catch(Exception e) {
				System.out.println("*************TeamPosition.jsp*****************"+e);
					log.writeErrLog(page.getClass(),match_id,e.toString());
		}		
		vparam.removeAllElements();	
		%>
<%
		
		if (request.getMethod().equalsIgnoreCase("POST")) {
			if(request.getParameter("dpseason") != null && !request.getParameter("dpseason").equals("")) {
				seasonId = request.getParameter("dpseason");
				//season_name = request.getParameter("dptournament");
				seriesId = request.getParameter("dptournament");
				//series_name = request.getParameter("seriesName");
				
				System.out.println("seasonId "+ seasonId + " seriesId " + seriesId);
				vparam.removeAllElements();				
				vparam.add(seriesId);
				vparam.add(seasonId);
				try {
					crsObjGetMatchPt = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_matchpointstally", vparam, "ScoreDB");								
					vparam.removeAllElements();			
				} catch (Exception e) {
					System.out.println("*************TeamPosition.jsp*****************"+e);
					log.writeErrLog(page.getClass(),match_id,e.toString());
				}	
			
			}
			
		}
%>

<html>
<head>
<title>Match Points Table</title>
    <script language="JavaScript" src="../js/tabber.js" type="text/javascript"></script>
    <script language="JavaScript" src="../js/sortable.js" type="text/javascript"></script>
    <script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
<%--    <script language="JavaScript" src="../js/otherFeedback.js"></script> --%>
    <link rel="stylesheet" type="text/css" href="../css/menu.css"/>
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
	<script>
			var scorer = null;
	var series = null;		
	var xmlHttp=null;
	var team = null;
	
	/******************************ScorerSeriesMatchDetails.jsp script part.**********************************/	
	
	//End of ScorerSeriesMatchDetails.jsp Report
	
	function GetXmlHttpObject() {
		try{
			//Firefox, Opera 8.0+, Safari
			xmlHttp=new XMLHttpRequest();
		}catch (e){
			// Internet Explorer
			try{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}catch (e){
				xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}
		
	/******************************TeamPosition.jsp script part.**********************************/	
	function TeamPositionvalidate() {
			if(document.getElementById("dptournament").value == "" ) {
				alert('Series Name Can Not Be Blank!');
		        document.getElementById("dptournament").focus();
				return false;
			} else if(document.getElementById("dpseason").value == "" ) {
				alert('Season Can Not Be Blank!');
		        document.getElementById("dpseason").focus();
				return false;
			} else {      
				document.frmpoints.action = "/cims/jsp/TeamPosition.jsp";
				frmpoints.submit();
			}
		}
		
	/***********************To Show Match Points Detail Div Using AJAX***********************/
    function ShowTeamPositionDetailDiv(teamId,seriesId){		
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowMatchPtDetailsDiv"+teamId).style.display==''){
				document.getElementById("plusImage"+teamId).src = "../images/plusdiv.jpg"; 
				document.getElementById("ShowMatchPtDetailsDiv"+teamId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/jsp/ShowMatchPointsResponse.jsp?teamId="+teamId+"&seriesId="+seriesId;		    	
		    	document.getElementById("plusImage"+teamId).src = "../images/minus.jpg"; 
		    	team = teamId;							
				//xmlHttp.onreadystatechange=stChgTeamMatchPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("ShowMatchPtDetailsDiv"+team).style.display='';
					document.getElementById("ShowMatchPtDetailsDiv"+team).innerHTML = responseResult;
					team = null;		
				}
		   	}
		}		
	}      
	//End of TeamPosition.jsp
	
	

	
	</script>
	
</head>
<body  style="background-color: white">
<jsp:include page="Menu.jsp"></jsp:include>
<br><br>
<br>
<form  id="frmpoints" name="frmpoints" method="post">

	<table table width="100%" border="0" align="center" class="table">
				<tr  >
					<td width="100%" colspan="3" align="center" class="legend">Tournament Points Tally</td>
				</tr>	
			</table>
	<table table width="100%" border="0" align="center" class="table">		
		<TR class="contentLight">
			<Td align="left"><b>Tournament Name :</b></Td>
			<td >
				<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="dptournament" id="dptournament">
					<option  value="0" >Select </option>
<%	if(crsObjTournamentNm != null){
						while(crsObjTournamentNm.next()){
						
%>
<%							if(crsObjTournamentNm.getString("id").equalsIgnoreCase(seriesId)){%>
					<option value="<%=crsObjTournamentNm.getString("id")%>" selected="selected"><%=crsObjTournamentNm.getString("name")%></option>
<%							}else{%>
					<option value="<%=crsObjTournamentNm.getString("id")%>" ><%=crsObjTournamentNm.getString("name")%></option>
<%							}
						}
					}
%>					
				</select>
			</td>			
<%--			<TD>--%>
<%--				<INPUT type="text" id="seriesName" name="seriesName" size="35" onkeyup="updateSeriesType(event);" onkeyPress="javascript:getSeriesTypeList(); return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz');"--%>
<%--				autocomplete="OFF" value='<%=series_name%>'>--%>
<%--			</TD>--%>
			<Td align="left"><b>Season :</b></Td>
			<td>
								<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="dpseason" id="dpseason">
									<option>Select </option>
<%if(crsObjSeason != null){
	while(crsObjSeason.next()){
%>
<%if(crsObjSeason.getString("id").equalsIgnoreCase(seasonId)){%>
									<option value="<%=crsObjSeason.getString("id")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>
<%}else{%>
									<option value="<%=crsObjSeason.getString("id")%>" ><%=crsObjSeason.getString("name")%></option>
				<%}
							}
						}
%>							    </select>
			&nbsp;&nbsp;
<%--			<TD>--%>
<%--				<INPUT type="text" id="seasonName" name="seasonName" onkeyup="updateSeason(event);" onkeyPress="javascript:getSeasonList(); return keyRestrict(event,'1234567890');"--%>
<%--					size="15" autocomplete="OFF" value='<%=season_name%>'>--%>
<%--			</TD>--%>
			
				<INPUT type="button" class="btn btn-warning btn-small" name="button" value="Search" onclick="TeamPositionvalidate();" >
				<INPUT type="hidden" name="seriesId" id="seriesId" value="">
				<INPUT type="hidden" name="seasonId" id="seasonId" value="">
			</TD>
		</TR>
		<TR>
			<td></td>
			<td>
				<DIV align="left" style="width:250px;">
				<DIV id="seriesList" name="seriesList" style="display:none;position:absolute;z-index:+5;"></DIV>
				</DIV>
			</td>
			<td></td>
			<td> 
				<DIV align="left" style="width:250px">
				<DIV id="seasonList" name="seasonList" style="display:none;position:absolute;z-index:+5;"></DIV>
				</DIV>
			</td>
		</TR>							
	</table>
	<br>
	
	<DIV id="MatchTeamPoints" align="right" style="">
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
	   		<tr><td colspan="12" class="contentDark" ><b>Note: Please Click On + To get The Match Details </b></td></tr>
	   		<tr class="contentLight" >
	       		<td width="2%" align="center" class="colheadinguser">&nbsp;</td>
	       		<td width="15%" align="center" class="colheadinguser" >Team Name </td>	       		
	       		<td width="5%" align="center" class="colheadinguser">Total Matches </td>
	       		<td width="5%" align="center" class="colheadinguser">Played </td>
	       		<td width="5%" align="center" class="colheadinguser">Abandon</td>
	       		<td width="5%" align="center" class="colheadinguser">Points </td>
	       		<td width="5%" align="center" class="colheadinguser">Win </td>
	       		<td width="5%" align="center" class="colheadinguser">Draw </td>
	       		<td width="5%" align="center" class="colheadinguser">Tie </td>	       		
	       		<td width="5%" align="center" class="colheadinguser">Loss </td>
	       		<td align="center" width="5%" class="colheadinguser">Net Run Rate </td>
	       		<td align="center" width="5%" class="colheadinguser">Quotient</td>
			</tr>							
			
				<%if(crsObjGetMatchPt != null ){
					int counter = 1;
					if(crsObjGetMatchPt.size() == 0){				
						message = " Data Not Available ";%>
					<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
					<%}else{%>
					<%while(crsObjGetMatchPt.next()){
						gsteamId = crsObjGetMatchPt.getString("team_id");
					if(counter % 2 != 0){%>
		<tr class="contentDark">
<%				}else{
%>		<tr class="contentLight">
<%				}%>								
						<td align="center" id="<%=counter++%>"><a onclick="ShowTeamPositionDetailDiv('<%=gsteamId%>','<%=crsObjGetMatchPt.getString("series")%>')"><IMG id="plusImage<%=gsteamId%>" name="plusImage<%=gsteamId%>" title="Click On + To Get The Details." alt="" src="../images/plusdiv.jpg" /></a></td>
						<td align="center"><%=crsObjGetMatchPt.getString("team_name")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("total_matches")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("Played")%></td>	
						<td align="center"><%=crsObjGetMatchPt.getString("abandon")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("points")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("Win")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("Draw")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("Tie")%></td>														
						<td align="center"><%=crsObjGetMatchPt.getString("Loss")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("RunRate")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("Quotient")%></td>													
					</tr>
					<tr><td colspan="10"><div id="ShowMatchPtDetailsDiv<%=gsteamId%>" style="display:none" ></div></td></tr>
				<%}%>
<%				}
}
%>						
		</table>
	</div>
	<div id="SavedMatchPointsDiv" style="display: none"></div>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	 <jsp:include page="admin/Footer.jsp"></jsp:include>
</form>
</body>
</html>
<%	
%>