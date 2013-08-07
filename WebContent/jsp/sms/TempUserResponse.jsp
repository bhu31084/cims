<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<html>
  <head>
    <script>
	function  sendResponse(){
		document.frmSendResponse.action = "../sms/SMSResponse.jsp"
		document.frmSendResponse.submit()
	}
    </script>
   
  </head>
  <body>
   <form id="frmSendResponse" name="frmSendResponse" action="">
    <table>
    	<tr>
    		<td>MSISDN : </td>
    		<td>
    		<Input type="text" id="MSISDN" name="MSISDN" value="9869232323"/>
    		</td>
    	</tr>
		<tr>
			<td>Msg(shortCode) : </td>
    		<td><Input type="text" id="Msg" name="Msg" value="rh bcci"/>
    		</td>
		</tr>
    	<tr>
    		<td>Key1 : </td>
    		<td><Input type="text" id="Key1" name="Key1" value="rh"/>
    		</td>
    	</tr>
    	<tr>
    		<td>Key2 : </td>
    		<td><Input type="text" id="Key2" name="Key2" value="bcci"/>
    		</td>
    	</tr>
    	<tr>
    		<td>RestMsg : </td>
    		<td><Input type="text" id="RestMsg" name="RestMsg" value="rh BCCI signature:Y"/>
    		</td>
    	</tr>
    	<tr>
    		<td><input type="button" value="Send Response" onclick="sendResponse()"></td>
    	</tr>
    </table>
	</FORM>
  </body>
</html>
