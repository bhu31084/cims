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
<%  CachedRowSet crsObjMatchDetails			             = null;
	Vector vparam = new Vector();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
%>
<%
	String season = "";
	String team = "";
	String position = "";
	String playerId = "";
	String playerName = "";
	String matchBetween = "";
	String teamOne	= "";
	String teamTwo = "";
	String hid = "";
	String[] playerIdArray = null;
	String[] playerNameArray = null;
	String[] teamArr = null;
	int counter = 0;
%>
<%
	season = request.getParameter("season")!=null?request.getParameter("season"):"";
	playerId = request.getParameter("playerId")!=null?request.getParameter("playerId"):"";
	team = request.getParameter("team")!=null?request.getParameter("team"):"";
	//System.out.println("team++++++++++++++++++++++++++" +team);
%>
<% 
	// To get session
	try
	{
		vparam.add(playerId);	
		vparam.add(season);	
		crsObjMatchDetails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_openingruns_details",vparam,"ScoreDB");
		vparam.removeAllElements();	
	}
	catch(Exception e)
	{
		System.out.println("Exception 1" +e.getMessage());
	}
%>
<html>
	<head>
	</head>
	<body>
			<table width=100% align=center border=1>
				<tr class="contentDark">
					<td align=center>Match Between</td>
					<td align=center>Date</td>
					<td align=center>Venue</td>
					<td align=center>Series</td>
					<td align=center>Runs</td>
				</tr>
<% 
	try
	{
		if (crsObjMatchDetails!=null)
		{
				while (crsObjMatchDetails.next())
				{
					matchBetween = crsObjMatchDetails.getString("matchbtwn");	
					teamArr =  matchBetween.split("vs");
					if (teamArr!=null)
					{
						teamOne = teamArr[0].trim();
						teamTwo = teamArr[1].trim();
					}
					if (!team.equalsIgnoreCase("All"))
					{
						if (team.equalsIgnoreCase(teamOne))
						{
							matchBetween = team+" "+"vs"+" "+teamTwo;
						}
						else
						{
							matchBetween = team+" "+"vs"+" "+teamOne;
						}
					}
					if(counter % 2 != 0){			 			
%>						<tr class="contentDark">
<%					}else{
%>						<tr class="contentLight">
<%
					}
%>
						<td align=left><%=matchBetween%></td>
						<td align=left><%=crsObjMatchDetails.getString("matchstart")!=null?crsObjMatchDetails.getString("matchstart").substring(0,10):""%></td>
						<td align=left><%=crsObjMatchDetails.getString("venue")!=null?crsObjMatchDetails.getString("venue"):""%></td>
						<td align=left><%=crsObjMatchDetails.getString("series")!=null?crsObjMatchDetails.getString("series"):""%></td>
						<td align=right><%=crsObjMatchDetails.getString("runs")!=null?crsObjMatchDetails.getString("runs"):""%></td>
					</tr>
<%				counter++;	
				}
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception 1" +e.getMessage());
	}
%>
			</table>
	</body>
</html>
