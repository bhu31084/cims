<!--Author 		 : Saudagar Mulik
	Created Date : 02/09/2008
	Description  : Umpire coach report.
	Company 	 : Paramatrix Tech Pvt Ltd.
	Modified by:Archana	Added change password button in LogOut button table.
-->
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ include file="AuthZ.jsp"%>
<%			String User_Name = (String)session.getAttribute("username");
			CachedRowSet crsObjViewData = null;
			CachedRowSet crsObjMatches = null;
			CachedRowSet crsObjTodayMatches = null;
			CachedRowSet crsObjRolesCrs = null;
			CachedRowSet dateCachedRowSet = null;
			GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
			Vector vparam = new Vector();
			Vector vecUserId = new Vector();
			String days		= "";
			String seriesId = "0";
			  
		try {
	    
	    	

			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy/MM/dd");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
					"dd/MM/yyyy");

			String match_id = "0";
			Common common = new Common();
			
			String date_one = sdf2.format(new Date());
			String start_date = "01/11/2009";
			String date_two = sdf2.format(new Date());
			String teams ="";
			String clubId= "";
			String Firstmatchid="";
			String userRole	= "";
			String hidUser	= "";	
			String userId   = "";
			boolean flag	= false;	
			if(!User_Name.equalsIgnoreCase("Report")){
				session.removeAttribute("seriesId");
			}
			userId   = (String)session.getAttribute("userid");
			vparam.add(userId);
			crsObjTodayMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getuserrole", vparam, "ScoreDB");
			vparam.removeAllElements();
			if (crsObjTodayMatches!=null){
				while (crsObjTodayMatches.next()){
					userRole = crsObjTodayMatches.getString("role")!=null?crsObjTodayMatches.getString("role"):"";
				}
			}
			
		 	if ((userRole.equalsIgnoreCase("2")) || (userRole.equalsIgnoreCase("3")) || (userRole.equalsIgnoreCase("4"))|| (userRole.equalsIgnoreCase("6") 
		 			|| (userRole.equalsIgnoreCase("29")))){
		 		flag =true;
			}
			
			String statusFlag = (String)session.getAttribute("statusFlag");
			String strSeriesId = (String)session.getAttribute("seriesId");
			
			if(strSeriesId!=null && !strSeriesId.equalsIgnoreCase("0")){
				vparam.add(common.formatDate(date_one));
				vparam.add(common.formatDate(date_two));
				vparam.add(strSeriesId);
				crsObjTodayMatches = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_getmatches_for_series", vparam, "ScoreDB");
			}else{
				if(userRole.equalsIgnoreCase("9")){
					vparam.add(common.formatDate(date_one));
					vparam.add(common.formatDate(date_two));
					crsObjTodayMatches = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getmatches", vparam, "ScoreDB");
				}else{
					vparam.add(userId);
					vparam.add(common.formatDate(date_one));
					vparam.add(common.formatDate(date_two));
					crsObjTodayMatches = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_user_getmatches", vparam, "ScoreDB");
				}
			}
			int todaymatch = crsObjTodayMatches.size();
			if(crsObjTodayMatches.first()){
				match_id = crsObjTodayMatches.getString("matches_id");
				Firstmatchid = crsObjTodayMatches.getString("matches_id");
				crsObjTodayMatches.previous();
			}
			vparam.removeAllElements();
			vparam.add(match_id);
			crsObjViewData = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getprematchtype", vparam, "ScoreDB");
			vparam.removeAllElements();
			
			if (request.getParameter("hid") != null) {
				if (request.getParameter("hid").equalsIgnoreCase("0")) {
					date_one = request.getParameter("txtDateFrom").toString();
					date_two = request.getParameter("txtDateTo").toString();
					start_date = request.getParameter("txtDateFrom").toString();
					clubId   = request.getParameter("selClub").toString();
				    hidUser  = request.getParameter("hidUser")!=null?request.getParameter("hidUser"):""; 
				    if (!hidUser.equalsIgnoreCase("1")){
					 if (clubId.equalsIgnoreCase("A")){
						date_one = request.getParameter("txtDateFrom").toString();
						date_two = request.getParameter("txtDateTo").toString();
						start_date = request.getParameter("txtDateFrom").toString();
						if(userRole.equalsIgnoreCase("9")){
							vparam.add(common.formatDate(date_one));
							vparam.add(common.formatDate(date_two));
							crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
									"esp_dsp_getmatches", vparam, "ScoreDB");
						}else{
							vparam.add(userId);
							vparam.add(common.formatDate(date_one));
							vparam.add(common.formatDate(date_two));
							crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
									"esp_dsp_user_getmatches", vparam, "ScoreDB");
						}
						vparam.removeAllElements();
					  }else{
						  if(userRole.equalsIgnoreCase("9")){
							  vparam.add(common.formatDate(date_one));
							  vparam.add(common.formatDate(date_two));
							  vparam.add(clubId);
							  crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
										"esp_dsp_getmatches_associationwise", vparam, "ScoreDB");
						  }else{
							  vparam.add(common.formatDate(date_one));
							  vparam.add(common.formatDate(date_two));
							  vparam.add(clubId);
							  vparam.add(userId);
							  crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
										"esp_dsp_getmatches_associationwise_withuser", vparam, "ScoreDB");
							  
						  }
						  vparam.removeAllElements();
					  }
				    }else {
				    	if(userRole.equalsIgnoreCase("9")){
							vparam.add(common.formatDate(date_one));
							vparam.add(common.formatDate(date_two));
							crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
									"esp_dsp_getmatches", vparam, "ScoreDB");
						}else{
							vparam.add(userId);
							vparam.add(common.formatDate(date_one));
							vparam.add(common.formatDate(date_two));
							crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
									"esp_dsp_user_getmatches", vparam, "ScoreDB");
						}
						vparam.removeAllElements();
				    }
				} else if (request.getParameter("hid").equalsIgnoreCase("1")) {
					match_id = request.getParameter("matchid");
					vparam.add(match_id);
					crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getprematchtype", vparam, "ScoreDB");
					vparam.removeAllElements();
					date_one = request.getParameter("txtDateFrom").toString();
					date_two = request.getParameter("txtDateTo").toString();
					start_date = request.getParameter("txtDateFrom").toString();
					if(userRole.equalsIgnoreCase("9")){
						vparam.add(common.formatDate(date_one));
						vparam.add(common.formatDate(date_two));
						crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
								"esp_dsp_getmatches", vparam, "ScoreDB");
					}else{
						vparam.add(userId);
						vparam.add(common.formatDate(date_one));
						vparam.add(common.formatDate(date_two));
						crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
								"esp_dsp_user_getmatches", vparam, "ScoreDB");
					}
					vparam.removeAllElements();	
					Firstmatchid = match_id;		
				} else if (request.getParameter("hid").equalsIgnoreCase("2")) {
					if (request.getParameter("matchid") != null && !request.getParameter("matchid").equals("0")) {
						session.setAttribute("matchid", request.getParameter("matchid"));
						session.setAttribute("matchId1", request.getParameter("matchid"));
						session.setAttribute("statusFlag","0");
						response.sendRedirect("/cims/jsp/ReportMain.jsp");
						return;	
					}else if (request.getParameter("hidMatch_id") != null && !request.getParameter("hidMatch_id").equals("0")) {
						session.setAttribute("matchid", request.getParameter("hidMatch_id"));
						session.setAttribute("matchId1", request.getParameter("hidMatch_id"));
						session.setAttribute("statusFlag","0");
						response.sendRedirect("/cims/jsp/ReportMain.jsp");
						return;	
					}
					
					else{
						session.setAttribute("statusFlag","1");
						response.sendRedirect("/cims/jsp/ReportMain.jsp");
						return;	
					}
					
				}else if (request.getParameter("hid").equalsIgnoreCase("3")) {
					Firstmatchid = request.getParameter("matchno");
					match_id = request.getParameter("matchno");
					session.setAttribute("statusFlag","0");
					vparam.add(Firstmatchid);
					crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getprematchtype", vparam, "ScoreDB");
					vparam.removeAllElements();
					date_one = request.getParameter("txtDateFrom").toString();
					date_two = request.getParameter("txtDateTo").toString();
					start_date = request.getParameter("txtDateFrom").toString();
					if(request.getParameter("seriesId")!=null && !request.getParameter("seriesId").equalsIgnoreCase("0")){
						crsObjTodayMatches = null;
						seriesId = request.getParameter("seriesId");
						session.setAttribute("seriesId",seriesId);
						vparam.add(common.formatDate(sdf2.format(new Date())));
						vparam.add(common.formatDate(sdf2.format(new Date())));
						vparam.add(request.getParameter("seriesId").toString());
						crsObjTodayMatches = lobjGenerateProc.GenerateStoreProcedure(
								"esp_dsp_getmatches_for_series", vparam, "ScoreDB");
						
					}else{
						if(userRole.equalsIgnoreCase("9")){
							vparam.add(common.formatDate(date_one));
							vparam.add(common.formatDate(date_two));
							crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
									"esp_dsp_getmatches", vparam, "ScoreDB");
						}else{
							vparam.add(userId);
							vparam.add(common.formatDate(date_one));
							vparam.add(common.formatDate(date_two));
							crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
									"esp_dsp_user_getmatches", vparam, "ScoreDB");
						}
						
						vparam.removeAllElements();
					}	
				}
			}else{
			//	date_one = request.getParameter("txtDateFrom").toString();
				//date_two = request.getParameter("txtDateTo").toString();
				
				vparam.add(common.formatDate(date_one));
				vparam.add(common.formatDate(date_two));
				if(request.getParameter("seriesId")!=null){
					crsObjTodayMatches = null;
					seriesId = request.getParameter("seriesId");
					vparam.add(request.getParameter("seriesId").toString());
					crsObjTodayMatches = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getmatches_for_series", vparam, "ScoreDB");
				}else if(strSeriesId!=null && !strSeriesId.equalsIgnoreCase("0")){
					vparam.add(strSeriesId);
					crsObjTodayMatches = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getmatches_for_series", vparam, "ScoreDB");
				}else{
					vparam.removeAllElements();
					if(userRole.equalsIgnoreCase("9")){
						vparam.add(common.formatDate(date_one));
						vparam.add(common.formatDate(date_two));
						crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
								"esp_dsp_getmatches", vparam, "ScoreDB");
					}else{
						vparam.add(userId);
						vparam.add(common.formatDate(date_one));
						vparam.add(common.formatDate(date_two));
						crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
								"esp_dsp_user_getmatches", vparam, "ScoreDB");
					}
				}	
				vparam.removeAllElements();		
			} 
			
			
%>
<html>
<head>
<script language="JavaScript" src="../js/Calender.js"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
<link rel="stylesheet" type="text/css" href="../css/tabexample.css">
<%--<link rel="stylesheet" type="text/css" href="../css/menu.css">--%>
<%--<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">--%>
<title>Select match</title>
<script>

	function callRedirect(flag,userrole){
		if(flag == "2"){
			window.open("/cims/jsp/admin/UmpiresMatchSetUp.jsp?userrole="+userrole+"&popup=A","CIMSMATCHAPP","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=25,left=25,width=950,height=650");
		}		
		//window.open("UmpiresMatchSetUp.jsp","CIMSMATCHAPP","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=25,left=25,width=950,height=650");
	}

//	function getAssignesmatch(){
//		if (document.getElementById('hidFlag').value=="1"){		
//			if (document.getElementById('chkUser').checked){
//				document.getElementById('hidUser').value = 1; 
//			}
//		}
//		document.getElementById("hid").value = "0";
//		document.selectmatch.submit();	
//	}
	
	function getAssignedmatch(){
		if (document.getElementById('hidFlag').value=="1"){		
			document.getElementById('hidUser').value = "1"; 
		}
		document.getElementById("hid").value = "0";
		
		document.selectmatch.submit();	
	}

		
	function getMatches(){
		/*if (document.getElementById('hidFlag').value=="1"){		
					//document.getElementById('hidUser').value = 1; 
		}*/
		document.getElementById("hid").value = "0";
		document.selectmatch.submit();	
	}
	
	function login(){
		document.selectmatch.action="/cims/jsp/Logout.jsp";	
		document.selectmatch.submit();	
	}
	
	function getValue(){
		if(document.getElementById("matchid").value != "0" ){
			document.getElementById("hid").value = "1";
			document.selectmatch.action="/cims/jsp/SelectMatch.jsp?hid=1";
			document.selectmatch.submit();
		}
	}

	function getmatch(matchid){
		document.getElementById("hid").value = "3";
		var seriesId = document.getElementById("seriesId").value;
		if(seriesId=="0"){
			document.selectmatch.action="/cims/jsp/SelectMatch.jsp?hid=3&matchno="+matchid;
		}else{
			document.selectmatch.action="/cims/jsp/SelectMatch.jsp?hid=3&matchno="+matchid+"&seriesId="+seriesId;
		}	
		document.selectmatch.submit();	
	}

	function validate(){
			document.getElementById("hid").value = "2"; 
			//document.selectmatch.action="ReportMain.jsp?statusFlag = 1";
			document.selectmatch.submit();	
	}
	
	function changePage(username){									
		window.open("/cims/jsp/ChangePWForSecurity.jsp?userName="+username,"CIMS3","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=300,left=300,width=400,height=200");
	}

	function changeProfile(){									
			window.open("/cims/jsp/admin/UpdateProfile.jsp","cims","location=no,directories=no, status=no,menubar=no, scrollbars=Yes,resizable=Yes,top=100,left=100,width=850,height=500");
	}
	function callAdminModule(username,userid){
		document.selectmatch.action = "/cims/jsp/AdminModule.jsp?username="+username;
		document.selectmatch.submit();	
		//window.open("/cims/jsp/admin/Menu.jsp?username="+username,"MenuAdmin","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=0,left=0,width="+(window.screen.availWidth)+",height="+(window.screen.availHeight));
		
	}
</script>
</head>
<body>
<FORM action="/cims/jsp/SelectMatch.jsp" name="selectmatch"
	id="selectmatch" method="post">
<table width="1010" align="center" border="1">
	<tr>
		<td><input type="hidden" id="hidUser" name="hidUser" value="0">
		<input type="hidden" id="hidFlag" name="hidFlag" value="0">
		<table border="0" width="100%">
			<tr>
				<td height="20%" width="100%"><IMG alt=""
					src="../images/AdminBG.jpg" width="100%"></td>
			</tr>
		</table>
		<TABLE border=0 width=100%>
			<tr>
				<TD align="right" width="80%">Date: <B><%= sdf1.format(new Date())%>
				</B></TD>

			</TR>
		</TABLE>
		<table border="0" width="100%" height="100%">
			<tr valign="top">
				<td width="25%" height="100%"><INPUT type="hidden" id="hid"
					name="hid" /> <INPUT type="hidden" id="seriesId" name="seriesId"
					value="<%=seriesId%>" />

				<table class="matchNotice">
					<%			if (crsObjTodayMatches != null) {
			while (crsObjTodayMatches.next()) {				
%>
					<tr valign="middle">

						<td nowrap="nowrap"><a
							href="javascript:getmatch('<%=crsObjTodayMatches.getString("matches_id")%>')"><img
							src="../images/left-blue-arrow.png" alt="click" border="0"><%=crsObjTodayMatches.getString("team_one")%>
						Vs. <%=crsObjTodayMatches.getString("team_two")%></a></td>
					</tr>
					<%
				}
			}	
			for(int i=todaymatch;i<10;i++){
%>
					<tr valign="middle">

						<td><a herf="#">&nbsp;</a></td>
					</tr>
					<%			}
%>


				</table>
				</td>

				<td width="80%">
				<TABLE width="100%">
					<tr>
						<td align="right">
						<%					if(User_Name.equalsIgnoreCase("Admin")){
%>
						
						<TD align="right" width="80%"><INPUT type="button"
							align="right" class="btn btn-small btn-warning"
							value="Admin Module"
							onclick="callAdminModule('<%=User_Name%>','<%=userId %>')">
						</TD>
						<%					}
%>
						<TD align="right" width="100%">
						<%						if(User_Name.equalsIgnoreCase("report")){
						}else{
%> <INPUT type="button" align="right" class="btn btn-small btn-warning"
							value="Change PassWord" onclick="changePage('<%=User_Name%>')">
						<%						}
%>
						</TD>
						<TD align="right" width="80%">
						<%						if(User_Name.equalsIgnoreCase("report")){
						}else{
%> <INPUT type="button" align="right" class="btn btn-small btn-warning"
							value="LogOut" onclick="login()"> <%						}
%>
						</TD>
						</td>
					</tr>
				</table>
				<FIELDSET style="padding: 10px; size: 45%;" class="background"><LEGEND
					class="background1"><a class="aheading">Select Dates</a> </LEGEND>
				<TABLE align="left" width="100%" border="1" bordercolor="#fff"
					cellspacing="0" cellpadding="5">
					<TR bgcolor="#E6F1FC" valign="top">
						<TD nowrap align="center" width="15%"><input maxlength="10"
							size="10" type="text" class="FlatTextBox150" name="txtDateFrom"
							id="txtDateFrom" readonly value="<%=start_date%>"
							onclick="showCal('FrCalendarFrom','DateFrom','txtDateFrom','selectmatch')">
						<a
							href="javascript:showCal('FrCalendarFrom','DateFrom','txtDateFrom','selectmatch')">
						<IMG src="../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
						</TD>
						<TD nowrap width="15%" align="center"><input type="text"
							maxlength="10" size="10" class="FlatTextBox150" name="txtDateTo"
							id="txtDateTo" readonly value="<%=date_two%>"
							onclick="showCal('FrCalendarTo','DateTo','txtDateTo','selectmatch')">
						<a
							href="javascript:showCal('FrCalendarTo','DateTo','txtDateTo','selectmatch')">
						<IMG src="../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
						</TD>
						<!-- Added by vaibhavg to get club-->
						<td nowrap width=20%><select class="input" name="selClub"
							id="selClub" style="width: 7cm">
							<option value="A">--All Association--</option>
							<%try{	
	vparam.removeAllElements();
	vparam.add("2");//
    crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roles",vparam,"ScoreDB");
	vparam.removeAllElements();	
	if(crsObjRolesCrs != null){	
		while(crsObjRolesCrs.next()){	
%>
							<option value="<%=crsObjRolesCrs.getString("id")%>"
								<%=clubId.equals(crsObjRolesCrs.getString("id"))?"selected":""%>><%=crsObjRolesCrs.getString("name")%></option>
							<%--
					<%=playerId.equals(userDataCrs.getString("role"))?"selected":"" %>
					--%>
							<%		}
	 }
   }catch(Exception e){
   }
%>
						</select></td>
						<TD>
						<table>
							<tr>
								<td nowrap align="center" width="10%"><INPUT type="button"
									class="btn btn-small btn-warning" value="Get Matches"
									onclick="getMatches()" /></td>
							</tr>
						</table>
						</TD>
					</TR>
				</TABLE>
				</FIELDSET>
				<br>
				<FIELDSET style="size: 45%; padding: 10px;" class="background"><LEGEND
					class="background1"><a class="aheading">Matches Details</a> </LEGEND>
				<TABLE align="left" width="100%" border="1" bordercolor="#fff"
					cellspacing="0" cellpadding="5" bgcolor="#E6F1FC">
					<tr>
						<td>&nbsp;</td>
						<TD nowrap align="center" style="padding-bottom: 5px;" width="40%"><font
							size="2" color="#003399">Matches:</font> <SELECT
							onchange="getValue()" name="matchid" id="matchid"
							style="width: 400px;">
							<OPTION value="0">--Select Match--</OPTION>
							<%					if (crsObjMatches != null) {
						while (crsObjMatches.next()) {
							if (crsObjMatches.getString("matches_id").equals(match_id)) {
		%>
							<OPTION selected="selected"
								value="<%=crsObjMatches.getString("matches_id")%>"><%=crsObjMatches.getString("team_one")%>
							Vs. <%=crsObjMatches.getString("team_two")%> -- (<%=crsObjMatches.getString("matches_id") %>)
							-- (<%=crsObjMatches.getString("start_date") %> - <%=crsObjMatches.getString("end_date")%>)</OPTION>
							<%							} else {%>
							<OPTION value="<%=crsObjMatches.getString("matches_id")%>">
							<%=crsObjMatches.getString("team_one")%> Vs. <%=crsObjMatches.getString("team_two")%>
							-- (<%=crsObjMatches.getString("matches_id")%>) -- (<%=crsObjMatches.getString("start_date") %>
							- <%=crsObjMatches.getString("end_date")%>)</OPTION>
							<%							}// end of else
						}// end of while
					}// end of main if
%>
						</SELECT> <input type="hidden" name="hidMatch_id" id="hidMatch_id"
							value="<%=match_id%>"></TD>
						<% if(flag==true){
%>
						<td nowrap align="center"><font size="2" color="#003399">
						<input type="button"
							class="btn btn-small btn-warning"
							value="Get assigned matches" onclick="getAssignedmatch()" /> <!--<input type=checkbox value="1" name="chkUser" id="chkUser" onclick="getAssignedmatch()">Get Assigned Matches</font></td>
--> <%}else{
%>
						
						<td>&nbsp;</td>
						<%}
%>
					</tr>
				</table>
				</FIELDSET>
				<br>
				<FIELDSET style="size: 45%; padding: 10px;" class="background"><LEGEND
					class="background1"><a class="aheading">Details</a></LEGEND>
				<TABLE align="center" width="100%" border="1" bordercolor="#fff"
					cellspacing="0" cellpadding="5" bgcolor="#E6F1FC">
					<%if (crsObjViewData == null) {%>
					<TR>
						<TD align="Left" width="25%" nowrap><font color="#003399" size="2">Competition</font></TD>
						<TD align="Left" width="25%" nowrap><font color="#003399" size="2">Match Between</font></TD>
						<TD align="Left" width="25%" nowrap><font color="#003399" size="2">Venue</font></TD>
						<TD align="Left" width="15%" nowrap><font color="#003399" size="2">Match Date</font></TD>
						<td width="10%">&nbsp;</td>

					</TR>
					<%} else if (crsObjViewData.next()) {%>
					<TR>
						<TD align="Left" nowrap><font color="#003399" size="2">Competition</font></TD>
						<TD align="Left" nowrap><font color="#003399" size="2">Match Between</font></TD>
						<TD align="Left" nowrap><font color="#003399" size="2">Venue</font></TD>
						<TD align="Left" nowrap><font color="#003399" size="2">Match Date</font></TD>
						<td width="10%"><b>Day:<b><%=crsObjViewData.getString("team2name")!=null?crsObjViewData.getString("matchDay"):""%></td>
					</TR>
					<TR>
						<TD align="Left" nowrap><%=crsObjViewData.getString("series")!=null?crsObjViewData.getString("series"):""%></TD>
						<TD align="Left" nowrap><%=crsObjViewData.getString("team1name")!=null?crsObjViewData.getString("team1name"):""%>
						Vs <%=crsObjViewData.getString("team2name")!=null?crsObjViewData.getString("team2name"):""%></TD>
						<TD align="Left" nowrap><%=crsObjViewData.getString("venue")%>,
						<%=crsObjViewData.getString("city")%></TD>
						<TD align="Left" nowrap><%=crsObjViewData.getString("matchdate")!=null?crsObjViewData.getString("matchdate"):""%></TD>
						<%
			if(User_Name.equalsIgnoreCase("report")){
				
			}else{
			if(flag==false){
%>
						<td nowrap><INPUT type="button" align="right"
							class="btn btn-small btn-warning" value="Continue"
							onclick="validate();callRedirect('1','<%=userRole %>')">
						</td>
						<% 			}else{
%>
						<td nowrap><INPUT type="button" align="right" class="btn btn-small btn-warning"
							value="Continue"
							onclick="validate();callRedirect('2','<%=userRole %>')">
						</td>
						<%			  }	
			}	
%>

					</TR>
				</TABLE>
				</FIELDSET>
				<BR>

				<FIELDSET style="size: 45%; padding: 10px;" class="background"><LEGEND
					class="background1"><a class="aheading">Summary</a></LEGEND>
				<TABLE align="left" width="100%" border="0" bordercolor="#fff"
					bgcolor="#E6F1FC" cellspacing="0" cellpadding="0">
					<tr>
						<td><jsp:include page="matchsummary.jsp">
							<jsp:param name="match" value="<%=Firstmatchid%>" />
						</jsp:include></td>
					</tr>
				</TABLE>
				<BR>

				</FIELDSET>
				<%	
	}
%> <% if (flag==true){
%> <script>
			document.getElementById('hidFlag').value = 1;
	</script> <%}
%>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</FORM>
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-26503107-1']);
  _gaq.push(['_trackPageview']);
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
</body>
</html>
<%
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
%>
		
	

