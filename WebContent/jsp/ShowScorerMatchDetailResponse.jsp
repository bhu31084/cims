<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires",0);
%>
<%
	String scorerId = request.getParameter("scorerId")==null?"0":request.getParameter("scorerId");
	String seasonId = request.getParameter("seasonId")==null?"0":request.getParameter("seasonId");
	String flag = "1";
	System.out.println("scorerId "+scorerId);
	System.out.println("seasonId "+seasonId);
	
	LogWriter log = new LogWriter();

	String gsSeriesId = "";
	String gsScoreId = "";
	CachedRowSet  crsObjMatchPts = null;
	Vector vParam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

		try{
			vParam.add(seasonId);
			vParam.add(scorerId);
			vParam.add("");
			vParam.add(flag);
			crsObjMatchPts = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_scorermatchdtls",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
	 		e.printStackTrace();
		}
	%>
<DIV id="ShowScorerMatchDetailsDiv<%=scorerId%>">
	<table width="880" border="1" align="center" cellpadding="2" cellspacing="1" class="table">
   		<tr class="contentLight">
   			<td align="center" width="1%"><font color="#840084">&nbsp;</font></td>
       		<td align="center" width="10%"><font color="#840084">Scorer Name </font></td>
<%--       		<td align="center" width="3%"><font color="#840084">Series Id </font></td>--%>
       		<td align="center" width="10%"><font color="#840084">Series Name </font></td>
       		<td align="center" width="2%"><font color="#840084">No Of Matches</font></td>
		</tr>
			<%if(crsObjMatchPts != null ){
			int counter = 1;
				while(crsObjMatchPts.next()){
				gsSeriesId = crsObjMatchPts.getString("seriesid");
				gsScoreId = crsObjMatchPts.getString("scoreruserid");
				if(counter % 2 != 0){%>
		<tr class="contentDark">
<%				}else{
%>		<tr class="contentLight">
<%				}%>
			<td  align="center" width="1%"><font color="#840084"><a onclick="ShowMatchDetailDiv('<%=gsScoreId%>','<%=gsSeriesId%>')"><IMG id="ScoplusImage<%=gsScoreId%><%=gsSeriesId%>" name="ScoplusImage<%=gsScoreId%><%=gsSeriesId%>" title="Click On + To Get The Details." alt="" src="../images/plusdiv.jpg" /></a></font></td>
			<td id="<%=counter++%>" width="5%" align="center"><%=crsObjMatchPts.getString("ScorerName")%></td>
			<td width="5%" align="left"><%=crsObjMatchPts.getString("seriesname")%></td>
			<td width="2%" align="right"><%=crsObjMatchPts.getString("noofmatches")%></td>
		</tr>
		<tr>
			<td colspan="10">
<%
				String dflag = "2";
				CachedRowSet  crsObjscorermatchdtls = null;

		try{
			vParam.add(seasonId);
			vParam.add(scorerId);
			vParam.add(gsSeriesId);
			vParam.add(dflag);
			crsObjscorermatchdtls = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_scorermatchdtls",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
	 		e.printStackTrace();
		}
	%>
	<DIV id="ShowMatchDetailsDiv<%=scorerId%><%=gsSeriesId%>" style="display: none;">
	<table width="880" border="1" align="center" cellpadding="2" cellspacing="1" class="table">
   		<tr class="contentLight" >   			
<%--       		<td  align="center" width="10%"><font color="#840084">Scorer One </font></td>--%>
       		<td  align="center" width="10%"><font color="#840084">Scorer two </font></td>
       		<td  align="center" width="10%"><font color="#840084">Series and Season Name </font></td>
       		<td  align="center" width="2%"><font color="#840084">Match Id</font></td>
<%--       		<td  align="center" width="10%"><font color="#840084">Series Id</font></td>--%>
       		<td  align="center" width="10%"><font color="#840084">Teams</font></td>
       		<td  align="center" width="5%"><font color="#840084">Expected Start</font></td>
		</tr>
			<%if(crsObjscorermatchdtls != null ){
			int dcounter = 1;
				while(crsObjscorermatchdtls.next()){					
				if(dcounter % 2 != 0){%>
		<tr class="contentDark">
<%				}else{
%>		<tr class="contentLight">
<%				}%>
<%--			<td id="<%=dcounter++%>" width="5%" align="center"><%=crsObjscorermatchdtls.getString("Scorer_1")%></td>--%>
			<%if(crsObjscorermatchdtls.getString("Scorer_2") == null || crsObjscorermatchdtls.getString("Scorer_2").equals("")){%>
			<td >Not Assigned</td>
<%			}else{
%>
			<td id="<%=dcounter++%>" width="5%" align="center"><%=crsObjscorermatchdtls.getString("Scorer_2")%></td>
			<%}%>
			<td width="5%" align="left"><%=crsObjscorermatchdtls.getString("series_season_name")%></td>
			<td width="2%" align="right"><%=crsObjscorermatchdtls.getString("match_id")%></td>
<%--			<td width="5%" align="left"><%=crsObjscorermatchdtls.getString("seriesid")%></td>--%>
			<td width="5%" align="left"><%=crsObjscorermatchdtls.getString("matchbtwn")%></td>
			<td width="5%" align="center"><%=crsObjscorermatchdtls.getString("expected_start").substring(0,11).toString()%></td>
		</tr>		
<%	}
			}%>
	</table>
</div>
<%--				<div id="ShowMatchDetailsDiv<%=gsSeriesId%>" style="display:none" >--%>
<%--				</div>--%>
			</td>
		</tr>
		
			<%	}
			}%>
	</table>
</div>
