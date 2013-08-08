<!--
	Author 		 : Dipti Shinde
	Created Date : 23/03/2009
	Description  : SMS Approval report disply .
	Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
	CachedRowSet seasonListCrs = null;
	CachedRowSet seriesListCrs = null;
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String 	currentDate	 = sdf.format(new Date());
	String fromDate = null;
	String toDate = null;
	GenerateStoreProcedure generateStProc = new GenerateStoreProcedure();
	Vector spParaVec = new Vector();
	
	try{
		spParaVec.add("");
		seasonListCrs = generateStProc.GenerateStoreProcedure("esp_dsp_seasonlist", spParaVec, "ScoreDB");
		spParaVec.removeAllElements();	
	}catch(Exception e){
		 e.printStackTrace();
		 out.println(e);
	}
	
	try {
		seriesListCrs = generateStProc.GenerateStoreProcedure("esp_dsp_getseriestypes", spParaVec, "ScoreDB");
		spParaVec.removeAllElements();	

	} catch (Exception e) {
		e.printStackTrace();
		out.println(e);
	}
%>	
<html>
	<head>
		<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
		<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
		<title>SMS Approval</title>
		<script>
		function GetXmlHttpObject() {
	        var xmlHttp = null;
	        try{
	            // Firefox, Opera 8.0+, Safari
	            xmlHttp = new XMLHttpRequest();
	        }
	        catch (e){
	            // Internet Explorer
	            try{
	                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
	            }
	            catch (e){
	                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	            }
	        }
	        return xmlHttp;
	    }
      
		function callSearch(){
			var accFlag = document.getElementById("selAccFlag").value
		  	document.getElementById("hidAccFlag").value = accFlag
			try {
	           xmlHttp = this.GetXmlHttpObject();
	     	  if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	          }else{
           		  var url = "/cims/jsp/admin/SMSApprovalResponce.jsp?accFlag="+accFlag
			      xmlHttp.onreadystatechange = receiveSMSResponse
	          	  xmlHttp.open("post", url, false);
			   	  xmlHttp.send(null);
		   	  }
		   	} catch(err) {
	           	alert(err.description + 'callSearch()');
	        }
		}
		
		function receiveSMSResponse(){
			 if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                try {
                   var responseResult = xmlHttp.responseText ;
            	   document.getElementById('divSMSApproval').innerHTML = responseResult
            	   document.getElementById('divSMSApproval').style.display = ''
                } catch(err) {
                    alert(err.description + 'ajex.js.receiveSMSResponse()');
                }
            }
		}
     
		</script>
	</head>
	<body>
		<jsp:include page="Menu.jsp"></jsp:include>
			<form action="" name="frmSMSApproval" id="frmSMSApproval" method="post">
			<br><br><br>
				<table width="90%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
					<tr align="center">
						 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">
					                SMS Report
					     </td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" align="center" cellpadding="2"
							cellspacing="1" class="table" >
								<tr class="contentDark">
								<td>
									Acceptance Flag : 
									<select id="selAccFlag" name="selAccFlag">
										<option value="">All</option>
										<option value="A">Y</option>
										<option value="R">N</option>
										<option value="P">Pending</option>
									</select>
									&nbsp;&nbsp;&nbsp;
									<input class="button1" id="btnSearch" name="btnSearch" type="button" value="Search" onclick="callSearch()"/>
								</td>
								</tr>
								<tr>
									<td>
										&nbsp;
									</td>
								</tr>
								<tr>
									<td>
										<div id="divSMSApproval" name="divSMSApproval" align="center" style="display:none;align:center;overflow:auto;left:500px;top:150px;width:900px;height:350px">
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<br>
				<input type="hidden" id="hidAccFlag" name="hidAccFlag" value="">
			</form>
		<br><br><br><br>
		<jsp:include page="Footer.jsp"></jsp:include>
	</body>
</html>	
