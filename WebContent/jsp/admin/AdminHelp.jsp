<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>

<html>
<head>
<title>ADMIN HELP</title>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
<script>
	function Report(id){
		 document.getElementById("frmHelp").action="/cims/jsp/PdfReport.jsp?ReportId="+id;
         document.getElementById("frmHelp").submit();
	}
</script>
</head>
	<body>
	<jsp:include page="Menu.jsp"></jsp:include>
		<form name="frmHelp" id="frmHelp" method="post">
		<br><br><br>
			<table width="800" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
				<tr align="center">
					 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">User Manuals</td>
				</tr>
				<tr>
					<td>
						<fieldset><legend class="legend1"></legend> <br>
							<table width="90%" border="0" align="center" cellpadding="2"
								cellspacing="1" class="table" >
									<tr width="90%" class="contentDark">
										<td>
											<center><font size="3" color="#8C86BD">Click on following links to view the user manuals.</font></center>
										</td>
									</tr>
									<tr class="contentLight">
										<td align="center">
											<table>
												<tr class="contentLight">
													<td><a  href="javascript:Report('AUM01')"><u>Admin Manual</u></a>
													</td>
													<td align="left">Document of all admin forms.
													</td>
												</tr>
												<tr class="contentLight">
													<td><a  href="javascript:Report('CSUM01')"><u>Score Module Manual</u></a>
													</td>
													<td align="left">Document of scoring.
													</td>
												</tr>
												<tr class="contentLight">
													<td><a  href="javascript:Report('CCAPRUM01')"><u>Captains Reports Manual</u></a>
													</td>
													<td align="left">Document of captains reports.
													</td>
												</tr>
												<tr class="contentLight">
													<td><a  href="javascript:Report('CREFRUM01')"><u>Referee's Feedback Manual</u></a>
													</td>
													<td align="left">Document of referee's reports.
													</td>
												</tr>
												<tr class="contentLight">
													<td><a  href="javascript:Report('CUCRUM01')"><u>Umpire Coach Manual</u></a>
													</td>
													<td align="left">Document of umpire coach reports.
													</td>
												</tr>
												<tr class="contentLight">
													<td><a  href="javascript:Report('CURUM01')"><u>Umpire Manual</u></a>	
													</td>
													<td align="left">Document of umpire reports.
													</td>
												</tr>
												<tr class="contentLight">
													<td><a  href="javascript:Report('CALLRUM01')"><u>All Users Reports Manual</u></a>
													</td>
													<td>Document of reports which are accessible to all users.
													</td>
												</tr>
												<tr class="contentLight">
													<td><a  href="javascript:Report('CFRUM01')"><u>Feedback Reports Manual</u></a>
													</td>
													<td align="left">Document of all reports.
													</td>
												</tr>
												<tr class="contentLight">
													<td><a  href="javascript:Report('CMOBUM01')"><u>Mobile Pages Manual</u></a>
													</td>
													<td align="left">Document of mobile pages.
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
						</fieldset>
					</td>	
				</tr>
			</table>
			<jsp:include page="Footer.jsp"></jsp:include>	
		</form>	
	</body>
</html>					