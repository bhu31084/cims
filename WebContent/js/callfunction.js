/*modifyed Date:23-10-2008*/
var callFun = new Function();

function Function() { // declear bastmen class
	var leng;
	var runid;
	var runname;
	var runs;
	var runsid;
	var isExtra;
	var inningId;
	var divname = "";
	var runTypeId; // set run type id witch is use to set in database
	var extraTypeId; //set extra type id witch is use to set in database
	var pitchFlag = false; // set flag for pitch
	var pitchPos; // set position for pitch
	var groundFlag = false; // set ground flag 
	var groundPos; // set ground Pos
	var scoreFlag = false; // set scoreFlag
	var newData = new Object(); // create map for new data
	//	var oldData = new Object(); // create map for old data witch is insertd in database
	var retireId; // set database id for retire
	var wicket = new Object();
	var matchFlag = false;
	var penaltyFlag = false;
	var pitchpostion = null; //these value is use to set pitch position id
	var res;
	var dateflag = null;
	var runflag = "1";
	var dismissalflag = "2";
	var batsmanStriker;
	var newBallFlag = false;
	var bowlerId = 1; // this variable is set for decied how many row are completed in bowler table so if new bowler is came we increment this variable.
	var interval = null; // set what type of interval
	var remark = null;
	var wicketFlag = false;
	var patenershipball = 0;
	var landmarkflag = true; // this flag is user when team completed landmark
	//newData is hashtable following variables are to enter values in DB.
	newData.inning_id = null;
	newData.date = null;
	newData.striker = null;
	newData.non_striker = null;
	newData.blower = null;
	newData.pitch_pos = null;
	newData.ground_pos = null;
	newData.bowlstyle = 1;
	newData.over_num = null;
	newData.over_wkt = null;
	newData.penalty = null;
	newData.new_ball = null;
	newData.description = null;
	newData.runtype = null;
	newData.extratype = null;
	newData.extrarun = null; // if no ball + bye + run like condition will be come than we use extrarun field
	newData.dismissalType = null;
	newData.dismissalBatsman = null;
	newData.dismissalBy1 = null;
	newData.dismissalBy2 = null;
	newData.canreturn = null;
	newData.flag = null;
	COL_BATT_OUT = 3;
	COL_BATT_BOWLER = 4;
	var changebowlerflag = false;

	var undoBatcallFunction = new Object() // undo logic Archana 13/08/2008
	var undoBallcallFunction = new Object() // undo logic Archana 13/08/2008
	var undoScorecallFunction = new Object() // undo logic Archana 13/08/2008
	var settype;

	this.runVariable = function() {//to get run from db table runtypemap for getting id.
		try {
			runid = (document.getElementById('runid').value).split("~");
			runname = (document.getElementById('runname').value).split("~");
			runs = (document.getElementById('runs').value).split("~");
			isExtra = (document.getElementById('isExtra').value).split("~");
			inningId = document.getElementById('inningId').value;
			leng = runid.length;

		} catch (err) {
			alert(err.description + 'callFunction.js.runVariable()');
		}
	}
	this.setpatenership = function() {//aft refresh to increment partnership runs
		patenershipball = $$('hdcurrentpatnershipball');
	}
	this.resetpatenership = function() {//aftr wicket reset.
		patenershipball = 0;
	}
	this.setPatenershipBall = function(ball) {//increment  each ball
		patenershipball = parseInt(patenershipball) + parseInt(ball);
	}
	this.getPatenershipBall = function() {//partnership popup
		return patenershipball;
	}
	this.addPitch = function(id) {//x y position id stored on DB
		try {
			pitchpostion = id;
			pitchFlag = true;
		} catch (err) {
			alert(err.description + 'callFunction.js.addPitch()');
		}
	}
	this.addGround = function(id) {//x y position id stored on DB(wagon wheel)
		try {
			groundPos = id;
			groundFlag = true;
		} catch (err) {
			alert(err.description + 'callFunction.js.addPitch()');
		}
	}
	this.powerplay = function() {//alert
		try {
			alert("Power play taken");
		} catch (err) {
			alert(err.description + 'callFunction.js.powerplay()');
		}

	}
	this.callFunction = function(type, run) {//callFinction start
		try {
			//  this.convertData();
			if (!$('chkonline').checked) {
				this.updateTime();
			}
			wicketFlag = false; // to identified wicket is gon in this ball or not
			this.newData(); // this function are use to take new data for perticular ball
			if (penaltyFlag == false) { // this flag set because when we set paanalty flag after that in next flag we reset the flag
			}
			if (pitchFlag == true) {
				newData.pitch_pos = pitchpostion;
				pitchFlag = false;
			}
			if (groundFlag == true) {
				newData.ground_pos = groundPos;
				groundFlag == false;
			}
			pitchpostion = null;
			//To update simple runs.
			if (type == "ball") {//  Function For  Ball + runs This Condition for 1 run to 8 run
				var r = confirm("You have selected " + run
						+ " Runs. Do you want to continue?");
				if (r == true) {
					landmarkflag = true; // this flag indicate ball is not increase(if thr is no ball)
					this.setPatenershipBall(1);
					newData.flag = '1';
					for (i = 1; i <= leng; i++) {
						runsid = parseInt(run) + parseInt(1) // these is for in database in id start from 1 e.g. for 0 runs in database id is 1
						if (runs[i] == runsid) { // zero is same as in database runtype_mst table
							newData.runtype = runs[i];
							res = this.callAjex(); // Call Database Ajex Function//to insert in DB
							if (res) {//To display in front end
								bastmenObj.updateRun(run);
								scoreObj.updateRun(run);
								ballObj.updateRun(run);
								hideMenu();
							}
							break;
						}// end of run if
					}// end of for
				}// end of confirmation if 
			} else if (type == "sixruns") { // this logic for if click on link four and six
				var r = confirm("You have selected " + run
						+ " Runs. Do you want to continue?");
				if (r == true) {
					landmarkflag = true; // this flag indicate ball is not increase
					this.setPatenershipBall(1);
					newData.flag = '1';
					for (i = 1; i <= leng; i++) {
						runsid = parseInt(run) + parseInt(1) // these is for in database in id start from 1 e.g. for 0 runs in database id is 1
						newData.runtype = "27";
						res = this.callAjex(); // Call Database Ajex Function
						if (res) {
							bastmenObj.fourRun(run);
							scoreObj.updateRun(run);
							ballObj.updateRun(run);
							hideMenu();
						}
						break;
					} // end if for
				}// end of confirmation if 
			} else if (type == "nofour") { // this logic for if click on link foure
				var r = confirm("You have selected " + run
						+ " Runs. Do you want to continue?");
				if (r == true) {
					landmarkflag = true; // this flag indicate ball is not increase
					this.setPatenershipBall(1);
					newData.flag = '1';
					for (i = 1; i <= leng; i++) {
						runsid = parseInt(run) + parseInt(1) // these is for in database in id start from 1 e.g. for 0 runs in database id is 1
						newData.runtype = "26";
						res = this.callAjex(); // Call Database Ajex Function
						if (res) {
							bastmenObj.fourRun(run);
							scoreObj.updateRun(run);
							ballObj.updateRun(run);
							hideMenu();
						}
						break;
					}// end of for 
				}// end of confirmation if 
			} else if (type == "wideplus") { // on Wide Image Function
				hideMenu();

			} else if (type == "wide") { // this condition for wide ball
				hideMenu();
				var r = confirm("You have selected Wide Ball. Do you want to continue?");
				if (r == true) {
					landmarkflag = false; // this flag indicate ball is not increase
					newData.flag = '1';
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'wide') { // wide is same as in database runtype_mst table 
							newData.runtype = runid[i];
							res = this.callAjex();
							if (res) {
								bastmenObj.extraUpdate(run, 'wide');
								scoreObj.extraUpdate(run);
								ballObj.extraUpdate(run, 'wide');

							}
						}
					}
				}// end of confirmation if 	  
			} else if (type == "wideoverthrow") {
				extratype('Wideoverthrows');
				showState('wideplussubmenu');
			} else if (type == "widebye") {
				extratype('WideBye');
				showState('wideplussubmenu');//sub menu like 1 2 3 ...
			} else if (type == "wideplusemenu") { // For All Wide  + All type + All Run Function
				// this flag is use for insert runid and extra id in ball_runtype_map  table
				hideMenu();
				var r = confirm("You have selected Wide Ball With " + run
						+ " Runs. Do you want to continue?");
				if (r == true) {
					landmarkflag = false; // this flag indicate ball is not increase
					for (i = 0; i < leng; i++) {
						newData.flag = '6';
						if (runname[i] == 'wide') {
							newData.extratype = runid[i];
						}
						if (runname[i] == 'bye') {
							newData.extrarun = runid[i];
						}
						if (runs[i] == run) {
							newData.runtype = runid[i];
						}
					}
					res = this.callAjex(); // Call Database Ajex Function
					if (res) {
						bastmenObj.extraUpdate(run, "WideBye");
						scoreObj.extraUpdate(run);
						ballObj.extraUpdate(run, "WideBye");
					}
				}// end of confirmation if 	     
			} else if (type == "noballplusruns") {
				hideMenu();

			} else if (type == "noball") {
				hideMenu();
				var r = confirm("You have selected No Ball.Do you want to continue?");
				if (r == true) {
					landmarkflag = false; // this flag indicate ball is not increase
					this.setPatenershipBall(1);
					newData.flag = '1';
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'noball') { // noball is same as in database runtype_mst table
							newData.runtype = runid[i];
							res = this.callAjex();
							if (res) {
								bastmenObj.extraUpdate(0, 'noball');
								scoreObj.extraUpdate(0);
								ballObj.extraUpdate(0, 'noball');

							}
						}// end of runs  if 
					}// end of for
				}// end of confirmation if 	  			        
			} else if (type == "noballrun") {
				document.getElementById("noballbatplussubmenuboudry").style.display = 'none';
				extratype('NoBallRun');
				showState('noballbatplussubmenu');
			} else if (type == "noballrunoverthrow") {
				extratype('NoBallRunOverThrows');
				showState('noballbatplussubmenu');
			} else if (type == "noballbye") {
				extratype('NoBallBye');
				showState('morenoballbatplussubmenu');
			} else if (type == "noballbyeoverthrow") {
				extratype('NoBallByeOverThrows');
				showState('morenoballbatplussubmenu');
			} else if (type == "noballlegbye") {
				extratype('NoBallLegBye');
				showState('morenoballbatplussubmenu');
			} else if (type == "noballlegbyeoverthrow") {
				extratype('NoBallLegByeOverThrows');
				showState('morenoballbatplussubmenu');
			} else if (type == "noballboundryrun") {
				document.getElementById("noballbatplussubmenu").style.display = 'none';
				extratype('NoBallRun');
				showState('noballbatplussubmenuboudry');
			} else if (type == "noballsubmenu") {
				if ($$('selType') == 'NoBallRun') {
					var r = confirm("You have selected " + run
							+ " runs with NoBall.Do you want to continue?");
				} else {
					var r = confirm("You have selected "
							+ run
							+ " Extra runs with NoBall.Do you want to continue?");
				}
				if (r == true) {
					landmarkflag = false; // this flag indicate ball is not increase
					this.setPatenershipBall(1);
					for (i = 0; i < leng; i++) {
						if ($$('selType') == 'NoBallRun') { // For No Ball + Run
							if (runname[i] == 'noball') {
								newData.flag = '5'; // this flag is use for insert runid and extra id in ball_runtype_map  table	
								newData.extratype = runid[i];
							}
						} else if ($$('selType') == 'noballrunoverthrow') {
							if (runname[i] == 'noball') {
								newData.flag = '5'; // this flag is use for insert runid and extra id in ball_runtype_map  table
								newData.extratype = runid[i];
							}
						} else if ($$('selType') == 'NoBallBye') {
							newData.flag = '6'; // this flag is use for insert runid and extra id in ball_runtype_map  table
							if (runname[i] == 'noball') {
								newData.extratype = runid[i];
							}
							if (runname[i] == 'bye') {
								newData.extrarun = runid[i];
							}

						} else if ($$('selType') == 'NoBallLegBye') {
							newData.flag = '6'; // this flag is use for insert runid and extra id in ball_runtype_map  table
							if (runname[i] == 'noball') {
								newData.extratype = runid[i];
							}
							if (runname[i] == 'legbye') {
								newData.extrarun = runid[i];
							}
						} else if ($$('selType') == 'NoBallByeOverThrows') {
							newData.flag = '6'; // this flag is use for insert runid and extra id in ball_runtype_map  table
							if (runname[i] == 'noball') {
								newData.extratype = runid[i];
							}
							if (runname[i] == 'bye') {
								newData.extrarun = runid[i];
							}
						} else if ($$('selType') == 'noballlegbyeoverthrow') {
							newData.flag = '6'; // this flag is use for insert runid and extra id in ball_runtype_map  table
							if (runname[i] == 'noball') {
								newData.extratype = runid[i];
							}
							if (runname[i] == 'legbye') {
								newData.extrarun = runid[i];
							}
						}
						if (runs[i] == run) {
							newData.runtype = runid[i];
						}
					}// end of for
					res = this.callAjex(); // Call Database Ajex Function
					if (res) {
						bastmenObj.extraUpdate(run, $$('selType'));
						scoreObj.extraUpdateNoBall(run, $$('selType'));
						ballObj.extraUpdate(run, $$('selType'));
						hideMenu();
					}// end if res
				} // end of confirmation if       
			} else if (type == "noballsubmenunoboundry") {
				var r = confirm("You have selected " + run
						+ " runs with NoBall.Do you want to continue?");
				if (r == true) {
					landmarkflag = false; // this flag indicate ball is not increase
					this.setPatenershipBall(1);
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'noball') {
							newData.flag = '5'; // this flag is use for insert runid and extra id in ball_runtype_map  table	
							newData.extratype = runid[i];
						}
					}
					newData.runtype = "26"
					res = this.callAjex(); // Call Database Ajex Function
					if (res) {
						bastmenObj.extraUpdate(run, "NoBallboundryRun");
						scoreObj.extraUpdateNoBall(run, "NoBallRun");
						ballObj.extraUpdate(run, "NoBallRun");
						hideMenu();
					}// end if res  
				} // end of confirmation if          
			} else if (type == "noballbatsubmenunosix") {
				var r = confirm("You have selected " + run
						+ " runs with No Ball.Do you want to continue?");
				if (r == true) {
					landmarkflag = false; // this flag indicate ball is not increase
					this.setPatenershipBall(1);
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'noball') {
							newData.flag = '5'; // this flag is use for insert runid and extra id in ball_runtype_map  table	
							newData.extratype = runid[i];
						}
					}
					newData.runtype = "27"
					res = this.callAjex(); // Call Database Ajex Function
					if (res) {
						bastmenObj.extraUpdate(run, "NoBallboundryRun");
						scoreObj.extraUpdateNoBall(run, "NoBallRun");
						ballObj.extraUpdate(run, "NoBallRun");
						hideMenu();
					}// end if res    
				} // end of confirmation if             
			} else if (type == "noballbatsubmenunoboundry") {
				var r = confirm("You have selected " + run
						+ " runs with No Ball.Do you want to continue?");
				if (r == true) {
					landmarkflag = false; // this flag indicate ball is not increase
					this.setPatenershipBall(1);
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'noball') {
							newData.flag = '5'; // this flag is use for insert runid and extra id in ball_runtype_map  table	
							newData.extratype = runid[i];
						}
					}
					newData.runtype = "5"
					res = this.callAjex(); // Call Database Ajex Function
					if (res) {
						bastmenObj.extraUpdate(run, "NoBallRun");
						scoreObj.extraUpdateNoBall(run, $$('selType'));
						ballObj.extraUpdate(run, $$('selType'));
						hideMenu();
					}// end of res  
				} // end of confirmation if             
			} else if (type == "noballsubmenunosix") {
				var r = confirm("You have selected " + run
						+ " runs with No Ball.Do you want to continue?");
				if (r == true) {
					landmarkflag = false; // this flag indicate ball is not increase
					this.setPatenershipBall(1);
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'noball') {
							newData.flag = '5'; // this flag is use for insert runid and extra id in ball_runtype_map  table	
							newData.extratype = runid[i];
						}
					}
					newData.runtype = "7"
					res = this.callAjex(); // Call Database Ajex Function
					if (res) {
						bastmenObj.extraUpdate(run, "NoBallRun");
						scoreObj.extraUpdateNoBall(run, $$('selType'));
						ballObj.extraUpdate(run, $$('selType'));
						hideMenu();
					}
				}// end of confirmation if 	 
			} else if (type == "byerun") {
				extratype('Bye');
				showState('byesplussubmenu')
			} else if (type == "byeoverthrow") {
				extratype('ByeOverThrows');
				showState('byesplussubmenu')
			} else if (type == "byessubmenu") { // Byes + All Function + All Run
				var r = confirm("You have selected " + run
						+ " byes runs.Do you want to continue?");
				if (r == true) {
					landmarkflag = true; // this flag indicate ball is not increase
					this.setPatenershipBall(1);
					newData.flag = '5'; // this flag is use for insert runid and extra id in ball_runtype_map  table
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'bye') {
							newData.extratype = runid[i];
						}
						if (runs[i] == run) {
							newData.runtype = runid[i];
						}
					}
					res = this.callAjex(); // Call Database Ajex Function
					if (res) {
						bastmenObj.extraUpdate(run, "Bye");
						scoreObj.updateTotalRuns(run);
						ballObj.updateByeLegByeRun(run);
						hideMenu();
					}// end if res
				}// end of confirmation if 	     
			} else if (type == "legbyesplus") {

			} else if (type == "legbyerun") {
				extratype('LegBye');
				showState('legbyessubmenu');
			} else if (type == "legbyeoverthrow") {
				extratype('LegByeOverThrows');
				showState('legbyessubmenu');
			} else if (type == "legbyessubmenu") {
				var r = confirm("You have selected " + run
						+ " leg byes runs.Do you want to continue?");
				if (r == true) {
					landmarkflag = true; // this flag indicate ball is not increase
					this.setPatenershipBall(1);
					newData.flag = '5'; // this flag is use for insert runid and extra id in ball_runtype_map  table
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'legbye') {
							newData.extratype = runid[i];
						}
						if (runs[i] == run) {
							newData.runtype = runid[i];
						}
					}
					res = this.callAjex(); // Call Database Ajex Function
					if (res) {
						bastmenObj.extraUpdate(run, "LegBye");
						scoreObj.updateTotalRuns(run);
						ballObj.updateByeLegByeRun(run);
						hideMenu();
					}// end of res
				}// end of confirmation if 	      
			} else if (type == "penalty") {
				hideMenu();
			} else if (type == "ForceEndOfOver") {
				hideMenu();
				var r = confirm("You have selected Force End Over Option.Do you want to continue?");
				if (r == true) {
					ajexObj.sendEndOver('FEO');
					ballObj.forceEndOfOver();
				}// end of confirmation if 		
			} else if (type == "pauseinnings") {
				hideMenu();
				var r = confirm("You have selected Pause Innings Option.Do you want to continue?");
				if (r == true) {
					intervalObj.stopTime();
				}// end of confirmation if
			} else if (type == "endinnings") {
				hideMenu();
				var r = confirm("You have selected End Innings Option.Do you want to continue?");
				if (r == true) {
					bastmenObj.checkRetireout();
				}// end of confirmation if    
			} else if (type == "switchbatsman") {
				hideMenu();
				var r = confirm("You have selected Switch Batsman Option .Do you want to continue?");
				if (r == true) {
					bastmenObj.swapBatsmen();
					bastmenObj.changeCSS();
					scoreObj.swapBatsmen();
				}// end of confirmation if 
			} else if (type == "changebowler") {//Change baller-Archana
				hideMenu();//End chg baller
				var r = confirm("You have selected Switch Bowler Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendEndOver('CB');
					showPopup('BackgroundDiv', 'swapBowlerRemarkList');
					this.setchangebowlerflag(true);
				}// end of confirmation if	 
			} else if (type == "newball") {
				hideMenu();
				var r = confirm("You have selected New Ball Taken Option .Do you want to continue?");
				if (r == true) {
					ballObj.newBall();
					newData.new_ball = "Y";
					newBallFlag = true;
				}// end of confirmation if	  
			} else if (type == "powerplay") {
				hideMenu();
				var r = confirm("You have selected Power Play Option .Do you want to continue?");
				if (r == true) {
					this.powerplay();
				} // end of confirmation if
			}

		} catch (err) {
			alert(err.description + "callFunction.js.callFunction()")
		}
	}//callFunction() end

	this.callDismissal = function(type, id) {
		try {
			// this.convertData();
			if (!$('chkonline').checked) {
				this.updateTime();
			}
			landmarkflag = true; // this flag indicate ball is not increase
			patenershipball = 0;
			document.getElementById('hdmatchtime').value = "0"; //partnership time 
			wicketFlag = true; // to identified wicket is gon in this ball or not
			// this.cleartData();
			this.newData(); // this function are use to take new data for perticular ball
			newData.flag = '2';//2:flag indicates dismissal & 1 : runs
			newData.canreturn = 'N'//for retire if batsman can return or not
			if (penaltyFlag == false) { // this flag set because when we set paanalty flag after that in next flag we reset the flag
				newData.penalty = 0;
			}
			if (pitchFlag == true) {
				newData.pitch_pos = pitchpostion;
			}
			if (groundFlag == true) {
				newData.ground_pos = groundPos;
			}
			//pitchpostion = null;		
			if (type == "Bowled") {
				var r = confirm("You have selected Bowled Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					batsmanStriker = bastmenObj.batSetStriker()
					this.dismissalType(id, batsmanStriker, "0", "0");
					res = this.callAjex();
					if (res) {
						wicket = bastmenObj.updateWicket(0, 'bowler'); // return map;
						scoreObj.updateWicket(1);
						scoreObj.updateNewBatsman(0, 0, 0);
						hideMenu();
						ballObj.updateWicket(0);
					}
				}// end of confirmation if      
			} else if (type == "Stumped") {
				hideMenu();
				var r = confirm("You have selected Stumped Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('stumped', id);
				}// end of confirmation if 
			} else if (type == "Wide + Stumped") {
				hideMenu();
				var r = confirm("You have selected Wide + Stumped Option .Do you want to continue?");
				if (r == true) {
					landmarkflag = false; // this flag indicate ball is not increase
					ajexObj.sendData("widestumped", id);
				}// end of confirmation if         
			} else if (type == "Wide + Obstructing The Field") { // Wides + Handled the Ball + Obstructing the Field
				hideMenu();
				var r = confirm("You have selected Wide + Obstructing The Field  Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('WideHTBOTF', id);
				}// end of confirmation if      
			} else if (type == "Wide + Handled the Ball") {
				//ajexObj.sendData('WideHTB',id);
				hideMenu();
				var r = confirm("You have selected Wide + Handled the Ball  Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					landmarkflag = false; // this flag indicate ball is not increase	
					newData.flag = '9';
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'wide') {
							newData.extratype = runid[i];
						}
					}
					batsmanStriker = bastmenObj.batSetStriker()
					this.dismissalType(id, batsmanStriker, "0", "0");
					bastmenObj.extraUpdate(0, 'wide');
					scoreObj.extraUpdate(0);
					ballObj.extraUpdate(0, 'wide');
					wicket = bastmenObj.updateWicket(22, 'bowler');
					res = this.callAjex();
					scoreObj.updateWicket(1);
					//	    ballObj.updateWicket(2);
					ballObj.updateWicket(3);// 06 06 2009

					scoreObj.updateNewBatsman(3, 0, 0);
					closePopup('BackgroundDiv', 'PopupDiv');
				} // end of confirmation if     
			} else if (type == "retires") {
				hideMenu();
				var r = confirm("You have selected Retired  Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					showPopup('BackgroundDiv', 'retireRemarkList');
					retireId = id;
				}// end of confirmation if 	
			} else if (type == "Wide + Hit Wicket") { // Wides + Hit Wicket
				hideMenu();
				var r = confirm("You have selected Wide + Hit Wicket Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					landmarkflag = false; // this flag indicate ball is not increase	
					newData.flag = '9';
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'wide') {
							newData.extratype = runid[i];
						}
					}
					batsmanStriker = bastmenObj.batSetStriker()
					this.dismissalType(id, batsmanStriker, "0", "0");
					res = this.callAjex();
					if (res) {
						bastmenObj.extraUpdate(0, 'wide');
						ballObj.extraUpdate(0, 'wide');
						scoreObj.extraUpdate(0);
						wicket = bastmenObj.updateWicket(11, 'bowler');
						scoreObj.updateWicket(1);
						scoreObj.updateNewBatsman(0, 0, 0);
						//ballObj.updateWicket(1);//dipti 13 05 2009
						ballObj.updateWicket(2);//dipti 14 05 2009

					}
				} // end of confirmation if 	       
			} else if (type == "Caught") {
				hideMenu();
				var r = confirm("You have selected Caught Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('caught', id);
				}// end of confirmation if 	          
			} else if (type == "Caught by Bowler") {
				hideMenu();
				var r = confirm("You have selected Caught by Bowler Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('caughtbybowler', id);
				}// end of confirmation if 	          	
			} else if (type == "Caught by WicketKeeper") {
				hideMenu();
				var r = confirm("You have selected Caught by WicketKeeper Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('caughtbywkt', id);
				}// end of confirmation if 	          		
			} else if (type == "Retired Out") {
				hideMenu();
				var r = confirm("You have selected Retired Out Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('retireout', id);
				}
			} else if (type == "Retired Not Out") {
				hideMenu();
				var r = confirm("You have selected Retired Not Out Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('absentout', id);
				}
			} else if (type == "Timed Out") {
				hideMenu();
				var r = confirm("You have selected Timed Out Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('timeout', id);
				}// end of confirmation if	
			} else if (type == "Hit The Ball Twice") { //Hit The Ball Twice
				hideMenu();
				var r = confirm("You have selected Hit The Ball Twice Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					batsmanStriker = bastmenObj.batSetStriker()
					this.dismissalType(id, batsmanStriker, "0", "0");
					res = this.callAjex();
					if (res) {
						wicket = bastmenObj.updateWicket(2, 'bowler');
						scoreObj.updateWicket(1);
						scoreObj.updateNewBatsman(0, 0, 0);
						ballObj.updateWicket(1);
					}
				} // end of confirmation if	    
			} else if (type == "Hit Wicket") {
				hideMenu();
				var r = confirm("You have selected Hit Wicket Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					batsmanStriker = bastmenObj.batSetStriker();
					this.dismissalType(id, batsmanStriker, "0", "0");
					res = this.callAjex();
					if (res) {
						wicket = bastmenObj.updateWicket(3, 'bowler');
						scoreObj.updateWicket(1);
						scoreObj.updateNewBatsman(0, 0, 0);
						ballObj.updateWicket(0);
					}
				}// end of confirmation if		       
			} else if (type == "Leg Before Wicket") {
				hideMenu();
				var r = confirm("You have selected Leg Before Wicket - LBW Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					batsmanStriker = bastmenObj.batSetStriker();
					this.dismissalType(id, batsmanStriker, "0", "0");
					res = this.callAjex();
					if (res) {
						wicket = bastmenObj.updateWicket(1, 'bowler');
						scoreObj.updateWicket(1);
						scoreObj.updateNewBatsman(0, 0, 0);
						ballObj.updateWicket(0);
					}
				}// end of confirmation if	       
			} else if (type == "Handled the Ball") {
				//ajexObj.sendData('handletheball',id);
				hideMenu();
				var r = confirm("You have selected Handled the Ball Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					batsmanStriker = bastmenObj.batSetStriker();
					this.dismissalType(id, batsmanStriker, "0", "0");
					wicket = bastmenObj.updateWicket(26, 'bowler');
					res = this.callAjex();
					scoreObj.updateWicket(1);
					scoreObj.updateNewBatsman(3, 0, 0);
					ballObj.updateRun(0);
					closePopup('BackgroundDiv', 'PopupDiv');
				}// end of confirmation if      
			} else if (type == "Obstructing The Field") { // Obstructing The Field
				hideMenu();
				var r = confirm("You have selected Obstructing The Field Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('handleball', id);
				}// end of confirmation if  		
			} else if (type == "Timed Out") {
				hideMenu();
				var r = confirm("You have selected Timed Out Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					scoreObj.updateWicket(1);
				} // end of confirmation if    
			} else if (type == "Run Out") {
				hideMenu();
				var r = confirm("You have selected Run Out Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('runout', id);
				} // end of confirmation if       
			} else if (type == "No Ball + Obstructing The Field") {// NoBall + Handled the Ball + Obstructing the Field
				hideMenu();
				var r = confirm("You have selected No Ball + Obstructing The Field Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('NoHTBOTF', id);
				} // end of confirmation if         
			} else if (type == "No Ball +  Handled the Ball") {
				//ajexObj.sendData('NoHTB',id);
				hideMenu();
				var r = confirm("You have selected No Ball +  Handled the Ball Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					newData.flag = '9';
					landmarkflag = false; // this flag indicate ball is not increase
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'noball') {
							newData.extratype = runid[i];
						}
					}
					batsmanStriker = bastmenObj.batSetStriker();
					this.dismissalType(id, batsmanStriker, "0", "0");
					bastmenObj.extraUpdate(0, 'noball');
					scoreObj.extraUpdate(0);
					ballObj.extraUpdate(0, 'noball');
					wicket = bastmenObj.updateWicket(25, 'bowler');
					res = this.callAjex();
					scoreObj.updateWicket(1);
					scoreObj.updateNewBatsman(3, 0, 0);
					ballObj.updateWicket(2);
					closePopup('BackgroundDiv', 'PopupDiv')
				} // end of confirmation if      
			} else if (type == "No Ball + Hit The Ball Twice") { // >No Ball + Hit The Ball Twice
				hideMenu();
				var r = confirm("You have selected No Ball + Hit The Ball Twice Option .Do you want to continue?");
				if (r == true) {
					this.chkonlinoffline();
					landmarkflag = false; // this flag indicate ball is not increase
					newData.flag = '9';
					for (i = 0; i < leng; i++) {
						if (runname[i] == 'noball') {
							newData.extratype = runid[i];
						}
					}
					batsmanStriker = bastmenObj.batSetStriker();
					this.dismissalType(id, batsmanStriker, "0", "0");
					res = this.callAjex();
					if (res) {
						bastmenObj.extraUpdate(0, 'noball');
						ballObj.extraUpdate(0, 'noball');
						wicket = bastmenObj.updateWicket(12, 'bowler');
						scoreObj.updateWicket(1);
						scoreObj.updateNewBatsman(0, 0, 0);
						ballObj.updateWicket(2);
					}
				}// end of confirmation if         
			} else if (type == "No Ball + Run Out") {// No Ball + Run Out
				hideMenu();
				var r = confirm("You have selected No Ball + Run Out Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('noballrunout', id);
				}// end of confirmation if 	
			}else if (type == "No Ball + Byes + Run Out") {// No Ball + Run Out
				hideMenu();
				var r = confirm("You have selected No Ball + Byes + Run Out Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('noballbyesrunout', id);
				}// end of confirmation if 	
			}else if (type == "No Ball + LegByes + Run Out") {// No Ball + Run Out
				hideMenu();
				var r = confirm("You have selected No Ball + LegByes + Run Out Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('noballlegbyesrunout', id);
				}// end of confirmation if 	
			}else if (type == "Wide + Run Out") {
				hideMenu();
				var r = confirm("You have selected Wide + Run Out Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('widerunout', id);
				}// end of confirmation if  	
			} else if (type == "Byes + Run Out") {
				hideMenu();
				var r = confirm("You have selected Byes + Run Out Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('byesrunout', id);
				}// end of confirmation if  	
			} else if (type == "LegByes + Run Out") {
				hideMenu();
				var r = confirm("You have selected LegByes + Run Out Option .Do you want to continue?");
				if (r == true) {
					ajexObj.sendData('legbyesrunout', id);
				}// end of confirmation if  	
			} else if (type == "ajaxStumped") {
				this.chkonlinoffline();
				batsmanStriker = bastmenObj.batSetStriker();
				wicket = bastmenObj.updateWicket(4, 'bowler');
				this.dismissalType(id, batsmanStriker, wicket.KeeperId, "0"); //wicket.Keeper is id of Keeper
				res = this.callAjex();
				scoreObj.updateWicket(1);
				scoreObj.updateNewBatsman(0, 0, 0);
				ballObj.updateWicket(0);
				closePopup('BackgroundDiv', 'PopupDiv');
			} else if (type == "ajaxwidestumped") {
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase
				newData.flag = '9';
				for (i = 0; i < leng; i++) {
					if (runname[i] == 'wide') {
						newData.extratype = runid[i];
					}
				}
				batsmanStriker = bastmenObj.batSetStriker();
				wicket = bastmenObj.updateWicket(9, 'bowler');
				this.dismissalType(id, batsmanStriker, wicket.KeeperId, "0"); //wicket.Keeper is id of Keeper
				res = this.callAjex();
				bastmenObj.extraUpdate(0, 'wide');
				ballObj.extraUpdate(0, 'wide');
				scoreObj.extraUpdate(0);
				scoreObj.updateWicket(1);
				scoreObj.updateNewBatsman(0, 0, 0);
				ballObj.updateWicket(2);//dipti 13 05 2009
				//ballObj.updateWicket(0);// 0 :to add wicket in balling analysis
				closePopup('BackgroundDiv', 'PopupDiv');

			} else if (type == "ajaxcaught") {
				this.chkonlinoffline();
				batsmanStriker = bastmenObj.batSetStriker();
				wicket = bastmenObj.updateWicket(5, "bowler");
				var StrikeChg = document.getElementById('StrikeChg').value;
				this.dismissalType(id, batsmanStriker, wicket.FilderId, "0"); //dismissal_filder[0] is id of Filder
				res = this.callAjex();
				closePopup('BackgroundDiv', 'PopupDiv');
				scoreObj.updateWicket(1);
				if ($('Wickt').innerHTML != "10") {
					scoreObj.updateNewBatsman(1, 0, StrikeChg);
				}
				ballObj.updateWicket(0);

			} else if (type == "ajaxcaughtbybowler") {
				this.chkonlinoffline();
				batsmanStriker = bastmenObj.batSetStriker();
				wicket = bastmenObj.updateWicket(27, "bowler");
				var strikerChanhecmb = document.getElementById('cbbStrikeChg').value;
				this.dismissalType(id, batsmanStriker, ballObj
						.bowlerSetStriker(), "0"); //
				res = this.callAjex();
				scoreObj.updateWicket(1);
				if ($('Wickt').innerHTML != "10") {
					scoreObj.updateNewBatsman(1, 0, strikerChanhecmb);
				}
				ballObj.updateWicket(0);
				closePopup('BackgroundDiv', 'PopupDiv');
			} else if (type == "ajaxcaughtwkt") {
				this.chkonlinoffline();
				batsmanStriker = bastmenObj.batSetStriker();
				wicket = bastmenObj.updateWicket(28, "bowler");
				var wktStrikerChg = document.getElementById('wktStrikeChg').value;
				this.dismissalType(id, batsmanStriker, wicket.FilderId, "0"); //
				res = this.callAjex();
				scoreObj.updateWicket(1);
				if ($('Wickt').innerHTML != "10") {
					scoreObj.updateNewBatsman(1, 0, wktStrikerChg);
				}
				ballObj.updateWicket(0);
				closePopup('BackgroundDiv', 'PopupDiv');
			} else if (type == "ajaxrunout") {
				this.chkonlinoffline();
				newData.flag = '3'; // flag 3  is for runout only
				wicket = bastmenObj.updateWicket(8, 'bowler');
				var outruns = $$('outruns');
				var selrunoutbatName = $$('selrunoutbatName');

				this.dismissalType(id, wicket.batNameId, wicket.filder1Id,
						wicket.filder2Id); //dismissal_filder[0] is id of Filder
				scoreObj.updateStrikerRun(outruns);// update batsman run in score card
				scoreObj.updateStrikerOrNonStrikerWicket(selrunoutbatName, 1); //check striker or non strike is last batsman out
				if ($('Wickt').innerHTML != "10") {
					scoreObj.updateNewBatsman(2, outruns, selrunoutbatName);
				}
				if (parseInt(wicket.run) == 0) {
					newData.runtype = 1;
				} else {
					for (i = 0; i < leng; i++) {
						if (runs[i] == wicket.run) { // zero is same as in database runtype_mst table
							newData.runtype = runid[i];
						}
					}
				}
				res = this.callAjex();
				scoreObj.updateRunoutRun(outruns);
				ballObj.updateRun(outruns);
				closePopup('BackgroundDiv', 'PopupDiv');
			} else if (type == "ajaxnoballrunout") {
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase
				newData.flag = '10';
				bastmenObj.extraUpdate(0, 'noball');
				scoreObj.extraUpdate(0);
				ballObj.extraUpdate(0, 'noball');
				wicket = bastmenObj.updateWicket(13, 'bowler');
				var outruns = $$('outruns');
				var selrunoutbatName = $$('selrunoutbatName');
				this.dismissalType(id, wicket.batNameId, wicket.filder1Id,
						wicket.filder2Id); //dismissal_filder[0] is id of Filder
				scoreObj.updateStrikerRun(outruns);// update batsman run in score card
				scoreObj.updateStrikerOrNonStrikerWicket(selrunoutbatName, 1); //check striker or non strike is last batsman out
				if ($('Wickt').innerHTML != "10") {
					scoreObj.updateNewBatsman(2, outruns, selrunoutbatName);
				}
				for (i = 0; i < leng; i++) {
					if (wicket.run != 0) {
						if (runs[i] == wicket.run) { // zero is same as in database runtype_mst table
							newData.runtype = runid[i];
						}
					} else {
						newData.runtype = 1;
					}
					if (runname[i] == 'noball') { // noball is same as in database runtype_mst table
						newData.extratype = runid[i];
					}
				}
				res = this.callAjex();
				scoreObj.updateRunoutRun(outruns);
				ballObj.updateRunOut(outruns);
				closePopup('BackgroundDiv', 'PopupDiv');
			}else if (type == "ajaxnoballbyesrunout") {
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase	
				newData.flag = '16';
				wicket = bastmenObj.updateWicket(36, 'bowler');
				var outruns = $$('outruns');
				bastmenObj.extraUpdate(outruns, 'noballlegbyesrunout');
				var selrunoutbatName = $$('selrunoutbatName');
				this.dismissalType(id, wicket.batNameId, wicket.filder1Id,
						wicket.filder2Id); //dismissal_filder[0] is id of Filder
				if ($('Wickt').innerHTML != "10") {
					scoreObj.updateNewBatsman(2, outruns, selrunoutbatName);
				}
				scoreObj.updateStrikerOrNonStrikerWicket(selrunoutbatName, 1); //check striker or non strike is last batsman out
				for (i = 0; i < leng; i++) {
					if (runs[i] == wicket.run) { // zero is same as in database runtype_mst table
						newData.runtype = runid[i];
					}
					if (runname[i] == 'noball') { // noball is same as in database runtype_mst table
						newData.extratype = runid[i];
					}
					if (parseInt(wicket.run) == 0) {
						newData.runtype = 1;
					}
					if (runname[i] == 'bye') {
						newData.extrarun = runid[i];
					}
				}
				res = this.callAjex();
				//scoreObj.updateStrikerRun($$('outruns'));// update batsman run in score card
				var outextarruns = parseInt(outruns) + parseInt(1);
				scoreObj.updateRunoutRun(outextarruns);
				ballObj.updateNoBallByeLegByesRunOut(outruns);
				closePopup('BackgroundDiv', 'PopupDiv');
			}else if (type == "ajaxnoballlegbyesrunout") {
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase	
				newData.flag = '16';
				wicket = bastmenObj.updateWicket(36, 'bowler');
				var outruns = $$('outruns');
				bastmenObj.extraUpdate(outruns, 'noballlegbyesrunout');
				var selrunoutbatName = $$('selrunoutbatName');
				this.dismissalType(id, wicket.batNameId, wicket.filder1Id,
						wicket.filder2Id); //dismissal_filder[0] is id of Filder
				if ($('Wickt').innerHTML != "10") {
					scoreObj.updateNewBatsman(2, outruns, selrunoutbatName);
				}
				scoreObj.updateStrikerOrNonStrikerWicket(selrunoutbatName, 1); //check striker or non strike is last batsman out
				for (i = 0; i < leng; i++) {
					if (runs[i] == wicket.run) { // zero is same as in database runtype_mst table
						newData.runtype = runid[i];
					}
					if (runname[i] == 'noball') { // noball is same as in database runtype_mst table
						newData.extratype = runid[i];
					}
					if (parseInt(wicket.run) == 0) {
						newData.runtype = 1;
					}
					if (runname[i] == 'legbye') {
						newData.extrarun = runid[i];
					}
				}
				res = this.callAjex();
				//scoreObj.updateStrikerRun($$('outruns'));// update batsman run in score card
				var outextarruns = parseInt(outruns) + parseInt(1);
				scoreObj.updateRunoutRun(outextarruns);
				ballObj.updateNoBallByeLegByesRunOut(outruns);
				closePopup('BackgroundDiv', 'PopupDiv');
			}else if (type == "ajaxwiderunout") {
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase	
				newData.flag = '10';
				bastmenObj.extraUpdate(0, 'wide');
				ballObj.extraUpdate(0, 'wide');
				scoreObj.extraUpdate(0);
				wicket = bastmenObj.updateWicket(24, 'bowler');
				var outruns = $$('outruns');
				bastmenObj.extraUpdate(outruns, 'widerunout');
				var selrunoutbatName = $$('selrunoutbatName');
				this.dismissalType(id, wicket.batNameId, wicket.filder1Id,
						wicket.filder2Id); //dismissal_filder[0] is id of Filder
				if ($('Wickt').innerHTML != "10") {
					scoreObj.updateNewBatsman(2, outruns, selrunoutbatName);
				}
				scoreObj.updateStrikerOrNonStrikerWicket(selrunoutbatName, 1); //check striker or non strike is last batsman out
				for (i = 0; i < leng; i++) {
					if (runs[i] == wicket.run) { // zero is same as in database runtype_mst table
						newData.runtype = runid[i];
					}
					if (runname[i] == 'wide') { // noball is same as in database runtype_mst table
						newData.extratype = runid[i];
					}
					if (parseInt(wicket.run) == 0) {
						newData.runtype = 1;
					}
				}
				res = this.callAjex();
				//scoreObj.updateStrikerRun($$('outruns'));// update batsman run in score card
				outruns = parseInt(outruns) + 1;
				scoreObj.updateRunoutRun(outruns);
				ballObj.updateRunOut(outruns);
				closePopup('BackgroundDiv', 'PopupDiv');
			} else if (type == "ajaxbyesrunout") {
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase	
				newData.flag = '10';
				wicket = bastmenObj.updateWicket(30, 'bowler');
				var outruns = $$('outruns');
				bastmenObj.extraUpdate(outruns, 'byesrunout');
				var selrunoutbatName = $$('selrunoutbatName');
				this.dismissalType(id, wicket.batNameId, wicket.filder1Id,
						wicket.filder2Id); //dismissal_filder[0] is id of Filder
				if ($('Wickt').innerHTML != "10") {
					scoreObj.updateNewBatsman(2, outruns, selrunoutbatName);
				}
				scoreObj.updateStrikerOrNonStrikerWicket(selrunoutbatName, 1); //check striker or non strike is last batsman out
				for (i = 0; i < leng; i++) {
					if (runs[i] == wicket.run) { // zero is same as in database runtype_mst table
						newData.runtype = runid[i];
					}
					if (runname[i] == 'bye') { // noball is same as in database runtype_mst table
						newData.extratype = runid[i];
					}
					if (parseInt(wicket.run) == 0) {
						newData.runtype = 1;
					}
				}
				res = this.callAjex();
				//scoreObj.updateStrikerRun($$('outruns'));// update batsman run in score card
				scoreObj.updateRunoutRun(outruns);
				ballObj.updateByeLegByesRunOut(outruns);
				closePopup('BackgroundDiv', 'PopupDiv');
			} else if (type == "ajaxlegbyesrunout") {
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase	
				newData.flag = '10';
				wicket = bastmenObj.updateWicket(31, 'bowler');
				var outruns = $$('outruns');
				bastmenObj.extraUpdate(outruns, 'legbyesrunout');
				var selrunoutbatName = $$('selrunoutbatName');
				this.dismissalType(id, wicket.batNameId, wicket.filder1Id,
						wicket.filder2Id); //dismissal_filder[0] is id of Filder
				if ($('Wickt').innerHTML != "10") {
					scoreObj.updateNewBatsman(2, outruns, selrunoutbatName);
				}
				scoreObj.updateStrikerOrNonStrikerWicket(selrunoutbatName, 1); //check striker or non strike is last batsman out
				for (i = 0; i < leng; i++) {
					if (runs[i] == wicket.run) { // zero is same as in database runtype_mst table
						newData.runtype = runid[i];
					}
					if (runname[i] == 'legbye') { // noball is same as in database runtype_mst table
						newData.extratype = runid[i];
					}
					if (parseInt(wicket.run) == 0) {
						newData.runtype = 1;
					}
				}
				res = this.callAjex();
				//scoreObj.updateStrikerRun($$('outruns'));// update batsman run in score card
				scoreObj.updateRunoutRun(outruns);
				ballObj.updateByeLegByesRunOut(outruns);
				closePopup('BackgroundDiv', 'PopupDiv');
			}else if (type == "ajaxretireout") {
				this.chkonlinoffline();
				newData.flag = '15';
				var selbatName = $$('selbatName');
				if (selbatName == "0") {
					this
							.dismissalType(id, bastmenObj.batSetStriker(), "0",
									"0"); //0 for strierk is retire out
				} else {
					this.dismissalType(id, bastmenObj.batSetNonStriker(), "0",
							"0"); // 1 for non striker is retire out
				}
				wicket = bastmenObj.updateWicket(6, 'bowler');
				res = this.callAjex();
				scoreObj.updateWicket(1);
				scoreObj.updateNewBatsman(3, 0, selbatName);
				closePopup('BackgroundDiv', 'PopupDiv');
			} else if (type == "ajaxabsenteout") {
				this.chkonlinoffline();
				newData.flag = '14';
				var selbatName = $$('selbatName');
				if (selbatName == "0") {
					this
							.dismissalType(id, bastmenObj.batSetStriker(), "0",
									"0"); //0 for strierk is retire out
				} else {
					this.dismissalType(id, bastmenObj.batSetNonStriker(), "0",
							"0"); // 1 for non striker is retire out
				}
				wicket = bastmenObj.updateWicket(29, 'bowler');
				res = this.callAjex();
				scoreObj.updateWicket(1);
				scoreObj.updateNewBatsman(3, 0, selbatName);
				closePopup('BackgroundDiv', 'PopupDiv');
			} else if (type == "ajaxhandleball") {
				this.chkonlinoffline();
				var selbatName = $$('selbatName');
				if (selbatName == "0") {
					this
							.dismissalType(id, bastmenObj.batSetStriker(), "0",
									"0"); //0 for strierk is handle the ball
				} else {
					this.dismissalType(id, bastmenObj.batSetNonStriker(), "0",
							"0"); // 1 for non striker is handle the ball
				}
				wicket = bastmenObj.updateWicket(7, 'bowler');
				res = this.callAjex();
				scoreObj.updateWicket(1);
				scoreObj.updateNewBatsman(3, 0, selbatName);
				ballObj.updateRun(0);
				closePopup('BackgroundDiv', 'PopupDiv');

			} else if (type == "ajaxhandletheball") { // this for handle the ball
				var selbatName = $$('selbatName');
				if (selbatName == "0") {
					this
							.dismissalType(id, bastmenObj.batSetStriker(), "0",
									"0"); //0 for strierk is handle the ball
				} else {
					this.dismissalType(id, bastmenObj.batSetNonStriker(), "0",
							"0"); // 1 for non striker is handle the ball
				}
				wicket = bastmenObj.updateWicket(26, 'bowler');
				res = this.callAjex();
				scoreObj.updateWicket(1);
				scoreObj.updateNewBatsman(3, 0, selbatName);
				ballObj.updateRun(0);
				closePopup('BackgroundDiv', 'PopupDiv');
			} else if (type == "ajaxWideHTBOTF") {
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase
				newData.flag = '9';
				var selbatName = $$('selbatName');
				for (i = 0; i < leng; i++) {
					if (runname[i] == 'wide') {
						newData.extratype = runid[i];
					}
				}
				if (selbatName == "0") {
					this
							.dismissalType(id, bastmenObj.batSetStriker(), "0",
									"0"); //0 for strierk is handle the ball and obstructing the field
				} else {
					this.dismissalType(id, bastmenObj.batSetNonStriker(), "0",
							"0"); // 1 for non striker is handle the ball and obstructing the field
				}
				bastmenObj.extraUpdate(0, 'wide');
				scoreObj.extraUpdate(0);
				ballObj.extraUpdate(0, 'wide');
				wicket = bastmenObj.updateWicket(10, 'bowler');
				res = this.callAjex();
				scoreObj.updateWicket(1);
				scoreObj.updateNewBatsman(3, 0, selbatName);
				/*
				 * Modified by bhushan 
				 * Desc :  wicket not credited bowler acc - pritam
				 * 
				 * */
				//ballObj.updateWicket(2); 
				ballObj.updateWicket(1);
				closePopup('BackgroundDiv', 'PopupDiv');

			} else if (type == "ajaxWideHTB") { // wide  + handle the ball;
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase
				var selotfbatName = $$('selotfbatName');
				var selbatName = $$('selbatName');
				newData.flag = '9';
				for (i = 0; i < leng; i++) {
					if (runname[i] == 'wide') {
						newData.extratype = runid[i];
					}
				}
				if (selbatName == "0") {
					this
							.dismissalType(id, bastmenObj.batSetStriker(), "0",
									"0"); //0 for strierk is handle the ball and obstructing the field
				} else {
					this.dismissalType(id, bastmenObj.batSetNonStriker(), "0",
							"0"); // 1 for non striker is handle the ball and obstructing the field
				}
				bastmenObj.extraUpdate(0, 'wide');
				scoreObj.extraUpdate(0);
				ballObj.extraUpdate(0, 'wide');
				wicket = bastmenObj.updateWicket(22, 'bowler');
				res = this.callAjex();
				scoreObj.updateWicket(1);
				ballObj.updateWicket(2);
				scoreObj.updateNewBatsman(3, 0, selotfbatName);
				closePopup('BackgroundDiv', 'PopupDiv');

			} else if (type == "ajaxNoHTBOTF") {
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase
				newData.flag = '9';
				var selbatName = $$('selbatName');
				for (i = 0; i < leng; i++) {
					if (runname[i] == 'noball') {
						newData.extratype = runid[i];
					}
				}
				if (selbatName == "0") {
					this
							.dismissalType(id, bastmenObj.batSetStriker(), "0",
									"0"); //0 for strierk is no ball +  handle the ball and obstructing the field
				} else {
					this.dismissalType(id, bastmenObj.batSetNonStriker(), "0",
							"0"); // 1 for non striker is  no ball handle the ball and obstructing the field
				}
				bastmenObj.extraUpdate(0, 'noball');
				scoreObj.extraUpdate(0);
				ballObj.extraUpdate(0, 'noball');
				wicket = bastmenObj.updateWicket(10, 'bowler');
				res = this.callAjex();
				scoreObj.updateWicket(1);
				scoreObj.updateNewBatsman(3, 0, selbatName);
				ballObj.updateWicket(2);
				closePopup('BackgroundDiv', 'PopupDiv')
			} else if (type == "ajaxNoHTB") { // no ball + handle the ball
				this.chkonlinoffline();
				landmarkflag = false; // this flag indicate ball is not increase
				newData.flag = '9';
				var selbatName = $$('selbatName');
				for (i = 0; i < leng; i++) {
					if (runname[i] == 'noball') {
						newData.extratype = runid[i];
					}
				}
				if (selbatName == "0") {
					this
							.dismissalType(id, bastmenObj.batSetStriker(), "0",
									"0"); //0 for strierk is no ball +  handle the ball and obstructing the field
				} else {
					this.dismissalType(id, bastmenObj.batSetNonStriker(), "0",
							"0"); // 1 for non striker is  no ball handle the ball and obstructing the field
				}
				bastmenObj.extraUpdate(0, 'noball');
				scoreObj.extraUpdate(0);
				ballObj.extraUpdate(0, 'noball');
				wicket = bastmenObj.updateWicket(25, 'bowler');
				res = this.callAjex();
				scoreObj.updateWicket(1);
				scoreObj.updateNewBatsman(3, 0, selbatName);
				ballObj.updateWicket(2);
				closePopup('BackgroundDiv', 'PopupDiv')
			} else if (type == "ajaxRETIRES") {// Retires logic flag is 20
				newData.flag = '13';
				this.chkonlinoffline();
				var selbatName = $$('selbatName');
				if (selbatName == "0") {
					this
							.dismissalType(id, bastmenObj.batSetStriker(), "0",
									"0"); //0 for strierk is retire out
				} else {
					this.dismissalType(id, bastmenObj.batSetNonStriker(), "0",
							"0"); // 1 for non striker is retire out
				}
				newData.description = $$('txtretireremark');
				document.getElementById("txtretireremark").value = "";
				newData.canreturn = 'Y'
				wicket = bastmenObj.updateWicket(20, 'bowler');
				res = this.callAjex();
				scoreObj.updateWicket(0);
				scoreObj.updateNewBatsman(3, 0, selbatName);
				closePopup('BackgroundDiv', 'PopupDiv');

			} else if (type == "ajaxtimeout") {
				this.chkonlinoffline();
				var selbatName = $$('selbatName');
				if (selbatName == "0") {
					this
							.dismissalType(id, bastmenObj.batSetStriker(), "0",
									"0"); //0 for strierk is no ball +  handle the ball and obstructing the field
				} else {
					this.dismissalType(id, bastmenObj.batSetNonStriker(), "0",
							"0"); // 1 for non striker is  no ball handle the ball and obstructing the field
				}
				wicket = bastmenObj.updateWicket(21, 'bowler');
				res = this.callAjex();
				scoreObj.updateWicket(1);
				scoreObj.updateNewBatsman(3, 0, selbatName);
				closePopup('BackgroundDiv', 'PopupDiv');
			}
			ajexObj.sendfallofwicket();
		} catch (err) {
			alert(err.description + "callFunction.js.callDismissal()")
		}
	}
	this.chkonlinoffline = function() {
		if ($('chkonline').checked == false) {
			ajexObj.sendlastballtime();
			showPopup('BackgroundDiv', 'offlinediv');
		}
	}
	this.cleartData = function() {
		try {
			newData.flag = "";
			newData.inning_id = "";
			newData.striker = "";
			newData.non_striker = "";
			newData.blower = "";
			newData.pitch_pos = "0";
			newData.bowlstyle = "";
			newData.over_num = "";
			//newData.over_wkt ="";
			newData.ground_pos = "0";
			newData.penalty = "0";
			newData.new_ball = "N";
			newData.description = "";
			newData.runtype = "";
			newData.extratype = "";
			newData.extrarun = "";
			newData.dismissalType = "";
			newData.dismissalBatsman = "";
			newData.dismissalBy1 = "";
			newData.dismissalBy2 = "";
			
			newData.pitch_pos = null; // this is optional that why we set null here for next ball 
		} catch (err) {
			alert(err.description + "callFunction.js.cleartData ()")
		}
	}

	this.showmenu = function(DivId, event) {
		var Id = DivId;
		if (screen.width != 1024 || screen.height != 768) {
			document.getElementById(Id).style.left = event.x - 15;
			document.getElementById(Id).top = event.y;
		}
	}
	this.showextramenu = function(DivId, event) {
		var Id = DivId;
		if (screen.width != 1024 || screen.height != 768) {
			document.getElementById(Id).style.left = event.x - 82;
			document.getElementById(Id).top = event.y;
		}
	}
	this.showsubmenu = function(MainDivId, SubDivId, event) {

		if (screen.width != 1024 || screen.height != 768) {
			var maindiv = document.getElementById(MainDivId).style.left;
			document.getElementById(SubDivId).style.left = parseInt(maindiv)
					+ parseInt(130);
		}
	}

	this.callAjex = function() {//to enter in DB each time this fun shud b called
		try {
			ajexObj.sendData("database", 0);
			penaltyFlag = false;
			this.cleartData();
			pitchFlag = false;
			groundFlag = false;
			return true;
		} catch (err) {
			alert(err.description + "callFunction.js.callAjex ()")
		}
	}
	this.ballwicketFlag = function() {
		return wicketFlag;
	}
	this.setballwicketFlag = function(wktflag) {
		wicketFlag = wktflag;
	}
	this.dismissalType = function(dismissal_id, batsman, dismissalBy1,
			dismissalBy2) {//on wkt every time get called
		try {
			newData.dismissalType = dismissal_id;
			newData.dismissalBatsman = batsman;
			newData.dismissalBy1 = dismissalBy1;
			newData.dismissalBy2 = dismissalBy2;

		} catch (err) {
			alert(err.description + "callFunction.js.dismissalType()")
		}
	}
	this.passMap = function() { //This Function is use for generate url;
		return newData;
	}

	this.Interval = function(type, id) {
		try {
			if (type == 'statusinterval') {
				ajexObj.sendData('statusinterval', id);
			} else {
				if (type == "ajaxinterval") {
					if ($('chkonline').checked) {
						var r = confirm("You have selected Start Game button.Do you want to continue?");
					} else {
						var r = confirm("You have selected Start Game button.Do you want to continue in offilne mode?");
						alert("Now you are in offline mode please check start time of play");
					}
				} else {
					var r = confirm("You have selected " + type
							+ " interval option. Do you want to continue?");
				}
				if (r == true) {
					bastmenObj.setmatchtimerflag(false);//set timer flag is false
					hideMenu();
					this.chkonlinoffline();
					if (type != "ajaxinterval") {
						if (type == "Drinks" || type == "Injury"
								|| type == "Change Ball") {
							bastmenObj.setmatchtimerflag("start");//for inbterval time strt
						} else {
							bastmenObj.setmatchtimerflag("stop");//for inbterval time stop
						}
						showPopup('BackgroundDiv', 'remarkList');
					}
					if (type == "ajaxinterval") { // this logic to update end time
						closePopup('BackgroundDiv', 'remarkList');
						ajexObj.sendData('endinterval', id);
						bastmenObj.setmatchtimerflag("start");
					} else {
						//closePopup('BackgroundDiv', 'remarkList');
						if (type == "End Inning" || type == "Declare") {
							bastmenObj.checkRetireout();
						} else {
							if (type == 'statusinterval') {
								ajexObj.sendData('statusinterval', id);
							} else {
								this.setIntervalType(type);
								ajexObj.sendData('interval', id);
							}
						}
					}
				}// end of confirm		
			}// end else	
		} catch (err) {
			alert(err.description + "callFunction.js.Interval()");
		}
	}

	this.setmaxOver = function() {
		ajexObj.sendData('setmaxover');
		closePopup('BackgroundDiv', 'modifiedtime');
		showPopup('BackgroundDiv', 'pbar');
		document.getElementById("main").action = "/cims/jsp/scorer.jsp"
		document.getElementById("main").submit();
	}
	this.setIntervalType = function(type) {
		interval = type;
	}
	this.overDetails = function(id) {
		document.getElementById('over_' + id).style.display = 'block'
		//var over = document.getElementById('achorover_num'+id).value;
		//var eachover  = parseInt(over) - parseInt(1);
		//ajexObj.sendDataToolTip('toolTip',eachover); 
	}
	this.getIntervalType = function() {
		return interval;
	}
	this.getRemark = function() {
		newData.description = $$('txtremark');
	}
	this.getpenaltyRemark = function() {
		newData.description = $$('txtpenaltyremark');
		document.getElementById("txtpenaltyremark").value = "";
	}
	this.setchangebowlerflag = function(flag) {
		changebowlerflag = flag;
	}
	this.getchangebowlerflag = function() {
		return changebowlerflag;
	}
	this.checkintervalrefreshstatus = function() {//to get interval status after refresh.
		var intervalid = $$('hdintervalstatusid');
		var intervalname = $$('hdintervalstatusname');
		var intervalcount = $$('hdintervalstatuscount');
		if (intervalcount != "0") {
			callFun.extraFunction('online', '0');
			/*closePopup('BackgroundDiv', 'BatList');
			closePopup('BackgroundDiv', 'BowlList');	
			closePopup('BackgroundDiv', 'remarkList');	
			closePopup('BackgroundDiv', 'penaltyremarkList');
			closePopup('BackgroundDiv', 'swapBowlerRemarkList');
			closePopup('BackgroundDiv', 'retireRemarkList');
			closePopup('BackgroundDiv', 'totallandmark');
			closePopup('BackgroundDiv', 'batsmanlandmark');
			closePopup('BackgroundDiv', 'partnershiplandmark');
			closePopup('BackgroundDiv', 'bowlerlandmark');*/
			showPopup('BackgroundDiv', 'remarkList');
			this.setIntervalType(intervalname);
			this.Interval('statusinterval', intervalid);
		}

	}
	this.checkbastman = function() {// when batsman is out than page will be refresh than we do this flow for new batsman selection
		if ($$("hdcheckwkt") != "0") {
			this.chkonlinoffline();
			callFun.extraFunction('newbatsman', '0');
		}
	}
	this.getswapBowlerRemark = function() {
		newData.description = $$('txtbowlerremark');
		document.getElementById("txtbowlerremark").value = "";
		showPopup('BackgroundDiv', 'BowlList')

	}
	this.penalty = function(id, run, name, ball_cnt) {
		try {
			hideMenu();
			var r = confirm("You have selected " + name
					+ " Option .Do you want to continue?");
			if (r == true) {
				var response = showPopup('BackgroundDiv', 'penaltyremarkList');
				if (response) {
					ajexObj.sendData("penalty", id);
					//newData.penalty = id; // set penalty  for previous ball
					//newData.description = $$('txtpenaltyremark');
					document.getElementById("txtpenaltyremark").value = "";
					if (($$('hdmatchtype') == "oneday" && $$('inningNo') == "2")
							|| ($$('hdmatchtype') == "test" && $$('inningNo') == "4")) {
						bastmenObj.penailtyUpdate(run, 1);
						scoreObj.penailtyUpdate(run);
					} else {
						if (run > 0) {
							bastmenObj.penailtyUpdate(run, 1);
							scoreObj.penailtyUpdate(run);
						}
				    }
					if(ball_cnt=='N'){
						ballObj.removeLastBall();
					}
					penaltyFlag = true;
				}// end of response
			}// end of confirm     
		} catch (err) {
			alert(err.description + "callFunction.js.penalty()");
		}
	}

	this.endInning = function() {
		try {
			closePopup('BackgroundDiv', 'BowlList')
			closePopup('BackgroundDiv', 'BatList')
			this.blockmaindiv('BackgroundDiv')
			if (confirm("Inning is Completed! Close this window to play next Innings for security reasons.")) {
				if (matchFlag == false) { // this condition is for if inning is end without match start
				} else {
				}
				ajexObj.sendData("inning", 0); // for update end time for current Inning
				this.blockmaindiv('BackgroundDiv');
				hideMenu();
				ajexObj.sendEndOver('EOI');
				ajexObj.sendEndMatch('endmatch', $$("hdmatchid"));
				showPopup('BackgroundDiv', 'endmatchdiv');
			} else {
				var totalwicket = $("Wickt").innerHTML
				this.hideblockmaindiv('BackgroundDiv');
				if (totalwicket == '10') {
					alert("Sorry,inning is over you can not continue match");
					ajexObj.sendData("inning", 0); // for update end time for current Inning
					this.endMatch("endmatch", $$("hdmatchid"));
				} else if ($$('hdmatchtype') == "oneday") {
					alert("Sorry,inning is over you can not continue match");
					ajexObj.sendData("inning", 0); // for update end time for current Inning
					this.endMatch("endmatch", $$("hdmatchid"));		
				}

			}
		} catch (err) {
			alert(err.description + "callFunction.js.endInning()");
		}
	}

	// archana
	this.moreundo = function() {

		ajexObj.sendShortRun('moreundo', '0');
		closePopup('BackgroundDiv', 'moreundo');

	}
	this.msg = function() {
		alert("Please check Striker and Non Striker properly.")
	}
	this.setType = function(type) {
		settype = type;
	}
	this.getType = function() {
		return settype;
	}
	this.setbowlerId = function(Id) { // this function is use for addRow.js
		bowlerId = Id;
	}
	this.getbowlerId = function() { // this function is use for addRow.js
		return bowlerId;
	}
	this.newData = function() {
		var over;
		var overnumber;
		newData.inning_id = $$('inningId');
		newData.striker = bastmenObj.batSetStriker();
		newData.non_striker = bastmenObj.batSetNonStriker();
		newData.blower = ballObj.bowlerSetStriker();
		if (isNaN($('SBOver').innerHTML)) {
			overnumber = "0";
		} else {
			over = $('SBOver').innerHTML.split(".");
			overnumber = over[0];
		}
		newData.over_num = overnumber;

		newData.bowlstyle = 1;
		//newData.over_wkt = 'Y';
		//newData.description ='default';
	}
	this.mousemove = function(event) {
		try {
			var x = (window.event) ? window.event.x : event.clientX;
			var y = (window.event) ? window.event.y : event.clientY;
			evt = event || window.event;
			var keyPressed = evt.which || evt.keyCode;

			if (keyPressed == 32) {
				if (divname != "") {
					$(divname).style.left = x;
					$(divname).style.top = y;
				}
			}
		} catch (err) {
			alert(err.description + "callFunction.js.mousemove()");
		}
	}
	this.setdivid = function(divid) {
		divname = divid;
	}
	this.getretired = function() {
		ajexObj.sendData('Retires', retireId);
		retireId = "";
	}
	this.rowNumber = function() {
		bastmenObj.batRowNumber();
		ballObj.bolerRowNumber();
	}
	this.strikerNonStrikerInTime = function() {
		bastmenObj.currentTime();
	}
	this.wicketDiv = function(div, event) {
		if (isNaN($(div).innerHTML)) {
			var x = (window.event) ? window.event.x : event.clientX;
			var y = (window.event) ? window.event.y : event.clientY;
			$(div).style.left = x;
			$(div).style.top = y;
			$(div).style.width = "100%";
			$(div).style.height = "100%";
			$(div).style.display = '';
		}
	}
	this.hideWcketDiv = function(div) {
		$(div).style.display = 'none';
	}
	this.overthewicket = function(val) {
		newData.over_wkt = val;
	}
	this.setmaxRowNumber = function() {
		try {

		} catch (err) {
			alert(err.description + "callFunction.js.setmaxRowNumber()");
		}
	}

	this.stumpshow = function(type, id) {
		var bowlerName = ballObj.BowlerName();//dipti 18 05 2009
		var wicketkeeperarray = ($$('selName').split("~"));//dipti 18 05 2009
		wicketkeeper = wicketkeeperarray[1] // Name Of Filder//dipti 18 05 2009

		if ($$('selName') == "") {
			alert("Select wicket keeper");
			return false;
		} else if (bowlerName == wicketkeeper) {//dipti 18 05 2009
			alert("You have selected bowler as wicket keeper.\nPlease select another wicket keeper other than bowler");//dipti 18 05 2009
			return false;//dipti 18 05 2009
		} else {
			this.callDismissal(type, id);
		}
	}

	this.caughtshow = function(type, id) {
		var bowlerName = ballObj.BowlerName();//dipti 28 05 2009
		var fielderarray = ($$('selFldName').split("~"));//dipti 28 05 2009
		fielder = fielderarray[1] // Name Of Filder//dipti 18 05 2009

		if ($$('selFldName') == '' || $$('StrikeChg') == '') {
			if ($$('selFldName') == '') {
				alert("Please select fielder name.");
				return false;
			} else {
				alert("Please select strike change or not field.")
				return false;
			}
		} else {
			if (bowlerName == fielder) {//dipti 28 05 2009
				alert("You have selected bowler as fielder.\nPlease select another fielder other than bowler");//dipti 28 05 2009
				return false;//dipti 28 05 2009
			}
			callFun.callDismissal(type, id);
		}

	}
	this.caughtbybowler = function(type, id) {
		if ($$('cbbStrikeChg') == '') {
			alert("Please select strike change or not field.")
			return false;
		} else {
			callFun.callDismissal(type, id);
		}

	}
	this.caughtwktshow = function(type, id) {
		var bowlerName = ballObj.BowlerName();
		var wicketkeeperarray = (document.getElementById("wktselFldName").value)
				.split("~");
		wicketkeeper = wicketkeeperarray[1] // Name Of Filder
		if ($$('wktselFldName') == '' || $$('wktStrikeChg') == '') {
			if ($$('wktselFldName') == '') {
				alert("Please select wicket keeper name.");
			} else {
				alert("Please select strike change or not field.")
			}
			return false;
		} else if (bowlerName == wicketkeeper) {
			alert("You have selected bowler as wicket keeper.\nPlease select another wicket keeper other than bowler");//dipti
			return false;
		} else {
			callFun.callDismissal(type, id);
		}
	}
	this.runoutshow = function(type, id) {
		if ($$('selFld1Name') == '' && $$('selFld2Name') == '') {
			alert("Please select at least one fielder name.");
			return false;
		} else if ($$('selFld1Name') == '') {
			alert("Please select first fielder name");
			return false;
		} else if ($$('selFld1Name') == $$('selFld2Name')) {
			alert("Please select different fielder name.");
			return false;
		} else if ($$('outruns') == '') {
			alert("Please select run field.");
			return false;
		} else if ($$('selrunoutbatName') == '') {
			alert("Select batsman name.");
			return false;
		} else if ($$('runoutStrikeChg') == "") {
			alert("Select striker change field.");
			return false;
		} else {
			callFun.callDismissal(type, id);
		}
	}
	this.otherwkt = function(type, id) {
		if ($$('selbatName') == '') {
			alert("Select batsman name.");
			return false;
		} else {
			callFun.callDismissal(type, id);
		}
	}
	this.handleball = function(type, id) {
		if ($$('selFlderName') == '') {
			alert("Select fielder name.");
			return false;
		}
		if ($$('selotfbatName') == '') {
			alert("Select batsman name.");
			return false;
		} else {
			callFun.callDismissal(type, id);
		}
	}
	this.closeBowlList = function(id) {
		try {
			$(id).style.display = 'none';
		} catch (err) {
			alert(err.description + "callFunction.js.closeBowlList");
		}
	}
	this.updateScore = function(overNumber) {
		try {
			showPopup('BackgroundDiv', 'selectedOverBallsDiv');
			ajexObj.sendDataUpdateOver('sendDataUpdateOver', overNumber);
		} catch (err) {
			alert(err.description + "callFunction.js.updateScore");
		}
	}
	this.blockmaindiv = function(id) {
		$(id).style.display = "block";
	}
	this.hideblockmaindiv = function(id) {
		$(id).style.display = '';
	}
	this.adjusttime = function(id) {
		var intervalid = document.getElementById("hdintervalid" + id).value;
		var startdate = document.getElementById("txtstartdate" + id).value;
		var enddate = document.getElementById("txtenddate" + id).value;
		var hdstartdate = document.getElementById("hdstartdate" + id).value;
		var isOkCurrDate = validatewithcurdate(enddate, startdate)
		var flag = 1//for alert message
		var isOkPrevDate = validatewithpreviousdate(enddate, startdate, flag)
		if (enddate == '') {
			ajexObj.sendupdateIntervalTime(intervalid, startdate, enddate,
					hdstartdate, "1");
		}
		if (isOkPrevDate) {
			if (isOkCurrDate) {
				ajexObj.sendupdateIntervalTime(intervalid, startdate, enddate,
						hdstartdate, "1");
			}
		} else {
			return false
		}

	}

	this.edittime = function(id) {
		var intervalid = document.getElementById("hdintervalid" + id).value;
		var startdate = document.getElementById("txtstartdate" + id).value;
		var enddate = document.getElementById("txtenddate" + id).value;
		var hdstartdate = document.getElementById("hdstartdate" + id).value;
		var isOkCurrDate = validatewithcurdate(enddate, startdate)
		var flag = 1//for alert message
		var isOkPrevDate = validatewithpreviousdate(enddate, startdate, flag)
		if (enddate == '') {
			ajexObj.sendupdateIntervalTime(intervalid, startdate, enddate,
					hdstartdate, "2");
		}
		if (isOkPrevDate) {
			if (isOkCurrDate) {
				ajexObj.sendupdateIntervalTime(intervalid, startdate, enddate,
						hdstartdate, "2");
			}
		} else {
			return false
		}

	}
	this.editwicketBalltime = function(wktid, batsmanid) {
		var wicketBallTime = document.getElementById("txtwicketball" + wktid).value;
		var hidwicketBallTime = document
				.getElementById("hidwicketball" + wktid).value;
		var wicketNextBallTime = document.getElementById("txtwicketnextball"
				+ wktid).value;
		var hidwicketNextBallTime = document.getElementById("hidwicketnextball"
				+ wktid).value;

		var inningid = document.getElementById('inningId').value
		var isOkCurrDate = validatewithcurdate(wicketNextBallTime,
				wicketBallTime)
		var flag = 2//for alert message
		var isOkPrevDate = validatewithpreviousdate(wicketNextBallTime,
				wicketBallTime, flag)

		if (wicketBallTime.indexOf("-") == -1
				|| wicketNextBallTime.indexOf("-") == -1) {
			if (wicketNextBallTime == '') {
				if (wicketBallTime.indexOf("-") == -1) {
					ajexObj.sendupdateBallTime(batsmanid, inningid,
							wicketBallTime, wicketNextBallTime,
							hidwicketBallTime, hidwicketNextBallTime);
					alert("Date and Time saved")
				}
			} else {
				if (isOkPrevDate) {
					if (isOkCurrDate) {
						ajexObj.sendupdateBallTime(batsmanid, inningid,
								wicketBallTime, wicketNextBallTime,
								hidwicketBallTime, hidwicketNextBallTime);
						alert("Date and Time saved")
					}
				} else {
					return false
				}

			}

		}
	}

	this.validateStartEndTime = function validateStartEndTime(wktid,
			innStartTime, innEndTime, maxBallTime) {
		var inTime = document.getElementById("txtwicketball" + wktid).value;
		var outTime = document.getElementById("txtwicketnextball" + wktid).value;
		validateStartEndDate(inTime, innStartTime, innEndTime, outTime,
				maxBallTime)
	}

	this.editInningTime = function(inningid, maxBallTime) {

		var inningStartTime = document.getElementById("txtstarttime").value;
		var inningEndTime = document.getElementById("txtendtime").value;
		validatewithpreviousdate(maxBallTime, inningStartTime, 4)
		validatewithpreviousdate(maxBallTime, inningEndTime, 5)
		var isOkCurrDate = validatewithcurdate(inningEndTime, inningEndTime)
		var flag = 1//for alert message
		var isOkPrevDate = validatewithpreviousdate(inningEndTime,
				inningStartTime, flag)
		if (inningStartTime.indexOf("-") == -1
				|| inningEndTime.indexOf("-") == -1) {

			if (inningEndTime == '') {
				isOkCurrDate = validatewithcurdate(inningStartTime,
						inningStartTime)
				if (isOkCurrDate) {
					if (inningStartTime.indexOf("-") == -1) {
						ajexObj.sendupdateInningStartTime(inningid,
								inningStartTime, inningEndTime);
						alert("Date and Time saved")
					}
				}

			} else {
				if (isOkPrevDate) {
					if (isOkCurrDate) {
						ajexObj.sendupdateInningStartTime(inningid,
								inningStartTime, inningEndTime);
						alert("Date and Time saved")
					}
				} else {
					return false
				}

			}

		}
	}
	this.endMatch = function(type, matchid) {
		r = confirm("Do you want end this match?");
		if (r) {
			try {

				this.blockmaindiv('BackgroundDiv');
				hideMenu();
				ajexObj.sendEndOver('EOI');
				if (type == "endmatch") {
					ajexObj.sendEndMatch('endmatch', matchid);
				} else if (type == "drwamatch") {
					ajexObj.sendEndMatch('drwamatch', matchid);
				}
				showPopup('BackgroundDiv', 'endmatchdiv');
			} catch (err) {
				alert(err.description + "callFunction.js.endMatch");
			}
		}
	}

	this.setresult = function() {
		closePopup('BackgroundDiv', 'endmatchdiv');
		//window.opener = "";
		window.close();
		window.open("/cims/jsp/SetSecondInning.jsp?isSupperOver=N","CIMS2",
						"location=Yes,directories=Yes,status=yes,menubar=Yes,scrollbars=Yes,resizable=yes,top=0,left=0,width="
						+ (window.screen.availWidth - 20)+ ",height="+ (window.screen.availHeight - 20));
	}
	
	this.updatematchresult = function() {
		var matchid =$$("hdmatchid");
		window.open("/cims/jsp/changeResult.jsp?matchId="+matchid+"&flag=1","CIMSINNINGS3",
				"location=no,directories=no,status=Yes,scrollbars=Yes,resizable=Yes,top=50," +
				"left=150,width="+(window.screen.availWidth-400)+",height="+(window.screen.availHeight-300));
	}
	
	
	this.setsupperover = function() {
		closePopup('BackgroundDiv', 'endmatchdiv');
		window.close();
		window.open("/cims/jsp/setSupperOverSecondInning.jsp?isSupperOver=Y","CIMS2",
						"location=Yes,directories=Yes,status=yes,menubar=Yes,scrollbars=Yes,resizable=yes,top=0,left=0,width="
						+ (window.screen.availWidth - 20)+ ",height="+ (window.screen.availHeight - 20));
	}
	this.goToLogin = function() {
		try {
			document.main.action = "/cims/jsp/Logout.jsp"
			document.main.submit();
		} catch (err) {
			alert(err.description + "callFunction.js.goToLogin");
		}
	}
	
	this.newBatsmanSelection = function(selbat) {
		if ($$(selbat) == "") {
			alert("Select batsman.");
			return false;
		} else {
			var playerArr = $$(selbat).split("~");
			playerArr[1];
			var r = confirm("Do you want to select (" + playerArr[1]
					+ ")  as new batsman.");
			if (r == true) {
				insRow('BATT_TABLE');
			}
		}
	}
	this.intervalpopup = function(backgroundiv, hidediv, showdiv) {
		//closePopup(backgroundiv, hidediv );
		//closePopup('BackgroundDiv', 'BatList');

		//closePopup('BackgroundDiv', 'BowlList');	
		/*closePopup('BackgroundDiv', 'remarkList');	
		closePopup('BackgroundDiv', 'penaltyremarkList');
		closePopup('BackgroundDiv', 'swapBowlerRemarkList');
		closePopup('BackgroundDiv', 'retireRemarkList');
		closePopup('BackgroundDiv', 'totallandmark');
		closePopup('BackgroundDiv', 'batsmanlandmark');
		closePopup('BackgroundDiv', 'partnershiplandmark');*/
		showPopup(backgroundiv, showdiv);
	}
	this.callinterval = function(id) {
		var interval = $$(id);
		if ($$(id) == '') {
			alert("Please select interval type")
			return false;
		}
		closePopup('BackgroundDiv', 'linkintervaldiv');
		var intervalArr = interval.split("~");
		if (intervalArr[0] == 'drwamatch') {
			callFun.endMatch(intervalArr[0], intervalArr[1])
		} else {
			this.Interval(intervalArr[0], intervalArr[1]);
		}
	}
	this.DiplayReportForInningOne = function(pos) {
		closePopup('BackgroundDiv', 'selectpreviousinning');
		var flg = "P";
		var reportflag = 'Y'
		if (document.getElementById('str' + pos).value != null
				&& document.getElementById('str' + pos).value != "") {
			var iningOneId = document.getElementById('str' + pos).value;
			window.open("/cims/jsp/previousInningsDetail.jsp?InningIdPre="+ iningOneId + "&flg=" + flg,
							"scorecard",
							"location=no,directories=no,status=yes,menubar=no,scrollbars=no,resizable=no,top=20,left=20,width=810,height=630");
		}
	}
	this.showinningreport = function() {
		showPopup('BackgroundDiv', 'selectpreviousinning');
	}
	this.setmatchpoint = function() {
		window.open("/cims/jsp/MatchPoints.jsp?",
						"CIMS3",
						"location=Yes,directories=No,status=yes,menubar=No,scrollbars=Yes,resizable=Yes,top=90,left=90,width=550,height=400");
	}
	
	this.updateBall = function(ballid) {//ballid is '' for swap batsmen of checked checkboxes 
		inningId = document.getElementById('inningId').value;
		if (ballid == "") {
			var ballIdsArr = document.forms[0].chkBallId // get checked balls ids
			var ballId = ""
			for (i = 0; i < ballIdsArr.length; i++) {
				if (ballIdsArr[i].checked) {
					ballId = ballId + ballIdsArr[i].value + "~";
				}
			}
			if (ballId == "") {
				alert("Please check balls for which you want to swap batsmen.")
			}
			ajexObj.sendDataSwapBatsman(ballId, inningId);//for checked balls
		} else { // for swapping all batsmen in over
			ajexObj.sendDataSwapBatsman(ballid, inningId);//for all balls
		}
	}
	this.updateOverRuns = function(ballNo, ballid, runs, wideball, noball,
			legbyes, byes, wicket, overno, date, batsman, bowler, bowlerid) {
		showPopup('BackgroundDiv', 'updateRunsDiv');
		ajexObj.sendDataUpdateOverRuns(ballNo, ballid, runs, wideball, noball,
				legbyes, byes, wicket, overno, date, batsman, bowler, bowlerid);
		if (wicket == "Y") {
			showPopup('BackgroundDiv', 'updateWicketDiv');
			ajexObj.sendDataUpdateWicket(ballid, batsman, overno);
		} else if (wicket == "N") {
			closePopup('BackgroundDiv', 'updateWicketDiv')
		}
	}

	this.updateRow = function(ballid) {
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
		var bowlerid = document.getElementById('selBowlerName').value
		var over = document.getElementById('hdOverNumber').value

		if (run == '0') {
			runType = "1"
		} else if (run == '1') {
			runType = "2"
		} else if (run == '2') {
			runType = "3"
		} else if (run == '3') {
			runType = "4"
		} else if (run == '4') {
			runType = "26"
		} else if (run == '5') {
			runType = "6"
		} else if (run == '6') {
			runType = "27"
		} else if (run == '7') {
			runType = "8"
		} else if (run == '8') {
			runType = "9"
		} else if (run == '9') {
			runType = "10"
		} else if (run == '4B') {
			runType = "5"
		} else if (run == '6B') {
			runType = "7"
		}

		if (wideBall != '0'
				&& document.getElementById('ballWideBall').disabled == false) {
			wideBallType = "12"
		}
		if (noBall != '0'
				&& document.getElementById('ballNoBall').disabled == false) {
			noBallType = "13"
		}
		if (legbyes != 'N'
				&& document.getElementById('ballLegByes').disabled == false) {
			legByesType = '15'
		}
		if (byes != 'N'
				&& document.getElementById('ballByes').disabled == false) {
			byesType = '14'
		}
		//alert(runType+"/"+wideBallType+"/"+noBallType+"/"+legByesType+"/"+byesType)

		var currDate;
		currDate = new Date();
		currDate.setSeconds(0);
		var ind = date.indexOf("/")
		if (ind != -1) {
			var textboxDate = convertdatetime(date)
			if (((textboxDate - currDate) / (1000 * 60)) > 0) {
				alert("Date and time cannot be more than current date and time");
				return false
			}
		}

		var formattedDate = this.addSecdate(date)
		showPopup('BackgroundDiv', 'updateRunsDiv');

		ajexObj.sendDataUpdateRow(ballid, runType, wideBallType, noBallType,
				legByesType, byesType, formattedDate, over, bowlerid);
	}
	/*to disable wideBall combo box disabled if noBall combobox is selected for 1 and vice a versa 
	to disable Legbyes combo box disabled if Byes combobox is selected for Y and vice a versa 
	 */
	this.changeBall = function(flag, ballid, batsman, overno) {
		if (flag == 'wide') {
			var wideBall = document.getElementById('ballWideBall').value
			if (wideBall == "0") {
				document.getElementById('ballNoBall').disabled = false
			} else {
				document.getElementById('ballNoBall').disabled = true
			}
		} else if (flag == 'noball') {
			var noBall = document.getElementById('ballNoBall').value
			if (noBall == "0") {
				document.getElementById('ballWideBall').disabled = false
			} else {
				document.getElementById('ballWideBall').disabled = true
			}
		} else if (flag == 'legbyes') {
			var legByes = document.getElementById('ballLegByes').value
			if (legByes == "N") {
				document.getElementById('ballByes').disabled = false
			} else if (legByes == "Y") {
				document.getElementById('ballByes').disabled = true
			}
		} else if (flag == 'byes') {
			var byes = document.getElementById('ballByes').value
			if (byes == "N") {
				document.getElementById('ballLegByes').disabled = false
			} else if (byes == "Y") {
				document.getElementById('ballLegByes').disabled = true
			}
		}

		if (flag == 'wicket') {
			var wicket = document.getElementById('ballWickets').value
			if (wicket == "Y") {
				showPopup('BackgroundDiv', 'updateWicketDiv');
				ajexObj.sendDataUpdateWicket(ballid, batsman, overno);
			} else if (wicket == "N") {
				closePopup('BackgroundDiv', 'updateWicketDiv')
			}
		}
	}
	this.editinterval = function() {
		ajexObj.updateInterval();
	}

	this.viewPlayers = function(matchid) {
		window.open("/cims/jsp/ViewTeamPlayersList.jsp?match=" + matchid,
						"playerlist",
						"location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=Yes,top=100,left=100,width=800,height=450");
	}

	this.exit = function() {
		//window.opener="";
		// window.close();
		self.close();//dipti 10 05 2009
	}

	this.updateRowWicket = function(ballid) {
		var wicketType = document.getElementById('selWicketType').value
		var fielder1 = document.getElementById('selFielder1').value
		var fielder2 = document.getElementById('selFielder2').value
		var Striker = document.getElementById('selBatsmanName').value
		ajexObj.sendDataUpdateWicketDetail(ballid, wicketType, fielder1,
				fielder2, Striker);

	}
	this.offline = function(maindiv, popupdiv) {
		if ($('chkonline').checked) {
			newData.date = "";
			this.setonlineflag("online");
		} else {
			if ($$("txtofflinedate") == '') {
				alert("Please enter offline date");
				return false;

			}
			var previousdate = $$("hdofflinedate");
			var currentdate = $$("txtofflinedate");
			var returnflag = validatedate(currentdate, previousdate)
			var dtToday = new Date();
			Cal = new Calendar(dtToday);
			newData.date = $$('txtofflinedate');
			this.setonlineflag("ofline");
		}
		if (returnflag != false) {
			closePopup(maindiv, popupdiv);
		}
	}
	this.checkstartmatchstatus = function() {
		//  var r = confirm("Do you want to play offline?");
		// if (r == true) {
		//      callFun.extraFunction('online','0')
		//  }	
		showPopup('BackgroundDiv', 'confirmOnline');//dipti
	}

	this.callConfirmOfflineDiv = function() {//dipti
		callFun.extraFunction('online', '0')
	}
	this.closeOfflineDiv = function() {//dipti
		closePopup('BackgroundDiv', 'confirmOnline')
		closePopup('BackgroundDiv', 'offlinediv')
	}
	this.refreshofflinedate = function() {
		newData.date = $$('txtofflinedate');
	}
	this.setonlineflag = function(flag) {
		dateflag = flag;
	}
	this.getonlineflag = function() {
		return dateflag;
	}
	this.adjustinterval = function(div) {
		if ($(div).style.display == '') {
			$(div).style.display = 'none';
		} else {
			$(div).style.display = '';
		}
	}
	this.addSecdate = function(date) {
		var datearr = date.split("/");
		if (datearr.length > 1) {
			var day = datearr[0];
			var month = datearr[1];
			var yeartime = datearr[2];
			var yeartimearr = yeartime.split(' ');
			var year = yeartimearr[0];
			var timearr = yeartimearr[1].split(":");
			var hr = timearr[0];
			var min = timearr[1];
			var ss = timearr[2];
			var caldate = year + "-" + month + "-" + day + " " + hr + ":" + min
					+ ":" + ss;
			return caldate;
		} else {
			return date;
		}

	}// end of function

	this.setlandmarkflag = function() {
		return landmarkflag;
	}

	this.chkoffline = function(chkname, txtname) {
		if ($(chkname).checked) {
			$(txtname).disabled = true;
			$('imganchor').disabled = true;
			this.setonlineflag("online");
			document.getElementById('txtofflinedate').value = "";
		} else {
			$(txtname).disabled = false;
			$('imganchor').disabled = false;
			this.setonlineflag("ofline");
		}
	}

	this.updateTime = function() { // add time in offline
		try {

			var time = document.getElementById("txtofflinedate").value;
			var datetimearr = time.split(" ");
			var str = datetimearr[1].split(":");
			var hre = str[0];
			var mins = str[1];
			var sec = str[2];
			sec = parseInt(sec, 10) + 2;
			if (sec >= 60) {
				mins++;
				var sec = 00;
				if (mins >= 60) {
					hre++;
					var mins = 00;
					if (hre >= 24) {
						var hre = 00;
					}
				}
			}
			/*Commented by : bhushan
			 * Desc: ParseInt is not working for 01 to 09 numbers so it changes 
			 * to ParseInt(var,10).
			 * */
			if (parseInt(sec, 10) < 10) {
				if (sec.length == 1) {
					sec = 0 + "" + sec;
				}
			}
			if (parseInt(mins, 10) < 10) {
				if (mins.length == 1) {
					mins = 0 + "" + mins;
				}
			}
			if (parseInt(hre, 10) < 10) {
				if (hre.length == 1) {
					hre = 0 + "" + hre;
				}
			}
			if (mins == 0) {
				mins = 01;
			}
			if (sec == 0) {
				sec = 01;
			}
			if (hre == 0) {
				hre = 01;
			}

			hre = parseInt(hre, 10);
			mins = parseInt(mins, 10);
			sec = parseInt(sec, 10);

			var caltime = hre + ":" + mins + ":" + sec
			document.getElementById("txtofflinedate").value = datetimearr[0]
					+ " " + caltime;

		} catch (err) {
			alert(err.description + "callFunction.js.updateTime");
		}
	}
	this.extraFunction = function(type, run) {
		try {

			if (type == "shortrun") {
				// extratype('extrasubmenu');
				showState('extrasubmenu');
			} else if (type == "undo") {
				hideMenu();
				var r = confirm("Do you want to delete previous entry? If yes, then please check current status.");
				if (r == true) {
					ajexObj.sendShortRun('undo', run);
				}
			} else if (type == "moreundo") {
				hideMenu();
				var r = confirm("Do you want to delete previous entries? If you are deleting all the overs then please close this window for proper scoring.");
				if (r == true) {
					showPopup('BackgroundDiv', 'moreundo');
				}
			} else if (type == "online") {
				hideMenu();
				ajexObj.sendlastballtime();
				showPopup('BackgroundDiv', 'offlinediv');
				if ($('chkonline').checked) {
					$('txtofflinedate').disabled = true;
					$('imganchor').disabled = true;
				} else {
					$('txtofflinedate').disabled = false;
					$('imganchor').disabled = false;
				}
			} else if (type == "staticremark") {
				hideMenu();
				var response = showPopup('BackgroundDiv', 'penaltyremarkList');
				if (response) {
					newData.description = $$('txtpenaltyremark');

				}

			} else if (type == "setmaxover") {
				hideMenu();
				showPopup('BackgroundDiv', 'modifiedtime');
			}else if (type == "setstrikernonstriker") {
				hideMenu();
				showPopup('BackgroundDiv','changestrikerPosition');
			} else if (type == "extrasubmenu") {
				hideMenu();
				ajexObj.sendShortRun('shortrun', run);
			} else if (type == "newbatsman") {
				hideMenu();
				var val;
				var strikerrow = bastmenObj.getstrikerRowId();
				var strikeroutname = $('BATT_TABLE').rows[strikerrow].cells[COL_BATT_OUT].innerHTML;
				var strikerbowlername = $('BATT_TABLE').rows[strikerrow].cells[COL_BATT_BOWLER].innerHTML;
				var nonstrikerrow = bastmenObj.getnonStrikerRowId();
				var nonstrikeroutname = $('BATT_TABLE').rows[nonstrikerrow].cells[COL_BATT_OUT].innerHTML;
				var nonstrikerbowlername = $('BATT_TABLE').rows[nonstrikerrow].cells[COL_BATT_BOWLER].innerHTML;
				if (nonstrikeroutname == "" && nonstrikerbowlername == "") {
					val = nonstrikerrow;
				} else if (strikeroutname == "" && strikerbowlername == "") {
					val = strikerrow;
				}
				var num;
				if (parseInt(strikerrow) > parseInt(nonstrikerrow)) {
					num = parseInt(strikerrow) + parseInt(1);
					bastmenObj.setnonstrikernumber(num);
					bastmenObj.setstrikernumber(val);
					bastmenObj.setNewBatsmanRowId(num);
				} else {
					num = parseInt(nonstrikerrow) + parseInt(1);
					bastmenObj.setstrikernumber(num);
					bastmenObj.setnonstrikernumber(val);
					bastmenObj.setNewBatsmanRowId(num);
				}

				showPopup('BackgroundDiv', 'BatList');
			}

		} catch (err) {
			alert(err.description + "callFunction.js.extraFunction");
		}
	}

}