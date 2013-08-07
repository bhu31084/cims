/* cricinfo mobile script */

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function test()
{
	getcontent_width();
	getcontent_width1();
	getcontent_width2();

}

function openS(URL,WindowName) {
window.open(URL,WindowName, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,titlebar=0,width=590,height=395');
if (openS.opener == null) openS.opener = window;
openS.opener.name = "opener";
}
function openL(URL,WindowName) {
window.open(URL,WindowName, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,titlebar=0,width=510,height=390');
if (openL.opener == null) openL.opener = window;
openL.opener.name = "opener";
}
function openR(URL,WindowName) {
window.open(URL,WindowName, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,titlebar=0,width=510,height=390');
if (openR.opener == null) openR.opener = window;
openR.opener.name = "opener";
}
function openJ(URL,WindowName) {
window.open(URL,WindowName, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,titlebar=0,width=280,height=200');
if (openJ.opener == null) openJ.opener = window;
openJ.opener.name = "opener";
}


function popup(mylink, windowname)
{
if (! window.focus)return true;
var href;
if (typeof(mylink) == 'string')
   href=mylink;
else
   href=mylink.href;
window.open(href, windowname, 'width=500,height=600,scrollbars=yes');
return false;
}


function check_alert()
{
if (document.getElementById("agree").checked == false)
   {  alert("Please check the terms and conditions");
   return false;
   }
   if (document.getElementById("download").checked == false)
   {  alert("Please download Genie on your mobile phone, before making the payment");
   return false;
   }
 else{return true;}
 }
 
 function chkspecialchars(string) {
 
 if (!string) return false;
 var iChars = "|,\":<>[]{}`.';()&$#%\\";
 
 for (var i = 0; i < string.length; i++) {
 if (iChars.indexOf(string.charAt(i)) != -1)
 return false;
 }
 return true;
 }

function MobileValidate()
{
//var x = document.wapform.phonenumber.value;
var y = document.wapform.phonenumber.value;
if(isNaN(y)||y.indexOf(" ")!=-1)
{
alert("Please enter Numbers only");
document.wapform.phonenumber.focus();
return false;
}
if (y.length>10)
{
alert("Please enter a valid mobile number");
document.wapform.phonenumber.focus();
return false;
}
if (y.length<10)
{
alert("Please enter a valid mobile number");
document.wapform.phonenumber.focus();
return false;
}
if (y.charAt(0)!="9")
{
alert("Please enter a valid mobile number");
document.wapform.phonenumber.focus();
return false;
}
if (chkspecialchars(document.getElementById("phonenumber").value) == "")
{
alert("Please enter a valid mobile number");
return false

}
else
{
alert("Thank you. You will receive an SMS soon");
}
return true;
}

function mobicastchkspecialchars(string) {

if (!string) return false;
var iChars = "|,\":<>[]{}`.';()&$#%\\";

for (var i = 0; i < string.length; i++) {
if (iChars.indexOf(string.charAt(i)) != -1)
return false;
}
return true;
}

function mobicastMobileValidate()
{
//var x = document.mobicastform.phonenumber.value;
var y = document.mobicastform.mobicastphonenumber.value;
if(isNaN(y)||y.indexOf(" ")!=-1)
{
alert("Please enter Numbers only");
document.mobicastform.mobicastphonenumber.focus();
return false;
}
if (y.length>10)
{
alert("Please enter a valid mobile number");
document.mobicastform.mobicastphonenumber.focus();
return false;
}
if (y.length<10)
{
alert("Please enter a valid mobile number");
document.mobicastform.mobicastphonenumber.focus();
return false;
}
if (y.charAt(0)!="9")
{
alert("Please enter a valid mobile number");
document.mobicastform.mobicastphonenumber.focus();
return false;
}
if (mobicastchkspecialchars(document.getElementById("mobicastphonenumber").value) == "")
{
alert("Please enter a valid mobile number");
return false;
}
else
{
alert("Thank you. You will receive an SMS soon");
}
return true;
}



