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
		String Flag = "1";
	    GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
		Vector spParam = new Vector();
	    CachedRowSet crsObjinningCalculation = null;

		Calendar cal = 	Calendar.getInstance();
		try{//wkt         batsmanId   batsmanName  batsmanInTime           batsmanOutTime
			spParam.add(InningId);
			spParam.add(Flag);
		   	crsObjinningCalculation	= spGenerate.GenerateStoreProcedure("esp_dsp_matchanalysis", spParam, "ScoreDB"); 
		   	spParam.removeAllElements();
	  	}catch (Exception e) {
 			e.printStackTrace();
 	  	}
%>
	<div id="showFourSixDiv">
						<table width="100%" height="100%" border="1">
							<tr>
								<td colspan="4" align="center"><font size="3"><b>  Four and Sixer Details </b></font> </td>
							<tr>
							<tr class="contentLastDark">
								<td align="center"><b>Batsman </b></td>
								<td align="center"><b>Bowler</b></td>
								<td align="center"><b>Over Number</b></td>
								<td align="center"><b>Four/Six</b></td>
							<tr>
<%							while(crsObjinningCalculation.next()){%>
							<tr>
								<td align="center"><%=crsObjinningCalculation.getString("batsman")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("bowler")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("over_num")%></td>	
								<td align="center"><%=crsObjinningCalculation.getString("name")%></td>																	
							</tr>
							<%}%>
						</table>
			</div>
<%}catch(Exception e){
		e.printStackTrace();
}%>