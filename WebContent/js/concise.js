function AddData(){
	document.getElementById("concise").action="ConciseBowling.jsp";
	document.getElementById("concise").submit();
}
function fallofwicketadd(hidid){
	$("HidId").value = hidid;	
		if($("selinning")=="0"){
		alert("Select Inning field");
	  	$("selinning").focus();
	  
	  }else if($("selWicket").value=="0"){
	  	alert("Select wicket field");
	  	$("selWicket").focus();
	  }else if($("selOutBatsman").value=="0"){
	  	alert("Select Out batsman field");
	  	$("selOutBatsman").focus();
	  }else if($("selNotOutBatsman").value=="0"){
	  	alert("Select Not Out batsman field");
	  	$("selNotOutBatsman").focus();
	  }else if($("selNotOutBatsman").value==$("selOutBatsman").value){
	  	alert("Select  Out batsman field and Not Out batsman field should not be same");
	  	$("selOutBatsman").focus();
	  }else{
		document.getElementById("concise").action="ConciseFallOfWicket.jsp";
		document.getElementById("concise").submit();
	 }	
}
function createinning(hidid){
	//if(validatecreateinning()){
		  $("HidId").value = hidid;	
		  document.getElementById("concise").action="concisecreateinning.jsp";
		  document.getElementById("concise").submit();
	 //} 
}
function inningdetails(hidid){
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseInningDetails.jsp";
	  document.getElementById("concise").submit();
	
}
function inningbatting(hidid){
	  var inning =$("selinning").value  
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseMatchTab.jsp?tab=3&HidId="+hidid+"&inning="+inning;
	  document.getElementById("concise").submit();
	
} 

function patnership(hidid){
	  var inning =$("selinning").value  
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseMatchTab.jsp?tab=5&HidId="+hidid+"&inning="+inning;
	  document.getElementById("concise").submit();
	
} 
function fallofwkt(hidid){
	  var inning =$("selinning").value  
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseMatchTab.jsp?tab=6&HidId="+hidid+"&inning="+inning;
	  document.getElementById("concise").submit();
	
}
function scoreingrate(hidid){
	  var inning =$("selinning").value  
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseMatchTab.jsp?tab=7&HidId="+hidid+"&inning="+inning;
	  document.getElementById("concise").submit();
	
}
function scoreingrunrate(hidid){
	 var inning =$("selinning").value  
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseMatchTab.jsp?tab=9&HidId="+hidid+"&inning="+inning;
	  document.getElementById("concise").submit();
}
function concisenewball(hidid){
	 var inning =$("selinning").value  
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseMatchTab.jsp?tab=10&HidId="+hidid+"&inning="+inning;
	  document.getElementById("concise").submit();
}


function indivisualscore(hidid){
	  var inning =$("selinning").value  
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseMatchTab.jsp?tab=8&HidId="+hidid+"&inning="+inning;
	  document.getElementById("concise").submit();
	
}


function inningbowling(hidid){
	  var inning =$("selinning").value  
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseMatchTab.jsp?tab=4&HidId="+hidid+"&inning="+inning;
	  document.getElementById("concise").submit();
	
} 
function test(){
alert("111")
}
function addinningdetails(hidid){
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseBatting.jsp";
	  document.getElementById("concise").submit();
	
}
function addbowlingdetails(hidid){
	  $("HidId").value = hidid;	
	  if($("selinning").value=="0"){
	  	alert("Select Inning field");
	  	$("selinning").focus();
	  
	  }else if($("selBowler").value=="0"){
	  	alert("Select Bowler field");
	  	$("selBowler").focus();
	  }else{
	  	document.getElementById("concise").action="ConciseBowling.jsp";
	  	document.getElementById("concise").submit();
	  }
	
}
function addpaternship(hidid){
	  $("HidId").value = hidid;
	  if($("selinning").value=="0"){
	  	alert("Select Inning field");
	  	$("selinning").focus();
	  }else if($("selBatsmanOne").value=="0"){
	  	alert("Select Batsman 1 field");
	  	$("selBatsmanOne").focus();
	  }else if($("selBatsmanTwo").value=="0"){
	  	alert("Select Batsman 2 field");
	  	$("selBatsmanTwo").focus();
	  }else if($("selBatsmanTwo").value==$("selBatsmanOne").value){
	  	alert("Batsman 1 and batsman 2 should not be same");
	  	$("selBatsmanTwo").focus();
	  }else{
	   document.getElementById("concise").action="ConcisePartnership.jsp";
	   document.getElementById("concise").submit();
	  }
	
}
function scoringrateadd(hidid){
	  $("HidId").value = hidid;	
	   if($("selinning").value=="0"){
	  	alert("Select Inning field");
	  	$("selinning").focus();
	  }else{
		document.getElementById("concise").action="ConciseScoringRate.jsp";
		document.getElementById("concise").submit();
 	  }		  
	
}
function scoringrunrateadd(hidid){
	  $("HidId").value = hidid;	
	  document.getElementById("concise").action="ConciseRunRate.jsp";
	  document.getElementById("concise").submit();
	
}
function newballtekanadd(hidid){
	  $("HidId").value = hidid;	
	  if($("selinning").value=="0"){
	  	alert("Select Inning field");
	  	$("selinning").focus();
	  }else{
	  document.getElementById("concise").action="ConciseNewBall.jsp";
	  document.getElementById("concise").submit();
	  }
}
function indivisualscoringadd(hidid){
	  $("HidId").value = hidid;	
	  if($("selinning").value=="0"){
	  	alert("Select Inning field");
	  	$("selinning").focus();
	  }else  if($("selBatsman").value=="0"){
	  	alert("Select Batsman field");
	  	$("selBatsman").focus();
	  }else{
	    document.getElementById("concise").action="conciseindividualsscoring.jsp";
	    document.getElementById("concise").submit();
	  }  
	
}


function validatecreateinning(){
var fromdate = $("txtstarttime").value;
	var todate = $("txtendtime").value;
	if($("txtstarttime").value==""){
		alert("Please Enter a start date");
		$("txtstarttime").focus();
		return false;
	}else if($("txtendtime").value==""){
		alert("Please Enter a end date");
		$("txtendtime").focus();
		return false;
	}else if($("selbattingteam").value== $("selbowlingteam").value){
		alert("Batting Team and bowling team should not same");
		$("selbattingteam").focus();
		return false;
	}else if(fromToDateValidate(fromdate,todate) == false){
		alert("Please select Fromdate less than or equal to Todate");
		return false;
	}else{
		return true;
	}
}
function calextratotal(){
	document.getElementById("txttotal").value = parseInt(document.getElementById("txtnoball").value) +
												parseInt(document.getElementById("txtwideball").value) +
												parseInt(document.getElementById("txtbyes").value) +
												parseInt(document.getElementById("txtlegbyes").value) +	
												parseInt(document.getElementById("txtpenalty").value)
}

function clearTextBox(id){	
	if(document.getElementById(id).value == '0'){
		document.getElementById(id).value = "";
	}
}

function fillZero(id){
	if(document.getElementById(id).value == ''){
		document.getElementById(id).value = '0';
	}
}

function wicketTypeChanged(){
	var val = document.getElementById("selHowOut").value;
	if(val == 2 || val == 3 || val == 4 || val == 6 || val == 21 || val == 23 || val == 27 || val == 28){
		document.getElementById("selFielderOne").disabled = false;
		document.getElementById("selFielderTwo").disabled = false;		
	}else{
		document.getElementById("selFielderOne").disabled = true;
		document.getElementById("selFielderTwo").disabled = true;		
	}
	
	if(val == 12 || val == 0){
		document.getElementById("selBowler").disabled = true;		
	}else{
		document.getElementById("selBowler").disabled = false;
	}
}
/*
2	st	Stumped
3	st	Wide + Stumped
4	ct	Caught		
6	ct wk	Caught by WicketKeeper
21	run out	Run Out
22	run out	Wide + Run Out
23	run out	No Ball + Run Out
27	run out	Byes + Run Out
28	run out	LegByes + Run Out


----- fielders not required -----
1	b	Bowled
5	ct&b	Caught by Bowler
7	Hit The Ball Twice	Hit The Ball Twice
8	hit wkt	Hit Wicket
9	lbw	Leg Before Wicket
10	Handled the Ball	Handled the Ball
11	Obstructing The Field	Obstructing The Field
12	Timed Out	Timed Out
13	Handled the Ball	Wide + Handled the Ball
14	Obstructing The Field	Wide + Obstructing The Field
15	Handled the Ball	No Ball +  Handled the Ball
18	Obstructing The Field	No Ball + Obstructing The Field
19	hit wkt	Wide + Hit Wicket
20	Hit The Ball Twice	No Ball + Hit The Ball Twice
24	retires	retires
25	Retired Out	Retired Out
26	Absent Hurt 	Absent Hurt


----- Bowler not required ------
12	Timed Out	Timed Out
*/