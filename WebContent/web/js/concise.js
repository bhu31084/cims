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
	if(validatecreateinning()){
		  $("HidId").value = hidid;	
		  document.getElementById("concise").action="concisecreateinning.jsp";
		  document.getElementById("concise").submit();
	 } 
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