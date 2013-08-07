<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="response/error_page.jsp"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%
		try {
		//String match_id = request.getParameter("matchid").toString();
		String match_id = request.getParameter("matchid");
	  //	session.setAttribute("match_id",matchid);
		//String match_id = (String)session.getAttribute("match_id");
		System.out.println("match_id on ajax "+match_id);
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy-MMM-dd");
		java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MMM-dd");
		java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat("DD/MM/yyyy");
		//String match_id = "709";
		CachedRowSet crsObjbatDetails = null;
		CachedRowSet crsObjballDetails = null;
		
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		
		Vector val = new Vector();		
		//crsObjInning = null;
		val = new Vector();
		val.add(match_id);
		crsObjbatDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_miniscorercard_summary_batsman",val, "ScoreDB");		
			
		//crsObjInning = null;
		val = new Vector();
		val.add(match_id);
		crsObjballDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_miniscorercard_summary_bowler",val, "ScoreDB");		%>
				
		
					
<div id="livescorecard" style="width:170px;height: 210px;">
	<table border="0" width="170" > 
		<tr> 
			<td width="">						
				<DIV style="width: 170px;height: 210px;" id="leftdiv">
			<%	if(crsObjbatDetails != null || crsObjballDetails != null ){
					if(crsObjbatDetails.size() == 0 || crsObjballDetails.size() == 0){ %>
						<table>
							<tr><td>No Match Available For Today</td></tr>
						</table>
				<%	}else{
					if(crsObjbatDetails.next()){ %>
						<table title="Live Score" style="width: 170px;height: 210px;" border="0" 
							class="contenttable">								
							<tr bgcolor="#BBDFF7"><td colspan="5" style="font-weight: bold;font-size: 11px;text-align: center;" ><%=sdf.format(new Date())%></td></tr>
							<tr bgcolor="#8CC8F0"><td colspan="5" style="font-weight: bold;font-size: 11px;text-align: center;"  ><%=crsObjbatDetails.getString("Team1")%> Vs. <%=crsObjbatDetails.getString("Team2")%></td></tr>
							<tr bgcolor="#e6f1fc"><td colspan="5" style="font-weight: bold;font-size: 11px;text-align: center;" >Status:<%=crsObjbatDetails.getString("result")%> </td></tr>
							<tr bgcolor="#BBDFF7">
								<td colspan="3" align="center" style="font-weight: bold;font-size: 11px;text-align: center;" ><%=crsObjbatDetails.getString("BATTING")%></td>
								<td colspan="2" align="center" style="font-weight: bold;font-size: 11px;text-align: center;"><%=crsObjbatDetails.getString("BOWLING")%></td>
							</tr>
							<tr bgcolor="#BBDFF7">
								<td colspan="5" align="center" style="font-weight: bold;font-size: 11px;text-align: center;" ><b><%=crsObjbatDetails.getString("batting_team_name")%></b>:-<%=crsObjbatDetails.getString("total")%>/<%=crsObjbatDetails.getString("wkts")%> &nbsp;(overs -  <%=crsObjbatDetails.getString("overs")%>)</td>
							</tr>
							<tr bgcolor="#8CC8F0"><td align="center" style="font-weight: bold;text-align: left;font-size: 11px">Batsman</td>
								<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">R</td>
								<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">B</td>
								<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">4s</td>
								<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">6s</td>
							</tr>
							
							<tr bgcolor="#e6f1fc">									
								<td style="font-size: 9px;text-align: left;"><%=crsObjbatDetails.getString("striker")%> *</td>
								<td style="font-size: 9px;text-align: right;"><%=crsObjbatDetails.getString("Striker_Score")%></td>
								<td style="font-size: 9px;text-align: right;"><%=crsObjbatDetails.getString("Striker_balls")%></td>
								<td style="font-size: 9px;text-align: right;padding-right: 10px;"><%=crsObjbatDetails.getString("Striker_fours")%></td>
								<td style="font-size: 9px;text-align: right;padding-right: 10px;"><%=crsObjbatDetails.getString("Striker_six")%></td>
							</tr>	
							<tr bgcolor="#e6f1fc">
								<td style="font-size: 9px;text-align: left;"><%=crsObjbatDetails.getString("nonstriker")%> </td>
								<td style="font-size: 9px;text-align: right;"><%=crsObjbatDetails.getString("NonStriker_Score")%></td>
								<td style="font-size: 9px;text-align: right;"><%=crsObjbatDetails.getString("NonStriker_balls")%></td>
								<td style="font-size: 9px;text-align: right;padding-right: 10px;"><%=crsObjbatDetails.getString("NonStriker_fours")%></td>
								<td style="font-size: 9x;text-align: right;padding-right: 10px;"><%=crsObjbatDetails.getString("NonStriker_six")%></td>
							</tr>
							<%}
							%>
							<tr bgcolor="#8CC8F0"><td align="center" style="font-weight: bold;font-size: 9px;text-align: left;">Bowler</td>
								<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">O</td>
								<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">M</td>		
								<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">W</td>		
								<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">R</td>										
							</tr>									
						<%	if(crsObjballDetails != null && crsObjballDetails.next()){ %>
							<tr bgcolor="#e6f1fc">
								<td style="text-align: left;font-size: 9px"><%=crsObjballDetails.getString("bowlername")%> *</td>
								<td style="text-align: right;font-size: 9px"><%=crsObjballDetails.getString("overs")%></td>
								<td style="text-align: right;font-size: 9px"><%=crsObjballDetails.getString("maiden")%></td>
								<td style="text-align: right;padding-right: 10px;font-size: 9px"><%=crsObjballDetails.getString("wicket")%></td>
								<td style="text-align: right;padding-right: 10px;font-size: 9px"><%=crsObjballDetails.getString("runs")%></td>										
							</tr>
							<%}%>
						</table>
					</DIV>					
				</td>
				</tr>
				<tr>
				<td style="width: 170px;height: 210px;">
					<div id="rightdiv" style="height: 210px;vertical-align: bottom;">
					<table border="0" width="170" style="text-align: justify;">
						<tr bgcolor="#8CC8F0"><td nowrap="nowrap" ><a href="javascript:ShowliveScoreCard('<%=match_id%>')" style="color: maroon;" id="<%=match_id%>" ><%=crsObjbatDetails.getString("Team1")%> Vs. <%=crsObjbatDetails.getString("Team2")%></a></td></tr>
						<tr bgcolor="#e6f1fc"><td nowrap="nowrap"><a href="javascript:getTeamLineUp('<%=match_id%>')" style="color: maroon;" id="<%=match_id%>" >Players</a></td></tr>
						<tr bgcolor="#8CC8F0"><td nowrap="nowrap"><a href="javascript:ShowFullScoreCard('<%=match_id%>')" style="color: maroon;" id="<%=match_id%>" >ScoreCard</a></td></tr>
						<tr bgcolor="#e6f1fc"><td >Refreshed after every 5 minutes. </td></tr>
					</table>				
					</div>
				</td>
				</tr>	
			</table>	
			<%
				}
			}					
			%>				
				
</div>
<%
		} catch (Exception e) {
			System.err.println(e.toString());
		}
%>