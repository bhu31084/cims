<!--
Page Name	 : TossChange.jsp
Created By 	 : Archana Dongre.
Created Date : 17th Dec 2008
Description  : Edit the toss if selected wrong
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ 
	page import="sun.jdbc.rowset.CachedRowSet,
		java.text.SimpleDateFormat,java.text.NumberFormat,
		in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
		java.util.*"
%>

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
		String matchId = (String)session.getAttribute("matchId1"); 														
		GenerateStoreProcedure  lobjGenerateProc	= new GenerateStoreProcedure(matchId);								                      
		CachedRowSet 			selectedTeam 		= null;
		CachedRowSet  			crsUpdateDetail 	= null;
		Vector					vparam 				= new Vector();
		Calendar		 		cal 				= Calendar.getInstance();				
        vparam.add(matchId);                
		selectedTeam 	= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_select_teams",vparam,"ScoreDB");							
		vparam.removeAllElements();	
		
		if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit")){
			//Archana To insert the record in database.										 					
				String tossId 			= request.getParameter("dpTossWon");
				String chooseToId 		= request.getParameter("dpChooseTo");				
				
				System.out.println("matchId	"+matchId);       			 
    			System.out.println("tossId "+tossId);       		
    			System.out.println("chooseToId "+chooseToId);   
				
				vparam.add(matchId);
				vparam.add(tossId);
				vparam.add(chooseToId);
				System.out.println("vector is "+vparam);
				crsUpdateDetail = lobjGenerateProc.GenerateStoreProcedure("esp_amd_toss",vparam,"ScoreDB");
				vparam.removeAllElements();
				//end Archana
%>
<%
		  }
%>
<html>
	<head>
    	<title>Toss Selection </title>
   			<script language="JavaScript" src="../js/Calender.js" type="text/javascript"></script>
			<link rel="stylesheet" type="text/css" href="../css/common.css">
			<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
			<link rel="stylesheet" type="text/css" href="../css/menu.css">
		    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	        <link rel="stylesheet" type="text/css" href="../css/tabexample.css">
    		<script language="javascript">
				function callNextPage(){//to pass the values of variables on player selection page.					
					if(document.getElementById('dpChooseTo').value == "" || document.getElementById('dpTossWon').value == ""){
							alert("Please Select Each Field ");
							return false;
						}else{
						 	document.getElementById('hdSubmit').value = "submit"
						 	document.frmTossChg.submit();
						 	alert(" U Have Successfully Changed The Toss !!!");												
							window.opener.location.reload();
							window.close();	 											 							 	
						}			 					 	
		 		}	
		 		
		 		function callCancel(){//dipti 19 05 2009
		 			self.close();
		 		}	 			 
			</script>
	</head>
	<body>
		<FORM name="frmTossChg" id="frmTossChg" method="post">
		<table width="100%">
		<tr>
			<td>	
				<jsp:include page="/cims/jsp/Banner.jsp"></jsp:include>
			</td>	
		</tr>
		</table>
		<br>
		<table width="50%" align="center">
		<tr align="center">				
			<td align="center" style="background-color:gainsboro;"><font size="5" color="#003399"> Toss Change</font></td>
			<td><input type="hidden" name="hdmatch_id" id="hdmatch_id" value=""></td>						
		</tr>
		</table>
		<br>		
		<table width="80%" align="center" style="border-top: 1cm;">
		 <tr>
			<td>
				<fieldset id="fldsetToss" class="background">
				<legend class="background1">
					<a class="aheading">Toss Change</a>
				</legend> 
				<table align="center" width="50%">
				<tr>
					<td><b>Teams :</b></td>
			   		<td>
						<select name="dpTossWon" id="dpTossWon">
							<option value="">Select </option>
<%							while(selectedTeam.next()){
%>							<option value="<%=selectedTeam.getString("id")%>"><%=selectedTeam.getString("team_name")%></option>
<%							}
%>					    </select>
					</td>
					<td><b>Elected To :</b></td> 
					<td>
						<select name="dpChooseTo" id="dpChooseTo">						
							<option value="">Choose To</option>
					    	<option value="0">Bat</option>
					        <option value="1">Field</option>
					    </select>
					</td> 		  
				 </tr>
				 <tr><td><br></td></tr> 		
				 </table> 
				 </fieldset> 	
			  </td>
			</tr>
			<tr>
	       		<td align="center">	       			       			
	      			<input type="button" id="btnReset" name="btnReset" value="Reset" onclick="callNextPage()">
	      			<input type="button" id="btnBack" name="btnBack" value="Cancel" onclick="callCancel()"> <!--dipti 19 05 2009-->
					<input type="hidden" name="hdmatch" id="hdmatch" value="<%=matchId%>">
					<input type="hidden" name="hdSubmit" id="hdSubmit" value="">				
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

