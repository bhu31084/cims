<!--
	Created Date : 13th Nov 2008
	Description  : Player Career Report 
	Company 	 : Paramatrix Tech Pvt Ltd.
	Modified by  : Vaibhavg (Added link  from TopPerformer to this page)  
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet,
            in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
            java.util.*"
%>
<%  response.setHeader("Pragma", "private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<%  CachedRowSet crsObjSeason			             = null;
	CachedRowSet crsObjTeams				         = null;
	CachedRowSet crsObjBatting				         = null;
	CachedRowSet crsObjRuns							 = null;
	CachedRowSet crsObjAssociationRecord			 = null;
	CachedRowSet crsObjBatsmanWktTypeStaistics       = null;
	CachedRowSet crsObjBowlerWktTypeStaistics        = null;
	Vector vparam = new Vector();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
%>
<%
	String season = "";
	String team = "";
	String position = "";
	String playerId = "";
	String playerName = "";
	String hid = "";
	String[] playerIdArray = new String[100];
	String[] playerNameArray = new String[100];
	int counter = 0;

%>
<%  hid = request.getParameter("hid");
	try
	{
		//System.out.println("hid" +hid);
		if (hid!=null && hid.equalsIgnoreCase("1"))
		{
			season = request.getParameter("selSeason");
			team = request.getParameter("selTeam");
			if (team.equalsIgnoreCase("0"))
			{
				team = "";
			}
			position = request.getParameter("selPosition");
			vparam.add(season);	
			vparam.add(team);	
			vparam.add(position);	
			crsObjBatting = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_positionwise_batsmanlist",vparam,"ScoreDB");		
			vparam.removeAllElements();	
			if (crsObjBatting!=null)
			{
				while (crsObjBatting.next())
				{
						playerId = playerId + crsObjBatting.getString("userid") + "~";
						playerName = playerName + crsObjBatting.getString("playername") + "~";
				}
			
			}
			if (playerId!=null)
			{
				playerIdArray = playerId.split("~");
			}
			if (playerName!=null)
			{
				playerNameArray = playerName.split("~")	;
			}
		}
	}
	catch(Exception e)
	{
		System.out.println("Excception 3" +e.getMessage());
	}
	
	
%>
<% 
	// To get session
	try
	{
		vparam.add("1");	
		crsObjSeason = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_season",vparam,"ScoreDB");		
		vparam.removeAllElements();	
	}
	catch(Exception e)
	{
		System.out.println("Exception 1" +e.getMessage());
	}
%>
<% 
	// To get teams
	try
	{
		vparam.add("1");	
		crsObjTeams = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_team_ms",vparam,"ScoreDB");		
		vparam.removeAllElements();	
	}
	catch(Exception e)
	{
		System.out.println("Exception 2" +e.getMessage());
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
			<script language="JavaScript" src="../js/datetimepicker.js" type="text/javascript"></script>
			<script language="JavaScript" src="../js/sortable.js" type="text/javascript"></script>
			<script>
					function positionWiseBatsman()
					{
						if (document.getElementById("selTeam").value == "0")
						{
							document.getElementById("hid").value=2;
						}
						else
						{
							document.getElementById("hid").value=1;
						}
							document.frmPositionWiseReport.submit();
					}

					function showDetail(playerid,season)
					{
						callBatsRuns(playerid,season);
					}

					function GetXmlHttpObject()
					{
						var xmlHttp=null;
						try
						{
							xmlHttp=new XMLHttpRequest();
						}
						catch (e)
						{
							// Internet Explorer
							try
							{
								xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
							}
							catch (e)
							{
								xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
							}
						}
						return xmlHttp;
					}

					// Getting Data for TeamOne Batting	 
					function callBatsRuns(playerid,season)
					{
						var eleObjArr=document.getElementById('selTeam').options;
						for(var i=0;i< eleObjArr.length;i++){
						if(eleObjArr[i].selected){
								var team = eleObjArr[i].text
							}
						}
						if(document.getElementById(playerid).style.display=='none')
						{
							xmlHttp=GetXmlHttpObject();
							if (xmlHttp==null)
							{
								alert ("Browser does not support HTTP Request") ;
								return;
							}
							else
							{
								var url="/cims/jsp/BatsmanReport.jsp?playerId="+playerid + "&season="+season + "&team="+team;
								//xmlHttp.onreadystatechange=stateChangedLAS1;
								xmlHttp.open("get",url,false);
								xmlHttp.send(null);
								if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
								{
									var responseResult= xmlHttp.responseText ;
									document.getElementById(playerid).style.display='';
									document.getElementById(playerid).innerHTML = responseResult;
									document.getElementById("plusImage"+playerid).src = "../images/minus.jpg";
									//document.getElementById(playerid).scrollIntoView(true);
                                   
								}
							}
						}
						else
						{
							document.getElementById(playerid).style.display='none';
                       	    document.getElementById("plusImage"+playerid).src = "../images/plusdiv.jpg";
						}
					}
                
					function stateChangedLAS1()
					{
					}

					function scoreCard(matchid)
					{
						//alert(matchid)
						document.frmPositionWiseReport.action = "/cims/jsp/TeamScoreDetails.jsp?matchId="+matchid;
						document.frmPositionWiseReport.submit();
					}
			</script>
	</head>
	<body>
		<jsp:include page="Menu.jsp" />
		<form name="frmPositionWiseReport" name="frmPositionWiseReport" method="post">
		<input type=hidden name=hid id=hid value=""/>
		<br>
 		<br>
 		<table width="90%" border="0" align="center" cellpadding="2"
			cellspacing="1" class="table">
				<tr>
					<td colspan="10"  bgcolor="#FFFFFF" class="legend" >
						Top Opening
					</td>
				</tr>
		<table>	
		<div>
			<table width=90% border=1 align=center>
					<tr class="contentDark">
						<td>
							Select Position:
							<select id="selPosition" name="selPosition">
								<option value="1">Opening</option>
							</select>
						</td>
						<td>
							Select Season:
							<select id="selSeason" name="selSeason">
<%	
	try
	{
		if(crsObjSeason!=null)
		{
				while(crsObjSeason.next())
				{
%>					<option value="<%=crsObjSeason.getString("id")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>
<%				}
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception 1" +e.getMessage());
	}
%>
							</select>
						</td>
						<td>
							Select Team:
							<select id="selTeam" name="selTeam">
								<option value="0">All</option>
<%
	try
	{
		if (crsObjTeams!=null)		
		{
				while (crsObjTeams.next())
				{
%>
				<option value="<%=crsObjTeams.getString("id")%>" <%=team.equalsIgnoreCase(crsObjTeams.getString("id"))?"selected":""%>><%=crsObjTeams.getString("team_name")%></option>
<%		
				}
		}
	}
	catch(Exception e)
	{
	}
%>
							</select>
						</td>
						<td><input type=button name="Show" value="Show" class="button1" onclick="positionWiseBatsman()"></td>
					</tr>
			</table>
			<BR>

			
<%
	if (hid!=null && hid.equalsIgnoreCase("1"))
	{
%>
	
		<table width=90% align=center border=1 cellpadding=5px>
				<tr class="contentDark">
					<td align=center>Player Name</td>
					<td align=center>Total Runs</td>
				</tr>
<% 
		crsObjBatting.beforeFirst();
		if (crsObjBatting!=null)
		{
			for (int i=0;i<playerIdArray.length;i++)
			{
				vparam.add(playerIdArray[i]);	
				vparam.add(season);
				crsObjRuns = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_opening_runs_forplayer",vparam,"ScoreDB");		
				vparam.removeAllElements();	
				while (crsObjRuns.next())
				{
					if(counter % 2 != 0){			 			
%>						<tr class="contentDark">
<%					}else{
%>						<tr class="contentLight">
<%
					}
%>

					    <td align=left>
						<a href="javascript:showDetail('<%=playerIdArray[i]%>','<%=season%>')">
						<IMG title="Click On + To Get The Details." height="10px" alt="" 	src="../images/plusdiv.jpg" id="plusImage<%=playerIdArray[i]%>"/></a>
						<%=playerNameArray[i]%>
						</td>
						<td align=right><%=crsObjRuns.getString("runs")%></td>
					</tr>
					<tr>
						<td  colspan=2>
							<div  id="<%=playerIdArray[i]%>" name="<%=playerIdArray[i]%>" style="display:none">
							</div>
						</td>
					</tr>
					
<%					counter ++;
				}
			}
		}
	  }

%>
<%
	if (hid!=null && hid.equalsIgnoreCase("2"))
	{
%>
		<table width=90% align=center border=1 cellpadding=5px>
				<tr class="contentDark">
					<td align=center>Player Name</td>
					<td align=center>Total Runs</td>
				</tr>
<%			crsObjBatting = null;
			season = request.getParameter("selSeason");
			team = request.getParameter("selTeam");
			if (team.equalsIgnoreCase("0"))
			{
				team = "";
			}
			position = request.getParameter("selPosition");
			vparam.add(season);	
			vparam.add(team);	
			vparam.add(position);	
			crsObjBatting = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_positionwise_batsmanlist",vparam,"ScoreDB");		
			vparam.removeAllElements();	
			if (crsObjBatting!=null)
			{
				while (crsObjBatting.next())
				{
					if(counter % 2 != 0){			 			
%>						<tr class="contentDark">
<%					}else{
%>						<tr class="contentLight">
<%
					}
%>

					    <td align=left>
						<a href="javascript:showDetail('<%=crsObjBatting.getString("userid")%>','<%=season%>')">
						<IMG title="Click On + To Get The Details." height="10px" alt="" 	src="../images/plusdiv.jpg" id="plusImage<%=crsObjBatting.getString("userid")%>"/></a>
						<%=crsObjBatting.getString("playername")%>
						</td>
						<td align=right><%=crsObjBatting.getString("runs")%></td>
					</tr>
					<tr>
						<td  colspan=2>
							<div  id="<%=crsObjBatting.getString("userid")%>" name="<%=crsObjBatting.getString("userid")%>" style="display:none">
							</div>
						</td>
					</tr>
					
<%					
				counter ++;
				}
			}
		}	
%>
			</table>
		</div>
		</form>
		<br>
		<br>
		<br>
		<br><br><br><br>
		<br>
		<br>
		<br><br><br>
		<table width="1000" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<tr>
			<td>
				<jsp:include page="admin/Footer.jsp"></jsp:include>
			</td>
		</tr>
	</table>
	</body>
</html>