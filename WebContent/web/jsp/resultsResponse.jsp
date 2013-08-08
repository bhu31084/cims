<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ include file="loginvalidate.jsp" %>
<%		
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");			
	Common common = new Common();
	String pageNo = "1";
	String TotalNoOfPages = null;
	String TotalPageCount = "1";
	String res = "";
	String currentYear = sdf.format(new Date()).substring(0,4);	
	String page_no = "";
	CachedRowSet  crsObjRecentResults = null;	
	Vector vParam =  new Vector();		
	pageNo = request.getParameter("hdpageNo")==null?"":request.getParameter("hdpageNo");
	//pageNo = request.getParameter("hdpageNo");		
	
	try{
		vParam.add(pageNo);
		crsObjRecentResults = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_resultofmatches",vParam,"ScoreDB");				
		vParam.removeAllElements();
	}catch(Exception e){
		e.printStackTrace();
	}

%>
<div id="resultsdiv" style="width: 600px;height: 650px;">			   				   
	<table width="600" border="0" >										
    	<%if(crsObjRecentResults != null){
    		int counter = 1;		                		
    		while(crsObjRecentResults.next()){
    		res = crsObjRecentResults.getString("result");
    		TotalNoOfPages = crsObjRecentResults.getString("noofpages");
    		if(counter % 2 == 0 ){%>
    		<tr bgcolor="#f0f7fd">
    		<%}else{%>
    		<tr bgcolor="#e6f1fc">
    		<%}%>		                				                			
    			<td valign="top" nowrap="nowrap" id="<%=counter++%>" align="center">&nbsp;&nbsp;&nbsp;<%=crsObjRecentResults.getString("expected_start").substring(0,11).toString()%>
    			&nbsp; To &nbsp;<%=crsObjRecentResults.getString("expected_end").substring(0,11).toString()%>
    			</td>
    			<td nowrap="nowrap" align="center">																				    				
	    			<div id="teams"><font color="#C66908"><b><%=crsObjRecentResults.getString("matchbtwn")%></b></font></div> 
	    			<div><%=crsObjRecentResults.getString("seriesname")%>,<%=crsObjRecentResults.getString("venuename")%>
	    			<!-- <%if(res.equalsIgnoreCase("drawn")){%>
	    				<div><font color="red">Result :<%=res%>	</font></div>
	    			<%}else{%>
	    				<div><font color="red">Result :<%=res%></font>	</div>
	    				<div><font color="red">Winner :<%=crsObjRecentResults.getString("winningteam")%></font></div>
	    			<%}%></div>-->						    																								    			
	    			<div><a href="javascript:ShowFullScoreCard('<%=crsObjRecentResults.getString("id")%>')" >ScoreCard</a></div>
    			</td>																                																				    		
    	</tr>																	    	
    	<%	}
    	}%>		                										                	
	</table>	              
</div>