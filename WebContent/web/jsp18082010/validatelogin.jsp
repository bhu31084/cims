
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
	try {		
		String username = "";   		
		username = request.getParameter("username")==null?"":request.getParameter("username");		
		//topPerformerflag = request.getParameter("topPerformerflag")==null?"":request.getParameter("topPerformerflag");
		
		CachedRowSet 			crsObjGetuserdetail        =	null;
		GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
		Vector 					vParam 					=  	new Vector();
		String message = null;
		
			
		String topPerformerflag = "";
		vParam.removeAllElements();
		String password = "";
		String role = "";
		String uname = "";
		String user_role_id = "";
		
		
		try{
			//to get the association list points,club_name,club_id
			vParam.add(username);//season id			
			System.out.println("vParam  ***  "+vParam);
			crsObjGetuserdetail = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_validate_username_pass",vParam,"ScoreDB");
			vParam.removeAllElements();
			
			if(crsObjGetuserdetail != null){
				while(crsObjGetuserdetail.next()){					
					uname = crsObjGetuserdetail.getString("nickname");
					role = crsObjGetuserdetail.getString("role");
					password = crsObjGetuserdetail.getString("password");
					user_role_id = crsObjGetuserdetail.getString("user_role_id");
				}
			}
			
		}catch (Exception e) {
			System.out.println("*************Validatelogin.jsp*****************"+e);
		}	
if(uname != null){%>
	<input type="hidden" id="txtname" name="txtname" value="<%=uname%>">
	<input type="hidden" id="txtrole" name="txtrole" value="<%=role%>">
	<input type="hidden" id="txtpass" name="txtpass" value="<%=password%>">
	<input type="hidden" id="txtuserroleid" name="txtuserroleid" value="<%=user_role_id%>">
<%}
	
%>

<%--<div id="userdata" >--%>
<%--		<table><tr><td>--%>
		
<%--		 --%>
<%--		 --%>
<%--		<input type="hidden" id="txtuserroleid" name="txtuserroleid" value="<%=user_role_id%>"> --%>
<%--		</td></tr></tabel> --%>
<%--</div>--%>
<%} catch (Exception e) {
			System.err.println(e.toString());
		}%>