<!--
	Author 		 : Dipti Shinde
	Created Date : 23/03/2009
	Description  : SMS Approval report disply .
	Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
	CachedRowSet seasonListCrs = null;
	CachedRowSet seriesListCrs = null;
	CachedRowSet seasonCrs = null;
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String 	currentDate	 = sdf.format(new Date());
	String fromDate = null;
	String toDate = null;
	GenerateStoreProcedure generateStProc = new GenerateStoreProcedure();
	Vector spParaVec = new Vector();
	
	spParaVec.removeAllElements();	
	spParaVec.add("1");
	seasonCrs = generateStProc.GenerateStoreProcedure("esp_dsp_season",spParaVec,"ScoreDB");
	spParaVec.removeAllElements();	

%>	
<html>
	<head>
		<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
		<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
		<title>SMS Approval</title>
		<script>
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
      
		function callSearch(){
			var accFlag = document.getElementById("selAccFlag").value
			var season = document.getElementById("selSeason").value
			var matchid = document.getElementById("txtMatchId").value

			if(season == ""){
				alert("Please select season.")
				return false
			}
			
		  	document.getElementById("hidAccFlag").value = accFlag
		  	document.getElementById("hidSeason").value = season
			try {
	           xmlHttp = this.GetXmlHttpObject();
	     	  if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	          }else{
           		  var url = "/cims/jsp/admin/SMSApprovalResponce.jsp?accFlag="+accFlag+"&pageNum=1&season="+season+"&matchid="+matchid
			     // xmlHttp.onreadystatechange = receiveSMSResponse
	          	  xmlHttp.open("post", url, false);
			   	  xmlHttp.send(null);
			   	  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	                try {
	                   var responseResult = xmlHttp.responseText ;
	            	   document.getElementById('divSMSApproval').innerHTML = responseResult
	            	   document.getElementById('divSMSApproval').style.display = ''
	                } catch(err) {
	                    alert(err.description + 'ajex.js.receiveSMSResponse()');
	                }
		          }
		   	  }
		   	} catch(err) {
	           	alert(err.description + 'callSearch()');
	        }
		}
		
     	function callNavigate(flag){
     	
	     	var totalPages = document.getElementById("hdTotalPages").value
	     	var currentPage = document.getElementById("txtPage").value
	     	var accFlag = document.getElementById("hdAcceptFlag").value
	     	var season = document.getElementById("hidSeason").value 
	     	var matchid = document.getElementById("hidMatchid").value 
	     	
     		if(flag == 1){//Previous
     			if((parseInt(currentPage) - 1) <= 0){
     				alert("This is first page.")
     				return false
     			}
     			document.getElementById("txtPage").value = parseInt(currentPage) - 1
     			pageNum = document.getElementById("txtPage").value
     			
     		}else if(flag == 2){//Next
     			if((parseInt(currentPage) + 1) > totalPages){
     				alert("This is last page.")
     				return false
     			}
     			document.getElementById("txtPage").value = parseInt(currentPage) + 1
     			pageNum = document.getElementById("txtPage").value
     			
     		}else if(flag == 3){//GoTo
     		    if(parseInt(currentPage) > totalPages || parseInt(currentPage) <= 0){
     				alert("Please enter valid page number.")
     				document.getElementById("txtPage").value = "1"
     				return false
     			}
     		    pageNum = document.getElementById("txtPage").value
     		}
     		
     		try {
	           xmlHttp = this.GetXmlHttpObject();
	     	  if (xmlHttp == null) {
	               alert("Browser does not support HTTP Request");
	               return;
	          }else{
           		  var url = "/cims/jsp/admin/SMSApprovalResponce.jsp?accFlag="+accFlag+"&pageNum="+pageNum+"&season="+season+"&matchid="+matchid
			      xmlHttp.open("post", url, false);
			   	  xmlHttp.send(null);
			   	  if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
	                try {
	                   var responseResult = xmlHttp.responseText ;
	            	   document.getElementById('divSMSApproval').innerHTML = responseResult
	            	   document.getElementById('divSMSApproval').style.display = ''
	                } catch(err) {
	                    alert(err.description + 'ajex.js.responsecallNavigate()');
	                }
		          }
		   	  }
		   	} catch(err) {
	           	alert(err.description + 'callNavigate()');
	        }
     	}
		</script>
	</head>
	<body>
		<jsp:include page="Menu.jsp"></jsp:include>
		<div class="leg"> SMS Report</div>
		<%--    Venue Master--%>
		<div class="portletContainer">
			<form action="" name="frmSMSApproval" id="frmSMSApproval" method="post">
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
					<tr>
						<td>
							<table width="100%" border="0" align="center" cellpadding="2"
							cellspacing="1" class="table" >
								<tr class="contentDark">
								<td >
									Season :
									<select name="selSeason" id="selSeason">
										<option>Select </option>
<%										if(seasonCrs != null){
											String seasonid = null;
											String curId = null;
											while(seasonCrs.next()){
											seasonid = seasonCrs.getString("id");
											curId = seasonCrs.getString("cur_season_id");
												if(seasonid.trim().equalsIgnoreCase(curId.trim())){
											
%>											<option selected="selected" value="<%=seasonCrs.getString("id")%>"><%=seasonCrs.getString("name")%></option>
<%												}else{%>
											<option value="<%=seasonCrs.getString("id")%>"><%=seasonCrs.getString("name")%></option>
<%												}
											}
										}
%>							   		 </select>
								
									Acceptance Flag : 
									<select id="selAccFlag" name="selAccFlag">
										<option value="">All</option>
										<option value="A">Y</option>
										<option value="R">N</option>
										<option value="NDNC">NDNC Registered</option>
										<option value="P">Pending</option>
									</select>
									&nbsp;&nbsp;&nbsp;
									Match Id :<input type=text id="txtMatchId" name="txtMatchId" value="">
									&nbsp;&nbsp;&nbsp;
									<input class="btn btn-warning" id="btnSearch" name="btnSearch" type="button" value="Search" onclick="callSearch()"/>
								</td>
								</tr>
								<tr>
									<td>
										<div id="divSMSApproval" name="divSMSApproval" align="center" style="display:none;align:center;left:500px;top:150px;width:900px;height:350px">
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<br>
				<input type="hidden" id="hidAccFlag" name="hidAccFlag" value="">
				<input type="hidden" id="hidSeason" name="hidSeason" value="">	
				<input type="hidden" id="hidMatchid" name="hidMatchid" value="">			
			</form>

		</div>
	</body>
</html>	
