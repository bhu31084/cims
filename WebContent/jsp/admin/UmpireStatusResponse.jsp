<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
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
	String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
	String gsUserId = request.getParameter("userId")==null?"0":request.getParameter("userId");
	String gsStatus = request.getParameter("status")==null?"0":request.getParameter("status");
	String gsuserflag = request.getParameter("userflag")==null?"0":request.getParameter("userflag");	
	String gsReturnMessage = "";
	String remark = request.getParameter("remark")==null?"-":request.getParameter("remark");
	String userRoleId = "";
	userRoleId = session.getAttribute("user_role_id").toString();
	CachedRowSet  crsObjInsertStatus = null;			
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	CachedRowSet  crsObj= null;
	String role="0";	
	
		if(request.getParameter("matchId")!= null){
			try{
					vparam.add(matchId);
					vparam.add(userRoleId);//User role id whose status has to be done y or n
					vparam.add(gsUserId);
					vparam.add(remark);
					vparam.add(gsStatus);//Status Y or N
					vparam.add(gsuserflag);//To set status for all officials in Match_official_map table against selected matchid
					crsObjInsertStatus = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialacceptance",vparam,"ScoreDB");
					vparam.removeAllElements();
					if(crsObjInsertStatus != null){
						while(crsObjInsertStatus.next()){
							gsReturnMessage = crsObjInsertStatus.getString("retvalue");
						}
					}					
				}catch(Exception e){
					e.printStackTrace();
				}
			}
	
%>
	<div id="divReturnMessage" ><label><%=gsReturnMessage%></label>
	</div>