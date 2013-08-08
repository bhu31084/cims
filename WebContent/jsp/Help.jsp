<!--
Page Name 	 : Under17.jsp
Created By 	 : Dipti Shinde.
Created Date : 17th Dec 2008
Description  : Under 17 report
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 17/12/2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
		String role;
		role = session.getAttribute("role").toString(); 
		//System.out.println(".....>"+role);
%>
<html>
<head>
<title>HELP</title>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link href="../css/adminForm.css" rel="stylesheet" type="text/css" />
<script>
function callHelp(id){
	
	//window.open("../helpdoc/CIMSReportsUserManual .pdf","HELP","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=200,left=100,width="+(window.screen.availWidth - 200)+",height="+(window.screen.availHeight - 200));
         //document.getElementById("frmHelp").action="PdfReport.jsp?ReportId=CALLRUM01";
         //document.getElementById("frmHelp").submit();
         	 if(id=="1"){
                 document.getElementById("frmHelp").action="/cims/jsp/PdfReport.jsp?ReportId=CFRUM01";   
                 document.getElementById("frmHelp").submit();
             }else if(id=="2"){
                 document.getElementById("frmHelp").action="/cims/jsp/PdfReport.jsp?ReportId=CCAPRUM01";   
                 document.getElementById("frmHelp").submit();
             }else if(id=="3"){
                 document.getElementById("frmHelp").action="/cims/jsp/PdfReport.jsp?ReportId=CREFRUM01";   
                 document.getElementById("frmHelp").submit();
             }else if(id=="4"){
                 document.getElementById("frmHelp").action="/cims/jsp/PdfReport.jsp?ReportId=CUCRUM01";   
                 document.getElementById("frmHelp").submit();
             }else if(id=="5"){
                 document.getElementById("frmHelp").action="/cims/jsp/PdfReport.jsp?ReportId=CURUM01";   
                 document.getElementById("frmHelp").submit();
             }else if(id=="6"){
                 document.getElementById("frmHelp").action="/cims/jsp/PdfReport.jsp?ReportId=CALLRUM01";   
                 document.getElementById("frmHelp").submit();
             }else if(id=="7"){
                 document.getElementById("frmHelp").action="/cims/jsp/PdfReport.jsp?ReportId=CMOBUM01";   
                 document.getElementById("frmHelp").submit();
             }
}
</script>
</head>
	<body>
	<jsp:include page="Menu.jsp"></jsp:include>
		<form name="frmHelp" id="frmHelp" method="post">		
			<br>
			<table width="910" border="0" align="center" cellpadding="2"
				cellspacing="1" class="table">
				
<%					if(role.equalsIgnoreCase("4") || role.equalsIgnoreCase("2") || role.equalsIgnoreCase("6") || role.equalsIgnoreCase("9")){
%>				
				<tr align="center">
					 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">User Manuals
				     </td>
				</tr>
				<tr>
					<td>
						<fieldset><legend class="legend1"></legend> <br>
							<table width="90%" border="0" align="center" cellpadding="2"
								cellspacing="1" class="table" >
										
						                <tr width="90%" class="contentDark">
											<td>
<%					if(role.equalsIgnoreCase("4") || role.equalsIgnoreCase("2") || role.equalsIgnoreCase("6")){
%>												<center><font size="3" color="#8C86BD">Click on following link to view the user manual.</font></center>			
<%					}else{%>
												<center><font size="3" color="#8C86BD">Click on following links to view the user manuals.</font></center>
<%					}
%>												
											</td>
										</tr>
<%					}
%>				
				<tr class="contentLight">
					<td align="center">
						<table>
<%			if(role.equalsIgnoreCase("4")){
%>
							<tr class="contentLight">
								<td><a  href="javascript:callHelp('3')"><u>Referee's Feedback Manual</u></a>
								</td>
								<td>Document of referee's reports.
								</td>
							</tr>
<%			}else if(role.equalsIgnoreCase("2")){
%>							
							<tr class="contentLight">
								<td><a  href="javascript:callHelp('5')"><u>Umpire Manual</u></a>	
								</td>
								<td>Document of umpire reports.
								</td>
							</tr>
<%			}else if(role.equalsIgnoreCase("6")){
%>							
							<tr class="contentLight">
								<td><a  href="javascript:callHelp('4')"><u>Umpire Coach Manual</u></a>
								</td>
								<td>Document of umpire coach reports.
								</td>
							</tr>
<%			}else if(role.equalsIgnoreCase("9")){		%>							
							
							<tr class="contentLight">
								<td><a  href="javascript:callHelp('2')"><u>Captains Reports Manual</u></a>
								</td>
								<td>Document of captains reports.
								</td>
							</tr>
							<tr class="contentLight">
								<td><a  href="javascript:callHelp('3')"><u>Referee's Feedback Manual</u></a>
								</td>
								<td>Document of referee's reports.
								</td>
							</tr>
							<tr class="contentLight">
								<td><a  href="javascript:callHelp('4')"><u>Umpire Coach Manual</u></a>
								</td>
								<td>Document of umpire coach reports.
								</td>
							</tr>
							<tr class="contentLight">
								<td><a  href="javascript:callHelp('5')"><u>Umpire Manual</u></a>	
								</td>
								<td>Document of umpire reports.
								</td>
							</tr>
							<tr class="contentLight">
								<td><a  href="javascript:callHelp('6')"><u>All Users Reports Manual</u></a>
								</td>
								<td>Document of reports which are accessible to all users.
								</td>
							</tr>
							<tr class="contentLight">
								<td><a  href="javascript:callHelp('1')"><u>Feedback Reports Manual</u></a>
								</td>
								<td>Document of all reports.
								</td>
							</tr>
							<tr class="contentLight">
								<td><a  href="javascript:callHelp('7')"><u>Mobile Pages Manual</u></a>
								</td>
								<td>Document of mobile pages.
								</td>
							</tr>
<%				}
%>					
							<tr class="contentLight">
								<td><a  href="/cims/jsp/SiteMap.jsp"><u>Site Map</u></a>
								</td>
								<td>Site Map
								</td>
							</tr>		
						</table>

					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				
				<tr width="90%" class="contentDark">
		 			<td align="left">						
						NOTE : Depending upon the speed of the connection,
						It may take some couple of minutes to download the file.
						
					</td>
				</tr>
				
			</table>
			
		</form>	
	</body>
</html>					