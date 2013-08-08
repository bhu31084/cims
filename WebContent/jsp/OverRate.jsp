<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.Math.*"%>
<%@ page import="java.text.SimpleDateFormat"%> 
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.csms.logwriter.LogWriter"%>

<%  CachedRowSet  inningIdCrs	=  null;
	CachedRowSet  umpireIdCrs	=  null;
	CachedRowSet  refereeIdCrs	=  null;
   
    String matchId				= "";
	String inningsId			= "";
    String inningIdOne			= "";
	String inningIdTwo			= "";	
	String inningIdThree		= "";	
	String inningIdFour			= "";
	String umpireID 			= "";
	String refereeId			= "";
	String userId				= "";
	String userRole				= "";
	String userRoleId			= "";
	String date					= "";
	String currentDate			= "";
	String label				= "";
	String hid					= "";
	String retVal				= "";
	String remark				= "";
	boolean flag				= false;
	boolean refereeFlag			= false;
    String[] splitInningsId 	= null;
    String[] umpireIDArr		= null; 
    String[] refereeIDArr		= null; 
    String[] splitDate			= null;
    Vector vparam 				= new Vector();
    Calendar cal 				= Calendar.getInstance();
%>
<%	matchId  = (String)session.getAttribute("matchid");
	userId   = (String)session.getAttribute("userid");
	userRole = session.getAttribute("role").toString();
	LogWriter log = new LogWriter();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	currentDate = new SimpleDateFormat("dd-MM-yyyy").format(cal.getTime());	
	
	// check umpire for match
	vparam.add(matchId);
	vparam.add("");
	vparam.add("1");
	umpireIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpireid",vparam,"ScoreDB");
	vparam.removeAllElements();
	try{
		if (umpireIdCrs != null){
			while (umpireIdCrs.next()){
					umpireID = umpireID + umpireIdCrs.getString("id") + "~";
					umpireIDArr = umpireID.split("~");
			}
		}	
		if(umpireIDArr!=null){
			for (int i=0; i < umpireIDArr.length;i++){
				if(userId.equals(umpireIDArr[i])){
					flag = true;
				}
			}
			if(!(flag)){
				//response.sendRedirect("ScoreSheet.jsp");
			}
		}		
	}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
	}

	// check referee for match
	vparam.add(matchId);
	vparam.add("");
	vparam.add("3");
	refereeIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpireid",vparam,"ScoreDB");
	vparam.removeAllElements();
	try{
		if (refereeIdCrs != null){
			while (refereeIdCrs.next()){
					refereeId = refereeId + refereeIdCrs.getString("id") + "~";
					refereeIDArr = refereeId.split("~");
			}
		}	
		if(refereeIDArr!=null){
			for (int i=0; i < refereeIDArr.length;i++){
				if(userId.equals(refereeIDArr[i])){
					flag 		= true;
					refereeFlag = true;
				}
			}
			if(!(flag)){
				//response.sendRedirect("ScoreSheet.jsp");
			}
		}		
	}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	// Get Inning Id
	vparam.add(matchId);
	inningIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getinningsid",vparam,"ScoreDB");
	vparam.removeAllElements();
	if (inningIdCrs != null){
		try{
			while (inningIdCrs.next()){
				inningsId 		= inningsId + inningIdCrs.getString("id") + "~";
				splitInningsId  = inningsId.split("~");
				if (splitInningsId !=null){
					if(splitInningsId.length == 1){
						inningIdOne = splitInningsId[0];
					}if(splitInningsId.length == 2){
						inningIdOne = splitInningsId[0];
						inningIdTwo = splitInningsId[1];
					}else if(splitInningsId.length == 3){
						inningIdOne = splitInningsId[0];
						inningIdTwo = splitInningsId[1];
						inningIdThree = splitInningsId[2];
					}else if(splitInningsId.length == 4){
						inningIdOne	  = splitInningsId[0];
						inningIdTwo	  = splitInningsId[1];
						inningIdThree = splitInningsId[2];
						inningIdThree = splitInningsId[3];
					}	
				}
			}
		}catch(Exception e)	{
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}
	
	// to get days of match
	vparam.add(matchId);
	vparam.add("");
	vparam.add("2");
	inningIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_over_rate_match_details",vparam,"ScoreDB");
	vparam.removeAllElements();
	try{
		if (inningIdCrs!=null){
			while(inningIdCrs.next()){
				date = date + inningIdCrs.getString("match_day_date")+ "~";
				splitDate = date.split("~");
			}
		}
	}catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	//To Get UserRoleId
	vparam.add("");
	vparam.add(userId);
	vparam.add("2");
	umpireIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpireid",vparam,"ScoreDB");
	vparam.removeAllElements();
	try{
		if (umpireIdCrs != null){
			while (umpireIdCrs.next()){
					userRoleId = umpireIdCrs.getString("user_role_id")!=null?umpireIdCrs.getString("user_role_id"):"";
			}
		}	
	}catch(Exception e){	
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	// Make entry in wfitem
try{
	hid = request.getParameter("hid")!=null?request.getParameter("hid"):"";
	if ((userRole.equals("2") && flag==true) || (userRole.equals("4") && refereeFlag ==true)){
		if (!(hid.equalsIgnoreCase("1"))){	
			vparam.add("4");//type overrate calculation
			vparam.add("1");//doctype overrate calculation
			vparam.add(userRoleId);//actor
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add(matchId);
			vparam.add("0");
			vparam.add(userRole);
			vparam.add("");
			umpireIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_overrateworkflow",vparam,"ScoreDB");
			vparam.removeAllElements();
			if (umpireIdCrs!=null){
				while (umpireIdCrs.next()){
							remark = umpireIdCrs.getString("Retval")!=null?umpireIdCrs.getString("Retval"):"";
							retVal = umpireIdCrs.getString("flag")!=null?umpireIdCrs.getString("flag"):"";
				}
			}	
		}
	}			
}catch(Exception e)	{
	log.writeErrLog(page.getClass(),matchId,e.toString());
}
	
// code to send report for approval 	
hid = request.getParameter("hid")!=null?request.getParameter("hid"):"";
try{
	if ((userRole.equals("2") && flag==true) || (userRole.equals("4") && refereeFlag ==true)){
		if (hid!=null && hid.equalsIgnoreCase("1")){
			vparam.add("4");//type overrate calculation
			vparam.add("1");//doctype overrate calculation
			vparam.add(userRoleId);//actor
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add("");
			vparam.add(matchId);
			vparam.add("1");
			vparam.add(userRole);
			vparam.add("");
			umpireIdCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_overrateworkflow",vparam,"ScoreDB");
			vparam.removeAllElements();
			if (umpireIdCrs!=null){
				while (umpireIdCrs.next()){
							remark = umpireIdCrs.getString("Retval")!=null?umpireIdCrs.getString("Retval"):"";
							retVal = umpireIdCrs.getString("flag")!=null?umpireIdCrs.getString("flag"):"";
				}
			}	
		}
	}	
}catch(Exception e)	{
	log.writeErrLog(page.getClass(),matchId,e.toString());
}
%>			
<html>
  <head>
    <title>OverRateCalculation</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
    <script>
    		function chkInningDate(flag){
    			var comboText = "";
    			if (flag==1){
	    			var selInning = document.getElementById('inningId').value;
	    			if (selInning==1){
	    				alert("Select Inning of Match");
	    				return false;
	    			}else{
	    				var inningOption = document.getElementById('inningId').options;
	    				if (inningOption!=null){
		    				for (var i=0;i<inningOption.length;i++){
		    						if (inningOption[i].selected){
		    								comboText = inningOption[i].text;
		    								document.getElementById('hid').value = comboText;
		    						}
		    				}
		    			}		
	    				doGetOverRateDataOnInning();		
	    			}
	    		}
	    		if (flag==2){
	    			var selInning = document.getElementById('dayDateId').value;
	    			if (selInning==1){
	    				alert("Select Day of Match");
	    				return false;
	    			}else{
	    				var dayOption = document.getElementById('dayDateId').options;
	    				if (dayOption!=null){
		    				for(var i=0;i<dayOption.length;i++){
		    					if (dayOption[i].selected){
		    						comboText = dayOption[i].text;	
		    						document.getElementById('hid').value = comboText;
		    					}
		    				}
		    			}	
	    				doGetOverRateDataOnDate();		
	    			}
	    		}
    		}
    		
    		function submitForm(){
				document.getElementById('hid').value = 1;
    			document.ApproveOverRate.submit();
    		}
    </script>
 </head>
 <body>
 <table style="width:100%">
    <tr>
    	<td align="center">
 	<div style="width: 84.5em">
 	<form name="ApproveOverRate" id="ApproveOverRate"> 	
 	<input type=hidden name="hid" id="hid" value=""/>
 	<jsp:include page="Menu.jsp" />
 	<input type=hidden name=hid id=hid value="">
 		<br>
 		<br>
 		<table width="100%" align="center" border="0" cellpadding="2" cellspacing="1" class="table">			
			<tr align="left">
				<td align="left" colspan="2" class="legend">Over Rate Calculation</td>
			</tr>
		</table>
		<br/>
		<table align="center">
 			<tr>
 				<td>
 					<b>Select Inning:</b> &nbsp;<select id="inningId" name="inningId" onchange="chkInningDate(1)">
 							<option value="1">--select--</option> 	
<%	if (splitInningsId!=null && splitInningsId.length > 0){
		for(int i=0 ; i<splitInningsId.length ;i++) {
%>
 							<option value="<%=splitInningsId[i]%>" >Inning<%=i+1%></option>
<%
		}
	}else{
%>
							<option value="">No Inning Id For This Match</option>
<% }	
%> 							
 					</select>	
 				</td>
 				<td>&nbsp;&nbsp;<b>OR</b>&nbsp;&nbsp;</td>
 				<td>
 					<b>Select Day:</b> &nbsp;<select id="dayDateId" name="dayDateId" onchange="chkInningDate(2)">
 							<option value="1">--select--</option> 
<%	if (splitDate!=null && splitDate.length > 0){
		for(int i=0 ; i<splitDate.length ;i++) {
%>
 							<option value="<%=splitDate[i]%>" <%=currentDate.equalsIgnoreCase(splitDate[i])?"selected" :""%>>Day<%=i+1%></option>
<%		}
	}else{
%>
							<option value="">No Day For This Match</option>
<% }	
%> 							
 					</select>	
 				</td>
 			</tr>
 		</table>
 		<br>
 		<center><b></b></center>
 		<br>
 		<table align=center width="100%">
 			<tr>
 				
 			</tr>
 		</table>
		<div class=message><%=remark%></div>
    	<div id="OverRate" name="OverRate" style="width: 100%">
				    			
    	</div>
    	<br>
<% if (flag && refereeFlag==false){
		if (!retVal.equals("1")){
%>
    	<table align=center width=100% style=border-collapse:collapse >
							<tr>
								<td colspan=4 align=center><input class="btn btn-warning" type=button value="Send To Referee" onclick="submitForm()"/></td>
							</tr>
		</table>
 <%   }
 	}
 %>
 <%if (refereeFlag==true){
 		if (!retVal.equals("1")){
 %>
 	  		<table align=center width=100% style=border-collapse:collapse >
							<tr>
								<td colspan=4 align=center><input class="btn btn-warning" type=button value="Approve" onclick="submitForm()"/></td>
							</tr>
			</table>						
 <%		}
 	}
 %>


	</form>	
	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td>
				<jsp:include page="admin/Footer.jsp"></jsp:include>
			</td>
		</tr>
	</table>
	</div>
	</td>
	</tr>
	</table>
 </body>
 <script>
 		var param = "";
 		 function GetXmlHttpObject(){
		        var xmlHttp=null;
		        try{
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
    		
    		// Getting OverRate data onload
    		function doGetOverRateDataOnInning(){
    		  xmlHttp=GetXmlHttpObject();
              if (xmlHttp==null){
                  alert ("Browser does not support HTTP Request") ;
                  return;
              }
              else{
              	  var dayOption = document.getElementById('inningId').options;
	    				if (dayOption!=null){
		    				for (var i=0;i<dayOption.length;i++){
		    						if (dayOption[i].selected){
		    								comboText = dayOption[i].text;
		    								//document.getElementById('hid').value = comboText;
		    						}
		    				}
		    			}			
				  var inningIdOne = document.getElementById('inningId').value;
				 // var url="OverRateCalculation.jsp?inningIdOne="+inningIdOne ;
			      var url="/cims/jsp/OverRateCalculation.jsp?inningIdOne="+inningIdOne +"&day="+comboText;
                //  xmlHttp.onreadystatechange=stateChangedLAS;
                  xmlHttp.open("get",url,false);
                  xmlHttp.send(null);
                  if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("OverRate");
	                   mdiv.innerHTML = responseResult;
	             }
              }
        	}
        	
    		
    		// Getting OverRate Data OnLoad
    		 function doGetOverRateDataOnload(date){
    		  xmlHttp=GetXmlHttpObject();
              if (xmlHttp==null){
                  alert ("Browser does not support HTTP Request") ;
                  return;
              }
              else{
              	  param = "date";
			      var url="/cims/jsp/OverRateCalculation.jsp?date="+date + "&param="+param;
                //  xmlHttp.onreadystatechange=stateChangedLAS1;
                  xmlHttp.open("get",url,false);
                  xmlHttp.send(null);
                  if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("OverRate");
	                   mdiv.innerHTML = responseResult;
	             }
              }
        	}
        	
        	// Getting OverRate Data based on onchange event
    		 function doGetOverRateDataOnDate(){
    		  xmlHttp=GetXmlHttpObject();
              if (xmlHttp==null){
                  alert ("Browser does not support HTTP Request") ;
                  return;
              }
              else{
              	  param = "date";
              	  var comboText = "";
	              var date = document.getElementById('dayDateId').value;
	              var dayOption = document.getElementById('dayDateId').options;
	    				if (dayOption!=null){
		    				for (var i=0;i<dayOption.length;i++){
		    						if (dayOption[i].selected){
		    								comboText = dayOption[i].text;
		    								//document.getElementById('hid').value = comboText;
		    						}
		    				}
		    			}		
	              var url="/cims/jsp/OverRateCalculation.jsp?date="+date + "&param="+param +"&day="+comboText;
                  //xmlHttp.onreadystatechange=stateChangedLAS3;
                  xmlHttp.open("get",url,false);
                  xmlHttp.send(null);
                  if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
	                   var responseResult= xmlHttp.responseText ;
	                   var mdiv = document.getElementById("OverRate");
	                   mdiv.innerHTML = responseResult;
	              }
              }
        	}
        	
      		//doGetOverRateDataOnload('<%=inningIdOne%>');	
 			doGetOverRateDataOnload('<%=currentDate%>');	
  </script>
</html>
