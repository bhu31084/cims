<!--
	Author 		 : Saudagar Mulik
	Created Date : 02/09/2008
	Description  : Umpire coach report.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%
		try {
			CachedRowSet crsObjViewData = null;
			CachedRowSet crsObjMatches = null;
			CachedRowSet crsObjTodayMatches = null;
			GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
			Vector vparam = new Vector();

			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy/MM/dd");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
					"dd/MM/yyyy");

			String match_id = "0";

			Common common = new Common();

			String date_one = sdf2.format(new Date());
			String date_two = sdf2.format(new Date());
			String teams ="";
			String Firstmatchid="";

			vparam.add(common.formatDate(date_one));
			vparam.add(common.formatDate(date_two));
			crsObjTodayMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getmatches", vparam, "ScoreDB");
			int todaymatch = crsObjTodayMatches.size();
			vparam.removeAllElements();
			if(crsObjTodayMatches.first()){
				match_id = crsObjTodayMatches.getString("matches_id");
				Firstmatchid = crsObjTodayMatches.getString("matches_id");
				crsObjTodayMatches.previous();
			}
			vparam.add(match_id);
			crsObjViewData = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getprematchtype", vparam, "ScoreDB");
			vparam.removeAllElements();
			
			if (request.getParameter("hid") != null) {
				if (request.getParameter("hid").equalsIgnoreCase("0")) {
					date_one = request.getParameter("txtDateFrom").toString();
					date_two = request.getParameter("txtDateTo").toString();
					vparam.add(common.formatDate(date_one));
					vparam.add(common.formatDate(date_two));
					crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getmatches", vparam, "ScoreDB");
					vparam.removeAllElements();							
				} else if (request.getParameter("hid").equalsIgnoreCase("1")) {
					match_id = request.getParameter("matchid");
					vparam.add(match_id);
					crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getprematchtype", vparam, "ScoreDB");
					vparam.removeAllElements();
					System.out.println("from date" + request.getParameter("txtDateFrom"));
					date_one = request.getParameter("txtDateFrom").toString();
					date_two = request.getParameter("txtDateTo").toString();
					vparam.add(common.formatDate(date_one));
					vparam.add(common.formatDate(date_two));
					crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getmatches", vparam, "ScoreDB");
					vparam.removeAllElements();	
					Firstmatchid = match_id;		
				} else if (request.getParameter("hid").equalsIgnoreCase("2")) {
					if (request.getParameter("matchid") != null && !request.getParameter("matchid").equals("0")) {
						session.setAttribute("matchid", request.getParameter("matchid"));
						session.setAttribute("matchId1", request.getParameter("matchid"));
						response.sendRedirect("/cims/jsp/ReportMain.jsp");
						return;	
					}
				}else if (request.getParameter("hid").equalsIgnoreCase("3")) {
					Firstmatchid = request.getParameter("matchno");
					match_id = request.getParameter("matchno");
					vparam.add(Firstmatchid);
					crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getprematchtype", vparam, "ScoreDB");
					vparam.removeAllElements();
					date_one = request.getParameter("txtDateFrom").toString();
					date_two = request.getParameter("txtDateTo").toString();
					vparam.add(common.formatDate(date_one));
					vparam.add(common.formatDate(date_two));
					crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getmatches", vparam, "ScoreDB");
					vparam.removeAllElements();
				}
			}else{
			//	date_one = request.getParameter("txtDateFrom").toString();
				//date_two = request.getParameter("txtDateTo").toString();
				vparam.add(common.formatDate(date_one));
				vparam.add(common.formatDate(date_two));
				crsObjMatches = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_getmatches", vparam, "ScoreDB");
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
	var i = 0;
	function getMatches(){
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
	var matchid1 = matchid;
	 window.open("/cims/jsp/pressInningDetails.jsp?press=press&matchno="+matchid1,"press"+i,"location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,top=0,left=280,width="+(window.screen.availWidth-290)+",height="+(window.screen.availHeight-30));
	i=i+1;
	}
	function validate(){
			document.getElementById("hid").value = "2";
			document.selectmatch.submit();	
	}
	
</script>
</head>

<body>
<FORM action="SelectMatch.jsp" name="selectmatch" method="post">
<table width="100%" cellpadding="0"  cellspacing="0" border="0">
	<tr>
		<td height="20%" width="100%"><IMG alt="" src="../images/bccitopmenu.jpg" width="100%" ></td>
    </tr>	
	<tr><td align="right">
		<div class="cboth pTB5">		
			<div class="right pR10"><a border="0" href="/cims/jsp/Logout.jsp">Log Out</a></div>
			<div class="right pR10">Date: <B><%= sdf1.format(new Date())%></div>
		</div>
	</td></tr>	
	<tr>
		<td valign="top">
			<table border="0" width="100%" height="100%" cellpadding="0"  cellspacing="0">
					<tr valign="top" >
						<td width="25%" height="100%"><INPUT type="hidden" id="hid" name="hid" />
							<table border="1" bgcolor="#E7DCBC" bordercolor="White"  height="100%" width="100%">
					<%			if (crsObjTodayMatches != null) {
								while (crsObjTodayMatches.next()) {
									/*if(crsObjTodayMatches.first()){
										if (request.getParameter("hid") == null){
											Firstmatchid = crsObjTodayMatches.getString("matches_id");
										}
									}*/
					%>			<tr valign="middle" >
									<td nowrap="nowrap"><a href="javascript:getmatch('<%=crsObjTodayMatches.getString("matches_id")%>')"><FONT color="#003399">
											<%=crsObjTodayMatches.getString("team_one")%> Vs. <%=crsObjTodayMatches.getString("team_two")%></font></a></td>
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
						<td width="75%" valign="top">						
						<FIELDSET style="size: 45%;" class="background" ><LEGEND class="background1"><a class="aheading">Details</a></LEGEND>
						<BR>
						<TABLE align="center" width="100%" border="1" bgcolor="#E4E4E4" cellspacing="5" cellpadding="5">
							<%if (crsObjViewData == null) {%>
							<TR>
								<TD align="Left" width="25%"> <font size="2" color="#003399">Competition</font></TD>
								<TD align="Left" width="25%"> <font size="2" color="#003399">Match Between</font></TD>
								<TD align="Left" width="50%"> <font size="2" color="#003399">Venue</font></TD>
							</TR>
							<%} else if (crsObjViewData.next()) {%>
							<TR>
								<TD align="Left"><font size="2" color="#003399">Competition</font></TD>
								<TD align="Left"><font size="2" color="#003399">Match Between</font></TD>
								<TD align="Left"><font size="2" color="#003399">Venue</font></TD>
							</TR>
							<TR>
								<TD align="Left"><%=crsObjViewData.getString("series")%></TD>
								<TD align="Left"><%=crsObjViewData.getString("team1name")%> Vs
								<%=crsObjViewData.getString("team2name")%></TD>
								<TD align="Left"><%=crsObjViewData.getString("venue")%>, <%=crsObjViewData.getString("city")%>
							</TR>
						</TABLE>
						</FIELDSET>
						<BR>
						<BR>
						<FIELDSET style="size: 45%;" class="background" ><LEGEND class="background1"><a class="aheading">Summary</a></LEGEND>
						<BR>
							<TABLE align="left" width="100%" border="1" bgcolor="#E4E4E4" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<jsp:include page="matchsummary.jsp">
										<jsp:param name="match" value="<%=Firstmatchid%>" />
								</jsp:include>
								
					 			</td> 
							</tr>	 
							</TABLE>
						<BR>
						
						</FIELDSET>
					<%	
						}
					%>	
						
						</td>
					   </tr>
					  </table>	
				</td>
	</tr>

 
 </table>  
</FORM>
</body>
</html>
<%
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
%>
