
/******************Referee report Scripting part*********************/

	function GetXmlHttpObject(){//ajax code to get the div from other page.
		var xmlHttp=null;
		try{
			// Firefox, Opera 8.0+, Safari
			xmlHttp=new XMLHttpRequest();
		}catch (e){
			// Internet Explorer
			try{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}catch (e){
	        	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}

	//To be called by Breaches add button.
	function AddBreaches(){
		var addflag = "1";// To insert breaches data selected record 
		if(document.getElementById("dpPlayer").value == 0){
			alert("Please select Player");
			document.getElementById("dpPlayer").focus();
			return false;
		}else if(document.getElementById("dpLevel").value == 0){
			alert("Please select Level");
			document.getElementById("dpLevel").focus();
			return false;
		}else if(document.getElementById("dpOffence").value == 0){
			alert("Please select Offence");
			document.getElementById("dpOffence").focus();			
			return false;			
		}else if(document.getElementById("dpPenalty").value == 0){
			alert("Please select Penalty");
			document.getElementById("dpPenalty").focus();
			return false;			
		}else{
			var matchid = document.getElementById("hdmatchid").value;
			var playerRoleId = document.getElementById("dpPlayer").value;
			var OffenceId = document.getElementById("dpOffence").value;
			var PenaltyId = document.getElementById("dpPenalty").value;
			if(PenaltyId == "1"){
				var Remark = document.getElementById("Fees").value;			
			}else{
				var Remark = document.getElementById("Banned").value;			
			}			
			xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null){
				alert ("Browser does not support HTTP Request");
				return;
			}else{
				var url ;
		    	url="/cims/jsp/BreachesDataSave.jsp?matchid="+matchid+"&playerRoleId="+playerRoleId+"&OffenceId="+OffenceId+"&PenaltyId="+PenaltyId+"&Remark="+Remark+"&addflag="+addflag;
				document.getElementById("BreachesDiv").style.display='';
				document.getElementById("CurrentPageOffenceDiv").style.display='none'
				//xmlHttp.onreadystatechange=stChgBreachesResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("BreachesDiv").innerHTML = responseResult;
				}
			    document.getElementById("dpPlayer").value = "0";		   	
			}
		}
	}

	/*function stChgBreachesResponse(){
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("BreachesDiv").innerHTML = responseResult;
		}
	}*/

	/************************ onclick of submit button.**************************/
	function submitRefereeData(){
		if(document.getElementById("hdUmpireId1").value == "0" || document.getElementById("hdUmpireId2").value == "0"){
			alert("Both Umpires Should Be Assigned For Match.")
		}else{
			if((document.getElementById('hidden_ids').value != "") && (document.getElementById('hidden_RefereeId').value != "")
			&&(document.getElementById('hiddengr_ids').value != "")){
				var isComplete = true;
				//validation of the question uncomment if required.
				/*if(document.getElementById('hidden_ids').value != ""){
					var str = document.getElementById('hidden_ids').value.split(",");
					for(var count = 0; count < str.length; count = count + 2){
						if(str[count+1] == ("Y")){
							if(document.getElementById(str[count]).value == "0" ){
								alert("Please Fill Question - "+document.getElementById("que_"+str[count]).innerHTML)
								document.getElementById(str[count]).focus()
								return false
								isComplete = false;
							}else if(document.getElementById("ump2"+str[count]).value == "0"){
								alert("Please Fill Question - "+document.getElementById("que_"+str[count]).innerHTML+" For Second Umpire")
								document.getElementById("ump2"+str[count]).focus()
								return false
								isComplete = false;
							}
						}
					}								
				}*/			
				/*if(document.getElementById('hiddengr_ids').value != ""){
					var grstr = document.getElementById('hiddengr_ids').value.split(",");				
					for(var grcount = 0; grcount < grstr.length; grcount = grcount + 2){					
							if(grstr[grcount+1] == ("Y")){
							if(document.getElementById("groundId"+grstr[grcount]).value == "0"){
								alert("Please Selec "+document.getElementById("groundque_"+grstr[grcount]).innerHTML)							
									document.getElementById("groundId"+grstr[grcount]).focus()
									return false							
									isComplete = false;
							}
						}
					}
				}
				if(document.getElementById('hidden_RefereeId').value != ""){
						var Refereestr = document.getElementById('hidden_RefereeId').value.split(",");					
						for(var refcount = 0; refcount < Refereestr.length; refcount = refcount + 2){					
							if(Refereestr[refcount+1] == ("Y")){																						
								if(document.getElementById("refereeId"+Refereestr[refcount]).value == "0" ){															
									alert("Please Fill Question "+document.getElementById("refque_"+Refereestr[refcount]).innerHTML)							
									document.getElementById("refereeId"+Refereestr[refcount]).focus()
									return false							
									isComplete = false;
								}
							}else{
							
							}
						}
				}*/			
				if(!isComplete){				
					return false;
				}else{
					document.getElementById("hdid").value = 1;
					document.frmRefereeReport.submit();
				}
			}else{
				alert("Please Log Out And Log In By Referee Login Id.")
			}
		}
	}

	function DeleteRecord(playerRoleId,OffenceId){		
		var addflag = "2";	// To delete selected record 		
		var matchid = document.getElementById("hdmatchid").value;						
		var PenaltyId =  "";
		var Remark = "";	
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			var url ;
	    	url="/cims/jsp/BreachesDataSave.jsp?matchid="+matchid+"&playerRoleId="+playerRoleId+"&OffenceId="+OffenceId+"&PenaltyId="+PenaltyId+"&Remark="+Remark+"&addflag="+addflag;
			document.getElementById("BreachesDiv").style.display='';
			document.getElementById("CurrentPageOffenceDiv").style.display='none'
			//xmlHttp.onreadystatechange=stChgBreachesResponse;
			xmlHttp.open("post",url,false);
		   	xmlHttp.send(null);
		   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				var responseResult= xmlHttp.responseText;
				document.getElementById("BreachesDiv").innerHTML = responseResult;
			}
		    document.getElementById("dpPlayer").value = "0";		   	
		}
	}

	function refereetotal(){	
		if(document.getElementById('hidden_ids').value != ""){		
			var str = document.getElementById('hidden_ids').value.split(","); // Combo Value
			var ump1_total = 0;
			var ump2_total = 0;
			for(var count = 0; count < str.length; count = count + 2){
				if(str[count+1] == ("Y")){
					ump1_total = parseInt(ump1_total) + parseInt(document.getElementById(str[count]).value);
				}
				if(str[count+1] == ("Y")){
					ump2_total = parseInt(ump2_total) + parseInt(document.getElementById("ump2"+str[count]).value);
				}
			}
			document.getElementById("txtUmpireTotalPt1").value = ump1_total
			document.getElementById("txtUmpireTotalPt2").value = ump2_total
		}else{
			document.getElementById("txtUmpireTotalPt1").value = 0;
			document.getElementById("txtUmpireTotalPt2").value = 0;
		}
	}

	function showDiv(){
		if(document.getElementById("dpPenalty").value == "1"){
			document.getElementById("FeeDiv").style.display='';
			document.getElementById("BannedDiv").style.display = 'none';
			document.getElementById("ReprimindDiv").style.display = 'none';
		}else if(document.getElementById("dpPenalty").value == "2"){
			document.getElementById("BannedDiv").style.display='';
			document.getElementById("FeeDiv").style.display = 'none';
			document.getElementById("ReprimindDiv").style.display = 'none';
		}else{
			document.getElementById("ReprimindDiv").style.display='';
			document.getElementById("FeeDiv").style.display = 'none';
			document.getElementById("BannedDiv").style.display = 'none';
		}
	}
	
	function addOffences(){
		var level = document.getElementById("dpLevel").value;
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			var url ;
	    	url="/cims/jsp/GetLevel.jsp?level="+level;
			document.getElementById("OffencesDiv").style.display='';
			document.getElementById("tempDev").style.display='none';
			//xmlHttp.onreadystatechange=stChgOffenceResponse;
			xmlHttp.open("post",url,false);
		   	xmlHttp.send(null);
		   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				var responseResult= xmlHttp.responseText;
				document.getElementById("OffencesDiv").innerHTML = responseResult;
			}
		}
	}

	/*function stChgOffenceResponse(){
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("OffencesDiv").innerHTML = responseResult;
		}
	}*/
		
	function DecideLevel(){		
		if(document.getElementById("dpPlayer").value == 0){
			alert("Please select Player");
			return false;
		}else{
			var matchid = document.getElementById("hdmatchid").value;
			var playerId = document.getElementById("dpPlayer").value;//Player user_role_id.
			var flg = "1" ;//To getthe level of breaches of player.
			xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null){
				alert ("Browser does not support HTTP Request");
		        return;
			}else{
				var url ;
		    	url="/cims/jsp/GetOffencesOnLevel.jsp?matchid="+matchid+"&playerId="+playerId+"&flg="+flg;
				document.getElementById("LevelDiv").style.display='';
				document.getElementById("tempLevelDev").style.display='none';
				//xmlHttp.onreadystatechange=stChgLevelResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);	
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("LevelDiv").innerHTML = responseResult;
				}	   	
			}
		}		
	}
	
	/*function stChgLevelResponse(){
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("LevelDiv").innerHTML = responseResult;
		}
	}*/
	
	function enterRemark(id){	
		var remarkDiv = document.getElementById( 'remDiv_'+id );
		var remarkTextArea = document.getElementById( 'rem_'+id );			
		if( remarkDiv.style.display == 'none' ){
			remarkDiv.style.display = ''
			remarkTextArea.focus();
		}else{
			if(remarkTextArea.value == ""){
				remarkDiv.style.display = 'none'
			}
		}
	}
	
	function enterUmp2Remark(id){
		var remark2Div = document.getElementById( 'remDiv_ump2'+id );
		var remark2TextArea = document.getElementById( 'rem_ump2'+id );	
		if( remark2Div.style.display == 'none' ){
			remark2Div.style.display = ''
			remark2TextArea.focus();
		}else{
			if(remark2TextArea.value == ""){
				remark2Div.style.display = 'none'
			}
		}		
	}
		
	function enterUmp1Remark(id){
		var remark1Div = document.getElementById( 'remDiv_ump1'+id );
		var remark1TextArea = document.getElementById( 'rem_ump1'+id );	
		if( remark1Div.style.display == 'none' ){
			remark1Div.style.display = ''
			remark1TextArea.focus();
		}else{
			if(remark1TextArea.value == ""){
				remark1Div.style.display = 'none'
			}
		}		
	}
		
	function enterGroundRemark(id){
		var groundremarkDiv = document.getElementById( 'groundDiv_'+id );
		var groundremarkTxtArea = document.getElementById( 'ground_'+id );
		if( groundremarkDiv.style.display == 'none' ){
			groundremarkDiv.style.display = ''
			groundremarkTxtArea.focus();
		}else{
			if(groundremarkTxtArea.value == ""){
				groundremarkDiv.style.display = 'none';
			}
		}		
	}
	
	
	
	/******************Captain report Scripting part*********************/
	function assign(){
		var isComplete = true;
		if(document.getElementById("hdUmpireId1").value == "0" || document.getElementById("hdUmpireId2").value == "0"){
			alert("Both Umpires Should Be Assigned For Match.")
		}else{
			if(document.getElementById('hidden_ids').value != ""){
				var str = document.getElementById('hidden_ids').value.split(",");
				for(var count = 0; count < str.length; count = count + 2){					
					if(str[count+1] == ("Y")){											
						if(document.getElementById(str[count]).value == "0" ){
							alert("Please Fill Question "+document.getElementById("que_"+str[count]).innerHTML)							
							document.getElementById(str[count]).focus()
							return false;
							isComplete = false;
						}else if(document.getElementById("ump2"+str[count]).value == "0"){
							alert("Please Fill Question "+document.getElementById("que_"+str[count]).innerHTML+" For Second Umpire")							
							document.getElementById("ump2"+str[count]).focus()
							return false							
							isComplete = false;
						}
					}
				}														
				if(!isComplete){				
					return false;
				}else{
					document.getElementById("hdid").value = 1;
					document.frmCaptainReport.submit();
				}
			}else{
				alert("Please Log Out And Log In By Referee Login Id.")
			}
		}	
	}
	
	function total(){	
		if(document.getElementById('hidden_ids').value != ""){
			var str = document.getElementById('hidden_ids').value.split(","); // Combo Value
			var ump1_total = 0;
			var ump2_total = 0;
			for(var count = 0; count < str.length; count = count + 2){
				if(str[count+1] == ("Y")){
				ump1_total = parseInt(ump1_total) + parseInt(document.getElementById(str[count]).value);
			}
			if(str[count+1] == ("Y")){
				ump2_total = parseInt(ump2_total) + parseInt(document.getElementById("ump2"+str[count]).value);
			}
		}
			document.getElementById("txtUmpireTotalPt1").value = ump1_total
			document.getElementById("txtUmpireTotalPt2").value = ump2_total
		}else{		
			document.getElementById("txtUmpireTotalPt1").value = 0;
			document.getElementById("txtUmpireTotalPt2").value = 0;
		}		
	}
	
	function enterCaptainUmp2Remark(id){
		var remark2Div = document.getElementById( 'remDiv_ump2'+id );
		var remark2TextArea = document.getElementById( 'rem_ump2'+id );	
		if( remark2Div.style.display == 'none' ){
			remark2Div.style.display = ''
			remark2TextArea.focus();
		}else{
			if(remark2TextArea.value == ""){
				remark2Div.style.display = 'none'
			}
		}		
	}
		
	function enterCaptainUmp1Remark(id){
		var remark1Div = document.getElementById( 'remDiv_ump1'+id );
		var remark1TextArea = document.getElementById( 'rem_ump1'+id );	
		if( remark1Div.style.display == 'none' ){
			remark1Div.style.display = ''
			remark1TextArea.focus();
		}else{
			if(remark1TextArea.value == ""){
				remark1Div.style.display = 'none'
			}
		}		
	}

	function DisplayReport(){
		document.getElementById("hid").value = document.frmCaptainReport.captain.value;
		document.frmCaptainReport.submit();
	}