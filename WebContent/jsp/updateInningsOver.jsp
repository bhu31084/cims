<!--
Page Name 	 : updateRow.jsp
Created By 	 : Dipti Shinde.
Created Date : 21-Oct-2008
Description  : To update individual ball
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 21-Oct-2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="java.util.*"%>

<html>
    <head>
        <title>Match Overs</title>
        <link href="../css/csms.css" rel="stylesheet" type="text/css">
        <script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>
        <script language="JavaScript" src="../js/ajax.js" type="text/javascript"></script>
        <script language="JavaScript" src="../js/popup.js" type="text/javascript"></script>
        <script language="JavaScript" src="../js/common.js" type="text/javascript"></script>
        <script language="JavaScript" src="../js/timer.js" type="text/javascript"></script>
        <script language="JavaScript" src="../js/datetimepicker.js" type="text/javascript"></script>
        <script language="JavaScript" src="../js/Calender.js" type="text/javascript"></script>
        
        <script language="javascript">
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
            
           function updateScore(overNumber){
           try{
               showPopup('BackgroundOverDiv', 'selectedOverBallsDiv' );
               sendUpdateOver(overNumber)
            }catch(err){
               alert(err.description + "updateScore");
            }	
           }
           
           function sendUpdateOver(overNumber){
            try {
                xmlHttp = this.GetXmlHttpObject();
                if (xmlHttp == null) {
                    alert("Browser does not support HTTP Request");
                    return;
                }else{
                var selectedInnId = document.getElementById('hdInningsid').value;
                var url = "/cims/jsp/updateInningEachOver.jsp?overNumber="+overNumber+"&selectedInnId="+selectedInnId;
              //  xmlHttp.onreadystatechange = receiveUpdateOver
                xmlHttp.open("post", url, false);
                xmlHttp.send(null);
                if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	     		   	try {
	                 var responseResult = xmlHttp.responseText ;
	                 $('selectedOverBallsDiv').innerHTML = responseResult
	                 //document.getElementById('selectedOverBallsDiv').scrollIntoView(true);	
	                } catch(err) {
	                 alert(err.description + 'reciveUpdateOver()');
	    	        }
	           }
               }
            } catch(err) {
             alert(err.description + 'sendUpdateOver()');
            }
          }
		  function closePopup(backgroundDiv,popUp){
		    try{
		        document.getElementById(backgroundDiv).style.display = "none";
		        document.getElementById(popUp).style.display = "none";
		    }catch(err) {
		    alert(err.description + 'reciveUpdateOver()');
	 	    }
		  }

		  function sendSwapBatsman(ballId){
		    var swap = "1"
		    var ballNo = ""
		    var runs = ""
		    var wideball = ""
		    var noball = ""
		    var legbyes ="" 
		    var byes = ""
		    var wicket = ""
		    var overno = ""
    		try { 
        	  xmlHttp = this.GetXmlHttpObject();
        	  if (xmlHttp == null) {
            	alert("Browser does not support HTTP Request");
            	return;
        	  }else{
		        var url = "/cims/jsp/updateScore.jsp?ballNo="+ballNo+"&ballId="+ballId+"&runs="+runs+"&wideball="+wideball+
		        "&noball="+noball+"&legbyes="+legbyes+"&byes="+byes+
		        "&wicket="+wicket+"&swap="+swap+"&overno="+overno;
		      //  xmlHttp.onreadystatechange = this.reciveSwapBatsman;
		        xmlHttp.open("post", url, false);
		        xmlHttp.send(null);
		        if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
     			   try {
            		var responseResult = xmlHttp.responseText ;
		           }catch(err) {
           			alert(err.description + 'reciveDataSwapBataman()');
    			   }
    		    }
    		 }
		   } catch(err) {
				alert(err.description + 'sendDataSwapBatsman()');
		   }
		}
		
		function updateInterval(){
    	 try { 
        	xmlHttp = this.GetXmlHttpObject();
        	if (xmlHttp == null) {
           	  alert("Browser does not support HTTP Request");
              return;
        	}else{
	          var url = "/cims/jsp/modifyInningInterval.jsp";
	  //        xmlHttp.onreadystatechange = this.reciveUpdateInterval;
	          xmlHttp.open("post", url, false);
	          xmlHttp.send(null);
	          if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
			      try {
	        	    var responseResult = xmlHttp.responseText ;
	            	document.getElementById('updateIntervalDiv').innerHTML = responseResult;
	            	showPopup('BackgroundDiv', 'updateIntervalDiv');  
	        	 }catch(err){
	        	    alert(err.description + 'reciveUpdateInterval()');
	    		 }
	         }
          }
         }catch(err) {
          alert(err.description + 'updateInterval()');
         }
      }  

	  function updateWicketBallTime(){
    	try { 
        xmlHttp = this.GetXmlHttpObject();
        if (xmlHttp == null) {
            alert("Browser does not support HTTP Request");
            return;
        }else{
	        var url = "/cims/jsp/updateInningWicketBallTime.jsp";
//	        xmlHttp.onreadystatechange = this.reciveupdateWicketBallTime;
	        xmlHttp.open("post", url, false);
	        xmlHttp.send(null);
	        if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
 	          try {
                var responseResult = xmlHttp.responseText ;
                document.getElementById('updateWicketBallTimeDiv').innerHTML = responseResult;
                showPopup('BackgroundOverDiv', 'updateWicketBallTimeDiv');  
              }catch(err){
                alert(err.description + 'reciveupdateWicketBallTime()');
              }
            }
    	}
		} catch(err) {
			alert(err.description + 'updateWicketBallTime()');
		}
	  }

	  function updateBall(ballid){//ballid is '' for swap batsmen of checked checkboxes 
	    try{
	        var ballIdsArr = document.forms[0].chkBallId
	        if(ballid == ""){
	            var ballId = ""
	            for (i=0;i<ballIdsArr.length;i++){
	                if (ballIdsArr[i].checked){
	                    ballId = ballId + ballIdsArr[i].value + "~";
	                }
	            }
	            if(ballId == ""){
	                alert("Please check balls for which you want to swap batsmen.")
	            }
	            sendSwapBatsman(ballId);//for checked balls
	        }else{	// for swapping all batsmen in over
	         sendSwapBatsman(ballid);//for all balls
	        } 	
	    }catch(err) {
	      alert(err.description + 'updateBall()');
	    }
	  }

	  function sendDataUpdateOverRuns(ballNo,ballid,runs,wideball,noball,legbyes,byes,wicket,overno,date,batsman,bowler,bowlerid){
    	try {
        xmlHttp = this.GetXmlHttpObject();
        if (xmlHttp == null) {
            alert("Browser does not support HTTP Request");
            return;
        }else{
	        var url = "/cims/jsp/updateOverScore.jsp?ballNo="+ballNo+"&ballId="+ballid+"&runs="+runs+"&wideball="+wideball+
	        "&noball="+noball+"&legbyes="+legbyes+"&byes="+byes+"&wicket="+wicket+
	        "&overno="+overno+"&date="+date+"&batsman="+batsman+"&bowler="+bowler+
	        "&bowlerid="+bowlerid;
	  //      xmlHttp.onreadystatechange = reciveDataUpdateOverRuns;
	        xmlHttp.open("post", url, false);
	        xmlHttp.send(null);
	        if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
 		     try {
            	var responseResult = xmlHttp.responseText ;
           		document.getElementById('updateRunsDiv').innerHTML = responseResult
            	//document.getElementById('updateRunsDiv').scrollIntoView(true);	
        	}catch(err){
        		alert(err.description + 'reciveDataUpdateOverRuns()');
    		}
		   }
    	}
		} catch(err) {
			alert(err.description + 'sendDataUpdateOverRuns()');
		}
	  }


//  ------------  
	 function deleteRecord(ballid){
       try { 
        xmlHttp = this.GetXmlHttpObject();
        if (xmlHttp == null) {
            alert("Browser does not support HTTP Request");
            return;
        }else{
           var url = "/cims/jsp/deleteOverBall.jsp?ballId="+ballid;
        }
    	//xmlHttp.onreadystatechange = reciveDeleteRecord;
   		xmlHttp.open("post", url, false);
	    xmlHttp.send(null);
	    if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
        try {
            var responseResult = xmlHttp.responseText ;
        }catch(err) {
        	alert(err.description + 'reciveDeleteRecord()');
    	}
		}
	   } catch(err) {
		  alert(err.description + 'ajex.js.deleteRecord()');
	   }
	}

//------------------  
	function sendDataUpdateWicket(ballid,batsman,overno){
	    var runType = ""
	    var wideBallType = ""
	    var noBallType = ""
	    var legByesType = ""
	    var byesType = ""
	    var flag = "2"
	    var date = ""
	    try { 
	        xmlHttp = this.GetXmlHttpObject();
	        if (xmlHttp == null) {
	            alert("Browser does not support HTTP Request");
	            return;
	        }else{
	        var url = "/cims/jsp/updateOverRow.jsp?ballId="+ballid+"&runType="+runType+"&wideBallType="+wideBallType+
	        "&noBallType="+noBallType+"&legByesType="+legByesType+"&byesType="+byesType+
	        "&date="+date+"&flag="+flag+"&batsman="+batsman+"&over="+overno;
	    }
//	    xmlHttp.onreadystatechange = reciveDataUpdateWicket;
	    
	    xmlHttp.open("post", url, false);
	    xmlHttp.send(null);
	    if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
        try {
            var responseResult = xmlHttp.responseText ;
            $('updateWicketDiv').innerHTML = responseResult
        }catch(err) {
        	alert(err.description + 'ajex.js.reciveDataUpdateWicket()');
    	}
		}
	  }catch(err) {
		alert(err.description + 'ajex.js.sendDataUpdateWicket()');
	  }
	}

	function swap(id){
	try { 
	    xmlHttp = this.GetXmlHttpObject();
	    if (xmlHttp == null) {
	        alert("Browser does not support HTTP Request");
	        return;
	    }else{
	        var inning_id = document.getElementById("hdInningsid").value;
	        var url = "/cims/jsp/admin/swappalyer.jsp?id="+id+"&inningId="+inning_id;
	    }
	//    xmlHttp.onreadystatechange = reciveswap;
	
	    xmlHttp.open("post", url, false);
	    xmlHttp.send(null);
        if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
        try {
            var responseResult = xmlHttp.responseText ;
            $('swappalyer').innerHTML = responseResult
            showPopup('BackgroundOverDiv', 'swappalyer' );
        }catch(err) {
	        alert(err.description + 'ajex.js.reciveswap()');
    	}
		}
	} catch(err) {
	    alert(err.description + 'ajex.js.swap()');
	    }    
	}    

	function exit(){
	    closePopup('BackgroundOverDiv', 'swappalyer' );
	}    

 	function AddPlayer(id,spflag){
 		var confirmMesg = confirm("Do you want to swap player1 by player2")
 		if (confirmMesg == true) {
	       try {
	            xmlHttp = this.GetXmlHttpObject();
	            if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	            }else{
	               var player1 = document.getElementById("cmbteamplayer0").value;
	               var player2 = document.getElementById("cmbteamplayer1").value;
	               var url = "/cims/jsp/admin/EditTeams.jsp?id="+id+"&player1="+player1+"&player2="+player2+"&flag=4&spflag="+spflag;
	               // xmlHttp.onreadystatechange = receivePlayer
	                xmlHttp.open("post", url, false);
	                xmlHttp.send(null); 
	                if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	         	      try {
	                     var responseResult = xmlHttp.responseText ;
	                     alert("Swap successful.Kindly check the same.")
			          }catch(err) {
	        	        alert(err.description + 'receiveTeamNames()');
	            	  }
	        		}  
	            }
			} catch(err) {
		    	alert(err.description + 'AddPlayer()');
			}
			
		}
   	 }    

	function updateOverRuns(ballNo,ballid,runs,wideball,noball,legbyes,byes,wicket,overno,date,batsman,bowler,bowlerid){
	    try{
	        showPopup('BackgroundOverDiv', 'updateRunsDiv' );
	        sendDataUpdateOverRuns(ballNo,ballid,runs,wideball,noball,legbyes,byes,wicket,overno,date,batsman,bowler,bowlerid);
	        if(wicket == "Y"){
	            showPopup('BackgroundOverDiv', 'updateWicketDiv' );
	            sendDataUpdateWicket(ballid,batsman,overno);
	        }else if(wicket == "N"){
	        closePopup('BackgroundOverDiv','updateWicketDiv');
	    }
		}catch(err) {
			alert(err.description + 'ajex.js.updateOverRuns()');
		}
	}  

	function sendDataUpdateRow(ballid,runType,wideBallType,noBallType,legByesType,byesType,date,over,bowlerid){
    var flag = "1"
    var batsman=""
    try { 
        xmlHttp = this.GetXmlHttpObject();
        if (xmlHttp == null) {
            alert("Browser does not support HTTP Request");
            return;
        }else{
        //----------------------------------------------		        
        var url = "/cims/jsp/updateOverRow.jsp?ballId="+ballid+"&runType="+runType+"&wideBallType="+wideBallType+
        "&noBallType="+noBallType+"&legByesType="+legByesType+"&byesType="+byesType+
        "&date="+date+"&flag="+flag+"&batsman="+batsman+"&over="+over+"&bowlerid="+bowlerid;
    	}
    	//xmlHttp.onreadystatechange = reciveDataUpdateRow;
        xmlHttp.open("post", url, false);
	    xmlHttp.send(null);
        if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
        try {
            var responseResult = xmlHttp.responseText ;
        }catch(err) {
            alert(err.description + 'ajex.js.reciveDataUpdateRow()');
        }
        }
	} catch(err) {
		alert(err.description + 'ajex.js.sendDataUpdateRow()');
	}
	}
	function convertdatetime(dtstr){
	    try{ 
	        var myDate = new Date ( dtstr.split(' ')[0].split('/')[2],
	            dtstr.split(' ')[0].split('/')[1]-1,
	            dtstr.split(' ')[0].split('/')[0],
	            dtstr.split(' ')[1].split(':')[0],
	            dtstr.split(' ')[1].split(':')[1],
	            00 );
	        return myDate;
	    }catch(err) {
	    alert(err.description + 'ajex.js.convertdatetime()');
	}		
	}

	function updateRow(ballid){
	    try{
	        var ballId = ballid
	        var runType = ""
	        var wideBallType = ""
	        var noBallType = ""
	        var legByesType = ""
	        var byesType = ""
	        var run = document.getElementById('ballRun').value
	        var wideBall = document.getElementById('ballWideBall').value
	        var noBall = document.getElementById('ballNoBall').value
	        var legbyes = document.getElementById('ballLegByes').value
	        var byes = document.getElementById('ballByes').value
	        var date = document.getElementById('txtballdate').value
	        var bowlerid = document.getElementById('selBowler').value
	        var over = document.getElementById('hdOverNumber').value
	        
	        if(run == '0'){
	            runType = "1"
	        }else if(run == '1'){
	        runType = "2"
		    }else if(run == '2'){
		    runType = "3"
			}else if(run == '3'){
			runType = "4"
			}else if(run == '4'){
			runType = "26"
			}else if(run == '5'){
			runType = "6"
			}else if(run == '6'){
			runType = "27"
			}else if(run == '7'){
			runType = "8"
			}else if(run == '8'){
			runType = "9"
			}else if(run == '9'){
			runType = "10"
			}else if(run == '4B'){
			runType = "5"
			}else if(run == '6B'){
			runType = "7"
			}
	
			if(wideBall != '0'&& document.getElementById('ballWideBall').disabled == false){
			    wideBallType = "12"
			}
			if(noBall != '0'&& document.getElementById('ballNoBall').disabled == false){
			    noBallType = "13"
			}
			if(legbyes != 'N' && document.getElementById('ballLegByes').disabled == false){
			    legByesType = '15'
			}
			if(byes != 'N' && document.getElementById('ballByes').disabled == false){
			    byesType = '14'
			}
			//------------------------------
			var currDate;
			currDate = new Date();
			currDate.setSeconds(0);
			var ind=date.indexOf("/")
			if(ind != -1){
			    var textboxDate = convertdatetime(date)	 
			    if(((textboxDate - currDate)/(1000*60)) > 0){
			        
			        alert ("Date and time cannot be more than current date and time");
			        return false
			    } 
			} 
			var formattedDate = callFun.addSecdate(date)	
			showPopup('BackgroundOverDiv', 'updateRunsDiv' );
			sendDataUpdateRow(ballid,runType,wideBallType,noBallType,legByesType,byesType,formattedDate,over,bowlerid);
		}catch(err){
			alert(err.description + 'updateRow()');
		}	
	  }

	  function changeBall(flag,ballid,batsman,overno){
   	 	try{
        if(flag == 'wide'){
            var wideBall = document.getElementById('ballWideBall').value
            if(wideBall == "0"){
               document.getElementById('ballNoBall').disabled = false
            }else{
               document.getElementById('ballNoBall').disabled = true
        	}
    	}else if(flag == 'noball'){
    		var noBall = document.getElementById('ballNoBall').value
	    	if(noBall == "0"){
		        document.getElementById('ballWideBall').disabled = false
    		}else{
			    document.getElementById('ballWideBall').disabled = true
			}
	    }else if(flag == 'legbyes'){
			var legByes = document.getElementById('ballLegByes').value
			if(legByes == "N"){
			    document.getElementById('ballByes').disabled = false
			}else if(legByes == "Y"){
				document.getElementById('ballByes').disabled = true
			}
		}else if(flag == 'byes'){
			var byes = document.getElementById('ballByes').value
			if(byes == "N"){
			    document.getElementById('ballLegByes').disabled = false
			}else if(byes == "Y"){
				document.getElementById('ballLegByes').disabled = true
			}
		}

		if(flag == 'wicket'){
		    var wicket = document.getElementById('ballWickets').value
		    if(wicket == "Y"){
		        showPopup('BackgroundOverDiv', 'updateWicketDiv' );
		        sendDataUpdateWicket(ballid,batsman,overno);
		    }else if(wicket == "N"){
		    	closePopup('BackgroundOverDiv','updateWicketDiv')			
			}
		}
		}catch(err){
			alert(err.description + 'changeBall()');
		}	
	}

	function sendDataUpdateWicketDetail(ballid,wicketType,fielder1,fielder2,striker){
	    try { 
	        xmlHttp = this.GetXmlHttpObject();
	        if (xmlHttp == null) {
	            alert("Browser does not support HTTP Request");
	            return;
	        }else{
	        var url = "/cims/jsp/updateOverWicket.jsp?ballId="+ballid+"&wicketType="+wicketType+"&fielder1="+fielder1+
	        "&fielder2="+fielder2+"&striker="+striker;
	    }
	   // xmlHttp.onreadystatechange = reciveDataUpdateWicketDetail;
	    
	    xmlHttp.open("post", url, false);
	    xmlHttp.send(null);
	    if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
        try {
            var responseResult = xmlHttp.responseText ;
        }catch(err) {
 	       alert(err.description + 'reciveDataUpdateWicketDetail()');
    	}
		}
		} catch(err) {
			alert(err.description + 'sendDataUpdateWicketDetail()');
		}
	}

	function updateWicket(ballid){
	    try{	
	        var wicketType = document.getElementById('selWicketType').value
	        var fielder1 = document.getElementById('selFielder1').value
	        var fielder2 = document.getElementById('selFielder2').value
	        var Striker = document.getElementById('selBatsman').value
	        sendDataUpdateWicketDetail(ballid,wicketType,fielder1,fielder2,Striker);
	    }catch(err){
	    	alert(err.description + 'updateWicket()');
		}	
	} 

	function previousPage(){
	    try{
	        var matchid = document.getElementById('hdMatchid').value  
	        document.frmupdateInningsOver.action="/cims/jsp/updateMatchInnings.jsp?matchId="+matchid;
	        document.frmupdateInningsOver.submit();
	    }catch(err){
	   		alert(err.description + 'previousPage()');
		}	
	}  

	function  addBallOpenDiv(overno,inningno){
	    try{
	        
	        showPopup('BackgroundOverDiv', 'addBallDiv' );
	        sendDataAddBall(overno,inningno);
	        
	    }catch(err) {
	    	alert(err.description + 'ajex.js.addBallOpenDiv()');
		}
	
	}

	function sendDataAddBall(overno,inningno){
	    try {
	        xmlHttp = this.GetXmlHttpObject();
	        if (xmlHttp == null) {
	            alert("Browser does not support HTTP Request");
	            return;
	        }else{
	        var url = "/cims/jsp/AddNewBall.jsp?overno="+overno+"&inningno="+inningno;
	      //  xmlHttp.onreadystatechange = reciveDataAddBall;
	        xmlHttp.open("post", url, false);
	        xmlHttp.send(null);
	        if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
 		     try {
        	    var responseResult = xmlHttp.responseText ;
            	$('addBallDiv').innerHTML = responseResult
	        }catch(err) {
    		    alert(err.description + 'ajex.js.reciveDataAddBall()');
		    }
			}
	    	}
		} catch(err) {
			alert(err.description + 'sendDataAddBall()');
		}
	
	}
	
	function addBall(overno,inningid){
	    var runType = ""
	    var wideBallType = ""
	    var noBallType = ""
	    var legByesType = ""
	    var byesType = ""
	    
	    var bowler = document.getElementById('selBowler').value
	    var striker =document.getElementById('selStriker').value
	    var nonstriker = document.getElementById('selNonstriker').value
	    var starttime = document.getElementById('txtballdate').value
	    var ballRun = document.getElementById('ballRun').value
	    var ballWideBall = document.getElementById('ballWideBall').value
	    var ballNoBall = document.getElementById('ballNoBall').value
	    var ballLegByes = document.getElementById('ballLegByes').value
	    var ballByes = document.getElementById('ballByes').value
	    var currDate;
	    currDate = new Date();
	    currDate.setSeconds(0);
	    var ind=starttime.indexOf("/")
	    if(ind != -1){
	        var textboxDate = convertdatetime(starttime)	 
	        if(((textboxDate - currDate)/(1000*60)) > 0){
	            alert ("Date and time cannot be more than current date and time");
	            return false
	        } 
	    } 
    
   		var formattedDate = callFun.addSecdate(starttime) 
    
    	if(ballRun == '0'){
        runType = "1"
    	}else if(ballRun == '1'){
    	runType = "2"
		}else if(ballRun == '2'){
		runType = "3"
		}else if(ballRun == '3'){
		runType = "4"
		}else if(ballRun == '4'){
		runType = "26"
		}else if(ballRun == '5'){
		runType = "6"
		}else if(ballRun == '6'){
		runType = "27"
		}else if(ballRun == '7'){
		runType = "8"
		}else if(ballRun == '8'){
		runType = "9"
		}else if(ballRun == '9'){
		runType = "10"
		}else if(ballRun == '4B'){
		runType = "5"
		}else if(ballRun == '6B'){
		runType = "7"
		}

		if(ballWideBall != '0'&& document.getElementById('ballWideBall').disabled == false){
		    wideBallType = "12"
		}
		if(ballNoBall != '0'&& document.getElementById('ballNoBall').disabled == false){
		    noBallType = "13"
		}
		if(ballLegByes != 'N' && document.getElementById('ballLegByes').disabled == false){
		    legByesType = '15'
		}
		if(ballByes != 'N' && document.getElementById('ballByes').disabled == false){
		    byesType = '14'
		}

		var widenoball =""
		if(wideBallType == '' && noBallType == ''){
		    widenoball = "0"	
		}else if(wideBallType == '' && noBallType != ''){
		widenoball = noBallType
		}else if(noBallType == '' && wideBallType != ''){
		widenoball = wideBallType
		}
//alert("widenoball:"+widenoball)
		var byesLegbyes =""
		if(legByesType == '15' && byesType == '14'){
		    alert("Legbyes and Byes can't be at same time.")
		    byesLegbyes = "0"
		    return false
		}


		if(legByesType == '' && byesType == ''){
		    byesLegbyes = "0"	
		}else if(legByesType == '' && byesType != ''){
		byesLegbyes = byesType
		}else if(byesType == '' && legByesType != ''){
		byesLegbyes = legByesType
		}
//alert("byesLegbyes:"+byesLegbyes)
		
		if(starttime == ''){
		    alert("Please select start time.")
		    return false
		}

		if(striker == nonstriker){
		    alert("Striker and Nonstriker can't be same player")
		    return false
		}else{
		try {
		    xmlHttp = this.GetXmlHttpObject();
		    if (xmlHttp == null) {
		        alert("Browser does not support HTTP Request");
		        return;
		    }else{
		    var url = "/cims/jsp/AddNewOverBall.jsp?overno="+overno+"&bowler="+bowler+"&inningid="+inningid
		    +"&striker="+striker+"&nonstriker="+nonstriker+"&starttime="+formattedDate
		    +"&ballRun="+ballRun+"&runType="+runType+"&widenoball="+widenoball
		    +"&byesLegbyes="+byesLegbyes;
		    xmlHttp.open("post", url, false);
		    xmlHttp.send(null);
		    if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
 	          try {
            	var responseResult = xmlHttp.responseText ;
	          }catch(err) {
		        alert(err.description + 'ajex.js.reciveDataAddOverBall()');
    		  }
			}
			}
		 }catch(err) {
			alert(err.description + 'addBall()');
		 }
		}   	 
	 }
	function updateInningTime(id){
	    try { 
	        xmlHttp = this.GetXmlHttpObject();
	        if (xmlHttp == null) {
	            alert("Browser does not support HTTP Request");
	            return;
	        }else{
		        var url = "/cims/jsp/updateInningsTime.jsp";
	//	        xmlHttp.onreadystatechange = this.reciveupdateInningTime;
		        xmlHttp.open("post", url, false);
		        xmlHttp.send(null);
 	            if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
		        try {
        	      var responseResult = xmlHttp.responseText ;
            	  document.getElementById('updateInningsTimeDiv').innerHTML = responseResult;
            	  showPopup('BackgroundOverDiv', 'updateInningsTimeDiv');  
        		}catch(err){
			       alert(err.description + 'reciveupdateInningTime()');
			    }
				}
	    	}
		} catch(err) {
			alert(err.description + 'updateInningTime()');
		}
	}

//+++++++++++++++++++++++
	function addInterval(){
		var intervalId = document.getElementById("selInterval").value
	    var inningId = document.getElementById("hdInningsid").value
	    var startTime = document.getElementById("txtStartTime").value
	    var endTime = document.getElementById("txtEndTime").value
	    var flag="1"
	    if(intervalId != 0){
	        if(startTime != "" && endTime != ""){
	            try { 
	                xmlHttp = this.GetXmlHttpObject();
	                if (xmlHttp == null) {
	                    alert("Browser does not support HTTP Request");
	                    return;
	                }else{
		                var url = "/cims/jsp/AddInterval.jsp?intervalId="+intervalId+"&startTime="+startTime+"&endTime="+endTime+"&inningId="+inningId+"&flag="+flag;
		//                xmlHttp.onreadystatechange = this.reciveAddInterval;
		                xmlHttp.open("post", url, false);
		                xmlHttp.send(null);
		                if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
     				      try {
				              var responseResult = xmlHttp.responseText ;
				          }catch(err){
					         alert(err.description + 'reciveAddInterval()');
						   }
						}
	           		}
		          }catch(err) {
		        	alert(err.description + 'addInterval()');
		    	  }
			  }else{
				alert("Please enter start and end time.")
				return false;
			  } 	
		 }else{
			alert("Please select interval type.")
			return false;
		 }
	  }

	function intervalDelete(intervalId,startTime,endTime,inningId){
		var flag="2"
	    try { 
    	    xmlHttp = this.GetXmlHttpObject();
        	if (xmlHttp == null) {
            	alert("Browser does not support HTTP Request");
            return;
        	}else{
	        var url = "/cims/jsp/AddInterval.jsp?intervalId="+intervalId+"&startTime="+startTime+"&endTime="+endTime+"&inningId="+inningId+"&flag="+flag;
	       // xmlHttp.onreadystatechange = this.reciveDeleteInterval;
	        xmlHttp.open("post", url, false);
	        xmlHttp.send(null);
            if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	          try {
    	        var responseResult = xmlHttp.responseText ;
              }catch(err){
        		alert(err.description + 'reciveDeleteInterval()');
    	      }
		    }
   		   }
		} catch	(err) {
			alert(err.description + 'intervalDelete()');
		}
	 }
//+++++++++++++++++++++++

	function updatePenalty(){
	    try { 
	        xmlHttp = this.GetXmlHttpObject();
	        if (xmlHttp == null) {
	            alert("Browser does not support HTTP Request");
	            return;
	        }else{
	        	var url = "/cims/jsp/UpdatePenalty.jsp";
	       // xmlHttp.onreadystatechange = this.reciveupdatePenalty;
	        	xmlHttp.open("post", url, false);
	        	xmlHttp.send(null);
        	   if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
		        try {
        	      var responseResult = xmlHttp.responseText ;
            	  document.getElementById('updatePenaltyDiv').innerHTML = responseResult;
            	  showPopup('BackgroundOverDiv', 'updatePenaltyDiv');  
                }catch(err){
                  alert(err.description + 'reciveupdatePenalty()');
                }
              }
	      }
	  } catch(err) {
		alert(err.description + 'updatePenalty()');
	  }
	}

	function addPenalty(){
	    var penaltyId = document.getElementById("selPenalty").value
	    var inningId = document.getElementById("hdInningsid").value
	    var penaltydate = document.getElementById("txtPenaltyTime").value
	    var flag="1"
	    if(penaltyId != 0){
	        if(penaltydate != ""){
	            try { 
	                xmlHttp = this.GetXmlHttpObject();
	                if (xmlHttp == null) {
	                    alert("Browser does not support HTTP Request");
	                    return;
	                }else{
	                var url = "/cims/jsp/AddPenalty.jsp?penaltyId="+penaltyId+"&penaltydate="+penaltydate+"&inningId="+inningId+"&flag="+flag;
	     //           xmlHttp.onreadystatechange = this.reciveAddPenalty;
	                xmlHttp.open("post", url, false);
	                xmlHttp.send(null);
                    if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
				        try {
	            			var responseResult = xmlHttp.responseText ;
				        }catch(err){
					        alert(err.description + 'reciveAddPenalty()');
					    }
					}
	            	}
	        	} catch(err) {
	        		alert(err.description + 'updateInningTime()');
	    		}
		   }else{
				alert("Please enter date and time.")
			return false;
		   } 	
	    }else{
		   alert("Please select penalty type.")
		   return false;
		}
	}

	function penaltyDelete(penaltyId,date,inningId){
	    var flag="2"
	    try { 
	        xmlHttp = this.GetXmlHttpObject();
	        if (xmlHttp == null) {
	            alert("Browser does not support HTTP Request");
	            return;
	        }else{
		        var url = "/cims/jsp/AddPenalty.jsp?penaltyId="+penaltyId+"&date="+date+"&inningId="+inningId+"&flag="+flag;
		        //xmlHttp.onreadystatechange = this.reciveDeletePenalty;
		        xmlHttp.open("post", url, false);
		        xmlHttp.send(null);
		        if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	        		try {
		             var responseResult = xmlHttp.responseText ;
	    	        }catch(err){
	        		 alert(err.description + 'reciveDeletePenalty()');
	    			}
				  }
	   		}
		} catch(err) {
			alert(err.description + 'penaltyDelete()');
		}
	}

	/*Added by Archana	*/
	function matchAnalysis(){ 		
	    try { 
	        window.open("/cims/jsp/MatchAnalysis.jsp","CIMS","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=100,left=100,width=880,height=500");
	    } catch(err) {
		    alert(err.description + 'matchAnalysis()');
		}
	}

	</script>
        
    </head>
    <%		String matchId = "";
            String inningId = request.getParameter("inningsId");//from previous page
            System.out.println("**********inningId" + inningId);
            String inningNumber = request.getParameter("inningNumber");//from previous page

            matchId = (String) session.getAttribute("matchId1");
            System.out.println("**********matchId" + matchId);
            String role = (String) session.getAttribute("role");

            if (role != null && role.equals("9")) {
                System.out.println("ADMIN");
            } else {
                System.out.println("NOT ADMIN");
            }

            if (inningId != null) {
                session.setAttribute("InningId", inningId);
                session.setAttribute("matchId", matchId);
            }
            //session.setAttribute("matchId",matchId);
            System.out.println("**********matchId" + matchId);

            CachedRowSet oversCrs = null;
            GenerateStoreProcedure spGenerate = new GenerateStoreProcedure(matchId);
            Vector spParam = new Vector();
            LogWriter log = new LogWriter();

            try {
                spParam.add(inningId);
                oversCrs = spGenerate.GenerateStoreProcedure("esp_dsp_getOvers", spParam, "ScoreDB");
            } catch (Exception e) {
                e.printStackTrace();
                log.writeErrLog(page.getClass(), matchId, e.toString());
            }
    %>
    <body>
        <jsp:include page="MenuScorer.jsp"></jsp:include> 
        <br>
        <br>
        <form name="frmupdateInningsOver" id="frmupdateInningsOver">
            <div  id="BackgroundOverDiv" class="backgrounddiv">
            </div>
            <div  id="BackgroundDiv" class="backgrounddiv"> <!-- Added by bhushan : Show Edit interval div from scoring pannel and edit option-->
            </div>
            <table width="95%">
                <tr>
                    <td  align="left">
                        <input type="button" value="Back" onclick="previousPage()">
                    </td>
                </tr>	
                <tr>
                    <td>&nbsp;</td>
                </tr>
                
            </table>
            
            <table align="center" border="1" width="95%">
                <tr class="tenoverupdateball">
                    <th align="center" height="70%" colspan="10"><b>Match Number : <%=matchId%>  (Innings Number : <%=inningNumber%>)</b></th>
                </tr>
                <%		if (oversCrs != null) {
                int overcount = 0;
                while (oversCrs.next()) {
                    int overNumber = oversCrs.getInt("over_num");
                    if (overcount == 0) {
                %>
                <tr class="contentLastDark">
                    <%
                    }
                    %>				
                    <td align="center"><a href="javascript:updateScore('<%=overNumber%>')">over : <%=(overNumber + 1)%></a></td>
                    <%
                    overcount++;

                    if (overcount == 10) {
                        overcount = 0;
                    %>
                </tr>
                <%

                    }
                }
            }
                %>			<tr>
                    &nbsp;
                </tr>
                <tr>
                    <td align="center" colspan="10"><a href="javascript:updateInterval()"><font style="color:blue;size: 14px" >Interval</font></a></td>
                </tr>
                <tr>
                    <td align="center" colspan="10"><a href="javascript:updateWicketBallTime()"><font style="color:blue;size: 14px" >Wicket</font></a></td>
                </tr>
                <tr>
                    <td align="center" colspan="10"><a href="javascript:updateInningTime('<%=inningId%>')"><font style="color:blue;size: 14px" >Inning time</font></a></td>
                </tr>
                <tr>
                    <td align="center" colspan="10"><a href="javascript:matchAnalysis()"><font style="color:blue;size: 14px" >Match Analysis</font></a></td>
                </tr>
                <tr>
                    <td align="center" colspan="10"><a href="javascript:updatePenalty()"><font style="color:blue;size: 14px" >Penalty</font></a></td>
                </tr>
                <tr>
                    <td align="center" colspan="10"><a href="javascript:swap('1')"><font style="color:blue;size: 14px" >Swap Batsman</font></a></td>
                </tr> 
                <tr>
                    <td align="center" colspan="10"><a href="javascript:swap('2')"><font style="color:blue;size: 14px" >Swap Bowler</font></a></td>
                </tr> 
            </table>
            <br>
            
            <div id="selectedOverBallsDiv" class="divupdateover" style='position: absolute;overflow:auto;'>
            </div>
            <div id="updateRunsDiv"   class="divupdateruns" style='position: absolute;' onmouseover = "callFun.setdivid('updateRunsDiv')">
            </div>
            <div id="addBallDiv"   class="divaddball" style='position: absolute;' onmouseover = "callFun.setdivid('updateRunsDiv')">
            </div>
            <div id="updateWicketDiv"   class="divupdatewicket" style='position: absolute;' onmouseover = "callFun.setdivid('updateWicketDiv')">
            </div>	
            <div id="updateIntervalDiv"  class="divupdateInterval" onmouseover = "callFun.setdivid('updateIntervalDiv')">
            </div>
            <div id="updatePenaltyDiv"  class="divupdatePenalty" style='position: absolute;' onmouseover = "callFun.setdivid('updatePenaltyDiv')">
            </div>
            <div id="updateWicketBallTimeDiv"  class="divupdateWicketBallTime" style='position: absolute;overflow:auto;' onmouseover = "callFun.setdivid('updateWicketBallTimeDiv')">
            </div>
            <div id="updateInningsTimeDiv"  class="divinningsTime" style='position: absolute;overflow:auto;' onmouseover = "callFun.setdivid('updateInningsTimeDiv')">
            </div>
            <div id="swappalyer"  class="swapbatsman" style='position: absolute;overflow:auto;' onmouseover = "callFun.setdivid('swappalyer')">
            </div>
            <input type="hidden" id="hdInningsid" name="hdInningsid" value="<%=inningId%>">
            <input type="hidden" id="hdMatchid" name="hdMatchid" value="<%=matchId%>">
            
        </form>
    </body>
</html>




