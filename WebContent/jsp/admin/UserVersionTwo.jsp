<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%
	Common commonUtil		  	 =  new Common();
    CachedRowSet  crsObjRolesCrs =  null;
    CachedRowSet  userDataCrs	 =  null;
    CachedRowSet  updateUserCrs	 =  null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
    Vector vparam 			     =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	String nickName 	= "";
	String fName    	= "";
	String mName    	= "";
	String sName		= "";
	String password 	= "";
	String pass_encr	= "";
	String pob			= "";
	String dob			= "";
	String sex 			= "";
	String roleId		= "";
	String clubId		= "";
	String address		= "";
	String hidUserId	= "";
	String playerId		= "";
	String retvalue		= "";
	String remark		= "";
	String updateParam  = "";
	String userIdParam  = "";
	String deleteParam	= "";
	String status		= "";
	String team			= "";
	String matchId		= "";
	String disName		= "";
	session.setAttribute("matchid","153");
	matchId 		    = (String)session.getAttribute("matchid");
	LogWriter log 		= new LogWriter();
	updateParam = request.getParameter("hidUpdate")!=null?request.getParameter("hidUpdate"):"";
	userIdParam = request.getParameter("hidUserId")!=null?request.getParameter("hidUserId"):"";
	String hid 		 = request.getParameter("hid");
	String hidUpdate = request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
	try{
		if (hid!=null && hid.equalsIgnoreCase("1") && !(updateParam.equalsIgnoreCase("update"))){
			nickName 	= request.getParameter("txtNickName")!=null?request.getParameter("txtNickName"):"";
			fName    	= request.getParameter("txtFUserName")!=null?request.getParameter("txtFUserName"):"";
			mName    	= request.getParameter("txtMUserName")!=null?request.getParameter("txtMUserName"):"";
			sName	 	= request.getParameter("txtLUserName")!=null?request.getParameter("txtLUserName"):"";
			disName		= request.getParameter("txtdisName")!=null?request.getParameter("txtdisName"):"";	
			password 	= request.getParameter("password")!=null?request.getParameter("password"):"";
			dob		 	= commonUtil.formatDate(request.getParameter("txtDob"));
			pob		 	= request.getParameter("txtPob")!=null?request.getParameter("txtPob"):"";
			sex 	 	= request.getParameter("selGender")!=null?request.getParameter("selGender"):"";
			roleId	 	= request.getParameter("selRole")!=null?request.getParameter("selRole"):"";
			team		= request.getParameter("selTeam")!=null?request.getParameter("selTeam"):"";
			clubId	 	= request.getParameter("selClub")!=null?request.getParameter("selClub"):"";
			address		= request.getParameter("userAddress").trim()!=null?request.getParameter("userAddress").trim():"";
			status		= request.getParameter("status")!=null?request.getParameter("status"):"";	
			
			vparam.add(status);	
			vparam.add(nickName);
			vparam.add(fName);
			vparam.add(mName);
			vparam.add(sName);
			vparam.add(disName);
			vparam.add(password);
			vparam.add(pass_encr);
			vparam.add(dob);
			vparam.add(pob);
			vparam.add(sex);
			vparam.add(address);
			vparam.add(roleId);
			vparam.add(clubId);
			if (roleId.equalsIgnoreCase("1")){
				vparam.add(team);	
			}else{
				vparam.add("");	
			}	
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("1");
	        updateUserCrs = lobjGenerateProc.GenerateStoreProcedure("amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
		}else if(hid!=null && hid.equalsIgnoreCase("1") && updateParam.equalsIgnoreCase("update")){
			//code to update user records
			hidUserId	= request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
			nickName 	= request.getParameter("txtNickName")!=null?request.getParameter("txtNickName"):"";
			fName    	= request.getParameter("txtFUserName")!=null?request.getParameter("txtFUserName"):"";
			mName    	= request.getParameter("txtMUserName")!=null?request.getParameter("txtMUserName"):"";
			sName	 	= request.getParameter("txtLUserName")!=null?request.getParameter("txtLUserName"):"";
			disName		= request.getParameter("txtdisName")!=null?request.getParameter("txtdisName"):"";	
			password 	= request.getParameter("password")!=null?request.getParameter("password"):"";
			dob		 	= commonUtil.formatDate(request.getParameter("txtDob"));
			pob		 	= request.getParameter("txtPob")!=null?request.getParameter("txtPob"):"";
			sex 	 	= request.getParameter("selGender")!=null?request.getParameter("selGender"):"";
			address		= request.getParameter("userAddress").trim()!=null?request.getParameter("userAddress").trim():"";
			roleId	 	= request.getParameter("selRole")!=null?request.getParameter("selRole"):"";
			clubId	 	= request.getParameter("selClub")!=null?request.getParameter("selClub"):"";
			team		= request.getParameter("selTeam")!=null?request.getParameter("selTeam"):"";
			status		= request.getParameter("status")!=null?request.getParameter("status"):"";	
			
			vparam.add(status);
			vparam.add(nickName);
			vparam.add(fName);
			vparam.add(mName);
			vparam.add(sName);
			vparam.add(disName);
			vparam.add(password);
			vparam.add(pass_encr);
			vparam.add(dob);
			vparam.add(pob);
			vparam.add(sex);
			vparam.add(address);
			vparam.add(roleId);
			vparam.add(clubId);
			if (roleId.equalsIgnoreCase("1")){
				vparam.add(team);	
			}else{
				vparam.add("");	
			}	
			vparam.add(userIdParam);
			vparam.add("");
			vparam.add("");
			vparam.add("2");
	        updateUserCrs = lobjGenerateProc.GenerateStoreProcedure("amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
		}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	// code to delete record
	deleteParam = request.getParameter("hidDelete")!=null?request.getParameter("hidDelete"):"";
	try{
		if(deleteParam!=null && deleteParam.equalsIgnoreCase("delete")){
			hidUserId = request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
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
			vparam.add(hidUserId);
			vparam.add("");
			vparam.add("");
			vparam.add("3");
		  	updateUserCrs = lobjGenerateProc.GenerateStoreProcedure("amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
		}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
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
				nickName	 = userDataCrs.getString("nickName")!=null?userDataCrs.getString("nickName"):"";
				fName   	 = userDataCrs.getString("fName")!=null?userDataCrs.getString("fName"):"";
				mName   	 = userDataCrs.getString("mName")!=null?userDataCrs.getString("mName"):"";
				sName		 = userDataCrs.getString("sName")!=null?userDataCrs.getString("sName"):"";
				disName		 = userDataCrs.getString("displayname")!=null?userDataCrs.getString("displayname"):"";
				roleId		 = userDataCrs.getString("role")!=null?userDataCrs.getString("role"):"";
				clubId		 = userDataCrs.getString("club")!=null?userDataCrs.getString("club"):"";	
				team		 = userDataCrs.getString("team")!=null?userDataCrs.getString("team"):"";
				password 	 = userDataCrs.getString("password")!=null?userDataCrs.getString("password"):"";
				pass_encr	 = userDataCrs.getString("password_enc")!=null?userDataCrs.getString("password_enc"):"";
				dob		 	 = userDataCrs.getString("dob").substring(0,10)!=null?userDataCrs.getString("dob").substring(0,10):"";
				status		 = userDataCrs.getString("status")!=null?userDataCrs.getString("status").trim():"";
				if (dob.equalsIgnoreCase("1900-01-01")){
						 dob = "";			
				}
				pob			 = userDataCrs.getString("pob")!=null?userDataCrs.getString("pob"):"";
				sex 		 = userDataCrs.getString("sex")!=null?userDataCrs.getString("sex"):"";
				address  	 = userDataCrs.getString("address1")!=null?userDataCrs.getString("address1"):"";
			}
	}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
  }

%>

 <html>
 <head>
 			<title>User Master</title>    
			<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
			<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>  
			<script>	 
					function validateData(){
						var userAddr = document.getElementById('userAddress').value;	
						var addrLength =userAddr.length; 
						if(document.getElementById('selRole').value == "0"){
							alert("Select Role");
							document.frmUser.selRole.focus();
							return false;
						}else if(document.getElementById('selClub').value == "0"){
							alert("Select Club");
							document.frmUser.selClub.focus();
							return false;
						}else if(document.getElementById('txtFUserName').value == ""){
							alert("Enter First Name");
							document.frmUser.txtFUserName.focus();
							return false;
						}else if(document.getElementById('txtLUserName').value == ""){
							alert("Enter Last Name");
							document.frmUser.txtLUserName.focus();
							return false;
						}else if(document.getElementById('txtdisName').value == ""){
							alert("Enter Display Name");
							document.frmUser.txtdisName.focus();
							return false;
						}else if(document.getElementById('txtNickName').value == ""){
							alert("Enter Nick Name");
							document.frmUser.txtNickName.focus();
							return false;
						}else if(document.getElementById('status').value == "0"){ 
							alert("select status");
							document.frmUser.status.focus();
							return false;
						}if(document.getElementById('selGender').value == 1){
							alert("Select Gender");
							document.frmUser.selGender.focus();
							return false;
						}else if(addrLength > 255){
							alert("Address Length should be less than 255 characters");
							document.frmUser.userAddress.focus();
							return false;
						}else if(document.getElementById('selRole').value == "1"){
							  if (document.getElementById('selTeam').value == ""){
							  	alert("Select Team");
							  	return false;
							  }
						}
							var retVal=confirm("Do You Want To Continue");
							if (retVal==true){
								document.getElementById('hid').value = 1;
								document.frmUser.submit();
							}else{
								return false;
							}	
					
					}
				
					function changeColour(which) {
						if (which.value.length > 0) {   // minimum 2 characters
							which.style.background = "#FFFFCC"; // white
						}
						else {
							which.style.background = "";  // yellow
						}
					}
					
					function validate(){
						
					}
					
					function addNickname(c){
						var firstName = document.getElementById('txtFUserName').value;
						var lastName  = document.getElementById('txtLUserName').value;
						document.getElementById('txtNickName').style.background = '#FFFFCC';
						if (lastName!="" && lastName!=null){
							firstChar = lastName.substring(0,1);
							document.getElementById('txtNickName').value = firstName+""+firstChar;			
						}
						else{
							if (firstName=="" && firstName!=null){
								document.getElementById('txtNickName').value = "";
							}
						}					
					}
					
			
				function userSearch(){
						 doGetUserData();
				}
				
				function passUserData(userId){
						document.getElementById('hiduserId').value=userId;
						document.getElementById('hid').value = 2;
						document.getElementById('hidUpdate').value = "update";
						var hidUpdate = document.getElementById('hidUpdate').value;
						var hidUserId = document.getElementById('hiduserId').value;
						document.frmUser.action="/cims/jsp/admin/UserMasterVersionTwo.jsp?hidUpdate="+hidUpdate+"&hidUserId="+hidUserId;
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
	 						document.frmUser.action="/cims/jsp/admin/UserMasterVersionTwo.jsp?hidDelete="+hidDelete+"&hidUserId="+hidUserId;
	 						document.frmUser.submit();
	 						//userSearch();
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
			<input type=hidden name=hidNickName id=hidNickName value="<%=nickName%>" />
			<input type=hidden name=hidDisName id=hidDisName value="<%=disName%>" />
			<input type=hidden name=hidFlag id=hidFlag value="1" />
			<br>
			
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
					<tr>
					    <td>
					        <fieldset id="fldsetpersonal"> 
								<legend >
									<font size="3" color="#400040" ><b>Search User's Details </b></font>
								</legend> 
							<table cellspacing=5> 
								<tr> 
									<td>&nbsp;</td>
									<td><label><font color="#003399"><b>Nick name</b></font></label></td>
									<td>&nbsp;</td>
									<td><label><font color="#003399"><b>First name</b></font></label></td>
									<td>&nbsp;</td>
									<td><label><font color="#003399"><b>Middle name</b></font></label></td>
									<td>&nbsp;</td>
									<td><label><font color="#003399"><b>Last name</b></font></label></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><input class="FlatTextBox" class = "input"type="text" name="searchNickName" id="searchNickName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
									<td>&nbsp;</td>
									<td><input class="FlatTextBox" type="text" name="searchFirstName" id="searchFirstName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
									<td>&nbsp;</td>
									<td><input class="FlatTextBox" type="text" name="searchMiddleName" id="searchMiddleName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
									<td>&nbsp;</td>
									<td><input class="FlatTextBox" type="text" name="searchLastName" id="searchLastName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
									<td>&nbsp;</td>
									<td><input type="button" name="Search"  value="Search" onclick="userSearch()"></td>

								</tr>	
							</table>	
							</fieldset>
						</td>
					</tr>
			</table>				
			<br>
			<div name="validatenames" id="validatenames">
			</div>
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
			<table width="95%">
				<tr>
				    <td>
				        <fieldset id="fldsetpersonal"> 
							
<%	if (hid!=null && hid.equalsIgnoreCase("2"))	{
																	
%>
										<font size="3" color="#400040" ><b><a href="/cims/jsp/admin/UserMasterVersionTwo.jsp">Add New User</a> </b></font>
										<br>
										<br>
										<legend >
											<font size="3" color="#400040" ><b>Update User's Details </b></font>
										</legend >

<%
	}else if(hid!=null && hid.equalsIgnoreCase("1")){
%>
										<font size="3" color="#400040" ><b><a href="/cims/jsp/admin/UserMasterVersionTwo.jsp">Add New User</a> </b></font>
										<br>
										<legend >
											<font size="3" color="#400040"><b>Add User Details</b></font>
										</legend >
<%
	}else if(hid!=null && hid.equalsIgnoreCase("3")){
%>

										<font size="3" color="#400040" ><b><a href="/cims/jsp/admin/UserMasterVersionTwo.jsp">Add New User</a> </b></font>
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
									<td><label><font color="#003399"><b>Role</b></font> </label></td>
									<td><label><font color="#003399"><b>Club</b></font> </label></td>
									<td><label><font color="#003399"><b>Team</b></font> </label></td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>	
								<tr>
									<td>
										 <select class="FlatTextBox" name="selRole" id="selRole" >
										 			<option value="0">--select--</option>

<%	try{	
		vparam.add("1");//
        crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roles",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjRolesCrs != null){	
			while(crsObjRolesCrs.next()){	
%>							
						<option value="<%=crsObjRolesCrs.getString("id")%>" <%=roleId.equals(crsObjRolesCrs.getString("id"))?"selected":""%>><%=crsObjRolesCrs.getString("name")%></option>
<%
			}
		 }
	   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>	
%>
							  			  </select>			   
									</td>
										
									<td>
										 <select class="FlatTextBox" name="selClub" id="selClub" >
										 		<option value="0">--select--</option>

<%
	try{	
		vparam.add("2");//
        crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roles",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjRolesCrs != null){	
			while(crsObjRolesCrs.next()){	
%>							
						<option value="<%=crsObjRolesCrs.getString("id")%>" <%=clubId.equals(crsObjRolesCrs.getString("id"))?"selected":""%>><%=crsObjRolesCrs.getString("name")%></option>
<%
			}
		 }
	   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>	

							  			  </select>			   
									</td>
									<td>
										 <select class="FlatTextBox" name="selTeam" id="selTeam" >
										 		<option value="">--select--</option>

<%
	try{	
		vparam.add("1");//
        crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teams",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjRolesCrs != null){	
			while(crsObjRolesCrs.next()){	
%>							
						<option value="<%=crsObjRolesCrs.getString("id")%>" <%=team.equals(crsObjRolesCrs.getString("id"))?"selected":""%>><%=crsObjRolesCrs.getString("team_name")%></option>
						<%--
						<%=playerId.equals(userDataCrs.getString("role"))?"selected":"" %>
						--%>
<%
			}
		 }
	   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>	

							  			  </select>			   
									</td>
									
								</tr>		
								<tr>
									<td colspan=4>&nbsp;</td>
								</tr>	
							
								<tr>
									<td><label><font color="#003399"><b>First name </b></font></label></td>
									<td><label><font color="#003399"><b>Middle name</b></font></label></td>
									<td><font color="#003399"><label><b>Last name </b></font></label></td>
									<td><font color="#003399"><label><b>Display name</b></font></label></td>
								</tr>
								
								<tr>
								
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>										
									<td><input class="FlatTextBox" type="text" name="txtFUserName" id="txtFUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=fName%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>			
									<td><input class="FlatTextBox" type="text" name="txtFUserName" id="txtFUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>	
<%
	}
%>		
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>				
									<td><input class="FlatTextBox" type="text" name="txtMUserName" id="txtMUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=mName%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>	
									<td><input class="FlatTextBox" type="text" name="txtMUserName" id="txtMUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>		
<%
	}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>					
									<td><input class="FlatTextBox" type="text" name="txtLUserName" id="txtLUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "addNickname();changeColour(this)" value="<%=sName%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>			
									<td><input class="FlatTextBox" type="text" name="txtLUserName" id="txtLUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "addNickname();changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>					
<%
	}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>
			  						<td>
				 					   <input class="FlatTextBox" type="text" name="txtdisName" id="txtdisName" onfocus = "this.style.background = '#FFFFCC'" onblur = "validateName();changeColour(this)" value="<%=disName%>" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')">
									</td>
<%
	}else{
%>	
									<td>
				 					   <input class="FlatTextBox" type="text" name="txtdisName" id="txtdisName" onfocus = "this.style.background = '#FFFFCC'" onblur = "validateName();changeColour(this)" value="" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')">
									</td>							
<%
	}
%>
</tr>
								
								<tr>
								
									<td><label><font color="#003399"><b>Nick name  </b></font></label></td>
								    <td><label><font color="#003399"><b>Date of Birth </b></font></label></td>
									<td><font color="#003399"><label><b>Place Of Birth </b></font></label></td>
									<td><label><font color="#003399"><b>Password</b></font></label></td>
									<%--<td><label><font color="#003399"><b>Numeric Password*</b></font></label></td>		
								--%></tr>
								<tr>
								
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>									
									<td><input class="FlatTextBox" type="text" name="txtNickName" id="txtNickName" onfocus = "addNickname(); this.style.background = '#FFFFCC'"  onblur = "validateName();changeColour(this)" value="<%=nickName%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>
									<td><input class="FlatTextBox" type="text" name="txtNickName" id="txtNickName" onfocus = "addNickname(); this.style.background = '#FFFFCC'"  onblur = "validateName();changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>						
								    <td>
									    <input class="FlatTextBox" type="text" name="txtDob" id="txtDob" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=dob%>" readonly>
									    <a href="javascript:showCal('DOBCalendar', 'Birth Date', 'txtDob', 'frmUser')"> 
									    <IMG src="../../images/cal.gif" width="15" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
<%
	}else{
%>	
									<td>
									    <input class="FlatTextBox" type="text" name="txtDob" id="txtDob" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" readonly>
									    <a href="javascript:showCal('DOBCalendar', 'Birth Date', 'txtDob', 'frmUser')"> 
									    <IMG src="../../images/cal.gif" width="15" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
<%
	}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>					
								    <td><input class="FlatTextBox" type="text" name="txtPob" id="txtPob" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=pob%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>	
									<td><input class="FlatTextBox" type="text" name="txtPob" id="txtPob" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>				
<%
	}
%>		
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>
			  						<td>
				 					   <input class="FlatTextBox" type="password" name="password" id="password" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=password%>">
									</td>
<%
	}else{
%>	
									<td>
				 					   <input class="FlatTextBox" type="password" name="password" id="password" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="">
									</td>							
<%
	}
%>	
								</tr>
								<tr>
								    <td colspan=2><label><font color="#003399"><b>&nbsp;Address</b></font></label></td><%--
								    <td><label><font color="#003399"><b>Plot</b></font></label></td>
								    <td><label><font color="#003399"><b>Street </b></font></label></td>
								--%><td > <label><font color="#003399"><b>&nbsp;Status</b></font></label></td>
									<td><label><font color="#003399"><b>Gender </b></font></label></td>
								</tr>
								<tr>
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>								
									<%--<td colspan=3><textarea id="userAddress" name="userAddress" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz 0123456789,.')"><%=address%></textarea></td>
--%>
									<td colspan=2><textarea cols="40" rows="3" name="userAddress" id="userAddress"  onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,',./;:`~abcdefghijklmnopqrstuvwxyz 1234567890');"><%=address%></textarea></td>
<%
	}else{
%>	
									<td colspan=2><textarea cols="40" rows="3" name="userAddress" id="userAddress"  onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,',./;:`~abcdefghijklmnopqrstuvwxyz 1234567890');"></textarea></td>
								
<%
	}
%>								
									<td>
										<select class="FlatTextBox" name="status" id="status">
								    		<option value="0">--select--</option>
											<option value="A" <%=status.equalsIgnoreCase("A")?"Selected":""%>>Active</option>
											<option value="I" <%=status.equalsIgnoreCase("I")?"Selected":""%>>InActive</option>
										</select>
									</td>
									 <td>
									 	<select class="FlatTextBox" name="selGender" id="selGender">
								    		<option value="1">--select--</option>
											<option value="M" <%=sex.equalsIgnoreCase("M")?"Selected":""%>>Male</option>
											<option value="F" <%=sex.equalsIgnoreCase("F")?"Selected":""%>>Female</option>
										</select>
									</td>
</tr>
								
								<tr>
									<%--<td><font color="#003399"><label><b>Pin</b></font></label></td>
									<td><label><font color="#003399"><b>District</b></font></label></td>
									--%>
								</tr>
								<tr>
<%--<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>										
									<td><input class="FlatTextBox" type="text" name="txtPlot" id="txtPlot" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=fName%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>			
									<td><input class="FlatTextBox" type="text" name="txtPlot" id="txtPlot" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>	
<%
	}
%>		
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>				
									<td><input class="FlatTextBox" type="text" name="txtStreet" id="txtStreet" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=mName%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
<%
	}else{
%>	
								<td><input class="FlatTextBox" type="text" name="txtStreet" id="txtStreet" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>		
<%
	}
%>							
--%>							
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
			          		var param= 2 ;
			          	  	var nickName= document.getElementById('searchNickName').value;
							var firstName= document.getElementById('searchFirstName').value;
							var middleName= document.getElementById('searchMiddleName').value;
							var lastName= document.getElementById('searchLastName').value;	
					        var url= "/cims/jsp/admin/SearchUserVersionTwo.jsp?nickName="+nickName +  "&firstName="+firstName + "&middleName="+middleName + "&lastName="+lastName + "&param="+param;
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
			  		 
			  	// validate nickName and display name
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
				 function validateName(){
				 	
				 	  xmlHttp=GetXmlHttpObject();
			          if (xmlHttp==null){
			              alert ("Browser does not support HTTP Request") ;
			              return;
			          }
			          else{
			          		var param = 1;
			          		var userId      = document.getElementById('hiduserId').value;
			         	  	var nickName	= document.getElementById('txtNickName').value;
			         	  	var displayName = document.getElementById('txtdisName').value;
			         	  	var hidNick		= document.getElementById('hidNickName').value;
			         	  	var hidDis		= document.getElementById('hidDisName').value;
    	  				    var hidFlag		= document.getElementById('hidFlag').value;
    	  				    var hidUpdate   = document.getElementById('hidUpdate').value;
			         	  	if (hidDis == displayName && hidNick == nickName && hidUpdate != "" ){
							    param = 3;
							    var url= "/cims/jsp/admin/SearchUserVersionTwo.jsp?nickName="+nickName +  "&displayName="+displayName + "&param="+param + "&userId="+userId;
							 }else if (hidDis == displayName && hidNick != nickName && hidFlag == "1" && hidUpdate != ""){ 
							    param = 6;
							    var val="";
							    var url= "/cims/jsp/admin/SearchUserVersionTwo.jsp?nickName="+nickName +  "&displayName="+val + "&param="+param + "&userId="+userId;
							 }else if (hidNick == nickName && hidDis != displayName && hidFlag == "1" && hidUpdate != ""){ 
							    param = 5;
							    var val="";
							    var url= "/cims/jsp/admin/SearchUserVersionTwo.jsp?nickName="+val  +  "&displayName="+displayName + "&param="+param + "&userId="+userId;
							 }else{
								 var url= "/cims/jsp/admin/SearchUserVersionTwo.jsp?nickName="+nickName +  "&displayName="+displayName + "&param="+param + "&userId="+userId;
							 }
			                xmlHttp.onreadystatechange=stateChangedLAS2;
			                xmlHttp.open("get",url,false);
			                xmlHttp.send(null);
			           }
			    	}
			    	
			 	   function stateChangedLAS2(){
			            if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			                   var responseResult= xmlHttp.responseText ;
			                    document.getElementById('validatenames').innerHTML=responseResult;
			             }
			  		 }	 
			  	
</script>

</html>
