<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
<html>
<head>
<%		response.setHeader("Cache-Control", "private");
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setHeader("Pragma", "must-revalidate");
		response.setDateHeader("Expires", 0);
%>
<%//cachedrowset declaration
		CachedRowSet playerScoreCrs 	= null;
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		LogWriter log 					=  new LogWriter();
		Vector vparam 					=  new Vector();
		String inningId 				= "";
		String matchId	 				= "";
		int total_min 	 				= 0;
		int total_four	 				= 0;
		int total_six	 				= 0;
		int total_ball	 				= 0;
		String fifty_min 				= "";
		String hundred_Min 				= "";
		String hundred_fifty_Min		= "";
		String two_hundred_Min 			= "";
		String two_hundred_fifty_Min	= "";
		String three_hundred_Min		= "";
		String three_hundred_fifty_Min	= "";
		String four_hundred_Min			= "";
		String four_hundred_fifty_Min	= "";	
		String fifty_four				= "";
		String hundred_four 			= "";
		String hundred_fifty_four		= "";
		String two_hundred_four 		= "";
		String two_hundred_fifty_four	= "";
		String three_hundred_four		= "";
		String three_hundred_fifty_four	= "";
		String four_hundred_four		= "";
		String four_hundred_fifty_four	= "";	
		String fifty_six				= "";
		String hundred_six 				= "";
		String hundred_fifty_six		= "";
		String two_hundred_six 			= "";
		String two_hundred_fifty_six	= "";
		String three_hundred_six		= "";
		String three_hundred_fifty_six	= "";
		String four_hundred_six			= "";
		String four_hundred_fifty_six	= "";	
		String fifty_ball				= "";
		String hundred_ball				= "";
		String hundred_fifty_ball		= "";
		String two_hundred_ball 		= "";
		String two_hundred_fifty_ball	= "";
		String three_hundred_ball		= "";
		String three_hundred_fifty_ball	= "";
		String four_hundred_ball		= "";
		String four_hundred_fifty_ball	= "";	
		
		matchId = (String)session.getAttribute("matchid");
		//inningId = request.getParameter("inningIdOne");
		inningId = request.getParameter("inningIdOne")!=null?request.getParameter("inningIdOne"):"";
%>
</head>
<body>
	<table width=100% border=1>
			<tr>
				<td align=center nowrap><font size=1>INDIVIDUAL SCORES</font></b></td>
				<td align=center nowrap colspan=4><font size=1>For 50</font></b></td>
				<td align=center nowrap colspan=4><font size=1>For 100</font></b></td>
				<td align=center nowrap colspan=4><font size=1>For 150</font></b></td>
				<td align=center nowrap colspan=4><font size=1>For 200</font></b></td>
				<td align=center nowrap colspan=4><font size=1>For 250</font></b></td>
				<td align=center nowrap colspan=4><font size=1>For 300</font></b></td>
				<td align=center nowrap colspan=4><font size=1>For 350</font></b></td>
				<td align=center nowrap colspan=4><font size=1>For 400</font></b></td>
				<%--<td align=center nowrap colspan=4><font size=1>For 450</b></td>
				--%><td align=center nowrap colspan=4><font size=1>ENTIRE INNINGS</font></b></td>
			</tr>
			<tr>
				<td align=center nowrap><font size=1>Batsman</font></b></td>
				<td nowrap align=center><font size=1>Min's</font></td>
				<td nowrap align=center><font size=1>4's</font></td>
				<td nowrap align=center><font size=1>6's</font></td>
				<td nowrap align=center><font size=1>Balls</font></td>
				<td nowrap align=center><font size=1>Min's</font></td>
				<td nowrap align=center><font size=1>4's</font></td>
				<td nowrap align=center><font size=1>6's</font></td>
				<td nowrap align=center><font size=1>Balls</font></td>
				<td nowrap align=center><font size=1>Min's</font></td>
				<td nowrap align=center><font size=1>4's</font></td>
				<td nowrap align=center><font size=1>6's</font></td>
				<td nowrap align=center><font size=1>Balls</font></td>
				<td nowrap align=center><font size=1>Min's</font></td>
				<td nowrap align=center><font size=1>4's</font></td>
				<td nowrap align=center><font size=1>6's</font></td>
				<td nowrap align=center><font size=1>Balls</font></td>
				<td nowrap align=center><font size=1>Min's</font></td>
				<td nowrap align=center><font size=1>4's</font></td>
				<td nowrap align=center><font size=1>6's</font></td>
				<td nowrap align=center><font size=1>Balls</font></td>
				<td nowrap align=center><font size=1>Min's</font></td>
				<td nowrap align=center><font size=1>4's</font></td>
				<td nowrap align=center><font size=1>6's</font></td>
				<td nowrap align=center><font size=1>Balls</font></td>
				<td nowrap align=center><font size=1>Min's</font></td>
				<td nowrap align=center><font size=1>4's</font></td>
				<td nowrap align=center><font size=1>6's</font></td>
				<td nowrap align=center><font size=1>Balls</font></td>
				<td nowrap align=center><font size=1>Min's</font></td>
				<td nowrap align=center><font size=1>4's</font></td>
				<td nowrap align=center><font size=1>6's</font></td>
				<td nowrap align=center><font size=1>Balls</font></td>
				<%--<td nowrap align=center>Min's</td>
				<td nowrap align=center>4's</td>
				<td nowrap align=center>6's</td>
				<td nowrap align=center>Balls</td>
				--%><td nowrap align=center><font size=1>Min's</font></td>
				<td nowrap align=center><font size=1>4's</font></td>
				<td nowrap align=center><font size=1>6's</font></td>
				<td nowrap align=center><font size=1>Balls</font></td>
			</tr> 
<%  vparam.add(inningId);
	//vparam.add(inningIdTwo);
	playerScoreCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_individualscores_for_testmatch",vparam,"ScoreDB");
	vparam.removeAllElements();
	try{
		if (playerScoreCrs!=null ) {
		 	 while (playerScoreCrs.next()){
%>									<tr>
										<td align=left nowrap><font color="#003399" size=1><%=playerScoreCrs.getString("batsman")!=null?playerScoreCrs.getString("batsman"):""%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("fifty_Min")!=null?playerScoreCrs.getString("fifty_Min"):"0"%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("fifty_four")!=null?playerScoreCrs.getString("fifty_four"):"0"%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("fifty_six")!=null?playerScoreCrs.getString("fifty_six"):"0"%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("fifty_ball")!=null?playerScoreCrs.getString("fifty_ball"):"0"%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("hundred_Min")!=null?playerScoreCrs.getString("hundred_Min"):""%></font></td>
<%	if(!playerScoreCrs.getString("hundred_Min").equals("0")){
%>
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("hundred_four")!=null?playerScoreCrs.getString("hundred_four"):"0")+Integer.parseInt(playerScoreCrs.getString("fifty_four")!=null?playerScoreCrs.getString("fifty_four"):"0")%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("hundred_six")!=null?playerScoreCrs.getString("hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("fifty_six")!=null?playerScoreCrs.getString("fifty_six"):"0")%></font></td>
<%}else{
%>	
										<td align=right><font color="#003399" size=1>0</font></td>		
										<td align=right><font color="#003399" size=1>0</font></td>
<%}
%>							
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("hundred_ball")!=null?playerScoreCrs.getString("hundred_ball"):"0"%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("hundred_fifty_Min")!=null?playerScoreCrs.getString("hundred_fifty_Min"):"0"%></font></td>
<% if(!playerScoreCrs.getString("hundred_fifty_Min").equals("0")){
%>										
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("hundred_fifty_four")!=null?playerScoreCrs.getString("hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_four")!=null?playerScoreCrs.getString("hundred_four"):"0")+Integer.parseInt(playerScoreCrs.getString("fifty_four")!=null?playerScoreCrs.getString("fifty_four"):"0") %></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("onehundre_fifty_six")!=null?playerScoreCrs.getString("onehundre_fifty_six"):"0" ) + Integer.parseInt(playerScoreCrs.getString("hundred_six")!=null?playerScoreCrs.getString("hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("fifty_six")!=null?playerScoreCrs.getString("fifty_six"):"0") %></font></td>
<%}else{
%>	
										<td align=right><font color="#003399" size=1>0</font></td>		
										<td align=right> <font color="#003399" size=1>0</font></td>	
<%}
%>								
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("onehundred_fifty_ball")!=null?playerScoreCrs.getString("onehundred_fifty_ball"):"0"%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("two_hundred_Min")!=null?playerScoreCrs.getString("two_hundred_Min"):"0"%></font></td>
<%if(!playerScoreCrs.getString("two_hundred_Min").equals("0")){
%>										
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("two_hundred_four")!=null?playerScoreCrs.getString("two_hundred_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_fifty_four")!=null?playerScoreCrs.getString("hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_four")!=null?playerScoreCrs.getString("hundred_four"):"0")+Integer.parseInt(playerScoreCrs.getString("fifty_four")!=null?playerScoreCrs.getString("fifty_four"):"0") %></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("two_hundred_six")!=null?playerScoreCrs.getString("two_hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("onehundre_fifty_six")!=null?playerScoreCrs.getString("onehundre_fifty_six"):"0" ) + Integer.parseInt(playerScoreCrs.getString("hundred_six")!=null?playerScoreCrs.getString("hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("fifty_six")!=null?playerScoreCrs.getString("fifty_six"):"0")%></font></td>
<%
}else{										
%>
										<td align=right><font color="#003399" size=1>0</font></td>		
										<td align=right><font color="#003399" size=1>0</font></td>
<%}
%>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("two_hundred_ball")!=null?playerScoreCrs.getString("two_hundred_ball"):"0"%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("two_hundred_fifty_Min")!=null?playerScoreCrs.getString("two_hundred_fifty_Min"):"0"%></font></td>
<% if(!playerScoreCrs.getString("two_hundred_fifty_Min").equals("0")){

%>										
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("two_hundred_fifty_four")!=null?playerScoreCrs.getString("two_hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_four")!=null?playerScoreCrs.getString("two_hundred_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_fifty_four")!=null?playerScoreCrs.getString("hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_four")!=null?playerScoreCrs.getString("hundred_four"):"0")+Integer.parseInt(playerScoreCrs.getString("fifty_four")!=null?playerScoreCrs.getString("fifty_four"):"0")%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("two_hundred_fifty_six")!=null?playerScoreCrs.getString("two_hundred_fifty_six"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_six")!=null?playerScoreCrs.getString("two_hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("onehundre_fifty_six")!=null?playerScoreCrs.getString("onehundre_fifty_six"):"0" ) + Integer.parseInt(playerScoreCrs.getString("hundred_six")!=null?playerScoreCrs.getString("hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("fifty_six")!=null?playerScoreCrs.getString("fifty_six"):"0")%></font></td>
<%}else{
%>	
										<td align=right><font color="#003399" size=1>0</font></td>		
										<td align=right><font color="#003399" size=1>0</font></td>
<%}
%>								
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("two_hundred_fifty_ball")!=null?playerScoreCrs.getString("two_hundred_fifty_ball"):"0"%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("three_hundred_Min")!=null?playerScoreCrs.getString("three_hundred_Min"):"0"%></font></td>
<%if(!playerScoreCrs.getString("three_hundred_Min").equals("0")){
%>										
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("three_hundred_four")!=null?playerScoreCrs.getString("three_hundred_four"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_fifty_four")!=null?playerScoreCrs.getString("two_hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_four")!=null?playerScoreCrs.getString("two_hundred_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_fifty_four")!=null?playerScoreCrs.getString("hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_four")!=null?playerScoreCrs.getString("hundred_four"):"0")+Integer.parseInt(playerScoreCrs.getString("fifty_four")!=null?playerScoreCrs.getString("fifty_four"):"0")%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("three_hundred_six")!=null?playerScoreCrs.getString("three_hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_fifty_six")!=null?playerScoreCrs.getString("two_hundred_fifty_six"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_six")!=null?playerScoreCrs.getString("two_hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("onehundre_fifty_six")!=null?playerScoreCrs.getString("onehundre_fifty_six"):"0" ) + Integer.parseInt(playerScoreCrs.getString("hundred_six")!=null?playerScoreCrs.getString("hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("fifty_six")!=null?playerScoreCrs.getString("fifty_six"):"0")%></font></td>
<%}else{
%>	
										<td align=right><font color="#003399" size=1>0</font></td>		
										<td align=right><font color="#003399" size=1>0</font></td>															
<%}
%>										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("three_hundred_ball")!=null?playerScoreCrs.getString("three_hundred_ball"):"0"%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("three_hundred_fifty_Min")!=null?playerScoreCrs.getString("three_hundred_fifty_Min"):"0"%></font></td>
<%if (!playerScoreCrs.getString("three_hundred_fifty_Min").equals("0")){
%>									

										<td nowrap align=center><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("three_hundred_fifty_four")!=null?playerScoreCrs.getString("three_hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("three_hundred_four")!=null?playerScoreCrs.getString("three_hundred_four"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_fifty_four")!=null?playerScoreCrs.getString("two_hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_four")!=null?playerScoreCrs.getString("two_hundred_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_fifty_four")!=null?playerScoreCrs.getString("hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_four")!=null?playerScoreCrs.getString("hundred_four"):"0")+Integer.parseInt(playerScoreCrs.getString("fifty_four")!=null?playerScoreCrs.getString("fifty_four"):"0")%></font></td>
										<td nowrap align=center><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("three_hundred_fifty_six")!=null?playerScoreCrs.getString("three_hundred_fifty_six"):"0") + Integer.parseInt(playerScoreCrs.getString("three_hundred_six")!=null?playerScoreCrs.getString("three_hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_fifty_six")!=null?playerScoreCrs.getString("two_hundred_fifty_six"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_six")!=null?playerScoreCrs.getString("two_hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("onehundre_fifty_six")!=null?playerScoreCrs.getString("onehundre_fifty_six"):"0" ) + Integer.parseInt(playerScoreCrs.getString("hundred_six")!=null?playerScoreCrs.getString("hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("fifty_six")!=null?playerScoreCrs.getString("fifty_six"):"0")%></font></td>
<%}else{
%>			
										<td align=right><font color="#003399" size=1>0</font></td>		
										<td align=right><font color="#003399" size=1>0</font></td>
<%}
%>							
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("three_hundred_fifty_ball")!=null?playerScoreCrs.getString("three_hundred_fifty_ball"):"0"%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("four_hundred_Min")!=null?playerScoreCrs.getString("four_hundred_Min"):"0"%></font></td>
<%if (!playerScoreCrs.getString("four_hundred_Min").equals("0")){
%>										
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("four_hundred_four")!=null?playerScoreCrs.getString("four_hundred_four"):"0") + Integer.parseInt(playerScoreCrs.getString("three_hundred_fifty_four")!=null?playerScoreCrs.getString("three_hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("three_hundred_four")!=null?playerScoreCrs.getString("three_hundred_four"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_fifty_four")!=null?playerScoreCrs.getString("two_hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_four")!=null?playerScoreCrs.getString("two_hundred_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_fifty_four")!=null?playerScoreCrs.getString("hundred_fifty_four"):"0") + Integer.parseInt(playerScoreCrs.getString("hundred_four")!=null?playerScoreCrs.getString("hundred_four"):"0")+Integer.parseInt(playerScoreCrs.getString("fifty_four")!=null?playerScoreCrs.getString("fifty_four"):"0")%></font></td>
										<td nowrap align=right><font color="#003399" size=1><%=Integer.parseInt(playerScoreCrs.getString("four_hundred_six")!=null?playerScoreCrs.getString("four_hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("three_hundred_fifty_six")!=null?playerScoreCrs.getString("three_hundred_fifty_six"):"0") + Integer.parseInt(playerScoreCrs.getString("three_hundred_six")!=null?playerScoreCrs.getString("three_hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_fifty_six")!=null?playerScoreCrs.getString("two_hundred_fifty_six"):"0") + Integer.parseInt(playerScoreCrs.getString("two_hundred_six")!=null?playerScoreCrs.getString("two_hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("onehundre_fifty_six")!=null?playerScoreCrs.getString("onehundre_fifty_six"):"0" ) + Integer.parseInt(playerScoreCrs.getString("hundred_six")!=null?playerScoreCrs.getString("hundred_six"):"0") + Integer.parseInt(playerScoreCrs.getString("fifty_six")!=null?playerScoreCrs.getString("fifty_six"):"0")%></font></td>
<%}else{
%>		
										<td align=right><font color="#003399" size=1>0</font></td>		
										<td align=right><font color="#003399" size=1>0</font></td>
<%}
%>								
										<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("four_hundred_ball")!=null?playerScoreCrs.getString("four_hundred_ball"):"0"%></font></td>
<%		// Total Minute Calculation for entire innings
		total_min = Integer.parseInt(playerScoreCrs.getString("fifty_Min")) + Integer.parseInt(playerScoreCrs.getString("hundred_Min")) + Integer.parseInt(playerScoreCrs.getString("hundred_fifty_Min")) + Integer.parseInt(playerScoreCrs.getString("two_hundred_Min")) + Integer.parseInt(playerScoreCrs.getString("two_hundred_fifty_Min")) + Integer.parseInt(playerScoreCrs.getString("three_hundred_Min")) + Integer.parseInt(playerScoreCrs.getString("three_hundred_fifty_Min")) + Integer.parseInt(playerScoreCrs.getString("four_hundred_Min")) +  Integer.parseInt(playerScoreCrs.getString("four_hundred_fifty_Min"));
%>
									<td nowrap align=right><font color="#003399" size=1><a href="javascript:showPlayerTimeDetail('<%=playerScoreCrs.getString("batsman_id")!=null?playerScoreCrs.getString("batsman_id"):"0"%>','<%=inningId%>')"><%=playerScoreCrs.getString("entire_min")!=null?playerScoreCrs.getString("entire_min"):"0"%></a></font>
									</td>
									<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("entire_four")!=null?playerScoreCrs.getString("entire_four"):"0"%></font></td>
									<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("entire_six")!=null?playerScoreCrs.getString("entire_six"):"0"%></font></td>
									<td nowrap align=right><font color="#003399" size=1><%=playerScoreCrs.getString("entire_ball")!=null?playerScoreCrs.getString("entire_ball"):"0"%></font></td>
<%				fifty_min 	  				= "";
			hundred_Min   				= "";
			hundred_fifty_Min			= "";
			two_hundred_Min				= "";
			two_hundred_fifty_Min		= "";
			three_hundred_Min			= "";
			three_hundred_fifty_Min		= "";
			four_hundred_Min			= "";
			four_hundred_fifty_Min		= "";												
%>				
							</tr>			
<%		 	 }
		}
	}catch(Exception e)	{
		log.writeErrLog(page.getClass(),matchId,e.toString());
	} 	 
%>	 	 
			</table>
</body>
</html>