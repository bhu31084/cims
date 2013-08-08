<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"%>
<%@ page import="java.io.File,java.io.*,javax.imageio.ImageIO,java.awt.image.BufferedImage"%>
<% 
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
	
    String imgPath = null;
    imgPath = (String)getServletContext().getRealPath("");
    System.out.println("imgPath---" + imgPath);
%>
<%	
	CachedRowSet  matchTeamsCachedRowSet = null;
	CachedRowSet  team1PlayersCachedRowSet = null;
	CachedRowSet  team2PlayersCachedRowSet = null;
	CachedRowSet  crsTeamName = null;
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	Vector 	vparam =  new Vector();
	String match = request.getParameter("match");
	String team1 = "";
	String team2 = "";
	String team1name = "";
	String team2name = "";
	String pStatus = "";
	String isCaptain = "";
	String isWKeeper = "";
	String pname = "";
	String disppname = "";
	String id = "";
	String photoPath = "";
	String useIds = "";
	

	if(request.getParameter("hidId")!=null && request.getParameter("hidId").equals("1")){
		String[] userIdArray = request.getParameter("user_id_arr").split("~");
		for(String userId:userIdArray){
		   if(request.getParameter("chk"+userId)!=null){
			   if(request.getParameter("chk"+userId).equalsIgnoreCase("on")){
				   vparam.removeAllElements();
				   vparam.add("1");
				   vparam.add(userId);
				   crsTeamName = lobjGenerateProc.GenerateStoreProcedure("amd_users_side",vparam,"ScoreDB");
				   vparam.removeAllElements();
					
			   }
		   }
		}
		
	}
	if(request.getParameter("hidId")!=null && request.getParameter("hidId").equalsIgnoreCase("2")){
		String[] userIdArray = request.getParameter("user_id_arr").split("~");
		for(String userId:userIdArray){
		   if(request.getParameter("chk"+userId)!=null){
			   if(request.getParameter("chk"+userId).equalsIgnoreCase("on")){
				   vparam.removeAllElements();
				   vparam.add("2");
				   vparam.add(userId);
				   crsTeamName = lobjGenerateProc.GenerateStoreProcedure("amd_users_side",vparam,"ScoreDB");
				   vparam.removeAllElements();
					
			   }
		   }
		}	
	}
	try{
		vparam.add(match);
		matchTeamsCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchteams",vparam,"ScoreDB");																					
		vparam.removeAllElements();		
	}catch(Exception e){
		e.printStackTrace();
	}
	if(matchTeamsCachedRowSet!= null){
		while(matchTeamsCachedRowSet.next()){
			team1 = matchTeamsCachedRowSet.getString("team1");
			team2 = matchTeamsCachedRowSet.getString("team2");
		}
	}		
	try{
		vparam.add(team1);
		vparam.add(match);	
		team1PlayersCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_viewplayer_selected",vparam,"ScoreDB");																					
		vparam.removeAllElements();		
	}catch(Exception e){
		e.printStackTrace();
	}	
	
	try{
		vparam.add(team2);
		vparam.add(match);
		team2PlayersCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_viewplayer_selected",vparam,"ScoreDB");																					
		vparam.removeAllElements();
	}catch(Exception e){
		e.printStackTrace();
	}

	try{
		vparam.add(team1);
		crsTeamName = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamname",vparam,"ScoreDB");
		vparam.removeAllElements();
		while(crsTeamName.next()){
			team1name = crsTeamName.getString("team_name");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	try{
		vparam.add(team2);
		crsTeamName = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teamname",vparam,"ScoreDB");
		vparam.removeAllElements();
		while(crsTeamName.next()){
			team2name = crsTeamName.getString("team_name");
		}
	}catch(Exception e){
		e.printStackTrace();
	}

%>

<html>
<head>
	<title>Player List</title>
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<script language="JavaScript" src="../js/overlib.js" type="text/javascript"></script>
	
	<script>
      function getImage(divid){
       		var img = document.getElementById('teamone'+divid)
			if(img.style.display == 'none'){
				img.style.display = ''
			}else{
				img.style.display = 'none'
			}
      } 
      
		function closewindow(){
			window.close();
		}
		function getTeam2Image(divid){
			var img = document.getElementById('teamtwo'+divid)
			if(img.style.display == 'none'){
				img.style.display = ''
			}else{
				img.style.display = 'none'
			}
		}

		function updateBatsman(hidvalue){
			document.getElementById("hidId").value = hidvalue;
			document.getElementById("frmPlayerslist").submit();
			
		}	
	</script>
</head>
<body>
	<form id="frmPlayerslist" name="frmPlayerslist" method="post">
	<br>
	<table width="600" border="0" align="center" >
		<tr>
			<td align="center" style="background-color:gainsboro;"><font size="4" color="#003399"><b>Selected Player for The Match</b></font></td>
		</tr>			
	</table>
	<br>
	<br>
	<table border="1" width="100%" border="1">
		<tr class="contentDark">
			<td colspan="3" align="center" ><font color="#003399" size="3"><b>Players for Team <%=team1name%></b></font></td>
			<td colspan="3" align="center" ><font color="#003399" size="3"><b>Players for Team <%=team2name%></b></font></td>
		</tr>
		<tr class="contentLight">
			
			<td colspan="3" valign="top">
			<table width="100%">
<%			

	while(team1PlayersCachedRowSet.next()){
				pStatus = team1PlayersCachedRowSet.getString("player_status");
				pname = team1PlayersCachedRowSet.getString("name");
				disppname = team1PlayersCachedRowSet.getString("dispname");
				id = team1PlayersCachedRowSet.getString("id");
				photoPath = team1PlayersCachedRowSet.getString("photopath");
				useIds = useIds + team1PlayersCachedRowSet.getString("user_id") + "~";
				if(photoPath != null){
					photoPath = photoPath.replace("\\", "/");
					photoPath = "../"+photoPath;
					//System.out.println("   photoPath   "+photoPath);
					
				}
			
%>				<tr>
						<td><input type="checkbox" name="chk<%=team1PlayersCachedRowSet.getString("user_id")%>" id="chk<%=team1PlayersCachedRowSet.getString("user_id")%>" /></td>
<%						if(pStatus.equalsIgnoreCase("2")){%>

						<td>
						<a href="javascript:getImage('<%=id%>')"><b><%=pname%></b></a>
						<input type="hidden" id="hdPath<%=id%>" name="hdPath<%=id%>" value="<%=photoPath%>">
							<div id="teamone<%=id%>" name="teamone<%=id%>" style="display:none;">
								<img src="<%=photoPath%>" width="150px" height="200px">
							</div>
						</td>
						<td><b><%=disppname%></b>(<%=team1PlayersCachedRowSet.getString("bats_side")%>)</td>
						<td><b><font color="#840084">&nbsp;&nbsp;&nbsp;(Twelth Man)</b></td>
<%						}else if(pStatus.equalsIgnoreCase("3")){%>
						<td>
					    <a href="javascript:getImage('<%=id%>')"><b><%=pname%></b></a>
						<input type="hidden" id="hdPath<%=id%>" name="hdPath<%=id%>" value="<%=photoPath%>">
						<div id="teamone<%=id%>" name="teamone<%=id%>" style="display:none">
							<img src="<%=photoPath%>" width="150px" height="200px">
						</div>
						</td>
						<td><b><%=disppname%></b>(<%=team1PlayersCachedRowSet.getString("bats_side")%>)</td>
						<td><b><font color="#840084">&nbsp;&nbsp;&nbsp;(Reserved Player)</b></td>
<%						}else if(pStatus.equalsIgnoreCase("1")){
							if(team1PlayersCachedRowSet.getString("is_captain").endsWith("1") && team1PlayersCachedRowSet.getString("is_wkeeper").endsWith("1")){
%>								<td>
								<a href="javascript:getImage('<%=id%>')"><b><%=pname%></b></a>
								<input type="hidden" id="hdPath<%=id%>" name="hdPath<%=id%>" value="<%=photoPath%>">
									<div id="teamone<%=id%>" name="teamone<%=id%>" style="display:none">
										<img src="<%=photoPath%>" width="150px" height="200px">
									</div>
								</td>
								<td><b><%=disppname%></b>(<%=team1PlayersCachedRowSet.getString("bats_side")%>)</td>
								<td><b><font color="#840084">&nbsp;&nbsp;&nbsp;(Captain)(Wicket Keeper)</b></td>
<%							}else{
							
								if(team1PlayersCachedRowSet.getString("is_captain").endsWith("1")){
%>								<td>
								<a href="javascript:getImage('<%=id%>')"><b><%=pname%></b></a>
								<input type="hidden" id="hdPath<%=id%>" name="hdPath<%=id%>" value="<%=photoPath%>">
									<div id="teamone<%=id%>" name="teamone<%=id%>" style="display:none">
										<img src="<%=photoPath%>" width="150px" height="200px">
									</div>
								</td>
								<td><b><%=disppname%></b>(<%=team1PlayersCachedRowSet.getString("bats_side")%>)</td>
								<td><b><font color="#840084">&nbsp;&nbsp;&nbsp;(Captain)</b></td>
<%								}else if(team1PlayersCachedRowSet.getString("is_wkeeper").endsWith("1")){
%>								<td>
								<a href="javascript:getImage('<%=id%>')"><b><%=pname%></b></a>
								<input type="hidden" id="hdPath<%=id%>" name="hdPath<%=id%>" value="<%=photoPath%>">	
									<div id="teamone<%=id%>" name="teamone<%=id%>" style="display:none">
										<img src="<%=photoPath%>" width="150px" height="200px">
									</div>
								</td>
								<td><b><%=disppname%></b>(<%=team1PlayersCachedRowSet.getString("bats_side")%>)</td>
								<td><b><font color="#840084">&nbsp;&nbsp;&nbsp;(Wicket Keeper)</b></td>
<%								}else{
%>								<td>
								<a href="javascript:getImage('<%=id%>')"><b><%=pname%></b></a>
								<input type="hidden" id="hdPath<%=id%>" name="hdPath<%=id%>" value="<%=photoPath%>">
									<div id="teamone<%=id%>" name="teamone<%=id%>" style="display:none">
										<img src="<%=photoPath%>" width="150px" height="200px">
									</div>
								</td>
								<td><b><%=disppname%></b>(<%=team1PlayersCachedRowSet.getString("bats_side")%>)</td>
<%								}
							}

%>											
<%						}	
%>						
					
				</tr>
<%}%>
			</table>
			</td>
			<td colspan="3" valign="top">
			<table width="100%" >
<%			while(team2PlayersCachedRowSet.next()){
				pStatus = team2PlayersCachedRowSet.getString("player_status");
				pname = team2PlayersCachedRowSet.getString("name");
				disppname = team2PlayersCachedRowSet.getString("dispname");
				id = team2PlayersCachedRowSet.getString("id");
				photoPath = team2PlayersCachedRowSet.getString("photopath");
				useIds =  useIds + team2PlayersCachedRowSet.getString("user_id") + "~";
				if(photoPath != null){
					photoPath = photoPath.replace("\\", "/");
					photoPath = "../"+photoPath;
					//System.out.println("   photoPath   "+photoPath);
				}
				
%>			<tr>
				<td><input type="checkbox" name="chk<%=team2PlayersCachedRowSet.getString("user_id")%>" id="chk<%=team2PlayersCachedRowSet.getString("user_id")%>" /></td>			
<%						if(pStatus.equalsIgnoreCase("2")){%>
						<td>
						<a href="javascript:getTeam2Image('<%=id%>')"><b><%=pname%></b></a>
							<div id="teamtwo<%=id%>" name="teamtwo<%=id%>" style="display:none">
								<img src="<%=photoPath%>" width="150px" height="200px">
							</div>
						</td>
						<td><b><%=disppname%></b>(<%=team2PlayersCachedRowSet.getString("bats_side")%>)</td>
						<td><b><font color="#840084">&nbsp;&nbsp;&nbsp;(Twelth Man)</b></td>
<%						}else if(pStatus.equalsIgnoreCase("3")){%>
						<td>
						<a href="javascript:getTeam2Image('<%=id%>')"><b><%=pname%></b></a>
							<div id="teamtwo<%=id%>" name="teamtwo<%=id%>" style="display:none">
								<img src="../photos/pic1.jpg" width="150px" height="200px">
<%--								<img src="<%=photoPath%>" width="150px" height="200px">--%>
							</div>
						</td>
						<td><b><%=disppname%></b>(<%=team2PlayersCachedRowSet.getString("bats_side")%>)</td>
						<td><b><font color="#840084">&nbsp;&nbsp;&nbsp;(Reserved Player)</b></td>
<%						}else if(pStatus.equalsIgnoreCase("1")){
							if(team2PlayersCachedRowSet.getString("is_captain").endsWith("1") && team2PlayersCachedRowSet.getString("is_wkeeper").endsWith("1")){
%>								<td>
								<a href="javascript:getTeam2Image('<%=id%>')"><b><%=pname%></b></a>
									<div id="teamtwo<%=id%>" name="teamtwo<%=id%>" style="display:none">
										<img src="<%=photoPath%>" width="150px" height="200px">
									</div>
								</td>
								<td><b><%=disppname%></b>(<%=team2PlayersCachedRowSet.getString("bats_side")%>)</td>	
								<td><b><font color="#840084">&nbsp;&nbsp;&nbsp;(Captain)(Wicket Keeper)</b></td>
<%							}else{
							
								if(team2PlayersCachedRowSet.getString("is_captain").endsWith("1")){
%>								<td>
								<a href="javascript:getTeam2Image('<%=id%>')"><b><%=pname%></b></a>
									<div id="teamtwo<%=id%>" name="teamtwo<%=id%>" style="display:none">
										<img src="<%=photoPath%>" width="150px" height="200px">
									</div>
								</td>
								<td><b><%=disppname%></b>(<%=team2PlayersCachedRowSet.getString("bats_side")%>)</td>
								<td><b><font color="#840084">&nbsp;&nbsp;&nbsp;(Captain)</b></td>
<%								}else if(team2PlayersCachedRowSet.getString("is_wkeeper").endsWith("1")){
%>								<td>
								<a href="javascript:getTeam2Image('<%=id%>')"><b><%=pname%></b></a>
									<div id="teamtwo<%=id%>" name="teamtwo<%=id%>" style="display:none">
										<img src="<%=photoPath%>" width="150px" height="200px">
									</div>
								</td>
								<td><b><%=disppname%></b>(<%=team2PlayersCachedRowSet.getString("bats_side")%>)</td>
								<td><b><font color="#840084">&nbsp;&nbsp;&nbsp;(Wicket Keeper)</b></td>
<%								}else{
%>								<td>
								<a href="javascript:getTeam2Image('<%=id%>')"><b><%=pname%></b></a>
									<div id="teamtwo<%=id%>" name="teamtwo<%=id%>" style="display:none">
										<img src="<%=photoPath%>" width="150px" height="200px">
									</div>
								</td>
								<td><b><%=disppname%></b>(<%=team2PlayersCachedRowSet.getString("bats_side")%>)</td>
<%								}
							}					
						}	
%>								
				</td>
			</tr>
<%}%>
			</table>
			</td>
		</tr>
		<tr class="contentDark">
			<td colspan="7" align="center">
				<input type="hidden" name="match" id="match" value="<%=match%>" />
				<input type="hidden" name="user_id_arr" id="user_id_arr" value="<%=useIds%>" />
				<input type="hidden" name="hidId" id="hidId" value="0" />
				<input type="button" name="btnLeftHand" id="btnLeftHand" value="Batsman LHS" onclick="updateBatsman('2')"/>
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btnRightHand" id="btnRightHand" value="Batsman RHS" onclick="updateBatsman('1')"/>
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btnLeftHand" id="btnLeftHand" value="Bowler LHS" onclick="updateBatsman('4')"/>
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btnRightHand" id="btnRightHand" value="Bolwer RHS" onclick="updateBatsman('3')"/> 
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btnCancel" id="btnCancel" value="Close" onclick="closewindow()" /></td>
		</tr>
	</table>
	</form>
</body>
</html>