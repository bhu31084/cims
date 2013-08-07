<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				in.co.paramatrix.csms.common.EMailSender,
				in.co.paramatrix.csms.sms.SmsSender,
				java.util.*"
%>
<%
	GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
	Vector 					vparam 					=  	new Vector();
	CachedRowSet  			lobjCachedRowSet		=	null;
	CachedRowSet			crsUserRoleId			=	null;
	CachedRowSet			crsObjcontact			=	null;
	EMailSender				smail					=	null;
	String 					userid					=   null;
	String 					userroleid				=   null;
	String 					contactnum				=	null;
	String					userName				= 	"";
	String 					nickname				=	"";
	String					password				=	"";
	String 					email					=	"";		
	boolean					flag					=	false;
	String 					msg						=	"";
	String 					url 					=	null;
	String 					link                    =   null;
	Hashtable 				urlHash 				= 	new Hashtable();
	
		userName = request.getParameter("userid");//
		vparam.add(userName); // user_id
		lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_email",vparam,"ScoreDB");
		vparam.removeAllElements();
		
		
	if(lobjCachedRowSet!=null){
		while(lobjCachedRowSet.next()){	
			userid = lobjCachedRowSet.getString("id").trim();
			nickname = lobjCachedRowSet.getString("nickname");
			password = lobjCachedRowSet.getString("password");
			email = lobjCachedRowSet.getString("email");
			flag = true;	
		}
	}

	/** try block added to execute sp esp_dsp_getuserroleid to get user role id */
	try{
		vparam.add("34274");
		crsUserRoleId = lobjGenerateProc.GenerateStoreProcedure(
		       	"dbo.esp_dsp_getuserroleid",vparam,"ScoreDB");
		vparam.removeAllElements();
		if(crsUserRoleId != null && crsUserRoleId.size() > 0 ){
			while(crsUserRoleId.next()){
				userroleid = crsUserRoleId.getString("user_role_id");
			}
		}
	}catch(Exception e){
		System.out.println("Exception : "+e);
		e.printStackTrace();
	}
	
	/** try block added to execute sp esp_dsp_get_contact_num to get receiver contact no */
	try{
		vparam.add(userroleid);
		crsObjcontact = lobjGenerateProc.GenerateStoreProcedure(
	       	"esp_dsp_get_contact_num",vparam,"ScoreDB");
	    vparam.removeAllElements();
		if(crsObjcontact != null && crsObjcontact.size() > 0 ){
			while(crsObjcontact.next()){
				contactnum = crsObjcontact.getString("contact");
			}
		}else{
		contactnum = "";
		}
	}catch(Exception e){
		System.out.println("Exception : "+e);
		e.printStackTrace();
	}	
System.out.print("contactnumcontactnum"+contactnum)	;
	if(flag){
		msg = "username : " + nickname + " and   password : " + password;
		 smail.sendMail(email,msg,"Cims Password");
	}	
	String urlflag = null;
	String sendFlag = null;
	if(contactnum != null){
		sendFlag = "true";
		/*SmsSender smssender = new SmsSender();
		url = smssender.buildUrl(contactnum,msg);//retrieved url from java class
		System.out.println("url>>>>>>>"+url);	
		String urlArr[] = url.split("&");
		link = urlArr[0];
		System.out.println("Linkv      ........... "+link);	
		for(int i = 1; i < urlArr.length; i++){
		String keyValue = (java.lang.String)urlArr[i];
		String keyValArr[] = keyValue.split("=");
		urlHash.put(keyValArr[0],keyValArr[1]);
		}
		urlflag = "true";	*/
	}
%>
     
<html>
<head>
<title>Forgot Password  </title>
<script>
function callSendSms(){
	 var url = document.getElementById("hdUrl").value;
	 document.frmSendPassword.method="post"
	 document.frmSendPassword.action=url
	 document.frmSendPassword.submit()
}
function SendSmsToUser(){
	var contact = document.getElementById("hdContact").value
	var message = document.getElementById("hdMessage").value
	document.frmSendPassword.action ="/cims/jsp/sms/SMSSend.jsp"
	document.frmSendPassword.submit();
}
</script>
</head>
<body>
<form name="frmSendPassword" id="frmSendPassword" action=""> 
	   <input type="hidden" name="hdUrl" id="hdUrl" value="<%=link%>">
	   <input type="hidden" name="hdMessage" id="hdMessage" value="<%=msg%>">
	   <input type="hidden" name="hdContact" id="hdContact" value="<%=contactnum%>">
<%	
		Enumeration e = urlHash.keys();
		while(e.hasMoreElements()){
			Object objKey = e.nextElement();
			System.out.println(objKey+"--...---"+urlHash.get(objKey));
%>
			<input type="hidden" name="<%=objKey%>" id="<%=objKey%>" value="<%=urlHash.get(objKey)%>">
<%--			System.out.println(objKey+"--...---"+urlHash.get(objKey));--%>
<%		}
%>
<center>
<%
		if(flag){
%>	
	<p><b><FONT COLOR="RED"><center>Password has been mailed to you!</center></FONT></b></p><br>
<%
		}else{
%>	
	<p><b><FONT COLOR="RED"><center>Email Id Not Found Please Contact Administrator.!</center></FONT></b></p><br>	
<%
		}
%>	
	<p><b><FONT COLOR="RED"><center><a href="/cims/jsp/Login.jsp">click here for login!</a></center></FONT></b></p><br>

</center>
<%		if(sendFlag != null && sendFlag.equalsIgnoreCase("True")){
%>				<script>
					SendSmsToUser();
				</script>
<%			}
%>	
<%		if(urlflag != null && urlflag.equalsIgnoreCase("True")){
%>		<script>
			callSendSms();
		</script>
<%		}
%>
</form>
</body>

</html>
