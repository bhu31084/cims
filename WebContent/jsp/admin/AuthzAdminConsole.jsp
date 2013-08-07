<!--
PageName	 : AuthzAdminConsole.jsp
Author 		 : Saudagar Mulik
Created Date : 13th Nov, 2008
Description  : UI for authorization framework.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="in.co.paramatrix.common.exceptions.*"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.common.authz.AuthZ"%>
<jsp:include page="Menu.jsp"></jsp:include>
<%
		AuthZ authz = AuthZ.getInstance();
		Vector<String> vRoles = authz.getAllRoles();
%>
<html>
<head>
<title>Admin Console</title>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />

<Script>
	var url = '';
	function setOps(){
		var eleObjArr = document.getElementById('user').options;
		for(var i=0;i< eleObjArr.length;i++){
			if(eleObjArr[i].selected){
				document.getElementById('hidOps').value = document.getElementById('hidOps').value + eleObjArr[i].text + '~'
			}
		}
		menuform.submit();
	}

	function setValue(){
		document.getElementById('hidOps').value = document.getElementById('txtuser').value;
		alert(document.getElementById('hidOps').value);		
		menuform.submit();
	}

	function GetXmlHttpObject(){
		var xmlHttp=null;
		try{
			xmlHttp=new XMLHttpRequest();
		}catch (e){
			try{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}catch (e){
	           	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		
		return xmlHttp;
	}

	function getOperations(role_name){
		if(role_name == 0){
			alert('Select role');
		} else {
			xmlHttp = GetXmlHttpObject();
			if (xmlHttp==null){
				alert ("Browser does not support HTTP Request");
		        return;
			}else{
		    	url="../response/ResponseAuthzAdminConsole.jsp?role=" + role_name;
				xmlHttp.onreadystatechange = stChgOffenceResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			}
		}
	}

	function mapEntities(role_name, entities, isUser, isMap){
		if(role_name == 0){
			alert('Select role');
		} else {
			xmlHttp = GetXmlHttpObject();
			if (xmlHttp==null){
				alert ("Browser does not support HTTP Request");
		        return;
			}else{
		    	url="../response/ResponseAuthzAdminConsole.jsp?role=" + role_name +"&entities="+entities+"&isMap=" + isMap+"&isUser=" + isUser;
				xmlHttp.onreadystatechange = stChgOffenceResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			}
		}
	}
	
	function moveData(lstBoxFrom, isUser, isAll, isMap, role_name){		
	
		var len = lstBoxFrom.length;				
		var entities = '';
		if(isAll) {
			for(var i = 0; i < len; i++) {
				entities = entities + lstBoxFrom[i].value + ",";
			}
		} else {
			for(var i = 0; i < len; i++) {
				if(lstBoxFrom[i].selected){
					entities = entities + lstBoxFrom[i].value + ",";
				}
			}
		}
		if(entities != ''){
			mapEntities(role_name, entities, isUser, isMap);
		} else {
			alert('Please select data to move');
		}
	}

	function stChgOffenceResponse(){
		if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete"){
			var responseResult = xmlHttp.responseText;
			fillValues(responseResult);
		}
	}
	
	function fillValues(values){
	
		for(var i =  frmRole.authOps.options.length -1; i >= 0; i--){
			frmRole.authOps.options[i] =  null;
		}
				
		for(var i = frmRole.nonauthOps.options.length -1 ; i >= 0; i--){
			frmRole.nonauthOps.options[i] =  null;
		}
		
		for(var i = frmRole.authUsers.options.length -1 ; i >= 0; i--){
			frmRole.authUsers.options[i] =  null;
		}
		
		for(var i = frmRole.nonauthUsers.options.length -1 ; i >= 0; i--){
			frmRole.nonauthUsers.options[i] =  null;
		}
		
		var arrValues = values.split('|');
		var arrAuthOps = '';
		var arrNonauthOps = '';		
		var arrAuthUsers = '';
		var arrUnauthUsers = '';
		
		if(arrValues[0] != null && arrValues[0] != ''){
			arrAuthOps = arrValues[0].split(',');
			for(var i = 0; i < arrAuthOps.length; i++){
				if(arrAuthOps[i]!='' && arrAuthOps[i]!=null){
					frmRole.authOps.options[frmRole.authOps.options.length] = new Option(arrAuthOps[i], arrAuthOps[i]);
				}
			}			
		}
		
		if(arrValues[1] != null && arrValues[1] != ''){
			arrNonauthOps = arrValues[1].split(',');
			for(var i = 0; i < arrNonauthOps.length; i++){
				if(arrNonauthOps[i]!='' && arrNonauthOps[i]!=null){
					frmRole.nonauthOps.options[frmRole.nonauthOps.options.length] = new Option(arrNonauthOps[i], arrNonauthOps[i]);
				}
			}			
		}
		
		if(arrValues[2] != null && arrValues[2] != ''){
			arrAuthUsers = arrValues[2].split(',');
			for(var i = 0; i < arrAuthUsers.length; i++){
				if(arrAuthUsers[i] != '' && arrAuthUsers[i] != null){
					frmRole.authUsers.options[frmRole.authUsers.options.length] = new Option(arrAuthUsers[i], arrAuthUsers[i]);
				}
			}
		}
		
		if(arrValues[3] != null && arrValues[3] != ''){
			arrUnauthUsers = arrValues[3].split(',');
			for(var i = 0; i < arrUnauthUsers.length; i++){
				if(arrUnauthUsers[i] != '' && arrUnauthUsers[i] != null){
					frmRole.nonauthUsers.options[frmRole.nonauthUsers.options.length] = new Option(arrUnauthUsers[i], arrUnauthUsers[i]);
				}
			}
		}
		
	}
	// to change textfield color		
		function changeColour(which) {
			if (which.value.length > 0) {   // minimum 2 characters
				which.style.background = "#FFFFFF"; // white
			}
			else {
				which.style.background = "";  // yellow
				//alert ("This box must be filled!");
				//which.focus();
				//return false;
			}
		}

</Script>
</head>
<body>

<form name="frmRole" id="frmRole" method="post">
<%--	<FIELDSET style="width: 975px; height: 450px;" title="Assigning users/operations to role.">--%>
<%--		<LEGEND><B>Role</B></LEGEND>--%>

		<div style="clear:both">&nbsp;</div>
		<fieldset style="width: 975px; height: 450px;"><legend class="legend1">Role </legend> 
		
		<TABLE width="100%" align="center">
			<tr align="center" class="contentDark">
				
				<TD>
					<SELECT class="inputField" name="cmbRole" title="Roles" style="width: 150px;"
						onchange="getOperations(cmbRole.value)">
						<OPTION value="0" title="Select role">- Select role -</OPTION>
						<%for (String role : vRoles) {%>
						<OPTION value="<%=role%>" title="Role name : <%=role%>"><%=role.toUpperCase()%></OPTION>
						<%}%>
					</SELECT>
				</TD>
<%--				<TD>&nbsp; &nbsp; &nbsp; --%>
<%--					<INPUT type="button" value="Add Role" onclick="alert('Added new role.')">--%>
<%--				</TD>--%>
			</TR>
		</TABLE>
		
		
		
		<table width="100%" border="1">
			<TR>
				<TD>		
					<FIELDSET style="width: 480px; height: 310px;" title="Assigning operations to role.">
						<LEGEND class="legend1">Role operation mapping</LEGEND> <BR>
						
						<TABLE align="center" width="95%" border="1">
							<tr>
								<TH width="43%" class="contentDark">Authorized</TH>
								<TH></TH>
								<TH width="43%" class="contentDark">Unauthorized</TH>
							</TR>
							<TR>
								<Td align="center">
									<SELECT class="inputField" name="authOps" id="authOps"
										multiple="multiple" size="15" style="width: 100%;"
										title="Assigned operations">
									</SELECT>
								</Td>
								<Td align="center">
								<INPUT class="button1" type="button" value=">>>"
									title="Remove all operations."
									onclick="moveData(authOps, false, true, false, cmbRole.value)"> 
								<BR>
								<BR>
								<BR>
								<BR>
								<INPUT class="button1" type="button" value=" -> "
									title="Remove selected operations."
									onclick="moveData(authOps, false, false, false, cmbRole.value)"> 								
								<BR>
								<INPUT class="button1" type="button" value=" <- "
									title="Assign selected operations."
									onclick="moveData(nonauthOps, false, false, true, cmbRole.value)">
								<BR>
								<BR>
								<BR>
								<BR>
								<INPUT class="button1" type="button" value="<<<" title="Assign all operations."
									onclick="moveData(nonauthOps, false, true,  true, cmbRole.value)"></Td>
								<Td align="center"><SELECT class="inputField" name="nonauthOps" id="nonauthOps"
									multiple="multiple" size="15" style="width: 100%;"
									title="Not assigned operations">
								</SELECT></Td>
							</TR>
						</TABLE>
						<br>
					</FIELDSET>
		
				</TD>
		
				<TD>
				<FIELDSET style="width: 480px; height: 310px;"
					title="Assigning users to role.">
					<LEGEND class="legend1">Role user mapping</LEGEND>
				<BR>
				<TABLE align="center" width="95%" border="1">
					<tr  >
						<TH width="43%" class="contentDark">Authorized</TH>
						<TH></TH>
						<TH width="43%" class="contentDark">Unauthorized</TH>
					</TR>
					<TR>
						<Td align="center">
							<SELECT class="inputField" name="authUsers" id="authUsers"
								multiple="multiple" size="15" style="width: 100%;"
								title="Authorized users">
							</SELECT>
						</Td>
						<Td align="center">
							<INPUT class="button1" type="button" value=">>>" title="Unauthorized all users"
								onclick="moveData(authUsers, true, true, false, cmbRole.value)"> 
							<BR>
							<BR>
							<BR>
							<BR>
							<INPUT class="button1" type="button" value=" -> " title="Unauthorized selected users"
								onclick="moveData(authUsers, true, false, false, cmbRole.value)">
							<BR>
							<INPUT class="button1" type="button" value=" <- " title="Authorized selected users"
								onclick="moveData(nonauthUsers, true, false, true, cmbRole.value)">
							<BR>
							<BR>
							<BR>
							<BR>
							<INPUT class="button1" type="button" value="<<<" title="Authorized all users"
								onclick="moveData(nonauthUsers, true, true, true, cmbRole.value)">
						</Td>
						<Td align="center">
							<SELECT class="inputField" name="nonauthUsers" id="nonauthUsers"
								multiple="multiple" size="15" style="width: 100%;"
								title="Unauthorized users">
							</SELECT>
						</Td>
					</TR>
				</TABLE>
				<BR>
			</FIELDSET>
			</TD>
		</TR>
	</table>
	
	<BR>
	<BR>

</FIELDSET>
</form>
</body>
<jsp:include page="Footer.jsp"></jsp:include>
</html>

