<!--
Page Name: MasterWeathertype.jsp
Author 		 : Archana Dongre.
Created Date : 18th Sep 2008
Description  : Entry of weather type 
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

<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<%
try{	
	CachedRowSet  crsObjWeather = null;
	Vector vparam =  new Vector();		
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit")){
		/*For insertion of record in database.*/
		String gsweatherName =	request.getParameter("txtweathername");
		String gsweatherDesc =	request.getParameter("txtweatherdesc");
		vparam.add(gsweatherName);//
		vparam.add(gsweatherDesc);//
		crsObjWeather = lobjGenerateProc.GenerateStoreProcedure(
			"esp_amd_weathertypesmst",vparam,"ScoreDB");			
		vparam.removeAllElements();				
	}
%>

<head><title>Weather type Master</title>
<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">    
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">    
    <script>
    function callNextPage(){
    		document.getElementById('hdSubmit').value = "submit";
			document.frmWeathertype.action = "/cims/jsp/MasterWeathertype.jsp";
			document.frmWeathertype.submit();			
		}	
	 function cancellation(){
	 		document.getElementById('txtweathername').value="";
	 		document.getElementById('txtweatherdesc').value="";
			document.frmWeathertype.action = "/cims/jsp/MasterWeathertype.jsp";			
		}	
    </script>
</head>

<body>
<FORM name="frmWeathertype" id="frmWeathertype" method="post">
			<br>
			<br>
		<table width="50%" align="center" style="border-top: 1cm;">
			<tr>
				<td colspan="10" align="center" style="background-color:gainsboro;"><font size="5" color="#003399"><b>Weather Type Master</b></font></td>
			</tr>
			<tr>
				<td><hr></td>
			</tr>
			<tr>
				<td>
					<fieldset id="fldsetWeather"> 
						<legend >
							<font size="3" color="#003399" ><b>Weather Details </b></font>
						</legend> 
						<br>
			 		<table align="center" width="90%" class="TDData">
						<tr >
							<td><b>Weather Type Name :</b></td>
						   	<td>
								<input type="text" name="txtweathername" id="txtweathername" value="" >
							</td> 
						</tr>
						<tr>							
						   	<td><b>Weather Type Description:</b></td> 
							<td>
								<input type="text" name="txtweatherdesc" id="txtweatherdesc" value="" >
							</td> 
						</tr>								
					</table> 					
					<br>
					</fieldset>
					<hr> 	
				</td>
			</tr>
			<tr>				
	       		<td align="right">
	       			<input type="button" id="btnsubmit" name="btnsubmit" value=" Submit" onclick="callNextPage()">
	      			<input type="button" id="btnCancel" name="btnCancel" value="Reset" onclick="cancellation()" >	 
	      			<input type="hidden" id="hdSubmit" name="hdSubmit" value="">      			     			     			
	       		</td>
	    	</tr>
		</TABLE>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</form>
</body>			


