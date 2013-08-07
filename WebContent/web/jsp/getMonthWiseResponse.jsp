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
		String currentmonth = "";
   		String currentYear = "";
		String monthFlag = "";	
		String message = "";	
		currentmonth = request.getParameter("month")==null?"":request.getParameter("month");
		currentYear = request.getParameter("currentYear")==null?"":request.getParameter("currentYear");
		monthFlag = request.getParameter("monthFlag")==null?"":request.getParameter("monthFlag");	
		
		CachedRowSet  crsObjScheduledMatches = null;		
		Vector vParam =  new Vector();	
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
		System.out.println("current month from main page is ***** "+currentmonth);	
		try{
			vParam.add(currentmonth);
			vParam.add(currentYear);
			vParam.add(monthFlag);
			crsObjScheduledMatches = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getprescheduldmatch",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
			e.printStackTrace();
		}			
		%>
<DIV id="monthdiv">
<table width="690" border="0" class="contenttable" >
	<tr><td colspan="4"> Month :<%=currentmonth%>&nbsp;&nbsp;Year : <%=currentYear%></td><tr>
<%--	<tr>--%>
<%--		<td align="center" ><font size="2" color=""><b> Date </b></font></td>--%>
<%--		<td align="center" ><font size="2" color=""><b> Teams And Match </b></font></td>--%>
<%--		<td align="center" ><font size="2" color=""><b> Venue </b></font></td>--%>
<%--		<td align="center"  ><font size="2" color=""><b> Series </b></font></td>--%>
<%--  	</tr>												  												  	--%>
	<%if(crsObjScheduledMatches != null ){
		int counter = 1;
		if(crsObjScheduledMatches.size() == 0){				
				message = " No Matches Scheduled ";%>
			<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
			<%}else{%>													
	<%	while(crsObjScheduledMatches.next()){
		if(counter % 2 == 0 ) {	%>
	<TR bgcolor="#f0f7fd">
	<%} else {%>
	<tr bgcolor="#e6f1fc">
		<%}		%>
		<td id="<%=counter++%>"><%=crsObjScheduledMatches.getString("expected_start").substring(0,11)%>
		<b> To </b><%=crsObjScheduledMatches.getString("expected_end").substring(0,11)%>
		</td>
		<td nowrap="nowrap" >												
			<div><font color="#C66908"><%=crsObjScheduledMatches.getString("matchbtwn")%></font></div>	
			<div><%=crsObjScheduledMatches.getString("venuename")%></div>
			<div><%=crsObjScheduledMatches.getString("description")%></div>
		</td>
	</tr>
	<%}	
	}			
}%>		
</table>	

</DIV>
<%} catch (Exception e) {
			System.err.println(e.toString());
		}
%>