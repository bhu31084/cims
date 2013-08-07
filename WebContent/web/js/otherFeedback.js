	var scorer = null;
	var series = null;		
	var xmlHttp=null;
	var team = null;
	
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
    	
	function stChgTeamMatchPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("ShowMatchPtDetailsDiv"+team).style.display='';
			document.getElementById("ShowMatchPtDetailsDiv"+team).innerHTML = responseResult;
			team = null;		
		}
	}
	
	function ShowTeamPositionDetailDiv(teamId,seriesId){
		
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowMatchPtDetailsDiv"+teamId).style.display==''){
				document.getElementById("plusImage"+teamId).src = "../Image/star.gif"; 
				document.getElementById("ShowMatchPtDetailsDiv"+teamId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/web/jsp/ShowMatchPointsResponse.jsp?teamId="+teamId+"&seriesId="+seriesId;		    	
		    	document.getElementById("plusImage"+teamId).src = "../Image/star-hover.gif"; 
		    	team = teamId;							
				xmlHttp.onreadystatechange=stChgTeamMatchPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
		   	}
		}		
	}      
	//End of TeamPosition.jsp
	
	
	