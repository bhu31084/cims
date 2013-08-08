var interval = null;
	function callMain(){
		var winhandle = null;
		var bowlerArr = (document.getElementById('selBowler').value).split("~"); // Combo Value
		var bowlerName = bowlerArr[0]; // Set Bowler Name;
		var BowlerId = bowlerArr[1]; // Set Bowler Id;
		var batsman1Arr = (document.getElementById('selBatsMan1').value).split("~"); // Combo Value
		var bat1Name = batsman1Arr[0]; // Set Batsman Name;
		var bat1Id = batsman1Arr[1]; // Set Batsman Id;
	 	
		var batsman2Arr = (document.getElementById('selBatsMan2').value).split("~"); // Combo Value
		var bat2Name = batsman2Arr[0]; // Set Non Batsman Name;
		var bat2Id = batsman2Arr[1]; // Set  Non Batsman Id;
		
		var bat1=  document.getElementById('selBatsMan1').value;
		var bat2 = document.getElementById('selBatsMan2').value;	 	
		
		if(document.getElementById('selBatsMan1').value == ""){
			alert("Please Choose First Striker.")
			return false;
		}else if(document.getElementById('selBatsMan2').value == ""){
			alert("Please Choose Second Striker.")
			return false;
		}else if(document.getElementById('selBatsMan1').value==document.getElementById('selBatsMan2').value){
			alert("Please Choose Different Strikers. Both can not be same");
		 	return false;
		}else if(document.getElementById('selBowler').value == ""){
			alert("Please Choose NonStriker.")
			return false;
		}else{
		var r = confirm("Do you want to select ("+ bat1Name +") as strikerbatsman and (" + bat2Name + ") as nonstriker batsman and ( " + bowlerName +" ) as bowler");
			if (r == true) {
		 		winhandle = window.open("/cims/jsp/scorer.jsp?bowlerName="+bowlerName+"&BowlerId="+BowlerId+" &BatsMan1="+bat1+" &BatsMan2="+bat2,"CIMS","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-20)+",height="+(window.screen.availHeight-30));	
				if (winhandle != null){
					window.opener="";
			        window.close();
    			}
		       }		
		}		 	
	}
	/*modifyed Date:12-09-2008*/
	function showPopup(mainDiv, popup) {
    try {
        var scrolledX, scrolledY;
        if (self.pageYOffset) {
            scrolledX = self.pageXOffset;
            scrolledY = self.pageYOffset;
        } else if (document.documentElement && document.documentElement.scrollTop) {
            scrolledX = document.documentElement.scrollLeft;
            scrolledY = document.documentElement.scrollTop;
        } else if (document.body) {
            scrolledX = document.body.scrollLeft;
            scrolledY = document.body.scrollTop;
        }
        var centerX, centerY;
        if (self.innerHeight) {
            centerX = self.innerWidth;
            centerY = self.innerHeight;
        } else if (document.documentElement && document.documentElement.clientHeight) {
            centerX = document.documentElement.clientWidth;
            centerY = document.documentElement.clientHeight;
        } else if (document.body) {
            centerX = document.body.clientWidth;
            centerY = document.body.clientHeight;
        }
        var backgroundDiv = $(mainDiv);
        backgroundDiv.style.display = "block";
        var popupDiv = $(popup);
        popupDiv.style.left = scrolledX + (centerX - 400) / 2;
    	popupDiv.style.top = scrolledY + (centerY) / 2;
        popupDiv.style.display = "block";
        return true;

    } catch(err) {
        alert(err.description + 'Popup.js.myPopup()');
    }
}
 function closePopup( backgroundDiv, popup ){
	document.getElementById(backgroundDiv).style.display = "none";
    document.getElementById(popup).style.display = "none";
    var linkintervaldiv = document.getElementById("linkintervaldiv").style.display;
    return true;
 }
 
 function callinterval(id){
	var interval = $$(id);
	if($$(id)=='') {
		alert("Please select interval type")
		return false;
	}
	closePopup('BackgroundDiv', 'linkintervaldiv' );
	var intervalArr = interval.split("~");
	Interval(intervalArr[0],intervalArr[1]);
 }
 function Interval(type,id){
 try{
 	if(type=='statusinterval') {
	   sendData('statusinterval',id);
	}else{
		if(type=="ajaxinterval"){
			var r = confirm("You have selected Start Game button. Do you want to continue?");
		}else{
			var r = confirm("You have selected "+ type +" interval option. Do you want to continue?");
		}	
	    if (r == true) {
			if(type=="ajaxinterval"){ // this logic to update end time
				sendData('endinterval',id);
			}else{
				if(type=="End Inning" || type=="Declare"){
				}else{	
					if(type=='statusinterval') {
						sendData('statusinterval',id);
					}else{
						setIntervalType(type);
						sendData('interval',id);
					}	
				}	
			}
		}// end of confirm		
	}// end else	
		}catch(err){
			alert(err.description + "Interval()");
		}	
	}
	function GetXmlHttpObject(){
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
    function sendData(urlType,id){ 
     try {
     	var onlineflag = "online";
     	var date = null;
     	var inning_id = $$('inningId');
		showPopup( "BackgroundDiv", "PopupDiv");
		 xmlHttp = GetXmlHttpObject();
         if (xmlHttp == null) {
            alert("Browser does not support HTTP Request");
            return;
         }
         else {
         	 if (urlType == "interval") {
             	var intervalRemark = $("txtintervalremark").innerHTML;
             	alert(intervalRemark);
                var intervalType = getIntervalType(); 
                var url = "/cims/jsp/interval.jsp?intervaltype=" +intervalType + "&id=" + id + "&remark=" + intervalRemark +"&flag=11&onlineflag="+onlineflag + "&offlinedate="+date;
            }else if(urlType=="statusinterval"){
            	var intervalRemark = "before start match"; 
                var intervalType = getIntervalType(); 
                var url = "/cims/jsp/interval.jsp?intervaltype=" +intervalType + "&id=" + id + "&remark=" + intervalRemark +"&flag=12&onlineflag="+onlineflag + "&offlinedate="+date;
            }
            else if(urlType == "endinterval"){
               var intervalRemark = "before start match"; 
               var intervalType = getIntervalType();
               var url = "/cims/jsp/interval.jsp?intervaltype=" +intervalType + "&id=" + id + "&remark=" + intervalRemark  + "&flag=13&onlineflag="+onlineflag + "&offlinedate="+date;
           }
           
	 }
	 xmlHttp.onreadystatechange = reciveData;
	 xmlHttp.open("post", url, false);
     xmlHttp.send(null);
    }catch(err){
	 alert(err.description + "callFunction.js.Interval()");
    }
  }
  
  function reciveData() {
    if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	    try {
	        if( xmlHttp.status == 200 && xmlHttp.statusText == "OK" ){
	        	var responseResult = xmlHttp.responseText;
	            document.getElementById('PopupDiv').innerHTML = responseResult;
	            
		    }    
	    } catch(err) {
	     //alert(err.description + 'ajex.js.extrasData()');
	    }
    }	
  }
  function getIntervalType(){
		return interval;
  }	
  function setIntervalType(type){
		interval = type;
	}	 				
  function cancelSelection(){		
		document.getElementById('hdback').value = "back";
		//if(document.getElementById('hdmsg').value == "deleted"){
		document.Selection.action = "/cims/jsp/SetSecondInning.jsp"
		document.Selection.submit();	 
		//}
  }
  function checkintervalrefreshstatus(){
		var intervalid = document.getElementById('hdintervalstatusid').value;
		var intervalname = document.getElementById('hdintervalstatusname').value;
		var intervalcount = document.getElementById('hdintervalstatuscount').value;
		if (parseInt(intervalcount)=="1"){
			setIntervalType(intervalname);
			Interval('statusinterval',intervalid);
		}
  }
