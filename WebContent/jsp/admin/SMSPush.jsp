<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>

<%  
	response.setHeader("Pragma", "private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
	
	String matchId = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
	String userId = request.getParameter("userId")==null?"0":request.getParameter("userId");
	String seriesname = request.getParameter("seriesname")==null?"0":request.getParameter("seriesname");
	String matchdate = request.getParameter("matchdate")==null?"0":request.getParameter("matchdate");
	String team1 = request.getParameter("team1")==null?"0":request.getParameter("team1");
	String team2 = request.getParameter("team2")==null?"0":request.getParameter("team2");
	String venue = request.getParameter("venue")==null?"0":request.getParameter("venue");
	String contactnum = null;
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	CachedRowSet  crsObjcontact = null;
	vparam.add(userId);//display teams
	crsObjcontact = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_get_contact_num",vparam,"ScoreDB");
    vparam.removeAllElements();
	if(crsObjcontact != null){
		while(crsObjcontact.next()){
			contactnum = crsObjcontact.getString("contact");
		}
	}
%>

<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<link href="../../css/form.css" rel="stylesheet" type="text/css" />
<link href="../../css/formtest.css" rel="stylesheet" type="text/css" />
<title>Send SMS</title> 
</head> 

<body> 
	<h3><center>Send SMS</center></h3> 
<form method="post" action="http://bulkpush.mytoday.com/BulkSms/SingleMsgApi"> 
<table width="100%" border="0" valign="top"> 
	<tr>
		<td><input type="hidden" name="feedid" value="177390" ></td>
	</tr> 
	<tr>
		<td><input type="hidden" name="senderid" value="BCCI" ></td>
	</tr>
	<tr>
		<td><input type="hidden" name="username" value="9322266012" ></td>
 	</tr>
  	<tr>
  		<td><input type="hidden" name="password" value="dpgwg" ></td>
  	</tr>
   <tr>
   		<td><input type="hidden" name="time" value="200902121200" ></td>
   	</tr>
   	<tr> 
   		<td><font size="2"><b> Mobiles Number<br>(Comma separated)</b></font></td>
   		<td ><textarea name="To" class="textAreaContact" rows="4" cols="100" maxlength = "100" ><%=contactnum%></textarea>

   		</td>
   	</tr> 
   	<tr>
   		<td><font size="2"><b> Message</b></font></td>
   		<td>
   			<textarea name="Text" value="Hello" class="textAreaContact" rows="6" cols="100" maxlength ="140">Appointed for match <%=team1%> Vs <%=team2%> on <%=matchdate%> at <%=venue%> Please Reply YES To 575758</textarea>
   		</td>
   	</tr>
    <tr>
    	
    	<td colspan="2" align="center"><input type="submit" name="Ok" value="Send"> </td>
    </tr> 
</table> 
</form> 
</body> 
</html>
    