	var scorer = null;
	var series = null;		
	var xmlHttp=null;
	var team = null;
	
	/******************************ScorerSeriesMatchDetails.jsp script part.**********************************/	
	
	//End of ScorerSeriesMatchDetails.jsp Report
	
	function GetXmlHttpObject() {
		try{
			//Firefox, Opera 8.0+, Safari
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
		
	/******************************TeamPosition.jsp script part.**********************************/	
	function TeamPositionvalidate() {
			if(document.getElementById("dptournament").value == "" ) {
				alert('Series Name Can Not Be Blank!');
		        document.getElementById("dptournament").focus();
				return false;
			} else if(document.getElementById("dpseason").value == "" ) {
				alert('Season Can Not Be Blank!');
		        document.getElementById("dpseason").focus();
				return false;
			} else {      
				document.frmpoints.action = "/cims/jsp/TeamPosition.jsp";
				frmpoints.submit();
			}
		}
		
	/***********************To Show Match Points Detail Div Using AJAX***********************/
    	
	/*function stChgTeamMatchPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("ShowMatchPtDetailsDiv"+team).style.display='';
			document.getElementById("ShowMatchPtDetailsDiv"+team).innerHTML = responseResult;
			team = null;		
		}
	}*/
	
	function ShowTeamPositionDetailDiv(teamId,seriesId){		
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowMatchPtDetailsDiv"+teamId).style.display==''){
				document.getElementById("plusImage"+teamId).src = "../images/plusdiv.jpg"; 
				document.getElementById("ShowMatchPtDetailsDiv"+teamId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/jsp/ShowMatchPointsResponse.jsp?teamId="+teamId+"&seriesId="+seriesId;		    	
		    	document.getElementById("plusImage"+teamId).src = "../images/minus.jpg"; 
		    	team = teamId;							
				//xmlHttp.onreadystatechange=stChgTeamMatchPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("ShowMatchPtDetailsDiv"+team).style.display='';
					document.getElementById("ShowMatchPtDetailsDiv"+team).innerHTML = responseResult;
					team = null;		
				}
		   	}
		}		
	}      
	//End of TeamPosition.jsp
	
	/*************************************Umpire's Suspect Action Report*********************************************************/
	
	/*********************To Add the remark for selected players******************************/	
	function enterAttributeRemark(){		
			var remarkDiv = document.getElementById( 'RemarkDiv' );
			var remarkTextArea = document.getElementById( 'txtRemarkDiv' );	
			if( remarkDiv.style.display == 'none' ){
				remarkDiv.style.display = ''
				remarkTextArea.focus();
			}else{
				if(remarkTextArea.innerHTML == ""){
					remarkDiv.style.display = 'none'
				}
			}		
		}
		
/*********************To Add the Record by ajax *****************************/			
	
	/*function stChgSuspectActionResponse(){
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("SavedSuspectActionDiv").innerHTML = responseResult;
		}
	}*/
	function imposeMaxLength(Object, MaxLen,event,id,flag){
		
		  if(flag == 1){
			  if(Object.value.length > MaxLen){
				alert("Please enter maximum 255 characters only.")
				document.getElementById(id).focus()
				return false
			  }	else{
				return true
			  }			  
		  }
		  var keyvalue = getKeyCode(event);
		  if(keyvalue==8 || keyvalue==0 || keyvalue==1){
			return true;
		  }else{
			/*  if(Object.value.length > MaxLen){
					alert("falg 2 Please enter maximum 255 characters only.")
					document.getElementById(id).focus()
					return false
			 }else{*/	
			    return (Object.value.length < MaxLen);
			// }
		  }	
		}
	function AddSuspectAction(){		
		var gsFlag = "1";
		if(document.getElementById("dpPlayer").value == 0){
			alert("Please select Player");
			document.getElementById("dpPlayer").focus();
			return false;			
		}else if(document.getElementById("txtRemarkDiv").value == null){
			alert("Please Add Remark");
			document.getElementById("txtRemarkDiv").focus();
			return false;			
		}else{				
			var match_id = document.getElementById("hdmatchid").value;
			var UserID = document.getElementById("hdloginuserId").value;	
			var playerRoleId = document.getElementById("dpPlayer").value;
			var getRemark = document.getElementById("txtRemarkDiv").value;	
			var userRole = document.getElementById("hdUserRole").value;
					
			xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null){
				alert ("Browser does not support HTTP Request");
		        return;
			}else{
				var url ;
		    	url="/cims/jsp/SuspectActionDataSave.jsp?match_id="+match_id+"&UserID="+UserID+"&playerRoleId="+playerRoleId+"&Remark="+getRemark+"&gsFlag="+gsFlag+"&userRole="+userRole;
				document.getElementById("SavedSuspectActionDiv").style.display='';
				document.getElementById("tempDiv").style.display='none';				
			//	xmlHttp.onreadystatechange=stChgSuspectActionResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("SavedSuspectActionDiv").innerHTML = responseResult;
				}			    
			}
		}		
	}

	/*function stChgdeleteSuspectActionResponse(){
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("SavedSuspectActionDiv").innerHTML = responseResult;
		}
	}*/
	
	function DeleteSuspectAction(playerRoleId){
			var match_id = document.getElementById("hdmatchid").value;
			var UserID = document.getElementById("hdloginuserId").value;	
			var userRole = document.getElementById("hdUserRole").value;
			var getRemark = "";
			var gsFlag = "2";
			//return false;		
			xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null){
				alert ("Browser does not support HTTP Request");
		        return;
			}else{
				var url ;
		    	url="/cims/jsp/SuspectActionDataSave.jsp?match_id="+match_id+"&UserID="+UserID+"&playerRoleId="+playerRoleId+"&Remark="+getRemark+"&gsFlag="+gsFlag+"&userRole="+userRole;
				document.getElementById("SavedSuspectActionDiv").style.display='';
				document.getElementById("tempDiv").style.display='none';				
				//xmlHttp.onreadystatechange=stChgdeleteSuspectActionResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);			    
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("SavedSuspectActionDiv").innerHTML = responseResult;
				}
			}
		}		
	
	
	//End of Umpire's Suspect Action Report
	