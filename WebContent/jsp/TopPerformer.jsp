<!--
	Page Name 	 : TopPerformer.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 13th Nov 2008
	Description  : Player Top Performers Report 
	Company 	 : Paramatrix Tech Pvt Ltd.
	Modified by  : Vaibhavg (Added association wise search)  
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
            in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
            java.util.*"
%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<% response.setHeader("Pragma", "private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<%  CachedRowSet crsObjTopBtsPerformer           = null;
	CachedRowSet crsObjTopBowlPerformer          = null;
	CachedRowSet crsObjSeriesTypeRecord 		 = null;
	CachedRowSet crsRoles						 = null;	
	CachedRowSet crsObjSeason					 = null;
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	Vector vparam                            = new Vector();
	Common common = new Common();
	String series_name = "";
	String season_name = "2008-2009";
	String seriesId = "";
	String seasonId = "1";
	String clubId	= "";
	String chkSeries= "";
	String chkconsolated = "";
	String serverMessageForBts = null;
	String serverMessageForBowl = null;
	try {
		crsObjSeriesTypeRecord = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getseriestypes", vparam, "ScoreDB");
					
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e);
	}
	try {
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
			seasonId = crsObjSeason.getString("id");
			season_name = crsObjSeason.getString("name");
		}
	}
	 crsObjSeason.beforeFirst();

%>
<%	if (request.getMethod().equalsIgnoreCase("POST")) {
		if(request.getParameter("seasonId") != null && !request.getParameter("seasonId").equals("")) {
			chkSeries    = request.getParameter("hdseries");
			seasonId    = request.getParameter("seasonId");
			season_name = request.getParameter("seasonName");
			seriesId    = request.getParameter("seriesTypeList");
			chkconsolated = request.getParameter("chkconsolated")==null?"0":request.getParameter("chkconsolated");
			if(seriesId==null || seriesId==""){
				seriesId = request.getParameter("hidSeriesType");	
			}
			series_name = request.getParameter("seriesName");
			clubId     = request.getParameter("selClub");
			// Addded by vaibhav to get bowler and batsman list based on series and association
			System.out.println(chkSeries + "----------------------------------------------------------------");
			try{
				if (!chkSeries.equals("1")){////If not all
						if (!clubId.equalsIgnoreCase("A")){
							vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add(clubId);
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("null")){
							vparam.add("2");
							}else{
							vparam.add("8"); 	
							}
						    crsObjTopBowlPerformer = lobjGenerateProc.GenerateStoreProcedure(
							"dbo.esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");	
						    vparam.removeAllElements();
							  
						    vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add(clubId);
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("2");
							}else{
							vparam.add("8"); 	
							}
							crsObjTopBtsPerformer = lobjGenerateProc.GenerateStoreProcedure(
							"dbo.esp_dsp_getseries_wise_top_batsman_list", vparam, "ScoreDB");
							vparam.removeAllElements();
							if(crsObjTopBowlPerformer.size() == 0) {
								serverMessageForBowl = "No Records Found For Top Bowler.";
							} 
							if(crsObjTopBtsPerformer.size() == 0) {
								serverMessageForBts  = "No Records Found For Top Batsman.";
							}
							
						}else{
					    	vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add("");
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("3");
							}else{
							vparam.add("8"); 	
							}
							crsObjTopBtsPerformer = lobjGenerateProc.GenerateStoreProcedure(
								"dbo.esp_dsp_getseries_wise_top_batsman_list", vparam, "ScoreDB");			
							vparam.removeAllElements();
							
							vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add("");
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("3");
							}else{
							vparam.add("8"); 	
							}
							crsObjTopBowlPerformer = lobjGenerateProc.GenerateStoreProcedure(
								"dbo.esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");	
							vparam.removeAllElements();
							
							if(crsObjTopBowlPerformer.size() == 0) {
								serverMessageForBowl = "No Records Found For Top Bowler.";
							} 
							if(crsObjTopBtsPerformer.size() == 0) {
								serverMessageForBts  = "No Records Found For Top Batsman.";
							}
						}
				}else{//All selected
					if (seriesId.equals("12") || seriesId.equals("13") || seriesId.equals("14") || seriesId.equals("15") ||seriesId.equals("16") ||seriesId.equals("17")){
						if (!clubId.equalsIgnoreCase("A")){//if association is not selected and ranji selected
							vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add(clubId);
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("4");
							}else{
							vparam.add("8"); 	
							}
							crsObjTopBtsPerformer = lobjGenerateProc.GenerateStoreProcedure(
								"dbo.esp_dsp_getseries_wise_top_batsman_list", vparam, "ScoreDB");			
							vparam.removeAllElements();
							vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add(clubId);
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("4");
							}else{
							vparam.add("8"); 	
							}
							crsObjTopBowlPerformer = lobjGenerateProc.GenerateStoreProcedure(
								"dbo.esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");	
							vparam.removeAllElements();
							if(crsObjTopBowlPerformer.size() == 0) {
								serverMessageForBowl = "No Records Found For Top Bowler.";
							} 
							if(crsObjTopBtsPerformer.size() == 0) {
								serverMessageForBts  = "No Records Found For Top Batsman.";
							}
						}else{//if association is selected and ranji selected
							vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add("");
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("5");
							}else{
							vparam.add("8"); 	
							}
							crsObjTopBtsPerformer = lobjGenerateProc.GenerateStoreProcedure(
								"dbo.esp_dsp_getseries_wise_top_batsman_list", vparam, "ScoreDB");			
							vparam.removeAllElements();
							vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add("");
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("5");
							}else{
							vparam.add("8"); 	
							}
							crsObjTopBowlPerformer = lobjGenerateProc.GenerateStoreProcedure(
								"dbo.esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");	
							vparam.removeAllElements();
							if(crsObjTopBowlPerformer.size() == 0) {
								serverMessageForBowl = "No Records Found For Top Bowler.";
							} 
							if(crsObjTopBtsPerformer.size() == 0) {
								serverMessageForBts  = "No Records Found For Top Batsman.";
							}
					}
				}else{
						if (!clubId.equalsIgnoreCase("A")){
							vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add(clubId);
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("2");
							}else{
							vparam.add("8"); 	
							}
						    crsObjTopBowlPerformer = lobjGenerateProc.GenerateStoreProcedure(
							"dbo.esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");	
						    vparam.removeAllElements();
							  
						    vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add(clubId);
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("2");
							}else{
							vparam.add("8"); 	
							}
							crsObjTopBtsPerformer = lobjGenerateProc.GenerateStoreProcedure(
							"dbo.esp_dsp_getseries_wise_top_batsman_list", vparam, "ScoreDB");
							vparam.removeAllElements();
							if(crsObjTopBowlPerformer.size() == 0) {
								serverMessageForBowl = "No Records Found For Top Bowler.";
							} 
							if(crsObjTopBtsPerformer.size() == 0) {
								serverMessageForBts  = "No Records Found For Top Batsman.";
							}
							
						}else{
					    	vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add("");
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("3");
							}else{
							vparam.add("8"); 	
							}
							crsObjTopBtsPerformer = lobjGenerateProc.GenerateStoreProcedure(
								"dbo.esp_dsp_getseries_wise_top_batsman_list", vparam, "ScoreDB");			
							vparam.removeAllElements();
							
							vparam.add(seriesId);
							vparam.add(seasonId);
							vparam.add("");
							vparam.add("");
							if(chkconsolated.equalsIgnoreCase("0")){
							vparam.add("2");
							}else{
							vparam.add("8"); 	
							}
							crsObjTopBowlPerformer = lobjGenerateProc.GenerateStoreProcedure(
								"dbo.esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");	
							vparam.removeAllElements();
							
							if(crsObjTopBowlPerformer.size() == 0) {
								serverMessageForBowl = "No Records Found For Top Bowler.";
							} 
							if(crsObjTopBtsPerformer.size() == 0) {
								serverMessageForBts  = "No Records Found For Top Batsman.";
							}
						}
					}
				}
			}catch(Exception e){
			    e.printStackTrace();
			}
				
			try {
				
			} catch (Exception e) {
					e.printStackTrace();
					out.println(e);
			}	
			
			}
			
		}
%>

<html>
<head>
 <title> Top Performer Details </title>
 
    <script language="JavaScript" src="../js/tabber.js" type="text/javascript"></script>
    <script language="JavaScript" src="../js/sortable.js" type="text/javascript"></script>
    <script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="../css/tabexample.css"> 
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/csms1.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../CSS/form.css">
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
	
	<script language="JavaScript">
		
		function validate() {
			//if(document.getElementById('chkSeries').checked){
			//	document.getElementById('hdseries').value="1";
			//}
			//document.getElementById('hidSeriesType').value =  document.getElementById("seriesName").value;
			/*if(document.topPerformerReportForm.seriesName.value == "" ) {
				alert('Series Name Can Not Be Blank!');
		        document.getElementById("seriesName").focus();
				return false;
			}  else {
				document.topPerformerReportForm.action = "/cims/jsp/TopPerformer.jsp";
				topPerformerReportForm.submit();
			}*/

			document.topPerformerReportForm.action = "/cims/jsp/TopPerformer.jsp";
			topPerformerReportForm.submit();
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
	 	
	 /************** For Series Type List **********************************************************************/
	 	function displaySeriesTypeData() {
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				   var responseResult = xmlHttp.responseText ;
		   		      
		   		      try //Internet Explorer
					  {
<%--						  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");--%>
<%--						  xmlDoc.async="false";--%>
<%--						  xmlDoc.loadXML(responseResult);--%>
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
		      	if(window.event.keyCode == 13 || window.event.keyCode == 0 || window.event.keyCode == 1 ) {
		      		if(document.topPerformerReportForm.seriesName.value != "" ) {
			      		if(document.topPerformerReportForm.series_id.selectedIndex != -1) {
							 	var strMessage = document.topPerformerReportForm.series_id.options[document.topPerformerReportForm.series_id.selectedIndex].value.split("|");;
							    document.topPerformerReportForm.seriesId.value = strMessage[0];
					    		document.topPerformerReportForm.seriesName.value = strMessage[1];
					    	    document.getElementById("seriesList").style.display="none";
		   	    		        document.getElementById("seasonName").focus();
		   	    		} else {
		   	    			alert('Please Select Series Name');
					        document.getElementById("series_id").focus();
		   	    			return false;
		   	    		}
		   	    	} else {
		   	    		alert('Please Enter Series Name');
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
		
/************** For Season List **********************************************************************/
 		 
	 	function displaySeasonData() {
			
		}
		
		function getSeasonList() {
	        xmlHttp = GetXmlHttpObject();
	        var valName = document.topPerformerReportForm.seasonName.value;
	        var seriesName = document.topPerformerReportForm.seriesName.value;
   	       
   	        if(seriesName == "") {
				document.getElementById('seasonList').innerHTML = "<font color='RED'>Please Enter Series Name First</font>";
   		 	    document.getElementById("seasonList").style.display = "";
   	        } else {	        
		           if(valName!="" && valName.length >= 1) {
				        var url = "/cims/jsp/SeasonListAjaxResponse.jsp?seasonName="+valName;
					    xmlHttp.open("get",url,false);
						xmlHttp.send(null);
						if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				   			var responseResult = xmlHttp.responseText ;
		   		   		 try //Internet Explorer
					  	 {
						  var mess = responseResult;
						  document.getElementById('seasonList').innerHTML = mess;
  			  		 	  document.getElementById("seasonList").style.display = "";
  			  		 	  var seasonLength =  document.topPerformerReportForm.season_id.options.length;
  			  		 	  if(seasonLength == 1) {
				    		document.topPerformerReportForm.seasonName.value = "";
			  		 	    var strMessage = document.topPerformerReportForm.season_id.options[0].value.split("|");;
						    document.topPerformerReportForm.seasonId.value = strMessage[0];
				    		document.topPerformerReportForm.seasonName.value = strMessage[1];
				    		document.getElementById("seasonList").style.display="none";
	    			        document.getElementById("seasonName").focus();
  			  		 	  }
  			  		 	  
		                }catch(e) {
						  try //Firefox, Mozilla, Opera, etc.
						  {
						  }catch(e) {
					    	alert(e.message)
					      }
					    }
				       }
				    }
  		    }
      }
 			        
        function updateSeason(e) {
        	evt = e || window.event;
			var keyPressed = evt.which || evt.keyCode;
        	    if(keyPressed == 13 || keyPressed ==0 || keyPressed ==1 ) {
		      		if(document.topPerformerReportForm.seasonName.value != "" ) {
			      		if(document.topPerformerReportForm.season_id.selectedIndex != -1) {
				    		document.topPerformerReportForm.seasonName.value = "";
					        var strMessage = document.topPerformerReportForm.season_id.options[document.topPerformerReportForm.season_id.selectedIndex].value.split("|");;
						    document.topPerformerReportForm.seasonId.value = strMessage[0];
				    		document.topPerformerReportForm.seasonName.value = strMessage[1];
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
		    	
		    	if(window.event.keyCode == 40) {
		    		if(document.topPerformerReportForm.seriesName.value != "") {
			        		document.getElementById("season_id").focus();
			        }
		    	}
		    	
		    	if(window.event.keyCode == 27) {
		         	document.getElementById("seasonList").style.display="none";
		        }
      }
      
      /**********************************************************************************************/
		
		 function onLoad() {
	        obj1 = new SelObj('topPerformerReportForm','seriesTypeList','seriesName');
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
      	    document.topPerformerReportForm.seriesName.value = document.topPerformerReportForm.seriesTypeList.options[document.topPerformerReportForm.seriesTypeList.selectedIndex].text;
    	    document.getElementById("seriesName").focus();
    	    hideList();
    	    document.topPerformerReportForm.hdseriesTypeList.value=document.topPerformerReportForm.seriesTypeList.value;
    	}
    	if(keyPressed== 27){
    		document.getElementById("lister").style.display="none";
        }
        
      }
      
      
      function showList(e) {
          
        evt = e || window.event;
    	var keyPressed = evt.which || evt.keyCode;
    	if(keyPressed == 40)
      	{
       	document.getElementById("lister").style.display="";
        document.getElementById("seriesTypeList").focus();
        }        
        if(document.getElementById("seriesTypeList").value=="0" ||document.getElementById("seriesTypeList").value==""||keyPressed == 0||keyPressed == 1)
        {
         document.getElementById("lister").style.display="";
        }
        if(keyPressed == 27){
         document.getElementById("lister").style.display="none";
        }
      }
      
      function hideList() {
        document.getElementById("lister").style.display='none';	
      }
      
       function changeList(event) {
        if (document.getElementById("lister").style.display=="none")
          showList(event);
        else
         hideList();
      }	
      
     
      
</script>
</head>
<body>
<table align="center" style="width: 84.5em;">
    <tr>
    	<td align="center">
<div style="width: 84.5em">
<jsp:include page="Menu.jsp"></jsp:include>
<br><br>


<FORM name="topPerformerReportForm" id="topPerformerReportForm" action="/cims/jsp/TopPerformer.jsp" method="POST">
<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv" >
</div>
<INPUT type="hidden" name="seriesId" id="seriesId" value="<%=seriesId%>">

<input type="hidden" name="hidSeriesType" id="hidSeriesType" value="<%=seriesId%>"/>
<input   type="hidden" id="hdseriesTypeList" name="hdseriesTypeList" value=""/>
<input   type="hidden" id="hdseries" name="hdseries" value=""/>

<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
  <tr>
		<td>
			<table width="100%" border="0" align="center">
				<tr>
					<td width="100%" class="legend" align="left" >Top Performers List</td>
				</tr>	
			</table>
		</td>
	</tr>
	<tr>
	  <td>
	    <table width="100%" border="0" align="center">
		  <tr>
		    <td width="30%" align="left">Tournament : (Enter letter to search)</td>
			<td width="10%" align="center">Season :</td>
			<td width="25%" align="center">Association :</td>
			<td width="20%">&nbsp;&nbsp;Consolated Report</td>
			<td width="15%">&nbsp;</td>
		  </tr>
		  <tr  align="center">
			 <TD width="30%" nowrap="nowrap" align="left">
			   <input   class="inputsearch" type="text" name="seriesName" id="seriesName" size="35" onKeyUp="javascript:obj1.bldUpdate(event);" autocomplete="OFF" value="<%=series_name%>"> 
			   <input	 class="btn btn-small" id="show" type="button" value="V" onClick="changeList(event);">
			   <DIV align="left" style="width:250px">
			   <DIV id="lister" name="lister" style="display:none;position:absolute;z-index:+10;">
			     <select   class="inputsearch"	  style="width:6.5cm" id="seriesTypeList" name="seriesTypeList" size="5"  onclick="update(event)" 	onkeypress="update(event)" >
<%		         while (crsObjSeriesTypeRecord.next()) {
%>			       <option value="<%=crsObjSeriesTypeRecord.getString("id")%>"><%=crsObjSeriesTypeRecord.getString("name")%></option>
<%               }
%> 			     </select>
			   </DIV>
			   </DIV>
			 </TD>
			 <td align="center" width="10%">
			 
			 <select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="seasonId" id="seasonId" >
					<option >Select </option>
			 <%if(crsObjSeason != null){
						while(crsObjSeason.next()){
			 %>
			 <%if(crsObjSeason.getString("id").equalsIgnoreCase(seasonId)){%>
					<option value="<%=crsObjSeason.getString("id")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>
			<%}else{%>
					<option value="<%=crsObjSeason.getString("id")%>" ><%=crsObjSeason.getString("name")%></option>
			<%}%>
			<%}
			 }
			%>	
			</select>
			  
			  
			  
		 
			 </td>
			 <td width="25%" nowrap="nowrap">
				<select class="input" name="selClub" id="selClub" style="width:5cm">
			 	 <option value="A">--All Association--</option>
<%				 try{
				  vparam.removeAllElements();
				  vparam.add("2");//
				  crsRoles = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roles",vparam,"ScoreDB");
				  vparam.removeAllElements();	
				 if(crsRoles != null){	
				 while(crsRoles.next()){	
%>				 <option value="<%=crsRoles.getString("id")%>" <%=clubId.equals(crsRoles.getString("id"))?"selected":""%>><%=crsRoles.getString("name")%></option>
<%				 }
	 			 }
			    }catch(Exception e){
  			    }
%>			    </select>
			 </td>
			 <TD align="center" width="20%"><INPUT type="checkbox" name="chkconsolated" id="chkconsolated" <%=chkconsolated.equalsIgnoreCase("0")?"":"checked"%>/>
			 </TD>
			 <TD align="left" width="15%"><INPUT type="button" class="btn btn-warning" name="button" value="Search" onclick="validate();" >
			 </TD>
		   </TR>
		   <tr>
		   	<td>&nbsp;</td>
		   	<td align="right"> 
			    <DIV align="left" style="width:250px">
					<DIV id="seasonList" name="seasonList" style="display:none;position:absolute;z-index:+5;"></DIV>
				</DIV>
			 </td>
			 <td>&nbsp;</td>
			 <td>&nbsp;</td>
		   </tr>
		   <tr>
			 <td> </td>
			 <td> 
				<DIV align="left" style="width:250px;">
					<DIV id="seriesList" name="seriesList" style="display:none;position:absolute;z-index:+5;"></DIV>
			   	</DIV>
			 </td>
		     <td> </td>
		   </tr>
		</table>
	  </td>
	</tr>
	<tr>
	  <td>
			<br>
			<table width="100%" border="0" align="center">
				<tr>
					<td>
			
						<font color="gray">NOTE  :- For Sort Record Click On Batsman / Bowler Name , Association Name Or Total Wkt / Runs. </font>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</table>
	<table width="100%" align="center" border="0">
	<tr>
		<td align="center">
			<div class="tabber" align="left" id="btsWktReport" name="btsWktReport" style="width:100%">
				<DIV class="tabbertab">
					<h2>Top Batsman</h2>
						<DIV id="topBtsPerformer" align="right" style="display: none;">	
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
									<td  align="center">
										<table align="center" border="0" width="100%">
											<tr color="#003399" class="headinguser">
												<td class="headinguser"><b>Top 50 Batsman(Series Wise)</b></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>
										<br>
										<table width="100%" border="0" class="sortable table tableBorder" name="sortTable" id="sortTable" align="left" cellpadding="2" cellspacing="1">
											<tr class="contentDark" rowspan="3">
												<th align="left" class="colheadinguser"><b>Batsmans Names</b></th>
												<th align="left" class="colheadinguser"><b>Association Name</b></th>
												<th align="right" class="colheadinguser"><b>Total Runs</b></th>
											</tr>

									<%
												if(crsObjTopBtsPerformer != null && crsObjTopBtsPerformer.size() > 0) {
													//System.out.println("crsObjTopBtsPerformer.size() " + crsObjTopBtsPerformer.size());
													while (crsObjTopBtsPerformer.next()) {
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
  												<tr class="contentLight1">
												  <td align="left" class="contentLight1">
<a onMouseOver="this.style.backgroundColor='#FFFFFF'; this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#EDEDED'" href="javascript:callRanjiPlayer('<%=crsObjTopBtsPerformer.getString("id")%>','<%=crsObjTopBtsPerformer.getString("associationid")%>','<%=crsObjTopBtsPerformer.getString("batsman")%>','<%=crsObjTopBtsPerformer.getString("association")%>')"><%=crsObjTopBtsPerformer.getString("batsman").trim()%></a></td>
												  <td align="left" class="contentLight1"><%=crsObjTopBtsPerformer.getString("association")%></td>
												  <%if(chkSeries.equals("1")){%>
												    <td align="right" class="contentLight1"><%=appendZero%></td>
												 <%}else{%>
												  	<td align="right" class="contentLight1">
<a onMouseOver="this.style.backgroundColor='#FFFFFF'; this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#EDEDED'" href="javascript:callEachMatchRuns('<%=crsObjTopBtsPerformer.getString("batsman").trim()%>','<%=crsObjTopBtsPerformer.getString("id")%>','<%=seriesId%>',<%=seasonId%>)"><%=appendZero%></a></td>
												 <%}%>
												 </tr>
									<%
												 	 }
												 }
												 //System.out.println("3");
									%>
												
											</table>
											<div name="DivBtsMatch" id="DivBtsMatch" style="display:none">
											</div>
										</td>
									</tr>
								</table>						
							</DIV>
					</DIV>
					<DIV class="tabbertab">
					<h2>Top Bowler</h2>
						<DIV id="topBowlPerformer" align="right" style="display: none;">
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
								<tr>
									<td width="100%" align="center">
										<table align="center" border="0" width="100%">
											<tr color="#003399"  class="headinguser">
												<td class="headinguser"><b>Top 50 Bowler(Series Wise)</b></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>
										<br>
										<table border="0" class="sortable table tableBorder" name="sortable" id="sortable" align="left" cellpadding="2" cellspacing="1">
											<tr class="contentDark" rowspan="3">
												<th align="left" class="colheadinguser"><b>Bowler Name</b></th>
												<th align="left" class="colheadinguser"><b>Association Name</b></th>
												<th align="right" class="colheadinguser"><b>Total Wickets</b></th>
											</tr>
												<tr class="contentLight1">
									<%
												if(crsObjTopBowlPerformer != null && crsObjTopBowlPerformer.size() > 0) {
													while (crsObjTopBowlPerformer.next()) {
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
									
									%>
												  
												  <td align="left" class="contentLight1">
<a onMouseOver="this.style.backgroundColor='#FFFFFF'; this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#EDEDED'" href="javascript:callRanjiPlayer('<%=crsObjTopBowlPerformer.getString("id")%>','<%=crsObjTopBowlPerformer.getString("associationid")%>','<%=crsObjTopBowlPerformer.getString("bowler")%>','<%=crsObjTopBowlPerformer.getString("association")%>')"><%=crsObjTopBowlPerformer.getString("bowler").trim()%></a></td>
												  <td align="left" class="contentLight1"><%=crsObjTopBowlPerformer.getString("association")%></td>
												  <%if(chkSeries.equals("1")){%>
												  <td align="right" class="contentLight1"><%=appendZero%></td>
												  <%}else{%>
												   <td align="right" class="contentLight1">
<a onMouseOver="this.style.backgroundColor='#FFFFFF'; this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#EDEDED'" href="javascript:callEachMatchWickets('<%=crsObjTopBowlPerformer.getString("bowler").trim()%>','<%=crsObjTopBowlPerformer.getString("id")%>','<%=seriesId%>',<%=seasonId%>)"><%=appendZero%></a></td>
												  <%}%>
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
					</DIV>
				</div>
			</td>
		</tr>
</table>
<script>
	onLoad();

	function callRanjiPlayer(id,associationid,playerName,associationame){
		var seasonId = document.getElementById("seasonId").value
		var seriesId = document.getElementById("hidSeriesType").value
		document.topPerformerReportForm.action="/cims/jsp/PlayerCareerReport.jsp?userid="+id +"&associationid="+associationid +"&playerName="+playerName +"&associationame="+associationame+"&seriesId="+seriesId+"&seasonId="+seasonId;
		document.topPerformerReportForm.submit();
	}
	
	function callEachMatchRuns(username,userid,seriesid,seasonid){
		window.open("/cims/jsp/TopPlayerMatcheDetail.jsp?userId="+userid+"&userName="+username+"&seriesId="+seriesid+"&seasonId="+seasonid+"&flag=1","matchesdetails","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=250,left=100,width="+(window.screen.availWidth-300)+",height="+(window.screen.availHeight-400));
	}
		
	function callEachMatchWickets(username,userid,seriesid,seasonid){
		window.open("/cims/jsp/TopPlayerMatcheDetail.jsp?userId="+userid+"&userName="+username+"&seriesId="+seriesid+"&seasonId="+seasonid+"&flag=2","matchesdetails","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=250,left=100,width="+(window.screen.availWidth-300)+",height="+(window.screen.availHeight-400));
	}
</script>
<script>
	displayTopBtsPerformer();
</script>
</FORM>

</div>
<br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="admin/Footer.jsp"></jsp:include>
</td>
</tr>
</table>
</body>
</html>
