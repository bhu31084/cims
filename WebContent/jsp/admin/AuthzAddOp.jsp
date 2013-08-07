<!--
PageName	 : AuthzAdminConsole.jsp
Author 		 : Vishwajeet Khot
Created Date : 25th Oct 2008
Description  : Mapping users with roles
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="in.co.paramatrix.common.exceptions.*"%>
<%@ page import="in.co.paramatrix.common.exceptions.InternalError"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<jsp:include page="Menu.jsp"></jsp:include>
<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
		String serverRemark = null;
		String remark = null;

		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		CachedRowSet lobjCachedRowSet = null;
		Vector vparam = null;

		in.co.paramatrix.common.authz.AuthZ authz = in.co.paramatrix.common.authz.AuthZ.getInstance();

		if (request.getMethod().equalsIgnoreCase("POST")) {
			String ops[] = request.getParameter("hidOps").split("~");			
			String role = request.getParameter("role");
			Vector vOps = new Vector();
			
			for(int i = 0; i < ops.length; i++){
				vOps.add(ops[i]);
				try{
					authz.addOp(ops[i]);
				}catch(Exception e){
					out.println(e);
				}
			}
//NoEntity,
//			InternalError, EntityDestroyed, InvalidEntity, LimitCrossed
			try{
				authz.addOpsToRole(vOps, role);
				
			}catch(NoEntity e){
				out.println(e);
			}catch(LimitCrossed e){
				out.println(e);
			}catch(InternalError e){
				out.println(e);
			}catch(EntityDestroyed e){
				out.println(e);
			}catch(InvalidEntity e){
				out.println(e);
			}catch(Exception e){			
				out.println(e);
			}
		}
		%>
<html>
<head>
<Script>
	
	function setOps(){
		var eleObjArr = document.getElementById('op').options;
		for(var i=0;i< eleObjArr.length;i++){
			if(eleObjArr[i].selected){
				document.getElementById('hidOps').value = document.getElementById('hidOps').value + eleObjArr[i].text + '~'
			}
		}
		menuform.submit();
	}

	function setValue(){
		document.getElementById('hidOps').value = document.getElementById('txtop').value;
		alert(document.getElementById('hidOps').value);
		
		menuform.submit();
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


<title>Admin Console</title>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
</head>
<body>
<br>
<FORM name="menuform" id="menuform" method="post"><br>
<br><br>
<table width="780" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
<tr align="center">
	 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">
		Admin Console
		</TD>
	</TR>
	<TR>
		<TD>
<%--		<fieldset id="fldsetvenue"><legend> <font size="3" color="#003399"><b>Admin--%>
<%--		Console</b></font> </legend> <br>--%>
		<fieldset><legend class="legend1">Admin Console
				</legend> <br>
		<table width="90%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table" >
			<tr align="left" class="contentDark">
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Role Name :</TD>
				<TD><SELECT name="role" id="role">
					<%vparam = new Vector();
		lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("getAuthzRoles", vparam, "ScoreDB");
		while (lobjCachedRowSet.next()) {%>
					<OPTION value="<%=lobjCachedRowSet.getString("name")%>"><%=lobjCachedRowSet.getString("name")%></OPTION>
					<%}%>
				</SELECT></TD>
			</TR>
			<tr width="90%" class="contentLight">
				<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Operation Name</TD>
				<%Vector<String> ops = authz.getAllOps();%>
				<TD><select name="op" id="op" multiple="multiple" size="17">
					<%for (String op : ops) {
			if (!op.equals("")) {
				%>
					<option value="<%=op.trim()%>"><%=op.trim()%></option>
					<%}
		}%>
				</select></TD>
			<tr align="left" class="contentDark">
				<td colspan="2" align="center"><INPUT type="text" name="txtop"></td>
			</TR>
			<tr width="100%" align="right" class="contentLight">
			
				<TD colspan="2" height="24"><input class="button1" align="left" type="button" id="btnsubmit"
					name="btnsubmit" value="Map ops" onclick="setOps()" /> <input
					class="button1" align="left" type="button" id="btnsubmit"
					name="btnsubmit" value="Add&mapop  " onclick="setValue()" /></TD>
		
			</TR>
			</TABLE>
		<br>
		</fieldset>
		</TD>
	</TR>
	
</table>
<INPUT type="hidden" name="hidOps" id="hidOps"> <br>
<br>
<%
		if (serverRemark != null && !serverRemark.equals("null")) {
			System.out.println(serverRemark);

			%> <font color=red><%=serverRemark%></font> <%
		}
	%></form>
</body>
<jsp:include page="Footer.jsp"></jsp:include>
</html>