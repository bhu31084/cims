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
		   	crsObjinningCalculation	= spGenerate.GenerateStoreProcedure("esp_dsp_partnershipdtls_withtime", spParam, "ScoreDB"); 
		   	spParam.removeAllElements();
	  	}catch (Exception e) {
 			e.printStackTrace();
 	  	}
%>					
	<div id="showPartnerShipDiv">
						<table width="100%" height="100%" border="1" >
							<tr>
								<td colspan="4" align="center"><font size="3"><b>  Partnership Details </b></font> </td>
							<tr>
							<tr class="contentLastDark">
								<td align="center"><b>Player Name </b></td>
								<td align="center"><b>Total Runs</b></td>
								<td align="center"><b>Total Time Taken</b></td>
								<td align="center"><b>No Of Balls</b></td>																
							<tr>
<%							while(crsObjinningCalculation.next()){%>
							<tr>
								<td align="center"><%=crsObjinningCalculation.getString("batsman")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("runs")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("mins")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("balls")%></td>								
							</tr><%}%>																				
						</table>
					</div>	
<%}catch(Exception e){
		e.printStackTrace();
}%>