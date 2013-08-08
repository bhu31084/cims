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
		String InningId= (String)session.getAttribute("InningId");
		String innStartTime = null;
		String innEndTime = null;
	    GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
	    Common commonUtil= new Common();
		Vector spParam = new Vector();
	    CachedRowSet inningWicketCrs = null;
        CachedRowSet batsmanTotalTimeCrs = null;
        CachedRowSet inningTimeCrs = null;
	   
		 
		Calendar cal = 	Calendar.getInstance();
		try{//wkt         batsmanId   batsmanName  batsmanInTime           batsmanOutTime
		
		   spParam.add(InningId);
		   inningWicketCrs	= spGenerate.GenerateStoreProcedure("esp_dsp_wicketBatsmanTime", spParam, "ScoreDB"); 
		   spParam.removeAllElements();	   	
	  	}catch (Exception e) {
 			e.printStackTrace();
 	  	}	
 	  	
 	  	try{
		
		   spParam.add(InningId);
		   inningTimeCrs	= spGenerate.GenerateStoreProcedure("esp_dsp_getinnstartendtime", spParam, "ScoreDB"); 
		   spParam.removeAllElements();	   	
	  	}catch (Exception e) {
 			e.printStackTrace();
 	  	}	
 	  	
 	  	if(inningTimeCrs != null && inningTimeCrs.size() > 0){
	 	  	while(inningTimeCrs.next()){
 	  			innStartTime = inningTimeCrs.getString("start_ts");
 	  			innEndTime = inningTimeCrs.getString("end_ts");
 	  		}
 	  	}
 	  	
 	  	
 	  		
%>						<div>
						<table width="100%" height="100%" >
							<tr>
								<td colspan="5" align="center"><b>Update batsman in time and batsman out time</b></td>
							<tr>
							<tr>
								<td align="center"><b>Wicket Number </b></td>
								<td align="center"><b>Batsman Name</b></td>
								<td align="center"><b>In Time</b></td>
								<td align="center"><b>Out Time</b></td>
								<td align="center">&nbsp;</td>
							<tr>
<%							//int i=0;
							while(inningWicketCrs.next()){
							
%>							<tr>
								<td align="center">Batsman : <%=inningWicketCrs.getString("wkt")%></td><!--batsmanId-->	
								<td align="center"><%=inningWicketCrs.getString("batsmanName")%></td>	
								<td align="center">
									<input type="Text" id="txtwicketball<%=inningWicketCrs.getString("wkt")%>"  name="txtwicketball<%=inningWicketCrs.getString("wkt")%>" maxlength="25" size="25" value="<%=commonUtil.formatDateTimeNewSlash(inningWicketCrs.getString("batsmanInTime"))%>" readonly >&nbsp;<a id="imganchor" name="imganchor"  href="javascript:NewCal('txtwicketball<%=inningWicketCrs.getString("wkt")%>','ddmmyyyy',true,24);"><IMG src="../images/cal.gif" border="0"></a>
									<input type="hidden" id="hidwicketball<%=inningWicketCrs.getString("wkt")%>"  name="hidwicketball<%=inningWicketCrs.getString("wkt")%>" maxlength="25" size="25" value="<%=commonUtil.formatDateTimeNewSlash(inningWicketCrs.getString("batsmanInTime"))%>" />
									<input type="hidden" id="hidmaxball<%=inningWicketCrs.getString("wkt")%>"  name="hidmaxball<%=inningWicketCrs.getString("wkt")%>" maxlength="25" size="25" value="<%=inningWicketCrs.getString("maxballtime") == null || inningWicketCrs.getString("maxballtime").equalsIgnoreCase("1900-01-01 00:00:00") ?"":commonUtil.formatDateTimeNewSlash(inningWicketCrs.getString("maxballtime"))%>">
								</td>
								<td align="center">
									<input type="Text" id="txtwicketnextball<%=inningWicketCrs.getString("wkt")%>"  name="txtwicketnextball<%=inningWicketCrs.getString("wkt")%>" maxlength="25" size="25" value="<%=inningWicketCrs.getString("batsmanOutTime")==null || inningWicketCrs.getString("batsmanOutTime").equalsIgnoreCase("1900-01-01 00:00:00") ?"":commonUtil.formatDateTimeNewSlash(inningWicketCrs.getString("batsmanOutTime"))%>" readonly>&nbsp;<a id="imganchor" name="imganchor"  href="javascript:NewCal('txtwicketnextball<%=inningWicketCrs.getString("wkt")%>','ddmmyyyy',true,24)" ><IMG src="../images/cal.gif" border="0"></a>
									<input type="hidden" id="hidwicketnextball<%=inningWicketCrs.getString("wkt")%>"  name="hidwicketnextball<%=inningWicketCrs.getString("wkt")%>" maxlength="25" size="25" value="<%=inningWicketCrs.getString("batsmanOutTime")==null || inningWicketCrs.getString("batsmanOutTime").equalsIgnoreCase("1900-01-01 00:00:00") ?"":commonUtil.formatDateTimeNewSlash(inningWicketCrs.getString("batsmanOutTime"))%>">
								</td>
								<td>
									<input type="button" name="btnsave<%=inningWicketCrs.getString("wkt")%>" 
									id="btnsave<%=inningWicketCrs.getString("wkt")%>" value="Save"
									onclick="callFun.editwicketBalltime(<%=inningWicketCrs.getString("wkt")%>,
																		<%=inningWicketCrs.getString("batsmanId")%>);
											callFun.validateStartEndTime('<%=inningWicketCrs.getString("wkt")%>','<%=innStartTime%>','<%=innEndTime%>',
											'<%=inningWicketCrs.getString("maxballtime") == null || inningWicketCrs.getString("maxballtime").equalsIgnoreCase("1900-01-01 00:00:00") ?"": commonUtil.formatDateTimeNewSlash(inningWicketCrs.getString("maxballtime"))%>')">
									
								</td>
							</tr>
							
<%							//i=i+1;
							}
%>							<tr>
								<td >&nbsp;<input type="hidden" name="inningId" id="inningId" value="<%=InningId%>"></td>
							</tr>
							<tr>
								<td colspan="5"><center><input type="button"  name="btnclose" id="btnclose" value="    Exit     " onclick="closePopup('BackgroundOverDiv', 'updateWicketBallTimeDiv')"></center></td>
							</tr>
						</table>
						

<%}catch(Exception e){
		e.printStackTrace();
	}	
%>
	
