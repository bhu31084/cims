<%@ page import="sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*"%>
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
	CachedRowSet team1PlayersCachedRowSet = null;
	CachedRowSet team2PlayersCachedRowSet = null;
	CachedRowSet tempPlayerCachedRowSet = null;
	CachedRowSet matchTempPlayerCachedRowSet = null;
	CachedRowSet inningCachedRowSet = null;
	CachedRowSet crsTeamName = null;
	String suceessMessage="";
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	Vector vparam = new Vector();
	String match = request.getParameter("match");
	String team1 = request.getParameter("team1");
	String team2 = request.getParameter("team2");
	String hidsubmit = request.getParameter("hidsubmit");
	int inning_cnt = 0;
	String[] team1player = request.getParameterValues("team1player");
	String[] team2player = request.getParameterValues("team2player");
	ArrayList<String> temp_player_array =new ArrayList<String>();
	
	String teamp1layerid = "";
	String teamp2layerid = "";
	if (team1player != null) {
		for (String player : team1player) {
			teamp1layerid = teamp1layerid + player + "~";
		}
	}
	if (team2player != null) {
		for (String player2 : team2player) {
			teamp2layerid = teamp2layerid + player2 + "~";
		}
	}

	
	try {
		vparam.add(match);
		inningCachedRowSet = lobjGenerateProc
				.GenerateStoreProcedure(
						"esp_dsp_inningscount", vparam,
						"ScoreDB");
		vparam.removeAllElements();
	} catch (Exception e) {
		e.printStackTrace();
	}
	if (hidsubmit != null && hidsubmit.equalsIgnoreCase("1")) {
		try {
			vparam.add(teamp1layerid);
			vparam.add(teamp2layerid);
			vparam.add(match);
			vparam.add(team1);
			vparam.add(team2);
			tempPlayerCachedRowSet = lobjGenerateProc
					.GenerateStoreProcedure(
							"esp_amd_tempteamplayermap", vparam,
							"ScoreDB");
			vparam.removeAllElements();
			suceessMessage ="Players Assign Successfully For This Match";
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	String team1name = "";
	String team2name = "";

	try {
		vparam.add(team1);
		team1PlayersCachedRowSet = lobjGenerateProc
				.GenerateStoreProcedure("esp_dsp_viewplayer", vparam,
						"ScoreDB");
		vparam.removeAllElements();
	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		vparam.add(team2);
		team2PlayersCachedRowSet = lobjGenerateProc
				.GenerateStoreProcedure("esp_dsp_viewplayer", vparam,
						"ScoreDB");
		vparam.removeAllElements();
	} catch (Exception e) {
		e.printStackTrace();
	}
	try {
		vparam.add(team1);
		crsTeamName = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_teamname", vparam, "ScoreDB");
		vparam.removeAllElements();
		while (crsTeamName.next()) {
			team1name = crsTeamName.getString("team_name");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	try {
		vparam.add(team2);
		crsTeamName = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_teamname", vparam, "ScoreDB");
		vparam.removeAllElements();
		while (crsTeamName.next()) {
			team2name = crsTeamName.getString("team_name");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	try {
		vparam.add(match);
		matchTempPlayerCachedRowSet = lobjGenerateProc
				.GenerateStoreProcedure(
						"esp_dsp_temp_match_team_player_map", vparam,
						"ScoreDB");
		vparam.removeAllElements();
		if (matchTempPlayerCachedRowSet != null) {
			
			while (matchTempPlayerCachedRowSet.next()) {
				temp_player_array.add(matchTempPlayerCachedRowSet.getString("team_player_id"));
			}
		}

	} catch (Exception e) {
		e.printStackTrace();
	}
%>

<html>
<head>
	<title>Player List</title>
	<script>
		function Addplayer(team){
			winhandle = window.open("/cims/jsp/playerAdd.jsp?","playeradd","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth-20)+",height="+(window.screen.availHeight-30));	
			if (winhandle != null){
			   window.opener="";
			   window.close();
			 }  
		}
		function adduser(){
			window.open("/cims/jsp/AddNewPlayer.jsp?","addnewplayer","location=no,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth-20)+",height="+(window.screen.availHeight-20));	
			
		}
		function check_player(){
			if($(".palyer2:checked").length > 16 || $(".palyer1:checked").length > 16){
			  alert("You can select Max 16 players.");		
			  return false;
			}else if($(".palyer1:checked").length <12 || $(".palyer2:checked").length < 12){
				alert("You need to select minimun 12 players.");		
				return false;
			}else{
				return true;
			}		
		}	
		
	</script>
	<link rel="stylesheet" type="text/css" href="/cims/css/styles.css">
	<link rel="stylesheet" type="text/css" href="/cims/css/common.css">
	<link rel="stylesheet" type="text/css" href="/cims/css/stylesheet.css">
	<script language="javascript" src="../js/jquery.js"></script>
</head>
<body>
	<form id="frmPlayerslist" name="frmPlayerslist" method="post">
	<table border="1" width="100%" height="60%" border="1">
		<tr>
			<td colspan="6"><font color="green"><%=suceessMessage %></font></td>
		</tr>
		<tr>
			<td colspan="3" align="center" class="legend">Players for Team <%=team1name%></td>
			<td colspan="3" align="center" class="legend">Players for Team <%=team2name%></td>
		</tr>
		<tr valign="top">
			<td colspan="3">
			<table>
<%
	while (team1PlayersCachedRowSet.next()) {

		boolean tempPlayer = false;
		for(String teamPlayerId :temp_player_array){
			if(team1PlayersCachedRowSet.getString("team_player_id").equalsIgnoreCase(teamPlayerId)){
				tempPlayer = true;
			}
		}
%>			<tr>
				<td><input type="checkbox" name="team1player"  class="palyer1" value="<%=team1PlayersCachedRowSet.getString("team_player_id")%>" <%=(tempPlayer==true) ? "checked" : "" %>></label></td>
				<td><%=team1PlayersCachedRowSet
										.getString("playername")%></td>
				<td><%=team1PlayersCachedRowSet.getString("displayname")%></td>
			</tr>
<%
	}
%>						
			</table>		
			</td>
			<td colspan="3">
			<table>
<%
	while (team2PlayersCachedRowSet.next()) {
		boolean tempPlayer = false;
		for(String teamPlayerId :temp_player_array){
			if(team2PlayersCachedRowSet.getString("team_player_id").equalsIgnoreCase(teamPlayerId)){
				tempPlayer = true;
			}
		}
%>			<tr>
				
				<td><input type="checkbox" name="team2player" class="palyer2" value="<%=team2PlayersCachedRowSet.getString("team_player_id")%>"  <%=(tempPlayer==true) ? "checked" : "" %>></label></td>
				<td><%=team2PlayersCachedRowSet
										.getString("playername")%></td>
				<td><%=team2PlayersCachedRowSet.getString("displayname")%></td>
			</tr>
<%
	}
%>			
			</table>	
			</td>
		</tr>
			<td colspan="6" align="center">
				<% if (inningCachedRowSet.size() < 1){  %>
				<input type="submit" name="btnmatchplayer" id="btnmatchplayerid" value="Assign Players For Match" class="btn btn-warning btn-small" onclick="return check_player();"/>
				<%} %>
				<input type="hidden" name="hidsubmit" id="hidsubmit" value="1" />
				<input type="hidden" name="match" id="match" value="<%=match%>" />

			</td>

			<!-- <td colspan="3" align="center"><input type="button" name="btnaddplayer1" id="btnaddplayer1" value="Add Player" onclick="adduser();"> </td>
			<td colspan="3" align="center"><input type="button" name="btnaddplayer2" id="btnaddplayer2" value="Add Player" onclick="adduser();"></td> -->
		<tr>
			
		</tr>	
	</table>
	</form>	
</body>
	
</html>