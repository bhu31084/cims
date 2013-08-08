<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<%--Admin Menu--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>

<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<%
    String User_Name = (String)session.getAttribute("username");
    String userId	 = (String)session.getAttribute("userId").toString();
	System.out.println("User_Name in menu is  "+User_Name);
    
    CachedRowSet  crsObj= null;
     CachedRowSet  crsObjroleid= null;
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	//vparam.add("34286");
	String roleid=null;
	String role="0";
	try{
	 vparam.add("Association");
	      crsObjroleid = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roleid", vparam, "ScoreDB");
			if(crsObjroleid!=null){
			while(crsObjroleid.next()){
			roleid=crsObjroleid.getString("id");
			System.out.println("roleid is "+roleid);
			}
			}
	        vparam.removeAllElements();
	        vparam.add(userId);
			 crsObj = lobjGenerateProc.GenerateStoreProcedure("esp_adm_loginrole", vparam, "ScoreDB");

			if(crsObj!=null){
			while(crsObj.next()){
			role=crsObj.getString("role");
			System.out.println("role is "+role);
			}
		}
		vparam.removeAllElements();
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%--<IMG alt="" src="../../images/bccitopmenu.jpg"  width="100%">--%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> Menu Admin</title>
<script src="../../js/SpryMenuBar.js" type="text/javascript"></script>
<link href="../../css/MenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<link href="../../css/MenuBarVertical.css" rel="stylesheet" type="text/css" />
<link href="../../css/adminmenu.css" rel="stylesheet" type="text/css" />
<script>
	function changePage(username){									
	
	window.open("/cims/jsp/ChangePWForSecurity.jsp?userName="+username,"CIMS3","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=300,left=300,width=400,height=200");
		
	}
	
	function callHelp(flag){
		if(flag == 1){
			window.open("../../helpdoc/CIMSAdminUserManual.pdf","HELP1","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=200,left=100,width="+(window.screen.availWidth - 200)+",height="+(window.screen.availHeight - 200));
		}else if(flag == 2){
			window.open("../../helpdoc/CIMSUSERMANUAL.pdf","HELP2","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=200,left=100,width="+(window.screen.availWidth - 200)+",height="+(window.screen.availHeight - 200));
		}else if(flag == 3){
			window.open("../../helpdoc/CIMSReportsUserManual .pdf","HELP3","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=200,left=100,width="+(window.screen.availWidth - 200)+",height="+(window.screen.availHeight - 200));
		}else if(flag == 4){
			window.open("../../helpdoc/FeedbackFormsHelp.pdf","HELP4","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=200,left=100,width="+(window.screen.availWidth - 200)+",height="+(window.screen.availHeight - 200));
		}
	}
	
	function sendSMS(){
		//window.open("../sms/SMSPush.jsp","sendsms","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=250,left=250,width="+(window.screen.availWidth-400)+",height="+(window.screen.availHeight-400));
		window.open("/cims/jsp/sms/MultipleSMSPush.jsp","sendmultiplesms","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,top=10,left=10,width="+(window.screen.availWidth-50)+",height="+(window.screen.availHeight-50));
	}
</script>

</head>



<body>
<table width="100%" cellpadding="0" cellspacing="0" >
	<tr> 
		<td align="left"><img src="../../images/AdminBG.jpg" alt="" /></td>
	</tr>
</table>

<ul  id="MenuBar1" class="MenuBarHorizontal">
<%
if(role.equals(roleid)||role.equals("9"))
{
%>
<li><a class="MenuBarItemSubmenu" >User Master</a>
<%}%>
	<ul>
		<li><a href="/cims/jsp/admin/UserMaster.jsp">Add Player</a></li>
		<li><a href="/cims/jsp/admin/PlayerSearch.jsp">Player Search</a></li>
	</ul>
</li>	
<%
if(role.equals("9"))
{
%>	
  	<li><a class="MenuBarItemSubmenu" >Region Master</a>
		<ul>
			<li><a  href="/cims/jsp/admin/ClubMaster.jsp">Club Master</a></li>
			<li><a href="/cims/jsp/admin/VenueMaster.jsp">Venue Master</a></li>
			<li><a href="/cims/jsp/admin/StateMaster.jsp">State Master</a></li>
			<li><a href="/cims/jsp/admin/LocationMaster.jsp">City Master</a></li>
		</ul>
  	</li>
 <%}%>
  <%
    if(role.equals("9") || role.equals(roleid))
       {
         %>
   <li><a class="MenuBarItemSubmenu" >Team Master</a>
      <ul>
       <%
    if(role.equals("9"))
       {
         %>	
        <li><a href="/cims/jsp/admin/TeamMaster.jsp">Team Registration</a></li>
        <%}%>
<%   if(role.equals(roleid)||role.equals("9"))     
     {
       %>
        <li><a href="/cims/jsp/admin/TeamPlayerMap.jsp">Team Player Map Master</a></li>
         <%}%>
      </ul>
  </li>
  <%}%>
  <%
if(role.equalsIgnoreCase("9"))
{
%>
  <li><a class="MenuBarItemSubmenu" >General Master</a>
      <ul>
      	<li><a  href="/cims/jsp/admin/RoleMaster.jsp">Role Master</a></li>
        <li><a  href="/cims/jsp/admin/AppealMaster.jsp ">Appeal Master</a></li>
        <li><a href="/cims/jsp/admin/ResultMaster.jsp">Result Master</a></li>
        <li><a href="/cims/jsp/admin/RoundMaster.jsp">Round Master</a></li>
		<li><a href="/cims/jsp/admin/SeasonMaster.jsp">Season Master</a></li>
        <li><a href="/cims/jsp/admin/WeathertypeMaster.jsp ">Weather Master</a></li>        
        <li><a  href="javascript:changePage('<%=User_Name%>')" >Change PassWord</a></li>
      </ul>
  </li>
   <li><a class="MenuBarItemSubmenu"  >Match Setup</a>
  		<ul>
  			<li><a href="/cims/jsp/admin/SeriesTypeMaster.jsp">Tournament Registration</a></li>
        	<li><a href="/cims/jsp/admin/SeriesSelectionMaster.jsp">Tournament Selection</a></li>
        	<li><a href="/cims/jsp/admin/MatchTypeDetails.jsp">Match Type Creation</a></li>	        
	      	<li><a href="/cims/jsp/admin/MatchSetUpMaster.jsp">Match Schedule</a></li>
 		    <li><a href="/cims/jsp/admin/concisematchdetails.jsp">Concise Match Schedule</a></li>
	       	<li><a href="/cims/jsp/admin/MatchScorerSelection.jsp">Assign Scorers</a></li>	
			<li><a href="/cims/jsp/admin/MatchAnalysisSelection.jsp">Assign Analyst</a></li>
	        <li><a href="/cims/jsp/admin/AdminMatchSetUp.jsp">Assign Officials</a></li>
	        <li><a href="/cims/jsp/admin/UmpiresMatchSetUp.jsp">Match Approval</a></li>	                      
			<li><a href="/cims/jsp/admin/EditScorerMatch.jsp">Match Access</a></li>	  
			<li><a href="/cims/jsp/admin/GetFileToUploadMatchSchedule.jsp">Upload Matches</a></li>
			<li><a href="/cims/jsp/admin/GetFileToUploadPlayerProfiles.jsp">Upload Player Profiles</a></li>
        </ul>
    </li>
    <li><a class="MenuBarItemSubmenu" >General Reports</a>
      <ul>
       		<li><a href="/cims/jsp/admin/TeamPosition.jsp">Team Points</a></li>
        	<li><a href="/cims/jsp/admin/MatchUsersList.jsp">Users of Match</a></li>
        	<li><a href="/cims/jsp/admin/ScorerSeriesMatchDetails.jsp">Scorer's Match Details</a></li>
        	<li><a href="/cims/jsp/SelectMatch.jsp">Reports</a></li>
        	<li><a href="javascript:sendSMS()">Send SMS</a></li>
        	<li><a href="/cims/jsp/admin/SMSApproval.jsp">SMS Accepted/Denied</a></li>
			<li><a href="/cims/jsp/admin/PenaltyReport.jsp">Penalty Report</a></li>
        	
      </ul>
	</li>    
    <li style="width:7em;">
    	<a class="MenuBarItemSubmenu" >AuthZ</a>
      	<ul>              
   			<li><a  href="/cims/jsp/admin/AuthzAdminConsole.jsp">Map Role-Users</a></li>
	     	<li><a href="/cims/jsp/admin/AuthzAddOp.jsp">Map Role-Ops</a></li>
	        <li><a href="/cims/jsp/admin/Reconfig.jsp">Reconfig All</a></li>
	        <li><a href="/cims/jsp/admin/EditPlayerMap.jsp">Edit Match Player</a></li>
	        <li><a href="/cims/jsp/admin/EditPlayerRoleMap.jsp">Edit Match Player Role</a></li>
	        <li><a href="/cims/jsp/admin/EditMatch.jsp">Edit Match</a></li>
      </ul>
  </li>  
 <%}%> 
   <li style="width:7em;"><a href="/cims/jsp/admin/AdminHelp.jsp"> Help</a></li> 
   <li style="width:7em;"><a href="/cims/jsp/Logout.jsp">Logout</a></li>
</ul>
<div class="clearer"></div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"MenuBarDownHover.gif", imgRight:"MenuBarRightHover.gif"});
</script>
<%
if(role.equals("0")){
%>
 <center style="font-size: large;"> No Access</center>
 <%
}
%>
</body>
</html>
