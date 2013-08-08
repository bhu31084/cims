<!--
	Page Name 	 : RefereeReportOnUmpires.jsp
	Created By 	 : Archana Dongre.
	Created Date : 8th oct 2008
	Description  : Referee report on Umpires
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page
	import="sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="in.co.paramatrix.common.*"%>
<%--<%@ include file="AuthZ.jsp" %>--%>
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
	String role = "4";
	String FLAG = "2";
	String match_id = "";
	String user_id = "";
	String loginUserId = "";
	String user_role = "";
	String gsflag = request.getParameter("flag") != null ? request
			.getParameter("flag") : "0";
	String tabhdId = request.getParameter("hdid")!=null ? request.getParameter("hdid") : "0" ;		
	if (gsflag.equalsIgnoreCase("1")) {
		match_id = request.getParameter("match");
		user_id = request.getParameter("refree_id");
		loginUserId = request.getParameter("refree");
		user_role = "9";
	} else {
		match_id = session.getAttribute("matchid").toString();
		user_id = session.getAttribute("userid").toString();
		loginUserId = session.getAttribute("usernamesurname")
				.toString();
		user_role = session.getAttribute("role").toString();
	}
	String refereeReportId = "8";//report id of referee report
	String flag = "1";
	String result = null;
	String message = "";

	ReplaceApostroph replaceApos = new ReplaceApostroph();
	LogWriter log = new LogWriter();
	CachedRowSet MatchTeams = null;

	CachedRowSet crsObjViewDataUmp1 = null;
	CachedRowSet crsObjViewDataUmp2 = null;
	CachedRowSet crsObjRefereeFields = null;
	CachedRowSet crsObjRefereeDetail = null;
	CachedRowSet crsObjmatchreport = null;
	CachedRowSet crsObjCaptains = null;
	CachedRowSet crsObjplayerDetail = null;
	CachedRowSet crsObjBreachesList = null;
	CachedRowSet crsObjGroundEquCrs = null;
	CachedRowSet crsObjOffencesDetail = null;
	CachedRowSet crsObjSaveRefereeData = null;
	CachedRowSet crsObjSaveUmpData = null;
	CachedRowSet crsObjGrEquipData = null;
	String totalFlag = "false";

	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
			"yyyy-MMM-dd");
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
			"yyyy-MMM-dd");
	java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat(
			"dd/MM/yyyy");
	int counter = 1;
	String gsUmpireName1 = null;
	String gsUmpire1Id = null;
	String gsrefid = null;
	String gsrefname = null;
	String gsUmpire2Id = null;
	String gsUmpireName2 = null;
	String gsAssociationName = null;
	String referee_user_id = null;
	StringBuffer sbIds = new StringBuffer();
	StringBuffer sbrefereeIds = new StringBuffer();//For referee fields
	StringBuffer sbgrEquipIds = new StringBuffer();

	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(
			match_id);
	Vector vparam = new Vector();
	Vector ids = new Vector();
	Vector refereeids = new Vector();//For referee fields
	Vector groundids = new Vector();

	//To display the userrole id's of players
	try {
		vparam.add(match_id);
		crsObjplayerDetail = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_userroleid_for_breaches", vparam, "ScoreDB");
		vparam.removeAllElements();
	} catch (Exception e) {
		System.out
				.println("*************RefereeReportOnUmpires.jsp*****************"
						+ e);
		log.writeErrLog(page.getClass(), match_id, e.toString());
	}
	//To dispaly the player records
	try {
		vparam.add(match_id);//Match id
		vparam.add("");//UserRole id
		vparam.add(FLAG);//Flag for display 2.
		crsObjOffencesDetail = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_referee_breachs_fb", vparam, "ScoreDB");
		vparam.removeAllElements();
	} catch (Exception e) {
		System.out
				.println("*************RefereeReportOnUmpires.jsp*****************"
						+ e);
		log.writeErrLog(page.getClass(), match_id, e.toString());
	}
	vparam.add(match_id);
	vparam.add(role);
	crsObjCaptains = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_getMatchConcerns", vparam, "ScoreDB");
	vparam.removeAllElements();
	if (crsObjCaptains.size() == 0) {
%>
<table width="880" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<tr>
		<td align="center" style="color: red; size: 5"><b>No Referee
		Assigned For This Match</b></td>
	</tr>
</table>
<%
	} else {
		//To dispaly of details of the MATCH
		try {
			vparam.add(match_id);
			crsObjRefereeDetail = lobjGenerateProc
					.GenerateStoreProcedure(
							"esp_dsp_referee_feedbackdtls", vparam,
							"ScoreDB");
			vparam.removeAllElements();
		} catch (Exception e) {
			System.out
					.println("*************RefereeReportOnUmpires.jsp*****************"
							+ e);
			log.writeErrLog(page.getClass(), match_id, e.toString());
		}

		//To display of REPORT ON THE MATCH
		try {
			vparam.add(match_id);
			crsObjmatchreport = lobjGenerateProc
					.GenerateStoreProcedure(
							"esp_dsp_referee_match_report", vparam,
							"ScoreDB");
			vparam.removeAllElements();
		} catch (Exception e) {
			System.out
					.println("*************RefereeReportOnUmpires.jsp*****************"
							+ e);
			log.writeErrLog(page.getClass(), match_id, e.toString());
		}
%>
<%
	if (user_role.equals("9")) {
			vparam.add(match_id);
			vparam.add(role);
			try {
				crsObjCaptains = lobjGenerateProc
						.GenerateStoreProcedure(
								"esp_dsp_getMatchConcerns", vparam,
								"ScoreDB");
				vparam.removeAllElements();
			} catch (Exception e) {
				System.out
						.println("*************RefereeReportOnUmpires.jsp*****************"
								+ e);
				log
						.writeErrLog(page.getClass(), match_id, e
								.toString());
			}

			if (crsObjCaptains != null) {
				while (crsObjCaptains.next()) {
					gsrefname = crsObjCaptains.getString("name");
					gsrefid = crsObjCaptains.getString("id");
				}
			}
			if (request.getParameter("hid") != null) {
				referee_user_id = request.getParameter("hid");
			}
		} else {
			if (request.getMethod().equalsIgnoreCase("post")) {
				if (request.getParameter("hdid") != null
						&& request.getParameter("hdid")
								.equalsIgnoreCase("1")) {
					//if(request.getParameter("hdUmpireId1") != null && request.getParameter("hdUmpireId2") != null){
					String[] retrieve_ids = request.getParameter(
							"hidden_ids").split(",");
					int retrieve_ids_length = retrieve_ids.length;
					String umpire1_id = request
							.getParameter("hdUmpireId1");
					String umpire2_id = request
							.getParameter("hdUmpireId2");
					for (int count = 0; count < retrieve_ids_length; count = count + 2) {
						String umpire1 = retrieve_ids[count];

						//For First Umpire
						vparam = new Vector();
						vparam.add(match_id);
						vparam.add(user_id);
						vparam.add(umpire1_id);
						vparam.add(retrieve_ids[count]);

						if (retrieve_ids[count + 1]
								.equalsIgnoreCase("Y")) {
							vparam.add(request.getParameter(umpire1));
							vparam
									.add(replaceApos
											.replacesingleqt((String) request
													.getParameter("rem_ump1"
															+ retrieve_ids[count])));
						} else if (retrieve_ids[count + 1]
								.equalsIgnoreCase("N")) {
							vparam.add("0");
							vparam
									.add(replaceApos
											.replacesingleqt((String) request
													.getParameter("rem_ump1"
															+ retrieve_ids[count])));
						}
						vparam.add(refereeReportId);//Report Id of captain report

						try {
							lobjGenerateProc.GenerateStoreProcedure(
									"esp_amd_userappraisal", vparam,
									"ScoreDB");
						} catch (Exception e) {
							System.out
									.println("*************RefereeReportOnUmpires.jsp*****************"
											+ e);
							log.writeErrLog(page.getClass(), match_id,
									e.toString());
						}

						//For Second Umpire
						vparam = new Vector();
						vparam.add(match_id);
						vparam.add(user_id);
						vparam.add(umpire2_id);
						vparam.add(retrieve_ids[count]);

						if (retrieve_ids[count + 1]
								.equalsIgnoreCase("Y")) {
							vparam.add(request.getParameter("ump2"
									+ retrieve_ids[count]));
							vparam
									.add(replaceApos
											.replacesingleqt((String) request
													.getParameter("rem_ump2"
															+ retrieve_ids[count])));
						} else if (retrieve_ids[count + 1]
								.equalsIgnoreCase("N")) {
							vparam.add("0");
							vparam
									.add(replaceApos
											.replacesingleqt((String) request
													.getParameter("rem_ump2"
															+ retrieve_ids[count])));
						}
						vparam.add(refereeReportId);//Report Id of captain report

						try {
							lobjGenerateProc.GenerateStoreProcedure(
									"esp_amd_userappraisal", vparam,
									"ScoreDB");
						} catch (Exception e) {
							System.out
									.println("*************RefereeReportOnUmpires.jsp*****************"
											+ e);
							log.writeErrLog(page.getClass(), match_id,
									e.toString());
						}
					}
					vparam.removeAllElements();

					//For the ground equipments.
					String[] retrieve_groundids = request.getParameter(
							"hiddengr_ids").split(",");
					int retrieve_groundids_length = retrieve_groundids.length;
					for (int grcount = 0; grcount < retrieve_groundids_length; grcount = grcount + 2) {
						vparam.removeAllElements();
						vparam = new Vector();
						vparam.add(match_id);
						vparam.add(user_id);
						vparam.add(retrieve_groundids[grcount]);
						if (retrieve_groundids[grcount + 1]
								.equalsIgnoreCase("Y")) {
							vparam.add(request.getParameter("groundId"
									+ retrieve_groundids[grcount]));
							//vparam.add(replaceApos.replacesingleqt((String)request.getParameter("ground_"+ retrieve_groundids[grcount])));
							vparam.add(request.getParameter("ground_"
									+ retrieve_groundids[grcount]));
						} else if (retrieve_groundids[grcount + 1]
								.equalsIgnoreCase("N")) {
							vparam.add("0");
							vparam.add(request.getParameter("ground_"
									+ retrieve_groundids[grcount]));
						}
						vparam.add("");//admin remark
						vparam.add(refereeReportId);//Report Id of captain report

						try {
							lobjGenerateProc.GenerateStoreProcedure(
									"esp_amd_pitchoutfield", vparam,
									"ScoreDB");
							vparam.removeAllElements();
						} catch (Exception e) {
							System.out
									.println("*************RefereeReportOnUmpires.jsp*****************"
											+ e);
							log.writeErrLog(page.getClass(), match_id,
									e.toString());
						}
					}//End of the ground equipments.

					//For referee part submit
					String[] refretrieve_ids = request.getParameter(
							"hidden_RefereeId").split(",");
					int refretrieve_ids_length = refretrieve_ids.length;
					for (int refcount = 0; refcount < refretrieve_ids_length; refcount = refcount + 2) {

						vparam = new Vector();
						vparam.add(match_id);
						vparam.add(user_id);
						vparam.add(refretrieve_ids[refcount]);
						if (refretrieve_ids[refcount + 1]
								.equalsIgnoreCase("N")) {
							vparam.add("0");
							vparam.add(request.getParameter("rem_"
									+ refretrieve_ids[refcount]));
						} else if (refretrieve_ids[refcount + 1]
								.equalsIgnoreCase("Y")) {
							vparam.add(request.getParameter("refereeId"
									+ refretrieve_ids[refcount]));
							vparam.add(request.getParameter("rem_"
									+ refretrieve_ids[refcount]));
						}
						vparam.add(refereeReportId);//Report Id of captain report

						try {
							crsObjSaveRefereeData = lobjGenerateProc
									.GenerateStoreProcedure(
											"esp_amd_matchrefereefeedback",
											vparam, "ScoreDB");
						} catch (Exception e) {
							System.out
									.println("*************RefereeReportOnUmpires.jsp*****************"
											+ e);
							log.writeErrLog(page.getClass(), match_id,
									e.toString());
						}
					}
					vparam.removeAllElements();
					//End of the referee part submit
					if (crsObjSaveRefereeData != null) {
						if (crsObjSaveRefereeData.next()) {
							//result = crsObjSaveRefereeData.getString("retval");
							if (crsObjSaveRefereeData.getString(
									"retval").equalsIgnoreCase("SAVED")) {
								message = "Record Saved Successfully";
							} else {
								message = "Record Updated Successfully";
							}
						}
					}
				}
			}
			if (request.getParameter("hdid") != null
					&& request.getParameter("hdid").equalsIgnoreCase(
							"2")) {
				String[] retrieve_ids = request.getParameter(
						"hidden_ids").split(",");
				int retrieve_ids_length = retrieve_ids.length;
				String umpire1_id = request.getParameter("hdUmpireId1");
				String umpire2_id = request.getParameter("hdUmpireId2");
				for (int count = 0; count < retrieve_ids_length; count = count + 2) {
					String umpire1 = retrieve_ids[count];

					//For First Umpire
					vparam = new Vector();
					vparam.add(match_id);
					vparam.add(user_id);
					vparam.add(umpire1_id);
					vparam.add(retrieve_ids[count]);

					if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
						vparam.add(request.getParameter(umpire1));
						vparam
								.add(replaceApos
										.replacesingleqt((String) request
												.getParameter("rem_ump1"
														+ retrieve_ids[count])));
					} else if (retrieve_ids[count + 1]
							.equalsIgnoreCase("N")) {
						vparam.add("0");
						vparam
								.add(replaceApos
										.replacesingleqt((String) request
												.getParameter("rem_ump1"
														+ retrieve_ids[count])));
					}
					vparam.add(refereeReportId);//Report Id of captain report

					try {
						lobjGenerateProc.GenerateStoreProcedure(
								"esp_amd_userappraisal", vparam,
								"ScoreDB");
					} catch (Exception e) {
						System.out
								.println("*************RefereeReportOnUmpires.jsp*****************"
										+ e);
						log.writeErrLog(page.getClass(), match_id, e
								.toString());
					}

					//For Second Umpire
					vparam = new Vector();
					vparam.add(match_id);
					vparam.add(user_id);
					vparam.add(umpire2_id);
					vparam.add(retrieve_ids[count]);

					if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
						vparam.add(request.getParameter("ump2"
								+ retrieve_ids[count]));
						vparam
								.add(replaceApos
										.replacesingleqt((String) request
												.getParameter("rem_ump2"
														+ retrieve_ids[count])));
					} else if (retrieve_ids[count + 1]
							.equalsIgnoreCase("N")) {
						vparam.add("0");
						vparam
								.add(replaceApos
										.replacesingleqt((String) request
												.getParameter("rem_ump2"
														+ retrieve_ids[count])));
					}
					vparam.add(refereeReportId);//Report Id of captain report

					try {
						crsObjSaveUmpData = lobjGenerateProc
								.GenerateStoreProcedure(
										"esp_amd_userappraisal",
										vparam, "ScoreDB");
					} catch (Exception e) {
						System.out
								.println("*************RefereeReportOnUmpires.jsp*****************"
										+ e);
						log.writeErrLog(page.getClass(), match_id, e
								.toString());
					}
				}
				vparam.removeAllElements();
				if (crsObjSaveUmpData != null) {
					if (crsObjSaveUmpData.next()) {
						//result = crsObjSaveRefereeData.getString("retval");
						if (crsObjSaveUmpData.getString("retval")
								.equalsIgnoreCase(
										"Data updated successfully!")) {
							message = "Updated Umpire Details Successfully";
						} else {
							message = "Saved Umpire Details Successfully";
						}
					}
				}

			}
			if (request.getParameter("hdid") != null
					&& request.getParameter("hdid").equalsIgnoreCase(
							"3")) {
				//For the ground equipments.
				String[] retrieve_groundids = request.getParameter(
						"hiddengr_ids").split(",");
				int retrieve_groundids_length = retrieve_groundids.length;
				for (int grcount = 0; grcount < retrieve_groundids_length; grcount = grcount + 2) {
					vparam.removeAllElements();
					vparam = new Vector();
					vparam.add(match_id);
					vparam.add(user_id);
					vparam.add(retrieve_groundids[grcount]);
					if (retrieve_groundids[grcount + 1]
							.equalsIgnoreCase("Y")) {
						vparam.add(request.getParameter("groundId"
								+ retrieve_groundids[grcount]));
						vparam
								.add(replaceApos
										.replacesingleqt((String) request
												.getParameter("ground_"
														+ retrieve_groundids[grcount])));

					} else if (retrieve_groundids[grcount + 1]
							.equalsIgnoreCase("N")) {
						vparam.add("0");
						vparam.add(request.getParameter("ground_"
								+ retrieve_groundids[grcount]));
					}
					vparam.add("");//admin remark
					vparam.add(refereeReportId);//Report Id of captain report

					try {
						crsObjGrEquipData = lobjGenerateProc
								.GenerateStoreProcedure(
										"esp_amd_pitchoutfield",
										vparam, "ScoreDB");
						vparam.removeAllElements();
					} catch (Exception e) {
						System.out
								.println("*************RefereeReportOnUmpires.jsp*****************"
										+ e);
						log.writeErrLog(page.getClass(), match_id, e
								.toString());
					}
				}//End of the ground equipments.

				if (crsObjGrEquipData != null) {
					if (crsObjGrEquipData.next()) {
						//result = crsObjSaveRefereeData.getString("retval");
						if (crsObjGrEquipData.getString("retval")
								.equalsIgnoreCase(
										"Data updated successfully!")) {
							message = "Updated InfraStructure Facilities and Ground Equipments Successfully";
						} else {
							message = "Saved InfraStructure Facilities and Ground Equipments Successfully";
						}
					}
				}
			}

			if (request.getParameter("hdid") != null
					&& request.getParameter("hdid").equalsIgnoreCase(
							"4")) {
				//For referee part submit
				String[] refretrieve_ids = request.getParameter(
						"hidden_RefereeId").split(",");
				int refretrieve_ids_length = refretrieve_ids.length;
				for (int refcount = 0; refcount < refretrieve_ids_length; refcount = refcount + 2) {

					vparam = new Vector();
					vparam.add(match_id);
					vparam.add(user_id);
					vparam.add(refretrieve_ids[refcount]);
					if (refretrieve_ids[refcount + 1]
							.equalsIgnoreCase("N")) {
						vparam.add("0");
						vparam
								.add(replaceApos
										.replacesingleqt((String) request
												.getParameter("rem_"
														+ refretrieve_ids[refcount])));
					} else if (refretrieve_ids[refcount + 1]
							.equalsIgnoreCase("Y")) {
						vparam.add(request.getParameter("refereeId"
								+ refretrieve_ids[refcount]));

						vparam
								.add(replaceApos
										.replacesingleqt((String) request
												.getParameter("rem_"
														+ refretrieve_ids[refcount])));
					}
					vparam.add(refereeReportId);//Report Id of captain report

					try {
						crsObjSaveRefereeData = lobjGenerateProc
								.GenerateStoreProcedure(
										"esp_amd_matchrefereefeedback",
										vparam, "ScoreDB");
					} catch (Exception e) {
						System.out
								.println("*************RefereeReportOnUmpires.jsp*****************"
										+ e);
						log.writeErrLog(page.getClass(), match_id, e
								.toString());
					}
				}
				vparam.removeAllElements();
				if (crsObjSaveRefereeData != null) {
					if (crsObjSaveRefereeData.next()) {
						if (crsObjSaveRefereeData.getString("retval")
								.equalsIgnoreCase("SAVED")) {
							message = "Referee Points Saved Successfully";
						} else {
							message = "Referee Points Updated Successfully";
						}
					}
				}
				//End of the referee part submit	

			}
		}
%>
<html>
<head>
<title>Referee's Match Report</title>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
<link href="../css/form.css" rel="stylesheet" type="text/css" />
<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
<script language="JavaScript"
	src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>
<script language="JavaScript"
	src="<%=request.getContextPath()%>/js/trim.js"></script>
<script language="javascript" src="../js/captainRefereeFeedback.js"></script>
<script language="javascript" src="../js/jquery.js"></script>
<script language="javascript">	
	var xmlHttp=null;
	function GetXmlHttpObject(){//ajax code to get the div from other page.		
		try{
			// Firefox, Opera 8.0+, Safari
			xmlHttp=new XMLHttpRequest();
		}catch (e){
			// Internet Explorer
			try{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}catch (e){
	        	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}
	
	function saveUmpDetails(){
			if(document.getElementById("hdUmpireId1").value == "0" || document.getElementById("hdUmpireId2").value == "0"){
			alert("Both Umpires Should Be Assigned For Match.")
		}else{			
			if((document.getElementById('hidden_ids').value != "")){
				var isComplete = true;
			if(!isComplete){				
					return false;
				}else{
					document.getElementById("hdid").value = 2;
					document.frmRefereeReport.submit();
				}
			}else{
				alert("Please Log Out And Log In By Referee Login Id.")
			}
		}	
	}

	function saveGroundEquipments(){
		if(document.getElementById("hdUmpireId1").value == "0" || document.getElementById("hdUmpireId2").value == "0"){
			alert("Both Umpires Should Be Assigned For Match.")
		}else{			
			if((document.getElementById('hiddengr_ids').value != "")){
				var isComplete = true;
			if(!isComplete){				
					return false;
				}else{
					document.getElementById("hdid").value = 3;
					document.frmRefereeReport.submit();
				}
			}else{
				alert("Please Log Out And Log In By Referee Login Id.")
			}
		}	
	}
	function saveRefereeDeta(){
		if(document.getElementById("hdUmpireId1").value == "0" || document.getElementById("hdUmpireId2").value == "0"){
			alert("Both Umpires Should Be Assigned For Match.")
		}else{			
			if((document.getElementById('hidden_RefereeId').value != "")){
				var isComplete = true;
			if(!isComplete){				
					return false;
				}else{
					document.getElementById("hdid").value = 4;
					document.frmRefereeReport.submit();
				}
			}else{
				alert("Please Log Out And Log In By Referee Login Id.")
			}
		}	
	}
	
	function chktxtsize(){
		alert(document.getElementById("txttemp").maxlength);
	}

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
					alert("falg 2 Please enter maximum 500 characters only.")
					document.getElementById(id).focus()
					return false
			 }else{*/	
			    return (Object.value.length < MaxLen);
			// }
		  }	
		}

		function callTooltip(anchorid,textareaid){
			//alert(anchorid)
			//	alert(textareaid)
			document.getElementById(anchorid).title = document.getElementById(textareaid).innerHTML
		}
		 $(document).ready(function() {
			    $(".tabLink").each(function(){
			      $(this).click(function(){
			        tabeId = $(this).attr('id');
			        $(".tabLink").removeClass("activeLink");
			        $(this).addClass("activeLink");
			        $(".tabcontent").addClass("hide");
			        $("#"+tabeId+"-1").removeClass("hide");
			        $("#section2_next").hide();
			        if(tabeId == "cont-2"){
			    		$("#cont-1").removeClass("activeLink");
			    		$("#cont-3").removeClass("activeLink");	
			    		$(".tabcontent").addClass("hide");
			    		$("#cont-2").addClass("activeLink");
			    		$("#cont-2-1").removeClass("hide");
			    		$("#section2_next").show();
			    	}	  

			    	if(tabeId == "cont-3"){
			    		$("#cont-1").removeClass("activeLink");
			    		$("#cont-2").removeClass("activeLink");	
			    		$(".tabcontent").addClass("hide");
			    		$("#cont-3").addClass("activeLink");
			    		$("#cont-3-1").removeClass("hide");
			    	}
			           
			        return false;	  
			      });
			    });
			    tab_selectction();
			  });	
		 function tab_selectction(){
			 var tabValue  = $("#hdid").val();
			    $("#section2_next").hide();
		    	if(tabValue == "2"){
		    		$("#cont-1").removeClass("activeLink");
		    		$("#cont-3").removeClass("activeLink");	
		    		$(".tabcontent").addClass("hide");
		    		$("#cont-2").addClass("activeLink");
		    		$("#cont-2-1").removeClass("hide");
		    		$("#section2_next").show();
		    	}	  

		    	if(tabValue == "3"){
		    		$("#cont-1").removeClass("activeLink");
		    		$("#cont-2").removeClass("activeLink");	
		    		$(".tabcontent").addClass("hide");
		    		$("#cont-3").addClass("activeLink");
		    		$("#cont-3-1").removeClass("hide");
		    	}
		 }	  
	</script>
<style type="text/css">
	.tab-box {
		border-bottom: 1px solid #DDD;
		padding-bottom: 5px;
		align: left;
		padding: 5px 35px;

	}
	
	.tab-box a {
		border: 1px solid #DDD;
		color: #000000;
		padding: 5px 15px;
		text-decoration: none;
		background-color: #eee;
		
	}
	
	.tab-box a.activeLink {
		background-color: #fff;
		border-bottom: 0;
		padding: 6px 15px;
		background-color: #FAA732;
    	background-image: -moz-linear-gradient(center top , #FBB450, #F89406);
    	background-repeat: repeat-x;
    	border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
    	color: #FFFFFF;
    	text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
		
	}
	
	.tabcontent {
		border: 1px solid #ddd;
		border-top: 0;
		padding: 5px;
	}
	
	.hide {
		display: none;
	}
	
	.small {
		color: #999;
		margin-top: 100px;
		border: 1px solid #EEE;
		padding: 5px;
		font-size: 9px;
		font-family: Verdana, Arial, Helvetica, sans-serif;
	}
</style>

</head>
<body onload="refereetotal()"
	style="padding-left: 5px; padding-right: 5px;">
<table align="center" style="width: 84.5em;">
	<tr>
		<td align="center">
		<div style="width: 84.5em" align="center">
		<%
			if (!gsflag.equalsIgnoreCase("1")) {
		%> <jsp:include page="Menu.jsp"></jsp:include>
		<br>
		<%
			}
		%>

		<FORM name="frmRefereeReport" id="frmRefereeReport" method="post"><br>
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
			<tr>
				<td colspan="9" bgcolor="#FFFFFF" class="legend">Referee's Report on Umpires</td>
			</tr>
			<% if (user_role.equals("9")) {%>
			<tr>
				<td colspan="9" align="right">Export : <a
					href="/cims/jsp/PDFRefereeReportOnUmpires.jsp" target="_blank">
				<img src="/cims/images/pdf.png" height="20" width="20" /> </a> 
				<a href="/cims/jsp/EXCELRefereeReportOnUmpires.jsp" target="_blank">
				<img src="/cims/images/excel.jpg" height="20" width="20" /> </a></td>
			</tr>
			<% } %>
			<tr>
				<td colspan="3"><!-- <B>NOTE:</B> <font color="red">User Can Fill Up/Update This Report Within Three Days From The Last Day Of Match.</font> -->
				</td>
			</tr>
			<tr class="contentDark">
				<%--			<td colspan="2" style="color: red "><font size="3" ><%=message%></td>--%>
				<td align="right"><%=loginUserId%></td>
				<td colspan="4" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>&nbsp;&nbsp;&nbsp;&nbsp;DATE
				:</b> <%=sdf.format(new Date())%></td>
			</tr>
		</table>
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
			<%
				try {
						if (crsObjRefereeDetail != null) {
							while (crsObjRefereeDetail.next()) {
								gsUmpire1Id = crsObjRefereeDetail
										.getString("umpireofficalid1");
								gsUmpire2Id = crsObjRefereeDetail
										.getString("umpireofficalid2");
								gsUmpireName1 = crsObjRefereeDetail
										.getString("umpire");
								gsUmpireName2 = crsObjRefereeDetail
										.getString("umpire2");
			%>
			<tr class="contentLight">
				<!--From System-->
				<td width="20%" align="left">Match No :</td>
				<td align="left"><%=match_id%></td>
				<%--			<td ></td>--%>
			</tr>
			<tr class="contentDark">
				<!--From System-->
				<td width="20%">Match Between :</td>
				<%
					if (crsObjRefereeDetail.getString("team1") == null
											|| crsObjRefereeDetail.getString("team1")
													.equals("")) {
				%>
				<td>----</td>
				<%
					} else {
				%>
				<td align="left"><%=crsObjRefereeDetail
												.getString("team1")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjRefereeDetail
												.getString("team2")%>
				</td>
				<%
					}
				%>
				<%--			<td align="left"></td>--%>
			</tr>
		
			<tr class="contentDark">
				<!--From System-->
				<td width="20%" align="left">Name Of the Referee :</td>
				<%
					if (crsObjRefereeDetail.getString("referee") == null
											|| crsObjRefereeDetail.getString("referee")
													.equals("")) {
				%>
				<td>----</td>
				<%
					} else {
				%>
				<td align="left"><%=crsObjRefereeDetail
												.getString("referee")%></td>
				<%
					}
				%>
				<%--			<td ></td>--%>
			</tr>
			<tr class="contentLight">
				<!--From System-->
				<td width="20%" align="left">Venue :</td>
				<%
					if (crsObjRefereeDetail.getString("venue") == null
											|| crsObjRefereeDetail.getString("venue")
													.equals("")) {
				%>
				<td>----</td>
				<%
					} else {
				%>
				<td align="left"><%=crsObjRefereeDetail
												.getString("venue")%></td>
				<%
					}
				%>
				<%--			<td ></td>--%>
			</tr>
			<tr class="contentDark">
				<!--From System-->
				<td width="20%" align="left">Date :</td>
				<%
					if (crsObjRefereeDetail.getString("date") == null
											|| crsObjRefereeDetail.getString("date")
													.equals("")) {
				%>
				<td>----</td>
				<%
					} else {
										String d1 = null;
										java.util.Date date = ddmmyyyy
												.parse(crsObjRefereeDetail
														.getString("date"));
										d1 = sdf.format(date);
										String d2 = null;
										java.util.Date date2 = ddmmyyyy
										.parse(crsObjRefereeDetail
												.getString("enddate"));
										d2 = sdf.format(date2);
										 
				%>
				<td width="80%"><%=d1%> To  <%=d2 %></td>
				<%--			<td align="left"><%=crsObjRefereeDetail.getString("date")%></td>--%>
				<%--			<td align="left"><%=sdf.format(new Date(crsObjRefereeDetail.getString("date")))%></td>--%>
				<%
					}
				%>
				<%--			<td ></td>--%>
			</tr>
			<tr class="contentLight">
				<td width="20%" align="left">Name Of Tournament :</td>
				<%
					if (crsObjRefereeDetail.getString("tournament") == null
											|| crsObjRefereeDetail.getString(
													"tournament").equals("")) {
				%>
				<td>----</td>
				<%
					} else {
				%>
				<td align="left"><%=crsObjRefereeDetail.getString("tournament")%></td>
				<%
					}
				%>
				<%--			<td ></td>--%>
			</tr>
		</table>
		<%
			}
					}
		%> 
		<br>
		<div class="tab-box"> 
		    <a href="javascript:;" class="tabLink activeLink" id="cont-1">Section 1</a> 
		    <a href="javascript:;" class="tabLink " id="cont-2">Section 2</a> 
		    <a href="javascript:;" class="tabLink " id="cont-3">Section 3</a> 
		 </div>
		 <div class="tabcontent" id="cont-1-1"> 
		 	<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
			<tr class="contentLight">
				<%--   		<textarea class="textArea" rows="4" cols="20" maxlength="500"	id="txttemp" name="txttemp"></textarea>--%>
				<td colspan="3" align="left" class="headinguser">UMPIRING
				PERFORMANCE</td>
			</tr>
			<tr>
				<td class="message" align="center" colspan="4"><%=message%></td>
			</tr>
			<tr class="contentDark">
				<td></td>
				<td align="left"><%=gsUmpireName1%></td>
				<td align="left"><%=gsUmpireName2%></td>
			</tr>
			<tr class="contentLight">
				<td></td>
				<td align="left"><b>Scale </b></td>
				<td align="left"><b>Scale</b></td>
			</tr>
			<%
				if (user_role.equals("9")) {
							//For Umpire 1
							vparam = new Vector();
							vparam.add(match_id);
							vparam.add(gsrefid); //change to userid
							vparam.add(gsUmpire1Id);
							vparam.add(refereeReportId);// report_id CAPTAIN REPORT ON GROUND PITCH AND FACILITIES Table:feedbackgroups_mst

							try {
								crsObjViewDataUmp1 = lobjGenerateProc
										.GenerateStoreProcedure(
												"esp_dsp_umpirereports", vparam,
												"ScoreDB");
							} catch (Exception e) {
								System.out
										.println("*************RefereeReportOnUmpires.jsp*****************"
												+ e);
								log.writeErrLog(page.getClass(), match_id, e
										.toString());
							}

							//For Umpire 2
							vparam = new Vector();
							vparam.add(match_id);
							vparam.add(gsrefid); //change to userid
							vparam.add(gsUmpire2Id);
							vparam.add(refereeReportId);// report_id CAPTAIN REPORT ON GROUND PITCH AND FACILITIES Table:feedbackgroups_mst

							try {
								crsObjViewDataUmp2 = lobjGenerateProc
										.GenerateStoreProcedure(
												"esp_dsp_umpirereports", vparam,
												"ScoreDB");
							} catch (Exception e) {
								System.out
										.println("*************RefereeReportOnUmpires.jsp*****************"
												+ e);
								log.writeErrLog(page.getClass(), match_id, e
										.toString());
							}

							if (crsObjViewDataUmp1 != null
									&& crsObjViewDataUmp2 != null) {
								while (crsObjViewDataUmp1.next()
										&& crsObjViewDataUmp2.next()) {
									sbIds
											.append(crsObjViewDataUmp1
													.getString("id"));
									sbIds.append(",");
									sbIds.append(crsObjViewDataUmp1
											.getString("scoring_required"));
									sbIds.append(",");
									ids.add(crsObjViewDataUmp1.getString("id"));
									ids.add(crsObjViewDataUmp1
											.getString("scoring_required"));
									if (counter % 2 != 0) {
			%>
			<TR class="contentDark">
				<%
					} else {
				%>
			
			<tr class="contentLight">
				<%
					}
				%>
				<%
					if (crsObjViewDataUmp1.getString(
												"scoring_required").equalsIgnoreCase(
												"N")) {

											if (totalFlag.equalsIgnoreCase("false")) {
												totalFlag = "true";
				%>
			
			<tr class=" contentDark">
				<!--From System-->
				<td></td>
				<td><b>Total Points:</b></td>
				<td><b>Total Points:</b></td>
			</tr>
			<tr class="contentLight">
				<td></td>
				<td align="left"><input type="text" id="txtUmpireTotalPt1"
					name="txtUmpireTotalPt1" value="0" size="20" disabled="disabled">
				</td>
				<td align="left"><input type="text" id="txtUmpireTotalPt2"
					name="txtUmpireTotalPt2" value="0" size="20" disabled="disabled"></td>
				<input type="hidden" id="hdUmpireId1" name="hdUmpireId1"
					value="<%=gsUmpire1Id%>" size="20">
				<input type="hidden" id="hdUmpireId2" name="hdUmpireId2"
					value="<%=gsUmpire2Id%>" size="20">
			</tr>
			<%
				}
									}
			%>
			</tr>
			<tr class=" contentDark">
				<TD id="que_<%=crsObjViewDataUmp1.getString("id")%>"><%=crsObjViewDataUmp1
												.getString("description")%></TD>
				<%
					if (crsObjViewDataUmp1.getString(
												"scoring_required").equalsIgnoreCase(
												"Y")) {
				%>
				<%
					String[] strArr = crsObjViewDataUmp1
													.getString("cnames").toString()
													.split(",");
											int length = Integer
													.parseInt(crsObjViewDataUmp1
															.getString("score_max")
															.toString());
				%>
				<%
					int selectedVal1 = Integer
													.parseInt(crsObjViewDataUmp1
															.getString("selected")) - 1;
				%>
				<TD align="left">
				<%
					for (int count = length - 1; count >= 0; count--) {
				%> <%
 	if (strArr.length > count) {
 									if (selectedVal1 == count) {
 %> <FONT color="#216EE2"
					size="2"><%=strArr[count]%></font> <INPUT type="hidden"
					id="<%=crsObjViewDataUmp2
																		.getString("id")%>" value="<%=count + 1%>">
				<%
					} else {
				%> <INPUT type="hidden"
					id='<%=crsObjViewDataUmp2
																		.getString("id")%>' value="0"> <%
 	}
 								}
 							}
 %>
				</TD>
				<%
					int selectedVal2 = Integer
													.parseInt(crsObjViewDataUmp2
															.getString("selected")) - 1;
				%>
				<TD align="left">
				<%
					for (int count = length - 1; count >= 0; count--) {
				%> <%
 	if (strArr.length > count) {
 									if (selectedVal2 == count) {
 %> <FONT color="#216EE2" size="2"><%=strArr[count]%></font>
				<INPUT type="hidden"
					id="ump2<%=crsObjViewDataUmp2
																		.getString("id")%>"
					value="<%=count + 1%>"> <%
 	} else {
 %> <INPUT
					type="hidden" id='ump2<%=crsObjViewDataUmp2
																		.getString("id")%>'
					value="0"> <%
 	}
 								}
 							}
 %>
				</TD>
				<%
					} else {
				%>
				<TD>
				<%
					if (crsObjViewDataUmp1.getString("remark") != null) {
				%> <TEXTAREA
					disabled="disabled" type="text" class="textArea" maxlength="500"><%=crsObjViewDataUmp1.getString(
														"remark").trim()%></TEXTAREA>
				<%
					} else {
				%> <TEXTAREA disabled="disabled" type="text"
					class="textArea" maxlength="500"></TEXTAREA> <%
 	}
 %>
				</TD>
				<TD>
				<%
					if (crsObjViewDataUmp2.getString("remark") != null) {
				%> <TEXTAREA
					disabled="disabled" type="text" class="textArea" maxlength="500"><%=crsObjViewDataUmp2.getString(
														"remark").trim()%></TEXTAREA>
				<%
					} else {
				%> <TEXTAREA disabled="disabled" type="text"
					class="textArea" maxlength="500"></TEXTAREA> <%
 	}
 %>
				</TD>
				<%
					}
									}
								}
								///////////*************************////////////////////////////////////
							} else {
				%>
				<%
					vparam = new Vector();
								vparam.add(match_id);
								vparam.add(user_id); //change to userid	34214
								vparam.add(gsUmpire1Id);//Umpire 1 id
								vparam.add(refereeReportId);// report_id CAPTAIN REPORT ON GROUND PITCH AND FACILITIES Table:feedbackgroups_mst

								crsObjViewDataUmp1 = lobjGenerateProc
										.GenerateStoreProcedure(
												"esp_dsp_umpirereports ", vparam,
												"ScoreDB");
				%>

				<%
					vparam = new Vector();
								vparam.add(match_id);
								vparam.add(user_id); //change to userid	
								vparam.add(gsUmpire2Id);//Umpire 2 id
								vparam.add(refereeReportId);// report_id CAPTAIN REPORT ON GROUND PITCH AND FACILITIES Table:feedbackgroups_mst

								try {
									crsObjViewDataUmp2 = lobjGenerateProc
											.GenerateStoreProcedure(
													"esp_dsp_umpirereports ", vparam,
													"ScoreDB");
								} catch (Exception e) {
									System.out
											.println("*************RefereeReportOnUmpires.jsp*****************"
													+ e);
									log.writeErrLog(page.getClass(), match_id, e
											.toString());
								}

								if (crsObjViewDataUmp1 != null
										&& crsObjViewDataUmp2 != null) {

									while (crsObjViewDataUmp1.next()
											&& crsObjViewDataUmp2.next()) {
				%>
				<%
					sbIds
												.append(crsObjViewDataUmp1
														.getString("id"));
										sbIds.append(",");
										sbIds.append(crsObjViewDataUmp1
												.getString("scoring_required"));
										sbIds.append(",");
										ids.add(crsObjViewDataUmp1.getString("id"));
										ids.add(crsObjViewDataUmp1
												.getString("scoring_required"));
										if (counter % 2 != 0) {
				%>
			
			<TR class="contentDark">
				<%
					} else {
				%>
			
			<tr class="contentLight">
				<%
					}
				%>
				<%
					if (crsObjViewDataUmp1.getString(
												"scoring_required").equalsIgnoreCase(
												"N")) {

											if (totalFlag.equalsIgnoreCase("false")) {
												totalFlag = "true";
				%>
			
			<tr class=" contentDark">
				<!--From System-->
				<td></td>
				<td><b>Total Points:</b></td>
				<td><b>Total Points:</b></td>
			</tr>
			<tr class="contentLight">
				<td></td>
				<td align="left"><input type="text" id="txtUmpireTotalPt1"
					name="txtUmpireTotalPt1" value="0" size="20" disabled="disabled">
				</td>
				<td align="left"><input type="text" id="txtUmpireTotalPt2"
					name="txtUmpireTotalPt2" value="0" size="20" disabled="disabled"></td>
				<input type="hidden" id="hdUmpireId1" name="hdUmpireId1"
					value="<%=gsUmpire1Id%>" size="20">
				<input type="hidden" id="hdUmpireId2" name="hdUmpireId2"
					value="<%=gsUmpire2Id%>" size="20">
			</tr>
			<%
				}
									}
			%>
			</tr>
			<tr class=" contentDark">
				<TD width="35%" id="que_<%=crsObjViewDataUmp1.getString("id")%>"
					name="<%=counter++%>"><b>.&nbsp;</b><%=crsObjViewDataUmp1
												.getString("description")%></TD>
				<%
					if (crsObjViewDataUmp1.getString(
												"scoring_required").equalsIgnoreCase(
												"Y")) {
				%>
				<%
					String[] strArr = crsObjViewDataUmp1
													.getString("cnames").toString()
													.split(",");
											int length = Integer
													.parseInt(crsObjViewDataUmp1
															.getString("score_max")
															.toString());
				%>
				<%
					int selectedVal1 = Integer
													.parseInt(crsObjViewDataUmp1
															.getString("selected")) - 1;
				%>
				<%
					
				%>
				<TD><SELECT id="<%=crsObjViewDataUmp1
													.getString("id")%>"
					name="<%=crsObjViewDataUmp1
													.getString("id")%>" onchange="total()">
					<%--					<OPTION value="0">- Select -</OPTION>--%>
					<%
						for (int count = length - 1; count >= 0; count--) {
					%>
					<%
						if (strArr.length > count) {
														if (selectedVal1 == count) {
					%>
					<OPTION value="<%=(count + 1)%>" selected="selected"><%=strArr[count]%></option>
					<%
						} else {
					%>
					<OPTION value="<%=(count + 1)%>"><%=strArr[count]%></option>
					<%
						}
													} else if (strArr.length <= count) {
														if (selectedVal1 == count) {
					%>
					<OPTION value="<%=count + 1%>" selected="selected"><%=count + 1%></option>
					<%
						} else {
					%>
					<OPTION value="<%=count + 1%>"><%=count + 1%></option>
					<%
						}
													}
												}
					%>
				</SELECT> <a id="remAnch_ump1<%=crsObjViewDataUmp1
													.getString("id")%>"
					name="remAnch_ump1<%=crsObjViewDataUmp1
													.getString("id")%>"
					href="javascript:void('')"
					onmouseover="callTooltip('remAnch_ump1<%=crsObjViewDataUmp1
													.getString("id")%>','rem_ump1<%=crsObjViewDataUmp1
													.getString("id")%>')"
					onclick="enterUmp1Remark('<%=crsObjViewDataUmp1
													.getString("id")%>')">Remark</a>
				<%
					if (crsObjViewDataUmp1.getString("remark")
													.trim().equalsIgnoreCase("")) {
				%>
				<div id="remDiv_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"
					name="remDiv_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"
					style="display: none"><textarea class="textArea"
					id="rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"
					name="rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>" rows="4"
					cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>','2')"><%=crsObjViewDataUmp1.getString(
														"remark").trim()%></textarea>
				</div>
				<%
					} else {
				%>
				<div id="remDiv_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"
					name="remDiv_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"><textarea
					class="textArea"
					id="rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"
					name="rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>" rows="4"
					cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>','2')"><%=crsObjViewDataUmp1.getString(
														"remark").trim()%></textarea>
				</div>
				<%
					}
				%>
				</TD>
				<%
					int selectedVal2 = Integer
													.parseInt(crsObjViewDataUmp2
															.getString("selected")) - 1;
				%>
				<%%>
				<TD><SELECT id="ump2<%=crsObjViewDataUmp2
													.getString("id")%>"
					name="ump2<%=crsObjViewDataUmp2
													.getString("id")%>"
					onchange="total()">
					<%--					<OPTION value="0">- Select -</OPTION>--%>
					<%
						for (int count = length - 1; count >= 0; count--) {
					%>
					<%
						if (strArr.length > count) {
														if (selectedVal2 == count) {
					%>
					<OPTION value="<%=(count + 1)%>" selected="selected"><%=strArr[count]%></option>
					<%
						} else {
					%>
					<OPTION value="<%=(count + 1)%>"><%=strArr[count]%></option>
					<%
						}
													} else if (strArr.length <= count) {
														if (selectedVal1 == count) {
					%>
					<OPTION value="<%=count + 1%>" selected="selected"><%=count + 1%></option>
					<%
						} else {
					%>
					<OPTION value="<%=count + 1%>"><%=count + 1%></option>
					<%
						}
													}
												}
					%>
				</SELECT> <a id="remAnch_ump2<%=crsObjViewDataUmp2
													.getString("id")%>"
					name="remAnch_ump2<%=crsObjViewDataUmp2
													.getString("id")%>"
					href="javascript:void('')"
					onmouseover="callTooltip('remAnch_ump2<%=crsObjViewDataUmp2
													.getString("id")%>','rem_ump2<%=crsObjViewDataUmp2
													.getString("id")%>')"
					onclick="enterUmp2Remark('<%=crsObjViewDataUmp2
													.getString("id")%>')">Remark</a>
				<%
					if (crsObjViewDataUmp2.getString("remark")
													.trim().equalsIgnoreCase("")) {
				%>
				<div id="remDiv_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"
					name="remDiv_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"
					style="display: none"><textarea class="textArea"
					id="rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"
					name="rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>" rows="4"
					cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>','2')"><%=crsObjViewDataUmp2.getString(
														"remark").trim()%></textarea>
				</div>
				<%
					} else {
				%>
				<div id="remDiv_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"
					name="remDiv_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"><textarea
					class="textArea"
					id="rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"
					name="rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>" rows="4"
					cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>','2')"><%=crsObjViewDataUmp2.getString(
														"remark").trim()%></textarea>
				</div>
				<%
					}
				%>
				</TD>
				<%
					} else {
				%>
				<td><a id="Ump1remAnch_<%=crsObjViewDataUmp1
													.getString("id")%>"
					name="Ump1remAnch_<%=crsObjViewDataUmp1
													.getString("id")%>"
					href="javascript:void('')"
					onmouseover="callTooltip('Ump1remAnch_<%=crsObjViewDataUmp1
													.getString("id")%>','rem_ump1<%=crsObjViewDataUmp1
													.getString("id")%>')"
					onclick="enterUmp1Remark('<%=crsObjViewDataUmp1
													.getString("id")%>')">Remark</a>
				<%
					if (crsObjViewDataUmp1.getString("remark")
													.trim().equalsIgnoreCase("")) {
				%>
				<div id="remDiv_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"
					name="remDiv_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"
					style="display: none"><textarea class="textArea"
					id="rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"
					name="rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>" rows="4"
					cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>','2')"><%=crsObjViewDataUmp1.getString(
														"remark").trim()%></textarea>
				</div>
				<%
					} else {
				%>
				<div id="remDiv_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"
					name="remDiv_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"><textarea
					class="textArea"
					id="rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>"
					name="rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>" rows="4"
					cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump1<%=crsObjViewDataUmp1
														.getString("id")%>','2')"><%=crsObjViewDataUmp1.getString(
														"remark").trim()%></textarea>
				</div>
				<%
					}
				%>
				</td>
				<td><a id="Ump2remAnch_<%=crsObjViewDataUmp2
													.getString("id")%>"
					name="Ump2remAnch_<%=crsObjViewDataUmp2
													.getString("id")%>"
					href="javascript:void('')"
					onmouseover="callTooltip('Ump2remAnch_<%=crsObjViewDataUmp2
													.getString("id")%>','rem_ump2<%=crsObjViewDataUmp2
													.getString("id")%>')"
					onclick="enterUmp2Remark('<%=crsObjViewDataUmp2
													.getString("id")%>')">Remark</a>
				<%
					if (crsObjViewDataUmp2.getString("remark")
													.trim().equalsIgnoreCase("")) {
				%>
				<div id="remDiv_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"
					name="remDiv_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"
					style="display: none"><textarea class="textArea"
					id="rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"
					name="rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>" rows="4"
					cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>','2')"><%=crsObjViewDataUmp2.getString(
														"remark").trim()%></textarea>
				</div>
				<%
					} else {
				%>
				<div id="remDiv_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"
					name="remDiv_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"><textarea
					class="textArea"
					id="rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>"
					name="rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>" rows="4"
					cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=crsObjViewDataUmp2
														.getString("id")%>','2')"><%=crsObjViewDataUmp2.getString(
														"remark").trim()%></textarea>
				</div>
				<%
					}
				%>
				</td>
				<%
					}
				%>
				<%
					}
								}
							}
				%>
			
			<tr>
				<td colspan="3" align="right"><INPUT type="button"
					class="btn btn-warning" id="btnSaveUmpDeta" name="btnSaveUmpDeta"
					value="Next" onclick="saveUmpDetails()"></td>
			</tr>
		</table>
		</div>
  		<div class="tabcontent hide" id="cont-2-1"> 
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table tableBorder">
			<tr class="contentLight">
				<td colspan="10" name="<%=counter++%>" class="headinguser">REPORT
				ON THE MATCH</td>
			</tr>

			<tr class="contentDark">
				<td class="colheadinguser">Name of Asscn.</td>
				<td class="colheadinguser"><b>Innings.</b></td>
				<td class="colheadinguser"><b>Runs Scored by the Asscn.</b></td>
				<td class="colheadinguser"><b>No. of Wickets fallen </b></td>
				<td class="colheadinguser"><b>Total Time taken by Asscn.</b></td>
				<td class="colheadinguser"><b>Overs Bowled by Opponent
				Asscn.</b></td>
				<td class="colheadinguser"><b>Overs Bowled Short by
				Opponent Asscn.</b></td>
				<td class="colheadinguser"><b>Financial Penalty on Opponent
				Asscn.</b></td>
				<td class="colheadinguser"><b>Match Points(league level)</b></td>
				<td class="colheadinguser"><b>Match Result(Knock Out Level)</b></td>
			</tr>
			<%
				while (crsObjmatchreport.next()) {
			%>
			<tr>
				<td align="left"><%=crsObjmatchreport.getString("nameofasscn")%></td>
				<td align="left"><%=crsObjmatchreport.getString("innings")%></td>
				<td align="left"><%=crsObjmatchreport.getString("runsscored")%></td>
				<td align="left"><%=crsObjmatchreport.getString("noofwkt")%></td>
				<td align="left"><%=crsObjmatchreport
												.getString("totalmatchtime")%></td>
				<td align="left"><%=crsObjmatchreport.getString("overbowled")%></td>
				<td align="left"><%=crsObjmatchreport
										.getString("overbowledshort")%></td>
				<td align="left"><b>Rs.</b></td>
				<td align="left"><%=crsObjmatchreport.getString("matchpoint")%></td>
				<td align="left"><%=crsObjmatchreport.getString("matchresult")%></td>
			</tr>
			<%
				}// end of while
			%>
		</table>
		<br>
		<!--table for breaches field. --> <%
 	if (user_role.equals("9")) {
 %>
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
			<tr class="contentDark">
				<td colspan="7" name="<%=counter++%>" class="headinguser">
				Summary of breaches of the code of conduct laid down by BCCI,if any.</td>
			</tr>
		</table>
		<%
			} else {
		%>
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
			<tr class="contentDark">
				<td colspan="7" name="<%=counter++%>" class="headinguser">Summary
				of breaches of the code of conduct laid down by BCCI,if any.</td>
			</tr>
			<tr class="contentLight">
				<td width="20%" align="left">Match Players :</td>
				<td width="10%" align="left">Level :</td>
				<td width="10%" align="left">Offence :</td>
				<td width="10%" align="left">Penalty Type:</td>
				<td width="15%" align="left">Penalty</td>
				<td align="left" colspan="2"></td>
			</tr>
			<br>
			<tr class="contentDark">
				<td><select name="dpPlayer" id="dpPlayer"
					onchange="DecideLevel()">
					<option value="0">Select</option>
					<%
						if (crsObjplayerDetail != null) {
										while (crsObjplayerDetail.next()) {
					%>
					<%
						//	if(crsObjplayerDetail.getString("userroleid").equalsIgnoreCase("")){
					%>
					<option value="<%=crsObjplayerDetail
												.getString("userroleid")%>"><%=crsObjplayerDetail
												.getString("playername")%></option>
					<%
						//	}else{
					%>
					<%
						//	}
										}
									}
					%>
					<input type="hidden" id="hdPlayerName" name="hdPlayerName" value="">
				</select></td>

				<td width="20%">
				<div id="tempLevelDev"><select>
					<option>-Select-</option>
				</select></div>
				<div id="LevelDiv" style="display: none;"></div>
				<input type="hidden" id="hdOffence" name="hdOffence" value="">
				</td>

				<td width="20%">
				<div id="tempDev"><select>
					<option>-Select-</option>
				</select></div>
				<div id="OffencesDiv" style="display: none;"></div>
				<input type="hidden" id="hdOffence" name="hdOffence" value="">
				</td>
				<td><select name="dpPenalty" id="dpPenalty"
					onchange="showDiv()">
					<option value="0">Select</option>
					<option value="1">Fees</option>
					<option value="2">Banned</option>
					<option value="3">Reprimind</option>
					<input type="hidden" id="hdPenalty" name="hdPenalty" value="">
				</select></td>
				<td colspan="2">
				<div id="FeeDiv" style="display: none;" align="center">Fees:
				<input type="text" id="Fees" name="Fees" size="2"
					onKeyPress="return keyRestrict(event,'.%1234567890')"></input></div>
				<div id="BannedDiv" style="display: none;" align="center">Banned:
				<input type="text" id="Banned" name="Banned" size="2"
					onKeyPress="return keyRestrict(event,'.%1234567890')"></input></div>
				<div id="ReprimindDiv" style="display: none;" align="center">
				<input type="text" id="Reprimind" name="Reprimind" size="10"
					value="Reprimind"></input></div>
				</td>
				<td align="right"><input class="btn btn-warning" type="button"
					id="btnAddBreaches" name="btnAddBreaches" value="Add"
					onclick="AddBreaches()"> <input type="hidden"
					id="hdmatchid" name="hdmatchid" value="<%=match_id%>"></td>
			</tr>
		</table>
		<%
			}
		%> <!--end of table breaches field. -->
		<div id="CurrentPageOffenceDiv">
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
			<tr class="contentLight">
				<td align="left" class="colheadinguser">Player Name</td>
				<td align="left" class="colheadinguser">Level</td>
				<td align="left" class="colheadinguser">Offence</td>
				<td align="left" class="colheadinguser" colspan="2">Penalty</td>

			</tr>
			<%
				if (crsObjOffencesDetail != null) {
							int Offencecounter = 1;
							while (crsObjOffencesDetail.next()) {
								if (Offencecounter % 2 != 0) {
			%>
			<tr class="contentDark">
				<%
					} else {
				%>
			
			<tr class="contentLight">
				<%
					}
				%>

				<td align="left" id="<%=Offencecounter++%>"><%=crsObjOffencesDetail
											.getString("playername")%></td>
				<td align="left"><%=crsObjOffencesDetail
											.getString("breach_level")%></td>
				<td align="left"><%=crsObjOffencesDetail
											.getString("description")%></td>
				<%
					if (crsObjOffencesDetail.getString("reason")
											.equals("25000")) {
				%>
				<td align="left">Reprimind</td>
				<%
					} else {
										if (crsObjOffencesDetail.getString(
												"fee_percentage").equals("0")) {
				%>
				<td align="left">Banned For &nbsp;<%=crsObjOffencesDetail
													.getString("reason")%>&nbsp;Matches</td>
				<%
					} else {
				%>
				<td align="left">&nbsp;<%=crsObjOffencesDetail
													.getString("reason")%>%&nbsp;Fees
				</td>
				<%
					}
				%>
				<%
					}
				%>
				<td align="left" class="colheadinguser"><input
					class="btn btn-warning" type="button" id="btnDelBreaches"
					name="btnDelBreaches" value="Delete"
					onclick="DeleteRecord('<%=crsObjOffencesDetail
											.getString("user_role_id")%>','<%=crsObjOffencesDetail
											.getString("breach_id")%>')">
				</td>
				<%
					} //end of while
							}//end of outer if
				%>
			</tr>
		</table>
		</div>

		<div id="BreachesDiv" style="display: none; color: red; font-size: 15"
			align="center"></div>

		<br>
		<!--table for infrasturustural fascility field. --> <%
 	if (user_role.equals("9")) {
 %>
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
<%
		vparam.removeAllElements();
		vparam.add(match_id);
		vparam.add(gsrefid); //change to userid	34214
		vparam.add(refereeReportId);
		try {
				crsObjGroundEquCrs = lobjGenerateProc.GenerateStoreProcedure(
											"esp_dsp_pitchoutfieldoneday",
											vparam, "ScoreDB");//need to change
				vparam.removeAllElements();
		} catch (Exception e) {
				System.out.println("*************RefereeReportOnUmpires.jsp*****************"+ e);
				log.writeErrLog(page.getClass(), match_id, e.toString());
		}
		if (crsObjGroundEquCrs != null) {
			while (crsObjGroundEquCrs.next()) {
					sbgrEquipIds.append(crsObjGroundEquCrs.getString("facilityid"));
					sbgrEquipIds.append(",");
					sbgrEquipIds.append(crsObjGroundEquCrs.getString("scoring_required"));
					sbgrEquipIds.append(",");
					groundids.add(crsObjGroundEquCrs.getString("facilityid"));
					groundids.add(crsObjGroundEquCrs.getString("scoring_required"));
			if (counter % 2 != 0) {
%>
			<tr class="contentDark">
<%			} else {
%>			<tr class="contentLight">
<%			}
%>
<%
			if (crsObjGroundEquCrs.getString("parent").equalsIgnoreCase("0")) {
%>				<TD name="<%=counter++%>"><%=crsObjGroundEquCrs.getString("description")%></TD>
<%			} else {
%>				<TD id="groundque_<%=crsObjGroundEquCrs.getString("facilityid")%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjGroundEquCrs
													.getString("description")%></TD>
<%			}
%>				<td align="left">
<%				if (crsObjGroundEquCrs.getString("scoring_required").equalsIgnoreCase("Y")) {
					String[] strArr = crsObjGroundEquCrs.getString("cnames").toString().split(",");
					int length = Integer.parseInt(crsObjGroundEquCrs.getString("score_max").toString());
					int selectedVal1 = Integer.parseInt(crsObjGroundEquCrs.getString("selected")) - 1;
				 	for (int count = length - 1; count >= 0; count--) {
 					if (strArr.length > count) {
					if (selectedVal1 == count) {
%> 					<LABEL><%=strArr[count]%></LABEL>
					<INPUT type="hidden" id="<%=crsObjGroundEquCrs.getString("facilityid")%>" value="<%=count + 1%>"> 
<%					} else {
%> 					<INPUT type="hidden" id='<%=crsObjGroundEquCrs.getString("facilityid")%>' value="0">
<%					}
					}
					}
%>				</td>
<%			    } else {}
%>
			</tr>
<%			}
		}
%>
		</table>
<%		} else {
%>
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
			<%
				vparam.removeAllElements();
							vparam.add(match_id);
							vparam.add(user_id); //change to userid	34214			
							vparam.add(refereeReportId);
							try {
								crsObjGroundEquCrs = lobjGenerateProc
										.GenerateStoreProcedure(
												"esp_dsp_pitchoutfieldoneday",
												vparam, "ScoreDB");//need to change
								vparam.removeAllElements();
							} catch (Exception e) {
								System.out
										.println("*************RefereeReportOnUmpires.jsp*****************"
												+ e);
								log.writeErrLog(page.getClass(), match_id, e
										.toString());
							}
							if (crsObjGroundEquCrs != null) {
								while (crsObjGroundEquCrs.next()) {
									sbgrEquipIds.append(crsObjGroundEquCrs
											.getString("facilityid"));
									sbgrEquipIds.append(",");
									sbgrEquipIds.append(crsObjGroundEquCrs
											.getString("scoring_required"));
									sbgrEquipIds.append(",");
									groundids.add(crsObjGroundEquCrs
											.getString("facilityid"));
									groundids.add(crsObjGroundEquCrs
											.getString("scoring_required"));
									if (counter % 2 != 0) {
			%>
			<tr class="contentDark">
				<%
					} else {
				%>
			
			<tr class="contentLight">
				<%
					}
				%>
				<%
					if (crsObjGroundEquCrs.getString("parent")
												.equalsIgnoreCase("0")) {
				%>
				<TD name="<%=counter++%>"><b>.&nbsp;</b><%=crsObjGroundEquCrs
													.getString("description")%></TD>
				<%
					} else {
				%>
				<TD id="groundque_<%=crsObjGroundEquCrs
													.getString("facilityid")%>"
					name="<%=counter++%>">&nbsp;&nbsp;*<%=crsObjGroundEquCrs
													.getString("description")%></TD>
				<%
					}
				%>
				<td>
				<%
					if (crsObjGroundEquCrs.getString(
												"scoring_required").equalsIgnoreCase(
												"Y")) {
				%>
				<%
					String[] strArr = crsObjGroundEquCrs
													.getString("cnames").toString()
													.split(",");
											int length = Integer
													.parseInt(crsObjGroundEquCrs
															.getString("score_max")
															.toString());
				%>
				<%
					int selectedVal1 = Integer
													.parseInt(crsObjGroundEquCrs
															.getString("selected")) - 1;
				%>
				<%%> <SELECT
					id="groundId<%=crsObjGroundEquCrs
													.getString("facilityid")%>"
					name="groundId<%=crsObjGroundEquCrs
													.getString("facilityid")%>">
					<%--					<OPTION value="0">- Select -</OPTION>--%>
					<%
						for (int count = length - 1; count >= 0; count--) {
					%>
					<%
						if (strArr.length > count) {
														if (selectedVal1 == count) {
					%>
					<OPTION value="<%=(count + 1)%>" selected="selected"><%=strArr[count]%></option>
					<%
						} else {
					%>
					<OPTION value="<%=(count + 1)%>"><%=strArr[count]%></option>
					<%
						}
													} else if (strArr.length <= count) {
														if (selectedVal1 == count) {
					%>
					<OPTION value="<%=count + 1%>" selected="selected"><%=count + 1%></option>
					<%
						} else {
					%>
					<OPTION value="<%=count + 1%>"><%=count + 1%></option>
					<%
						}
													}
												}
					%>
				</SELECT> <a id="groundAnch_<%=crsObjGroundEquCrs
													.getString("facilityid")%>"
					name="groundAnch_<%=crsObjGroundEquCrs
													.getString("facilityid")%>"
					href="javascript:void(0)"
					onmouseover="callTooltip('groundAnch_<%=crsObjGroundEquCrs
													.getString("facilityid")%>','ground_<%=crsObjGroundEquCrs
													.getString("facilityid")%>')"
					onclick="enterGroundRemark('<%=crsObjGroundEquCrs
													.getString("facilityid")%>')">Remark</a>
				<%
					if (crsObjGroundEquCrs.getString("remark")
													.trim().equalsIgnoreCase("")) {
				%>
				<div id="groundDiv_<%=crsObjGroundEquCrs
																.getString("facilityid")%>"
					name="groundDiv_<%=crsObjGroundEquCrs
																.getString("facilityid")%>"
					style="display: none"><textarea class="textArea"
					id="ground_<%=crsObjGroundEquCrs
																.getString("facilityid")%>"
					name="ground_<%=crsObjGroundEquCrs
																.getString("facilityid")%>"
					rows="4" cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'ground_<%=crsObjGroundEquCrs
																.getString("facilityid")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'ground_<%=crsObjGroundEquCrs
																.getString("facilityid")%>','2')"><%=crsObjGroundEquCrs.getString(
														"remark").trim()%></textarea>
				</div>
				<%
					} else {
				%>
				<div id="groundDiv_<%=crsObjGroundEquCrs
																.getString("facilityid")%>"
					name="groundDiv_<%=crsObjGroundEquCrs
																.getString("facilityid")%>"><textarea
					class="textArea"
					id="ground_<%=crsObjGroundEquCrs
																.getString("facilityid")%>"
					name="ground_<%=crsObjGroundEquCrs
																.getString("facilityid")%>"
					rows="4" cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'ground_<%=crsObjGroundEquCrs
																.getString("facilityid")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'ground_<%=crsObjGroundEquCrs
																.getString("facilityid")%>','2')"><%=crsObjGroundEquCrs.getString(
														"remark").trim()%></textarea>
				</div>
				<%
					}
				%>
				</TD>
				<%
					} else {
										}
				%>
			</tr>
			<%
				}
							}
			%>
			<%
				}
			%>
			<tr>
				<td colspan="3" align="right"><span id="section2_next"><INPUT type="button"
					class="btn btn-warning" id="btnSaveInfraData"
					name="btnSaveInfraData" value="Next"
					onclick="saveGroundEquipments()" /></span></td>
			</tr>
		</table>
		</div> 
  		<div class="tabcontent hide" id="cont-3-1"> 
			<table class="table" border="0" align="center" cellpadding="2"
			cellspacing="1">
			<%
				if (user_role.equals("9")) {
							Vector refereeFld = new Vector();
							//to dispaly of Lower fields.
							refereeFld.add(match_id);
							refereeFld.add(gsrefid);
							refereeFld.add(refereeReportId);
							try {
								crsObjRefereeFields = lobjGenerateProc
										.GenerateStoreProcedure(
												"esp_dsp_matchrefereefeedback",
												refereeFld, "ScoreDB");
								refereeFld.removeAllElements();
							} catch (Exception e) {
								System.out
										.println("*************RefereeReportOnUmpires.jsp*****************"
												+ e);
								log.writeErrLog(page.getClass(), match_id, e
										.toString());
							}

							if (crsObjRefereeFields != null) {
								int refcounter = 1;
								while (crsObjRefereeFields.next()) {
									sbrefereeIds.append(crsObjRefereeFields
											.getString("rolefacilityid"));
									sbrefereeIds.append(",");
									sbrefereeIds.append(crsObjRefereeFields
											.getString("scoring_required"));
									sbrefereeIds.append(",");
									refereeids.add(crsObjRefereeFields
											.getString("rolefacilityid"));
									refereeids.add(crsObjRefereeFields
											.getString("scoring_required"));
			%>

			<tr class=<%=(refcounter % 2) != 0 ? "contentDark"
												: "contentLight"%>>

				<td><%=crsObjRefereeFields
												.getString("description")%></td>
				<%
					if (crsObjRefereeFields.getString(
												"scoring_required").equalsIgnoreCase(
												"Y")) {
				%>
				<%
					String[] strArr = crsObjRefereeFields
													.getString("cnames").toString()
													.split(",");
											int length = Integer
													.parseInt(crsObjRefereeFields
															.getString("score_max")
															.toString());
				%>
				<%
					int selectedVal1 = Integer
													.parseInt(crsObjRefereeFields
															.getString("selected")) - 1;
				%>
				<td>
				<%
					for (int count = length - 1; count >= 0; count--) {
												if (strArr.length > count) {
													if (selectedVal1 == count) {
				%> <LABEL><%=strArr[count]%></LABEL>
				<INPUT type="hidden"
					id="<%=crsObjRefereeFields
																		.getString("rolefacilityid")%>"
					value="<%=count + 1%>" /> <%
 	} else {
 %> <INPUT type="hidden"
					id='<%=crsObjRefereeFields
																		.getString("rolefacilityid")%>' value="0" />
				<%
					}
												}
											}
				%>
				</td>
				<%
					} else {
											if (crsObjRefereeFields.getString("remark") != null) {
				%>
				<td width="50%"><textarea class="textArea"
					id="refereeId<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					name="refereeId<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					maxlength="500"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890')">
					<%=crsObjRefereeFields
														.getString("remark")%>
				</textarea></td>
				<%
					} else {
				%>
				<td width="50%"><textarea class="textArea"
					id="refereeId<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					name="refereeId<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					maxlength="500"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890')">
				</textarea></td>
				<%
					}
										}
				%>
			</tr>
			<%
				refcounter++;
								}
							}
						} else {
							Vector refereeFld = new Vector();
							//to dispaly of Lower fields.
							refereeFld.add(match_id);
							refereeFld.add(user_id);
							refereeFld.add(refereeReportId);
							try {
								crsObjRefereeFields = lobjGenerateProc
										.GenerateStoreProcedure(
												"esp_dsp_matchrefereefeedback",
												refereeFld, "ScoreDB");
								refereeFld.removeAllElements();
							} catch (Exception e) {
								System.out
										.println("*************RefereeReportOnUmpires.jsp*****************"
												+ e);
								log.writeErrLog(page.getClass(), match_id, e
										.toString());
							}

							if (crsObjRefereeFields != null) {
								while (crsObjRefereeFields.next()) {
									sbrefereeIds.append(crsObjRefereeFields
											.getString("rolefacilityid"));
									sbrefereeIds.append(",");
									sbrefereeIds.append(crsObjRefereeFields
											.getString("scoring_required"));
									sbrefereeIds.append(",");
									refereeids.add(crsObjRefereeFields
											.getString("rolefacilityid"));
									refereeids.add(crsObjRefereeFields
											.getString("scoring_required"));
									//System.out.println("sbrefereeIds *** "+sbrefereeIds);

									if (counter % 2 != 0) {
			%>
			<tr class="contentDark">
				<%
					} else {
				%>
			
			<tr class="contentLight">
				<%
					}
				%>
				<TD id="refque_<%=crsObjRefereeFields
												.getString("rolefacilityid")%>"
					name="<%=counter++%>"><b>.&nbsp;</b><%=crsObjRefereeFields
												.getString("description")%>
				</TD>
				<%
					if (crsObjRefereeFields.getString(
												"scoring_required").equalsIgnoreCase(
												"Y")) {
				%>
				<%
					String[] strArr = crsObjRefereeFields
													.getString("cnames").toString()
													.split(",");
											int length = Integer
													.parseInt(crsObjRefereeFields
															.getString("score_max")
															.toString());
											int selectedVal1 = Integer
													.parseInt(crsObjRefereeFields
															.getString("selected")) - 1;
				%>
				<TD><SELECT
					id="refereeId<%=crsObjRefereeFields
															.getString("rolefacilityid")%>"
					name="refereeId<%=crsObjRefereeFields
															.getString("rolefacilityid")%>">
					<%
						for (int count = length - 1; count >= 0; count--) {
					%>
					<%
						if (strArr.length > count) {
														if (selectedVal1 == count) {
					%>
					<OPTION value="<%=(count + 1)%>" selected="selected"><%=strArr[count]%></option>
					<%
						} else {
					%>
					<OPTION value="<%=(count + 1)%>"><%=strArr[count]%></option>
					<%
						}
													} else if (strArr.length <= count) {
														if (selectedVal1 == count) {
					%>
					<OPTION value="<%=count + 1%>" selected="selected"><%=count + 1%></option>
					<%
						} else {
					%>
					<OPTION value="<%=count + 1%>"><%=count + 1%></option>
					<%
						}
													}
												}
					%>
				</SELECT></td>
				<td align="center"><a
					id="remAnch_<%=crsObjRefereeFields
															.getString("rolefacilityid")%>"
					name="remAnch_<%=crsObjRefereeFields
															.getString("rolefacilityid")%>"
					href="javascript:void('')"
					onmouseover="callTooltip('remAnch_<%=crsObjRefereeFields
															.getString("rolefacilityid")%>','rem_<%=crsObjRefereeFields
															.getString("rolefacilityid")%>')"
					onclick="enterRemark('<%=crsObjRefereeFields
															.getString("rolefacilityid")%>')">Remark</a>
				<%
					if (crsObjRefereeFields.getString("remark")
													.trim().equalsIgnoreCase("")) {
				%>
				<div
					id="remDiv_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					name="remDiv_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					style="display: none"><textarea class="textArea"
					id="rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					name="rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					rows="4" cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>','2')">
						<%=crsObjRefereeFields
														.getString("remark")
														.trim()%>
					</textarea></div>
				<%
					} else {
				%>
				<div
					id="remDiv_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					name="remDiv_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"><textarea
					class="textArea"
					id="rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					name="rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					rows="4" cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>','2')"><%=crsObjRefereeFields
														.getString("remark")
														.trim()%></textarea>
				</div>
				<%
					}
				%>
				</td>
				<%
					} else {
				%>
				<td align="l" colspan="11"><a
					id="remAnch_<%=crsObjRefereeFields
															.getString("rolefacilityid")%>"
					name="remAnch_<%=crsObjRefereeFields
															.getString("rolefacilityid")%>"
					href="javascript:void('')"
					onmouseover="callTooltip('remAnch_<%=crsObjRefereeFields
															.getString("rolefacilityid")%>','rem_<%=crsObjRefereeFields
															.getString("rolefacilityid")%>')"
					onclick="enterRemark('<%=crsObjRefereeFields
															.getString("rolefacilityid")%>')">Remark</a>
				<%
					if (crsObjRefereeFields.getString("remark")
													.trim().equalsIgnoreCase("")) {
				%>
				<div
					id="remDiv_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					name="remDiv_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					style="display: none"><textarea class="textArea"
					id="rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					name="rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					rows="4" cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>','2')"><%=crsObjRefereeFields
														.getString("remark")
														.trim()%></textarea>
				</div>
				<%
					} else {
				%>
				<div
					id="remDiv_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					name="remDiv_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>">
				<textarea class="textArea"
					id="rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					name="rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>"
					rows="4" cols="20" maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=crsObjRefereeFields
																.getString("rolefacilityid")%>','2')"><%=crsObjRefereeFields
														.getString("remark")
														.trim()%>
			</textarea></div>
				<%
					}
										}
									}
								}
							}
				%>
				
			<tr>
				<td colspan="3" align="right"><INPUT type="button"
					class="btn btn-warning" id="btnSaveRefereeData"
					name="btnSaveRefereeData" value="Save" onclick="saveRefereeDeta()" />
				</td>
			</tr>
		</table>

		<%
			//dipti
		%> NOTE : Please enter maximum 500 characters for remark. <br>
		<br>

		<%
			if (!user_role.equals("9")) {
		%>
		<table width="100%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
			<tr>
				<td align="center">
				<%
					if (!gsflag.equalsIgnoreCase("1")) {
				%> <input class="btn btn-warning"
					type="button" align="center" class="contentDark" id="btnSubmit"
					name="btnSubmit" value="Submit" onclick="submitRefereeData()">
				<%
					}
				%>
				</td>
			</tr>
		</table>
</div>
		<%
			}
		%> 
		<input type="hidden" id="hidden_ids" name="hidden_ids"	value="<%=sbIds%>" />
 		<input type="hidden" id="hiddengr_ids" name="hiddengr_ids" value="<%=sbgrEquipIds%>" />
		<input type="hidden" id="hidden_RefereeId" name="hidden_RefereeId" value="<%=sbrefereeIds%>" /> 
		<INPUT type="hidden" id="hdid" 	name="hdid" value="<%=tabhdId %>" /> 
		<INPUT type="hidden" id="hdgrid" name="hdgrid" />
		<INPUT type="hidden" id="hid" name="hid" value="" /> </form>
		</div>
		</td>
	</tr>
</table>
<jsp:include page="admin/Footer.jsp"></jsp:include>
</body>
<%
	} catch (Exception e) {
			System.out
					.println("*************RefereeReportOnUmpires.jsp*****************"
							+ e);
			log.writeErrLog(page.getClass(), match_id, e.toString());
		}
%>
</html>
<%
	}
%>
