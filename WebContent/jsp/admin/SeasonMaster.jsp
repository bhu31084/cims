<!--
Page Name: AppealMaster.jsp
Author 		 :Swapnilg
Created Date : 6 oct 2008
Description  : Entry of appeal type 
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page
	import="in.co.paramatrix.common.validator.DataValidator,in.co.paramatrix.common.exceptions.NoEntity,in.co.paramatrix.common.exceptions.InvalidEntity"%>

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
	CachedRowSet crsObjWeather = null;
	CachedRowSet crsObjweathercombo = null;
	Vector vparam = new Vector();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	String serverMessage = null;

	try {

		if (request.getParameter("hdSubmit") != null
				&& request.getParameter("hdSubmit").equals("submit")) {
			/*For insertion of record in database.*/
			String gsResultId = null;
			if (request.getParameter("hditemlist").equals("")) {
				gsResultId = null;
			} else {
				gsResultId = request.getParameter("hditemlist");
			}

			String gsweatherName = request
					.getParameter("txtappealname");
			String flag = request.getParameter("hiddenval");
			String checkbox = request.getParameter("seriescheck");
			System.out.println("gsweatherName " + gsweatherName);

			System.out.println("flag " + checkbox);

			vparam.add(gsResultId);//
			vparam.add(gsweatherName);//
			vparam.add(checkbox);//
			vparam.add(request.getParameter("hiddenval"));
			crsObjWeather = lobjGenerateProc.GenerateStoreProcedure(
					"esp_amd_seasonsmst", vparam, "ScoreDB");
			vparam.removeAllElements();

		}
		vparam.add("0");
		crsObjweathercombo = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_seasonsearch", vparam, "ScoreDB");
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<html>
<head>
<title>Season Master</title>
<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js"
	type="text/javascript"></script>
<script>
    var xmlHttp=null;
	function callNextPage(id){
    		document.getElementById('hdSubmit').value = "submit";
	document.getElementById('hiddenval').value = id;
		document.frmseason.action = "/cims/jsp/admin/SeasonMaster.jsp";

		if (id == "D" && document.getElementById('hditemlist').value != "") {

			var deleteconfirm = confirm("Do you want to delete the record.")
			if (deleteconfirm) {
				document.frmseason.submit();
			} else {
				return false
			}

		}
		if (id == "A") {
			document.frmseason.submit();
		}
	}

	function textValidate() {
		var resulttxt = document.getElementById('txtappealname').value;
		var resultdesc = document.getElementById('txtappealdesc').value;
		var alphaExp1 = /^[a-zA-Z ]+$/;

		if (resulttxt.match(alphaExp1)) {

			if (resultdesc != "") {
				return true;
			} else {
				alert("Enter some Description ");
				return false;
			}

		} else {

			if (resulttxt == "") {
				if (resulttxt == "" && resultdesc == "") {
					alert("Enter All Records");
				} else {
					alert("Enter Appeal Name");
				}
			} else {
				alert("Appeal should contain alphabets ");
				return false;
			}

		}
	}

	function cancellation() {
		document.getElementById("resultsearchtxt").value = "";
		document.getElementById("itemlist").value = "";
		document.getElementById("hditemlist").value = "";
		document.getElementById("editRolediv7").style.display = "none";
		document.getElementById('txtappealname').value = "";
		document.getElementById('txtappealdesc').value = "";
		document.frmseason.action = "MasterWeathertype.jsp";
	}

	function GetXmlHttpObject() {
		try {
			//Firefox, Opera 8.0+, Safari
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			// Internet Explorer
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}

	function displayData() {
		if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
			var responseResult = xmlHttp.responseText;
			try //Internet Explorer
			{
				xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
				xmlDoc.async = "false";
				xmlDoc.loadXML(responseResult);
				var mess = responseResult.split("<br>");
				document.getElementById("txtappealname").value = mess[1]//xmlDoc.getElementsByTagName("Name")[0].childNodes[0].nodeValue;            
			} catch (e) {
				try //Firefox, Mozilla, Opera, etc.
				{
					parser = new DOMParser();
					xmlDoc = parser.parseFromString(text, "text/xml");

				} catch (e) {
					alert(e.message)
				}
			}
		}

	}

	function SelObj(formname, selname, textname, str) {
		this.formname = formname;
		this.selname = selname;
		this.textname = textname;
		this.select_str = str || '';
		this.selectArr = new Array();
		this.initialize = initialize;
		this.bldInitial = bldInitial;
		this.bldUpdate = bldUpdate;
	}
	function initialize() {
		if (this.select_str == '') {
			for ( var i = 0; i < document.forms[this.formname][this.selname].options.length; i++) {
				this.selectArr[i] = document.forms[this.formname][this.selname].options[i];
				this.select_str += document.forms[this.formname][this.selname].options[i].value
						+ ":"
						+ document.forms[this.formname][this.selname].options[i].text
						+ ",";
			}
		} else {
			var tempArr = this.select_str.split(',');
			for ( var i = 0; i < tempArr.length; i++) {
				var prop = tempArr[i].split(':');
				this.selectArr[i] = new Option(prop[1], prop[0]);
			}
		}
		return;
	}
	function bldInitial() {
		this.initialize();
		for ( var i = 0; i < this.selectArr.length; i++)
			document.forms[this.formname][this.selname].options[i] = this.selectArr[i];
		document.forms[this.formname][this.selname].options.length = this.selectArr.length;
		return;
	}

	function bldUpdate(event) {
		var str = document.forms[this.formname][this.textname].value.replace(
				'^\\s*', '');
		// If there is an empty String, don't search (hide list)
		if (str == '') {
			this.bldInitial();
			hideList();
			return;
		}
		this.initialize();
		// Show List as User Types
		showList(event);
		var j = 0;
		str = str.replace("(", "");
		str = str.replace(")", "");
		pattern1 = new RegExp("^" + str, "i");
		for ( var i = 0; i < this.selectArr.length; i++)
			if (pattern1.test(this.selectArr[i].text))
				document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
		document.forms[this.formname][this.selname].options.length = j;

		// If none of the options in the list meet the user's input, close list
		if (j == 0) {
			hideList();
		}
		if (event.keyCode == 40) {
			selected("itemlist");
		}
	}

	function selected(obj) {
		var eleObjArr1 = document.getElementById(obj).options;
		if (eleObjArr1.length >= 1) {
			eleObjArr1[0].selected = true;
		}
	}

	function setUp() {
		obj1 = new SelObj('frmseason', 'itemlist', 'resultsearchtxt');
		obj1.bldInitial();
	}

	function update(event) {
		if(event.keyCode == 13 || event.keyCode == 0 || event.keyCode == 9 || (event.button && event.button == 0) ){
			document.frmseason.resultsearchtxt.value = document.frmseason.itemlist.options[document.frmseason.itemlist.selectedIndex].text;
			document.getElementById("resultsearchtxt").focus();
			hideList();
			document.frmseason.hditemlist.value = document.frmseason.itemlist.value;
		}else  if (event.keyCode == 27) {
			document.getElementById("lister").style.display = "none";
		}
	}

	function showList(event) {
	      if(event.keyCode == 40)
	      {
	        document.getElementById("lister").style.display="block";
	        document.getElementById("itemlist").focus();
	        }        
	        if(document.getElementById("itemlist").value=="0" ||document.getElementById("itemlist").value==""||event.keyCode == 0)
	        {
	         document.getElementById("lister").style.display="block";
	        }
	        if(event.keyCode == 27){
	         document.getElementById("lister").style.display="none";
	        }
	}
    
	function showListOld(event) {
		if(event.keyCode == 40 || event.button==0){
			document.getElementById("lister").style.display = "block";
			document.getElementById("itemlist").focus();
		}
		if (document.getElementById("itemlist").value == "0"
				|| document.getElementById("itemlist").value == ""
				|| event.keyCode == 0) {
			document.getElementById("lister").style.display = "block";
		}
		if (event.keyCode == 27) {
			document.getElementById("lister").style.display = "none";
		}
	}

	function hideList() {
		document.getElementById("lister").style.display = "none";
		xmlHttp = GetXmlHttpObject();
		var valName = document.frmseason.itemlist.value;
		if (valName != "") {
			var url = "/cims/jsp/admin/seasonsearchcombo.jsp?Appealid=" + valName;
			xmlHttp.open("get", url, false);
			xmlHttp.send(null);
			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
				var responseResult = xmlHttp.responseText;
				try //Internet Explorer
				{
					if (window.ActiveXObject){
						xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
						xmlDoc.async = "false";
						xmlDoc.loadXML(responseResult);
					}else{
						xmlDoc = document.implementation.createDocument("","",null);	
					}
					var mess = responseResult.split("<br>");
					document.getElementById("txtappealname").value = mess[1]//xmlDoc.getElementsByTagName("Name")[0].childNodes[0].nodeValue;            
				} catch (e) {
					try //Firefox, Mozilla, Opera, etc.
					{
						parser = new DOMParser();
						xmlDoc = parser.parseFromString(text, "text/xml");

					} catch (e) {
						alert(e.message)
					}
				}
			}
		}
	}

	function changeList(event) {
		if (document.getElementById("lister").style.display == "none"){
			showList(event);
		} else{
			hideList();
		}		
	}
	function changeColour(which) {
		if (which.value.length > 0) {   // minimum 2 characters
			which.style.background = "#FFFFFF"; // white
		}
		else {
			which.style.background = "";  // yellow
		}
	}
</script>
</head>

<body  style="height: 100%" OnLoad="javascript:setUp()">
<jsp:include page="Menu.jsp"></jsp:include>
<FORM name="frmseason" id="frmseason" method="post"><br>
<br>
<table width="780" border="0" align="center" cellpadding="2"
	cellspacing="1" class="table">
	<tr align="center"> 
		<td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">Season Master</td>
	</tr>
	<tr>
		<td>
		<div id="editRolediv7" style="display: block">
		<%if (crsObjWeather != null) {
				while (crsObjWeather.next()) {%>

		<table width="50%" height="10%" align="center" border="0"
			id="displayResult" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td class="message"><%=crsObjWeather.getString("Retval")%></td>
			</tr>
		</table>
		<%}
			}%>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<fieldset><legend class="legend1">Season Master </legend> <br>
		<table width="90%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
			<%--						search--%>
			<tr align="left" class="contentDark">
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Search</td>
				<td><input class="textBoxAdminSearch" type="text"
					name="resultsearchtxt" 
					id="resultsearchtxt"
					size="20"
					onKeyUp="javascript:obj1.bldUpdate(event);"> <input
					class="button1" id="show" type="button" value="V"
					onClick="changeList(event);">


				<DIV align="left" style="width: 250px">
				<DIV id="lister"
					style="display: none; position: absolute; z-index: +10;"><select
					class="inputsearch" style="width: 4.2cm" id="itemlist"
					name="itemlist" size="5" onclick="update(event)"
					onkeypress="update(event)">

					<%while (crsObjweathercombo.next()) {%>
					<option value="<%=crsObjweathercombo.getString("id")%>"><%=crsObjweathercombo.getString("name")%></option>
					<%}%>

				</select></DIV>
				</DIV>
				</td>

			</tr>


			<%--		search end--%>


			<tr width="90%" class="contentLight">
				<td nowrap="nowrap">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name :</td>
				<td><input type="text" class="textBoxAdmin"
					name="txtappealname" id="txtappealname"
					onfocus="this.style.background = '#FFFFCC'"
					onblur="changeColour(this)"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?()!1234567890');"
					value=""></td>
			</tr>
			<tr align="left" class="contentDark">
				<td nowrap="nowrap">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Create
				Series</td>
				<td><input type="checkbox" value="" id="seriescheck_id"
					name="seriescheck" value="0"></td>
			</tr>
			<tr width="100%" align="right" class="contentLight">
				<td colspan="2" height="24"><input class="button1"
					type="button" id="btnsubmit" name="btnsubmit" value="Submit"
					onclick="callNextPage('A')"> <input class="button1"
					type="button" id="btnCancel" name="btnCancel" value="Reset"
					onclick="cancellation()"> <input class="button1"
					type="button" id="btnDelete" name="btnDelete" value="Delete"
					onclick="callNextPage('D')"> <input type="hidden"
					id="hdSubmit" name="hdSubmit" value=""> <input
					type="hidden" id="hiddenval" name="hiddenval" value=""> <input
					type="hidden" id="hditemlist" name="hditemlist" value=""></td>
			</tr>
		</table>
		<br>
		</fieldset>

		</td>
	</tr>

</TABLE>

<br>
<br>



</form>
</body>

<br>
<br>
<br>
<jsp:include page="Footer.jsp"></jsp:include>
</html>

