<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.text.SimpleDateFormat,
				java.util.*"
%>	
<%  	response.setHeader("Pragma","private");
		response.setHeader("Pragma", "No-cache");
	    response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");  
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
	try{
		String matchId = (String)session.getAttribute("matchId");
		String InningId= (String)session.getAttribute("InningId");
		System.out.println("InningId "+InningId);
%>					
<html>
<head>
<title>Match Analysis Table</title>       
	<link rel="stylesheet" type="text/css" href="../css/tabexample.css"> 
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/csms1.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css"/> 
	<link href="../css/csms.css" rel="stylesheet" type="text/css">
	<script>
	/*Inning Time Calculation -Archana*/
		var xmlHttp=null;
		
		function GetXmlHttpObject() {
		      try{
		         //Firefox, Opera 8.0+, Safari
		         xmlHttp=new XMLHttpRequest();
		       }
		    catch (e){
		         // Internet Explorer
		         try{
		           xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		         }
		         catch (e){
		           xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		         }
			}
		     return xmlHttp;
	 	}
		
		function ShowInningTimeCalculation(){ 		
 		try { 
			xmlHttp = this.GetXmlHttpObject();
       		if (xmlHttp == null) {
       	
	           alert("Browser does not support HTTP Request");
	           return;
	        }else{	     
				var url = "/cims/jsp/InningTimeCalculation.jsp";
				//xmlHttp.onreadystatechange = this.reciveInningTimeCalculation;
				document.getElementById("showInningTimeDiv").style.display='';
				document.getElementById("showFourSixDiv").style.display='none';
				document.getElementById("showWicketsDiv").style.display='none';
				document.getElementById("showExtrasDiv").style.display='none';
				document.getElementById("showPartnerShipDiv").style.display='none';
			    xmlHttp.open("post", url, false);
	   			xmlHttp.send(null);
	   			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
         	     try {
               	  var responseResult = xmlHttp.responseText ;
                  document.getElementById('showInningTimeDiv').innerHTML = responseResult;
				  //showPopup('BackgroundOverDiv', 'showInningTimeDiv');
            	 }catch(err){
               	   alert(err.description + 'reciveInningTimeCalculation()');
                 }
                }
	   		}
   		} catch(err) {
	        alert(err.description + 'ShowInningTimeCalculation()');
     	}
 	    }

 	
 	/*ShowFour/Sixer() -Archana*/
	 	function ShowFourSixer(){ 		 		
	 	  try { 
				xmlHttp = this.GetXmlHttpObject();
	       		if (xmlHttp == null) {
	       	
		           alert("Browser does not support HTTP Request");
		           return;
		        }else{
					var url = "/cims/jsp/GetFoursAndSix.jsp";
					//xmlHttp.onreadystatechange = this.reciveShowFourSixer;
					document.getElementById("showFourSixDiv").style.display='';
				    xmlHttp.open("post", url, false);
		   			xmlHttp.send(null);
		   			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	         		    try {
	               		 var responseResult = xmlHttp.responseText ;           	
						 document.getElementById('showFourSixDiv').innerHTML = responseResult;
						 //showPopup('BackgroundOverDiv', 'showFourSixDiv');
	        		    }catch(err){
	               		 alert(err.description + 'reciveShowFourSixer()');
	            		}
        			}
		   		}
	   		} catch(err) {
		        alert(err.description + 'ShowFourSixer()');
	     	}
	 	}
 		/*ShowWickets() -Archana*/
	 	function ShowWickets(){ 		
 		  try { 
			xmlHttp = this.GetXmlHttpObject();
       		if (xmlHttp == null) {
       	
	           alert("Browser does not support HTTP Request");
	           return;
	        }else{	     
				var url = "/cims/jsp/GetWickets.jsp";
				//xmlHttp.onreadystatechange = this.reciveShowWickets;
				document.getElementById("showInningTimeDiv").style.display='none';
				document.getElementById("showFourSixDiv").style.display='none';
				document.getElementById("showWicketsDiv").style.display='';
				document.getElementById("showExtrasDiv").style.display='none';
				document.getElementById("showPartnerShipDiv").style.display='none';
			    xmlHttp.open("post", url, false);
	   			xmlHttp.send(null);
	   			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
            	try {
                  var responseResult = xmlHttp.responseText ;
                  document.getElementById('showWicketsDiv').innerHTML = responseResult;
				  //showPopup('BackgroundOverDiv', 'showWicketsDiv');
                }catch(err){
                  alert(err.description + 'reciveShowWickets()');
                }
                }
	   		}
   		  } catch(err) {
        	alert(err.description + 'matchAnalysis()');
     	   }
 	   }
 	
 	  /*ShowExtras() -Archana*/
 	   function ShowExtras(){ 		
 	     try { 
			xmlHttp = this.GetXmlHttpObject();
       		if (xmlHttp == null) {
       	       alert("Browser does not support HTTP Request");
	           return;
	        }else{	     
				var url = "/cims/jsp/GetExtras.jsp";
		//		xmlHttp.onreadystatechange = this.reciveShowExtras;
				document.getElementById("showInningTimeDiv").style.display='none';
				document.getElementById("showFourSixDiv").style.display='none';
				document.getElementById("showWicketsDiv").style.display='none';
				document.getElementById("showExtrasDiv").style.display='';
				document.getElementById("showPartnerShipDiv").style.display='none';
			    xmlHttp.open("post", url, false);
	   			xmlHttp.send(null);
	   			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
            	try {
               	  var responseResult = xmlHttp.responseText ;
                  document.getElementById('showExtrasDiv').innerHTML = responseResult;
				  //showPopup('BackgroundOverDiv', 'showExtrasDiv');
            	}catch(err){
                  alert(err.description + 'reciveShowExtras()');
                }
               }
	   		}
   		  } catch(err) {
            alert(err.description + 'matchAnalysis()');
     	  }
 	    }
 	
 		/*ShowPartnership() -Archana*/
	 	function ShowPartnership(){ 		
 		  try { 
			xmlHttp = this.GetXmlHttpObject();
       		if (xmlHttp == null) {
       	
	           alert("Browser does not support HTTP Request");
	           return;
	        }else{	     
				var url = "/cims/jsp/GetPartnership.jsp";
			//	xmlHttp.onreadystatechange = this.reciveShowPartnership;
				document.getElementById("showInningTimeDiv").style.display='none';
				document.getElementById("showFourSixDiv").style.display='none';
				document.getElementById("showWicketsDiv").style.display='none';
				document.getElementById("showExtrasDiv").style.display='none';
				document.getElementById("showPartnerShipDiv").style.display='';
			    xmlHttp.open("post", url, false);
	   			xmlHttp.send(null);
	   			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
           		  try {
              		var responseResult = xmlHttp.responseText ;
              		document.getElementById('showPartnerShipDiv').innerHTML = responseResult;
					//showPopup('BackgroundOverDiv', 'showPartnerShipDiv');
           		  }catch(err){
               		alert(err.description + 'reciveShowPartnership()');
            	   }
        		}
	   		}
   		   } catch(err) {
             alert(err.description + 'ShowPartnership()');
     	    }
 	    }
 	
 		function CloseMatchAnalysis(){ 		
 		try { 
	 		window.close();
   		} catch(err) {
        alert(err.description + 'CloseMatchAnalysis()');
     	}
     	}	
 		function editdata(val){
     	 if(document.getElementById("edit"+val).value=="Edit"){
	     		document.getElementById("selBatsmen"+val).disabled=false;
	     		document.getElementById("selFielderOne"+val).disabled=false;
	     		document.getElementById("selFielderTwo"+val).disabled=false;
	     		document.getElementById("selHowOut"+val).disabled=false;
	     		document.getElementById("selBowler"+val).disabled=true;
	     		document.getElementById("edit"+val).value="Save";
     	 }else{
     	   try { 
			xmlHttp = this.GetXmlHttpObject();
       		if (xmlHttp == null) {
       	
	           alert("Browser does not support HTTP Request");
	           return;
	        }else{	   
	        	var batsman = document.getElementById("selBatsmen"+val).value;
	     		var filder1 = document.getElementById("selFielderOne"+val).value;
	     		var filder2 = document.getElementById("selFielderTwo"+val).value;
	     		var HowOut  = document.getElementById("selHowOut"+val).value;
	     		var bowler  = document.getElementById("selBowler"+val).value;
	     		var ball = document.getElementById("hdball"+val).value;
				var url = "/cims/jsp/GetWickets.jsp?hId=1&batsman="+batsman+"&filder1="+filder1+"&filder2="+filder2+"&HowOut="+HowOut+"&bowler="+bowler+"&ball="+ball;
			    xmlHttp.open("post", url, false);
	   			xmlHttp.send(null);
	   			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
           		  try {
              		var responseResult = xmlHttp.responseText ;
              		alert(responseResult);
					document.getElementById("selBatsmen"+val).disabled=true;
		     		document.getElementById("selFielderOne"+val).disabled=true;
		     		document.getElementById("selFielderTwo"+val).disabled=true;
	    	 		document.getElementById("selHowOut"+val).disabled=true;
	     			document.getElementById("selBowler"+val).disabled=true;
	     			document.getElementById("edit"+val).value="Edit";
           		  }catch(err){
               		alert(err.description + 'reciveShowPartnership()');
            	  }
        	   }
	   		}
   		   }catch(err) {
             alert(err.description + 'ShowPartnership()');
     	   }
     	 }
     	}
	
	/*End */
	</script>
	  
</head>
<body  style="background-color: white">
<form  id="frmmatchAnalysis" name="frmmatchAnalysis" method="post">
	<table width="100%" height="10%" >
		<tr>
			<td colspan="5" align="center"><font size="3"><b> Match Analysis </b></font></td>
		</tr>	
		<tr class="contentLastDark">
			<td align="center" ><a href="javascript:ShowFourSixer()"><font style="color:blue;size: 14px" > Four/Six </font></a></td>
			<td align="center" ><a href="javascript:ShowWickets()"><font style="color:blue;size: 14px" > Wickets </font></a></td>
			<td align="center" ><a href="javascript:ShowExtras()"><font style="color:blue;size: 14px" > Extras </font></a></td>
			<td align="center" ><a href="javascript:ShowPartnership()"><font style="color:blue;size: 14px" > Partnership </font></a></td>
			<td align="center" ><a href="javascript:ShowInningTimeCalculation()"><font style="color:blue;size: 14px" >Inning Time Calculation</font></a></td>
		</tr>
		<br>			
		<tr >
			<td colspan="5">
				<div id="showFourSixDiv" style='display: none'>
				</div>
				<div id="showWicketsDiv" style='display: none'>
				</div>
				<div id="showExtrasDiv" style='display: none' >
				</div>
				<div id="showPartnerShipDiv" style='display: none' >
				</div>
				<div id="showInningTimeDiv" style='display: none' >
				</div>
			</td>
		</tr>
	</table >	
	<table width="100%" height="90%">														
		<tr>
			<td colspan="5" align="center"><input type="button"  name="btnclose" id="btnclose" value="    Close     " onclick="CloseMatchAnalysis()"></td>
		</tr>
	</table></form>
</body>
</html>				
<%}catch(Exception e){
		e.printStackTrace();
}%>