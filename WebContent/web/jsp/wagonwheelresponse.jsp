<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" %>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%
	try{	
	String inningid = request.getParameter("inningid")==null?"":request.getParameter("inningid");
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();	
	CachedRowSet crsObjPlayers = null;
	CachedRowSet crsObjPlayers2 = null;
	Vector vparam = new Vector();
	try{
		vparam.add(inningid);
		crsObjPlayers = lobjGenerateProc.GenerateStoreProcedure(
				"dsp_batsmenlist", vparam, "ScoreDB");
		crsObjPlayers2 = lobjGenerateProc.GenerateStoreProcedure(
			"dsp_batsmenlist", vparam, "ScoreDB");
	}catch(Exception e) {
			System.out.println("********* WagonWheelResponse *********");
			e.printStackTrace();
	}
%>
<div id="wagonwheel">
<table width="100%" border="1" bgcolor="#f0f7fd">
	<tr >
		<td nowrap="nowrap" valign="top">
<%--			<div style="width: 250px;height: 100%">--%>
			<table border="1" class="contenttable" >
				<tr style="width: 100%;">		    
		    		<td style="text-align: center;font-size: 13px;" colspan="2"><b>Players List</b></td>		    
		   		</tr>
				
				 <%if(crsObjPlayers != null){ %>													
		     <%	int colorcounter = 1;
		     while(crsObjPlayers.next()){		     			
		   		if(colorcounter % 2 == 0 ){%>
        		<tr bgcolor="#f0f7fd">
        		<%}else{%>
        		<tr bgcolor="#e6f1fc" style="width: 100%;">	
        		<%}%>		    
			    <td style="text-align: left;font-size: 15px;padding-left: 50px;" nowrap="nowrap" id="<%=colorcounter++%>">									  			
			     <a id="<%=crsObjPlayers.getString("id")%>"><%=crsObjPlayers.getString("playername")%></a>
			    </td>
			   </tr>
		      <% }
		      }%>
		      <tr>
			</table>
		</td>
		<td style="height: 100%" valign="top">
			<div id="wagonwheel" style=""><img src="../Image/WagonWheel.jpg" width="275"
				height="350" border="1" />			
			</div>
		</td>
	</tr>
</table>
</div>	
<%}catch (Exception e) {
			System.out.println("********* WagonWheelResponse *********");
			e.printStackTrace();
		}%>