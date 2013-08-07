<!--
Page Name 	 : MatchTypeDetails.jsp
Created By 	 : Gaurav Yadav
Created Date : 9th Sept 2008
Description  : Creating General Match Information
Company 	 : Paramatrix Tech Pvt Ltd.
ver1
modifyed Date:12-09-2008
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"%>
<%  	response.setHeader("Pragma","private");
		response.setHeader("Pragma", "No-cache");
	    response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");  
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
%>

<%

    CachedRowSet 	 matchCachedRowSet		 =  null;
    Vector 		  		vparam 				 =  new Vector();
    GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();				
    
    String					name					= 	"";
    String					noOfPlayers				= 	"";
    String					noOfInnings				= 	"";
    String					maxOvers				= 	"";
    String					noOfDays				= 	"";
    String					powerPlay				= 	"";
    String					ballPerOver				= 	"";
    String					noOfUmpire				= 	"";
    String					status					= 	"";
    String					oversPerBowler			= 	"";
    String					matchTypeId				= 	"";
    
    try{
    	//if(request.getMethod().equalsIgnoreCase("Post"))
		//	{
		if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit"))
			{
    		name 			= request.getParameter("cmbName");
    		noOfPlayers 	= request.getParameter("cmbNoOfPlayers");
    		noOfInnings	 	= request.getParameter("cmbNoOfInnings");
    		maxOvers 		= request.getParameter("txtMaxOvers");
    		noOfDays 		= request.getParameter("cmbNoOfDays");
    		powerPlay 		= request.getParameter("cmbPowerPlay");
    		ballPerOver 	= request.getParameter("cmbBallPerOver");
    		noOfUmpire		= request.getParameter("cmbNoOfUmpire");
    		status 			= request.getParameter("cmbStatus");
    		oversPerBowler 	= request.getParameter("txtOversPerBowler");
    		
    		System.out.println("name			"+name);   
    		System.out.println("noOfPlayers		"+noOfPlayers);   
    		System.out.println("noOfInnings		"+noOfInnings);   
    		System.out.println("maxOvers		"+maxOvers);   
    		System.out.println("noOfDays		"+noOfDays);   
    		System.out.println("powerPlay		"+powerPlay);   
    		System.out.println("ballPerOver		"+ballPerOver);   
    		System.out.println("noOfUmpire		"+noOfUmpire);   
    		System.out.println("status			"+status);   
    		System.out.println("oversPerBowler	"+oversPerBowler);   
    		
				
				vparam.add(name);
				vparam.add(noOfInnings);
				vparam.add(noOfDays);
				vparam.add(noOfPlayers);
				vparam.add(maxOvers);
				vparam.add(ballPerOver);
				vparam.add(oversPerBowler);
				vparam.add(powerPlay);
				vparam.add(noOfUmpire);
				vparam.add(status);
                matchCachedRowSet    	= lobjGenerateProc.GenerateStoreProcedure("esp_amd_matchtypes",vparam,"ScoreDB");               								
                vparam.removeAllElements();
                if(matchCachedRowSet != null){
	                while(matchCachedRowSet.next()){
	                
	                		matchTypeId	=	matchCachedRowSet.getString("retval");
	                
	                //System.out.println(" hello"+matchCachedRowSet.getString("retval"));  
	                
	                	session.setAttribute("matchType_Id",matchTypeId);
	     				String match_Type_Id = (String)session.getAttribute("matchType_Id");  
	              		System.out.println("match_Type_Id 	"+match_Type_Id);
	                }
		   		}
		   	%>

<%--	   		<form name="frmName" id="frmName" method="post">	--%>
<%--	   			<input type="hidden" name="hdmatchType" id="hdmatchType" value="<%=matchTypeId%>">--%>
<%--	   		</form>--%>
<%--	   		<script>	   			--%>
<%--	   			document.frmName.action = "MatchSetUpMaster.jsp";	--%>
<%--				document.frmName.submit();	 	--%>
<%--	   		</script>--%>

		   	<%
		  }
%>

<html>
  <head>    
    <title>Match Type Details</title>
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">	  
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">    
  <script language="javascript">
  
  function numbersonly(e){
		var unicode=e.charCode? e.charCode : e.keyCode
		if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
			if (unicode<48||unicode>57) //if not a number
				return false //disable key press
		}
	}
		
		 function callMain(){
		 	if(document.getElementById('cmbName').value == ""|| document.getElementById('cmbNoOfPlayers').value == "" || 
			document.getElementById('cmbNoOfInnings').value == "" || document.getElementById('txtMaxOvers').value == "" || 
			document.getElementById('cmbNoOfDays').value == "" || document.getElementById('cmbPowerPlay').value == "" || 
			document.getElementById('cmbBallPerOver').value == "" || document.getElementById('cmbNoOfUmpire').value == "" || 
			document.getElementById('txtOversPerBowler').value == "" || document.getElementById('cmbStatus').value == "" ) 
			{
				alert("Please Fill Each Field Entry");
			}else {
			document.getElementById('hdSubmit').value = "submit"
			frmMatchTypeDetails.submit();	 			
			}
	 }
	 function cancellation(){
			document.frmMatchTypeDetails.action = "MatchTypeDetails.jsp";
			document.frmMatchTypeDetails.submit();	 
		}	
 
		</script>    
  </head>
  <body>
<jsp:include page="MasterPageMenu.jsp"></jsp:include> 
	<FORM name="frmMatchTypeDetails" id="frmMatchTypeDetails" method="post">	
		<table width="80%" align="center" style="border-top: 1cm;">
			<tr>
				<td colspan="4" align="center" style="background-color:#FFCC66;"><font size="5" color="#003399"><b>Match Type Settings</b></font></td>
			</tr>
			<tr>
				<td><hr></td>
			</tr>			
			<tr>
				<td>
					<fieldset id="fldsetMchTypeDetails"> 
						<legend >
							<font size="3" color="#003399" ><b>Match Type Details </b></font>
						</legend> 
						<br>
					<table align="center" width="70%" class="TDData">
						<tr >
			   				<td><b>Match Name:</b></td> 
							<td>
								<select name="cmbName" id="cmbName">
									<option "0" value="One Day">One Day Match</option>
									<option "1" value="Test">Test Match</option>
									<option "2" value="20-20 Match">20-20 Match</option>
									<option "3" value="Friendly Match">Friendly Match</option>
								</select>
							</td>
							<td><b>No of Players:</b></td> 
							<td>
								<select name="cmbNoOfPlayers" id="cmbNoOfPlayers">								
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11" selected="selected">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
								</select>
							</td>  							
						</tr>
						<tr>
							<td><br></td>
						</tr>
						<tr >
			   				<td><b>No Of Innings:</b></td> 
							<td>
								<select name="cmbNoOfInnings" id="cmbNoOfInnings">									
									<option value="2" selected="selected">2</option>
									<option value="4">4</option>									
								</select>
							</td>
							<td><b>Max Overs:</b></td> 
							<td>
								<input size="3" maxLength=2 type="text" name="txtMaxOvers" id="txtMaxOvers" value="15" onKeyPress="return numbersonly(event)">
							</td>  							
						</tr>
						<tr>
							<td><br></td>
						</tr>  
						<tr >
			   				<td><b>No Of Days:</b></td> 
							<td>
								<select name="cmbNoOfDays" id="cmbNoOfDays">									
									<option value="1" selected="selected">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="4">5</option>
								</select>
							</td>
							<td><b>Ball Per Over:</b></td> 
							<td>
								<select name="cmbBallPerOver" id="cmbBallPerOver">									
									<option value="6" selected="selected">6</option>									
								</select>
							</td>  							
						</tr>
						<tr>
							<td><br></td>
						</tr>
						<tr >
			   				<td><b>Power Play:</b></td> 
							<td>
								<select name="cmbPowerPlay" id="cmbPowerPlay">									
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3" selected="selected">3</option>
									<option value="4">4</option>
									<option value="4">5</option>
								</select>
							</td>
							<td><b>No Of Umpire:</b></td> 
							<td>
								<select name="cmbNoOfUmpire" id="cmbNoOfUmpire">									
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3" selected="selected">3</option>
									<option value="4">4</option>
								</select>
							</td>  							
						</tr>
						<tr>
							<td><br></td>
						</tr>
						<tr >
			   				<td><b>Overs Per Bowler:</b></td> 
							<td>
								<input size="3" maxLength=2 type="text" name="txtOversPerBowler" id="txtOversPerBowler" value="3" onKeyPress="return numbersonly(event)">
							</td>														
							<td><b>Status:</b></td> 
							<td>
								<select name="cmbStatus" id="cmbStatus">
									<option value="A">A</option>
									<option value="D">D</option>									
								</select>
							</td>  							
						</tr>						
						<tr>
							<td><br></td>
						</tr>
					</table> 
					</fieldset> 								
				</td>
			</tr>			
			<tr>
				<td><hr></td>
			</tr>
			<br>					
			<tr>
	       		<td align="right">
	       			<input type="button" id="btnSubmit" name="btnSubmit" value=" Submit" onclick="callMain()">
	      			<input type="button" id="btnCancel" name="btnCancel" value="Cancel" onclick="cancellation()" >	      			
	      			<input type="hidden" name="hdmatch" id="hdmatch" value="">
					<input type="hidden" name="hdSubmit" id="hdSubmit" value="" >    			
	       		</td>
	    	</tr>
	    </table>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
	</form>
</body>
</html>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
