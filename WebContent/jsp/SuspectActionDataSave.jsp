<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="in.co.paramatrix.common.*"%>
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
	ReplaceApostroph replaceApos = new ReplaceApostroph();
	String gsmatch_id = request.getParameter("match_id")==null?"0":request.getParameter("match_id");
	String gsUserLoginId = request.getParameter("UserID")==null?"0":request.getParameter("UserID");
	String gsPlayerRoleId = request.getParameter("playerRoleId")==null?"0":request.getParameter("playerRoleId");
	String gsRemark = request.getParameter("Remark")==null?"0":request.getParameter("Remark");	
	gsRemark = replaceApos.replacesingleqt(gsRemark);
	String gsFlag = request.getParameter("gsFlag")==null?"0":request.getParameter("gsFlag");
	String gsUserRole= request.getParameter("userRole")==null?"0":request.getParameter("userRole");
	System.out.println("gsPlayerRoleId "+gsPlayerRoleId);
	System.out.println("gsRemark "+gsRemark); 
	String flag = "1";
	//String gsFlag = "1";

	CachedRowSet  crsObjSuspectAction = null;
	CachedRowSet  crsObjDisplaySuspectAction = null;
	

	Vector vparam =  new Vector();
	Vector vdspparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

		//To save Suspect Action Data.
		if(request.getParameter("playerRoleId")!= null){
			try{
				vparam.add(gsmatch_id);
				vparam.add(gsUserLoginId);
				vparam.add(gsPlayerRoleId);
				vparam.add(gsRemark);
				vparam.add(gsFlag);
				crsObjSuspectAction = lobjGenerateProc.GenerateStoreProcedure(
					"esp_amd_officialplayerremark",vparam,"ScoreDB");
				vparam.removeAllElements();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		// To display all records of the selected match
		vdspparam.add(flag);
		vdspparam.add(gsmatch_id);
		vdspparam.add("1"); //season
		vdspparam.add(gsUserRole); 
		vdspparam.add(gsUserLoginId); 
		crsObjDisplaySuspectAction = lobjGenerateProc.GenerateStoreProcedure(
					//"esp_dsp_officialplayerremark",vdspparam,"ScoreDB");
					"esp_dsp_officialplayersuspectremark",vdspparam,"ScoreDB");
				
		vdspparam.removeAllElements();
%>
<div id="SavedSuspectActionDiv">
	<table width="980" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr class="contentDark">
			<td align="left" class="colheadinguser">Player Name</td>
			<td align="left" class="colheadinguser">Remark</td>
			<td align="left" class="colheadinguser">Delete Record</td>
		</tr>
		<%if(crsObjDisplaySuspectAction != null){
		int counter = 1;
				while(crsObjDisplaySuspectAction.next()){
		if(counter % 2 != 0){%>
		<tr class="contentLight">
<%				}else{
%>		<tr class="contentDark">
<%				}
%>			<td align="left" id="<%=counter++%>"><%=crsObjDisplaySuspectAction.getString("name")%></td>
			<td align="left"><%=crsObjDisplaySuspectAction.getString("remark")%></td>
			<td align="left"><a id="deletelink" name="deletelink" href="javascript:DeleteSuspectAction('<%=crsObjDisplaySuspectAction.getString("player")%>')">Delete</a></td>
<%			}//end of while	
}//end of if
%>		</tr>
	</table>
</div>
