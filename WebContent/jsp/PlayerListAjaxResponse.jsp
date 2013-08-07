<!--
	Page Name 	 : PlayerListAjaxResponse.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 22th Nov 2008
	Description  : Ajax Response for Player List 
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
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
<HEAD>
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
</HEAD>
<%
        CachedRowSet crsObjResult = null;
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		Integer pageNo = null; 

		String clubId = request.getParameter("clubId");
		String teamId = request.getParameter("teamId");
		String paging = request.getParameter("pageNo");
	System.out.println("clubId ##### " + clubId + "teamId ##### " + teamId);
		System.out.println("paging ###### " + paging);
		try {
			vparam.add(clubId);
			vparam.add(teamId);
			vparam.add(paging);
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_playerListPaging", vparam, "ScoreDB");
			vparam.removeAllElements();
			
			if(crsObjResult != null && crsObjResult.size() > 0) {
%>
		<table width="90%" border="0" align="center">
			<input type="hidden" name="teamId" id="teamId" value='<%=teamId%>'>
					<tr>
						<th class="headinguser" align="left">Player Name</th>
						<th class="colheadinguser">Team Name</th>
					</tr>
					<tr>
						
	<%
	
					while (crsObjResult.next()) {
							pageNo = crsObjResult.getInt("usernoofpages");
							
							//System.out.println("pageNo AJAX " + pageNo);
							
	%>
						<td nowrap><a onclick="javascript:setPlayerListWindow('<%=crsObjResult.getString("id")%>|<%=crsObjResult.getString("name")%>');"><%=crsObjResult.getString("name")%></a></td>
						<td nowrap><%=crsObjResult.getString("team")%></td>
					</tr>	
				
	<%
					}
				
	%>
		</table>
		
<%
		} else {
		%>
			
			<font color=red>No Player Found</font>
		
		<%
		} 
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
<input type="hidden" name="pageNo" id="pageNo" value='<%=pageNo%>'>
		
 