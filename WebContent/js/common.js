/*modifyed Date:12-09-2008*/
// JScript File
var checkglobReqCntr=0;//for assigning unique IDS TO  AJAX DYNAMIC LIST REQUEST
var timerVal=500;//for timeout value to set for setting the delay on the keypress event for the  AJAX DYNAMIC LIST REQUEST
function $(val){
    try{
        if( document.getElementById(val) != null){
            return document.getElementById(val);
        }else{
            alert('Invalid Form Element Name = '+val)
        }
    }catch(err){
        alert('error in Common.js.$() '+err.description)
    }
}

function $$(val){
    try{
        if( document.getElementById(val).value != null){
            return document.getElementById(val).value;
        }else{
            alert('Invalid Form Element Name = '+val)
        }
    }catch(err){
        //alert('error in Common.js.$$() '+err.description)
    }
}

/*
	DynAPI Distribution
	StringBuffer Class

	The DynAPI Distribution is distributed under the terms of the GNU LGPL license.

*/

function trim(field)
{
	while(''+field.value.charAt(0)==' ')
		field.value=field.value.substring(1,field.value.length);
	return field.value
}

function StringBuffer(){
	this.buffer=[];
};
var p = StringBuffer.prototype;
p.add=function(src){
	this.buffer[this.buffer.length]=src;
};
p.flush=function(){
	this.buffer.length=0;
};
p.getLength=function(){
	return this.buffer.join('').length;
};
p.toString=function(delim){
	return this.buffer.join(delim||'');
};

// More features can be added such as indexOf(), charAt(), etc

function isInteger(inpString){
	try{
		var intPattern= /[^0-9]/
		if(intPattern.test(inpString) == false){
			return true;
		}else{
			return false;
		}
	}catch(err){
		alert("error in /js/common.js.isInteger() "+err.description);
	}
}


function getMouseXY(e) // works on IE6,FF,Moz,Opera7
{ 
  	  var mousex =0 ;
  	  var mousey =0 ;
  if (!e) e = window.event; // works on IE, but not NS (we rely on NS passing us the event)
  if (e)
  { 
    if (e.pageX || e.pageY)
    { // this doesn't work on IE6!! (works on FF,Moz,Opera7)
      mousex = e.pageX;
      mousey = e.pageY;
      algor = '[e.pageX]';
      if (e.clientX || e.clientY) algor += ' [e.clientX] '
    }
    else if (e.clientX || e.clientY)
    { // works on IE6,FF,Moz,Opera7
      // Note: I am adding together both the "body" and "documentElement" scroll positions
      //       this lets me cover for the quirks that happen based on the "doctype" of the html page.
      //         (example: IE6 in compatibility mode or strict)
      //       Based on the different ways that IE,FF,Moz,Opera use these ScrollValues for body and documentElement
      //       it looks like they will fill EITHER ONE SCROLL VALUE OR THE OTHER, NOT BOTH 
      //         (from info at http://www.quirksmode.org/js/doctypes.html)
      mousex = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
      mousey = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
      algor = '[e.clientX]';
      if (e.pageX || e.pageY) algor += ' [e.pageX] '
    }
//	alert("mousex =  "+mousex+"  mousey = "+mousey);
  }
	return mousey; 
	//document.getElementById('scrollDivUp').style.top=mousey+'px'
}



function IsNumeric(val){
	try{
		return !isNaN(new Number(val))
	}catch(err){
			alert(' err in  Common.js.isNumber () '+err.description)
		}
}


/*
function IsNumeric(sText)
{
   var ValidChars = "0123456789.";
   var IsNumber=true;
   var Char;

 
   for (i = 0; i < sText.length && IsNumber == true; i++) 
      { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
         IsNumber = false;
         }
      }
   return IsNumber;
   
   }
*/
    function trimString(thisString){
	    var newString = thisString;
	    while (newString.charCodeAt(0) < 33)
	    {
		    newString = newString.substring(1,newString.length);
	    }
    	
	    while (newString.charCodeAt(newString.length - 1) < 33)
	    {
		    newString = newString.substring(0, newString.length - 1);
	    }
	    return newString;
    }

//function that trims and parses to int on an input string
function parseTrimInt(eleId){
    try{
            return parseInt(trimString($(eleId).value) == ''?'0':trimString($(eleId).value));
    }catch(err){
        alert('error in Common.js.parseTrimInt()  '+err.description)
    }
}

//function that trims and parses to float on an input string
function parseTrimFloat(eleId){
    try{
            return parseFloat(trimString($(eleId).value) == ''?'0.0':trimString($(eleId).value));
    }catch(err){
        alert('error in Common.js.parseTrimFloat()  '+err.description)
    }
}

/**
 * function to set and unset the display of the screens
 * 
 * 
 * @arguments: hideId desc:ids of the element to hide(delemited strings)
 * @arguments: unhideId desc:ids of the element to Unhide(delemited strings)
 **/
function hideUnhideFields(hideId,unhideId){
    try{
        var hideIdArr=hideId.split('~');
        var unhideIdArr=unhideId.split('~');
		for(var i=0;i<hideIdArr.length;i++){
			if(hideId != '' && $(hideIdArr[i]) != null  ){	
                $(hideIdArr[i]).style.display='none';				
            }
        }
        for(var i=0;i<unhideIdArr.length;i++){
            if(unhideId != '' && $(unhideIdArr[i]) != null ){
                $(unhideIdArr[i]).style.display='';
            }
        }
    }catch(err){
        alert('err in Common.js.hideUnhideFields()  '+err.description)
    }   
}

/**
 * function to set and unset the readonly fl;ag of an element
 * 
 * 
 * @arguments: readonlyid desc:ids of the element to set or unset readonly(delemited strings)
 * @arguments: setUnsetFlagdesc:boolean value true:to sets readonly || false:to unsets readonly
 **/

function setUnsetReadOnly(readonlyid,setUnsetFlag){
    try{
        var readonlyidArr=readonlyid.split('~'); 
        for(var i=0;i<readonlyidArr.length;i++){
            if($(readonlyidArr[i]) != null ){
                $(readonlyidArr[i]).readOnly=eval(setUnsetFlag);
            }
        }
    }catch(err){
        alert('err in Common.js.setUnsetReadOnly()  '+err.description)
    }   
}

/**
 * function to set and unset the readonly fl;ag of an element
 * 
 * 
 * @arguments: readonlyid desc:ids of the element to set or unset disabled(delemited strings)
 * @arguments: setUnsetFlagdesc:boolean value true:to sets readonly || false:to unsets disabled
 **/

function setUnsetDisabled(disabledid,setUnsetFlag){
    try{
        var disabledidArr=disabledid.split('~'); 
        for(var i=0;i<disabledidArr.length;i++){
            if($(disabledidArr[i]) != null ){
                $(disabledidArr[i]).disabled=eval(setUnsetFlag);
                if(eval(setUnsetFlag)){
                    $(disabledidArr[i]).style.background='#F0F0F0'
                }else{
                    $(disabledidArr[i]).style.background='#FFFFFF'
                }
            }
        }
    }catch(err){
        alert('err in Common.js.setUnsetDisabled()  '+err.description)
    }   
}

/**
 * function to set all the fields clear
 * 
 * 
 * @arguments: eleid desc:ids of the element to clear thefield (delemited strings)
 * 
 **/

function setClearField(clearId){
    try{
        var clearIdArr=clearId.split('~'); 
        for(var i=0;i<clearIdArr.length;i++){
            if($(clearIdArr[i]) != null ){
                $(clearIdArr[i]).value='';
            }
        }
    }catch(err){
        alert('err in Common.js.setClearField()  '+err.description)
    }   
}

/**
 * function to set all the the InnerHtml of an element Clear
 * 
 * 
 * @arguments: clearId desc:ids of the element to clear the innerHTML (delemited strings)
 * 
 **/
function setClearInnerHtml(clearId){
    try{
        var clearIdArr=clearId.split('~'); 
        for(var i=0;i<clearIdArr.length;i++){
            if($(clearIdArr[i]) != null ){
                $(clearIdArr[i]).innerHTML='';
            }
        }
    }catch(err){
        alert('err in Common.js.setUnsetReadOnly()  '+err.description)
    }   
}

/**
 * function to set AJAX DYNAMIC LIST REQUEST
 * 
 * 
 * @argument 1: currObj desc:object of the element which initiates the dynamic list 
 * @argument 2: e desc:Event object of the element which initiates the dynamic list 
 * @argument 3: url desc:url of the server side webpage
 * @argument 4: paramtoFile desc:parameter to distinguish requests
 * @argument 5: addParam desc:additional namevalue parameters if any
 * 
 **/
	function setRequest(currObj,e,url,paramtoFile,addParam){
		try{		
//		    alert('e.keyCode'+e.keyCode);
		    addParam = addParam==null?'':addParam;
		    if(e.keyCode == 16  | e.keyCode == 9 | e.keyCode == 27 | e.keyCode == 37 | e.keyCode == 38 | e.keyCode == 39 | e.keyCode == 40 | e.keyCode == 13)return false;
		    var checkCntr =++checkglobReqCntr;
		    var retFunc=function (){sendFinalRequest(currObj,checkCntr,e,url,paramtoFile,addParam)}
		    setTimeout(retFunc ,timerVal)//checkglobReqCntr
	    }catch(err){
	        alert('error in Common.js.setRequest()'+err.description);
	    }
	}

/**
 * threaded function called after a specfic time interval
 * 
 * @argument 1: currObj desc:object of the element which initiates the dynamic list 
 * @argument 2: checkCntr desc:unique request counter id
 * @argument 3: e desc:Event object of the element which initiates the dynamic list 
 * @argument 4: e desc:Event object of the element which initiates the dynamic list 
 * @argument 5: url desc:url of the server side webpage
 * @argument 6: paramtoFile desc:parameter to distinguish requests
 * @argument 7: addParam desc:additional namevalue parameters if any
 * 
 **/
	function sendFinalRequest(currObj,checkCntr,e,url,paramtoFile,addParam){
		try{
//			alert("checkglobReqCntr "+checkglobReqCntr);
//			alert("checkCntr   "+checkCntr);
			if(checkCntr == checkglobReqCntr){
				ajax_showOptions(eval(currObj),url,paramtoFile,addParam,e);
				checkglobReqCntr=0;
			}else{
				return false;
			}
		}catch(err){
	        alert('error in Common.js.sendFinalRequest()'+err.description);
		}
	}


	//checks if an value set in the corresponding hidden field ,if no then it will clear the display field as well with checking
	//clears all field without checking any hidden field
	function checkClearField(fieldId,checktype){//checktype 'check' 'nocheck'
		try{
		    if(checktype == 'check'){
		        var temp_fieldId=fieldId.split('~');
		        for(var i=0;i<temp_fieldId.length;i++){
		            if(temp_fieldId[i] != ''){
		                if($(temp_fieldId[i]).value == ''){
			                if($(temp_fieldId[i]+'_hidden')!= null){
    			                $(temp_fieldId[i]+'_hidden').value='';
		                        $(temp_fieldId[i]).value="";
		                    }
		                }
		                if($(temp_fieldId[i]).value == ''){
			                if($(temp_fieldId[i]+'_dispalt')!= null){
		                        $(temp_fieldId[i]).value="";
    			                $(temp_fieldId[i]+'_dispalt').value='';
		                    }
		                }
	                }
	            }
	        }else if(checktype == 'nocheck'){
		        var temp_fieldId=fieldId.split('~');
		        for(var i=0;i<temp_fieldId.length;i++){
		            if(temp_fieldId[i] != ''){
		                $(temp_fieldId[i]).value=''
                        if($(temp_fieldId[i]+'_hidden')!= null){
		                    $(temp_fieldId[i]+'_hidden').value='';
		                }
		                if($(temp_fieldId[i]+'_dispalt')!= null){
			                $(temp_fieldId[i]+'_dispalt').value='';
	                    }
	                }
	            }
	        }
	    }catch(err){
	        alert('error in Common.js/checkClearField '+err.description)
	    }
	}
	

/**
 * COMMON DHTML FUNCTIONS
 * These are handy functions I use all the time.
 *
 * By Seth Banks (webmaster at subimage dot com)
 * http://www.subimage.com/
 *
 * Up to date code can be found at http://www.subimage.com/dhtml/
 *
 * This code is free for you to use anywhere, just keep this comment block.
 */

/**
 * X-browser event handler attachment and detachment
 * TH: Switched first true to false per http://www.onlinetools.org/articles/unobtrusivejavascript/chapter4.html
 *
 * @argument obj - the object to attach event to
 * @argument evType - name of the event - DONT ADD "on", pass only "mouseover", etc
 * @argument fn - function to call
 */
function addEvent(obj, evType, fn){
 if (obj.addEventListener){
    obj.addEventListener(evType, fn, false);
    return true;
 } else if (obj.attachEvent){
    var r = obj.attachEvent("on"+evType, fn);
    return r;
 } else {
    return false;
 }
}
function removeEvent(obj, evType, fn, useCapture){
  if (obj.removeEventListener){
    obj.removeEventListener(evType, fn, useCapture);
    return true;
  } else if (obj.detachEvent){
    var r = obj.detachEvent("on"+evType, fn);
    return r;
  } else {
    alert("Handler could not be removed");
  }
}

/**
 * Code below taken from - http://www.evolt.org/article/document_body_doctype_switching_and_more/17/30655/
 *
 * Modified 4/22/04 to work with Opera/Moz (by webmaster at subimage dot com)
 *
 * Gets the full width/height because it's different for most browsers.
 */
function getViewportHeight() {
	if (window.innerHeight!=window.undefined) return window.innerHeight;
	if (document.compatMode=='CSS1Compat') return document.documentElement.clientHeight;
	if (document.body) return document.body.clientHeight; 

	return window.undefined; 
}
function getViewportWidth() {
	var offset = 17;
	var width = null;
	if (window.innerWidth!=window.undefined) return window.innerWidth; 
	if (document.compatMode=='CSS1Compat') return document.documentElement.clientWidth; 
	if (document.body) return document.body.clientWidth; 
}

/**
 * Gets the real scroll top
 */
function getScrollTop() {
	if (self.pageYOffset) // all except Explorer
	{
		return self.pageYOffset;
	}
	else if (document.documentElement && document.documentElement.scrollTop)
		// Explorer 6 Strict
	{
		return document.documentElement.scrollTop;
	}
	else if (document.body) // all other Explorers
	{
		return document.body.scrollTop;
	}
}
function getScrollLeft() {
	if (self.pageXOffset) // all except Explorer
	{
		return self.pageXOffset;
	}
	else if (document.documentElement && document.documentElement.scrollLeft)
		// Explorer 6 Strict
	{
		return document.documentElement.scrollLeft;
	}
	else if (document.body) // all other Explorers
	{
		return document.body.scrollLeft;
	}
}



/*
    changeCss () function  called to change the CSS of an object on mousehover or click
*/
var globalCssTrObj='';
function changeCss(action,rowObj){
    try{
        if(action == 'moin'){
            rowObj.className = 'rowStyleChCss';
                for(var i=0;i<rowObj.childNodes.length;i++){
                    rowObj.childNodes[i].className = 'rowStyleChCss';
                }
        }else if(action == 'moout'){
            if(rowObj.getAttribute('activeTr') == 'false'){
                rowObj.className = rowObj.getAttribute('tempClassName');
                for(var i=0;i<rowObj.childNodes.length;i++){
                    rowObj.childNodes[i].className = rowObj.getAttribute('tempClassName');
                }
            }
        }else if(action == 'moclk'){
            if(globalCssTrObj != ''){
                globalCssTrObj.className = globalCssTrObj.getAttribute('tempClassName');
                for(var i=0;i<rowObj.childNodes.length;i++){
                    globalCssTrObj.childNodes[i].className = globalCssTrObj.getAttribute('tempClassName');
                }
                globalCssTrObj.setAttribute('activeTr','false')
            }
            rowObj.className = 'rowStyleChCss';
            for(var i=0;i<rowObj.childNodes.length;i++){
                rowObj.childNodes[i].className = 'rowStyleChCss';
            }
            rowObj.setAttribute('activeTr','true')
            globalCssTrObj = rowObj;
        }
    }catch(err){
        alert('err in changeCss() '+err.description)
    }
}    



function getIdAttribute(eleObj){
	if(eleObj.getAttribute('id') == null || eleObj.getAttribute('id') == ""){
		return eleObj.getAttribute('name');
	}else{
		return eleObj.getAttribute('id');
	}
}

function filterElementType(eleObj){
	if(eleObj.type == 'button'){
		return false;
	}else{
		return true;
	}
}

function buildQueryString(formIndex){
	var eleObjArr= document.forms[formIndex].elements		
	var url_Str="";
	for(var i=0;i<eleObjArr.length;i++){
		if(filterElementType(eleObjArr[i])){
			if(i == (eleObjArr.length-1) ){
				url_Str=url_Str+(getIdAttribute(eleObjArr[i])+"="+encodeURIComponent(eleObjArr[i].value))
			}else{
				url_Str=url_Str+(getIdAttribute(eleObjArr[i])+"="+encodeURIComponent(eleObjArr[i].value))+"&"
			}
		}
	}
	if(url_Str.substring(url_Str.length-1) == '&'){
		//alert(url_Str.substring(0,url_Str.length-1))
		return url_Str.substring(0,url_Str.length-1);
	}else{
		return url_Str;
	}
}

/*
    checkNumericAll() checks i9f all the fields are numeric 
*/
function checkNumericAll(delStr){
    try{		
        var numArr = delStr.split('~');
        for(var i=0;i<numArr.length;i++){				
            if(trim($(numArr[i]))  != "" ){				
                if(!IsNumeric($$(numArr[i]))){						
                    return numArr[i];
                }				
            }
        }
        return "";
   }catch(err){
        alert('err in Common.js.checkNumericAll() '+err.description);
    }
}

/*
    function to check the max value
*/
function checkMaxValAll(delStr,limtvalue){
    try{
        var delStrArr = delStr.split('~');
        for(var i=0;i<delStrArr.length;i++){
            if($(delStrArr[i]) != null && $$(delStrArr[i]) != ""){
                if((new Number($$(delStrArr[i]))) > limtvalue){
                    return delStrArr[i];
                }
            }
        }
        return "";
    }catch(err){
        alert('err in Common.js.checkLimitValAll() '+err.description);
    }
}

/*
    function to check the sum equals  value
*/

function checkSumEqualsvalue(delStr,sumvalue,message,defFocus){
    try{
        var delStrArr = delStr.split('~');
        var tempNum=0;
        for(var i=0;i<delStrArr.length;i++){
            if($(delStrArr[i]) != null && $$(delStrArr[i]) != ""){
                tempNum = tempNum + new Number($$(delStrArr[i]) == "" ?'0':$$(delStrArr[i]))
            }
        }
        if((( new Number(tempNum)).toString() != (new Number(sumvalue)).toString() )){
            alert(message);
            $(defFocus).focus();
            return true;
        }
        return "";
    }catch(err){
        alert('err in Common.js.checkLimitValAll() '+err.description);
    }
}

/*
    function to check mandatory fields 'fieldId1#message1~fieldId2#message2'
*/
function checkEmptyAll(delStr){
    try{
        var strArr = delStr.split('~');
        for(var i=0;i<strArr.length;i++){
            if(trim($((strArr[i].split('#'))[0]))  == "" ){
                alert('Please Enter '+strArr[i].split('#')[1]+' ! ')
                $((strArr[i].split('#'))[0]).focus();
                return true;
            }
        }
        return false;
    }catch(err){
        alert('err in Common.js.checkEmptyAll() '+err.description);
    }
}

function checkBiggerDate(dateStr,dateFMT){
	try{
		if(dateFMT == 'dd/mm/yyyy'){
			var date1val=$$(dateStr.split('~')[0]);//passed to be bigger
			var date2val=$$(dateStr.split('~')[1]);//passed to be smaller
			if(date1val == '' || date2val =='')return;
			var newDate1Obj=getDateObject(dateStr.split('~')[0],dateFMT)
			var newDate2Obj=getDateObject(dateStr.split('~')[1],dateFMT)
			if(newDate1Obj < newDate2Obj){
				return true;
			}else{
				return false;
			}
		}
		return false;
	}catch(err){
       alert('err in Common.js.checkBiggerDate() '+err.description);
 	}
}


function getDateObject(fieldId,dateFMT){
	try{
		if(dateFMT == 'dd/mm/yyyy'){
			var dateval=$$(fieldId);
			if(dateval == '' )return;
			var newdateval=dateval.split('/')[1]+'/'+dateval.split('/')[0]+'/'+dateval.split('/')[2]
			return new Date(newdateval)							
		}
	}catch(err){
       alert('err in Common.js.getDateObject() '+err.description);
	}
}


function setDefaultValueAll(fieldIdStr,defVal){
	try{
			var fieldIdArr = fieldIdStr.split('~');
			for(var i=0;i<fieldIdArr.length;i++ ){
				$(fieldIdArr[i]).value=defVal;
			}
	}catch(err){
       alert('err in Common.js.setDefaultValueAll() '+err.description);
	}
}

//new functions added 
function CheckNumericOnBlr(p_id,p_defaultVal){
	try{
		if(isNaN(new Number( $$(p_id) ) ) ){
			alert('Please Enter Numeric Value !')			
			$(p_id).focus();			
			if(p_defaultVal != null &&  p_defaultVal != ''){
				$(p_id).value =p_defaultVal;
				return false;			
			}
		}else{
			if(p_defaultVal != null &&  p_defaultVal != ''){
				$(p_id).value =p_defaultVal;
				return true;
			}
				return true;
		}
	}catch(err){
			alert(' err in  Common.js.CheckNumericOnBlr() '+err.description)
		}
}

function isHidden(p_fieldId){
	try{
		if($(p_fieldId).style.display == 'none'){
			return true;
		}else{
			return false;
		}
	}catch(err){
		alert(' err in  Common.js.CheckNumericOnBlr() '+err.description)
	}
}

function fromToDateValidate(fromDate,toDate){
		fromDay   = fromDate.substring(0, fromDate.indexOf("/"));
		fromMonth = fromDate.substring (fromDate.indexOf ("/")+1, fromDate.lastIndexOf ("/"));
		fromYear  = fromDate.substring (fromDate.lastIndexOf("/")+1, fromDate.length); 
		
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
			return false	
		}
		else {
			return true
		}
	} 