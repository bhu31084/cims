<!--
	Page Name 	 : PlayerCareerReport.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 13th Nov 2008
	Description  : Player Career Report 
	Company 	 : Paramatrix Tech Pvt Ltd.
	Modified by  : Vaibhavg (Added link  from TopPerformer to this page)  
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet,
            in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
            java.util.*"
%>
<%  response.setHeader("Pragma", "private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<%  CachedRowSet crsObjPlayerBattingRecord           = null;
	CachedRowSet crsObjPlayerBowlingRecord           = null;
	CachedRowSet crsObjAssociationRecord = null;
	CachedRowSet crsObjBatsmanWktTypeStaistics       = null;
	CachedRowSet crsObjBowlerWktTypeStaistics        = null;
	CachedRowSet crsObjSeason					 	 = null;
	Vector vparam                                    = new Vector();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();

	String player_name   = "";
	String userId        = "";
	String associationid = "";
	String associatioName= ""; 
	String seriesId= ""; 
	String seasonId= "";
	String season_name = "2008-2009";
	//code added by vaibhav
		userId = request.getParameter("userid")!=null?request.getParameter("userid"):"";
		associationid  = request.getParameter("associationid")!=null?request.getParameter("associationid"):"";
		player_name    = request.getParameter("playerName")!=null?request.getParameter("playerName"):""; 
		associatioName = request.getParameter("associationame")!=null?request.getParameter("associationame"):"";
		seriesId = request.getParameter("seriesId")!=null?request.getParameter("seriesId"):"0";
		seasonId = request.getParameter("seasonId")!=null?request.getParameter("seasonId"):"";
	
		try {	crsObjAssociationRecord = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_getclubs_playerlist", vparam, "ScoreDB");
		} catch (Exception e) {
			e.printStackTrace();
			out.println(e);
		}
	
	
	try {
		vparam.removeAllElements();	
		vparam.add("1");
		crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");
		vparam.removeAllElements();	
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e);
	}
	
	if(crsObjSeason!=null){
		while(crsObjSeason.next()){
			//seasonId = crsObjSeason.getString("id");
			//season_name = crsObjSeason.getString("name");
		}
	}
	 crsObjSeason.beforeFirst();
%>
<html>
<head>
    <title> Player Details </title>
    <script language="JavaScript" src="../js/tabber.js" type="text/javascript"></script>
    <script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="../css/tabexample.css"> 
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../css/form.css">
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
   
    <script language="javascript">
        var xmlHttp=null;
 	          
		function displayBtsWkts(id) { // Display the Batsman Wickets 
		  var seasonId = document.getElementById('seasonId').value;
		  var seriseId = document.getElementById('hdseriesid').value;
		  document.getElementById("wagonWeelBtsWkts").src = "/cims/jsp/playerReport/WagonWheelWicketsRes.jsp?id="+id+"&seasonId="+seasonId+"&seriseId="+seriseId+"&spName=dsp_batsman_wickets_wagon_wheel_staistics";
          document.getElementById("wagonWeelBtsWktsResponse").style.display= "";
          document.getElementById("pitchBtsWkts").src = "/cims/jsp/playerReport/BallPitchedWicketsRes.jsp?id="+id+"&seasonId="+seasonId+"&seriseId="+seriseId+"&spName=dsp_batsman_wickets_pitch_map_staistics";
       
        }
        
        function displayBtsBound(id) { // Display the Batsman Boundaries
        	var seasonId = document.getElementById('seasonId').value;
        	 var seriseId = document.getElementById('hdseriesid').value;
           document.getElementById("wagonWeelBtsBound").src = "/cims/jsp/playerReport/WagonWheelBoundariesRes.jsp?id="+id+"&seasonId="+seasonId+"&seriseId="+seriseId+"&spName=dsp_batsman_boundaries_wagon_wheel_staistics";
           document.getElementById("wagonWeelBtsBoundResponse").style.display= "";
           document.getElementById("pitchBtsBound").src = "/cims/jsp/playerReport/BallPitchedBoundariesRes.jsp?id="+id+"&seasonId="+seasonId+"&seriseId="+seriseId+"&spName=dsp_batsman_boundaries_pitch_map_staistics";
        }
        
        function displayBowlsWkts(id) { // Display the Bowlers Wickets
        	var seasonId = document.getElementById('seasonId').value; 
        	 var seriseId = document.getElementById('hdseriesid').value;
           document.getElementById("wagonWeelBowlsWkts").src = "/cims/jsp/playerReport/WagonWheelWicketsRes.jsp?id="+id+"&seasonId="+seasonId+"&seriseId="+seriseId+"&spName=dsp_bowler_wickets_wagon_wheel_staistics";
           document.getElementById("wagonWeelBowlsWktsResponse").style.display= "";
           document.getElementById("pitchBowlsWkts").src = "/cims/jsp/playerReport/BallPitchedWicketsRes.jsp?id="+id+"&seasonId="+seasonId+"&seriseId="+seriseId+"&spName=dsp_bowler_wickets_pitch_map_staistics";
        }
        
        function displayBowlsBound(id) { //Display the Bowlers Boundaries
        	var seasonId = document.getElementById('seasonId').value; 
        	 var seriseId = document.getElementById('hdseriesid').value;
           document.getElementById("wagonWeelBowlsBound").src = "/cims/jsp/playerReport/WagonWheelBoundariesRes.jsp?id="+id+"&seasonId="+seasonId+"&seriseId="+seriseId+"&spName=dsp_bowler_boundaries_wagon_wheel_staistics";
           document.getElementById("wagonWeelBowlsBoundResponse").style.display= "";
           document.getElementById("pitchBowlsBound").src = "/cims/jsp/playerReport/BallPitchedBoundariesRes.jsp?id="+id+"&seasonId="+seasonId+"&seriseId="+seriseId+"&spName=dsp_bowler_boundaries_pitch_map_staistics";
        }
              
       function displayReport(displayId) {
        	 if(displayId=="1") {
               displayBtsStatistics();
			 } else if(displayId=="2") {
				var idval = document.playerReportForm.hid.value;
		        if (idval!=null && idval!=""){
		        	displayBtsWkts(document.playerReportForm.hid.value);
		     	  }else{
			        var valId =document.getElementById('hdassociation').value;
		            displayBtsWkts(valId);
		        }  
			 } else if(displayId=="3") {
				 var idval = document.playerReportForm.hid.value;
			        if (idval!=null && idval!=""){
			        	displayBtsBound(document.playerReportForm.hid.value);
			     	  }else{
			            var valId =document.getElementById('hdassociation').value;
			            displayBtsBound(valId);
			        } 
			 } else if(displayId=="4") {
				displayBtsWktsTypeStatistics();
			 } else if(displayId=="5") {
				displayBowlStatistics();
			 } else if(displayId=="6") {
				 var idval = document.playerReportForm.hid.value;
			        if (idval!=null && idval!=""){
			        	displayBowlsWkts(document.playerReportForm.hid.value);
			     	  }else{
			            var valId =document.getElementById('hdassociation').value;
			            displayBowlsWkts(valId);
			        } 
			 } else if(displayId=="7") {
				 var idval = document.playerReportForm.hid.value;
			        if (idval!=null && idval!=""){
			        	displayBowlsBound(document.playerReportForm.hid.value);
			     	  }else{
			            var valId =document.getElementById('hdassociation').value;
			            displayBowlsBound(valId);
			        } 
			 } else if(displayId=="8") {
				displayBowlWktsTypeStatistics();
			 } 
        }
        
        function showHistory(val_tabberIndex) { //function in tabber.js file 
			if(val_tabberIndex == 0) {
				displayReport("1");
			}
			else if(val_tabberIndex == 1) {
				displayReport("2");
			}
			else if(val_tabberIndex == 2) {
				displayReport("3");
			}
			else if(val_tabberIndex == 3) {
				displayReport("4");
			}
			else if(val_tabberIndex == 4) {
				displayReport("5");
			}
			else if(val_tabberIndex == 5) {
				displayReport("6");
			}
			else if(val_tabberIndex == 6) {
				displayReport("7");
			}
			else if(val_tabberIndex == 7) {
				displayReport("8");
			}
		}
		
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
	 	
	 /************** For BatsMan Statistics List **********************************************************************/
		function displayBtsStatistics() {
			//alert('displayBtsStatistics')
	        xmlHttp = GetXmlHttpObject();
	        var idval = document.playerReportForm.hid.value;
	        var seasonId = document.getElementById('seasonId').value;
	        var seriseId = document.getElementById('hdseriesid').value;
	        if (idval!=null && idval!=""){
	        	var valId =document.playerReportForm.hid.value;
	     	  }else{
	            var valId =document.getElementById('hdassociation').value;
	        }    
	          // if(valId!=""){
	        var url = "/cims/jsp/BtsStatisticsAjaxResponse.jsp?pid="+valId+"&seasonId="+seasonId+"&seriseId="+seriseId;
		    //xmlHttp.onreadystatechange = displayBtsManStatisticsData;
		    xmlHttp.open("get",url,false);
			xmlHttp.send(null);
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				   var responseResult = xmlHttp.responseText ;
		   		      
		   		      try //Internet Explorer
					  {
						 // xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
						  //xmlDoc.async="false";
						  //xmlDoc.loadXML(responseResult);
						  var mess = responseResult;
					  	  document.getElementById('btsStatistics').innerHTML = mess;
  			  		 	  document.getElementById('btsStatistics').style.display = "";
		              } catch(e) {
					 
					  try //Firefox, Mozilla, Opera, etc.
					  {
					    //parser=new DOMParser();
					   // xmlDoc=parser.parseFromString(text,"text/xml");
					   
					    } catch(e) {
					    	alert(e.message)
					    }
					 }
				}
	     // }
      }
	 /************** For Bowler Statistics List **********************************************************************/
	 	function displayBowlStatistics() {
			//alert('displayBtsStatistics')
	        xmlHttp = GetXmlHttpObject();
	        var idval = document.playerReportForm.hid.value;
	        var seasonId = document.getElementById('seasonId').value;
	        var seriseId = document.getElementById('hdseriesid').value;
 			if (idval!=null && idval!=""){
 	        	var valId =document.playerReportForm.hid.value;
 	     	  }else{
 	            var valId =document.getElementById('hdassociation').value;
 	        }   
	        var url = "/cims/jsp/BowlStatisticsAjaxResponse.jsp?pid="+valId+"&seasonId="+seasonId+"&seriseId="+seriseId;;
		   //  xmlHttp.onreadystatechange = displayBowlStatisticsData;
			xmlHttp.open("get",url,false);
			xmlHttp.send(null);
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			  var responseResult = xmlHttp.responseText ;
		   	     try //Internet Explorer
				 {
				  var mess = responseResult;
				  document.getElementById('bowlStatistics').innerHTML = mess;
  			 	  document.getElementById('bowlStatistics').style.display = "";
		         }catch(e) {
			         alert(e.description + 'displayBowlStatistics()');
				 }
				  
		    }
			
	    
        }
      /*****************For Bowler all Matches.****************dipti*****************************/
      
        function getAllBtsMatches(pid){
      		var seriesId = document.getElementById("hdseriesid").value
	     	var seasonId = document.getElementById("hdseasonid").value
	      	try {
		           xmlHttp = this.GetXmlHttpObject();
		     	  if (xmlHttp == null) {
		               alert("Browser does not support HTTP Request");
		               return;
		          }else{
				      var url = "/cims/jsp/BtsStatisticsAllMatches.jsp?pid="+pid+"&seriesId="+seriesId+"&seasonId="+seasonId
		             // xmlHttp.onreadystatechange = receiveAllbtsMatches
		          	  xmlHttp.open("post", url, false);
				   	  xmlHttp.send(null);
				   	  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
       				  try {
		            	var responseResult = xmlHttp.responseText ;
		            	document.getElementById("DivBtsAllMatch").innerHTML = responseResult
		           	    if(document.getElementById("DivBtsAllMatch").style.display == 'none'){
			     	 	 document.getElementById("DivBtsAllMatch").style.display = ''
			      		}else{
			         	 document.getElementById("DivBtsAllMatch").style.display = 'none'
			      		}
            		  }catch(err) {
	            		alert(err.description + 'receiveAllbtsMatches()');
       				  }
                      }
		   		  }
		   	}catch(err) {
	          alert(err.description + 'getAllBtsMatches()');
	        }
        }
       
       function divHide(){
         if(document.getElementById("DivBtsAllMatch").style.display == 'none'){
     	   document.getElementById("DivBtsAllMatch").style.display = ''
         }else{
           document.getElementById("DivBtsAllMatch").style.display = 'none'
         }
      }
      
      function showWickets(matchid,bowlingteam,playerid,flag){
       	window.open("/cims/jsp/BowlWktsDetail.jsp?matchid="+matchid+"&bowlingteam="+bowlingteam+"&playerid="+playerid+"&flag="+flag,"scorecard","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=250,left=250,width="+(window.screen.availWidth-450)+",height="+(window.screen.availHeight-450));
      }
      /*****************For Bowler all Matches.****************dipti*****************************/
       function getAllBowlMatches(pid){
       	 var seriesId = document.getElementById("hdseriesid").value
	     var seasonId = document.getElementById("hdseasonid").value
	     try {
		   xmlHttp = this.GetXmlHttpObject();
		   if (xmlHttp == null) {
		      alert("Browser does not support HTTP Request");
		      return;
		   }else{
			  var url = "/cims/jsp/BowlStatisticsAllMatches.jsp?pid="+pid+"&seriesId="+seriesId+"&seasonId="+seasonId
		     // xmlHttp.onreadystatechange = receiveAllbowlMatches
		      xmlHttp.open("post", url, false);
			  xmlHttp.send(null);
			  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
       		  try {
            	var responseResult = xmlHttp.responseText ;
            	document.getElementById("DivBowlAllMatch").innerHTML = responseResult
            	if(document.getElementById("DivBowlAllMatch").style.display == 'none'){
		     	  document.getElementById("DivBowlAllMatch").style.display = ''
		        }else{
		          document.getElementById("DivBowlAllMatch").style.display = 'none'
		        }
              }catch(err){
	            alert(err.description + 'receiveAllbowlMatches()');
       		  }
              }
		   }
		}catch(err){
	        alert(err.description + 'getAllBowlMatches()');
	    }
      }
       /************** For Bowl Wkts Type Statistics **********************************************************************/
	 	function displayBowlWktsTypeStatistics() {
	        xmlHttp = GetXmlHttpObject();
	        var idval = document.playerReportForm.hid.value;
	        var seasonId = document.getElementById('seasonId').value;
	        var seriseId = document.getElementById('hdseriesid').value;
	        if (idval!=null && idval!=""){
	        	var valId =document.playerReportForm.hid.value;
	     	  }else{
	            var valId =document.getElementById('hdassociation').value;
	        }
	          // if(valId!=""){
	        var url = "/cims/jsp/BowlWktsTypeStatisticsAjaxResponse.jsp?pid="+valId+"&seasonId="+seasonId+"&seriseId="+seriseId;;
		   //  xmlHttp.onreadystatechange = displayBowlWktsTypeStatisticsData;
			xmlHttp.open("get",url,false);
			xmlHttp.send(null);
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			  var responseResult = xmlHttp.responseText ;
   		      try //Internet Explorer
			  {
				var mess = responseResult;
				document.getElementById('bowlWktsTypeStatistics').innerHTML = mess;
  			  	document.getElementById('bowlWktsTypeStatistics').style.display = "";
		      }catch(e) {
		      	alert(e)
			  }
		    }
        }
      
       /************** For Bowler Statistics List **********************************************************************/
		function displayBtsWktsTypeStatistics() {
			//alert('displayBtsStatistics')
	        xmlHttp = GetXmlHttpObject();
	        var idval = document.playerReportForm.hid.value;
	        var seasonId = document.getElementById('seasonId').value;
	        var seriseId = document.getElementById('hdseriesid').value;
	        if (idval!=null && idval!=""){
	        	var valId =document.playerReportForm.hid.value;
	     	  }else{
	            var valId =document.getElementById('hdassociation').value;
	        }
	          // if(valId!=""){
	        var url = "/cims/jsp/BtsWktsTypeStatisticsAjaxResponse.jsp?pid="+valId+"&seasonId="+seasonId+"&seriseId="+seriseId;;
		   // xmlHttp.onreadystatechange = displayBtsWktsTypeStatisticsData;
			xmlHttp.open("get",url,false);
			xmlHttp.send(null);
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			   var responseResult = xmlHttp.responseText ;
		   	   try //Internet Explorer
			   {
				  var mess = responseResult;
				  document.getElementById('btsWktsTypeStatistics').innerHTML = mess;
  			 	  document.getElementById('btsWktsTypeStatistics').style.display = "";
		       }catch(e) {
			   }
			}
        }
      
      	
		 function onLoad() {
	        obj1 = new SelObj('playerReportForm','clubList','clubName');
	        obj1.bldInitial(); 
		 }
  	      
		function selected(obj){
      	 var eleObjArr1=document.getElementById(obj).options;
		 if (eleObjArr1.length >= 1){
		 eleObjArr1[0].selected = true;
		 }
		} 
	

   function SelObj(formname,selname,textname,str) {
        this.formname = formname;
        this.selname = selname;
        this.textname = textname;
        this.select_str = str || '';
        this.selectArr = new Array();
        this.initialize = initialize;
        this.bldInitial = bldInitial;
        this.bldUpdate = bldUpdate;
      }
      function initialize() {
        if (this.select_str =='') {
          for(var i=0;i<document.forms[this.formname][this.selname].options.length;i++) {
            this.selectArr[i] = document.forms[this.formname][this.selname].options[i];
            this.select_str += document.forms[this.formname][this.selname].options[i].value+":"+
            document.forms[this.formname][this.selname].options[i].text+",";
          }
        } else {
          var tempArr = this.select_str.split(',');
          for(var i=0;i<tempArr.length;i++) {
            var prop = tempArr[i].split(':');
            this.selectArr[i] = new Option(prop[1],prop[0]);
          }
        }
        return;
      }
      function bldInitial() {
        this.initialize();
        for(var i=0;i<this.selectArr.length;i++)
          document.forms[this.formname][this.selname].options[i] = this.selectArr[i];
        document.forms[this.formname][this.selname].options.length = this.selectArr.length;
        return;
      }
      
      function bldUpdate(e) {
       evt = e || window.event;
	   var keyPressed = evt.which || evt.keyCode;
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList(e);
        var j = 0;
         str=str.replace("(","");
        str=str.replace(")","");
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
	        document.forms[this.formname][this.selname].options.length = j;   
      
       
        if (j==0) {
          hideList();
        }
    
     if(keyPressed == 40)
       {
       	selected("clubList");
       }   
      }
      
     <!-- Functions Below Added by Steven Luke -->
      function update(e) {
        evt = e || window.event;
		var keyPressed = evt.which || evt.keyCode;
      	if(keyPressed == 13 || keyPressed ==0 || keyPressed ==1){
	        document.playerReportForm.clubName.value = document.playerReportForm.clubList.options[document.playerReportForm.clubList.selectedIndex].text;
    	    document.getElementById("clubName").focus();
    	    hideList();
    	    document.getElementById("lister").style.display="none";
    	    document.playerReportForm.hdclubList.value=document.playerReportForm.clubList.value;
    	  }
    	  if(keyPressed == 27){
	         document.getElementById("lister").style.display="none";
          }
        
      }
      
      
      function showList(e) {
        evt = e || window.event;
		var keyPressed = evt.which || evt.keyCode;	
	    if(keyPressed == 40)
        {
         document.getElementById("lister").style.display='';
         document.getElementById("clubList").focus();
        }        
        if(document.getElementById("clubList").value=="0" ||document.getElementById("clubList").value==""||keyPressed == 0)
        {
         document.getElementById("lister").style.display='';
        }
        if(keyPressed == 27){
         document.getElementById("lister").style.display="none";
        }
      }
      
      function hideList() {
        document.getElementById("lister").style.display="none";	
        document.getElementById('playerList').innerHTML = "<font color='RED'>Please Search Player Name </font>";
   		document.getElementById("playerList").style.display = '';
      }
      
       function changeList(event) {
        if (document.getElementById("lister").style.display=="none")
          showList(event);
        else
          hideList();
      }	
      
/*******************************************************************************************/
	
	function getPlayerListWindow() {
		 var clubId = document.playerReportForm.clubList.value;   
	        if(clubId == "") {
				document.getElementById('playerList').innerHTML = "<font color='RED'>Please Enter Association Name First</font>";
   		 	    document.getElementById("playerList").style.display = "";
   		 	    
   	        } else {
	            document.getElementById("playerList").style.display="none";
				var obj = window.showModalDialog('/cims/jsp/PlayerListWindow.jsp?clubId='+clubId, '1000', '5000');				
				if(obj != null) {
					var playerData = obj.split('|');
				    document.playerReportForm.player_name.disabled=false;
					document.playerReportForm.hid.value = playerData[0];
					document.playerReportForm.player_name.value = playerData[1];
					displayBtsStatistics();
				}
			}
	}
	
	 function disabledPlayerNameBox() {
	  	//document.playerReportForm.player_name.disabled=true;
	  	document.getElementById("clubName").focus();
     }
     
     
     
     /************** For Player List **********************************************************************/
 		 
	 	function displayData() {
			
		}
		
		function getPlayerList() {
	        xmlHttp = GetXmlHttpObject();
	 		var clubId = document.playerReportForm.clubList.value;
            var playerName = document.playerReportForm.player_name.value;
   	        	if(playerName.length > 1) {
   		 	    	document.getElementById("playerList").style.display = "";
   		 	     	var url = "/cims/jsp/PlayerListAssoAjaxResponse.jsp?clubId="+clubId+"&pname="+playerName;
			     	//xmlHttp.onreadystatechange = displayData;
				 	xmlHttp.open("get",url,false);
				 	xmlHttp.send(null);
				 	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				  	 var responseResult = xmlHttp.responseText ;
		   		      try //Internet Explorer
					  {
<%--						  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");--%>
<%--						  xmlDoc.async="false";--%>
<%--						  xmlDoc.loadXML(responseResult);--%>
						  var mess = responseResult;
      			          document.getElementById("playerList").style.display="";
						  document.getElementById('playerList').innerHTML = mess;
					  
		              } catch(e) {
						  try //Firefox, Mozilla, Opera, etc.
					  	  {
					      }catch(e) {
					    	alert(e.message)
					      }
					 }
				   }
				}
      }
 			        
        function updatePlayer(e) {
          evt = e || window.event;
		  var keyPressed = evt.which || evt.keyCode;
          if(keyPressed == 13 || keyPressed ==0 || keyPressed==1) {
			if(document.playerReportForm.player_name.value != "" ) {
			   if(document.playerReportForm.player_id.selectedIndex != -1) {
				 document.playerReportForm.player_name.value = "";
				 var strMessage = document.playerReportForm.player_id.options[document.playerReportForm.player_id.selectedIndex].value.split("|");;
				 document.playerReportForm.hid.value = strMessage[0];
				 document.playerReportForm.player_name.value = strMessage[1];
				 document.getElementById("playerList").style.display="none";
	    		 document.getElementById("player_name").focus();
			   } else {
		   	     alert('Please Select Player Name');
				 document.getElementById("player_id").focus();
		   	     return false;
		   	    }
		   	 }else {
		   	 	 alert('Please Enter Player Name');
				 document.getElementById("player_name").focus();
		   	     return false;
		   	  }
		   } 
		    	
		    	if(keyPressed == 40) {
		    		//if(document.playerReportForm.clubName.value != "") {
			        		document.getElementById("player_id").focus();
			        //}
		    	}
		    	
		    	if(keyPressed == 27) {
		         	document.getElementById("playerList").style.display="none";
		        }
      }
      
      /**********************************************************************************************/
		
	function runWicketDetails(row,matchid,userid,flag){
	
		try {	
			  xmlHttp = this.GetXmlHttpObject();
	     	  if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	          }else{
	          	if(flag == "1"){
			       var url = "/cims/jsp/TopPlayerRunDetail.jsp?matchId="+matchid+"&userId="+userid+"&flag="+flag
			    }else if(flag == "2"){
			       var url = "/cims/jsp/TopPlayerRunDetail.jsp?matchId="+matchid+"&userId="+userid+"&flag="+flag
			    } 
			     
			    xmlHttp.open("post", url, false);
			   	xmlHttp.send(null);
	            if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	       		   	var responseResult = xmlHttp.responseText ;
	            	document.getElementById("runwicket_"+row).innerHTML  = responseResult
	            	document.getElementById("runwicket_"+row).style.display = ''
	           	 }
	          	  
	   		  }
	   
        } catch(err) {
           	alert(err.description + 'runWicketDetails()');
        }
	}
	
	/**********************************************************************************************************/
	//Added by archana to link match full scorecard. 
	function ShowFullScoreCard(matchid){
		//alert("Match ID is*** "+matchid)		
		window.open("/cims/web/jsp/FullScoreCard.jsp?matchid="+matchid,"fullscorecard",'top= 10,left = 10,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=920,height=920');
	}	
     
	
  </script>
	
</head>
<body>
<table align="center">
    <tr>
    	<td align="center">
<div style="width:84.5em">
<jsp:include page="Menu.jsp"></jsp:include>
<br><br>
<FORM name="playerReportForm" id="playerReportForm" action="PlayerCareerReport.jsp" method="POST">
<INPUT type="hidden" name="hid" id="hid" value="">
<input   type="hidden" id="clubId" name="clubId" value=""/>
<input   type="hidden" id="hdclubList" name="hdclubList" value=""/>
<input   type="hidden" id="hdseriesid" name="hdseriesid" value="<%=seriesId%>"/>
<input   type="hidden" id="hdseasonid" name="hdseasonid" value="<%=seasonId%>"/>
<input   type="hidden" id="hdassociation" name="hdassociation" value="<%=userId%>"/>
	  <table width="100%"  border="0" align="center" cellpadding="2"	cellspacing="1" class="table">
<tr>
   <td align="left" class="legend">Player Career Averages</td>
 </tr>	
 </table>
 <table border="0" align="center" cellpadding="2"	cellspacing="1" class="table">
 <tr>
  	 <td>&nbsp;</td>
 <td width="4%">
	<DIV align="left" style="width:250px">
		<font color="gray">Enter association name to search</font>
	</DIV> 
 </td>
 <td>&nbsp;</td>
 <td>&nbsp;</td>
 <td>&nbsp;</td>
 <td width="4%"> 
	<DIV align="left" style="width:250px">
		<font color="gray">Enter player name to search</font>
	</DIV>
 </td>
  </tr>
  <tr>
     <TD nowrap="nowrap">Association :</TD>
  <TD nowrap="nowrap">
	<input class="inputsearch" type="text" name="clubName" id="clubName" value="<%=associatioName%>" size="35" onKeyUp="javascript:obj1.bldUpdate(event);" <%=seriesId.equalsIgnoreCase("0")?"":"disabled"%>> 
	<input class="btn btn-small"	id="show" type="button" value="V" onClick="changeList(event);" <%=seriesId.equalsIgnoreCase("0")?"":"disabled"%>>
	<DIV align="left" style="width:250px">
		<DIV id="lister" name="lister" style="display:none;position:absolute;z-index:+10;">
			<select   class="inputsearch"	  style="width:5.5cm" id="clubList" name="clubList" size="5"  onclick="update(event)" 	onkeypress="update(event)" >
<%						while (crsObjAssociationRecord.next()) {
%>							<option value="<%=crsObjAssociationRecord.getString("id")%>" ><%=crsObjAssociationRecord.getString("name")%></option>
<%   					}
%>
			</select>																					
		</DIV>
	</DIV>
  </TD>
  <TD>Season :</TD>
  <TD>
  <select  name="seasonId" id="seasonId"  <%=seriesId.equalsIgnoreCase("0")?"":"disabled" %>>
		<option >Select </option>
<%				if(crsObjSeason != null){
		while(crsObjSeason.next()){
		System.out.println("-------------------------------------------------");	
		System.out.println(seasonId);
		System.out.println(crsObjSeason.getString("id"));
		
			if(crsObjSeason.getString("id").equalsIgnoreCase(seasonId)){%>
		<option value="<%=crsObjSeason.getString("id")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>
<%						} else{
%>					<option value="<%=crsObjSeason.getString("id")%>" ><%=crsObjSeason.getString("name")%></option>
<%						}
		}
 }
%>	
</select>
  </TD>
  <TD nowrap="nowrap">Player :</TD>
  <TD nowrap="nowrap">
  	<INPUT type="text" id="player_name" name="player_name" size="35" onkeyup="updatePlayer(event);" 
  		onkeyPress="getPlayerList(); javascript: return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz');"
		 value='<%=player_name%>' onfocus="displayBtsStatistics();" 
		<%=seriesId.equalsIgnoreCase("0")?"":"disabled" %>>
  </TD>
 <TD>
 	<%if(seriesId.equalsIgnoreCase("0")){ %>
	OR <a href="javascript:getPlayerListWindow();" class="btn btn-warning btn-small" style="">Search</a>
	<%} %>
	 </TD>
  </TR>
  <tr>
	 <td>&nbsp;</td>
	 <td width="5%">&nbsp;</td>
	 <td>&nbsp;</td>
	 <td>&nbsp;</td>
	 <td>&nbsp;</td>
	 <td width="5%"> 
		<DIV id="playerList" name="playerList" style="display:none;position:absolute;z-index:+5;">
		</DIV>
	 </td>
	 <td>&nbsp;</td>
  </tr>
</table>		  
  <table width="100%" align="center" border="0">
	<tr>
		<td width="90%">
			<div class="tabber" align="left" id="btsWktReport" name="btsWktReport">
				<DIV class="tabbertab">
					<h2>Bats Statistics</h2>
						<DIV id="btsStatistics" align="left" style="display: none;">
						</DIV>
				</DIV>
				<DIV class="tabbertab">
					<h2>Bats Wickets</h2>
						<DIV id="wagonWeelBtsWktsResponse" align="right" style="display: none;">
							<table align="center" border="0" width="50%">
								<tr>
									<td class="headinguser"><b>Wagon Wheel Report</b>
									<br>
									<br>
										<IMG alt="" id="wagonWeelBtsWkts" name="wagonWeelBtsWkts"/>
									</td>
									<td class="headinguser"><b>Pitch Report</b>
									<br>
										<IMG alt="" id="pitchBtsWkts" name="pitchBtsWkts" />
									</td>
								</tr>
							</table>
						</DIV>
				</DIV>
				<DIV class="tabbertab">
					<h2>Bats Boundaries</h2>
						<DIV id="wagonWeelBtsBoundResponse" align="right" style="display: none;">
							<table align="center" border="0" width="50%">
								<tr>
									<td class="headinguser"><b>Wagon Wheel Report</b>
									<br>
									<br>
										<IMG alt="" id="wagonWeelBtsBound" name="wagonWeelBtsBound"/>
									</td>
									<td class="headinguser"><b>Pitch Report</b>
									<br>
										<IMG alt="" id="pitchBtsBound" name="pitchBtsBound" />
									</td>
								</tr>
							</table>
						</DIV>
				</DIV>
				<DIV class="tabbertab">
					<h2>Bats Wkts Statistics</h2>
						<DIV id="btsWktsTypeStatistics" align="left" style="display: none;">
						</DIV>
				</DIV>
				<DIV class="tabbertab">
					<h2>Bowl Statistics</h2>
						<DIV id="bowlStatistics" align="left" style="display: none;">
							
						</DIV>
				</DIV>
				<DIV class="tabbertab">
					<h2>Bowl Wickets</h2>
						<DIV id="wagonWeelBowlsWktsResponse" align="right" style="display: none;">
							<table align="center" border="0" width="50%">
								<tr>
									<td class="headinguser"><b>Wagon Wheel Report</b>
									<br>
									<br>
										<IMG alt="" id="wagonWeelBowlsWkts" name="wagonWeelBowlsWkts"/>
									</td>
									<td class="headinguser"><b>Pitch Report</b>
									<br>
											<IMG alt="" id="pitchBowlsWkts" name="pitchBowlsWkts" />
									</td>
								</tr>
							</table>
						</DIV>
				</DIV>
				<DIV class="tabbertab">
					<h2>Bowl Boundaries</h2>
						<DIV id="wagonWeelBowlsBoundResponse" align="right" style="display: none;">
							<table align="center" border="0" width="50%">
								<tr>
									<td class="headinguser"><b>Wagon Wheel Report</b>
									<br>
									<br>
										<IMG alt="" id="wagonWeelBowlsBound" name="wagonWeelBowlsBound"/>
									</td>
									<td class="headinguser"><b>Pitch Report</b>
									<br>
										<IMG alt="" id="pitchBowlsBound" name="pitchBowlsBound" />
									</td>
								</tr>
							</table>
						</DIV>
				</DIV>
				<DIV class="tabbertab">
					<h2>Bowl Wkts Statistics</h2>
						<DIV id="bowlWktsTypeStatistics" align="left" style="display: none;">
						</DIV>
				</DIV>
			</DIV>
		</td>
	</tr>
</table>
<script>
	onLoad();
	//disabledPlayerNameBox();
</script>
<script>
	displayBtsStatistics();
</script>
</FORM>
</div>
</td>
</tr>
</table>
</body>

<br><br><br><br><br><br><br><br><br>
<jsp:include page="admin/Footer.jsp"></jsp:include>
</html>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     