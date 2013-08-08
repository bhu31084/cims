<!--
	Page Name 	 : Playe
	rCareerReport.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 13th Nov 2008
	Description  : Player Career Report 
	Company 	 : Paramatrix Tech Pvt Ltd.
	Modified by  : Vaibhavg (Added link  from TopPerformer to this page)  
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet,
            in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
            java.util.*"
%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%  response.setHeader("Pragma", "private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<%  CachedRowSet crsObj           = null;
	
	CachedRowSet crsObjAssociationRecord = null;
	
	CachedRowSet crsObjSeason					 	 = null;
	Vector vparam                                    = new Vector();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();

	String player_name   = "";
	String userId        = "";
	String associationid = "";
	String associatioName= ""; 
	String seriesId= ""; 
	String seasonId= "";
	String roleId= "";
	String hidId = "";
	String clubId = "";
	String userRoleId = "";
	String start_date ="";
	String date_two ="";
	Common common = new Common();
	String season_name = "2008-2009";
	//code added by vaibhav
		userId = request.getParameter("userid")!=null?request.getParameter("userid"):"";
		player_name= request.getParameter("official")!=null?request.getParameter("official"):"";
		associationid  = request.getParameter("associationid")!=null?request.getParameter("associationid"):"";
		associatioName  = request.getParameter("associatioName")!=null?request.getParameter("associatioName"):"";
		clubId= request.getParameter("clubId")!=null?request.getParameter("clubId"):"";
		seriesId = request.getParameter("seriesId")!=null?request.getParameter("seriesId"):"0";
		seasonId = request.getParameter("seasonId")!=null?request.getParameter("seasonId"):"";
		roleId = request.getParameter("roleId")!=null?request.getParameter("roleId"):"";
		userRoleId = request.getParameter("userRoleId")!=null?request.getParameter("userRoleId"):"";
		hidId= request.getParameter("hidId")!=null?request.getParameter("hidId"):"";
		start_date = request.getParameter("txtDateFrom")!=null?request.getParameter("txtDateFrom"):"";
		date_two = request.getParameter("txtDateTo")!=null?request.getParameter("txtDateTo"):"";
		
		if(hidId.equalsIgnoreCase("2")){
			vparam.add(seasonId);
			vparam.add(userRoleId);
			vparam.add(roleId);
			vparam.add(clubId);
			vparam.add(common.formatDate(start_date));
			vparam.add(common.formatDate(date_two));
			vparam.add("2");
			crsObj = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_official_consoldated_report", vparam, "ScoreDB");
			vparam.removeAllElements();
		}
			
		try {	crsObjAssociationRecord = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_getclubs_playerlist", vparam, "ScoreDB");
		} catch (Exception e) {
			e.printStackTrace();
			out.println(e);
		}
	
	
	try {
		vparam.removeAllElements();	
		vparam.add("1");
		crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");
		vparam.removeAllElements();	
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e);
	}
	
	if(crsObjSeason!=null){
		while(crsObjSeason.next()){
			seasonId = crsObjSeason.getString("id");
			season_name = crsObjSeason.getString("name");
		}
	}
	 crsObjSeason.beforeFirst();
%>
<html>
<head>
	<title>Umpire Report</title>
	<script language="JavaScript" src="../js/Calender.js" type="text/javascript"></script>
	<script language="JavaScript" src="../js/common.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="../css/tabexample.css"> 
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">

	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../css/form.css">
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div style="height=50%">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
  <tr>
	<td class="legend" colspan="2" align="center"><b><span style="font-size:20px;">Umpire Match Details Report</span></b> </td>
  </tr>
  <tr>
	<td colspan="2" align="right">
			Export :
			<a href="/cims/jsp/PDFUmpireCareerReportResponse.jsp?seasonId=<%=seasonId%>&roleId=<%=roleId%>&clubId=<%=clubId%>&txtDateFrom=<%=start_date%>&txtDateTo=<%=date_two%>&flag=2&userRoleId=<%=userRoleId%>&associatioName=<%=associatioName%>&official=<%=player_name%>" target="_blank" class="button">
				<img src="../images/pdf.png" height="20" width="20" />
			</a> 
			
	</td>
  </tr>
  <tr>
	<td colspan="2"></td>
  </tr>
  <tr>
	<td colspan="2" ></td>
  </tr>	
  <tr class="contentDark">
	<td>Official Name: <%=player_name %> </td>
	<td>Association Name: <%=associatioName %> </td>
   </tr>
   <tr class="contentLight"/>			
 	<td>From Date: <%=start_date %></td>
	<td>End Date: <%=date_two %></td>
  </tr>
</table>
<br/><br/><br/>
<% if(crsObj != null) {
	
%> <table width="100%" border="1" align="center" cellpadding="2" cellspacing="1" class="table">
	  <tr class="contentDark">
		<td>Match </td>
		<td>Match Type </td>
		<td>From Date </td>
		<td>To Date </td>
		<td>days</td>
		<td>Tournament</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	  </tr>

<%	int i = 0;
	while(crsObj.next()){
%>		<tr class="<%=i%2==0?"contentLight":"contentDark" %>">
		
		<td><%= crsObj.getString("match") %></td>	
		<td><%= crsObj.getString("matchtype") %></td>
		<td><%= crsObj.getString("from_date") %></td>
		<td><%= crsObj.getString("to_date")%></td>
		<td><%= crsObj.getString("days") %></td>
		<td><%= crsObj.getString("tournament") %></td>
		<td><a href="/cims/jsp/RefereeReportOnUmpires.jsp" target="_blank">Referee's Feedback	</a></td>
		<td><a href="/cims/jsp/UmpiresSelfAssessment.jsp" target="_blank">Umpire's Self Assessment</a></td>
		<td><a href="/cims/jsp/UmpireCoachReport.jsp" target="_blank">Umpire Coach Feedback</a></td>

		</tr>
<%	i = i + 1;
	}
%>		
	</table>		
<% }
%>
</div>
</body>
</html>