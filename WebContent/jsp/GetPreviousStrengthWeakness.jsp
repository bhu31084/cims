<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
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
	String StrengthId = "S";
	String WeaknessId = "W";

	String retval = null;
	System.out.println("playerId "+playerId);
	System.out.println("RoleId "+RoleId);
	System.out.println("StrengthId "+StrengthId);
	System.out.println("WeaknessId "+WeaknessId);
	
	CachedRowSet  crsObjPreStrength = null;
	CachedRowSet  crsObjPreWeakness = null;
	Vector vStrparam =  new Vector();
	Vector vWeakparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

	try{
		vStrparam.add(playerId);
		vStrparam.add(RoleId);
		vStrparam.add(StrengthId);
		crsObjPreStrength = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_playerattr",vStrparam,"ScoreDB");
		vStrparam.removeAllElements();
	}catch (Exception e) {
		System.out.println("Exception"+e);
		e.printStackTrace();
	}
	try{
		vWeakparam.add(playerId);
		vWeakparam.add(RoleId);
		vWeakparam.add(WeaknessId);
		crsObjPreWeakness = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_playerattr",vWeakparam,"ScoreDB");
		vWeakparam.removeAllElements();
	}catch (Exception e) {
		System.out.println("Exception"+e);
		e.printStackTrace();
	}
%>
<div id="PreviousStrengthDiv">
				<select	id="lbChooseStrengthTo" multiple="multiple" size="10" STYLE="width: 180px; height: 218px; overflow: scroll"  >
<%		if(crsObjPreStrength != null){
					while(crsObjPreStrength.next()){
%>					<option value="<%=crsObjPreStrength.getString("id")%>"><%=crsObjPreStrength.getString("name")%></option>
<%					}
				}
%>
				</select>
</div>
<br>
<div id="PreviousWeaknessDiv">
				<select	id="lbChooseWeaknessTo" multiple="multiple" size="10" STYLE="width: 180px; height: 218px; overflow: scroll">
<%					if(crsObjPreWeakness != null){
						while(crsObjPreWeakness.next()){%>
					<option value="<%=crsObjPreWeakness.getString("id")%>"><%=crsObjPreWeakness.getString("name")%></option>
<%						}
					}
%>
				</select>
</div>