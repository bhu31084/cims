<!--Page Name  : umpiringDecisionLog.jsp
Created By 	 :Swapnil G.
Created Date : 30th Aug 2008
Description  : Maintain the Umpire's Decision Log.
Company 	 : Paramatrix Tech Pvt Ltd.-->

<%@ page import="sun.jdbc.rowset.CachedRowSet,
            in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
            java.util.*"%>  
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>          
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
	java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String strMatch_id =(String)session.getAttribute("matchid");
	String loginUserName = null;
	loginUserName = session.getAttribute("usernamesurname").toString();
	CachedRowSet lobjCachedRowSet =	null;
	CachedRowSet lobjCachedRowSetumpirecoach = null;
	CachedRowSet lobjCachedRowSetupdate = null;
	CachedRowSet lobjCachedRowSetappeal	= null;
	CachedRowSet lobjCachedRowSetinsert = null;
	CachedRowSet lobjCachedRowSetumpire = null;
	CachedRowSet lobjCachedRowSetdisplay = null;
	CachedRowSet lobjCachedRowSetdelete = null;
	CachedRowSet crsObjRefereeDetail = null;
	LogWriter log = new LogWriter();
	
	
    //String strMatch_id="117";
    //String umpire_id="34285";
    String umpire_id =(String)session.getAttribute("userid");
	String umpireid= null;
    String umpire_mapid="0";
	int                         editcount                     =0;
	int                         count                           =0;
	
	GenerateStoreProcedure  	lobjGenerateProc 			=	new GenerateStoreProcedure();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	Vector 						vparam 						=  	new Vector();
	String                      username               		 =  null;
	String                      match                   	 = 	null;
	String                      day                     	 =	null;
	String                      gsaction                     =  null;	
	String                      giumpireid                   =  null  ;             
	String                      giappealid                    =null  ;
	String                      gibatsman                     =null;
    String                      giresult                       =null ;          
	String                      gsball                       =  null;
	String                      gibowler                       = null;
	String                      gireasonid                     =  null;
	String                      inningid                       =null;
	String                      inningcount                       =null;
	String                      gdesc                       =null;
	String                      gremark                       =null;
	String                      matchtype                       =null;
	String						teamnames					=null;
	
	gsaction = request.getParameter("Hidden");
	
	//for match details in top table
	
	try{
	vparam.add(strMatch_id); // Match_id
	
	try{
		lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_mobileinning",vparam,"ScoreDB");
	}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
	}
	
	vparam.removeAllElements();
	vparam.add("2");//role 2 for umpires
	vparam.add(strMatch_id); // Match_id
	
	try{
		lobjCachedRowSetumpire = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchumpire",vparam,"ScoreDB");
	}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
	}
	
	vparam.removeAllElements();
	try{
	 vparam.add(strMatch_id);
	 crsObjRefereeDetail = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_referee_feedbackdtls",vparam,"ScoreDB");
	 vparam.removeAllElements();
	
	}catch(Exception e){
	  e.printStackTrace();
	}
	
	vparam.removeAllElements();
	vparam.add("6");
	vparam.add(strMatch_id); // Match_id
	
	try{		
		lobjCachedRowSetumpirecoach = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchumpire",vparam,"ScoreDB");
	}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
	}	
	
	
	while(lobjCachedRowSetumpirecoach.next()){
	umpireid=lobjCachedRowSetumpirecoach.getString("id");
	if(umpireid.equals(umpire_id))
	{
	umpire_mapid=lobjCachedRowSetumpirecoach.getString("mapid");
	}
	else{
	if(umpire_id.equals("34291")){
	umpire_mapid=lobjCachedRowSetumpirecoach.getString("mapid");//admin
	}
	}
	
	}
	vparam.removeAllElements();
	vparam.add("0");
	
	try{
		lobjCachedRowSetappeal = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_appealsearch",vparam,"ScoreDB");
	}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
	}	
		vparam.removeAllElements();
		}
	catch(Exception e){
	e.printStackTrace();
	}
	

try {

	         if( gsaction != null )
	         {
	      
	         if( gsaction.equals("1") )
	         {
	            giumpireid        = request.getParameter("combUsername"); 
				inningid          = request.getParameter("dpInning");    
				giappealid        = request.getParameter("dpAppeal");
				gireasonid        = request.getParameter("dpReason");
			    gibowler       = request.getParameter("dpBowler");
				giresult           = request.getParameter("dpResult");
				gsball              =request.getParameter("dbover");				
				gibatsman       = request.getParameter("dpBatsmen");
				gdesc       = request.getParameter("dpDesc"); 
				gdesc       = request.getParameter("dpDesc"); 
				gremark       = request.getParameter("txtremark");  
  

				vparam.add(giumpireid);
				vparam.add(umpire_mapid);
				vparam.add(giappealid);
				vparam.add(gireasonid);
				vparam.add(giresult);
				vparam.add(gdesc);
				vparam.add(gsball);
				vparam.add(gibatsman);				
				vparam.add(gibowler);
			    vparam.add(inningid);
			    vparam.add(gremark);
                vparam.add("A");
	 
		try{	
			lobjCachedRowSetinsert =lobjGenerateProc.GenerateStoreProcedure("esp_amd_umpiredecisionmap",vparam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		}	
                vparam.removeAllElements();
                vparam.add(giumpireid);
				vparam.add(umpire_mapid);
				vparam.add(giappealid);
				vparam.add(gireasonid);
				vparam.add(giresult);
				vparam.add(gdesc);
				vparam.add(gsball);
				vparam.add(gibatsman);				
				vparam.add(gibowler);
			    vparam.add(inningid);			    
			    vparam.add(gremark);               
                vparam.add("S");

               
           try{     
                lobjCachedRowSetdisplay=lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
           }catch (Exception e) {
				System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
				log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		   }     
                vparam.removeAllElements();
               
			}
			if(gsaction.equals("4")){
	            giumpireid        = request.getParameter("combUsername"); 
				inningid          = request.getParameter("dpInning");    
				giappealid        = request.getParameter("dpAppeal");
				gireasonid        = request.getParameter("dpReason");
			    gibowler       = request.getParameter("dpBowler");
				giresult           = request.getParameter("dpResult");
				gsball              =request.getParameter("dbover");				
				gibatsman       = request.getParameter("dpBatsmen");
				gremark       = request.getParameter("txtremark"); 
				  
  

				vparam.add(giumpireid);
				vparam.add(umpire_mapid);
				vparam.add(giappealid);
				vparam.add(gireasonid);
				vparam.add(giresult);
				vparam.add(gdesc);
				vparam.add(gsball);
				vparam.add(gibatsman);				
				vparam.add(gibowler);
			    vparam.add(inningid);			    
			    vparam.add(gremark);
			     vparam.add("S");  
			   
		try{	              
               lobjCachedRowSetdisplay=lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
        }catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		}   
                vparam.removeAllElements();
			}
			
			
			 if( gsaction.equals("5") )
	          {
	            String editno=request.getParameter("Hiddencount");
				vparam.add(request.getParameter("ump"+editno));
				vparam.add(umpire_mapid);
				vparam.add(request.getParameter("app"+editno));
				vparam.add(request.getParameter("reas"+editno));
				vparam.add(request.getParameter("res"+editno));
				vparam.add(request.getParameter("des"+editno));
				vparam.add(request.getParameter("o"+editno));
				vparam.add(request.getParameter("bat"+editno));				
				vparam.add(request.getParameter("bow"+editno));
			    vparam.add(request.getParameter("i"+editno));			    
			    vparam.add(request.getParameter("rem"+editno));
			    vparam.add("E");
	           
		try{
			   lobjCachedRowSetupdate =lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		}   
               vparam.removeAllElements();              
               
               inningid          = request.getParameter("dpInning");  
	            giumpireid   = request.getParameter("combUsername"); 
				giappealid    = request.getParameter("dpAppeal");
				gireasonid     = request.getParameter("dpReason");
			    gibowler       = request.getParameter("dpBowler");
				giresult        = request.getParameter("dpResult");
				gsball           =request.getParameter("dbover");				
				gibatsman       = request.getParameter("dpBatsmen");
				gdesc       = request.getParameter("dpDesc"); 
				gremark       = request.getParameter("txtremark"); 
  

				vparam.add(giumpireid);
				vparam.add(umpire_mapid);
				vparam.add(giappealid);
				vparam.add(gireasonid);
				vparam.add(giresult);
				vparam.add(gdesc);
				vparam.add(gsball);
				vparam.add(gibatsman);				
				vparam.add(gibowler);
			    vparam.add(inningid);			    
			    vparam.add(gremark);
			     vparam.add("A");
	           
		try{		
			  lobjCachedRowSetinsert =lobjGenerateProc.GenerateStoreProcedure("esp_amd_umpiredecisionmap",vparam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		}	  
                 vparam.removeAllElements();
               
               vparam.add(giumpireid);
				vparam.add(umpire_mapid);
				vparam.add(giappealid);
				vparam.add(gireasonid);
				vparam.add(giresult);
				vparam.add(gdesc);
				vparam.add(gsball);
				vparam.add(gibatsman);				
				vparam.add(gibowler);
			    vparam.add(inningid); 
			     vparam.add(gremark);  
	            vparam.add("S");
               
           try{      
               lobjCachedRowSetdisplay=lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
           }catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		   }     
                vparam.removeAllElements();
			}

			
			
			
			
			if( gsaction.equals("2") )
	         
	          {
				
	            String deleteno=request.getParameter("Hiddencount");
				vparam.add(request.getParameter("ump"+deleteno));
				vparam.add(umpire_mapid);
				vparam.add(request.getParameter("app"+deleteno));
				vparam.add(request.getParameter("reas"+deleteno));
				vparam.add(request.getParameter("res"+deleteno));
				vparam.add(request.getParameter("des"+deleteno));
				vparam.add(request.getParameter("o"+deleteno));
				vparam.add(request.getParameter("bat"+deleteno));				
				vparam.add(request.getParameter("bow"+deleteno));
			    vparam.add(request.getParameter("i"+deleteno));
			     vparam.add(request.getParameter("rem"+deleteno));
			     vparam.add("D");
	         
		try{	
			lobjCachedRowSetdelete =lobjGenerateProc.GenerateStoreProcedure("esp_amd_umpiredecisionmap",vparam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		}	
                 vparam.removeAllElements();       
				vparam.add(request.getParameter("ump"+deleteno));
				vparam.add(umpire_mapid);
				vparam.add(request.getParameter("app"+deleteno));
				vparam.add(request.getParameter("reas"+deleteno));
				vparam.add(request.getParameter("res"+deleteno));
				vparam.add(request.getParameter("des"+deleteno));
				vparam.add(request.getParameter("o"+deleteno));
				vparam.add(request.getParameter("bat"+deleteno));				
				vparam.add(request.getParameter("bow"+deleteno));
			    vparam.add(request.getParameter("i"+deleteno));  
			     vparam.add(request.getParameter("rem"+deleteno));     
             vparam.add("S");
               
             try{    
               lobjCachedRowSetdisplay=lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
             }catch (Exception e) {
				System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
				log.writeErrLog(page.getClass(),strMatch_id,e.toString());
			 }  
                vparam.removeAllElements();
			}
			}//end if 
		}catch (Exception e) {
					e.printStackTrace();
				}	
		
		
		
	
%>
<html>
	<head>
	    <title>UMPIRING DECISION LOG </title>    
	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
	 <script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
<script language="javascript">	

 var xmlHttp=null;
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
 
 function deleteRecord(obj)
 {
       document.getElementById("Hiddencount").value=obj;
       var i="i"+obj;
       var o="o"+obj;
       var ump="ump"+obj;
       var bat="bat"+obj;
       var bow="bow"+obj;
       var app="app"+obj;
       var res="res"+obj;
       var des="des"+obj;
       var reas="reas"+obj;
       var rem="rem"+obj;
       var retval = confirm("Do you want to delete this record");
       if (retval==true) {     
            document.getElementById("Hidden").value="2";		      
    		document.frmUmpireDecisionLog.action = "/cims/jsp/umpiringDecisionLog.jsp";
    		document.frmUmpireDecisionLog.submit();
    		document.getElementById("Hidden").value="";
    		}
 }

 
 
 
 
 
       function changeColor(obj){
        document.getElementById(obj).style.backgroundColor="white";
       }
 
 
      function cancel(){
     
      document.getElementById("btnUpdate").disabled=true;
	  document.getElementById("btnSubmit").disabled=false;
	  document.getElementById('dpInning').value=0 ;
      document.getElementById('dbover').value="" ;
      document.getElementById('dpBatsmen').value=0 ;
      document.getElementById('dpBowler').value=0 ;
      document.getElementById('dpAppeal').value= 0;
      document.getElementById('dpResult').value= 0;
      document.getElementById('dpDesc').value= "Y";
      document.getElementById('dpReason').value=0;
      document.getElementById('combUsername').value=0;
       document.getElementById('txtremark').value="";
      }
 
        
      function edit(hiddcount){
       document.getElementById("btnUpdate").disabled=false;
	   document.getElementById("btnSubmit").disabled="disabled";
       document.getElementById("Hiddencount").value=hiddcount;
       var i="i"+hiddcount;
       document.getElementById("Hidden").value="2";      
       xmlHttp = GetXmlHttpObject();
       var valName=document.getElementById(i).value;    
       var url = "/cims/jsp/UmpireDecisionResponse.jsp?val="+valName+"&inning=inning";
	   //xmlHttp.onreadystatechange = displayData;
	   xmlHttp.open("get",url,false);
	   xmlHttp.send(null);
	   if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
		   var responseResult = xmlHttp.responseText;
		      try //Internet Explorer
			  {
			   if(document.getElementById("Hidden").value=="2"){
			  var cmbbox = responseResult.split("<br>");
			  var mdiv=document.getElementById("div1");
              mdiv.innerHTML=cmbbox[0];			 
              var mdiv=document.getElementById("div2");
              mdiv.innerHTML=cmbbox[1];
			  }if(document.getElementById("Hidden").value=="3"){
			  var mdiv=document.getElementById("div3");
              mdiv.innerHTML=responseResult;
			  }
			  document.getElementById("Hidden").value=="";
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
	   document.getElementById("Hidden").value="";  
       var o="o"+hiddcount;
       var ump="ump"+hiddcount;
       var bat="bat"+hiddcount;
       var bow="bow"+hiddcount;
       var app="app"+hiddcount;
       var res="res"+hiddcount;
       var des="des"+hiddcount;
       var reas="reas"+hiddcount;       
       var rem="rem"+hiddcount;
       document.getElementById("Hidden").value="3";	      
       xmlHttp = GetXmlHttpObject();
       var valName=document.getElementById(app).value;
       var url = "/cims/jsp/UmpireDecisionResponse.jsp?val="+valName+"&inning=appeal";
	  // xmlHttp.onreadystatechange = displayData;
	   xmlHttp.open("get",url,false);
	   xmlHttp.send(null);
       if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
		   var responseResult = xmlHttp.responseText ;
   		      try //Internet Explorer
			  {
			  if(document.getElementById("Hidden").value=="2"){
			  var cmbbox = responseResult.split("<br>");
			  var mdiv=document.getElementById("div1");
              mdiv.innerHTML=cmbbox[0];			 
              var mdiv=document.getElementById("div2");
              mdiv.innerHTML=cmbbox[1];
			  }if(document.getElementById("Hidden").value=="3"){
			  var mdiv=document.getElementById("div3");
              mdiv.innerHTML=responseResult;
			  }
			  document.getElementById("Hidden").value=="";
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
       document.getElementById("Hidden").value="";  
       document.getElementById('dpInning').value= document.getElementById(i).value;
       document.getElementById('dbover').value= document.getElementById(o).value;
       document.getElementById('dpBatsmen').value= document.getElementById(bat).value;
       document.getElementById('dpBowler').value= document.getElementById(bow).value;
       document.getElementById('dpAppeal').value= document.getElementById(app).value;
       document.getElementById('dpResult').value= document.getElementById(res).value;
       document.getElementById('dpDesc').value= document.getElementById(des).value;
       document.getElementById('dpReason').value= document.getElementById(reas).value;      
       document.getElementById('txtremark').value= document.getElementById(rem).value;
       document.getElementById('combUsername').value= document.getElementById(ump).value;
       xmlHttp = GetXmlHttpObject();
       var valName=document.frmUmpireDecisionLog.dpAppeal.value;
       var url = "/cims/jsp/UmpireDecisionResponse.jsp?val="+valName+"&inning=edit"+"&inningid="+document.getElementById(i).value+"&over="+document.getElementById(o).value+
        "&batsman="+document.getElementById(bat).value+"&bowler="+document.getElementById(bow).value+"&appealid="+document.getElementById(app).value+
        "&res="+document.getElementById(res).value+"&desc="+document.getElementById(des).value+"&reas="+document.getElementById(reas).value+
        "&umpire="+document.getElementById(ump).value+"&umpcoach="+document.getElementById("umpcoachid").value+"&umpcoach="+document.getElementById("umpcoachid").value+"&remark="+document.getElementById("txtremark").value;
	//	xmlHttp.onreadystatechange = displayData;
	   xmlHttp.open("get",url,false);
	   xmlHttp.send(null);
	   if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
		   var responseResult = xmlHttp.responseText ;
		      try //Internet Explorer
			  {
			   if(document.getElementById("Hidden").value=="2"){
			  var cmbbox = responseResult.split("<br>");
			  var mdiv=document.getElementById("div1");
              mdiv.innerHTML=cmbbox[0];			 
              var mdiv=document.getElementById("div2");
              mdiv.innerHTML=cmbbox[1];
			  }if(document.getElementById("Hidden").value=="3"){
			  var mdiv=document.getElementById("div3");
              mdiv.innerHTML=responseResult;
			  }
			  document.getElementById("Hidden").value=="";
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
 

 
 
 
 
  	
	 function callNextPage(obj){
	 
	 document.getElementById("umpireDataforCoach").innerHTML = ""
	 if(obj=="submit"){
	 if(textValidate()){
	 
	        document.getElementById("Hidden").value="1";		      
    		document.frmUmpireDecisionLog.action = "/cims/jsp/umpiringDecisionLog.jsp";
    		document.frmUmpireDecisionLog.submit();
    		document.getElementById("Hidden").value="";
		}	
		}
		if(obj=="Search"){
		    document.getElementById("Hidden").value="4";		      
    		document.frmUmpireDecisionLog.action = "/cims/jsp/umpiringDecisionLog.jsp";
    		document.frmUmpireDecisionLog.submit();
    		document.getElementById("Hidden").value="";
		}
		if(obj=="update"){
		 if(textValidate()){
		   document.getElementById("Hidden").value="5";		      
    		document.frmUmpireDecisionLog.action = "/cims/jsp/umpiringDecisionLog.jsp";
    		document.frmUmpireDecisionLog.submit();
    		document.getElementById("Hidden").value="";
		}
		}
		
		}
 function selectid(){
        document.getElementById("Hidden").value="2";      
    	xmlHttp = GetXmlHttpObject();
        var valName=document.frmUmpireDecisionLog.dpInning.value;       
        var url = "/cims/jsp/UmpireDecisionResponse.jsp?val="+valName+"&inning=inning";
		//xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
		   var responseResult = xmlHttp.responseText ;
   		      try //Internet Explorer
			  {
			   if(document.getElementById("Hidden").value=="2"){
			  var cmbbox = responseResult.split("<br>");
			  var mdiv=document.getElementById("div1");
              mdiv.innerHTML=cmbbox[0];			 
              var mdiv=document.getElementById("div2");
              mdiv.innerHTML=cmbbox[1];
			  }if(document.getElementById("Hidden").value=="3"){
			  var mdiv=document.getElementById("div3");
              mdiv.innerHTML=responseResult;
			  }
			  document.getElementById("Hidden").value=="";
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
		
	function selectappeal(){
		document.getElementById('dpAppeal').style.backgroundColor="white";
	    document.getElementById("Hidden").value="3";	      
    	xmlHttp = GetXmlHttpObject();
        var valName=document.frmUmpireDecisionLog.dpAppeal.value;
        var url = "/cims/jsp/UmpireDecisionResponse.jsp?val="+valName+"&inning=appeal";
		//xmlHttp.onreadystatechange = displayData;
		xmlHttp.open("get",url,false);
		xmlHttp.send(null);
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
		   var responseResult = xmlHttp.responseText ;
   		      try //Internet Explorer
			  {
			   if(document.getElementById("Hidden").value=="2"){
			  var cmbbox = responseResult.split("<br>");
			  var mdiv=document.getElementById("div1");
              mdiv.innerHTML=cmbbox[0];			 
              var mdiv=document.getElementById("div2");
              mdiv.innerHTML=cmbbox[1];
			  }if(document.getElementById("Hidden").value=="3"){
			  var mdiv=document.getElementById("div3");
              mdiv.innerHTML=responseResult;
			  }
			  document.getElementById("Hidden").value=="";
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
		
		 function textValidate(){
		 
		 var alphaExp = /^[.0-9]+$/;	
		 
		 	var flag = true;
		 	
		 	var strMessage = "Please select following : \n";
		 	
			if(document.getElementById('combUsername').value=="0"){			
				 document.getElementById('combUsername').style.backgroundColor="#FAAFBE";
				 strMessage = strMessage + "\tUmpire\n";
				 flag = false;
			}
			if(document.getElementById('dpInning').value=="0") { 
			   document.getElementById('dpInning').style.backgroundColor="#FAAFBE";		
			   strMessage = strMessage + "\tInning\n";
			   flag = false;
			}
<%--			if(!document.getElementById('dbover').value.match(alphaExp)){ --%>
<%--			   	document.getElementById('dbover').style.backgroundColor="#FAAFBE";		--%>
<%--			   	strMessage = strMessage + "\tOver number in digit\n";--%>
<%--			   	flag = false;--%>
<%--			}--%>
			if(document.getElementById('dpBatsmen').value=="0" ){
			   	document.getElementById('dpBatsmen').style.backgroundColor="#FAAFBE"; 		
			   	strMessage = strMessage + "\t Batsman\n";
			   	flag = false;
			}
			if(document.getElementById('dpBowler').value=="0" ){
			   	document.getElementById('dpBowler').style.backgroundColor="#FAAFBE"; 		
			   	strMessage = strMessage + "\tBowler \n";
			   	flag = false;
			}
			if(document.getElementById('dpAppeal').value=="0"){ 
			   	document.getElementById('dpAppeal').style.backgroundColor="#FAAFBE";		
			   	strMessage = strMessage + "\tAppeal type\n";
			   	flag = false;
			}
			if(document.getElementById('dpResult').value=="0"){ 	
			   	document.getElementById('dpResult').style.backgroundColor="#FAAFBE";	
			   	strMessage = strMessage + "\tResult\n";
			   	flag = false;
			}
			if(document.getElementById('dpDesc').value=="0"){ 
			   	document.getElementById('dpDesc').style.backgroundColor="#FAAFBE";		
			   	strMessage = strMessage + "\tDecision\n";
			   	flag = false;
			}
			if(!flag){
				alert(strMessage);
			}
			return flag;			
		 }
		
		function sendUmpireId(){
		var umpireid = document.getElementById("combUsername").value
        try {
         	  xmlHttp = this.GetXmlHttpObject();
         	  if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	          }else{
	         	 // var selectedInnId = document.getElementById('hdInningsid').value;
	              var url = "/cims/jsp/umpiringDecisionForAdmin.jsp?umpireid="+umpireid;
	             // xmlHttp.onreadystatechange = receiveUmpireDecision
	          	  xmlHttp.open("post", url, false);
			   	  xmlHttp.send(null);
			   	  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
            	  try {
               		var responseResult = xmlHttp.responseText ;
               		document.getElementById('umpireData').innerHTML = responseResult
               
            	 }catch(err){
               		alert(err.description + 'reciveDataUpdateOverRuns()');
	            }
        		}
	   		}
	   	}catch(err) {
          alert(err.description + 'sendUmpireId()');
        }
    }

	function searchLog(){
		if(document.getElementById("umpireDataTable") != null){
			document.getElementById("umpireDataTable").innerHTML = ""
		}
		if(document.getElementById("messageDiv") != null){
			document.getElementById("messageDiv").innerHTML = ""
		}
		var umpireid = document.getElementById("combUsername").value
		if(umpireid == 0){
			alert("Please select umpire.")
		}else{
			var umpireid = document.getElementById("combUsername").value
			try {
	         	  xmlHttp = this.GetXmlHttpObject();
	         	  if (xmlHttp == null) {
		               alert("Browser does not support HTTP Request");
		               return;
		          }else{
		         	  var url = "/cims/jsp/umpiringDecisionForAdmin.jsp?umpireid="+umpireid;
		              //xmlHttp.onreadystatechange = receiveUmpireDecisionforCoach
		          	  xmlHttp.open("post", url, false);
				   	  xmlHttp.send(null);
				   	  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
            			try {
			               var responseResult = xmlHttp.responseText ;
            			   document.getElementById('umpireDataforCoach').innerHTML = responseResult
				        }catch(err){
			               alert(err.description + 'receiveUmpireDecisionforCoach()');
            			}
			          }
		   		  }
		   	} catch(err) {
	           	alert(err.description + 'searchLog()');
	        }
		}		
	}
	
	function deleteLog(umpireid,umpireCoach,appealid,reasonid,appealyn,decisionyn,overno,batsman,bowler,inningid,remark,flag){
	try
	{
      xmlHttp = this.GetXmlHttpObject();
	  if (xmlHttp == null) {
	    alert("Browser does not support HTTP Request");
		return;
	  }else{
	    var url = "/cims/jsp/deleteUmpireDecisionLog.jsp?umpireid="+umpireid+"&umpireCoach="+umpireCoach
				+"&appealid="+appealid+"&reasonid="+reasonid
				+"&appealyn="+appealyn+"&decisionyn="+decisionyn
		    	+"&overno="+overno+"&batsman="+batsman+"&bowler="+bowler
		    	+"&inningid="+inningid+"&remark="+remark+"&flag="+flag	
	    xmlHttp.open("post", url, false);
	    xmlHttp.send(null);
	    if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
          try{
		   var responseResult = xmlHttp.responseText ;
          }catch(err){
	       alert(err.description + 'receiveUmpireLog()');
          }
	    }
	  }
    } catch(err) {
	    alert(err.description + 'searchLog()');
	}
	}

	</script>
  </head>
<body>	
<table align="center" style="width: 84.5em;">
    <tr>
    	<td align="center">
<div style="width:84.5em">
<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="frmUmpireDecisionLog" id="frmUmpireDecisionLog" method="post"><br>
	<br>
		<input type="hidden" name="umpcoachid" id="umpcoachid" value="<%=umpire_mapid%>">
		<table border="0" id="headerTable" width="100%"  >
			<tr>
				<td class="legend"><font size="4" >Umpiring Decision Log</font></td>
			</tr>
			<tr>
				<td colspan="9" align="right">
				Export : 
					<a href="/cims/jsp/PDFumpiringDecisionLog.jsp" target="_blank">
						<img src="/cims/images/pdf.png" height="20" width="20" />
					</a>
					<a href="/cims/jsp/EXCELumpiringDecisionLog.jsp" target="_blank">
						<img src="/cims/images/excel.jpg" height="20" width="20" />
					</a>
				</td>
			</tr>
		</table>
	    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
	    <tr>
			<td colspan="2"  class="contentDark" colspan="2" align="right"><b><%=loginUserName%>&nbsp;&nbsp;&nbsp;DATE :</b> <%=sdf.format(new Date())%></td>
		</tr>
<%		
    	if(crsObjRefereeDetail != null){
		  while(crsObjRefereeDetail.next()){
%>
		<tr class="contentLight"><!--From System-->
			<td width="20%" align="left" >Match No :</td>
			<td align="left"><%=strMatch_id%></td>
			
		</tr>
		<tr class="contentDark"><!--From System-->
		 	<td width="20%">Match Between :</td>
			<%if(crsObjRefereeDetail.getString("team1") == null || crsObjRefereeDetail.getString("team1").equals("")){%>
				<td >----</td>
<%			}else{%>
			<td align="left"><%=crsObjRefereeDetail.getString("team1")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjRefereeDetail.getString("team2")%>
			</td>
			<%}%>
			
		</tr>
		<tr class="contentDark"><!--From System-->
			<td width="20%" align="left" >Venue :</td>
			<%if(crsObjRefereeDetail.getString("venue") == null || crsObjRefereeDetail.getString("venue").equals("")){%>
				<td >----</td>
<%			}else{
%>
				<td align="left"><%=crsObjRefereeDetail.getString("venue")%></td>
<%			}%>
			
		</tr>
		<tr class="contentLight"><!--From System-->
			<td width="20%" align="left" >Date :</td>
			<%if(crsObjRefereeDetail.getString("date") == null || crsObjRefereeDetail.getString("date").equals("")){%>
				<td >----</td>
<%			}else{
				String d1 = null;
				java.util.Date date = ddmmyyyy.parse(crsObjRefereeDetail.getString("date"));
				d1 = sdf.format(date);
           
        %>
	<td width="80%" ><%=d1 %></td>
<%--			<td align="left"><%=crsObjRefereeDetail.getString("date")%></td>--%>
<%--			<td align="left"><%=sdf.format(new Date(crsObjRefereeDetail.getString("date")))%></td>--%>
			<%}%>
			
		</tr>
		<tr class="contentDark">
			<td width="20%" align="left" >Name Of Tournament :</td>
			<%if(crsObjRefereeDetail.getString("tournament") == null || crsObjRefereeDetail.getString("tournament").equals("")){%>
				<td >----</td>
<%			}else{%>
			<td align="left"><%=crsObjRefereeDetail.getString("tournament")%></td>
			<%}%>
			
		</tr>
		<tr class="contentDark">
			<td width="20%" align="left" >Umpire Coach :</td>
			<%if(crsObjRefereeDetail.getString("umpirecoach") == null || crsObjRefereeDetail.getString("umpirecoach").equals("")){%>
				<td >----</td>
			<%}else{%>
			<td align="left"><%=crsObjRefereeDetail.getString("umpirecoach")%></td>
			<%}%>
		</tr>
	</table>
<%			}
		}
%>
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
			<tr class="contentDark"><!--From System-->   
	    	
				<td width="20%" align="left" ><b>UMPIRE NAME :</b></td>	
				<td width="80%">
<%		if(lobjCachedRowSetumpire.size() > 0){
					
 if(umpire_id.equals("34291")){%>						
				<select name="combUsername" id="combUsername" class="combox" onchange="sendUmpireId()"  > 
<%}else{%>	

						
				<select name="combUsername" id="combUsername" class="combox" onchange="changeColor('combUsername')"  > 
<%}%>
				<OPTION value="0">Select umpire</OPTION>
		         <%
	        		
	            		if(lobjCachedRowSetumpire!=null)
	            		{
	            		    while(lobjCachedRowSetumpire.next())
	            		     { 
	            		     matchtype=lobjCachedRowSetumpire.getString("name");            		    
	            		     %>
	                	      <option value="<%=lobjCachedRowSetumpire.getString("mapid")%>"><%=lobjCachedRowSetumpire.getString("nickname")%></option>   
		                     <%}
		                     
		                }%>   
		            
		           </select>  
<%}else{%>	 
				Umpire not assigned for this match 
<%}
%>				 
<%if(!(umpire_id.equals("34291"))){%>	
				 <input type="button" class="button1"  id="btnSearch" name="btnSearch" value="Search" onclick="searchLog()" >
<%}%>				            
				</td>
			</tr>
<%if(matchtype != null){
%>			
			<tr class="contentLight"><!--From System-->
				<td><b>MATCH :</b></td>
				<td><b><%=matchtype%></b></td>
			
			</tr>
<%	}
%>			
		</table>
		<br>
		<div style="width: 84.5em">
<%if(!(umpire_id.equals("34291"))){ %>		
		<table border="1" width="95%" class="table">
			
			<tr class="contentDark">
				<td class="colheadinguser" align="center">Inning</td>
	       		<td class="colheadinguser" align="center">O</td>
		   		<td class="colheadinguser" align="center">Batsmen</td> 
	   			<td class="colheadinguser" align="center">Bowler</td>
	   			<td class="colheadinguser" align="center">Appeal</td>
		   		<td class="colheadinguser" align="center">Result</td> 
		   		<td class="colheadinguser" align="center">Decision</td>
		   		<td class="colheadinguser" align="center">Reason</td> 		   		
		   		<td class="colheadinguser" align="center">Remark</td>   
			</tr>
	   		<tr class="contentLight">
	   			<td ><!--From user-->
	   			
	        		<select name="dpInning" id="dpInning" class="combox" onchange="selectid()"   onfocus="changeColor('dpInning')" >
	        		     <option value="0">Inning</option>
	            		<%
	            		
	            		if(lobjCachedRowSet!=null)
	            		{
	            		    while(lobjCachedRowSet.next())
	            		     { 
	            		     count++;
	            		     %>
	                	      <option value="<%=lobjCachedRowSet.getString("id")%>"><%=count%></option>   
		                     <%}
		                }%>
		            </select>
				</td>
	    	   
	    	    <td><!--From user-->		        	
				<input type="text" id="dbover" name="dbover" value=""  onKeyPress="return keyRestrict(event,'.1234567890');" size="5" maxlength="5"  onfocus="changeColor('dpOver')" ></td>
				</td>
		       
		        
		        <td><!--From user-->
		        <div id="div1">
		        
		        	<select name="dpBatsmen" id="dpBatsmen" class="combox"   onchange="changeColor('dpBatsmen')" >
		        	   <option value="0">Batsman</option>
		            	
		            </select>
		           </div> 
				</td>
		       
		        <td><!--From user-->
		        <div id="div2">
		        	<select name="dpBowler" id="dpBowler" class="combox"  onchange="changeColor('dpBowler')" >
		        	<option value="0">Bowling</option>
		            	
		            </select>
		         </div>
		          </td>
		        <td><!--From user-->
		        	<select name="dpAppeal" id="dpAppeal" class="combox"  onchange="selectappeal()"   >
		        	<option value="0">Appeal</option>
	    	        	<%
	    	        
	    	        	if(lobjCachedRowSetappeal!=null)
	    	        	{
	    	        	     while(lobjCachedRowSetappeal.next())
	            		    { 
	            		    %>
	                	   <option value="<%=lobjCachedRowSetappeal.getString("id")%>"><%=lobjCachedRowSetappeal.getString("name")%></option>   
	                	   
		                   <%}
		                }%>  
		            </select>
	    	    </td>
		        
		        <td><!--From user-->
		        	<select name="dpResult" id="dpResult" class="combox" onchange="changeColor('dpResult')" >
		        	<option value="0">Result</option>
		        	<option value="Y">Given</option>
		            <option value="N">Not Given</option>
		            	
		            </select>
		        </td>
		        <td>
		        	<select name="dpDesc" id="dpDesc" class="combox"  onchange="changeColor('dpDesc')">
		                <option value="Y">Correct</option>
		                <option value="N">InCorrect</option>
		            </select>
		       
		     </td>
		      
		        <td><!--From user-->
		        <div id="div3">
		        	<select name="dpReason" id="dpReason" class="combox" >
		            	<option value="0">Choose Reason</option>
		                 
		            </select>
		            </div>
		        </td>     
		        
		        <td><!--From user-->		        	
				<input type="text" id="txtremark" name="txtremark"  onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');" value=""  ></td>
				</td>
		       
		       
				
			</tr>
		        <input type="hidden" name="Hidden" id="Hidden" value="">
		        <input type="hidden" name="Hiddencount" id="Hiddencount" value="">        
			
		</table>   
		
		<br>
		
		
<% }else{
%>	
	<table width="95%">
		<tr>
			<td>
				<div id="umpireData" name="umpireData"></div>
			</td>
		</tr>
	</table>
<%}
%>	
		</div>
		<br>
		<table border="0" width="95%">
		<tr>
		<%
		if(umpireid!=null){
		if(umpireid.equals(umpire_id)){%>
			
		    	<td  align="center">
		    	  <input type="button" class="btn btn-warning"  id="btnSubmit" name="btnSubmit" value="Add"  onclick="callNextPage('submit')" >
<%--		          <input type="button" class="button1"  id="btnSearch" name="btnSearch" value="Search" onclick="callNextPage('Search')" >--%>
				 
		          <input type="button" class="btn btn-warning"  style="d" id="btnUpdate" name="btnUpdate" value="Update" onclick="callNextPage('update')" disabled="disabled">
		        </td>
		        
		       
		   
		    <%		    
		    }}
		    if(umpire_id.equals("34291")){%>
<%--		    <td align="center">--%>
<%--		     <input type="button"  class="button1"  id="btnSearch" name="btnSearch" value="Search" onclick="callNextPage('Search')" >--%>
<%--		     </td>--%>
		   <% }%>
		    
		  
		     </tr>
		</table>
		<br><br>
		 <table width="95%">
			<tr>
				<td>
					<div id="umpireDataforCoach" name="umpireDataforCoach"></div>
				</td>
			</tr>
		</table>
	<br><br>
	
<%
	try{
	if (lobjCachedRowSetinsert != null || lobjCachedRowSetdelete !=null)	
	 {
%>	 
	 <div  id="messageDiv" name="messageDiv">
	  <%if(gsaction.equals("2")){%>	 
	  <p class="message">Record Deleted <p>	 
	<%}
	 if(gsaction.equals("1")){%>	 
	   <p class="message">Record Added <p>	
	<%}
	 if(gsaction.equals("5")){%>	 
	   <p class="message">Record Updated <p>	
	<%}%>
	<div>
	<%}
	}catch(Exception e)
	{e.printStackTrace();}
	
	
	if (lobjCachedRowSetdisplay != null )
	{
	if(lobjCachedRowSetdisplay.last())	
	 {
	 lobjCachedRowSetdisplay.beforeFirst(); 	    
	    %>
	 <div id="umpireDataTable" name="umpireDataTable">
	 <table border="1" width="95%">
	   <tr class="contentDark">
		<td class="colheadinguser" align="center">Umpire</td>
				<td class="colheadinguser" align="center">Inning</td>
					<td class="colheadinguser" align="center">Over </td>
						<td class="colheadinguser" align="center">Batsman</td>
							<td class="colheadinguser" align="center">Bowler</td>
								<td class="colheadinguser" align="center" >Appeal</td>
									<td class="colheadinguser" align="center">Result</td>
										<td class="colheadinguser" align="center">Desision</td>
											<td class="colheadinguser" align="center">Reason</td>
											<td class="colheadinguser" align="center">Remark</td>
											<%	if(!umpire_id.equals("34291")){%>
											<td class="colheadinguser" align="center">Edit</td>
											<%}%>
											<%	if(!umpire_id.equals("34291")){%>
											<td class="colheadinguser" align="center">Delete</td>
											<%}%>
											
			</tr>
	<%
	
	      try{
	
			while (lobjCachedRowSetdisplay.next()) {
			editcount++;
				%>
	         
			<tr >
			<input type="hidden" name="<%="ump"+editcount%>" id="<%="ump"+editcount%>" value="<%=lobjCachedRowSetdisplay.getString("umpire")%>">
			<td nowrap><%=lobjCachedRowSetdisplay.getString("umpirename")%></td>
			<input type="hidden" name="<%="i"+editcount%>" id="<%="i"+editcount%>" value="<%=lobjCachedRowSetdisplay.getString("inning")%>">
			
			<td nowrap align="center"><%=lobjCachedRowSetdisplay.getString("inning_cnt")%></td>
			<td nowrap align="center"><%=lobjCachedRowSetdisplay.getString("over_num")%></td>
				<input type="hidden" name="<%="o"+editcount%>" id="<%="o"+editcount%>" value="<%=lobjCachedRowSetdisplay.getString("over_num")%>">
			<td nowrap><%=lobjCachedRowSetdisplay.getString("batsmanname")%></td>
			<input type="hidden" name="<%="bat"+editcount%>" id="<%="bat"+editcount%>" value="<%=lobjCachedRowSetdisplay.getString("batsman")%>">
			<td nowrap><%=lobjCachedRowSetdisplay.getString("bowlername")%></td>
			
			<input type="hidden" name="<%="bow"+editcount%>" id="<%="bow"+editcount%>" value="<%=lobjCachedRowSetdisplay.getString("bowler")%>">
			<td nowrap><%=lobjCachedRowSetdisplay.getString("appealdetail")%></td>
			<input type="hidden" name="<%="app"+editcount%>" id="<%="app"+editcount%>" value="<%=lobjCachedRowSetdisplay.getString("appeal")%>">
			<td nowrap><%=lobjCachedRowSetdisplay.getString("appeal_accept")%></td>
			<input type="hidden" name="<%="res"+editcount%>" id="<%="res"+editcount%>" value="<%=lobjCachedRowSetdisplay.getString("appealaccept")%>">
			<td nowrap><%=lobjCachedRowSetdisplay.getString("decision_correct")%></td>
			<input type="hidden" name="<%="des"+editcount%>" id="<%="des"+editcount%>" value="<%=lobjCachedRowSetdisplay.getString("decisioncorrect")%>">
			<td ><%=lobjCachedRowSetdisplay.getString("reasondetail")%></td>
			<input type="hidden" name="<%="reas"+editcount%>" id="<%="reas"+editcount%>" value="<%=lobjCachedRowSetdisplay.getString("reason")%>">
			
			<td ><%=lobjCachedRowSetdisplay.getString("remark")%></td>
				<input type="hidden" name="<%="rem"+editcount%>" id="<%="rem"+editcount%>" value="<%=lobjCachedRowSetdisplay.getString("remark")%>">
			<%	if(!umpire_id.equals("34291")){%>
			<td align="center">
			<a  id="<%=editcount%>"   href="javascript:edit(<%=editcount%>)">edit</a></td>
			<%}%>
			<%	if(!umpire_id.equals("34291")){%>
			<td align="center">
			<a  id="<%=editcount%>"   href="javascript:deleteRecord(<%=editcount%>)">delete</a></td>
			<%}%>
			
			</tr>
		
		<%}
		
		}catch(Exception e){ e.printStackTrace();}
		}else{%>
		  <b>No Record Found<b>
		<%		
		}
		}
	%>

		</table>
	</div>   	
	</form>
	<br><br><br><br><br>
	<jsp:include page="admin/Footer.jsp"></jsp:include>
	</div>
	</td>
	</tr>
	</table>
</body> 
	
</html> 