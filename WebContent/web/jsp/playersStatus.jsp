<!--
Page Name 	 : /NewWeb/jsp/Login.jsp
Created By 	 : Archana Dongre.
Created Date : 10 feb 2009
Description  : New Web Login Page.
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ include file="loginvalidate.jsp" %>
<%@ page import="in.co.paramatrix.common.ChangeInitial"%>
<%		
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");			
	Common common = new Common();
	String pageNo = "1";
	String res = "";	
	//String message = "";	
	ChangeInitial chgInitial = new ChangeInitial();	
	Vector vParam =  new Vector();
	//Vector vparam = new Vector();
	//GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();		
	CachedRowSet crsObjTopBtsPerformer           = null;
	CachedRowSet crsObjTopBowlPerformer          = null;
	CachedRowSet crsObjSeriesTypeRecord 		 = null;
	CachedRowSet crsRoles						 = null;		
	String series_name = "";
	String season_name = "2008-2009";
	String seriesId = "";
	String seasonId = session.getAttribute("season").toString();
	String clubId	= "";
	String chkSeries= "";
	String chkedAllSeries= "";
	String bowlerUserId = null;
	String bowlername = null;
	String batsmanUserId = null;
	String serverMessageForBts = null;
	String serverMessageForBowl = null;
	try {
		crsObjSeriesTypeRecord = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getseriestypes", vparam, "ScoreDB");		
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e);
	}
		
	if (request.getMethod().equalsIgnoreCase("POST")) {//chkSeries
		
		/*if(request.getParameter("hdrdseries").equals("1")){
			chkedAllSeries = "all";
		}*/
		if(request.getParameter("seasonId") != null && !request.getParameter("seasonId").equals("")) {
				chkSeries    = request.getParameter("hdseries");
				seasonId    = request.getParameter("seasonId");
				season_name = request.getParameter("seasonName");
				seriesId    = request.getParameter("seriesTypeList");
				if(seriesId==null || seriesId==""){
					seriesId = request.getParameter("hidSeriesType");
				}
				series_name = request.getParameter("seriesName");
				clubId     = request.getParameter("selClub");
				vparam.add(seriesId);
				vparam.add(seasonId);
				vparam.add("");
				vparam.add("");
				vparam.add("3");
				crsObjTopBtsPerformer = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getseries_wise_top_batsman_list", vparam, "ScoreDB");			
				vparam.removeAllElements();
				vparam.add(seriesId);
				vparam.add(seasonId);
				vparam.add("");
				vparam.add("");
				vparam.add("3");
				crsObjTopBowlPerformer = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");	
				vparam.removeAllElements();
				if(crsObjTopBowlPerformer.size() == 0) {
					serverMessageForBowl = "No Records Found For Top Bowler.";
				} 
				if(crsObjTopBtsPerformer.size() == 0) {
					serverMessageForBts  = "No Records Found For Top Batsman.";
				}
			}	
			
			
		}		
					
		%>			

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CIMS 2009</title>
<link href="../css/Main.css" rel="stylesheet" type="text/css" />
<link href="../css/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
<link href="../css/commonSpry.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/otherFeedback.js"></script>
<script language="JavaScript" src="../js/tabber.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/sortable.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>

<script language="JavaScript" src="../js/popup.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>

<script language="javascript">
	var xmlHttp=null;	
	var flag = 0;
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
	
	function getMonthData(month){				
		var currentYear = document.getElementById("txtyear").value;
		var monthFlag = "1";
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{			
				var url;
		    	url="/cims/web/jsp/getMonthWiseResponse.jsp?month="+month+"&currentYear="+currentYear+"&monthFlag="+monthFlag;
		    	document.getElementById("monthdiv").style.display='';
		    	document.getElementById("pageLoadDiv").style.display='none';		    			    
		    	//xmlHttp.onreadystatechange=stChgMonthDataPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;						
					document.getElementById("monthdiv").innerHTML = responseResult;
				}
		}		
	}
				
		function validate() {
			if(document.getElementById('chkSeries').checked){
				document.getElementById('hdseries').value="1";						
			}
			if(document.frmplayerStatus.seriesName.value == "" ){
				alert('Tournament Name Can Not Be Blank!');
		        document.getElementById("seriesName").focus();
				return false;
			} else if(document.frmplayerStatus.seasonName.value == "" ) {
				alert('Season Can Not Be Blank!');
		        document.getElementById("seasonName").focus();
				return false;
			} else {
				document.frmplayerStatus.action = "/cims/web/jsp/playersStatus.jsp";
				document.frmplayerStatus.submit();			
			}
		}
		
		function displayTopBowlPerformer() {
			document.getElementById("topBowlPerformer").style.display= "";       
		}
		
		function displayTopBtsPerformer() {
			document.getElementById("topBtsPerformer").style.display= "";   
	        document.getElementById("seriesName").focus();			    
		}
	
		 function displayReport(displayId) {
        	 if(displayId=="1") {
 	 		   displayTopBtsPerformer();
			 } else if(displayId=="2") {
			 	displayTopBowlPerformer();
			 } 
        }
        
        function showHistory(val_tabberIndex) { //function in tabber.js file 
			if(val_tabberIndex == 0) {
				displayReport("1");
			}
			else if(val_tabberIndex == 1) {
				displayReport("2");
			}
		}
		
		function callSubmit(){					
			try{
				document.getElementById('hdSubmit').value = "submit"
			
				if(document.getElementById('txtUserName').value == ""){
					alert(" User Name can not be left Blank !");
					frmplayerStatus.txtUserName.focus();
				}else if(document.getElementById('password').value == ""){
					alert(" Password can not be left Blank !");
					frmplayerStatus.password.focus();
				}else{
					document.frmplayerStatus.submit();			
				}	
		}catch(err){
				alert("callSubmit"+err.description); 
		}
	}
		
		
	 /************** For Tournament Type List **********************************************************************/
	 function displaySeriesTypeData() {
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				   var responseResult = xmlHttp.responseText ;
		   		      
		   		      try //Internet Explorer
					  {
						  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
						  xmlDoc.async="false";
						  xmlDoc.loadXML(responseResult);
						  var mess = responseResult;
						  document.getElementById('seriesList').innerHTML = mess;
  			  		 	  document.getElementById("seriesList").style.display = "";
  			  		 	  
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
		}
		
		function getSeriesTypeList() {
	        xmlHttp = GetXmlHttpObject();
	        var valName = document.topPerformerReportForm.seriesName.value;
           if(valName!="" && valName.length >= 2) {
		        var url = "/cims/jsp/SeriesTypeListAjaxResponse.jsp?seriesName="+valName;
			     xmlHttp.onreadystatechange = displaySeriesTypeData;
				xmlHttp.open("get",url,false);
				xmlHttp.send(null);

      		}
      }
      
       function updateSeriesType(event) {
		      	if(window.event.keyCode == 13 || window.event.keyCode == 0 ) {
		      		if(document.topPerformerReportForm.seriesName.value != "" ) {
			      		if(document.topPerformerReportForm.series_id.selectedIndex != -1) {
							 	var strMessage = document.topPerformerReportForm.series_id.options[document.topPerformerReportForm.series_id.selectedIndex].value.split("|");;
							    document.topPerformerReportForm.seriesId.value = strMessage[0];
					    		document.topPerformerReportForm.seriesName.value = strMessage[1];
					    	    document.getElementById("seriesList").style.display="none";
		   	    		        document.getElementById("seasonName").focus();
		   	    		} else {
		   	    			alert('Please Select Tournament Name');
					        document.getElementById("series_id").focus();
		   	    			return false;
		   	    		}
		   	    	} else {
		   	    		alert('Please Enter Tournament Name');
				        document.getElementById("seriesName").focus();
	   	    			return false;
		   	    	}
				}
				
		    	if(window.event.keyCode == 40) {
			        document.getElementById("series_id").focus();
		    	}
		    	
		    	if(window.event.keyCode == 27) {
		         	document.getElementById("seriesList").style.display="none";
		        }
        }	 
	 	
	 	function displaySeasonData() {
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				   var responseResult = xmlHttp.responseText ;
		   		      
		   		      try //Internet Explorer
					  {
						  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
						  xmlDoc.async="false";
						  xmlDoc.loadXML(responseResult);
						  var mess = responseResult;
						  document.getElementById('seasonList').innerHTML = mess;
  			  		 	  document.getElementById("seasonList").style.display = "";
  			  		 	  
  			  		 	  var seasonLength =  document.frmplayerStatus.season_id.options.length;
  			  		 	  
  			  		 	  if(seasonLength == 1) {
				    		document.frmplayerStatus.seasonName.value = "";
			  		 	    var strMessage = document.frmplayerStatus.season_id.options[0].value.split("|");;
						    document.frmplayerStatus.seasonId.value = strMessage[0];
				    		document.frmplayerStatus.seasonName.value = strMessage[1];
				    		document.getElementById("seasonList").style.display="none";
	    			        document.getElementById("seasonName").focus();
  			  		 	  }
  			  		 	  
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
		}		
      
       function getSeasonList() {
	        xmlHttp = GetXmlHttpObject();
	        var valName = document.topPerformerReportForm.seasonName.value;
	        var seriesName = document.topPerformerReportForm.seriesName.value;
   	       
   	        if(seriesName == "") {
				document.getElementById('seasonList').innerHTML = "<font color='RED'>Please Enter Tournament Name First</font>";
   		 	    document.getElementById("seasonList").style.display = "";
   	        } else {	        
		           if(valName!="" && valName.length >= 1) {
				        var url = "/cims/web/jsp/SeasonListAjaxResponse.jsp?seasonName="+valName;
					     xmlHttp.onreadystatechange = displaySeasonData;
						xmlHttp.open("get",url,false);
						xmlHttp.send(null);
		      		}
		      
		    }
      }
 			        
        function updateSeason(e) {
		        evt = e || window.event;
				var keyPressed = evt.which || evt.keyCode;
		        if(keyPressed == 13 || keyPressed ==0 ||keyPressed ==1 ) {
		      		if(document.frmplayerStatus.seasonName.value != "" ) {
			      		if(document.frmplayerStatus.season_id.selectedIndex != -1) {
				    		document.frmplayerStatus.seasonName.value = "";
					        var strMessage = document.frmplayerStatus.season_id.options[document.frmplayerStatus.season_id.selectedIndex].value.split("|");
						    document.frmplayerStatus.seasonId.value = strMessage[0];
				    		document.frmplayerStatus.seasonName.value = strMessage[1];
				    	    document.getElementById("seasonList").style.display="none";
	    			        document.getElementById("seasonName").focus();
			    		} else {
		   	    			alert('Please Select Season Name');
					        document.getElementById("season_id").focus();
		   	    			return false;
		   	    		}
		   	    	} else {
		   	    		alert('Please Enter Season Name');
					    document.getElementById("seasonName").focus();
		   	    		return false;
		   	    	}
		    	} 
		    	
		    	if(keyPressed == 40) {
		    		if(document.frmplayerStatus.seriesName.value != "") {
			        		document.getElementById("season_id").focus();
			        }
		    	}
		    	
		    	if(keyPressed == 27) {
		         	document.getElementById("seasonList").style.display="none";
		        }
      }
      
      /**********************************************************************************************/
		
		 function onLoad() {
	        obj1 = new SelObj('frmplayerStatus','seriesTypeList','seriesName');
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
       	selected("seriesTypeList");
       }   
      }
      
     <!-- Functions Below Added by Steven Luke -->
      function update(e) {
      	evt = e || window.event;
        var keyPressed = evt.which || evt.keyCode;
      	if(keyPressed == 13 || keyPressed ==0 || keyPressed ==1){
	        document.frmplayerStatus.seriesName.value = document.frmplayerStatus.seriesTypeList.options[document.frmplayerStatus.seriesTypeList.selectedIndex].text;
    	    document.getElementById("seriesName").focus();
    	    hideList();
    	    document.frmplayerStatus.hdseriesTypeList.value=document.frmplayerStatus.seriesTypeList.value;
    	     }
    	  if(keyPressed == 27){
         document.getElementById("lister").style.display="none";
        }
        
      }
      
      
      function showList(e) {   
      evt = e || window.event;
	   var keyPressed = evt.which || evt.keyCode;
      if(keyPressed== 40)
      {
        document.getElementById("lister").style.display="";
        document.getElementById("seriesTypeList").focus();
        }        
        if(document.getElementById("seriesTypeList").value=="0" ||document.getElementById("seriesTypeList").value==""||window.event.keyCode == 0)
        {
         document.getElementById("lister").style.display="";
        }
        if(keyPressed == 27){
         document.getElementById("lister").style.display="none";
        }
      }
      
      function hideList() {
        document.getElementById("lister").style.display="none";	
      }
      
       function changeList() {
        if (document.getElementById("lister").style.display=="none")
          showList();
        else
         hideList();
      }	
      
      function ShowBatsmanList(){
      	document.getElementById("topBowlPerformer").style.display = 'none';
      	document.getElementById("topBtsPerformer").style.display = '';
      }
      
      function ShowBowlerList(){
      	document.getElementById("topBowlPerformer").style.display = '';
      	document.getElementById("topBtsPerformer").style.display = 'none';
      	
      }
      
      /* Ajax functions */
      var bowler = null;//
      var batsman =null;
            
      function callBowlerDetails(bowlerId,bowlerName){      	
       	var series_id = document.getElementById("hidSeriesType").value 
      	var seasonId = document.getElementById("seasonId").value
      	if(document.getElementById("chkhdseries").value == 1){
      		var flag = "bs";
      	}else{
      		var flag = "ba";
      	}
      	
      	 //Flag for all Tournament details for bowlers
      	xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowBowlerDetailsDiv"+bowlerId).style.display==''){
				document.getElementById("plusImage"+bowlerId).src = "../Image/horizontal_arw.gif"; 
				document.getElementById("ShowBowlerDetailsDiv"+bowlerId).style.display='none';
				document.getElementById("ShowBowlerSeriesDiv"+bowlerId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/web/jsp/BowlerStatusResponse.jsp?bowlerId="+bowlerId+"&seasonId="+seasonId+"&bowlerName="+bowlerName+"&series_id="+series_id+"&flag="+flag;;		    	
		    	document.getElementById("plusImage"+bowlerId).src = "../Image/vertical_arw.gif"; 
		    	bowler = bowlerId;							
				//xmlHttp.onreadystatechange=stChgBowlerResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);	
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("ShowBowlerDetailsDiv"+bowler).style.display='';
					document.getElementById("ShowBowlerSeriesDiv"+bowlerId).style.display='none';
					document.getElementById("ShowBowlerDetailsDiv"+bowler).innerHTML = responseResult;
					bowler = null;		
				}		   
		   	}
		}	
      }	
      
      function callEachMatchWickets(bowlerId,bowlerName){      	
      //alert(batsmanId)
		//alert(batsmanId)
      	var series_id = document.getElementById("hidSeriesType").value 
      	var seasonId = document.getElementById("seasonId").value
      	var flag = "bs"; //Flag for selected Tournament details for bowlers
      	xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowBowlerSeriesDiv"+bowlerId).style.display==''){
				document.getElementById("plusImage"+bowlerId).src = "../Image/horizontal_arw.gif"; 
				document.getElementById("ShowBowlerDetailsDiv"+bowlerId).style.display='none';
				document.getElementById("ShowBowlerSeriesDiv"+bowlerId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/web/jsp/BowlerStatusResponse.jsp?bowlerId="+bowlerId+"&seasonId="+seasonId+"&bowlerName="+bowlerName+"&series_id="+series_id+"&flag="+flag;;		    	
		    	document.getElementById("plusImage"+bowlerId).src = "../Image/vertical_arw.gif"; 
		    	bowler = bowlerId;							
				//xmlHttp.onreadystatechange=stChgBowlerResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);	
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("ShowBowlerDetailsDiv"+bowler).style.display='none';
					document.getElementById("ShowBowlerSeriesDiv"+bowlerId).style.display='';
					document.getElementById("ShowBowlerSeriesDiv"+bowler).innerHTML = responseResult;
					bowler = null;
				}		   
		   	}
		}	
      }	
      
      function callBatsmanDetails(batsmanId,batsmanName){      	
      //	alert("flag  *****     "+document.getElementById('allflag').value)
      	var series_id = document.getElementById("hidSeriesType").value 
      	var seasonId = document.getElementById("seasonId").value      
      	if(document.getElementById("chkhdseries").value == 1){
      		var flag = "s";
      	}else{
      		var flag = "a";
      	};//Flag for all Tournament details
      	xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowBatsmanDetailsDiv"+batsmanId).style.display==''){
				document.getElementById("plusImage"+batsmanId).src = "../Image/horizontal_arw.gif"; 
				document.getElementById("ShowBatsmanDetailsDiv"+batsmanId).style.display='none';
				document.getElementById("ShowBatsmanSeriesDiv"+batsmanId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/web/jsp/BatsmanStatusResponse.jsp?batsmanId="+batsmanId+"&seasonId="+seasonId+"&batsmanName="+batsmanName+"&series_id="+series_id+"&flag="+flag;		    	
		    	document.getElementById("plusImage"+batsmanId).src = "../Image/vertical_arw.gif"; 
		    	batsman = batsmanId;							
				//xmlHttp.onreadystatechange=stChgbatsmanPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("ShowBatsmanDetailsDiv"+batsman).style.display='';
					document.getElementById("ShowBatsmanSeriesDiv"+batsmanId).style.display='none';
					document.getElementById("ShowBatsmanDetailsDiv"+batsman).innerHTML = responseResult;
					batsman = null;		
				}			   
		   	}
		}	
      }	
      
      function callEachMatchRuns(batsmanId,batsmanName){		
		var series_id = document.getElementById("hidSeriesType").value 
      	var seasonId = document.getElementById("seasonId").value 
      	var flag = "s";//Flag for selected Tournament details
      	xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowBatsmanSeriesDiv"+batsmanId).style.display==''){
				document.getElementById("plusImage"+batsmanId).src = "../Image/horizontal_arw.gif"; 
				document.getElementById("ShowBatsmanDetailsDiv"+batsmanId).style.display='none';
				document.getElementById("ShowBatsmanSeriesDiv"+batsmanId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="/cims/web/jsp/BatsmanStatusResponse.jsp?batsmanId="+batsmanId+"&seasonId="+seasonId+"&batsmanName="+batsmanName+"&series_id="+series_id+"&flag="+flag;		    	
		    	document.getElementById("plusImage"+batsmanId).src = "../Image/vertical_arw.gif"; 
		    	batsman = batsmanId;							
				//xmlHttp.onreadystatechange=stChgbatsmanPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("ShowBatsmanDetailsDiv"+batsman).style.display='none';
					document.getElementById("ShowBatsmanSeriesDiv"+batsman).style.display='';
					document.getElementById("ShowBatsmanSeriesDiv"+batsman).innerHTML = responseResult;
					batsman = null;		
				}			   
		   	}
		}		
	}
      
      	
      function runWicketDetails(row,matchid,userid,flag){
	
		try {	
			  xmlHttp = this.GetXmlHttpObject();
	     	  if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	          }else{
	          	if(flag == "1"){
			       var url = "/cims/web/jsp/TopPlayerRunDetail.jsp?matchId="+matchid+"&userId="+userid+"&flag="+flag
			    }else if(flag == "2"){
			       var url = "/cims/web/jsp/TopPlayerRunDetail.jsp?matchId="+matchid+"&userId="+userid+"&flag="+flag
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
      
</script>
</head>

<body  style="margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-right: 0px;">

<form action="/cims/web/jsp/playersStatus.jsp" method="post" name="frmplayerStatus" id="frmplayerStatus" >
<jsp:include page="Header.jsp"></jsp:include>		
<div id = "pbar" name="pbar" class="divlist" style="left: 450px;top: 300px;" align="center">
<table style="background: transparent;">			
	<tr>
<%--		<td align="center" valign="middle" ><b><img src="../Image/loading.gif" /></b></td>--%>
<td align="center" valign="middle"><b><img src="../Image/wait24trans.gif" />&nbsp;<font color="red" size="3"> Loading ......</font></b></td>
	</tr>
</table>
</div>
<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv" >
</div>
<script>showPopup('BackgroundDiv','pbar')</script>
<INPUT type="hidden" name="allflag" id="allflag" value="">
<INPUT type="hidden" name="seriesId" id="seriesId" value="<%=seriesId%>">
<INPUT type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">
<input type="hidden" name="hidSeriesType" id="hidSeriesType" value="<%=seriesId%>"/>
<input   type="hidden" id="hdseriesTypeList" name="hdseriesTypeList" value=""/>
<input   type="hidden" id="hdseries" name="hdseries" value=""/>
<div id="outerDiv" style="width: 1003px;">			
	<table style="width: 1003px;">
		<tr>
			<td valign="top">
				<table width="200" border="0" >
				   <tr>
				 		<td valign="top"><%@ include file="commiteeinfo.jsp" %> 	    	   	 
 	    	   			</td>
				   </tr>				   				   							  												  												          		
				</table>
			</td>
			<td width="788" valign="top">
				<table width="788" border="0" >
					<tr>
						 	<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Top Performers</td>
					</tr>
					<tr class="commityRowAlt">
						<td nowrap="nowrap" class="commityRowAlt" style="font-size: 12px;width: 190px;" >Tournament : (Enter letter to search)
						</td>
						<TD nowrap="nowrap" class="commityRowAlt" valign="top" style="width: 300px;">
							<input type="text" name="seriesName"  id="seriesName" size="35" onKeyUp="javascript:obj1.bldUpdate(event);" autocomplete="OFF" value="<%=series_name%>"> 
							<input id="show" type="button" value="V" class="PopButton" onClick="changeList();"><input type="checkbox" name="chkSeries" id="chkSeries" />All
							<DIV align="left" style="width:150px">
								<DIV id="lister" name="lister" style="display:none;position:absolute;z-index:+10;font-size: 10px;">
									<select   class="inputsearch"  style="width:6.5cm;font-size: 11px;" id="seriesTypeList" name="seriesTypeList" size="5"  onclick="update(event)" onkeypress="update(event)" >
										<%while (crsObjSeriesTypeRecord.next()) { 
										  %>
												<option value="<%=crsObjSeriesTypeRecord.getString("id")%>" style="font-size: 12px;"><%=crsObjSeriesTypeRecord.getString("name")%></option>
												<%
								             	}
									      %>
									</select>
									
								</DIV>
							</DIV>
						</TD>					
																					
						<td width=3% class="commityRowAlt" nowrap="nowrap" colspan="2">								
						<INPUT type="hidden" id="seasonName" name="seasonName" onkeyup="updateSeason(event);" onkeyPress="javascript:getSeasonList(); return keyRestrict(event,'1234567890');"
							size="9" onkeyup="getSeasonList()" autocomplete="OFF" maxlength="9" style="font-size: 11px;"
							value='<%=season_name%>'>&nbsp;&nbsp;&nbsp;&nbsp;
		 				<input type="hidden" id="chkhdseries" name="chkhdseries" value="<%=chkSeries%>" >
		 				<INPUT type="button" name="button" value="Search" class="FlatButton" onclick="validate();" >
						</TD>
					</TR>				
					<tr>
						<td></td>
						<td valign="top"> 
							<DIV align="left" style="width:100px;">
								<DIV id="seriesList" name="seriesList" style="display:none;position:absolute;z-index:+5;"></DIV>
							</DIV>
						</td>
						<td></td>
						<td valign="top"> 
							<DIV align="left" style="width:150px">
								<DIV id="seasonList" name="seasonList" style="display:none;position:absolute;z-index:+5;"></DIV>
							</DIV>
						</td>
					</tr>
					<tr bgcolor="#e6f1fc">
			    		<td valign="top" colspan="4" style="font-size: 13px;">				    								    				
						 	<a href="javascript:ShowBatsmanList()" id="TopBatsman" name="TopBatsman" >Top Batsman </a>&nbsp;|&nbsp;
						   	<a href="javascript:ShowBowlerList()" id="TopBowler" name="TopBowler" >Top Bowler</a>
						</td>		   	
					</tr>
					<tr>						
						<td colspan="4">
							<DIV id="topBtsPerformer" align="right" style="">	
							<table align="center" border="0" width="100%">
								<tr>
									<td align="center">
							<%
										if(serverMessageForBts != null && !serverMessageForBts.equals("")) {
							%>
													<font color=red><%=serverMessageForBts%></font>
							<%	}							
							%>
									<td>
								</tr>
								<tr>
									<td width="100%" align="center">
										<table align="center" border="0" width="100%">
											<tr color="#003399"  class="headinguser">
												<td style="font-size: 14px;"><b>Top 50 Batsmans(Tournament Wise)</b></td>
											</tr>
										</table>
									</td>
								</tr>								
								<tr>
									<td>										
										<table width="100%" border="0" name="sortTable" id="sortTable" align="left" cellpadding="2" cellspacing="1">
											<tr rowspan="3" bgcolor="#f0f7fd">
												<th>&nbsp;</th>
												<th align="left" style="text-decoration: none;font-size: 14px;"><b>Batsmans</b></th>
												<th align="left" style="text-decoration: none;font-size: 14px;"><b>Association</b></th>
												<th align="center" style="text-decoration: none;font-size: 14px;"><b>Scored Runs</b></th>
											</tr>
											<%int counter = 1;%>
									<%
												if(crsObjTopBtsPerformer != null && crsObjTopBtsPerformer.size() > 0) {
													//System.out.println("crsObjTopBtsPerformer.size() " + crsObjTopBtsPerformer.size());
													while (crsObjTopBtsPerformer.next()) {
													batsmanUserId = crsObjTopBtsPerformer.getString("id");
													String total_runs = crsObjTopBtsPerformer.getString("total_runs");
													StringBuffer appendZero = new StringBuffer();
													//System.out.println("1");
													if(total_runs.length() == 1) {
														appendZero.append("000"+total_runs);												
													} else if(total_runs.length() == 2){
														appendZero.append("00"+total_runs);
														//System.out.println(appendZero);	
													} else if(total_runs.length() == 3){
														appendZero.append("0"+total_runs);
														////System.out.println(appendZero);	
													} else {
														appendZero.append(total_runs);
														//System.out.println(appendZero);	
													}
													//System.out.println("2");
									%>
  												<%if(counter % 2 == 0 ){%>
								        		<tr bgcolor="#f0f7fd">
								        		<%}else{%>
								        		<tr bgcolor="#e6f1fc">	
								        		<%}%>
												  <td style="text-align: right;padding-right: 7px;font-size: 11px;" id="<%=counter++%>"><a><IMG id="plusImage<%=batsmanUserId%>" name="plusImage<%=batsmanUserId%>" alt="" src="../Image/horizontal_arw.gif" /></a></td>
												  <td align="left" class="contentLight1" id=""><a href="javascript:callBatsmanDetails('<%=batsmanUserId%>','<%=crsObjTopBtsPerformer.getString("batsman")%>')" ><%=chgInitial.properCase(crsObjTopBtsPerformer.getString("batsman")).trim()%></a></td>
												  <td align="left" class="contentLight1"><%=chgInitial.properCase(crsObjTopBtsPerformer.getString("association"))%></td>
												  <td style="text-align: right;padding-right: 30px;"><%=appendZero%></td>
												 </tr>
												<tr>													
													<td colspan="7">
														<div id="ShowBatsmanDetailsDiv<%=batsmanUserId%>" style="display:none" ></div>
													</td>
												  </tr>
												  <tr>													
													<td colspan="7">
														<div id="ShowBatsmanSeriesDiv<%=batsmanUserId%>" style="display:none" ></div>
													</td>
												  </tr>		
								 <%
												 	 }
												 }
												 //System.out.println("3");
									%>
												
											</table>
										</td>
									</tr>
								</table>						
							</DIV>		
							<DIV id="topBowlPerformer" align="right" style="display: none;" >
							<table align="center" border="0" width="100%">
								<tr>
									<td align="center">
							<%
										if(serverMessageForBowl != null && !serverMessageForBowl.equals("")) {
							%>
													<font color=red><%=serverMessageForBowl%></font>
							<%	}							
							%>
									<td>
								</tr>
								<tr class="commityRowAlt">
									<td width="100%" align="center">
										<table align="center" border="0" width="100%">
											<tr color="#003399" >
												<td style="font-size: 14px;" colspan="4"><b>Top 50 Bowler(Tournament Wise)</b></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td valign="top">										
										<table width="100%" border="0" name="sortable" id="sortable" align="left" cellpadding="2" cellspacing="1">
											<tr bgcolor="#e6f1fc">
												<th>&nbsp;</th>
												<th align="left" style="font-size: 14px;padding-left: 10px;"><b>Bowler</b></th>
												<th align="left" style="font-size: 14px;padding-left: 10px;"><b>Association</b></th>
												<th align="center" style="font-size: 14px;padding-left: 10px;"><b>Total Wickets</b></th>
											</tr>
											<%int colorcounter = 1;%>
												<%
												if(crsObjTopBowlPerformer != null && crsObjTopBowlPerformer.size() > 0) {
													
													while (crsObjTopBowlPerformer.next()) {
													bowlerUserId = crsObjTopBowlPerformer.getString("id");
													bowlername = chgInitial.properCase(crsObjTopBowlPerformer.getString("bowler"));
													//System.out.println("crsObjTopBowlPerformer.size() " + crsObjTopBowlPerformer.size());
													String total_wickets = crsObjTopBowlPerformer.getString("total_wicktes");
													StringBuffer appendZero = new StringBuffer();
													//System.out.println("1");
													
													if(total_wickets.length() == 1) {
														appendZero.append("00"+total_wickets);												
													} else if(total_wickets.length() == 2){
														appendZero.append("0"+total_wickets);
														//System.out.println(appendZero);	
													} else {
														appendZero.append(total_wickets);
														//System.out.println(appendZero);	
													}
													
													//System.out.println("2");					
									
										%>	  <%if(colorcounter % 2 == 0 ){%>
								        		<tr bgcolor="#e6f1fc">
								        		<%}else{%>
								        		<tr bgcolor="#f0f7fd">	
								        		<%}%>
												  <td style="text-align: right;padding-right: 7px;font-size: 11px;" id="<%=colorcounter++%>"><a><IMG id="plusImage<%=bowlerUserId%>" name="plusImage<%=bowlerUserId%>" alt="" src="../Image/horizontal_arw.gif" /></a></td>
												  <td align="left" class="contentLight1" style="padding-left: 7px;" id=""><a href="javascript:callBowlerDetails('<%=bowlerUserId%>','<%=bowlername%>')" ><%=bowlername.trim()%></a></td>
												  <td align="left" class="contentLight1" style="padding-left: 7px;"><%=chgInitial.properCase(crsObjTopBowlPerformer.getString("association"))%></td>
												  <td style="text-align: right;padding-right: 40px;" ><%=appendZero%></td>
<%--												  <td style="text-align: right;padding-right: 40px;"><a href="javascript:callEachMatchWickets('<%=crsObjTopBowlPerformer.getString("bowler").trim()%>','<%=crsObjTopBowlPerformer.getString("id")%>','<%=seriesId%>',<%=seasonId%>)"><%=appendZero%></a></td>--%>
												  </tr>
												  <tr>													
													<td colspan="7">
														<div id="ShowBowlerDetailsDiv<%=bowlerUserId%>" style="display:none" ></div>
													</td>
												  </tr>
												  <tr>													
													<td colspan="7">
														<div id="ShowBowlerSeriesDiv<%=bowlerUserId%>" style="display:none" ></div>
													</td>
												  </tr>		
											<%	 	 }
										}
												 	//System.out.println("3");
									%>
												
											</table>
										</td>
									</tr>
							</table>
						</DIV>	
						</td>
					</tr>
				</table>
			</td>
			<td width="10" ></td>				        		
		</tr>
	</table>
</div>
<script>
	onLoad();
</script>			
		<table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" >
			<tr>
		  		<td>						          	
					<br />
					<br />
					<br />
					<br />
					<br />
					<br />
					<br /><br /><br /><br /><br />
				</td>
		    	<td>&nbsp;</td>
		    	<td>&nbsp;</td>
			</tr>
		</table>
<jsp:include page="Footer.jsp"></jsp:include>	
</form>
<script>    	
	closePopup('BackgroundDiv','pbar');	
 </script>	
</body>		
</html>	

