<!--
	Page Name 	 : SMSPush.jsp
	Created By 	 : Dipti Shinde.
	Created Date : 10th Mar 2009.
	Description  : To send sms to multiple officials.
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
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 	Date currentDateTime = new Date();
 	
	String url = null;
	String contactnum = null;
	String message = "";
	String contactNumber = "";
	String messageCode = null;
	String messageflag = null;
	String rowId = null;
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	CachedRowSet  crsObjcontact = null;
	CachedRowSet  crsGetRole = null;
	CachedRowSet  crsMessage = null;
	CachedRowSet  crsSendMessage = null;
	Hashtable urlHash = new Hashtable();
	String Link = null;
	String sendFlag = null;
		
	String urlflag = null;
	if(request.getParameter("hdSend")!= null && request.getParameter("hdSend").equalsIgnoreCase("1")){
		contactNumber = request.getParameter("To");//Retrieve commaSeparated Cont Nos
		message = request.getParameter("Text");
		sendFlag = "true";
		
	}
%>
<html> 
 <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <link href="../../css/form.css" rel="stylesheet" type="text/css" />
  <link href="../../css/formtest.css" rel="stylesheet" type="text/css" />
  <link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
  <script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js"></script>

  <script>
  
    var contactNumbers = ""
	function GetXmlHttpObject(){
        var xmlHttp = null;
        try{
            // Firefox, Opera 8.0+, Safari
            xmlHttp = new XMLHttpRequest();
        }
        catch (e){
            // Internet Explorer
            try{
                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e){
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        return xmlHttp;
    }

	function sendSms(){
	
		var mobileNo = document.getElementById("To").innerHTML
		var message = document.getElementById("Text").innerHTML
		
		document.getElementById("hdMessage").value = message
		document.getElementById("hdContact").value = mobileNo
		document.getElementById("hdSend").value = "1"
	
		document.frmSmsMultiPush.submit()
	}
	
	function callSendSms(){
		// var url = document.getElementById("hdUrl").value;
		 document.frmSmsMultiPush.action="http://bulkpush.mytoday.com/BulkSms/SingleMsgApi";
		 document.frmSmsMultiPush.submit()
	}
	
	function loadXMLString(txt){
		try //Internet Explorer
		  {
			  if (window.ActiveXObject){  
					xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
					xmlDoc.async="false";
					xmlDoc.loadXML(txt);
				}else{
					xmlDoc = document.implementation.createDocument("","",null);
				}
			  return(xmlDoc); 
		  }catch(e){
			  alert(e.message);
		  }
		  return(null);
	}
	
        
    function doGetUserData(){
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request") ;
			return;
		}else{
			var roleId = document.getElementById('selRoleId').value;	
			var userName = document.getElementById('txtName').value;
			var url= "/cims/jsp/sms/MultipleUsers.jsp?userRoleId="+roleId+"&userName="+userName;
			//xmlHttp.onreadystatechange=receiveUsers;
			xmlHttp.open("get",url,false);
			xmlHttp.send(null);
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	          var responseResult= xmlHttp.responseText ;
	          document.getElementById('searchUserDiv').innerHTML =  responseResult
	        }
		}
	}
			    	
	function userSearch(){
		var roleId = document.getElementById('selRoleId').value
		if(roleId == 0){
			alert("Please select role.")
			return false
		}
	 	doGetUserData()
	}

	function getAllContactNum(){
      var contactNumArr = document.forms[0].chkUser 
	  for (i=0;i<contactNumArr.length;i++){
	  	if(contactNumArr[i].checked){
	  		contactNumArr[i].checked = false
	  	}else{
	  		contactNumArr[i].checked = true
	  	}
	  }
	}
	
	function getContactNum(){
		document.getElementById("To").innerHTML = ""
		var contactNum = ""
		var contactNumArr = document.forms[0].chkUser 
		for (i=0;i<contactNumArr.length;i++){
			if (contactNumArr[i].checked){
				if(contactNumArr[i].value != "-"){
				  contactNum = contactNum + contactNumArr[i].value + ",";
			    }
			}
		}
		contactNumbers = contactNumbers + contactNum
		document.getElementById("To").value = contactNum
	}
	
	function SendSmsToUser(contactnum,message){
		document.getElementById("hdMessage").value = message
		document.getElementById("hdContact").value = contactnum
		if(contactnum == ""){
			alert("Please enter contact number.")
			document.getElementById("To").focus()
			return false
		}	
		window.open("/cims/jsp/sms/SMSSend.jsp?hdMessage="+message+"&hdContact="+contactnum+"&hdFlag=2","CIMSSMSSEND","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=310,left=385,width=1,height=110");
	}
	
  </script>
  <title>Send SMS to multiple users.</title> 
  </head> 
  <body> 
	<form name="frmSmsMultiPush" id="frmSmsMultiPush" method="post"> 
		<div id = "divMain" name="divMain" >	
		  <table width="99%" border="0" align="center" cellpadding="2"  cellspacing="1" class="table"> 
		     <tr align="center">
			  <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">Send SMS to multiple users</td>
			 </tr>
			 <tr class="contentDark">
		    	<td>&nbsp;&nbsp;&nbsp;&nbsp;Role :
		    	 <select name="selRoleId" id="selRoleId">
	  				<option value="0">--select--</option>
<%	try{	
		vparam.add("1");
        crsGetRole = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roles",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsGetRole != null){	
			while(crsGetRole.next()){	
%>				   <option value="<%=crsGetRole.getString("id")%>" ><%=crsGetRole.getString("name")%></option>
<%			}
		 }
	   }catch(Exception e){
		e.printStackTrace();
	   }
%>		  				
	  			  </select>&nbsp;&nbsp;
	  			  Enter Name : <input type="text" id="txtName" name="txtName" value=""/>
	  			  <input type="button" class="button1" value="Search" onclick="userSearch()"/>
	  			</td>
	  		 </tr>
	  		<tr>
	  			<td valign="top"></td>
	 		</tr>
	 	</table>
		<br>
	 	<table border="0">
	 	  <tr valign="top">
	 		<td>
	 			<div id="searchUserDiv" name="searchUserDiv">
				</div>
	 		</td>
	 	   </tr>
	 	</table> 
		<br>	 	 		
	  	<table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		  <tr class="contentDark"> 
			<td>&nbsp;&nbsp; Mobiles Number :<br>&nbsp;&nbsp;(Comma separated)</td>
	   		<td ><textarea name="To" id="To" class="textAreaMessage" rows="4" cols="100"  onKeyPress="return keyRestrict(event,',1234567890')"><%=contactNumber%></textarea>
	   			 <input type="hidden" name="hdContact" id="hdContact" value="<%=contactNumber%>">
	   			  
	   		</td>
	   	  </tr> 
		  <tr class="contentLight">
			 <td>&nbsp;&nbsp;<b> Message :</td>
			 <td>
				<textarea name="Text" id="Text" class="textAreaMessage" rows="6" cols="100" maxlength ="140"><%=message%></textarea>
				<input type="hidden" name="hdMessage" id="hdMessage" value="<%=message%>">
			  </td>
		   </tr>  	
<%		   //  }
%>         <tr class="contentDark">
			 <td colspan="2" align="center"><input class="button1" type="button" name="Ok" value="Send" onclick="sendSms()"> </td>
		   </tr> 
		 </table> 
	   </div>
	   <input type="hidden" name="hdSend" id="hdSend" value="">
	   <input type="hidden" name="hdFlag" id="hdFlag" value="2">
	  
      
	   <div id = "divLoad" name="divLoad" align="center" style="display:none">
		  <img src="../../Image/icon-loading-animated.gif"  width="50" height="50" />
        <br><br><font size="5">Sending SMS...</font>
	    </div>
<%		if(sendFlag != null && sendFlag.equalsIgnoreCase("True")){
		contactNumber = request.getParameter("To");//Retrieve commaSeparated Cont Nos
		message = request.getParameter("Text");
		
%>				<script>
					SendSmsToUser('<%=contactNumber%>','<%=message%>');
				</script>
<%		}
%>		    
	  </form> 

	</body> 
</html>
    