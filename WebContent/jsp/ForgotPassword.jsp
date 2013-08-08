<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"
%>
<%  String str=request.getParameter("userid");
					out.println("userid		" +str);
					
				%>
<head>
	<title></title>

		<SCRIPT LANGUAGE=javascript>
				
				function validateForm(){
					//alert("validateForm");
					if(forgotPass.usertype.selectedIndex == 0 ){
					alert("Please Select question!");
					forgotPass.usertype.focus();
					return false;
				}
				if(forgotPass.answer.value.length==0){
					alert("Please enter answer!");
					forgotPass.answer.focus();
					return false;
				}
					document.forgotPass.action ="/cims/jsp/Mail.jsp";
					document.forgotPass.submit();
				}
				
				
		</SCRIPT>
</head>

		<body>
				 <center>
				 	 <form  method="post" name="forgotPass">
					 	<table width="50%" border="1" class="signup"  align="center">
					<tr> 
						<td colspan="2" align="center">
							   <font size="4" color="#6600">Please Enter the Following Details</font><br>
					   </td>
				   </tr>
				 <tr>
					 		<td align="right">
					 			<b><font color="red">Secret Question.</font><b>
					 		</td>
					 		<td align="left">
					 			<select name="usertype" id="usertype">
									<option>---------------select question---------------</option>
									<option value="pet">what is your pet name?</option>
									<option value="movie">what is your favourite movie?</option>
								</select>
						</td>	
					 </tr>
					  <tr>
						  <td align="right"><b><font color="red">Answer</font><b></td>
						  <td align="left">
							 <INPUT type="text" name="answer" id="answer" size="30" maxlength="120"/>
							 <INPUT type="hidden" name="userid" id="userid" value="<%=str%>" />
 							 </td>
					 </tr>
					 
					 <tr><td colspan="2">&nbsp;</td></tr>
					   <tr>
						  <td align="center" colspan="2">
							  <INPUT type="button" value="Submit" onclick="return validateForm()"></INPUT>
												
						  </td>
					 </tr>
					 </table>
				</form>
		</body>



