<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.csms.logwriter.LogWriter"%>

<%	Common commonUtil		  	 =  new Common();
    CachedRowSet  userDataCrs	 =  null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
	Vector vparam 			     =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	String nickName	 	= "";
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
	session.setAttribute("matchid","153");
	matchId 		    = (String)session.getAttribute("matchid");
	LogWriter log 		= new LogWriter();
	nickName = request.getParameter("nickName");
	fName    = request.getParameter("firstName");
	mName    = request.getParameter("middleName");
	sName	 = request.getParameter("lastName");
	disName	 = request.getParameter("displayName");
	param 	 = request.getParameter("param");
	userId	 = request.getParameter("userId");
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
<%// to validate nickname and displayname
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
	}
%>
<%// to validate nickname and displayname
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
	}
%>

 <html>
 <head>
 			<title> User Data </title>    
			<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
 </head>
 <body>
<%
	if (param.equalsIgnoreCase("1")){
%>	
		<table>
			<tr>
				<td>
					<font color=red><%=remark%></font>
				</td>
			</tr>
			</table>	
<%
	}
%>			
<%
	if (param.equalsIgnoreCase("3")){
%>
		<table>
			<tr>
				<td>
					<font color=red></font>
				</td>
			</tr>
		</table>	
<%			
	}
%>		
<%
	if (param.equalsIgnoreCase("5")){
%>
		<table>
			<tr>
				<td>
					<font color=red><%=remark%></font>
				</td>
			</tr>
		</table>	
<%			
	}
%>			
<%
	if (param.equalsIgnoreCase("6")){
%>
		<table>
			<tr>
				<td>
					<font color=red><%=remark%></font>
				</td>
			</tr>
		</table>	
<%			
	}
%>	
<%	if ((!(param.equalsIgnoreCase("1"))) && (!param.equalsIgnoreCase("3")) && (!param.equalsIgnoreCase("5")) && (!param.equalsIgnoreCase("6"))) {
	
%>
	<form name="frmUser" id="frmUser" method=post>
			<input type=hidden name=hid id=hid value="" />
			<input type=hidden name=hiduserId id=hiduserId value=""/>
			<input type=hidden name=hidUpdate id=hidUpdate value=""/>
			<input type=hidden name=hidDelete id=hidDelete value=""/>
			<input type=hidden name=hidFlag id=hidFlag value="1" />
			<table width="0.1%" align="left" style="border-top: 1cm;">
					<tr>
						<td colspan="10" align="center" style="background-color:gainsboro;"><font size="4" color="#400040"><b><a href="/cims/jsp/admin/UserMaster.jsp">BACK</a></b></font></td>
					</tr>
					<tr>
						<td></td>
					</tr>
			</table>	
			<br><br>
			<table width="95%" align="center" style="border-top: 1cm;">
					<tr>
						<td colspan="10" align="center" style="background-color:gainsboro;"><font size="4" color="#400040"><b>User Detail Form</b></font></td>
					</tr>
					<tr>
						<td></td>
					</tr>
			</table>	
			<br>
			<table width="95%" align=center >
					<tr>
					    <td>
					        <fieldset id="fldsetpersonal"> 
								<legend >
									<font size="3" color="#400040" ><b>User Data</b></font>
								</legend> 
								<table align=center border=1 width=65%>	
										<tr>
											<td><b>Nick name</b></td>
											<td><b>First name</b></td>
											<td><b>Middle name</b></td>
											<td><b>Last name</b></td>
											<td><b>Status</b></td>											
										</tr>			
<%
	//code to get user records.
try{
	  vparam.add(fName);
  	  vparam.add(mName);
  	  vparam.add(sName);
  	  vparam.add(nickName);
  	  vparam.add("");
      vparam.add("");
      vparam.add("");
  	  vparam.add("1");
  	  userDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_userInfo",vparam,"ScoreDB");
	  vparam.removeAllElements();	
	  if(userDataCrs != null && userDataCrs.size() > 0){	
			while(userDataCrs.next()){	
				nickName = userDataCrs.getString("nickName").trim()!=null?userDataCrs.getString("nickName").trim():"";
				fName    = userDataCrs.getString("fName").trim()!=null?userDataCrs.getString("fName").trim():"";
				mName    = userDataCrs.getString("mName").trim()!=null?userDataCrs.getString("mName").trim():"";
				sName	 = userDataCrs.getString("sName").trim()!=null?userDataCrs.getString("sName").trim():"";
				id		 = userDataCrs.getString("id")!=null?userDataCrs.getString("id"):"";
				status	 = userDataCrs.getString("status")!=null?userDataCrs.getString("status").trim():"";
%>
									<tr>
											<td><label><font color="#003399"><a href=# onclick="passUserData(<%=id%>)"><%=nickName%></a></font></label></td>
											<td><label><font color="#003399"><%=fName%>&nbsp;</label></font></td>
											<td><label><font color="#003399"><%=mName%>&nbsp;</font></label></td>
											<td><label><font color="#003399"><%=sName%>&nbsp;</font></label></td>
<%
	if (status.equalsIgnoreCase("A")){
		status	=	"Active";
	}else{
		status	=	"InActive";
	}
	
%>											
											<td><label><font color="#003399"><%=status%></font></label></td>
											<%--
											<td><label><font color="#003399"> <a href=# onclick="deleteUser(<%=id%>)">Delete</a></font></label></td>
											--%>
										</tr>	
<%
		}
	}else{
%>
										<tr>
											<td align=center colspan=4><font color="red">Record Not Found.</font></td>
										</tr>	
<%			
		}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>										
									</table>	
							</fieldset>
						</td>
					</tr>
			</table>				
			<table>
				<tr>
					<td></td>
				</tr>
			</table>
<%
	}
%>		
</form>
</body>
</html>

	