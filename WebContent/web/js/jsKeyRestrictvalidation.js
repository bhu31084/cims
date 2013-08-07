

/*
*  jsvalidation.js  
*  Date 8/5/2005
*  Html Form Validation Script
*  Rajvinder Singh
*/

var error = new Array();
var e=0;

//Block numbers call on onKeyPress event
function getKeyCode(e)
{
 if (window.event)
 	return window.event.keyCode;
 else if (e)
    return e.which;
 else
    return null;
}

function onKeyPressBlockNumbers(e)
{
	var key = window.event ? e.keyCode : e.which;
	var keychar = String.fromCharCode(key);
	reg = /\d/;
	return !reg.test(keychar);
}




var dot=0;
function keyRestrictDot(field,e, validchars) {

 var key='', keychar='';
 key = getKeyCode(e);
 
 if (key == null) return true;
 if(key==46){
  dot=dot+1;
 }
 if(dot>1)
 {
 document.getElementById(field).value="";
 dot=0;
 return false;
 }
 keychar = String.fromCharCode(key);
 keychar = keychar.toLowerCase();
 validchars = validchars.toLowerCase();
 if (validchars.indexOf(keychar) != -1)
  return true;
 if ( key==null || key==0 || key==8 || key==9 || key==13 || key==27 )
  return true;
 return false;
}



function keyRestrict(e, validchars) {
 var key='', keychar='';
 key = getKeyCode(e);
 if (key == null) return true;
 keychar = String.fromCharCode(key);
 keychar = keychar.toLowerCase();
 validchars = validchars.toLowerCase();
 if (validchars.indexOf(keychar) != -1)
  return true;
 if ( key==null || key==0 || key==8 || key==9 || key==13 || key==27 )
  return true;
 return false;
}


//Check date if less than SystemDate
function validateDate1(vDateName)
{
// vDateName form Element
var mDay = vDateName.value.substr(0,2);
var mMonth = vDateName.value.substr(3,2);
var mYear = vDateName.value.substr(6,4)

var sd= new Date();
 
var mon=sd.getMonth()+1;
var dt=sd.getDate();
var yr=sd.getYear();
if(mYear<yr | (mYear == yr && mMonth<=mon && mDay <dt))
  {
	//alert("Invalid Date\nPlease Re-Enter");
	vDateName.value = "";
	vDateName.focus();
	return true;
  }
}




function   creditPeriodRestriction(Field){
  				var creditPeriod=30;
				if(Field.value > creditPeriod)
				{
				 	 Field.focus();
				 	 alert("CreditPeriod should not be greater than"+creditPeriod+" days");
				 	 Field.value="";
					 return false;
					}
				}


//adding error msg
function add_error_msg(msg)
{
    error[e] = msg; 
    e++;
    return false;
}

//initialize error array          
function initialize_error_msgs()
{
 /*
 for(n=0;n<=error.length-1;n++)
 {
  error[n]=" ";
 }
 */
 error = new Array();
 e=0;
}
/*function RegExTest(element,expression)
{
return element.value.match(expression) != null;
}*/


//Checking for valid decimal number
/*function IsDecimal(element)
{
var decimalRE = "^(\\+|-)?[0-9][0-9]*(\\.[0-9]*)?$";
return RegExTest(element,decimalRE);
}*/




//display error msg
function display_error_msgs(form_name)
{
  var errDes="";
  //errDes = "Error Processing   " + form_name.name + "\n\n"; 

 for(n=0;n<=error.length-1;n++)
 {
  errDes=errDes+error[n]+"\n";
 }
 alert(errDes);
}

//check error array for displaying error msg
function check_display_errors(form_name)
{

  if(e>0)
  {
  	display_error_msgs(form_name);
 	return false;
  }
  else
  {
	 return true;
  }
}

//function check for empty field value
function is_empty_tb(textbox)
{
  if (textbox.value == '')
  {
	return true;
  }
  else
  {
   return false;
  }
}


function mod_is_empty_tb(textbox)
{
  chkString = escape(textbox.value)
  if( (chkString.substring(0,3)=="%20") && (textbox.value.length == 1))
  {	
        textbox.value="";
	return true;
  }
  else
  {
   return false;
  }
}


function printMsg(msg)
{
  return add_error_msg(msg) ;
}

function validate_maxlength_allowed(textbox,msg)
{
	var size;
	size=textbox.value.length;
	if(size>9 || size<9)
	{
		return add_error_msg(msg);
	}
}
//8/12/2005 edited by abhishek
function validate_maxlength_allowed(textbox,msg,maxsize)
{
	var size;
	var maxallowed;
	maxallowed = maxsize;
	size=textbox.value.length;
	if(size>maxallowed)
	{
		return add_error_msg(msg);
	}
}

//8/12/2005 edited by abhishek
function validate_maxlength_allowed_fix(textbox,msg,maxsize)
{
	var size;
	var maxallowed;
	maxallowed = maxsize;
	size=textbox.value.length;
	if(size<maxallowed||size>maxallowed)
	{
		return add_error_msg(msg);
	}
}

//function checks for mandatory field's value
function validate_mandatory_tb(textbox)
{
  if(textbox.type=="text" || textbox.type=="textarea")
  var f_value = textbox.value;
  else
  if(textbox.type=="select-one")
  var f_value = textbox.options[textbox.selectedIndex].value;
     
  if (f_value == "") 
  {
    if(textbox.type=="text" || textbox.type=="textarea")
  	return add_error_msg(textbox.name + " must be entered");
	else
	if(textbox.type=="select-one")
	return add_error_msg("select " + textbox.name + " from SelectBox");
  }
}

//function checks for mandatory field's value and throws customised message as in argument
function validate_mandatory_tb_with_message(textbox, message)
{
  if(textbox.type=="text" || textbox.type=="textarea" || textbox.type=="hidden" || textbox.type=="password")
  var f_value = textbox.value;
  else
  if(textbox.type=="select-one")
  var f_value = textbox.options[textbox.selectedIndex].value;
  else
  {
   if(textbox[0].type=="radio")
   {
    var f_value = "";
    var radiolen = textbox.length;
    for(i=0;i<=radiolen-1;i++) 
    {
     if(textbox[i].checked)
     var f_value = "1";
	 
    }
   }
  } 
     
  if (f_value == "") 
  {
    if(textbox.type=="text" || textbox.type=="textarea" || textbox.type=="password")
  	return add_error_msg(message);
	else
	if(textbox.type=="select-one")
	return add_error_msg(message);
	else
	if(textbox[0].type=="radio")
	return add_error_msg(message);
  }
}


//function compares two textbox value
function validate_compare_tb(textbox1,textbox2)
{
 if(textbox1.value!=textbox2.value)
 return true;
 else
 return false;
}

//function checks for Numeric Value Entry
function validate_numeric_value(textbox)
{
 if(isNaN(textbox.value))
 {
  return add_error_msg(textbox.name + " must be a Numeric Value");
 }
}

//function checks for Numeric Value Entry with Apropriate Field Msg
function validate_numeric_value_with_msg(textbox,msg)
{
 if(isNaN(textbox.value))
 {
  return add_error_msg(msg + " must be a Numeric Value");
 }
}

//function checks for String Value
function validate_string_value(textbox)
{
 var str = textbox.value;
 for(i=0;i<=str.length-1;i++)
 {
  if(!(isNaN(str.charAt(i))))
  return add_error_msg(textbox.name + " must be String Value");
 }
}

//function checks for String Value Entry with Apropriate Field Msg
function validate_string_value_with_msg(textbox,msg)
{
 var str = textbox.value; 
 for(i=0;i<=str.length-1;i++)
 {
  if(!(isNaN(str.charAt(i))))
  return add_error_msg(msg + " must be String Value");
 }
}

//function checks for Alpha-Numeric Value
function validate_alpha_numeric_value(textbox)
{
  if(!(isNaN(textbox.value)))
  {
   return false;//add_error_msg(textbox.name + " must be Alpha-Numeric OR String Value");
  }
}

//function checks for Alpha-Numeric Value Entry with Apropriate Field Msg
function validate_alpha_numeric_value_with_msg(textbox,msg)
{
  if(!(isNaN(textbox.value)))
  {
   return add_error_msg(msg + " must be Alpha-Numeric OR String Value");
  }
}

//function checks for spaces[begening and end of the string] in the value of textbox input field
function validate_textbox_space(textbox)
  {
    chkString = escape(textbox.value)
    if(chkString.substring(0,3)=="%20")
    return add_error_msg("Space not allowed at the begening of "+textbox.name+" = "+ textbox.value);
    if(chkString.substring(chkString.length-3,chkString.length+1)=="%20")
    return add_error_msg("Space not allowed at the end of "+textbox.name+" = "+ textbox.value);
  }
  
//function checks for spaces[begening and end of the string] in the value of textbox input field with Msg  
function validate_textbox_space_with_msg(textbox,msg)
  {
    chkString = escape(textbox.value)
    if(chkString.substring(0,3)=="%20")
    return add_error_msg("Space not allowed at the beginning of "+msg);
    if(chkString.substring(chkString.length-3,chkString.length+1)=="%20")
    return add_error_msg("Space not allowed at the end of "+msg);
  }  

//function checks specified decimal points in numeric value
function validate_decimal_value(textbox,dVal)
{
  var fldLen = textbox.value.length;
  for(i=0;i<=fldLen-1;i++)
  {
   if(textbox.value.charAt(i)==".")
   {
    if((parseInt(fldLen-1)-i)>parseInt(dVal))
	add_error_msg(textbox.value + " Only "+dVal+" decimal points allowed");
   }
  }
}

//function checks specified decimal points in numeric value with Msg
function validate_decimal_value_with_msg(textbox,dVal,msg)
{
  var fldLen = textbox.value.length;
  for(i=0;i<=fldLen-1;i++)
  {
   if(textbox.value.charAt(i)==".")
   {
    if((parseInt(fldLen-1)-i)>parseInt(dVal))
	add_error_msg(" Only "+dVal+" digits allowed after decimal point in "+ msg);
   }
  }
}

//function checks specified decimal points in numeric value and digits before decimal points
function validate_decimal_init_value(textbox,dVal,iVal,textbox_name)
{
  var fldLen = textbox.value.length;
  for(i=0;i<=fldLen-1;i++)
  {
   if(textbox.value.charAt(i)==".")
   {
    if((parseInt(fldLen-1)-i)>parseInt(dVal))
	add_error_msg("For "+textbox_name+" Only "+dVal+" digits allowed after decimal point");
	
	if((parseInt(i))>parseInt(iVal))
	add_error_msg("For "+textbox_name+" Only "+iVal+" digits allowed before decimal point");
   }
  }
}

//function checks specified decimal points in numeric value and digits before decimal points with Msg
function validate_decimal_init_value_with_msg(textbox,dVal,iVal,textbox_name,msg)
{
  var fldLen = textbox.value.length;
  for(i=0;i<=fldLen-1;i++)
  {
   if(textbox.value.charAt(i)==".")
   {
    if((parseInt(fldLen-1)-i)>parseInt(dVal))
	add_error_msg("For "+msg+" Only "+dVal+" digits allowed after decimal point");
	
	if((parseInt(i))>parseInt(iVal))
	add_error_msg("For "+msg+" Only "+iVal+" digits allowed before decimal point");
   }
  }
}

//function validates email values  
function validate_email_value(textbox)
{

 var email = textbox.value;
 var flag = new Boolean();
 
 if(email.charAt(0)!="@")
 { 
  for(i=0;i<=email.length-1;i++)
  {
   if(email.charAt(i)=="@")
   {
    for(j=i;j<=email.length-1;j++)
    {
     if(email.charAt(j)==".")
	 {
	  if(email.length-1>j+1)
	  return true;
	 } 
    }
    return add_error_msg("Please enter a valid email address");
   }
  }
  return add_error_msg("Please enter a valid email address");
 }
 else
 return add_error_msg("Please enter a valid email address");
 
}  


//function checks for integer value
function validate_integer_value(textbox)
{
 var fldlen = textbox.value.length;
 for(i=0;i<=fldlen-1;i++)
 {
  if(textbox.value.charAt(i)==".")
  add_error_msg(textbox.name + " must be Integer Value"); 
 }
}

//function checks for an integer value (no decimals allowed).
function validate_integer_value_msg(textbox,msg)
{
 var fldlen = textbox.value.length;
 for(i=0;i<=fldlen-1;i++)
 {
  if(textbox.value.charAt(i)==".")
  add_error_msg("Decimal value not allowed in "+msg); 
 }
}

function validate_ispositive(textbox)
{
 if(parseFloat(textbox.value)<=parseFloat("0")) 
 add_error_msg(textbox.name + " Value must be > 0"); 

}

function validate_ispositive_msg(textbox,msg)
{
 if(parseFloat(textbox.value)<=parseFloat("0")) 
 add_error_msg(msg+" should be a positive value"); 

}

//function checks for special char entry
function validate_special_char(textbox,msg)
{
 var amtinv = textbox.value;
 var validStr = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.0123456789/-?(),\"+\n\r";
	  
 for(i=0;i<=textbox.value.length-1;i++)
 {
  //alert(validStr.indexOf(amtinv.charAt(i)));
  if(validStr.indexOf(amtinv.charAt(i))==-1)
  {
   add_error_msg("Invalid character    "+amtinv.charAt(i)+"    entered for "+msg);
   break;
  }
 }
}

//Added by Subhendu
function clear_error_msg()
{
	e=0;
	return false;
}


//check date format in dd/mm/yy from single textbox 7/9/2005 (Abhishek and shaila)
/*function validate_date_value_with_msg(textbox,msg,allowempty)
{
 var fdate = textbox.value; 

	if(fdate.length==10)
	{
 
			 var fdd  =  fdate.substring(0,2);
			 var fspace1 = fdate.substring(2,3);
			 var fmm = fdate.substring(3,5);
			 var space2 = fdate.substring(5,6);
			 var fyy = fdate.substring(6,10);

			//checking wether the dd mm yy are number or not


				if(isNaN(fdd) || isNaN(fmm) || isNaN(fyy))
				{
					return add_error_msg(msg +": invalid date: DateFormat: dd/mm/yy ");
				}

				if((fdd) < 1 || (fdd) > 31)
				{
					return add_error_msg(msg +": Date range from 01 to 31: DateFormat: dd/mm/yy");
				}

				if((fmm) < 1 || (fmm) > 12)
				{
					return add_error_msg(msg +": Month range from 01 to 12: DateFormat: dd/mm/yy");
				}

				if((fyy) < 0 )
				{
					return add_error_msg(msg +": Year range from 00 to 99: DateFormat: dd/mm/yy");
				}

				if(fspace1 !="/" ||space2 !="/")
				{
					return add_error_msg(msg +": DateFormat: dd/mm/yy");

				}

				if(allowempty!="true")
					{
						if(fdate=="")
						{
							return add_error_msg(msg +": DateFormat: dd/mm/yy");

						}
					}


	}
	

}*/



/**
 * DHTML date validation script for dd/mm/yyyy. Edited by Abhishek 8/17/2005
 */
// Declaring valid date character, minimum year and maximum year



var msg1;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}
function textLimit(field, maxlen) {
try{
	if (field.value.length > maxlen + 1)
	alert('you can not Enter larger than 254 Character!');
	if (field.value.length > maxlen)
	field.value = field.value.substring(0, maxlen);
}catch(err){
		//err.printStackTrace();
		alert('err in TrainingHRApproval.jsp.textLimit() '+err.description);
	}
}
function isDate(dtStr){

	var dtCh= "/";
	var minYear=1960;
	var maxYear=2100;
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		add_error_msg("The date format should be : dd/mm/yyyy:  " +msg1);
		//alert("The date format should be : dd/mm/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		add_error_msg("Please enter a valid month:  "+msg1)
		//alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		add_error_msg("Please enter a valid day:  " +msg1)
		//alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		add_error_msg("Please enter a valid 4 digit year between "+minYear+" and "+maxYear);
		//alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		add_error_msg("Please enter a valid date:  "+msg1);
		//alert("Please enter a valid date")
		return false
	}
return true
}

//msg in this has no such use...
 function validate_date_value_with_msg(textbox,msg,allowempty){

	if(allowempty!="true"|| textbox.value!="")
	{
			msg1=msg;
			if (isDate(textbox.value)==false){
				textbox.focus()
				return false
			}

	}	
    return true
 }
//date validation Umesh
function fromToDateValidate(fromDate , toDate )
{

	fromDay   = fromDate.substring(0, fromDate.indexOf("/"));
	fromMonth = fromDate.substring (fromDate.indexOf ("/")+1, fromDate.lastIndexOf ("/"));
	fromYear  = fromDate.substring (fromDate.lastIndexOf("/")+1, fromDate.length); 

//   enterYear  = strDate.substring (strDate.lastIndexOf ("/")+1, strDate.length); 

	objFromDate = new Date()


	objFromDate.setDate(fromDay);
    objFromDate.setMonth(fromMonth - 1);
    objFromDate.setYear(fromYear);


	toDay   = toDate.substring(0, toDate.indexOf("/"));
	toMonth = toDate.substring (toDate.indexOf ("/")+1, toDate.lastIndexOf ("/"));
	toYear  = toDate.substring (toDate.lastIndexOf ("/")+1, toDate.length); 

	objToDate = new Date()

   
    objToDate.setDate(toDay);
    objToDate.setMonth(toMonth - 1);
    objToDate.setYear(toYear);


	fromDateTime  = objFromDate.getTime();
	toDateTime    = objToDate.getTime();


	// calculating difference in time //
	diffTime =(toDateTime - fromDateTime);


	if(diffTime < 0) {
		add_error_msg('From Date is greater than To Date')
		return false	
	}
	else {
		return true
	}

}  // end of  fromToDateValidate


/// method to validate with  current date , entered date should be greater than current date

function currentDateValidate(enteredDate)
{

	enteredDay   = enteredDate.substring(0, enteredDate.indexOf("/"));
	enteredMonth = enteredDate.substring (enteredDate.indexOf ("/")+1, enteredDate.lastIndexOf ("/"));
	enteredYear  = enteredDate.substring (enteredDate.lastIndexOf("/")+1, enteredDate.length); 

	objEnteredDate = new Date()
	
	objEnteredDate.setDate(enteredDay);
    objEnteredDate.setMonth(enteredMonth - 1);
    objEnteredDate.setYear(enteredYear);

	objCurrDate = new Date()
	

	enteredDateTime = objEnteredDate.getTime()
	currentDateTime = objCurrDate.getTime()

	diffTime = (enteredDateTime - currentDateTime)

	
	if( diffTime > 0 ) {
		add_error_msg('Entered Date cannot be greater than today date')
		return false
	}
	else {
		return true
	} 

//	return false


}  // end of  currentDateValidate

//current date must be greater than current date
function currentDateValidate_later(enteredDate)
{

	enteredDay   = enteredDate.substring(0, enteredDate.indexOf("/"));
	enteredMonth = enteredDate.substring (enteredDate.indexOf ("/")+1, enteredDate.lastIndexOf ("/"));
	enteredYear  = enteredDate.substring (enteredDate.lastIndexOf("/")+1, enteredDate.length); 

	objEnteredDate = new Date()
	
	objEnteredDate.setDate(enteredDay);
    objEnteredDate.setMonth(enteredMonth - 1);
    objEnteredDate.setYear(enteredYear);

	objCurrDate = new Date()
	

	enteredDateTime = objEnteredDate.getTime()
	currentDateTime = objCurrDate.getTime()

	diffTime = (enteredDateTime - currentDateTime)

	
	if( diffTime > 0 ) {
		return true
	}
	else {add_error_msg('Entered Date must be greater than today date')
		return false
		
	} 

//	return false


}  // end of  currentDateValidate





//Abhishek 9/5/2005 created for add requirement form for checking experience range
function validate_combo_range(cb1,cb2,msg)

{
	var r1=parseInt(cb1);


	var r2=parseInt(cb2);

	if((r1>r2) )
	{
		add_error_msg(msg+": Please enter a valid range");
	return false
	}
	return true
}

//added by singarvel is to remove the blank space
function trimAll(sString) 
{
	while (sString.substring(0,1) == ' ')
	{
		sString = sString.substring(1, sString.length);
	}
	while (sString.substring(sString.length-1, sString.length) == ' ')
	{
		sString = sString.substring(0,sString.length-1);
	}
	sString = removeSpaces(sString);
	return sString;
}

// remove the spaces
function removeSpaces(s){
	var strArray = s.split(/\s/g)
	var str = '';
	for (var i=0; i<strArray.length; i++){
		 str = str + strArray[i]+ ' ';
	}
		str = str.substring(0,str.length-1);
		return str;
	}


// check wheather the particular is blank
function isBlank(s){
	var st = String(s)
	if( s == 'null' || trimAll(st).length == 0 || s == null ){
		return true;
	}	
	return false;
}

