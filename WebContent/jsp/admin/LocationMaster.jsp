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
        CachedRowSet crsObjResult                = null;
		CachedRowSet crsObjResultcombo           = null;
		CachedRowSet  crsObjstateval             =null;
		Vector vparam                            = new Vector();
		String gsrlId                            = null;
		String gslocname                          = null;
		String statelist                     = null;
    	String serverMessage = null;
    	
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		try {
			if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit"))
	   {
	/*For insertion of record in database.*/
              
				
				 if(request.getParameter("hditemlist").equals(""))
                {
                gsrlId=null;
                }
                else{                
				gsrlId = request.getParameter("hditemlist");
				}
				gslocname = request.getParameter("locname");
				statelist = request.getParameter("statelist");
   			    String flag = request.getParameter("hiddenval");
				
		 /*-------------------------- Added By Vishwajeet --------------------------------------------*/

  			    Vector lvFormsData = new Vector();
				Vector lvValidatorId = new Vector();
				Vector lvFieldName = new Vector();
  			     
				in.co.paramatrix.common.validator.DataValidator dv = (DataValidator)application.getAttribute("datavalidator");
				 							
								
				lvFormsData.add(gslocname);
				lvValidatorId.add("gslocname");	
				lvFieldName.add("Name");	
				
				lvFormsData.add(flag);
				lvValidatorId.add("flag");	
				lvFieldName.add("Location Status");	
				
				lvFormsData.add(statelist);
				lvValidatorId.add("id");	
				lvFieldName.add("State");
				
				serverMessage = validateData(lvValidatorId, lvFormsData, lvFieldName, dv);
		
		/***************************************************************************************/
		
				if(serverMessage.equals("")) {
					vparam.add(gsrlId);//
					vparam.add(gslocname);//
					vparam.add(statelist);//
					vparam.add(request.getParameter("hiddenval"));
					crsObjResult = lobjGenerateProc.GenerateStoreProcedure("esp_amd_locationmst", vparam, "ScoreDB");
					vparam.removeAllElements();
				}
			}
			vparam.add("0");
			crsObjResultcombo = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_locationsearch", vparam, "ScoreDB");
					vparam.removeAllElements();
					vparam.add("1");
			crsObjstateval = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_statesval", vparam, "ScoreDB");
					vparam.removeAllElements();

		} catch (Exception e) {
			e.printStackTrace();
		}

		%>
<html>
<head>
<title>Location Master</title>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
 <script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
<script type="text/javascript">
   
    var xmlHttp=null;
  
       function callNextPage(id){
    		document.getElementById('hdSubmit').value = "submit";
    		document.getElementById('hiddenval').value = id;
    		document.locform.action = "/cims/jsp/admin/LocationMaster.jsp";
    		
    		if(id=="D"&&document.getElementById('hditemlist').value!="")
			{
			
				var deleteconfirm = confirm("Do you want to delete the record.")
				if(deleteconfirm){
					document.locform.submit();
				}else{
					return false 
				}
			
			}
			if(id=="A"){		
			if(textValidate()){			
			document.locform.submit();
			}
			}	
    			
		}	
		
		function textValidate(){
		 	var resulttxt=document.getElementById('locname').value;
	        var alphaExp1 = /^[a-zA-Z ( ) ]+$/; 
		     var flag =true;
		     var mess="";
			if(!resulttxt.match(alphaExp1))
			   { 
			   mess=mess+"Enter location in alphabets\n";
				flag =false;
			   }
			if(document.getElementById('statelist').value=="0")
			{
			mess=mess+"Please Select State\n";			
			  flag =false;
			}
			
			if(flag==false)
			{
			alert(mess);
			return false;
			}
			else
			{
			return true;
			}
		 }
		
  
    	 function selected(obj){
      	 var eleObjArr1=document.getElementById(obj).options;
		 if (eleObjArr1.length >= 1){
		 eleObjArr1[0].selected = true;
		 }
		} 

	 
	
	
	
	 function cancellation(){
	          document.getElementById("itemlist").value = "";
	          document.getElementById("hditemlist").value = "";
	         document.getElementById("entry").value = "";
	         document.getElementById("locname").value = "";
	         document.getElementById("statelist").value ="0";	 	         
             document.getElementById("editRolediv7").style.display = "none";
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
   		    	   				  
			   var mess=responseResult.split("<br>");
			   
            document.getElementById("locname").value =mess[1]// xmlDoc.getElementsByTagName("Name")[0].childNodes[0].nodeValue;            
            document.getElementById("statelist").value =mess[2]; //xmlDoc.getElementsByTagName("Description")[0].childNodes[0].nodeValue;   
          
			  }
			catch(e)
			  {
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
        obj1 = new SelObj('locform','itemlist','entry');
        obj1.bldInitial(); 
      }
      <!-- Functions Below Added by Steven Luke -->
      function update(event) {  
    	  if(event.keyCode == 13 || event.keyCode ==0 || event.keyCode ==9 || event.button==0){
	        document.locform.entry.value = document.locform.itemlist.options[document.locform.itemlist.selectedIndex].text;
    	    document.getElementById("itemlist").focus();
    	     document.locform.hditemlist.value=document.locform.itemlist.value;    	   
    	    hideList();    	   
    	     }
    	  if(event.keyCode == 27){
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
        var valName=document.locform.itemlist.value;
        if(valName!=""){
        var url = "/cims/jsp/admin/LocationFromcombo.jsp?Resultid="+valName;
	    xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
		}
      }
      function changeList(event) {
        if (document.getElementById("lister").style.display=="none")
          showList(event);
        else
          hideList(event);
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
<FORM name="locform" id="locform" method="post"><br>
<br>
<%--  ------------------------Added By Vishwajeet --------------------------------------------%>
<%
			if(serverMessage != null && !serverMessage.equals("")) {

%>
						<center><font color=red>Supplied data is invalid for following fields  <%=serverMessage%>.</font></center>
<%
	}							
%>

<%-- --------------------------------------------------------------------------------------------%>

<div class="leg">City Master</div>
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
			<tr align="center">
				<td class="message"><%=crsObjResult.getString("val")%></font></td>
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
		<fieldset><legend class="legend1">City Details
		</legend> <br>

		<table width="90%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table" >
			<tr align="left" class="contentDark">
				<td >
				<div id="editRolediv1" style="display: block;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search City:</div>
				</td>
				<td>
				<div id="editRolediv2" style="display: block;"><input   class="textBoxAdminSearch"	 type="text" name="entry" size="27" onKeyUp="javascript:obj1.bldUpdate(event);"> 
				<input	 class="btn btn-small"	id="show" type="button" value="V" onClick="changeList(event);"></div>

				<DIV align="left" style="width:250px">
				<DIV id="lister" style="display:none;position:absolute;z-index:+10;">
				<select   class="inputsearch"	  style="width:5.5cm" id="itemlist" name="itemlist" size="5" onclick="update(event)"	onkeypress="update(event)" >

					<%while (crsObjResultcombo.next()) {
			  %>
					<option value="<%=crsObjResultcombo.getString("id")%>"><%=crsObjResultcombo.getString("name")%></option>
					<%
	             	}
		      %>

				</select></DIV>
				</DIV>
				</td>

			</tr>


			<tr width="90%" class="contentLight">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;City :</td>
				<td><input class="textBoxAdmin" type="text" id="locname" name="locname" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz ()');"  value="" size="30" />
				</td>
			</tr>
			<tr align="left" class="contentDark">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;State :</td>
				<td><select   onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" class="inputField"  style="width:6.2cm" id="statelist" name="statelist" 	 >
                     <OPTION value="0">state</OPTION>
					<%while (crsObjstateval.next()) {
			  %>
					<option value="<%=crsObjstateval.getString("id")%>"><%=crsObjstateval.getString("name")%></option>
					<%
	             	}
		      %>              
				</select>
				 </td>
               </tr>
              <tr width="90%" class="contentLight" align="right">
		          <td colspan="2" align="right">
		       			<input  class="btn btn-warning" type="button" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callNextPage('A')">
		      			<input  class="btn btn-warning"  type="button" id="btnCancel" name="btnCancel" value="Reset" onclick="cancellation()" >
		      			<input  class="btn btn-warning"  type="button" id="btnDelete" name="btnDelete" value="Delete" onclick="callNextPage('D')" >
		      			<input type="hidden" id="hdSubmit" name="hdSubmit" value="">
		      			<input type="hidden" id="hiddenval" name="hiddenval" value="">	      				      			
		      			<input  type="hidden" id="hditemlist" name="hditemlist" value="">       			     			     			
		       		</td>
	    	</tr>
		</table>
		<br>
		</fieldset>
		</td>
		</tr>	
		
	   </table>
</div>
	</form>
</body>

<jsp:include page="Footer.jsp"></jsp:include>
<div>	
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
	
