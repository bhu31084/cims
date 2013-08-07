<!--
	Author 		 : Archana Dongre
	Created Date : 17/09/2008
	Description  : Display current match Player's Report.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	try {
		
		String gsmatchid = request.getParameter("matchid");
		gsmatchid = "117";
		String battingteam = null;
		String gsinningId = null;
		String runs = "";
	 	CachedRowSet crsObjBowlerDetails = null;
		CachedRowSet crsObjBatsmanDetails = null;
		CachedRowSet crsObjInning = null;
		
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();		
		Vector val = new Vector();		
		val.add(gsmatchid);
		crsObjInning = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getInnings", val, "ScoreDB");
		String inning_id = null;
		val.removeAllElements();
		
		if(request.getParameter("dpPlayer")!= null && request.getParameter("txtruns")!= null ){
			gsinningId = request.getParameter("dpinning");
			//System.out.println("inningId "+gsinningId);
			runs = request.getParameter("txtruns");
			//System.out.println("runs "+runs);
			val.add(gsinningId);
			val.add(runs);			
			crsObjBatsmanDetails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_batsmanruns", val, "ScoreDB");	
			val.removeAllElements();		
		}	
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8"/>	    
		<title></title>
		<link rel="stylesheet" type="text/css" href="../../css/common.css">
		<link rel="stylesheet" type="text/css" href="../../css/stylesheet.css">
	</head>  
<body>
<form name="frmPlayerReport" id="frmPlayerReport" method="post" action="/cims/jsp/mobile/MobilePlayerReport.jsp">	
	<table border="0" align="center" width="100%">
		
		<tr><td colspan="7"><hr></td></tr>
		<tr>
			<td align="center" >
				<select id="dpinning" name="dpinning">				
				<%if(crsObjInning != null){
					while(crsObjInning.next()){ %>
<%if(crsObjInning.getString("inning").equalsIgnoreCase(gsinningId)){%>										
								<option value="<%=crsObjInning.getString("inning")%>" selected="selected"><%=crsObjInning.getString("battingteam")%></option>
<%}else{%>
								<option value="<%=crsObjInning.getString("inning")%>"><%=crsObjInning.getString("battingteam")%></option>
<%		}				
	}
}
				%>
				</select>				
				<select id="dpPlayer" name="dpPlayer">				
				<option value="0" selected="selected">BatsMan</option>
				<option value="1">Bowler</option>
				</select>				
				<input type="text" id="txtruns" name="txtruns" value="<%=runs%>" size="3" maxlength="3">				
				<input type="submit" id="btnsearch" name="btnsearch" value="show">
			</td>			
		</tr>
		<tr><td colspan="7"><hr></td></tr>
	</table>
	<%if(crsObjBatsmanDetails !=null){%>
	<div id="batsmanDiv" style="display: ''">
		<table border="1" align="center" width="100%">
		<tr>
			<td colspan="5" align="center" style="background-color:#E3E3E3;"><font size="2" color="#003399"><b>BatsMan's Report</b></font></td>			
		</tr>
		<tr>
			<td><font size="1" ><b>BatsMan Name</b></td>
			<td><font size="1" ><b>Runs</b></td>
			<td><font size="1" ><b>Balls</b></td>
			<td><font size="1" ><b>S/R</b></td>						
		</tr>
	<%	
				while(crsObjBatsmanDetails.next()){
			%>
		<tr>			
			<td><font size="1" color="#003399"><%=crsObjBatsmanDetails.getString("batsman")%></td>
			<td><font size="1" color="#003399"><%=crsObjBatsmanDetails.getString("runs")%></td>
			<td><font size="1" color="#003399"><%=crsObjBatsmanDetails.getString("balls")%></td>
			<td><font size="1" color="#003399"><%=crsObjBatsmanDetails.getString("strike")%>%</td>				
		</tr>
		<%		}%>			
	</table>
	</div> 	
	<%}	%>
	<br>	
	<%if(crsObjBowlerDetails !=null){%>
	<div id="bowlerDiv" style="display: ''" >
		<table border="1" align="center" width="100%">
		<tr>
			<td colspan="4" align="center" style="background-color:#E3E3E3;"><font size="2" color="#003399"><b>Bowler's Report</b></font></td>			
		</tr>
		<tr>
			<td><font size="1" color="#003399"><b>Bowler Name</b></td>
			<td><font size="1" color="#003399"><b>Overs</b></td>
			<td><font size="1" color="#003399"><b>Wickets</b></td>			
		</tr>
		<%	
				while(crsObjBowlerDetails.next()){
			%>
		<tr>			
			<td><font size="1" color="#003399"><%=crsObjBowlerDetails.getString("batsman")%></td>
			<td><font size="1" color="#003399"><%=crsObjBowlerDetails.getString("runs")%></td>
			<td><font size="1" color="#003399"><%=crsObjBowlerDetails.getString("balls")%></td>
			<td><font size="1" color="#003399"><%=crsObjBowlerDetails.getString("strike")%>%</td>				
		</tr>
		<%		}%>	
	</table>	
	</div>
	<%}%>  		
</form> 	      
</body>
</html>
<%}catch(Exception e){
	
}%>
