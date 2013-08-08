<!--
Page name	 : UpdateProfile.jsp
Replaced By  : Vaibhav Gaikar.
Created Date : 21 / 04 / 2009
Description  : update users details
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
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="in.co.paramatrix.common.validator.DataValidator,in.co.paramatrix.common.exceptions.NoEntity,in.co.paramatrix.common.exceptions.InvalidEntity"%>
<%@ page import="in.co.paramatrix.common.authz.AuthZ"%>
<%@ page import="java.io.File,java.io.*,javax.imageio.ImageIO,java.awt.image.BufferedImage"%>
<% 
	Common commonUtil		  	 =  new Common();
    CachedRowSet  userDataCrs	 =  null;
    CachedRowSet  updateUserCrs	 =  null;
	CachedRowSet  crsObjRolesCrs =  null;
	CachedRowSet  crsObjStateCrs =  null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
    Vector vparam 			     =  new Vector();
	String nickName 		= "";
	String fName    		= "";
	String mName    		= "";
	String sName			= "";
	String password 		= "pass";
	String pass_encr		= "";
	String pob				= "";
	String dob				= "";
	String sex 				= "";
	String roleId			= "";
	String clubId			= "";
	String countryId		= "";
	String stateId			= "";
	String locationId		= "";
	String address			= "";
	String userContact		= "";
	String matchId			= "";
	String disName			= "";
	String userId			= "";
	String userEmail		= "";
	String team				= "";
	String status			= "";
	String hidUserId		= "";
	String hid				= "";
	String remark			= "";
	String retValue			= "";
	String hiddob			= "";
	matchId 		    = (String)session.getAttribute("matchid");
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	LogWriter log 		= new LogWriter();
	userId				= (String)session.getAttribute("userid");
try{
	 hid 		= request.getParameter("hid")!=null?request.getParameter("hid"):"";
	 if(hid!=null && hid.equalsIgnoreCase("1")){
			//code to update user records
			hidUserId	= request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
			nickName 	= request.getParameter("txtNickName")!=null?request.getParameter("txtNickName"):"";
			fName    	= request.getParameter("txtFUserName")!=null?request.getParameter("txtFUserName"):"";
			mName    	= request.getParameter("txtMUserName")!=null?request.getParameter("txtMUserName"):"";
			sName	 	= request.getParameter("txtLUserName")!=null?request.getParameter("txtLUserName"):"";
			disName		= request.getParameter("txtdisName")!=null?request.getParameter("txtdisName"):"";	
			password 	= request.getParameter("password")!=null?request.getParameter("password"):"";
			pass_encr	= request.getParameter("npassword")!=null?request.getParameter("npassword"):"";
			hiddob		= request.getParameter("txtDob")!=null?request.getParameter("txtDob"):"";
			dob		 	= commonUtil.formatDate(request.getParameter("txtDob"));
			pob		 	= request.getParameter("txtPob")!=null?request.getParameter("txtPob"):"";
			sex 	 	= request.getParameter("selGender")!=null?request.getParameter("selGender"):"";
			address		= request.getParameter("userAddress").trim()!=null?request.getParameter("userAddress").trim():"";
			userContact = request.getParameter("userContact").trim()!=null?request.getParameter("userContact").trim():"";
			userEmail	= request.getParameter("userEmail").trim()!=null?request.getParameter("userEmail").trim():"";
			countryId	= request.getParameter("selCountry").trim()!=null?request.getParameter("selCountry").trim():"";
			stateId		= request.getParameter("selState").trim()!=null?request.getParameter("selState").trim():"";
			locationId  = request.getParameter("selLocation").trim()!=null?request.getParameter("selLocation").trim():"";
			vparam.add(fName);
			vparam.add(mName);
			vparam.add(sName);
			vparam.add(nickName);
			vparam.add(disName);
			vparam.add(password);
			//vparam.add(pass_encr);
			vparam.add(dob);
			vparam.add(pob);
			vparam.add(sex);
			vparam.add(address);
			vparam.add(userContact);
			vparam.add(userEmail);
			vparam.add(locationId);	
			vparam.add(userId);
			
		    updateUserCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.amd_profile",vparam,"ScoreDB");
			vparam.removeAllElements();	
		}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
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
  	vparam.add("2");
	userDataCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_userInfo",vparam,"ScoreDB");
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
				dob		 	 = userDataCrs.getString("dob")!=null?userDataCrs.getString("dob").substring(0,10):"";
				status		 = userDataCrs.getString("status")!=null?userDataCrs.getString("status").trim():"";
				if (dob.equalsIgnoreCase("01/01/1900")){
						 dob = "";			
				}
				pob			 = userDataCrs.getString("pob")!=null?userDataCrs.getString("pob"):"";
				sex 		 = userDataCrs.getString("sex")!=null?userDataCrs.getString("sex"):"";
				address  	 = userDataCrs.getString("address1")!=null?userDataCrs.getString("address1"):"";
				userContact	 = userDataCrs.getString("contactnum")!=null?userDataCrs.getString("contactnum"):"";
				userEmail	 = userDataCrs.getString("email")!=null?userDataCrs.getString("email"):"";
			}
	}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
    }
%>
<%
	try{
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
	  	vparam.add("6");
		userDataCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_userInfo",vparam,"ScoreDB");
		vparam.removeAllElements();	
	    if(userDataCrs != null){	
				while(userDataCrs.next()){	
					locationId	 = userDataCrs.getString("location")!=null?userDataCrs.getString("location"):"";
					stateId   	 = userDataCrs.getString("state")!=null?userDataCrs.getString("state"):"";
					countryId  	 = userDataCrs.getString("country")!=null?userDataCrs.getString("country"):"";
				}
		 }

	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}

	if (updateUserCrs!=null){
		while (updateUserCrs.next()){
				retValue = updateUserCrs.getString("RetValue");
				if (retValue.equalsIgnoreCase("1")){
					remark = updateUserCrs.getString("Remark");
				}else if(retValue.equalsIgnoreCase("2")){
					remark = updateUserCrs.getString("Remark");
				}
		}
	}
%>

<html>
	<head>
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" /> 
	<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
	<script language="JavaScript" src="../../js/timer.js" type="text/javascript"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>  
<%  response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
	<script>
			function validateData(){
				var userAddr 	= document.getElementById('userAddress').value;	
				var userContact = document.getElementById('userContact').value;	
							
				var addrLength 		= userAddr.length; 
				var contactLength	= userContact.length;
				 if(document.getElementById('txtFUserName').value == ""){
					alert("Enter First Name");
					document.frmUser.txtFUserName.focus();
					return false;
				}else if (document.getElementById('txtMUserName').value == ""){
					alert("Enter Middle Name");
					document.getElementById('txtMUserName').focus();
					return false;
				}else if(document.getElementById('txtLUserName').value == ""){
					alert("Enter Last Name");
					document.frmUser.txtLUserName.focus();
					return false;
				}else if(document.getElementById('password').value == ""){
					alert("Enter password");
					document.getElementById('password').focus();
					return false;
				}else if(document.getElementById('txtNickName').value == ""){
					alert("Enter Nick Name");
					document.frmUser.txtNickName.focus();
					return false;
				}else if(document.getElementById('txtDob').value == ""){
					alert("Enter Date Of Birth");
					document.frmUser.txtDob.focus();
					return false;
				}else if(document.getElementById('txtPob').value == ""){
					alert("Enter Place Of Birth");
					document.frmUser.txtPob.focus();
					return false;
				}else if (userContact==""){
					alert("Enter Mobile Number");
					document.getElementById('userContact').focus();
					return false;
				}
				else if(contactLength !='10'){
					alert("Enter Proper Mobile Number");
					document.getElementById('userContact').focus();
					return false;
				}else if(document.getElementById('txtdisName').value == ""){
					alert("Enter Display Name");
					document.frmUser.txtdisName.focus();
					return false;
				}else if(document.getElementById('selGender').value == 1){
					alert("Select Gender");
					document.frmUser.selGender.focus();
					return false;
				}else if(addrLength > 255){
					alert("Address Length should be less than 255 characters");
					document.frmUser.userContact.focus();
					return false;
				}else if(document.getElementById('selCountry').value=="0"){
					alert("Select Country");
					document.frmUser.selCountry.focus();
					return false;
				}else if(document.getElementById('selState').value=="0"){
					alert("Select State");
				    document.getElementById('selState').focus();
					return false;	
				}else if(document.getElementById('selLocation').value=="0"){
					alert("Select City");
					document.getElementById('selLocation').focus();
					return false;
				}else if(userAddr==""){
					//userAddr = userAddr.trim;
					alert("Enter Address");
					 document.getElementById('userAddress').focus();
					return false;
				}else if(ValidateEmail()){
					var retVal=confirm("Do you want to continue?");
					if (retVal==true){
						document.getElementById('hid').value = 1;
						//document.getElementById('hidOnload').value = 2;
						document.frmUser.submit();
					}else{
						return false;
					}	
				}	
			}
		
			function echeck(str) {
				var at="@";
				var dot=".";
				var lat=str.indexOf(at);
				var lstr=str.length;
				var ldot=str.indexOf(dot);
				if (str.indexOf(at)==-1){
				   alert("Invalid E-mail ID");
				   return false;
				}
				if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
				   alert("Invalid E-mail ID");
				   return false;
				}
				if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
				    alert("Invalid E-mail ID");
				    return false;
				}
				 if (str.indexOf(at,(lat+1))!=-1){
				    alert("Invalid E-mail ID");
				    return false;
				 }
				 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
				    alert("Invalid E-mail ID");
				    return false;
				 }
				 if (str.indexOf(dot,(lat+2))==-1){
				    alert("Invalid E-mail ID");
				    return false;
				 }
				 if (str.indexOf(" ")!=-1){
				    alert("Invalid E-mail ID");
				    return false;
				 }
		 		 return true;					
			}

			function ValidateEmail(){
					var emailID=document.frmUser.userEmail
					if ((emailID.value==null)||(emailID.value=="")){
						alert("Please Enter Email ID");
						document.frmUser.userEmail.focus();
						return false;
					}
					if (echeck(emailID.value)==false){
						//emailID.value="";
					    document.frmUser.userEmail.focus();
						return false;
					}
					return true
			 }
			
			// get role caption	
			function getRoleName(){
				var eleObjArr=document.getElementById('selRole').options;
				for(var i=0;i< eleObjArr.length;i++){
				if(eleObjArr[i].selected){
						document.getElementById('hidRoleName').value = eleObjArr[i].text
					}
				}
			}
	</script>
	</head>
	<body>
			<form name="frmUser" id="frmUser" method=post>
			<input type="hidden" name="hidNickName" name="hidNickName" value="<%=nickName%>"/>
			<input type="hidden" name="hidDisplayName" name="hidDisplayName" value="<%=disName%>"/>
			<div id="validatenames" name="validatenames">
			</div>
			<div>
				<font color=red><%=remark%></font>
			</div>
			<table width="100%" align="center" >
				<tr>
					<td align=center><b>Update Profile</b></td>
				</tr>
			</table>
			<table width="100%" align="center" >
				<tr>
				    <td>
				        <fieldset id="fldsetpersonal"> 
								<legend >
									<font size="3" color="#003399" ><b>Update User's Details</b> </font>
								</legend >
								<table width="100%" align="center" >
								<tr class="contentDark">
									<td class="colheadinguser1">&nbsp;First name </b></font></td>
									<td class="colheadinguser1">&nbsp;Middle name</b></font></td>
									<td class="colheadinguser1">&nbsp;Last name </b></font></td>
									<td class="colheadinguser1">&nbsp;Password</b></font></td>
								</tr>
								<tr class="contentLight">
									<td><input class="input" type="text" name="txtFUserName" id="txtFUserName" onfocus = "this.style.background = '#FFFFCC'" style="width:4cm"  value="<%=fName%>" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')" ></td>

									<td><input class="input" type="text" name="txtMUserName" id="txtMUserName" onfocus = "this.style.background = '#FFFFCC'" value="<%=mName%>" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')" style="width:4cm" ></td>		
			
									 <td><input class="input" type="text" name="txtLUserName" id="txtLUserName" onfocus = "this.style.background = '#FFFFCC'" value="<%=sName%>" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')" style="width:4cm"></td>					

									<td><input class="input" type="password" name="password" id="password" onfocus = "this.style.background = '#FFFFCC'"  value="<%=password%>" style="width:4cm" onKeyPress="return keyRestrict(event,'0123456789abcdefghijklmnopqrstuvwxyz')">
									</td>							
								</tr>
								<tr class="contentDark">
									<td class="colheadinguser1">&nbsp;Username</td>
								    <td class="colheadinguser1">&nbsp;Date of Birth </td>
									<td class="colheadinguser1">&nbsp;Place Of Birth</td>
									<td class="colheadinguser1">&nbsp;Mobile number</td>
								</tr>
								<tr class="contentLight">
								    <td><input class="input" type="text" name="txtNickName" id="txtNickName"  value="<%=nickName%>" onKeyPress="return  keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')" onfocus = "this.style.background = '#FFFFCC'" style="width:4cm"  readonly></td>
						
								    <td>
									    <input class="input" type="text" name="txtDob" id="txtDob" value="<%=dob%>" readonly style="width:4cm">
									    <a href="javascript:showCal('DOBCalendar', 'Birth Date', 'txtDob', 'frmUser')"> 
									    <IMG src="../../images/cal.gif" width="15" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
					
								    <td><input class="input" type="text" name="txtPob" id="txtPob" onfocus = "this.style.background = '#FFFFCC'" value="<%=pob%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')" style="width:4cm"></td>
								
									<td><input type=text class="input" name="userContact" id="userContact"  value="<%=userContact%>" onfocus = "this.style.background = '#FFFFCC'"  onKeyPress="return keyRestrict(event,'1234567890');"  style="width:4cm">
									</td>
								</tr>
								<tr class="contentDark">
								    <td class="colheadinguser1"> &nbsp;Display Name</b></font></td>
								    <td class="colheadinguser1"> &nbsp;Email Id</b></font></td>
								    <td class="colheadinguser1">&nbsp;Gender </b></font></td>
									 <td class="colheadinguser1">&nbsp; </b></font></td>
								</tr>
								<tr class="contentLight">
									<td>
			 					   <input class="input" type="text" name="txtdisName" id="txtdisName" onfocus = "this.style.background = '#FFFFCC'"  value="<%=disName%>" onKeyPress="return keyRestrict(event,' ()abcdefghijklmnopqrstuvwxyz')" style="width:4cm" onblur="validateName('2')">
									</td>
									<td>
									<input type=text class="input" style="width:5cm" name="userEmail" id="userEmail"  value="<%=userEmail%>" onfocus = "this.style.background = '#FFFFCC'" onKeyPress="return keyRestrict(event,'@.abcdefghijklmnopqrstuvwxyz1234567890_');" >
									</td>
									 <td>
									 	<select class="input" name="selGender" id="selGender" style="width:4cm">
										<option value="M" <%=sex.equalsIgnoreCase("M")?"Selected":""%>>Male</option>
											<option value="F" <%=sex.equalsIgnoreCase("F")?"Selected":""%>>Female</option>
										</select>
									</td>
									 <td>
									 	&nbsp;
									</td>
								</tr>
								<tr class="contentDark">
									<td class="colheadinguser1"> &nbsp;Country</td>
								    <td class="colheadinguser1"> &nbsp;State</td>
								    <td class="colheadinguser1" colspan="2"> &nbsp;City</td>
								</tr>
								<tr class="contentLight">
									<td>
										 <select class="input" name="selCountry" id="selCountry" onchange="getState()" style="width:4cm">
										 		<option value="0" size=3>--select--</option>
<%	try{
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
		vparam.add("3");
	    crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_userInfo",vparam,"ScoreDB");
        vparam.removeAllElements();	
        String hidOnload ="";
		hidOnload = request.getParameter("hidOnload")!=null?request.getParameter("hidOnload"):"";
		if(crsObjRolesCrs != null){	
			while(crsObjRolesCrs.next()){	
			if (hidOnload.equals("")){
				countryId = "1";
			}
%>						<option value="<%=crsObjRolesCrs.getString("id")%>" <%=countryId.equals(crsObjRolesCrs.getString("id"))?"selected":""%>><%=crsObjRolesCrs.getString("name")%></option>
<%			}
		 }
	   }catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
%>	
							  			  </select>			   
									</td>			
								     <td> 
									    	<div id="stateDiv" name="stateDiv">
										    	<select class="input" name="selState" id="selState" onchange="getLocation()" style="width:4cm">
												 		<option value="0">--select--</option>
<%	try{
		vparam.add("");
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
        crsObjStateCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_userInfo",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjStateCrs != null){	
			while(crsObjStateCrs.next()){	
%>							
						<option value="<%=crsObjStateCrs.getString("id")%>" <%=stateId.equals(crsObjStateCrs.getString("id"))?"selected":""%>><%=crsObjStateCrs.getString("name")%></option>
						
<%			}
		 }
	   }catch(Exception e) {
		log.writeErrLog(page.getClass(),matchId,e.toString());
	   }
%>	
												 		
									  			</select>	
								  			 </div> 
									  </td>
								      <td colspan="2"> 
								      		 <div id="locationDiv" name="locationDiv" >
										    	  <select class="input" name="selLocation" id="selLocation" style="width:4cm">
												 		<option value="0">--select--</option>
<%	try{	
		vparam.add("");
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
        crsObjStateCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_userInfo",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjStateCrs != null){	
			while(crsObjStateCrs.next()){	
%>							
						<option value="<%=crsObjStateCrs.getString("id")%>" <%=locationId.equals(crsObjStateCrs.getString("id"))?"selected":""%>><%=crsObjStateCrs.getString("name")%></option>
					
<%			}
		 }
	}catch(Exception e)	 {
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>												 		
									  			</select>	
								  			  </div>
									  <input type="hidden" name="hdselCountry" id="hdselCountry" value="<%=countryId%>">
									  <input type="hidden" name="selState" id="selState" value="<%=stateId%>">
									  <input type="hidden" name="selLocation" id="selLocation" value="<%=locationId%>">
									  </td>
								</tr>
								<tr class="contentDark">
									<td class="colheadinguser1" colspan=1>&nbsp;Address</b></font></td>
									<td>
										&nbsp;
									</td>
									<td>
										&nbsp;
									</td>
									<td>
										&nbsp;
									</td>
								</tr>
								<tr class="contentLight">
									<td colspan=1><textarea style="width:7cm" cols="40" rows="3" name="userAddress" id="userAddress"  onfocus = "this.style.background = '#FFFFCC'"  onKeyPress="return keyRestrict(event,',./;:~abcdefghijklmnopqrstuvwxyz 1234567890');"><%=address%></textarea>
									</td>
									<td>
										&nbsp;
									</td>
									<td>
										&nbsp;
									</td>
									<td>
										&nbsp;
									</td>
								</tr>
							</table>
						</fieldset>
				</td>
			</tr>
		</table>
		<br>
		<table align=center width=100%>
			<tr>
				<td align=center><input type=button value="Update" onclick="validateData()" class="button1">
				&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value="Cancel" onclick="cancel()" class="button1"></td>	
			</tr>
		</table>
		<input type=hidden name="hidUserId" id="hidUserId" value="<%=userId%>"/>
		<input type=hidden name="hid" id="hid" value=""/>
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

function getState(){ // get state based on country id
	 xmlHttp=GetXmlHttpObject();
	  if (xmlHttp==null){
		  alert ("Browser does not support HTTP Request") ;
		  return;
	  }
	  else{
			param = 8;
			var countryId = document.getElementById('selCountry').value;
			var url= "/cims/jsp/admin/SearchUser.jsp?countryId="+countryId + "&param="+param;
			xmlHttp.onreadystatechange=stateChangedLAS4;
			xmlHttp.open("get",url,false);
			xmlHttp.send(null);
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				 var responseResult = xmlHttp.responseText ;
				 document.getElementById('stateDiv').innerHTML = responseResult ;
			}
	   }
}

function stateChangedLAS4(){
	
 } 

function getLocation(){ // get location based on state id
	 xmlHttp=GetXmlHttpObject();
	  if (xmlHttp==null){
		  alert ("Browser does not support HTTP Request") ;
		  return;
	  }
	  else{
			param = 9;
			var stateId = document.getElementById('selState').value;
			//alert("stateid" +stateId);
			var url= "/cims/jsp/admin/SearchUser.jsp?stateId="+stateId + "&param="+param;
			xmlHttp.onreadystatechange=stateChangedLAS5;
			xmlHttp.open("get",url,false);
			xmlHttp.send(null);
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				  var responseResult = xmlHttp.responseText ;
				  document.getElementById('locationDiv').innerHTML = responseResult ;
			}
	   }
}

function stateChangedLAS5(){
	
 } 

 function cancel()
 {
	 window.close();
 }
	
	// Getting User Data
function validateName(flag){
 xmlHttp=GetXmlHttpObject();
  if (xmlHttp==null){
	  alert ("Browser does not support HTTP Request") ;
	  return;
  }
  else
  { 
		
		var param = 1;
		var userId      = document.getElementById('hidUserId').value;
		//alert(userId);
		var nickName	= document.getElementById('txtNickName').value;
		var displayName = document.getElementById('txtdisName').value;
		var hidNick		= document.getElementById('hidNickName').value;
		var hidDis		= document.getElementById('hidDisplayName').value;

		if (flag=="1")
		{
			if (nickName!=hidNick)	
			{
			  param = 6;
			  var url= "/cims/jsp/admin/SearchUser.jsp?nickName="+nickName  + "&param="+param + "&userId="+userId;
			}
		}
		
		if (flag=="2")
		{
			if (displayName!=hidDis)	
			{
			  param = 5;
			  var url= "/cims/jsp/admin/SearchUser.jsp?displayName="+displayName  + "&param="+param + "&userId="+userId;
			  xmlHttp.onreadystatechange=stateChangedLAS2;
			  xmlHttp.open("get",url,false);
			  xmlHttp.send(null);
				 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
				 {
				   var responseResult= xmlHttp.responseText ;
				   document.getElementById('validatenames').innerHTML=responseResult;
		
				 }
			}
			
		}
   }
}

function stateChangedLAS2(){
	
 }	 
</script>
</html>