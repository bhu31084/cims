var scorer = null;
var series = null;		
var xmlHttp=null;
var team = null;
var teamname = null;
function GetXmlHttpObject() {
	try{
		//Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
	}catch (e){
		// Internet Explorer
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}catch (e){
			try{
				xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}catch(e){
				alert("Your browser does not support AJAX!");      				
			}	
		}
	}
	return xmlHttp;
}

/*function stChgMatchResponse(){				
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;					
			document.getElementById("MatchPointsDiv").innerHTML = responseResult;		
		}
	}*/
		

function SeriesMatchPointsTally(seriesId,name){			
		var seasonId = document.getElementById("hidseason").value;	
			
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{			
				var url;
		    	url="/cims/web/jsp/TeamRanking.jsp?seriesId="+seriesId+"&seasonId="+seasonId+"&name="+name;
		    	//document.getElementById("MatchPointsDiv").innerHTML = "";
		    	document.getElementById("MatchPointsDiv").style.display='';
		    	document.getElementById("instructionDiv").style.display= 'none'; 		    	
		    	//xmlHttp.onreadystatechange=stChgMatchResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;					
			document.getElementById("MatchPointsDiv").innerHTML = responseResult;		
		}
			   	
		}
	}
	
	/*function stChgTeamMatchPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;			
			document.getElementById("ShowMatchPtDetailsDiv"+teamname).style.display='';
			document.getElementById("ShowMatchPtDetailsDiv"+teamname).innerHTML = responseResult;
			teamname = null;		
		}
	}*/
	
	function ShowTeamPositionDetailDiv(teamsId,seriesId){
		
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowMatchPtDetailsDiv"+teamsId).style.display==''){
				document.getElementById("plusImage"+teamsId).src = "../Image/star.gif"; 
				document.getElementById("ShowMatchPtDetailsDiv"+teamsId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/web/jsp/ShowMatchPointsResponse.jsp?teamsId="+teamsId+"&seriesId="+seriesId;		    	
		    	document.getElementById("plusImage"+teamsId).src = "../Image/star-hover.gif"; 
		    	teamname = teamsId;							
				//xmlHttp.onreadystatechange=stChgTeamMatchPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;			
					document.getElementById("ShowMatchPtDetailsDiv"+teamname).style.display='';
					document.getElementById("ShowMatchPtDetailsDiv"+teamname).innerHTML = responseResult;
					teamname = null;		
				}
		   	}
		}		
	}      
	
	/*function stChgMatchPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;			
			//document.getElementById("secondpageDiv").style.display='';				
			document.getElementById("secondpageDiv").innerHTML = responseResult;
		}
	}*/
	
	function showpoints(seriesId,name){							
		var seasonId = document.getElementById("hidseason").value;		
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{			
				var url;
		    	url="/cims/web/jsp/getAllSeriesResponse.jsp?seriesId="+seriesId+"&seasonId="+seasonId+"&name="+name;
		    	document.getElementById("secondpageDiv").style.display='';		   
		    	document.getElementById("loadpagediv").style.display='none'; 
		    	//xmlHttp.onreadystatechange=stChgMatchPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;			
					//document.getElementById("secondpageDiv").style.display='';				
					document.getElementById("secondpageDiv").innerHTML = responseResult;
				}
		}
	}	
	
	/*
	function stChgTeamFrontPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("ShowMatchPtDetailsDiv1"+team).style.display='';
			document.getElementById("ShowMatchPtDetailsDiv1"+team).innerHTML = responseResult;
			team = null;		
		}
	}
	*/
	function ShowTeamPositionDetailDiv1(teamId,seriesId){
		
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowMatchPtDetailsDiv1"+teamId).style.display==''){
				document.getElementById("plusImage"+teamId).src = "../Image/star.gif"; 
				document.getElementById("ShowMatchPtDetailsDiv1"+teamId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/web/jsp/ShowMatchesNestedResponse.jsp?teamId="+teamId+"&seriesId="+seriesId;		    	
		    	document.getElementById("plusImage"+teamId).src = "../Image/star-hover.gif"; 
		    	team = teamId;							
				//xmlHttp.onreadystatechange=stChgTeamFrontPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("ShowMatchPtDetailsDiv1"+team).style.display='';
					document.getElementById("ShowMatchPtDetailsDiv1"+team).innerHTML = responseResult;
					team = null;		
				}
		   	}
		}		
	}   