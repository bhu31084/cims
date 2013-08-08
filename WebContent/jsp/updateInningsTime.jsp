<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.text.SimpleDateFormat,
				java.util.*,in.co.paramatrix.csms.common.Common"
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
		Common commonUtil= new Common();
		String matchId = (String)session.getAttribute("matchId");
		String InningId= (String)session.getAttribute("InningId");
	    GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
		Vector spParam = new Vector();
		String maxBallTime = null;
	    CachedRowSet inningWicketCrs = null;
	    String endTime	= "";
	   
		 
		Calendar cal = 	Calendar.getInstance();
		try{		
		   spParam.add(InningId);
		   inningWicketCrs	= spGenerate.GenerateStoreProcedure("esp_dsp_inningStartTimeEndTime", spParam, "ScoreDB"); 
		   spParam.removeAllElements();	   	
	  	}catch (Exception e) {
 			e.printStackTrace();
 	  	}			
%>						<div>
						<table width="100%" height="100%" >
							<tr>
								<td colspan="5" align="center"><b>Update innings start time / end time</b></td>
							<tr>
							<tr>
								<td align="center"><b>Inning Id mkmkmk</b></td>
								<td align="center"><b>Start Time</b></td>
								<td align="center"><b>End Time</b></td>
								<td align="center">&nbsp;</td>
							<tr>
<%							
							while(inningWicketCrs.next()){
								endTime = inningWicketCrs.getString("end_ts");
								
							
%>							<tr>
<%--								<td align="center">Batsman : <%=inningWicketCrs.getString("wkt")%></td>	--%>
<%--								<td align="center"><%=inningWicketCrs.getString("batsmanName")%></td>	--%>
<%--								<td align="center">--%>
<%--									<input type="Text" id="txtwicketball<%=inningWicketCrs.getString("wkt")%>"  name="txtwicketball<%=inningWicketCrs.getString("wkt")%>" maxlength="25" size="25" value="<%=inningWicketCrs.getString("batsmanInTime")%>" readonly >&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtwicketball<%=inningWicketCrs.getString("wkt")%>','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>--%>
<%--								</td>--%>
<%--								<td align="center">--%>
<%--								<%//if(inningWicketCrs.getString("batsmanOutTime")==null || inningWicketCrs.getString("batsmanOutTime").equalsIgnoreCase("1900-01-01 00:00:00")){%>--%>
<%--									<input type="Text" id="txtwicketnextball<%=inningWicketCrs.getString("wkt")%>"  name="txtwicketnextball<%=inningWicketCrs.getString("wkt")%>" maxlength="25" size="25" value="<%=inningWicketCrs.getString("batsmanOutTime")==null || inningWicketCrs.getString("batsmanOutTime").equalsIgnoreCase("1900-01-01 00:00:00") ?"":inningWicketCrs.getString("batsmanOutTime")%>" readonly>&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtwicketnextball<%=inningWicketCrs.getString("wkt")%>','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>--%>
<%--								<%//}else{%>--%>
<%--								<input type="Text" id="txtwicketnextball<%=inningWicketCrs.getString("wkt")%>"  name="txtwicketnextball<%=inningWicketCrs.getString("wkt")%>" maxlength="25" size="25" value="<%=inningWicketCrs.getString("batsmanOutTime")==null || inningWicketCrs.getString("batsmanOutTime").equalsIgnoreCase("1900-01-01 00:00:00") ?"":inningWicketCrs.getString("batsmanOutTime")%>" readonly>&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtwicketnextball<%=inningWicketCrs.getString("wkt")%>','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>--%>
<%--								<%//}%>--%>
<%--								</td>--%>
								<td align="center"><%=InningId%></td>
								<td align="center">
								<%maxBallTime = commonUtil.formatDateTimeNewSlash(inningWicketCrs.getString("maxtime"));%>
									<input type="Text" id="txtstarttime"  name="txtstarttime" maxlength="25" size="25" value="<%=inningWicketCrs.getString("start_ts") == null ? "" : commonUtil.formatDateTimeNewSlash(inningWicketCrs.getString("start_ts"))%>" readonly >&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtstarttime','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>
									
								</td>
								<td align="center">
<%									//if(inningWicketCrs.getString("end_ts").equalsIgnoreCase("null")){
%>									
<%--<input type="Text" id="txtendtime"  name="txtendtime" maxlength="25" size="25" value="" readonly >&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtendtime','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>--%>
<%									//}else{
%>									
<%--<input type="Text" id="txtendtime"  name="txtendtime" maxlength="25" size="25" value="<%=inningWicketCrs.getString("end_ts") == null ? "" : inningWicketCrs.getString("end_ts")%>" readonly >&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtendtime','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>--%>
<%									//}
%>
									<input type="Text" id="txtendtime"  
									name="txtendtime" maxlength="25" size="25" 
									value="<%=inningWicketCrs.getString("end_ts")== null || 
									inningWicketCrs.getString("end_ts").equalsIgnoreCase("1900-01-01 00:00:00") ?"":commonUtil.formatDateTimeNewSlash(inningWicketCrs.getString("end_ts"))%>" readonly>&nbsp;
									<a id="imganchor" name="imganchor" 
									href="javascript:NewCal('txtendtime','ddmmyyyy',true,24)">
									<IMG src="../images/cal.gif" border="0"></a>
									
								</td>
								
							</tr>
							
<%							
							}
							
%>							<tr>
								<td align="center" colspan="3">
<% if (endTime== null || 
		endTime.equalsIgnoreCase("1900-01-01 00:00:00")){
%>				&nbsp;<input type="hidden" name="inningId" id="inningId" value="<%=InningId%>">
				<input type="button"  name="btnclose" id="btnclose" value=" Exit " onclick="closePopup('BackgroundOverDiv', 'updateInningsTimeDiv')">
<%}else{
%>	
				<input type="button" name="" id="" value=" Save "	onclick="callFun.editInningTime('<%=InningId%>','<%=maxBallTime%>')">
				&nbsp;<input type="hidden" name="inningId" id="inningId" value="<%=InningId%>">
				<input type="button"  name="btnclose" id="btnclose" value=" Exit " onclick="closePopup('BackgroundOverDiv', 'updateInningsTimeDiv')">	
<%}
%>							
								
							</td>
						</tr>
					</table>
						

<%}catch(Exception e){
		e.printStackTrace();
	}	
%>
	
