/*modifyed Date:12-09-2008*/
var ajexObj = new ajex();
// Create obj of Ajex Class
function ajex() { // declear Ajex class
    try {
        var databasemap = new Object();
        var ballflag = false; // this flag is use to decied ball entry ajex function call
        this.GetXmlHttpObject = function() {
            var xmlHttp = null;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            }
            catch (e)
            {
                // Internet Explorer
                try
                {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                }
                catch (e)
                {
                    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
            }
            return xmlHttp;
        }

        //----------------------------------------------------------------------        
        this.sendData = function(urlType,id) { //id is use for database insertion which is come for main.jsp 
            try {
            	var inning_id = $$('inningId');
            	var currentdate = null;
            	var date = null;
            	 ballflag = false;
                if(urlType!="database" && urlType!="penalty" && urlType!="inning" && urlType!="startinning" && urlType!="inningcounter" && urlType!="setmaxover"){
                    showPopup( "BackgroundDiv", "PopupDiv");
                }
                xmlHttp = this.GetXmlHttpObject();

                if (xmlHttp == null) {
                    alert("Browser does not support HTTP Request");
                    return;
                }
                else {
                	 var onlineflag = callFun.getonlineflag();
                	/*Start logic for check online entry or offline entry*/
                    
                    if(onlineflag!="online"){
                    	currentdate = document.getElementById("txtofflinedate").value
                        date = callFun.addSecdate(LRtrim(currentdate));
                       // date = currentdate;
	                }
    	            if(urlType=="penalty"){
    	            	var url = "interval.jsp?id="+ id +"&flag=5&onlineflag="+onlineflag + "&offlinedate="+date;
    	            } 	
                    if (urlType == "interval") {
                    	var intervalRemark = $$('txtremark'); 
                    	var intervalRemark = "default"; 
                    	var intervalType = callFun.getIntervalType(); 
                        var url = "interval.jsp?intervaltype=" +intervalType + "&id=" + id + "&remark=" + intervalRemark +"&flag=1&onlineflag="+onlineflag + "&offlinedate="+date;
                    }else if(urlType=="statusinterval"){
                    	var intervalRemark = $$('txtremark'); 
                    	document.getElementById("txtremark").value="";
                    	var intervalType = callFun.getIntervalType(); 
                        var url = "interval.jsp?intervaltype=" +intervalType + "&id=" + id + "&remark=" + intervalRemark +"&flag=4&onlineflag="+onlineflag + "&offlinedate="+date;
                    }
                    else if(urlType == "endinterval"){
                    	var intervalRemark = $$('txtremark');
                    	document.getElementById("txtremark").value="";
                    	var intervalType = callFun.getIntervalType();
                    	var url = "interval.jsp?intervaltype=" +intervalType + "&id=" + id + "&remark=" + intervalRemark  + "&flag=2&onlineflag="+onlineflag + "&offlinedate="+date;
                    }else if(urlType=="setmaxover"){
                    	var maxover = $('txtmaxremark').value;
                    	var totaltarget =$('txttarget').value;
                    	var matchid = $$('hdmatchid');
                    	var url = "interval.jsp?over=" + maxover  + "&flag=3&matchid=" + matchid+"&totaltarget="+totaltarget+"&onlineflag="+onlineflag + "&offlinedate="+date;
                    	$('txttarget').innerHTML="0";
                    }
                    else if (urlType == "stumped") { // For Stumped
                        var url = "out.jsp?Id="+id+"&WicketId=1&InningId="+inning_id;
                    }else if (urlType == "caught") {
                        var url = "out.jsp?Id="+id+"&WicketId=2&InningId="+inning_id;
                    }else if(urlType=="caughtbybowler"){
                    	var url = "out.jsp?Id="+id+"&WicketId=16&InningId="+inning_id;
                    }else if(urlType=="caughtbywkt"){
                    	var url = "out.jsp?Id="+id+"&WicketId=17&InningId="+inning_id;
                    }
                    else if (urlType == "Retires" || urlType == "retireout" || urlType == "absentout"  || urlType == "handleball" || urlType == "runout" || urlType == "WideHTBOTF" || urlType == "NoHTBOTF" || urlType=="NoHTB" || urlType == "noballrunout" || urlType =="timeout" 
                    			|| urlType=="WideHTB" || urlType=="byesrunout" || urlType=="legbyesrunout" ||urlType =="widerunout" || urlType=="handletheball" ||
                    			urlType=="noballbyesrunout" || urlType=="noballlegbyesrunout") {
                        var urlArr = new Array();
                        urlArr = bastmenObj.strikernonStriker();
                        strikerPlayerId = urlArr[0];
                        strikerPlayerName = urlArr[1];
                        nonStrikerPlayerId = urlArr[2];
                        nonStrikerPlayerName = urlArr[3];
                        if(urlType == "Retires" ){//For Retires 
                        	var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=10&InningId="+inning_id;
                        	//End retires                  
                       	}else if (urlType == "retireout") {
                            var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=4&InningId="+inning_id;
                        }else if (urlType == "absentout") {
                            var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=18&InningId="+inning_id;
                        }else if(urlType=="handletheball"){
                        	var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=15&InningId="+inning_id; 
                        }else if (urlType == "handleball") {
                            var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=5&InningId="+inning_id;
                        } else if (urlType == "runout") {
                            var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=3&InningId="+inning_id;
                        }else if (urlType == "WideHTBOTF") {
                            var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=7&InningId="+inning_id;
                            // Wide + Handled The Ball + Obstructiing the Field
                        }else if(urlType =="WideHTB"){
                            var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=13&InningId="+inning_id;
                        }else if(urlType=="NoHTB"){
                        	 var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=14&InningId="+inning_id;
                        }else if (urlType == "NoHTBOTF") {
                            var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=8&InningId="+inning_id;
                            // No Ball + Handled The Ball + Obstructiing the Field
                        }else if (urlType == "noballrunout") {
                            var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=9&InningId="+inning_id;
                            // No Ball + Run Out
                        }else if (urlType == "noballbyesrunout") {
                            var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=30&InningId="+inning_id;
                            // No Ball + Run Out
                        }else if (urlType == "noballlegbyesrunout") {
                            var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=31&InningId="+inning_id;
                            // No Ball + Run Out
                        }else if(urlType=="timeout"){
                        	 var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=11&InningId="+inning_id;
                        }else if(urlType=="widerunout"){
                        	var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=12&InningId="+inning_id;
                        }else if(urlType=="byesrunout"){
                        	var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=13&InningId="+inning_id;
                        }else if(urlType=="legbyesrunout"){
                        	var url = "out.jsp?strikerPlayerId=" + strikerPlayerId + "&nonStrikerPlayerId=" + nonStrikerPlayerId + "&strikerPlayerName=" + strikerPlayerName + "&nonStrikerPlayerName=" + nonStrikerPlayerName + "&Id="+id+"&WicketId=14&InningId="+inning_id;
                        }	
                        
                    }else if (urlType == "widestumped") {
                        var url = "out.jsp?Id="+id+"&WicketId=6&InningId="+inning_id;
                    } else if(urlType=="database"){
                    	databasemap = callFun.passMap();
                        var bowler= databasemap.blower;
                        var strikerbowler= ballObj.bowlerSetStriker();
                	 	 if(bowler!=strikerbowler){
                	 	 	alert("check bowler Name ");
                	 	 }
                        ballflag = true;
                        var url = "database.jsp?&flag="+ databasemap.flag + "&inning_id=" + databasemap.inning_id  +"&striker="+databasemap.striker +"&non_striker="+databasemap.non_striker+"&blower="+databasemap.blower+"&pitch_pos="+databasemap.pitch_pos+"&ground_pos="+databasemap.ground_pos+"&bowlstyle="+databasemap.bowlstyle+"&over_num="+databasemap.over_num+"&over_wkt="+databasemap.over_wkt+"&penalty="+databasemap.penalty+"&new_ball="+databasemap.new_ball+"&description="+databasemap.description+"&runtype="+databasemap.runtype+"&dismissalType="+databasemap.dismissalType+"&dismissalBatsman="+databasemap.dismissalBatsman+"&dismissalBy1="+databasemap.dismissalBy1+"&dismissalBy2="+databasemap.dismissalBy2 +"&extratype="+databasemap.extratype+"&extrarun="+databasemap.extrarun+"&canreturn="+databasemap.canreturn+"&onlineflag="+onlineflag + "&offlinedate="+date;
                     }else if(urlType == "updateOvr"){
	                    	var url = "updateOver.jsp?inning_id="+inning_id;
	                }else if(urlType=="inning"){
	                	databasemap = callFun.passMap();
	                	var url = "updateInning.jsp?&flag=1&inning_id=" + inning_id; // 1 for update end time
	                }else if(urlType=="startinning"){
	                	databasemap = callFun.passMap();
	                	var url = "updateInning.jsp?&flag=2&inning_id=" + inning_id; // 2 for update start time
	                }else if(urlType=="inningcounter"){
		                var url = "updateInning.jsp?&flag=3&inning_id=" + inning_id; // 3 for update over counter
	                } 
					//xmlHttp.onreadystatechange = this.reciveData;
                    xmlHttp.open("post", "/cims/jsp/"+url, false);
                    xmlHttp.send(null);
            		
                    if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                	try {
                	  if( xmlHttp.status == 200 && xmlHttp.statusText == "OK" ){
                	 	 var responseResult = LRtrim(xmlHttp.responseText);
                	 	 document.getElementById('PopupDiv').innerHTML = responseResult;
	                     if(ballflag){
		                     if (responseResult!="ballinsertsuccess"){
		                     	alert("Error in database. to resloved this issue refreshing your page");
		                     	showPopup('BackgroundDiv','pbar');
		                     	document.getElementById("main").action = "/cims/jsp/scorer.jsp";
								document.getElementById("main").submit();
		                     }
	                    } 
	                  }else{
	                  	alert("Some Error Occure from netwrok side.to resloved this issue refreshing your page");
	               	  	showPopup('BackgroundDiv','pbar');
	               	  	document.getElementById("main").action = "/cims/jsp/scorer.jsp";
						document.getElementById("main").submit();
	                  }   
                	} catch(err) {
                    	alert(err.description + 'ajex.js.sendData()');
           			}
           		    }	
                }
            } catch(err) {
                alert(err.description + 'ajex.js.showExtras');
            }
        }

        //----------------------------------------------------------------------
        
         //--dipti--
 		this.sendDataLastTenOvr = function(urlType,pageNumber,lastTenOverFlag) {
       	  try { 
       		xmlHttp = this.GetXmlHttpObject();
       		if(xmlHttp == null) {
	          alert("Browser does not support HTTP Request");
	          return;
	        }else{
	          var url = "/cims/jsp/lasttenovers.jsp?pageNumber="+pageNumber+"&lastTenOverFlag="+lastTenOverFlag;//pageNumber 0 for lasttenover & 1,2,..so on for paging
	    	  //xmlHttp.onreadystatechange = this.reciveDataLastTenOvr;
			  xmlHttp.open("post", url, false);
	   		  xmlHttp.send(null);
	   		  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                try {
                   var responseResult = xmlHttp.responseText ;
				   document.getElementById('hidOvers').value = responseResult
                } catch(err) {
                    alert(err.description + 'ajex.js.reciveDataLastTenOvr()');
                }
              }
	   		}
	   	  }catch(err) {
            alert(err.description + 'ajex.js.sendDataLastTenOvr()');
          }	
        }
        
        this.sendDataUpdateOver = function(urlType,overnumber) { //for pop up
         try{
           var tooltipflag = "0"
       	   xmlHttp = this.GetXmlHttpObject();
       	   if(xmlHttp == null) {
	          alert("Browser does not support HTTP Request");
	          return;
	       }else{
	          var url = "/cims/jsp/updateOver.jsp?overNumber="+overnumber+"&tooltipflag="+tooltipflag;
	         // xmlHttp.onreadystatechange = this.reciveDataUpdateOver;
			  xmlHttp.open("post", url, false);
	   		  xmlHttp.send(null);
	   		  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
           	  try {
              	var responseResult = xmlHttp.responseText ;
	            $('selectedOverBallsDiv').innerHTML = responseResult
           	  }catch(err) {
    	        alert(err.description + 'ajex.js.reciveupdateover()');
           	  }
        	  }
	   		}
	   	 }catch(err) {
           alert(err.description + 'ajex.js.sendDataUpdateOver()');
         }
        }	
        
        this.sendDataToolTip = function(urlType,overnumber) { //for tool tip
	       	try{ 	
	       	  var tooltipflag = "1"
	       	  xmlHttp = this.GetXmlHttpObject();
	       		if (xmlHttp == null) {
		           alert("Browser does not support HTTP Request");
		           return;
		        }else{
		        	var url = "/cims/jsp/updateOver.jsp?overNumber="+overnumber+"&tooltipflag="+tooltipflag;
		    	 	//xmlHttp.onreadystatechange = this.reciveDataToolTip;
				    xmlHttp.open("post", url, false);
		   			xmlHttp.send(null);
		   			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	                  try {
	                    var responseResult = xmlHttp.responseText ;
	                    document.getElementById('hidToolTip').value = responseResult
	                  }catch(err) {
	                    alert(err.description + 'ajex.js.reciveDataToolTip()');
	                  }
	                }
		   		 }
		    }catch(err){
	           alert(err.description + 'ajex.js.sendDataToolTip()');
	        }
        }   	
        
        this.sendDataSwapBatsman = function (ballId ,inningId){
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
			  if(xmlHttp == null) {
				alert("Browser does not support HTTP Request");
				return;
			  }else{
				var url = "/cims/jsp/updateScore.jsp?ballNo="+ballNo+"&ballId="+ballId+"&runs="+runs+"&wideball="+wideball+
		        		  "&noball="+noball+"&legbyes="+legbyes+"&byes="+byes+
		        		  "&wicket="+wicket+"&swap="+swap+"&overno="+overno;
				//xmlHttp.onreadystatechange = this.reciveDataSwapBataman;
				xmlHttp.open("post", url, false);
				xmlHttp.send(null);
				if(xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	              try {
	                 var responseResult = xmlHttp.responseText ;
	              }catch(err){
	                 alert(err.description + 'ajex.js.reciveDataSwapBataman()');
	              }
            	}
			  }
			}catch(err) {
		       alert(err.description + 'ajex.js.sendDataSwapBatsman()');
		    }
        }
        
        this.sendDataUpdateOverRuns = function(ballNo,ballid,runs,wideball,noball,legbyes,byes,wicket,overno,date,batsman,bowler,bowlerid){
      	  var swap = "2"
		    try { 
			  var swap = "2"	
	       	  xmlHttp = this.GetXmlHttpObject();
	       	  if(xmlHttp == null) {
		        alert("Browser does not support HTTP Request");
		        return;
		      }else{
		       	var url = "/cims/jsp/updateScore.jsp?ballNo="+ballNo+"&ballId="+ballid+"&runs="+runs+"&wideball="+wideball+
		        		  "&noball="+noball+"&legbyes="+legbyes+"&byes="+byes+
		        		  "&wicket="+wicket+"&swap="+swap+"&overno="+overno+"&date="+date+
		        		  "&batsman="+batsman+"&bowler="+bowler+
	        		  	  "&bowlerid="+bowlerid;
		    	//xmlHttp.onreadystatechange = this.reciveDataUpdateOverRuns;
				xmlHttp.open("post", url, false);
		   		xmlHttp.send(null);
		   		if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	                try {
	                   var responseResult = xmlHttp.responseText ;
	                   $('updateRunsDiv').innerHTML = responseResult
	                }catch(err){
	                   alert(err.description + 'ajex.js.reciveDataUpdateOverRuns()');
	                }
                }
		   	   }
			 }catch(err){
		       alert(err.description + 'ajex.js.sendDataUpdateOverRuns()');
		   	 }
		}
		
		
        this.sendDataUpdateRow = function(ballid,runType,wideBallType,noBallType,legByesType,byesType,date,over,bowlerid){
          var flag = "1"
          var batsman=""
            try { 
			  xmlHttp = this.GetXmlHttpObject();
	       	  if(xmlHttp == null) {
		        alert("Browser does not support HTTP Request");
		        return;
		      }else{
		       	var url = "/cims/jsp/updateRow.jsp?ballId="+ballid+"&runType="+runType+"&wideBallType="+wideBallType+
			       		  "&noBallType="+noBallType+"&legByesType="+legByesType+"&byesType="+byesType+"&date="+date+"&flag="+flag
			       		  +"&batsman="+batsman+"&over="+over+"&bowlerid="+bowlerid;
			  }
		      //xmlHttp.onreadystatechange = this.reciveDataUpdateRow;
		      xmlHttp.open("post", url, false);
		   	  xmlHttp.send(null);
		   	  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                try {
                   var responseResult = xmlHttp.responseText ;
                }catch(err) {
                   alert(err.description + 'ajex.js.reciveDataUpdateRow()');
                }
              }
		   	}catch(err) {
		      alert(err.description + 'ajex.js.sendDataUpdateRow()');
		   	 }
        }
         
        this.sendDataUpdateWicket = function(ballid,batsman,overno){
           var runType = ""
	       var wideBallType = ""
	       var noBallType = ""
	       var legByesType = ""
	       var byesType = ""
	       var flag = "2"
	       var date = ""
	       var bowlerid = ""
	       try{ 
		     xmlHttp = this.GetXmlHttpObject();
	       	 if(xmlHttp == null) {
		        alert("Browser does not support HTTP Request");
		        return;
		     }else{
		        var url = "/cims/jsp/updateRow.jsp?ballId="+ballid+"&runType="+runType+"&wideBallType="+wideBallType+
			      		  "&noBallType="+noBallType+"&legByesType="+legByesType+"&byesType="+byesType+"&date="+date+"&flag="+flag
			      		  +"&batsman="+batsman+"&over="+overno+"&bowlerid="+bowlerid;
			    }
		    	//xmlHttp.onreadystatechange = this.reciveDataUpdateWicket;
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
       
        this.sendDataUpdateWicketDetail = function(ballid,wicketType,fielder1,fielder2,striker){
          try { 
			xmlHttp = this.GetXmlHttpObject();
	       	if(xmlHttp == null) {
		      alert("Browser does not support HTTP Request");
		      return;
		    }else{
		       var url = "/cims/jsp/updateWicket.jsp?ballId="+ballid+"&wicketType="+wicketType+"&fielder1="+fielder1+
			      		  "&fielder2="+fielder2+"&striker="+striker;
			} 
		    xmlHttp.open("post", url, false);
		    xmlHttp.send(null);
		    if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                try {
                   var responseResult = xmlHttp.responseText ;
                }catch(err) {
                   alert(err.description + 'ajex.js.reciveDataUpdateWicketDetail()');
                }
            }
		  }catch(err){
		   	alert(err.description + 'ajex.js.sendDataUpdateWicketDetail()');
		  }
        }
        
        //--dipti--
        this.addnewbatsman = function(type,batsmanid){
          try{ 
            xmlHttp = this.GetXmlHttpObject();
    		if(xmlHttp == null) {
              alert("Browser does not support HTTP Request");
	          return;
	        }else{
              var inning_id = $$('inningId');
	          var striker = batsmanid;
	          var batsmandate = null;
	          var onlineflag = callFun.getonlineflag();
	          if(onlineflag!="online"){
                 currentdate = document.getElementById("txtofflinedate").value
                 batsmandate = callFun.addSecdate(LRtrim(currentdate))
	            // date = currentdate;
	 	      }
	          if(type=="addnewplayer"){
                 var url = "/cims/jsp/database.jsp?&flag=12"+"&inning_id=" + inning_id +"&striker="+striker+"&non_striker=0&blower=0&pitch_pos=0&ground_pos=0&bowlstyle=0&over_num=0&over_wkt=0&penalty=0&new_ball=0&description=0&runtype=0&dismissalType=0&dismissalBatsman=0&dismissalBy1=0&dismissalBy2=0&extratype=0&extrarun=0&canreturn=0&onlineflag="+onlineflag+"&offlinedate="+batsmandate;
	          }
	    	//  xmlHttp.onreadystatechange = this.reciveaddnewbatsman;
		      xmlHttp.open("post", url, false);
	   	      xmlHttp.send(null);
	   	      if(xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                try{
                  if( xmlHttp.status == 200 && xmlHttp.statusText == "OK" ){
                    var responseResult = LRtrim(xmlHttp.responseText);
                	if (responseResult!="ballinsertsuccess"){
                      alert("Error in database. to resloved this issue refreshing your page");
		              showPopup('BackgroundDiv','pbar');
		              document.getElementById("main").action = "/cims/jsp/scorer.jsp"
                      document.getElementById("main").submit();
		            }
	              } 
	              else{
                    alert("Some Error Occure from netwrok side.to resloved this issue refreshing your page");
	                showPopup('BackgroundDiv','pbar');
	                document.getElementById("main").action = "/cims/jsp/scorer.jsp"
			  		document.getElementById("main").submit();
	             } 
 		        }catch(err) {
 		        	alert(err.description + 'ajex.js.addnewbatsman1');
                }
             }
	   	      
	   	    }
	      }catch(err) {
	      	alert("1")
            alert(err.description + 'ajex.js.addnewbatsman');
          }	
        }
        
        // this ajex function for short run
        this.sendShortRun = function(urlType,run) {
       	  try{ 
       		xmlHttp = this.GetXmlHttpObject();
       		if(xmlHttp == null) {
	          alert("Browser does not support HTTP Request");
	          return;
	        }else{
	          var inning_id = $$('inningId');
	          if(urlType=="undo"){
	            var url = "/cims/jsp/database.jsp?&flag=8"+"&inning_id=" + inning_id +"&striker=0&non_striker=0&blower=0&pitch_pos=0&ground_pos=0&bowlstyle=0&over_num=0&over_wkt=0&penalty=0&new_ball=0&description=0&runtype="+run+"&dismissalType=0&dismissalBatsman=0&dismissalBy1=0&dismissalBy2=0&extratype=0&extrarun=0&canreturn=0&onlineflag=0&offlinedate=0";
	          }else if(urlType=="moreundo"){
	            var over = $$('txtundoover');
	            var url = "/cims/jsp/database.jsp?&flag=11"+"&inning_id=" + inning_id +"&striker=0&non_striker=0&blower=0&pitch_pos=0&ground_pos=0&bowlstyle=0&over_num="+over+"&over_wkt=0&penalty=0&new_ball=0&description=0&runtype="+run+"&dismissalType=0&dismissalBatsman=0&dismissalBy1=0&dismissalBy2=0&extratype=0&extrarun=0&canreturn=0&onlineflag=0&offlinedate=0";
	          }else{
		      	var url = "/cims/jsp/database.jsp?&flag=7"+"&inning_id=" + inning_id +"&striker=0&non_striker=0&blower=0&pitch_pos=0&ground_pos=0&bowlstyle=0&over_num=0&over_wkt=0&penalty=0&new_ball=0&description=0&runtype="+run+"&dismissalType=0&dismissalBatsman=0&dismissalBy1=0&dismissalBy2=0&extratype=0&extrarun=0&canreturn=0&onlineflag=0&offlinedate=0";
		      }	
	    	  //xmlHttp.onreadystatechange = this.reciveShortRun;
			  xmlHttp.open("post", url, false);
	   		  xmlHttp.send(null);
	   		  if(xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                try {
                  var responseResult = xmlHttp.responseText ;
	              showPopup('BackgroundDiv','pbar');
	              document.getElementById("main").action = "/cims/jsp/scorer.jsp"
				  document.getElementById("main").submit();
			    }catch(err) {
                  alert(err.description + 'ajex.js.reciveShortRun');
                }
              }
	   		}
	   	  }catch(err){
            alert(err.description + 'ajex.js.reciveShortRun');
          }	
        }
        
        /*ajex code for wagon Wheel*/
        this.sendwagon = function(urlType,bastmanid,flag) {
       	  try { 
       		xmlHttp = this.GetXmlHttpObject();
       		if (xmlHttp == null) {
	           alert("Browser does not support HTTP Request");
	           return;
	         }else{
	          	var inning_id = $$('inningId');
	        	var url = "/cims/jsp/WagonWheel.jsp?flag="+flag+"&inningid=" + inning_id +"&playerid="+bastmanid;
	        	//xmlHttp.onreadystatechange = this.recivewagon;
				xmlHttp.open("post", url, false);
	   			xmlHttp.send(null);
	   			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                  try {
                    var responseResult = xmlHttp.responseText ;
                    // document.getElementById('wagon').innerHTML = responseResult;
                    document.getElementById('wagondiv').innerHTML = responseResult;
                    showPopup( "BackgroundDiv", "wagondiv");
                  }catch(err) {
                    alert(err.description + 'ajex.js.recivewagon');
                  }
                }
	   		 }
	   	   }catch(err) {
              alert(err.description + 'ajex.js.inningid');
           }	
        }
        
        this.sendfallofwicket = function() {
       	  try { 
       		xmlHttp = this.GetXmlHttpObject();
       		if (xmlHttp == null) {
	          alert("Browser does not support HTTP Request");
	          return;
	        }else{
	          var inning_id = document.getElementById('inningId').value;
	          var flag = "1";
	          var url = "/cims/jsp/fallofwicket.jsp?flag="+flag+"&inningid=" + inning_id;
	         // xmlHttp.onreadystatechange = this.fallofwicket;
			  xmlHttp.open("post", url, false);
	   		  xmlHttp.send(null);
	   		  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
          		try {
            	  var responseResult = LRtrim(xmlHttp.responseText);
				  var  subResponseResult =  responseResult.substring(0,((responseResult.length)-1)) 
                  document.getElementById('fallofwicket').innerHTML = subResponseResult;
                }catch(err){
                  alert(err.description + 'ajex.js.fallofwicket');
                }
              }
	   		}
	   	  }catch(err) {
            alert(err.description + 'ajex.js.sendfallofwicket');
          }	
        }
      
        this.sendlastballtime = function() {
       	  try{ 
       		xmlHttp = this.GetXmlHttpObject();
       		if(xmlHttp == null) {
	          alert("Browser does not support HTTP Request");
	          return;
	        }else{
	          var inning_id = document.getElementById('inningId').value;
	          var flag = "2"; // this function is writtn for check last ball time in databse for ofline only.
	          var url = "/cims/jsp/fallofwicket.jsp?flag="+flag+"&inningid=" + inning_id;
	         // xmlHttp.onreadystatechange = this.lastballtime;
			  xmlHttp.open("post", url, false);
	   		  xmlHttp.send(null);
	   		  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
          	    try {
            	  var responseResult = LRtrim(xmlHttp.responseText);
            	  document.getElementById("txtofflinedate").value =  responseResult
            	  document.getElementById("hdofflinedate").value =  responseResult
                }catch(err) {
                  alert(err.description + 'ajex.js.lastballtime');
                }
              }
	   	    }
	   	  }catch(err) {
             alert(err.description + 'ajex.js.sendlastballtime');
          }	
        }
        
        this.sendEndMatch = function(urlType,matchid){
          try{ 
       	    xmlHttp = this.GetXmlHttpObject();
       		if (xmlHttp == null) {
	          alert("Browser does not support HTTP Request");
	          return;
	        }else{
	          if(urlType=="drwamatch"){
	            var url = "/cims/jsp/MatchEnd.jsp?matchid="+matchid+"&flag=1";
	          }else{ 	
		        var url = "/cims/jsp/MatchEnd.jsp?matchid="+matchid+"&flag=2";
		      }	
	          //xmlHttp.onreadystatechange = this.reciveendmatch;
			  xmlHttp.open("post", url, false);
	   		  xmlHttp.send(null);
	   		  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                try {
                   var responseResult = xmlHttp.responseText ;
                   $('resultspan').innerHTML = responseResult
                } catch(err) {
                    alert(err.description + 'ajex.js.reciveDataLastTenOvr()');
                }
              }
	   	    }
	   	  }catch(err) {
            alert(err.description + 'ajex.js.inningid');
          }	
        }
        
       this.sendupdateIntervalTime = function(intervalid,startdate,enddate,hdstartdate,flag){
         try{ 
       	   xmlHttp = this.GetXmlHttpObject();
       	   if(xmlHttp == null) {
	         alert("Browser does not support HTTP Request");
	         return;
	       }else{
	         var inning_id = $$('inningId');
	         var url = "/cims/jsp/updateintervaltime.jsp?inningid="+inning_id+"&intervalid="+intervalid+"&startdate="+startdate+"&enddate="+enddate+"&hdstartdate="+hdstartdate+"&flag="+flag;
		     //xmlHttp.onreadystatechange = this.reciveendupdateIntervalTime;
			 xmlHttp.open("post", url, false);
	   		 xmlHttp.send(null);
	   		 if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                try {
                   var responseResult = xmlHttp.responseText ;
                } catch(err) {
                    alert(err.description + 'ajex.js.rreciveendupdateIntervalTim');
                }
             }
	   	   }
	   	  }catch(err) {
             alert(err.description + 'ajex.js.sendupdateIntervalTime');
          }	
        }
        
        this.sendupdateBallTime = function(batsmanid,inningid,wicketBallTime,wicketNextBallTime,hidwicketBallTime,hidwicketNextBallTime){
          try{ 
       		xmlHttp = this.GetXmlHttpObject();
       		if(xmlHttp == null) {
	          alert("Browser does not support HTTP Request");
	          return;
	        }else{
	          var inning_id = $$('inningId');
	          var url = "/cims/jsp/updateBallTime.jsp?batsmanid="+batsmanid+"&inningid="+inningid+"&wicketBallTime="+wicketBallTime+
	          			"&wicketNextBallTime="+wicketNextBallTime+"&hidwicketBallTime="+hidwicketBallTime+"&hidwicketNextBallTime="+hidwicketNextBallTime;
		      //xmlHttp.onreadystatechange = this.reciveendupdateBallTime;
			  xmlHttp.open("post", url, false);
	   		  xmlHttp.send(null);
	   		  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                try {
                   var responseResult = xmlHttp.responseText ;
                } catch(err) {
                    alert(err.description + 'ajex.js.reciveendupdateBallTime');
                }
              }
	   		}
	   	  }catch(err) {
             alert(err.description + 'ajex.js.sendupdateBallTime');
           }	
        }
        
       this.sendupdateInningStartTime = function(inningid,inningStartTime,inningEndTime){
         try { 
       	   xmlHttp = this.GetXmlHttpObject();
       	     if (xmlHttp == null) {
	           alert("Browser does not support HTTP Request");
	           return;
	         }else{
	           var url = "/cims/jsp/updateInningStartEndTime.jsp?inningid="+inningid+"&inningStartTime="+inningStartTime+"&inningEndTime="+inningEndTime;
		       //xmlHttp.onreadystatechange = this.reciveupdateInningTime;
			   	xmlHttp.open("post", url, false);
	   			xmlHttp.send(null);
	   			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	                try {
	                   var responseResult = xmlHttp.responseText ;
	                }catch(err) {
	                    alert(err.description + 'ajex.js.reciveupdateInningTime');
	                }
                }
	   		}
	   	  }catch(err) {
            alert(err.description + 'ajex.js.sendupdateInningStartTime');
          }	
        }
       
       //----
       this.sendupdateoverrate = function(flag){
         try { 
       	   xmlHttp = this.GetXmlHttpObject();
       	   if (xmlHttp == null) {
	         alert("Browser does not support HTTP Request");
	         return;
	       }else{
	         var inning_id = $$('inningId');
	         var url = "/cims/jsp/updateoverrate.jsp?inningid="+inning_id+"&flag=1";
		     //xmlHttp.onreadystatechange = this.reciveupdateoverrate;
			 xmlHttp.open("post", url, false);
	   		 xmlHttp.send(null);
	   		 if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
               try{
                 var responseResult = LRtrim(xmlHttp.responseText);
                 document.getElementById("overrate").innerHTML = responseResult;
               }catch(err){
                 alert(err.description + 'ajex.js.rreciveendupdateIntervalTim');
               }
             }
	   	   }
	   	 }catch(err) {
            alert(err.description + 'ajex.js.sendupdateIntervalTime');
         }	
        }
        
        this.sendpatenership = function(strikerId,nonStrikerId,strikerName,nonStrikerName,partershiprun,totalball,matchtime){
          try { 
       		xmlHttp = this.GetXmlHttpObject();
       		if(xmlHttp == null) {
	          alert("Browser does not support HTTP Request");
	          return;
	        }else{
	          var inning_id = $$('inningId');
	          var url = "/cims/jsp/updateoverrate.jsp?inningid="+inning_id+"&flag=2&strikerId="+strikerId+"&nonStrikerId="+nonStrikerId+
	          	  		"&strikerName="+strikerName+"&nonStrikerName=" +nonStrikerName + "&partershiprun=" + partershiprun +
	                	"&totalball="+totalball+"&matchtime="+matchtime;
		       //xmlHttp.onreadystatechange = this.recivepatenership;
			   xmlHttp.open("post", url, false);
	   		   xmlHttp.send(null);
	   		   if(xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	             try{
	                var responseResult = LRtrim(xmlHttp.responseText);
	                document.getElementById('partnershiprun').innerHTML = responseResult;
	             }catch(err){
	               alert(err.description + 'ajex.js.rreciveendupdateIntervalTim');
	             }
               }
	   		}
	   	  }catch(err) {
            alert(err.description + 'ajex.js.sendupdateIntervalTime');
          }	
        }
        
       this.sendEndOver = function(type){
         try { 
       	   xmlHttp = this.GetXmlHttpObject();
       	   if(xmlHttp == null) {
	         alert("Browser does not support HTTP Request");
	         return;
	       }else{
	         var inning_id = $$('inningId');
	         var url = "/cims/jsp/updateoverrate.jsp?inningid="+inning_id+"&type="+type+"&flag=3";
		     //xmlHttp.onreadystatechange = this.reciveEndOver;
			 xmlHttp.open("post", url, false);
	   		 xmlHttp.send(null);
	   		 if(xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
               try{
			     var responseResult = LRtrim(xmlHttp.responseText);
               }catch(err){
                 alert(err.description + 'ajex.js.rreciveendupdateIntervalTim');
               }
             }
	   		}
	   	  }catch(err) {
           alert(err.description + 'ajex.js.sendupdateIntervalTime');
          }	
        }
       
        this.updateInterval = function(){
       	  try{ 
   			xmlHttp = this.GetXmlHttpObject();
          	if(xmlHttp == null) {
   	         alert("Browser does not support HTTP Request");
   	         return;
   	        }else{
   			  var url = "/cims/jsp/modifyInningInterval.jsp";
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
           
   	    this.show = function() {
            document.getElementById("menu").style.display = '';
        }
        this.hide = function () {
            document.getElementById("menu").style.display = 'none';
        }
        
        this.sendServerTime = function(type){
          try{ 
             xmlHttp = this.GetXmlHttpObject();
             if(xmlHttp == null) {
	            alert("Browser does not support HTTP Request");
	           return;
	         }else{
               var url = "/cims/jsp/serverTime.jsp?type="+type;
			   xmlHttp.open("post", url, false);
	   		   xmlHttp.send(null);
	   		   if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                 try {
                   var responseResult = LRtrim(xmlHttp.responseText);
                   document.getElementById("serverTime").innerHTML = responseResult;
                 }catch(err) {
                   alert(err.description + 'ajex.js.reciveServerTime');
                 }
           	   }
             }
	   	  }catch(err) {
             alert(err.description + 'ajex.js.sendServerTime');
          }	
        }
        
    } catch(err) {
     // alert(err.description + 'ajex.js.mainclass()');
    }
    
}
		  
