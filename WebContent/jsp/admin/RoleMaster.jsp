<!--
Page Name:   RoleMaster.jsp
Author 		 : Swapnilg.
Created Date : 16th Sep 2008
Description  : Selection of Series 
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
<%@ page import="in.co.paramatrix.common.authz.AuthZ"%>
<%@ page import="in.co.paramatrix.common.exceptions.*"%>
<%@ page import="in.co.paramatrix.common.exceptions.InternalError"%>

<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
		
		String authz_message = "";
        CachedRowSet crsObjResult                = null;
		CachedRowSet crsObjResultcombo           = null;
		Vector vparam                            = new Vector();
		String gsrlId                            = null;
		String gsrlName                          = null;
		String gsDescription                     = null;
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		String serverMessage = null;
		    	
		try {
			if (request.getParameter("hiddenval") != null
					&& request.getParameter("hiddenval").equals("submit")) {
				/*For insertion of record in database.*/
                if(request.getParameter("hditemlist").equals(""))
                {
                gsrlId=null;
                }
                else{                
				gsrlId = request.getParameter("hditemlist");
				}
				
				
				gsrlName = request.getParameter("rlname");
				gsDescription = request.getParameter("rldescription");
			    String flag = request.getParameter("hiddenval1");
				
 			    /*-------------------------- Added By Vishwajeet --------------------------------------------*/

 			    Vector lvFormsData = new Vector();
				Vector lvValidatorId = new Vector();
				Vector lvFieldName = new Vector();
  			     
				in.co.paramatrix.common.validator.DataValidator dv = (DataValidator)application.getAttribute("datavalidator");
								
				lvFormsData.add(gsrlName);
				lvValidatorId.add("gsrlName");	
				lvFieldName.add("Name");	
				
				lvFormsData.add(gsDescription);
				lvValidatorId.add("gsDescription");	
				lvFieldName.add("Description");
				
				lvFormsData.add(flag);
				lvValidatorId.add("flag");	
				lvFieldName.add("Role Status");	
							
				serverMessage = validateData(lvValidatorId, lvFormsData, lvFieldName, dv); 
				
			/***************************************************************************************/
 				if(serverMessage.equals("")) {
					vparam.add(gsrlId);//
					vparam.add(gsrlName);//
					vparam.add(gsDescription);//		
					vparam.add("2");
					vparam.add(request.getParameter("hiddenval1"));  //
					
					crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
							"esp_amd_rolemst", vparam, "ScoreDB");
					vparam.removeAllElements();
				}
				
				try{
					AuthZ.getInstance().addRole(gsrlName);
					authz_message = gsrlName + " role added in authz";
				}catch(EntityDestroyed e){
					authz_message = e.getMessage();
				}catch(DuplicateEntity e){
					authz_message = e.getMessage();
				}catch(InvalidEntity e){
					authz_message = e.getMessage();
				}catch(LimitCrossed e){
					authz_message = e.getMessage();
				}catch(InternalError e){
					authz_message = e.getMessage();
				}
			}
			vparam.add("1");
			crsObjResultcombo = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_rolesearch", vparam, "ScoreDB");

		} catch (Exception e) {
			e.printStackTrace();
		}

		%>
<html>
<head>
<title>Role Master</title>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
 <script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
<script type="text/javascript">
   
    var xmlHttp=null;
  
     
   function callNextPage(id){
    		document.getElementById('hiddenval').value = "submit";
    		document.getElementById('hiddenval1').value = id;
    		document.menuform.action = "/cims/jsp/admin/RoleMaster.jsp";
    		
			if(id=="D"&&document.getElementById('itemlist').value!="")
			{
			
			var deleteconfirm = confirm("Do you want to delete the record.")
				if(deleteconfirm){
					document.menuform.submit();
				}else{
					return false 
				}
			
			
			}
			if(id=="A"){
			if(textValidate()){
			document.menuform.submit();
			}
			}			
		}	
		 
	 function textValidate(){
		 	var roletxt=document.getElementById('rlname').value;
		 	var roledisc=document.getElementById('rldescription').value;
	        var alphaExp1 = /^[a-zA-Z ]+$/; 
		 	
			if(roletxt.match(alphaExp1))
			   { 
				
				if(roledisc!="")
				{
				return true;
				}
				else{
				 alert("Enter some Description ");
				return false;
				}
				
			}else{
			 if(roletxt=="")
			    {
			      if(roletxt==""&& roledisc=="")
			    {
			      alert("Enter All Records");
			    }else{
			     alert("Enter Role Name");
			    }
			    }
			   else{
			     alert("Rolename should contain alphabets ");
				return false;
				}
			
			  
			}
		 }
		
		
		

	  function cancellation() {
	         document.getElementById("rolesearchtxt").value="";
	         document.getElementById("itemlist").value="";	         
	         document.getElementById("hditemlist").value="";
	         document.getElementById("rlname").value="";
	 		 document.getElementById('rldescription').value="";            
             document.getElementById("editRolediv7").style.display = "none";
			 document.menuform.action = "/cims/jsp/admin/RoleMaster.jsp";			
		}
	
	 function selected(obj){
      	 var eleObjArr1=document.getElementById(obj).options;
		 if (eleObjArr1.length >= 1){
		 eleObjArr1[0].selected = true;
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
      	try {
	    	if (window.ActiveXObject){  
	    		xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
	    		xmlDoc.async="false";
	    		xmlDoc.loadXML(responseResult);
	    	}else{
	    		xmlDoc = document.implementation.createDocument("","",null);
	    	}
		   	var mess=responseResult.split("<br>");
            document.getElementById("rlname").value =mess[1]// xmlDoc.getElementsByTagName("Name")[0].childNodes[0].nodeValue;            
            document.getElementById("rldescription").value =mess[2]; //xmlDoc.getElementsByTagName("Description")[0].childNodes[0].nodeValue;   
		}catch(e){
		  alert(e.message);
		  }
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
      
      
    function setUp() {
        obj1 = new SelObj('menuform','itemlist','rolesearchtxt');
        obj1.bldInitial(); 
    }

	function update(event) {
		if(event.keyCode == 13 || event.keyCode == 0 || event.keyCode == 9 || event.button == 0 ){
	        document.menuform.rolesearchtxt.value = document.menuform.itemlist.options[document.menuform.itemlist.selectedIndex].text;
    	    document.getElementById("rolesearchtxt").focus();
    	    hideList();
    	    document.menuform.hditemlist.value=document.menuform.itemlist.value;
		}else if(event.keyCode == 27){
         	document.getElementById("lister").style.display="none";
        }
	}
      
      
      function showList(event) {
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
      
      function hideList() {
        document.getElementById("lister").style.display="none";	
        xmlHttp = GetXmlHttpObject();
        var valName=document.menuform.itemlist.value;
        if(valName!="")
        {
        var url = "/cims/jsp/admin/RoleMaterfromcombo.jsp?Roleid="+valName;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
      }
      }
      
      
       function changeList(event) {
        if (document.getElementById("lister").style.display=="none")
          showList(event);
        else
          hideList();
      }	
      
     // to change textfield color		
		function changeColour(which) {
			if (which.value.length > 0) {   // minimum 2 characters
				which.style.background = "#FFFFFF"; // white
			}
			else {
				which.style.background = "";  // yellow
			}
		}
	</script>
</head>

<body OnLoad="javascript:setUp()">
<div class="container">
<jsp:include page="Menu.jsp"></jsp:include>

<FORM name="menuform" id="menuform" method="post"><br>

<%--  ------------------------Added By Vishwajeet --------------------------------------------%>
<%
			if(serverMessage != null && !serverMessage.equals("")) {

%>
						<center><font color=red>Supplied data is invalid for following fields  <%=serverMessage%>.</font></center>
<%
	}							
%>

<%-- --------------------------------------------------------------------------------------------%>
<div class="leg">Role Master</div>
<div class="portletContainer">
<table width="100%" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
	<tr>
		<td>
			<div id="editRolediv7" style="display: block;"><%if (crsObjResult != null) {
		   
			while (crsObjResult.next()) {
				%>

		<table width="50%" height="10%" align="center" border="0"
			id="displayResult" cellspacing="0" cellpadding="0">
<%--			 <tr> <%=authz_message%> </tr>--%>
			<tr align="center">
				<td class="message"><%=crsObjResult.getString("val")%></td>
				
			</tr>
			
		</table>
		<%}
		}
	%>
	</div>	
		</td>
	</tr>
  	<tr>
		<td>
		<fieldset><legend class="legend1">Role Details
		</legend> <br>

		<table align="center" width="90%" class="TDData">
			<tr align="left" class="contentDark">
				<td >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search:
				</td>
				<td>
				
				<input   class="textBoxAdminSearch"	 type="text" id="rolesearchtxt" name="rolesearchtxt" size="30" onKeyUp="javascript:obj1.bldUpdate(event);"> 
				<input	 class="btn btn-small"	id="show" type="button" value="V" onClick="changeList(event);">

				<DIV align="left" style="width:250px">
				<DIV id="lister" style="display:none;position:absolute;z-index:+10;">
				<select   class="inputsearch"	  style="width:5.5cm" id="itemlist" name="itemlist" size="5"  onclick="update(event)" 	onkeypress="update(event)" >

					<%while (crsObjResultcombo.next()) {%>
					<option value="<%=crsObjResultcombo.getString("id")%>"><%=crsObjResultcombo.getString("name")%></option>
					<%
	             	}%>

				</select></DIV>
				</DIV>
				</td>

			</tr>


			<tr width="90%" class="contentLight">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name :</td>
				<td><input class="textBoxAdmin" type="text" id="rlname" name="rlname" value="" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" size="30"
				 onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz ');"  />
				</td>
			</tr>
			<tr width="90%" class="contentDark">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Description :</td>
				<td><input  class="textBoxAdmin"	 type="text" id="rldescription" name="rldescription"
					value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');"  onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" size="30" /></td>
			</tr>
			<tr width="100%" align="right" class="contentLight">
			<td colspan="2" height="24">
					<input class="btn btn-warning"   type="button" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callNextPage('A')"/>
					<input class="btn btn-warning"   type="button" id="btnCancel" name="btnCancel" value="Reset"	onclick="cancellation()"/>
					<input class="btn btn-warning"   type="button" id="btnDelete" name="btnDelete" value="Delete"onclick="callNextPage('D')"/>
					<input    type="hidden" id="hiddenval" name="hiddenval" value=""/>
					<input   type="hidden" id="hiddenval1" name="hiddenval1" value=""/>
					<input   type="hidden" id="hditemlist" name="hditemlist" value=""/>
		     	</td>
	    	</tr>
		</table>
		<br>
		</fieldset>
		</td>
		</tr>	
		<tr>
		<td>
		
		</td>
	</tr>		
		
	   </table>
		<br>
		<br>
<div>
		
	</form>
</div>
<jsp:include page="Footer.jsp"></jsp:include>
</body>


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
	


