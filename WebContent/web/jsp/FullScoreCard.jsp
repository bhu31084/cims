<%--
  Created by IntelliJ IDEA.
  User: bhushanf
  Date: Aug 13, 2008
  Time: 12:01:56 PM
  To change this template use File | Settings | File Templates.
  modifyed Date:12-09-2008
--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,
                 in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
                 java.util.*,
                 java.lang.*"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>                 
                 
<% response.setHeader("Pragma", "private");
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "must-revalidate");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setDateHeader("Expires", 0);
%>
<%
	try{		 
		 CachedRowSet 			 crsInningId 		= null;
		 CachedRowSet			 teamNameCatachedRowSet = null;
		 CachedRowSet			 resultCrs = null;
		 
	 	 Vector					 vparam 			= new Vector();		
		 String 				 teamName			= null;
		 LogWriter log = new LogWriter();
	   	
	   	String matchid = request.getParameter("matchid")==null?"":request.getParameter("matchid");
	  	//System.out.println("matchid *** "+matchid);
	  	//String matchId = (String)session.getAttribute("match_id");
	  	//System.out.println("matchid *** "+matchId);
	  	//if(matchid == matchId){
	  	//	matchId = (String)session.getAttribute("match_id");
	  	//}else{
	  		session.setAttribute("match_id",matchid);
	  //	}	  	 	
		String matchId = (String)session.getAttribute("match_id");
		System.out.println("match_id "+matchId);
		
		GenerateStoreProcedure  lobjGenerateProc	= new GenerateStoreProcedure(matchId); 
		/*Start Logic for Calculate Number of inning */
		String inningId = request.getParameter("InningIdPre") != null ? request.getParameter("InningIdPre") : (String) session.getAttribute("inning_id");
		String[] preInningId = null;
		String inning_Id = "";
		vparam.add(matchId);
		crsInningId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getInningId",vparam,"ScoreDB");	
		int maxInning = crsInningId.size();
		vparam.removeAllElements();	
		
		if(crsInningId!=null){
		while(crsInningId.next()){
		
			inning_Id = inning_Id + crsInningId.getString("id")+ "~";
			preInningId = inning_Id.split("~");
			}
		}
		vparam.add(matchId);	
		teamNameCatachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_teamsname",vparam,"ScoreDB");					
        while(teamNameCatachedRowSet.next()){
        teamName = teamNameCatachedRowSet.getString("teamsname");
       }
       vparam.removeAllElements();
       
       vparam.add(matchId);
	   resultCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_reportresult",vparam,"ScoreDB");
	   vparam.removeAllElements();
	   String matchresult = null;
		
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<%--<meta http-equiv="refresh" content="60" />--%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>-::-<%=teamName%>-::-</title>
<link href="../css/form.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/tabber.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/tabexample.css"> 
<link href="../css/csms.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../css/styles.css">
<link href="../css/commonSpry.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css"> 
<script language="JavaScript" src="../js/popup.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>
<script>
var inningno = null;
//MakeCursorHourglass();
//showPopup('BackgroundDiv','pbar');
function GetXmlHttpObject(){
	var xmlHttp=null;
    try{
        xmlHttp=new XMLHttpRequest();
    }
    catch (e){
    	try{
           xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e){
        	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
   }
  return xmlHttp;
}
function srrate(){
var over = (document.getElementById('Batstotalover').innerHTML).split(".");
// To Split Ball And Overs, TO Store All Over From Over Field
	var totalover = over[0];
    var ball = over[1];
    var totalball = parseInt((totalover * 6)) + parseInt(ball);
    var run = parseInt(document.getElementById('battotalruns').innerHTML);
    var srRate = (run/ totalball)*6;
    document.getElementById('totlarunrate').innerHTML = srRate.toFixed(2);
    if (document.getElementById('totlarunrate').innerHTML == "Infinity" ||isNaN(document.getElementById('totlarunrate').innerHTML)) { // if Strike Rate In Infinity than we set it blank
    	document.getElementById('totlarunrate').innerHTML = "";
    }
}
function showHistory(val_tabberIndex){ //function in tabber.js file 
var maxInn = parseInt(document.getElementById('hidMaxInning').value) 
	if(val_tabberIndex == 0){
		Inning(maxInn);
	}
	else if(val_tabberIndex == 1){
				Inning((maxInn-1));
	}
	else if(val_tabberIndex == 2){
				Inning((maxInn-2));
	}
	else if(val_tabberIndex == 3){
				Inning((maxInn-3));
	}
}
function changeImageSrc(id, type){
		
		document.getElementById('pitch_report').style.display = "none";
		document.getElementById("responsepage").src = "";
		
		
		document.getElementById("WagonWheel").style.display = "none";
		document.getElementById("responseWagon").src = "";	
		
		//setTimeout("display("+id+")",500);
		
		displayPitchPad(id, type);
		displayWagon(id, type);
	}
	
	function displayWagon(id, type){
		document.getElementById("responseWagon").src = "/cims/web/jsp/ResponseWagonWheel.jsp?id="+id+"&type="+type;
		document.getElementById('WagonWheel').style.display = "";
	}
	
	function displayPitchPad(id, type){
		//alert(id + ' - ' + type)
		document.getElementById("responsepage").src = "/cims/web/jsp/ResopnseBallPitched.jsp?id="+id+"&type="+type;
		//document.getElementById("responsepage").style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src = response/ResopnseBallPitched.jsp?id=" + id + ")";
		document.getElementById('pitch_report').style.display = "";
		
	}

	function srrate(){
		var over = (document.getElementById('Batstotalover').innerHTML).split(".");
		// To Split Ball And Overs, TO Store All Over From Over Field
		var totalover = over[0];
	    var ball = over[1];
		var totalball = parseInt((totalover * 6)) + parseInt(ball);
	    var run = parseInt(document.getElementById('battotalruns').innerHTML);
		var srRate = (run/ totalball)*6;
	    document.getElementById('totlarunrate').innerHTML = srRate.toFixed(2);
		if (document.getElementById('totlarunrate').innerHTML == "Infinity" ||isNaN(document.getElementById('totlarunrate').innerHTML)) { // if Strike Rate In Infinity than we set it blank
    		document.getElementById('totlarunrate').innerHTML = "";
		}
   }

function printreport(){
	var matchId = document.getElementById('matchId').value
	var InningId = document.getElementById('inningid').value 
	winhandle = window.open("/cims/jsp/battingbowlingdetails.jsp?matchId="+matchId+"&InningId="+InningId+"&flg=1","battingreport","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-40)+",height="+(window.screen.availHeight-20));
}
function Inning(id){
	
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
       alert ("Browser does not support HTTP Request") ;
       return;
    }
    else{
      var matchId = document.getElementById('matchId').value
      var InningId ="1";
      if(id=="1"){
	    InningId = document.getElementById('str1').value;
	    inningno = "1";
	  }else if(id=="2"){
	    InningId = document.getElementById('str2').value;
	     inningno ="2";
	  }else if(id=="3"){
	    InningId = document.getElementById('str3').value;
	     inningno = "3";
	  }else if(id=="4"){
	    InningId = document.getElementById('str4').value;
	     inningno ="4";
	  }        
	  var flg = "P";        
	   var url = "/cims/web/jsp/InningScorecard.jsp?InningIdPre="+InningId+"&flg="+flg;
	   
     // var url = "battingbowling.jsp?matchId="+matchId+"&InningId="+InningId;
      //document.getElementById("Inning1").innerHTML = "";
     // xmlHttp.onreadystatechange = displayInning;
      xmlHttp.open("get",url,false);
      xmlHttp.send(null);
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
    	var responseResult = xmlHttp.responseText ;
    	var mdiv =null;
        if(inningno=="1"){
	        mdiv =  document.getElementById("Inning1");
	    }else if(inningno=="2"){
	        mdiv = document.getElementById("Inning2");
	    }else if(inningno=="3"){
	        mdiv = document.getElementById("Inning3");
	    }else if(inningno=="4"){
	        mdiv = document.getElementById("Inning4");
	    }  
	    var maxInn = parseInt(document.getElementById('hidMaxInning').value) 
 
 		while(maxInn > 0){
	 		document.getElementById("Inning"+maxInn).innerHTML=null;
	 		maxInn = parseInt(maxInn) - 1
 		}
		//document.getElementById("Inning1").innerHTML=null;
		//document.getElementById("Inning2").innerHTML=null;
		//document.getElementById("Inning3").innerHTML=null;
		//document.getElementById("Inning4").innerHTML=null;
        mdiv.innerHTML = responseResult;
        srrate();
        
    }
    }
}
/*function displayInning(){
	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
    	var responseResult = xmlHttp.responseText ;
    	var mdiv =null;
        if(inningno=="1"){
	        mdiv =  document.getElementById("Inning1");
	    }else if(inningno=="2"){
	        mdiv = document.getElementById("Inning2");
	    }else if(inningno=="3"){
	        mdiv = document.getElementById("Inning3");
	    }else if(inningno=="4"){
	        mdiv = document.getElementById("Inning4");
	    }  
	    var maxInn = parseInt(document.getElementById('hidMaxInning').value) 
 
 		while(maxInn > 0){
	 		document.getElementById("Inning"+maxInn).innerHTML=null;
	 		maxInn = parseInt(maxInn) - 1
 		}
		//document.getElementById("Inning1").innerHTML=null;
		//document.getElementById("Inning2").innerHTML=null;
		//document.getElementById("Inning3").innerHTML=null;
		//document.getElementById("Inning4").innerHTML=null;
        mdiv.innerHTML = responseResult;
        srrate();
    }
}*/

function callRefresh(matchid){
	document.main.action="/cims/web/jsp/FullScoreCard.jsp?matchid="+matchid;
	document.main.submit();
}

function MakeCursorHourglass()
{
	//alert("1")
	//document.getElementById("pbar").style.display = '';
	document.getElementById("pbar").style.display='';	
	//alert("2")
}

function MakeCursorNormal()
{
	//alert("3")
	//document.body.style.cursor = "default";
	document.getElementById("pbar").style.display = 'none';
	//alert("4")
	
}
</script>
</head>

<body style="margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-bottom: 0px;" >
<div id = "pbar" name="pbar" class="divlist" style="left: 300px;top: 250px;">
		<table>			
			<tr>
<%--				<td align="center" valign="middle">--%>
<%--				<img src="../Image/wait24trans.gif" />--%>
<%--				</td>--%>
<td align="center" valign="middle"><b><img src="../Image/wait24trans.gif" />&nbsp;<font color="red" size="3"> Loading ......</b></font></td>
			</tr>
		</table>
		</div>
		<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv" >
		</div>
		
			<script>showPopup('BackgroundDiv','pbar')</script>
		
<form name="main" id="main" method="post" action="" >		
<div style="margin-top: 1px;">
<%--	<table width="100%" border="1" >		--%>
<%--		<tr valign="top" align="left" style="width: 100%">--%>
<%--			<td>--%>
				<table align="center" class="tabber" >
					<tr align="center">
						<td valign="top">
							<input class="FlatButton" type="button" value="Refresh" onclick="callRefresh('<%=matchid%>')"/>
						</td>
					</tr>
					<tr align="left" >
						<td >
							<div class="tabber" style="float: left">
<%								if(preInningId!=null){
								//for(int i=0;i<preInningId.length;i++){	
								for(int i=(preInningId.length-1);i >= 0;i--){
%>								
								<div class="tabbertab">
					  				<h2>Inning <%=i+1%></h2>
									<div id = "Inning<%=i+1%>"></div>
						 		</div>
<%
								}// end of for
								}// end of if 	
%>		    	 								
							</div>							
						 </td>	
					</tr>
				</table>
				
<%--			</td>--%>
<%--		</tr>--%>
<%--	</table>--%>
<%		if(preInningId!=null){
		for(int k=0;k<preInningId.length;k++){
			String str1=preInningId[k];
	%>			<input type="hidden" name="str<%=k+1%>" id="str<%=k+1%>" value="<%=str1%>">
	<%		}
		}
%>		
		<input type="hidden" name="matchId" id="matchId" value="<%=matchId%>">
		<input type="hidden" name="hidMaxInning" id="hidMaxInning" value="<%=maxInning%>">
</div>
  <script>
	Inning(<%=maxInning%>);
	
  </script>
   
  
   
<%--   <jsp:include page="admin/Footer.jsp"></jsp:include>--%>
</form>
</body>
<% } catch (Exception e) {
    e.printStackTrace();
	}
%>
<script>    	
	closePopup('BackgroundDiv','pbar');	
</script>
</html>
