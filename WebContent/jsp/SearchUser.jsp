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
	Common commonUtil		  	 =  new Common();
    CachedRowSet  userDataCrs	 =  null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
	Vector vparam 			     =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
%>
<%
	String nickname	 	= "";
	String fname   	 	= "";
	String mname   	 	= "";
	String sname		= "";
	String address		= "";
	String password 	= "";
	String pass_encr	= "";
	String pob			= "";
	String dob			= "";
	String sex 			= "";
	String roleId		= "";
	String id			= "";
	String hidUserId	= "";
%>
<%  nickname = request.getParameter("nickName");
	fname    = request.getParameter("firstName");
	mname    = request.getParameter("middleName");
	sname	 = request.getParameter("lastName");
%>

 <html>
 <head>
 			<title> User Data </title>    
			<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
					<link rel="stylesheet" type="text/css" href="../../css/common.css">
					<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">	 
				    <link rel="stylesheet" type="text/css" href=".../../css/styles.css">    
			<script>
					
			</script>
 </head>
 <body>
	<form name="frmUser" id="frmUser" method=post>
			<input type=hidden name=hid id=hid value="" />
			<input type=hidden name=hiduserId id=hiduserId value=""/>
			<input type=hidden name=hidUpdate id=hidUpdate value=""/>
			<input type=hidden name=hidDelete id=hidDelete value=""/>
			<table width="0.1%" align="left" style="border-top: 1cm;">
					<tr>
						<td colspan="10" align="center" style="background-color:gainsboro;"><font size="4" color="#400040"><b><a href="/cims/jsp/UserMaster.jsp">BACK</a></b></font></td>
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
											<td><label>Nick name</label></td>
											<td><label>First name</label></td>
											<td><label>Middle name</label></td>
											<td><label>Last name</label></td>
											
										</tr>			
<%
	//code to get user records.
try{
	  vparam.add(fname);
  	  vparam.add(mname);
  	  vparam.add(sname);
  	  vparam.add(nickname);
  	  vparam.add("");
      vparam.add("");
      vparam.add("");
  	  vparam.add("1");
  	  userDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_userInfo",vparam,"ScoreDB");
	  vparam.removeAllElements();	
	  if(userDataCrs != null && userDataCrs.size() > 0){	
			while(userDataCrs.next()){	
				nickname = userDataCrs.getString("nickname")!=null?userDataCrs.getString("nickname"):"";
				fname    = userDataCrs.getString("fname")!=null?userDataCrs.getString("fname"):"";
				mname    = userDataCrs.getString("mname")!=null?userDataCrs.getString("mname"):"";
				sname	 = userDataCrs.getString("sname")!=null?userDataCrs.getString("sname"):"";
				id		 = userDataCrs.getString("id")!=null?userDataCrs.getString("id"):"";
%>
								
									
										
										<tr>
											<td><label><font color="#003399"><a href=# onclick="passUserData(<%=id%>)"><%=nickname%></a></font></label></td>
											
											<td><label><font color="#003399"> <%=fname%></label></font></td>
											
											<td><label><font color="#003399"> <%=mname%></font></label></td>
											
											<td><label><font color="#003399"> <%=sname%></font></label></td><%--
											<td><label><font color="#003399"> <a href=# onclick="deleteUser(<%=id%>)">Delete</a></font></label></td>
											
										--%></tr>	
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
		
</form>
</body>
</html>

	