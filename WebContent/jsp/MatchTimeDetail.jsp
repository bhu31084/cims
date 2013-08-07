<!--
	Author 		 		: Vaibhav Gaikar
	Created Date 		: 06/04/2009
	Description  		: To show match time detail
	Company 	 		: Paramatrix Tech Pvt Ltd.
	Created Date		: 06 / 04 / 2009
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<%  String inningId = "";
	String inningStartTime = "";
	String inningEndTime = "";
	String interuptionStartTime = "";
	String interuptionEndTime = "";
	String inningTotalMin = "";
	String matchId  = "";
	String interMissionMinute = "";
	String intermissionStartTime = "";
	String intermissionEndTime = "";
	String batsManId	= "";
	int totalIntermissionMinute = 0;
	int totalInningTime = 0;
	int totalMin = 0;
	int cssCounter = 1;
	Vector vparam = new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	matchId = (String)session.getAttribute("matchid");
	lobjGenerateProc = new GenerateStoreProcedure(matchId);
	LogWriter log =  new LogWriter();
	CachedRowSet matchInningDetailCrs  = null;
	CachedRowSet intermissionDetailCrs = null;
	CachedRowSet batsmanInningDetailCrs = null;
	String flag = "";

%>
<%	flag = request.getParameter("flag")!=null?request.getParameter("flag"):"";
    batsManId = request.getParameter("batsManId")!=null?request.getParameter("batsManId"):"";
	inningId = request.getParameter ("inningId")!=null ? request.getParameter ("inningId"):"" ;
	if (flag.equalsIgnoreCase("1")) // Inning time details
	{
		vparam.add(inningId);
		matchInningDetailCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_inningtimedesc",vparam,"ScoreDB");
		try
		{
			if (matchInningDetailCrs!=null && matchInningDetailCrs.size() > 0)
			{
				while (matchInningDetailCrs.next())	
				{
					inningStartTime = matchInningDetailCrs.getString("start_ts")!=null?matchInningDetailCrs.getString("start_ts").substring(0,16):"0";
					inningEndTime = matchInningDetailCrs.getString("end_ts")!=null?matchInningDetailCrs.getString("end_ts").substring(0,16):"0";
					inningTotalMin = matchInningDetailCrs.getString("total_minutes")!=null?matchInningDetailCrs.getString("total_minutes"):"0";
				}
			}
		}
		catch (Exception e)
		{
			System.out.println("Exception 1" +e.getMessage());
		}
	}

	if (flag.equalsIgnoreCase("2")) // Batsman time details
	{
		vparam.add(batsManId);
		vparam.add(inningId);
		matchInningDetailCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_batterminutes_desc",vparam,"ScoreDB");
		try
		{
			if (matchInningDetailCrs!=null && matchInningDetailCrs.size() > 0)
			{
				while (matchInningDetailCrs.next())	
				{
					inningStartTime = matchInningDetailCrs.getString("play_start_ts")!=null?matchInningDetailCrs.getString("play_start_ts").substring(0,16):"0";
					inningEndTime = matchInningDetailCrs.getString("play_end_ts")!=null?matchInningDetailCrs.getString("play_end_ts").substring(0,16):"0";
					inningTotalMin = matchInningDetailCrs.getString("total_play")!=null?matchInningDetailCrs.getString("total_play"):"0";
				}
			}
		}
		catch (Exception e)
		{
			System.out.println("Exception 1" +e.getMessage());
		}
		vparam.removeAllElements();
		vparam.add(batsManId);
		vparam.add(inningId);
		batsmanInningDetailCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_batsman_inning_time",vparam,"ScoreDB");
	}

	if (inningStartTime.equalsIgnoreCase("1900-01-01 00:00"))
	{
		inningStartTime = "";
	}

	if (inningEndTime.equalsIgnoreCase("1900-01-01 00:00"))
	{
		inningEndTime = "";
	}

	if (inningTotalMin.equalsIgnoreCase(""))
	{
		inningTotalMin = "0";
	}
	
%>
<html>
	<head>
			<title>Match Time Details</title>
<%  response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
			<link href="../css/form.css" rel="stylesheet" type="text/css" />
			<script>
					function closeWindow()
					{
						var windowopener = "";
						window.close();
					}
			</script>
	</head>
	<body>
			<table width=100% border=1 align=center cellspacing=0>
<%  if (flag.equalsIgnoreCase("1")) // inning time details
	{
%>
					<tr>
						<td align=center colspan=3 class="contentDark"><b>Total Inning Minutes</b></td>
					</tr>

					<tr>
						<td align=center class="colheadinguser">Inning Start time</td>
						<td align=center class="colheadinguser">Inning End time</td>
						<td align=center class="colheadinguser">Total Minutes</td>
					</tr>
					<tr>
						<td align=right class="contentLight"><%=inningStartTime%>&nbsp;</td>
						<td align=right class="contentLight"><%=inningEndTime%>&nbsp;</td>
						<td align=right class="contentLight"><b><%=inningTotalMin%></b>&nbsp;&nbsp;&nbsp;<b>[A]</b>
						
						</td>
					</tr>
<% }
%>
<%  if (flag.equalsIgnoreCase("2")) // Batsman time details
	{
%>
					<tr>
						<td align=center colspan=3 class="contentDark"><b>Total Batsman Minutes</b></td>
					</tr>

					<tr>
						<td align=center class="colheadinguser">Play Start time</td>
						<td align=center class="colheadinguser">Play End time</td>
						<td align=center class="colheadinguser">Total Minutes</td>
					</tr>
<%					try{
					if(batsmanInningDetailCrs!=null && batsmanInningDetailCrs.size() > 0){
					while(batsmanInningDetailCrs.next()){
						inningTotalMin = batsmanInningDetailCrs.getString("total_time");
%>
					<tr>
						<td align=right class="contentLight"><%="1900-01-01 00:00".equalsIgnoreCase(batsmanInningDetailCrs.getString("play_start_ts"))?"":batsmanInningDetailCrs.getString("play_start_ts")%>&nbsp;</td>
						<td align=right class="contentLight"><%="1900-01-01 00:00".equalsIgnoreCase(batsmanInningDetailCrs.getString("play_end_ts"))?"":batsmanInningDetailCrs.getString("play_end_ts")%>&nbsp;</td>
						<td align=right class="contentLight"><b><%="0".equalsIgnoreCase(batsmanInningDetailCrs.getString("total_play"))?"0":batsmanInningDetailCrs.getString("total_play")%></b>&nbsp;&nbsp;&nbsp;<b>[A]</b>
						
						</td>
					</tr>
<%					}}}
					catch(Exception e){
						e.printStackTrace();
					}
	}				
%>					
			</table>
<%
%>
			<br>
			<table width=100% border=1 align=center cellspacing=0>
					<tr>
						<td align=center colspan=5 class="contentDark"><b>Total Intermission Minutes</b></td>
					</tr>
					<tr>
						<td align=center class="colheadinguser">Intermission</td>
						<td align=center class="colheadinguser">Type</td>
						<td align=center class="colheadinguser">Start time</td>
						<td align=center class="colheadinguser">End time</td>
						<td align=center class="colheadinguser">Stoppages Minutes</td>
					</tr>
<%	intermissionDetailCrs = (CachedRowSet) matchInningDetailCrs;
	intermissionDetailCrs.beforeFirst();
	try
	{
		if (intermissionDetailCrs!=null && intermissionDetailCrs.size() > 0)
		{
			while (intermissionDetailCrs.next())
			{
				interMissionMinute = intermissionDetailCrs.getString("stoppage_minutes")!=null?intermissionDetailCrs.getString("stoppage_minutes"):"0" ;
			
				intermissionStartTime = intermissionDetailCrs.getString("interstart_ts")!=null?intermissionDetailCrs.getString("interstart_ts").substring(0,16):"0" ;

				intermissionEndTime=intermissionDetailCrs.getString("interend_ts")!=null?intermissionDetailCrs.getString("interend_ts").substring(0,16):"0";
			
				if (intermissionStartTime.equalsIgnoreCase("1900-01-01 00:00"))
				{
					intermissionStartTime = "";
				}

				if (intermissionEndTime.equalsIgnoreCase("1900-01-01 00:00"))
				{
					intermissionEndTime = "";
				}

				totalIntermissionMinute = totalIntermissionMinute + Integer.parseInt(interMissionMinute);
%>
<%				if (cssCounter%2!=0)
				{
%>
					<tr class="contentDark">
<%				}
				else
				{
%>
					<tr class="contentLight">
<%				}
%>
						<td align=left><%=intermissionDetailCrs.getString("intermission")!=null?intermissionDetailCrs.getString("intermission"):""%></td>
						<td align=left><%=intermissionDetailCrs.getString("intermission_type")!=null?intermissionDetailCrs.getString("intermission_type"):""%></td>
						<td align=right><%=intermissionStartTime%></td>
						<td align=right><%=intermissionEndTime%></td>
						<td align=right><%=intermissionDetailCrs.getString("stoppage_minutes")!=null?intermissionDetailCrs.getString("stoppage_minutes"):"0"%></td>
					</tr>
<%			cssCounter ++;
			}
		}
	}
	catch (Exception e)
	{
			System.out.println("Exception 2" +e.getMessage());
	}
%>
<%	try
	{
		totalMin = new Integer (inningTotalMin) ;
		totalInningTime = totalMin - totalIntermissionMinute ;
	}
	catch(Exception e)
	{
		System.out.println("Exception 3"+e.getMessage());
	}
%>
<%	if (cssCounter%2!=0)	
	{
%>
				<tr class="contentDark">
<%	}
	else
	{
%>
				<tr class="contentLight">
<%	}
%>
						<td colspan=4 align=right ><b>Total</b></td>
						<td  align=right><b><%=totalIntermissionMinute%>&nbsp;&nbsp;&nbsp;<b>[B]</b></b></td>
					</tr>
			</table>
			<br>
			<table width=100% border=1 align=center cellspacing=0>
<%  if (flag.equalsIgnoreCase("1")) // inning time details
	{
%>				
				<tr>
					<td align=center class="contentLight"><b>Actual Inning Time [A] - [B]: </b>&nbsp;&nbsp;&nbsp; <b><%=totalInningTime%></b></td>
				</tr>
<% }
%>
<%  if (flag.equalsIgnoreCase("2")) // inning time details
	{
%>				
				<tr>
					<td align=center class="contentLight"><b>Actual Batsman Min [A] - [B]: </b>&nbsp;&nbsp;&nbsp; <b><%=totalInningTime%></b></td>
				</tr>
<% }
%>
			</table>
			<br>
			<br>
			<table align=center>
					<tr>
						<td><a href=# onclick="closeWindow()"><b>close</b></a></td>
					</tr>
			</table>
	</body>
</html>