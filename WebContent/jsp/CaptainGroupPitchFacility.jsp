<!--
Page Name 	 : CaptainGroupPitchFacility.jsp
Created By 	 : Archana Dongre.
Created Date : 28th Aug 2008
Description  : Captain report on group pitch and facility
Company 	 : Paramatrix Tech Pvt Ltd.
Modified on 15th sep Archana-Added code for the session continuation. 

Modification
	Date : 31/10/2008
	By	 : Saudagar Mulik
	Desc.: Modifications made for admin display.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="java.util.*"%>
<%@ page import="in.co.paramatrix.common.*"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
%>
<%
			String report_id = "6";
			String role = "1"; //For Captain / player			
			String match_id = session.getAttribute("matchid").toString();
			String loginUserId = session.getAttribute("usernamesurname").toString();
			String user_role = session.getAttribute("role").toString();
			String user_id = session.getAttribute("userid").toString();

			CachedRowSet MatchTeams = null;
			CachedRowSet crsObjTeamData = null;
			CachedRowSet crsObjViewDataUmp1 = null;
			CachedRowSet crsObjViewDataUmp2 = null;
			CachedRowSet crsObjUmpireList = null;
			CachedRowSet crsObjUmpire1data = null;
			CachedRowSet crsObjUmpire2data = null;
			CachedRowSet crsObjCaptains = null;

			ReplaceApostroph replaceApos = new ReplaceApostroph();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy-MMM-dd");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MMM-dd");
			java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat("dd/MM/yyyy");
			String result = null;
			String message = "";
			String gsUmpireName1 = null;
			String gsUmpire1Id = null;
			String gsUmpire2Id = null;
			String gsUmpireName2 = null;
			String gsAssociationName = null;
			String totalFlag = "false";
			//String gsumpireId1 = null;
			String captain_user_id = null;
			LogWriter log = new LogWriter();
			StringBuffer sbIds = new StringBuffer();
			GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(match_id);
			Vector vparam = new Vector();
			Vector ids = new Vector();

		try{
			vparam.add(match_id);
			vparam.add(user_id);
			try{
				crsObjTeamData = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_captainfeedback", vparam, "ScoreDB");
				vparam.removeAllElements();
			}catch (Exception e) {
				System.out.println("*************CaptainGroupPitchFacility.jsp*****************"+e);
					log.writeErrLog(page.getClass(),match_id,e.toString());
			}	

			if (user_role.equals("9")) {
				
				vparam.removeAllElements();
				vparam.add(match_id);
				vparam.add(role);
				
				try{
				crsObjCaptains = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_getMatchConcerns", vparam, "ScoreDB");
				vparam.removeAllElements();
				}catch (Exception e) {
					System.out.println("*************CaptainGroupPitchFacility.jsp*****************"+e);
						log.writeErrLog(page.getClass(),match_id,e.toString());
				}	
				if (request.getParameter("hid") != null) {
					captain_user_id = request.getParameter("hid");
				}
			} else {
				if (request.getMethod().equalsIgnoreCase("post")) {
					if (request.getParameter("hdid") != null
							&& request.getParameter("hdid").equalsIgnoreCase(
									"1")) {
						String[] retrieve_ids = request.getParameter(
								"hidden_ids").split(",");
						int retrieve_ids_length = retrieve_ids.length;

						String umpire1_id = request.getParameter("hdUmpireId1");
						String umpire2_id = request.getParameter("hdUmpireId2");
						System.out.println("Umpire 1 "+umpire1_id);
						System.out.println("Umpire 2 "+umpire2_id);
						if(umpire1_id.equals("0") && umpire1_id.equals("0")){%>
							<table width="880" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
							<tr>
								<td align="center" style="color: red;size: 5"><b>No Umpires are Assigned For This Match <br> Please Slect Other Match</b></td>
							</tr>
						</table>
						<%}else{							
							for (int count = 0; count < retrieve_ids_length; count = count + 2) {
								System.out.println("retrieve_ids[count] : "
										+ retrieve_ids[count]);
								String umpire1 = retrieve_ids[count];
								System.out.println(request.getParameter(umpire1)
										+ " : " + retrieve_ids[count + 1]);
								//For First Umpire
								vparam = new Vector();
								vparam.add(match_id);
								vparam.add(user_id);
								vparam.add(umpire1_id);
								vparam.add(retrieve_ids[count]);
	
								if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
									vparam.add(request.getParameter(umpire1));
									vparam.add(replaceApos.replacesingleqt((String)request.getParameter("rem_ump1"+ retrieve_ids[count])));
								} else if (retrieve_ids[count + 1]
										.equalsIgnoreCase("N")) {
									vparam.add("0");
									vparam.add(replaceApos.replacesingleqt((String)request.getParameter("rem_ump1"+ retrieve_ids[count])));
								}
								vparam.add(report_id);//Report Id of captain report
								try{
									crsObjUmpire1data = lobjGenerateProc
										.GenerateStoreProcedure(
												"esp_amd_userappraisal", vparam,
												"ScoreDB");									
								}catch (Exception e) {
									System.out.println("*************CaptainGroupPitchFacility.jsp*****************"+e);
										log.writeErrLog(page.getClass(),match_id,e.toString());
								}
								
								
								
	
								//For Second Umpire
								vparam = new Vector();
								vparam.add(match_id);
								vparam.add(user_id);
								vparam.add(umpire2_id);
								vparam.add(retrieve_ids[count]);
	
								if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
									vparam.add(request.getParameter("ump2" + retrieve_ids[count]));
									vparam.add(replaceApos.replacesingleqt((String)request.getParameter("rem_ump2"+ retrieve_ids[count])));									
								} else if (retrieve_ids[count + 1]
										.equalsIgnoreCase("N")) {
									vparam.add("0");
									vparam.add(replaceApos.replacesingleqt((String)request.getParameter("rem_ump2" + retrieve_ids[count])));
								}
								vparam.add(report_id);//Report Id of captain report
								
								try{
									crsObjUmpire2data = lobjGenerateProc
										.GenerateStoreProcedure(
												"esp_amd_userappraisal", vparam,
												"ScoreDB");									
								}catch (Exception e) {
									System.out.println("*************CaptainGroupPitchFacility.jsp*****************"+e);
										log.writeErrLog(page.getClass(),match_id,e.toString());
								}
							}					
							
						}
					}
				}
			}	
			vparam.removeAllElements();
			vparam.add(match_id);
			vparam.add(user_id); //change to captain's id
			try{
				crsObjUmpireList = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getmatchofficialid", vparam, "ScoreDB");
				vparam.removeAllElements();	
				}catch (Exception e) {
					System.out.println("*************CaptainGroupPitchFacility.jsp*****************"+e);
						log.writeErrLog(page.getClass(),match_id,e.toString());
				}
			if (crsObjUmpire1data != null) {
				if (crsObjUmpire1data.next()) {
					result = crsObjUmpire1data.getString("retval");					
					if(result.equalsIgnoreCase("Data saved successfully!")) {
						message = "Record Saved Successfully";
					}else {
						message = "Record Updated Successfully";
					}
				}
			}
%>
<html>
<head>
	<title>CAPTAIN REPORT ON GROUND PITCH AND FACILITIES</title>
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/trim.js"></script>
	<script language="javascript" src="../js/captainRefereeFeedback.js"></script>
</head>
<script>
	function getKeyCode(e){
	 if (window.event)
	        return window.event.keyCode;
	 else if (e)
	    return e.which;
	 else
	    return null;
	}
	
	function imposeMaxLength(Object, MaxLen,event,id,flag){
		
	  if(flag == 1){
		  if(Object.value.length > MaxLen){
			alert("Please enter maximum 500 characters only.")
			document.getElementById(id).focus()
			return false
		  }	else{
			return true
		  }			  
	  }
	  var keyvalue = getKeyCode(event);
	  if(keyvalue==8 || keyvalue==0 || keyvalue==1){
		return true;
	  }else{
		/*  if(Object.value.length > MaxLen){
				alert("falg 2 Please enter maximum 255 characters only.")
				document.getElementById(id).focus()
				return false
		 }else{*/	
		    return (Object.value.length < MaxLen);
		// }
	  }	
	}

	function callTooltip(anchorid,textareaid){
		document.getElementById(anchorid).title = document.getElementById(textareaid).innerHTML
	}	
</script>
<body onload="total()">
<div class="container">
<table align="center">
    <tr>
    	<td align="center">
    	
<jsp:include page="Menu.jsp"></jsp:include>
<br>
<FORM name="frmCaptainReport" id="frmCaptainReport" method="post"><br>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
	<tr>
		<td colspan="2" bgcolor="#FFFFFF" class="legend"> Captain's Report </td>
	</tr>
	<tr class="contentLight">				
		<td colspan="2" align="right"><%=loginUserId%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>DATE
		:</b> <%=sdf.format(new Date())%></td>
	</tr>
</table>
<table width="100%" border="0" align="center" class="table">
	<%
			if (crsObjTeamData != null) {
				while (crsObjTeamData.next()) {
					gsUmpire1Id = crsObjTeamData.getString("umpire1id");
					gsUmpireName1 = crsObjTeamData.getString("umpire1"); 
					gsUmpire2Id = crsObjTeamData.getString("umpire2id");
					gsUmpireName2 = crsObjTeamData.getString("umpire2");
%>
	<tr class="contentDark">
		<!--From System-->		
		<td width="20%" align="left">Match No :</td>
		<td align="left" width="50%"><%=match_id%></td>		
	</tr>
	<tr class="contentLight">
		<!--From System-->		
		<td width="20%">Captain's Name :</td>

		<%if (user_role.equals("9")) {%>

		<td width="50%"><SELECT id="captain" name="captain" onchange="DisplayReport()">
			<%String temp = "";
						boolean flag = true;
						while (crsObjCaptains.next()) {
							if (crsObjCaptains.getString("id").equals(
									captain_user_id)) {%>
			<option selected="selected"
				value="<%=crsObjCaptains.getString("id")%>"><%=crsObjCaptains
														.getString("name")%></option>
			<%				captain_user_id = crsObjCaptains
										.getString("id");
								temp = crsObjCaptains.getString("id");
							} else {%>
			<option value="<%=crsObjCaptains.getString("id")%>"><%=crsObjCaptains
														.getString("name")%></option>
			<%}

							if (flag) {
								temp = crsObjCaptains.getString("id");
								flag = false;
							}
						}
						captain_user_id = temp;
					%>
		</SELECT></td>

		<%} else {
						if (crsObjTeamData.getString("captain_name") != null){
							%>
		<td><%=crsObjTeamData.getString("captain_name")%></td>
		<%} else {%>
		<%}
	}%>
		
	</tr>
	<tr class="contentDark">
		<!--From System-->		
		<td width="20%">Match Between :</td>
		<td align="left" width="40%" ><%=crsObjTeamData.getString("team1")%>&nbsp;&nbsp;&nbsp;&nbsp; VS &nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjTeamData.getString("team2")%></td>		
	</tr>
	<tr class="contentLight">
		<!--From System-->		
		<td align="left" >Venue :</td>
		<%if (crsObjTeamData.getString("venue").equalsIgnoreCase("null")) {%>
		<td align="left">----</td>
		<%} else {%>
		<td align="left"><%=crsObjTeamData.getString("venue")%></td>
		<%}%>
	</tr>
	<tr class="contentDark">
		<!--From System-->		
		<td align="left">Name of Association :</td>
		<%if (crsObjTeamData.getString("club") == null || crsObjTeamData.getString("club").equals("")) {%>
		<td align="left">----</td>
		<%} else {%>
		<td align="left"><%=crsObjTeamData.getString("club")%></td>
		<%}%>
	</tr>
	<tr class="contentDark">
		<!--From System-->
		<td width="20%" align="left">Name Of the Referee :</td>
<%		if (crsObjTeamData.getString("referee") == null
			|| crsObjTeamData.getString("referee").equals("")) {
%>		<td>----</td>
<%		} else {
%>		<td align="left"><%=crsObjTeamData.getString("referee")%></td>
<%		}
%>
	</tr>
	<tr class="contentLight">
	  <td width="20%" align="left">Name Of Tournament :</td>
<%	  if (crsObjTeamData.getString("tournament") == null
		|| crsObjTeamData.getString("tournament").equals("")) {
%>	  <td>----</td>
<%
	} else {
%>    <td align="left"><%=crsObjTeamData.getString("tournament")%></td>
<%  }
%>
	</tr>
	<tr class="contentDark">
		<!--From System-->		
		<td align="left">Date :</td>
		<%if (crsObjTeamData.getString("startdate") == null || crsObjTeamData.getString("startdate").equals("")) {%>
		<td align="left">----</td>
		<%} else {
				String d1 = null;
				java.util.Date date = ddmmyyyy.parse(crsObjTeamData.getString("startdate"));
				d1 = sdf.format(date);           
        %>
	<td width="80%" ><%=d1 %></td>	
		<%}%>
	</tr>
</table>
<br>
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<tr class="contentLight">
		<td colspan="10" align="left" class="headinguser">NAME OF
		UMPIRES : </td>
	</tr>
	<tr class="contentDark">
		<!--From System-->
		<td>1)<%=crsObjTeamData.getString("umpire1")%> <input
			type="hidden" id="hdumpire1" name="hdumpire1"
			value="<%=crsObjTeamData.getString("umpire1")%>"></td>
		<td>2)<%=crsObjTeamData.getString("umpire2")%> <input
			type="hidden" id="hdumpire2" name="hdumpire2"
			value="<%=crsObjTeamData.getString("umpire2")%>"></td>
	</tr>
	<%}
			}%>
</table>
<br>
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<tr class="contentLight">
		<td colspan="3" align="left" class="headinguser">UMPIRING
		PERFORMANCE</td>
	</tr>
	<tr>
		<td class="message" align="center" colspan="4">
						<%=message%>
		</td>
	</tr>	
	<tr class="contentLight">
		<!--From System-->
		<td rowspan="3"  width="50%">Specify appropriate scale for Umpires performance : </td>
		<td align="left"><b></td>
		<td align="left"><b></b></td>
	</tr>
	<tr class="contentLight">
		<td align="left"><%=gsUmpireName1%></td>
		<td align="left"><%=gsUmpireName2%></td>
	</tr>
	<tr class="contentDark">
		<td align="left"><b>Scale </b></td>
		<td align="left"><b>Scale</b></td>
	</tr>
	<%if (user_role.equals("9")) {

				vparam = new Vector();
				vparam.add(match_id);
				vparam.add(captain_user_id); //change to userid	
				vparam.add(gsUmpire1Id);
				vparam.add(report_id);// report_id CAPTAIN REPORT ON GROUND PITCH AND FACILITIES Table:feedbackgroups_mst

				try{
				crsObjViewDataUmp1 = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_umpirereports", vparam, "ScoreDB");

				}catch (Exception e) {
					System.out.println("*************CaptainGroupPitchFacility.jsp*****************"+e);
						log.writeErrLog(page.getClass(),match_id,e.toString());
				}
				
				
				vparam = new Vector();
				vparam.add(match_id);
				vparam.add(captain_user_id); //change to userid	
				vparam.add(gsUmpire2Id);
				vparam.add(report_id);// report_id CAPTAIN REPORT ON GROUND PITCH AND FACILITIES Table:feedbackgroups_mst

				try{
				crsObjViewDataUmp2 = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_umpirereports", vparam, "ScoreDB");

				}catch (Exception e) {
					System.out.println("*************CaptainGroupPitchFacility.jsp*****************"+e);
						log.writeErrLog(page.getClass(),match_id,e.toString());
				}
				

				if (crsObjViewDataUmp1 != null && crsObjViewDataUmp2 != null) {
					int counter = 1;
					while (crsObjViewDataUmp1.next()
							&& crsObjViewDataUmp2.next()) {

						sbIds.append(crsObjViewDataUmp1.getString("id"));
						sbIds.append(",");
						sbIds.append(crsObjViewDataUmp1
								.getString("scoring_required"));
						sbIds.append(",");

						ids.add(crsObjViewDataUmp1.getString("id"));
						ids.add(crsObjViewDataUmp1
								.getString("scoring_required"));
						if (counter % 2 != 0) {%>
	<TR class="contentLight">
		<%} else {%>
	<tr class="contentDark">
		<%}%>
		<%if(crsObjViewDataUmp1.getString("scoring_required").equalsIgnoreCase("N")){
			
			if(totalFlag.equalsIgnoreCase("false")){
			totalFlag = "true";
			%>
		
		<tr class="contentLight">
		<!--From System-->
		<td></td>
		<td><b>Total Points:-</b></td>
		<td><b>Total Points:-</b></td>
	</tr>
	<tr class="contentDark">
		<td></td>
		<td align="left"><input type="text" id="txtUmpireTotalPt1"
			name="txtUmpireTotalPt1" value="0" size="20" disabled="disabled"></td>
		<td align="left"><input type="text" id="txtUmpireTotalPt2"
			name="txtUmpireTotalPt2" value="0" size="20" disabled="disabled"></td>
		<input type="hidden" id="hdUmpireId1" name="hdUmpireId1"
			value="<%=gsUmpire1Id%>" size="20">
		<input type="hidden" id="hdUmpireId2" name="hdUmpireId2"
			value="<%=gsUmpire2Id%>" size="20">
	</tr>   	
			<%
			}	
			}%>
			</tr>
			<tr class=" contentDark">
		<TD id="que_<%=crsObjViewDataUmp1.getString("id")%>" name="<%=counter++%>" >.&nbsp;<%=crsObjViewDataUmp1.getString("description")%></TD>
		<%if(crsObjViewDataUmp1.getString("scoring_required")
								.equalsIgnoreCase("Y")) {
							%>
		<%String[] strArr = crsObjViewDataUmp1.getString(
									"cnames").toString().split(",");
							int length = Integer.parseInt(crsObjViewDataUmp1.getString("score_max").toString());%>
		<%int selectedVal1 = Integer.parseInt(crsObjViewDataUmp1.getString("selected")) - 1;%>
		<TD>
		<%for (int count = length - 1; count >= 0; count--) {
				if (strArr.length > count) {
					if (selectedVal1 == count) {%>
			 <LABEL><%=strArr[count]%></LABEL>
		<INPUT type="hidden" id="<%=crsObjViewDataUmp2.getString("id")%>" value="<%=count+1%>">
		 <%} else {%>
		<INPUT type="hidden" id='<%=crsObjViewDataUmp2.getString("id")%>' value="0">
		 <%}
		}
	}%></TD>
		<%int selectedVal2 = Integer.parseInt(crsObjViewDataUmp2.getString("selected")) - 1;%>
		<TD><%for (int count = length - 1; count >= 0; count--) {
				if (strArr.length > count) {
					if (selectedVal2 == count) {%>
		<LABEL><%=strArr[count]%></LABEL>
		<INPUT type="hidden" id="ump2<%=crsObjViewDataUmp2.getString("id")%>" value="<%=count+1%>">
		 <%} else {%>
		  <INPUT type="hidden" id='ump2<%=crsObjViewDataUmp2.getString("id")%>' value="0"> 
		 <%}
		}
	}%></TD>
		<%} else {%>

		<TD><%if (crsObjViewDataUmp1.getString("remark") != null) {%> <TEXTAREA
			disabled="disabled" type="text" class="textArea" maxlength="500"><%=crsObjViewDataUmp1
												.getString("remark").trim()%></TEXTAREA> <%} else {%> <TEXTAREA
			disabled="disabled" type="text" class="textArea" maxlength="500"></TEXTAREA>
		<%}%></TD>
		<TD><%if (crsObjViewDataUmp2.getString("remark") != null) {%> <TEXTAREA
			disabled="disabled" type="text" class="textArea" maxlength="500"><%=crsObjViewDataUmp2
												.getString("remark").trim()%></TEXTAREA> <%} else {%> <TEXTAREA
			disabled="disabled" type="text" class="textArea" maxlength="500"></TEXTAREA>
		<%}%></TD>

		<%}
					}
				}
				///////////*************************////////////////////////////////////
			} else {
				vparam = new Vector();
				vparam.add(match_id);
				vparam.add(user_id); //change to userid	
				vparam.add(gsUmpire1Id);
				vparam.add(report_id);// report_id CAPTAIN REPORT ON GROUND PITCH AND FACILITIES Table:feedbackgroups_mst

				try{
				crsObjViewDataUmp1 = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_umpirereports", vparam, "ScoreDB");

				}catch (Exception e) {
					System.out.println("*************CaptainGroupPitchFacility.jsp*****************"+e);
						log.writeErrLog(page.getClass(),match_id,e.toString());
				}
				
				

				vparam = new Vector();
				vparam.add(match_id);
				vparam.add(user_id); //change to userid	
				vparam.add(gsUmpire2Id);
				vparam.add(report_id);// report_id CAPTAIN REPORT ON GROUND PITCH AND FACILITIES Table:feedbackgroups_mst

				try{
				crsObjViewDataUmp2 = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_umpirereports", vparam, "ScoreDB");

				}catch (Exception e) {
					System.out.println("*************CaptainGroupPitchFacility.jsp*****************"+e);
						log.writeErrLog(page.getClass(),match_id,e.toString());
				}
				if (crsObjViewDataUmp1 != null && crsObjViewDataUmp2 != null) {
					int counter = 1;
					while (crsObjViewDataUmp1.next()
							&& crsObjViewDataUmp2.next()) {

						sbIds.append(crsObjViewDataUmp1.getString("id"));
						sbIds.append(",");
						sbIds.append(crsObjViewDataUmp1
								.getString("scoring_required"));
						sbIds.append(",");

						ids.add(crsObjViewDataUmp1.getString("id"));
						ids.add(crsObjViewDataUmp1
								.getString("scoring_required"));
						if (counter % 2 != 0) {
						%>
	<TR class="contentLight">
		<%} else {
						%>
	<tr class="contentDark">
		<%}		
%>
	<%if(crsObjViewDataUmp1.getString("scoring_required").equalsIgnoreCase("N")){
			
			if(totalFlag.equalsIgnoreCase("false")){
			totalFlag = "true";
			%>
		
		<tr class="contentLight">
		<!--From System-->
		<td></td>
		<td><b>Total Points:-</b></td>
		<td><b>Total Points:-</b></td>
	</tr>
	<tr class="contentDark">
		<td></td>
		<td align="left"><input type="text" id="txtUmpireTotalPt1"
			name="txtUmpireTotalPt1" value="0" size="20" disabled="disabled"></td>
		<td align="left"><input type="text" id="txtUmpireTotalPt2"
			name="txtUmpireTotalPt2" value="0" size="20" disabled="disabled"></td>
		<input type="hidden" id="hdUmpireId1" name="hdUmpireId1"
			value="<%=gsUmpire1Id%>" size="20">
		<input type="hidden" id="hdUmpireId2" name="hdUmpireId2"
			value="<%=gsUmpire2Id%>" size="20">
	</tr>   	
			<%
			}	
			}%>
			</tr>
			<tr class=" contentDark">
		<TD width="40%" id="que_<%=crsObjViewDataUmp1.getString("id")%>"><%=crsObjViewDataUmp1.getString("description")%></TD>
		<%if (crsObjViewDataUmp1.getString("scoring_required")
								.equalsIgnoreCase("Y")) {
							%>
		<%String[] strArr = crsObjViewDataUmp1.getString(
									"cnames").toString().split(",");
							int length = Integer.parseInt(crsObjViewDataUmp1
									.getString("score_max").toString());%>
		<%int selectedVal1 = Integer
									.parseInt(crsObjViewDataUmp1
											.getString("selected")) - 1;%>		
		<TD><SELECT id="<%=crsObjViewDataUmp1.getString("id")%>"
			name="<%=crsObjViewDataUmp1.getString("id")%>" onchange="total()">
			<OPTION value="0">- Select -</OPTION>
			<%for (int count = length - 1; count >= 0; count--) {%>

			<%if (strArr.length > count) {
									if (selectedVal1 == count) {%>
			<OPTION value="<%=(count+1)%>" selected="selected"><%=strArr[count]%></option>
			<%} else {%>
			<OPTION value="<%=(count+1)%>"><%=strArr[count]%></option>
			<%}
								} else if (strArr.length <= count) {
									if (selectedVal1 == count) {%>
			<OPTION value="<%=count+1%>" selected="selected"><%=count + 1%></option>
			<%} else {%>
			<OPTION value="<%=count+1%>"><%=count + 1%></option>
			<%}
								}
							}%>

		</SELECT>
		<a id="remAnch_ump1<%=crsObjViewDataUmp1.getString("id")%>"	name="remAnch_ump1<%=crsObjViewDataUmp1.getString("id")%>" href="javascript:void('')"
			 onmouseover="callTooltip('remAnch_ump1<%=crsObjViewDataUmp1.getString("id")%>','rem_ump1<%=crsObjViewDataUmp1.getString("id")%>')" onclick="enterCaptainUmp1Remark('<%=crsObjViewDataUmp1.getString("id")%>')">Remark</a> 
	<%if (crsObjViewDataUmp1.getString("remark").trim().equalsIgnoreCase("")) { %>
			<div id="remDiv_ump1<%=crsObjViewDataUmp1.getString("id")%>" name="remDiv_ump1<%=crsObjViewDataUmp1.getString("id")%>" style="display:none">
		<textarea class="textArea" id="rem_ump1<%=crsObjViewDataUmp1.getString("id")%>"	name="rem_ump1<%=crsObjViewDataUmp1.getString("id")%>" rows="4" cols="20"
			maxlength="500"	onblur="imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1.getString("id")%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1.getString("id")%>','2')"><%=crsObjViewDataUmp1.getString("remark").trim()%></textarea>
		</div>
		<%
						} else {
							%>
		<div id="remDiv_ump1<%=crsObjViewDataUmp1.getString("id")%>"
			name="remDiv_ump1<%=crsObjViewDataUmp1.getString("id")%>"><textarea
			class="textArea" id="rem_ump1<%=crsObjViewDataUmp1.getString("id")%>"
			name="rem_ump1<%=crsObjViewDataUmp1.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1.getString("id")%>','2')"><%=crsObjViewDataUmp1.getString("remark").trim()%></textarea>
		</div>
		<%}%>	
			
		
		</TD>
		<%int selectedVal2 = Integer
									.parseInt(crsObjViewDataUmp2
											.getString("selected")) - 1;%>
		<TD><SELECT id="ump2<%=crsObjViewDataUmp2.getString("id")%>"
			name="ump2<%=crsObjViewDataUmp2.getString("id")%>" onchange="total()">
			<OPTION value="0">- Select -</OPTION>
			<%for (int count = length - 1; count >= 0; count--) {%>
			<%if (strArr.length > count) {
									if (selectedVal2 == count) {%>
			<OPTION value="<%=(count+1)%>" selected="selected"><%=strArr[count]%></option>
			<%} else {%>
			<OPTION value="<%=(count+1)%>"><%=strArr[count]%></option>
			<%}
								} else if (strArr.length <= count) {
									if (selectedVal1 == count) {%>
			<OPTION value="<%=count+1%>" selected="selected"><%=count + 1%></option>
			<%} else {%>
			<OPTION value="<%=count+1%>"><%=count + 1%></option>
			<%}
								}

							}%>
		</SELECT>
		<a id="remAnch_ump2<%=crsObjViewDataUmp2.getString("id")%>"	name="remAnch_ump2<%=crsObjViewDataUmp2.getString("id")%>" href="javascript:void('')"
			onmouseover="callTooltip('remAnch_ump2<%=crsObjViewDataUmp2.getString("id")%>','rem_ump2<%=crsObjViewDataUmp2.getString("id")%>')"  onclick="enterCaptainUmp2Remark('<%=crsObjViewDataUmp2.getString("id")%>')">Remark</a> 
	<%if (crsObjViewDataUmp2.getString("remark").trim().equalsIgnoreCase("")) { %>
			<div id="remDiv_ump2<%=crsObjViewDataUmp2.getString("id")%>" name="remDiv_ump2<%=crsObjViewDataUmp2.getString("id")%>" style="display:none">
		<textarea class="textArea" id="rem_ump2<%=crsObjViewDataUmp2.getString("id")%>"	name="rem_ump2<%=crsObjViewDataUmp2.getString("id")%>" rows="4" cols="20"
			maxlength="500"	onblur="imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2.getString("id")%>','1')" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2.getString("id")%>','2')"><%=crsObjViewDataUmp2.getString("remark").trim()%></textarea>
		</div>
		<%
						} else {
							%>
		<div id="remDiv_ump2<%=crsObjViewDataUmp2.getString("id")%>"
			name="remDiv_ump2<%=crsObjViewDataUmp2.getString("id")%>"><textarea
			class="textArea" id="rem_ump2<%=crsObjViewDataUmp2.getString("id")%>"
			name="rem_ump2<%=crsObjViewDataUmp2.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2.getString("id")%>','2')"><%=crsObjViewDataUmp2.getString("remark").trim()%></textarea>
		</div>
		<%}%>		
		</TD>
		<%} else { %>
			
			<td>
			<a id="Ump1remAnch_<%=crsObjViewDataUmp1.getString("id")%>"
				name="Ump1remAnch_<%=crsObjViewDataUmp1.getString("id")%>"
				href="javascript:void('')"
				onmouseover="callTooltip('Ump1remAnch_<%=crsObjViewDataUmp1.getString("id")%>','rem_ump1<%=crsObjViewDataUmp1.getString("id")%>')"
				onclick="enterCaptainUmp1Remark('<%=crsObjViewDataUmp1.getString("id")%>')">Remark</a>	<%		
					if (crsObjViewDataUmp1.getString("remark").trim()
								.equalsIgnoreCase("")) {
%>
		<div id="remDiv_ump1<%=crsObjViewDataUmp1.getString("id")%>"
			name="remDiv_ump1<%=crsObjViewDataUmp1.getString("id")%>" style="display:none"><textarea
			class="textArea" id="rem_ump1<%=crsObjViewDataUmp1.getString("id")%>"
			name="rem_ump1<%=crsObjViewDataUmp1.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1.getString("id")%>','2')"><%=crsObjViewDataUmp1.getString("remark").trim()%></textarea>
		</div>
		<%
						} else {
							%>
		<div id="remDiv_ump1<%=crsObjViewDataUmp1.getString("id")%>"
			name="remDiv_ump1<%=crsObjViewDataUmp1.getString("id")%>"><textarea
			class="textArea" id="rem_ump1<%=crsObjViewDataUmp1.getString("id")%>"
			name="rem_ump1<%=crsObjViewDataUmp1.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1.getString("id")%>','2')"><%=crsObjViewDataUmp1.getString("remark").trim()%></textarea>
		</div>
		<%}	%>
			</td>			
			<td>
			<a id="Ump2remAnch_<%=crsObjViewDataUmp2.getString("id")%>"
				name="Ump2remAnch_<%=crsObjViewDataUmp2.getString("id")%>"
				href="javascript:void('')"
				onmouseover="callTooltip('Ump2remAnch_<%=crsObjViewDataUmp2.getString("id")%>','rem_ump2<%=crsObjViewDataUmp2.getString("id")%>')"
				onclick="enterCaptainUmp2Remark('<%=crsObjViewDataUmp2.getString("id")%>')">Remark</a>	<%		
					if (crsObjViewDataUmp2.getString("remark").trim()
								.equalsIgnoreCase("")) {
%>
		<div id="remDiv_ump2<%=crsObjViewDataUmp2.getString("id")%>"
			name="remDiv_ump2<%=crsObjViewDataUmp2.getString("id")%>" style="display:none"><textarea
			class="textArea" id="rem_ump2<%=crsObjViewDataUmp2.getString("id")%>"
			name="rem_ump2<%=crsObjViewDataUmp2.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2.getString("id")%>','2')"><%=crsObjViewDataUmp2.getString("remark").trim()%></textarea>
		</div>
		<%
						} else {
							%>
		<div id="remDiv_ump2<%=crsObjViewDataUmp2.getString("id")%>"
			name="remDiv_ump2<%=crsObjViewDataUmp2.getString("id")%>"><textarea
			class="textArea" id="rem_ump2<%=crsObjViewDataUmp2.getString("id")%>"
			name="rem_ump2<%=crsObjViewDataUmp2.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2.getString("id")%>','2')"><%=crsObjViewDataUmp2.getString("remark").trim()%></textarea>
		</div>
		<%}	%>
			</td>		
			<%}%>
		<%}
				}
			}%>
<%--	<tr class="contentLight">--%>
<%--		<!--From System-->--%>
<%--		<td></td>--%>
<%--		<td><b>Total Points:-</b></td>--%>
<%--		<td><b>Total Points:-</b></td>--%>
<%--	</tr>--%>
<%--	<tr class="contentDark">--%>
<%--		<td></td>--%>
<%--		<td align="left"><input type="text" id="txtUmpireTotalPt1"--%>
<%--			name="txtUmpireTotalPt1" value="0" size="20" disabled="disabled"></td>--%>
<%--		<td align="left"><input type="text" id="txtUmpireTotalPt2"--%>
<%--			name="txtUmpireTotalPt2" value="0" size="20" disabled="disabled"></td>--%>
<%--		<input type="hidden" id="hdUmpireId1" name="hdUmpireId1"--%>
<%--			value="<%=gsUmpire1Id%>" size="20">--%>
<%--		<input type="hidden" id="hdUmpireId2" name="hdUmpireId2"--%>
<%--			value="<%=gsUmpire2Id%>" size="20">--%>
<%--	</tr>--%>
</table>
NOTE : Please enter maximum 500 characters for remark.
<br>
<br>


<%if (!user_role.equals("9")) {%>
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<tr>
		<td align="center"><input class="btn btn-warning" type="button" align="center"
			class="contentDark" id="btnSubmit" name="btnSubmit" value="Submit"
			onclick="assign()"></td>
	</tr>
</table>
<%}%> <INPUT type="hidden" id="hdid" name="hdid" /> <input
	type="hidden" id="hidden_ids" name="hidden_ids" value="<%=sbIds%>" />
<INPUT type="hidden" id="hid" name="hid" />
	
	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td>
				<jsp:include page="admin/Footer.jsp"></jsp:include>
			</td>
		</tr>
	</table>
</form>


</td>
</tr>
</table>
</div>
</body>
</html>
<%
		} catch (Exception e) {
			System.out.println("*************CaptainGroupPitchFacility.jsp*****************"+e);
				log.writeErrLog(page.getClass(),match_id,e.toString());
		}
%>
