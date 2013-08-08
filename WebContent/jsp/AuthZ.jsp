
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.common.exceptions.NoEntity"%>
<%
try {

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	if (session.getAttribute("username") == null) {
	
		// Session not Available.
		//	Redirected to login page.
		response.sendRedirect(basePath + "/cims/jsp/Logout.jsp?message=Your are not logged in.");
		
	} else {
	
		// Session Available.
		//	Redirected to login page.			
		String user_name = session.getAttribute("username").toString();
		String url = request.getRequestURI();
		
		in.co.paramatrix.common.authz.AuthZ authz = in.co.paramatrix.common.authz.AuthZ.getInstance();
		boolean isAllowed = false;
	
		String method_id = url.substring(10,url.length()-4).toLowerCase().replace("\\","_").replace("/","_");
		
		try {
			//Check whether user has access to view this page.
			isAllowed = authz.checkOpForUser(method_id, user_name);
		} catch(NoEntity e) {
			System.out.println(e);
			String path1 = "/cims/jsp/Logout.jsp";
			if (method_id.indexOf("_") == -1) { %>
			<jsp:forward page="Logout.jsp">
				<jsp:param name="message" value="Not an valid user."/>
			</jsp:forward>
			<% } else { %>
			<jsp:forward page="../Logout.jsp">
				<jsp:param name="message" value="Not an valid user."/>
			</jsp:forward>
			<% }
		}
		
		if(!isAllowed) {
			System.out.println("[AuthZ.jsp][Denied] User: '" + user_name + "' - url: '" + url +"'");
			// Not authorized.
			// Redirect to login page.
			if(method_id.indexOf("_") == -1) {%>
			<jsp:forward page="Logout.jsp">
				<jsp:param name="message" value="Access Denied."/>
			</jsp:forward>
			<%} else {%>
			<jsp:forward page="../Logout.jsp">
				<jsp:param name="message" value="Access Denied."/>
			</jsp:forward>
			<%}			
		} else {
			// Authorize.
			// Do nothing.
			System.out.println("[AuthZ.jsp][Allowed] User: '" + user_name + "' - url: '" + url +"'");
		}
	}
} finally {
		
}%>