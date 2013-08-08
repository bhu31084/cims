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
    CachedRowSet  crsObjRolesCrs =  null;
    CachedRowSet  userDataCrs	 =  null;
    CachedRowSet  updateUserCrs	 =  null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
    Vector vparam 			     =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
%>
<%
	String nickname 	= "";
	String fname    	= "";
	String mname    	= "";
	String sname		= "";
	String password 	= "";
	String pass_encr	= "";
	String pob			= "";
	String dob			= "";
	String sex 			= "";
	String roleId		= "";
	String address		= "";
	String hidUserId	= "";
	String playerId		= "";
	String retvalue		= "";
	String remark		= "";
	String updateParam  = "";
	String userIdParam  = "";
%>
<%--code to save user records --%>
<% // code to save user records
	updateParam = request.getParameter("hidUpdate")!=null?request.getParameter("hidUpdate"):"";
	userIdParam = request.getParameter("hidUserId")!=null?request.getParameter("hidUserId"):"";
//	deleteParam	= request.getParameter("hidUserId")!=null?request.getParameter("hidUserId"):"";
	String hid 		 = request.getParameter("hid");
	String hidUpdate = request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
	try{
		if (hid!=null && hid.equalsIgnoreCase("1") && !(updateParam.equalsIgnoreCase("update"))){
			nickname 	= request.getParameter("txtNickName")!=null?request.getParameter("txtNickName"):"";
			fname    	= request.getParameter("txtFUserName")!=null?request.getParameter("txtFUserName"):"";
			mname    	= request.getParameter("txtMUserName")!=null?request.getParameter("txtMUserName"):"";
			sname	 	= request.getParameter("txtLUserName")!=null?request.getParameter("txtLUserName"):"";
			password 	= request.getParameter("password")!=null?request.getParameter("password"):"";
			pass_encr	= request.getParameter("npassword")!=null?request.getParameter("npassword"):"";
			dob		 	= commonUtil.formatDate(request.getParameter("txtDob"));
			pob		 	= request.getParameter("txtPob")!=null?request.getParameter("txtPob"):"";
			sex 	 	= request.getParameter("selGender")!=null?request.getParameter("selGender"):"";
			roleId	 	= request.getParameter("selRole")!=null?request.getParameter("selRole"):"";
			address		= request.getParameter("userAddress").trim()!=null?request.getParameter("userAddress").trim():"";
			System.out.println("address" +address);
			vparam.add(nickname);
			vparam.add(fname);
			vparam.add(mname);
			vparam.add(sname);
			vparam.add(password);
			vparam.add(pass_encr);
			vparam.add(dob);
			vparam.add(pob);
			vparam.add(sex);
			vparam.add(address);
			vparam.add(roleId);
			vparam.add("");
			vparam.add("");
			vparam.add("1");
	        updateUserCrs = lobjGenerateProc.GenerateStoreProcedure("amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
		}else if(hid!=null && hid.equalsIgnoreCase("1") && updateParam.equalsIgnoreCase("update")){
			//code to update user records
			hidUserId= request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
			nickname 	= request.getParameter("txtNickName")!=null?request.getParameter("txtNickName"):"";
			fname    	= request.getParameter("txtFUserName")!=null?request.getParameter("txtFUserName"):"";
			mname    	= request.getParameter("txtMUserName")!=null?request.getParameter("txtMUserName"):"";
			sname	 	= request.getParameter("txtLUserName")!=null?request.getParameter("txtLUserName"):"";
			password 	= request.getParameter("password")!=null?request.getParameter("password"):"";
			pass_encr	= request.getParameter("npassword")!=null?request.getParameter("npassword"):"";
			dob		 	= commonUtil.formatDate(request.getParameter("txtDob"));
			pob		 	= request.getParameter("txtPob")!=null?request.getParameter("txtPob"):"";
			sex 	 	= request.getParameter("selGender")!=null?request.getParameter("selGender"):"";
			address		= request.getParameter("userAddress").trim()!=null?request.getParameter("userAddress").trim():"";
			roleId	 	= request.getParameter("selRole")!=null?request.getParameter("selRole"):"";
			System.out.println("address" +address);
			vparam.add(nickname);
			vparam.add(fname);
			vparam.add(mname);
			vparam.add(sname);
			vparam.add(password);
			vparam.add(pass_encr);
			vparam.add(dob);
			vparam.add(pob);
			vparam.add(sex);
			vparam.add(address);
			vparam.add(roleId);
			vparam.add(userIdParam);
			vparam.add("");
			vparam.add("2");
	        updateUserCrs = lobjGenerateProc.GenerateStoreProcedure("amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
			System.out.println("Update finished");
		}
	}catch(Exception e){
	}
%>
<%
	// code to delete record
	try{
		if(hid!=null && hid.equalsIgnoreCase("3")){
			hidUserId = request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
			System.out.println("deletehidUserId" +hidUserId);
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
			vparam.add(hidUserId);
			vparam.add("");
			vparam.add("3");
		  	updateUserCrs = lobjGenerateProc.GenerateStoreProcedure("amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
		}
	}catch(Exception e){
	}
%>	



<%	//code to get searched user records
	hidUserId = request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
	vparam.add("");
  	vparam.add("");
  	vparam.add("");
  	vparam.add("");
  	vparam.add(hidUserId);
  	vparam.add("");
  	vparam.add("");
  	vparam.add("2");
	hidUserId = request.getParameter("hiduserId");
	userDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_userInfo",vparam,"ScoreDB");
	vparam.removeAllElements();	
	try{
	 if(userDataCrs != null){	
			while(userDataCrs.next()){	
				nickname	 = userDataCrs.getString("nickname")!=null?userDataCrs.getString("nickname"):"";
				fname   	 = userDataCrs.getString("fname")!=null?userDataCrs.getString("fname"):"";
				mname   	 = userDataCrs.getString("mname")!=null?userDataCrs.getString("mname"):"";
				sname		 = userDataCrs.getString("sname")!=null?userDataCrs.getString("sname"):"";
				roleId		 = userDataCrs.getString("role")!=null?userDataCrs.getString("role"):"";
				password 	 = userDataCrs.getString("password")!=null?userDataCrs.getString("password"):"";
				pass_encr	 = userDataCrs.getString("password_enc")!=null?userDataCrs.getString("password_enc"):"";
				dob		 	 = userDataCrs.getString("dob")!=null?userDataCrs.getString("dob"):"";
				pob			 = userDataCrs.getString("pob")!=null?userDataCrs.getString("pob"):"";
				sex 		 = userDataCrs.getString("sex")!=null?userDataCrs.getString("sex"):"";
				address  	 = userDataCrs.getString("address1")!=null?userDataCrs.getString("address1"):"";
			}
	}
	}catch(Exception e){
  }
  System.out.println("esp_dsp_userInfo finished");
%>

 <html>
 <head>
 			<title> Official Data </title>    
			<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
			<link rel="stylesheet" type="text/css" href="../../css/common.css">
			<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">	 
		    <link rel="stylesheet" type="text/css" href=".../../css/styles.css">
		  
		   <script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>  
			<script>	 
					function validateData(){
						var userAddr = document.getElementById('userAddress').value;	
						var addrLength =userAddr.length; 
						if(document.getElementById('selRole').value == "0"){
							alert("Select Role");
							document.frmUser.selRole.focus();
							return false;
						}else if(document.getElementById('txtFUserName').value == ""){
							alert("Enter First Name");
							document.frmUser.txtFUserName.focus();
							return false;
						}else if(document.getElementById('txtLUserName').value == ""){
							alert("Enter Last Name");
							document.frmUser.txtLUserName.focus();
							return false;
						}else if(document.getElementById('txtNickName').value == ""){
							alert("Enter Nick Name");
							document.frmUser.txtNickName.focus();
							return false;
						}else if(document.getElementById('selGender').value == 1){
							alert("Select Gender");
							document.frmUser.selGender.focus();
							return false;
						}else if(addrLength > 255){
							alert("Address Length should be less than 255 characters");
							document.frmUser.userAddress.focus();
							return false;
						}else{
							var retVal=confirm("Do You Want To Continue");
							if (retVal==true){
								document.getElementById('hid').value = 1;
								//alert(document.getElementById('hidUpdate').value);
								//alert(document.getElementById('hidUpdate').value);
								//alert(document.getElementById('hidSave').value);
								document.frmUser.submit();
							}else{
								return false;
							}	
						}
					}
				
					
			<%--	function validateSearch(){
						var nickName= document.getElementById('searchNickName').value;
						var firstName= document.getElementById('searchFirstName').value;
						var middleName= document.getElementById('searchMiddleName').value;
						var lastName= document.getElementById('searchLastName').value;
						window.open("SearchUser.jsp?nickName="+nickName +  "&firstName="+firstName + "&middleName="+middleName + "&lastName="+lastName,"CIMS","location=no,directories=no,status=Yes,menubar=Yes,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth-100)+",height="+(window.screen.availHeight-1500));
					}
			--%>
			
				function userSearch(){
						// alert("1");
						 doGetUserData();
				}
				
				function passUserData(userId){
						document.getElementById('hiduserId').value=userId;
						//alert("hduserid" +document.getElementById('hiduserId').value);
						document.getElementById('hid').value = 2;
						document.getElementById('hidUpdate').value = "update";
						var hidUpdate = document.getElementById('hidUpdate').value;
						//alert(document.getElementById('hiduserId').value);
						var hidUserId = document.getElementById('hiduserId').value;
						//alert("hidUserId" +hidUserId);
						document.frmUser.action="/cims/jsp/UserMaster.jsp?hidUpdate="+hidUpdate+"&hidUserId="+hidUserId;
						document.frmUser.submit();
 				}
 				
 				function deleteUser(userId){
 						document.getElementById('hiduserId').value=userId;
 						document.getElementById('hid').value = 3;
 						document.getElementById('hidDelete').value = "delete";
 						var hidDelete = document.getElementById('hidDelete').value;
 						var hidUserId = document.getElementById('hiduserId').value;
 						var retVal=confirm("Do You Want To Continue");
 						if (retVal==true){
							document.frmUser.submit();
						}else{
							return false;
						}
						
				}
				
 		</script>
 </head>
<body>
<form name="frmUser" id="frmUser" method=post>
			<input type=hidden name=hid id=hid value="" />
			<input type=hidden name=hiduserId id=hiduserId value=""/>
			<input type=hidden name=hidUpdate id=hidUpdate value="<%=hidUpdate%>"/>
			<input type=hidden name=hidDelete id=hidDelete value="<%=hidUpdate%>"/>
			<table width="95%" align="center" style="border-top: 1cm;">
					<tr>
						<td colspan="10" align="center" style="background-color:gainsboro;"><font size="4" color="#003399"><b>User Detail Form</b></font></td>
					</tr>
					<tr>
						<td></td>
					</tr>
			</table>	
			<br>
			<table width="95%">
					<tr >
					    <td>
					        <fieldset id="fldsetpersonal"> 
								<legend >
									<font size="3" color="#400040" ><b>Search User's Details </b></font>
								</legend> 
							<table>
								<tr> 
									<td><label><font color="#003399"><b>Nick name</b></font></label></td>
									<td>&nbsp;</td>
									<td><label><font color="#003399"><b>First name</b></font></label></td>
									<td>&nbsp;</td>
									<td><label><font color="#003399"><b>Middle name</b></font></label></td>
									<td>&nbsp;</td>
									<td><label><font color="#003399"><b>Last name</b></font></label></td>
								</tr>
								<tr>
									<td><input class="FlatTextBox" type="text" name="searchNickName" id="searchNickName" value=""></td>
									<td>&nbsp;</td>
									<td><input class="FlatTextBox" type="text" name="searchFirstName" id="searchFirstName" value=""></td>
									<td>&nbsp;</td>
									<td><input class="FlatTextBox" type="text" name="searchMiddleName" id="searchMiddleName" value=""></td>
									<td>&nbsp;</td>
									<td><input class="FlatTextBox" type="text" name="searchLastName" id="searchLastName" value=""></td>
									<td>&nbsp;</td>
									<%--<td><input type="button" name="Search"  value="Search" onclick="validateSearch()"></td>
									--%>
									<td><input type="button" name="Search"  value="Search" onclick="userSearch()"></td>

								</tr>	
							</table>	
							</fieldset>
						</td>
					</tr>
			</table>				
			<br>
			<table width="95%">
				<tr>
				    <td>
				        <fieldset id="fldsetpersonal"> 
							
<%	if (hid!=null && hid.equalsIgnoreCase("2"))	{
																	
%>
										<font size="3" color="#400040" ><b><a href="/cims/jsp/UserMaster.jsp">Add New User</a> </b></font>
										<br>
										<br>
										<legend >
											<font size="3" color="#400040" ><b>Update User's Details </b></font>
										</legend >

<%
	}else if(hid!=null && hid.equalsIgnoreCase("1")){
%>
										<font size="3" color="#400040" ><b><a href="/cims/jsp/UserMaster.jsp">Add New User</a> </b></font>
										<br>
										<legend >
											<font size="3" color="#400040"><b>Add User Details</b></font>
										</legend >
<%
	}else if(hid!=null && hid.equalsIgnoreCase("3")){
%>

										<font size="3" color="#400040" ><b><a href="/cims/jsp/UserMaster.jsp">Add New User</a> </b></font>
										<br>
										<legend >
											<font size="3" color="#400040"><b>User Details</b></font>
										</legend >
																				
<%
	}else{
%>	
										<legend >
											<font size="3" color="#400040"><b>Add User Details</b></font>
										</legend >	
												
<%
	}
%>				


							</legend> 
							<table width=95% class="TableHeader1"  align="center">
								<tr>
									<td colspan=4>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><label><font color="#003399"><b>Role</b></font> </label></td>
									<td>
										 <select class="FlatTextBox" name="selRole" id="selRole" >
										 			<%--<option value="0">--select--</option>
--%>
<%
	try{	
		vparam.add("0");//
        crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roles",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjRolesCrs != null){	
			while(crsObjRolesCrs.next()){	
				playerId = crsObjRolesCrs.getString("id");
				//System.out.println("roleId" +roleId);
%>							
						<option value="<%=crsObjRolesCrs.getString("id")%>" <%=roleId.equals(crsObjRolesCrs.getString("id"))?"selected":""%>><%=crsObjRolesCrs.getString("name")%></option>
						<%--
						<%=playerId.equals(userDataCrs.getString("role"))?"selected":"" %>
						--%>
<%
			}
		 }
	   }catch(Exception e){
		e.printStackTrace();
	}
%>	
%>
							  			  </select>			   
									</td>
									<td><label><font color="#003399"><b>Password  *</b></font></label></td>
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>
			  						<td>
				 					   <input class="FlatTextBox" type="password" name="password" id="password" value="<%=password%>">
									</td>
<%
	}else{
%>	
									<td>
				 					   <input class="FlatTextBox" type="password" name="password" id="password" value="">
									</td>							
<%
	}
%>						
									<td><label><font color="#003399"><b>Numeric Password *</b></font></label></td>
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>									
								    <td>
								        <input class="FlatTextBox" type="password" name="npassword" id="npassword" value="<%=pass_encr%>" onKeyPress="return keyRestrict(event,'1234567890')">
								    </td>	
<%
	}else{
%>	
									<td>
								        <input class="FlatTextBox" type="password" name="npassword" id="npassword" value="" onKeyPress="return keyRestrict(event,'1234567890')">
								    </td>	
<%
	}
%>					    		
								</tr>			
							</table>
							<br>			
							<table width="95%" class="TableHeader1"  align="center">
								<tr>
									<td>&nbsp;</td>
									<td><label><font color="#003399"><b>First name </b></font></label></td>
									<td><label><font color="#003399"><b>Middle name</b></font></label></td>
									<td><label><font color="#003399"><b>Last name </b></font></label></td>
									<%--<td><label><font color="#003399"><b>Address </b></font></label></td>
								--%>
								</tr>
								
								<tr>
									<td>&nbsp;</td>
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>										
									<td><input class="FlatTextBox" type="text" name="txtFUserName" id="txtFUserName" value="<%=fname%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>			
									<td><input class="FlatTextBox" type="text" name="txtFUserName" id="txtFUserName" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>	
<%
	}
%>		
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>				
									<td><input class="FlatTextBox" type="text" name="txtMUserName" id="txtMUserName" value="<%=mname%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>	
									<td><input class="FlatTextBox" type="text" name="txtMUserName" id="txtMUserName" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>		
<%
	}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>					
									<td><input class="FlatTextBox" type="text" name="txtLUserName" id="txtLUserName" value="<%=sname%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>			
									<td><input class="FlatTextBox" type="text" name="txtLUserName" id="txtLUserName" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>					
<%
	}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>					
									<%--<td><input class="FlatTextBox" type="text" name="txtAddress" id="txtAddress" value="<%=address%>"   onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
--%><%
	}else{
%><%--	
									<td><input class="FlatTextBox" type="text" name="txtAddress" id="txtAddress" value=""   onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>			
--%><%
	}
%>						
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<%--<td><label><font color="#003399"><b>Address </b></font></label></td>
								--%>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><label><font color="#003399"><b>Nick name  </b></font></label></td>
								    <td><label><font color="#003399"><b>Date of Birth </b></font></label></td>
									<td><label><font color="#003399"><b>Place Of Birth</b></font></label></td>
									<td><label><font color="#003399"><b>Gender </b></font></label></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>									
									<td><input class="FlatTextBox" type="text" name="txtNickName" id="txtNickName" value="<%=nickname%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>
									<td><input class="FlatTextBox" type="text" name="txtNickName" id="txtNickName" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>						
								    <td>
									    <input class="FlatTextBox" type="text" name="txtDob" id="txtDob" value="<%=dob%>" readonly>
									    <a href="javascript:showCal('DOBCalendar', 'Birth Date', 'txtDob', 'frmUser')"> 
									    <IMG src="../../images/cal.gif" width="15" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
<%
	}else{
%>	
									<td>
									    <input class="FlatTextBox" type="text" name="txtDob" id="txtDob" value="" readonly>
									    <a href="javascript:showCal('DOBCalendar', 'Birth Date', 'txtDob', 'frmUser')"> 
									    <IMG src="../../images/cal.gif" width="15" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
<%
	}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>					
								    <td><input class="FlatTextBox" type="text" name="txtPob" id="txtPob" value="<%=pob%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>	
									<td><input class="FlatTextBox" type="text" name="txtPob" id="txtPob" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>				
<%
	}
%>					    
								    <td><select class="FlatTextBox" name="selGender" id="selGender">
								    		<option value="1">--select--</option>
											<option value="M" <%=sex.equalsIgnoreCase("M")?"Selected":""%>>Male</option>
											<option value="F" <%=sex.equalsIgnoreCase("F")?"Selected":""%>>Female</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<%--<td><label><font color="#003399"><b>Address </b></font></label></td>
								--%>
								</tr>
								<tr>
									<td colspan=3><label><font color="#003399"><b>&nbsp;Address</b></font></label></td>
									<%--<td><label><font color="#003399"><b>Address </b></font></label></td>
								--%>
								</tr>
								<tr>
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>								
									<%--<td colspan=3><textarea id="userAddress" name="userAddress" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz 0123456789,.')"><%=address%></textarea></td>
--%>
									<td colspan=3><textarea cols="10" rows="2" name="userAddress" id="userAddress" style="WIDTH:150px; HEIGHT: 43px;" onKeyPress="return keyRestrict(event,',./;:`~abcdefghijklmnopqrstuvwxyz 1234567890');"><%=address%></textarea></td>
<%
	}else{
%>	
									<td colspan=3><textarea cols="10" rows="2" name="userAddress" id="userAddress" style="WIDTH:150px; HEIGHT: 43px;" onKeyPress="return keyRestrict(event,',./;:`~abcdefghijklmnopqrstuvwxyz 1234567890');"></textarea></td>
									
<%
	}
%>					
									<%--<td><label><font color="#003399"><b>Address </b></font></label></td>
								--%>
								</tr>
								<%--<tr>
									<td>&nbsp;</td>
								    <td><label>Official Email Id </label></td>
								    <td><label>Personal Email Id </label></td>
								    <td><label >Mobile (Official) </label></td>
									<td><label>Mobile (Personal)</label></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								    <td>
									    <input class="FlatTextBox" type="text" name="txtOmailId" id="txtOmailId" value="">
									</td>
									 <td>
									    <input class="FlatTextBox" type="text" name="txtPmailId" id="txtPmailId" value="">
									</td>
									<td><input class="FlatTextBox" type="text" name="txtOMobile" id="txtOMobile" value=""></td>
									<td><input class="FlatTextBox" type="text" name="txtPMobile" id="txtPMobile" value=""></td>
								</tr>
							--%></table>
							
					</fieldset>	
    	      	 </td>       
   	       	 </tr>
      	</table>
      	<br>
		<table align=center  width=95%>
				<tr>
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>					
					<td colspan=4 align=center><input type=button name=save value=UPDATE onclick="validateData()">&nbsp;&nbsp;&nbsp;<input type=button name=save value=DELETE onclick="deleteUser(<%=hidUserId%>)"></td>
					<td colspan=4 align=center></td>
<%
	}else if(hid!=null && hid.equalsIgnoreCase("3")){
%><%--	
					<td colspan=4 align=center><input type=button name=save value=UPDATE onclick="validateData()">&nbsp;&nbsp;&nbsp;<input type=button name=save value=DELETE onclick="deleteUser(<%=hidUserId%>)"></td>
					<td colspan=4 align=center></td>
--%>
					<td colspan=4 align=center><input type=button name=save value=SAVE onclick="validateData()"></td>				
<%
	}else{
%>	
					<td colspan=4 align=center><input type=button name=save value=SAVE onclick="validateData()"></td>				
<%
	}
%>
				</tr>
		</table>
		<br>
				
<%	if (updateUserCrs!=null)	{
		while (updateUserCrs.next()){
				retvalue =  updateUserCrs.getString("Retvalue");
				if (retvalue.equalsIgnoreCase("1")){
						remark   =  updateUserCrs.getString("Remark");
%>
						<font color=red><%=remark%></font>
<%					
				}else if (retvalue.equalsIgnoreCase("2")){
						remark   =  updateUserCrs.getString("Remark");
%>
						<font color=red><%=remark%></font>
<%				
				}else if (retvalue.equalsIgnoreCase("0")){
						remark   =  updateUserCrs.getString("Remark");
%>
						<font color=red><%=remark%></font>		
<%				}		
		}
	}		
%>
</form>
</body>
<script>
			function GetXmlHttpObject(){
			        var xmlHttp=null;
			        try{
			            xmlHttp=new XMLHttpRequest();
			        }
			        catch (e){
			              // Internet Explorer
			           try{
			               xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			           }
			           catch (e){
			                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			           }
			          }
			            return xmlHttp;
				 }
		
				// Getting User Data
				 function doGetUserData(){
				 	  xmlHttp=GetXmlHttpObject();
			          if (xmlHttp==null){
			              alert ("Browser does not support HTTP Request") ;
			              return;
			          }
			          else{
			          	
			          	  	var nickName= document.getElementById('searchNickName').value;
							var firstName= document.getElementById('searchFirstName').value;
							var middleName= document.getElementById('searchMiddleName').value;
							var lastName= document.getElementById('searchLastName').value;	
					        var url= "/cims/jsp/SearchUser.jsp?nickName="+nickName +  "&firstName="+firstName + "&middleName="+middleName + "&lastName="+lastName;
			                xmlHttp.onreadystatechange=stateChangedLAS1;
			                xmlHttp.open("get",url,false);
			                xmlHttp.send(null);
			           }
			    	}
			    	
			 	   function stateChangedLAS1(){
			            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			                   var responseResult= xmlHttp.responseText ;
			                   document.getElementById('userdetail').innerHTML = "";
			                  // document.getElementById('userdetail').style.display="none";
			                  // alert(responseResult);
			                   var mdiv = document.getElementById("searchUser");
			                   mdiv.innerHTML= responseResult;
			             }
			  		 }
			  	
</script>

</html>
