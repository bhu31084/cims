/*modifyed Date:12-09-2008*/
var bastmanMinutsID = 0;

function Start() {
	//bastmanMinutsID = setTimeout( "upadteBastmanMinuts();Restart();", 100000);
	bastmanMinutsID = setTimeout( "upadteBastmanMinuts();Restart();", 60000);
}

function Restart() {
   Start();
}

function Stop() {
   if(bastmanMinutsID) {
      clearTimeout(bastmanMinutsID);
      bastmanMinutsID = 0;
      bastmantableId = 0;
   }
}

function initBastmanMinuts() {
	bastmenObj.setmatchtimerflag("start");
	Start();
}

function convertdatetime(dtstr){
	var myDate = new Date ( dtstr.split(' ')[0].split('/')[2],
			  dtstr.split(' ')[0].split('/')[1]-1,
			  dtstr.split(' ')[0].split('/')[0],
			  dtstr.split(' ')[1].split(':')[0],
			  dtstr.split(' ')[1].split(':')[1],
			  00 );
	return myDate;
}
function convertdatetimewithslash(dtstr){
	var datearr = dtstr.split("-");
	var timearr = datearr[2].split(" ");
	var date = timearr[0] +"/"+datearr[1]+"/"+datearr[0] + " "+timearr[1];
	return date;
}
function convertdatetimewithdash(dtstr){
	var datearr = dtstr.split("/");
	var timearr = datearr[2].split(" ");
	if(parseInt(datearr[1]) < 10){
		datearr[1] = "0" + datearr[1];
	}
	var date = timearr[0] +"-"+datearr[1]+"-"+datearr[0] + " "+timearr[1];
	return date;
}
function validatedate(txtdate,txtpreviousdate) {
	var currDate;
	currDate = new Date();
	currDate.setSeconds(0);
	var textboxDate;
	var textprevboxDate;
	var txtprevformatdate;
	var ind=txtdate.indexOf("/")
	if(ind != -1){
		textboxDate = convertdatetime(txtdate)
		if(((textboxDate - currDate)/(1000*60)) > 0){
				alert ("Date and time cannot be more than current date and time");
		        return false;
		}else{
				return true;
		}
	}
	else {
		ind=txtdate.indexOf("-")
		if(ind != -1){
			textboxDate = convertdatetimewithslash(txtdate)	 
			textboxDate = convertdatetime(textboxDate);
			if(((textboxDate - currDate)/(1000*60)) > 0){
			        alert ("Date and time cannot be more than current date and time");
			        return false;
			}else{
				return true;
			}
		}
	}
	if(txtdate != ''){
		 textboxDate = convertdatetime(txtdate);
		 var prevind = txtpreviousdate.indexOf("-")
		 if(prevind!=-1) {
			 textprevboxDate = convertdatetimewithslash(txtpreviousdate)
			 txtprevformatdate = convertdatetime(textprevboxDate);
			 if(((txtprevformatdate - textboxDate)/(1000*60)) > 0){
		        alert ("Ball time can not be lesser than previous ball time");
		        return false;
			 }
		 }
	 }
}	

function validatewithcurdate(txtdate,txtpreviousdate) {
	var currDate;
	currDate = new Date();
	currDate.setSeconds(0);
	var textboxDate;
	var textprevboxDate;
	var txtprevformatdate;
	var ind=txtdate.indexOf("/")
	if(ind != -1){
		textboxDate = convertdatetime(txtdate)
		if(((textboxDate - currDate)/(1000*60)) > 0){
				alert ("Date and time cannot be more than current date and time");
		        return false;
		}else{
				return true;
		}
	}
	else {
		ind=txtdate.indexOf("-")
		if(ind != -1){
			textboxDate = convertdatetimewithslash(txtdate)	 
			textboxDate = convertdatetime(textboxDate);
			if(((textboxDate - currDate)/(1000*60)) > 0){
			        alert ("Date and time cannot be more than current date and time");
			        return false;
			}else{
				return true;
			}
		}
	}
	
}	

function validateStartEndDate(inTime,innStartTime,innEndTime,outTime,maxBallTime){
	validatewithpreviousdate(inTime,innStartTime,3)
	validatewithpreviousdate(innEndTime,outTime,3)
	validatewithpreviousdate(maxBallTime,inTime,4)
	validatewithpreviousdate(maxBallTime,outTime,5)
}

function validatewithpreviousdate(txtdate1,txtpreviousdate1,flag) {
	if(txtdate1.indexOf("/")!=-1){
	 var txtdate = convertdatetimewithdash(txtdate1)
	}else{
	 var txtdate = txtdate1
	}	
	if(txtpreviousdate1.indexOf("/")!=-1){
	  var txtpreviousdate = convertdatetimewithdash(txtpreviousdate1)
	}else{
	  var txtpreviousdate = txtpreviousdate1	
	}
	var textboxDate;
	var textprevboxDate;

		if(txtdate != ''){
			 var currentind = txtdate.indexOf("-")
			 var prevind = txtpreviousdate.indexOf("-")
			 if(prevind!=-1 && currentind!=-1 ) {
				 textprevboxDate = convertdatetimewithslash(txtpreviousdate)
				 textboxDate = convertdatetimewithslash(txtdate);
				 textboxDate = convertdatetime(textboxDate);
				 textprevboxDate = convertdatetime(textprevboxDate);
				 if(((textprevboxDate - textboxDate)/(1000*60)) > 0){
				 	if(flag == 1){
				 		alert ("End time can not be less then start time");
				 	}else if(flag == 2){
			        	 alert ("Out time can not be less then in time");
			        }else if(flag == 3){
			        	 alert ("Start time can not be less then innings start time");
			        }else if(flag == 4){
			        	 alert ("In time can not be greater then max ball time");
			        }else if(flag == 5){
			        	 alert ("Out time can not be greater then max ball time");
			        }
			        return false;
				 }else{
				   return true;
				 }
			 }else if(currentind!=-1 && prevind==-1){
			 	textboxDate = convertdatetimewithslash(txtdate);
			 	textprevboxDate = convertdatetime(txtpreviousdate);
			 	textboxDate = convertdatetime(textboxDate);
			 	if(((textprevboxDate  - textboxDate)/(1000*60)) > 0){
			 	if(flag == 1){
				 		alert ("Start time can not be greater then end time");
				 	}else if(flag == 2){
			        	 alert ("In time can not be greater then out time");
			        }else if(flag == 3){
			        	 alert ("End time can not be greater then innings end time");
			        }else if(flag == 4){
			        	 alert ("Start time can not be greater then max ball time");
			        }
			       
			        return false;
				 }else{
				   return true;
				 }
			 }else if(currentind==-1 && prevind==-1){
			 	return true;
			 	/*textboxDate = convertdatetimewithslash(txtdate);
			 	textprevboxDate = convertdatetimewithslash(txtpreviousdate)
			 	textprevboxDate = convertdatetime(txtpreviousdate);
			 	textboxDate = convertdatetime(textboxDate);
			 	if(((textboxDate - textprevboxDate)/(1000*60)) > 0){
			        alert ("In Time can not be greater then Out time..");
			        return false;
				 }else{
				   return true;
				 }*/
			 }
		 }
}
