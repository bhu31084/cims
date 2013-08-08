<!--
	Author 		 : Saudagar Mulik
	Created Date : 02/09/2008
	Description  : Umpire coach report.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="java.util.*"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
		String report_id = "2";
		String role = "2"; //For umpire

		String match_id = session.getAttribute("matchid").toString();
		String loginUserName = session.getAttribute("username").toString();
		String user_role = session.getAttribute("role").toString();
		String user_id = session.getAttribute("userid").toString();

		// This are some data format object to represent date in different 
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MM-dd hh:mm:ss");
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd");
		java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
				"yyyy-MMM-dd hh:mm");

		// DIfferent variables and object declarations.		
		Vector<String> vparam = new Vector<String>();
		Vector<String> ids = new Vector<String>();

		String match_type = "";
		String venue = "";
		String colleague = "";
		String versus = "";
		String strDate = "";
		String matchType = null;
		String umpire_name = null;
		String umpire_id = null;

		String umpire_user_id = null;

		LogWriter log = new LogWriter(match_id);

		StringBuffer sbIds = new StringBuffer();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(
				match_id);

		CachedRowSet crsObjUmpires = null;
		CachedRowSet crsObjDetails = null;
		CachedRowSet crsObjViewData = null;

		// Variables initializes from the store procedure resultant data.
		vparam.add(match_id);
		crsObjDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_matchdetails", vparam, "ScoreDB");

		if (crsObjDetails.next()) {
			match_type = crsObjDetails.getString("type");
			venue = crsObjDetails.getString("location");
			colleague = crsObjDetails.getString("colleague");
			versus = crsObjDetails.getString("versus");
			strDate = crsObjDetails.getString("start_ts");
		}

		// If page is submitted then hid value is set to 1 and page will entered in if loop.		
		String strObj = "";
		try {
			Date strdate = sdf.parse(strDate);
			strObj = sdf1.format(strdate);
		} catch (Exception e) {
			System.out.println("Date '" + strDate + "' unparsable");
			strObj = "Date not available";
		}

		vparam = new Vector<String>();
		vparam.add(match_id);
		crsObjDetails = null;
		crsObjDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_matchdetails", vparam, "ScoreDB");
		if (crsObjDetails.next()) {
			matchType = crsObjDetails.getString("type");
		}

		if (user_role.equals("9")) {
			System.out.println("Role is admin");
			vparam = new Vector<String>();
			vparam.add(match_id);
			vparam.add(role);
			crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getMatchConcerns", vparam, "ScoreDB");

			if (request.getParameter("hid") != null) {
				umpire_user_id = request.getParameter("hid");
			}

		}
%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/trim.js"></script>
<script>
	function validate(){
		var str = document.getElementById('hidden_ids').value.split(",");
		var errorArray = new Array(str.length);
		var isComplete = true;
		for(var count = 0; count < str.length; count = count + 2){
			if(str[count+1] == "Y" && document.getElementById(str[count]).value == 0){
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
	
	function DisplayReport(){
		document.getElementById("hid").value = document.frmcoatchreport.umpire.value;
		document.frmcoatchreport.submit();
	}
</script>
<title>Umpires Self Assessment Report</title>

</head>

<body>
<jsp:include page="Menu.jsp"></jsp:include>

<FORM action="/cims/jsp/UmpireSelfAssesment.jsp" method="post"
	name="frmcoatchreport">
<br>
<br>
<br>
<table width="780" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
	<tr>
		<td colspan="9" bgcolor="#FFFFFF" class="legend">Umpires Self Assessment Report</td>
	</tr>
	<tr>
		<td colspan="2" width="90%" class="contentDark" align="right"><b><%=loginUserName%>&nbsp;&nbsp;&nbsp;DATE :</b> <%=sdf1.format(new Date())%></td>
	</tr>


<%--
	First field set. 
	This field set contains one table that is used to display match detail from database.
--%>



	<tr class="contentLight">
		<TD width="15%"><font size="2"><b>Umpire</b></font></TD>
		<%if (user_role.equals("9")) {
			%>
		<TD  id="umpire" name="umpire"><SELECT name="umpire"
			onchange="DisplayReport()">
			<%String temp = "";
			boolean flag = true;
			while (crsObjViewData.next()) {
				if (crsObjViewData.getString("id").equals(umpire_user_id)) {%>
			<option selected="selected"
				value="<%=crsObjViewData.getString("id")%>"><%=crsObjViewData.getString("name")%></option>
			<%
					umpire_user_id = crsObjViewData.getString("id");
					temp = crsObjViewData.getString("id");
				} else {%>
			<option value="<%=crsObjViewData.getString("id")%>"><%=crsObjViewData.getString("name")%></option>
			<%}
				
				if (flag) {
					temp = crsObjViewData.getString("id");
					flag = false;
				}
			}
			umpire_user_id = temp;
		%>
		</SELECT></TD>
		<%} else {%>
		<TD  width="15%" id="umpire" name="umpire"><%=umpire_name%> <INPUT
			type="hidden" name="umpire" value="<%=umpire_id%>"></TD>
		<%}%>
	</TR>
	<tr class="contentDark">
		<TD width="15%"><font size="2"><b>Match</b></TD>
		<TD ><%= match_type%></TD>
	</TR>
	<TR>
		<TD width="15%"><font size="2"><b>Venue</b></TD>
		<TD ><%= venue%></TD>
	</TR>
	<tr class="contentDark">
		<TD width="15%"><font size="2"><b>Colleague</b></TD>
		<TD ><%= colleague%></TD>
	</TR>
	<TR>
		<TD width="15%"><font size="2"><b>Versus</b></TD>
		<TD ><%= versus%></TD>
	</TR>
	<tr class="contentDark">
		<TD width="15%"><font size="2"><b>Date</b></TD>
		<TD ><%= strObj%></TD>
	</TR>
	<TR>
		<TD width="25%"><font size="2"><b>Name of the Tournament</b></TD>
		<TD >Tournament</TD>
	</TR>
</table>
<br>
<br>

<%
		if (user_role.equals("9")) {

			vparam = new Vector<String>();
			vparam.add(match_id);
			vparam.add(umpire_user_id);
			crsObjUmpires = null;
			crsObjUmpires = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getmatchofficialid_umpire", vparam, "ScoreDB");

			if (crsObjUmpires.next()) {
				umpire_name = crsObjUmpires.getString("name");
				umpire_id = crsObjUmpires.getString("official");
			}

			vparam = new Vector<String>();
			vparam.add(match_id);
			vparam.add(umpire_user_id);
			vparam.add(umpire_id);
			vparam.add(report_id);
			crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_umpirereports", vparam, "ScoreDB");

			%> <%--
	Second fieldset
	This fieldset contain one table which was used to display point and rating values for feed back.
	Each and every table data comes from database.
--%>

<table width="780" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
	<%
	int counter = 1;
	while (crsObjViewData.next()) {
	
				if(counter % 2 != 0){	
%>			<tr class="contentDark">
<%				}else{
%>			<tr class="contentLight">
<%				}
%>	
		<TD><b><%=counter++%>. <%=crsObjViewData.getString("description")%></b></TD>
		<TD><%
				if (crsObjViewData.getString("scoring_required")
						.equalsIgnoreCase("Y")) {
					String[] strArr = crsObjViewData.getString("cnames")
							.toString().split(",");
					int length = Integer.parseInt(crsObjViewData.getString(
							"score_max").toString());%> <%
					int selectedVal = Integer.parseInt(crsObjViewData
							.getString("selected")) - 1;
					for (int count = length - 1; count >= 0; count--) {
						if (strArr.length > count) {
							if (selectedVal == count) {%> <LABEL><%=strArr[count]%></LABEL> <%}
						}
					}
				} else {
					if (crsObjViewData.getString("remark") != null) {
						%> <TEXTAREA class="textArea"
			disabled="disabled" id="<%=crsObjViewData.getString("id")%>"
			name="<%=crsObjViewData.getString("id")%>" maxlength="255"><%=crsObjViewData.getString("remark").trim()%></TEXTAREA>
		<%} else {%> <TEXTAREA disabled="disabled"
			id="<%=crsObjViewData.getString("id")%>"
			name="<%=crsObjViewData.getString("id")%>" maxlength="255"></TEXTAREA>
		<%}
				}%></TD>
	</TR>
	<%}%>
	<input type="hidden" name="ids" value="<%=ids%>"></input>
</table>
<BR>



<%} else {

			if (request.getParameter("hid") != null
					&& request.getParameter("hid").equalsIgnoreCase("1")) {
				String[] retrieve_ids = request.getParameter("hidden_ids")
						.split(",");
				int retrieve_ids_length = retrieve_ids.length;

				umpire_id = request.getParameter("umpire");

				for (int count = 0; count < retrieve_ids_length; count = count + 2) {
					vparam = new Vector<String>();
					vparam.add(match_id);
					vparam.add(user_id);
					vparam.add(umpire_id);
					vparam.add(retrieve_ids[count]);
					if (retrieve_ids[count + 1].equalsIgnoreCase("Y")) {
						vparam.add(request.getParameter(retrieve_ids[count]));
						vparam.add("");
					} else if (retrieve_ids[count + 1].equalsIgnoreCase("N")) {
						vparam.add("0");
						vparam.add(request.getParameter(retrieve_ids[count]));
					}
					vparam.add(report_id);

					lobjGenerateProc.GenerateStoreProcedure(
							"esp_amd_userappraisal", vparam, "ScoreDB");
				}
			}
			vparam = new Vector<String>();
			vparam.add(match_id);
			vparam.add(user_id);
			crsObjUmpires = null;
			crsObjUmpires = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getmatchofficialid_umpire", vparam, "ScoreDB");

			if (crsObjUmpires.next()) {
				umpire_name = crsObjUmpires.getString("name");
				umpire_id = crsObjUmpires.getString("official");
			}

			vparam = new Vector<String>();
			vparam.add(match_id);
			vparam.add(user_id);
			vparam.add(umpire_id);
			vparam.add(report_id);
			crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_umpirereports", vparam, "ScoreDB");
%> <%--
	Second fieldset
	This fieldset contain one table which was used to display point and rating values for feed back.
	Each and every table data comes from database.
--%>
<FIELDSET dir="ltr"><LEGEND title="Rating" align="top"><font size="3"
	color="#003399"><b>Rating</b></font></LEGEND>
<table border=1 width=75% cellspacing="0" cellpadding="5" align="center">
	<%while (crsObjViewData.next()) {

				sbIds.append(crsObjViewData.getString("id"));
				sbIds.append(",");
				sbIds.append(crsObjViewData.getString("scoring_required"));
				sbIds.append(",");

				ids.add(crsObjViewData.getString("id"));
				ids.add(crsObjViewData.getString("scoring_required"));
				%>

	<TR>
		<TD><b><%=crsObjViewData.getString("description")%></b></TD>
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

			<%
					int selectedVal = Integer.parseInt(crsObjViewData
							.getString("selected")) - 1;

					for (int count = length - 1; count >= 0; count--) {
						if (strArr.length > count) {
							if (selectedVal == count) {%>
			<OPTION value="<%=(count+1)%>" selected="selected"><%=strArr[count]%></option>
			<%} else {%>
			<OPTION value="<%=(count+1)%>"><%=strArr[count]%></option>
			<%}
						} else {
							if (selectedVal == count) {%>
			<OPTION value="<%=count+1%>" selected="selected"><%=count + 1%></option>
			<%} else {%>
			<OPTION value="<%=count+1%>"><%=count + 1%></option>
			<%}%>
			<OPTION value="<%=count+1%>"><%=count + 1%></option>
			<%}
					}%>
		</SELECT> <%} else {
					if (crsObjViewData.getString("remark") != null) {%> <TEXTAREA
			id="<%=crsObjViewData.getString("id")%>"
			name="<%=crsObjViewData.getString("id")%>" maxlength="255"><%=crsObjViewData.getString("remark").trim()%></TEXTAREA>
		<%} else {%> <TEXTAREA id="<%=crsObjViewData.getString("id")%>"
			name="<%=crsObjViewData.getString("id")%>" maxlength="255"></TEXTAREA>
		<%}
				}%></TD>
	</TR>
	<%}%>
	<input type="hidden" name="ids" value="<%=ids%>"></input>
</table>
<BR>

</FIELDSET>
<center><INPUT type="button" value="submit" onclick="validate()" /> <INPUT
	type="hidden" id="hidden_ids" name="hidden_ids" value="<%=sbIds%>" />
<%}%> <BR>
<INPUT type="hidden" id="hid" name="hid" />
</FORM>
</body>
</html>

