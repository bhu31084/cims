	function SendSmsToUser(contactnum,message){
		document.getElementById("hdMessage").value = message
		document.getElementById("hdContact").value = contactnum
//		window.open("../../jsp/sms/SMSSend.jsp?hdMessage="+message+"&hdContact="+contactnum+"&hdFlag=2","CIMSSMSSEND","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=100,left=100,width=880,height=500");
		window.open("../../jsp/sms/SMSSend.jsp?hdMessage="+message+"&hdContact="+contactnum+"&hdFlag=2","CIMSSMSSEND","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=310,left=385,width=1,height=110");
		
		//document.frmmobile.action ="../../jsp/sms/SMSSend.jsp"
		//document.frmmobile.submit();
	}
	
	function validate(){
		var contactnum = document.getElementById('phonenumber').value
		var message = "Access cricket on your phone - http://www.bccicricket.org/cims/jsp/mobile/login.jsp for live score" //message to be sent
		
		if(isNaN(contactnum)||contactnum.indexOf(" ")!=-1)
		{
			alert("Please enter Numbers only");
			document.getElementById('phonenumber').focus();
			return false;
		}
		if (contactnum.length>10)
		{
			alert("Please enter a valid mobile number");
			document.getElementById('phonenumber').focus();
			return false;
		}
		if (contactnum.length<10)
		{
			alert("Please enter a valid mobile number");
			document.getElementById('phonenumber').focus();
			return false;
		}
		if (contactnum.charAt(0)!="9")
		{
			alert("Please enter a valid mobile number");
			document.getElementById('phonenumber').focus();
			return false;
		}
		if (chkspecialchars(document.getElementById("phonenumber").value) == "")
		{
			alert("Please enter a valid mobile number");
			return false
		}
				
		SendSmsToUser(contactnum,message)
		return true;
		
	}
	