<!--
Page Name: TeamMaster.jsp
Author 		 : Swapnilg.
Created Date : 21th Sep 2008
Description  : Selection of Team 
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
<%
        CachedRowSet crsObjResult = null;
		CachedRowSet crsObjResultClub = null;
		CachedRowSet crsObjResultcombo = null;
		Vector vparam = new Vector();
		String gsteamId=null;
		String gsteamName=null;
		String gsClub =null;
		String gsTeamLoc =null;
		String gsTeamDesc =null;
		String gsNikname =null;
    	String serverMessage = null;

		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		try {
			if (request.getParameter("hiddenval") != null
					&& request.getParameter("hiddenval").equals("submit")) {
				/*For insertion of record in database.*/
				  if(request.getParameter("hditemlist1")=="")
                {
                gsteamId=null;
                }
                else{                
				gsteamId = request.getParameter("hditemlist1");
				}							
				 gsteamName = request.getParameter("teamname");
				 gsNikname = request.getParameter("teamnikname");
				 gsClub = request.getParameter("hditemlist");				
				 gsTeamLoc = request.getParameter("teamloc");
				 gsTeamDesc = request.getParameter("teamdis");
				 String flag = request.getParameter("hiddenval1");
				 
				
				 
		/*-------------------------- Added By Vishwajeet --------------------------------------------*/

 			    Vector lvFormsData = new Vector();
				Vector lvValidatorId = new Vector();
				Vector lvFieldName = new Vector();
  			     
				in.co.paramatrix.common.validator.DataValidator dv = (DataValidator)application.getAttribute("datavalidator");
				 							
								
				lvFormsData.add(gsteamName);
				lvValidatorId.add("gsteamName");	
				lvFieldName.add("Team Name");	
				
				lvFormsData.add(gsNikname);
				lvValidatorId.add("gsNikname");	
				lvFieldName.add("Team Abbreviation");
				
				lvFormsData.add(gsClub);
				lvValidatorId.add("id");	
				lvFieldName.add("Club");
				
				lvFormsData.add(flag);
				lvValidatorId.add("flag");	
				lvFieldName.add("Team Status");	

				lvFormsData.add(gsTeamLoc);
				lvValidatorId.add("commonName");	
				lvFieldName.add("Team Location");
				
				lvFormsData.add(gsTeamDesc);
				lvValidatorId.add("gsTeamDesc");	
				lvFieldName.add("Description");
				
				serverMessage = validateData(lvValidatorId, lvFormsData, lvFieldName, dv); 
		
		/***************************************************************************************/
		
				if(serverMessage.equals("")) {
					vparam.add(gsteamId);
					vparam.add(gsteamName);//
					vparam.add(gsNikname);//
					vparam.add(gsClub);//		
					vparam.add(gsTeamLoc);//
					vparam.add(gsTeamDesc);//
					vparam.add(request.getParameter("hiddenval1"));
					crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_amd_teamsmst", vparam, "ScoreDB");
					vparam.removeAllElements();
				}
			}

			vparam.add("0");
			crsObjResultcombo = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_teamsearch", vparam, "ScoreDB");
			vparam.removeAllElements();

			vparam.add("1");
			crsObjResultClub = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_clubval", vparam, "ScoreDB");
			vparam.removeAllElements();
			vparam.add("1");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
%>

<html>
<head>
<title>Team Master</title>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
<script type="text/javascript">

   var xmlHttp=null;
   function callNextPage(id){
    		document.getElementById('hiddenval').value = "submit";      	    
    		document.getElementById('hiddenval1').value = id;
			document.teamMaster.action = "/cims/jsp/admin/TeamMaster.jsp";
			if(id=="D"&&document.getElementById('hditemlist1').value!="")
			{
			var deleteconfirm = confirm("Do you want to delete the record.")
				if(deleteconfirm){
					document.teamMaster.submit();
				}else{
					return false 
				}
			
			
			
			}
			if(id=="A"){		
			if(textValidate()){			
			document.teamMaster.submit();
			}
			}			
		}	
	 function cancellation(){
	        document.getElementById('entry1').value="";
	         document.getElementById('hditemlist1').value="";
	         document.getElementById('hditemlist').value="";
	        document.getElementById('itemlist1').value="";
	         document.getElementById('itemlist').value="";
	 		document.getElementById('teamname').value="";
	 		document.getElementById('teamloc').value="";
	 		document.getElementById('teamdis').value="";
	 		document.getElementById('teamnikname').value="";
			document.teamMaster.action = "/cims/jsp/admin/TeamMaster.jsp";	
			document.getElementById('entry').value="";			
	        document.getElementById("lister").style.display="none"; 
	        document.getElementById("lister1").style.display="none";
	        document.getElementById("editRolediv7").style.display="none";
		}	
		
	
	
	 function textValidate(){
		 	var Teamtxt=document.getElementById('teamname').value;
		 	var Teamnik=document.getElementById('teamnikname').value;
		 	var Teamloc=document.getElementById('teamloc').value;
		 	var Teamdsc=document.getElementById('teamdis').value;
	        var alphaExp1 = /^[a-zA-Z ]+$/; 
	        var mess ="Pease enter the followind details\n";
	        var flag ="true";
				if(Teamtxt==""){
				mess =mess+"Team Name\n";
				flag ="false";
				}
				if(Teamnik==""){
				mess =mess+"Abbreviation\n";
				flag ="false";
				}
			   if(document.getElementById('hditemlist').value=="")
			   {
			   mess =mess+"Select Club\n";
			   flag ="false";
			   }
				if(!Teamloc.match(alphaExp1))
				{
				 mess =mess+"Team Location should be in alphabet\n";
			   flag ="false";
				}
				if(Teamdsc=="")
				{
				 mess =mess+"Description\n";
			   flag ="false";				
			   }
			   
			   if(flag=="true")
				{				
				return true ;				
			  }else{
			  alert(mess);
			   return false ;
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
        this.bldUpdate1 = bldUpdate1; 
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
        if(event.keyCode == 40)
       {
       selected("itemlist");
       }   
      }
      
      
      function selected(obj){
      	 var eleObjArr1=document.getElementById(obj).options;
		 if (eleObjArr1.length >= 1){
		 eleObjArr1[0].selected = true;
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
        // If only one option meets the user's entry, select it, put the text in the field,
        // and close the list.
      
        // If none of the options in the list meet the user's input, close list
        if (j==0) {
          hideList1();
        }
         if(event.keyCode == 40)
       {
       selected("itemlist1");
       }   
      }
         
      
      function setUp() {
        obj1 = new SelObj('teamMaster','itemlist','entry');
        obj2 = new SelObj('teamMaster','itemlist1','entry1'); 
        obj1.bldInitial(); 
        obj2.bldInitial();
      }
      <!-- Functions Below Added by Steven Luke -->
    function update(event) {
    	if(event.keyCode == 13 || event.keyCode == 0 || event.keyCode == 9 || event.button == 0 ){
	        document.teamMaster.entry.value = document.teamMaster.itemlist.options[document.teamMaster.itemlist.selectedIndex].text;
    	    document.getElementById("entry").focus();
    	    hideList();
    	    document.teamMaster.hditemlist.value=document.teamMaster.itemlist.value;
    	     }
    	  if(event.keyCode == 27){
         document.getElementById("lister").style.display="none";
         document.teamMaster.hditemlist.value=document.teamMaster.itemlist.value;
        }
        
      }
        function update1(event) {
        	if(event.keyCode == 13 || event.keyCode == 0 || event.keyCode == 9 || event.button == 0 ){
	        document.teamMaster.entry1.value = document.teamMaster.itemlist1.options[document.teamMaster.itemlist1.selectedIndex].text;
    	    document.getElementById("entry1").focus();
    	    hideList1();
    	    document.teamMaster.hditemlist1.value=document.teamMaster.itemlist1.value;
    	     }
    	  if(event.keyCode == 27){
         document.getElementById("lister1").style.display="none";
        }
        
      }
      
     function showList(event) {
      document.teamMaster.hditemlist.value=document.teamMaster.itemlist.value;
      if(event.keyCode == 40)
      {
        document.getElementById("lister").style.display="block";
        document.getElementById("itemlist").focus();
        }        
        if(document.getElementById("itemlist").value=="0" ||document.getElementById("itemlist").value==""||event.keyCode == 0)
        {
         document.getElementById("lister").style.display="block";
        }
        if(event.keyCode == 27){
         document.getElementById("lister").style.display="none";
        }
      }
      
      
       function showList1(event) {
      if(event.keyCode == 40)
      {
        document.getElementById("lister1").style.display="block";
        document.getElementById("itemlist1").focus();
        }        
        if(document.getElementById("itemlist1").value=="0" ||document.getElementById("itemlist1").value==""||event.keyCode == 0)
        {
         document.getElementById("lister1").style.display="block";
        }
        if(event.keyCode == 27){
         document.getElementById("lister1").style.display="none";
        }
      }
     
      function hideList() {
        document.teamMaster.hditemlist.value=document.teamMaster.itemlist.value;
        document.getElementById("lister").style.display="none";	
      
      }
    
       function hideList1() {      
       document.getElementById("hiddenval2").value="search";
        document.getElementById("lister1").style.display="none";	
        xmlHttp = GetXmlHttpObject();
        var valName=document.teamMaster.itemlist1.value;
       if(valName!=""){
        var url = "/cims/jsp/admin/TeamMasterfromcombo.jsp?TeamId="+valName+"&response=search";
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);      
       }
        document.getElementById("hiddenval2").value="";
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
   		    	   				  
			  if(document.getElementById("hiddenval2").value=="search"){
			    var mess=responseResult.split("<br>");
			document.getElementById("hditemlist").value = mess[2]           
            document.getElementById("teamname").value =  mess[1]            
            document.getElementById("entry").value =  mess[3]          
			document.getElementById("teamloc").value =  mess[5]			
            document.getElementById("teamdis").value = mess[4] 
		     document.getElementById("teamnikname").value = mess[6]
		     }
		     if(document.getElementById("hiddenval2").value=="page"){
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
        if (document.getElementById("lister").style.display=="none")
          showList(event);
        else
          hideList();
      }	

function changeList1(event) {
        if (document.getElementById("lister1").style.display=="none")
          showList1(event);
        else
          hideList1();
      }	
      
   function showrecord()
      {         
       if (document.getElementById("paging").style.display=="none")
       {
          document.getElementById("paging").style.display="block";
           document.getElementById("hiddenval2").value="page";
         xmlHttp = GetXmlHttpObject();
        var valName=document.getElementById("hdpage").value;
         var status=document.getElementById("status").value;
       if(valName!="0"){
        var url = "/cims/jsp/admin/TeamMasterfromcombo.jsp?pageid="+valName+"&response=page"+"&status="+status;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
       document.getElementById("hiddenval2").value="";
       }
       }
        else
          document.getElementById("paging").style.display="none";
      }
      
  
     function nextpage(obj){
     if(obj=="increase")
      document.getElementById("hdpage").value=eval(document.getElementById("hdpage").value)+1;
     else{
     if(document.getElementById("hdpage").value!="1"){
       document.getElementById("hdpage").value=eval(document.getElementById("hdpage").value)-1;
       }
     }
       document.getElementById("hiddenval2").value="page";
       xmlHttp = GetXmlHttpObject();
        var valName=document.getElementById("hdpage").value;
         var status=document.getElementById("status").value;
       if(valName!="0"){
        var url = "/cims/jsp/admin/TeamMasterfromcombo.jsp?pageid="+valName+"&response=page"+"&status="+status;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
       document.getElementById("hiddenval2").value="";
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
				//alert ("This box must be filled!");
				//which.focus();
				//return false;
			}
		}

	</script>
</head>
<body OnLoad="javascript:setUp()">
<div class="container">
<jsp:include page="Menu.jsp"></jsp:include>
<br>
<FORM name="teamMaster" id="teamMaster" method="post"><br>
<br>
<%--  ------------------------Added By Vishwajeet --------------------------------------------%>
<%
			if(serverMessage != null && !serverMessage.equals("")) {

%>
						<center><font color=red>Supplied data is invalid for following fields  <%=serverMessage%>.</font></center>
<%
	}							
%>
<div class="leg">Team Master</div>
<%--    Team Master--%>
<div class="portletContainer">
<%-- --------------------------------------------------------------------------------------------%>
<table width="100%" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
	<tr>
		<td>
				<div id="editRolediv7" style="display: block;">
		<%if (crsObjResult != null) {
			while (crsObjResult.next()) {
				%>

		<table width="100%" height="100%" align="center" border="0"
			id="displayResult" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td class="message"><%=crsObjResult.getString("RetVal")%></td>
			</tr>
			
		</table>
		<% }
		}
	%></div>
		</td>
	</tr>
	<tr>
		<td>
		<fieldset><legend class="legend1">Team Details
		</legend> <br>
		
		<table width="90%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table" >


			<tr align="left" class="contentDark">
				<td >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search:
				</td>
				<td>
				<div id="editRolediv2" style="display: block;">
				<input class="textBoxAdminSearch" class="inputsearch" id="entry1"	name="entry1" size="50" onKeyUp="javascript:obj2.bldUpdate1(event);">
				  <input class="btn btn-small"	id="show" type="button" value="V" onClick="changeList1(event);">
                    
				</div>

				<DIV align="left" style="width:250px">
				<DIV id="lister1" 
					style="display:none;position:absolute;z-index:+10;">
					<select   style="width:10cm" class="inputsearch" id="itemlist1" name="itemlist1" size="5"  onclick="update1(event)" onkeypress="update1(event)">					
				 
					<%while (crsObjResultcombo.next()) {

			%>
					<option value="<%=crsObjResultcombo.getString("id")%>"><%=crsObjResultcombo.getString("team_name")%></option>
					<%
		    }
		  %>

				</select></DIV>
				</DIV>
				</td>

			</tr>
			<tr width="90%" class="contentLight">
				<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Team Abbreviation :</td>
				<td><input  class="textBoxAdmin" size="20%" type="text" id="teamnikname"" name="teamnikname" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');"  onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" value="" maxlength="16"  /> (Not more than 16 charactar)</td>
			</tr>
			
			<tr width="90%" class="contentDark">
				<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Team Name :</td>
				<td><input  class="textBoxAdmin" size="50%" type="text" id="teamname" name="teamname" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');" value="" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)"  /></td>
			</tr>
			
			<tr width="90%" class="contentLight">
				<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Association :</td>
				<td><input type="text" class="textBoxAdmin" id="entry" name="entry" size="50"
					onKeyUp="javascript:obj1.bldUpdate(event);" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)"> 
					 <input class="btn btn-small"	id="show" type="button" value="V" onClick="changeList(event);">
                    
				<DIV align="left" style="width:250px">
				<DIV id="lister" style="display:none;position:absolute;z-index:+10;">
				<select  style="width:10cm" class="input"  id="itemlist" name="itemlist" size="5"
				 onclick="update(event)"	onkeypress="update(event)">
				 
					<%while (crsObjResultClub.next()) {
			%>

					<option value="<%=crsObjResultClub.getString("id")%>"><%=crsObjResultClub.getString("name")%></option>
					<%
		}
		%>

				</select></DIV>
				</DIV>
				</td>

			<tr width="90%" class="contentDark">
			
				<td nowrap="nowrap" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Team Location :</td>
				<td><input class="textBoxAdmin"  size="40%" type="text" id="teamloc" name="teamloc" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');"  maxlength="40" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" /></td>
			</tr>		
			
			<tr width="90%" class="contentLight">
				<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Description:</td>
				<td><input class="textBoxAdmin" size="40%" type="text" id="teamdis" name="teamdis" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');"  value=""  maxlength="350" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" /></td>
			</tr>
			<tr width="100%" align="right" class="contentDark">
				<td colspan="2">
				<input class="btn btn-warning"  type="button" id="btnsubmit" name="btnsubmit"value="Submit" onclick="callNextPage('A')"> 
				<input class="btn btn-warning"  type="button" id="btnCancel" name="btnCancel" value="Reset"  onclick="cancellation()">
                  <input class="btn btn-warning" type="button" id="btnDelete" name="btnDelete" value="Delete"onclick="callNextPage('D')"/>
                  	<input class="btn btn-warning"  type="button" id="page" name="page"value="Records" onclick="showrecord()"> 
                  <input type="hidden" id="hiddenval" name="hiddenval" value="">
                   <input type="hidden" id="hiddenval1" name="hiddenval1" value=""/>  
                   <input type="hidden" id="hiddenval2" name="hiddenval2" value=""/>                   
                   <input type="hidden" id="hditemlist" name="hditemlist" value=""/>                                     
                   <input type="hidden" id="hditemlist1" name="hditemlist1" value=""/>                                                       
                   <input type="hidden" id="hdpage" name="hdpage" value="1"/>
                  </td>
			</tr>
		</table>
		<br>
		</fieldset>
<%--		<table align="right" border="0" id="buttonRolemaster">--%>
<%--			--%>
<%--		</table>--%>
		

	
	<div id="paging"  style="display: none;">
	<input class="button" type="button" id="back" name="back" value="Back  "  onclick="nextpage('decrease');"/>
    <input class="button"  type="button" id="next" name="next" value="Next  " onclick="nextpage('increase');"> 
	
	<SELECT class="input"  id="status" name="status" onchange="setmode()">
	<option value="A" >Present Records </option>
	<option value="D" >Deleted Records</option>
	</SELECT>
	<div id="pagingpages"  style="display: block">
	</div>
	</div>
		</table>
		</div>
		</form>
</body>
</div>
<jsp:include page="Footer.jsp"></jsp:include>
</html>

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
	

