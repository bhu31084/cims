<%@ page import="sun.jdbc.rowset.CachedRowSet,
                 in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
                 java.util.*"%>
<% response.setHeader("Pragma", "private");
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "must-revalidate");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setDateHeader("Expires", 0);
%>
<%
	String bowlerName="abc";
	String BowlerId = "";
	String BatsMan1="abc~10";
	String 	BatsMan2 = "abc~11";
	session.setAttribute("InningId",request.getParameter("Inning"));
	session.setAttribute("matchId1",request.getParameter("matchid"));
	response.sendRedirect("/cims/jsp/scorer.jsp?bowlerName=" + bowlerName +"&BowlerId=" + BowlerId + "&BatsMan1="+ BatsMan1 +"&BatsMan2=" +BatsMan2);
%>


