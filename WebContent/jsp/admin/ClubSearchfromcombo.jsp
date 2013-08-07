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
		String clubname=null;
		String statename=null;		
		String zonename=null;
		String parent=null;
		String zoneid=null;
		String stateid=null;
		String clubid= request.getParameter("ClubId");
		try {
			vparam.add(clubid);
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_clubsearch", vparam, "ScoreDB");
			vparam.removeAllElements();

			while (crsObjResult.next()) {
			 clubid =crsObjResult.getString("id"); 
             clubname= crsObjResult.getString("name"); 
             zoneid =crsObjResult.getString("zone");
             stateid =crsObjResult.getString("state");            
             statename= crsObjResult.getString("statename");
              zonename= crsObjResult.getString("zonename");
               parent= crsObjResult.getString("parent");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
	
  <%=clubid%><br><%=clubname%><br><%=stateid%><br><%=zoneid%><br><%=statename%><br><%=zonename%>
 
 <%}
 if(request.getParameter("response").equals("page")){
 try {
			vparam.add("10");
			vparam.add(request.getParameter("pageid"));
			vparam.add(request.getParameter("status"));
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_pagedspclubmst", vparam, "ScoreDB");
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
				<td style="font-weight: bold">ClubName</td>
				<td style="font-weight: bold">State</td>
				<td style="font-weight: bold">Zone</td>
			</tr>
 <%
 while(crsObjResult.next()){
  %> 
 <TR> 
 <td><%=crsObjResult.getString("name")%></td>
 <td><%=crsObjResult.getString("statename")%></td>
 <td><%=crsObjResult.getString("zonename")%></td>
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