<!--
Page Name 	 : MatchTypeDetails.jsp
Created By 	 : Archana Dongre
Created Date : 9th Sept 2008
Description  : Creating Match Type.
Company 	 : Paramatrix Tech Pvt Ltd.
modifyed Date:12-09-2008
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"%>
<%@ include file="../AuthZ.jsp" %>
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
    String message = "";

    try{    
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
        matchCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_matchtypes",vparam,"ScoreDB");               								
                vparam.removeAllElements();
		if(matchCachedRowSet != null){
	    	while(matchCachedRowSet.next()){
	        	matchTypeId	=	matchCachedRowSet.getString("retval");	           
	            session.setAttribute("matchType_Id",matchTypeId);
	     		String match_Type_Id = (String)session.getAttribute("matchType_Id");  
	            System.out.println("match_Type_Id 	"+match_Type_Id);	            
			}
			if(matchTypeId != null){		
					message = " Record Saved Successfully. ";			
				}
		}
	}
	
%>
<html>
	<head>
    <title>Match Type Details</title>
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>   
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
		document.frmMatchTypeDetails.action = "/cims/jsp/admin/MatchTypeDetails.jsp";
		document.frmMatchTypeDetails.submit();
	}
	</script>
	</head>
	<body>
	<div class="container">
	<jsp:include page="Menu.jsp"></jsp:include>
		<FORM name="frmMatchTypeDetails" id="frmMatchTypeDetails" method="post">
		<div class="leg">Match Type Settings</div>
		<div class="portletContainer">
			<table width="100%" border="0" align="center" cellpadding="2"
					cellspacing="1" class="table">
				<tr>
					<td><fieldset><legend class="legend1">Add Match Type Details</legend> <br>
				 		<table width="90%" border="0" align="center" cellpadding="2" cellspacing="1" class="table" >
							<tr style="color:red;font-size: 2"><label><%=message%></label></tr>
							<tr align="left" class="contentDark">
								<td>&nbsp;&nbsp;Match Type :</td>
								<td>
									<input class="textBoxAdminMatchSetup" size="15" type="text" name="cmbName" id="cmbName" onfocus = "this.style.background = '#FFFFCC'" value="" 
									onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -123450()')">
								</td>
								<td>&nbsp;&nbsp;No of Players:</td>
								<td>
									<select onfocus = "this.style.background = '#FFFFCC'" class="inputFieldMatchSetup" name="cmbNoOfPlayers" id="cmbNoOfPlayers" >
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
							<tr width="90%" class="contentLight">
								<td>&nbsp;&nbsp;No Of Innings:</td>
							   	<td>
									<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="cmbNoOfInnings" id="cmbNoOfInnings">
										<option value="2" selected="selected">2</option>
										<option value="4">4</option>
									</select>
								</td>
								<td>&nbsp;&nbsp;Max Overs:</td>
							   	<td>
									<input class="textBoxAdminMatchSetup" size="2" maxlength="5" type="text" name="txtMaxOvers" id="txtMaxOvers" onfocus = "this.style.background = '#FFFFCC'" value="15" onKeyPress="return numbersonly(event)">
								</td>
							</tr>
							<tr align="left" class="contentDark">
				   				<td>&nbsp;&nbsp;No Of Days:</td>
								<td>
									<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="cmbNoOfDays" id="cmbNoOfDays">
									<option value="1" selected="selected">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="4">5</option>
								</td>
								<td>&nbsp;&nbsp;Ball Per Over :</td>
								<td>
									<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="cmbBallPerOver" id="cmbBallPerOver">
										<option value="6" selected="selected">6</option>
								    </select>
								</td>
							</tr>
							<tr width="90%" class="contentLight">
								<td>&nbsp;&nbsp;Power Play:</td>
							   	<td>
									<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="cmbPowerPlay" id="cmbPowerPlay">
										<option value="0">0</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3" selected="selected">3</option>
										<option value="4">4</option>
										<option value="4">5</option>
									</select>
								</td>
								<td>&nbsp;&nbsp;No Of Umpire:</td>
							   	<td>
									<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="cmbNoOfUmpire" id="cmbNoOfUmpire">
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3" selected="selected">3</option>
										<option value="4">4</option>
									</select>
								</td>
							</tr>
							<tr width="90%" class="contentDark">
								<td>&nbsp;&nbsp;Overs Per Bowler:</td>
							   	<td>
									<input class="textBoxAdminMatchSetup" maxLength=2 size="3" type="text" name="txtOversPerBowler" id="txtOversPerBowler" onfocus = "this.style.background = '#FFFFCC'" value="3" onKeyPress="return numbersonly(event)">
								</td>
								<td>&nbsp;&nbsp;Status:</td>
							   	<td>
									<select onfocus = "this.style.background = '#FFFFCC'"  class="inputFieldMatchSetup" name="cmbStatus" id="cmbStatus">
										<option value="A">A</option>
										<option value="D">D</option>									
									</select>
								</td>													   	
							</tr> 
							<tr width="100%" align="right" class="contentLight">
								<td colspan="4" height="24">       			
					       			<input class="btn btn-warning" type="button"  id="btnsubmit" name="btnsubmit" value=" Submit" onclick="callMain()">				       			
					      			<input class="btn btn-warning" type="button"  id="btnCancel" name="btnCancel" value="Cancel" onclick="cancellation()" >	      							      			
					      			<input type="hidden" name="hdmatch" id="hdmatch" value="">
									<input type="hidden" name="hdSubmit" id="hdSubmit" value="" >	      			
					       		</td>
							</tr>	
							</table> 
						<br>
						</fieldset> 	
					</td>
				</tr>
		    </table>				   
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
	</form>
</div>
<jsp:include page="Footer.jsp"></jsp:include>
</body>
	
</html>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
