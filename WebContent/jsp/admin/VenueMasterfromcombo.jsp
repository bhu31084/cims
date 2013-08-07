
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

        CachedRowSet crsObjResult = null;
        CachedRowSet crsObjResultstate = null;
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		if(request.getParameter("response").equals("search")){
			String veneueid= request.getParameter("VenueId");
			String name=null;		
			String address=null;		
			String plot=null;
			String locationid=null;
			String district=null;
			String street=null;
			String end1=null;
			String end2=null;		
			String state=null;
			String city=null;
			String pin =null;
			String stateid=null;
			String club = null;
			try {
				vparam.add(veneueid);
				crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_venuesearch", vparam, "ScoreDB");
				vparam.removeAllElements();
	
				while (crsObjResult.next()) {
	             name= crsObjResult.getString("name"); 
	             address =crsObjResult.getString("address1");
	             locationid =crsObjResult.getString("location");
	             plot= crsObjResult.getString("plot"); 
	              street= crsObjResult.getString("street");
	             district =crsObjResult.getString("district");
	             end1= crsObjResult.getString("end1"); 
	             end2 =crsObjResult.getString("end2");
	             state= crsObjResult.getString("state"); 
	             stateid= crsObjResult.getString("stateid"); 
	             city =crsObjResult.getString("city");
	             pin= crsObjResult.getString("pin");
	             club = crsObjResult.getString("club");
	             System.out.println("get club "+club);             
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		
%>
	
  <%=club%><br><%=veneueid%><br><%=name%><br><%=address%><br><%=locationid%><br><%=street%><br><%=plot%><br><%=district%><br><%=end1%><br><%=end2%> <br><%=state%><br><%=city%><br><%=pin%>
<br><%=stateid%><br>

 <%
 try {
			vparam.add(stateid);
			crsObjResultstate = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_citysearch", vparam, "ScoreDB");
			vparam.removeAllElements();
			%>
			<select class="input" style="width:6cm" id="itemlist5" name="itemlist5" size="5"
			onkeypress="update5(event)"		onclick="update5(event)">
<%
			while (crsObjResultstate.next()) {
			%>
			<option value="<%=crsObjResultstate.getString("id")%>" ><%=crsObjResultstate.getString("name")%> </option>
			
			<%
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
%>
        </select>
 
 <%
 }
 if(request.getParameter("response").equals("page")){
 try {
			vparam.add("10");
			vparam.add(request.getParameter("pageid"));
			vparam.add(request.getParameter("status"));
			crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_pagedspvenuemst", vparam, "ScoreDB");
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
				<td style="font-weight: bold">VenueName</td>
				<td style="font-weight: bold">Address</td>
				<td style="font-weight: bold">Plot</td>
				<td style="font-weight: bold">District</td>
				<td style="font-weight: bold">Street</td>
				<td style="font-weight: bold">VenueLocation</td>
				<td style="font-weight: bold">End1</td>
				<td style="font-weight: bold">End2</td>
				<td style="font-weight: bold">Pin</td>
				<td style="font-weight: bold">club</td>
			</tr>
 <%
 while(crsObjResult.next()){
  %> 
 <TR> 
 <td><%=crsObjResult.getString("name")%></td>
 <td><%=crsObjResult.getString("address")%></td>
 <td><%=crsObjResult.getString("plot")%></td>
 <td><%=crsObjResult.getString("district")%></td>
 <td><%=crsObjResult.getString("street")%></td>
 <td><%=crsObjResult.getString("locationname")%></td>
 <td><%=crsObjResult.getString("end1")%></td>
 <td><%=crsObjResult.getString("end2")%></td>
 <td><%=crsObjResult.getString("pin")%></td>
 
 <%if(crsObjResult.getString("club_name") == null || crsObjResult.getString("club_name") == ""){%>
 	<td>Not Mentioned</td>	
<% }else{%>
	<td><%=crsObjResult.getString("club_name")%></td>
<%}%>
 
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
 