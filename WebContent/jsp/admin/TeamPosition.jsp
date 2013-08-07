<!--
	Author 		 : Archana Dongre
	Created Date : 10/12/2008
	Description  : Display match points table for admin login.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>

<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ include file="../AuthZ.jsp" %>
<%
	String user_id =session.getAttribute("userid").toString();
	String loginUserId = session.getAttribute("usernamesurname").toString();	
	
	CachedRowSet crsObjGetMatchPt           = null;
	CachedRowSet  crsObjTournamentNm = null;	
	CachedRowSet crsObjSeason   = null;
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	Vector vparam = new Vector();
	Common common = new Common();
	String series_name = "";
	String season_name = "";
	String seriesId = "";
	String seasonId = "";
	String pageNo = "";
	String message = "";
	String gsteamId = "";	
%>
		<%try{
			vparam.add("1");//display all series name.
			crsObjTournamentNm = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_series_ms",vparam,"ScoreDB");			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");		
		vparam.removeAllElements();	
		%>
<%
		
		if (request.getMethod().equalsIgnoreCase("POST")) {
			if(request.getParameter("dpseason") != null && !request.getParameter("dpseason").equals("")) {
				seasonId = request.getParameter("dpseason");
				//season_name = request.getParameter("dptournament");
				seriesId = request.getParameter("dptournament");
				//series_name = request.getParameter("seriesName");
				
				vparam.removeAllElements();
				vparam.add(seriesId);
				vparam.add(seasonId);				
				try {					
					crsObjGetMatchPt = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_matchpointstally", vparam, "ScoreDB");								
					vparam.removeAllElements();			
				} catch (Exception e) {
					e.printStackTrace();
					out.println(e);
				}			
			}			
		}
%>
<html>
<head>
<title>Match Points Table</title>
    <script language="JavaScript" src="../../js/tabber.js" type="text/javascript"></script>
    <script language="JavaScript" src="../../js/sortable.js" type="text/javascript"></script>
    <script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="../css/menu.css"/>
<%--	<link href="../css/form.css" rel="stylesheet" type="text/css" />--%>
<%--	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />--%>
	<script language="JavaScript">
		var team = null;
		var xmlHttp=null;

		function GetXmlHttpObject() {
		      try{
		         //Firefox, Opera 8.0+, Safari
		         xmlHttp=new XMLHttpRequest();
		       }
		    catch (e){
		         // Internet Explorer
		         try{
		           xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		         }
		         catch (e){
		           xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		         }
			}
		     return xmlHttp;
	 	}

		/****************************** To Search the matches from given series and season**************************/
		function validate() {
			if(document.getElementById("dptournament").value == "" ) {
				alert('Series Name Can Not Be Blank!');
		        document.getElementById("dptournament").focus();
				return false;
			} else if(document.getElementById("dpseason").value == "" ) {
				alert('Season Can Not Be Blank!');
		        document.getElementById("dpseason").focus();
				return false;
			} else {      
				document.frmpoints.action = "/cims/jsp/admin/TeamPosition.jsp";
				frmpoints.submit();
			}
		}
		
		 /***********************To Show Match Points Detail Div Using AJAX***********************/
    	
	function stChgMatchPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("ShowMatchPtDetailsDiv"+team).style.display='';
			document.getElementById("ShowMatchPtDetailsDiv"+team).innerHTML = responseResult;
			team = null;		
		}
	}
	
	function ShowDetailDiv(teamId,seriesId){		
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowMatchPtDetailsDiv"+teamId).style.display==''){
				document.getElementById("plusImage"+teamId).src = "../../images/plusdiv.jpg"; 
				document.getElementById("ShowMatchPtDetailsDiv"+teamId).style.display='none';
				return;
			}else{
				var url ;		    	
	    		url="/cims/jsp/admin/ShowMatchPointsResponse.jsp?teamId="+teamId+"&seriesId="+seriesId;
		    	document.getElementById("plusImage"+teamId).src = "../../images/minus.jpg"; 
		    	team = teamId;							
				//xmlHttp.onreadystatechange=stChgMatchPtResponse;
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
	
	function  adminEdit(matchId){	
	var teampt1 = document.getElementById("team1Points"+matchId).value;	
	var teampt2 = document.getElementById("team2Points"+matchId).value;		
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			var url ;
	    	url="/cims/jsp/admin/SaveMatchPointsResponse.jsp?match_id="+matchId+"&team1_pt="+teampt1+"&team2_pt="+teampt2;
			document.getElementById("SavedMatchPointsDiv").style.display='';			
			//xmlHttp.onreadystatechange=stChgEditResponse;
			xmlHttp.open("post",url,false);
		   	xmlHttp.send(null);
		   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				 responseResult= xmlHttp.responseText;			
				document.getElementById("SavedMatchPointsDiv").innerHTML = responseResult;
			}
		}
	}

</script>      
</head>
<body  style="background-color: white">
<jsp:include page="Menu.jsp"></jsp:include>
<div class="leg">Series Points Tally</div>
<%--    Venue Master--%>
<div class="portletContainer">
<form  id="frmpoints" name="frmpoints" method="post">
	<table width="100%" border="0" align="center">		
		<TR>
			<TH align="center"><b>Tournament Name :</b></TH>
			<td >
				<select  onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="dptournament" id="dptournament">
					<option value="0" >Select </option>
<%					if(crsObjTournamentNm != null){
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
			<TH align="center"><b>Season.. :</b></TH>
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
%>
							    </select>
							</td>	
			<TD align="left">
				<INPUT type="button" class="btn btn-warning" name="button" value="Search" onclick="validate();" >
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
	<table align="center"><tr><td><div id="SavedMatchPointsDiv" style="display: none"></div></td></tr></table>
	
	<DIV id="MatchTeamPoints" align="right" style="">		
		<table width="100%" border="1" align="center" cellpadding="2" cellspacing="1" class="table">
	   		<tr><td colspan="11"><b>Note: Please Click On + To get The Match Details </b></td></tr>
	   		<tr class="contentLight" >
	       		<td width="2%" align="center" class="colheadinguser">&nbsp;</td>
	       		<td width="15%" align="center" class="colheadinguser">Team Name </td>	       		
	       		<td width="5%" align="center" class="colheadinguser">Played </td>
	       		<td width="5%" align="center" class="colheadinguser">Points </td>
	       		<td width="5%" align="center" class="colheadinguser">Win </td>
	       		<td width="5%" align="center" class="colheadinguser">Draw </td>
	       		<td width="5%" align="center" class="colheadinguser">Tie </td>	       		
	       		<td width="5%" align="center" class="colheadinguser">Loss </td>
	       		<td align="center" width="5%" class="colheadinguser" >Net Run Rate </td>
	       		<td align="center" width="5%" class="colheadinguser">Quotient</td>
			</tr>							
			
				<%if(crsObjGetMatchPt != null ){
					int counter = 1;
					if(crsObjGetMatchPt.size() == 0){
					message = " No Data Available ";	%>	
								<tr style="color:red;font-size: 15"><label><%=message%></label></tr>	
						<%	
					}else{
					while(crsObjGetMatchPt.next()){
						gsteamId = crsObjGetMatchPt.getString("team_id");
					if(counter % 2 != 0){%>
		<tr class="contentDark">
<%				}else{
%>		<tr class="contentLight">
<%				}%>								
						<td align="center" id="<%=counter++%>"><a onclick="ShowDetailDiv('<%=gsteamId%>','<%=crsObjGetMatchPt.getString("series")%>')"><IMG id="plusImage<%=gsteamId%>" name="plusImage<%=gsteamId%>" title="Click On + To Get The Details." alt="" src="../../images/plusdiv.jpg" /></a></td>
						<td align="center"><%=crsObjGetMatchPt.getString("team_name")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("Played")%></td>	
						<td align="center"><%=crsObjGetMatchPt.getString("points")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("Win")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("Draw")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("Tie")%></td>														
						<td align="center"><%=crsObjGetMatchPt.getString("Loss")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("RunRate")%></td>
						<td align="center"><%=crsObjGetMatchPt.getString("Quotient")%></td>													
					</tr>
					<tr><td colspan="10"><div id="ShowMatchPtDetailsDiv<%=gsteamId%>" style="display:none" ></div></td></tr>
			<%	}%>
<%			}
		}		
%>						
		</table>
	</div>	

</form>
</div>
<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>
<%	
%>