
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>

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
        CachedRowSet crsObjResult = null;
        CachedRowSet lobjCachedRowSetbowlinglist =null;
        CachedRowSet lobjCachedRowSetbattinglist =null;
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		LogWriter log = new LogWriter();
		String matchId = null;
		matchId = session.getAttribute("matchid").toString();
		
if(request.getParameter("inning").equals("inning")){
	try{
	vparam.add(request.getParameter("val"));
		try{
			lobjCachedRowSetbowlinglist = lobjGenerateProc.GenerateStoreProcedure("dsp_bowlinglist",vparam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************umpiringDecisionResponse.jsp*****************"+e);
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}	
    vparam.removeAllElements();
	vparam.add(request.getParameter("val"));
		try{
			lobjCachedRowSetbattinglist = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenlist",vparam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************umpiringDecisionResponse.jsp*****************"+e);
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}	
	vparam.removeAllElements();	
	}catch(Exception e){
	e.printStackTrace();
	}	
%>
	      
		  
		        	<select name="dpBatsmen" id="dpBatsmen" class="combox"  onchange="changeColor('dpBatsmen')"  >
		        	   <option value="0">Batsman</option>
		            	<%
		            	if(lobjCachedRowSetbattinglist!=null)
		            	{
		            	     while(lobjCachedRowSetbattinglist.next())
	            		      { 
	            		      
	            		     %>
	                	     <option value="<%=lobjCachedRowSetbattinglist.getString("id")%>"><%=lobjCachedRowSetbattinglist.getString("playername")%></option>   
		                    <%}
		                }%> 
		            </select>
			<br>
		
		        	<select name="dpBowler" id="dpBowler" class="combox" onchange="changeColor('dpBowler')" >
		        	<option value="0">Bowling</option>
		            	<%
		            	if(lobjCachedRowSetbowlinglist!=null)
		            	{
		            	    while(lobjCachedRowSetbowlinglist.next())
	            		    {
	            		  
	            		    %>
	                	    <option value="<%=lobjCachedRowSetbowlinglist.getString("id")%>"><%=lobjCachedRowSetbowlinglist.getString("playername")%></option>   
		                   <%}
		                }%> 
		            </select>
		  
<% }
  if(request.getParameter("inning").equals("appeal")){

try{
	vparam.add(request.getParameter("val"));
	try{
		crsObjResult = lobjGenerateProc.GenerateStoreProcedure("demo_dsp_results",vparam,"ScoreDB");    
	}catch (Exception e) {
		System.out.println("*************umpiringDecisionResponse.jsp*****************"+e);
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}		
	vparam.removeAllElements();	
	}catch(Exception e){
	e.printStackTrace();
	}	




%>
                  <select name="dpReason" id="dpReason" class="combox" >
		            	<option value="0">Choose Reason</option>
		            	<%
		            	if(crsObjResult!=null)
		            	{
		            	    while(crsObjResult.next())
	            		    { 
	            		    %>
	                	    <option value="<%=crsObjResult.getString("id")%>"><%=crsObjResult.getString("reason")%></option>   
		                   <%}
		                }%> 
		                 
		            </select>
		      
<%}

    if(request.getParameter("inning").equals("edit")){
                vparam.add(request.getParameter("umpire"));
				vparam.add(request.getParameter("umpcoach"));
				vparam.add(request.getParameter("appealid"));
				vparam.add(request.getParameter("reas"));
				vparam.add(request.getParameter("res"));
				vparam.add(request.getParameter("desc"));
				vparam.add(request.getParameter("over"));
				vparam.add(request.getParameter("batsman"));				
				vparam.add(request.getParameter("bowler"));
			     vparam.add(request.getParameter("inningid"));
			      vparam.add(request.getParameter("remark"));
			     vparam.add("S");
			    
	try{
			
	
	crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
	
    vparam.removeAllElements();
	
	}catch (Exception e) {
			System.out.println("*************umpiringDecisionResponse.jsp*****************"+e);
			log.writeErrLog(page.getClass(),matchId,e.toString());
	}	 
		      
}
%>




			        		        