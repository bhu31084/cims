<!--
Page Name:    RegionMaster.jsp
Author 		 : Swapnilgupta.
Created Date : 20th Sep 2008
Description  : Selection of Region Master 
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
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

      	CachedRowSet crsObjResult             = null;
		CachedRowSet crsObjResultState        = null;
		CachedRowSet crsObjResultZone         = null;
	    CachedRowSet 	crsObjClubsearch      =null;
	    CachedRowSet 	crsObjVenuesearch      =null;
	    CachedRowSet 	crsObjResultstate      =null;//for state master insertion
	    CachedRowSet 	crsObjResultvenue      =null;
	    String gsclubname                      =null;
	    String gsstateid                      =null;
	    String gszoneid                         =null;
	    String gsclubid                        =null;
	    String clubname                        =null;
	    String statename                       =null;
	    String gsStateid                    =null;
	    String gsStatename                   =null;
	    String gsCountryname                   =null;
	     
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
          //Variables for country master
        
		Vector vparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		try {
			if (request.getParameter("hdSubmit") != null
					&& (request.getParameter("hdSubmit").equals("submit")||request.getParameter("hdSubmit").equals("delete")))
					 {
				/*For insertion of record in database.*/
				 gsclubid = request.getParameter("itemlist2");
				 gsclubname = request.getParameter("txtassociation");
				 gsstateid = request.getParameter("itemlist");
				 gszoneid = request.getParameter("itemlist1");
				
				 statename = request.getParameter("entry");
				 clubname = request.getParameter("entry1");
				vparam.add(gsclubid);//
				vparam.add(gsclubname);//
				vparam.add(gsstateid);//		
				vparam.add(gszoneid);//
				vparam.add("2");//
				vparam.add(request.getParameter("hiddenval"));
				crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
						"esp_amd_clubsmst", vparam, "ScoreDB");
				vparam.removeAllElements();
			}
			
			if (request.getParameter("hdSubmit") != null
					&& request.getParameter("hdSubmit").equals("submit1")) {
				/*For insertion of record in database.*/
				gsStateid = request.getParameter("itemlist3");
				 gsStatename = request.getParameter("txtstate");
				 gsCountryname = request.getParameter("country");
				vparam.add(gsStateid);//
				vparam.add(gsStatename);//
				//vparam.add(gsCountryname);//
				System.out.println("vector" + vparam);
				crsObjResultstate = lobjGenerateProc.GenerateStoreProcedure(
						"esp_amd_statessmst", vparam, "ScoreDB");
				vparam.removeAllElements();
			}

          if (request.getParameter("hdSubmit") != null
					&& (request.getParameter("hdSubmit").equals("submit2")||request.getParameter("hdSubmit").equals("delete2")))
					 {
				venueid	=request.getParameter("itemlist6"); 
			     if(request.getParameter("hiddenval1").equals("venue"))
			     {
				 venuelocation =request.getParameter("hiddenval2");
				 }
				 else{
				  venuelocation = request.getParameter("itemlist5");
				 }
				 venuename = request.getParameter("txtvenue");
				 venueadd = request.getParameter("txtvenueadd");
				 venuestreet = request.getParameter("txtvenuestreet");
				 venueplot = request.getParameter("txtvenueplot");
				 venueend1 = request.getParameter("txtvenueend1");
				 venueend2 = request.getParameter("txtvenueend2");
				 venuepincode = request.getParameter("txtvenuepin");
				 venuedistrict = request.getParameter("txtvenuedistrict");				
				 veneulocationname = request.getParameter("entry5");
				 venuestatus=request.getParameter("hiddenval");
				 
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
			    vparam.add(venuestatus);//;
				crsObjResultvenue = lobjGenerateProc.GenerateStoreProcedure(
						"esp_amd_venuessmst", vparam, "ScoreDB");
				vparam.removeAllElements();
			
			}
			
			
			if (request.getParameter("hdSubmit") != null
					&& (request.getParameter("hdSubmit").equals("submit3")||request.getParameter("hdSubmit").equals("delete3")))
					 {
				/*For insertion of record in database.*/
			System.out.print("country");
			
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
<title>Region Master</title>

<style>
.roundcont {
	width: 600px;
	background-color: #f90;
	color: #fff;
}

.roundcont p {
	margin: 0 10px;
}

.roundtop { 
	background: url(../../images1/tr.gif) no-repeat top right; 
}

.roundbottom {
	background: url(../../images1/br.gif) no-repeat top right; 
}

img.corner {
   width: 15px;
   height: 15px;
   border: none;
   display: block !important;
}

FIELDSET {
 background-color: F8ECE0;
	border-color: orange
}

B {
	color: #ff6600
}

HR {
	color: orange;
}
.button{
background-color: white;
}

</style>






<script type="text/javascript">
  var flag="addDiv";
   var xmlHttp=null;
  function edit(){  
 	document.getElementById("editRolediv1").style.display = "block";
    document.getElementById("editRolediv2").style.display = "block";
  }
function edit1(){  
 	document.getElementById("editRolediv3").style.display = "block";
    document.getElementById("editRolediv4").style.display = "block";
  }
  function edit2(){  
 	document.getElementById("editRolediv10").style.display = "block";
    document.getElementById("editRolediv11").style.display = "block";
  }

function callNextPage(str){
           if(str=="delete"||str=="delete3"||str=="delete2")
           {
            document.getElementById('hiddenval').value ="D";
           }
           else{
            document.getElementById('hiddenval').value = "A";	
           }		
		    document.getElementById('hdSubmit').value = str;
		    
		    
		    if(str=="submit"||str=="delete"){
		    	if(textValidate()){
					document.regionMaster.action = "/cims/jsp/admin/RegionMaster.jsp";
					document.regionMaster.submit();	
				}
			}
			 if(str=="submit2"||str=="delete2"){
		    	if(textValidatevenue()){		 
					document.regionMaster.action = "/cims/jsp/admin/RegionMaster.jsp";
					document.regionMaster.submit();	
				}
			}
		}
		
		function textValidate(){
		 	var clubtxt=document.getElementById('txtassociation').value;		
		 	var alphaExp = /^[a-zA-Z 0-9]+$/;
		 	var code1 =clubtxt.charCodeAt(0);
		 	var code2 =clubtxt.charCodeAt(1);
		 	var code3 =clubtxt.charCodeAt(2);
		 	var code4 =clubtxt.charCodeAt(3);
			if(clubtxt.match(alphaExp)&&((code1 >= 65 && code1 <= 90) ||(code1 >= 96 && code1 <= 122))&&
			   ((code2 >= 65 && code2 <= 90) ||(code2 >= 96 && code2 <= 122))&&((code3 >= 65 && code3 <= 90) ||(code3 >= 96 && code3 <= 122))
			   &&((code4 >= 65 && code4 <= 90) ||(code4 >= 96 && code4 <= 122))){
			   if(document.getElementById('itemlist').value!="")
			   {
				if(document.getElementById('itemlist1').value!="")
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
			    alert("Clubname should start with alphabets,minimum first four letter");
				return false;
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
	        var alphaExp1 = /^[a-zA-Z ]+$/; 
		 	var alphaExp = /^[a-zA-Z , . 0-9]+$/;
		 	var alphaExp2 = /^[ 0-9]+$/;
		 	var code1 =Venuetxt.charCodeAt(0);
		 	var code2 =Venuetxt.charCodeAt(1);
		 	var code3 =Venuetxt.charCodeAt(2);
		 	var code4 =Venuetxt.charCodeAt(3);
			if(Venuetxt.match(alphaExp1)&&((code1 >= 65 && code1 <= 90) ||(code1 >= 96 && code1 <= 122))&&
			   ((code2 >= 65 && code2 <= 90) ||(code2 >= 96 && code2 <= 122))&&((code3 >= 65 && code3 <= 90) ||(code3 >= 96 && code3 <= 122))
			   &&((code4 >= 65 && code4 <= 90) ||(code4 >= 96 && code4 <= 122))){
			   if(Venueadd.match(alphaExp))
			   {
				if(Venueplot.match(alphaExp))
				{
				if(Venuedist.match(alphaExp1))
				{
				if(Venuestreet.match(alphaExp1))
				{
				if(Venueend1.match(alphaExp1)&&Venueend2.match(alphaExp1))
				{
					if(document.getElementById("hiddenval2").value!=""||document.getElementById('itemlist5').value!="")
				{
			
				if(Venuepin.match(alphaExp2))
				{
				return true;
				}				
				else{
					 alert("enter pincode in digits");
				return false;
				}
				}				
				else{
					 alert("select state and city");
				return false;
				}
				
				}				
				else{
					 alert("enter end1 and end2 should contain alphabets");
				return false;
				}
				}
				else{
				 alert("Street should contain alphabets");
				return false;
				}
				
				return true;
				}
				else{
				 alert("Destrict should contain alphabets");
				return false;
				}
				}
				else{
				alert("Plot should contain alphabets, digits, comma(,), fullstop (.)");
				return false;
				}
				}
			   else{
			    alert("Address should contain alphabets, digits, comma(,), and fullstop (.)");
				return false;
				}
			}else{
			    alert("Venue  name should contain alphabets,minimum first four letter");
				return false;
			}
		 }
		
		
		
			
		
	 function cancellation(){
	        document.getElementById('itemlist1').value="";
	        document.getElementById('itemlist').value="";
	        document.getElementById('itemlist2').value="";
	 		document.getElementById('txtassociation').value="";
			document.regionMaster.action = "/cims/jsp/admin/RegionMaster.jsp";	
			document.getElementById('editRolediv7').style.display="none";
			document.getElementById('editRolediv8').style.display="none";		
			document.getElementById('editRolediv1').style.display="none";
			document.getElementById('editRolediv2').style.display="none";
			document.getElementById('entry').value="";
	 		document.getElementById('entry1').value="";
	 		
					
		}
		
		 function cancellation1(){
		 	document.getElementById('editRolediv9').style.display="none";			
		    document.getElementById('editRolediv10').style.display="none";
			document.getElementById('editRolediv11').style.display="none";
		    document.getElementById("txtvenue").value =""   ;          
            document.getElementById("txtvenueadd").value = "";
            document.getElementById("txtvenueplot").value =  ""    ;    
			document.getElementById("txtvenuedistrict").value = "";
		    document.getElementById("hiddenval2").value = ""     ;
			document.getElementById("txtvenueend1").value = "";
			document.getElementById("txtvenueend2").value =	""	 ;			
            document.getElementById("entry4").value ="";
			document.getElementById("entry5").value ="";
			document.getElementById("itemlist4").value ="";
			document.getElementById("itemlist5").value ="";
			document.getElementById("txtvenuepin").value ="";
			document.getElementById('txtvenuestreet').value="";
		 
		}	
		
			
 function expandContract(id) {
    document.getElementById(flag).style.display ="none";	
    flag =id;
	var divDisplay = document.getElementById(id).style.display;
	var setStyle = "";
	if (divDisplay == "block") {
		setStyle = "none";
	} else {
		setStyle = "block";
	}
    document.getElementById(id).style.display = setStyle;	
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
        this.bldUpdate3 = bldUpdate3;
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
      function bldUpdate() {
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList();
        var j = 0;
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
        document.forms[this.formname][this.selname].options.length = j;
        // If only one option meets the user's entry, select it, put the text in the field,
        // and close the list.
        if(j==1){
          document.forms[this.formname][this.selname].options[0].selected = true;
          document.forms[this.formname][this.textname].value = document.forms[this.formname][this.selname].options[0].text;
          hideList();
        }
        // If none of the options in the list meet the user's input, close list
        if (j==0) {
          hideList();
        }
      }
      
      
         function bldUpdate1() {
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList1();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList1();
        var j = 0;
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
        document.forms[this.formname][this.selname].options.length = j;
        // If only one option meets the user's entry, select it, put the text in the field,
        // and close the list.
        if(j==1){
          document.forms[this.formname][this.selname].options[0].selected = true;
          document.forms[this.formname][this.textname].value = document.forms[this.formname][this.selname].options[0].text;
          hideList1();
        }
        // If none of the options in the list meet the user's input, close list
        if (j==0) {
          hideList1();
        }
      }
      
      
       function bldUpdate2() {
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList1();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList2();
        var j = 0;
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
        document.forms[this.formname][this.selname].options.length = j;
        // If only one option meets the user's entry, select it, put the text in the field,
        // and close the list.
        if(j==1){
          document.forms[this.formname][this.selname].options[0].selected = true;
          document.forms[this.formname][this.textname].value = document.forms[this.formname][this.selname].options[0].text;
          hideList2();
        }
        // If none of the options in the list meet the user's input, close list
        if (j==0) {
          hideList2();
        }
      }
      
      
       function bldUpdate3() {
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList3();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList3();
        var j = 0;
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
        document.forms[this.formname][this.selname].options.length = j;
        // If only one option meets the user's entry, select it, put the text in the field,
        // and close the list.
        if(j==1){
          document.forms[this.formname][this.selname].options[0].selected = true;
          document.forms[this.formname][this.textname].value = document.forms[this.formname][this.selname].options[0].text;
          hideList3();
        }
        // If none of the options in the list meet the user's input, close list
        if (j==0) {
          hideList3();
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
        showList4();
        var j = 0;
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
        document.forms[this.formname][this.selname].options.length = j;
        // If only one option meets the user's entry, select it, put the text in the field,
        // and close the list.
        if(j==1){
          document.forms[this.formname][this.selname].options[0].selected = true;
          document.forms[this.formname][this.textname].value = document.forms[this.formname][this.selname].options[0].text;
          hideList4();
        }
        // If none of the options in the list meet the user's input, close list
        if (j==0) {
          hideList4();
        }
      }
      
        function bldUpdate5() {
          document.getElementById("hiddenval2").value="";
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList5();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList5();
        var j = 0;
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
        document.forms[this.formname][this.selname].options.length = j;
        // If only one option meets the user's entry, select it, put the text in the field,
        // and close the list.
        if(j==1){
          document.forms[this.formname][this.selname].options[0].selected = true;
          document.forms[this.formname][this.textname].value = document.forms[this.formname][this.selname].options[0].text;
          hideList5();
        }
        // If none of the options in the list meet the user's input, close list
        if (j==0) {
          hideList5();
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
        showList6();
        var j = 0;
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
        document.forms[this.formname][this.selname].options.length = j;
        // If only one option meets the user's entry, select it, put the text in the field,
        // and close the list.
        if(j==1){
          document.forms[this.formname][this.selname].options[0].selected = true;
          document.forms[this.formname][this.textname].value = document.forms[this.formname][this.selname].options[0].text;
          hideList6();
        }
        // If none of the options in the list meet the user's input, close list
        if (j==0) {
          hideList6();
        }
      }
      
      function setUp() {
        obj1 = new SelObj('regionMaster','itemlist','entry');
        obj1.bldInitial();
         obj2 = new SelObj('regionMaster','itemlist1','entry1');
        obj2.bldInitial();  
        obj3 = new SelObj('regionMaster','itemlist2','entry2');
        obj3.bldInitial(); 
        obj4 = new SelObj('regionMaster','itemlist3','entry3');
        obj4.bldInitial(); 
        obj5 = new SelObj('regionMaster','itemlist4','entry4');
        obj5.bldInitial(); 
        obj6 = new SelObj('regionMaster','itemlist5','entry5');
        obj6.bldInitial(); 
         obj7 = new SelObj('regionMaster','itemlist6','entry6');
        obj7.bldInitial(); 
      }
      <!-- Functions Below Added by Steven Luke -->
      function update() {
      
        // document.getElementById("hiddenval").value = "selectvalue";
        document.regionMaster.entry.value = document.regionMaster.itemlist.options[document.regionMaster.itemlist.selectedIndex].text;
        hideList();
      }
       function update1() {
      
        // document.getElementById("hiddenval").value = "selectvalue";
        document.regionMaster.entry1.value = document.regionMaster.itemlist1.options[document.regionMaster.itemlist1.selectedIndex].text;
        hideList1();
      }
      
        function update2() {
      
        // document.getElementById("hiddenval").value = "selectvalue";
        document.regionMaster.entry2.value = document.regionMaster.itemlist2.options[document.regionMaster.itemlist2.selectedIndex].text;
        hideList2();
      }
        function update3() {
      
        // document.getElementById("hiddenval").value = "selectvalue";
        document.regionMaster.entry3.value = document.regionMaster.itemlist3.options[document.regionMaster.itemlist3.selectedIndex].text;
        hideList3();
      }
        function update4() {
      
        // document.getElementById("hiddenval").value = "selectvalue";
        document.regionMaster.entry4.value = document.regionMaster.itemlist4.options[document.regionMaster.itemlist4.selectedIndex].text;
        hideList4();
      }
       function update5() {
      
        // document.getElementById("hiddenval").value = "selectvalue";
        document.regionMaster.entry5.value = document.regionMaster.itemlist5.options[document.regionMaster.itemlist5.selectedIndex].text;
        hideList5();
      }
       function update6() {
      
        // document.getElementById("hiddenval").value = "selectvalue";
        document.regionMaster.entry6.value = document.regionMaster.itemlist6.options[document.regionMaster.itemlist6.selectedIndex].text;
        hideList6();
      }
      function showList() {
        document.getElementById("lister").style.display="block";
      }
   
     function showList1() {
        document.getElementById("lister1").style.display="block";
      }
   
       function showList2() {
        document.getElementById("lister2").style.display="block";
      }
       function showList3() {
        document.getElementById("lister3").style.display="block";
      }
      
        function showList4() {
        document.getElementById("lister4").style.display="block";
      }
        function showList5() {
        document.getElementById("lister5").style.display="block";
      }
       function showList6() {
        document.getElementById("lister6").style.display="block";
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
        if(valName!="")
        {
        var url = "/cims/jsp/admin/ClubSearchfromcombo.jsp?ClubId="+valName;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
		}
      }
       function hideList3() {
        document.getElementById("lister3").style.display="none";	
      
      } 
      function hideList4() {
        document.getElementById("lister4").style.display="none";
        document.getElementById("hiddenval1").value="state"        	
        xmlHttp = GetXmlHttpObject();
        var valName=document.regionMaster.itemlist4.value;
        var url = "/cims/jsp/admin/CitybyStateajax.jsp?StateId="+valName;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);	
      
      }
        function hideList5() {
        document.getElementById("lister5").style.display="none";
      }
        function hideList6() {
        document.getElementById("lister6").style.display="none";
         document.getElementById("hiddenval1").value="venue";
         xmlHttp = GetXmlHttpObject();
        var valName=document.regionMaster.itemlist6.value;
        var url = "/cims/jsp/admin/VenueMasterfromcombo.jsp?VenueId="+valName;
		xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);	
      
        
      }
      
      function changeList() {
        if (document.getElementById("lister").style.display=="none")
          showList();
        else
          hideList();
      }
      
        function changeList1() {
        if (document.getElementById("lister1").style.display=="none")
          showList1();
        else
          hideList1();
      }
     
       function changeList2() {
        if (document.getElementById("lister2").style.display=="none")
          showList2();
        else
          hideList2();
      }
        function changeList3() {
        if (document.getElementById("lister3").style.display=="none")
          showList3();
        else
          hideList3();
      }
       function changeList4() {
        if (document.getElementById("lister4").style.display=="none")
          showList4();
        else
          hideList4();
      }
        
         function changeList5() {
    
          
        if (document.getElementById("lister5").style.display=="none")
          showList5();
        else
          hideList5();
      }
         function changeList6() {
        if (document.getElementById("lister6").style.display=="none")
          showList6();
        else
          hideList6();
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
			document.getElementById("itemlist").value = xmlDoc.getElementsByTagName("ID")[0].childNodes[0].nodeValue;             
            document.getElementById("txtassociation").value = xmlDoc.getElementsByTagName("Name")[0].childNodes[0].nodeValue;             
            document.getElementById("entry").value = xmlDoc.getElementsByTagName("Statename")[0].childNodes[0].nodeValue;           
			document.getElementById("entry1").value = xmlDoc.getElementsByTagName("Zonename")[0].childNodes[0].nodeValue;
			document.getElementById("itemlist").value = xmlDoc.getElementsByTagName("State")[0].childNodes[0].nodeValue;           
			document.getElementById("itemlist1").value = xmlDoc.getElementsByTagName("Zone")[0].childNodes[0].nodeValue;
		    document.getElementById("hiddenval1").value="null";
		}  
		if(document.getElementById("hiddenval1").value=="state")
		{
		   var mdiv =document.getElementById('lister5');
			mdiv.innerHTML=responseResult;
		}
		   if(document.getElementById("hiddenval1").value=="venue")
			   {
			   
			document.getElementById("txtvenue").value = xmlDoc.getElementsByTagName("Name")[0].childNodes[0].nodeValue;             
            document.getElementById("txtvenueadd").value = xmlDoc.getElementsByTagName("ADD")[0].childNodes[0].nodeValue;             
            document.getElementById("txtvenueplot").value = xmlDoc.getElementsByTagName("Plot")[0].childNodes[0].nodeValue;           
			document.getElementById("txtvenuedistrict").value = xmlDoc.getElementsByTagName("Disc")[0].childNodes[0].nodeValue;			          
			document.getElementById("txtvenuestreet").value = xmlDoc.getElementsByTagName("Street")[0].childNodes[0].nodeValue;
		    document.getElementById("hiddenval2").value = xmlDoc.getElementsByTagName("LocId")[0].childNodes[0].nodeValue;
		              
			document.getElementById("txtvenueend1").value = xmlDoc.getElementsByTagName("End1")[0].childNodes[0].nodeValue;           
			document.getElementById("txtvenueend2").value = xmlDoc.getElementsByTagName("End2")[0].childNodes[0].nodeValue; 		 			
            document.getElementById("entry4").value =xmlDoc.getElementsByTagName("State")[0].childNodes[0].nodeValue;
			document.getElementById("entry5").value =xmlDoc.getElementsByTagName("City")[0].childNodes[0].nodeValue;
			document.getElementById("txtvenuepin").value =xmlDoc.getElementsByTagName("Pin")[0].childNodes[0].nodeValue; 
		 
			  }
			  }
			catch(e)
			  {
					alert(e.message);
			  }
		}
		
		 
  }	
</script>
</head>
<body OnLoad="javascript:setUp()">

<jsp:include page="Menu.jsp"></jsp:include>
<br>
<br>
<FORM name="regionMaster" id="regionMaster" method="post"><br>
<center>
<input style="color: white;border-width: .5mm;background-color: #ffccoo;border-color: white;font-size: 110%;font-weight: bold;"  type="button" value="club master" onclick="expandContract('addDiv')"> 
<input style="color: white;border-width: .5mm;background-color:#ffccoo;border-color: white;font-size: 110%;font-weight: bold;"  type="button" value="state master" onclick="expandContract('addDiv1')">
<input style="color: white;border-width: .5mm;background-color:#ffccoo;border-color: white;font-size: 110%;font-weight: bold;"  type="button" value="venue master" onclick="expandContract('addDiv2')">
<input style="color: white;border-width: .5mm;background-color:#ffccoo;border-color: white;font-size: 110%;font-weight: bold;"  type="button" value="country master"	onclick="expandContract('addDiv3')">
</center>
<br>
<br>

<%--          Club Master--%>
<div id="addDiv" style="display: none;">
<table width="40%" align="center" style="border-top: 1cm;">
	<tr>
				 <div class="roundcont">
                        <div class="roundtop">
	                    <img src="../../images1/tl.gif" alt=""  width="15" height="15" class="corner"  style="display: none" />
                              </div>
                             <center>Club Master </center>
                                   <div class="roundbottom">
	                                       <img src="../../images1/bl.gif" alt=""  width="15" height="15" class="corner" 	 style="display: none" />
                                        </div>
                       </div>
			</tr>
	<tr>
		     <td>
		       <hr>
		        </td>
	</tr>
	<tr>
		     <td>
		         <fieldset id="fldsetvenue"><legend> 
		                <font size="3" color="#003399">
		                   <b>ClubMaster </b></font> </legend> <br>
		<table align="center" width="90%" class="TDData">
		
<%--	search	----%>
<tr align="left">
				<td style="font-weight: bold">
				<div id="editRolediv1" style="display: none;"><b>Search</b></div>
				</td>
				<td>
				<div id="editRolediv2" style="display: none;">
				<input type="text"	name="entry2" size="30" onKeyUp="javascript:obj3.bldUpdate2();">
				 <input	 class="button" id="show2" type="button" value="V" onClick="changeList2();"></div>
				<DIV align="left" style="width:250px">
				<DIV id="lister2" style="display:none;position:absolute;z-index:+10;">
				<select style="width:6.2cm" id="itemlist2" name="itemlist2" size="5"
					onChange="update2()">					
                  	<%while (crsObjClubsearch.next()) {
			        %>
					<OPTION value="<%=crsObjClubsearch.getString("id")%>"><%=crsObjClubsearch.getString("name")%></OPTION>
					<%}%>
				</select></DIV>
				</DIV>
				</td>

			</tr>
<%----search end--%>
		
			<tr>
				<td nowrap="nowrap"><b>Association Name:</b></td>
				<td><input type="text" name="txtassociation" id="txtassociation" size="30"  value="" maxlength="50"></td>
			</tr>
			
<%--	state		----%>
			<tr align="left">
				<td style="font-weight: bold">
				<b>State:</b>
				</td>
				<td>
				<input type="text"	name="entry" size="30" onKeyUp="javascript:obj1.bldUpdate();"> 
				<input  class="button"	id="show" type="button" value="V" onClick="changeList();">
			

				<DIV align="left" style="width:250px">
				<DIV id="lister" style="display:none;position:absolute;z-index:+10;">
				<select style="width:6.2cm" id="itemlist" name="itemlist" size="5"
					onChange="update()">
                  
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
			<tr align="left">
				<td style="font-weight: bold">
				<b>Zone:</b>
				</td>
				<td>
				<input type="text"	name="entry1" size="30" onKeyUp="javascript:obj2.bldUpdate1();"> 
				<input  class="button"	id="show1" type="button" value="V" onClick="changeList1();">
				

				<DIV align="left" style="width:250px">
				<DIV id="lister1" style="display:none;position:absolute;z-index:+10;">
				<select style="width:6.2cm" id="itemlist1" name="itemlist1" size="5"
					onChange="update1()">

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
		
		</table>
		</fieldset>
		</td>
	</tr>
	<tr>
		<td align="right">
		<input  class="button" type="button" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callNextPage('submit')"> 
		<input  class="button" type="button" id="btnCancel" name="btnCancel" value="Reset" 	onclick="cancellation()">
		<input  class="button" type="button" id="btnEdit" name="btnEdit" value="Edit" 	onclick="edit()">
		<input  class="button" type="button" id="btnDelete" name="btnDelete" value="Delete"  onclick="callNextPage('delete')">
		 <input type="hidden" id="hdSubmit"	name="hdSubmit" value=""></td>
		  <input type="hidden" id="hiddenval" name="hiddenval" value=""/>
		     <input type="hidden" id="hiddenval2" name="hiddenval2" value="null"/>
	</tr>
</TABLE>
<br>
<br>
      <div id="editRolediv7" style="display: block;">
		<%if (crsObjResult != null) {
			while (crsObjResult.next()) {
				%>

		<table width="60%"  align="center" border="1"	id="displayResult" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="6" align="center" style="background-color:orange;"><font
					size="3" color="white"><%=crsObjResult.getString("RetVal")%></font></td>
			</tr>
			<tr>
				
				
				<td style="font-weight: bold">AssociationName</td>
				<td style="font-weight: bold">State</td>
				<td style="font-weight: bold">Zone</td>
			</tr>
			<tr>
			
				<td><%=gsclubname%></td>
				<td><%=statename%></td>
				<td><%=clubname%></td>
			</tr>
		</table>
		<%}
		}
	%></div>	
</div>
<%--Club master end--%>


<%--        State Master--%>

   <div id="addDiv1" style="display: none;">
    <table width="40%" align="center" style="border-top: 1cm;">
	<tr>
				 <div class="roundcont">
                        <div class="roundtop">
	                    <img src="../../images1/tl.gif" alt=""  width="15" height="15" class="corner"  style="display: none" />
                              </div>
                             <center>State Master </center>
                                   <div class="roundbottom">
	                                       <img src="../../images1/bl.gif" alt=""  width="15" height="15" class="corner" 	 style="display: none" />
                                        </div>
                       </div>
			</tr>
	<tr>
		<td>
		<hr>
		</td>
	</tr>
	<tr>
		<td>
		<fieldset id="fldsetvenue"><legend> <font size="3" color="#003399"> <b>State
		Master </b></font> </legend> <br>
		<table align="center" width="90%" class="TDData">
		
		
		
		
		
		<%--	search	state----%>
            <tr align="left">
				<td style="font-weight: bold">
				<div id="editRolediv3" style="display: none;">Search</div>
				</td>
				<td>
				<div id="editRolediv4" style="display: none;">
				<input type="text"	name="entry3" size="30" onKeyUp="javascript:obj4.bldUpdate3();">
				 <input	id="show2" type="button" value="V" onClick="changeList3();"></div>
				<DIV align="left" style="width:250px">
				<DIV id="lister3" style="display:none;position:absolute;z-index:+10;">
				<select style="width:6.2cm" id="itemlist3" name="itemlist3" size="5"
					onChange="update3()">
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
			<tr>
				<td><b>State Name:</b></td>
				<td><input type="text" name="txtstate" id="txtstate" value=""maxlength="9"></td>
			</tr>

			<tr>
				<td><b>Country :</b></td>
				<td><select name="country" id="country">
					<option value="1">India</option>
				</select></td>
			</tr>

		</table>
		</fieldset>
	</tr>
	<tr>
		<td align="right">
		<input  class="button" type="button" id="btnsubmit" name="btnsubmit"	value="Submit" onclick="callNextPage('submit1')"> 
		<input  class="button" type="button" id="btnCancel" name="btnCancel" value="Reset"	onclick="cancellation()">
		 <input  class="button" type="button" id="btnEdit1" name="btnEdit1" value="Edit" 	onclick="edit1()">
		 <input type="hidden" id="hdSubmit"	name="hdSubmit" value=""></td>
	</tr>
</TABLE>
<br>
<br>
 <div id="editRolediv8" style="display: block;">
		<%if (crsObjResultstate != null) {
			while (crsObjResultstate.next()) {
				%>

		<table  align="center" border="1"
			id="displayResult" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="6" align="center" style="background-color:gainsboro;"><font
					size="3" color="#003399"><b><%=crsObjResultstate.getString("RetVal")%></b></font></td>
			</tr>
			<tr>
				
				<td style="font-weight: bold">Stateid</td>
				<td style="font-weight: bold">StateName</td>
			</tr>
			<tr>
				<td><%=crsObjResultstate.getString("id")%></td>
				<td><%=gsStatename%></td>
			</tr>
		</table>
		<%}
		}
	%></div>
   </div>	

<%--    Venue Master--%>
   <div id="addDiv2" style="display: none;">
    <table width="60%" align="center" style="border-top: 1cm;">
	<tr>
				 <div class="roundcont">
                        <div class="roundtop">
	                    <img src="../../images1/tl.gif" alt=""  width="15" height="15" class="corner"  style="display: none" />
                              </div>
                             <center>Venue Master </center>
                                   <div class="roundbottom">
	                                       <img src="../../images1/bl.gif" alt=""  width="15" height="15" class="corner" 	 style="display: none" />
                                        </div>
                       </div>
			</tr>
	<tr>
		<td>
		<hr>
		</td>
	</tr>
	<tr>
		<td>
		<fieldset id="fldsetvenue"><legend> <font size="3" color="#003399"> <b>Venue Master </b></font> </legend> <br>
		<table align="center" width="70%" class="TDData">
		
<%--	search Venue	----%>
           <tr align="left">
				<td style="font-weight: bold">
				<div id="editRolediv10" style="display: none;"><b>Search</b></div>
				</td>
				<td>
				<div id="editRolediv11" style="display: none;">
				<input type="text"	name="entry6" size="30" onKeyUp="javascript:obj7.bldUpdate6();">
				 <input  class="button"	id="show2" type="button" value="V" onClick="changeList6();"></div>
				<DIV align="left" style="width:250px">
				<DIV id="lister6" style="display:none;position:absolute;z-index:+10;">
				<select style="width:6.2cm" id="itemlist6" name="itemlist6" size="5" onChange="update6()">	
				
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
	
			<tr>
				<td nowrap="nowrap"><b>Venue Name:</b></td>
				<td><input type="text" name="txtvenue" id="txtvenue" value=""maxlength="50"></td>
			</tr>
			
			<tr>
				<td><b>Address:</b></td>
				<td><TEXTAREA id="txtvenueadd" name="txtvenueadd" rows="2" cols="25"></TEXTAREA></td>
			</tr>
			 <tr>
				<td><b>Plot:</b></td>
				<td><input type="text" name="txtvenueplot" id="txtvenueplot" value=""maxlength="9"></td>
			</tr>
			
			 <tr>
				<td><b>District:</b></td>
				<td><input type="text" name="txtvenuedistrict" id="txtvenuedistrict" value=""maxlength="40"></td>
			</tr>
			
			 <tr>
				<td><b>Street:</b></td>
				<td><input type="text" name="txtvenuestreet" id="txtvenuestreet" value=""maxlength="40"></td>
			</tr>
			
			
			 <tr>
				<td><b>End1:</b></td>
				<td><input type="text" name="txtvenueend1" id="txtvenueend1" value=""maxlength="40"></td>
			</tr>
			
			 <tr>
				<td><b>End2:</b></td>
				<td><input type="text" name="txtvenueend2" id="txtvenueend2" value=""maxlength="40"></td>
			</tr>
          
<%--	state	venue	----%>
			<tr align="left">
				<td style="font-weight: bold">
				<b>State</b>
				</td>
				<td>
				<input type="text"	name="entry4" size="20" onKeyUp="javascript:obj5.bldUpdate();"> 
				<input  class="button"	id="show" type="button" value="V" onClick="changeList4();">	

				<DIV align="left" style="width:250px">
				<DIV id="lister4" style="display:none;position:absolute;z-index:+10;">
				<select style="width:4cm" id="itemlist4" name="itemlist4" size="5"
					onChange="update4()">

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
			<tr align="left">
				<td style="font-weight: bold">
				<b>City</b>
				</td>
				<td>
				<input type="text"	name="entry5" size="20" onKeyUp="javascript:obj6.bldUpdate5();"> 
				<input  class="button"	id="show" type="button" value="V" onClick="changeList5();">	

				<DIV align="left" style="width:250px">
				<DIV id="lister5" style="display:none;position:absolute;z-index:+10;">
				<select style="width:4cm" id="itemlist5" name="itemlist5" size="5"
					onChange="update5()">
				</select></DIV>
				</DIV>
				</td>

			</tr>
			
			 <tr>
				<td><b>Pin:</b></td>
				<td><input type="text" name="txtvenuepin" id="txtvenuepin" value=""maxlength="9"></td>
			</tr>
		</table>
		</fieldset>
	</tr>
	<tr>
		<td align="right">
		<input class="button" type="button" id="btnsubmit" name="btnsubmit"	value="Submit" onclick="callNextPage('submit2')"> 
		<input  class="button" type="button" id="btnCancel" name="btnCancel" value="Reset"	onclick="cancellation1()">
		 <input  class="button" type="button" id="btnEdit1" name="btnEdit1" value="Edit" 	onclick="edit2()">
		<input  class="button" type="button" id="btnDelete" name="btnDelete" value="Delete"  onclick="callNextPage('delete2')">
		 <input  class="button" type="hidden" id="hdSubmit"	name="hdSubmit" value=""></td>
		  <input   type="hidden" id="hiddenval" name="hiddenval" value=""/>		  
		   <input type="hidden" id="hiddenval1" name="hiddenval1" value="null"/>
	</tr>
</TABLE>
  <br>
<br>
 <div id="editRolediv9" style="display: block;">
		<%if (crsObjResultvenue != null) {
			while (crsObjResultvenue.next()) {
				%>

		<table width="60%"  align="center" border="1" id="displayResult" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="10" align="center" style="background-color:orange;"><font
					size="3" color="white"><%=crsObjResultvenue.getString("RetVal")%></font></td>
			</tr>
			<tr>
				
				
				<td style="font-weight: bold">VenueName</td>
				<td style="font-weight: bold">Venueadd</td>
				<td style="font-weight: bold">Venueplot</td>
				<td style="font-weight: bold">Venuedistrict</td>
				<td style="font-weight: bold">Venuestreet</td>
				<td style="font-weight: bold">VenueLocation</td>
				<td style="font-weight: bold">End1</td>
				<td style="font-weight: bold">End2</td>
				<td style="font-weight: bold">Pin</td>
			</tr>
			<tr>
			
				<td><%=venuename%></td>
				<td><%=venueadd%></td>
				<td><%=venueplot%></td>
				<td><%=venuedistrict%></td>
				<td><%=venuestreet%></td>
				<td><%=veneulocationname%></td>
				<td><%=venueend1%></td>
				<td><%=venueend2%></td>
				<td><%=venuepincode%></td>
			</tr>
		</table>
		<%}
		}
	%></div>
   </div>	
   
<%--   venue end master--%>
<%--  Country master --%>

 <div id="addDiv3" style="display: none;">
    <table width="40%" align="center" style="border-top: 1cm;">
	<tr>
				 <div class="roundcont">
                        <div class="roundtop">
	                    <img src="../../images1/tl.gif" alt=""  width="15" height="15" class="corner"  style="display: none" />
                              </div>
                             <center>Country Master </center>
                                   <div class="roundbottom">
	                                       <img src="../../images1/bl.gif" alt=""  width="15" height="15" class="corner" 	 style="display: none" />
                                        </div>
                       </div>
			</tr>
	<tr>
		<td><hr></td>
	</tr>
	<tr>
		<td>
		<fieldset id="fldsetvenue"><legend> <font size="3" color="#003399">
		 <b>Country	Master </b></font> </legend> <br>
		<table align="center" width="90%" class="TDData">
			<tr>
				<td><b>Country Name:</b></td>
				<td><input  type="text" name="txtvenue" id="txtvenue" value=""maxlength="20"></td>
			</tr>
			
          

		</table>
		</fieldset>
	</tr>
	<tr>
		<td align="right">
		<input  class="button" type="button" id="btnsubmit" name="btnsubmit"	value="Submit" onclick="callNextPage('submit3')"> 
		<input  class="button" type="button" id="btnCancel" name="btnCancel" value="Reset"	onclick="cancellation()">
		 <input  class="button" type="button" id="btnEdit1" name="btnEdit1" value="Edit" 	onclick="edit1()">
		 <input  class="button" type="button" id="btnDelete" name="btnDelete" value="Delete" onclick="callNextPage('delete3')">
		 <input type="hidden" id="hdSubmit"	name="hdSubmit" value=""></td>
	</tr>
</TABLE>
   </div>	
   
<%--  Countries end --%>
   
</form>


</body>
</html>
