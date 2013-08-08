	var series = null;		
	var xmlHttp=null;	
	var seriesname = null;
	var SeriesTypeID =null;
	var teamname = null;
	var teamid = null;
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
	
	function getAssociationData(clubId,clubname,currentseason,clublogo){						
		
		//document.getElementById("busyIconDiv").style.display='';
		//document.getElementById("loadPageDiv").style.display='none';	
		//alert("2")	
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{			
				var url;
		    	url="/cims/web/jsp/getAssociationWiseResponse.jsp?currentseason="+currentseason+"&clubId="+clubId+"&clubname="+clubname+"&clublogo="+clublogo;
		    	document.getElementById("AssoDivById").style.display='';
		    	document.getElementById("loadPageDiv").style.display='none';
		    	//document.getElementById("busyIconDiv").style.display='none';		    			    
		    	//xmlHttp.onreadystatechange=stChgAssociationResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;			
					//document.getElementById("loadPageDiv").scrollIntoView;
					//alert(responseResult)			
					document.getElementById("AssoDivById").innerHTML = responseResult;
				}
		}		
	}
	
	/*function stChgAssociationResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;			
			//document.getElementById("loadPageDiv").scrollIntoView;
			//alert(responseResult)			
			document.getElementById("AssoDivById").innerHTML = responseResult;
		}
	}*/	
	
/*	function stChgSeriesPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;			
			document.getElementById("ShowseriesPtDetailsDiv"+seriesname).style.display='';
			document.getElementById("ShowseriesPtDetailsDiv"+seriesname).innerHTML = responseResult;
			seriesname = null;
		}
	}*/
	
	function ShowSeriesPositionDetailDiv(clubID,SeriesTypeID,season){
		//alert(clubID)
		//alert(SeriesTypeID)
		//alert(season)
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowseriesPtDetailsDiv"+SeriesTypeID).style.display==''){
				document.getElementById("plusImage"+SeriesTypeID).src = "../Image/Arrow.gif"; 
				document.getElementById("ShowseriesPtDetailsDiv"+SeriesTypeID).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/web/jsp/getSerieswiseResp.jsp?clubID="+clubID+"&SeriesTypeID="+SeriesTypeID+"&season="+season;		    	
		    	document.getElementById("plusImage"+SeriesTypeID).src = "../Image/ArrowCurve.gif"; 
		    	seriesname = SeriesTypeID;							
				//xmlHttp.onreadystatechange=stChgSeriesPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;			
					document.getElementById("ShowseriesPtDetailsDiv"+seriesname).style.display='';
					document.getElementById("ShowseriesPtDetailsDiv"+seriesname).innerHTML = responseResult;
					seriesname = null;
				}
		   	}
		}		
	}  
		
	function ShowTeamPointsDetailDiv(clubID,SeriesTypeID,season,teamid){
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowTeamMatchDetailsDiv"+teamid).style.display==''){
				document.getElementById("plusImage"+teamid).src = "../Image/Arrow.gif"; 
				document.getElementById("ShowTeamMatchDetailsDiv"+teamid).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/web/jsp/getTeamPointsResponse.jsp?clubID="+clubID+"&SeriesTypeID="+SeriesTypeID+"&season="+season+"&teamid="+teamid;		    	
		    	document.getElementById("plusImage"+teamid).src = "../Image/ArrowCurve.gif"; 
		    	teamname = teamid;							
				//xmlHttp.onreadystatechange=stChgTeamPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;			
					document.getElementById("ShowTeamMatchDetailsDiv"+teamname).style.display='';
					document.getElementById("ShowTeamMatchDetailsDiv"+teamname).innerHTML = responseResult;
					teamname = null;
				}
			   	
		   	}
		}			
	}
	
	function ShowFullScoreCard(matchid){
		//alert("Match ID is***in Association p[age "+matchid)
		//var flag = "ShowRefresh";
		//window.open("FullScoreCard.jsp?matchid="+matchid,"fullscorecard");
		window.open("/cims/web/jsp/FullScoreCard.jsp?matchid="+matchid,"fullscorecard",'top= 50,left = 50,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=920,height=920');
	}