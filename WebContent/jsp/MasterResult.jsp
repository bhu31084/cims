<!--
Page Name: MasterResult.jsp
Author 		 : Archana Dongre.
Created Date : 18th Sep 2008
Description  :  Entry of result type 
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
	CachedRowSet  crsObjResult = null;
	Vector vparam =  new Vector();		
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit")){
		/*For insertion of record in database.*/
		String gsResultName =	request.getParameter("txtresultname");
		String gsResultDesc =	request.getParameter("txtresultdesc");
		vparam.add(gsResultName);//
		vparam.add(gsResultDesc);//
		crsObjResult = lobjGenerateProc.GenerateStoreProcedure(
			"esp_amd_resultsmst",vparam,"ScoreDB");			
		vparam.removeAllElements();				
	}
%>

<head><title>Result Master</title>
<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">    
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">    
    <script>
    function callNextPage(){
    		document.getElementById('hdSubmit').value = "submit";
			document.frmresult.action = "/cims/jsp/MasterResult.jsp";
			document.frmresult.submit();			
		}	
	 function cancellation(){
	 		document.getElementById('txtresultname').value="";
	 		document.getElementById('txtresultdesc').value="";
			document.frmresult.action = "/cims/jsp/MasterResult.jsp";			
		}	
    </script>
</head>

<body>
<FORM name="frmresult" id="frmresult" method="post">
			<br>
			<br>
		<table width="50%" align="center" style="border-top: 1cm;">
			<tr>
				<td colspan="10" align="center" style="background-color:gainsboro;"><font size="5" color="#003399"><b>Result Master</b></font></td>
			</tr>
			<tr>
				<td><hr></td>
			</tr>
			<tr>
				<td>
					<fieldset id="fldsetresult"> 
						<legend >
							<font size="3" color="#003399" ><b>Result Details </b></font>
						</legend> 
						<br>
			 		<table align="center" width="90%" class="TDData">
						<tr >
							<td><b>Result Name :</b></td>
						   	<td>
								<input type="text" name="txtresultname" id="txtresultname" value="" >
							</td> 
						</tr>
						<tr>							
						   	<td><b>Result Description:</b></td> 
							<td>
								<input type="text" name="txtresultdesc" id="txtresultdesc" value="" >
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


