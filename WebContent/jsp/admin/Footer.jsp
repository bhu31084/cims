<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'Footer.jsp.jsp' starting page</title>
  </head>
	<body>
		<div style="width:100%">
			<table width="100%" border="1">
				<tr>
					<td class="footer">
<div style="display:block;width:68%; text-align:left; padding-left:1%; float:left;">
CIMS
</div>
<div style="display:block;width:30%; text-align:right; padding-right:1%; float:left;">

</div>
</td>
				</tr>
			</table>
		</div>
	</body>
</html>