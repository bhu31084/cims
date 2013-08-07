<!--
Page Name 	 : MatchUserList.jsp
Created By 	 : Avadhut Joshi
Created Date : 12th Oct 2008
Description  : Displaying List of Match officials/Users
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"
%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.text.SimpleDateFormat"%>
<jsp:include page="../AuthZ.jsp"></jsp:include>
<% 
		response.setHeader("Pragma","private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
	  	Common commonUtil= new Common();
		String strfname	="";
		String strmname	="";
		String flag		="";		
		String strsname	="";
		String strorder	="";		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");	
		String 	GSFromDate			=	sdf.format(new Date());
		String 	GSToDate			=	sdf.format(new Date());
		String 	gsFromDate = "";
		String 	gsToDate = "";
		String 	gsConvertFromDate = "";
		String 	gsConvertToDate = "";
		String hdfromdate = request.getParameter("hdfromdate")==null?"":request.getParameter("hdfromdate");
		String hdtodate = request.getParameter("hdtodate")==null?"":request.getParameter("hdtodate");		
              		
		try{	
				CachedRowSet  userCachedRowSet		= null;
				CachedRowSet  teamsCachedRowSet		= null;				
				GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();										
				Vector vparam =  new Vector();					
				strfname = request.getParameter("hdFname");				
				strmname = request.getParameter("hdMname");	
				strorder = request.getParameter("hdOrder");
				if(strfname!=null){		
					vparam.add(strfname);
	                vparam.add(strmname);
	                vparam.add(commonUtil.formatDate(hdfromdate));	                	                                              
	                vparam.add(commonUtil.formatDate(hdtodate));	                
	                vparam.add(strorder);
	                System.out.println("strfname" +strfname);
	                System.out.println("strmname" +strmname);
	                System.out.println("hdfromdate" +hdfromdate);
	                System.out.println("hdtodate" +hdtodate);
	                System.out.println("strorder" +strorder);
	                userCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_matchusers",vparam,"ScoreDB");               								
	                vparam.removeAllElements();  	
                }
%>
<html>
  <head>
	<title>Match User List</title>
    <link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>    
    <script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
    <script>
    		function fnSearch(){
				document.getElementById('hdFname').value=document.getElementById('txtFname').value;
				document.getElementById('hdMname').value=document.getElementById('txtMname').value;
				document.getElementById('hdOrder').value=document.getElementById('cmbOrder').value;	
				document.getElementById("hdfromdate").value = document.getElementById("txtFromdate").value;
				document.getElementById("hdtodate").value = document.getElementById("txtTodate").value;															 	
				document.frmTeamPlayerMap.submit();	  	
    		}
    		
       	 // to change textfield color		
		function changeColour(which) {
			if (which.value.length > 0) {   // minimum 2 characters
				which.style.background = "#FFFFFF"; // white
			}
			else {
				which.style.background = "";  // yellow
			}
		}
    </script>
  </head>
  
<body>
	<jsp:include page="Menu.jsp"></jsp:include>
	<div style="clear:both;">&nbsp;</div>
<div class="leg">Match Users/Officials</div>
<%--    Venue Master--%>
<div class="portletContainer">

	<form name="frmTeamPlayerMap" id="frmTeamPlayerMap"  method="post">
	<input type="hidden" name="hdmatch_id" id="hdmatch_id" value="" />			
	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr >
			<td align="left" valign="top"  >			
				<fieldset id="fldsetMchTypeCategory" style="height: 150px;"> 
					<br/>
					<legend class="legend1">Match Search</legend>
					<table  border="0" align="center" style="border-top: 1cm; width:500px;" >					
						<tr align="center" class="contentDark">
	<%--					<td align="Center" nowrap="nowrap"><b>Match Id From:</b> <input type="hidden" name="hdmatch_id" id="hdmatch_id" value=""></td>	--%>
							<td  align="CENTER">
								<select id="cmbOrder" name="cmbOrder">
		<%--						<option value="0">-select order-</option>--%>
									<option value="1">Order by Match Id</option>						
									<option value="2">Order by Match Official</option>
								</select>
								<input type="hidden" name="hdOrder" id="hdOrder" value="">						
							</td>				
							<td align="Center" nowrap="nowrap" >Match Id From:<input type="hidden" name="hdmatch_id" id="hdmatch_id" value=""></td>	
							<td  align="CENTER">
								<input class="input" type="text" name="txtFname" id="txtFname" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,'0123456789');" >				
								<input type="hidden" name="hdFname" id="hdFname" value="">						
							</td>
							<td align="CENTER" nowrap="nowrap" >&nbsp;&nbsp;&nbsp;Match Id To:</td>					
							<td  align="CENTER">
								<input class="input" type="text" name="txtMname" id="txtMname"  onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,'0123456789 ');" >				
								<input type="hidden" name="hdMname" id="hdMname" value="">											
							</td>
						</tr>	
						<tr width="90%" class="contentLight">			
							<td colspan="2" align="right">From:			
								<%if(gsConvertFromDate != ""){%>			
									<a href="javascript:showCal('FrCalendarFrom','StartDate','txtFromdate','frmTeamPlayerMap')">
									<input type="text" size="8" class="textBoxAdminMatchSetup" name="txtFromdate" id="txtFromdate" readonly
									value="<%=gsConvertFromDate%>">
									<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" id="hdfromdate" name="hdfromdate" value="<%=hdfromdate%>">		
								<%}else {%>
				
									<a href="javascript:showCal('FrCalendarFrom','StartDate','txtFromdate','frmTeamPlayerMap')">
									<input type="text"  size="8" class="textBoxAdminMatchSetup" name="txtFromdate" id="txtFromdate" readonly
									value="<%=GSFromDate%>" >
									<IMG src="/cims/images/cal.gif" border="0" alt="" ></a>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" id="hdfromdate" name="hdfromdate" value="<%=hdfromdate%>">
								
								<%}%>
							</td>
							<td colspan="2" align="right">To :   			
								<%if(gsConvertToDate != ""){%>
								
									<a href="javascript:showCal('FrCalendarTo','EndDate','txtTodate','frmTeamPlayerMap')">
									<input type="text" size="8" class="textBoxAdminMatchSetup" name="txtTodate" id="txtTodate" readonly
										value="<%=gsConvertToDate%>">
									<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" id="hdtodate" name="hdtodate" value="<%=hdtodate%>">
								
								<%}else {%>
								
									<a href="javascript:showCal('FrCalendarTo','EndDate','txtTodate','frmTeamPlayerMap')">
									<input type="text" size="8" class="textBoxAdminMatchSetup" name="txtTodate" id="txtTodate" readonly
										value="<%=GSToDate%>">
									<IMG src="/cims/images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="hidden" id="hdtodate" name="hdtodate" value="<%=hdtodate%>">
								
								<%}%>
							</td>
							<td colspan="3">
								<input class="btn btn-warning" type="button" name = "btnSearch" id ="btnSearch" value= "Search" onclick="fnSearch()"> 
							</td>
						</tr>
						<tr><td colspan="5" align="left"> NOTE: Enter either Match Id or Date for search</td> <tr>
						
					</table>	
				</fieldset>
				<div id="divMessage" style="display: none; font-style: italic; color: blue;font-size: 15;font-weight: bold;clear: both;" align="left" >
				</div>
				<div style="clear:both;">&nbsp;</div>
				<table width="100%">
					<tr align="center" >				
						<td class="contentDark" align="center" colspan="7" ><font size="4" color="#8C86BD" > Match Users</font>
						<input type="hidden" name="hdmatch_id" id="hdmatch_id" value=""></td>						
					</tr>
					<tr class="contentDark">
						<td class="colheading">Match Id</td>				
						<td class="colheading">Nickname</td>									
						<td class="colheading">Display Name</td>					
						<td class="colheading">First Name</td>
						<td class="colheading">Middle Name</td>
						<td class="colheading">Surname</td>		
						<%--<td><b>Password</b></td>--%>
						<td class="colheading">Role Name</td>									
					</tr>			
	<%
				if(userCachedRowSet!=null){
					while(userCachedRowSet.next()){				
	%>	
					<tr style="border: 0" >
						<td><%= userCachedRowSet.getString("matchid") %></td>
						<td><%= userCachedRowSet.getString("nickname") %></td>					
						<td><%= userCachedRowSet.getString("displayname") %></td>					
						<td><%= userCachedRowSet.getString("fname") %></td>
						<td><%= userCachedRowSet.getString("mname") %></td>
						<td><%= userCachedRowSet.getString("sname") %></td>							
						<td><%= userCachedRowSet.getString("rolename") %></td>
	<%				}
	%>
					</tr>
	<%			}
	%>			
				</table>					
				</fieldset>			
			</td>
		</tr>		
	</table>
<%
	}catch(Exception e){
		e.printStackTrace();
		out.println(e);
	}
%>			
  </form> 
 </body>
 <br>
<jsp:include page="Footer.jsp"></jsp:include>	
</html>