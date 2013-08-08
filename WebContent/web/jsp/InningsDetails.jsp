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
	 	 Vector					 vparam 			= new Vector();
		 String					 matchId 			= null;	
		 String 				 teamName			= null;
		 LogWriter log = new LogWriter();
	   	 if(session.getAttribute("matchId1") == null)
				{
					matchId = 	session.getAttribute("matchid").toString();
					System.out.println("matchId		"+matchId);
					session.setAttribute("matchId1",matchId);
				
				}
				else 
				{
					matchId = 	session.getAttribute("matchId1").toString();
					//session.setAttribute("matchid",matchId);
                }
		
		/*Start Logic for Calculate Number of inning */
		 GenerateStoreProcedure  lobjGenerateProc	= new GenerateStoreProcedure(matchId); 
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
		
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="refresh" content="120" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>-::-<%=teamName%>-::-</title>
<link href="../css/csms.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">    
<link rel="stylesheet" type="text/css" href="../css/styles.css">
<link rel="stylesheet" type="text/css" href="../css/tabexample.css"> 
<link href="../css/form.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/tabber.js" type="text/javascript"></script>
<script>
var inningno = null;
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
function printreport(){
	var matchId = document.getElementById('matchId').value
	var InningId = document.getElementById('inningid').value 
	winhandle = window.open("/cims/jsp/battingbowlingdetails.jsp?matchId="+matchId+"&InningId="+InningId+"&printFlg=1","battingreport","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-40)+",height="+(window.screen.availHeight-20));
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
	          
      var url = "/cims/jsp/battingbowling.jsp?matchId="+matchId+"&InningId="+InningId;
      document.getElementById("Inning1").innerHTML = "";
      xmlHttp.onreadystatechange = displayInning;
      xmlHttp.open("get",url,false);
      xmlHttp.send(null);
    }
}
function displayInning(){
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
        mdiv.innerHTML = responseResult;
        srrate();
    }
}

function callRefresh(){
	document.main.action="/cims/web/jsp/InningsDetails.jsp"
	document.main.submit();
}
</script>

</head>

<body bottomMargin="0"  leftMargin="0" topMargin="0"  rightMargin="0" >
<jsp:include page="Menu.jsp"></jsp:include>
<br>
<form name="main" id="main" method="post" action="" >
<div>
	<table width="100%" border="0"  cellpadding="2" cellspacing="1">		
		<tr valign="top" align="left" style="width: 100%">
			<td>
				<table border="0">
					<tr style="width: 100%" align="center">
						<td>
							<input class="button1" type="button" value="Refresh" onclick="callRefresh()"/>
							 <input class="button1" type="button" name="btnprint" id="btnprint" value="Print" onclick="printreport()">
						</td>
					</tr>
					<tr>
						<td>
							<div class="tabber">
<%					 		 	if(preInningId!=null){
								//for(int i=0;i<preInningId.length;i++){	
								for(int i=(preInningId.length-1);i >= 0;i--){
%>								<div class="tabbertab">
					  				<h2>Inning <%=i+1%></h2>
									<div id = "Inning<%=i+1%>"></div> 
						 		</div>
<%
								}// end of for
								}// end of if 	//window.print();
%>		    	 			
							</div>
						 </td>	
						 
					  </tr>
				 </table>
			</td>
		</tr>
	</table>
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
  <jsp:include page="admin/Footer.jsp"></jsp:include>
</form>
</body>
<% } catch (Exception e) {
    e.printStackTrace();
	}

%>
</html>
