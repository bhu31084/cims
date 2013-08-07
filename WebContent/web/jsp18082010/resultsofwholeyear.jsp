<!--
Page Name 	 : /NewWeb/jsp/WebLogin.jsp
Created By 	 : Archana Dongre.
Created Date : 10 feb 2009
Description  : New Web Login Page.
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ include file="loginvalidate.jsp" %>
<%		
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");			
	Common common = new Common();
	String pageNo = "1";
	String TotalNoOfPages = null;
	String TotalPageCount = "1";
	String res = "";
	String currentYear = sdf.format(new Date()).substring(0,4);	
	String page_no = "";
	CachedRowSet  crsObjRecentResults = null;	
	Vector vParam =  new Vector();	
	try{			
		vParam.add(pageNo);
		crsObjRecentResults = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_resultofmatches",vParam,"ScoreDB");
		vParam.removeAllElements();
		
		if(crsObjRecentResults != null){
			while(crsObjRecentResults.next()){
				TotalPageCount = crsObjRecentResults.getString("noofpages");					
			}
			crsObjRecentResults.beforeFirst();
		}
	}catch (Exception e) {
		System.out.println("Exception"+e);
		e.printStackTrace();
	}	
		
	%>			

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CIMS 2009</title>
<link href="../css/Main.css" rel="stylesheet" type="text/css" />
<%--<link href="../css/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />--%>
<link href="../css/commonSpry.css" rel="stylesheet" type="text/css" />
<%--<script language="JavaScript" type="text/javascript" src="../js/SpryTabbedPanels.js"></script>--%>
<script language="JavaScript" src="../js/jsKeyRestrictvalidation.js"></script> 
<script language="JavaScript" src="../js/popup.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>  
<script >
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
	function callSubmit(){					
			try{
				document.getElementById('hdSubmit').value = "submit"
			
				if(document.getElementById('txtUserName').value == ""){
					alert(" User Name can not be left Blank !");
					frmSchedule.txtUserName.focus();
				}else if(document.getElementById('password').value == ""){
					alert(" Password can not be left Blank !");
					frmSchedule.password.focus();
				}else{
					document.frmSchedule.submit();			
				}	
		}catch(err){
				alert("callSubmit"+err.description); 
		}
	}
		
	
	function previousYearData(){		
		var year = document.getElementById("txtyear").value
		var Year = year  - 1;
		document.getElementById("txtyear").value = Year;	
	}
	
	function NextYearData(){		
		var year = document.getElementById("txtyear").value
		year++;
		document.getElementById("txtyear").value = year ;
		
		
	}
	
	function NextTenRecords(){
		document.getElementById("btnBack").disabled = false;
		//alert(document.getElementById("hdpostpage").value)
		nextPage = document.getElementById("hdpostpage").value;
		//alert(document.getElementById("hdTotalNoOfPages").value)
		if(document.getElementById("hdTotalNoOfPages").value == "null"){
			alert("Please Search Matches");
		}else{
			var lastpage = document.getElementById("hdTotalNoOfPages").value;			
			nextPage++	
			document.getElementById("hdpostpage").value = 	nextPage;
			document.getElementById("hdprepage").value = nextPage;
			if(nextPage > lastpage){
				alert("You have reached on last page");
				document.getElementById("btnNext").disabled = true;
				return false;
			}else{
				searchMatches(nextPage)
			}
		}		
	}
	
	function previousTenRecords(){	
		document.getElementById("btnNext").disabled = false;
		//alert(document.getElementById("hdprepage").value)
		prePage = document.getElementById("hdprepage").value;		
		//alert(document.getElementById("hdTotalNoOfPages").value)
		if(document.getElementById("hdTotalNoOfPages").value == "null"){
			alert("Please Search Matches");
		}else{
			prePage--
			document.getElementById("hdprepage").value = prePage ;
			document.getElementById("hdpostpage").value = prePage;	
			if(prePage < "1"){
				alert("You have reached on first page ! ");				
				document.getElementById("btnBack").disabled = true;
				return false;				
			}else{			
				searchMatches(prePage)
			}
		}
	}
	
	function searchMatches(pageNo){
	document.getElementById("txtpageno").value = "";
	document.getElementById("lblpageno").value = pageNo;
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{			
			var url;
	    	url="resultsResponse.jsp?hdpageNo="+pageNo;	    	
	    	document.getElementById("resultsdiv").style.display='';
	    	document.getElementById("tempdiv").style.display= 'none';
			xmlHttp.open("post",url,false);
		   	xmlHttp.send(null);
		   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
				var responseResult= xmlHttp.responseText;								
				document.getElementById("resultsdiv").innerHTML = responseResult;				
			}			   	
		}
	}
	
	function searchMatchesbyPageNo(){
		var firstpage = 1;
		var requestedpage = document.getElementById("txtpageno").value
		var totalPages = document.getElementById("hdTotalNoOfPages").value				
		if(requestedpage != null || requestedpage != ""){			
			//alert("in if condition")
			if(parseInt(document.getElementById("txtpageno").value) < firstpage || parseInt(document.getElementById("txtpageno").value) > totalPages){
				alert("Please Select valid Page No")				
				document.getElementById("txtpageno").value = '';
				return false;																
			}else{
				document.getElementById("lblpageno").value = requestedpage;
				xmlHttp=GetXmlHttpObject();
				if(xmlHttp==null){
					alert ("Browser does not support HTTP Request");
					return;
				}else{			
					var url;
			    	url="resultsResponse.jsp?hdpageNo="+requestedpage;			    	
			    	document.getElementById("resultsdiv").style.display='';
			    	document.getElementById("tempdiv").style.display= 'none'; 		    				    	
					xmlHttp.open("post",url,false);
				   	xmlHttp.send(null);
				   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
						var responseResult= xmlHttp.responseText;										
						document.getElementById("resultsdiv").innerHTML = responseResult;
						document.getElementById("hdprepage").value = requestedpage ;
						document.getElementById("hdpostpage").value = requestedpage;		
					}			   	
				}			
			}
		}
	}
	function ShowFullScoreCard(matchid){		
		window.open("FullScoreCard.jsp?matchid="+matchid,"fullscorecard",'top= 50,left = 50,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=920,height=920');
	}

</script>
</head>

<body  style="margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-right: 0px;">
<form method="get" name="frmSchedule" id="frmSchedule" >		
<div id = "pbar" name="pbar" class="divlist" style="left: 450px;top: 300px;" align="center">
<table style="background: transparent;">			
	<tr>
<%--		<td align="center" valign="middle" ><b><img src="../Image/loading.gif" /></b></td>--%>
<td align="center" valign="middle"><b><img src="../Image/wait24trans.gif" />&nbsp;<font color="red" size="3"> Loading ......</b></font></td>
	</tr>
</table>
</div>
<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv" >
</div>
<script>showPopup('BackgroundDiv','pbar')</script>
<jsp:include page="Header.jsp"></jsp:include>
<div id="outerDiv" style="width: 1003px;height: 1000px;">			
<table style="width: 1003px;">
	<tr>
		<td valign="top">
		<table width="200" border="0" >
			<tr>
				<td valign="top">
				<%@ include file="commiteeinfo.jsp" %>
 	    		</td>						
			</tr>									  												          		
		</table>
		</td>
		<td width="600" border="0" valign="top">			
			<div id="MainDiv" style="width: 600px;height: 650px;">			   				   
			   	<table width="600" border="0" >					
					<tr>
				 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Results</td>
				   </tr>
				   </table>
				   <table width="600" border="0" style="border-left: none;border-top: none;border-right: none;border-bottom: none;" class="contenttable">
						<tr>
				    			<td align="left">
<%--				    				<input type="button" id="btnBack" name="btnBack" class="PopButton" onclick="previousTenRecords('<%=Integer.parseInt(pageNo)%>')" value="<<">--%>
<%--				    				&nbsp;&nbsp;&nbsp;<input type="button" id="btnNext" name="btnNext" class="PopButton" value=">>" onclick="NextTenRecords('<%=Integer.parseInt(pageNo)%>')">--%>
				    				<input type="hidden" id="hdprepage" name="hdprepage" value="1">
				    				<input type="button" id="btnBack" name="btnBack" class="PopButton" onclick="previousTenRecords()" value="<<">
				    				&nbsp;&nbsp;&nbsp;<input type="button" id="btnNext" name="btnNext" class="PopButton" value=">>" onclick="NextTenRecords()">
				    				<input type="hidden" id="hdpostpage" name="hdpostpage" value="1">
				    				<input align="middle"" type="text" size="2" id="txtpageno" name="txtpageno" value="" onKeyPress="return keyRestrict(event,'1234567890')">
				    				<input type="button" size="3" id="btngo" name="btngo" value="Go" class="PopButton" onclick="searchMatchesbyPageNo()">
				    				<input type="hidden" id="hdgo" name="hdgo" value="" >
				    			</td>
				    			<td align="left"><b>Current Page : <input type="text" id="lblpageno" value="1" size="1"> Of <%=TotalPageCount%></b>&nbsp;&nbsp;
				    			</td>
				    	</tr>
				    	</table>
				    	<div id="resultsdiv" style="display: none;"></div>
				    	<div id="tempdiv" style="height: 1000px;overflow: auto;">
				    	<table width="600" border="0" style="border-left: none;border-top: none;border-right: none;border-bottom: none;" class="contenttable">
		                	<%if(crsObjRecentResults != null){
		                		int counter = 1;		                		
		                		while(crsObjRecentResults.next()){
		                		res = crsObjRecentResults.getString("result");
		                		TotalNoOfPages = crsObjRecentResults.getString("noofpages");
		                		if(counter % 2 == 0 ){%>
		                		<tr bgcolor="#f0f7fd">
		                		<%}else{%>
		                		<tr bgcolor="#e6f1fc">
		                		<%}%>		                				                			
		                			<td valign="top" nowrap="nowrap" id="<%=counter++%>" align="center">&nbsp;&nbsp;&nbsp;<%=crsObjRecentResults.getString("expected_start").substring(0,11).toString()%>
		                			&nbsp; To &nbsp;<%=crsObjRecentResults.getString("expected_end").substring(0,11).toString()%>
		                			</td>
		                			<td nowrap="nowrap" align="center">																				    				
						    			<div id="teams"><font color="#C66908"><b><%=crsObjRecentResults.getString("matchbtwn")%></b></font></div> 
						    			<div><%=crsObjRecentResults.getString("seriesname")%>,<%=crsObjRecentResults.getString("venuename")%>
						    			<%if(res.equalsIgnoreCase("drawn")){%>
						    				<div><font color="red">Result :<%=res%>	</font></div>
						    			<%}else{%>
						    				<div><font color="red">Result :<%=res%></font>	</div>
						    				<div><font color="red">Winner :<%=crsObjRecentResults.getString("winningteam")%></font></div>
						    			<%}%></div>						    																								    			
						    			<div><a href="javascript:ShowFullScoreCard('<%=crsObjRecentResults.getString("id")%>')" >ScoreCard</a></div>
					    			</td>																                																				    		
					    	</tr>																	    	
					    	<%	}
		                	}%>	
		                										                	
	              		</table>	              
				</div>
			<input type="hidden" name="hdTotalNoOfPages" id="hdTotalNoOfPages" align="center" value="<%=TotalNoOfPages%>">	
			<input type="hidden" id="hdpageNo" name="hdpageNo" value="" >
			</td>
			<td width="200" border="0" valign="top"></td>
		</tr>
	</table>
</div>			

<table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" >
<tr>
	<td>     	      
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
	</tr>
</table>	
<jsp:include page="Footer.jsp"></jsp:include>
</form>	
</body>	
<script>    	
	closePopup('BackgroundDiv','pbar');	
 </script>	
</html>	

