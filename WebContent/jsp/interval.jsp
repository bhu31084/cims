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
		String matchId = (String)session.getAttribute("matchId1");
	    GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
	    CachedRowSet intervalCachedRowSet = null;
	    CachedRowSet displayintervalCachedRowSet = null;
	    Vector vparam = new Vector();
		
		Calendar cal = 	Calendar.getInstance();
		String InningId= (String)session.getAttribute("InningId");
		String intervalType = request.getParameter("intervaltype")==null?"":request.getParameter("intervaltype");
		String id = request.getParameter("id")==null?"": request.getParameter("id");  
		String flag = request.getParameter("flag")==null?"":request.getParameter("flag");  
		String note = request.getParameter("remark")==null?"":request.getParameter("remark");
		String over = request.getParameter("over")==null?"":request.getParameter("over");
		String matchid= request.getParameter("matchid")==null?"":request.getParameter("matchid");
		String totaltarget = request.getParameter("totaltarget")==null?"":request.getParameter("totaltarget");
		String gsdate = null;
		String authentic = "Y";
		if(flag.equals("1") || flag.equals("5") || flag.equals("2") ||flag.equals("3") || flag.equals("11") || flag.equals("12") || flag.equals("13")){
			if(request.getParameter("onlineflag").equalsIgnoreCase("online") && request.getParameter("onlineflag")!=null){
					gsdate = new SimpleDateFormat("MM/dd/yyyy HH:MM:ss").format(cal.getTime());	
					authentic = "Y";
			}               
	        if(request.getParameter("onlineflag").equalsIgnoreCase("ofline") && request.getParameter("onlineflag")!=null){
					gsdate = request.getParameter("offlinedate");
					authentic = "N";
			}
		}
		if(flag!=null && (flag.equals("1") || flag.equals("11"))){ 
			try{
				vparam.add(InningId);
				vparam.add(id);
				vparam.add(authentic);
				vparam.add(note);
				vparam.add(gsdate);
				vparam.add(flag); // flag 1 for insert in interval
			    intervalCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_interval", vparam, "ScoreDB"); // Batsman List
		    	vparam.removeAllElements();
		    }catch (Exception e) {
 			   e.printStackTrace();
			}	
	   }else if(flag!=null && flag.equals("3")){
	   	   try{	
		   		vparam.add(InningId);
		   		vparam.add(totaltarget);
		   		vparam.add(over);
		   		vparam.add(gsdate);
		   		vparam.add(authentic);
		   		vparam.add(flag); // flag 1 for insert in interval
		   		intervalCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_settestmaxover", vparam, "ScoreDB"); // Batsman List
		    	vparam.removeAllElements();
		    }catch (Exception e) {
 			   e.printStackTrace();
 			}	
	   }else if(flag!=null && flag.equals("4")){
	   }else if(flag!=null && flag.equals("5")){
	   	  try{	
	   		vparam.add(InningId);
			vparam.add(id);
			vparam.add(gsdate);
			vparam.add(authentic);
			vparam.add(flag); // flag 4 for update penalty
			intervalCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_penalty", vparam, "ScoreDB"); // Batsman List
	    	vparam.removeAllElements();
		  }catch (Exception e) {
 			   e.printStackTrace();
 		  }		    	
	   }else{
	   	  try{
	   		vparam.add(InningId);
			vparam.add(id);
			vparam.add(authentic);
			vparam.add(note);
			vparam.add(gsdate);
			vparam.add(flag); // flag 2 for update  in interval
		    intervalCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_interval", vparam, "ScoreDB"); // Batsman List
	    	vparam.removeAllElements();
	      }catch (Exception e) {
 			   e.printStackTrace();
 		  }	
	   }
	   try{
		   vparam.add("1");
		   vparam.add(InningId);
		   displayintervalCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_interval", vparam, "ScoreDB"); // Batsman List
		   vparam.removeAllElements();	   	
	  }catch (Exception e) {
 		e.printStackTrace();
 	  }			
	
%>	
<%if(flag!=null && (flag.equals("1") ||flag.equals("4") || flag.equals("11") || flag.equals("12")||flag.equals("13"))){
%>
<html>
<head>
	<title> Interval </title>
	<script language="JavaScript" src="../js/datetimepicker.js" type="text/javascript"></script>
</head>		
	<body>
		<div class="out">
			<table width="100%" height="100%" border="5">
				<tr>
					<td>
						<div style="display: none" id ="adjustinterval" name="adjustinterval">
						<table width="100%" height="100%">
							<tr>
								<td><b>Interval Name : </b></td>
								<td><b>Start Time:</b></td>
								<td><b>End Time:</b></td>
							<tr>
<%							int i=0;
							while(displayintervalCachedRowSet.next()){
%>							<tr>
								<td><%=displayintervalCachedRowSet.getString("name")%></td>	
								<td><input type="hidden" name="hdintervalid<%=i%>" id="hdintervalid<%=i%>" value="<%=displayintervalCachedRowSet.getString("id")%>">
									<input type="hidden" id="hdstartdate<%=i%>"  name="hdstartdate<%=i%>" maxlength="25" size="20" value="<%=displayintervalCachedRowSet.getString("start_ts")%>" readonly >
								<input type="Text" id="txtstartdate<%=i%>"  name="txtstartdate<%=i%>" maxlength="25" size="20" value="<%=displayintervalCachedRowSet.getString("start_ts")%>" readonly ><a id="imganchor" name="imganchor" href="javascript:NewCal('txtstartdate<%=i%>','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a></td>
								<td><input type="Text" id="txtenddate<%=i%>"  name="txtenddate<%=i%>" maxlength="25" size="20" value="<%=displayintervalCachedRowSet.getString("end_ts")%>" readonly><a id="imganchor" name="imganchor" href="javascript:NewCal('txtenddate<%=i%>','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a></td>
								<td><input type="button" name="btnsave<%=i%>" id="btnsave<%=i%>" value="Save" onclick="callFun.adjusttime('<%=i%>')"></td>
							</tr>
<%							i=i+1;
							}
%>							
						</table>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<table align="center" width="100%" height="100%">
							<tr>
								<td align="center">Match will  resume after <%=intervalType%> </td>
							</tr>
						</table>	
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" >
						<input type="hidden" name="inningid" id="inningid" value="<%=InningId%>">
<%
	if(flag!=null && (flag.equals("11") || flag.equals("12")||flag.equals("13"))){
%>
		<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Start Game"  onclick="Interval('ajaxinterval','<%=id%>');closePopup('BackgroundDiv','PopupDiv')"></input>	
<%	}else{
%>		<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Start Game"  onclick="callFun.Interval('ajaxinterval','<%=id%>');closePopup('BackgroundDiv','PopupDiv')"></input>
		<input type="button" align="left" id="btnupdate" name="btnupdate" value="Update Previous Entry"  onclick="closePopup('BackgroundDiv','PopupDiv')"></input>
		<input type="button" align="left" id="btnadjust" name="btnadjust" value="Adjust Interval Time"  onclick="callFun.adjustinterval('adjustinterval')"></input>
<% }
%>						
                     </td>
					</tr>
			</table>		
		</div>
	</body>
<% }
	}catch(Exception e){
		e.printStackTrace();
	}	
%>
	
</html>		