
<!--
Page Name:    RegionMaster.jsp
Author 		 : Swapnilgupta.
Created Date : 20th Sep 2008
Description  : Selection of Region Master 
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%> 
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.common.validator.DataValidator,in.co.paramatrix.common.exceptions.NoEntity,in.co.paramatrix.common.exceptions.InvalidEntity"%>

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
	<%--  ------------------------Added By Vishwajeet --------------------------------------------%>
<%!
	 public String validateData(Vector lvValidatorId, Vector lvFormsData, Vector lvFieldName, DataValidator dv) throws NoEntity, InvalidEntity {
		   StringBuffer serverRemark = new StringBuffer();
		   
		  	for(int i = 0; i < lvValidatorId.size(); i++ ) {
		   		for(int k=0; k < lvFieldName.size(); k++)	{
					test:
		   				for(int j = 0; j < lvFormsData.size(); j++) {
							try {
									dv.validate((String)lvValidatorId.elementAt(i), lvFormsData.elementAt(j));
									i++;
									k++;
									continue test;
							} catch (in.co.paramatrix.common.exceptions.RuleViolated ruleViolated) {
								serverRemark.append("'"+lvFieldName.elementAt(k)+"',");		
								i++;
								k++;							 
							} 
						}
				}
			}
			
			if(serverRemark.length() > 0) {
				serverRemark.deleteCharAt(serverRemark.lastIndexOf(","));
			}
			return serverRemark.toString();
	}

%>	
		<%-- --------------------------------------------------------------------------------------------%>
<% 


      
      Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
       CachedRowSet crsObjResult             = null;
		CachedRowSet crsObjResultState        = null;
		CachedRowSet crsObjResultZone         = null;
	    CachedRowSet 	crsObjClubsearch      =null;
	    CachedRowSet 	crsObjResultvenue      =null;
	    String gsclubname                      =null;
	    String gsstateid                      =null;
	    String gszoneid                         =null;
	    String gsclubid                        =null;
	    String clubname                        =null;
	    String statename                       =null;
	    String serverMessage = null;
     
		try {
			if (request.getParameter("hdSubmit") != null)
					 {
				/*For insertion of record in database.*/
				 if(request.getParameter("hditemlist2").equalsIgnoreCase(""))
                {
                gsclubid=null;
                }
                else{                
				gsclubid = request.getParameter("hditemlist2");
				}
				
		
				
				 gsclubname = request.getParameter("txtassociation");
				 gsstateid = request.getParameter("hditemlist");
				 gszoneid = request.getParameter("hditemlist1");				
				 statename = request.getParameter("entry");
				 clubname = request.getParameter("entry1");
		 		 String flag = request.getParameter("hiddenval");
				 
				
  			  /*-------------------------- Added By Vishwajeet --------------------------------------------*/

  			    Vector lvFormsData = new Vector();
				Vector lvValidatorId = new Vector();
				Vector lvFieldName = new Vector();
  			     
				in.co.paramatrix.common.validator.DataValidator dv = (DataValidator)application.getAttribute("datavalidator");
				 
							
				lvFormsData.add(gsclubname);
				lvValidatorId.add("gsclubname");	
				lvFieldName.add("Association Name");	
				
				lvFormsData.add(statename);
				lvValidatorId.add("commonName");	
				lvFieldName.add("State");
				
				
				lvFormsData.add(clubname);
				lvValidatorId.add("commonName");	
				lvFieldName.add("Zone");
				
				lvFormsData.add(flag);
				lvValidatorId.add("flag");	
				lvFieldName.add("Club Status");	
				
				lvFormsData.add(gsstateid);
				lvValidatorId.add("id");	
				lvFieldName.add("State");	
				
				lvFormsData.add(gszoneid);
				lvValidatorId.add("id");	
				lvFieldName.add("Zone");
				
				serverMessage = validateData(lvValidatorId, lvFormsData, lvFieldName, dv);
		
		/***************************************************************************************/
		
				if(serverMessage.equals("")) {
					vparam.add(gsclubid);//
					vparam.add(gsclubname);//
					vparam.add(gsstateid);//		
					vparam.add(gszoneid);//
					vparam.add("2");//
					vparam.add(request.getParameter("hiddenval"));
					//vparam.add("A");
					crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
							"esp_amd_clubsmst", vparam, "ScoreDB");
					vparam.removeAllElements();
				}
			}
		

			vparam.add("1");
			crsObjResultState = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_statesval", vparam, "ScoreDB");
			vparam.removeAllElements();
			vparam.add("1");
			crsObjResultZone = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_zoneval", vparam, "ScoreDB");
			vparam.removeAllElements();
			vparam.add("0");
			crsObjClubsearch = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_clubsearch", vparam, "ScoreDB");
			vparam.removeAllElements();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		%>
<html>
<head>
<title>Club  Master</title>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
<script type="text/javascript">
  var flag="addDiv";
   var xmlHttp=null;
 

function callNextPage(str){
           if(str=="delete")
           {
           
           		var deleteconfirm = confirm("Do you want to delete the record.")
				if(deleteconfirm){
					 document.getElementById('hiddenval').value ="D";
				}else{
					return false 
				}
           
           
           
           }
           else{
            document.getElementById('hiddenval').value = "A";	
           }		
		    document.getElementById('hdSubmit').value = str;
		    
		    
		    if(str=="submit"){
		    if(textValidate()){
			document.regionMaster.action = "/cims/jsp/admin/ClubMaster.jsp";
			document.regionMaster.submit();	
			}
			}
			 if(str=="delete"&&document.getElementById('hditemlist2').value!="" ){ 
			document.regionMaster.action = "/cims/jsp/admin/ClubMaster.jsp";
			document.regionMaster.submit();	
			}
		
		}
		
		function textValidate(){
		 	var clubtxt=document.getElementById('txtassociation').value;
			if(clubtxt!=""){
			   if(document.getElementById('hditemlist').value!="")
			   {
				if(document.getElementById('hditemlist1').value!="")
				{				
				return true;				
				}
				else{
				alert("Selet zone");
				return false;
				}
				}
			   else{
			    alert("Select state");
				return false;
				}
			}else{
			    alert("Enter Club Name");
				return false;
			}
		 }
		
		
	
		 function selected(obj){
      	 var eleObjArr1=document.getElementById(obj).options;
		 if (eleObjArr1.length >= 1){
			 eleObjArr1[0].selected = true;
			 hideList();
		 }
		} 
		
			
		
	 function cancellation(){
	        document.getElementById('hditemlist1').value="";
	        document.getElementById('hditemlist').value="";
	        document.getElementById('hditemlist2').value="";
	        document.getElementById('itemlist1').value="";
	        document.getElementById('itemlist').value="";
	        document.getElementById('itemlist2').value="";
	 		document.getElementById('txtassociation').value="";
			document.getElementById('editRolediv7').style.display="none";
		
			document.getElementById('entry').value="";
	 		document.getElementById('entry1').value="";
	 		document.getElementById('entry2').value="";
	 		
					
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
        this.bldUpdate1 = bldUpdate1;
        this.bldUpdate2 = bldUpdate2;
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
      
      function bldUpdate(event) {
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList(event);
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
      if(event.keyCode  == 40)
       {
       selected("itemlist");
       }   
      }
      
      
         function bldUpdate1(event) {
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList1();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList1(event);
        var j = 0;
         str=str.replace("(","");
        str=str.replace(")","");
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
            document.forms[this.formname][this.selname].options.length = j;
       
        // If none of the options in the list meet the user's input, close list
        if (j==0) {
          hideList1();
        }
         if(event.keyCode  == 40)
       {
       selected("itemlist1");
       }   
      }
      
      
       function bldUpdate2(thisEvent) {
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList2();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList2(thisEvent);
        var j = 0;
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
        document.forms[this.formname][this.selname].options.length = j;
      
        // If none of the options in the list meet the user's input, close list
        if (j==0) {
          hideList2();
        }
        if(event.keyCode  == 40){
       		selected("itemlist2");
       }   
      }
      
     
   
      
      function setUp() {
        obj1 = new SelObj('regionMaster','itemlist','entry');
        obj1.bldInitial();
        obj2 = new SelObj('regionMaster','itemlist1','entry1');
        obj2.bldInitial();  
        obj3 = new SelObj('regionMaster','itemlist2','entry2');
        obj3.bldInitial(); 
      
      }
    
      function update(event) {
      	if(event.keyCode == 13 || event.keyCode == 0 || event.keyCode == 9 || event.button == 0 ){
	        document.regionMaster.entry.value = document.regionMaster.itemlist.options[document.regionMaster.itemlist.selectedIndex].text;
    	    document.getElementById("entry").focus();
    	    hideList();
    	    document.regionMaster.hditemlist.value=document.regionMaster.itemlist.value;
	    }else if(event.keyCode  == 27){
        	document.getElementById("lister").style.display="none";
        }        
      }
      
      
     function update1(event) {
    	 if(event.keyCode == 13 || event.keyCode == 0 || event.keyCode == 9 || event.button == 0 ){
	        document.regionMaster.entry1.value = document.regionMaster.itemlist1.options[document.regionMaster.itemlist1.selectedIndex].text;
	        if(document.getElementById("entry1")){
    	    	document.getElementById("entry1").focus();
	        }
    	    hideList1();
    	    document.regionMaster.hditemlist1.value=document.regionMaster.itemlist1.value;
    	     }
    	  if(event.keyCode  == 27){
         document.getElementById("lister1").style.display="none";
        }        
      }

      function update2(thisEvent) {
    	  if(thisEvent.keyCode == 13 || thisEvent.keyCode == 0 || thisEvent.button == 0 || thisEvent.keyCode == 9){
      		document.regionMaster.entry2.value = document.regionMaster.itemlist2.options[document.regionMaster.itemlist2.selectedIndex].text;
	       	if(document.getElementById("entry2")){
	 	    	document.getElementById("entry2").focus();
	       	}
	 	    document.regionMaster.hditemlist2.value=document.regionMaster.itemlist2.value;
	 	    hideList2();
	 	 } else if(thisEvent.keyCode  == 27){
	      	document.getElementById("lister2").style.display="none";
	 	 }
     }
     
		function showList(event) {
			if(event.keyCode == 40 || event.button==0){
		        document.getElementById("lister").style.display="block";
		        document.getElementById("itemlist").focus();
			}else if(event.keyCode  == 27){
		         document.getElementById("lister").style.display="none";
	        }
		    if(document.getElementById("itemlist").value=="0" ||document.getElementById("itemlist").value==""||event.keyCode  == 0){
	        	document.getElementById("lister").style.display="block";
	        }
			document.regionMaster.hditemlist.value=document.regionMaster.itemlist.value;
		}
   
     
     function showList1(event) {      
      if(event.keyCode  == 40)
      {
        document.getElementById("lister1").style.display="block";
        document.getElementById("itemlist1").focus();
        }        
        if(document.getElementById("itemlist1").value=="0" ||document.getElementById("itemlist1").value==""||event.keyCode  == 0)
        {
         document.getElementById("lister1").style.display="block";
        }
        if(event.keyCode  == 27){
         document.getElementById("lister1").style.display="none";
        }
         document.regionMaster.hditemlist1.value=document.regionMaster.itemlist1.value;
      }
   
   
        function showList2(event) {
            if(event.keyCode == 27){
	        	document.getElementById("lister2").style.display="none";
	        }else if(event.keyCode == 40 || event.keyCode == 9 || event.keyCode == 13 || event.button==0){
		        document.getElementById("lister2").style.display="block";
		        document.getElementById("itemlist2").focus();
	        }else if(document.getElementById("itemlist2").value=="0" ||document.getElementById("itemlist2").value==""|| event.keyCode == 0){
	        	document.getElementById("lister2").style.display="block";
	        }
	        
		}
      
    
      
      function hideList() {       
        document.getElementById("lister").style.display="none";	
       
      }
        function hideList1() {       
        document.getElementById("lister1").style.display="none";	
      
      }
      
       function hideList2() {
        document.getElementById("lister2").style.display="none";
        document.getElementById("hiddenval1").value="club";	
        xmlHttp = GetXmlHttpObject();
        var valName=document.regionMaster.itemlist2.value;
        //alert(valName)
        if(valName!=""){
	        var url = "/cims/jsp/admin/ClubSearchfromcombo.jsp?ClubId="+valName+"&response=search";
			xmlHttp.onreadystatechange = displayData;
			xmlHttp.open("get",url,false);
			xmlHttp.send(null);
			
		}
      }
      
    
      
      

function GetXmlHttpObject(){
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
    function displayData(){
	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
		   var responseResult = xmlHttp.responseText ;
   		      try //Internet Explorer
			  {
   				if (window.ActiveXObject){  
   		    		xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
   		    		xmlDoc.async="false";
   				  	xmlDoc.loadXML(responseResult);
   				}else{
   		    		xmlDoc = document.implementation.createDocument("","",null);
   				}	  
			   if(document.getElementById("hiddenval1").value=="club")
			   {
			 var mess=responseResult.split("<br>");
			//document.getElementById("itemlist2").value = mess[0];//xmlDoc.getElementsByTagName("ID")[0].childNodes[0].nodeValue;             
            document.getElementById("txtassociation").value = mess[1]//xmlDoc.getElementsByTagName("Name")[0].childNodes[0].nodeValue;             
            document.getElementById("entry").value = mess[4]//xmlDoc.getElementsByTagName("Statename")[0].childNodes[0].nodeValue;           
			document.getElementById("entry1").value = mess[5]//xmlDoc.getElementsByTagName("Zonename")[0].childNodes[0].nodeValue;
			document.getElementById("hditemlist").value = mess[2]//xmlDoc.getElementsByTagName("State")[0].childNodes[0].nodeValue;           
			document.getElementById("hditemlist1").value = mess[3]//xmlDoc.getElementsByTagName("Zone")[0].childNodes[0].nodeValue;
		    document.getElementById("hiddenval1").value="null";
		  } 
		   if(document.getElementById("hiddenval3").value=="page")
			   {
			     var mdiv=document.getElementById("pagingpages");
		        mdiv.innerHTML=responseResult;
			   }		    
	
			  }
			catch(e)
			  {
			  	alert(e.message);
			  }
		}
		
		 
  }	
  
    function changeList(event) {
        if (document.getElementById("lister").style.display=="none"){
          showList(event);
        }else{
          hideList();
        }
	}	
  
    function changeList1(event) {
        if (document.getElementById("lister1").style.display=="none"){
          showList1(event);
        }else{
          hideList1();
        }  
    }	

    function changeList2(event) {
        if (document.getElementById("lister2").style.display=="none"){
        	showList2(event);
        }else{
        	hideList2();
        }
    }	
      
      
    function showrecord(){
       if (document.getElementById("paging").style.display=="none"){
          document.getElementById("paging").style.display="block";
          document.getElementById("hiddenval3").value="page";      
       		xmlHttp = GetXmlHttpObject();
        var valName=document.getElementById("hdpage").value;
         var status=document.getElementById("status").value;
       if(valName!="0"){
        var url = "/cims/jsp/admin/ClubSearchfromcombo.jsp?pageid="+valName+"&response=page"+"&status="+status;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
       document.getElementById("hiddenval3").value="";
      }
      }  
        else
          document.getElementById("paging").style.display="none";
      }
      
  
     function nextpage(obj){    
     if(obj=="increase")
      document.getElementById("hdpage").value=eval(document.getElementById("hdpage").value)+1;
     else{
     if(document.getElementById("hdpage").value!="1")
       document.getElementById("hdpage").value=eval(document.getElementById("hdpage").value)-1;
     }
      
       document.getElementById("hiddenval3").value="page";      
       xmlHttp = GetXmlHttpObject();
        var valName=document.getElementById("hdpage").value;
         var status=document.getElementById("status").value;
       if(valName!="0"){
        var url = "/cims/jsp/admin/ClubSearchfromcombo.jsp?pageid="+valName+"&response=page"+"&status="+status;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
       document.getElementById("hiddenval3").value="";
  }  
  }
      
 function setmode()
 {
 document.getElementById("hdpage").value="0";
 }
 // to change textfield color		
			function changeColour(which) {
				if (which.value.length > 0) {   // minimum 2 characters
					which.style.background = "#FFFFFF"; // white
				}
				else {
					which.style.background = "";  // yellow
					//which.focus();
					//return false;
				}
			}	
      
</script>
</head>
<body OnLoad="javascript:setUp()">
<div class="container">
<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="regionMaster" id="regionMaster" method="post">

<%--  ------------------------Added By Vishwajeet --------------------------------------------%>
<%
			if(serverMessage != null && !serverMessage.equals("")) {

%>
						<center><font color=red>Supplied data is invalid for following fields  <%=serverMessage%>.</font></center>
<%
			}							
%>
<br>
<%-- --------------------------------------------------------------------------------------------%>

<div class="leg">Association Master</div>
<%--          Club Master--%>
	<table width="100%" border="0" align="center" cellpadding="2"
				cellspacing="1" class="table">
		
		<tr>
		     <td class="portletContainer">

<div id="editRolediv7" style="display: block;">
<%				if (crsObjResult != null) {
					while (crsObjResult.next()) {
%>				<table width="100%"  align="center" border="0"	id="displayResult" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td class="message"><%=crsObjResult.getString("RetVal")%></td>
					</tr>
				</table>
<%					}
				}
%>			</div>

		         <fieldset><legend class="legend1">Association Details</legend> <br>
				<table width="90%" border="0" align="center" cellpadding="2"
					cellspacing="1" class="table" >
		
<%--	search	----%>
			<tr align="left" class="contentDark">
				<td >
				 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search
				</td>
				<td>
				<input class="textBoxAdminSearch" type="text" name="entry2" size="40" onkeyup="javascript:obj3.bldUpdate2(event);">				
				 <input class="btn btn-small"	id="show" type="button" value="V" onClick="changeList2(event);">
								<DIV align="left" style="width:250px">
				<DIV id="lister2" style="display:none;position:absolute;z-index:+10;">
				<select class="inputsearch" style="width:7.3cm" id="itemlist2" name="itemlist2" size="5"
					onclick="update2(event)" onkeypress="update2(event)">					
                  	<%while (crsObjClubsearch.next()) {
			        %>
					<OPTION value="<%=crsObjClubsearch.getString("id")%>"><%=crsObjClubsearch.getString("name")%></OPTION>
					<%}%>
				</select></DIV>
				</DIV>
				</td>

			</tr>
			<tr width="90%" class="contentLight">
				<td nowrap="nowrap">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Association Name:</td>
				<td><input class="textBoxAdmin" type="text" name="txtassociation" id="txtassociation" size="40"  onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');"  value="" maxlength="50" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)"></td>
			</tr>
			<tr width="90%" class="contentDark">
				<td >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;State:
				</td>
				<td>
				<input class="textBoxAdmin" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" type="text" id="entry"	name="entry" size="35" onKeyUp="javascript:obj1.bldUpdate(event);"> 
				
				 <input class="btn btn-small"	id="show" type="button" value="V" onClick="changeList(event);">
			

				<DIV align="left" style="width:250px">
				<DIV id="lister" style="display:none;position:absolute;z-index:+10;">
				<select  class="inputField" style="width:6.5cm" id="itemlist" name="itemlist" size="5"
				onclick="update(event)"	onkeypress="update(event)">
                  
					<%while (crsObjResultState.next()) {
			        %>
					<OPTION value="<%=crsObjResultState.getString("id")%>"><%=crsObjResultState.getString("name")%></OPTION>
					<%}
					crsObjResultState.beforeFirst();
					%>

				</select></DIV>
				</DIV>
				</td>

			</tr>
			
<%--	state end		----%>
<%--	zone		----%>
			<tr width="90%" class="contentLight">
				<td >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Zone:
				</td>
				<td>
				<input class="textBoxAdmin" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" type="text" id="entry1" name="entry1" size="35" onKeyUp="javascript:obj2.bldUpdate1(event);">				
				 <input class="btn btn-small"	id="show" type="button" value="V" onClick="changeList1(event);">

				<DIV align="left" style="width:250px">
				<DIV id="lister1" style="display:none;position:absolute;z-index:+10;">
				<select class="inputField" style="width:6.5cm" id="itemlist1" name="itemlist1" size="5"
				onclick="update1(event)"	onkeypress="update1(event)">

				<%
		  while (crsObjResultZone.next()) {
			%>
					<OPTION value="<%=crsObjResultZone.getString("id")%>"><%=crsObjResultZone.getString("name")%></OPTION>
					<%}%>
				</select></DIV>
				</DIV>
				</td>

			</tr>
			
<%--     zone end     ----%>
			<tr width="100%" align="right" class="contentDark">
				<td colspan="2"align="right">
					<input  class="btn btn-warning" type="button" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callNextPage('submit')"> 
					<input  class="btn btn-warning" type="button" id="btnCancel" name="btnCancel" value="Reset" 	onclick="cancellation()">
					<input  class="btn btn-warning" type="button" id="btnDelete" name="btnDelete" value="Delete"  onclick="callNextPage('delete')">
					<input class="btn btn-warning"  type="button" id="page" name="page"value="Records" onclick="showrecord()"> 
					<input type="hidden" id="hdSubmit"	name="hdSubmit" value=""></td>
					<input type="hidden" id="hiddenval" name="hiddenval" value=""/>
					<input type="hidden" id="hiddenval1" name="hiddenval1" value=""/>
					<input type="hidden" id="hiddenval2" name="hiddenval2" value="null"/>		   
					<input type="hidden" id="hditemlist" name="hditemlist" value=""/>		  		   
					<input type="hidden" id="hditemlist1" name="hditemlist1" value=""/>		  		  		   
					<input type="hidden" id="hditemlist2" name="hditemlist2" value=""/>
					<input type="hidden" id="hiddenval3" name="hiddenval3" value=""/>
					<input type="hidden" id="hdpage" name="hdpage" value="1"/>
				</td>	
			</tr>
		</table>
		<br>
		</fieldset>
			
		</td>
	</tr>
	
</TABLE>
<br>
<br>

      	
	<TABLE  align="center" width="60%">
	<tr>
	<td>
	 <div  id="paging"  style="display: none;">
	<input class="button" type="button" id="back" name="back" value="Back  "  onclick="nextpage('decrease');"/>
    <input class="button"  type="button" id="next" name="next" value="Next  " onclick="nextpage('increase');"> 
	<SELECT class="input"  id="status" name="status" onchange="setmode()">
	<option value="A" >Present Records </option>
	<option value="D" >Deleted Records</option>
	</SELECT>
	<div id="pagingpages"  style="display: block">
	</div>
	</div>
	</td>
	</tr>
	</TABLE>
</form>
</div>
<jsp:include page="Footer.jsp"></jsp:include>
</body>

</html>
