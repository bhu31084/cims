<!--
	Author 		 : Vaibhav Gaikar
	Created Date : 22 / 04 / 2009
	Description  : Display Penalty detail based on the match.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%
	CachedRowSet crsObjSeason   = null;
	CachedRowSet crsObjMatches	= null;
	CachedRowSet crsObjPenalty	= null;
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	Vector vparam = new Vector();
	Common common = new Common();
	String sessionId = "";
	String matchBetween = "";
	String venue = "";
	String seriesName = "";	
	String hidMatchId = "";
	String cmbSession = "";
	String hid = "";	
	int cssCounter= 1;
	hid = request.getParameter("hid")!=null?request.getParameter("hid"):"";
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
	try
	{
		if (hid!=null && hid.equalsIgnoreCase("2"))
		{
			hidMatchId = request.getParameter("hidMatchId")!=null?request.getParameter("hidMatchId"):"";
			vparam.add(hidMatchId);
			crsObjPenalty = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getpenalty_forinning",vparam,"ScoreDB");		
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception 3" +e.getMessage());
	}
%>
<html>
	<head>
			<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
			<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" /> 
			<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script> 
			<script>
					function showMatches()
					{
						var season = document.getElementById("selSeason").value;
						if (season == 'A')
						{
							alert("Select Season");
							return false;
						}
						document.getElementById("hid").value = 1;
						document.frmPenalty.submit();
					}

					function showPenaltyDetail(matchid)
					{
						document.getElementById('hidMatchId').value=matchid;
						document.getElementById("hid").value = 2;
						document.frmPenalty.submit();
					}

			</script>
	</head>
<body>
<jsp:include page="Menu.jsp"></jsp:include>
<div class="leg">Penalty Report</div>
<%--    Venue Master--%>
<div class="portletContainer">
		<form id="frmPenalty" name="frmPenalty" method=post>
		<input type="hidden" name="hid" value="hid" value=""/>
		<input type="hidden" name="hidMatchId" value="hidMatchId" value="0"/>
		<br>
		<table align=center width=100% border=0>
			
			<tr>
				<td align=left>
					<b>Select Season : </b>
						<select id="selSeason" name="selSeason" class="input">
<%
	try
	{
		cmbSession = request.getParameter("selSeason")==null?"0":request.getParameter("selSeason");
		if (crsObjSeason!=null)
		{
			int i = 0;
			while (crsObjSeason.next())
			{
				if(i==0 && cmbSession.equalsIgnoreCase("0"))
				{
					cmbSession = crsObjSeason.getString("id");
					System.out.println("cmbSession" +cmbSession);
				}
				i++;
%>
									<option value="<%=crsObjSeason.getString("id")%>" <%=cmbSession.equalsIgnoreCase(crsObjSeason.getString("id"))?"selected":""%>>
									<%=crsObjSeason.getString("name")%>
									</option>
<%
			}
		}
	}
    catch(Exception e)
	{
		System.out.println("Exception 2" +e.getMessage());
	}
%>
									</select>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type=button value="Go" onclick="showMatches()" class="btn btn-warning"/>
								</td>
							</tr>
					</table>
					<br><br>
<% // get matches based on season id
	try
	{			
			vparam.add(cmbSession);	
			crsObjMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_penaltiesmatch",vparam,"ScoreDB");		
			vparam.removeAllElements();	
	
	}
	catch(Exception e)
	{
		System.out.println("Exception 2" +e.getMessage());
	}

%>
<%	
	if (hid!=null && !(hid.equalsIgnoreCase("2")))
	{
%>
				<div id="matchDetail">
					<table width="100%" >
						<tr class="contentDark">
							<td width=40% align=center class="colheadinguser">Match Between</td>
							<td width=20% align=center class="colheadinguser">Venue</td>
							<td width=30% align=center class="colheadinguser">Series</td>
						</tr>
<%
	try
	{
		if (crsObjMatches!=null)
		{
			while (crsObjMatches.next())
			{
				matchBetween = crsObjMatches.getString("matchbtwn")!=null?crsObjMatches.getString("matchbtwn"):"";
				venue = crsObjMatches.getString("venuename")!=null?crsObjMatches.getString("venuename"):"";
				seriesName = crsObjMatches.getString("seriesname")!=null?crsObjMatches.getString("seriesname"):"";
				if (cssCounter%2!=0)
				{
%>
						<tr class="contentLight">
<%				}
				else
				{
%>
						<tr class="contentDark">
<%				}
				cssCounter ++;
%>
							<td width=40% align=center><a href="javascript:showPenaltyDetail('<%=crsObjMatches.getString("id")!=null?crsObjMatches.getString("id"):""%>')"><%=matchBetween%></a></td>
							<td width=20% align=center><%=venue%></td>
							<td width=30% align=center><%=seriesName%></td>
						</tr>
<%
			}
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception 3" +e.getMessage());
	}
%>	
						
					</table>
				</div>
<%
	}
%>
<% 
	if (hid!=null && hid.equalsIgnoreCase("2"))
	{
%>
				<div id="penaltyDetails">
					<table width="100%">
							<tr>
								<td align=center class="colheadinguser">Match Between</td>
								<td align=center class="colheadinguser">Inning</td>
								<td align=center class="colheadinguser">Penalty Name</td>
								<td align=center class="colheadinguser">Warning</td>
								<td align=center class="colheadinguser">Penalty Runs</td>
								<td align=center class="colheadinguser">Bats Apply</td>
								<td align=center class="colheadinguser">Bowling Team</td>
								<td align=center class="colheadinguser">Batting Team</td>
							</tr>
<%
	try
	{
		if (crsObjPenalty!=null)
		{
			while (crsObjPenalty.next())
			{
				String batsApply = crsObjPenalty.getString("bats_apply")!=null?crsObjPenalty.getString("bats_apply"):"";
				String warning = crsObjPenalty.getString("warning")!=null?crsObjPenalty.getString("warning"):"";

				if (warning.equalsIgnoreCase("Y"))
				{
					warning = "Yes";
				}
				else if(warning.equalsIgnoreCase("N"))
				{
					warning = "No";
				}

				if (batsApply.equalsIgnoreCase("Y"))
				{
					batsApply = "Yes";
				}
				else if(batsApply.equalsIgnoreCase("N"))
				{
					batsApply = "No";
				}

				if (cssCounter%2!=0)
				{
%>
					<tr class="contentLight">
<%				}
				else
				{
%>
					<tr class="contentDark">
<%				}
				cssCounter ++;
%>
								<td align=left><%=crsObjPenalty.getString("matchbtwn")!=null?crsObjPenalty.getString("matchbtwn"):""%></td>
								<td align=right><%=crsObjPenalty.getString("inning")!=null?crsObjPenalty.getString("inning"):""%></td>
								<td align=left><%=crsObjPenalty.getString("name")!=null?crsObjPenalty.getString("name"):""%></td>
								<td align=left><%=warning%></td>
								<td align=right><%=crsObjPenalty.getString("penalty_runs")!=null?crsObjPenalty.getString("penalty_runs"):""%></td>
								<td align=left>
								<%=batsApply%>
								</td>
								<td align=left><%=crsObjPenalty.getString("bowling_team")!=null?crsObjPenalty.getString("bowling_team"):""%></td>
								<td align=left><%=crsObjPenalty.getString("batting_team")!=null?crsObjPenalty.getString("batting_team"):""%></td>
							</tr>
<%
			}
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception 4"  +e.getMessage());
	}
%>

					</table>
				</div>
<% }//if end
%>
				
			
		</form>
</div>
</body>
<br><jsp:include page="Footer.jsp"></jsp:include>
</html>