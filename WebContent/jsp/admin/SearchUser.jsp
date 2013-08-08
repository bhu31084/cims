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
%>
<%  Common commonUtil		  	 =  new Common();
    CachedRowSet  userDataCrs	 =  null; 
    CachedRowSet  crsObjStateCrs =  null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
    Vector vparam 			     =  new Vector();
%>
<%	String nickName	 	= "";
	String fName   	 	= "";
	String mName   	 	= "";
	String sName		= "";
	String disName		= ""; 
	String address		= "";
	String password 	= "";
	String pass_encr	= "";
	String pob			= "";
	String dob			= "";
	String sex 			= "";
	String roleId		= "";
	String id			= "";
	String hidUserId	= "";
	String status		= "";
	String matchId		= "";
	String param		= "";
	String retValue		= "";
	String remark		= "";
	String userId		= "";
	String userRole		= "";	
	String flag			= "";
	String teamName 	= "";
	String clubname 	= "";
	String userRoleId	= "";
	String countryId	= "";
	String stateId		= "";
	String locationId	= "";
	String hidpaging	= "";
	String pageNo		= "";
	String lastPageNo	= "";
	String matchCount   = "";
    String dispnickflag	= "";
	String matchCountFlag = "";

	matchId 		    = (String)session.getAttribute("matchid");
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	LogWriter log 		= new LogWriter();
%>
<%  nickName   = request.getParameter("nickName")!=null?request.getParameter("nickName").trim():"";
	fName      = request.getParameter("firstName")!=null?request.getParameter("firstName").trim():"";
	mName      = request.getParameter("middleName")!=null?request.getParameter("middleName").trim():"";
	sName	   = request.getParameter("lastName")!=null?request.getParameter("lastName").trim():"";
	disName	   = request.getParameter("displayName")!=null?request.getParameter("displayName").trim():"";
	param 	   = request.getParameter("param")!=null?request.getParameter("param").trim():"";
	userId	   = request.getParameter("userId")!=null?request.getParameter("userId").trim():"";
	userRole   = request.getParameter("userRole")!=null?request.getParameter("userRole").trim():"";
	userRoleId = request.getParameter("userRoleId")!=null?request.getParameter("userRoleId").trim():"";
	countryId  = request.getParameter("countryId")!=null?request.getParameter("countryId").trim():"";
	stateId	   = request.getParameter("stateId")!=null?request.getParameter("stateId").trim():""; 	 	
    dispnickflag= request.getParameter("flag")!=null?request.getParameter("flag").trim():""; 

%>
<%// to get state based on city
try{
	if (param.equalsIgnoreCase("8")){
%>	
				<select class="input" name="selState" id="selState" onchange="getLocation()" >
						<option value="0">--select--</option>
<%		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add(countryId);
		vparam.add("4");
        crsObjStateCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_userInfo",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjStateCrs != null){	
			while(crsObjStateCrs.next()){	
%>							
						<option value="<%=crsObjStateCrs.getString("id")%>" <%=stateId.equals(crsObjStateCrs.getString("id"))?"selected":""%>><%=crsObjStateCrs.getString("name")%></option>
						<%--
						<%=playerId.equals(userDataCrs.getString("role"))?"selected":"" %>
						--%>
<%			}
		 }
%>	
				</select>	
<%	}
}catch(Exception e)	{
}
%>

<%// to get location based on state
try{
	if (param.equalsIgnoreCase("9")){
%>		
		 		<select class="input" name="selLocation" id="selLocation" >
						<option value="0">--select--</option>
<%		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add("");
		vparam.add(stateId);
		vparam.add("5");
        crsObjStateCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_userInfo",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjStateCrs != null){	
			while(crsObjStateCrs.next()){	
%>							
						<option value="<%=crsObjStateCrs.getString("id")%>" <%=locationId.equals(crsObjStateCrs.getString("id"))?"selected":""%>><%=crsObjStateCrs.getString("name")%></option>
						<%--
						<%=playerId.equals(userDataCrs.getString("role"))?"selected":"" %>
						--%>
<%			}
		 }
%>	
				</select>	
<%	}
}catch(Exception e)	{
}
%>

<%// to validate nickname and displayname
	try{
		if (param.equalsIgnoreCase("1")){
		    vparam.add("");
			vparam.add(nickName);
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add(disName);
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add(userId);
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("4");
	  		userDataCrs = lobjGenerateProc.GenerateStoreProcedure("amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
			if(userDataCrs != null && userDataCrs.size() > 0){	
				while(userDataCrs.next()){	
						retValue   = userDataCrs.getString("Retvalue");
						if (retValue.equalsIgnoreCase("1")){
							remark = userDataCrs.getString("Remark");
						}else if(retValue.equalsIgnoreCase("2")){
							remark = userDataCrs.getString("Remark");	
						}
				}
		  }
	}  
	}catch(Exception e){
	}
%>
<%// to validate displayname
	try{
		if (param.equalsIgnoreCase("5")){
		    vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add(disName);
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add(userId);
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("5");
	  		userDataCrs = lobjGenerateProc.GenerateStoreProcedure("amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
			if(userDataCrs != null && userDataCrs.size() > 0){	
				while(userDataCrs.next()){	
						retValue   = userDataCrs.getString("Retvalue");
						if (retValue.equalsIgnoreCase("1")){
							remark = userDataCrs.getString("Remark");
						}else if(retValue.equalsIgnoreCase("2")){
							remark = userDataCrs.getString("Remark");	
						}
				}
		  }
	}  
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>
<%// to validate nickname
	try{
		if (param.equalsIgnoreCase("6")){
		    vparam.add("");
			vparam.add(nickName);
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add(userId);
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("6");
	  		userDataCrs = lobjGenerateProc.GenerateStoreProcedure("amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
			if(userDataCrs != null && userDataCrs.size() > 0){	
				while(userDataCrs.next()){	
						retValue   = userDataCrs.getString("Retvalue");
						if (retValue.equalsIgnoreCase("1")){
							remark = userDataCrs.getString("Remark");
						}else if(retValue.equalsIgnoreCase("2")){
							remark = userDataCrs.getString("Remark");	
						}
				}
		  }
		}  
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>
<%-- To validate first name and last name--%>
 <html>
 <head>
		<title> User Data </title>    
		<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
		<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
		 <script language="JavaScript">
		 		function wndclose(){
			 		window.opener="";
				     window.close();
				 }    
				 
				 function closeDuplicateDiv(){
					  document.getElementById("duplicateDiv").style.display = 'none';	
				 }
				 
		 </script>
 </head>
 <body>
 <IFRAME id="download_reports" src="" width="0" height="0" ></IFRAME>
<!-- To retrive data based on fname and lname-->
<%try{
if (param.equalsIgnoreCase("7") && dispnickflag.equalsIgnoreCase("1")){

				vparam.add(fName);
				vparam.add(sName);
				vparam.add("");
				vparam.add("");
				vparam.add("1");
		  		userDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_availableplayerdtls",vparam,"ScoreDB");
				vparam.removeAllElements();	
				if(userDataCrs != null && userDataCrs.size() > 0){	
						
%>				
				<table border=1 width=90% align=center> 
							<tr>
								<td colspan=7 align=center><font color=red>Records with similar name already exist.</font></td>
							</tr>
							<tr class="contentDark">
								<td class="colheadinguser" align=center>User name</td>	
								<td class="colheadinguser" align=center>Display name</td>
								<td class="colheadinguser" align=center>First name</td>
								<td class="colheadinguser" align=center>Middle name</td>
								<td class="colheadinguser" align=center>Last name</td>
							    <td class="colheadinguser" align=center>Team name</td>
                                <td class="colheadinguser" align=center>Club name</td>
							</tr>			
<%					while(userDataCrs.next()){	
								id		 = userDataCrs.getString("id")!=null?userDataCrs.getString("id").trim():"";
%>						    <tr>
								<td align=center><label><font color="#003399"><a href="javascript:passUserData('<%=id%>')"><%=userDataCrs.getString("nickname")!=null?userDataCrs.getString("nickname"):""%></a></font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("displayname")!=null?userDataCrs.getString("displayname"):""%>&nbsp;</font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("fname")!=null?userDataCrs.getString("fname"):""%>&nbsp;</font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("mname")!=null?userDataCrs.getString("mname"):""%>&nbsp;</font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("sname")!=null?userDataCrs.getString("sname"):""%>&nbsp;</font></label></td>
                                <td align=center><label><font color="#003399"><%=userDataCrs.getString("team_name")!=null?userDataCrs.getString("team_name"):""%>&nbsp;</font></label></td>
                                <td align=center><label><font color="#003399"><%=userDataCrs.getString("club_name")!=null?userDataCrs.getString("club_name"):""%>&nbsp;</font></label></td>
							</tr>
<%					}
%>					
			</table>	
			<table align=center>
				<tr>
						<td colspan=2> <font color=red>Still you want to add the records</font></td>
				</tr>
				<tr>
						<td>&nbsp;&nbsp;&nbsp;<input class="button1" type=button name=yes value=" YES " onclick="closeDuplicateDiv()">&nbsp;&nbsp;&nbsp;<input type=button name=no class="button1" value="  NO  " onclick="reset();closeDuplicateDiv()"></td>
						<td></td>
				</tr>
			</table>
<%		  }
%>			  
<%		}	  
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>
<!-- To retrive data based on display name-->
<%try{
if (param.equalsIgnoreCase("7") && dispnickflag.equalsIgnoreCase("2")){
            	vparam.add("");
				vparam.add("");
				vparam.add(disName);
				vparam.add("");
				vparam.add("2");
                                userDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_availableplayerdtls",vparam,"ScoreDB");
			        vparam.removeAllElements();	
				if(userDataCrs != null && userDataCrs.size() > 0){
%>
				<table border=1 width=90% align=center> 
							<tr>
								<td colspan=7 align=center><font color=red>Records with this display name already exist. Data can not be save.</font></td>
							</tr>
							<tr class="contentDark">
								<td class="colheadinguser" align=center>User name</td>	
								<td class="colheadinguser" align=center>Display name</td>
								<td class="colheadinguser" align=center>First name</td>
								<td class="colheadinguser" align=center>Middle name</td>
								<td class="colheadinguser" align=center>Last name</td>
							    <td class="colheadinguser" align=center>Team name</td>
                                <td class="colheadinguser" align=center>Club name</td>
							</tr>			
<%					while(userDataCrs.next()){	
								id		 = userDataCrs.getString("id")!=null?userDataCrs.getString("id").trim():"";
%>						    <tr>
								<td align=center><label><font color="#003399"><a href="javascript:passUserData('<%=id%>')"><%=userDataCrs.getString("nickname")!=null?userDataCrs.getString("nickname"):""%></a></font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("displayname")!=null?userDataCrs.getString("displayname"):""%>&nbsp;</font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("fname")!=null?userDataCrs.getString("fname"):""%>&nbsp;</font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("mname")!=null?userDataCrs.getString("mname"):""%>&nbsp;</font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("sname")!=null?userDataCrs.getString("sname"):""%>&nbsp;</font></label></td>
                                <td align=center><label><font color="#003399"><%=userDataCrs.getString("team_name")!=null?userDataCrs.getString("team_name"):""%>&nbsp;</font></label></td>
                                <td align=center><label><font color="#003399"><%=userDataCrs.getString("club_name")!=null?userDataCrs.getString("club_name"):""%>&nbsp;</font></label></td>
							</tr>
<%					}
%>					
			</table>	
			
<%		  }
%>			  
<%		}	  
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>
<!-- To retrive data based on display name-->
<%try{
if (param.equalsIgnoreCase("7") && dispnickflag.equalsIgnoreCase("3")){
       			vparam.add("");
				vparam.add("");
				vparam.add("");
				vparam.add(nickName);
				vparam.add("3");
                userDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_availableplayerdtls",vparam,"ScoreDB");
				vparam.removeAllElements();	
				if(userDataCrs != null && userDataCrs.size() > 0){
%>					<table border=1 width=90% align=center> 
							<tr>
								<td colspan=7 align=center><font color=red>Records with this username name already exist. Data can not be save.</font></td>
							</tr>
							<tr class="contentDark">
								<td class="colheadinguser" align=center>User name</td>	
								<td class="colheadinguser" align=center>Display name</td>
								<td class="colheadinguser" align=center>First name</td>
								<td class="colheadinguser" align=center>Middle name</td>
								<td class="colheadinguser" align=center>Last name</td>
							    <td class="colheadinguser" align=center>Team name</td>
                                <td class="colheadinguser" align=center>Club name</td>
							</tr>			
<%					while(userDataCrs.next()){	
								id		 = userDataCrs.getString("id")!=null?userDataCrs.getString("id").trim():"";
%>						    <tr>
								<td align=center><label><font color="#003399"><a href="javascript:passUserData('<%=id%>')"><%=userDataCrs.getString("nickname")!=null?userDataCrs.getString("nickname"):""%></a></font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("displayname")!=null?userDataCrs.getString("displayname"):""%>&nbsp;</font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("fname")!=null?userDataCrs.getString("fname"):""%>&nbsp;</font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("mname")!=null?userDataCrs.getString("mname"):""%>&nbsp;</font></label></td>
								<td align=center><label><font color="#003399"><%=userDataCrs.getString("sname")!=null?userDataCrs.getString("sname"):""%>&nbsp;</font></label></td>
                                <td align=center><label><font color="#003399"><%=userDataCrs.getString("team_name")!=null?userDataCrs.getString("team_name"):""%>&nbsp;</font></label></td>
                                <td align=center><label><font color="#003399"><%=userDataCrs.getString("club_name")!=null?userDataCrs.getString("club_name"):""%>&nbsp;</font></label></td>
							</tr>
<%					}
%>			</table>	
<%		  }
%>			  
<%		}	  
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>
<%
System.out.println("param param param param :"+param);
if (param.equalsIgnoreCase("1")){
%>		<span align=right><font color=red align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=remark%></font></span>
<%}
%>			
<%if (param.equalsIgnoreCase("3")){
%>		<span align=right><font color=red align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=remark%></font></span>
<%}
%>		
<%if (param.equalsIgnoreCase("5")){ 
%>		<span align=right><font color=red align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=remark%></font></span>	
<%}
%>			
<%if (param.equalsIgnoreCase("6")){
%>		<span align=right><font color=red align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=remark%></font></span>
<%}
%>	
<%	if ((!(param.equalsIgnoreCase("1"))) && (!param.equalsIgnoreCase("3")) && (!param.equalsIgnoreCase("5")) && (!param.equalsIgnoreCase("6")) && (!param.equalsIgnoreCase("7")) && (!flag.equalsIgnoreCase("1")) && (!param.equalsIgnoreCase("8")) && (!param.equalsIgnoreCase("9"))) {
%> 
	<form name="frmUser" id="frmUser" method=post>
			<input type=hidden name=hid id=hid value="" />
			<input type=hidden name=hiduserId id=hiduserId value=""/>
			<input type=hidden name=hidUpdate id=hidUpdate value=""/>
			<input type=hidden name=hidDelete id=hidDelete value=""/>
			<input type=hidden name=hidFlag id=hidFlag value="1" />
			<input type=hidden name=hidFlag id=hidFlag value="1" />
			<input type=hidden name=hidLastPageNo id=hidLastPageNo value=""/>
<%--			<input type=hidden name=hidUpdatePhoto id=hidUpdatePhoto value="1" />--%><!--by dipti-->
			<table width="0.1%" align="right">
					<tr>
						<td><a href="/cims/jsp/admin/PlayerSearch.jsp" class="btn btn-small" style="text-decoration:none;">BACK</a></td>
						<td align=right><input type=button value="ExportToExcel" onclick="exportToExcel()" class="btn btn-small"></td>
					</tr>
			</table>
			<br>
<%
	try{
			hidpaging = request.getParameter("hidpaging")!=null?request.getParameter("hidpaging"):"";
			if ((!(userRoleId.equalsIgnoreCase("0")) && !(userRole.equalsIgnoreCase("26")))){
				  vparam.add(hidpaging);
				  vparam.add(fName); // Added to search recordds based on roles
				  vparam.add(mName);
				  vparam.add(sName);
				  vparam.add(nickName);
				  vparam.add(disName);
				  vparam.add((String)session.getAttribute("userid"));
				  vparam.add(userRoleId);
				  vparam.add("");
				   vparam.add("");
				  vparam.add("0");
			}else{
				  vparam.add(hidpaging);	
				  vparam.add(fName); // Added to search record based on user names.
				  vparam.add(mName);
				  vparam.add(sName);
				  vparam.add(nickName);
				  vparam.add(disName);
				  vparam.add((String)session.getAttribute("userid"));
				  vparam.add(userRole);
				  vparam.add("");
				  vparam.add("");
				  vparam.add("1");
			}	  
			  userDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_userInfo",vparam,"ScoreDB");
			  vparam.removeAllElements();	
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>			
			<table width="100%" align=center >
					<tr>
					    <td>
<%--					        <fieldset id="fldsetpersonal"> --%>
<%--								<legend >--%>
<%--									<font size="4" color="#003399"><b>User Data</b></font>--%>
<%--								</legend> --%>
						<fieldset><legend class="legend1">User Data
								</legend> 
								<ul class="pagination">
											<li><a href="javascript:previousPagingRecords()" class="btn btn-small" style="text-decoration:none;"><<</a></li>
											<li><a href="javascript:nextPagingRecords()" class="btn btn-small" style="text-decoration:none;">>></a></li>
<%if(userDataCrs != null && userDataCrs.size() > 0){
	while(userDataCrs.next()){	
		lastPageNo  = userDataCrs.getString("noofpages")!=null?userDataCrs.getString("noofpages").trim():"";
	}
%>											
											<li><%=hidpaging%> of <%=lastPageNo%></li>
<%}else{
%> 										     <li>&nbsp;</li>	
<%}
%>									
	
											<li><input type=text name="pagingno" id="pagingno" size=2/> </li>
											<li><input type=button name=Go value=Go class="btn btn-small" onclick="pagingRecords()"/></li>

								</ul>
<%try{
	  if(userDataCrs != null && userDataCrs.size() > 0){
		  userDataCrs.beforeFirst();
			while(userDataCrs.next()){	
					matchCountFlag = userDataCrs.getString("flag")!=null?userDataCrs.getString("flag"):"";
			}
	  }
}catch(Exception e){
	log.writeErrLog(page.getClass(),matchId,e.toString());
}
%>
								<table>	
										<tr class="contentDark">
											<td align=center class="colheadinguser">Username</td>
											<td align=center class="colheadinguser">Display name</td>
											<td align=center class="colheadinguser">First name</td>
											<td align=center class="colheadinguser">Middle name</td>
											<td align=center class="colheadinguser">Last name</td>
											<td align=center class="colheadinguser">No of Matches</td>
											<td align=center class="colheadinguser">Status</td>									
										</tr>			
<%//code to get user records.

try{
	  if(userDataCrs != null && userDataCrs.size() > 0){
		  userDataCrs.beforeFirst();
			while(userDataCrs.next()){	
				nickName 	= userDataCrs.getString("nickName")!=null?userDataCrs.getString("nickName").trim():"";
				fName    	= userDataCrs.getString("fName")!=null?userDataCrs.getString("fName").trim():"";
				mName    	= userDataCrs.getString("mName")!=null?userDataCrs.getString("mName").trim():"";
				sName	 	= userDataCrs.getString("sName")!=null?userDataCrs.getString("sName").trim():"";
				id		 	= userDataCrs.getString("id")!=null?userDataCrs.getString("id"):"";
				matchCount = userDataCrs.getString("match_count")!=null?userDataCrs.getString("match_count"):"";
				status	 	= userDataCrs.getString("status")!=null?userDataCrs.getString("status").trim():"";
				disName  	= userDataCrs.getString("displayname")!=null?userDataCrs.getString("displayname").trim():"";
				pageNo   	= userDataCrs.getString("noofpages")!=null?userDataCrs.getString("noofpages").trim():"";
				lastPageNo  = userDataCrs.getString("noofpages")!=null?userDataCrs.getString("noofpages").trim():"";
%>
										<tr class="contentLight">
											<td align=center width=15%><a href="javascript:passUserData(<%=id%>)"><%=nickName%></a></td>
											<td align=center width=15%><%=disName%>&nbsp;</td>
											<td align=center width=20%><%=fName%>&nbsp;</td>
											<td align=center width=15%><%=mName%>&nbsp;</td>
											<td align=center width=20%><%=sName%>&nbsp;</td>
<%  if (status.equalsIgnoreCase("A")){
		status	=	"Active";
	}else{
		status	=	"InActive";
	}
%>	
											<td align=center width=5%><%=matchCount%></td>
										<td align=center width=5%><%=status%></td>
										</tr>	
<%	}
	}else{
%>									<tr>
											<td align=center colspan=4 color="red">Record Not Found.</td>
										</tr>	
<%	}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>
									</table>	
							</fieldset>
						</td>
					</tr>
			</table>				
	
<%}

%>	
<input type=hidden name=hidOnload id=hidOnload value="1" />
<input type=hidden name=hidUpdatePhoto id=hidUpdatePhoto value="1" /><!--by dipti-->
<input type=hidden name=pageNo id=pageNo value="<%=pageNo%>"/>
<input type=hidden name=lastPageNo id=lastPageNo value="<%=lastPageNo%>"/>
</form>
</body>
</html>


	