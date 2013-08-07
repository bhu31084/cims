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
	//retrieved from PrintOfficialsAppointMentLetter.jsp
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
	String replyMessage = null;
	String messageCode = null;
	String messageflag = null;
	String rowId = null;
	String senderId = null;
	String shortuserrole = null;
	String replyMessageFlag ="false";
	String replysignature = null;
	String signature = null;
	String link = null;
	String urlflag = null;
	String sendFlag = null;
	Vector vparam =  new Vector();
	Hashtable urlHash = new Hashtable();
		
	CachedRowSet  crsObjcontact = null;
	CachedRowSet  crsMessage = null;
	CachedRowSet  crsSendMessage = null;
	CachedRowSet  crsUserRoleId = null;
	
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

	
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
		System.out.println("Exception : "+e);
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
				
				if(contactnum.length() == 11){
					if(contactnum.charAt(0) == '0'){
						contactnum = contactnum.substring(1);
					}
				}

				if(contactnum.length() > 11){
					if(contactnum.length() ==  12){
						contactnum = contactnum.substring(2);
					}
				}
			}else{
				contactnum = "";
			}
		}catch(Exception e){
			System.out.println("Exception : "+e);
			e.printStackTrace();
		}	
	}
	
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
		System.out.println("Signature-------->  "+signature);		
	
		//message = "You are appointed as "+userrole+" for "+seriesname+","+team1+" Vs "+team2+" at "+
		//			venue+" on "+ sdfmatchdate2.format(displaymatchdate)+"."+
		//			" Please check and confirm via email / online system, within 24 hours";
		
		message = "Appointed as "+userrole+" for "+seriesname+" at "+
		venue+" on "+ sdfmatchdate2.format(displaymatchdate)+"."+
		" Check and confirm via email/online, within 48 hours";
		
		//message = "You are appointed as "+userrole+" for "+seriesname+","+team1+" Vs "+team2+" at "+
		//			venue+" on "+ sdfmatchdate2.format(displaymatchdate)+",pls confirm asap, type ""BCCI "+
		//			signature+":"+"Y or N"" and send it to 575758";	
		
	}

	
	if(request.getParameter("hdSend")!= null && request.getParameter("hdSend").equalsIgnoreCase("1")){
		contactnum = request.getParameter("To");
		message = request.getParameter("Text");	
		matchId = request.getParameter("hdMatchId");
		receiverId = request.getParameter("hdUserId")==null?"0":request.getParameter("hdUserId");
		signature = request.getParameter("hdSignature");	
		System.out.println(message+"\n"+matchId+"\n"+receiverId+"\n"+senderId+"\n"+sdf.format(currentDateTime)+"\n"+signature+"\n"+contactnum);
		
		/**Code to insert message details in database.*/
		try{
			vparam.add(message);//content
			vparam.add("1");//type
			vparam.add(matchId);//matchid
			vparam.add(receiverId);//receiver
			vparam.add(senderId);//sender
			vparam.add("");//send_ts
			vparam.add(signature);//signature
			vparam.add(contactnum);//replyPhone   
			vparam.add("");//reply text
			vparam.add("");//reply_ts
			vparam.add("P");//state
			vparam.add("");//statechange_ts
			
			
		if(request.getParameter("hdReply")!= null && request.getParameter("hdReply").equalsIgnoreCase("1")){//if click Yes
			vparam.add("1");//flag
			vparam.add("1");//1:Yes message exists still send again
		}else{//at starting
			vparam.add("1");//flag
			vparam.add("2");//default value  2 for message exists
		}
			System.out.println("exec esp_amd_send_receive_messages"+ vparam);			
			crsMessage = lobjGenerateProc.GenerateStoreProcedure(
	       	"esp_amd_send_receive_messages",vparam,"ScoreDB");
	   		vparam.removeAllElements();	
			System.out.println("********************************************************************aftr sp fired");
	   		if(crsMessage != null && crsMessage.size() > 0){
	   			while(crsMessage.next()){
	   				replyMessage = crsMessage.getString("retval");
	   				replysignature = crsMessage.getString("signature");
	   				if(replyMessage.trim().equalsIgnoreCase("Message Exists")){
	   					replyMessageFlag = "true";
	   				}
	   			}
	   		}		 
			System.out.println("**********************replyMessage*********************************"+replyMessage);			
		}catch(Exception e){
			System.out.println("Exception : "+e);
			e.printStackTrace();
		}	
		
		
		
		/**Code to send SMS*/
		if(replyMessage.trim().equalsIgnoreCase("Message Inserted") || replyMessage.trim().equalsIgnoreCase("Message Replaced")){
			sendFlag = "true";
		}				
		
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
		document.frmSmsPush.submit()
	}

	function loadXMLString(txt) 
	{
		try{ //Internet Explorer
			if (window.ActiveXObject){  
				xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
				xmlDoc.async="false";
				xmlDoc.loadXML(txt);
			}else{
				xmlDoc = document.implementation.createDocument("","",null);
			}

			  return(xmlDoc); 
		}catch(e){
			  try{//Firefox, Mozilla, Opera, etc.
				    parser=new DOMParser();
			    	xmlDoc=parser.parseFromString(txt,"text/xml");
				    return(xmlDoc);
			    }
			  catch(e) {alert(e.message)}
		  }
		return(null);
	}
	
	function contactValidate(){
    	alert("Please update contact number using user master form.")
    	window.opener="";
		window.close();
    	return false
    }
    
    function callReply(reply){
	   	document.getElementById("hdSend").value = "1"
		document.getElementById('hdReply').value = reply
		document.frmSmsPush.submit()
    }
    
	function SendSmsToUser(){
		var contact = document.getElementById("To").value
		var message = document.getElementById("Text").value
		var signature = document.getElementById("hdSignature").value
		window.open("/cims/jsp/sms/SMSSend.jsp?hdMessage="+message+"&hdContact="+contact+"&hdSignature="+signature+"&hdFlag=1","CIMSSMSSEND","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=310,left=385,width=1,height=110");
	}
	
	function cancel(){
		self.close()
	}
    
  </script>
  <title>Send SMS</title> 
  </head> 
  <body> 
<%	if(contactnum == ""){
%>		<script>
  		contactValidate()
  		</script>
<%	}
%>
		<form name="frmSmsPush" id="frmSmsPush" action="" method="post"> 
			<div id = "divMain" name="divMain" >
				<table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" class="table"> 
					<tr align="center">
						<td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">Send SMS</td>
				    </tr>
				    
<%		if(replyMessageFlag.equalsIgnoreCase("true")){
%>
					<tr>
						<td colspan="2" >
						<table width="100%">
							<tr>
								<td width="100%" align="center" class="message">Message already sent to this official<br>Do you want to resend the message?
									<input type="button" class="button1" name="btnYes" id="btnYes" value="Yes" onclick=callReply(1) />
								</td>
							</tr>
						</table>
						</td>
					</tr>	

<%		}
%>					    	
				   	<tr class="contentDark"> 
			   			<td ><font size="2">&nbsp;&nbsp;<b> Mobiles Number :<br>&nbsp;&nbsp;</b></font></td>
<%		if(request.getParameter("hdContact") == null){
%>				   		<td ><textarea readonly name="To" id="To" class="textAreaContact" rows="4" cols="100" maxlength = "100" onKeyPress="return keyRestrict(event,',1234567890')"><%=contactnum.equalsIgnoreCase("null")? "" : contactnum%></textarea></td>
<%		}else{
%>						<td ><textarea readonly name="To" id="To" class="textAreaContact" rows="4" cols="100" maxlength = "100" onKeyPress="return keyRestrict(event,',1234567890')"><%=request.getParameter("hdContact")%></textarea></td>
<%		}
%>				   	</tr> 
				   	<tr class="contentLight">
				   		<td><font size="2">&nbsp;&nbsp;<b> Message :</b></font></td>
<%		if(request.getParameter("hdMessage") == null){
%>				   		<td><textarea readonly name="Text" id="Text" value="Hello" class="textAreaMessage" rows="6" cols="100" maxlength ="140"><%=message%></textarea></td>
<%		}else{
%>				   		<td><textarea readonly name="Text" id="Text" value="Hello" class="textAreaMessage" rows="6" cols="100" maxlength ="140"><%=request.getParameter("hdMessage")%></textarea></td>
<%		}
%>				   	</tr>
<%		if(!(replyMessageFlag.equalsIgnoreCase("true"))){
%>					<tr class="contentDark">
						<td colspan="2" align="center"><input class="button1" type="button" name="Ok" value="Send" onclick="sendSms()">
						<input class="button1" type="button" name="Ok" value="Cancel" onclick="cancel()"> </td>
				    </tr> 
<%		}else{
%>					<td colspan="2" align="center"><input class="button1" type="button" name="Ok" value="Cancel" onclick="cancel()"></td>
<%		}
%>				    
				</table> 
			</div>
		<input type="hidden" name="hdSend" id="hdSend" value="">
		<input type="hidden" name="hdUserId" id="hdUserId" value="<%=receiverId%>">
		<input type="hidden" name="hdMatchId" id="hdMatchId" value="<%=matchId%>">
		<input type="hidden" name="hdSignature" id="hdSignature" value="<%=signature%>">
		<input type="hidden" name="hdContact" id="hdContact" value="<%=contactnum%>"> 
		<input type="hidden" name="hdMessage" id="hdMessage" value="<%=message%>">
		<input type="hidden" name="hdReply" id="hdReply" value="">	
		<input type="hidden" name="hdFlag" id="hdFlag" value="1">
				
<%		if(sendFlag != null && sendFlag.equalsIgnoreCase("True")){
%>				<script>
					SendSmsToUser();
				</script>
<%			}
%>	
		</form> 
	</body> 
</html>
    