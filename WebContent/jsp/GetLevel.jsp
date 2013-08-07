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
	String gsLevel = request.getParameter("level")==null?"0":request.getParameter("level");
	System.out.println("level "+gsLevel);
	System.out.println("level*********** ");
	String flag = "1";
	
	CachedRowSet  crsObjOffences = null;	
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	
	//To save Breaches Data.
		if(request.getParameter("level")!= null){
			try{
					vparam.add(flag);//1
					vparam.add(gsLevel);//1					
					crsObjOffences = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_breaches_list",vparam,"ScoreDB");
					vparam.removeAllElements();
				}catch (Exception e) {
					System.out.println("Exception"+e);
		    		e.printStackTrace();
				}
		}%>	
		
<div id="OffencesDiv"> 
	<table>
		<tr>
		<td>
				<select name="dpOffence" id="dpOffence">
					<option value="0" >Select </option>
<%					if(crsObjOffences != null){
						while(crsObjOffences.next()){%>
<%						//	if(crsObjBreachesList.getString("userroleid").equalsIgnoreCase("")){%>
					<option value="<%=crsObjOffences.getString("id")%>" ><%=crsObjOffences.getString("name")%></option>
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
	
	