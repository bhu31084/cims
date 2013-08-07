<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Match upload summary</title>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
</head>
<body>
<jsp:include page="Menu.jsp"></jsp:include>
<br>

<FORM ENCTYPE="multipart/form-data" ACTION="/cims/UploadMatchSchedules" METHOD=POST>
<%
session.setAttribute("LoginPage","/cims/web/jsp/login.jsp");
	Map returnMap = null;
	Map errorMap = null;
	List duplicateRecord = null;
	List newRecord = null;
	
	String strFileError = null;
	String column = null;
	String[] columns = null;
	int headerSize = 0;
	if(session.getAttribute("column") != null){
		column = (String)session.getAttribute("column");
		columns = column.split(",");
		headerSize = columns.length;
	}
	if(session.getAttribute("returnMap") != null){
		returnMap = (Map) session.getAttribute("returnMap");
		if(returnMap.get("FileError") != null){
			strFileError = (String) returnMap.get("FileError");	
		}
		if(returnMap.get("Error") != null){
			errorMap = (Map) returnMap.get("Error");	
		}
		if(returnMap.get("duplicateRecord") != null){
			duplicateRecord=(List) returnMap.get("duplicateRecord");	
		}
		if(returnMap.get("newRecord") != null){
			newRecord = (List) returnMap.get("newRecord");	
		}
	}
	session.removeAttribute("returnMap");
	session.removeAttribute("column");
%> 
<Br><Br><Br>
<table width="100%" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
		<tr class="contentLight">
			<td colspan="2">
			<Center><B> Upload Match Schedule Report </B> </Center>
			</td>
		</tr>
		
<% if(strFileError != null){ %>
		<tr class="contentDark"> <td colspan="2"> <%=strFileError %> </td> </tr>
<%} if(errorMap != null && errorMap.size() > 0){
	%>
	<tr class="contentLight">
		<td colspan="4"> Errors in File while uploading data</td>
	</tr>
	<tr class="contentDark">
		<td colspan="4"> 
			<TABLE border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
	<%Set<Integer> keySet = errorMap.keySet();
	Iterator<Integer> iter = keySet.iterator();
	while (iter.hasNext()) {
		int lineNo = iter.next();
		List<String> errorList = (List<String>) errorMap.get(lineNo);
		%>
		<tr class="contentLight"> 
			<th width = "10%"> Line No</th>
			<th> Error Description</th>
		</tr>
		<%
		for (int i = 0; i < errorList.size(); i++) {
%>
		<tr class="contentDark">
			<td> <%=lineNo %></td>
			<td> <%=errorList.get(i) %></td>
		</tr>

<% 		}
	}%>				
			</TABLE>
		</td>
	</tr>		
<%} if(duplicateRecord!= null && duplicateRecord.size()>0){
%>
	<tr class="contentLight">
		<td colspan="4">Duplicate Records found</td>
	</tr>
	<tr class="contentDark">
		<td colspan="4"> 
			<TABLE border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
				<TR>
			<%  for (int headerCount = 0; headerCount < headerSize; headerCount++) { %>
					<TH> <%= columns[headerCount] %></TH>
			<%}%>
				</TR>
	<%
	for (int i = 0; i < duplicateRecord.size(); i++) {
		Map<String, String> duplicateEntryMap = (Map<String, String>) duplicateRecord.get(i);%>
		<tr class="contentLight"> <td> <%=(i+1) %></td>
		<% for (int headerCount = 1; headerCount < headerSize; headerCount++) {%>
			<TD>
				<%=duplicateEntryMap.get(columns[headerCount])%>
			</TD>
		<%} %>
		</tr> 
	<%}
		%>

			</TABLE>
		</td>
	</tr>	
<%} System.out.println("newRecord.size()----"+ newRecord);
	if(newRecord != null && newRecord.size()>0){
	System.out.println("newRecord.size()----"+ newRecord.size());
%>
	<tr class="contentLight">
		<td colspan="4">New Records inserted</td>
	</tr>
	<tr class="contentLight">
		<td colspan="4"> 
			<TABLE border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
				<TR class="contentLight">
			<%  for (int headerCount = 0; headerCount < headerSize; headerCount++) { %>
					<TH> <%= columns[headerCount] %></TH>
			<%}%>
				</TR>
	<%
	for (int i = 0; i < newRecord.size(); i++) {
		Map<String, String> newEntryMap = (Map<String, String>) newRecord.get(i);%>
		<tr> <td> <%=(i+1) %></td>
		<%for (int headerCount = 1; headerCount < headerSize; headerCount++) {%>
			<TD>
				<%=newEntryMap.get(columns[headerCount])%>
			</TD>
		<%} %>
		</tr> 
	<%}
		%>

			</TABLE>
		</td>
	</tr>	
<%}
	%>

	
	</table>
</FORM>
<br>
<br>
<br>
<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>