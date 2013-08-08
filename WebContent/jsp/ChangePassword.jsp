<!--
Page Name    : ChangePassword.jsp	
Created By 	 : Archana Dongre.
Created Date : 19th oct 2008
Description  : Used to change the users password.
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"
%>

<%  String userName = request.getParameter("userName")==null?"":request.getParameter("userName");
	String prePassword = request.getParameter("prePass")==null?"":request.getParameter("prePass");	
	CachedRowSet  crsObjChgPassword = null;
	Vector vparam =  new Vector();
	String retval = null;
	String message = "";
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

	String oldPass = request.getParameter("PassPre")==null?"":request.getParameter("PassPre");
	String userId = request.getParameter("txtloginId")==null?"":request.getParameter("txtloginId");
	String newPass = request.getParameter("passnewPW")==null?"":request.getParameter("passnewPW");	
	if(request.getParameter("hiddenSubmit")!=null && request.getParameter("hiddenSubmit").equalsIgnoreCase("submit")){	
		try{
				vparam.add(userId);
				vparam.add(newPass);										
				crsObjChgPassword = lobjGenerateProc.GenerateStoreProcedure(
					"esp_amd_password_change",vparam,"ScoreDB");
				vparam.removeAllElements();
				if(crsObjChgPassword != null){
					while(crsObjChgPassword.next()){
					retval = crsObjChgPassword.getString("RetVal");								
					}
				}				
		}catch(Exception e){
				e.printStackTrace();
		}		
	}					
%>
<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">	  
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">    
	<SCRIPT LANGUAGE=javascript>
		function catchEnter(e) {
			if (!e) var e = window.event;
			if (e.keyCode) code = e.keyCode;
			else if (e.which) code = e.which;
			if (code==13) {
				submitForm();
			}
		}				
		function setFocus(){
			document.getElementById('passnewPW').focus();
		}						

		function submitForm(){
			var newpass = document.getElementById("passnewPW").value
			var userId = document.getElementById("txtloginId").value
			var oldPass = document.getElementById("PassPre").value									
			if(document.getElementById("passnewPW").value == ""){
				alert("Please Insert New PassWord!")
				return false;
			}else if(document.getElementById("passconfirmPW").value == ""){
				alert("Please Insert Confirm PassWord!")
				return false;
			}else if(document.getElementById("PassPre").value == document.getElementById("passconfirmPW").value){
				alert("Please Choose New PassWord Other Than Old Password!")
				return false;
			}else if(document.getElementById("PassPre").value == document.getElementById("passnewPW").value){
				alert("Please Choose Confirm PassWord Other Than Old Password!")		
				return false;
			}else if(document.getElementById("passnewPW").value != document.getElementById("passconfirmPW").value){
				alert("New PassWord And Confirn Password Should Be Same!");
				return false;
			}else{					
				document.getElementById("hiddenSubmit").value = "submit"; 						
				var hiddenSubmit = document.getElementById("hiddenSubmit").value;
				document.changePass.action ="/cims/jsp/ChangePassword.jsp?hiddenSubmit="+hiddenSubmit;																														
				document.changePass.submit();
				alert("Your Password Has Been Changed Please Login Now Using New Password!!!");												
				window.opener.location.reload();
				window.close();						
			}
		}
	</SCRIPT>
</head>
<body onload="setFocus()">
	<center>
		<form method="post" id="changePass" name="changePass" onkeypress="catchEnter(event)">
			<table width="100%" border="0" class="signup"  align="center">
				<tr> 
					<td colspan="3" align="center" style="background-color:gainsboro;"><font size="4" color="#003399"> Change Password For First Time Login </font>
					</td>
				</tr>
				<tr><td colspan="2"><hr></td></tr>
				<tr>
					<td align="center">
						<b><font color="red">Login Id :</font><b>
					</td>
					<td align="center">
						<INPUT type="text" name="txtloginId" id="txtloginId" size="15" value="<%=userName%>" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<td align="center"><b><font color="red">Previous Password :</font><b></td>
					<td align="center">
						<INPUT type="password" name="PassPre" id="PassPre" size="15" value="<%=prePassword%>" readonly="readonly" />
						<INPUT type="hidden" name="hdPassPre" id="hdPassPre" value="" />
 					</td>
					</tr>
					<tr>
						<td align="center"><b><font color="red">New Password :</font><b></td>
						<td align="center">
							<INPUT type="password" name="passnewPW" id="passnewPW" size="15" />
							<INPUT type="hidden" name="hdpassnewPW" id="hdpassnewPW" value="" />
 						</td>
					</tr>
					<tr>
						<td align="center"><b><font color="red">Confirm Password :</font><b></td>
						<td align="center">
							<INPUT type="password" name="passconfirmPW" id="passconfirmPW" size="15"/>
							<INPUT type="hidden" name="hdpassconfirmPW" id="hdpassconfirmPW" value="" />
 						</td>
					</tr>
					<tr><td colspan="2"><hr></td></tr>
					<tr>
						<td align="center" colspan="2">
							<INPUT type="button" id="btnsubmit" value="Submit" onclick="submitForm()"></INPUT>
							<INPUT type="hidden" id="hiddenSubmit" value=""></INPUT>																			
						</td>
					</tr>
				</table>
			</form>
</body>
</html>