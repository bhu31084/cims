<!--
	Page Name 	 : SMSResponse.jsp
	Created By 	 : Dipti Shinde.
	Created Date : 12th Mar 2009.
	Description  : To display sms acceptancereply .
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.sms.SmsSender"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,java.io.*,java.lang.*"%>

<%  
	response.setHeader("Pragma", "private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
	CachedRowSet acceptedDataCrs = null;
	GenerateStoreProcedure generateStProc = new GenerateStoreProcedure();
	Vector spParaVec = new Vector();
	String acceptanceFlag = request.getParameter("accFlag").trim()== null ? "0": request.getParameter("accFlag").trim();
	String pageNum = request.getParameter("pageNum").trim()== null ? "1": request.getParameter("pageNum").trim();
	String season = request.getParameter("season").trim()== null ? "1": request.getParameter("season").trim();
	String matchid = request.getParameter("matchid").trim()== null ? "": request.getParameter("matchid").trim();
	String acceptValue = null;
	String totPages = null;
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//2009-04-03 16:14:46
	java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
	String displaySendDate = null;
	String displayConfirmedDate = null;
		
   	try{
   		spParaVec.add(pageNum);//page number
   		spParaVec.add(season);//season  		
		spParaVec.add(acceptanceFlag);
		spParaVec.add(matchid);
		acceptedDataCrs = generateStProc.GenerateStoreProcedure("esp_matchofficialconfirmation_status", spParaVec, "ScoreDB");
		spParaVec.removeAllElements();	
	}catch(Exception e){
		 e.printStackTrace();
		 out.println(e);
	}
	if(acceptedDataCrs != null && acceptedDataCrs.size() > 0){
		
		while(acceptedDataCrs.next()){
			totPages = acceptedDataCrs.getString("noofpages");
		}
		acceptedDataCrs.beforeFirst();
	}
%>
<html>
  <head>
  
  </head>
  <title>SMS Approval</title> 
  <body>
  	<table width="100%" border="1">
<% 	//recordno,match_id,displayname,role,status,confirmed_through,confirmed_by_id,confirmed_by,send_ts,confirmed_at,messagecontent,statechange_ts,reply_phone,confirmed,noofpages
	
	if(acceptedDataCrs != null && acceptedDataCrs.size() > 0){
%> 		<tr>
  			<td colspan="8" class="contentDark">
  				<input type="button" class="btn btn-small"  id="btnBack" name="btnBack" value="  <<  " onclick="callNavigate('1')">&nbsp;&nbsp;
  				<input type="button" class="btn btn-small"  id="btnNext" name="btnNext" value="  >>  " onclick="callNavigate('2')">&nbsp;&nbsp;
  				<input type="text" id="txtPage" name="txtPage" value="<%=pageNum%>" size="2">&nbsp;&nbsp; of &nbsp;<%=totPages%>&nbsp;
  				<input type="button" class="btn btn-small"  id="btnGo" name="btnGo" value="   Go   " onclick="callNavigate('3')">
  			</td>
  		</tr>
<%		}
%>  		
		<tr class="contentDark">
			<td class="colheading" align="center">Receiver</td>
			<td  class="colheading" align="center">Role</td>
			<td  class="colheading" align="center">Contact Number</td>
			<td class="colheading" align="center">Match Id</td>
			<td class="colheading" align="center">&nbsp;&nbsp;&nbsp;Send&nbsp;&nbsp;Date</td>
<%				if(acceptanceFlag.length() == 0){  //for all				
%>			<td class="colheading" align="center">Status</td>
<%				}
%> 			
			<td class="colheading" align="center">&nbsp;Accepted&nbsp; Date</td>	
			<td class="colheading" align="center">Message</td>
		</tr>
<% 		if(acceptedDataCrs != null && acceptedDataCrs.size() > 0){
			while(acceptedDataCrs.next()){
%>		<tr class="contentLight">
			<td align="center"><%=acceptedDataCrs.getString("displayname")%></td>
			<td align="center"><%=acceptedDataCrs.getString("role")%></td>
			<td align="center"><%=acceptedDataCrs.getString("reply_phone").trim().length() == 0 ? "-" : acceptedDataCrs.getString("reply_phone")%></td>
			<td align="center"><%=acceptedDataCrs.getString("match_id")%></td>
<%
			java.util.Date date = sdf1.parse(acceptedDataCrs.getString("send_ts"));
			displaySendDate = sdf2.format(date);
%>			
			<td align="center"><%=acceptedDataCrs.getString("send_ts").equalsIgnoreCase("1900-01-01 00:00:00") ? "-" : displaySendDate%></td>
<%				if(acceptanceFlag.length() == 0){ 
					if(acceptedDataCrs.getString("confirmed_by").trim().length() != 0){ 				
%>			<td align="center"><%=acceptedDataCrs.getString("status")%>&nbsp;-&nbsp;<%=acceptedDataCrs.getString("confirmed_by")%>&nbsp;-&nbsp;<%=acceptedDataCrs.getString("confirmed_through")%></td>
<%					}else{%>
			<td align="center"><%=acceptedDataCrs.getString("status")%></td>
<%					}
				}
%> 			
<%			java.util.Date date2 = sdf1.parse(acceptedDataCrs.getString("confirmed_at"));
			displayConfirmedDate = sdf2.format(date2);
%>		
			<td align="center"><%=acceptedDataCrs.getString("confirmed_at").equalsIgnoreCase("1900-01-01 00:00:00") ? "-" : displayConfirmedDate%></td>
<%			if(acceptedDataCrs.getString("messagecontent").trim().length() == 0 ){%>
			<td align="center"> -
				<input type="hidden" id="hdTotalPages" name="hdTotalPages" value="<%=acceptedDataCrs.getString("noofpages")%>">
			</td>
<%			}else{%>
			<td><%=acceptedDataCrs.getString("messagecontent")%>
				<input type="hidden" id="hdTotalPages" name="hdTotalPages" value="<%=acceptedDataCrs.getString("noofpages")%>">
			</td>
<%			}
%>			
		</tr>
<%
			}//end While
		}else{//end if
%>			<tr class="contentLight">
				<td width="100%" align="center" colspan="7"><font color="red">No Data present.</font></td>
			</tr>
				
<%		}
%>
		<input type="hidden" id="hdPageNumber" name="hdPageNumber" value="1" >
		<input type="hidden" id="hdAcceptFlag" name="hdAcceptFlag" value="<%=acceptanceFlag%>" >
		<input type="hidden" id="hidSeason" name="hidSeason" value="<%=season%>" >
		<input type="hidden" id="hidMatchid" name="hidMatchid" value="<%=matchid%>">
		
	</table>
  </body>
</html>