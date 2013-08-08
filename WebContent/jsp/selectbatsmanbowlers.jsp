<!--
Page Name	 : selectbatsmanbowlers.jsp
Created By 	 : Archana Dongre.
Created Date : 10th aug 2008
Description  : To Select The players for the match.
Company 	 : Paramatrix Tech Pvt Ltd.
Modified By-Updated on: 05.57 pm 11/09/2008 by Avadhut
Modified By Archana on 12-09-08 1.00pm-Added if condition and hidden field for the secondInningFlag
Modified by Archana on12/09/08::Added code to get the flag from the setSecondInning.jsp page to use in the if else condition for the esp_amd_teamplayers1 SP execution 
-->
<!---->

<%@ page import="sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ include file="AuthZ.jsp" %>
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

		CachedRowSet  teamPlayersCachedRowSet 	= null;
		CachedRowSet  BatsMan1 = null;
		CachedRowSet  BatsMan2 = null;
		CachedRowSet  Bowlers  = null;
		CachedRowSet  crsobjback = null;
		CachedRowSet  crsobjinn = null;
		CachedRowSet intervalCachedRowSet  = null;
		CachedRowSet pauseInningCachedRowSet = null;
		Collection crs = null;
		Vector vparam =  new Vector();
		LogWriter log = new LogWriter();

		String intervalidarr[] = null;
		String intervalnamearr[] = null;
		int intervalleng = 0;
		String team2			= null;
		String captain			= null;
		String wicketkeeper 	= null;
		String extraplayer 		= null;
		String palyerId			= null;
		String extras			= null;	
		String inningId 		= null;
		String matchId 			= null;
		String IntervalId 		= null;
	    String IntervalName 	= "";
	    String intervalid		= "";
	    String intervalname     = "";
	    String intervalcount	= "";
	    
		matchId = (String)session.getAttribute("matchId1");
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);	
		// String inningId = (String)session.getAttribute("InningId");
		//out.println("Inning id "+inningId);
//Code Added By Gaurav
		if(session.getAttribute("InningId") == null)
			{
				inningId = request.getParameter("InningId");
				session.setAttribute("InningId",inningId);
			}
			else
			{
               	inningId = (String)session.getAttribute("InningId");
			}
//Code Added By Gaurav	End                
               
		
		captain 		= request.getParameter("hdCaptain");//request.getParameter("strCaptain");
		wicketkeeper 	=  request.getParameter("hdWicketKeeper");//request.getParameter("strWicketkeeper");hdWicketKeeper
		palyerId		= request.getParameter("hdteamPlayers");
		extraplayer 	=  request.getParameter("hd12thMan");	
		extras			= request.getParameter("hdteamPlayersextra");					    			
		String secondInningFlag	=request.getParameter("hdsecondInningFlag");	    	

//INSERTINg Team2 Players in the DB
			
 		team2 = request.getParameter("hdteam2");
 		if(secondInningFlag != null && secondInningFlag.equalsIgnoreCase("1")){
	 		vparam.add(inningId);
			BatsMan1 = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenList",vparam,"ScoreDB");
			BatsMan2 = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenList",vparam,"ScoreDB");
			vparam.removeAllElements();
			
			vparam.add(inningId);
			Bowlers  = lobjGenerateProc.GenerateStoreProcedure("dsp_bowlingList",vparam,"ScoreDB");				
			vparam.removeAllElements();
		}else {
			if(team2!=null && palyerId!=null && captain!=null & wicketkeeper!=null ){
				vparam.add(matchId);
	 			vparam.add(team2); 					
				vparam.add(palyerId);
				vparam.add(captain);
				vparam.add(wicketkeeper); 
				vparam.add(extraplayer); 
				vparam.add(extras); 																
				teamPlayersCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_teamplayers1",vparam,"ScoreDB");													
				vparam.removeAllElements();				
			}
			vparam.add(inningId);
			BatsMan1 = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenList",vparam,"ScoreDB");
			BatsMan2 = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenList",vparam,"ScoreDB");
			vparam.removeAllElements();
							
			vparam.add(inningId);
			Bowlers  = lobjGenerateProc.GenerateStoreProcedure("dsp_bowlingList",vparam,"ScoreDB");				
			vparam.removeAllElements();
		}	
%>

<%		 try{
			vparam.add(inningId);
		    intervalCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_intervalstatus", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();		
			while(intervalCachedRowSet.next()){
				intervalid = intervalCachedRowSet.getString("id");
				intervalname = intervalCachedRowSet.getString("name");
				intervalcount = "1";
			}
		}catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		vparam.add(matchId);
		crsobjinn  = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_inningnum",vparam,"ScoreDB");				
		vparam.removeAllElements();
			try{
	        	vparam.add("4"); //default value 4 Flag 4 for Interval
			    pauseInningCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_types", vparam, "ScoreDB"); // Interval Type List
		
	        	
	    	    while(pauseInningCachedRowSet.next()){
	    	     		IntervalId = IntervalId +  pauseInningCachedRowSet.getString("id") + "~";
    	    			IntervalName = IntervalName + pauseInningCachedRowSet.getString("name") + "~";
    	    		}	
		        if(IntervalId!="" && IntervalId!=null){
			        intervalidarr = IntervalId.split("~");
    			    intervalnamearr = IntervalName.split("~");
    			}  
		    	intervalleng = intervalidarr.length;  	
    	    	vparam.removeAllElements();
			}catch (Exception e) {
			    e.printStackTrace();
			    log.writeErrLog(page.getClass(),matchId,e.toString());
			}
%>


<html>
<head>
<script language="JavaScript" src="../js/ajax.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/common.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/intervalTime.js" type="text/javascript"></script>
<link href="../css/csms.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">	  
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">  

<script>
	/* Added to show the Player list */
	function viewlist(){		
		var match = document.getElementById('hdmatch').value		 	
		window.open("/cims/jsp/ViewTeamPlayersList.jsp?match="+match,"playerlist","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=Yes,top=10,left=10,width=980,height=450");	
	}
	
</script> 
</head>
<body onload="viewlist()">
<FORM name="Selection" id="Selection" method="post">
	<table width="100%">
		<tr>
			<td>	
				<jsp:include page="Banner.jsp"></jsp:include>
				<jsp:include page="MenuEditTossOption.jsp"></jsp:include>
			</td>	
		</tr>
	</table>
	
	<br>
	<table border="0" width="100%" height="30%" align="center">
	<br>
		<tr>
			<td class="legend" align="center">SELECT BATSMEN AND BOWLER</td>
		</tr>
			
		<tr>
			<td colspan="3">
				<fieldset id="fldsetExtraData">
					<LEGEND >
						<font size="3" color="#003399" ><b>Players </b></font>
					</LEGEND> 			
					<table border="0" width="100%" align="center">
						<tr >
							<td align="center"><font size="2" ><b>Striker :</b></font></td>						
							<td>
								<select name="selBatsMan1" id="selBatsMan1" class="inputField" style="border: #000000 1px solid" width="200px">
									<option value="">-Select-</option>
<%								while(BatsMan1.next()){
%>
									<option value="<%=BatsMan1.getString("playername")+"~"+BatsMan1.getString("id")%>"><%=BatsMan1.getString("playername")%></option>
<%								}
%>	
								</select>
							</td>
						</tr>
						<tr >
							<td align="center"><font size="2" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Non-Striker :</b></font></td>			
							<td>
								<select name="selBatsMan2" id="selBatsMan2" class="inputField" style="border: #000000 1px solid" width="200px">
									<option value="">-Select-</option>
<%								while(BatsMan2.next()){
%>
									<option value="<%=BatsMan2.getString("playername")+"~"+BatsMan2.getString("id")%>"><%=BatsMan2.getString("playername")%></option>
<%								}
%>
							</select>
						</td>
					</tr>
					<tr >
						<td align="center"><font size="2" ><b>&nbsp;Bowler :</b></font></td>			
						<td>
							<select name="selBowler" id="selBowler" class="inputField" style="border: #000000 1px solid" width="200px">
								<option value="">-Select-</option>
<%							while(Bowlers.next()){
							//System.out.println("Player Id is "+Bowlers.getString("player_Id"));
%>								<option	value="<%=Bowlers.getString("playername")+'~'+ Bowlers.getString("id")%>"><%=Bowlers.getString("playername")%></option>
<%							}
%>							</select>
						</td>
					</tr>
				 </table>
				<br>
				</fieldset>
		</td>
	</tr>
	<tr>
	</tr>
</table>
<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv">
</div>
<div id="linkintervaldiv" name="linkintervaldiv" class="divInterval">
	<table align="center">
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td>
				<lable><b>  Interval :- </b></lable>
				<select name="selinterval" id="selinterval">
					<option value="">--Select Interval Type--</option>
<%		 			for(int a=0;a<intervalleng;a++){
%>			 		<option value="<%=intervalnamearr[a]%>~<%=intervalidarr[a]%>"><%=intervalnamearr[a]%></option>
<%					}
%>				 </select>
			</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr>
		 <td><lable><b>  Remark :- </b></lable><textarea NAME="txtintervalremark" id="txtintervalremark" ROWS="2" COLS="40"></textarea>
		 </td>
		</tr>
		 <tr>
		 	<td>&nbsp;
		 	</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input class="btn btn-warning" type="button" align="center" id="btninterval" name="btninterval" value="  Interval  " 	onclick="callinterval('selinterval')"></input>
				<input class="btn btn-warning" type="button" align="center" id="btncancel" name="btncancel" value="  Cancel  " 	onclick="closePopup('BackgroundDiv','linkintervaldiv')"></input>
			</td>
		</tr>		
	</table>	
</div>
<div id="PopupDiv" class="popupdiv">
</div>
   <table border="0" align="center" >	
		<tr>
			<td colspan="2" align="center">
				<input class="btn btn-warning" type="button" align="center"	id="btnsubmit" name="btnsubmit" value="Submit" onclick="callMain();"></input>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<% while(crsobjinn.next()){
				if(crsobjinn.getString("inning").equals("3")){%>
				<input class="btn btn-warning" align="center" type="button" value="Back" onclick="cancelSelection()"></input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<%}
				}%>
				<input class="btn btn-warning" type="button" id="btnbatintervaltime" name="btnbatintervaltime" value="Interval Time"
				onclick="showPopup('BackgroundDiv','linkintervaldiv')">
			</td>
		</tr>
	</table>
	
<input type="hidden" id="inningId" name="inningId" value="<%=inningId%>"></input>	
<input type="hidden" name="hdintervalstatusid" id="hdintervalstatusid" value="<%=intervalid%>">
<input type="hidden" name="hdintervalstatusname" id="hdintervalstatusname" value="<%=intervalname%>">	
<input type="hidden" name="hdintervalstatuscount" id="hdintervalstatuscount" value="<%=intervalcount%>">
<input type="hidden" id="hdback" name="hdback" value=""></input>
<%if(crsobjback != null && crsobjback.next()){%>
<input type="hidden" id="hdmsg" name="hdmsg" value="<%=crsobjback.getString("RetVal")%>"></input>
<%}else{%>
<input type="hidden" id="hdmsg" name="hdmsg"></input>
<input type="hidden" id="hdmatch" name="hdmatch" value="<%=matchId%>" ></input>
<%}%>
<%	}catch(Exception e){
		e.printStackTrace();
	}
%>
<script>
	checkintervalrefreshstatus();
</script>
</form>
</body>
</html>

