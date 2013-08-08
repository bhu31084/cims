<!--
	Author 				: Archana Dongre
	Created Date		: 02/03/2009
	Description 		: Wagon Wheel Report.
	Company 	 		: Paramatrix Tech Pvt Ltd.	
-->

<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" %>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%
		String match_id = request.getParameter("matchid")==null?"":request.getParameter("matchid");
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MM-dd hh:mm:ss");
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");
		java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd hh:mm");

		String inning_id = "0";
		String inningId = null;
		String selected_player1 = "0";
		String selected_player2 = "0";
		String selected_type = "0";
		String firstInning = null;
		//String match_id = session.getAttribute("matchid").toString();
		//String match_id = "687";
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();

		CachedRowSet crsObjInnings = null;
		CachedRowSet crsObjfirstInnings = null;
		CachedRowSet crsObjPlayers = null;
		CachedRowSet crsObjPlayers2 = null;

		Vector vparam = new Vector();

		if (request.getParameter("hid") != null) {
			if (request.getParameter("hid").equalsIgnoreCase("1")) {
				
				vparam = new Vector();
				vparam.add(firstInning);
				crsObjPlayers = lobjGenerateProc.GenerateStoreProcedure(
						"dsp_batsmenlist", vparam, "ScoreDB");
				crsObjPlayers2 = lobjGenerateProc.GenerateStoreProcedure(
						"dsp_batsmenlist", vparam, "ScoreDB");
			}
		}

		vparam = new Vector();
		vparam.add(match_id);
		crsObjInnings = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_getInnings", vparam, "ScoreDB");
		crsObjfirstInnings = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_getInnings", vparam, "ScoreDB");
		if(crsObjfirstInnings != null){
			int count = 0;
			while(crsObjfirstInnings.next()){
				if(count == 1){				
				 
				}else{
					firstInning = crsObjfirstInnings.getString("inning");
					count++;
				}
			}
		}
		System.out.println("count++;"+firstInning);
		vparam = new Vector();
		vparam.add(firstInning);
		crsObjPlayers = lobjGenerateProc.GenerateStoreProcedure(
				"dsp_batsmenlist", vparam, "ScoreDB");
		crsObjPlayers2 = lobjGenerateProc.GenerateStoreProcedure(
						"dsp_batsmenlist", vparam, "ScoreDB");
%>
<html>
<head>

<script type="text/javascript"> 
var xmlHttp=null;	
	function GetXmlHttpObject() {
		try{
			//Firefox, Opera 8.0+, Safari
			xmlHttp=new XMLHttpRequest();
		}catch (e){
			// Internet Explorer
			try{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}catch (e){
				try{
					xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
				}catch(e){
					alert("Your browser does not support AJAX!");      				
				}	
			}
		}
		return xmlHttp;
	}	

	function validate(){
		if(document.getElementById("inning_id").value != 0){
			document.getElementById("hid").value = "1";
			document.frmWagonWheel.submit();
		}
	}	
	function getViewData(){
		if(document.getElementById("type").value == 2){
			if(document.getElementById("player1").value == document.getElementById("player2").value){
				alert("Please select 2 different batsman for parternership wagon wheel.");
			}
		}
		if(document.getElementById("inning_id").value != 0){
			//document.getElementById("hid").value = "2";
			createRequestObject()
		}else{
			alert("Select inning.");
		}
	}
	
	function getInningData(inningId){		
	//alert(inningId)		
	xmlHttp=GetXmlHttpObject();
	if(xmlHttp==null){
		alert ("Browser does not support HTTP Request");
		return;
	}else{
			var url;
	    	url="/cims/web/jsp/wagonwheelresponse.jsp?inningid="+inningId;		    	
	    	document.getElementById("ajaxResponseDiv").style.display='';
			document.getElementById("loadDivWagonWheel").style.display= 'none'; 	
			xmlHttp.open("post",url,false);
		   	xmlHttp.send(null);
		   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				var responseResult= xmlHttp.responseText;
				document.getElementById("ajaxResponseDiv").innerHTML = responseResult;
			}			   	
		}
	}
</script>
	

<title>Wagon wheel</title>
</head>
<body>
<FORM name="frmWagonWheel" method="post">
<table border="1" width="100%">   
   <tr>
 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 20px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Wagon Wheel Graph</td>
   </tr>
	<TR>
		<TD align="right" colspan="4">Date: <B><%= sdf1.format(new Date())%> </B></TD>
	</TR>	
</TABLE>
<table  border="1" width="100%"> 
	<tr >
		<%if (crsObjInnings != null) {
			int i = 1;%>
			<%while (crsObjInnings.next()) {
				inningId = 	crsObjInnings.getString("inning");
				%>
				<td><input type="button" class="button" id="<%=inningId%>" value="Inning <%=i++%>" onclick="getInningData('<%=inningId%>')"></td>
			<%}
		  }	%>
	</tr>
</table>
<div id="loadDivWagonWheel">
<table width="100%" border="1" bgcolor="#f0f7fd">
	<tr >
		<td nowrap="nowrap" valign="top">
<%--			<div style="width: 250px;height: 100%">--%>
			<table border="1" class="contenttable" >
				<tr style="width: 100%;">		    
		    		<td style="text-align: center;font-size: 13px;" colspan="2"><b>Players List</b></td>		    
		   		</tr>
				
				 <%if(crsObjPlayers != null){ %>													
		     <%	int colorcounter = 1;
		     while(crsObjPlayers.next()){		     			
		   		if(colorcounter % 2 == 0 ){%>
        		<tr bgcolor="#f0f7fd">
        		<%}else{%>
        		<tr bgcolor="#e6f1fc" style="width: 100%;">	
        		<%}%>		    
			    <td style="text-align: left;font-size: 15px;padding-left: 50px;" nowrap="nowrap" id="<%=colorcounter++%>">									  			
			     <a id="<%=crsObjPlayers.getString("id")%>"><%=crsObjPlayers.getString("playername")%></a>
			    </td>
			   </tr>
		      <% }
		      }%>
		      <tr>
			</table>
		</td>
		<td style="height: 100%" valign="top">
			<div id="wagonwheel" style=""><img src="../Image/WagonWheel.jpg" width="275"
				height="350" border="1" />			
			</div>
		</td>
	</tr>
</table>
</div>
<div id="ajaxResponseDiv" style="display: none;"></div>
<INPUT type="hidden" id="hid" name="hid" /></FORM>
</body>
</html>
