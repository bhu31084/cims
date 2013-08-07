<!--
Page name	 : UserMaster.jsp
Replaced By  : Vaibhav Gaikar. 
Created Date : 17th Sep 2008
Description  : To add User details in Database
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.csms.logwriter.LogWriter"%>

<%  response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
	String roleId		= "";
	String userId		= "";
	String userRole		= "";
	String userRoleId   = "";	
	String id = null;
	String userName = null;
	String contactNumber = null;
	String searchUserName = null;
	
	CachedRowSet  userDataCrs	 =  null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
    Vector spParamVec 			     =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

	userRole   = request.getParameter("userRole")!=null?request.getParameter("userRole").trim():"";
	userRoleId = request.getParameter("userRoleId")!=null?request.getParameter("userRoleId").trim():"";
	searchUserName = request.getParameter("userName")!=null?request.getParameter("userName").trim():"";

	try{
		  spParamVec.add(userRoleId);	
		  spParamVec.add(searchUserName);
		  userDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialnamewith_contactno",spParamVec,"ScoreDB");
		  spParamVec.removeAllElements();	
	}catch(Exception e){
		  e.printStackTrace();
	}
	
%>
<div id="resultDiv"  name="resultDiv"  style="overflow:auto;height:10em;width:53em; ">
  <table width="100%" align=center >
   
<%    try{
	  if(userDataCrs != null && userDataCrs.size() > 0){
%>
	 <tr  valign="top">
	  <td align=center><input type="checkbox" name="chkAll" id="chkAll" onclick="getAllContactNum()"></td>
	  <td align="left" class="colheadinguser">User Name</td>
	  <td align=center class="colheadinguser">Contact Number</td>
    </tr>			
<%
	
	  userDataCrs.beforeFirst();
	  int count = 0;
		while(userDataCrs.next()){	
		 id 	= userDataCrs.getString("id")!=null?userDataCrs.getString("id").trim():"";
		 userName    	= userDataCrs.getString("fullname")!=null?userDataCrs.getString("fullname").trim():"";
		 contactNumber    	= userDataCrs.getString("contactnum")!=null?userDataCrs.getString("contactnum").trim():"";
		if(contactNumber.length() == 0){
			contactNumber = "-";
		}
		if(count%2 == 0){ 
%>
	<tr class="contentDark" valign="top">
<%		}else{
%>		
	<tr class="contentLight" valign="top">
<%		}
%>
	   <td width="10%" align=center><input type="checkbox" name="chkUser" id="chkUser" value="<%=contactNumber%>"/></td>
	   <td width="60%" align=left><%=userName%></td>
	   <td width="30%" align=center><%=contactNumber%></td>
	</tr>	
	
<%	count++;
   		}
	 }else{
%>
	<tr>
	   <td align=center colspan=3><font color="red">Record Not Found.</font></td>
	</tr>	
<%	 }
	}catch(Exception e){
		e.printStackTrace();
	}
%>		
  </table>	
</div>
<br>
<%	 if(userDataCrs != null && userDataCrs.size() > 0){
%>
  <table width="100%">
  	<tr>
  		<td align="center">
			<input type="button" class="button1" id="btnOk" value="ADD Contact Numbers" onclick="getContactNum()">
		</td>
	</tr>	
  <table>	
<%	}
%>  	