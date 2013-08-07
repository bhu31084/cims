<!--
	Page Name 	 : SMSPush.jsp
	Created By 	 : Dipti Shinde.
	Created Date : 10th Mar 2009.
	Description  : To send sms and save date and time in database.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.common.RandomGenerator"%>
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
	String userRoleId = (String)session.getAttribute("userId").toString();//userId
	String flag = request.getParameter("flag")==null?"0":request.getParameter("flag");
	String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
	String receiverId = request.getParameter("receiverId")==null?"0":request.getParameter("receiverId");
	String seriesname = request.getParameter("seriesname")==null?"0":request.getParameter("seriesname");
	String matchdate = request.getParameter("matchdate")==null?"0":request.getParameter("matchdate");
	String team1 = request.getParameter("team1")==null?"0":request.getParameter("team1");
	String team2 = request.getParameter("team2")==null?"0":request.getParameter("team2");
	String venue = request.getParameter("venue")==null?"0":request.getParameter("venue");
	String userrole = request.getParameter("userrole")==null?"":request.getParameter("userrole");

	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.text.SimpleDateFormat sdfmatchdate1 = new java.text.SimpleDateFormat("MMM dd yyyy");
	java.text.SimpleDateFormat sdfmatchdate2 = new java.text.SimpleDateFormat("dd/MM/yyyy");	
	java.util.Date displaymatchdate = null;

	if(matchdate != "0"){
		 displaymatchdate = sdfmatchdate1.parse(matchdate);
	}
	
	Date currentDateTime = new Date();
 	
	String url = null;
	String contactnum = null;
	String message = null;
	String messageCode = null;
	String messageflag = null;
	String rowId = null;
	String senderId = null;
	String shortuserrole = null;
	String signature = null;
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	CachedRowSet  crsObjcontact = null;
	CachedRowSet  crsMessage = null;
	CachedRowSet  crsSendMessage = null;
	CachedRowSet  crsUserRoleId = null;

	
	
	/** try block added to execute sp esp_dsp_getuserroleid to get user role id */
	try{
		vparam.add(userRoleId);
		crsUserRoleId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getuserroleid",vparam,"ScoreDB");
		vparam.removeAllElements();
		
		if(crsUserRoleId != null && crsUserRoleId.size() > 0 ){
			while(crsUserRoleId.next()){
				senderId = crsUserRoleId.getString("user_role_id");
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	

	/** try block added to execute sp esp_dsp_get_contact_num to get receiver contact no */
	if(flag.equalsIgnoreCase("1")){
		try{
			vparam.add(receiverId);
			
			crsObjcontact = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_get_contact_num",vparam,"ScoreDB");
		    vparam.removeAllElements();
			if(crsObjcontact != null && crsObjcontact.size() > 0 ){
				while(crsObjcontact.next()){
					contactnum = crsObjcontact.getString("contact");
				}
			}else{
			contactnum = "";
			}
		}catch(Exception e){
			e.printStackTrace();
		}	
	}//end if flag1
	
	if(contactnum != null){
		if(userrole.equalsIgnoreCase("umpire1")){
			shortuserrole = "U1";
		}else if(userrole.equalsIgnoreCase("umpire2")){
			shortuserrole = "U2";
		}else if(userrole.equalsIgnoreCase("referee")){
			shortuserrole = "RF";
		}else if(userrole.equalsIgnoreCase("umpirecoach")){
			shortuserrole = "UC";
		}
		
		/** random string generator gives random string value as signature. */		
		signature = RandomGenerator.getRandomString(7, 7);
	
		//message = "You are appointed as "+userrole+" for "+seriesname+","+team1+" Vs "+team2+" at "+
		//			venue+" on "+ sdfmatchdate2.format(displaymatchdate)+"."+
		//			" Please check and confirm via email / online system, within 24 hours";
		message = "Appointed as "+userrole+" for "+seriesname+" at "+
				   venue+" on "+ sdfmatchdate2.format(displaymatchdate)+"."+
					" Check and confirm via email/online, within 48 hours";
		//shortuserrole+"-"+matchId+":"+signature+":"+"Y or N'' and send it to 575758";		
	}

	String urlflag = null;
	if(request.getParameter("hdSend")!= null && request.getParameter("hdSend").equalsIgnoreCase("1")){
		
		String contactNumber = request.getParameter("To");
		message = request.getParameter("Text");	
		matchId = request.getParameter("hdMatchId");
		receiverId = request.getParameter("hdUserId")==null?"0":request.getParameter("hdUserId");
		signature = request.getParameter("hdSignature");	
		/**Code to insert message details in database.*/
		try{
			vparam.add(message);//content
			vparam.add("1");//type
			vparam.add(matchId);//matchid
			vparam.add(receiverId);//receiver
			vparam.add(senderId);//sender
			vparam.add(sdf.format(currentDateTime));//send_ts
			vparam.add(signature);//signature
			vparam.add(contactNumber);//replyPhone
			vparam.add("");//reply text
			vparam.add("");//reply_ts
			//vparam.add("");//Processed
			//vparam.add("");//state
			vparam.add("");//statechange_ts
			vparam.add("1");//flag
			
			crsMessage = lobjGenerateProc.GenerateStoreProcedure("esp_amd_send_receive_messages",vparam,"ScoreDB");
	   		vparam.removeAllElements();			
			
		}catch(Exception e){
			e.printStackTrace();
		}	
	
	/**Code to send SMS*/
		//String contactNumber = request.getParameter("To");
		//message = request.getParameter("Text");
		//receiverId = request.getParameter("hdUserId")==null?"0":request.getParameter("hdUserId");
				
		SmsSender smssender = new SmsSender();
		url = smssender.buildUrl(contactNumber,message);//retrieved url from java class
		urlflag = "true";
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
	function GetXmlHttpObject() {
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
		if(mobileNo == ""){
				alert("Please enter contact number.")
				document.getElementById("To").focus()
				return false
		}
		document.getElementById("hdSend").value = "1"
		//document.getElementById("divLoad").style.display =''
		//document.getElementById("divMain").style.display ='none'
	
		document.frmSmsPush.submit()
	}
	
	function callSendSms(){

		try {
	           xmlHttp = this.GetXmlHttpObject();
	     	  if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	          }else{
			      var url = document.getElementById("hdUrl").value;
			      xmlHttp.onreadystatechange = receiveSMSProcess
	          	  xmlHttp.open("post", url, false);
			   	  xmlHttp.send(null);
			   	  window.opener="";
				  window.close();
	   		  }
	   	} catch(err) {
           	alert(err.description + 'callSendSms()');
        }
       
        
	}
	
	function loadXMLString(txt) 
	{
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
		  }
		catch(e)
		  {
			  alert(e.message);
		  }
		return(null);
	}
	
	function receiveSMSProcess(){
    	if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
       		try {
            	var responseResult = xmlHttp.responseText;            	
             //alert(responseResult)
         	 //document.getElementById("divLoad").style.display ='none'
       		 //document.getElementById("divMain").style.display =''
	            	try
	    	        	{
						xmlDoc = loadXMLString(responseResult);
						//alert(xmlDoc);
						
						if(responseResult.indexOf("CODE") > -1)
							{
								alert(xmlDoc.getElementsByTagName("DESC")[0].childNodes[0].nodeValue);
							}
						else 
							{
								alert("Message Sent!!!")
							}
							
					}
					catch(e)
					{
						alert("Error in display msg"+e);
					}	
										
  
            } catch(err) {
	            alert(err.description + 'receiveSMSProcess()');
       		}
        }
    }
    
    function contactValidate(){
    	alert("Please update contact number using user master form.")
    	window.opener="";
		window.close();
    	return false
    }
  </script>
  <title>Send SMS</title> 
  </head> 
  <body> 
<%	if(contactnum == ""){
%>	
  		<script>
  		contactValidate()
  		</script>
<%	}
%>
		<form name="frmSmsPush" id="frmSmsPush" action=""> 
<%			if(urlflag == null){
%>		
			<div id = "divMain" name="divMain" >
				<table width="99%" border="0" align="center" cellpadding="2"
							cellspacing="1" class="table"> 
					<tr align="center">
						<td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">Send SMS</td>
				    </tr>	
				   	<tr class="contentDark"> 
				   		<td ><font size="2">&nbsp;&nbsp;<b> Mobiles Number :<br>&nbsp;&nbsp;</b></font></td>
				   		<td ><textarea readonly name="To" id="To" class="textAreaContact" rows="4" cols="100" maxlength = "100" onKeyPress="return keyRestrict(event,',1234567890')"><%=contactnum.equalsIgnoreCase("null")? "" : contactnum%></textarea>
				   		</td>
				   	</tr> 
				   	<tr class="contentLight">
				   		<td><font size="2">&nbsp;&nbsp;<b> Message :</b></font></td>
				   		<td>
				   			<textarea readonly name="Text" id="Text" value="Hello" class="textAreaMessage" rows="6" cols="100" maxlength ="140"><%=message%></textarea>
				   		</td>
				   	</tr>
					<tr class="contentDark">
						<td colspan="2" align="center"><input class="button1" type="button" name="Ok" value="Send" onclick="sendSms()"> </td>
				    </tr> 
				</table> 
			</div>
<%			}//end if(urlflag == null)
%>			<input type="hidden" name="hdSend" id="hdSend" value="">
			<input type="hidden" name="hdUrl" id="hdUrl" value="<%=url%>">
			<input type="hidden" name="hdUserId" id="hdUserId" value="<%=receiverId%>">
			<input type="hidden" name="hdMatchId" id="hdMatchId" value="<%=matchId%>">
			<input type="hidden" name="hdSignature" id="hdSignature" value="<%=signature%>">			
			<div id = "divLoad" name="divLoad" align="center" style="display:none">
			    <img src="../../Image/icon-loading-animated.gif"  width="50" height="50" />
           		<br><br><font size="5">Sending SMS...</font>
			</div>
<%			if(urlflag != null && urlflag.equalsIgnoreCase("True")){
%>				<script>
					callSendSms();
				</script>
<%			}
%>		</form> 
	</body> 
</html>
    