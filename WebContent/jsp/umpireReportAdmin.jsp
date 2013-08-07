<%-- 
    Document   : UmpiresSelfAssessmentPerformance
    Created on : Dec 17, 2008, 10:50:02 AM
    Author     : bhushanf
--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
		
        CachedRowSet crsObjMtWiseUmpSelfAssest = null;
		CachedRowSet crsCmbMtWiseUmpSelfAssest = null;
		CachedRowSet crsObjSeriesTypeRecord = null;
        Calendar cal ;
        String currYear = null;
        String reportHeading=null;
        Vector vparam = new Vector();
        String sessionId = "0";
        String sessionName = null;
		GregorianCalendar currDateObj=new GregorianCalendar();
		cal = new GregorianCalendar(currDateObj.get(Calendar.YEAR),currDateObj.get(Calendar.MONTH),1);
		int Year=cal.get(Calendar.YEAR);
                currYear = (Year - 1)+"-" + (Year);
                GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
                String hidId = request.getParameter("hidId")!=null?request.getParameter("hidId"):"0";   
                String sessionVal = request.getParameter("cmbsession")!=null?request.getParameter("cmbsession"):"0";   
                String series_name = request.getParameter("seriesName")!=null?request.getParameter("seriesName"):"";
            	String seriesId =  request.getParameter("hdseriesTypeList")!=null? request.getParameter("hdseriesTypeList"):"0";	;
            	String reportId = request.getParameter("reportid")!=null?request.getParameter("reportid"):"0";   
                String cmbSession = request.getParameter("cmbsession")!=null?request.getParameter("cmbsession"):currYear;   
                String userRole = session.getAttribute("role").toString();
                String userId = session.getAttribute("userid").toString()!=null?session.getAttribute("userid").toString():"0"; 
                if(reportId.equalsIgnoreCase("1")){
                   reportHeading ="Umpire Assessment Report";
                }else if(reportId.equalsIgnoreCase("2")){ 
                    reportHeading ="Umpire Coach Assessment Report";
                 }else if(reportId.equalsIgnoreCase("3")){
                    reportHeading ="Referee Assessment Report";
                 } 
                if(hidId.equalsIgnoreCase("1")){
                   String sessionArr[] = sessionVal.split("~");
                   if(sessionArr.length > 0){
                    sessionId = sessionArr[0]; 
                    sessionName = sessionArr[1];
                    }
                 }else{
                   sessionName = currYear;    
                 }
                 
                vparam.add("");   
                crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_seasonlist", vparam, "ScoreDB");
               vparam.removeAllElements();
               if(crsObjMtWiseUmpSelfAssest!=null){
	           		while(crsObjMtWiseUmpSelfAssest.next()){
	           			sessionName = crsObjMtWiseUmpSelfAssest.getString("name");
	           		}
	           		crsObjMtWiseUmpSelfAssest.beforeFirst();	
           	   }
           	   if(hidId.equalsIgnoreCase("1")){
                	vparam.add(sessionId);   
                	if(userRole.equalsIgnoreCase("9") && !seriesId.equalsIgnoreCase("0")){
                   		vparam.add("1");  // admin login
                	}else{
                    	vparam.add("2"); // other than admin login
                	}
                    
                	vparam.add(userId);
                    vparam.add(seriesId); 
                	if(reportId.equalsIgnoreCase("1")){
                    	crsCmbMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_umpires_self_coach_refree_assessment_performance", vparam, "ScoreDB");
                   
                	}else if(reportId.equalsIgnoreCase("2")){
                		crsCmbMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_coach_umpires_self_assessment_performance", vparam, "ScoreDB");
	                }else{
    	            	crsCmbMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_refree_umpires_self_assessment_performance", vparam, "ScoreDB");
            	    } 
               		vparam.removeAllElements();
               } 
               try {
				crsObjSeriesTypeRecord = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_getseriestypes", vparam, "ScoreDB");
			   } catch (Exception e) {
				e.printStackTrace();
			   }
               
               
%>             

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Umpire Self Assessment Report</title>
         <link rel="stylesheet" type="text/css" href="../css/menu.css">
         <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
         <link href="../css/form.css" rel="stylesheet" type="text/css" />
         <link href="../css/formtest.css" rel="stylesheet" type="text/css" />    
         <script language="javascript">
            function validate() {
                if(document.getElementById("cmbsession").value=="0"){
                    alert("Please Select Season");
                    document.getElementById("cmbsession").focus();
                    return false;
                }    
                else{    
                	if(document.getElementById("seriesName").value == ""){
                		document.getElementById("seriesName").value = ""
                		document.getElementById("hdseriesTypeList").value = "0"
                	}
                    document.getElementById("hidId").value="1";
                    document.umpireselfassessmentForm.action = "/cims/jsp/umpireReportAdmin.jsp";
                    document.umpireselfassessmentForm.submit();
                }
            }
            function GetXmlHttpObject() {
                var xmlHttp = null;
                try
                {
                    // Firefox, Opera 8.0+, Safari
                    xmlHttp = new XMLHttpRequest();
                }
                catch (e)
                {
                    // Internet Explorer
                    try
                    {
                        xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                    }
                    catch (e)
                    {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                }
                return xmlHttp;
             }
             
             function openmatchwindow(match_id,umpireId,seasonId,seriseId,reportId){
				var url;

             	if(reportId=="1"){

             		url = "/cims/jsp/adminumpireassesmentmatechdetails.jsp";

             	}else{

	             	url = "/cims/jsp/adminrefreeassesmentmatechdetails.jsp";

             	}
           		window.open(url+"?match="+match_id+"&seasonId="+seasonId+"&umpireId="+umpireId+"&seriseId="+seriseId+"&reportId="+reportId,"MatchDatails","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+screen.width+",height="+(screen.height-150));	
             }
             function mainReport(report_id,session_id,user_id){
                try { 
                if(document.getElementById(user_id).style.display=='none'){
                    var sessionVal = document.getElementById("sessionVal").value;
                    var seriseid = document.getElementById("hdseriesTypeList").value;
                    xmlHttp = this.GetXmlHttpObject();
                    if (xmlHttp == null) {
                        alert("Browser does not support HTTP Request");
                        return;
                    }else{
                    	if(report_id=="3" ||report_id=="2" ){
                    	var url = "/cims/jsp/adminRefreeAssesmentReportResponse.jsp?reportId="+report_id+"&sessionId="+session_id+"&userId="+user_id+"&cmbsession="+sessionVal+"&seriseid="+seriseid;
                    	}else{
                        var url = "/cims/jsp/adminAssesmentReportResponse.jsp?reportId="+report_id+"&sessionId="+session_id+"&userId="+user_id+"&cmbsession="+sessionVal+"&seriseid="+seriseid;
                        }
        				xmlHttp.open("post", url, false);
                   	 	xmlHttp.send(null);
                         if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                            try {
                                var responseResult = xmlHttp.responseText ;
                                document.getElementById(user_id).innerHTML = responseResult
                                
                                document.getElementById(user_id).style.display='';
                                document.getElementById("plusImage"+user_id).src = "/cims/images/minus.jpg";
                                document.getElementById(user_id).scrollIntoView(true);
                                   
                            } catch(err) {
                                alert(err.description + 'ajex.js.reciveDataLastTenOvr()');
                             }
                         }//end of if 
                      }// end of else
                  }else{
                    document.getElementById(user_id).style.display='none';
                    
                    document.getElementById("plusImage"+user_id).src = "/cims/images/plusdiv.jpg";
                    
                  }
                  } catch(err) {
                        alert(err.description + 'ajex.js.inningid');
                  }//end of catch	
                   
               }
               
               function referee(id){
                 if(document.getElementById("refere"+id).style.display==''){
                    document.getElementById("refere"+id).style.display='none';
                 }else{
                    document.getElementById("refere"+id).style.display='';
                 } 
               }
               
               function umpire(id){
                 if(document.getElementById("umpire"+id).style.display==''){
                    document.getElementById("umpire"+id).style.display='none';
                 }else{
                    document.getElementById("umpire"+id).style.display='';
                 } 
               }
                function umpir2(id){
                 if(document.getElementById("umpir2"+id).style.display==''){
                    document.getElementById("umpir2"+id).style.display='none';
                 }else{
                    document.getElementById("umpir2"+id).style.display='';
                 } 
               }
               
               
               function coach(id){
                 if(document.getElementById("coach"+id).style.display==''){
                    document.getElementById("coach"+id).style.display='none';
                 }else{
                    document.getElementById("coach"+id).style.display='';
                 } 
               }
               
               function HidUnHide(id){
                 if(document.getElementById("umpireremark"+id).style.display==''){
                    document.getElementById("umpireremark"+id).style.display='none';
                 }else{
                    document.getElementById("umpireremark"+id).style.display='';
                 }
               }
               function HidUnHide1(id){
               	if(document.getElementById("umpireremark1"+id).style.display==''){
                    document.getElementById("umpireremark1"+id).style.display='none';
                 }else{
                    document.getElementById("umpireremark1"+id).style.display='';
                 }
               }
               function hdUmpireCoachText(id){
                 if(document.getElementById("umpirecoachremark"+id).style.display==''){
                    document.getElementById("umpirecoachremark"+id).style.display='none';
                 }else{
                    document.getElementById("umpirecoachremark"+id).style.display='';
                 }
               }  
                function hdUmpireRefreeText(id){
                 if(document.getElementById("umpirerefreeremark"+id).style.display==''){
                    document.getElementById("umpirerefreeremark"+id).style.display='none';
                 }else{
                    document.getElementById("umpirerefreeremark"+id).style.display='';
                 }
               }  
               function onLoad() {
	      		  obj1 = new SelObj('umpireselfassessmentForm','seriesTypeList','seriesName');
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
    				if(keyPressed == 40){
				       	selected("seriesTypeList");
       				 }   
       	 	 }
      		 function update(e) {
      			evt = e || window.event;
	  			 var keyPressed = evt.which || evt.keyCode;
	  			if(keyPressed == 13 || keyPressed ==0 || keyPressed ==1){
					document.umpireselfassessmentForm.seriesName.value = document.umpireselfassessmentForm.seriesTypeList.options[document.umpireselfassessmentForm.seriesTypeList.selectedIndex].text;
			    	document.getElementById("seriesName").focus();
			    	hideList();
			    	document.umpireselfassessmentForm.hdseriesTypeList.value=document.umpireselfassessmentForm.seriesTypeList.value;
			     }
			     if(keyPressed == 27){
			         document.getElementById("lister").style.display="none";
			     }
        	 }
		     function showList(e) {
			     evt = e || window.event;
	  			 var keyPressed = evt.which || evt.keyCode;
			     
			      if(keyPressed == 40){
				  	document.getElementById("lister").style.display='';
				    document.getElementById("seriesTypeList").focus();
			      }
			      if(document.getElementById("seriesTypeList").value=="0" ||document.getElementById("seriesTypeList").value==""||keyPressed == 0){
				    document.getElementById("lister").style.display='';
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

	</script>

    </head>
    <body>
<div class="container">
<jsp:include page="Menu.jsp"></jsp:include>
    <table width="100%" align="center">
    <tr>
    	<td align="center">
    <div >
       	<form name="umpireselfassessmentForm" id="umpireselfassessmentForm" method="POST">
        <br><br>
        	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
               	<tr>
					<td  align="left" class="legend"><%=reportHeading%></td>
	       	   	</tr>
           	</table>
           
           	<table width="100%" cellpadding="2" cellspacing="1" class="table">
			<tr>
				<td>
					<table width="100%" border="0" align="center" class="table">
					  	<tr class="contentLight">
							<td>&nbsp;</td>
							<td width="25%" nowrap="nowrap">Tournament : (Enter letter to search)</td>
							<td width="20%" nowrap="nowrap"> <input class="inputsearch" type="text"
								name="seriesName" id="seriesName" size="30"
								onKeyUp="javascript:obj1.bldUpdate(event);" autocomplete="OFF"
								value="<%=series_name%>"> <input class="btn btn-small" id="show"
								type="button" value="V" onClick="changeList();">
							<div align="left" style="width:250px">
							<div id="lister" style="display:none;position:absolute;z-index:+10;">
							<select class="inputsearch" style="width:6.5cm" id="seriesTypeList"
								name="seriesTypeList" size="5" onclick="update(event)"
								onkeypress="update(event)">
			<%					while (crsObjSeriesTypeRecord.next()) {
			%>					<option value='<%=crsObjSeriesTypeRecord.getString("id")%>'><%=crsObjSeriesTypeRecord.getString("name")%></option>
			<%	            }
			%>				</select></div>
							</div>
							</td>
							<td width="10%" align="left" nowrap="nowrap">Season :</td>
							<td width="10%" nowrap="nowrap">
								<select id="cmbsession" name="cmbsession">
									<option value="0">---Select---</option>
									<%    if(crsObjMtWiseUmpSelfAssest!=null){
				                            while(crsObjMtWiseUmpSelfAssest.next()){%>							
									<option
												value='<%=crsObjMtWiseUmpSelfAssest.getString("id")+"~"+crsObjMtWiseUmpSelfAssest.getString("name")%>'
												<%=sessionName.equalsIgnoreCase(crsObjMtWiseUmpSelfAssest.getString("name"))?"selected":"" %>>
												<%=crsObjMtWiseUmpSelfAssest.getString("name")%></option>
				<%                          }// end of while
				                          }// end of if %>
								</select>
							</td>
							<td><input type="button" class="btn btn-warning btn-small" name="button" value="Search" onclick="validate();"> </td>
						</tr>
					</table>
				</td>
			</tr>
           <tr>
           <td>    
<%         if(hidId.equalsIgnoreCase("1")){
%>        <table width="100%" border="0"  class="table">
            <tr class="contentLight">
                <td nowrap="nowrap" align="left">
                    * U:- Umpire Rating.
                </td>    
            </tr>   
            <tr class="contentLight" >
                <td nowrap="nowrap" align="left">
                    * C:- Umpire Coach Rating.
                </td>    
            </tr>   
            <tr class="contentLight" >
                <td nowrap="nowrap" align="left">
                    * R:- Referee Rating.
                </td>    
            </tr>   
           <tr class="contentLight">
             <td nowrap="nowrap" align="left">
	            * Click on Name or Score to get details.
             </td>    
           </tr>   
           
            </table>
            <br>
            <table width="100%" align="center" class="table tableBorder1" >
               <tr class="contentDark">
                   
<%                 if(reportId.equalsIgnoreCase("1")){  
%>                 <td>Umpire Name</td>
                   <td>Umpire Rating</td>
                   <td>Coach Rating</td>
                   <td>Referee Rating</td>
                   <td>FeedBack</td>
<%                 }else if(reportId.equalsIgnoreCase("2")){
%>				   <td>Umpire Coach Name</td>
                   <td>Coach  Rating</td>
                   <td>Umpire1 Rating</td>
                   <td>Umpire2 Rating</td>	
                   <td>FeedBack</td>
	
<%				   }else if(reportId.equalsIgnoreCase("3")){
%>				   <td>Refree Name</td>
                   <td>Refree  Rating</td>
                   <td>Umpire1 Rating</td>
                   <td>Umpire2 Rating</td> 
                   <td>FeedBack</td>	
	
<%				   }	
%>                                    
               </tr> 
<%          if(crsCmbMtWiseUmpSelfAssest!=null){ 
            int i=0;
             while(crsCmbMtWiseUmpSelfAssest.next()){
              if(i%2==0){
%>             <tr >
<%              }else{
%>              <tr >
<%               }
					if(reportId.equalsIgnoreCase("1")){
%>                  <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')"><IMG id="plusImage<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" name="plusImage<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" title="Click On + To Get The Details." height="10px" alt="" border="0" src="../images/plusdiv.jpg" /></a>&nbsp;<%=crsCmbMtWiseUmpSelfAssest.getString("name")%></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#B0B0B0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("TotalScore")%></b></font></a></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#0099FF"><b><%=crsCmbMtWiseUmpSelfAssest.getString("umpirecoachrate")%></b></font></a></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#716FB0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("refreerate")%></b></font></a></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#716FB0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("feedback_cnt")%> / <%=crsCmbMtWiseUmpSelfAssest.getString("total_match_cnt")%> </b></font></a></td>
<%					}else if(reportId.equalsIgnoreCase("2")){
%>					 <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')"><IMG id="plusImage<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" name="plusImage<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" title="Click On + To Get The Details." height="10px" border="0" alt="" src="../images/plusdiv.jpg" /></a>&nbsp;<%=crsCmbMtWiseUmpSelfAssest.getString("name")%></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#B0B0B0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("TotalScore")%></b></font></a></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#0099FF"><b><%=crsCmbMtWiseUmpSelfAssest.getString("umpire1score")%></b></font></a></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#716FB0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("umpire2score")%></b></font></a></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#716FB0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("feedback_cnt")%> / <%=crsCmbMtWiseUmpSelfAssest.getString("total_match_cnt")%></b></font></a></td>  
						
<%					}else{
%>                  <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')"><IMG id="plusImage<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" name="plusImage<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" title="Click On + To Get The Details." height="10px" border="0" alt="" src="../images/plusdiv.jpg" /></a>&nbsp;<%=crsCmbMtWiseUmpSelfAssest.getString("name")%></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#B0B0B0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("RefreeScore")%></b></font></a></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#0099FF"><b><%=crsCmbMtWiseUmpSelfAssest.getString("umpire1score")%></b></font></a></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#716FB0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("umpire2score")%></b></font></a></td>
                    <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>')" class="link"><font color="#716FB0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("feedback_cnt")%> / <%=crsCmbMtWiseUmpSelfAssest.getString("total_match_cnt")%></b></font></a></td>  
<%					}
%>                    
	
                </tr>
                <tr>
                    <td colspan="5" height="100%">
                        <div id="<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" name="<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" style='display:none;overflow:auto'  >
                        </div>
                    </td>
                </tr>
<%           i=i+1;
              }// end of while
             }// end of if
%>               
           </table>    
<%          }
%>          </td> 
            </tr>
            </table>
           <input type="hidden" name="hidId" id="hidId" value="0">
           <input type="hidden" name="reportid" id="reportid" value="<%=reportId%>">    
           <input type="hidden" name="sessionVal" id="sessionVal" value="<%=sessionVal%>">
           <input type="hidden" name="hidSeriesType" id="hidSeriesType"value="<%=seriesId%>" /> 
		   <input type="hidden" id="hdseriesTypeList" name="hdseriesTypeList" value="<%=seriesId%>" /> 
		  <input type="hidden" id="hdseries" name="hdseries" value="" />    
           <script type="text/javascript">
			onLoad();
		   </script>
		   <br><br><br><br><br>
		   
						<jsp:include page="admin/Footer.jsp"></jsp:include>
					
        </form>
      </div>
      
    	
    	</td>
    </tr>
    </table>  
</div>
    </body>
</html>
