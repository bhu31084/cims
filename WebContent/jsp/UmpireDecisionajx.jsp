
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
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
		
		
if(request.getParameter("inning").equals("inning")){
	try{
	vparam.add(request.getParameter("val"));
	lobjCachedRowSetbowlinglist = lobjGenerateProc.GenerateStoreProcedure("dsp_bowlinglist",vparam,"ScoreDB");
    vparam.removeAllElements();
	vparam.add(request.getParameter("val"));
	lobjCachedRowSetbattinglist = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenlist",vparam,"ScoreDB");
	vparam.removeAllElements();	
	}catch(Exception e){
	e.printStackTrace();
	}	
%>
	      
		  
		        	<select name="dpBatsmen" id="dpBatsmen" class="combox" >
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
		
		        	<select name="dpBowler" id="dpBowler" class="combox">
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
		  
<% }else{

try{
	vparam.add(request.getParameter("val"));
	crsObjResult = lobjGenerateProc.GenerateStoreProcedure("demo_dsp_results",vparam,"ScoreDB");    
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
		      
<%}%>




			        		        