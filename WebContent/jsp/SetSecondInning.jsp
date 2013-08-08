<!--
Page Name	 : SetSecondInning.jsp
Created By 	 : Archana Dongre.
Created Date : 10th Sep 2008
Description  : To Set The Inning Id For Second Inning 
Company 	 : Paramatrix Tech Pvt Ltd.
Modified by Archana on12/09/08::Added code to pass the flag on the selectbatsmanbowler.jsp page.
-->
<%@ 
	page import="sun.jdbc.rowset.CachedRowSet,java.text.SimpleDateFormat,java.text.NumberFormat,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*"
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

<html>
	<head>
    	<title>Inning Selection </title>   			
			<link rel="stylesheet" type="text/css" href="../css/common.css">
			<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
			<link rel="stylesheet" type="text/css" href="../css/menu.css">    
		    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
    		<script language="javascript">
    			function callNextPage(){
    			if(document.getElementById("selFollow").value == "0")
    			{
    				alert('Please Select Follow on option:');
    				return false;
    			}
    			else{
	    			document.getElementById('hdSubmit').value = "submit";	
	    			document.frmInningSelection.submit();
	    			}
    			}
		 		
		 		function cancellation(){
		 					document.getElementById('hdSubmit').value = "submit"		 	
		 					//document.frmInningSelection.action = "SetSecondInning.jsp"
							document.frmInningSelection.submit();	 
		 		}		 
			</script>
	</head>

<%
	try{		

		     
		CachedRowSet 			selectedTeams 			= null;
		CachedRowSet 			crsInningId 			= null;
		CachedRowSet 			crsAddNextInningData 	= null;
		CachedRowSet 			crsGetSecondInningId 	= null;
		CachedRowSet 			crsobjback			 	= null;		
		CachedRowSet 			crsmatchresult			= null;	
		CachedRowSet 			crsobjinn				= null; //added by Avadhut			
		Vector					vparam 			= new Vector();			
		//To get the inning id-Archana
		String matchId = (String)session.getAttribute("matchId1");
		GenerateStoreProcedure  lobjGenerateProc= new GenerateStoreProcedure(matchId);  
		String preInningId = null;
		String battingTeam=null;
		String bowlingTeam=null;
		String cmbBattingTeam=null;
		String twoInningIds=null;
		//added by Avadhut:start			
		vparam.add(matchId);
		crsobjinn  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_inningnum",vparam,"ScoreDB");				
		vparam.removeAllElements();
		//added by Avadhut:end
		int result = 0;
		String flag=null;
		boolean autoflag = false;
		//String cmbMatch = "";
		int Count=0;
		String secondInningFlag	= "1";//flag 1 for the second inning check.

		vparam.add(matchId);					
		crsmatchresult = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchstatus",vparam,"ScoreDB");																					
		vparam.removeAllElements();	
		if(crsmatchresult!=null){
			while(crsmatchresult.next()){
				result =  crsmatchresult.getInt("result");
			}
		}
		if(result > 0){
			response.sendRedirect("Logout.jsp");
	        return;
		}
		
		vparam.add(matchId);					
		crsInningId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_inningdetails",vparam,"ScoreDB");																					
		vparam.removeAllElements();	
		if(crsInningId!=null){
			while(crsInningId.next()){				
				preInningId = crsInningId.getString("id");
			 	battingTeam = crsInningId.getString("batting_team");
			 	bowlingTeam = crsInningId.getString("bowling_team");
			 	flag = crsInningId.getString("flag");
			 	Count++;
			}// end of while
			String SecondInningId ="";
			if(flag.equalsIgnoreCase("oneday1")){
				autoflag = true;
			}else if(flag.equalsIgnoreCase("test1")){
				autoflag = true;
			}else if(flag.equalsIgnoreCase("oneday2") || flag.equalsIgnoreCase("test2")){
				response.sendRedirect("Logout.jsp");
				 return;
			}// end of if
			if(request.getParameter("hdback")!=null && request.getParameter("hdback").equals("back")){
					vparam.add(matchId);
					crsobjback = lobjGenerateProc.GenerateStoreProcedure("esp_amd_inning_back",vparam,"ScoreDB");
					vparam.removeAllElements();	
	        }else{
			if(autoflag){
				vparam.add(matchId);	
				vparam.add(bowlingTeam); //	battingTeam
				vparam.add(battingTeam); // bowlingTeam
				vparam.add("N"); // follow on flag
				crsAddNextInningData=lobjGenerateProc.GenerateStoreProcedure("esp_amd_inningstwo",vparam,"ScoreDB");
				vparam.removeAllElements();	
				if(crsAddNextInningData != null){
					while(crsAddNextInningData.next()){				
						SecondInningId = crsAddNextInningData.getString("RetVal");
					}	
				}			
				
	        	session.setAttribute("InningId",SecondInningId);
		        String inningId = (String)session.getAttribute("InningId");
		        response.sendRedirect("selectbatsmanbowlers.jsp?teamId="+battingTeam+"&chooseToId=0&hdsecondInningFlag=1");
		        return;
	       }
		   }// end of else	
		}// end of main if
		
	if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit"))
	{		
		String []teamId  = null;
		String []chooseToId = null;
		String battingTeam1 = null;
		String bowlingTeam1 = null;
		String SecondInningId ="";
		String char_flag    = "";//added by Avadhut

		if(request.getParameter("dpTeams") != null && request.getParameter("dpChooseTo") != null)
		{
			teamId = request.getParameter("dpTeams").split("~");
			chooseToId = request.getParameter("dpChooseTo").split("~");	
			char_flag = request.getParameter("selFollow");	//added by Avadhut
				
		}
		
		if(Count < 4){
		
			if(battingTeam.equals(teamId[0]))
			{
				battingTeam1 = battingTeam;
				bowlingTeam1 =  bowlingTeam;
			} 
			else
			{
				battingTeam1 = bowlingTeam;
				bowlingTeam1 =   battingTeam;
			}
		
		vparam.add(matchId);	
		vparam.add(battingTeam1); //	battingTeam
		vparam.add(bowlingTeam1); // bowlingTeam
		vparam.add(char_flag);//followon flag added by Avadhut
		crsAddNextInningData=lobjGenerateProc.GenerateStoreProcedure("esp_amd_inningstwo",vparam,"ScoreDB");
		vparam.removeAllElements();	
		
		if(crsAddNextInningData != null){
			while(crsAddNextInningData.next()){				
				SecondInningId = crsAddNextInningData.getString("RetVal");
			}	
		}			
		session.setAttribute("InningId",SecondInningId);
        String inningId = (String)session.getAttribute("InningId");
        
		response.sendRedirect("selectbatsmanbowlers.jsp?teamId="+teamId[0]+"&chooseToId="+chooseToId[0]+"hdsecondInningFlag=1");
			
		}	
	}							

%>
	<body>
		<FORM name="frmInningSelection" id="frmInningSelection" method="post"><br>
		<br>	
		<br>
		<table width="50%" align="center" style="border-top: 1cm;">
			<tr>
				<td colspan="10" align="center" style="background-color:gainsboro;"><font size="5" color="#003399">Set Inning </font></td>
			</tr>
			<tr>
				<td><hr></td>
			</tr>
			<tr>
				<td>
					<fieldset id="fldInning">
						<legend >
							<font size="3" color="#003399" ><b>Inning </b></font>
						</legend> 
						<br>
					<table align="center" width="80%" class="TDData" >
						<tr >
							<td><b>Match Teams:</b></td>
		   					<td>
								<select name="dpTeams" id="dpTeams" >
								<option value="">Select </option>
<%	

		    vparam.add(matchId);                
			selectedTeams 	= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_select_teams",vparam,"ScoreDB");								
			vparam.removeAllElements();				
	
			if(selectedTeams!=null){			
				while(selectedTeams.next()){
				if(selectedTeams.getString("id").equalsIgnoreCase(battingTeam)){%>
					<option value="<%=selectedTeams.getString("id")+"~"+selectedTeams.getString("team_name")%>" selected="selected">
								 	<%=selectedTeams.getString("team_name")%></option>
				<%}else{%>
					<option value="<%=selectedTeams.getString("id")+"~"+selectedTeams.getString("team_name")%>"><%=selectedTeams.getString("team_name")%></option>
				<%}
				}}%>				 	
							    </select>
							</td>
							<td><b>Choose To :</b></td> 
							<td>
								<select name="dpChooseTo" id="dpChooseTo">						
									<option value="">Choose To</option>
							    	<option value="0" selected>Bat</option>
<%--							        <option value="1">Field</option>				        --%>
							    </select>
							</td> 		  
						</tr> 		
<!--ADDED BY AVADHUT: START -->
<%
String inn_num = "";
while(crsobjinn.next()){
			inn_num = crsobjinn.getString("inning");
			System.out.println(inn_num);
			
			//if(inn_num.equalsIgnoreCase("3")){
%>					
					<tr >
						<td align="center"><font size="2" ><b>Follow On :</b></font></td>			
						<td>
							<select name="selFollow" id="selFollow" class="inputField" style="border: #000000 1px solid" width="200px">
							<option value="0">-Select-</option>
							<option	value="Y">Yes</option>
							<option	value="N">No</option>							
</select>
						</td>
					</tr>	
<% //}
 } %> 								
					<!--ADDED BY AVADHUT: END -->									
						
					</table> 
					<br>
				</fieldset> 
					
			</td>
		</tr>
		<tr>
			<td><hr></td>				
		</tr>	
		<tr>
	  		<td align="right">	       		
	   			<input type="button" id="btnNext" name="btnNext" value=" Next >" onclick="callNextPage()" >
	  			<input type="button" id="btnCancel" name="btnCancel" value="Cancel" onclick="cancellation()" >	      		
	      		<input type="hidden" id="hdpreInningId" name="hdpreInningId" value="<%=preInningId%>">	
	      		<input type="hidden" id="hdCount" name="hdCount" value="<%=Count%>">
	      		<input type="hidden" name="hdSubmit" id="hdSubmit" value="" >	
	      		<input type="hidden" name="hdsecondInningFlag" id="hdsecondInningFlag" value="<%=secondInningFlag%>">				
	       	</td>
	    </tr>
	</table>
	<script language="javascript">
			try
			{
				var	Count=0;
				var flg = "P";
				Count=document.getElementById('hdCount').value;
				var inId = document.getElementById('hdpreInningId').value;
				if(Count > 0){
				
					if(Count == 1){
					}else if(Count == 2){
					}else if(Count == 3){
					}else if(Count == 4){
					document.getElementById('btnNext').disabled=true;
					alert("All Four Inning Created");
					winhandle = window.open("scorer.jsp?InningIdPre="+inId+"&flg="+flg,"CIMS","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-20)+",height="+(window.screen.availHeight-30));	
				 		if (winhandle != null){
				 		//alert("OK");
					        window.opener="";
					        window.close();
					     } 
					}else{
					//alert("YOYOYOY"+5);
					}		
			  }	
			}catch(obj)
			{alert("Error........"+obj)}
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
		</form>
	</body>
</html>

