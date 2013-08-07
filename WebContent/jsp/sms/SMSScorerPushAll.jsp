<!--
	Page Name 	 : SMSPush.jsp
	Created By 	 : Dipti Shinde.
	Created Date : 31st Mar 2009.
	Description  : To send sms to all officials and save date and time in database.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.common.RandomGenerator"%>
<%@ page import="in.co.paramatrix.csms.sms.SmsSender"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,java.io.*,java.lang.*"%>

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
	String userRoleId = (String)session.getAttribute("userId").toString();//userId
	String scorer1 = request.getParameter("scorer1Id")==null?"":request.getParameter("scorer1Id");
	String scorer2 = request.getParameter("scorer2Id")==null?"":request.getParameter("scorer2Id");
	String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
	String seriesname = request.getParameter("seriesname")==null?"0":request.getParameter("seriesname");
	String matchdate = request.getParameter("matchdate")==null?"0":request.getParameter("matchdate");
	String team1 = request.getParameter("team1")==null?"0":request.getParameter("team1");
	String team2 = request.getParameter("team2")==null?"0":request.getParameter("team2");
	String venue = request.getParameter("venue")==null?"0":request.getParameter("venue");
	
	String userIdRole = scorer1+":"+scorer2;
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.text.SimpleDateFormat sdfmatchdate1 = new java.text.SimpleDateFormat("MMM dd yyyy");
	java.text.SimpleDateFormat sdfmatchdate2 = new java.text.SimpleDateFormat("dd/MM/yyyy");	
	java.util.Date displaymatchdate = null;

	if(matchdate != "0"){
		 displaymatchdate = sdfmatchdate1.parse(matchdate);
	}
	
	Date currentDateTime = new Date();
 	
	String message = null;
	String messageCode = null;
	String messageflag = null;
	String rowId = null;
	String senderId = null;
	String userrole = null;
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	CachedRowSet  crsObjcontact = null;
	CachedRowSet  crsSendMessage = null;
	CachedRowSet  crsUserRoleId = null;
	
	/** try block added to execute sp esp_dsp_getuserroleid to get user role id */
	try{
		vparam.add(userRoleId);
		crsUserRoleId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getuserroleid",vparam,"ScoreDB");
		vparam.removeAllElements();
		
		if(crsUserRoleId != null && crsUserRoleId.size() > 0 ){
			while(crsUserRoleId.next()){
				senderId = crsUserRoleId.getString("user_role_id");
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	String contactNumRole = "";
	String[]userIdRoleArr = userIdRole.split(":");
	String []contactArr = new String[3];
	String []receiverIdArr = new String[3];

	for(int i = 0,j= 0 ; i < (userIdRoleArr.length) ; i=i+2,j++){
		String contactnum = null;
		try{
			if(userIdRoleArr[i] != null){
				vparam.add(userIdRoleArr[i]);
				crsObjcontact = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_get_contact_num",vparam,"ScoreDB");
			    vparam.removeAllElements();
				if(crsObjcontact != null && crsObjcontact.size() > 0 ){
					while(crsObjcontact.next()){
						contactnum = crsObjcontact.getString("contact");
					}
				}
				
				contactArr[j] = contactnum;
				receiverIdArr[j] = userIdRoleArr[i];
			}	
		}catch(Exception e){
			e.printStackTrace();
		}
	}//end for	

	String []messageArr = new String[3];
	String signature = null;
	String []signatureArr = new String[3];
	
	for(int i = 1,j= 0;i < (userIdRoleArr.length) ;i=i+2,j++){

		if(userIdRoleArr[i].equalsIgnoreCase("s1")){
			userrole = "scorer1";
		}else if(userIdRoleArr[i].equalsIgnoreCase("s2")){
			userrole = "scorer2";
		}
		
				
		signature = RandomGenerator.getRandomString(7, 7);
		signatureArr[j] = signature;
		//messageArr[j] = "You are appointed as "+userrole+" for "+seriesname+","+team1+" Vs "+team2+" at "+
		//				venue+" on "+ sdfmatchdate2.format(displaymatchdate)+"."+
		//				" Please check and confirm via email / online system, within 24 hours";
		messageArr[j] = "Appointed as "+userrole+" for "+seriesname+" at "+
						 venue+" on "+ sdfmatchdate2.format(displaymatchdate)+"."+
						" Check and confirm via email/online, within 48 hours";
		
	}
			
	String url[] = new String[3];
	String urlflag[] = new String[3];
	for(int i= 0;i < (messageArr.length) ;i++){
		CachedRowSet  crsMessage = null;
		if(contactArr[i] != null){
		
			/**Code to insert message details in database.*/
			try{
				vparam.add(messageArr[i]);//content
				vparam.add("1");//type
				vparam.add(matchId);//matchid
				vparam.add(receiverIdArr[i]);//receiver
				vparam.add(senderId);//sender
				vparam.add(sdf.format(currentDateTime));//send_ts
				vparam.add(signatureArr[i]);//signature
				vparam.add(contactArr[i]);//replyPhone
				vparam.add("");//reply text
				vparam.add("");//reply_ts
				vparam.add("");//state
				vparam.add("");//statechange_ts
				vparam.add("1");//flag
				vparam.add("2");//flag
				crsMessage = lobjGenerateProc.GenerateStoreProcedure("esp_amd_send_receive_messages",vparam,"ScoreDB");
		   		vparam.removeAllElements();			
				
			}catch(Exception e){
				e.printStackTrace();
			}	
		}//end if
	}//end for
	
	for(int i= 0;i < 3 ;i++){
		SmsSender smssender = new SmsSender();
		url[i] = smssender.buildUrl(contactArr[i],messageArr[i]);//retrieved url from java class	
		urlflag[i] = "true";		
	}
%>	
<html>
	<head>
		<script>
		 var smscount = 0;
		var deliveredTo = "";
		function GetXmlHttpObject() {
	        var xmlHttp = null;
	        try{
	            // Firefox, Opera 8.0+, Safari
	            xmlHttp = new XMLHttpRequest();
	        }
	        catch (e){
	            // Internet Explorer
	            try{
	                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
	            }
	            catch (e){
	                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	            }
	        }
	        return xmlHttp;
	    }
    
		function callSendSms(val){
		  	smscount = smscount + 1;
			var val = smscount
			try {
	          xmlHttp = this.GetXmlHttpObject();
	     	  if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	          }else{
	         	if(smscount < 5){
			      var url = document.getElementById("hdUrl"+val).value;
			      var indexBcci = url.indexOf("BCCI")
			     // alert("indexBcci"+(parseInt(indexBcci)+2))
			      var userrole = url.substring((parseInt(indexBcci)+5),(parseInt(indexBcci)+7))
			    // alert("url    >" + url.substring((parseInt(indexBcci)+5),(parseInt(indexBcci)+7)))
			     if(userrole=="s1"){
			     	userrole = "scorer1 "
			     }	
			     if(userrole=="s2"){
			     	userrole = "scorer2 "
			     }
			     deliveredTo = deliveredTo +" Delivered To "+userrole
			     document.getElementById('hdDeliverdTo').value = deliveredTo
			     
			     document.getElementById("divmsg").innerHTML = document.getElementById("divmsg").innerHTML +  deliveredTo + "<br>";
			     deliveredTo="";	
			    // xmlHttp.onreadystatechange = receiveSMSProcess
			     xmlHttp.open("post", url, false);
			   	 xmlHttp.send();
			   	 if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
		       		try {
		       	    	var responseResult = xmlHttp.responseText ;            	
		                 	try
			    	        	{
								xmlDoc = loadXMLString(responseResult);
								if(responseResult.indexOf("CODE") > -1)
									{
										alert(xmlDoc.getElementsByTagName("DESC")[0].childNodes[0].nodeValue);
									}
								else 
									{
										if(smscount < 5){
											callSendSms(smscount);
										}
									}
									
							}
							catch(e)
							{
								alert("Error in display msg"+e);
							}	
												
		  
		            } catch(err) {
			            alert(err.description + 'receiveSMSProcess()');
		       		}
		          }
<%--			   	  window.opener="";--%>
<%--				  window.close();--%>
				 } 
	   		  }
		   	} catch(err) {
	           	//alert(err.description + 'callSendSms()');
	        }
	
		}
		
		function loadXMLString(txt){
			try //Internet Explorer
			  {
				if (window.ActiveXObject){  
					xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
					xmlDoc.async="false";
					xmlDoc.loadXML(txt);
				}else{
					xmlDoc = document.implementation.createDocument("","",null);
				}

				  return(xmlDoc); 
			  }
			catch(e)
			  {
				  try //Firefox, Mozilla, Opera, etc.
				    {			
					    parser=new DOMParser();
				    	xmlDoc=parser.parseFromString(txt,"text/xml");
					    return(xmlDoc);
				    }
				  catch(e) {alert(e.message)}
			  }
			return(null);
		}	
		
		function receiveSMSProcess(){
    	}	
		</script>
	</head>
	<body>
<%--	<input type="hidden" name="hdDeliverdTo" id="hdDeliverdTo" value="">--%>
	    <table>
		 <tr>
		   <td>
				<div id="divmsg" name="divmsg"></div>
		    </td>
		  </tr>
		</table>
		<input type="hidden" name="hdcontactNumRole" id="contactNumRole" value="<%=contactNumRole%>">
		<input type="hidden" name="hdUrl1" id="hdUrl1" value="<%=url[0]%>">
		<input type="hidden" name="hdUrl2" id="hdUrl2" value="<%=url[1]%>">
		<input type="hidden" name="hdDeliverdTo" id="hdDeliverdTo" value="">
		
		<script>
			var contactNumRole = document.getElementById('hdcontactNumRole').value
			var contactNumRoleArr = contactNumRole.split("-")
		</script>
		<script>
			callSendSms();
		</script>
	</body>
</html>