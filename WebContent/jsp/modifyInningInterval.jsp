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
		String matchId = (String)session.getAttribute("matchId");
	    GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
	    CachedRowSet intervalCachedRowSet = null;
	    CachedRowSet displayintervalCachedRowSet = null;
		CachedRowSet getIntervalCrs = null;
		Common commonUtil= new Common();
	    Vector vparam = new Vector();
		 
		Calendar cal = 	Calendar.getInstance();
		String InningId= (String)session.getAttribute("InningId");
		try{
		   vparam.add("2");
		   vparam.add(InningId);
		   displayintervalCachedRowSet	= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_interval", vparam, "ScoreDB"); // Batsman List
		   vparam.removeAllElements();	   	
	  	}catch (Exception e) {
 			e.printStackTrace();
 	  	}
 	  	
 	  	
 	  	try{		
		   vparam.add("4");//flag 4 for intervals
		   getIntervalCrs = lobjGenerateProc.GenerateStoreProcedure("dsp_types", vparam, "ScoreDB"); 
		   vparam.removeAllElements();	   	
	  	}catch (Exception e) {
 			e.printStackTrace();
 	  	}			
%>
		<div>
			<table width="100%" height="100%" border="5">
				<tr>
					<td>
						<div id ="adjustinterval" name="adjustinterval">
						<table width="100%" height="100%">
							<tr>
								<td colspan="2"><b>Update Interval Time</b> </td>
							<tr>
							<tr>
								<td><b>Interval Name : </b></td>
								<td><b>Start Time:</b></td>
								<td><b>End Time:</b></td>
							<tr>
<%							int i=0;
							String endDate = null;
							String startDate = null;
							while(displayintervalCachedRowSet.next()){
%>							<tr>
								<td><%=displayintervalCachedRowSet.getString("name")%></td>	
								<td><input type="hidden" name="hdintervalid<%=i%>" id="hdintervalid<%=i%>" value="<%=displayintervalCachedRowSet.getString("id")%>">
									<input type="hidden" id="hdstartdate<%=i%>"  name="hdstartdate<%=i%>" maxlength="25" size="20" value="<%=commonUtil.formatDateTimeNewSlash(displayintervalCachedRowSet.getString("start_ts"))%>" readonly >
<% 								startDate = displayintervalCachedRowSet.getString("start_ts")==null?"":displayintervalCachedRowSet.getString("start_ts");
								if(!startDate.equalsIgnoreCase("")){
									startDate = commonUtil.formatDateTimeNewSlash(displayintervalCachedRowSet.getString("start_ts"));
								}	
%>								
								<input type="Text" id="txtstartdate<%=i%>"  name="txtstartdate<%=i%>" maxlength="25" size="20" value="<%=startDate%>" readonly >
<%
	/*Common commonUtil= new Common();	
	String startTime = commonUtil.formatDateTimeNewSlash(displayintervalCachedRowSet.getString("start_ts"));
	String endTime = commonUtil.formatDateTimeNewSlash(displayintervalCachedRowSet.getString("end_ts"));
	*/
%>								
<%--								<input type="hidden" id="hdStartTime<%=i%>" name="hdStartTime<%=i%>" value="<%=startTime%>">--%>
<%--								<input type="hidden" id="hdEndTime<%=i%>" name="hdEndTime<%=i%>" value="<%=endTime%>">--%>
								<a id="imganchor" name="imganchor" href="javascript:NewCal('txtstartdate<%=i%>','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a></td>
								<td>
								<%//if(displayintervalCachedRowSet.getString("end_ts").trim().equalsIgnoreCase("")){%>
<%--									<input type="Text" id="txtenddate<%=i%>"  name="txtenddate<%=i%>" maxlength="25" size="20" value="<%=displayintervalCachedRowSet.getString("end_ts")%>" readonly><a id="imganchor" name="imganchor" href="javascript:NewCal('txtenddate<%=i%>','ddmmyyyy',true,24)"></a>--%>
								<%//}else{
									 endDate = displayintervalCachedRowSet.getString("end_ts")==null?"":displayintervalCachedRowSet.getString("end_ts");
									 	
									 if(!endDate.equalsIgnoreCase("")){
										endDate = commonUtil.formatDateTimeNewSlash(displayintervalCachedRowSet.getString("end_ts"));
									}	
								%>
									<input type="Text" id="txtenddate<%=i%>"  name="txtenddate<%=i%>" maxlength="25" size="20" value="<%=endDate%>" readonly><a id="imganchor" name="imganchor" href="javascript:NewCal('txtenddate<%=i%>','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>
								<%//}%>
								</td>
								<td><input type="button" name="btndelete<%=i%>" id="btdelete<%=i%>" value="Delete" onclick="intervalDelete('<%=displayintervalCachedRowSet.getString("id")%>',
																															   '<%=displayintervalCachedRowSet.getString("start_ts")%>',
																															   '<%=displayintervalCachedRowSet.getString("end_ts")%>',
																															   '<%=InningId%>');updateInterval();alert('Interval Deleted')"></td>
								<td><input type="button" name="btnsave<%=i%>" id="btnsave<%=i%>" value="Save" onclick="callFun.edittime('<%=i%>')"></td>
							</tr>
							
<%							i=i+1;
							}
%>							<tr>
								<td>&nbsp;<input type="hidden" name="inningId" id="inningId" value="<%=InningId%>"></td>
							</tr>
							<tr>
								<td colspan="5" align="center">
								<fieldset><legend class="legend1">Add New Interval</legend>
									<br>
									<table>
										<tr>
											<td><b>Interval Type:</b>
											<select id="selInterval" name="selInterval">
											<OPTION value="0">-- Select --</OPTION>
<%								if(getIntervalCrs != null){			
									while(getIntervalCrs.next()){
%>											<OPTION value="<%=getIntervalCrs.getString("id")%>"><%=getIntervalCrs.getString("name")%></OPTION>
<%									}
								}	
%>											</select>
											&nbsp;<b>Start Time:</b><input type="Text" id="txtStartTime"  name="txtStartTime" maxlength="25" size="25" value="" readonly>&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtStartTime','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>
											&nbsp;<b>End Time:</b><input type="Text" id="txtEndTime"  name="txtEndTime" maxlength="25" size="25" value="" readonly>&nbsp;<a id="imganchor" name="imganchor" href="javascript:NewCal('txtEndTime','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>
											
											&nbsp;<input type="button" value="  Add  " onclick="addInterval();updateInterval()"/>
											</td>
										</tr>
									</table>
									<br>	
								</fieldset>
								</td>
							</tr>
							<tr>
								<td colspan="5"><center><input type="button"  name="btnclose" id="btnclose" value="    Close     " onclick="closePopup('BackgroundDiv', 'updateIntervalDiv')"></center></td>
							</tr>
						</table>
						</div>
					</td>
				</tr>
			</table>		
		</div>

<%}catch(Exception e){
		e.printStackTrace();
	}	
%>
	
