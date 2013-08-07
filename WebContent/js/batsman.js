/*modifyed Date:12-09-2008*/
var bastmenObj = new bastment();
// Create obj of bastment Class
function bastment() { // declear bastmen class
    try {
        // Define Column  Id
        COL_BATT_NUMBER=0;//TD manes
        COL_BATT_INTIME=1;
        //COL_BATT_OUTTIME=2;
        COL_BATT_NAME = 2;
        COL_BATT_OUT = 3;
        COL_BATT_BOWLER = 4;
        COL_BATT_RUN = 5;
        COL_BATT_BALL = 6;
        COL_BATT_MINUTS = 7;
        COL_BATT_FOUR = 8;
        COL_BATT_SIX = 9;
        COL_BATT_SR = 10;
        COL_EXTRA = null;
       
        COL_EXTRA_TOTAL = 3;
        
        COL_EXTRA_WIDE = 1;
     
        COL_EXTRA_NOBALL = 2;
   
        COL_EXTRA_WIDEBYE = 4;
   

        // Define Striker And Non Striker Row number
        var striker = 1;
        var nonStriker = 2;
        // ROW NUMBER
        var extra = 23;
        //Extra Row number.
    	var rowNumber;
    	var retireflag =1;
		var matchstartflag = "stop";
		this.checkRetirecolumn = function(){ // check retire batsman playing or not//after refresh
			try{
				var batsstriker = $$('hdbatsmanstriker'); // ROW NUMBER
				var batsnonStriker = $$('hdbatsmannonstriker');
				
				if($('BATT_TABLE').rows[batsstriker].cells[COL_BATT_OUT].innerHTML=="Retires"){
					$('BATT_TABLE').rows[batsstriker].cells[COL_BATT_OUT].innerHTML ="";
				}else if($('BATT_TABLE').rows[batsnonStriker].cells[COL_BATT_OUT].innerHTML=="Retires"){
					$('BATT_TABLE').rows[batsnonStriker].cells[COL_BATT_OUT].innerHTML ="";
				}
			}		
			catch(err){
				 alert(err.description + 'BCCI.js.bastment.checkRetirecolumn()');
			}
		}
		
		this.setstrikernonstriker = function(){
			striker = $$('hdbatsmanstriker'); // ROW NUMBER
			nonStriker = $$('hdbatsmannonstriker');
		}
		
		this.batSetStriker = function(){//to set striker bd id
			var currentStriker = $('BATT_TABLE').rows[striker].id;
			return currentStriker;
		}
		
		this.batSetNonStriker = function(){////to set nonstriker db id
			var currentNonStriker = $('BATT_TABLE').rows[nonStriker].id;
			return currentNonStriker;
		}
		
		this.setstrikernumber = function(strikerid){//swapping striker
			var previoustrikerId = striker;
			striker = strikerid;
			return previoustrikerId;
		}
		
		this.setnonstrikernumber = function(nonstrikerid){//non striker swapping on clicking button
			var previounonstrikerId = striker;
			nonStriker = nonstrikerid;
			return previounonstrikerId;
		}
		
        this.updateRun = function (run) {
            try {
                var today = new Date();
                var h = today.getHours();
                var m = today.getMinutes();
                var s = today.getSeconds();
                // add a zero in front of numbers<10
                m = intervalObj.checkTime(m);
                s = intervalObj.checkTime(s);
                $('txt').innerHTML = h + ":" + m + ":" + s;
                $('clock').value = m;
                var row = $('BATT_TABLE').rows[striker];
                this.updateCell(row, COL_BATT_RUN, run);
                // This Function is Use To Display data on Front Page
                this.updateCell(row, COL_BATT_BALL, 1);
                //To update SRrate
                this.strikerate(row);
                if (run == '4') {
                    this.updateCell(row, COL_BATT_FOUR, 1);
                }
                if (run == '6') {
                    this.updateCell(row, COL_BATT_SIX, 1);
                }
                // Logic For Striker and Non Striker
                if (run % 2 != 0) {
                    this.swapBatsmen();
                }
                this.changeCSS();
                this.showBatsmanLandMark(row,run);//to chk 50 ,100 runs

                // This Function For Change Striker And Non Striker CSS

            } catch(err) {
                alert(err.description + 'BCCI.js.bastment.update()');
            }
        }
		
		this.strikerate = function(row){
			try{
				 var runs = row.cells[COL_BATT_RUN].innerHTML;
	             var ball = row.cells[COL_BATT_BALL].innerHTML;
	             if ((isNaN(runs) && isNaN(ball)) == false) {
	               var srRate = (runs * 100) / ball;
	               this.updateSRCell(row, COL_BATT_SR, srRate);
	              } else {
	                 this.updateSRCell(row, COL_BATT_SR, 0.00);
	              }
			}catch(err){
				alert(err.description + 'BCCI.js.bastment.strikerate()');	
			}
		}

		this.fourRun = function(run){
			try{
			 	var row = $('BATT_TABLE').rows[striker];
                this.updateCell(row, COL_BATT_RUN, run);
                this.updateCell(row, COL_BATT_BALL, 1);
                var runs = $('BATT_TABLE').rows[striker].cells[COL_BATT_RUN].innerHTML;
                var ball = $('BATT_TABLE').rows[striker].cells[COL_BATT_BALL].innerHTML;
                if ((isNaN(runs) && isNaN(ball)) == false) {
                    var srRate = (runs * 100) / ball;
                    this.updateSRCell(row, COL_BATT_SR, srRate);
                } else {
                    this.updateSRCell(row, COL_BATT_SR, 0.00);
                }
                // Logic For Striker and Non Striker
                if (run % 2 != 0) {
                    this.swapBatsmen();
                }
                this.changeCSS();
                this.showBatsmanLandMark(row,run);

           }catch(err){
           		alert(err.description + 'BCCI.js.bastment.fourRun()');
           }     
		}

        this.changeCSS = function() {
            try {
            	var rowStriker = $('BATT_TABLE').rows[striker];//dipti 06 06 2009
            	var rowNonStriker = $('BATT_TABLE').rows[nonStriker];//dipti 06 06 2009
            	//this.updateCell(rowStriker,COL_BATT_OUT, 'not out');//dipti 06 06 2009
            	//this.updateCell(rowNonStriker,COL_BATT_OUT, 'not out');//dipti 06 06 2009
                // set css to striker
                this.setStriker($('BATT_TABLE').rows[striker]);
                // set css to nonstriker
                this.setNonStriker($('BATT_TABLE').rows[nonStriker]);
            } catch(err) {
                alert(err.description + 'bastment.js.changeCSS()');
            }
        }

        //Archana-Function to update extra runs got by Byes/LegByes
        this.updateBLBRuns = function (run) {
            try {
                //alert("updateByesLegByes")
                var row = $('BATT_TABLE').rows[striker];
                var extrarow = $('BATT_TABLE').rows[extra];
                this.updateCell(extrarow, COL_BATT_RUN, run);
                // This Function is Use To Display data on Front Page
                this.updateCell(row, COL_BATT_RUN, 0);
                // Update Ball Form Batsman Account
                this.updateCell(row, COL_BATT_BALL, 1);
                // Update Ball Form Batsman Account
                if (run == '4') {
                    this.updateCell(extrarow, COL_BATT_FOUR, 1);
                }
                if (run == '6') {
                    this.updateCell(extrarow, COL_BATT_SIX, 1);
                }
                //For Striker change.
                if (run % 2 != 0) {
                    this.swapBatsmen();
                }
                this.changeCSS();
                // This Function For Change Striker And Non Striker CSS
            } catch(err) {
                alert(err.description + 'BCCI.js.bastment.updateByesLegByesRuns()');
            }
        }

        //To update strike rate.
        this.updateSRCell = function (row, cell_no, newData) {
            try {
                var data = parseInt(row.cells[cell_no].innerHTML);
                row.cells[cell_no].innerHTML = newData.toFixed(2);
                row.className = 'striker';
            } catch(err) {
                alert(err.description + 'BCCI.js.bastment.updateSRCell()');
            }
        }
        
        this.penailtyUpdate = function(run, ball) { // run or ball parameter
            try {
                var row = $('BATT_TABLE').rows[striker];
                this.updateExtraCell(row, "open", run) // if only noball ball
               // this.updateExtraCell(row, "Extratotal", run);
            } catch(err) {
                alert(err.description + 'bastment.js.penailtyUpdate()');
            }
        }
		
		this.totalBall = function(){
			var totalball = 0;
        	var batsmanball = 0;
			for(var i=1;i<12;i++){
        		if($('BATT_TABLE').rows[i].cells[COL_BATT_BALL].innerHTML==null || $('BATT_TABLE').rows[i].cells[COL_BATT_BALL].innerHTML=='' || isNaN($('BATT_TABLE').rows[i].cells[COL_BATT_BALL].innerHTML)){
        			batsmanball = 0;
        		}else{
        			batsmanball = parseInt($('BATT_TABLE').rows[i].cells[COL_BATT_BALL].innerHTML);
        		}
        		totalball = parseInt(totalball) + parseInt(batsmanball);
           	}
          return totalball; 	
		}
        this.extraUpdate = function(run, flag) {
            try {
                var type = null;
                // Define Which Extra Ball E.g. Wide,No etc
                var row = $('BATT_TABLE').rows[striker];
                
                if (flag == "wide") {
                    this.updateExtraCell(row, "w", 1) // if only wide ball
                    this.updateExtraCell(row, "Extratotal", 1)
                }else if (flag == "noball") {
                    this.updateExtraCell(row, "nb", 1) // if only noball ball
                    this.updateExtraCell(row, "Extratotal", 1)
                    this.updateRun(0) // if ball is no  than add blow in baller account
                }else if (flag=="NoBallboundryRun"){
                	this.updateExtraCell(row, "nb", 1)
	                this.updateExtraCell(row, "Extratotal", 1)
	                this.fourRun(run);
                }else if(flag=="widerunout"){
                	this.updateExtraCell(row, "Extratotal", run)
                }else if(flag=="byesrunout"){
                	this.updateExtraCell(row, "Extratotal", run)
                }else if(flag=="legbyesrunout"){
                	this.updateExtraCell(row, "Extratotal", run)
                }else if(flag=="noballlegbyesrunout"){
                	this.updateExtraCell(row, "nb", 1)
                	this.updateExtraCell(row, "Extratotal", (parseInt(run) + parseInt(1)))
                }

                if (run % 2 != 0) {
                    if (flag == "NoBallRun" || flag == "NoBallRunOverThrows") { // Rule For No Ball With Batsman Taken Run
                        this.updateExtraCell(row, "nb", 1)
                        this.updateExtraCell(row, "Extratotal", 1)
                        this.updateRun(run) // if ball is no and batsman take Run Than We Add Run in Batsmen Account
                    } else if (flag == "NoBallBye" || flag == "WideBye" || flag == "NoBallByeOverThrows") { // Rule For No Ball With Byes Or Wide Ball With Byes
                        if (flag == "NoBallBye" || flag == "NoBallByeOverThrows") {
                            this.updateExtraCell(row, "nb", 1);
                            this.updateExtraCell(row, "nb", run);
                            // Add Run In Noball Account
                        } else {
                            this.updateExtraCell(row, "w", 1);
                            this.updateExtraCell(row, "w", run);
                            // Add Run In Wideball Account
                        }
                        
                        // Add Run in Byes Account
                        this.updateExtraCell(row, "Extratotal", (parseInt(run) + parseInt(1)))
                       if(flag != "WideBye" ){
	                        this.updateRun(0) // if ball is no + byes and batsman take Run Than We Add Ball To Bowler Account
	                    }
                        this.swapBatsmen()//
                    }
                    else if (flag == "NoBallLegBye" || flag == "NoBallLegByeOverThrows") {
                        this.updateExtraCell(row, "nb", 1);
                        // Add Run In Noball Account
                        this.updateExtraCell(row, "nb", run);
                        // Add Run in LegByes Account
                        this.updateExtraCell(row, "Extratotal", (parseInt(run) + parseInt(1)))
                        this.updateRun(0) // if ball is no +Leg byes and batsman take Run Than We Add Ball To Bowler Account
                        this.swapBatsmen()//
                    } else if (flag == "LegBye" || flag == "LegByeOverThrows") {
                        this.updateExtraCell(row, "lb", run);
                        // Add Run in Byes Account
                        this.updateExtraCell(row, "Extratotal", run)
                        this.updateRun(0) // if byes and batsman take Run Than We Add Ball To Batsman Account
                        this.swapBatsmen()//
                    } else if (flag == "Bye" || flag == "ByeOverThrows") {
                        this.updateExtraCell(row, "b", run);
                        // Add Run in Byes Account
                        this.updateExtraCell(row, "Extratotal", run)
                        this.updateRun(0) // if byes and batsman take Run Than We Add Ball To Batsman Account
                        this.swapBatsmen()//
                    } else if (flag == "Wideoverthrows") {
                        this.updateExtraCell(row, "w", (parseInt(run) + parseInt(1)));
                        // Add Run In Wideball Account
                        this.updateExtraCell(row, "Extratotal", (parseInt(run) + parseInt(1)))
                        this.swapBatsmen();
                    }
                } else {
                    if (flag == "NoBallRun" || flag == "NoBallRunOverThrows") { // Rule For No Ball With Batsman Taken Run
                        this.updateExtraCell(row, "nb", 1)
                        this.updateExtraCell(row, "Extratotal", 1)
                        this.updateRun(run) // if ball is no and batsman take Run Than We Add Run in Batsmen Account
                    } else if (flag == "NoBallBye" || flag == "WideBye" || flag == "NoBallByeOverThrows") { // Rule For No Ball With Byes
                        if (flag == "NoBallBye" || flag == "NoBallByeOverThrows") {
                            this.updateExtraCell(row, "nb", 1);
                            this.updateExtraCell(row, "nb", run);
                            // Add Run In Noball Account
                        } else {
                            this.updateExtraCell(row, "w", 1);
                            this.updateExtraCell(row, "w", run);	
                            // Add Run In Wideball Account
                        }
                 
                        // Add Run in Byes Account
                        this.updateExtraCell(row, "Extratotal", (parseInt(run) + parseInt(1)))
                        if(flag != "WideBye" ){
	                        this.updateRun(0) // if ball is no + byes and batsman take Run Than We Add Ball To Bowler Account
	                    }    
                    }
                    else if (flag == "NoBallLegBye" || flag == "NoBallLegByeOverThrows") {
                        this.updateExtraCell(row, "nb", 1);
                        // Add Run In Noball Account
                        this.updateExtraCell(row, "nb", run);
                        // Add Run in LegByes Account
                        this.updateExtraCell(row, "Extratotal", parseInt(run) + parseInt(1))
                        this.updateRun(0) // if ball is no +Leg byes and batsman take Run Than We Add Ball To Bowler Account
                    } else if (flag == "LegBye" || flag == "LegByeOverThrows") {
                        this.updateExtraCell(row, "lb", run);
                        // Add Run in LegByes Account
                        this.updateExtraCell(row, "Extratotal", run)
                        this.updateRun(0) // if ball is no +Leg by
                    } else if (flag == "Bye" || flag == "ByeOverThrows") {
                        this.updateExtraCell(row, "b", run);
                        // Add Run in LegByes Account
                        this.updateExtraCell(row, "Extratotal", run)
                        this.updateRun(0) // if ball is no +Leg by
                    } else if (flag == "Wideoverthrows") {
                        this.updateExtraCell(row, "w", parseInt(run) + parseInt(1));
                        // Add Run In Wideball Account
                        this.updateExtraCell(row, "Extratotal", (parseInt(run) + parseInt(1)))
                    }
                }
                // set css to striker
                this.setStriker($('BATT_TABLE').rows[striker]);

                // set css to nonstriker
                this.setNonStriker($('BATT_TABLE').rows[nonStriker]);
                
            } catch(err) {
                alert(err.description + 'BCCI.js.bastment.extraUpdate()');
            }

        }

        this.swapBatsmen = function() {
            try {
                var temp = striker;
                striker = nonStriker;
                nonStriker = temp;
            } catch(err) {
                alert(err.description + 'bastment.js.swapBatsmen()');
            }
        }

        this.strikernonStriker = function() { // this function is for help ajex code we got striker id and name useing this code to display in combo box
            try {
                var playerArr = new Array(10);
                playerArr[0] = striker;
                // Store Striker Row
                playerArr[1] = $('BATT_TABLE').rows[striker].cells[COL_BATT_NAME].id;
                // Store Striker Name
                playerArr[2] = nonStriker // Store nonStriker Row
                playerArr[3] = $('BATT_TABLE').rows[nonStriker].cells[COL_BATT_NAME].id;
                // Store Striker Name
            } catch(err) {
                alert(err.description + 'bastment.js.strikernonStriker()');
            }
            return playerArr;
        }
        this.updateWicket = function (flag,credit) {
            try {

                //map for Wicket String
            	var map = new Object();
				var subflag = false;	
                var str = "";
                var outstr = "";
                var divstr="";
                var row = $('BATT_TABLE').rows[striker];
                var divname="div"+row.id;
                if (credit == "bowler") { // this flag is use to excute only bowler credit wickets
                    map.bowler = ballObj.BowlerName();
                    if (flag == 0) { // 0 flag set For Bowled
                        outstr ="";
                        str = "b " + map.bowler;
                        this.updateBatsman(0);
                        this.setOutFlag(0);// flag is 0
                    } else if (flag == 1) { // flag 1 for LBW
                        outstr = "lbw "
                        str = " b " + map.bowler;
                        this.updateBatsman(0);
                        this.setOutFlag(0); // flag is 0
                    } else if (flag == 2 || flag == 12) { // flag 2 for Hit Ball Twice ; 12 - No Ball + Hit The Ball Twice 
                        outstr = "";
                        str = "Hit Ball Twice";
                        this.updateBatsman(0);
                        this.setOutFlag(0);
                    } else if (flag == 3 || flag == 11) { // flag 2 for Hit Wicket ; 11 - Wide + Hit Wicket
                        outstr = "hit wkt ";
                        str = "b" + map.bowler;
                        this.updateBatsman(0);
                        this.setOutFlag(0);
                    }
                    else if (flag == 4 || flag == 9) { // flag 4 for Stump flag 9 for stump + wide
                        var array = (document.getElementById("selName").value).split("~");
                        map.Keeper = array[1] // Name Of Keeper
                        map.KeeperId = array[2] // Id Of Keeper
                        map.sub = array[3];
                        if(map.sub=="P"){
	                        outstr = "st  ";
    	                    str =map.Keeper + " b " + map.bowler;
    	                }else{
    	                	outstr = "st  ";
    	                    str ="(sub)" + map.Keeper + " b " + map.bowler;
    	                }    
                        this.updateBatsman(0);
                        this.setOutFlag(0);
                    } else if (flag == 5) { // flag 5 for Caught
                       var array = (document.getElementById("selFldName").value).split("~");
                        map.Filder = array[1] // Name Of Filder
                        map.FilderId = array[2] // Id Of Filder
                        map.sub = array[3];
                        if(map.sub=="P"){
	                        outstr = "ct ";
    	                    str = map.Filder + " b " + map.bowler;
                        }else{
                        	outstr = "ct ";
    	                    str = "(sub)" + map.Filder + " b " + map.bowler;
                        }
                        if ($('Wickt').innerHTML != "9"){
	                        if (document.getElementById("StrikeChg").value == "1") { // Check Striker is Change Striker or Not
	                            this.updateBatsman(1);
	                            this.setOutFlag(1);
	                            // Striker Change Strik
	                        } else {
	                            this.updateBatsman(0);
	                            this.setOutFlag(0);
	                            // Striker not change strik
	                        }
                        }
                    }else if(flag==27){ // caught by bowler
                    	outstr = "ct&b ";
                        str = map.bowler;
                        //divstr  = "c " + map.Filder + " b " + map.bowler;
                       if ($('Wickt').innerHTML != "9") {
	                        if (document.getElementById("cbbStrikeChg").value == "1") { // Check Striker is Change Striker or Not
	                            this.updateBatsman(1);
	                            this.setOutFlag(1);
	                            // Striker Change Strik
	                        } else {
	                            this.updateBatsman(0);
	                            this.setOutFlag(0);
	                            // Striker not change strik
	                        }
                       } 
                    }else if(flag==28){ // caught by wicket keeper
                    	var array = (document.getElementById("wktselFldName").value).split("~");
                        map.Filder = array[1] // Name Of Filder
                        map.FilderId = array[2] // Id Of Filder
                        map.sub = array[3]
                        if(map.sub=="P"){
                       		outstr = "ct wk ";
                        	str = map.Filder +" b " + map.bowler;
                        }else{
                        	outstr = "ct wk ";
                        	str = "(sub)" + map.Filder +" b " + map.bowler;
                        }	
                        //divstr  = "c " + map.Filder + " b " + map.bowler;
                        if ($('Wickt').innerHTML != "9") { // this is for if last wicket is gon and we select striker change
                        	if (document.getElementById("wktStrikeChg").value == "1") { // Check Striker is Change Striker or Not
                            	this.updateBatsman(1);
	                            this.setOutFlag(1);
                            // Striker Change Strik
    	                    } else {
        	                    this.updateBatsman(0);
            	                this.setOutFlag(0);
                            // Striker not change strik
                	        }
                        }
                    }
                    else if(flag == 26 || flag==22 ||flag ==25){
                    	outstr = ""
                        str = "Handled the ball";
                        this.updateBatsman(0);
                        this.setOutFlag(0); // flag is 0
                    }else if (flag == 6 || flag == 7 || flag == 10 || flag==20 || flag==21 || flag==29) { // flag 6 for Retire Out
                        if (flag == 6) {
                            outstr = ""
                            str = "Retire Out";
                        }else if(flag==29){ 
                        	outstr = ""
                        	str ="Retire Not Out"; 
                        }else if(flag==20){ 
                        	outstr = ""
                        	str ="Retires"; // if thse str will be change than dont forget to change in addrow.js
                        }else if(flag==21){
	                        outstr = "";	
                        	str = "Time Out";	
                        } else if(flag == 7 || flag == 10) {
	                        outstr = "";
                            str = "obstructing the field" 
                        }else if(flag==22 || flag==25 ||flag == 26){// wide+ handle the ball
                           outstr = "";
                        	str = "Handled the ball";
                        }else{
                        	 outstr = ""
                        	 str = "Handled the ball";
                         }
	                    map.batName = document.getElementById("selbatName").value;// change by bushan for sloved obstructing the field error 22/09/2008
						if (map.batName == "0") { // 1 for  Striker Batsman Is Retire Out
						    this.updateBatsman(0);
						    this.setOutFlag(0);
                        } else { // For non Striker Retire Out
                            row = $('BATT_TABLE').rows[nonStriker];
                            this.updateBatsman(2);
                            this.setOutFlag(2);
                        }
                    }// End of Flag 6 and 7
                    else if(flag==22){
                    	var filder1array = (document.getElementById("selFlderName").value).split("~");
                    	 map.filder1 = filder1array[1];
                         map.filder1Id = filder1array[2];
                         map.batName = document.getElementById("selotfbatName").value;
                        	if (map.batName == "0") { // 1 for  Striker Batsman Is Retire Out
	                            this.updateBatsman(0);
	                            this.setOutFlag(0);
    	                    } else { // For non Striker Retire Out
        	                    row = $('BATT_TABLE').rows[nonStriker];
            	                this.updateBatsman(2);
            	                this.setOutFlag(2);
                	        }
                         str = "Handled the ball..";
                         divstr = "(Handled the ball)" + map.filder1 ;
                    }
                    else if (flag == 8 || flag == 13 || flag == 24 || flag == 30 || flag == 31 || flag == 36) { // 8 for Run Out 13 - no ball run out
                        var filder1array = (document.getElementById("selFld1Name").value).split("~");
                        if($$('selFld2Name')==''){
                       	  map.filder2 = "";
                       	  map.filder2Id = "";
                        }else{
                        	var filder2array = (document.getElementById("selFld2Name").value).split("~");
                         	map.filder2 = filder2array[1];
                	        map.filder2Id = filder2array[2];	
                	        map.sub1 = 	trimAll(filder2array[3]);
                        }
	                       
    	                    map.filder1 = filder1array[1];
        	                map.filder1Id = filder1array[2];
        	                map.sub = 	trimAll(filder1array[3]);
            	            map.batName = document.getElementById("selrunoutbatName").value;
                        	map.run = document.getElementById("outruns").value;
                        if(flag==24){ // wide + run out
                        	 this.updateExtraCell(row, "w", map.run);
                        }else if(flag==30){ // b + run out
                        	 this.updateExtraCell(row, "b", map.run);
                        }else if(flag==31){ // lb+ run out
                        	 this.updateExtraCell(row, "lb", map.run);
                        }else if(flag==36){ // lb+ run out
                        	 this.updateExtraCell(row, "nb", map.run);
                        }
                        else{
	                        this.updateCell(row, COL_BATT_RUN, map.run);
	                    }    
						if(map.filder2 == "undefined"){
							map.filder2 ="";
							map.filder2Id ="";
						}	
                        // This Function is Use To Display data on Front Page
                        if (map.filder2 == "") {
                           	outstr ="r.o."
                            if(map.sub=="P"){
	                            str =map.filder1;
	                        }else{
	                        	str ="(sub)" + map.filder1;
	                        }    
                            // if run out done by single player
                        } else {
	                       	outstr ="r.o."
                            if(map.sub!="P" && map.sub1=="P"){
	                            str ="(sub)" + map.filder1 + " / " + map.filder2;
	                        }else if(map.sub1!="P" && map.sub=="P"){
	                        	str = map.filder1 + " / (sub)" + map.filder2;
			                }else if (map.sub!="P" && map.sub1!="P" ){
	                        	str = "(sub) " + map.filder1 + " / (sub) " + map.filder2;
	                        }else{
	                        	str = map.filder1 + " / " + map.filder2;	
	                        }   
                            // if run out done by two player
                        }

                        if (map.batName == "0") { // 3 for  Striker Batsman Is Run Out
                            if(flag==8){
                            	var ballrow = $('BATT_TABLE').rows[striker];
	                            this.updateCell(ballrow, COL_BATT_BALL, 1);
                            }
                            map.batNameId = this.batSetStriker();
                            this.updateBatsman(3);
                            this.setOutFlag(3);
                        } else { // For non Striker Run Out
                        	if(flag==8){
                        		this.updateCell(row, COL_BATT_BALL, 1);
                        	}
                            map.batNameId = this.batSetNonStriker();
                            row = $('BATT_TABLE').rows[nonStriker];
                            
                            this.updateBatsman(4);
                            this.setOutFlag(4);
                        }
                    }
	               //$(divname).innerHTML=divstr;
                    this.updateCell(row, COL_BATT_BOWLER, str);
                    this.updateCell(row, COL_BATT_OUT, outstr);
                    // Thse Functione Use To Display data in Frount Page
                    if (flag != 9 && flag != 8 && flag != 10 && flag != 11 && flag != 12 && flag != 13 && flag!=20 && flag!=21 && flag!=6 && flag!=29 && flag!=24 && flag!=22 && flag!=25) { // 10- Wide/No + Handle The Ball/Obstructing the field ; 9 - WIde + Stump ;11 -Wide + Hit Wicket; 12 - No Ball + Hit The Ball Twice
                        this.updateCell(row, COL_BATT_BALL, 1);
                    }
                    this.strikerate(row);	
                     var oldtimer = $( 'time_' + row.id ).innerHTML
                     //$( 'time_' + row.id ).innerHTML= oldtimer+ "&nbsp;&nbsp;&nbsp;&nbsp;<b>Out Time:-</b><label>" + this.time() + "</label>";
                     //$( 'time_' + row.id ).style.width="300px";

                    
                }//	End Of Caught If
                if(row.rowIndex % 2 ==0){    // change Css When over is Completed
                    row.className = 'contentDark';
                }else{
                    row.className = 'contentLight';
                }
                  // set css to nonstriker
                this.setNonStriker($('BATT_TABLE').rows[nonStriker]);
                return map;
            } catch(err) {
                alert(err.description + 'BCCI.js.bastment.updateWicket()');
            }
        }// end of update wicket function-Archana
        //
        this.updateCell = function (row, cell_no, newData) {// Use To Display Data
            try {
                var data = parseInt(row.cells[cell_no].innerHTML);
	            if (isNaN(data) == false) {
                    row.cells[cell_no].innerHTML = parseInt(data) + parseInt(newData);
                    //eval added by dipti
                } else {
                    row.cells[cell_no].innerHTML =newData ;
                }
                if (isNaN(row.cells[COL_BATT_RUN].innerHTML)) {
                    row.cells[COL_BATT_RUN].innerHTML = "0";
                }
                row.className = 'striker';
            }
            catch(err) {
                alert(err.description + 'BCCI.js.bastment.updateCell()');
            }
        }// end of updateCell
        
        this.updateBatsman = function(flag) {
            try {
                var num;
                if (flag == "0" || flag == "3") { // flag 0  for new player play  || 3 For Run out
                    if (parseInt(striker) < parseInt(nonStriker)) {
                        num = nonStriker;
                    } else {
                        num = striker;
                    }
                    num = parseInt(num) + parseInt(1);
                    num = this.findNewBatsmanRow (num);
                    striker = num;
                    if (flag == "3") { // This Flag is For Runout + BatsmanTaken Run
                          if (document.getElementById("runoutStrikeChg").value == "1") { // Check Striker is Change Striker or Not
                          // Striker Change Strik
                           this.swapBatsmen();
                          }
                    }
                    //this.setStriker($('BATT_TABLE').rows[striker]);
                }
                if (flag == "1") { // flag 1 for  non striker player play
                    if (parseInt(striker) < parseInt(nonStriker)) {
                        num = nonStriker;
                    } else {
                        num = striker;
                    }
                    num = parseInt(num) + parseInt(1);
                    num = this.findNewBatsmanRow (num);
                    striker = nonStriker;
                    nonStriker = num;
                }
                if (flag == "2" || flag == "4") {// This Flag is for If Non Striker Is Retire Out || and 4 for runout
                    if (parseInt(striker) < parseInt(nonStriker)) {
                        num = nonStriker;
                    } else {
                        num = striker;
                    }
                    num = parseInt(num) + parseInt(1);
                    num = this.findNewBatsmanRow (num);
                    nonStriker = num;
                    if (flag == "4") { // This Flag is For Runout + BatsmanTaken Run
                        if (document.getElementById("runoutStrikeChg").value == "1") { // Check Striker is Change Striker or Not
                          // Striker Change Strik
                           this.swapBatsmen();
                        }
                    }
                   // this.setStriker($('BATT_TABLE').rows[striker]);
                }
               
				this.setNewBatsmanRowId(num);
            } catch(err) {
                alert(err.description + 'bastment.js.updateBatsman()');
            }
        }
		
		this.findNewBatsmanRow = function(num){ // find row id for new batsman
			try{
				var rowid = num;
				var rowflag = false;
				var batsmanOUT_COL;
				var batsmanBOWLER_COL;
				var rownum;
				while(parseInt(rowid) < 12){
					batsmanOUT_COL = $('BATT_TABLE').rows[rowid].cells[COL_BATT_OUT].innerHTML;
					batsmanBOWLER_COL = $('BATT_TABLE').rows[rowid].cells[COL_BATT_BOWLER].innerHTML;
					if(rowflag == false){				
						if((batsmanOUT_COL=="" && batsmanBOWLER_COL=="") || (isNaN(batsmanOUT_COL) && isNaN(batsmanBOWLER_COL))){
							rownum = rowid;
							rowflag = true;
						}
					}
					rowid = rowid + 1;		
				}
				return rownum;
			}catch(err){
			 	 alert(err.description + 'bastment.js.findNewBatsmanRow()');	
			}	
		}
        this.updateExtraCell = function (row, Id, run) {
            try {
                var data = parseInt(document.getElementById(Id).innerHTML);
              if (isNaN(data) == false) {
                   document.getElementById(Id).innerHTML = eval(data) + eval(run);
                    //eval added by dipti
                } else {
                    document.getElementById(Id).innerHTML = run;
                }
                row.className = 'striker';
               
            } catch(err) {
               // alert(err.description + 'BCCI.js.bastment.updateExtraCell()');
            }
        }

        this.setStriker = function (row) {
            try {
            	
				var wicket = callFun.ballwicketFlag();
				if ($('Wickt').innerHTML=="9" && wicket==true) {
				}else{
					row.className = 'striker';
					if($("bastman_right"+row.id).value=="1"){
						$("wagon_wheel_id").src="../images/rh_wagon_wheel.jpg"
					}else{
						$("wagon_wheel_id").src="../images/lh_wagon_wheel.jpg"
					}	
				}
            } catch(err) {
                alert(err.description + 'BCCI.js.bastment.setStriker()');
            }
        }

        this.setNonStriker = function (row) {
            try {
            	 var wicket = callFun.ballwicketFlag();
            	 if ($('Wickt').innerHTML =="9" && wicket==true) {
	             }else{
	             	row.className = 'nonStriker';
	             }   
            } catch(err) {
                alert(err.description + 'BCCI.js.bastment.setNonStriker()');
            }
        }
        this.setswapStrikerNonStriker = function(){
          try{  
            striker = parseInt($("txtstrikerbatsman").value);
            nonStriker = parseInt($("txtnonstrikerbatsman").value);
            closePopup('BackgroundDiv','changestrikerPosition')
            this.changeCSS();
          }catch(err) {
                alert(err.description + 'BCCI.js.bastment.setswapStrikerNonStriker()');
            }  
        }
        this.PrintAllValues = function(){
         	undo.rowID = $('BATT_TABLE').rows[striker].id;
        	undo.tempName =  $('BATT_TABLE').rows[striker].cells[COL_BATT_NAME].innerHTML;
        	undo.tempRun = $('BATT_TABLE').rows[striker].cells[COL_BATT_RUN].innerHTML; 
        	undo.tempBall = $('BATT_TABLE').rows[striker].cells[COL_BATT_BALL].innerHTML;      	
			undo.tempMinite = $('BATT_TABLE').rows[striker].cells[COL_BATT_MINUTS].innerHTML;
			undo.tempFour = $('BATT_TABLE').rows[striker].cells[COL_BATT_FOUR].innerHTML;
			undo.tempSix = $('BATT_TABLE').rows[striker].cells[COL_BATT_SIX].innerHTML;					
			undo.tempSR = $('BATT_TABLE').rows[striker].cells[COL_BATT_SR].innerHTML;
			return undo;			
		}
		
		this.showBatsmanLandMark = function(row,lastBallRuns){
			try{
				var totalRuns = parseInt( row.cells[COL_BATT_RUN].innerHTML ) - parseInt( lastBallRuns );
				var totalball = row.cells[COL_BATT_BALL].innerHTML; 
				var matchtime = row.cells[COL_BATT_MINUTS].innerHTML; 
				var mark = totalRuns%50 + parseInt(lastBallRuns);
				if( parseInt(lastBallRuns) > 0 && parseInt(mark) >= 50 ){
					$('batsmanlandmarkrun').innerHTML = "Congratulations!&nbsp;&nbsp;&nbsp;"+ row.cells[COL_BATT_NAME].innerHTML +"  Completed " + row.cells[COL_BATT_RUN].innerHTML +"  Runs in  "+ totalball +"  ball and  "+ matchtime +"  Minutes."
	           		showPopup('BackgroundDiv','batsmanlandmark');
				}
			}catch(err){
				alert(err.description + 'BCCI.js.bastment.showBatsmanLandMark()');
			}	
		}
		
		this.showPaternshipLandmark = function(lastBallRuns){
			try{
				var landmarkrun;
        		var remindar;
        		var totalball = 0;
        		var batsmanball = 0;
        		var wicket = callFun.ballwicketFlag();
        		var matchtime = $$('hdmatchtime');
        		/*This logic for count total ball*/
				if (($('Wickt').innerHTML =="9" || $('Wickt').innerHTML =="10") && wicket==true) {
				}else{
				var strikerfourrun = $('BATT_TABLE').rows[striker].cells[COL_BATT_FOUR].innerHTML;
				var nonstrikerfourrun = $('BATT_TABLE').rows[nonStriker].cells[COL_BATT_FOUR].innerHTML;
				var fourcounter = parseInt(strikerfourrun) + parseInt(nonstrikerfourrun);
				
				var strikersixrun = $('BATT_TABLE').rows[striker].cells[COL_BATT_SIX].innerHTML;
				var nonstrikersixrun = $('BATT_TABLE').rows[nonStriker].cells[COL_BATT_SIX].innerHTML;
				var sixcounter = parseInt(strikersixrun) + parseInt(nonstrikersixrun);
				
				totalball = callFun.getPatenershipBall();  
				var strikerMin = $('BATT_TABLE').rows[striker].cells[COL_BATT_MINUTS].innerHTML;
				var nonstrikermin = $('BATT_TABLE').rows[nonStriker].cells[COL_BATT_MINUTS].innerHTML;
				if(parseInt(strikerMin) > parseInt(nonstrikermin)) {
					matchtime = nonstrikermin;
				}else {
					matchtime = strikerMin;
				}
				var strikerName =  $('BATT_TABLE').rows[striker].cells[COL_BATT_NAME].innerHTML;
				var strikerId = $('BATT_TABLE').rows[striker].id; 
				var nonStrikerName = $('BATT_TABLE').rows[nonStriker].cells[COL_BATT_NAME].innerHTML;
				var nonStrikerId = $('BATT_TABLE').rows[nonStriker].id; 
				var lastwicketrun = $("lstWicket").innerHTML 
				var totalRuns = parseInt( $("total").innerHTML ) - parseInt( lastBallRuns ) - parseInt(lastwicketrun);
				var mark = totalRuns%50 + parseInt(lastBallRuns);
				var partershiprun = parseInt(totalRuns) + parseInt(lastBallRuns);
					if( parseInt(lastBallRuns) > 0 && parseInt(mark) >= 50 ){
						ajexObj.sendpatenership(strikerId,nonStrikerId,strikerName,nonStrikerName,partershiprun,totalball,matchtime)
						showPopup('BackgroundDiv','partnershiplandmark');
					}
				}	
				
			}catch(err){
				alert(err.description + 'BCCI.js.bastment.showPaternshipLandmark()');
			}
		}
		
		this.totalBall = function(){
			try{
				var batsmanball;
				var totalball = 0;
				for(var i=1;i<12;i++){
        			if($('BATT_TABLE').rows[i].cells[COL_BATT_BALL].innerHTML==null || $('BATT_TABLE').rows[i].cells[COL_BATT_BALL].innerHTML=='' || isNaN($('BATT_TABLE').rows[i].cells[COL_BATT_BALL].innerHTML)){
        				batsmanball = 0;
	        		}else{
    	    			batsmanball = $('BATT_TABLE').rows[i].cells[COL_BATT_BALL].innerHTML;
        			}
        			totalball = parseInt(totalball) + parseInt(batsmanball);
           		}
           		return totalball;	
           	}catch(err){
           		alert(err.description + 'BCCI.js.bastment.totalBall()');
           	}	
		}
		this.setBatSrtiker = function(){// Archana 12/08/2008 Created By Me 
			return striker;
		}
		
		this.setNewBatsmanRowId = function(row){
			rowNumber = row;
		}	
		this.getNewBatsmanRoWId = function(){
			return rowNumber;
		}
    } catch(err) {
        alert(err.description + 'BCCI.js.bastment.bastment()');
    }

    this.batRowNumber= function(){
        try{
            for(var i=1;i<12;i++){
                $('BATT_TABLE').rows[i].cells[COL_BATT_NUMBER].innerHTML=i;
            }
        }catch(err){
              alert(err.description + 'BCCI.js.bastment.batRowNumber()');
        }
    }
    
    this.checkBowlerRow = function(){
    	try{
            if($('BATT_TABLE').rows[1].cells[COL_BATT_NAME].innerHTML=="null") {
            	alert("You are deleting all entry for this inning so please close this window for security reason.")
            }
            
         }catch(err){
               alert(err.description + 'BCCI.js.bastment.checkstartmatchstatus()');
         }
    }
    this.checkRetireout = function(){
        var maxnum;
        var str = "";    
         if ($('Wickt').innerHTML != "10"){
            if(isNaN($('Wickt').innerHTML)){
                maxnum = 3;
            }else{
                maxnum = parseInt($('Wickt').innerHTML) + parseInt(3);
            }    
            for(i=maxnum;i<12;i++){
                if(i==11){
                    str = str +" " +  $('BATT_TABLE').rows[i].cells[COL_BATT_NAME].innerHTML;
                }else{ 
                    str = str +" " +  $('BATT_TABLE').rows[i].cells[COL_BATT_NAME].innerHTML+",";
                }
            }
            var r = confirm(str + "have not batted as of now. Whether these players are retired out or retired not out? If Yes,then please click on OK button and make all these players retired out for getting proper result. Otherwise, click cancel button to complete the inning.");
            if (r == false) {
                callFun.endInning();
            }else{
            	//showPopup('BackgroundDiv', 'retireOutDiv');
            }	
            
         }
    }
    this.currentTime = function(){
        try{
            currentTime=this.time();
            $( 'time_' + $('BATT_TABLE').rows[striker].id ).innerHTML = "<b>In Time:-</b><label id=time"+$('BATT_TABLE').rows[striker].id + ">" + currentTime +"</label>";
            $( 'time_' + $('BATT_TABLE').rows[nonStriker].id ).innerHTML ="<b>In Time:-</b><label id=time"+$('BATT_TABLE').rows[nonStriker].id + ">" + currentTime +"</label>";
        }catch(err){
            alert(err.description + 'BCCI.js.bastment.currentTime()');
        }
    }
    
    this.time= function(){
        try{
            var today = new Date();
            var h = today.getHours();
            var m = today.getMinutes();
            var s = today.getSeconds();
            m = parseInt(m) + parseInt(1);
            if(m >=60){
            	m=0;
            	h = parseInt(h) + parseInt(1)
            }
            Time = h + ":" + m;
            return Time;
       }catch(err){
            alert(err.description + 'BCCI.js.bastment.time()');
        }
    }
    
    this.playerTime = function(){
        try{
	       	var wicket = callFun.ballwicketFlag();
	       	if (($('Wickt').innerHTML =="9" ||$('Wickt').innerHTML =="10")  && wicket==true) {
			}else if (wicket==true){
	       	}
			else{
	         	if($('BATT_TABLE')!=null){
	         	    var strikerTime = this.calculateBatsmanTime($('BATT_TABLE').rows[striker]);
		            if(strikerTime=='NaN'){
		            	strikerTime="";
		            }
	   	            $('BATT_TABLE').rows[striker].cells[COL_BATT_MINUTS].innerHTML = strikerTime;
		            var nonStrikerTime = this.calculateBatsmanTime($('BATT_TABLE').rows[nonStriker]);
					if(strikerTime=='NaN'){
		            	nonStrikerTime="";
		            }
				    $('BATT_TABLE').rows[nonStriker].cells[COL_BATT_MINUTS].innerHTML = nonStrikerTime;
			  	}
		  	}// end of wicket if	        
        }catch(err){
            alert(err.description + 'BCCI.js.bastment.playerTime()');
        }
    }
    this.setOutFlag = function(flagid){
    	try{
    		retireflag = flagid;
    	}catch(err){
    		alert(err.description + 'bastment.js.setOutFlag()');
    	}
    }
    this.getOutFlag  = function(){
    	try{
    		return retireflag; 
    	}catch(err){
    		alert(err.description + 'bastment.js.getOutFlag()');
    	}
    }
    this.setmatchtimerflag = function(flag){
    	matchstartflag = flag;
    }
    this.getmatchtimerflag = function(){
   	    return matchstartflag;	
    }
    this.calculateBatsmanTime = function(row){
        try{
        	var wicket = callFun.ballwicketFlag();
        	if (($('Wickt').innerHTML =="9" || $('Wickt').innerHTML =="10")&& wicket==true) {
	       		}else{
	       	    var previoustime;
	            if(isNaN(row.cells[COL_BATT_MINUTS].innerHTML)){
	            	previoustime = "0";
	            }else{
	            	previoustime = parseInt(row.cells[COL_BATT_MINUTS].innerHTML);
	            }
	            if(isNaN(previoustime)){
	            	previoustime = "0";
	            }
	        	var batsmanTime =parseInt(previoustime) + parseInt(1);
	            return batsmanTime;
		    	}     
        }catch(err){
            alert(err.description + 'bastment.js.calculateBatsmanTime()');                
        }
    }
	this.getstrikerRowId = function(){
		return striker;
	}
	this.getnonStrikerRowId = function(){
		return nonStriker;
	}
	this.setbatsmancss = function(){
	  var wicket = callFun.ballwicketFlag();
	  if ($('Wickt').innerHTML =="10" && wicket==true){
	  }else{
		$('BATT_TABLE').rows[striker].className = 'striker';
		$('BATT_TABLE').rows[nonStriker].className = 'nonStriker';
		if($("bastman_right"+$('BATT_TABLE').rows[striker].id).value=="1"){
			$("wagon_wheel_id").src="../images/rh_wagon_wheel.jpg"
		}else{
			$("wagon_wheel_id").src="../images/lh_wagon_wheel.jpg"
		}
	  }	
	}	
    this.interval = function(id){
    }
}

function upadteBastmanMinuts(){
	var matchstartflag = bastmenObj.getmatchtimerflag();
	if(matchstartflag=="start"){
		var time =  document.getElementById('hdmatchtime').value;
       	var inningtime = document.getElementById('hdtotalInningMint').value;
        document.getElementById('hdmatchtime').value = parseInt(time) + parseInt(1); 
	   	document.getElementById('hdtotalInningMint').value = parseInt(inningtime) + parseInt(1); 
		bastmenObj.playerTime();
	}	
}
function updateBatsmanTableTime(){
	for(var i=0;i<12;i++){
		if($('BATT_TABLE').rows[i].cells[COL_BATT_MINUTS].innerHTML =="NaN"){
			$('BATT_TABLE').rows[i].cells[COL_BATT_MINUTS].innerHTML="";
		}
	}
}
// end of bastment class
