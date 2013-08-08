<!--
	Author 				: Saudagar Mulik
	Created Date		: 12/09/2008
	Description 		: Display to show wagon wheel for individual player and should call from Scorer.jsp or ScorerRefresh.jsp
	Company 	 		: Paramatrix Tech Pvt Ltd.
	Modification Date	: 12/09/2008
-->

<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="response/error_page.jsp"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="java.sql.SQLException"%>

<%
		String inning_id = request.getParameter("inningid");
		String player_id = request.getParameter("playerid");

		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		CachedRowSet crsObjViewData = null;

		Vector vparam = new Vector();
		vparam.add(inning_id);
		vparam.add(player_id);
		crsObjViewData = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_fieldpos", vparam, "ScoreDB");

		HashMap hm = new HashMap();
		for (int count = 1; count <= 26; count++) {
			hm.put("" + count, "");
		}
		if (crsObjViewData != null) {
			while (crsObjViewData.next()) {
				hm.put(crsObjViewData.getString("id"), crsObjViewData
						.getString("runs"));
			}
		}
%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">

<title>Wagon wheel</title>

</head>

<body>



<div style="position:absolute; top:0%; left: 0%; border:1"><img
	src="../images/WagonWheel.jpg" width="330" height="500" border="1"
	align="left" /> <BR>

<!--usemap="#scoring_positions"-->
<div style="position:absolute; top:75%; left:48%; border:1;" id="1"
	title="Bowler"><FONT color="white"> <%=hm.get("1")%> </FONT></div>
<div style="position:absolute; top:90%; left:25%; border:1;" id="2"
	title="long_off"><FONT color="white"><%=hm.get("2")%></FONT></div>
<div style="position:absolute; top:72%; left:15%; border:1;" id="3"
	title="dip_mid_off"><FONT color="white"><%=hm.get("3")%></FONT></div>
<div style="position:absolute; top:50%; left:10%; border:1;" id="4"
	title="dip_cover"><FONT color="white"><%=hm.get("4")%></FONT></div>
<div style="position:absolute; top:22%; left:15%; border:1;" id="5"
	title="third_man"><FONT color="white"><%=hm.get("5")%></FONT></div>
<div style="position:absolute; top:40%; left:85%; border:1;" id="6"
	title="Deep_Square_Leg"><FONT color="white"><%=hm.get("6")%></FONT></div>
<div style="position:absolute; top:80%; left:70%; border:1;" id="7"
	title="Deep_Mid_On"><FONT color="white"><%=hm.get("7")%></FONT></div>
<div style="position:absolute; top:90%; left:70%; border:1;" id="8"
	title="Long_On"><FONT color="white"><%=hm.get("8")%></FONT></div>
<div style="position:absolute; top:70%; left:60%; border:1;" id="9"
	title="Mid_On"><FONT color="white"><%=hm.get("9")%></FONT></div>
<div style="position:absolute; top:48%; left:58%; border:1;" id="10"
	title="Silly_Mid_On"><FONT color="white"><%=hm.get("10")%></FONT></div>
<div style="position:absolute; top:52%; left:68%; border:1;" id="11"
	title="Mid_Wicket"><FONT color="white"><%=hm.get("11")%></FONT></div>
<div style="position:absolute; top:70%; left:85%; border:1;" id="12"
	title="Deep_Mid_Wicket"><FONT color="white"><%=hm.get("12")%></FONT></div>
<div style="position:absolute; top:42%; left:62%; border:1;" id="13"
	title="Short_Leg"><FONT color="white"><%=hm.get("13")%></FONT></div>
<div style="position:absolute; top:40%; left:68%; border:1;" id="14"
	title="Square_Leg"><FONT color="white"><%=hm.get("14")%></FONT></div>
<div style="position:absolute; top:32%; left:60%; border:1;" id="15"
	title="Leg_Slip"><FONT color="white"><%=hm.get("15")%></FONT></div>
<div style="position:absolute; top:60%; left:28%; border:1;" id="16"
	title="Mid_Off"><FONT color="white"><%=hm.get("16")%></FONT></div>
<div style="position:absolute; top:48%; left:35%; border:1;" id="17"
	title="Silly_Mid_Off"><FONT color="white"><%=hm.get("17")%></FONT></div>
<div style="position:absolute; top:40%; left:28%; border:1;" id="18"
	title="Point"><FONT color="white"><%=hm.get("18")%></FONT></div>
<div style="position:absolute; top:52%; left:28%; border:1;" id="19"
	title="Extra_Cover"><FONT color="white"><%=hm.get("19")%></FONT></div>
<div style="position:absolute; top:42%; left:37%; border:1;" id="20"
	title="Silly_Point"><FONT color="white"><%=hm.get("20")%></FONT></div>
<div style="position:absolute; top:55%; left:48%; border:1;" id="21"
	title="Silly_Point"><FONT color="white"><%=hm.get("21")%></FONT></div>
<div style="position:absolute; top:15%; left:70%; border:1;" id="22"
	title="Deep_Fine_Leg"><FONT color="white"><%=hm.get("22")%></FONT></div>
<div style="position:absolute; top:33%; left:48%; border:1;" id="23"
	title="Wicket_Keeper"><FONT color="white"><%=hm.get("23")%></FONT></div>
<div style="position:absolute; top:32%; left:35%; border:1;" id="24"
	title="Slips"><FONT color="white"><%=hm.get("24")%></FONT></div>
<div style="position:absolute; top:90%; left:48%; border:1;" id="25"
	title="Straight_Long"><FONT color="white"><%=hm.get("25")%></FONT></div>
<div style="position:absolute; top:15%; left:48%; border:1;" id="26"
	title="Long_Stop"><FONT color="white"><%=hm.get("26")%></FONT></div>

<DIV style="position:absolute; top:100%; left:45%; border:1"><INPUT
	type="button" value="    Close   "  onclick="closePopup('BackgroundDiv','wagondiv')"></DIV>
</div>



</body>
</html>

