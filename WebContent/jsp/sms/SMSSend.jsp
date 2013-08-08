<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.common.RandomGenerator"%>
<%@ page import="in.co.paramatrix.csms.sms.*"%>
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
	String urlflag = null;
	String url = null;
	String link = null;
	String responseMessage = "";
	Hashtable urlHash = new Hashtable();
	String message = request.getParameter("hdMessage")==null?"":request.getParameter("hdMessage");
	String contactNumber = request.getParameter("hdContact")==null?"":request.getParameter("hdContact");
	String signature = request.getParameter("hdSignature")==null?"":request.getParameter("hdSignature");
	String flag = request.getParameter("hdFlag")==null?"":request.getParameter("hdFlag");//flag = 1 :from SMSPush 2 :from MultipleSMSPush
	
	Date currentDateTime = new Date();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
	if(message != null && contactNumber != null){
	
		SmsSender smssender = new SmsSender();
		url = smssender.buildUrl(contactNumber,message);//retrieved url from java class

		if(flag.equalsIgnoreCase("1")){//sms push
			SmsScheduler smsscheduler = (SmsScheduler)config.getServletContext().getAttribute("smsService");	
			smsscheduler.sendFirstSMS();//send through thread only.
			responseMessage ="Message Sent";
			smsscheduler=null;
		}else if(flag.equalsIgnoreCase("2")){//multiple sms
			SmsScheduler smsscheduler = new SmsScheduler();
			responseMessage = smsscheduler.sendSMS(url,signature,flag);
			smsscheduler=null;
		}
		
		urlflag = "true";
	}

%>
<html>
	<head>
		<title>SMS SENDING</title>
		<script>
			function callSendSms(){
				var responseToMsg = document.getElementById('hdResponseToMsg').value
				if(responseToMsg.indexOf("ERROR") != -1){
					
					if(responseToMsg.indexOf("DESC") != -1){
					var endDesc = responseToMsg.indexOf("</DESC>") 
						var errMessage = responseToMsg.substring((responseToMsg.indexOf("DESC") + 5),endDesc)
						alert(errMessage +".\n Your message is not sent.")
						self.close()
					}else{
						var errMessage = responseToMsg
						alert(errMessage +".\n Your message is not sent.")
						self.close()
					}
				}else{
					alert("Message sent!!!")
					self.close()
				}
			}
		</script>
	</head>
	<body>
		<form id="frmSmsSend" name="frmSmsSend" method="post">
		<input type="hidden" name="hdUrl" id="hdUrl" value="<%=link%>">
		<input type="hidden" name="hdResponseToMsg" id="hdResponseToMsg" value="<%=responseMessage%>">
		
<%		if(urlflag != null && urlflag.equalsIgnoreCase("True")){
				
%>				<script>
					callSendSms();
				</script>
<%			}
%>
		</form>
	</body>
</html>