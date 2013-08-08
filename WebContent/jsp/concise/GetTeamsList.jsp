<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires",0);
%>
<%	
	String seasonId = request.getParameter("seasonId")==null?"0":request.getParameter("seasonId");
	String seriesId = request.getParameter("seriesId")==null?"0":request.getParameter("seriesId");		
	
	CachedRowSet  crsObjTeamsList = null;		
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	try{		
		vparam.add(seriesId);//1								
		crsObjTeamsList = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getconcise_matchteams",vparam,"ScoreDB");
		vparam.removeAllElements();
	}catch (Exception e) {
		System.out.println("Exception"+e);
		e.printStackTrace();
	}
	%>		

<div id="teamsresponse"> 
	<table>
		<tr>
		<td>
			<select name="dpteams" id="dpteams">
				<option value="0" >Select </option>
				<%    if(crsObjTeamsList!=null){
	                           while(crsObjTeamsList.next()){
	%>				<option
						value='<%=crsObjTeamsList.getString("id")+"~"+crsObjTeamsList.getString("team_name")%>' >
						<%=crsObjTeamsList.getString("team_name")%></option>
	<%                }// end of while
	                  }// end of if
	%>				
				</select>
			</td>
		</tr>	
	</table>
</div>
