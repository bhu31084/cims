<!--
Page Name 	 : updateRow.jsp
Created By 	 : Dipti Shinde.
Created Date : 21-Oct-2008
Description  : To update individual ball
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 21-Oct-2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%	
	String overNumber = request.getParameter("overNumber");
	CachedRowSet updateBallCrs = null;
	CachedRowSet inningCrs = null;
	String matchId = (String)session.getAttribute("matchId1");
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
	Vector spParam = new Vector();
	LogWriter log = new LogWriter();
	Common commonUtil =  new Common();
	String flag = "false";//flag to add blank tr in between current and next over
	String allBallIds = "";
	String inningId = request.getParameter("selectedInnId");
	String curInningId =(String)session.getAttribute("InningId");
	String role=(String)session.getAttribute("role");
		
	if(role != null && role.equals("9")){
			System.out.println("--ADMIN");
	}else{
			System.out.println("--NOT ADMIN");
	}
	 
	try{
		spParam.add(overNumber);
		spParam.add(inningId);
		updateBallCrs = spGenerate.GenerateStoreProcedure("esp_dsp_ballsinover",spParam,"ScoreDB");
		spParam.removeAllElements();
	}catch (Exception e) {
		System.out.println("*************updateInningEachOver.jsp*****************"+e);
    	e.printStackTrace();
    	log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	try{
		spParam.add(inningId);
		inningCrs = spGenerate.GenerateStoreProcedure("esp_dsp_inningStartTimeEndTime",spParam,"ScoreDB");
		spParam.removeAllElements();
	}catch (Exception e) {
		System.out.println("*************updateInningEachOver.jsp*****************"+e);
    	e.printStackTrace();
    	log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	String inningEndTime = null;
	if(inningCrs!=null){		
			while(inningCrs.next()){
				inningEndTime = inningCrs.getString("end_ts");
			}
	}		

%>
<html>
<head>
</head>
<body>
	<table align="center" border="1" width="97%">
		<tr>
			<td colspan="15" ><center><b>Over Number : <%=(Integer.parseInt(overNumber)+1)%> </b> </center></td>
		</tr>
		<tr class="tenoverupdateball">
			<th>&nbsp;</th>
			<th>Ball No</th>
			<th>Bowler</th>
			<th>Batsman</th>
			<th>Non Striker</th>
			<th>Over</th>
			<th>Runs</th>
			<th>Wides</th>
			<th>No balls</th>
			<th>Leg byes</th>
			<th>Byes</th>
			<th>Wkt</th>
			<th>Over the wkt</th>
			<th>Date</th>
			<th>&nbsp;</th>
<%			//if(role != null && role.equals("9")){//for delete link
			if(inningEndTime != null && !(inningEndTime.equalsIgnoreCase("null"))){//for delete link	

%>			<th>&nbsp;</th>
<%			}
%>			
		</tr>
<%	if(updateBallCrs!=null){		
		int i = 1;
		
		while(updateBallCrs.next()){
		
	    if(updateBallCrs.getInt("overno") != (Integer.parseInt(overNumber)+1)){break;}
				
			allBallIds = allBallIds + updateBallCrs.getString("ball_id") + "~";
			if(updateBallCrs.getString("authentic").equalsIgnoreCase("N")){
%>		<tr class="contentOffline">
<%			}else if(updateBallCrs.getString("authentic").equalsIgnoreCase("M")){
%>		<tr class="contentUpdated">
<%			}else{	
%>		<tr class="contentLastDark" > 
<%			}
%>
			<td><input type="checkbox" id="chkBallId" name="chkBallId" value="<%=updateBallCrs.getString("ball_id")%>"></td>
			<td align="center"><%=i%></td>
			<td nowrap class="lefttd"><%=updateBallCrs.getString("Bowler")%></td>
			<td nowrap class="lefttd"><%=updateBallCrs.getString("Batsman")%></td>
			<td nowrap class="lefttd"><%=updateBallCrs.getString("NonStriker")%></td>
			<td nowrap><%=updateBallCrs.getString("overno")%></td>
			<td><%=updateBallCrs.getString("runs")%></td>
			<td><%=updateBallCrs.getString("wideball")%></td>
			<td><%=updateBallCrs.getString("noball")%></td>
			<td><%=updateBallCrs.getString("legbeyes")%></td>
			<td><%=updateBallCrs.getString("byes")%></td>
			<td><%=updateBallCrs.getString("wkt")%></td>
			<td><%=updateBallCrs.getString("over_wkt")%></td>
			<td nowrap="nowrap"><%=updateBallCrs.getString("ball_date")%></td>
			<td class="lefttd"><a href="javascript:updateOverRuns('<%=i%>',
																'<%=updateBallCrs.getString("ball_id")%>',
																'<%=updateBallCrs.getString("runs")%>',
																'<%=updateBallCrs.getString("wideball")%>',
																'<%=updateBallCrs.getString("noball")%>',
																'<%=updateBallCrs.getString("legbeyes")%>',
																'<%=updateBallCrs.getString("byes")%>',
																'<%=updateBallCrs.getString("wkt")%>',
																'<%=updateBallCrs.getString("overno")%>',
																'<%=updateBallCrs.getString("ball_date")%>',
																'<%=updateBallCrs.getString("strikerid")%>',
																'<%=updateBallCrs.getString("Bowler")%>',
																'<%=updateBallCrs.getString("BowlerId")%>'),closePopup('BackgroundOverDiv','addBallDiv')">EDIT</a></td>

			<td class="lefttd"><a href="javascript:deleteRecord('<%=updateBallCrs.getString("ball_id")%>'),updateScore('<%=(Integer.parseInt(overNumber))%>')">DELETE</a></td>

		</tr>	
<%			i=i+1;
		}//end while
	}//end if
%>
	</table>
	<br>
	<input type="button" align="center" value="Swap Batsman" 
		onclick="javascript:updateBall('');updateScore('<%=Integer.parseInt(overNumber)%>')">
	<input type="button" align="center" value="Swap All Batsman" 
		onclick="javascript:updateBall('<%=allBallIds%>');updateScore('<%=Integer.parseInt(overNumber)%>')">
	<input type="button" align="center" value="Exit"  
		onclick="javascript:closePopup('BackgroundOverDiv','selectedOverBallsDiv'),
		closePopup('BackgroundOverDiv','updateRunsDiv'),closePopup('BackgroundOverDiv','updateWicketDiv'),closePopup('BackgroundOverDiv','addBallDiv')">
<%	//if(role != null && role.equals("9")){
if(inningEndTime != null && !(inningEndTime.equalsIgnoreCase("null"))){//for delete link	
%>	<input type="button" value="Add New Ball" onclick="javascript:addBallOpenDiv('<%=Integer.parseInt(overNumber)%>','<%=curInningId%>'),closePopup('BackgroundOverDiv','updateWicketDiv'),closePopup('BackgroundOverDiv','updateRunsDiv')">	
<%	}
%>
</html>

