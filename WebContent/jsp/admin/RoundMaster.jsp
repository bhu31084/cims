<!--
Page Name: RoundMaster.jsp
Author 		 : Avadhut Joshi.
Created Date : 19th Sep 2008
Description  : Entry of Rounds 
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
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<%

  CachedRowSet  crsObjRounds = null;
  CachedRowSet crsObjRoundcombo =null;
  Vector vparam =  new Vector();		
  GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
  String serverMessage = null;
  	
try{	
	
	
	if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit")){
		/*For insertion of record in database.*/
		String  gsroundId=null;
		 if(request.getParameter("hditemlist").equals(""))
                {
                gsroundId=null;
                }
                else{                
				gsroundId = request.getParameter("hditemlist");
				}
		String gsroundName =	request.getParameter("txtroundname");
		String gsroundDesc =	request.getParameter("txtrounddesc");		
		String flag = request.getParameter("hiddenval");

 			    Vector lvFormsData = new Vector();
				Vector lvValidatorId = new Vector();
				Vector lvFieldName = new Vector();
  			     
				in.co.paramatrix.common.validator.DataValidator dv = (DataValidator)application.getAttribute("datavalidator");
								
				lvFormsData.add(gsroundName);
				lvValidatorId.add("gsRoundName");	
				lvFieldName.add("Round Name");	
				
				lvFormsData.add(gsroundDesc);
				lvValidatorId.add("gsRoundDesc");	
				lvFieldName.add("Round Description");
				
				lvFormsData.add(flag);
				lvValidatorId.add("flag");	
				lvFieldName.add("Result Status");	
							
				serverMessage = validateData(lvValidatorId, lvFormsData, lvFieldName, dv); 
				
			/***************************************************************************************/
 				if(serverMessage.equals("")) {
					vparam.add(gsroundId);//
					vparam.add(gsroundName);//
					vparam.add(gsroundDesc);//
					vparam.add(request.getParameter("hiddenval"));
					crsObjRounds = lobjGenerateProc.GenerateStoreProcedure(
						"esp_amd_roundsmst",vparam,"ScoreDB");			
					vparam.removeAllElements();		
				}		
	}
	vparam.add("0");
			crsObjRoundcombo = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_roundsearch", vparam, "ScoreDB");
	}catch(Exception e){
	e.printStackTrace();
	}
	
%>

<head><title>Rounds Master</title>

<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
 <script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
    <script>
      var xmlHttp=null;
      
   
		
	 function callNextPage(id){
    		document.getElementById('hdSubmit').value = "submit";
    		document.getElementById('hiddenval').value = id;
    	    document.frmRound.action = "/cims/jsp/admin/RoundMaster.jsp";
			
		  if(id=="D"&&document.getElementById('hditemlist').value!=""){
			var deleteconfirm = confirm("Do you want to delete the record.")
				if(deleteconfirm){
					document.frmRound.submit();
				}else{
					return false 
				}
			
			}
			if(id=="A"){		
			if(textValidate()){			
			document.frmRound.submit();
			}
			}		
		}	
		
	 function cancellation(){
	       document.getElementById("resultsearchtxt").value = "";         
           document.getElementById("editRolediv7").style.display = "none";
           document.getElementById("itemlist").value = "";           
           document.getElementById("hditemlist").value = "";
	 	   document.getElementById('txtroundname').value="";
	 	   document.getElementById('txtrounddesc').value="";
		   document.frmRound.action = "/cims/jsp/admin/RoundMaster.jsp";			
		}	
		
			 function textValidate(){
		 	var resulttxt=document.getElementById('txtroundname').value;
		 	var resultdesc=document.getElementById('txtrounddesc').value;
	      
		 	var alphaExp = /^[a-zA-Z 0-9]+$/;
		 
			if(resulttxt.match(alphaExp))
			   { 
				
				if(resultdesc!="")
				{
				return true;
				}
				else{
				 alert("Enter some Description ");
				return false;
				}
				
			}else{
			  
				 if(resulttxt=="")
			    {
			      if(resulttxt==""&& resultdesc=="")
			    {
			      alert("Enter All Records");
			    }else{
			     alert("Enter Round Name");
			    }
			    }
			   else{
			   alert("Roundname should contain alphabets and digits ");
				return false;
				}
				
				
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

			  var mess=responseResult.split("<br>");
            document.getElementById("txtroundname").value =mess[1] //xmlDoc.getElementsByTagName("Name")[0].childNodes[0].nodeValue;            
            document.getElementById("txtrounddesc").value = mess[2]//xmlDoc.getElementsByTagName("Desc")[0].childNodes[0].nodeValue;  
          
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
          return;.
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
      
      function setUp() {
        obj1 = new SelObj('frmRound','itemlist','resultsearchtxt');
        obj1.bldInitial(); 
      }

      function update(event) {
    	 if(event.keyCode == 13 || event.keyCode == 0 || event.keyCode == 9 || event.button == 0 ){
	        document.frmRound.resultsearchtxt.value = document.frmRound.itemlist.options[document.frmRound.itemlist.selectedIndex].text;
    	    document.getElementById("resultsearchtxt").focus();
    	    hideList();
    	    document.frmRound.hditemlist.value=document.frmRound.itemlist.value;
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
        var valName=document.frmRound.itemlist.value;
           if(valName!=""){
        var url = "/cims/jsp/admin/RoundSearchfromcombo.jsp?Roundid="+valName;
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
				//alert ("This box must be filled!");
				//which.focus();
				//return false;
			}
		}
    </script>
</head>

<body  OnLoad="javascript:setUp()" >
<div class="container">
<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="frmRound" id="frmRound" method="post">

<%--  ------------------------Added By Vishwajeet --------------------------------------------%>
<%
			if(serverMessage != null && !serverMessage.equals("")) {

%>
						<center><font color=red>Supplied data is invalid for following fields  <%=serverMessage%>.</font></center>
<%
	}							
%>
<div class="leg">Round Master</div>
<%--    Venue Master--%>
<div class="portletContainer">
<%-- --------------------------------------------------------------------------------------------%>
			
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
			<tr>
				<td>
					<div id="editRolediv7" style="display: block;">
					<%if (crsObjRounds != null) {
						while (crsObjRounds.next()) {
					%>		<table width="50%" height="10%" align="center" border="0"
								id="displayResult" cellspacing="0" cellpadding="0">
								<tr align="center">
									<td class="message"><%=crsObjRounds.getString("Retval")%></font></td>
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
					<fieldset><legend class="legend1">Round Details
						</legend> <br>
			 		       <table width="90%" border="0" align="center" cellpadding="2"
							cellspacing="1" class="table" >
						
				<%--	search--%>
			 	<tr align="left" class="contentDark">
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search 
					</td>
				<td>
				
				<input  class="textBoxAdminSearch" type="text" id="resultsearchtxt" name="resultsearchtxt" size="20" onKeyUp="javascript:obj1.bldUpdate(event);">
                  <input class="btn btn-small"	id="show" type="button" value="V" onClick="changeList(event);">
                 
				<DIV align="left" style="width:250px">
				<DIV id="lister" style="display:none;position:absolute;z-index:+10;">
				<select  class="inputsearch" style="width:4.2cm" id="itemlist" name="itemlist" size="5"
				onclick="update(event)"	onkeypress="update(event)">

					<%while (crsObjRoundcombo.next()) {
			  %>
					<option value="<%=crsObjRoundcombo.getString("id")%>"><%=crsObjRoundcombo.getString("name")%></option>
					<%
	             	}
		      %>

				</select></DIV>
				</DIV>
				</td>

			</tr>
			 		
			 		
<%--		search end--%>	
						
						
						<tr width="90%" class="contentLight">
							<td nowrap="nowrap">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Round Name :</td>
						   	<td>
								<input class="textBoxAdmin" type="text" name="txtroundname" id="txtroundname" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');"  onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" value="" >
							</td> 
						</tr>
						<tr width="90%" class="contentDark">							
						   	<td nowrap="nowrap">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Round Description:</td> 
							<td>
								<input class="textBoxAdmin" type="text" name="txtrounddesc" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)"  id="txtrounddesc" value="" >
							</td> 
						</tr>
						<tr width="100%" align="right" class="contentLight">
							<td colspan="2" height="24">
				       			<input  class="btn btn-warning" type="button" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callNextPage('A')">
				      			<input  class="btn btn-warning" type="button" id="btnCancel" name="btnCancel" value="Reset" onclick="cancellation()">
				      			<input  class="btn btn-warning" type="button" id="btnDelete" name="btnDelete" value="Delete" onclick="callNextPage('D')" >
				      			<input  type="hidden" id="hdSubmit" name="hdSubmit" value="">
				      			<input  type="hidden" id="hiddenval" name="hiddenval" value="">  
				      			<input  type="hidden" id="hditemlist" name="hditemlist" value="">      			     			     			
				       		</td>
				    	</tr>								
					</table> 					
					<br>
					</fieldset>
						
				</td>
			</tr>
			
		</TABLE>
</div>
</form>

</div>
<jsp:include page="Footer.jsp"></jsp:include>
</body>			

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
