
<!--
Page Name:    stateMaster.jsp
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

	
<% 
        CachedRowSet crsObjResult             = null;
		CachedRowSet crsObjResultState        = null;
	   
      //Variables for state master
         String gsStateid                    =null;
	     String gsStatename                   =null;
	     String gsCountryname                   =null;
    	 
    	 String serverMessage = null;
	     
	
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		try {
			if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit")){
				/*For insertion of record in database.*/
				 gsStateid = request.getParameter("itemlist");
				 if(request.getParameter("hditemlist").equals(""))
                {
                gsStateid=null;
                }
                else{                
				gsStateid = request.getParameter("hditemlist");
				}

				 gsStatename = request.getParameter("txtstate");
				 gsCountryname = request.getParameter("country");
				 String flag = request.getParameter("hiddenval");
				 
				System.out.println("@@ flag @@" + flag);
		 		System.out.println("@@ gsStatename @@" + gsStatename);
		 		System.out.println("@@ gsCountryname @@" + gsCountryname);
				
				 /*-------------------------- Added By Vishwajeet --------------------------------------------*/

  			    Vector lvFormsData = new Vector();
				Vector lvValidatorId = new Vector();
				Vector lvFieldName = new Vector();
  			     
				in.co.paramatrix.common.validator.DataValidator dv = (DataValidator)application.getAttribute("datavalidator");
				 							
								
				lvFormsData.add(gsStatename);
				lvValidatorId.add("gsStatename");	
				lvFieldName.add("State Name");	
				
				lvFormsData.add(flag);
				lvValidatorId.add("flag");	
				lvFieldName.add("State Status");	
				
				lvFormsData.add(gsCountryname);
				lvValidatorId.add("id");	
				lvFieldName.add("Country");
				
				serverMessage = validateData(lvValidatorId, lvFormsData, lvFieldName, dv);
		
		/***************************************************************************************/
		
				if(serverMessage.equals("")) {
					vparam.add(gsStateid);
					vparam.add(gsStatename);
					vparam.add(gsCountryname);
					vparam.add(request.getParameter("hiddenval"));
					crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
							"esp_amd_statesmst", vparam, "ScoreDB");
				}
				
			}

			vparam.removeAllElements();
			vparam.add("1");
			crsObjResultState = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_statesval", vparam, "ScoreDB");
			vparam.removeAllElements();
		
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		%>
<html>
<head>
<title>State Master</title>
<%--<link rel="stylesheet" type="text/css" href="../../CSS/Styles.css">--%>
<%--<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">--%>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
<%--<link href="../../css/formtest.css" rel="stylesheet" type="text/css" />--%>
<script type="text/javascript">
 

 function callNextPage(id){
 	
    		document.getElementById('hdSubmit').value = "submit";
    		document.getElementById('hiddenval').value = id;
    	    document.stateMaster.action = "/cims/jsp/admin/StateMaster.jsp";
			
		  if(id=="D"&&document.getElementById('hditemlist').value!="")
			{
				var deleteconfirm = confirm("Do you want to delete the record.")
				if(deleteconfirm){
					document.stateMaster.submit();
				}else{
					return false 
				}
			
			
			
			}
			if(id=="A"){		
			if(textValidate()){			
			document.stateMaster.submit();
			}
			}		
		}	
		
		
		 function cancellation(){
	       document.getElementById("entry").value = "";	              
           document.getElementById("editRolediv3").style.display = "none";
           document.getElementById("itemlist").value = "";           
           document.getElementById("hditemlist").value = "";
	 	   document.getElementById('txtstate').value="";		
		}	
		
		
		
		
		 function textValidate(){
		 	var resulttxt=document.getElementById('txtstate').value;
	      
		 	var alphaExp = /^[a-zA-Z ]+$/;
		 
			if(resulttxt.match(alphaExp))
			   { 
				return true;
				
			}else{
			  alert("Enter State name in alphabets");
				return false;
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
      
      	 function selected(obj){
      	 var eleObjArr1=document.getElementById(obj).options;
		 if (eleObjArr1.length >= 1){
		 eleObjArr1[0].selected = true;
		 }
		} 
		
      function setUp() {
        obj1 = new SelObj('stateMaster','itemlist','entry');
        obj1.bldInitial(); 
      }
      <!-- Functions Below Added by Steven Luke -->
      function update(event) {  
      	if(event.keyCode == 13 || event.keyCode ==0 || event.keyCode ==9 || event.button==0){
	        document.stateMaster.entry.value = document.stateMaster.itemlist.options[document.stateMaster.itemlist.selectedIndex].text;
    	    document.getElementById("itemlist").focus();
    	     document.stateMaster.hditemlist.value=document.stateMaster.itemlist.value;    	   
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
       if(document.stateMaster.hditemlist.value!="")
       {
       document.stateMaster.txtstate.value=document.stateMaster.entry.value;
       }
       else{
       document.stateMaster.txtstate.value="";
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
<body  OnLoad="javascript:setUp()" >
<div class="container">
<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="stateMaster" id="stateMaster" method="post"><br><br>

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

<%--        State Master--%>
	 <div class="leg">
                 State Master 
     </div>
<%--<table width="80%" align="center" >--%>
<table width="100%" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">

<tr>
	<td>
	<div id="editRolediv3" style="display: block;">
		<%if (crsObjResult != null) {
		try{
			while (crsObjResult.next()) {
				%>

		<table width="50%"  align="center" border="0"
			id="displayResult" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td class="message"><%=crsObjResult.getString("RetVal")%></td>
			</tr>
		</table>
		<%}
        }catch(Exception e){e.printStackTrace();} 
		}
	%></div>
	</td>
</tr>
<tr>
<td class="portletContainer">
	<fieldset><legend class="legend1">State Details
		</legend> <br>
<%--    <table width="50%" align="center" style="border-top: 1cm;">--%>
		<table width="90%" border="0" align="center" cellpadding="2"
					cellspacing="1" class="table" >

	
	<%--	search	state----%>
            <tr align="left" class="contentDark">
				<td>
				<div id="editRolediv1" style="display: block;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search:</div>
				</td>
				<td>
				<div id="editRolediv2" style="display: block;">
				<input class="textBoxAdminSearch" type="text"	name="entry" size="30" onKeyUp="javascript:obj1.bldUpdate(event);">
				 <input class="btn btn-small"	id="show" type="button" value="V" onClick="changeList(event);"></div>
				<DIV align="left" style="width:250px">
				<DIV id="lister" style="display:none;position:absolute;z-index:+10;">
				<select class="inputsearch" style="width:6.2cm" id="itemlist" name="itemlist" size="5"
				onkeypress="update(event)"	onclick="update(event)">
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
<%----search end state--%>
			<tr width="90%" class="contentLight">
				<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;State Name:</td>
				<td><input class="textBoxAdmin"  type="text" name="txtstate" id="txtstate" value=""   onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)"></td>
			</tr>

			<tr width="90%" class="contentDark">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Country :</td>
<%--				<td><select  style="width:6.2cm" class="input" name="country" id="country">--%>
					<td><select  onfocus = "this.style.background = '#FFFFCC'" style="width:6.2cm" class="inputField" name="country" id="country">
					<option value="1">India</option>
				</select></td>
			</tr>

		<tr width="100%" align="right" class="contentLight">
			<td colspan="2" height="24">
		            <input  name="button" class="btn btn-warning" type="button" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callNextPage('A')"/>
	      			<input  name="button" class="btn btn-warning" type="button" id="btnCancel" name="btnCancel" value="Reset" onclick="cancellation()"/>	      			
	      			<input  name="button" class="btn btn-warning" type="button" id="btnDelete" name="btnDelete" value="Delete" onclick="callNextPage('D')" />
	      			<input  type="hidden" id="hdSubmit" name="hdSubmit" value="">
	      			<input  type="hidden" id="hiddenval" name="hiddenval" value=""> 	      			
	      			<input  type="hidden" id="hditemlist" name="hditemlist" value=""> 
	      			
	    	</td>
		</tr>
		
</TABLE>
<br>
</fieldset>
</td>
</tr>
</table>

</form>
</div>
</body>
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
	