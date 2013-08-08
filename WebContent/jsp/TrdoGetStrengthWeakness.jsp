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
	String playerId = request.getParameter("playerId")==null?"0":request.getParameter("playerId");
	String RoleId = request.getParameter("RoleId")==null?"0":request.getParameter("RoleId");

	//String StrengthId = request.getParameter("StrengthId")==null?"0":request.getParameter("StrengthId");
	//String WeaknessId = request.getParameter("WeaknessId")==null?"0":request.getParameter("WeaknessId");	
	String retval = null;

	String StrengthId = "S";
	String WeaknessId = "W";
	//var strength = "S";
	//var weakness = "W";

	System.out.println("playerId "+playerId);
	System.out.println("RoleId "+RoleId);
	System.out.println("StrengthId "+StrengthId);
	
	CachedRowSet  crsObjGetStrength = null;
	CachedRowSet  crsObjGetWeakness = null;
	Vector vStrparam =  new Vector();
	Vector vWeakparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

		try{
			vStrparam.add(StrengthId);
			vStrparam.add(RoleId);
			crsObjGetStrength = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_strengths_weakness_list",vStrparam,"ScoreDB");
			vStrparam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
	 		e.printStackTrace();
		}

		try{
			vWeakparam.add(WeaknessId);	
			vWeakparam.add(RoleId);	
			crsObjGetWeakness = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_strengths_weakness_list",vWeakparam,"ScoreDB");
			vWeakparam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
	 		e.printStackTrace();
		}
%>					
<div id="StrengthDiv"> 	
	<select	id="lbChooseStrengthFrom" multiple="multiple" size="10" STYLE="width: 180px; height: 218px; overflow: scroll"  >
	<%	if(crsObjGetStrength != null){
			while(crsObjGetStrength.next()){				
%>		<option value="<%=crsObjGetStrength.getString("id")%>"><%=crsObjGetStrength.getString("name")%></option>
<%			}
		}
%>					
	</select>							
</div>
<br>
<div id="WeaknessDiv"> 	
	<select	id="lbChooseWeaknessFrom" multiple="multiple" size="10" STYLE="width: 180px; height: 218px; overflow: scroll"  >
	<%while(crsObjGetWeakness.next()){				
%>		<option value="<%=crsObjGetWeakness.getString("id")%>"><%=crsObjGetWeakness.getString("name")%></option>
<%		}
%>	</select>						
</div>