<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.sms.SmsSender"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,java.io.*,java.lang.*"%>

<%  
	response.setHeader("Pragma", "private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<%
	//window.open("TopPlayerMatchDetail.jsp?userId="+userId+"&seriesname="+seriesname,"sendsms","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=250,left=250,width="+(window.screen.availWidth-400)+",height="+(window.screen.availHeight-400));
	String seriesId= null; 
	String seasonId= null;
	String pid = null;
	String flag = null;
	String userName = null;
	//+"&userName="+username
	
	seriesId = request.getParameter("seriesId")!=null?request.getParameter("seriesId"):"";
	seasonId = request.getParameter("seasonId")!=null?request.getParameter("seasonId"):"";
	pid = request.getParameter("userId")!=null?request.getParameter("userId"):"";
	flag = request.getParameter("flag")!=null?request.getParameter("flag"):"";
	userName = request.getParameter("userName")!=null?request.getParameter("userName"):"";
	
%>
<html> 
 <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <link href="../css/form.css" rel="stylesheet" type="text/css" />
  <link href="../css/formtest.css" rel="stylesheet" type="text/css" />
  <link href="../css/adminForm.css" rel="stylesheet" type="text/css" />
  <script language="JavaScript" src="../js/jsKeyRestrictvalidation.js"></script>
  
  <link rel="stylesheet" type="text/css" href="../css/common.css">
  <link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
  <link rel="stylesheet" type="text/css" href="../css/menu.css">
  <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">

  <script>
  
	function GetXmlHttpObject() {
        var xmlHttp = null;
        try{
            // Firefox, Opera 8.0+, Safari
            xmlHttp = new XMLHttpRequest();
        }
        catch (e){
            // Internet Explorer
            try{
                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e){
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        return xmlHttp;
    }
	 
  	function callMatchDetail(){
		try {		
			var userid = document.getElementById("hdUserId").value
			var seriesid = document.getElementById("hdSeriesId").value
			var seasonid = document.getElementById("hdSeasonId").value
			var flag = document.getElementById("hdflag").value   
			var username = document.getElementById("hduserName").value 
				
				  xmlHttp = this.GetXmlHttpObject();
		     	  if (xmlHttp == null) {
		               alert("Browser does not support HTTP Request");
		               return;
		          }else{
		          	if(flag == "1"){
				       var url = "/cims/jsp/BtsStatisticsAllMatches.jsp?pid="+userid+"&seriesId="+seriesid+"&userName="+username+"&seasonId="+seasonid+"&flag="+flag
				    }else if(flag == "2"){
				       var url = "/cims/jsp/BowlStatisticsAllMatches.jsp?pid="+userid+"&seriesId="+seriesid+"&userName="+username+"&seasonId="+seasonid+"&flag="+flag
				    } 
				      
		              xmlHttp.onreadystatechange = receiveAllbtsMatches
		              xmlHttp.open("post", url, false);
				   	  xmlHttp.send(null);
		   		  }
		   	} catch(err) {
	           	alert(err.description + 'getAllBtsMatches()');
	        }
		
	}						
  	
  	function receiveAllbtsMatches(){
    	if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
       		try {
            	var responseResult = xmlHttp.responseText ;
            	document.getElementById("DivBtsMatch").innerHTML = responseResult
            	if(document.getElementById("DivBtsMatch").style.display == 'none'){
			     	 document.getElementById("DivBtsMatch").style.display = ''
			      }else{
			         document.getElementById("DivBtsMatch").style.display = 'none'
			      }
            } catch(err) {
	            alert(err.description + 'receiveAllbtsMatches()');
       		}
        }
      }

 	 function showWickets(matchid,bowlingteam,playerid,flag){
       	window.open("/cims/jsp/BowlWktsDetail.jsp?matchid="+matchid+"&bowlingteam="+bowlingteam+"&playerid="+playerid+"&flag="+flag,"scorecard","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=250,left=250,width="+(window.screen.availWidth-450)+",height="+(window.screen.availHeight-450));
     }

     function ShowFullScoreCard(matchid){
		window.open("../web/jsp/FullScoreCard.jsp?matchid="+matchid,"fullscorecard",'top= 10,left = 10,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=920,height=920');
	 }
  </script>
 <title><%=userName%></title> 
  </head> 
  <body > 
  	<div align="left" name="DivBtsMatch" id="DivBtsMatch" style="display:none;width:730px;height:350px;overflow:auto;">
 	</div>
	<input type="hidden" id="hdUserId" name="hdUserId" value="<%=pid%>">
	<input type="hidden" id="hdSeriesId" name="hdSeriesId" value="<%=seriesId%>">
	<input type="hidden" id="hdSeasonId" name="hdSeasonId" value="<%=seasonId%>">
	<input type="hidden" id="hdflag" name="hdflag" value="<%=flag%>">
	<input type="hidden" id="hduserName" name="hduserName" value="<%=userName%>">
  </body>
  <script>
  callMatchDetail()
  </script>
 </html> 