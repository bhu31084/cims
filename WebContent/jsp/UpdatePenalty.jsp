<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.text.SimpleDateFormat,
				java.util.*"
%>	
<%  	response.setHeader("Pragma","private");
		response.setHeader("Pragma", "No-cache");
	    response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");  
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);

	try{
		String matchId = (String)session.getAttribute("matchId");
		String InningId= (String)session.getAttribute("InningId");
	    GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
		Vector spParam = new Vector();
	    CachedRowSet penaltyCrs = null;
		CachedRowSet getPenaltyCrs = null;
		CachedRowSet penaltyDeleteCrs = null;
	   
		 
		Calendar cal = 	Calendar.getInstance();
		try{		
		   spParam.add(InningId);
		   penaltyCrs	= spGenerate.GenerateStoreProcedure("esp_dsp_getinningPenalty", spParam, "ScoreDB"); 
		   spParam.removeAllElements();	   	
	  	}catch (Exception e) {
 			e.printStackTrace();
 	  	}
 	  	
 	  	try{		
		   spParam.add("3");//flag 3 for penalty
		   getPenaltyCrs = spGenerate.GenerateStoreProcedure("dsp_types", spParam, "ScoreDB"); 
		   spParam.removeAllElements();	   	
	  	}catch (Exception e) {
 			e.printStackTrace();
 	  	}
 	  		  				
%>
<html>
<head>
</head>
<body>
						<div>
						<table border="0" width="90%" height="100%" >
							<tr>
								<td colspan="5" align="center"><b>Update Penalty</b></td>
							<tr>
							<tr>
								<td align="center"><b>Penalty </b></td>
								<td align="center"><b>Description</b></td>
								<td align="center"><b>Runs</b></td>
								<td align="center"><b>Date</b></td>
								<td align="center"><b>&nbsp;</b></td>
								
<%--								<td align="center">&nbsp;</td>--%>
							<tr>
<%							
							while(penaltyCrs.next()){
							
%>							<tr>
								<td align="center"><%=penaltyCrs.getString("penaltyno")%></td>	
								<td align="center"><%=penaltyCrs.getString("penaltyname")%></td>
								<td align="center"><%=penaltyCrs.getString("penaltyruns")%></td>
								<td align="center"><%=penaltyCrs.getString("penaltydate")%></td>								
								<td align="center"><input type="button" value="DELETE" onclick="penaltyDelete('<%=penaltyCrs.getString("penaltyid")%>',
																											  '<%=penaltyCrs.getString("penaltydate")%>',
																											  '<%=InningId%>'),updatePenalty()"></td>								
							</tr>
							
<%							}
%>
							<tr>
								<td colspan="5" align="center">
								<fieldset><legend class="legend1">Add New Penalty</legend>
									<br>
									<table>
										<tr>
											<td><b>Penalty Type:</b>
											<select id="selPenalty" name="selPenalty">
											<OPTION value="0">-- Select --</OPTION>
<%								if(getPenaltyCrs != null){			
									while(getPenaltyCrs.next()){
%>											<OPTION value="<%=getPenaltyCrs.getString("id")%>"><%=getPenaltyCrs.getString("name")%></OPTION>
<%									}
								}	
%>											</select>
											<b>Date:</b><input type="Text" id="txtPenaltyTime"  name="txtPenaltyTime" maxlength="25" size="25" value="" readonly>&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtPenaltyTime','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>
											<input type="button" value="  Add  " onclick="addPenalty(),updatePenalty()"/>
											</td>
										</tr>
									</table>
									<br>	
								</fieldset>
								</td>
							</tr>
<%--							<tr>--%>
<%--								<td >&nbsp;<input type="hidden" name="inningId" id="inningId" value="<%=InningId%>"></td>--%>
<%--							</tr>--%>
							<tr>
								<td colspan="5"><center><input type="button"  name="btnclose" id="btnclose" value="    Exit     " onclick="closePopup('BackgroundOverDiv', 'updatePenaltyDiv')"></center>
								<input type="hidden" id="hidPenalty" name="hidPenalty" value=""></td>
							</tr>
						</table>
						</div>
</body>
</html>						

<%}catch(Exception e){
		e.printStackTrace();
	}	
%>
	
