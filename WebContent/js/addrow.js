/*modifyed Date:12-09-2008*/

function insRow(id) { // this function is use to Append row in batsman table
	try{
		COL_BATT_BOWLER = 4;
        COL_BATT_OUT = 3;
        COL_BATT_NAME = 2;
        COL_BATT_RUN = 5;
        var scorercardstriker = "No1";
        var scorercardnonStriker = "No2";
        var batsmanNameRow;
        var scorerbatsman;   
        selbat ="selbat";
        var retireflag = false;
        var flag=false;
        var currentTime = bastmenObj.time();
        if($$(selbat)==""){
        	alert("Select batsman");
        	//callFun.hideblockmaindiv('BackgroundDiv')
        	return false;	
        }else{
         /*This logic is use to get  id for out batsman*/
        scorerbatsman = scoreObj.getoutcol();
        if(trimAll(scorerbatsman)=="No1"){
	        batsmanNameRow  = "No11";
	    }else{
	      	batsmanNameRow  = "No22";
	    }
	    	 
        var playerArr=$$(selbat).split("~");
      	/*Start for retire */
        for(var i=1;i<12;i++){
            if(playerArr[0]==$(id).rows[i].id && $(id).rows[i].cells[COL_BATT_OUT].innerHTML=="Retires"){
            	var flag  = bastmenObj.getOutFlag();
            	var batruns = $(id).rows[i].cells[COL_BATT_RUN].innerHTML;
            	if(flag==1 ||flag==0){
                    bastmenObj.setstrikernumber(i);
                    changebatsmancss(id);
	            }else if( flag==2){
	            	bastmenObj.setnonstrikernumber(i);
	            	changebatsmancss(id);
	            }
            	if(flag==3){
            		alert($$('selrunoutbatName'))
            	}	
            	
	           scorerbatsman = scoreObj.getoutcol();
	           if(trimAll(scorerbatsman)=="No1"){
	           	batsmanNameRow  = "No11";
	           }else{
	            batsmanNameRow  = "No22";
	           }	 
	           $(batsmanNameRow).innerHTML = $(id).rows[i].cells[COL_BATT_NAME].innerHTML // display new batsman name is scorecare
	           $(scorerbatsman).innerHTML = batruns;
	           $('BATT_TABLE').rows[i].cells[COL_BATT_OUT].innerHTML="";	
	           retireflag = true;           	
            }
        }
        /*End retire */
        if(retireflag==true){
        }else{
        retireflag = false;
        var rowlength = document.getElementById(id).rows.length;
        var rowid;
        
        var wicket_number = parseInt(document.getElementById("Wickt").innerHTML);
        var wicket_number_flag = false;
		var index =  bastmenObj.getNewBatsmanRoWId();
		for(i=1;i < rowlength;i++){ // this for loop is use to delete row 
			if(playerArr[0]==document.getElementById(id).rows[i].id){
				rowid = i;
			}	
		}
		document.getElementById(id).deleteRow(rowid); 
		if(wicket_number==9 && index!=11){ // this logic is used to solved last wicket highligh issue.
			index = 11;
			wicket_number_flag = true;
		}	
		var x=document.getElementById(id).insertRow(index);
		scorerbatsman = scoreObj.getoutcol();
		x.id=playerArr[0];
		//var indexadd = document.getElementById(id).rows(index + 1);
	    	var no = x.insertCell(0);
	    	var intime = x.insertCell(1);
	    //  var outtime = x.insertCell(2);
	        var batsman=x.insertCell(2);
	        var Status=x.insertCell(3);
			var bowler = x.insertCell(4);
			var runs =  x.insertCell(5);
			var balls = x.insertCell(6);
			var minis = x.insertCell(7);
			var four = x.insertCell(8);
			var six = x.insertCell(9);
			var sr = x.insertCell(10);
	
	        no.innerHTML = "";
			intime.onmouseover = function(){
				document.getElementById( 'time_'+ playerArr[0] ).style.display = 'block';
			}
			intime.onmouseout = function(){
				document.getElementById( 'time_'+ playerArr[0] ).style.display = 'none';
			}
	        intime.innerHTML ="<img border='0' width='16px' height='16px' src='../images/Clock.jpg'><BR>" + "<div style='background:#ADADAD;position:absolute;z-index=2;display:none' id='time_"+ playerArr[0] +"' name='time_"+ playerArr[0] +"'><b>In Time:-</b><label id=time"+playerArr[0]+">" + currentTime +"</label></div>";
	        intime.align="center";
	        intime.valign="middle";
	        intime.className="lefttd";
	        batsman.innerHTML=playerArr[1];
	        batsman.id =playerArr[1];
	        batsman.align="left";
	        batsman.className="lefttd";
	        Status.innerHTML="";
			Status.align="left";
			Status.className="lefttd";
			bowler.innerHTML=""; 
			bowler.align="left"
			bowler.className="lefttd";
			runs.innerHTML="0"; 
			runs.align="right"
			balls.innerHTML="0";
			balls.align="right"
			minis.innerHTML="0";
			minis.align="right"
			four.innerHTML="0";
			four.align="right"
			six.innerHTML="0"; 
			six.align="right"
			sr.innerHTML="0.00"; 
			sr.align="right"
	        callFun.rowNumber();
	        $(batsmanNameRow).innerHTML = playerArr[1] // display new batsman name is scorecare
	        flag =false;
       	 }// end else 
       	   closePopup('BackgroundDiv','BatList');
	       cmb.beforeRemoveOptions('selbat'); // this function remove selected item from cmobo box
	       updateBatsmanTableTime();
	       if(wicket_number_flag){
	    	  if(bastmenObj.getstrikerRowId() < bastmenObj.getnonStrikerRowId()){
	    		  bastmenObj.setnonstrikernumber(11);
	    	  }else{
	    		  bastmenObj.setstrikernumber(11);
	    	  }	  
	       } 	   
	       bastmenObj.setbatsmancss();
   		   /*This logic for add retire batsman name in combo box*/
   		   for(i=1;i<index;i++){// this code is write for if any batsman is Retires than we need to add that batsman name in combo box
	      	if(document.getElementById(id).rows[i].cells[COL_BATT_OUT].innerHTML == "Retires"){
					var selbatvalue = document.getElementById(id).rows[i].id +'~' + document.getElementById(id).rows[i].cells[COL_BATT_NAME].innerHTML;
					var setbatname = document.getElementById(id).rows[i].cells[COL_BATT_NAME].innerHTML; 
					cmb.addToCombo(selbatvalue,setbatname,'selbat');
				}
				
			}
   		batsmancss(id); //this funcion is use to change css
   		callFun.setballwicketFlag(false);
		callFun.resetpatenership();
		ajexObj.addnewbatsman("addnewplayer",playerArr[0]);
	  }// end of else
                 
    }catch(err){
		alert(err.description + " addRow.js.insRow")
	}	  
} 
function changebatsmancss(id){
	try{
		var strikecss = bastmenObj.getNewBatsmanRoWId();
	    if($(id).rows[strikecss].rowIndex % 2 ==0){    // change Css When over is Completed
	      $(id).rows[strikecss].className = 'contentDark';
	    }else{
	      $(id).rows[strikecss].className = 'contentLight';
	    }
	}catch(err){
	   //alert(err.description + " addRow.js.changebatsmancss");
	}   
}
function batsmancss(id){
	try{
		for(var i=0;i<12;i++){
			if($(id).rows[i].rowIndex % 2 ==0){    // change Css When over is Completed
	      		$(id).rows[i].className = 'contentDark';
		    }else{
	    		$(id).rows[i].className = 'contentLight';
		    }
	   }
	   bastmenObj.setbatsmancss();
	}catch(err){
	   alert(err.description + " addRow.js.batsmancss");
	} 
	
}

function addRow(id) {
	try{
		//$('btnsubmit').disabled = true;
        COL_BALL_NAME = 1; // this is set for witch column is Bowler Name
        COL_BALL_OVER = 2;
        COL_BALL_MEDDAN = 3;
        COL_BALL_RUN = 4;
        COL_BALL_WKT = 5;
        COL_BALL_WIDE = 6;
        COL_BALL_NOBALL = 7;
        COL_BALL_SR = 8;
        COL_BALL_ECO = 9;
        ballObj.chnagebowlerrowcss();
        var getchangebowler = callFun.getchangebowlerflag();
        var previousstrikerid = ballObj.getPreviousStriker();
        var bowl1 ="";
      	var StrikerId =1;
        var flag=false;
        var bowlerflag = false;
        var wktflag = false; 
        var newBowlerFlag = false ;//  this variable is use to check bowler over Quata is completed or not
        bowl1 = document.getElementById('selBowler').value;
        var arrt1 = bowl1.split("~");		
        var PresentRow = ballObj.Striker();
        if($$('selBowler')==""){
        	alert("Please select bowler");
        	bowlerflag = true;
        	return false;
        }
        if($("BALL_TABLE").rows[PresentRow].id == arrt1[1]){
			alert("You can not select same bowler again");
			bowlerflag = true;
			return false;
		}
		/*if (getchangebowler==true){
			 if($("BALL_TABLE").rows[previousstrikerid].id == arrt1[1]){
				alert("You can not select same bowler again");
				bowlerflag = true;
				return false;
			 }
		}*/
		if(bowlerflag == false){
			if(arrt1[2]=='Y'){	
				 var r = confirm("You are selected wicket keeper as a bowler? Do you Want to Continue..");
        		 if (r == false) {
        		 	wktflag = true;
			     } 	
	  		}
	  		
	  		if(wktflag==false){
		  		var rowlength = document.getElementById(id).rows.length; // Set length of bowler Table
				var tableRow ; // set row number 
				var rowId ; // Set RowId For Bowler Which is Bowled First
				var maxrowflag = false;
				var bowlername;
			    for(i=1;i<rowlength;i++){
					if(arrt1[1] == $("BALL_TABLE").rows[i].id){
						flag=true;
						rowId = i;
					}
				}
				if(flag==false){
				   	var row = callFun.getbowlerId();     // this function is use to identify how many bowler ball so we can set bowlerStriker as a new row
				  	 for(i=1;i<rowlength;i++){
				  	 bowlername = $("BALL_TABLE").rows[i].cells[COL_BALL_NAME].innerHTML; 
				  	 	if(bowlername=="&nbsp;" && maxrowflag==false){
				  	 		maxrowflag = true;
				  	 		row = i;
				  	 	}
				  	 }
				    StrikerId = parseInt(row);
				    ballObj.newStriker(StrikerId);
			        callFun.setbowlerId(StrikerId);  // set new row id , so always we got max row id
			        $("BALL_TABLE").rows[StrikerId].id =arrt1[1] ;
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_NAME].innerHTML =  arrt1[0];
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_MEDDAN].align="right"
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_MEDDAN].innerHTML="0";
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_RUN].align="right"
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_RUN].innerHTML="0";
					$("BALL_TABLE").rows[StrikerId].cells[COL_BALL_WKT].align="right"
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_WKT].innerHTML="0";
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_WIDE].align="right"
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_WIDE].innerHTML="0";
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_NOBALL].align="right"			        
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_NOBALL].innerHTML="0";
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_SR].align="right"	
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_SR].innerHTML="0.00";
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_ECO].align="right"	
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_ECO].innerHTML="0.00";
			        $("BALL_TABLE").rows[StrikerId].cells[COL_BALL_OVER].align="right"
		        
				}
				else{
					StrikerId = rowId;
			        ballObj.newStriker(rowId); // This Logic For Previous Bowler Balled.
				}
				if(isNaN($("BALL_TABLE").rows[StrikerId].cells[COL_BALL_OVER].innerHTML)){
					newBowlerFlag = false;
				}else{
					if($$('hdmatchtype')=="oneday"){ // this flag is use to check match is test or oneday this is use for validation
						var max_over_flag = true;
						var maxoverArr = ($("BALL_TABLE").rows[StrikerId].cells[COL_BALL_OVER].innerHTML).split(".");
						var bowlerrowlength = document.getElementById("BALL_TABLE").rows.length; // Set length of bowler Table
						
					    for(i=1;i<bowlerrowlength;i++){
					    	var bowler_over = $("BALL_TABLE").rows[i].cells[COL_BALL_OVER].innerHTML.split(".");
					    	if(StrikerId!=i){
					    		if(parseInt(bowler_over[0]) >= (parseInt($$('hdoverperbowler')) + 1 )){
					    			max_over_flag = false;
					    		}	
					    	}
							
						}
					    if (max_over_flag==false){
							if(parseInt(maxoverArr[0]) >= parseInt($$('hdoverperbowler'))){
								alert("This bowler's overs quota is completed");
								newBowlerFlag  =false;// modefied by bhushan because user requirement was change
							}
					    }else{
					    	if(parseInt(maxoverArr[0]) >= (parseInt($$('hdoverperbowler')) + 2)){
								alert("This bowler's overs quota is completed");
								newBowlerFlag  =false;// modefied by bhushan because user requirement was change
							}
					    }	
					}	
				}
				if(newBowlerFlag == false){
					callFun.rowNumber();
					closePopup('BackgroundDiv','BowlList')
					ballObj.setbowlercss();
					var previousstrikerid = ballObj.getPreviousStriker();
					var childObj= $('selBowler');
					var childObjArr = childObj.options;
					var splitcmb
					for(var i=0;i<childObjArr.length;i++){ // this logic is for previous bowler selection
						splitcmb = (childObjArr[i].value).split("~");
						if(splitcmb[1] == previousstrikerid){
							 $('selBowler').options[i].selected = true;
						}
					}
				}  		
			}      
	   }		 
	  	// this logoic if over i end and page will be refresh than we increase over counter 
	  	
	 document.getElementById('hdbowlercounter').value = parseInt(document.getElementById('hdbowlercounter').value) + parseInt("1");
    //$('btnsubmit').disabled = false;
    }catch(err){
        alert(err.description + " addRow.js.addRow"  )
    }
}

