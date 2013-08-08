/*modifyed Date:12-09-2008*/
var scoreObj = new scordBoard();
function scordBoard() {/**right hand side table.*/
    try {
        var striker = "No1";
        var strikercss="No11";
        var nonStriker = "No2";
        var nonStrikercss = "No22";
		var out_col;
		var out_colcss;	
        // Col NUMBER
        var batRow = 1;
        var landmarkflag = false; 
        //Row Number

        this.updateRun = function (run) {
            try {
                this.updateCell(run, 'r');
                // For Runs
                if (run % 2 != 0) {
                    this.swapBatsmen();
                }
            } catch(err) {
                alert(err.description + 'BCCI.js.scordBoard.update()');
            }
        }// end of update function

        this.extraUpdate = function(run) {
            try {
                this.updateCell((parseInt(run) + parseInt(1)), 'e');
                // For Extra
                if ((run) % 2 != 0) {
                    this.swapBatsmen();
                }
            } catch(err) {
                alert(err.description, 'BCCI.js.scordBoard.extra()');
            }
        }//end of extraUpdate (scoreBoard)

        // Penailty Update

        this.updateWicket = function (wicket) {
            try {
                this.updateTotalWicket(wicket);
                if ($('Wickt').innerHTML == "10") { // for chek if All Out happend
				 callFun.endInning();
                } 
            } catch(err) {
                alert(err.description + 'BCCI.js.scordBoard.updateWicket()');
            }
        }

        this.updateTotalWicket = function (wicket) {
            try {
                var score = parseInt($('total').innerHTML);
                var WCK = parseInt($('Wickt').innerHTML);
                if (isNaN(WCK) == false) {
                    $("Wickt").innerHTML = WCK + parseInt(wicket);
                } else {
                    $("Wickt").innerHTML = wicket;
                }
                this.updateBatsmanTableTotalRun();
                if(isNaN($("total").innerHTML)){   // this logic for if total run cell is empty than we set it as zero
                    $("lstWicket").innerHTML ="0";
                }else{
                    $("lstWicket").innerHTML = parseInt($("total").innerHTML);
                 }

                if(isNaN($(striker).innerHTML)){
                    $("lastMan").innerHTML ="0";
                }else{
                    $("lastMan").innerHTML = $(striker).innerHTML;
                 }
            } catch(err) {
                alert(err.description + 'BCCI.js.scordBoard.scoreupdateCell()');
            }
        }
        this.updateStrikerOrNonStrikerWicket = function(flag,wicket){
        	try {
                var score = parseInt($('total').innerHTML);
                var WCK = parseInt($('Wickt').innerHTML);
                if (isNaN(WCK) == false) {
                    $("Wickt").innerHTML = WCK + parseInt(wicket);
                } else {
                    $("Wickt").innerHTML = wicket;
                }
                this.updateBatsmanTableTotalRun();
                if(isNaN($("total").innerHTML)){   // this logic for if total run cell is empty than we set it as zero
                    $("lstWicket").innerHTML ="0";
                }else{
                    $("lstWicket").innerHTML = parseInt($("total").innerHTML);
                 }
				if (flag == "0") { // 0 - Striker Out
                   if(isNaN($(striker).innerHTML)){
    	                $("lastMan").innerHTML ="0";
	                }else{
        	            $("lastMan").innerHTML = $(striker).innerHTML;
            	     }
                  
                }else {
                   if(isNaN($(nonStriker).innerHTML)){
    	                $("lastMan").innerHTML ="0";
	                }else{
        	            $("lastMan").innerHTML = $(nonStriker).innerHTML;
            	     }
                }
            } catch(err) {
                alert(err.description + 'BCCI.js.scordBoard.scoreupdateCell()');
            }	
        }
        this.penailtyUpdate = function(run) {
            try {
                this.updateCell(run, 'e');
                // For Extra
            } catch(err) {
                alert(err.description + 'BCCI.js.scordBoard.extra()');
            }
        }

		this.updateStrikerRun = function(newData){ // this function is only use for run out condition
		 var data = parseInt($(striker).innerHTML);
		  if (isNaN(data) == false) {
              $(striker).innerHTML = data + parseInt(newData);
          } else {
              $(striker).innerHTML = newData;
          }
		}
        this.updateCell = function (newData, flag) {
            try {
                var data = parseInt($(striker).innerHTML);
                var score = parseInt($("total").innerHTML);
                if (flag == 'r') {
                    if (isNaN(data) == false) {
                        $(striker).innerHTML = data + parseInt(newData);
                    } else {
                        $(striker).innerHTML = newData;
                    }
                }
                if (isNaN(score) == false) {
                    $("total").innerHTML = parseInt(score) + parseInt(newData);
                } else {
                    $("total").innerHTML = newData;
                }
                this.requireRun(newData);
	            this.landMark( newData ); 
	            bastmenObj.showPaternshipLandmark(newData);
	           // bastmenObj.showPaternshipLandmark(newData);
	           this.updateBatsmanTableTotalRun(); // update total run for batsman table
            }
            catch(err) {
                alert(err.description + 'BCCI.js.scordBoard.scoreupdateCell()');
            }
        }// end of updateCell
		this.requireRun = function(run){
			 var runreq = $("runreq").innerHTML;
			 if(runreq > 0){
	             $("runreq").innerHTML = parseInt(runreq) - parseInt(run);
	         }

	         if($$('hdreqrunflag')=="true"){
	         	if($("runreq").innerHTML <= 0){
	         		callFun.endInning();
	         		$("runreq").innerHTML = "0";
	         		
	         	}
	         }    
		}
        this.landMark = function( lastBallRuns ){//team 50 100
        	try{
        		var landmarkrun;
        		var remindar;
        		var totalball = 0;
        		var batsmanball = 0;
        		var matchtime = $$('hdtotalInningMint')

        		/*This logic for count total ball*/
        		
				//totalball = bastmenObj.totalBall();
				var ballflag = callFun.setlandmarkflag();
				if (ballflag){
					var totalballArr = ($('SBOver').innerHTML).split(".")
					if(totalballArr[1] =="5"){
						totalball = parseInt(totalballArr[0]) + parseInt(1);
						totalball = totalball + ".0";
					}else{
						var ball =  parseInt(totalballArr[1]) + parseInt(1);
						totalball = totalballArr[0] +"." +ball
					}
				}else{
					var totalball = $('SBOver').innerHTML;
				}	
				var totalRuns = parseInt( $("total").innerHTML ) - parseInt( lastBallRuns );
				var mark = totalRuns%50 + parseInt(lastBallRuns);
				if( parseInt(lastBallRuns) > 0 && mark >= 50 ){
					$('totallandmarkkrun').innerHTML = "Congratulations!&nbsp;&nbsp;&nbsp;&nbsp;"+ $("total").innerHTML +" runs Completed in  "+ totalball +"  Overs and  "+ matchtime +"  Minutes"
           			showPopup('BackgroundDiv','totallandmark');
				}
        	}catch(err){
        		alert(err.description + 'BCCI.js.scordBoard.landMark()');
        	}
        }

        this.updateNewBatsman = function(flag, run, batsman) { // this for witch batsman will be out so new batsman come for that position.
            try {
                if (flag == "0" && run == "0" && batsman == "0") { //For Bowled,Stump, Wide+Hit Wicket , Hit The Ball Twice  flag-0 for conditon ; run-0 menas no run ; batsman-0 ;means Striker out
                    $(striker).innerHTML = "0";
                    this.setoutcol(striker);
                } else if (flag == "1" && run == "0" ) { // if Caught and batsman chang the Strike
                    $(striker).innerHTML = "0";
                    this.setoutcol(striker);
                     if(batsman == "1"){
                       this.swapBatsmen();
                   	 }
	                }else if (flag == "2" || flag == "3") {  //2-For Run Out Happen    3- Retire Out  ;-Handle the ball/ Obstructing the field ; Wide + Handle the ball/ Obstructing the field ; No Ball + Handle the ball/ Obstructing the field
                	if (batsman == "0") { // 0 - Striker Out
                        $(striker).innerHTML = "0";
                        this.setoutcol(striker);
                    } else {
                        $(nonStriker).innerHTML = "0";
                        this.setoutcol(nonStriker);
                    }
                    if(flag == "2"){
	                    if (document.getElementById("runoutStrikeChg").value == "1") { // Check Striker is Change Striker or Not
	                          // Striker Change Strik
	                           this.swapBatsmen();
	                    }
	                }    
                }
                var newbatsmanrowid = bastmenObj.getNewBatsmanRoWId(); // this is use to genarate and remove combo box for batsman so user can get letest batsman list
                 if ($('Wickt').innerHTML != "10") {
	                showPopup('BackgroundDiv', 'BatList' );
	             }   
            } catch(err) {
                alert(err.description + 'ScoreCard.js.scordBoard.updateNewBatsman()');
            }
        }
		/*This logic is use to set which batsman is out so if retire batsman come as new batsman then we set previous run in that column*/
		this.setoutcol = function(col){
			out_col = col;
		}	
		this.getoutcol = function(){
			return out_col;
		}
		//archana Update score byes/legbyes
        this.updateTotalRuns = function (run) {
            try {
                var score = parseInt($('total').innerHTML);
                if (isNaN(score) == false) {
                    $("total").innerHTML = score + parseInt(run);
                } else {
                    $("total").innerHTML = run;
                }
                this.requireRun(run);
				this.landMark(run);
				bastmenObj.showPaternshipLandmark(run);
				//bastmenObj.showPaternshipLandmark(run);
                this.updateBatsmanTableTotalRun(); // update total run for batsman table
                if (run % 2 != 0) {
                    this.swapBatsmen();
                }
            } catch(err) {
                alert(err.description +'BCCI.js.scordBoard.updateTotalRuns()');
            }
        }

        this.updateRunoutRun = function(run){ // run out time run
        	try {
                var score = parseInt($('total').innerHTML);
                if (isNaN(score) == false) {
                    $("total").innerHTML = score + parseInt(run);
                } else {
                    $("total").innerHTML = run;
                }
                this.requireRun(run);
				 this.landMark(run);	
				 bastmenObj.showPaternshipLandmark(run);
				  //bastmenObj.showPaternshipLandmark(run);
                this.updateBatsmanTableTotalRun(); // update total run for batsman table
                $("lstWicket").innerHTML = parseInt($("total").innerHTML);
                if ($('Wickt').innerHTML == "10") { // for chek if All Out happend
				  callFun.endInning();
                } 
            } catch(err) {
                alert(err.description +'BCCI.js.scordBoard.updateTotalRuns()');
            }
        }

        this.extraUpdateNoBall = function(run,flag){
            if(flag=="NoBallRun"){
               this.updateCell(run,'r') //r stand For Batsman Run
                this.extraUpdate("0");
            }else if(flag=="NoBallRunOverThrows"){
               this.updateCell(run,'r') //r stand For Batsman Run
                this.extraUpdate("0");
            }else{
                this.extraUpdate(run);
            }
        }

        this.swapBatsmen = function() {
            try {
                var temp = striker;
                striker = nonStriker;
                nonStriker = temp;
				this.setStrikerCss();
            } catch(err) {
                alert(err.description, 'bastment.js.swapBatsmen()');
            }
        }

        this.setStrikerCss = function(){
        	if(striker=="No1"){
					$('No11').className='scorecardstrikercss';
					$('No22').className='scorecardnonstrikercss';
        			//$('No11').className='scorecardnonstrikercss';
        			//$('No22').className='scorecardstrikercss';
				}else{
					$('No11').className='scorecardnonstrikercss';
					$('No22').className='scorecardstrikercss';
					//$('No11').className='scorecardstrikercss';
					//$('No22').className='scorecardnonstrikercss';
				}
        }

       this.setStriker = function (row) {
            try {
                row.className = 'striker';
            } catch(err) {
                alert(err.description, 'BCCI.js.scordBoard.setStriker()');
            }
        }

        this.setNonStriker = function (row) {
            try {
                row.className = 'nonStriker';
            } catch(err) {
                alert(err.description + 'BCCI.js.scordBoard.setNonStriker()');
            }
        }
	
		this.PrintAllValues = function(){
       		undo.tempNo1 = $("No1").innerHTML;
			undo.tempTotal = $("total").innerHTML;			
			undo.tempNo2 = $("No2").innerHTML;
			undo.templstMan = $("lastMan").innerHTML;
			undo.tempwicket = $("Wickt").innerHTML;
			undo.tempScoreOvers=$("SBOver").innerHTML;
			undo.templstWicket = $("lstWicket").innerHTML;
			undo.tempRemOver=$("RemOver").innerHTML;
			return undo;		
			
		}

		this.updateBatsmanTableTotalRun = function() {//total below batsman analysis.
		  try{
			   $('batsmanscorerewkt').innerHTML = $("Wickt").innerHTML; // display total overs for batsman list	
			   $('Batstotalover').innerHTML = $("SBOver").innerHTML; // display total wkt for batsman list	
			   $('battotalruns').innerHTML = $("total").innerHTML; // display total run for batsman list		
			 this.updateTotalSRCell();
		  }catch(err){
		  	 alert(err.description, 'scordBoard.js.updateBatsmanTableTotalRun()');
		  }	   
		}

		this.updateTotalSRCell = function() {//over rate and strike rate
            try {
                var over = ($('Batstotalover').innerHTML).split(".");
                // To Split Ball And Overs, TO Store All Over From Over Field
                var totalover = over[0];
                var ball = over[1];
                var totalball = parseInt((totalover * 6)) + parseInt(ball);

                var run = parseInt($('battotalruns').innerHTML);
                var srRate = (run/ totalball)*6;

                $('totlarunrate').innerHTML = srRate.toFixed(2);
                if ($('totlarunrate').innerHTML == "Infinity" ||isNaN($('totlarunrate').innerHTML)) { // if Strike Rate In Infinity than we set it blank
                    $('totlarunrate').innerHTML = "";
                }
                
            } catch(err) {
                alert(err.description + 'BCCI.js.bastment.updateSRCell()');
            }
        }
    } catch(err) {
        alert(err.description, 'BCCI.js.Score()');
    }
}
//End score Board Table