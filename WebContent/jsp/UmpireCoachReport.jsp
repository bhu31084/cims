<!--
	Author 		 : 	Saudagar Mulik
	Created Date : 02/09/2008
	Description  : Umpire coach report.
	Company 	 : Paramatrix Tech Pvt Ltd.
	Modified by	 : Avadhut Joshi 
-->

<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="response/error_page.jsp"%>
<%@ page import="in.co.paramatrix.common.*"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="java.sql.SQLException"%>

<%
		try {
			String report_id = "1";
			String strMessage = null;
			String loginUserId = null;				
			CachedRowSet crsObjDetails = null;
			CachedRowSet crsObjUmpires = null;
			CachedRowSet crsObjViewData = null;
			CachedRowSet crsObjMessage = null;
			CachedRowSet crsObjUmpireData = null;
			CachedRowSet crsObjUmpireCoachAdmin = null;			
			String matchType = null;
			String referee = null;
			String umpirecoach = null;
			String tournament = null;
			String venue = null;
			String club = null;
			String zone = null;
			String match_id = null;
			String coach_id = null;
			String coach_id_admin = null;	
			ReplaceApostroph replaceApos = new ReplaceApostroph();


			match_id = session.getAttribute("matchid").toString();
System.out.println("Match id"+match_id);			
			String userRole = session.getAttribute("role").toString();
			//out.println(match_id);
			coach_id = session.getAttribute("userid").toString();
			loginUserId = (String)session.getAttribute("usernamesurname").toString();
			//out.println(coach_id);			
			//coach_id = "34285";

			GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(
					match_id);

			Vector vparam = new Vector();

			String umpire_id = null;
			
			if(userRole.equalsIgnoreCase("9")){
				vparam.add(match_id);
				vparam.add("6");
				crsObjUmpireCoachAdmin = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_getMatchConcerns", vparam, "ScoreDB");
				vparam.removeAllElements();
			}
			
		if(crsObjUmpireCoachAdmin!= null)
			{
				while(crsObjUmpireCoachAdmin.next()){
						
						coach_id_admin = crsObjUmpireCoachAdmin.getString("id");
				}
			}
			

			if (request.getParameter("hid") != null) {
				if (request.getParameter("hid").equalsIgnoreCase("1")) {

					String[] retrieve_ids = request.getParameter("hidden_ids")
							.split(",");
					int retrieve_ids_length = retrieve_ids.length;

					umpire_id = request.getParameter("umpireName");

					for (int count = 0; count < retrieve_ids_length; count = count + 2) {
						vparam = new Vector();
						vparam.add(match_id);		
//						System.out.println(match_id);										
						vparam.add(coach_id);
//						System.out.println(coach_id);
						vparam.add(umpire_id);
//						System.out.println(umpire_id);
						vparam.add(retrieve_ids[count]);
//						System.out.println(retrieve_ids[count]);
						if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
							vparam.add(request
									.getParameter(retrieve_ids[count]));
							vparam.add(replaceApos.replacesingleqt((String)request.getParameter("rem_"+ retrieve_ids[count])));//
						} else if (retrieve_ids[count + 1]
								.equalsIgnoreCase("N")) {
							vparam.add("0");
						vparam.add(replaceApos.replacesingleqt((String)request.getParameter("rem_"+ retrieve_ids[count])));
						}
						vparam.add(report_id);
						crsObjMessage =lobjGenerateProc.GenerateStoreProcedure(
								"esp_amd_userappraisal", vparam, "ScoreDB");
									while(crsObjMessage.next()){
						strMessage = crsObjMessage.getString("RetVal");
					}
					}
				} else if (request.getParameter("hid").equalsIgnoreCase("2")) {
					umpire_id = request.getParameter("umpireName");
				}
			}

			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy-MM-dd hh:mm:ss");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
					"yyyy-MMM-dd");
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
					"yyyy-MMM-dd hh:mm");

			Vector ids = new Vector();

			StringBuffer sbIds = new StringBuffer();

			vparam = new Vector();

			vparam.add(match_id);
			crsObjDetails = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_umpirecoach_report", vparam, "ScoreDB");
			crsObjUmpires = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getUmpires", vparam, "ScoreDB");

			if (crsObjDetails.next()) {
				matchType = crsObjDetails.getString("team1_name")+" v/s "+ crsObjDetails.getString("team2_name");
				referee = crsObjDetails.getString("referee")==null? "-" : crsObjDetails.getString("referee");
				umpirecoach= crsObjDetails.getString("umpirecoach")==null? "-" :crsObjDetails.getString("umpirecoach");
				tournament = crsObjDetails.getString("tournament");
				venue = crsObjDetails.getString("venue");
				club = crsObjDetails.getString("club");
				zone = crsObjDetails.getString("zone")==null? "-" :crsObjDetails.getString("zone");
			}
%>
<html>
<head>
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

<script>
	function validate(){
		var str = document.getElementById('hidden_ids').value.split(",");
		var errorArray = new Array(str.length);
		var isComplete = true;
		for(var count = 0; count < str.length; count = count + 2){
			if(str[count+1] == "Y" && document.getElementById(str[count]).value == 0){
				//alert(count +" : "+ str[count+1]+" : "+ document.getElementById(str[count]).value);
				isComplete = false;
			}
		}
		if(isComplete){
			document.getElementById("hid").value = "1";
			document.frmcoatchreport.submit();
		}else{
			alert("Please select all the values.");
		}
	}
	
	function update_values(){
		document.getElementById("hid").value = "2";
		document.frmcoatchreport.submit();
	}
	
	function enterRemark(id){
			var remarkDiv = document.getElementById( 'remDiv_'+id );
			var remarkTextArea = document.getElementById( 'rem_'+id );
			if( remarkDiv.style.display == 'none' ){
				remarkDiv.style.display = ''
				remarkTextArea.focus();
			}else{
				if(remarkTextArea.innerHTML == ""){
					remarkDiv.style.display = 'none'
				}
			}
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

	function callTooltip(id){
		document.getElementById("remAnch_"+id).title = document.getElementById("rem_"+id).innerHTML
	}	
</script>
</head>

<body>
<table align="center" style="width: 84.5em;">
    <tr>
    	<td align="center">

<div style="width:84.5em">
<jsp:include page="AuthZ.jsp"></jsp:include>

<jsp:include page="Menu.jsp"></jsp:include>

<FORM name="frmcoatchreport" action="/cims/jsp/UmpireCoachReport.jsp"
	method="post"><br>
	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
			<tr>
				<td colspan="2" bgcolor="#FFFFFF" class="legend">Umpire Coach's Match Report</td>
			</tr>
			<tr>
				<td colspan="9" align="right">
				Export : 
					<a href="/cims/jsp/PDFUmpireCoachReport.jsp" target="_blank">
						<img src="/cims/images/pdf.png" height="20" width="20"  />
					</a>
					<a href="/cims/jsp/EXCELUmpireCoachReport.jsp" target="_blank">
						<img src="/cims/images/excel.jpg" height="20" width="20" />
					</a>
				</td>
			</tr>
			<tr>
				<td colspan="2" width="90%" class="contentDark" colspan="2" align="right"><b><%=loginUserId%>&nbsp;&nbsp;&nbsp;DATE :</b> <%=sdf1.format(new Date())%></td>
			</tr>
	
		<tr class="contentLight">
			<td width="15%"><b>MATCH ID:</b></td>
			<td align="left"><%=match_id%></td>
		</tr>
		<tr class="contentDark">
			<td width="15%"><b>MATCH:</b></td>
			<td align="left"><%=matchType%></td>
		</tr>
		<tr class="contentLight">
			<td width="15%"><b>Name Of the Referee:</b></td>
			<td align="left"><%=referee%></td>
		</tr>
		<tr class="contentDark">
			<td width="15%"><b>Name Of Tournament :</b></td>
			<td align="left"><%=tournament%></td>
		</tr>
		<tr class="contentLight">
			<td width="15%"><b>Venue :</b></td>
			<td align="left"><%=venue%></td>
		</tr>
		<tr class="contentDark">
			<td width="15%"><b>Zone :</b></td>
			<td align="left"><%=zone%></td>
		</tr>
		<tr class="contentDark">
			<td width="15%"><b>Umpire Coach :</b></td>
			<td align="left"><%=umpirecoach%></td>
		</tr>

		
		<tr class="contentLight">
			<td width="15%"><b>UMPIRE:</b></td>
			<td align="left">
			
<%			String strId = null;
			boolean init = false;
		if(crsObjUmpires.size() == 0 ){
%>			<font size="3" color="#003399">Umpire not assigned for this match</font>
<%		}else{
%>			<SELECT id="umpireName" name="umpireName"
				onchange="update_values()">
				<%
			


		if(crsObjUmpires.size()>0){
			while (crsObjUmpires.next()) {

				if (!init) {
					strId = crsObjUmpires.getString("id");

					init = true;
				}
				if (umpire_id != null
						&& crsObjUmpires.getString("id").equals(umpire_id)) {
					strId = crsObjUmpires.getString("id");

					%>
				
				<option value="<%=crsObjUmpires.getString("id")%>"
					selected="selected"><%=crsObjUmpires.getString("user_name")%></option>
				<%} else {%>
				
				<option value="<%=crsObjUmpires.getString("id")%>"><%=crsObjUmpires.getString("user_name")%></option>
				<%}
				}//end while
			}	%>
			</SELECT>
<%			}
%>
			</td>
		</tr>
		<br>
	<tr align="left">
	<td>
	
		<td>				<%if(crsObjMessage != null){%>
			<b style="color: red;"> <%=strMessage%> </b>
			<%}%>  
		</td>	
	</tr>
	</table>
	<BR>
				
<%

//start
		if(strId != null){
			vparam = new Vector();			
			vparam.add(strId);//strId);			// Put umpire user id
			crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_useridfrom", vparam, "ScoreDB");
					String UmpireUserId = null;
					if (crsObjViewData != null  && crsObjViewData.next()) {
						UmpireUserId = crsObjViewData.getString("id");
					}
		//end
			vparam = new Vector();
			vparam.add(match_id);
			vparam.add(UmpireUserId);//strId);			// Put umpire user id
			vparam.add(strId);//strId);			// Put  umpire official id
			vparam.add("7");
			crsObjUmpireData = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_umpirereports", vparam, "ScoreDB");
		}
		
		
%>
	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
<%	if(strId != null){
%>
		<tr align="left">
			<td width="33%" class="headinguser">
				<b> Description</b>
			</td>		
			<td width="25%" class="headinguser">
				<b> Rating by Umpire Coach</b>
			</td>
			<td width="10%" class="headinguser">
				<b>Self Rating by Umpire</b>
			</td>
			<td width="32%" class="headinguser">
				<b>Remark</b>
			</td>
		</tr>
<%	}
			vparam = new Vector();
			vparam.add(match_id);
			if(userRole.equals("9")){
			vparam.add(coach_id_admin);
			}else{
			      vparam.add(coach_id);
			}			
			vparam.add(strId);
			vparam.add(report_id);
//									System.out.println(vparam);
			crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_umpirereports", vparam, "ScoreDB");
			int counter = 1;		
			while (crsObjViewData.next() && crsObjUmpireData.next()) {
				sbIds.append(crsObjViewData.getString("id"));
				sbIds.append(",");
				sbIds.append(crsObjViewData.getString("scoring_required"));
				sbIds.append(",");

				ids.add(crsObjViewData.getString("id"));
				ids.add(crsObjViewData.getString("scoring_required"));
				if(counter % 2 != 0){	
%>
			<tr class="contentLight">
<%				}else{
%>			<tr class="contentDark">
<%				}
%>	
		
			<TD> &nbsp;<%=crsObjViewData.getString("description")%></TD>
			<TD><%
				if (crsObjViewData.getString("scoring_required")
						.equalsIgnoreCase("Y")) {
					String[] strArr = crsObjViewData.getString("cnames")
							.toString().split(",");
					int length = Integer.parseInt(crsObjViewData.getString(
							"score_max").toString());%> <SELECT
				id="<%=crsObjViewData.getString("id")%>"
				name="<%=crsObjViewData.getString("id")%>">
				<OPTION value="0">- Select -</OPTION>
				<%int selectedVal = Integer.parseInt(crsObjViewData
							.getString("selected")) - 1;

					for (int count = length - 1; count >= 0; count--) {
						if (strArr.length > count) {
							if (selectedVal == count) {%>
				<OPTION value="<%=(count+1)%>" selected="selected"><%=strArr[count]%></option>
				<%} else {%>
				<OPTION value="<%=(count+1)%>"><%=strArr[count]%></option>
				<%}
						} else if (strArr.length <= count) {
							if (selectedVal == count) {%>
				<OPTION value="<%=count+1%>" selected="selected"><%=count + 1%></option>
				<%} else {%>
				<OPTION value="<%=count+1%>"><%=count + 1%></option>
				<%}
						}
					}%>
			</SELECT>
			<a id="remAnch_<%=crsObjViewData.getString("id")%>"
			name="remAnch_<%=crsObjViewData.getString("id")%>"
			href="javascript:void('')"
			onmouseover="callTooltip('<%=crsObjViewData.getString("id")%>')"
			onclick="enterRemark('<%=crsObjViewData.getString("id")%>')">Remark</a> 
			
			
			
<%if (crsObjViewData.getString("remark").trim()
								.equalsIgnoreCase("")) {
%>
		<div id="remDiv_<%=crsObjViewData.getString("id")%>"
			name="remDiv_<%=crsObjViewData.getString("id")%>" style="display:none"><textarea
			class="textArea" id="rem_<%=crsObjViewData.getString("id")%>"
			name="rem_<%=crsObjViewData.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_<%=crsObjViewData.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=crsObjViewData.getString("id")%>','2')"><%=crsObjViewData.getString("remark").trim()%></textarea>
		</div>
		<%
						} else {
							%>
		<div id="remDiv_<%=crsObjViewData.getString("id")%>"
			name="remDiv_<%=crsObjViewData.getString("id")%>"><textarea
			class="textArea" id="rem_<%=crsObjViewData.getString("id")%>"
			name="rem_<%=crsObjViewData.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_<%=crsObjViewData.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=crsObjViewData.getString("id")%>','2')"><%=crsObjViewData.getString("remark").trim()%></textarea>
		</div>
		<%
			}						 
			//remark
			} else {%>			</SELECT>
			<a id="remAnch_<%=crsObjViewData.getString("id")%>"
			name="remAnch_<%=crsObjViewData.getString("id")%>"
			href="javascript:void('')"
			onmouseover="callTooltip('<%=crsObjViewData.getString("id")%>')"
			onclick="enterRemark('<%=crsObjViewData.getString("id")%>')">Remark</a> 
			
			
			
<%if (crsObjViewData.getString("remark").trim()
								.equalsIgnoreCase("")) {
%>
		<div id="remDiv_<%=crsObjViewData.getString("id")%>"
			name="remDiv_<%=crsObjViewData.getString("id")%>" style="display:none"><textarea
			class="textArea" id="rem_<%=crsObjViewData.getString("id")%>"
			name="rem_<%=crsObjViewData.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_<%=crsObjViewData.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=crsObjViewData.getString("id")%>','2')"><%=crsObjViewData.getString("remark").trim()%></textarea>
		</div>
		<%
						} else {
							%>
		<div id="remDiv_<%=crsObjViewData.getString("id")%>"
			name="remDiv_<%=crsObjViewData.getString("id")%>"><textarea
			class="textArea" id="rem_<%=crsObjViewData.getString("id")%>"
			name="rem_<%=crsObjViewData.getString("id")%>" rows="4" cols="20"
			maxlength="500"
			onblur="imposeMaxLength(this,500,event,'rem_<%=crsObjViewData.getString("id")%>','1')"
			onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_<%=crsObjViewData.getString("id")%>','2')"><%=crsObjViewData.getString("remark").trim()%></textarea>
		</div>
		<%
			}						 
			
			}%></TD>
<%--			}%></TD>--%>
				
					<td>
					<%
					if (crsObjUmpireData.getString("scoring_required")
							.equalsIgnoreCase("Y")) {
						String[] valueArr = crsObjUmpireData.getString("cnames")
								.toString().split(",");
						for (int count = valueArr.length; count > 0; count--) {
							if (crsObjUmpireData.getString("selected")
									.equalsIgnoreCase("" + count)) {
%>					 <label style="color: black;white-space:inherit; " ><%=valueArr[count - 1]%></label> <%
							}
						}
					} 
%>				</td>
				<td>
<% 				  if (crsObjUmpireData.getString("remark") != null) {
%>					<span><%=crsObjUmpireData.getString("remark")%></span>
				<%} else {%><span></span>
				<%}	%>
				</td>
					
				
		</TR>
		<%}%>
		<input type="hidden" name="ids" value="<%=ids%>"></input>
	</table>
	<BR>
<%--	</FIELDSET>--%>


NOTE : Please enter maximum 500 characters for remark.
<br>
<br>
<center><INPUT type="hidden" id="hid" name="hid" /> 
	<%if(!(userRole.equals("9"))){%>
<INPUT
	type="button" value="Submit" onclick="validate()" /> <input
	type="hidden" id="hidden_ids" name="hidden_ids" value="<%=sbIds%>" />
	<%}%>
</center>
<br>
	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td>
				<jsp:include page="admin/Footer.jsp"></jsp:include>
			</td>
		</tr>
	</table>
</FORM>
</div>
</td>
</tr>
</table>
</body>

</html>
<%
		} catch (SQLException e) {
			System.out.println(e.toString());
			e.printStackTrace();
			//throw e;
		} catch (Exception e) {
			System.out.println(e.toString());
			e.printStackTrace();
			//throw e;
		}
%>
