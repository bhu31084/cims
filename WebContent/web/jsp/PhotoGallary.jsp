<!--
Page name	 : PlayerSearch.jsp for web
Replaced By  : Archana Dongre.
Created Date : 29 apr 2009
Description  : To get user's details.
Company 	 : Paramatrix Tech Pvt Ltd. 
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>  
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ include file="loginvalidate.jsp" %>
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
<%	Common commonUtil		  	 =  new Common();
    CachedRowSet  crsObjRolesCrs =  null;
    CachedRowSet  userDataCrs	 =  null;
    CachedRowSet  updateUserCrs	 =  null;
    CachedRowSet  crsObjSeason 	 = null;
    CachedRowSet  crsObjZone 	 = null;
    CachedRowSet crsObjSeriesTypeRecord  = null;
    
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");    
	String userRole 			 =  "";
	String matchId				 =  "";	
	matchId 		    		 = (String)session.getAttribute("matchid");
	%>

<html>
	<head>
		<title> Player Data </title>    
		<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
		<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" /> 
		<script language="JavaScript" src="../js/tabber.js" type="text/javascript"></script>
		<script language="JavaScript" src="../js/sortable.js" type="text/javascript"></script>
		<script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
		<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>
		<script language="JavaScript" src="../js/otherFeedback.js"></script>
		<script language="JavaScript" src="../js/popup.js"></script>
		<script type="text/javascript" src="../js/common.js"></script>
		<script>
			function callSubmit(){		
				try{
					document.getElementById('hdSubmit').value = "submit"			
					if(document.getElementById('txtUserName').value == ""){
						alert(" User Name can not be left Blank !");
						frmphotoGallary.txtUserName.focus();
					}else if(document.getElementById('password').value == ""){
						alert(" Password can not be left Blank !");
						frmphotoGallary.password.focus();
					}else{
						document.frmphotoGallary.submit();			
					}	
				}catch(err){
						alert("callSubmit"+err.description); 
				}
			}
		</script>			
	</head>
	<body>
		<form id="frmphotoGallary" name="frmphotoGallary" method="get">
		<jsp:include page="Header.jsp"></jsp:include> 	  		
		<table style="width: 185px;height: 800px;" border="0" >				 
		<tr>		    
			<td valign="top">
				<div style="width: 185px;height: 800px;overflow: auto;" class="scrollBarsHV"> 
				<table style="width: 185px;height: 800px;" border="0" class="contenttable">
					<tr>
						<td background = "../Image/top_bluecen.jpg" valign="top" style="font-size: 14px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >BCCI Office Bearers</td>
					</tr>
					<tr>
						<td class="commityRow">Shashank V Manohar </td>
					</tr>
					<tr >
						<td class="commityRowAlt" style="color: gray;">President</td>		    		    
					</tr>
					<tr >		    
						<td class="commityRow">N. Srinivasan</td>		    		    
					</tr>
					<tr>		    
						<td class="commityRowAlt" style="color: gray;">Hon.Secretary </td>		    		    
					</tr>
					<tr >		    
						<td class="commityRow">Sanjay Jagdale </td>		    		    
					</tr>
					<tr >		    
						<td class="commityRowAlt" style="color: gray;">Hon. Joint Secretary </td>
					</tr>
					<tr >		    
						<td class="commityRow">M.P. Pandove </td>		    		    
					</tr>
					<tr >		    
						<td class="commityRowAlt" style="color: gray;">Hon. Treasurer </td>		    		    
					</tr>
					<tr >		    
						<td class="commityRow">Dayanand.G.Narvekar </td>		    		    
					</tr>
					<tr >		    
						<td class="commityRowAlt" style="color: gray;">Vice President </td>
					</tr>
					<tr >		    
						<td class="commityRow">Rajiv Shukla </td>		    		    
					</tr>
					<tr >		    
						<td class="commityRowAlt" style="color: gray;">Vice President </td>		    		    
					</tr>									   
					<tr >		    
						<td class="commityRow">Chirayu Amin </td>		    		    
					</tr>
					<tr >		    
						<td class="commityRowAlt" style="color: gray;">Vice President </td>		    		    
					</tr>
					<tr >		    
						<td class="commityRow">Lalit Kumar Modi </td>		    		    
					</tr>
					<tr >		    
						<td class="commityRowAlt" style="color: gray;">Vice President </td>		    		    
					</tr>								  
					<tr>
						<td background = "../Image/top_bluecen.jpg" valign="top" style="font-size: 14px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Administrative Team</td>
					</tr>   
					<tr > 		    
						<td class="commityRow">Prof. R.S. Shetty </td>		    		    
					</tr>
					<tr >		    
						<td class="commityRowAlt" style="color: gray;">Chief Administrative Officer</td>		    		    
					</tr>
					<tr > 		    
						<td class="commityRow">Mr.DINESH MENON</td>		    		    
					</tr>
					<tr >		    
						<td class="commityRowAlt" style="color: gray;">MANAGER ADMINISTRATION</td>		    		    
					</tr>									  
					<tr > 		    
						<td class="commityRow">Mr.SURU  NAYAK</td>		    		    
					</tr>
					<tr>		    
						<td class="commityRowAlt" style="color: gray;">MANAGER,CRICKET OPERATIONS</td>		    		    
					</tr>
					<tr> 		    
						<td class="commityRow">Mr.STANLEY SALDANHA</td>		    		    
					</tr>
					<tr>		    
						<td class="commityRowAlt" style="color: gray;">MANAGER,GAME DEVELOPMENT</td>		    		    
					</tr>
					<tr> 		    
						<td class="commityRow">Mr. DEVENDRA PRABHUDESAI</td>		    		    
					</tr>
					<tr>		    
						<td class="commityRowAlt" style="color: gray;">MANAGER,MEDIA RELATIONS & CORPORATE AFFAIRS</td>		    		    
					</tr>									   
				</table>
				</div>
			</td>
			<td valign="top">
				<div>
				<table id="" border="0" style="width: 800px;" class="contenttable">	   	
				   	<tr>
						<td background = "../Image/top_bluecen.jpg" valign="top" colspan="2" style="font-size: 14px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >BCCI Events</td>
					</tr>
					<tr>
					<td valign="top" colspan="2" style="font-size: 14px;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Under Construction</td>
					</tr>
<%--				   	<tr class="contentDark"> 						--%>
<%--						<td class="colheadinguser" style="width: 15%;">Season : --%>
<%--							<select class="input" name="selSeasonId" id="selSeasonId"  >--%>
<%--								<option value="0">--select--</option>							 			--%>
<%--					 			<%	try{	--%>
<%--										vparam.removeAllElements();	--%>
<%--										vparam.add("2");//--%>
<%--										crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(--%>
<%--													"esp_dsp_season",vparam,"ScoreDB");--%>
<%--										vparam.removeAllElements();	--%>
<%--										if(crsObjSeason != null){	--%>
<%--											while(crsObjSeason.next()){	--%>
<%--								%>						--%>
<%--								<%if(crsObjSeason.getString("id").equalsIgnoreCase("2")){%>	--%>
<%--														<option value="<%=crsObjSeason.getString("id")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>--%>
<%--								<%}else{%>					--%>
<%--														<option value="<%=crsObjSeason.getString("id")%>" ><%=crsObjSeason.getString("name")%></option>	--%>
<%--												<%}%>--%>
<%--														--%>
<%--								<%			}--%>
<%--										 }--%>
<%--									   }catch(Exception e){--%>
<%--										log.writeErrLog(page.getClass(),matchId,e.toString());--%>
<%--									}--%>
<%--								%>	--%>
<%--	 						 </select>								 												--%>
<%--						</td>--%>
<%--						<td class="colheadinguser" style="width: 15%;">Season : --%>
<%--							<select class="input" name="selSeasonId" id="selSeasonId"  >--%>
<%--								<option value="0">--select--</option>							 			--%>
<%--					 			<%	try{	--%>
<%--										vparam.removeAllElements();	--%>
<%--										vparam.add("2");//--%>
<%--										crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(--%>
<%--													"esp_dsp_season",vparam,"ScoreDB");--%>
<%--										vparam.removeAllElements();	--%>
<%--										if(crsObjSeason != null){	--%>
<%--											while(crsObjSeason.next()){	--%>
<%--								%>						--%>
<%--								<%if(crsObjSeason.getString("id").equalsIgnoreCase("2")){%>	--%>
<%--														<option value="<%=crsObjSeason.getString("id")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>--%>
<%--								<%}else{%>					--%>
<%--														<option value="<%=crsObjSeason.getString("id")%>" ><%=crsObjSeason.getString("name")%></option>	--%>
<%--												<%}%>--%>
<%--														--%>
<%--								<%			}--%>
<%--										 }--%>
<%--									   }catch(Exception e){--%>
<%--										log.writeErrLog(page.getClass(),matchId,e.toString());--%>
<%--									}--%>
<%--								%>	--%>
<%--	 						 </select>								 												--%>
<%--						</td>							--%>
<%--					</tr>--%>
				</table>
				</div>
			</td>	
		</tr>
		</table>	
		<br>
		<jsp:include page="Footer.jsp"></jsp:include>
		</form>		
	</body>
</html>