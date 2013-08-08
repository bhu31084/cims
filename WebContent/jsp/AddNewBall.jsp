<!--
Page Name 	 : AddNewBall.jsp
Created By 	 : Dipti Shinde.
Created Date : 30/12/2008
Description  : To add new ball in db
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 30/12/2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<%  	response.setHeader("Pragma","private");
		response.setHeader("Pragma", "No-cache");
	    response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");  
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
		
		CachedRowSet bowlersCrs = null;
		CachedRowSet batsmenNameCrs = null;
		String matchId = (String)session.getAttribute("matchId");
		String inningId = (String)session.getAttribute("InningId");
		GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
		Vector spParam = new Vector();
		
		String overno = request.getParameter("overno")==null?"":request.getParameter("overno");
		String inningno = request.getParameter("inningno");
		
		int ioverno = 0;
		 try {
		 	ioverno = Integer.parseInt(overno);
		 }catch (Exception e) {
		    e.printStackTrace();
		 }	
		LogWriter log = new LogWriter();
		
		try{
			spParam.add(inningId);
			bowlersCrs = spGenerate.GenerateStoreProcedure("dsp_bowlinglist",spParam,"ScoreDB");
			spParam.removeAllElements();
		}catch (Exception e) {
	    	e.printStackTrace();
	    	log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		
		try{
			spParam.add(inningId);
			batsmenNameCrs = spGenerate.GenerateStoreProcedure("dsp_batsmenlist",spParam,"ScoreDB");
			spParam.removeAllElements();
		}catch (Exception e) {
	    	e.printStackTrace();
	    	log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		
			
try{
	
%>
	<div>
		<table align="center" border="1" width="95%">
			<tr><td align="center" colspan="9"><b>Over No : <%=(ioverno+1)%></b></td></tr>
			<tr class="tenoverupdateball">
				<th>Bowler</th>
				<th>Striker</th>
				<th>Nonstriker</th>
				<th>Runs</th>
				<th>Wide Ball</th>
				<th>No Ball</th>
				<th>Legbyes</th>
				<th>Byes</th>
<%--				<th>Wicket</th>--%>
				<th>Date</th>
			</tr>
			<tr class="contentLastDark" align="center">
				<td>
					<select id="selBowler" name="selBowler">
<%					if(bowlersCrs != null){	
						while(bowlersCrs.next()){
%>				 			<option value ="<%=bowlersCrs.getString("id")%>">
				 			<%=bowlersCrs.getString("playername")%></option>					
<%						}//end while
					}//end if	
%>					</select>
				</td>
				<td>
					<select id="selStriker" name="selStriker">
<%					if(batsmenNameCrs != null){	
						while(batsmenNameCrs.next()){
%>				 			<option value ="<%=batsmenNameCrs.getString("id")%>">
				 			<%=batsmenNameCrs.getString("playername")%></option>					
<%						}//end while
					}//end if	
%>					</select>
				</td>
				<td>
<%				batsmenNameCrs.beforeFirst();
%>
				<select id="selNonstriker" name="selNonstriker">
<%					if(batsmenNameCrs != null){	
						while(batsmenNameCrs.next()){
%>				 			<option value ="<%=batsmenNameCrs.getString("id")%>">
				 			<%=batsmenNameCrs.getString("playername")%></option>					
<%						}//end while
					}//end if	
%>					</select>
				</td>
				<td>
					<select id="ballRun" name="ballRun">
<%					for(int i=0;i<10;i++){
						String val = new Integer(i).toString();
%>						 <option value ="<%=i%>"><%=i%></option>
<%					}
%>						 <option value ="4B">4(B)</option>
						 <option value ="6B">6(B)</option>
					</select>
				</td>
				<td>
<%--					<select id="ballWideBall" name="ballWideBall" onchange="changeBall('wide','<%=ballId%>','<%=batsman%>','<%=overno%>')">--%>
					<select id="ballWideBall" name="ballWideBall" onchange="changeBall('wide','','','')">
					  <option value ="0">0</option>
					  <option value ="1">1</option>
					</select>
				</td>
				<td>
					<select id="ballNoBall" name="ballNoBall" onchange="changeBall('noball','','','')">
					  <option value ="0">0</option>
					  <option value ="1">1</option>
					</select>	
				</td>
				<td>
					<select id="ballLegByes" name="ballLegByes" onchange="changeBall('legbyes','','','')">
					  <option value ="Y">Y</option>
					  <option value ="N">N</option>
					</select>
				</td>
				<td>
					<select id="ballByes" name="ballByes" onchange="changeBall('byes','','','')">
					  <option value ="Y">Y</option>
					  <option value ="N">N</option>
					</select>
				</td>
<%--				<td>--%>
<%--					<select id="ballWickets" name="ballWickets">--%>
<%--					   <option value ="Y">Y</option>--%>
<%--					  <option value ="N">N</option>--%>
<%--					</select>--%>
<%--				</td>--%>
				<td>
					<input type="Text" id="txtballdate"  name="txtballdate" maxlength="25" size="25" value="" ><a id="imganchor" name="imganchor" href="javascript:NewCal('txtballdate','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>
				</td>
			</tr>
		</table>
		<br>
		<table>
			<tr>
				<td>
					<td><input type="button" align="center" value="Add" onclick="addBall('<%=(ioverno)%>','<%=inningno%>');javascript:updateScore('<%=(ioverno)%>');closePopup('BackgroundOverDiv','updateRunsDiv');closePopup('BackgroundOverDiv','updateWicketDiv')"></input>
					<td><input type="button" align="center" value="Exit"  onclick="closePopup('BackgroundOverDiv','updateRunsDiv'),closePopup('BackgroundOverDiv','updateWicketDiv'),closePopup('BackgroundOverDiv','addBallDiv')">
						<input type="hidden" id="hdOverNumber" name="hdOverNumber" value="<%=overno%>">	
					</td>
			</tr>

		</table>		
	</div>	
	

<%
	}finally {
		matchId = null;
		inningId = null;
		log = null;
		
	}
%>	
