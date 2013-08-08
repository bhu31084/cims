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
		System.out.println("InningId "+InningId);
	    GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
		Vector spParam = new Vector();
	    CachedRowSet crsObjinningCalculation = null;

		Calendar cal = 	Calendar.getInstance();
		try{//wkt         batsmanId   batsmanName  batsmanInTime           batsmanOutTime
			spParam.add(InningId);
		   	crsObjinningCalculation	= spGenerate.GenerateStoreProcedure("esp_dsp_inning_time_calc", spParam, "ScoreDB"); 
		   	spParam.removeAllElements();
	  	}catch (Exception e) {
 			e.printStackTrace();
 	  	}
%>					
	<div id="showInningTimeDiv">
						<table width="100%" height="100%" border="1" >
							<tr>
								<td colspan="11" align="center" ><font size="3"><b> Inning Time Calculation </b></font><br></td>
							</tr>													
							<tr class="contentLastDark">
								<td align="center"><b>Total Time </b></td>
								<td align="center"><b>Deducted Time</b></td>
								<td align="center"><b>Actual Inning Time</b></td>
								<td align="center"><b>No Of Lunch</b></td>
								<td align="center"><b>Lunch Time </b></td>
								<td align="center"><b>No Of Tea</b></td>
								<td align="center"><b>Tea Time </b></td>
								<td align="center"><b>End Of Day</b></td>
								<td align="center"><b>End Of Day Time</b></td>
								<td align="center"><b>Other Interruptions</b></td>
								<td align="center"><b>Other Interruptions Time</b></td>								
							</tr>
<%							while(crsObjinningCalculation.next()){%>
							<tr>
								<td align="center"><%=crsObjinningCalculation.getString("total_time")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("deducted_time")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("inn_time")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("lunch_count")%></td>
								<td align="center"><%=crsObjinningCalculation.getString("lunch_time")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("tea_count")%></td>
								<td align="center"><%=crsObjinningCalculation.getString("tea_time")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("eod_count")%></td>
								<td align="center"><%=crsObjinningCalculation.getString("eod_time")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("othe_count")%></td>
								<td align="center"><%=crsObjinningCalculation.getString("other_interuption")%></td>
							</tr>
							<tr><td colspan="11">&nbsp;</td></tr>
<%}%>						<tr>
								<td align="left" colspan="11"> <b>Note:</b> <font color="blue">Actual Inning Time = Total Time - Deducted Time
								&nbsp;&nbsp;&nbsp;and &nbsp;&nbsp; Other Interruptions :(Rain,Bad Light,etc.)</font></td>
							</tr>														
						</table>
					</div>	
<%}catch(Exception e){
		e.printStackTrace();
}%>