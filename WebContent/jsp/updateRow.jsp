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
	CachedRowSet updateBallCrs = null;
	CachedRowSet wicketTypesCrs = null;
	CachedRowSet fielderNameCrs = null;
	CachedRowSet wicketDetailCrs = null;
	CachedRowSet batsmenNameCrs = null;
	
	String matchId = (String)session.getAttribute("matchId1");
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
	Vector spParam = new Vector();
	LogWriter log = new LogWriter();
	Common commonUtil =  new Common();
		
	String inningId = (String)session.getAttribute("InningId");
	String ballId	= request.getParameter("ballId");
	String runType = request.getParameter("runType");
	String wideBallType = request.getParameter("wideBallType");
	String noBallType = request.getParameter("noBallType");
	String legByesType = request.getParameter("legByesType");
	String byesType = request.getParameter("byesType");
	String date = request.getParameter("date");
	String flag = request.getParameter("flag");
	String batsman = request.getParameter("batsman");
	String bowlerid = request.getParameter("bowlerid");
	String overno = request.getParameter("over")==null?"":request.getParameter("over").trim();
	String wicketType = "";
	String fielder1 = "";
	String fielder2 = "";
	String batsman1 = "";
	
	int ioverno = 0;
	 try {
	 	ioverno = Integer.parseInt(overno);
	 	ioverno = ioverno - 1;
	 	
	 }catch (Exception e) {
	    e.printStackTrace();
	 }
	
if(flag.equalsIgnoreCase("1")){
	
	try{
		spParam.add(ballId); 
		spParam.add(runType); 
		spParam.add(wideBallType); 
		spParam.add(noBallType); 
		spParam.add(legByesType); 
		spParam.add(byesType);
		spParam.add(date);
		spParam.add(bowlerid);
		spParam.add(String.valueOf(ioverno));
		updateBallCrs = spGenerate.GenerateStoreProcedure("esp_amd_updateeachball",spParam,"ScoreDB");
		spParam.removeAllElements();
	}catch (Exception e) {
		System.out.println("*************updateRow.jsp*****************"+e);
	   // e.printStackTrace();
	    log.writeErrLog(page.getClass(),matchId,e.toString());
	}
}else if(flag.equalsIgnoreCase("2")){//to show update wicket div 
	
	try{
		spParam.add("1");
		wicketTypesCrs = spGenerate.GenerateStoreProcedure("dsp_types",spParam,"ScoreDB");
		spParam.removeAllElements();
	}catch (Exception e) {
    	System.out.println("*************updateRow.jsp*****************"+e);
    	log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	try{
		spParam.add(inningId);
		fielderNameCrs = spGenerate.GenerateStoreProcedure("dsp_fieldlist",spParam,"ScoreDB");
		spParam.removeAllElements();
	}catch (Exception e) {
    	System.out.println("*************updateRow.jsp*****************"+e);
    	log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	try{
		spParam.add(ballId);
		spParam.add(inningId);
		batsmenNameCrs = spGenerate.GenerateStoreProcedure("esp_dsp_getStrikerNonstriker",spParam,"ScoreDB");
		spParam.removeAllElements();
	}catch (Exception e){
    	e.printStackTrace();
    	log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	try{
		spParam.add(ballId);
		wicketDetailCrs = spGenerate.GenerateStoreProcedure("esp_dsp_wicketdetail",spParam,"ScoreDB");
		spParam.removeAllElements();
	}catch (Exception e) {
    	System.out.println("*************updateRow.jsp*****************"+e);
    	log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	
	if(wicketDetailCrs != null){	
		while(wicketDetailCrs.next()){
			wicketType = wicketDetailCrs.getString("type");
			fielder1 = wicketDetailCrs.getString("dismissed_by1");
			fielder2 = wicketDetailCrs.getString("dismissed_by2");
			batsman1 = wicketDetailCrs.getString("batsman");
		}
	}
%>
<html>
<body>
	<table align="center" border="1" width="95%">
		<tr class="tenoverupdateball">
			<th>Wicket Types</th>
			<th>Fielder 1</th>
			<th>Fielder 2</th>
			<th>Batsman</th>
		</tr>
		<tr class="contentLastDark">
			<td>
				<select id="selWicketType" name="selWicketType">
<%				if(wicketTypesCrs != null){	
					while(wicketTypesCrs.next()){
%>
						<option value ="<%=wicketTypesCrs.getString("id")%>" 
						<%=wicketType.equalsIgnoreCase(wicketTypesCrs.getString("id")) ? "selected" : ""%>>
						<%=wicketTypesCrs.getString("description")%></option>					
<%					}//end while
				}//end if	
%>	
				</select>
			</td>
			<td>
				<select id="selFielder1" name="selFielder1">
<%				if(fielderNameCrs != null){	
%>					<option value ="0" 
					<%=fielder1.equalsIgnoreCase("0") ? "selected" : ""%>>-- select --</option>
<%					while(fielderNameCrs.next()){
%>
				 		<option value ="<%=fielderNameCrs.getString("id")%>" 
				 		<%=fielder1.equalsIgnoreCase(fielderNameCrs.getString("id")) ? "selected" : ""%>>
				 		<%=fielderNameCrs.getString("playername")%></option>					
<%					}//end while
				}//end if	
%>	
				</select>
				
			</td>
			<td>
				<select id="selFielder2" name="selFielder2">
<%				if(fielderNameCrs != null){	
					fielderNameCrs.beforeFirst();
%>					<option value ="0" 
					<%=fielder2.equalsIgnoreCase("0") ? "selected" : ""%>>-- select --</option>
<%					while(fielderNameCrs.next()){
%>
 						<option value ="<%=fielderNameCrs.getString("id")%>" 
 						<%=fielder2.equalsIgnoreCase(fielderNameCrs.getString("id")) ? "selected" : ""%>>
 						<%=fielderNameCrs.getString("playername")%></option>					
<%					}//end while
				}//end if	
%>	
				</select>
				
			</td>
			<td>
				<select id="selBatsmanName" name="selBatsmanName">
<%				if(batsmenNameCrs != null){	
					while(batsmenNameCrs.next()){//
%> 						<option value ="<%=batsmenNameCrs.getString("id")%>"
 						<%=batsman1.equalsIgnoreCase(batsmenNameCrs.getString("id")) ? "selected" : ""%>>
 						<%=batsmenNameCrs.getString("playername")%></option>					
<%					}//end while
				}//end if	
%>	
				</select>
				
			</td>
		</tr>
	</table>
	<br>
	<input type="button" align="center" value="Update"  onclick="callFun.updateRowWicket(<%=ballId%>),callFun.updateScore('<%=(ioverno - 1)%>'),closePopup('BackgroundDiv','updateWicketDiv'),closePopup('BackgroundDiv','updateRunsDiv')">
	<input type="button" align="center" value="Exit"  onclick="closePopup('BackgroundDiv','updateWicketDiv')">
</html>
<%
}//end else
%>

