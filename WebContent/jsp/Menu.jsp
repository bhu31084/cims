<!--
	Author 		 		: Saudagar Mulik
	Created Date 		: 04/09/2008
	Description  		: Menu for report pages.
	Company 	 		: Paramatrix Tech Pvt Ltd.
	Modification Date	: 03/11/2008
-->

<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="/cims/jsp/response/error_page.jsp"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>

<%
				String matchId = null;
				String userId = null;
				String mtype = null;
				String username =(String)session.getAttribute("username");
				int retVal = 0;
				String statusFlag = (String)session.getAttribute("statusFlag");
				
				if(statusFlag.equalsIgnoreCase("1")){
				 matchId = "0";
				}else{
					matchId = session.getAttribute("matchid").toString()==null?"0":session.getAttribute("matchid").toString();
				}
				if(matchId.equalsIgnoreCase("0")){
					response.sendRedirect("/cims/jsp/Logout.jsp?message=Session Expire!");
				}
				userId = session.getAttribute("userid").toString(); 
				CachedRowSet crsObjViewMenu = null;
				CachedRowSet crsObjViewMType = null;				
				GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
				Vector vparam = new Vector();
				vparam.add(matchId);
				vparam.add(userId);		
				try{
				crsObjViewMenu = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_menu", vparam, "ScoreDB");	
				}catch(Exception e){
					e.printStackTrace();
				}   			
				vparam.removeAllElements();			
								
				vparam.add(matchId);
				try{
				crsObjViewMType = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_matchtype_match", vparam, "ScoreDB");	
				}catch(Exception e){
					e.printStackTrace();
				}						
				vparam.removeAllElements();					
				if(crsObjViewMType !=null && crsObjViewMType .next()){
					//mtype = crsObjViewMType.getString("matchtype");	
					mtype = crsObjViewMType.getString("num_innings");
					session.setAttribute("role", new Integer(retVal));
				}
				if(crsObjViewMenu!=null && crsObjViewMenu.next()){
					retVal = crsObjViewMenu.getInt("retval");
					session.setAttribute("role", new Integer(retVal));
				}
				
				
/*

id,name
1,Player
2,Umpire
3,Scorer
4,Referee
5,Curetor
6,Umpire Coach
9,Admin
*/

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>Menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/chromestyle2.css" />

<script type="text/javascript" src="../js/chrome.js">
	
</script>



</head>

<body>
 <div style="width:84.5em">
 <table width="100%" border="0"  cellpadding="0" cellspacing="0">
<%--	<tr> --%>
<%--   		<td height="20%" ><IMG alt="" src="../images/bccitopmenu.jpg"  width="100%"></td>--%>
<%--    </tr>	--%>
	<tr>
		<td align="left"><img src="../images/AdminBG.jpg" alt="" /></td>
	</tr>
 </table>	
 </div>
 
<div class="chromestyle" id="chromemenu" align="left">
<ul>
<li style="width:4em;"><a class="chromestyleborder" href="/cims/jsp/SelectMatch.jsp">Home</a></li>
<li><a rel="dropmenu1" class="chromestyleborder">Match Details</a></li>
<li style="width:11em;"><a rel="dropmenu3" class="chromestyleborder">Match Feedback</a></li>
<li><a rel="dropmenu5" class="chromestyleborder">For Player</a></li>
<li><a rel="dropmenu6" class="chromestyleborder">Report</a></li>
<%if(retVal != 9){%>
<li><a href="/cims/jsp/admin/UmpiresMatchSetUp.jsp" class="chromestyleborder">Match Approval</a></li>
<%}%>
<li style="width:6em;"><a href="/cims/jsp/Help.jsp"  class="chromestyleborder">Help</a></li>
<li style="width:6em;"><a href="/cims/jsp/Logout.jsp" class="chromestyleborder">Logout</a></li>
</ul>
</div>

<!--1st drop down menu -->                                                   
<div id="dropmenu1" class="dropmenudiv" align="left">
<% 
	if(statusFlag.equalsIgnoreCase("0")){
	if(username.equalsIgnoreCase("report")){
	}else{
		if(mtype.equalsIgnoreCase("2")){%>    
			<a href="/cims/jsp/LimitedOvers.jsp">Limited Over Match</a>
<%		}else{
%>			<a href="/cims/jsp/TestMatchScoreSheetVersion3.jsp">2 , 3 , 4,5 Days Match</a>
			<a href="/cims/jsp/SeriesMatchDetailsByOfficials.jsp">Matches Scored by Officials</a>
<% 
		}
    }//main else
%>
	<a href="/cims/jsp/InningsDetails.jsp">Print Scorecard</a>
	<a href="/cims/jsp/TeamScoreDetails.jsp">ScoreCard</a>
	<a href="/cims/jsp/TeamPosition.jsp">Team Position</a>
	<a href="/cims/jsp/ScorecardSummary.jsp">Desktop Scorecard</a>
	<a href="/cims/jsp/InningsDetail.jsp">Inning Summary</a>
<% }else{
%> 		<a>Not Authorised</a>
<% }
%>

</div>

<!--3rd drop down menu -->                                                   
<div id="dropmenu3" class="dropmenudiv" align="left">
<%if(retVal == 1){%>
	<a href="/cims/jsp/CaptainGroupPitchFacility.jsp">Captain's Feedback</a>
<%}else if(retVal == 4){%>
	<a href="/cims/jsp/RefereeReportOnUmpires.jsp">Referee's Feedback</a>
	<a href="/cims/jsp/TRDOReportForPlayerAttribute.jsp">TRDO Report</a>
	<a href="/cims/jsp/SuspectAction.jsp?suspectactionrole=4">Suspect Action Report</a>
	<%if(mtype.equalsIgnoreCase("2")){%>    
			<a href="/cims/jsp/PitchOutfieldReportLimited.jsp">Pitch Outfield Feedback (1 day)</a>
	<%}else{%>
		<a href="/cims/jsp/PitchOutfieldReportFiveDays.jsp">Pitch Outfield Feedback (Multiple days)</a>
	<%}%>

<a href="/cims/jsp/OverRate.jsp">Over Rate Calculation</a>
<%}else if(retVal == 2){%>
	<%--<a href="UmpireSelfAssesment.jsp">Umpire Self Assessment</a>--%>
	<a href="/cims/jsp/UmpiresSelfAssessment.jsp">Umpire's Self Assessment</a>
	<a href="/cims/jsp/UmpireReport.jsp">Umpire Feedback</a>
	<a href="/cims/jsp/OverRate.jsp">Over Rate Calculation</a>
	<a href="/cims/jsp/SuspectAction.jsp?suspectactionrole=2">Suspect Action Report</a>
<%}else if(retVal == 6){%>
	<a href="/cims/jsp/umpiringDecisionLog.jsp">Umpiring Decision Log</a>
	<a href="/cims/jsp/UmpireCoachReport.jsp">Umpire Coach Feedback</a>
	<a href="/cims/jsp/SuspectAction.jsp?suspectactionrole=6">Suspect Action Report</a>
<%}else if(retVal == 9 && statusFlag.equalsIgnoreCase("0")){%>
	<a href="/cims/jsp/CaptainGroupPitchFacility.jsp">Captain's Pitch & Facility Feedback</a>
	<a href="/cims/jsp/RefereeReportOnUmpires.jsp">Referee's Feedback</a>
	<a href="/cims/jsp/TRDOReportForPlayerAttribute.jsp">TRDO Report</a>
	<a href="/cims/jsp/SuspectAction.jsp">Suspect Action Report</a>
	<%if((mtype.equalsIgnoreCase("Ond Day"))|| (mtype.equalsIgnoreCase("OndDay"))){%>    
	<a href="/cims/jsp/PitchOutfieldReportLimited.jsp">Pitch Outfield Feedback</a>
<%}else{%>
	<a href="/cims/jsp/PitchOutfieldReportFiveDays.jsp">Pitch Outfield Feedback (Multiple days)</a>
<%}%>
	<a href="/cims/jsp/OverRate.jsp">Over Rate Calculation</a>
<%--<a href="UmpireSelfAssesment.jsp">Umpire Self Assessment</a>--%>
	<a href="/cims/jsp/UmpiresSelfAssessment.jsp">Umpire's Self Assessment</a>
	<a href="/cims/jsp/UmpireReport.jsp">Umpire Feedback</a>
	<a href="/cims/jsp/umpiringDecisionLog.jsp">Umpiring Decision Log</a>
	<a href="/cims/jsp/UmpireCoachReport.jsp">Umpire Coach Feedback</a>
<%}else{%>
	<a>Not Authorised</a>
<%}%>
</div>

<!--4rd drop down menu -->                                                   
<div id="dropmenu4" class="dropmenudiv" align="left">
<a>Under Construction</a>
</div>



<!--4rd drop down menu -->                                                   
<div id="dropmenu5" class="dropmenudiv" align="left">
<a href="/cims/jsp/TopPerformer.jsp">Top Performers</a>
<a href="/cims/jsp/PlayerCareerReport.jsp">Player Career</a>
<a href="/cims/jsp/OffendersList.jsp">Offenders List</a>
</div>

<!--4rd drop down menu --> 
                                                
<div id="dropmenu6" class="dropmenudiv" align="left">
<%if(retVal == 9){%>  
<a href="/cims/jsp/umpireReportAdmin.jsp?reportid=1">Umpire Assessment</a>
<a href="/cims/jsp/displayTrdoReport.jsp?reportid=4">TRDO Report</a>
<a href="/cims/jsp/UmpireCareerReport.jsp">Umpire Report</a>

<%}else if(retVal == 2){ 
%>
    <a href="/cims/jsp/UmpiresSelfAssessmentPerformance.jsp?reportid=1">Umpire Assessment</a>
<% }else if(retVal == 6){
%>
  <a href="/cims/jsp/UmpiresSelfAssessmentPerformance.jsp?reportid=2">Umpire Coach Assessment</a>      
<%}else if(retVal == 4){
%>   <a href="/cims/jsp/UmpiresSelfAssessmentPerformance.jsp?reportid=3">Referee Assessment</a> 
<%}
else{%>
	<a>Not Authorised</a>
<%}%>
</div>

<script type="text/javascript">
cssdropdown.startchrome("chromemenu")
</script>
</body>

</html>