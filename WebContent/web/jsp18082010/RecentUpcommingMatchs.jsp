<!--
	Author 		 : Archana Dongre
	Created Date : 31/01/09
	Description  : Display match Ranking summry.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="error_page.jsp"%>
<%
		try {		
		//String currentmonth = "";
   		//String currentYear = "";
		//String monthFlag = "";	
		String getflag = "";	
		getflag = request.getParameter("getflag")==null?"":request.getParameter("getflag");
		System.out.println("getflag from main page is ***** "+getflag);
		//currentYear = request.getParameter("currentYear")==null?"":request.getParameter("currentYear");
		//monthFlag = request.getParameter("monthFlag")==null?"":request.getParameter("monthFlag");
		
		String res = null;
		GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
		Vector 					vparam 					=  	new Vector();
		CachedRowSet 			crsObjRecentResults        =	null;
		CachedRowSet 			crsObjUpcomingMatches        =	null;
				
%>	
<%if(getflag.equalsIgnoreCase("R")){
	vparam.removeAllElements();	
		vparam.add("1");//flag 1 (recent results)
		vparam.add("0");//To show top five matches on first page 
		crsObjRecentResults = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_fixtures_web", vparam, "ScoreDB");
		vparam.removeAllElements();	
%>
<div >
	<table border="0" style="width: 250px;" >						                	
	<%if(crsObjRecentResults != null){
		if(crsObjRecentResults.size() == 0){%>			                		
				<tr>
	    			<td >
	    				<div style="color:red;">No Matches Scheduled</div>
		    		</td>
	    		</tr>
			<%}else{
		int resultcount = 1;
		while(crsObjRecentResults.next()){																	                		
			res = crsObjRecentResults.getString("result");		                			
				if(resultcount % 2 == 0 ){%> 
					<tr bgcolor="#f0f7fd">
					<%}else{%>
					<tr bgcolor="#e6f1fc">
					<%}%>	
	    			<td id="<%=resultcount++%>">																				    				
		    			<div id="teams" style="color:green;"><%=crsObjRecentResults.getString("Teams")%> </div>
		    			<div id="Tournament and location"><b>Tournament :</b> <%=crsObjRecentResults.getString("Series")%></div>
		    			<div><b>Venue : </b><%=crsObjRecentResults.getString("venue")%></div>
		    			<div ><b>Date : </b><%=crsObjRecentResults.getString("start_date").substring(0,11).toString()%></div>
		    			<%if(res.equalsIgnoreCase("drawn")){%>
		    				<div id="result" style="color:red;"><b>Result :</b> <%=res%></div>
		    			<%}else{%>
		    				<div id="result" style="color:red;"><b>Result :</b> <%=res%></div>
		    				<div id="winner" style="color:red;"><b>Winner :</b> <%=crsObjRecentResults.getString("MatchWinner")%></div>
		    			<%}%>						    			
	<%--								    			<div id="winner" style="color:red;"><b>Winner :</b> <%=crsObjRecentResults.getString("MatchWinner")%></div>																					    			--%>
		    			<div><a href="javascript:ShowFullScoreCard('<%=crsObjRecentResults.getString("Match_id")%>')" >ScoreCard</a></div>
	    			</td>
	    	</tr>
	<%			    	
	
	}
		}	}
		%>		                											                	
		</table>
	</div>					
<%}else{%>	
	<%
		vparam.removeAllElements();	
		vparam.add("2");//flag 2 (Upcomming Matches)
		vparam.add("1");//To show top five matches on first page 		
		crsObjUpcomingMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_fixtures_web", vparam, "ScoreDB");
		vparam.removeAllElements();	
	%>
	<div >
		<table border="0" style="width: 250px;" >
	    	<%if(crsObjUpcomingMatches != null){
			if(crsObjUpcomingMatches.size() == 0){%>			                		
				<tr>
	    			<td >
	    				<div style="color:red;">No Matches Scheduled</div>
		    		</td>
	    		</tr>
			<%}else{
			int resultcount = 1;
		while(crsObjUpcomingMatches.next()){																	                										                		
			if(resultcount % 2 == 0 ){%> 
					<tr bgcolor="#f0f7fd">
					<%}else{%>
					<tr bgcolor="#e6f1fc">
					<%}%>	
				<td  id="<%=resultcount++%>">
					<div id="teams" style="color:green;"><%=crsObjUpcomingMatches.getString("Teams")%>.</div>
	    			<div id="Tournament and location"><b>Tournament :</b><%=crsObjUpcomingMatches.getString("Series")%></div>
	    			<div ><b>Date : </b><%=crsObjUpcomingMatches.getString("start_date").substring(0,11).toString()%></div>
	    			<div><b>Venue :</b><%=crsObjUpcomingMatches.getString("venue")%></div>
	    		</td>
		<%	}
		}
	}%>																			    		
	    	</tr>											                	
			</table>
	</div>	
	<%}%>			
<%} catch (Exception e) {
			System.err.println(e.toString());
		}
%>