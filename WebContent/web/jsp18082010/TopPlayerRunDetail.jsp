<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>

<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
%>
<%
	String matchId= null; 
	String userId= null;
	String flag = null;
		
	matchId = request.getParameter("matchId")!=null?request.getParameter("matchId"):"";
	userId = request.getParameter("userId")!=null?request.getParameter("userId"):"";
	flag = request.getParameter("flag")!=null?request.getParameter("flag"):"";
	
    CachedRowSet runDetailsCrs = null;
	Vector vparam = new Vector();
	GenerateStoreProcedure generateProc = new GenerateStoreProcedure();
	
			try {
			vparam.add(userId);
			vparam.add(matchId);
		
				if(flag != null && flag.equalsIgnoreCase("1")){
					runDetailsCrs = generateProc.GenerateStoreProcedure(
							"esp_dsp_inningwisebatter_runs", vparam, "ScoreDB");
				}else if(flag != null && flag.equalsIgnoreCase("2")){						
					runDetailsCrs = generateProc.GenerateStoreProcedure(
							"esp_dsp_inningwisebowler_runs", vparam, "ScoreDB");	
				}		
			vparam.removeAllElements();
			}catch (Exception e) {
				e.printStackTrace();
			}
			

%>
<html>
<body>
	<table border="1" class="contenttable">
<%
	if(runDetailsCrs != null && runDetailsCrs.size() >0){
		while(runDetailsCrs.next()){
%>
		<tr>
			<th>
				Inning1 :
			</th>
			<td><%=runDetailsCrs.getString("inning1")%></td>
			<th>
				Inning2 :
			</tr>
			<td><%=runDetailsCrs.getString("inning2")%></td>
		</tr>
		

<%				
		}
	}
%>
	<table>
</body>
</html>