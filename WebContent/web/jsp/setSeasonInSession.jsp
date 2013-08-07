<%
	String Seasonid = request.getParameter("seasonid");
	System.out.println("season id is  "+Seasonid);
	session.setAttribute("season", Seasonid);	
	String season = session.getAttribute("season").toString();	
%>
<%=season%>