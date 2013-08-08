<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Player Registration</title>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
<Script>
	function submitForm(){
		var file = document.forms[0].fileUpload.value;
		if(file ==''){
			alert('Please select File to be uploaded');
			return false;
		}else{
			var fileSplit = file.split('.');
			if(fileSplit.length > 0 && (fileSplit[1] =='XLS'||fileSplit[1] =='xls' || fileSplit[1] == 'xlsx')){
				document.forms[0].submit();
			}else{
				alert('Please upload Excel File');
				return false;
			}
		}
	}
</Script>
</head>


<body>
<jsp:include page="Menu.jsp"></jsp:include>
<FORM ENCTYPE="multipart/form-data" ACTION="/cims/UploadPlayerProfiles" METHOD=POST>
<div class="leg">Player Registration</div>
<%--    Venue Master--%>
<div class="portletContainer">
	<table width="100%" border="0" align="center" cellpadding="2"
		cellspacing="1" >
		
		<tr class="contentDrak">
			
			<td><b>Select File :</b><INPUT NAME="fileUpload" TYPE="file"></td>
		</tr>
		<tr class="contentLight">
			<td><INPUT TYPE="button" VALUE="Upload" class="btn btn-warning" onclick="submitForm()"><input type="hidden" name="hdFilePath" value=""></td>
		</tr>
	</table>
</div>
</FORM>

<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>	