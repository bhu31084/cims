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
<%@ page import="in.co.paramatrix.common.*"%>

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
    CachedRowSet  crsObjRolesCrs =  null;
    CachedRowSet  crsObjStateCrs =  null;
    CachedRowSet  userDataCrs	 =  null;
    CachedRowSet  updateUserCrs	 =  null;
	CachedRowSet deleteUserPhotographCrs = null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
    Vector vparam 			     =  new Vector();
	ReplaceApostroph replaceApos = new ReplaceApostroph();
%>
<%	String nickName 		= "";
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
	String battingRight		= "";
	String bowlingRight		= "";
	String locationId		= "";
	String address			= "";
	String userContact		= "";
	String hidUserId		= "";
	String playerId			= "";
	String retvalue			= "";
	String remark			= "";
	String updateParam  	= "";
	String userIdParam 		= "";
	String deleteParam		= "";
	String status			= "";
	String team				= "";
	String matchId			= "";
	String disName			= "";
	String hidRoleName		= "";
	String userId			= "";
	String userRole			= "";
	String userEmail		= "";
	String hid				= "";
	String searchNickName   = "";
	String searchFirstName  = "";
	String searchMiddleName = "";
	String searchLastName   = "";
	String teamPlayerId		= "";
	String retvalueOne		= "";
	String serverMessage 	= null;
	String photoUpload		= "";
	String imageName 		= "";
	String filePath			= ""; 
	String imageUserId		= "";
	String userExistingPhotograph = "";
	//String inputFile		= "";
	int lastPageNo			= 0;
	int randomInt=0;
	FileInputStream fis     = null;
	File inputFile			= null;
	FileOutputStream os     = null;
	BufferedImage buffImage = null;
	Random randomGenerator = new Random();
    randomInt = randomGenerator.nextInt(100000);   
	//session.setAttribute("matchid","153");
	matchId 		    = (String)session.getAttribute("matchid");
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	//userRole			= (String)session.getAttribute("role");
	LogWriter log 		= new LogWriter();
	userId				= request.getParameter("userid")!=null?request.getParameter("userid"):"";
%>
<%!	 public String validateData(Vector lvValidatorId, Vector lvFormsData, Vector lvFieldName, DataValidator dv) throws NoEntity, InvalidEntity {
		   StringBuffer serverRemark = new StringBuffer();
		  	for(int i = 0; i < lvValidatorId.size(); i++ ) {
		   		for(int k=0; k < lvFieldName.size(); k++)	{
					test:
		   				for(int j = 0; j < lvFormsData.size(); j++) {
							try {
									dv.validate((String)lvValidatorId.elementAt(i), lvFormsData.elementAt(j));
									i++;
									k++;
									continue test;
							} catch (in.co.paramatrix.common.exceptions.RuleViolated ruleViolated) {
								serverRemark.append("'"+lvFieldName.elementAt(k)+"',");		
								i++;
								k++;							 
							} 
						}
				}
			}
			if(serverRemark.length() > 0) {
				serverRemark.deleteCharAt(serverRemark.lastIndexOf(","));
			}
			return serverRemark.toString();
	}
%>
<%--code to save user records --%>
<% 	updateParam = request.getParameter("hidUpdate")!=null?request.getParameter("hidUpdate"):"";
	userIdParam = request.getParameter("hidUserId")!=null?request.getParameter("hidUserId"):"";
	hid 		= request.getParameter("hid")!=null?request.getParameter("hid"):"";
	String hidUpdate = request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
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
			vparam.add("");
			vparam.add("");
			vparam.add(hidUserId);
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("3");
		  	updateUserCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
		}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>
	
<%	//code to get searched user records
try{
	hidUserId = request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
	vparam.add("");
	vparam.add("");
  	vparam.add("");
  	vparam.add("");
  	vparam.add("");
  	vparam.add("");
  	vparam.add(hidUserId);
  	vparam.add(""); 
  	vparam.add("");
	vparam.add("");
  	vparam.add("2");
	userDataCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_userInfo",vparam,"ScoreDB");
	vparam.removeAllElements();	
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
				battingRight = userDataCrs.getString("batting_right")!=null?userDataCrs.getString("batting_right").trim():"";
				bowlingRight = userDataCrs.getString("bowling_right")!=null?userDataCrs.getString("bowling_right").trim():"";
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
<% //code to get country , state and city
try{
	hidUserId = request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
	if (!(hid.equals("1"))) {
		vparam.add("");
		vparam.add("");
	  	vparam.add("");
	  	vparam.add("");
	  	vparam.add("");
	  	vparam.add("");
	  	vparam.add(hidUserId);
	  	vparam.add("");
	  	vparam.add("");
		vparam.add("");
	  	vparam.add("6");
		hidUserId = request.getParameter("hiduserId");
		userDataCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_userInfo",vparam,"ScoreDB");
		vparam.removeAllElements();	
	    if(userDataCrs != null){	
				while(userDataCrs.next()){	
					locationId	 = userDataCrs.getString("location")!=null?userDataCrs.getString("location"):"";
					stateId   	 = userDataCrs.getString("state")!=null?userDataCrs.getString("state"):"";
					countryId  	 = userDataCrs.getString("country")!=null?userDataCrs.getString("country"):"";
				}
		 }
	 }	 
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	} 
%>

<%	//code to get searched user records for team player map
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
				battingRight = userDataCrs.getString("batting_right")!=null?userDataCrs.getString("batting_right").trim():"";
				bowlingRight = userDataCrs.getString("bowling_right")!=null?userDataCrs.getString("bowling_right").trim():"";
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
<%  // code to save new user   
    try{
   		 if (hid!=null && hid.equalsIgnoreCase("1") && !(updateParam.equalsIgnoreCase("update"))){
			nickName 	= request.getParameter("txtNickName")!=null?request.getParameter("txtNickName"):"";
			fName    	= request.getParameter("txtFUserName")!=null?request.getParameter("txtFUserName"):"";
			mName    	= request.getParameter("txtMUserName")!=null?request.getParameter("txtMUserName"):"";
			sName	 	= request.getParameter("txtLUserName")!=null?request.getParameter("txtLUserName"):"";
			disName		= request.getParameter("txtdisName")!=null?request.getParameter("txtdisName"):"";	
			password 	= request.getParameter("password")!=null?request.getParameter("password"):"";
			//pass_encr	= request.getParameter("npassword")!=null?request.getParameter("npassword"):"";
			dob		 	= commonUtil.formatDate(request.getParameter("txtDob")); 
			pob		 	= request.getParameter("txtPob")!=null?request.getParameter("txtPob"):"";
			sex 	 	= request.getParameter("selGender")!=null?request.getParameter("selGender"):"";
			roleId	 	= request.getParameter("selRole")!=null?request.getParameter("selRole"):"";
			team		= request.getParameter("selTeam")!=null?request.getParameter("selTeam"):"";
			clubId	 	= request.getParameter("selClub")!=null?request.getParameter("selClub"):"";
			address		= request.getParameter("userAddress").trim()!=null?request.getParameter("userAddress").trim():"";
			userContact = request.getParameter("userContact").trim()!=null?request.getParameter("userContact").trim():"";
			userEmail	= request.getParameter("userEmail").trim()!=null?request.getParameter("userEmail").trim():"";
			countryId	= request.getParameter("selCountry").trim()!=null?request.getParameter("selCountry").trim():"";
			stateId		= request.getParameter("selState").trim()!=null?request.getParameter("selState").trim():"";
			locationId  = request.getParameter("selLocation").trim()!=null?request.getParameter("selLocation").trim():"";
			status		= request.getParameter("status")!=null?request.getParameter("status"):"";
			battingRight= request.getParameter("selbatsmanright")!=null?request.getParameter("selbatsmanright"):"";
			bowlingRight= request.getParameter("selbowlerright")!=null?request.getParameter("selbowlerright"):"";
			hidRoleName = request.getParameter("hidRoleName")!=null?request.getParameter("hidRoleName"):"";	
						
			Vector lvFormsData = new Vector();
			Vector lvValidatorId = new Vector();
			Vector lvFieldName = new Vector();
			if(!mName.equals("")) {
				lvFormsData.add(mName);
				lvValidatorId.add("mName");
				lvFieldName.add("Middle Name");			
			}			
			if(!dob.equals("")) {
				lvFormsData.add(dob);
				lvValidatorId.add("dateOfBirth");
				lvFieldName.add("Date Of Birth");		
			}			
			if(!pob.equals("")) {
				lvFormsData.add(pob);
				lvValidatorId.add("name");
				lvFieldName.add("Place Of Birth");	
			}			
			if(!address.equals("")) {
				lvFormsData.add(address);
				lvValidatorId.add("name");
				lvFieldName.add("Address");	
			}		
		   	lvFormsData.add(nickName);
			lvValidatorId.add("name");
			lvFieldName.add("Nick Name");
			
			lvFormsData.add(fName);
			lvValidatorId.add("name");	
			lvFieldName.add("First Name");		
		
			lvFormsData.add(sName);
			lvValidatorId.add("name");
			lvFieldName.add("Last Name");
			
			lvFormsData.add(disName);
			lvValidatorId.add("name");
			lvFieldName.add("Display Name");
			
			lvFormsData.add(password);
			lvValidatorId.add("password");
			lvFieldName.add("Password");
			
			lvFormsData.add(sex);
			lvValidatorId.add("sex");
			lvFieldName.add("Gender");
			
			lvFormsData.add(roleId);
			lvFieldName.add("Role Id");
			lvValidatorId.add("id");
			
			lvFormsData.add(clubId);	
			lvValidatorId.add("id");
			lvFieldName.add("Club Id");	
				
			lvFormsData.add(status);	
			lvValidatorId.add("status");
			lvFieldName.add("Status");

			in.co.paramatrix.common.validator.DataValidator dv = (DataValidator)application.getAttribute("datavalidator");
			serverMessage = validateData(lvValidatorId, lvFormsData, lvFieldName, dv);
			
			if(serverMessage.equals("")) {
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
				vparam.add(replaceApos.replacesingleqt(address));
				vparam.add(userContact);
				vparam.add(userEmail);
				vparam.add(roleId);
				vparam.add(clubId);
				if (roleId.equalsIgnoreCase("1")){
					vparam.add(team);	
				}else{
					vparam.add("");
				}
				vparam.add("");
				vparam.add("");
				vparam.add(locationId);
				vparam.add("");
				vparam.add("");
				vparam.add(battingRight);
				vparam.add(bowlingRight);
				vparam.add("1");
		        updateUserCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.amd_user",vparam,"ScoreDB");
				vparam.removeAllElements();		
				
				AuthZ authz = AuthZ.getInstance();
				
				try {				
					authz.addUser(nickName);
				} catch(Exception e){
					log.writeErrLog("Error Authz [AddUser] "+ e);
					//out.println("Exception" + e);
				}
				
				try {
					authz.mapUserToRole(nickName, hidRoleName);
				} catch(Exception e) {
					log.writeErrLog("Error Authz [Map User] "+ e);
					//out.println("Exception" + e);
				}
			} // end of if serverMessage
		}else if(hid!=null && hid.equalsIgnoreCase("1") && updateParam.equalsIgnoreCase("update")){
			//code to update user records
			hidUserId	= request.getParameter("hiduserId")!=null?request.getParameter("hiduserId"):"";
			//System.out.println("hidUserId ++++++++++++++++++++++++" +hidUserId);
			nickName 	= request.getParameter("txtNickName")!=null?request.getParameter("txtNickName"):"";
			fName    	= request.getParameter("txtFUserName")!=null?request.getParameter("txtFUserName"):"";
			mName    	= request.getParameter("txtMUserName")!=null?request.getParameter("txtMUserName"):"";
			sName	 	= request.getParameter("txtLUserName")!=null?request.getParameter("txtLUserName"):"";
			disName		= request.getParameter("txtdisName")!=null?request.getParameter("txtdisName"):"";	
			password 	= request.getParameter("password")!=null?request.getParameter("password"):"";
			pass_encr	= request.getParameter("npassword")!=null?request.getParameter("npassword"):"";
			dob		 	= commonUtil.formatDate(request.getParameter("txtDob"));
			pob		 	= request.getParameter("txtPob")!=null?request.getParameter("txtPob"):"";
			sex 	 	= request.getParameter("selGender")!=null?request.getParameter("selGender"):"";
			address		= request.getParameter("userAddress").trim()!=null?request.getParameter("userAddress").trim():"";
			userContact = request.getParameter("userContact").trim()!=null?request.getParameter("userContact").trim():"";
			userEmail	= request.getParameter("userEmail").trim()!=null?request.getParameter("userEmail").trim():"";
			countryId	= request.getParameter("selCountry").trim()!=null?request.getParameter("selCountry").trim():"";
			stateId		= request.getParameter("selState").trim()!=null?request.getParameter("selState").trim():"";
			locationId  = request.getParameter("selLocation").trim()!=null?request.getParameter("selLocation").trim():"";
			roleId	 	= request.getParameter("selRole")!=null?request.getParameter("selRole"):"";
			clubId	 	= request.getParameter("selClub")!=null?request.getParameter("selClub"):"";
			team		= request.getParameter("selTeam")!=null?request.getParameter("selTeam"):"";
			status		= request.getParameter("status")!=null?request.getParameter("status"):"";
			battingRight= request.getParameter("selbatsmanright")!=null?request.getParameter("selbatsmanright"):"";
			bowlingRight= request.getParameter("selbowlerright")!=null?request.getParameter("selbowlerright"):"";
			hidRoleName = request.getParameter("hidRoleName")!=null?request.getParameter("hidRoleName"):"";
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
			vparam.add(replaceApos.replacesingleqt(address));
			vparam.add(userContact);
			vparam.add(userEmail);
			vparam.add(roleId);
			vparam.add(clubId);
			if (roleId.equalsIgnoreCase("1")){
				vparam.add(team);	
			}else{
				vparam.add("");	
			}
			if (userId!=""){
				vparam.add(userId);	
			}else{	
				vparam.add(userIdParam);
			}	
			vparam.add("");
			vparam.add(locationId);
			vparam.add("");
			vparam.add("");
			vparam.add(battingRight);
			vparam.add(bowlingRight);
			vparam.add("2");
	        updateUserCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.amd_user",vparam,"ScoreDB");
			vparam.removeAllElements();	
			AuthZ authz = AuthZ.getInstance();
				try {				
					authz.addUser(nickName);
				} catch(Exception e){
					log.writeErrLog("Error Authz update [AddUser] "+ e);
					//out.println("Exception" + e);
				}
				
				try {
					authz.mapUserToRole(nickName, hidRoleName);
				} catch(Exception e) {
					log.writeErrLog("Error Authz update [Map User] "+ e);
					//out.println("Exception" + e);
				}
		}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>

<% try{
		if(hid!=null && hid.equalsIgnoreCase("6")){
			roleId	 	= request.getParameter("selRole")!=null?request.getParameter("selRole"):"";
			clubId	 	= request.getParameter("selClub")!=null?request.getParameter("selClub"):"";
			team		= request.getParameter("selTeam")!=null?request.getParameter("selTeam"):"";
		}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>

<html>
 <head>
	<title>User Master</title>   
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" /> 
	<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
	<script language="JavaScript" src="../../js/timer.js" type="text/javascript"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>  
	<script>	 
			// validate user data
			function validateData(){
				var userAddr 	= document.getElementById('userAddress').value;	
				var userContact = document.getElementById('userContact').value;	
				var addrLength 		= userAddr.length; 
				var contactLength	= userContact.length;
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
				}else if(ValidateEmail()){
					 if(document.getElementById('selRole').value == "1"){
					 	 if (document.getElementById('selTeam').value == ""){
					  		alert("Select Team");
					  		document.frmUser.selTeam.focus();
					  		return false;
					  	 }	
					}
					getRoleName();
					var retVal=confirm("Do you want to continue?");
					if (retVal==true){
						document.getElementById('hid').value = 1;
						document.getElementById('hidOnload').value = 2;
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
				if(document.getElementById('selRole').value != "1"){
					var emailID=document.frmUser.userEmail
					if ((emailID.value==null)||(emailID.value=="")){
						alert("Please Enter Email ID");
						emailID.focus();
						return false;
					}
					if (echeck(emailID.value)==false){
						//emailID.value="";
					    emailID.focus();
						return false;
					}
					return true
				}else{
					return true;
				}	
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
			// to change textfield color		
			function changeColour(which) {
				if (which.value.length > 0) {   // minimum 2 characters
					which.style.background = "#FFFFCC"; // white
				}
				else {
					which.style.background = "";  // yellow
					//alert ("This box must be filled!");
					//which.focus();
					//return false;
				}
			}
			
			// to set firstname , middlename , lastname onblur(firstname)
			function setName(){
				var firstName = document.getElementById('txtFUserName').value;
				var splitName = firstName.split(" ");
				if (splitName.length==3){
					var fName = splitName[0];		
					var sName = splitName[1];
					var lName = splitName[2];		
					document.getElementById('txtFUserName').value = fName;
					document.getElementById('txtLUserName').value = lName;
					document.getElementById('txtMUserName').value = sName;
				}else if (splitName.length==2){
					var fName = splitName[0];		
					var sName = splitName[1];
					document.getElementById('txtFUserName').value = fName;
					document.getElementById('txtMUserName').value = "";
					document.getElementById('txtLUserName').value = sName;
				}
			}
			
			//set firstname , middlename , lastname in search option		
			function searchName(){
				var firstName = document.getElementById('searchFirstName').value;
				var splitName = firstName.split(" ");
				if (splitName.length==3){
					var fName = splitName[0];		
					var sName = splitName[1];
					var lName = splitName[2];		
					document.getElementById('searchFirstName').value = fName;
					document.getElementById('searchMiddleName').value = sName;
					document.getElementById('searchLastName').value = lName;
				}else if (splitName.length==2){
					var fName = splitName[0];		
					var sName = splitName[1];
					document.getElementById('searchFirstName').value = fName;
					document.getElementById('searchMiddleName').value = "";
					document.getElementById('searchLastName').value = sName;
				}
			}

			// validate display name
			function validateDispName(){
				var firstName = document.getElementById('txtFUserName').value;
				var middleName= document.getElementById('txtMUserName').value;
				var lastName  = document.getElementById('txtLUserName').value;
				if (document.getElementById('txtdisName').value =="" && firstName!="" && middleName!="" && lastName!=""){
					alert("Enter Display Name");
					document.frmUser.txtdisName.focus();
					return false;
				}else if (document.getElementById('txtdisName').value !=""){
					validateName();
				}	
			}
			
			//validate nickname
			function validateNickName(){
				var firstName = document.getElementById('txtFUserName').value;
				var middleName= document.getElementById('txtMUserName').value;
				var lastName  = document.getElementById('txtLUserName').value;
				if (document.getElementById('txtNickName').value =="" && firstName!="" && middleName!="" && lastName!=""){
					alert("Enter Nick Name");
					document.frmUser.txtNickName.focus();
					return false;
				}else if (document.getElementById('txtdisName').value !=""){
					validateName();
				}	
			}
			
			// onblur set nickname	
			function addNickname(){
				convertToCamelCase('txtFUserName');
				convertToCamelCase('txtMUserName');
				convertToCamelCase('txtLUserName');
				var firstName = document.getElementById('txtFUserName').value;
				var lastName  = document.getElementById('txtLUserName').value;
				var middleName= document.getElementById('txtMUserName').value;
				var nickName  =	document.getElementById('txtNickName').value
				document.getElementById('txtNickName').style.background = '#FFFFCC';
				if (lastName!="" && lastName!=null){
					firstChar = lastName.substring(0,1);
					if (nickName == ""){
						document.getElementById('txtNickName').value = firstName+""+firstChar;			
					}else{
					}	
				}
				else{
					if (firstName=="" && firstName!=null){
						if (nickName == ""){
							document.getElementById('txtNickName').value = "";
						}else{
						}	
					}
				}					
			}
			
			//	onblur set displayname	
			function addDisplayName(){
				convertToCamelCase('txtFUserName');
				convertToCamelCase('txtMUserName');
				convertToCamelCase('txtLUserName');
				var dispName  = document.getElementById('txtdisName').value;
				var firstName = document.getElementById('txtFUserName').value;
				var middleName= document.getElementById('txtMUserName').value;
				var lastName  = document.getElementById('txtLUserName').value;
				//alert(lastName);
				if( dispName == "" && (firstName.length > 10 || lastName.length > 10)){
						dispName = firstName.substring(0,1).toUpperCase() +" "+
							       middleName.substring(0,1).toUpperCase() +" "+
							       lastName;
						document.getElementById('txtdisName').value = dispName;
				}else if (dispName == ""){
						dispName = firstName +" "+lastName;
						document.getElementById('txtdisName').value = dispName;
						//alert(dispName);
				}
				
			}
			 	
			function convertToCamelCase( elementId ){
					var origanalVal = document.getElementById( elementId ).value;
					if( origanalVal != null && origanalVal.length > 1 ){
						document.getElementById(elementId).value = origanalVal.substring(0,1).toUpperCase() + 
												origanalVal.substring(1).toLowerCase();
					}
			}
		
			// ajax function call to search record
			function userSearch(){
					document.getElementById('hidpaging').value = 1;
					doGetUserData();
			}
			
			// To get searched user record	
			function passUserData(userId){
				document.getElementById('hiduserId').value=userId;
				document.getElementById('hid').value = 2;
				document.getElementById('hidOnload').value = 2;
				document.getElementById('hidUpdatePhoto').value = 2; 
				document.getElementById('hidUpdate').value = "update";
				var hidUpdate = document.getElementById('hidUpdate').value;
				var hidUserId = document.getElementById('hiduserId').value;
				document.frmUser.action="/cims/jsp/admin/UserMaster.jsp?hidUpdate="+hidUpdate+"&hidUserId="+hidUserId;
				document.frmUser.submit();
			}
 			
 			// to delete search user record	
			function deleteUser(userId){
					document.getElementById('hiduserId').value=userId;
					document.getElementById('hid').value = 3;
					document.getElementById('hidDelete').value = "delete";
					var hidDelete = document.getElementById('hidDelete').value;
					var hidUserId = document.getElementById('hiduserId').value;
					var retVal=confirm("Do You Want To Continue");
					if (retVal==true){
						document.frmUser.action="/cims/jsp/admin/UserMaster.jsp?hidDelete="+hidDelete+"&hidUserId="+hidUserId;
						document.frmUser.submit();
				}else{
					return false;
				}
			}
				
			function returnAvailablePlayers(flag){
                 if (flag==1){
                     doValidateName(1);
                  }else if(flag==2)   {
                     doValidateName(2);
                  }else if(flag==3)  {
                     doValidateName(3);
                  }
			}
			
			function nextPagingRecords(){
				if (document.getElementById('hidpageid').value ==1){
					document.getElementById('hidpaging').value = document.getElementById('hidpagingno').value
				}
				document.getElementById('hidpageid').value = 2
				var pageNo = document.getElementById('pageNo').value
				if (((document.getElementById('hidpaging').value) < parseInt(pageNo))){
					var val 	= document.getElementById('hidpaging').value;
					document.getElementById('hidpaging').value = parseInt(val) + 1;
					doGetUserData();
				}else{
					alert("These are last records.");
					//return false;	
				}
			}
			
			function previousPagingRecords(){
				if (document.getElementById('hidpageid').value ==1){
					document.getElementById('hidpaging').value = document.getElementById('hidpagingno').value
				}	
				document.getElementById('hidpageid').value = 2
				var val = document.getElementById('hidpaging').value;
				if (document.getElementById('hidpaging').value != 1){
					document.getElementById('hidpaging').value = parseInt(val) - 1;
					doGetUserData();
				}else{
					alert("These are first records.");
					//return false;
				}
			}
			
			function pagingRecords(){
					if (document.getElementById('pagingno').value==""){
						alert("Enter pageno");
						return false;
					}else{
						document.getElementById('hidpageid').value =1;
						document.getElementById('hidpagingno').value = document.getElementById('pagingno').value;
						doGetUserData();
					}
			}

			function selClubTeam(){
				document.getElementById('hid').value = 6;
				document.frmUser.action="/cims/jsp/admin/UserMaster.jsp";
				document.frmUser.submit();
			}
			//function currentDateValidate(enteredDate){
				//var dateDiff = "";
				//var currentTime = new Date()
				//var month 		= currentTime.getMonth() + 1
				//var day 		= currentTime.getDate()
				//if (day > 0 && day < 10){
				//	day = "0"+day;
				//}
				//var year = currentTime.getFullYear()
				//var currDate = day + "/" + month + "/" + year
				//var d1 = new Date(enteredDate);
				//var d2 = new Date(currDate);
			
				//if(d1 > d2) {		
				//	return false
				//}
				//else {
				//	return true
				//} 	
			//}  // end of currentDateValidate
	</script>
 </head>
<body onload="focus()">
<form name="frmUser" id="frmUser" method=post>
 <IFRAME id="download_reports" src="" width="0" height="0" ></IFRAME>
		<input type=hidden name=hid id=hid value="" />
		<input type=hidden name=hiduserId id=hiduserId value=""/>
		<input type=hidden name=hidUpdate id=hidUpdate value="<%=hidUpdate%>"/>
		<input type=hidden name=hidDelete id=hidDelete value="<%=hidUpdate%>"/>
		<input type=hidden name=hidNickName id=hidNickName value="<%=nickName%>" />
		<input type=hidden name=hidDisName id=hidDisName value="<%=disName%>" />
		<input type=hidden name=hidRoleName id=hidRoleName value="" />
		<input type=hidden name=hidSearchNickName   id=hidSearchNickName value="<%=searchNickName%>" />
		<input type=hidden name=hidSearchFirstName  id=hidSearchFirstName value="<%=searchFirstName%>" />
		<input type=hidden name=hidSearchMiddleName id=hidSearchMiddleName value="<%=searchMiddleName%>" />
		<input type=hidden name=hidSearchLastName   id=hidSearchLastName value="<%=searchLastName%>" />
		<input type=hidden name=hidFlag id=hidFlag value="1" />
		<input type=hidden name=hidOnload id=hidOnload value="1" />
		
		<table width=90% >
			<tr>
				<td align=center width=90%>
						<div name="validatenames" id="validatenames"  style:width="0.1%">  
						</div>
				</td>
			</tr>
		</table>	
		
		<div name="duplicateDiv" id="duplicateDiv" style:width="0.1%">
		</div>
		
                
<%	if (updateUserCrs!=null)
	{
		while (updateUserCrs.next())
		{
				retvalue =  updateUserCrs.getString("Retvalue");
				retvalueOne =  updateUserCrs.getString("Retvalue1");
%>        <div name="remarkDiv" id="remarkDiv" style:width="0.1%">
<% 	if (retvalue.equalsIgnoreCase("1") && 														!(retvalueOne.equalsIgnoreCase("6"))){
					remark   =  updateUserCrs.getString("Remark");
%>					<font color=red><%=remark%></font>
<%				}else if (retvalue.equalsIgnoreCase("2")){
						remark   =  updateUserCrs.getString("Remark");
%>					<font color=red><%=remark%></font>
<%			    }else if (retvalue.equalsIgnoreCase("0")){
						remark   =  updateUserCrs.getString("Remark");
%>					<font color=red><%=remark%></font>		
<%				}else if (retvalue.equalsIgnoreCase("4")){
						remark   =  updateUserCrs.getString("Remark");
						teamPlayerId = updateUserCrs.getString("team_player_id")!=null?updateUserCrs.getString("team_player_id"):"";
%>					<font color=red><%=remark%></font>		
<%	}if (retvalue.equalsIgnoreCase("1") && retvalueOne.equalsIgnoreCase("6")){
			remark   =  updateUserCrs.getString("Remark");
			nickName   =  updateUserCrs.getString("Remark2");
			imageUserId   =  updateUserCrs.getString("Remark3");
			session.setAttribute("userNickname",nickName);
			session.setAttribute("userimageUserId",imageUserId);
%>					<font color=red><%=remark%> <a href=# onclick="selClubTeam()">Do you want to add player with same club and team</a></font>
<%				}
		}
%>      </div>
<%  }	
	if(serverMessage != null && !serverMessage.equals("")) {
%>					<font color=red>Supplied data is invalid for following fields  <%=serverMessage%>.</font>
<%	}							
%>	
<%	imageUserId = request.getParameter("hidUserId");
	//System.out.println("imageUserId ************************************" +imageUserId);
	if (imageUserId !=null)
	{
			session.setAttribute("imageUserId",imageUserId);
			//System.out.println("session ************************************" +imageUserId);
%>	<div id="imageDiv">
		<table align=right height="5%" width="15%">
			<tr>
				<td>
					<img src="/cims/jsp/admin/UploadImage.jsp" id="uploadPhotoImg" name="uploadPhotoImg" width="120px" height="80px">
				</td>
			</tr>
		</table>
	</div>
		<br>
		<br>
		<br>
<%	}
%>

<table width="100%" align="center">
				<tr>
				    <td>
				        <fieldset id="fldsetpersonal"> 
<%	if (hid!=null && hid.equalsIgnoreCase("2"))	{
																	
%>
										<a href="/cims/jsp/admin/UserMaster.jsp" class="btn btn-warning" style="text-decoration:none">Add New User</a> 
										
										<legend >
											Update User's Details
										</legend >

<%}else if(hid!=null && hid.equalsIgnoreCase("1")){
%>
										<a href="/cims/jsp/admin/UserMaster.jsp" class="btn btn-warning" style="text-decoration:none">Add New User</a>
										<br>
										<legend  class="legend1">
											Add User Details
										</legend >
<%}else if(hid!=null && hid.equalsIgnoreCase("3")){
%>
										<a href="/cims/jsp/admin/UserMaster.jsp" class="btn btn-warning" style="text-decoration:none">Add New User</a>
										<br>
										<legend >
											<font size="3" color="#400040"><b>User Details</b></font>
										</legend >
<%}else{
%>	
										<legend  class="legend1">
											Add User Details
										</legend >	
<%}
%>				


							<table width=95% class="TableHeader1"  align="center">
								<tr class="contentDark">
									<td class="colheadinguser1">&nbsp;Role</td>
									<td class="colheadinguser1">&nbsp;Association </td>
									<td class="colheadinguser1" colspan="2">&nbsp;Team</b></font> </td>
								</tr>
<%	try{	
		vparam.add((String)session.getAttribute("userid"));//
        crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teams_playermap",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjRolesCrs != null){	
			while(crsObjRolesCrs.next()){	
						userRole = crsObjRolesCrs.getString("role")!=null?crsObjRolesCrs.getString("role"):"";
			}
		 }
	   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	  }
%>									
								<tr class="contentLight">
<%	if (userRole.equalsIgnoreCase("26")){
%>								
									<td>
										 <select class="input" name="selRole" id="selRole" >
										 			<option value="1">Player</option>
							  			  </select>			   
									</td>
<%	}else{
%>	
									<td>
										 <select class="input" name="selRole" id="selRole" style="width:7cm">
										 			<option value="0">--select--</option>
<%	try{	
		vparam.add("1");//
        crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roles",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjRolesCrs != null){	
			while(crsObjRolesCrs.next()){	
%>							
						<option value="<%=crsObjRolesCrs.getString("id")%>" <%=roleId.equals(crsObjRolesCrs.getString("id"))?"selected":""%>><%=crsObjRolesCrs.getString("name")%></option>
						<%--
						<%=playerId.equals(userDataCrs.getString("role"))?"selected":"" %>
						--%>
<%			}
		 }
	   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>	
							  			  </select>			   
									</td>	
<%	}
%>							
<%  if (userRole.equalsIgnoreCase("26")){
%>										
									<td>
										 <select class="input" name="selClub" id="selClub" style="width:7cm" onchange="getTeams()">
										 		<option value="0">--select--</option>
<%try{	
	vparam.add((String)session.getAttribute("userid"));//
    crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teams_playermap",vparam,"ScoreDB");
	vparam.removeAllElements();	
	if(crsObjRolesCrs != null){	
		if(crsObjRolesCrs.first()){	
%>							
			<option value="<%=crsObjRolesCrs.getString("club")%>" <%=clubId.equals(crsObjRolesCrs.getString("club"))?"selected":""%>><%=crsObjRolesCrs.getString("name")%></option>
			<%--
			<%=playerId.equals(userDataCrs.getString("role"))?"selected":"" %>
			--%>
<%		}
	 }
   }catch(Exception e){
	log.writeErrLog(page.getClass(),matchId,e.toString());
}
%>
										  </select>			   
									</td>	
<%	}else{
%>
									<td>
										 <select class="input" name="selClub" id="selClub" style="width:7cm" onchange="getTeams()">
										 		<option value="0">--select--</option>
<%try{	
	vparam.add("2");//
    crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roles",vparam,"ScoreDB");
	vparam.removeAllElements();	
	if(crsObjRolesCrs != null){	
		while(crsObjRolesCrs.next()){	
%>							
					<option value="<%=crsObjRolesCrs.getString("id")%>" <%=clubId.equals(crsObjRolesCrs.getString("id"))?"selected":""%>><%=crsObjRolesCrs.getString("name")%></option>
					<%--
					<%=playerId.equals(userDataCrs.getString("role"))?"selected":"" %>
					--%>
<%		}
	 }
   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>
										  </select>			   
									</td>	
<%	}
%>
<%  if (userRole.equalsIgnoreCase("26")){
%>									
									<td colspan="2">
									<div id="teamsDiv" name="teamsDiv" >
									 <select class="input" name="selTeam" id="selTeam" >
											<option value="0">--select--</option>
<%//**********************************************%>
<%	try{	
		vparam.add((String)session.getAttribute("userid"));//
        crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teams_playermap",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjRolesCrs != null){	
			while(crsObjRolesCrs.next()){	
%>							
						<option value="<%=crsObjRolesCrs.getString("id")%>" <%=team.equals(crsObjRolesCrs.getString("id"))?"selected":""%>><%=crsObjRolesCrs.getString("team_name")%></option>
						<%--
						<%=playerId.equals(userDataCrs.getString("role"))?"selected":"" %>
						--%>
<%			}
		 }
	   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
		}
%>	

<%//**********************************************%>											
									 </select>			 		
									</div>
									<input type="hidden" name="hidselectteam" id="hidselectteam" value="<%=team%>">	 
										 	   
									</td>
<%	}else{
%>	
									<td colspan="2">
									<div id="teamsDiv" name="teamsDiv" >
										<select class="input" name="selTeam" id="selTeam" >
											<option value="0">--select--</option>
<%//********************************************* %>
<%	try{	
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
<%			}
		 }
	   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>	
<%//********************************************* %>											
									 	</select>
									</div>
									<input type="hidden" name="hidselectteam" id="hidselectteam" value="<%=team%>">	  
									</td>			
<%}						
%>
</tr>										
								<tr class="contentDark">
									<td class="colheadinguser1">&nbsp;First name </b></font></td>
									<td class="colheadinguser1">&nbsp;Middle name</b></font></td>
									<td class="colheadinguser1">&nbsp;Last name </b></font></td>
									<td class="colheadinguser1">&nbsp;Password</b></font></td>
								</tr>
								<tr class="contentLight">
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>										
									<td><input class="input" type="text" name="txtFUserName" id="txtFUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "setName();changeColour(this)" value="<%=fName%>" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')" ></td>
<%
	}else{
%>			
									<td><input class="input" type="text" name="txtFUserName" id="txtFUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "setName();changeColour(this)" value="<%=fName%>" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')" ></td>	
<%}
%>		
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>				
									<td><input class="input" type="text" name="txtMUserName" id="txtMUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=mName%>" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')" ></td>
<%}else{
%>	
									<td><input class="input" type="text" name="txtMUserName" id="txtMUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=mName%>" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')" ></td>		
<%}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){
%>					
									<td><input class="input" type="text" name="txtLUserName" id="txtLUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=sName%>" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')" style="width:4cm"></td>
<%}else{
%>			
									 <td><input class="input" type="text" name="txtLUserName" id="txtLUserName" onfocus = "this.style.background = '#FFFFCC'" onblur = "returnAvailablePlayers(1);changeColour(this)" value="<%=sName%>" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')" style="width:4cm"></td>					
<%	}
%>									<td>
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>		  							
				 					   <input class="input" type="password" name="password" id="password" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=password%>" style="width:4cm" onKeyPress="return keyRestrict(event,'0123456789abcdefghijklmnopqrstuvwxyz')">
<%}else{
%>										<input class="input" type="password" name="password" id="password" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=password%>" style="width:4cm" onKeyPress="return keyRestrict(event,'0123456789abcdefghijklmnopqrstuvwxyz')">
<%}
%>									</td>							
								</tr>
								<tr class="contentDark">
								
									<td class="colheadinguser1">&nbsp;Username</td>
								    <td class="colheadinguser1">&nbsp;Date of Birth </td>
									<td class="colheadinguser1">&nbsp;Place Of Birth</td>
									<td class="colheadinguser1">&nbsp;Mobile number</td>
								</tr>
								<tr class="contentLight">
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>									
									<td><input class="input" type="text" name="txtNickName" id="txtNickName" onfocus = "addNickname();addDisplayName();this.style.background = '#FFFFCC'"  onblur = "validateNickName();changeColour(this)" value="<%=nickName%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')" ></td>
<%}else{
%>								    <td><input class="input" type="text" name="txtNickName" id="txtNickName" onfocus = "addNickname();addDisplayName(); this.style.background = '#FFFFCC'"  onblur = "validateNickName();returnAvailablePlayers(3);changeColour(this)" value="<%=nickName%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')" ></td>
<%}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>						
								    <td>
									    <input class="input" type="text" name="txtDob" id="txtDob" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=dob%>" readonly >
									    <a href="javascript:showCal('DOBCalendar', 'Birth Date', 'txtDob', 'frmUser')"> 
									    <IMG src="../../images/cal.gif" width="15" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
<%}else{
%>	
									<td>
									    <input class="input" type="text" name="txtDob" id="txtDob" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=dob%>" readonly >
									    <a href="javascript:showCal('DOBCalendar', 'Birth Date', 'txtDob', 'frmUser')"> 
									    <IMG src="../../images/cal.gif" width="15" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
<%}
%>	
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>					
								    <td><input class="input" type="text" name="txtPob" id="txtPob" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=pob%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')" style="width:4cm"></td>
<%}else{
%>	
									<td><input class="input" type="text" name="txtPob" id="txtPob" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="<%=pob%>" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')" style="width:4cm"></td>				
<%}
%>									
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>								
									<td><input type=text class="input" name="userContact" id="userContact"  value="<%=userContact%>" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,'1234567890');" ></td>
<%}else{
%>	
									<td><input type=text class="input" name="userContact" id="userContact"  value="<%=userContact%>" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,'1234567890');"></td>
<%}
%>
								</tr>
								
								<tr class="contentDark">
									<%--
								    <td colspan=2><font color="#003399"><b>&nbsp;Address</b></font></td>
								    --%>
								    <td class="colheadinguser1"> &nbsp;Display Name</b></font></td>
								    <td class="colheadinguser1"> &nbsp;Email Id</b></font></td>
								    <td class="colheadinguser1"> &nbsp;Status</b></font></td>
									<td class="colheadinguser1">&nbsp;Gender </b></font></td>
									<%--<td colspan=2><font color="#003399"><b>&nbsp;Address</b></font></td>
								--%></tr>
								<tr class="contentLight"><%--
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>								
									<td colspan=2><textarea cols="40" rows="3" name="userAddress" id="userAddress"  onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,',./;:`~abcdefghijklmnopqrstuvwxyz 1234567890');"><%=address%></textarea></td>
<%}else{
%>	
									<td colspan=2><textarea cols="40" rows="3" name="userAddress" id="userAddress"  onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,',./;:`~abcdefghijklmnopqrstuvwxyz 1234567890');"><%=address%></textarea></td>
<%}
%>								
									--%>
									<td>
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>			 					   <input class="input" type="text" name="txtdisName" id="txtdisName" onfocus = "addNickname();addDisplayName();;this.style.background = '#FFFFCC'" onblur = "validateDispName();changeColour(this)" value="<%=disName%>" onKeyPress="return keyRestrict(event,' ()abcdefghijklmnopqrstuvwxyz')" style="width:4cm">
<%	}else{
%>			 					   <input class="input" type="text" name="txtdisName" id="txtdisName" onfocus = "addNickname();addDisplayName();;this.style.background = '#FFFFCC'" onblur = "validateDispName();returnAvailablePlayers(2);changeColour(this)" value="<%=disName%>" onKeyPress="return keyRestrict(event,' ()abcdefghijklmnopqrstuvwxyz')" style="width:4cm">
<%	}
%>									</td>
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>								
									<td><input type=text class="input" style="width:7cm" name="userEmail" id="userEmail"  value="<%=userEmail%>" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,'@.-_abcdefghijklmnopqrstuvwxyz1234567890');" ></td>
<%}else{
%>	
									<td><input type=text class="input" style="width:7cm" name="userEmail" id="userEmail"  value="<%=userEmail%>" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,'@.-_abcdefghijklmnopqrstuvwxyz1234567890');" ></td>
<%}
%>	
								
									<td>
										<select class="input" name="status" id="status" style="width:4cm">
								    		<%--<option value="0">--select--</option>
											--%><option value="A" <%=status.equalsIgnoreCase("A")?"Selected":""%>>Active</option>
											<option value="I" <%=status.equalsIgnoreCase("I")?"Selected":""%>>InActive</option>
										</select>
									</td>
									 <td>
									 	<select class="input" name="selGender" id="selGender" style="width:4cm"><%--
								    		<option value="1">--select--</option>
											--%><option value="M" <%=sex.equalsIgnoreCase("M")?"Selected":""%>>Male</option>
											<option value="F" <%=sex.equalsIgnoreCase("F")?"Selected":""%>>Female</option>
										</select>
									</td>
<%--<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>								
									<td colspan=2><textarea cols="20" rows="3" name="userAddress" id="userAddress"  onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,',./;:`~abcdefghijklmnopqrstuvwxyz 1234567890');"><%=address%></textarea></td>
<%}else{
%>	
									<td colspan=2><textarea cols="20" rows="3" name="userAddress" id="userAddress"  onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,',./;:`~abcdefghijklmnopqrstuvwxyz 1234567890');"><%=address%></textarea></td>
<%}
%>	
								--%>
								</tr>
								<tr class="contentDark">
									<td class="colheadinguser1"> &nbsp;Country</td>
								    <td class="colheadinguser1"> &nbsp;State</td>
								    <td class="colheadinguser1" colspan="2"> &nbsp;City</td>
								</tr>
								<tr class="contentLight">
									<td>
										 <select class="input" name="selCountry" id="selCountry" onchange="getState()" style="width:7cm">
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
						<%--
						<%=playerId.equals(userDataCrs.getString("role"))?"selected":"" %>
						--%>
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
										    	<select class="input" name="selState" id="selState" onchange="getLocation()" style="width:7cm">
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
										    	  <select class="input" name="selLocation" id="selLocation" style="width:9cm">
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
									<td class="colheadinguser1">&nbsp;Address</td>
									<td class="colheadinguser1" colspan=>&nbsp;Batsman Discipline</td>
									<td class="colheadinguser1" colspan=2>&nbsp;Bowler Discipline</td>
								</tr>
								<tr class="contentLight">
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>								
									<td><textarea cols="30" rows="3" name="userAddress" id="userAddress"  onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,',./;:~abcdefghijklmnopqrstuvwxyz 1234567890');"><%=address%></textarea></td>
									<td>  
										<select id="selbatsmanright" name="selbatsmanright">
											<option value="1" <%=battingRight.equalsIgnoreCase("1")?"selected":""%>>R.H.B.</option>
											<option value="0" <%=battingRight.equalsIgnoreCase("0")?"selected":""%>>L.H.B.</option>
										</select>
									</td>
									<td>
										<select id="selbowlerright" name="selbowlerright">
											<option value="1" <%=bowlingRight.equalsIgnoreCase("1")?"selected":"" %>>R.H.B.</option>
											<option value="0" <%=bowlingRight.equalsIgnoreCase("0")?"selected":"" %>>L.H.B.</option>
										</select>
									</td>	

<%}else{
%>	
									<td><textarea cols="30" rows="3" name="userAddress" id="userAddress"  onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,',./;:~abcdefghijklmnopqrstuvwxyz 1234567890');"><%=address%></textarea></td>
									<td>  
										<select id="selbatsmanright" name="selbatsmanright">
											<option value="1" <%=battingRight.equalsIgnoreCase("1")?"selected":"" %>>R.H.B.</option>
											<option value="0" <%=battingRight.equalsIgnoreCase("0")?"selected":"" %>>L.H.B.</option>
										</select>
									</td>
									<td>
										<select id="selbowlerright" name="selbowlerright">
											<option value="1" <%=bowlingRight.equalsIgnoreCase("1")?"selected":"" %>>R.H.B.</option>
											<option value="0" <%=bowlingRight.equalsIgnoreCase("0")?"selected":"" %>>L.H.B.</option>
										</select>
									</td>
<%}
%>									
<%
String hidUpdatePhoto = request.getParameter("hidUpdatePhoto")!=null?request.getParameter("hidUpdatePhoto"):"";
System.out.println("hidUpdatePhoto" +hidUpdatePhoto);
if ((retvalue.equalsIgnoreCase("1") && retvalueOne.equalsIgnoreCase("6")) && (hidUpdatePhoto.equalsIgnoreCase("")))
	{
		
%>	
		<td><a href="/cims/jsp/admin/FileUpload.jsp">Upload  Photo</a></td>
<%	}
%>
<%	System.out.println("hidUpdatePhoto" +hidUpdatePhoto);
	if ((hidUpdatePhoto.equalsIgnoreCase("2")) && !(retvalue.equalsIgnoreCase("2")))
	{
		session.setAttribute("userNickname",nickName);
		session.setAttribute("userimageUserId",hidUserId);
%>	
		<td><a href="/cims/jsp/admin/FileUpload.jsp">Upload  Photo</a></td>
<%	}
%>

					</tr>
					<tr class="contentDark">
<%	if (hid!=null && hid.equalsIgnoreCase("2")){									
%>					
					<td colspan=4 align=right><input type=button  class="btn btn-warning" name=save value=Update onclick="validateData()">&nbsp;&nbsp;&nbsp;<input type=button  class="btn" name=save value=Delete onclick="deleteUser(<%=hidUserId%>)"></td>
					
<%}else if(hid!=null && hid.equalsIgnoreCase("3")){
%>
					<td colspan=4 align=right><input type=button  class="btn btn-warning"  class="button" name=save value=Save onclick="validateData()"></td>				
<%}else{
%>	
					 <td colspan=4 align=right><input type=button  class="btn btn-warning"  class="button"  class="button" name=save value=Save onclick="validateData()"></td>				
<%}
%>					</tr>
							</table>
					</fieldset>	
    	      	 </td>       
   	       	 </tr>
      	</table>
    	<table align=center  width=95% align="center">
		</table>
		<div id="playerdetail" name="playerdetail">
		</div>
		<input type=hidden name=hidUserRole id=hidUserRole value="<%=userRole%>"/> 
		<input type=hidden name=lastPageNo id=lastPageNo value="<%=lastPageNo%>"/>
</form>
<%
if(userId.equalsIgnoreCase("")){
}else{
%>
<script>
	passUserData('<%=userId%>')
</script>
<%  }
%>	

</body>
<script>
	getTeams();
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
	          		var param		  = 2 ;
	          	  	var nickName  	  = document.getElementById('searchNickName').value;
					var firstName 	  = document.getElementById('searchFirstName').value;
					var middleName	  = document.getElementById('searchMiddleName').value;
					var lastName  	  = document.getElementById('searchLastName').value;
					var displayName	  = document.getElementById('searchDisName').value;	
					var userRole  	  = document.getElementById('hidUserRole').value;	
					var roleId  	  = document.getElementById('selRoleId').value;	
					if (document.getElementById('hidpageid').value == 1){
						var hidpaging = document.getElementById('pagingno').value
					}else{
						var hidpaging = document.getElementById('hidpaging').value;	
					}	
					var url= "/cims/jsp/admin/SearchUser.jsp?nickName="+nickName +  "&firstName="+firstName + "&middleName="+middleName + "&lastName="+lastName + "&userRole="+userRole + "&userRoleId="+roleId + "&displayName="+displayName + "&hidpaging="+hidpaging + "&param="+param;
	                xmlHttp.onreadystatechange=stateChangedLAS1;
	                xmlHttp.open("get",url,false);
	                xmlHttp.send(null);
	                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   document.getElementById('userdetail').innerHTML = "";
	                   document.getElementById('playerdetail').innerHTML = "";
					  // document.getElementById('imageDiv').innerHTML = "";
	                   var mdiv = document.getElementById("searchUser");
	                   mdiv.innerHTML= responseResult;
	                }
	           }
	    	}
			    	
	 	   function stateChangedLAS1(){
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
	          else{ var param = 1;
	          		var userId      = document.getElementById('hiduserId').value;
	          		//alert(userId);
	         	  	var nickName	= document.getElementById('txtNickName').value;
	         	  	var displayName = document.getElementById('txtdisName').value;
	         	  	var hidNick		= document.getElementById('hidNickName').value;
	         	  	var hidDis		= document.getElementById('hidDisName').value;
  				    var hidFlag		= document.getElementById('hidFlag').value;
  				    var hidUpdate   = document.getElementById('hidUpdate').value;
  					
	         	  	if (hidDis == displayName && hidNick == nickName && hidUpdate != "" ){
				 //		alert("displayname and nick name are same");
					    param = 3;
					    var url= "/cims/jsp/admin/SearchUser.jsp?nickName="+nickName +  "&displayName="+displayName + "&param="+param + "&userId="+userId;
					 }else if (hidDis == displayName && hidNick != nickName && hidFlag == "1" && hidUpdate != ""){ 
					// 	alert("displayname same and nick is not same");
					    param = 6;
					    var val="";
					    var url= "/cims/jsp/admin/SearchUser.jsp?nickName="+nickName +  "&displayName="+val + "&param="+param + "&userId="+userId;
					 }else if (hidNick == nickName && hidDis != displayName && hidFlag == "1" && hidUpdate != ""){ 
					 //	alert("nick same and disp not same");
					    param = 5;
					    var val="";
					    var url= "/cims/jsp/admin/SearchUser.jsp?nickName="+val  +  "&displayName="+displayName + "&param="+param + "&userId="+userId;
					 }else{
						var url= "/cims/jsp/admin/SearchUser.jsp?nickName="+nickName +  "&displayName="+displayName + "&param="+param + "&userId="+userId;
					 }
	                xmlHttp.onreadystatechange=stateChangedLAS2;
	                xmlHttp.open("get",url,false);
	                xmlHttp.send(null);
	                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   //alert(responseResult);
	                   document.getElementById('validatenames').innerHTML=responseResult;
	           		}
	           }
	    	}
	    	
	 	   function stateChangedLAS2(){
	            
	  		 }	 
			  		 
		  		 // Validate first name and lastname
			 function doValidateName(flag){
			 	  xmlHttp=GetXmlHttpObject();
		          if (xmlHttp==null){
		              alert ("Browser does not support HTTP Request") ;
		              return;
		          }
		          else{
                        var param= 7 ;
						if (flag==1){
							var firstName = document.getElementById('txtFUserName').value;
							var middleName= document.getElementById('txtMUserName').value;
							var lastName  = document.getElementById('txtLUserName').value;
							var url= "/cims/jsp/admin/SearchUser.jsp?firstName="+firstName + "&middleName="+middleName + "&lastName="+lastName + "&param="+param + "&flag="+flag;
						}else if(flag==2){
							   var displayName = document.getElementById('txtdisName').value;
							   var url= "/cims/jsp/admin/SearchUser.jsp?displayName="+displayName + "&param="+param + "&flag="+flag;
						}else if(flag==3){
							   var nickName	= document.getElementById('txtNickName').value;
							   var url= "/cims/jsp/admin/SearchUser.jsp?nickName="+nickName + "&param="+param + "&flag="+flag;
						}          
						xmlHttp.onreadystatechange=stateChangedLAS3;
						xmlHttp.open("get",url,false);
						xmlHttp.send(null);
						if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
							var responseResult = xmlHttp.responseText ;
						   document.getElementById("duplicateDiv").style.display = '';
								document.getElementById('validatenames').innerHTML = "";
						   document.getElementById('duplicateDiv').innerHTML = responseResult ;
						}
		           }
		    	}
		    	
		 	    function stateChangedLAS3(){
		            
		  		 } 
		  	
			  	function closeDuplicateDiv(){
			  	 		document.getElementById("duplicateDiv").style.display = 'none';	
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
			                xmlHttp.onreadystatechange=stateChangedLAS6;
			                xmlHttp.open("get",url,false);
			                xmlHttp.send(null);
			                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
		            	 		 var responseResult = xmlHttp.responseText ;
		            	    	 document.getElementById('stateDiv').innerHTML = responseResult ;
	        				}
			           }
			  	}
			  	 function stateChangedLAS6(){
			            
		  		 } 
				
			  	function getTeams(){// get teams based on club id
			  		 xmlHttp=GetXmlHttpObject();
			          if (xmlHttp==null){
			              alert ("Browser does not support HTTP Request") ;
			              return;
			          }
			          else{
			          		param = 10;
			          		var clubid = document.getElementById('selClub').value;
			          		var teamid = document.getElementById('hidselectteam').value;
			          		var url= "/cims/jsp/admin/TeamResponse.jsp?clubId="+clubid + "&param="+param+ "&teamid="+teamid;
			                xmlHttp.onreadystatechange=stateChangedLAS7;
			                xmlHttp.open("get",url,false);
			                xmlHttp.send(null);
			                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
		            	 		var responseResult = xmlHttp.responseText ;
		            	    	document.getElementById('teamsDiv').innerHTML = responseResult;
		            	    	
	        				}
			           }
			  	}
			  	  	
			  	function stateChangedLAS7(){
		            
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

				 // display user photo
					
					//uploadUserPhoto ();


				function uploadUserPhoto(){ // get location based on state id
		  		 	 xmlHttp=GetXmlHttpObject();
			          if (xmlHttp==null){
			              alert ("Browser does not support HTTP Request") ;
			              return;
			          }
			          else{
			          		param = 9;
			          		var stateId = document.getElementById('selState').value;
							var id=34125;
							var url= "MyJsp.jsp?imageUserId="+id;
			                xmlHttp.onreadystatechange=stateChangedLAS6;
			                xmlHttp.open("get",url,false);
			                xmlHttp.send(null);
			                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
		            	  		  var responseResult = xmlHttp.responseText ;
		                		 // document.getElementById('uploadPhotoImg').src = responseResult ;
	        				}
			           }
			  	 }

				 function stateChangedLAS6(){
		            
		  		 } 
				 
				 function exportToExcel() 
				 {
					var roleId = document.getElementById('selRoleId').value ;
					if (roleId=='0')
					{
						alert("select role");
						return false;
					}
					document.getElementById("download_reports").src= "/cims/jsp/admin/ExcelReport.jsp?roleId="+roleId;
				}
					
</script>
</html>
