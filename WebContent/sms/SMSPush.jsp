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
%>
<%
	String url = null;
	String flag =  request.getParameter("flag")==null?"0":request.getParameter("flag");
	String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
	String userId = request.getParameter("userId")==null?"0":request.getParameter("userId");
	String seriesname = request.getParameter("seriesname")==null?"0":request.getParameter("seriesname");
	String matchdate = request.getParameter("matchdate")==null?"0":request.getParameter("matchdate");
	String team1 = request.getParameter("team1")==null?"0":request.getParameter("team1");
	String team2 = request.getParameter("team2")==null?"0":request.getParameter("team2");
	String venue = request.getParameter("venue")==null?"0":request.getParameter("venue");
	String contactnum = null;
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	CachedRowSet  crsObjcontact = null;
	
	try{
		vparam.add(userId);
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
	
	String urlflag = null;
	if(request.getParameter("hdSend")!= null && request.getParameter("hdSend").equalsIgnoreCase("1")){
		String contactNumber = request.getParameter("To");
		String message = request.getParameter("Text");
		SmsSender smssender = new SmsSender();
System.out.println("contactNumber=====================>"+contactNumber);
System.out.println("message=====================>"+message);		
		url = smssender.buildUrl(contactNumber,message);//retrieved url from java class
System.out.println("url=====================>"+url);		
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
		document.getElementById("divLoad").style.display =''
		document.getElementById("divMain").style.display ='none'
	}
	
	function callSendSms(){
		
	alert("------"+document.getElementById("hdUrl").value)
		try {
	           xmlHttp = this.GetXmlHttpObject();
	     	  if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	          }else{
alert("1")	 				 	 
			      var url = document.getElementById("hdUrl").value;
alert("2")	 				 	 			      
	              xmlHttp.onreadystatechange = receiveSMSProcess
alert("3")	 				 	 			      	              
	          	  xmlHttp.open("post", url, false);
alert("4")	 				 	 			      	          	  
			   	  xmlHttp.send(null);
	   		  }
	   	} catch(err) {
           	alert(err.description + 'callSendSms()');
        }
        document.getElementById("divLoad").style.display ='none'
        document.getElementById("divMain").style.display =''
	}
	
	function receiveSMSProcess(){
alert("in receive")	 				 	 			      	
    	if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
       		try {
            	var responseResult = xmlHttp.responseText ;
alert("in receive2")	 				 	 			      	            	
            	alert(responseResult)
            	if (responseResult.indexOf("ERROR") > -1){
            		alert("Message not sent due to some error.")
            	}else{
            		alert("Message Sent!!!")
            	}
            } catch(err) {
	            alert(err.description + 'receiveSMSProcess()');
       		}
        }
    }
  </script>
  <title>Send SMS</title> 
  </head> 
  <body> 
		<form name="frmSmsPush" id="frmSmsPush" action=""> 
			<div id = "divMain" name="divMain" >
				<table width="99%" border="0" align="center" cellpadding="2"
							cellspacing="1" class="table"> 
					<tr align="center">
						<td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">Send SMS</td>
				    </tr>	
<%
						if(flag.equalsIgnoreCase("1")){
%> 	
				   	<tr class="contentDark"> 
				   		<td ><font size="2">&nbsp;&nbsp;<b> Mobiles Number :<br>&nbsp;&nbsp;(Comma separated)</b></font></td>
				   		<td ><textarea name="To" id="To" class="textAreaContact" rows="4" cols="100" maxlength = "100" onKeyPress="return keyRestrict(event,',1234567890')"><%=contactnum.equalsIgnoreCase("null")? "" : contactnum%></textarea>
				
				   		</td>
				   	</tr> 
				   	<tr class="contentLight">
				   		<td><font size="2">&nbsp;&nbsp;<b> Message :</b></font></td>
				   		<td>
				   			<textarea name="Text" id="Text" value="Hello" class="textAreaContact" rows="6" cols="100" maxlength ="140">Appointed for match <%=team1%> Vs <%=team2%> on <%=matchdate%> at <%=venue%> Please Reply YES To 575758</textarea>
				   		</td>
				   	</tr>
<%
						}else{
%>		  
					<tr class="contentDark"> 
				   		<td><font size="2">&nbsp;&nbsp;<b> Mobiles Number :<br>&nbsp;&nbsp;(Comma separated)</b></font></td>
				   		<td ><textarea name="To" id="To" class="textAreaContact" rows="4" cols="100" maxlength = "100" onKeyPress="return keyRestrict(event,',1234567890')">9819878396</textarea>
				
				   		</td>
				   	</tr> 
				   	<tr class="contentLight">
				   		<td><font size="2">&nbsp;&nbsp;<b> Message :</b></font></td>
				   		<td>
				   			<textarea name="Text" id="Text" value="Hello" class="textAreaContact" rows="6" cols="100" maxlength ="140">test</textarea>
				   		</td>
				   	</tr>  	
				
<%					}
%>
					<tr class="contentDark">
						<td colspan="2" align="center"><input class="button1" type="submit" name="Ok" value="Send" onclick="sendSms()"> </td>
						<input type="hidden" name="hdSend" id="hdSend" value="">
						<input type="hidden" name="hdUrl" id="hdUrl" value="<%=url%>">
				    </tr> 
				</table> 
			</div>
			<div id = "divLoad" name="divLoad" style="display:none">
				<table width="99%" align="center">
					<br>
					<br>
					<br>
					<tr>
						<td align="center"><font color="red"><b>Sending SMS ...!</b></font></td>
					</tr>
				</table>
			</div>
<%			if(urlflag != null && urlflag.equalsIgnoreCase("True")){
%>				<script>
					callSendSms();
				</script>
<%			}
%>		</form> 
	</body> 
</html>
    