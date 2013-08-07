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
	String gsproperty = request.getParameter("Property")==null?"0":request.getParameter("Property");
	String gsplayerrole = request.getParameter("player_role")==null?"0":request.getParameter("player_role");
	
	System.out.println("gsplayerrole "+gsplayerrole);
	System.out.println("gsproperty "+gsproperty);
	
	CachedRowSet  crsObjStrengths = null;	
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	
	//To get the strengths and weaknesses of players.
		try{
					
					vparam.add(gsplayerrole);
					vparam.add(gsproperty);					
					System.out.println("Vector is "+vparam);					
					crsObjStrengths = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_strengths_weakness_list",vparam,"ScoreDB");
					vparam.removeAllElements();
				}catch (Exception e) {
					System.out.println("Exception"+e);
		    		e.printStackTrace();
				}
		%>	
		
<div id="StrengthDiv"> 
	<table>
		<tr>
		<td>
				<select name="dpStrength" id="dpStrength">
					<option value="0" >-Select-</option>
<%					if(crsObjStrengths != null){
						while(crsObjStrengths.next()){%>
<%						//	if(crsObjBreachesList.getString("userroleid").equalsIgnoreCase("")){%>
					<option value="<%=crsObjStrengths.getString("id")%>" ><%=crsObjStrengths.getString("name")%></option>
<%					   //	}else{%>
<%						//	}
						}
					}
%>					<input type="hidden" id="hdPlayerName" name="hdPlayerName" value="">
				</select>
			</td>
		</tr>	
	</table>
</div>		
	
	