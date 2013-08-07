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

        CachedRowSet crsObjResult = null;
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
	if(request.getParameter("response").equals("search")){
		String teamDesc=null;
		String teamCulb=null;		
		String teamName=null;
		String teamLoc=null;
		String clubId=null;
		String  nickname =null;
		String teamId= request.getParameter("TeamId");
		try {
			vparam.add(teamId);
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamsearch", vparam, "ScoreDB");
			vparam.removeAllElements();
   
			while (crsObjResult.next()) {
			
			 teamId =crsObjResult.getString("id");			  
             teamName= crsObjResult.getString("team_name"); 
             nickname= crsObjResult.getString("nickname"); 
              clubId =crsObjResult.getString("club");	
             teamDesc= crsObjResult.getString("Description");             
             teamCulb= crsObjResult.getString("name");             
			 teamLoc =crsObjResult.getString("team_location"); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
     <%=teamId%><br><%=teamName%><br><%=clubId%><br><%=teamCulb%><br><%=teamDesc%><br><%=teamLoc%><br><%=nickname%>
 <%}
 if(request.getParameter("response").equals("page")){
 try {
			vparam.add("10");
			vparam.add(request.getParameter("pageid"));
			vparam.add(request.getParameter("status"));
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_pagedspteammst", vparam, "ScoreDB");
			vparam.removeAllElements();
			}catch(Exception e){
			e.printStackTrace();
			}

 if(crsObjResult!=null){
 try{
 out.print("Page:"+request.getParameter("pageid"));
 %> 
 <table width="100%" height="100%" align="center" border="1" id="displayResult" cellspacing="0" cellpadding="0">
 
             <tr  style="background-color: #dde2f2;">
				<td style="font-weight: bold">TeamName</td>
				<td style="font-weight: bold">Abbreviation</td>
				<td style="font-weight: bold">Club</td>
				<td style="font-weight: bold">TeamLocation</td>
				<td style="font-weight: bold">Description</td>
			</tr>
 <%
 while(crsObjResult.next()){
  %> 
 <TR> 
 <td><%=crsObjResult.getString("nickname")%></td>
 <td><%=crsObjResult.getString("team_name")%></td>
 <td><%=crsObjResult.getString("clubname")%></td>
 <td><%=crsObjResult.getString("team_location")%></td>
 <td><%=crsObjResult.getString("description")%></td>
 </TR>
 <%
 }
 }catch(Exception e){
 e.printStackTrace();
 }
 %> 
 </table>
 <%
 }

 }
 %>