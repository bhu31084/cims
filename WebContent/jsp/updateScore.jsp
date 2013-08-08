<!--
Page Name 	 : updateScore.jsp
Created By 	 : Dipti Shinde.
Created Date : 1-Oct-2008
Description  : Swapping Striker-Nonstriker of individual ball or all balls of over and displaying new pop wp window 
			   to update each ball's run 
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 21-Oct-2008
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
		
		String matchId = (String)session.getAttribute("matchId1");
		String inningId = (String)session.getAttribute("InningId");
		
		GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
		Vector spParamVec = new Vector();
				
		String ballNo	= request.getParameter("ballNo");
		String ballId	= request.getParameter("ballId");
		//swap = 1(for swapping striker nonstriker)& swap =2(display particular ball's data)
		String swap = request.getParameter("swap");
		String runs = request.getParameter("runs");
		String wideball = request.getParameter("wideball");
		String noball = request.getParameter("noball");
		String legbyes = request.getParameter("legbyes");
		String byes = request.getParameter("byes");
		String wicket = request.getParameter("wicket");
		String overno = request.getParameter("overno")==null?"":request.getParameter("overno").trim();
		String date = request.getParameter("date");
		String batsman = request.getParameter("batsman");
		String bowler = request.getParameter("bowler");
		String bowlerid = request.getParameter("bowlerid")==null?"":request.getParameter("bowlerid").trim();

		int ioverno = 0;
		 try {
		 	ioverno = new Integer(overno);
		 }catch (Exception e) {
		    //e.printStackTrace();
		 }	
		LogWriter log = new LogWriter();
		String[] ballIdArr = ballId.split("~");
		
		
	
try{
	if(swap.equalsIgnoreCase("1")){	//for swapping striker nonstriker
		try{
			for(int i=0;i < ballIdArr.length;i++){
				spParamVec.add(ballIdArr[i]); // ball_id
				spParamVec.add(inningId); // inning_id
				spGenerate.GenerateStoreProcedure("esp_amd_swapstrikernonstriker",spParamVec,"ScoreDB");
				spParamVec.removeAllElements();
			}
		}catch (Exception e) {
		    e.printStackTrace();
		    log.writeErrLog(page.getClass(),matchId,e.toString());
		}
	}else if(swap.equalsIgnoreCase("2")){ //display particular ball's data
		try{
				spParamVec.add(inningId);
				bowlersCrs = spGenerate.GenerateStoreProcedure("dsp_bowlinglist",spParamVec,"ScoreDB");
				spParamVec.removeAllElements();
			}catch (Exception e) {
		    	e.printStackTrace();
		    	log.writeErrLog(page.getClass(),matchId,e.toString());
		}
%>
<html>
	<body>
		<table align="center" border="1" width="95%">
			<tr><td colspan="8"><b>Over No : <%=overno%>  Ball No : <%=ballNo%> </b></td></tr>
			<tr class="tenoverupdateball">
				<th>Bowler</th>
				<th>Runs</th>
				<th>Wide Ball</th>
				<th>No Ball</th>
				<th>Legbyes</th>
				<th>Byes</th>
				<th>Wicket</th>
				<th>Date</th>
			</tr>
			<tr class="contentLastDark">
				<td><%=bowler%></td>
				<td><%=runs%></td>
				<td><%=wideball%></td>
				<td><%=noball%></td>
				<td><%=legbyes%></td>
				<td><%=byes%></td>
				<td><%=wicket%></td>
				<td nowrap="nowrap"><%=date%></td>
			</tr>
			<tr class="contentLastDark">
				<td>
					<select id="selBowlerName" name="selBowlerName">
<%					if(bowlersCrs != null){	
						while(bowlersCrs.next()){
%>				 			<option value ="<%=bowlersCrs.getString("id")%>" <%=bowlerid.equalsIgnoreCase(bowlersCrs.getString("id")) ? "selected" : ""%>>
				 			<%=bowlersCrs.getString("playername")%></option>					
<%						}//end while
					}//end if	
%>					</select>
				</td>
				<td>
					<select id="ballRun" name="ballRun">
<%					for(int i=0;i<10;i++){
						String val = new Integer(i).toString();
%>						 <option value ="<%=i%>" <%=runs.equalsIgnoreCase(val)? "selected" : ""%> ><%=i%></option>
<%					}
					
%>						 <option value ="4B">4(B)</option>
						 <option value ="6B">6(B)</option>
					</select>
				</td>
				<td>
					<select id="ballWideBall" name="ballWideBall" onchange="callFun.changeBall('wide','<%=ballId%>','<%=batsman%>','<%=overno%>')">
					  <option value ="0" <%=wideball.equalsIgnoreCase("0")? "selected" : ""%>>0</option>
					  <option value ="1" <%=wideball.equalsIgnoreCase("1")? "selected" : ""%>>1</option>
					</select>
				</td>
				<td>
					<select id="ballNoBall" name="ballNoBall" onchange="callFun.changeBall('noball','<%=ballId%>','<%=batsman%>','<%=overno%>')">
					  <option value ="0" <%=noball.equalsIgnoreCase("0")? "selected" : ""%>>0</option>
					  <option value ="1" <%=noball.equalsIgnoreCase("1")? "selected" : ""%>>1</option>
					</select>	
				</td>
				<td>
					<select id="ballLegByes" name="ballLegByes" onchange="callFun.changeBall('legbyes','<%=ballId%>'),'<%=batsman%>','<%=overno%>'">
					  <option value ="Y" <%=legbyes.equalsIgnoreCase("Y")? "selected" : ""%>>Y</option>
					  <option value ="N" <%=legbyes.equalsIgnoreCase("N")? "selected" : ""%>>N</option>
					</select>
				</td>
				<td>
					<select id="ballByes" name="ballByes" onchange="callFun.changeBall('byes','<%=ballId%>'),'<%=batsman%>','<%=overno%>'">
					  <option value ="Y" <%=byes.equalsIgnoreCase("Y")? "selected" : ""%>>Y</option>
					  <option value ="N" <%=byes.equalsIgnoreCase("N")? "selected" : ""%>>N</option>
					</select>
				</td>
				<td>
					<select id="ballWickets" name="ballWickets" onchange="callFun.changeBall('wicket','<%=ballId%>','<%=batsman%>','<%=overno%>')">
					   <option value ="Y" <%=wicket.equalsIgnoreCase("Y")? "selected" : ""%>>Y</option>
					  <option value ="N" <%=wicket.equalsIgnoreCase("N")? "selected" : ""%>>N</option>
					</select>
				</td>
				<td>
					<input type="Text" id="txtballdate"  name="txtballdate" maxlength="25" size="25" value="<%=date%>" ><a id="imganchor" name="imganchor" href="javascript:NewCal('txtballdate','ddmmyyyy',true,24)"><IMG src="../images/cal.gif" border="0"></a>
				</td>
			</tr>
		</table>
		<br>
		<table>
			<tr>
				<td>
					<td><input type="button" align="center" value="Update" onclick="callFun.updateRow('<%=ballId%>');callFun.updateScore('<%=(ioverno -1)%>');closePopup('BackgroundDiv','updateRunsDiv'),closePopup('BackgroundDiv','updateWicketDiv')"></input>
					<td><input type="button" align="center" value="Exit"  onclick="closePopup('BackgroundDiv','updateRunsDiv'),closePopup('BackgroundDiv','updateWicketDiv')"></input>
						<input type="hidden" id="hdOverNumber" name="hdOverNumber" value="<%=overno%>">	
				</td>
			</tr>
		</table>		
	</body>
</html>			
<% }//end else
	}finally {
		/*matchId = null;
		ballId = null;
		inningId = null;
		log = null;
		spGenerate = null;
		spParamVec = null;
		ballIdArr = null;*/
	}
%>	
