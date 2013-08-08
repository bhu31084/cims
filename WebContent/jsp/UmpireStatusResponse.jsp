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
	String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
	String gsUserId = request.getParameter("userId")==null?"0":request.getParameter("userId");
	String gsStatus = request.getParameter("status")==null?"0":request.getParameter("status");	
	String gsReturnMessage = "";
	String gsuserflg = "2";
	String remark = "";
	System.out.println("gsUserId "+remark);
	String userRoleId = "";
	userRoleId = session.getAttribute("user_role_id").toString();
	CachedRowSet  crsObjInsertStatus = null;			
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	CachedRowSet  crsObj= null;
	String role="0";
	
	try{		       
	        vparam.add(gsUserId);
	       // out.println("userId "+gsUserId);
			crsObj = lobjGenerateProc.GenerateStoreProcedure("esp_adm_loginrole", vparam, "ScoreDB");
			if(crsObj!=null){
			while(crsObj.next()){
			role=crsObj.getString("role");
			System.out.println("role is "+role);
			}
		}
		vparam.removeAllElements();
	}catch(Exception e){
		e.printStackTrace();
	}
		if(request.getParameter("matchId")!= null){
			try{
				vparam.add(matchId);
				vparam.add(userRoleId);
				vparam.add("");
				vparam.add(remark);
				vparam.add(gsStatus);
				vparam.add(gsuserflg);
				crsObjInsertStatus = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_officialacceptance",vparam,"ScoreDB");
				vparam.removeAllElements();
				if(crsObjInsertStatus != null){
					while(crsObjInsertStatus.next()){
						if(role.equalsIgnoreCase("9")){
							gsReturnMessage = crsObjInsertStatus.getString("retvalue");
						}else{
							gsReturnMessage = crsObjInsertStatus.getString("retvalue");
						}						
						System.out.println("gsReturnMessage "+gsReturnMessage);
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
%>
	<div id="divReturnMessage" ><label><%=gsReturnMessage%></label>
	</div>