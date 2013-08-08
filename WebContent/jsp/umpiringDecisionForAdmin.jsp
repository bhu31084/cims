<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<%	String matchId = (String)session.getAttribute("matchId1");
   	String umpireid = request.getParameter("umpireid");
    String userid =(String)session.getAttribute("userid");
   	String role="6";
   	String umpireCoach = null;
	CachedRowSet umpireCoachCrs =	null;
	CachedRowSet umpireDecisionCrs =	null;
	CachedRowSet inningCrs =	null;
	LogWriter log = new LogWriter();
	GenerateStoreProcedure generateStProc = new GenerateStoreProcedure(matchId);
	Vector spParamVec = new Vector();
	int editcount = 0;
	int i =1;
	
try{
	spParamVec.add(role);
	spParamVec.add(matchId);
	
	try{
		umpireCoachCrs = generateStProc.GenerateStoreProcedure(
			"esp_dsp_matchumpire", spParamVec, "ScoreDB");
			if(umpireCoachCrs != null && umpireCoachCrs.size() > 0){	
				while(umpireCoachCrs.next()){
					umpireCoach = umpireCoachCrs.getString("mapid");
				}
			}
	}catch (Exception e) {
		System.out.println("*************umpiringDecisionForAdmin.jsp*****************"+e);
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
	
	spParamVec.removeAllElements();
	spParamVec.add(matchId); 
	spParamVec.add(umpireid);
	spParamVec.add(umpireCoach);
	umpireDecisionCrs = generateStProc.GenerateStoreProcedure("esp_dsp_getumpiresdecision",spParamVec,"ScoreDB");
	
	
	spParamVec.removeAllElements();
	spParamVec.add(matchId);  	
	inningCrs = generateStProc.GenerateStoreProcedure("esp_dsp_getinningswithnumber",spParamVec,"ScoreDB");	
	
	
	}catch (Exception e) {
		System.out.println("*************umpiringDecisionForAdmin.jsp*****************"+e);
		e.printStackTrace();
		log.writeErrLog(page.getClass(),matchId,e.toString());
	} 
%>
<html>
<body>
<%
	if(!(umpireid.equalsIgnoreCase("0"))){
%>
	<table style="WIDTH: 100%" border="1" width="100%">
		<tr class="contentDark">
			<th class="colheadinguser" align="center">Inning <br>Number</th>
<%--			<th class="colheadinguser" align="center">Inning <br> Id</th>--%>
			<th class="colheadinguser" align="center">Over</th>
			<th class="colheadinguser" align="center">Batsman</th>
			<th class="colheadinguser" align="center">Bowler</th>
			<th class="colheadinguser" align="center">Appeal</th>
			<th class="colheadinguser" align="center">Result</th>
			<th class="colheadinguser" align="center">Decision</th>
			<th class="colheadinguser" align="center">Reason</th>
			<th class="colheadinguser" align="center">Remark</th>
			<%	if(!userid.equals("34290")){%>
			<th class="colheadinguser" align="center">Delete</th>
			<%  } %>
		</tr>
<%		
		ArrayList inningnoAl = new ArrayList();
		ArrayList inningidAl = new ArrayList();
		if(inningCrs != null && inningCrs.size() > 0){	
			while(inningCrs.next()){
				inningnoAl.add(inningCrs.getString("inningno"));
				inningidAl.add(inningCrs.getString("inningid"));
			}
		}
		
		if(umpireDecisionCrs != null && umpireDecisionCrs.size() > 0){	
		umpireDecisionCrs.beforeFirst();
		String flag="D";
			while(umpireDecisionCrs.next()){
				editcount++;
%>		<tr>
<%				for(int p=0 ;p< inningnoAl.size();p++){
					if(umpireDecisionCrs.getString("inningid").equals(inningidAl.get(p))){
%>			<td align="center" nowrap><%=inningnoAl.get(p)%>
			<input type="hidden" name="<%="i"+editcount%>" id="<%="i"+editcount%>" value="<%=umpireDecisionCrs.getString("inningid")%>">
			</td>
<%					}
				}
%>	
<%--			<td align="center" nowrap><%=umpireDecisionCrs.getString("inningid")%></td>--%>
			<td align="center" nowrap><%=umpireDecisionCrs.getString("overno")%>
			<input type="hidden" name="<%="o"+editcount%>" id="<%="o"+editcount%>" value="<%=umpireDecisionCrs.getString("overno")%>">
			</td>
			<td nowrap><%=umpireDecisionCrs.getString("batsman_name")%>
			<input type="hidden" name="<%="bat"+editcount%>" id="<%="bat"+editcount%>" value="<%=umpireDecisionCrs.getString("batsman")%>">
			</td>
			<td nowrap><%=umpireDecisionCrs.getString("bowler_name")%>
			<input type="hidden" name="<%="bow"+editcount%>" id="<%="bow"+editcount%>" value="<%=umpireDecisionCrs.getString("bowler")%>">
			</td>
			<td nowrap><%=umpireDecisionCrs.getString("appeal")%>
			<input type="hidden" name="<%="app"+editcount%>" id="<%="app"+editcount%>" value="<%=umpireDecisionCrs.getString("appealid")%>">
			</td>
			<td nowrap><%=umpireDecisionCrs.getString("appeal_accepted")%>
			<input type="hidden" name="<%="res"+editcount%>" id="<%="res"+editcount%>" value="<%=umpireDecisionCrs.getString("appealyn")%>">
			</td>
			<td nowrap><%=umpireDecisionCrs.getString("decision_correct")%>
			<input type="hidden" name="<%="des"+editcount%>" id="<%="des"+editcount%>" value="<%=umpireDecisionCrs.getString("decisionyn")%>">
			</td>
			<td ><%=umpireDecisionCrs.getString("reason")%>
			<input type="hidden" name="<%="reas"+editcount%>" id="<%="reas"+editcount%>" value="<%=umpireDecisionCrs.getString("reasonid")%>">
			</td>
			<td nowrap><%=umpireDecisionCrs.getString("remark")%>
			<input type="hidden" name="<%="rem"+editcount%>" id="<%="rem"+editcount%>" value="<%=umpireDecisionCrs.getString("remark")%>">
			</td>
			<%	if(!userid.equals("34290")){%>
			<td nowrap><a href="javascript:deleteRecord(<%=editcount%>)">delete</a>
			<input type="hidden" name="<%="ump"+editcount%>" id="<%="ump"+editcount%>" value="<%=umpireid%>">
			</td>
			<%	} %>
<%--//umpire  appraiser   appealid    appeal  reasonid  reason   bowler   batsman    bowler_name --%>
<%--//  batsman_name  appealyn appeal_accepted decisionyn decision_correct inningid    overno   remark--%>
<%--												//umpireid,umpireCoach,appealid,reasonid,appealyn,decisionyn,decisionyn,overno,batsman,bowler,inningid,remark,flag								--%>
<%--			<TD ALIGN="CENTER"><INPUT TYPE="BUTTON" VALUE="DELETE" ONCLICK="DELETELOG('<%=UMPIREID%>',--%>
<%--																						'<%=UMPIRECOACH%>',--%>
<%--																						'<%=UMPIREDECISIONCRS.GETSTRING("APPEALID")%>',--%>
<%--																						'<%=UMPIREDECISIONCRS.GETSTRING("REASONID")%>',--%>
<%--																						'<%=UMPIREDECISIONCRS.GETSTRING("APPEALYN")%>',--%>
<%--																						'<%=UMPIREDECISIONCRS.GETSTRING("DECISIONYN")%>',--%>
<%--																						'<%=UMPIREDECISIONCRS.GETSTRING("OVERNO")%>',--%>
<%--																						'<%=UMPIREDECISIONCRS.GETSTRING("BATSMAN")%>',--%>
<%--																						'<%=UMPIREDECISIONCRS.GETSTRING("BOWLER")%>',--%>
<%--																						'<%=UMPIREDECISIONCRS.GETSTRING("INNINGID")%>',--%>
<%--																						'<%=UMPIREDECISIONCRS.GETSTRING("REMARK")%>',--%>
<%--																						'<%=FLAG%>'--%>
<%--																						),SEARCHLOG()"/></TD>--%>
		</tr>
<%				i++;
				
			}	
		}else{
%>		
		<tr>
			<td height="50" colspan="11" align="center" nowrap class="message"> No Data Present</td>
		</tr>
<%		}
%>

	
	<table>
<%	}	else {
%>		
	<table style="WIDTH: 100%" border="0" width="100%">
		<tr  align="center">
			<td class="message">
				Please Select Umpire
			</td>
		</tr>	
	</table>	
<%	}

%>
</body>
</html>
