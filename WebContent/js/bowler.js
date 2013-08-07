/*modifyed Date:12-09-2008*/
var ballObj = new bowler();
function bowler() {
    try {
        COL_BALL_NUMBER=0;
        COL_BALL_NAME = 1;
        COL_BALL_OVER = 2;
        COL_BALL_MEDDAN = 3;
        COL_BALL_RUN = 4;
        COL_BALL_WKT = 5;
        COL_BALL_WIDE = 6;
        //dipti
        COL_BALL_NOBALL = 7;
        //dipti
        COL_BALL_SR = 8;
        COL_BALL_ECO = 9;
        matchOvers = 50;


        var BALL_MAP = [  {"ID":"1"},
        {"ID":"2"},
        {"ID":"3"},
        {"ID":"4"},
        {"ID":"5"},
        {"ID":"6"},
        {"ID":"7"},
        {"ID":"8"},
        {"ID":"9"},
        {"ID":"10"},
        {"ID":"11"}
                ];
        var ballStriker = null;
        var count = 0;
        // FOr Increse Bowler Over
        var count1 = 0;
        var todaycount1 = 0; 
        // For Score Card Remining Over
        var runFlag = 0;
        // For Check Over Is Median or not
        var swapflag = false;
        // set swapflag id false for checking ball is 1st or not bydefauls it is 1st ball in inning
        var previousovertotal = 0;
        var over=0;
        var todayover=0;
        var overball = 0;
        var todayoverball = 0;
        var remainingover = 0;
        var remainingball = 0;
        var flag = "0";
        var countball=0;
        var previousstrikerbowlerId;
        // These Flag is for check weather striker over is first or not
       
       	this.setballcount = function(){
       		count1 = $$('hdtotalcount');
       		todaycount1 = $$('hdchangetotalcount');
       		//count = $$('hidstrikerbowler');
       		var strikerbowler = $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_OVER].innerHTML;
			var over_no = strikerbowler.split(".");
            	var total_overs = over_no[0];
            	var total_balls = over_no[1];
                //bowler = bowler * 6;
                strikerbowler = parseInt(total_overs) * parseInt(6) + parseInt(total_balls);
                count = strikerbowler
       		
       	}
        this.Striker = function() {
            return ballStriker;
        }
        this.setmaxOver = function(){
        	matchOvers = $$('hdovers');
        }
        this.setstrikerbowler = function(){

         ballStriker = $$('hdbowlerstriker');// ROW NUMBER
         callFun.setbowlerId(ballStriker);
        }
        this.setlastbowlerover = function(){
       
	        var balls =($('BALL_TABLE').rows[ballStriker].cells[COL_BALL_OVER].innerHTML).split(".");
	        var overs = ($('SBOver').innerHTML).split(".");
	        var lastovers;
    	    if(parseInt(balls[1]) >= parseInt(6)){
    	    	lastovers = parseInt(balls[0]) + parseInt(1);
    	    	 $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_OVER].innerHTML = lastovers + ".0";
    	    	 var lastrun = parseInt($$('hdlastrun'));
    	    	  if (lastrun % 2 != 0) { // this logic is use for  swap batsman when over is completed and press refresh button
                    bastmenObj.swapBatsmen();
                     bastmenObj.changeCSS();
                     scoreObj.swapBatsmen();
                     scoreObj.setStrikerCss();
                }
    	    	 showPopup('BackgroundDiv', 'BowlList');
    	    	 
        	} else if(parseInt(overs[1])== 0){
        		 var lastrun = parseInt($$('hdlastrun'));
        		 var allball = parseInt($$('allball'));
    	    	  if (lastrun % 2 != 0) { // this logic is use for  swap batsman when over is completed and press refresh button
                	 bastmenObj.swapBatsmen();
                     bastmenObj.changeCSS();
                     scoreObj.swapBatsmen();
                     scoreObj.setStrikerCss();
                }
                if(allball == 0){//dipti 22 05 2009
        			showPopup('BackgroundDiv', 'BowlList');//if aftr refresh allball is 0 thn only show bowlr seln.
        		}
        	}
        	
        }
        this.setbowlercss = function(){
        	$('BALL_TABLE').rows[ballStriker].className="striker"
        	if($("bowling_right"+$('BALL_TABLE').rows[ballStriker].id).value=="0"){
        		$("pitch_id").src="../images/lh_Pitch.jpg";
        	}else{
        		$("pitch_id").src="../images/rh_Pitch.jpg";
        	}	
        		
        }
        this.bowlerSetStriker = function() {
            var currentballStriker = $('BALL_TABLE').rows[ballStriker].id;
            return currentballStriker;
        }
        this.updateRun = function (run) {
            try {
                if (run != "0") {
                    runFlag = 1 // Set runFlag is 1 For over is not run
                }
                var row = $('BALL_TABLE').rows[ballStriker];
                this.updateCell(row, COL_BALL_RUN, run);
                this.updateOverCell(row, COL_BALL_OVER, '1');
                //
                this.updateEcoCell(row, COL_BALL_ECO);
                this.updateBowlerSRCell(row, COL_BALL_SR);

            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.update()');
            }
        }// end of update
        this.updateByeLegByeRun = function(run){
        	try {
              /*  if (run != "0") {
                    runFlag = 1 // Set runFlag is 1 For over is not run
               }*/
                var row = $('BALL_TABLE').rows[ballStriker];
              this.updateOverCell(row, COL_BALL_OVER, '1');
              this.updateEcoCell(row, COL_BALL_ECO);
               this.updateBowlerSRCell(row, COL_BALL_SR);

            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.update()');
            }
        }
        
        this.forceEndOfOver = function() {
        	var forcedmatchFlag = false;
            var row = $('BALL_TABLE').rows[ballStriker];
            /*this loigc for counter increment*/
             var coun1rem = parseInt(count1)%6
             var todaycount1rem = parseInt(todaycount1) % 6 /*this variable calculate todayes overs*/
             var addcount1 =  parseInt(6) - parseInt(coun1rem) 
             var todayaddcount1 =  parseInt(6) - parseInt(todaycount1rem) 
             count1 = parseInt(count1) + parseInt(addcount1)
             todaycount1 = parseInt(todaycount1) + parseInt(todayaddcount1)
             count = 6;
			 over = parseInt(count1 / 6);
			 todayover = parseInt(todaycount1 / 6);
             overball = parseInt(count1) %6;
             todayoverball = parseInt(todaycount1) %6;
             var overs = parseInt(over) ;
             var todayovers = parseInt(todayover);
             $('SBOver').innerHTML = overs +"."+overball;
             $('hdtodaySBOver').innerHTML = todayovers + "." + todayoverball;
             scoreObj.updateBatsmanTableTotalRun();
             remainingover = parseInt(matchOvers) - parseInt(todayover);
             remainingball = parseInt(6) - parseInt(todayoverball);
             if(remainingball==6){
	             remainingball =0; // this logic is for set 6 th ball is 0th ball for next over
             }
             if(remainingover<=0 && remainingball ==0){
             	$('RemOver').innerHTML = 0+ "." +0;
             	if($$('hdmatchtype')=="oneday"){ // this flag is use to check match is test or oneday this is use for validation
	             	callFun.endInning();
    	         	forcedmatchFlag = true;
    	        }else{
    	        	alert("Day maximum overs are completed");
    	        } 	
             }else{
            	 var remaining_overs = parseInt(remainingover) +"."+parseInt(remainingball);	
            	 if (remaining_overs < 0){
 					$('RemOver').innerHTML = 0
 				 } else {
 					$('RemOver').innerHTML = remaining_overs;
 				 }
            }
            var rovers = parseInt(remainingover)
            var remaining_overs = parseInt(rovers) +"."+parseInt(remainingball);	
       	 	if (parseFloat(remaining_overs) < 0){
				$('RemOver').innerHTML = 0
			 } else {
				$('RemOver').innerHTML = remaining_overs;
			 }
            var data = (row.cells[COL_BALL_OVER].innerHTML).split(".")
            row.cells[COL_BALL_OVER].innerHTML = parseInt(data) + parseInt(1) + ".0";
            var r = confirm("Over is not completed? Do you Want to continue?   ");
            if(forcedmatchFlag==false){
	            if (r == true) {
	            	callFun.chkonlinoffline();
	            	this.setPreviousStriker(row.id)
	                callFun.setchangebowlerflag(false);
	                this.chnagebowlerrowcss();
	                ajexObj.sendData("inningcounter","0");// update over counter
	                showPopup('BackgroundDiv', 'BowlList')
	                if (runFlag == "0") {
	                    if (isNaN(parseInt(row.cells[COL_BALL_MEDDAN].innerHTML))) { // Condition if 1st over is median than we first do inner html is 0
	                        row.cells[COL_BALL_MEDDAN].innerHTML = 0;
	                    }
	                    row.cells[COL_BALL_MEDDAN].innerHTML = parseInt(row.cells[COL_BALL_MEDDAN].innerHTML) + parseInt(1);
	                } else {
	                    if (isNaN(row.cells[COL_BALL_MEDDAN].innerHTML)) {
	                        row.cells[COL_BALL_MEDDAN].innerHTML = 0;
	                    }
	                }
	                runFlag = "0" // Set runFlag is 0 for track next medain over
	                bastmenObj.swapBatsmen();
	                // this for over Completd than batsmen will be change position For Batsman Screen
	
	                bastmenObj.changeCSS();
	                // this is for Striker and non Striker CSS  Login from batsman screen
	            }
	        }    
         }
        this.updateRunOut = function (run) { // This Function For No Ball + Run Out Condition Itself
            try {
                if (run != "0") {
                    runFlag = 1 // Set runFlag is 1 For over is not run
                }
                var row = $('BALL_TABLE').rows[ballStriker];
                this.updateCell(row, COL_BALL_RUN, run);
                this.updateEcoCell(row, COL_BALL_ECO);
                this.updateBowlerSRCell(row, COL_BALL_SR);
                this.setStriker($('BALL_TABLE').rows[ballStriker]);
                
            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.updateRunOut()');
            }
        }// end of update
        
        this.updateByeLegByesRunOut = function (run) { // This Function For No Ball + Run Out Condition Itself
            try {
                var row = $('BALL_TABLE').rows[ballStriker];
                //this.updateCell(row, COL_BALL_RUN, run);
                this.updateEcoCell(row, COL_BALL_ECO);
                this.updateBowlerSRCell(row, COL_BALL_SR);
                this.updateOverCell(row, COL_BALL_OVER, '1');
                this.setStriker($('BALL_TABLE').rows[ballStriker]);
                
            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.updateRunOut()');
            }
        }// end of update
        
        this.updateNoBallByeLegByesRunOut = function (run) { // This Function For No Ball + Run Out Condition Itself
            try {
                var row = $('BALL_TABLE').rows[ballStriker];
                this.updateCell(row, COL_BALL_RUN, (parseInt(run)+ parseInt(1)));
                this.updateEcoCell(row, COL_BALL_ECO);
                this.updateBowlerSRCell(row, COL_BALL_SR);
                this.updateCell(row, COL_BALL_NOBALL,1);
                this.setStriker($('BALL_TABLE').rows[ballStriker]);
                
            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.updateRunOut()');
            }
        }// end of update
        
        //Start	Archana Devloment 26072008
        // bhushan
        this.updateBLB = function() { // For Byes And LegByes Account
            try {

                var row = $('BALL_TABLE').rows[ballStriker];
                this.updateEcoCell(row, COL_BALL_ECO);
                 this.updateBowlerSRCell(row, COL_BALL_SR);
                this.updateOverCell(row, COL_BALL_OVER, '1');
                //
                this.setStriker($('BALL_TABLE').rows[ballStriker]);
            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.updateBLB()');
            }
        }
        this.BowlerName = function() {
            try {
                var row = $('BALL_TABLE').rows[ballStriker];//ballStriker id from front end
                var name = row.cells[COL_BALL_NAME].innerHTML;
                return name;//to use in wicket H.out in batsman score card
            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.BowlerName()');
            }
        }
        //Archana-To update the wicket in ball class
        this.updateWicket = function (flag) {
            try {
                var row = $('BALL_TABLE').rows[ballStriker];
                // Thse Functione Use To Display data in Frount Page
                if (flag != 2 && flag != 3) {//dipti 06 06 2009
                	this.updateOverCell(row, COL_BALL_OVER, '1');
                }
                if (flag == 0) {// flag 0 for if wicket gon and credit goes to bowler
                    this.updateCell(row, COL_BALL_WKT, 1);
                    var wkt = row.cells[COL_BALL_WKT].innerHTML;
                    if(parseInt(wkt) % parseInt(5) == 0){
                    	var bowlerName = row.cells[COL_BALL_NAME].innerHTML
                    	$('bowlerlandmarkwkt').innerHTML = "Congratulations! "+ bowlerName+" &nbsp; Completed " + wkt +"  Wicket ";
	           			showPopup('BackgroundDiv','bowlerlandmark');
                    }
                    
                } else if (flag == 1 || flag == 3){//|| flag == 2) {//dipti 14 05 2009
                //else if (flag == 1){
                    this.updateCell(row, COL_BALL_WKT, 0);
                }else if (flag == 2){//dipti 14 05 2009
                    this.updateCell(row, COL_BALL_WKT, 1);//to pass 1 to update wicket
               	}
            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.updateWicket()');
            }
        }// end of update
        this.updateOverCell = function (row, cell_no, newData) {//to update each row in bowler analysis
        	var matchFlag = false;
        	var checkpanaltyballreduceflag = false;
        	var wicket = $('Wickt').innerHTML;
        	if(isNaN(row.cells[cell_no].innerHTML)){
			}else{
				var totalsovers = row.cells[COL_BALL_OVER].innerHTML.split(".");
				var over = totalsovers[0];
				var balls =  totalsovers[1];
				if(over==0){
					
				}else{
					//count = parseInt(parseInt(over) * parseInt(6)) + parseInt(balls);
					//count1 = this.updateScorerOver();
				}	
			}
        	
			count1 = parseInt(count1) + parseInt(newData);
			todaycount1 = parseInt(todaycount1) + parseInt(newData);
            count = parseInt(count) + parseInt(newData);
            over = parseInt(count1 / 6);
            todayover = parseInt(todaycount1 / 6);
            overball = parseInt(count1) %6;
            todayoverball = parseInt(todaycount1 % 6);
            if(parseInt(overball) < 0){
            	$('SBOver').innerHTML = over +".0";
            }else{	
            	$('SBOver').innerHTML = over +"."+overball;
            }
            $('hdtodaySBOver').innerHTML = todayover + "." + todayoverball;
            scoreObj.updateBatsmanTableTotalRun();
            remainingover = parseInt(matchOvers - 1) - parseInt(todayover);
            remainingball = parseInt(6) - parseInt(todayoverball);
             if(remainingball==6){
	             remainingball =0; // this logic is for set 6 th ball is 0th ball for next over
	             remainingover = parseInt(remainingover) + 1;
             }
             if(remainingover<=0 && remainingball ==0){
             	$('RemOver').innerHTML = 0+ "." +0;
             	if($$('hdmatchtype')=="oneday"){ // this flag is use to check match is test or oneday this is use for validation
             		callFun.endInning();
             		matchFlag = true;
             	}else{
    	        	alert("Day maximum overs are completed");
    	        }	
             }else{
            	 var remaining_overs = parseInt(remainingover) +"."+parseInt(remainingball);
            	 if (parseFloat(remaining_overs) < 0){
 					$('RemOver').innerHTML = 0
 				 } else {
 					$('RemOver').innerHTML = remaining_overs;
 				 }
             }
           try {
                var data = parseInt(count);

                if (isNaN(data) == false) {
                    var division = parseInt(data / 6);
                    var rem = data % 6;	
                    row.cells[cell_no].innerHTML = (division + "." + rem);

                    if (count % 6==0) {    // This Condition for Chnage Striker Css When Over Is Completed
                        this.chnagebowlerrowcss();
                    }
                   
                    if(matchFlag==false && wicket!='10'){
                    
		                if (count1 % 6 == 0) {
		                	
		                	if(parseInt(newData)==-1){
		                	  var r = true;
		                	  checkpanaltyballreduceflag = true;
		                	}else{	
		                		checkpanaltyballreduceflag = false;
		                		var r = confirm("There have been 6 legitimate balls bowled.End over now?");
		                	}	
	                        if (r == true) {
	                        	callFun.chkonlinoffline();
	                        	this.setPreviousStriker(row.id);
	                        	callFun.setchangebowlerflag(false);
								ajexObj.sendData("inningcounter","0");// update over counter
								if(checkpanaltyballreduceflag==false){
									showPopup('BackgroundDiv', 'BowlList')
								}	
	                           	if (runFlag == "0") {
	                                if (isNaN(parseInt(row.cells[COL_BALL_MEDDAN].innerHTML))) { // Condition if 1st over is median than we first do inner html is 0
	                                    row.cells[COL_BALL_MEDDAN].innerHTML = 0;
	                                }
	                                if(checkpanaltyballreduceflag){
	                                	row.cells[COL_BALL_MEDDAN].innerHTML = parseInt(row.cells[COL_BALL_MEDDAN].innerHTML);
	                                }else{	
	                                	row.cells[COL_BALL_MEDDAN].innerHTML = parseInt(row.cells[COL_BALL_MEDDAN].innerHTML) + parseInt(1);
	                                }
	                            }else {
	                                if (isNaN(row.cells[COL_BALL_MEDDAN].innerHTML)) {
	                                    row.cells[COL_BALL_MEDDAN].innerHTML = 0;
	                                }
	                            }
	                           	runFlag = "0" // Set runFlag is 0 for track next medain over
	                            bastmenObj.swapBatsmen();
	                            // this for over Completd than batsmen will be change position For Batsman Screen
	
	                            bastmenObj.changeCSS();
	                            // this is for Striker and non Striker CSS  Login from batsman screen
	                            scoreObj.swapBatsmen();
	
	                        }else {
	                        	over = $('SBOver').innerHTML.split(".");
	                			overnumber = over[0];
	                			var previousover = parseInt(over[0]) - parseInt(1);
	                			 $('SBOver').innerHTML = previousover + ".5"; // when over is not completed then we redure 1 ball.
	                			count = parseInt(count) - parseInt(1)
	                            count1 = parseInt(count1) - parseInt(1);
								todaycount1 = parseInt(todaycount1) - parseInt(1);
	                            // this for if we dont want to complete over than we set count as 5 so in every ball this logic will be come
	                            this.setStriker($('BALL_TABLE').rows[ballStriker]);
	                        }
	                    }
	               }     
                } else {
                    row.cells[cell_no].innerHTML = newData;
                }

            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.updateOverCell()');
            }
        }// end of updateCell
        //To update overcell


        /****************dipti start***********************bowler*************************************************************/
        this.extraUpdate = function(run, flag) {
            try {
		
                if (flag == "wide" || flag == "Wideoverthrows" || flag=="WideBye") {
                    COL_EXTRA = COL_BALL_WIDE;
                } else if (flag == "NoBallRun" || flag == "NoBallBye" || flag == "NoBallLegBye" || flag == "noball" ||
                           flag == "NoBallRunOverThrows" || flag == "NoBallByeOverThrows" || flag == "NoBallLegByeOverThrows") {
                    COL_EXTRA = COL_BALL_NOBALL;
                }
				 runFlag = 1 // Set runFlag is 1 For over is not run	 logic for over median
                var row = $('BALL_TABLE').rows[ballStriker];
                this.updateCell(row, COL_BALL_RUN, (parseInt(run) + parseInt(1)));
                //Add runs to bowlers Run Acc.
                this.updateCell(row, COL_EXTRA, 1);
                //Add runs to bowlers wide acc
                this.updateEcoCell(row, COL_BALL_ECO);
                 this.updateBowlerSRCell(row, COL_BALL_SR);
                this.setStriker($('BALL_TABLE').rows[ballStriker]);

            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.extraUpdate()');
            }
        }//end of extraUpdate (bowler)

        this.removeLastBall = function(){
        	var row = $('BALL_TABLE').rows[ballStriker];
        	this.updateOverCell(row, COL_BALL_OVER, '-1');
        }	
        //To update strike rate.
        this.updateEcoCell = function (row, cell_no) {
            try {
                var over = (row.cells[COL_BALL_OVER].innerHTML).split(".");
                // To Split Ball And Overs, TO Store All Over From Over Field
                var totalover = over[0];
                var ball = over[1];
                var totalball = parseInt((totalover * 6)) + parseInt(ball);

                var run = parseInt(row.cells[COL_BALL_RUN].innerHTML);
                var srRate = (run * 6) /totalball;
				
                row.cells[cell_no].innerHTML = srRate.toFixed(2);
                if (row.cells[cell_no].innerHTML == "Infinity" ||isNaN(row.cells[cell_no].innerHTML)) { // if Eco In Infinity than we set it blank
                    row.cells[cell_no].innerHTML = "0.00";
                }
                
            } catch(err) {
                alert(err.description + 'BCCI.js.bastment.updateEcoCell()');
            }
        }
        this.updateBowlerSRCell = function(row, cell_no){
        	 try {
                var over = (row.cells[COL_BALL_OVER].innerHTML).split(".");
                // To Split Ball And Overs, TO Store All Over From Over Field
                var totalover = over[0];
                var ball = over[1];
                var totalball = parseInt((totalover * 6)) + parseInt(ball);

                var wkt = parseInt(row.cells[COL_BALL_WKT].innerHTML);
                var srRate = totalball /wkt;
				
                row.cells[cell_no].innerHTML = srRate.toFixed(2);
                if (row.cells[cell_no].innerHTML == "Infinity" ||isNaN(row.cells[cell_no].innerHTML)) { // if Strike Rate In Infinity than we set it blank
                    row.cells[cell_no].innerHTML = "0.00";
                }
                
            } catch(err) {
                alert(err.description + 'BCCI.js.bastment.updateEcoCell()');
            }
        }
        //End of strike rate updateEcoCell
        /****************dipti end***********************bowler*************************************************************/
        this.updateCell = function (row, cell_no, newData) {
            try {
            	var data = parseFloat(row.cells[cell_no].innerHTML);
                if (isNaN(data) == false) {
                    row.cells[cell_no].innerHTML = data + parseFloat(newData);
                } else {
                    row.cells[cell_no].innerHTML = newData;
                }
                 row.className = 'striker';

            } catch(err) {
                (err.description +'BCCI.js.bowler.updateCell()');
            }
        }// end of updateCell

        this.setStriker = function (row) {//when new bowlr selected to sert default runs wkts etc.
            try {
                //row.className = 'striker';

                if (isNaN(row.cells[COL_BALL_OVER].innerHTML)) {
                    row.cells[COL_BALL_OVER].innerHTML = "0.0" // Set Over Cell 0.0 If InnerHTML Is null
                }
                if (isNaN(row.cells[COL_BALL_RUN].innerHTML)) {
                    row.cells[COL_BALL_RUN].innerHTML = "0.0" // Set eco Cell 0  If InnerHTML Is null
                }
                if (isNaN(row.cells[COL_BALL_ECO].innerHTML)) {
                    row.cells[COL_BALL_ECO].innerHTML = "0.0" // Set Reco Cell 0  If InnerHTML Is null
                }
            } catch(err) {
                alert(err.description + 'BCCI.js.bowler.setStriker()');
            }
        }        // end of setStriker Function
        this.setPreviousStriker = function(previousbowlerId){//to stop user from selecting same bowler
        	try{
        		previousstrikerbowlerId = previousbowlerId;
        	}catch(err){
        		alert(err.description + 'BCCI.js.bowler.setPreviousStriker()');	
        	}
        }
        this.getPreviousStriker = function(){
        	try{
        		return previousstrikerbowlerId;
        	}catch(err){
        		alert(err.description + 'BCCI.js.bowler.getPreviousStriker()');	
        	}
        }
        this.newStriker = function(newStriker) {
            row = $('BALL_TABLE').rows[ballStriker];
            // This logic for change css for previous over
            //row.className = '';
            //set  previous striker css is none
            ballStriker = newStriker;
            row = $('BALL_TABLE').rows[ballStriker];
            this.setStriker(row);
            var bowler = $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_OVER].innerHTML;
            if (isNaN(bowler)) {
                bowler = 0;
                count = bowler
            } else {
            	var overno = bowler.split(".");
            	var totalovers = overno[0];
            	var totalballs = overno[1];
                //bowler = bowler * 6;
                bowler = parseInt(totalovers) * parseInt(6) + parseInt(totalballs);
                count = bowler
            }
        }
        this.newBall = function() {
            var over;
            if (isNaN($('SBOver').innerHTML)) {
                over = 0;
            } else {
                over = $('SBOver').innerHTML;
            }
            alert("New ball taken from " + over + "  overs");
        }

        // archana
        this.PrintAllValues = function() {

            undo.rowID = $('BALL_TABLE').rows[ballStriker].id;
            undo.tempBallName = $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_NAME].innerHTML;
            undo.tempMaiden = $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_MEDDAN].innerHTML;
            undo.tempBallRun = $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_RUN].innerHTML;
            undo.tempWicket = $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_WKT].innerHTML;
            undo.tempBallOver = $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_OVER].innerHTML;
            undo.tempWide = $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_WIDE].innerHTML;
            undo.tempNoBall = $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_NOBALL].innerHTML;
            undo.tempBallEco = $('BALL_TABLE').rows[ballStriker].cells[COL_BALL_ECO].innerHTML;
            return undo;
        }//
        this.setBallSrtiker = function() {// Archana 12/08/2008 Created By Me
            return ballStriker;
        }
        // stop
        this.chnagebowlerrowcss = function(){
            if(ballStriker % 2 ==0){    // change Css When over is Completed
                $('BALL_TABLE').rows[ballStriker].className = 'contentDark';
            }else{
                $('BALL_TABLE').rows[ballStriker].className = 'contentLight';
            }
        }
        this.bolerRowNumber= function(){
       		 for(var i=1;i<12;i++){
            $('BALL_TABLE').rows[i].cells[COL_BALL_NUMBER].innerHTML=i;

            }
    	}
    	  //--dipti--
    	this.goto = function()  {
    		showPopup('BackgroundDiv', 'gotoDiv');
    	}
    	    	
		this.getLastTenOvers = function(lastTenOverFlag,NavigateButtonFlag){
		if(NavigateButtonFlag != 3){//gotoover	
			  var pageNumber = 0
			  if(document.getElementById('hdpageNumber').value == ''){
					pageNumber = 0
			  }else{
					//alert("2 st :    "+document.getElementById('hdpageNumber').value)
					pageNumber = document.getElementById('hdpageNumber').value
			  }
			  if(lastTenOverFlag == 0){//lastTenOverFlag = 0 for last Ten Over & lastTenOverFlag = 1 for paging
					ajexObj.sendDataLastTenOvr('lastTenOvrs',pageNumber,lastTenOverFlag); 
			  }else if(lastTenOverFlag == 1){//Paging
					var currentOver = $('SBOver').innerHTML.split(".");
				    var maxPageNumber = parseInt(parseInt(currentOver[0])/10) 
					if(document.getElementById('hdpageNumber').value == ''){
					    if((parseInt(currentOver[0])%10) != 0){//for over 1-9 (0.1 - 0.9) pg no 1 i.e.quotient + 1
						pageNumber = (parseInt(parseInt(currentOver[0])/10) + 1)
					    }else{//for overno divisible by 10 page no is quotient
							pageNumber = parseInt(parseInt(currentOver[0])/10)
					    }
					    document.getElementById('hdMaxPageNumber').value = pageNumber
				    }// end if hdpageNumber 		   		
					if(NavigateButtonFlag == 1){//back
						if((pageNumber - 1) <= 0){
							alert('First page')
							return false
						}else{
							pageNumber = pageNumber - 1
							document.getElementById('hdpageNumber').value = pageNumber
							ajexObj.sendDataLastTenOvr('lastTenOvrs',pageNumber,lastTenOverFlag);//lastTenOverFlag = 1
						}	
					}// end NavigateButtonFlag if
					else if(NavigateButtonFlag == 2){//next
				   			if((pageNumber + 1) > document.getElementById('hdMaxPageNumber').value){
				   				alert('Last page')
				   				return false
							}else{
								pageNumber = parseInt(parseInt(pageNumber) + parseInt(1))
								document.getElementById('hdpageNumber').value = pageNumber
				   				ajexObj.sendDataLastTenOvr('lastTenOvrs',pageNumber,lastTenOverFlag);//lastTenOverFlag = 1
							}
				   	}
			   }	// end of else if  paging
			}else{//NavigateButtonFlag "3"
				var enteredOver = $$('txtOverNumber')
	    		var currentOver = $('SBOver').innerHTML.split(".")
	    		var pageNumber = 0
	    		if(isNaN(enteredOver)){//dipti 06 06 2009
		    		 alert("Invalid over number!")
		 			 document.getElementById('txtOverNumber').value = "";
		    		 $('txtOverNumber').focus();
		    		 return false;
	    		}
	    		if(parseInt(enteredOver) > currentOver[0] || enteredOver == 0){//dipti 06 06 2009
	    			alert("Invalid over number!")
	 				document.getElementById('txtOverNumber').value = "";
	    			$('txtOverNumber').focus();
	    			return false;
	    		}
	    		//var lastTenOverFlag = 1
	    		
	    		 if((parseInt(parseInt(enteredOver))%10) != 0){//for over 1-9 (0.1 - 0.9) pg no 1 i.e.quotient + 1
					pageNumber = (parseInt(parseInt(parseInt(enteredOver))/10) + 1)
			     }else{//for overno divisible by 10 page no is quotient
					pageNumber = parseInt(parseInt(parseInt(enteredOver))/10)
				 }
				 ajexObj.sendDataLastTenOvr('lastTenOvrs',pageNumber,lastTenOverFlag);
				 closePopup('BackgroundDiv','gotoDiv')//dipti 06 06 2009
			} //NavigateButtonFlag "3" end  
			var result = $$('hidOvers')
			var SplitResult = result.split(":");
			var lasttenovr = SplitResult[1]
			var fieldresult = lasttenovr.split("$");
			var over = fieldresult[0]
			                      
			var eachOver = over.split("~")
			for(var i = 0;i < 10;i++){
				$('over'+(i+1)).innerHTML = ""
				$('bwlr'+(i+1)).innerHTML = ""
				$('runs'+(i+1)).innerHTML = ""
				$('wkt'+(i+1)).innerHTML = ""
			
			}
			if(lastTenOverFlag == 0){
				for(var i=0;i<eachOver.length-1;i++){//for last 10 overs
				
					$('over'+(i+1)).innerHTML ='<a href="javascript:callFun.updateScore('+ eachOver[i] +')">'+ (parseInt(eachOver[i]) + parseInt(1))  +'</a>' 
					$('over'+(i+1)).className='tenovers';
					
					document.getElementById('achorover_num'+(i+1)).value = eachOver[i]; 
				}
			}else{//for paging
				for(var i=0;i<eachOver.length-1;i++){
				
					$('over'+(i+1)).innerHTML ='<a href="javascript:callFun.updateScore('+ eachOver[i] +')">'+ (parseInt(eachOver[i]) + parseInt(1))  +'</a>' 
					$('over'+(i+1)).className='tenovers';
					
					document.getElementById('achorover_num'+(i+1)).value = eachOver[i]; 
				}
			}
			
			var BwlrName = fieldresult[1]
			var eachName = BwlrName.split(",")
			ajexObj.sendDataToolTip('toolTip',over);
			var tooltipResult = $$('hidToolTip')
			var tooltiparr = tooltipResult.split("~");
			for(var i=0;i<eachName.length-1;i++){
				$('bwlr'+(i+1)).innerHTML ='<b>' + eachName[i] + '</b>'
				$('over_'+(i+1)).innerHTML = tooltiparr[i];
				$('bwlr'+(i+1)).className='tenovers';
			}
			
			var runs = fieldresult[2]
			var eachOvrRuns = runs.split(",")
			for(var i=0;i<eachOvrRuns.length-1;i++){
				$('runs'+(i+1)).innerHTML = eachOvrRuns[i]
				$('runs'+(i+1)).className='tenovers'
			}
			
			var wicket = fieldresult[3]
			var eachOvrWkt = wicket.split(",")
			for(var i=0;i<eachOvrWkt.length-1;i++){
				document.getElementById('wkt'+(i+1)).innerHTML = eachOvrWkt[i]
				$('wkt'+(i+1)).className='tenovers'
			}
			var totalruns = fieldresult[4]
			var eachovertotal = totalruns.split(",")
			for(var i=0;i<eachovertotal-1;i++){
				$('total'+(i+1)).innerHTML = eachovertotal[i]
				$('total'+(i+1)).className='tenovers'
			}
		}
		this.updateScorerOver = function(){
			try{
				for(var i=1;i<12;i++){
            		if(isNaN($('BALL_TABLE').rows[i].cells[COL_BALL_OVER].innerHTML)){
            		}else{
	            		var balloversarr = $('BALL_TABLE').rows[i].cells[COL_BALL_OVER].innerHTML.split(".")
	            		var ballover = balloversarr[0];
	            		var balls = balloversarr[1];
	            		if(isNaN(ballover)){
	            			ballover = "0";
	            		}
	            		if(isNaN(balls)){
	            			balls = "0";
	            		}
	            		var ballcount = (parseInt(ballover) * parseInt(6)) + parseInt(balls);
	            		countball = parseInt(countball) + parseInt(ballcount);
	            	}	
				}
            	var totalovers = countball / 6;
            	var totalBalls = countball % 6;
				$('SBOver').innerHTML = parseInt(totalovers) + "." + parseInt(totalBalls);
				var remainintotalOver = parseInt(matchOvers) - parseInt(totalovers) - parseInt(1);
				var remainingBall =  parseInt($$('hdballperover')) - parseInt(totalBalls);
				var remaining_overs = parseInt(remainintotalOver) +"."+parseInt(remainingBall);
				if (parseFloat(remaining_overs) < 0){
					$('RemOver').innerHTML = 0
				} else {
					$('RemOver').innerHTML = remaining_overs;
				}	
				return countball;
			}catch(err){
				alert(err.description + 'bowler.js.updateScorerOver()');
			}
		}
    //--dipti--
    	
    } catch(err) {
        alert(err.description + 'bowler.js.bowler()');
    }
}
// end of the bowler class
