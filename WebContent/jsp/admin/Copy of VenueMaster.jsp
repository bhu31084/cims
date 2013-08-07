
<!--
Page Name:    VenueMaster.jsp
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
		CachedRowSet crsObjResultZone         = null;
	    CachedRowSet crsObjAssociations       = null;
	    CachedRowSet 	crsObjVenuesearch      =null;
	    CachedRowSet 	crsObjResultvenue      =null;
	    String gsclubname                      =null;
	    String gsstateid                      =null;
	    String gszoneid                         =null;
	    String gsclubid                        =null;
	    String clubname                        =null;
	    String statename                       =null;
     
	   //Variables for venue master
         String venueid                   =null;
         String venuename                 =null;
         String venueadd                =null;
         String venuestreet               =null;
         String venueplot                =null;
         String venueend1               =null;         
         String venueend2               =null;         
         String venuepincode               =null;         
         String venuedistrict               =null;
         String venuelocation              =null;  
         String venuestatus                =null;
         String veneulocationname         =null;
    	 String serverMessage = null;
    	 String venueclub               =null;
    	 
          //Variables for country master  
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
			

          try {
			if (request.getParameter("hiddenval") != null
					&& request.getParameter("hiddenval").equals("submit")) {
					
					 if(request.getParameter("hditemlist6").equals(""))
	                {
	                venueid=null;
	                }
	                else{                
					venueid = request.getParameter("hditemlist6");
					}	
						     
				 venuelocation = request.getParameter("hditemlist5");
				 venuename = request.getParameter("txtvenue");
				 venueadd = request.getParameter("txtvenueadd");
				 venuestreet = request.getParameter("txtvenuestreet");
				 venueplot = request.getParameter("txtvenueplot");
				 venueend1 = request.getParameter("txtvenueend1");
				 venueend2 = request.getParameter("txtvenueend2");
				 venuepincode = request.getParameter("txtvenuepin");
				 venuedistrict = request.getParameter("txtvenuedistrict");				
				 veneulocationname = request.getParameter("entry5");
				 venuestatus=request.getParameter("hiddenval1");
				 venueclub = request.getParameter("hiddenvenueClub");
			
		 		
		 		    
  			  /*-------------------------- Added By Vishwajeet --------------------------------------------*/

  			    Vector lvFormsData = new Vector();
				Vector lvValidatorId = new Vector();
				Vector lvFieldName = new Vector();
  			     
				in.co.paramatrix.common.validator.DataValidator dv = (DataValidator)application.getAttribute("datavalidator");
				 
				lvFormsData.add(venuename);
				lvValidatorId.add("venuename");	
				lvFieldName.add("Venue Name");
				
				lvFormsData.add(venueadd);
				lvValidatorId.add("venueadd");	
				lvFieldName.add("Address");
				
				lvFormsData.add(venuestreet);
				lvValidatorId.add("venuestreet");	
				lvFieldName.add("Street");	
				
				lvFormsData.add(venueplot);
				lvValidatorId.add("venueplot");	
				lvFieldName.add("Plot");	
				
				lvFormsData.add(venueend1);
				lvValidatorId.add("venueend1");	
				lvFieldName.add("End1");
				
				lvFormsData.add(venueend2);
				lvValidatorId.add("venueend2");	
				lvFieldName.add("End2");
				
				lvFormsData.add(venuepincode);
				lvValidatorId.add("venuepincode");	
				lvFieldName.add("Pin");
				
				lvFormsData.add(venuedistrict);
				lvValidatorId.add("venuedistrict");	
				lvFieldName.add("District");
				
				lvFormsData.add(venuestatus);
				lvValidatorId.add("flag");	
				lvFieldName.add("Venue status");
				
				lvFormsData.add(venueclub);
				lvValidatorId.add("venueclub");	
				lvFieldName.add("Association Name");
				
				serverMessage = validateData(lvValidatorId, lvFormsData, lvFieldName, dv);
		
		/***************************************************************************************/
		
					if(serverMessage.equals("")) {
					    vparam.add(venueid);//
						vparam.add(venuename);//
						vparam.add(venueadd);//				
						vparam.add(venueplot);//
						vparam.add(venuestreet);//
						vparam.add(venueend1);//
						vparam.add(venueend2);//
						vparam.add(venuepincode);//
						vparam.add(venuedistrict);//				
					    vparam.add(venuelocation);//
					    vparam.add(venuestatus);//
					    vparam.add(venueclub);//Club id
					    System.out.println("vparam"+vparam);
						crsObjResultvenue = lobjGenerateProc.GenerateStoreProcedure(
								"esp_amd_venuessmst", vparam, "ScoreDB");
						vparam.removeAllElements();
					}
			}
		
			vparam.add("1");
			crsObjResultState = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_statesval", vparam, "ScoreDB");
			vparam.removeAllElements();
			
			
			vparam.add("0");
			crsObjVenuesearch = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_venuesearch", vparam, "ScoreDB");
			vparam.removeAllElements();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		%>
<html>
<head>
<title>Venue Master</title>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
<script type="text/javascript">

 function callNextPage(id){
   if(id=="D")
           {
            document.getElementById('hiddenval1').value ="D";
           }
           else{
            document.getElementById('hiddenval1').value = "A";	
           }		
		  
    		document.getElementById('hiddenvenueClub').value = document.getElementById('selClub').value    		
    		document.getElementById('hiddenval').value = "submit"; 
			document.regionMaster.action = "VenueMaster.jsp";
			if(id=="D"&&document.getElementById('hditemlist6').value!="")
			{
				var deleteconfirm = confirm("Do you want to delete the record.")
				if(deleteconfirm){
					document.regionMaster.submit();
				}else{
					return false 
				}
			
			
			
			}
			if(id=="A"){		
			if(textValidatevenue()){			
			document.regionMaster.submit();
			}
			}			
		}	
		
		
	
		
		 function textValidatevenue(){
		 	var Venuetxt=document.getElementById('txtvenue').value;
		 	var Venueadd=document.getElementById('txtvenueadd').value;
		 	var Venueplot=document.getElementById('txtvenueplot').value;
		 	var Venuedist=document.getElementById('txtvenuedistrict').value;
		 	var Venuestreet=document.getElementById('txtvenuestreet').value;
		 	var Venueend1=document.getElementById('txtvenueend1').value;
		 	var Venueend2=document.getElementById('txtvenueend2').value;
		 	var Venuepin=document.getElementById('txtvenuepin').value;
		 	var venueclub = document.getElementById('selClub').value;
	        var alphaExp1 = /^[a-zA-Z ]+$/; 
		 	var alphaExp = /^[a-zA-Z , . 0-9]+$/;
		 	var alphaExp2 = /^[ 0-9]+$/;
		 	var flag =true;
		    var mess ="please enter following details :\n"
			if(!Venuetxt.match(alphaExp1)){
			   mess=mess+  " Venue  name should contain alphabets\n";
				flag= false;
			  }
			   if(!Venueadd!="")
			   {
			   mess=mess+  " Address\n";
				flag= false;
			   }
							
				
			  if(document.getElementById('hditemlist4').value==""){
			    mess=mess+  " Select State\n";
				flag= false;
				}
				
				 if(document.getElementById('hditemlist5').value==""){
			    mess=mess+  " Select City\n";
				flag= false;
				}
				
				if(!Venuepin.match(alphaExp2))
				{
				mess=mess+  " pin in integer\n";
				flag= false;
				}				
				
				
				if(flag==false){
				alert(mess);
				return flag;
				}else{
				return flag;
				}
				
			}
		
		
		
			
		
	
		
		 function cancellation(){
		 	document.getElementById('editRolediv9').style.display="none";
		    document.getElementById("txtvenue").value =""   ;          
            document.getElementById("txtvenueadd").value = "";
            document.getElementById("txtvenueplot").value =  ""    ;    
			document.getElementById("txtvenuedistrict").value = "";
		    document.getElementById("hiddenval2").value = ""     ;
			document.getElementById("txtvenueend1").value = "";
			document.getElementById("txtvenueend2").value =	""	 ;			
            document.getElementById("entry4").value ="";
			document.getElementById("entry5").value ="";
			document.getElementById("entry6").value ="";
			document.getElementById("itemlist4").value ="";
			document.getElementById("itemlist5").value ="";
			document.getElementById("hditemlist4").value ="";
			document.getElementById("hditemlist5").value ="";			
			document.getElementById("hditemlist6").value ="";
			document.getElementById("itemlist6").value ="";
			document.getElementById("txtvenuepin").value ="";
			document.getElementById('txtvenuestreet').value="";
			document.getElementById('selClub').value = "0";		 
		 
		}	
		
			
 
  
    function SelObj(formname,selname,textname,str) {
        this.formname = formname;
        this.selname = selname;
        this.textname = textname;
        this.select_str = str || '';
        this.selectArr = new Array();
        this.initialize = initialize;
        this.bldInitial = bldInitial;
        this.bldUpdate4= bldUpdate4;          
        this.bldUpdate5= bldUpdate5;
         this.bldUpdate6= bldUpdate6;
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
     
     
      function selected(obj){
      	 var eleObjArr1=document.getElementById(obj).options;
		 if (eleObjArr1.length >= 1){
		 eleObjArr1[0].selected = true;
		 }
		} 
     
      
       function bldUpdate4() {
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList4();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList4(event);
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
          hideList4();
        }
         if(window.event.keyCode == 40)
       {
       selected("itemlist4");
       }   
      }
      
        function bldUpdate5() {
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList5();
          return;
        }
        this.initialize(); 
        // Show List as User Types
        showList5(event);
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
          hideList5();
        }
         if(window.event.keyCode == 40)
       {
       selected("itemlist5");
       }   
      }
      
      function bldUpdate6() {
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList6();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList6(event);
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
          hideList6();
        }
         if(window.event.keyCode == 40)
       {
       selected("itemlist6");
       }   
      }
      
      function setUp() {       
       obj5 = new SelObj('regionMaster','itemlist4','entry4');
       obj5.bldInitial();       
       obj7 = new SelObj('regionMaster','itemlist6','entry6');
       obj7.bldInitial(); 
      }
      
       function setUp1() {
       obj6 = new SelObj('regionMaster','itemlist5','entry5');
       obj6.bldInitial();  
      
      }
     
    
       
       function update4(event) {
      	if(window.event.keyCode == 13 || window.event.keyCode ==0){
	        document.regionMaster.entry4.value = document.regionMaster.itemlist4.options[document.regionMaster.itemlist4.selectedIndex].text;
    	    document.getElementById("entry4").focus(); 
    	    hideList4();
    	    document.regionMaster.hditemlist4.value=document.regionMaster.itemlist4.value;
    	     }
    	  if(window.event.keyCode == 27){
         document.getElementById("lister4").style.display="none";
         }        
        }
      
      
      function update5(event) {
      	if(window.event.keyCode == 13 || window.event.keyCode ==0){
	        document.regionMaster.entry5.value = document.regionMaster.itemlist5.options[document.regionMaster.itemlist5.selectedIndex].text;
    	    document.getElementById("entry5").focus(); 
    	    hideList5();
    	    document.regionMaster.hditemlist5.value=document.regionMaster.itemlist5.value;
    	     }
    	  if(window.event.keyCode == 27){
         document.getElementById("lister5").style.display="none";
         }        
        }
      
     function update6(event) {
      	if(window.event.keyCode == 13 || window.event.keyCode ==0){
	        document.regionMaster.entry6.value = document.regionMaster.itemlist6.options[document.regionMaster.itemlist6.selectedIndex].text;
    	    document.getElementById("entry6").focus(); 
    	    hideList6();
    	    document.regionMaster.hditemlist6.value=document.regionMaster.itemlist6.value;
    	     }
    	  if(window.event.keyCode == 27){
         document.getElementById("lister6").style.display="none";
         }        
        }
     
      
       function showList4(event) {
      if(window.event.keyCode == 40)
      {
        document.getElementById("lister4").style.display="block";
        document.getElementById("itemlist4").focus();
        }        
        if(document.getElementById("itemlist4").value=="0" ||document.getElementById("itemlist4").value=="" ||window.event.keyCode == 0)
        {
         document.getElementById("lister4").style.display="block";
        }
        if(window.event.keyCode == 27){
         document.getElementById("lister4").style.display="none";
        }
        
      }
      
     function showList5(event) {
      if(window.event.keyCode == 40)
      {
        document.getElementById("lister5").style.display="block";
        document.getElementById("itemlist5").focus();
        }        
        if(document.getElementById("itemlist5").value=="0" ||document.getElementById("itemlist5").value==""||window.event.keyCode == 0)
        {
         document.getElementById("lister5").style.display="block";
        }
        if(window.event.keyCode == 27){
         document.getElementById("lister5").style.display="none";
        }
         document.regionMaster.hditemlist5.value=document.regionMaster.itemlist5.value;
      }
      
      
      function showList6(event) {      
      if(window.event.keyCode == 40)
      {
        document.getElementById("lister6").style.display="block";
        document.getElementById("itemlist6").focus();
        }        
        if(document.getElementById("itemlist6").value=="0" ||document.getElementById("itemlist6").value==""||window.event.keyCode == 0 )
        {
         document.getElementById("lister6").style.display="block";
        }
        if(window.event.keyCode == 27){
         document.getElementById("lister6").style.display="none";
        }
      }
      
     
      
      
      
      function hideList4() {
        document.getElementById("lister4").style.display="none";
        document.getElementById("entry5").value="";
        document.getElementById("hiddenval3").value="state"        	
        xmlHttp = GetXmlHttpObject();
        var valName=document.regionMaster.itemlist4.value;
        if(valName!="")
        {            
        var url = "CitybyStateajax.jsp?StateId="+valName;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);	
      }
       document.getElementById("hiddenval3").value=""        	
      }
        function hideList5() {
        document.getElementById("lister5").style.display="none";       
      }
      
        function hideList6() {
        document.getElementById("lister6").style.display="none";
         document.getElementById("hiddenval3").value="venue";
         xmlHttp = GetXmlHttpObject();
        var valName=document.regionMaster.itemlist6.value;
        if(valName!=""){
        var url = "VenueMasterfromcombo.jsp?VenueId="+valName+"&response=search";
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);	
      }    
       document.getElementById("hiddenval3").value="";    
      }
      
     
     
        
      
      function changeList6(event) {        
        if (document.getElementById("lister6").style.display=="none")
          showList6(event);
        else
          hideList6();
      } 
      
      
         function changeList5() {
        if (document.getElementById("lister5").style.display=="none")
          showList5();
        else
          hideList5();
      } 
      
        function changeList4() {
        if (document.getElementById("lister4").style.display=="none")
          showList4();
        else
          hideList4();
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
			  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
			  xmlDoc.async="false";
			  xmlDoc.loadXML(responseResult);
		   if( document.getElementById("hiddenval3").value=="venue"){		    
		    var mess=responseResult.split("<br>");		        
		    var mdiv =document.getElementById('lister5');			
			mdiv.innerHTML=mess[14];			
			document.getElementById("txtvenue").value = mess[2]
            document.getElementById("txtvenueadd").value =  mess[3]//xmlDoc.getElementsByTagName("ADD")[0].childNodes[0].nodeValue;             
            document.getElementById("txtvenueplot").value = mess[6] //xmlDoc.getElementsByTagName("Plot")[0].childNodes[0].nodeValue;           
			document.getElementById("txtvenuedistrict").value = mess[7] //xmlDoc.getElementsByTagName("Disc")[0].childNodes[0].nodeValue;			          
			document.getElementById("txtvenuestreet").value = mess[5] //xmlDoc.getElementsByTagName("Street")[0].childNodes[0].nodeValue;		              
			document.getElementById("txtvenueend1").value =  mess[8]//xmlDoc.getElementsByTagName("End1")[0].childNodes[0].nodeValue;           
			document.getElementById("txtvenueend2").value = mess[9] //xmlDoc.getElementsByTagName("End2")[0].childNodes[0].nodeValue; 		 			
            document.getElementById("entry4").value = mess[10]//xmlDoc.getElementsByTagName("State")[0].childNodes[0].nodeValue;
			document.getElementById("entry5").value = mess[11]//xmlDoc.getElementsByTagName("City")[0].childNodes[0].nodeValue;
			document.getElementById("txtvenuepin").value = mess[12]//xmlDoc.getElementsByTagName("Pin")[0].childNodes[0].nodeValue; 		
			document.getElementById("hditemlist4").value = mess[13]
			document.getElementById("hditemlist5").value =mess[4]//document.getElementById("hiddenval2").value;
			var eleObjArr=document.getElementById('selClub').options;  
				for(var i=0;i< eleObjArr.length;i++){
					if(eleObjArr[i].text == mess[0].trim()){						
						eleObjArr[i].selected = true;				
					}				
				}			
		    setUp1()
		 }
	if(document.getElementById("hiddenval3").value=="state")
		{	
		  
		   var mdiv =document.getElementById('lister5');
			mdiv.innerHTML=responseResult;
			document.getElementById("hditemlist5").value ="";
			setUp1()
		}
		
		 if(document.getElementById("hiddenval4").value=="page"){
		     var mdiv=document.getElementById("pagingpages");
		     mdiv.innerHTML=responseResult;
		     }
			  }
			catch(e)
			  {
			  try //Firefox, Mozilla, Opera, etc.
			    {
			    parser=new DOMParser();
			    xmlDoc=parser.parseFromString(text,"text/xml");
			   
			    }
			  catch(e) {alert(e.message)}
			  }
		}		 
    }	
    
    String.prototype.trim = function () {    	
   	 	return this.replace(/^\s*/, "").replace(/\s*$/, "");
	}    

    function showrecord()
      {         
       if (document.getElementById("paging").style.display=="none")
       {
          document.getElementById("paging").style.display="block";
           document.getElementById("hiddenval4").value="page";
         xmlHttp = GetXmlHttpObject();
        var valName=document.getElementById("hdpage").value;
         var status=document.getElementById("status").value;
       if(valName!="0"){
        var url = "VenueMasterfromcombo.jsp?pageid="+valName+"&response=page"+"&status="+status;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
       document.getElementById("hiddenval4").value="";
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
       document.getElementById("hiddenval4").value="page";
       xmlHttp = GetXmlHttpObject();
        var valName=document.getElementById("hdpage").value;
         var status=document.getElementById("status").value;
       if(valName!="0"){
        var url = "VenueMasterfromcombo.jsp?pageid="+valName+"&response=page"+"&status="+status;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
       document.getElementById("hiddenval4").value="";
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
<body  OnLoad="javascript:setUp()">

<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="regionMaster" id="regionMaster" method="post"><br>



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
<br>
<%--    Venue Master--%>
<table width="780" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
	<tr align="center">
		 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">Venue Master </td>
	</tr>
	<tr>
		<td>
			<div id="editRolediv9" style="display: block;">
		<%if (crsObjResultvenue != null) {
			while (crsObjResultvenue.next()) {
				%>

		<table width="70%"  align="center" border="0" id="displayResult" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td class="message" ><%=crsObjResultvenue.getString("RetVal")%></td>
			</tr>
		</table>
		<%}
		}
	%></div>
		</td>
	</tr>
	<tr>
		<td>
		<fieldset><legend class="legend1">Venue Details
		</legend> <br>
		<table width="90%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table" >
		
<%--	search Venue	----%>
           <tr align="left" class="contentDark">
				<td >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search
				</td>
				<td>
				
				<input class="textBoxAdminSearch" type="text"	name="entry6" size="30" onKeyUp="javascript:obj7.bldUpdate6(event);">
				 <input  class="button1"	id="show2" type="button" value="V" onClick="changeList6(event);">
				<DIV align="left" style="width:250px">
				<DIV id="lister6" style="display:none;position:absolute;z-index:+10;">
				<select class="inputsearch" style="width:6.2cm" id="itemlist6" name="itemlist6" size="5" onclick="update6(event)" onkeypress="update6(event)">	
				
				<%
		  while (crsObjVenuesearch.next()) {
			%>
					<OPTION value="<%=crsObjVenuesearch.getString("id")%>"><%=crsObjVenuesearch.getString("name")%></OPTION>
					<%}%>
				</select></DIV>
				</DIV>
				</td>

			</tr>
 <%----search  Venue end--%>
	
			<tr width="90%" class="contentLight">
				<td nowrap="nowrap">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Venue Name:</td>
				<td><input class="textBoxAdmin" type="text" name="txtvenue" id="txtvenue" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" size="30"  value="" maxlength="50"></td>
			</tr>
			
			<tr width="90%" class="contentLight">
				<td nowrap="nowrap">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Association Name:</td>
				<td>
				<select class="input" name="selClub" id="selClub" style="width:7cm">
		 			<option value="0">--All Association--</option>
					<%try{	
						vparam.add("2");//To get the all associations from association master.
					    crsObjAssociations = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roles",vparam,"ScoreDB");
						vparam.removeAllElements();	
						if(crsObjAssociations != null){	
							while(crsObjAssociations.next()){	
					%>							
										<option value="<%=crsObjAssociations.getString("id")%>" id="<%=crsObjAssociations.getString("name")%>"><%=crsObjAssociations.getString("name")%></option>
					<%		}
						 }
					   }catch(Exception e){
					   }
					%>
		 		</select>		 		
				</td>
			</tr>
			
			<tr align="left" class="contentDark">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Address:</td>
				<td><TEXTAREA class="textArea" id="txtvenueadd" name="txtvenueadd"   onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" size="30"  rows="2" cols="25"></TEXTAREA></td>
			</tr>
			 <tr width="90%" class="contentLight">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Plot:</td>
				<td><input class="textBoxAdmin" type="text" name="txtvenueplot"  onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" size="30"  id="txtvenueplot" value="" maxlength="30"></td>
			</tr>
			
			 <tr align="left" class="contentDark">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:</td>
				<td><input class="textBoxAdmin" type="text" name="txtvenuedistrict" id="txtvenuedistrict" value=""  onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" size="30"  maxlength="40"></td>
			</tr>
			
			 <tr width="90%" class="contentLight">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Street:</td>
				<td><input class="textBoxAdmin" type="text" name="txtvenuestreet" id="txtvenuestreet"  onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');"  onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" size="30"  value="" maxlength="40"></td>
			</tr>
			
			
			 <tr align="left" class="contentDark">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;End1:</td>
				<td><input class="textBoxAdmin" type="text" name="txtvenueend1" id="txtvenueend1"  onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');"  onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" size="30" value=""maxlength="40"></td>
			</tr>
			
			 <tr width="90%" class="contentLight">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;End2:</td>
				<td><input class="textBoxAdmin" type="text" name="txtvenueend2" id="txtvenueend2"  onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');"  onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" size="30" value=""maxlength="40"></td>
			</tr>
          
<%--	state	venue	----%>
			<tr align="left" class="contentDark">
				<td >
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;State
				</td>
				<td>
				<input class="textBoxAdmin" type="text"	name="entry4" size="30" onKeyUp="javascript:obj5.bldUpdate4(event);" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)"> 
				 <input  class="button1"	id="show2" type="button" value="V" onClick="changeList4();">
				 	<a  href="StateMaster.jsp">Add  State</a>				 
				<DIV align="left" style="width:250px">
				<DIV id="lister4" style="display:none;position:absolute;z-index:+10;">
				<select class="input"  style="width:6cm" id="itemlist4" name="itemlist4" size="5"
				 onclick="update4(event)"	onkeypress="update4(event)">

					<%while (crsObjResultState.next()) {
			        %>
					<OPTION value="<%=crsObjResultState.getString("id")%>"><%=crsObjResultState.getString("name")%></OPTION>
					<%}
					%>

				</select></DIV>
				</DIV>
				</td>			
			</tr>
			
<%--	state end	venue	----%>
		
				<tr width="90%" class="contentLight">
				<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;City
				</td>
				<td>
				<input class="textBoxAdmin" type="text"	name="entry5" size="30" onKeyUp="javascript:obj6.bldUpdate5(event);" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)">
				 <input  class="button1"	id="show2" type="button" value="V" onClick="changeList5();">
				<a  href="LocationMaster.jsp">Add City and Map</a>		
				<DIV align="left" style="width:250px">
				<DIV id="lister5" style="display:none;position:absolute;z-index:+10;">
				<select class="input" style="width:6cm" id="itemlist5" name="itemlist5" size="5"
				onclick="update5(event)" onkeypress="update5(event)">
				</select></DIV>
				</DIV>
				</td>

			</tr>			
			 <tr align="left" class="contentDark">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pin:</td>
				<td><input class="textBoxAdmin" type="text" name="txtvenuepin" id="txtvenuepin"  onKeyPress="return keyRestrict(event,' -_/.,()!1234567890');" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)" size="30"  value=""maxlength="9"></td>
			</tr>
			
			<tr width="90%" class="contentLight">
				<td align="right" colspan="2">
					<input class="button1" type="button" id="btnsubmit" name="btnsubmit"	value="Submit" onclick="callNextPage('A')"> 
					<input  class="button1" type="button" id="btnCancel" name="btnCancel" value="Reset"	onclick="cancellation()">
					<input  class="button1" type="button" id="btnDelete" name="btnDelete" value="Delete"  onclick="callNextPage('D')">		
                  	<input class="button1"  type="button" id="page" name="page"value="Records" onclick="showrecord()"> 
					<input  class="button1" type="hidden" id="hdSubmit"	name="hdSubmit" value=""></td>
					<input   type="hidden" id="hiddenval" name="hiddenval" value=""/>	
					<input   type="hidden" id="hiddenval1" name="hiddenval1" value=""/>	
				 	<input   type="hidden" id="hiddenval2" name="hiddenval2" value=""/>
			        <input   type="hidden" id="hiddenval3" name="hiddenval3" value=""/>	
			        <input   type="hidden" id="hiddenval4" name="hiddenval4" value=""/>		        
			        <input   type="hidden" id="hditemlist4" name="hditemlist4" value=""/>
			        <input   type="hidden" id="hditemlist5" name="hditemlist5" value=""/>		        
			        <input   type="hidden" id="hditemlist6" name="hditemlist6" value=""/>
			        <input   type="hidden" id="hiddenvenueClub" name="hiddenvenueClub" value=""/>	
			        <input type="hidden" id="hdpage" name="hdpage" value="1"/>
			</tr>
		</table>
		<br>
		</fieldset>
	</tr>
	
</TABLE>
  <br>
<br>
 
	
	<br>
	<br>
	<TABLE  align="center" width="70%">
	<tr>
	<td>
	<div id="paging"  style="display: none;">
	<input class="button" type="button" id="back" name="back" value="Back  "  onclick="nextpage('decrease');"/>
    <input class="button"  type="button" id="next" name="next" value="Next  " onclick="nextpage('increase');"> 
	
	<SELECT class="input"  id="status" name="status" onchange="setmode()">
	<option value="A" >Present Records </option>
	<option value="D" >Deleted Records</option>
	</SELECT>
	<br>
	<br>
	<div id="pagingpages"  style="display: block">
	</div>
	</div>
	</tr>
	</td>
	</table>	
</form>
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
