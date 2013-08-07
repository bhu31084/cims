<!-- Admin match set up response page to get all list of users.*/-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
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
		final String UMP_ROLE = "2";
		final String SCORER_ROLE = "3";
		final String REFEREE_ROLE = "4";
		final String UMP_COACH_ROLE = "6";

		CachedRowSet  crsObjMatchData = null;
		CachedRowSet  crsObjUmpire2 = null;		
		CachedRowSet  crsObjUmpireCoach = null;
		CachedRowSet  crsObjMatchReferee = null;		
		CachedRowSet  crsObjTeamsId = null;
		CachedRowSet  crsObjUmpire1 = null;
		CachedRowSet  crsObjUmpire3 = null;

		Vector vparam =  new Vector();
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

		String mId = new String();
		String team1Id = new String();
		String team2Id = new String();
		String umpire1_id = "";
		String umpire1 = "";
		String umpire2_id = "";
		String umpire2 ="";
		String umpire3_id = "";
		String umpire3 ="";			
		String umpirecoach_id = "";
		String umpirecoach = "";
		String referee_id = "";
		String matchreferee = "";
		

		String ump1Id = new String();
		String ump2Id = new String();
		String ump3Id = new String();		
		String umpCoachId = new String();		
		String refereeId = new String();

		String match_id = request.getParameter("matchId")==null?"0":request.getParameter("matchId");
		String Preval = request.getParameter("Preval")==null?"0":request.getParameter("Preval");
		String Postval = request.getParameter("Postval")==null?"0":request.getParameter("Postval");%>

		<%try{
			vparam.add(match_id);//display teams
			crsObjTeamsId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_modifymatch",vparam,"ScoreDB");
		    vparam.removeAllElements();
			while(crsObjTeamsId.next()){
				mId = crsObjTeamsId.getString("match_id");
				team1Id = crsObjTeamsId.getString("team1_id");
				team2Id = crsObjTeamsId.getString("team2_id");
				umpire1_id = crsObjTeamsId.getString("umpire1_id");
				umpire1 = crsObjTeamsId.getString("umpire1");
				umpire2_id = crsObjTeamsId.getString("umpire2_id");
				umpire2 = crsObjTeamsId.getString("umpire2");
				umpire3_id = crsObjTeamsId.getString("umpire3_id");
				umpire3 = crsObjTeamsId.getString("umpire3");				
				umpirecoach_id = crsObjTeamsId.getString("umpirecoach_id");
				umpirecoach = crsObjTeamsId.getString("umpirecoach");
				referee_id = crsObjTeamsId.getString("referee_id");
				matchreferee = crsObjTeamsId.getString("matchreferee");				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		try{
			vparam.add(UMP_ROLE);//To insert first Umpire1 Id's in Combo box.
			vparam.add(team1Id);
			vparam.add(team2Id);
			vparam.add(mId);
			vparam.add(Preval);
			vparam.add(Postval);
			crsObjUmpire1 = lobjGenerateProc.GenerateStoreProcedure("dsp_scorerlist1",vparam,"ScoreDB");
		    vparam.removeAllElements();
		}catch(Exception e){
			e.printStackTrace();
		}
		try{
			vparam.add(UMP_ROLE);//To insert second Umpire2 Id's in Combo box.
			vparam.add(team1Id);
			vparam.add(team2Id);
			vparam.add(mId);
			vparam.add(Preval);
			vparam.add(Postval);
			crsObjUmpire2 = lobjGenerateProc.GenerateStoreProcedure("dsp_scorerlist1",vparam,"ScoreDB");
		    vparam.removeAllElements();	
		}catch(Exception e){
			e.printStackTrace();
		}
		
		try{
			vparam.add(UMP_ROLE);//To insert second Umpire2 Id's in Combo box.
			vparam.add(team1Id);
			vparam.add(team2Id);
			vparam.add(mId);
			vparam.add(Preval);
			vparam.add(Postval);
			crsObjUmpire3 = lobjGenerateProc.GenerateStoreProcedure("dsp_scorerlist1",vparam,"ScoreDB");
		    vparam.removeAllElements();	
		}catch(Exception e){
			e.printStackTrace();
		}		
				
		try{	
			vparam.add(UMP_COACH_ROLE);//To insert Umpire Coach id's in Combo box.
			vparam.add(team1Id);
			vparam.add(team2Id);
			vparam.add(mId);
			vparam.add(Preval);
			vparam.add(Postval);
			crsObjUmpireCoach = lobjGenerateProc.GenerateStoreProcedure("dsp_scorerlist1",vparam,"ScoreDB");
		    vparam.removeAllElements();	
		}catch(Exception e){
			e.printStackTrace();
		}
		try{	
			vparam.add(REFEREE_ROLE);//To insert Referee id's in Combo box.
			vparam.add(team1Id);
			vparam.add(team2Id);
			vparam.add(mId);
			vparam.add(Preval);
			vparam.add(Postval);
			crsObjMatchReferee = lobjGenerateProc.GenerateStoreProcedure("dsp_scorerlist1",vparam,"ScoreDB");
		    vparam.removeAllElements();	
		}catch(Exception e){
			e.printStackTrace();
		}
%>
			<div id="MatchUmp1Div">
				<%if(crsObjUmpire1 != null){%>						
				<select name="dpUmpire1<%=mId%>" id="dpUmpire1<%=mId%>" >									
					<%if(umpire1 == null){%>
					<option value=""></option>
					<%}else{%>
					<option value="<%=umpire1_id%>"><%=umpire1%></option>
					<%}%>
					<option value=""></option>
					<%while(crsObjUmpire1.next()){%>
		<%if(crsObjUmpire1.getString("umpireid").equalsIgnoreCase(umpire1_id)){
		%>
					<option value="<%=crsObjUmpire1.getString("umpireid")%>" selected="selected"><%=crsObjUmpire1.getString("umpirename")%></option>
		<%}else{%>
					<option value="<%=crsObjUmpire1.getString("umpireid")%>" ><%=crsObjUmpire1.getString("umpirename")%></option>
		<%}	%>
					<%}%>
				</select>
				<%}%>
			</div>
			<br>
			<div id="MatchUmp2Div">
				<%if(crsObjUmpire2 != null){%>														
				<select name="dpUmpire2<%=mId%>" id="dpUmpire2<%=mId%>" >									
					<%if(umpire2 == null){%>
					<option value=""></option>
					<%}else{%>
					<option value="<%=umpire2_id%>"><%=umpire2%></option>
					<%}%>							
					<option value=""></option>
					<%while(crsObjUmpire2.next()){%>
		<%if(crsObjUmpire2.getString("umpireid").equalsIgnoreCase(umpire2_id)){%>				
					<option value="<%=crsObjUmpire2.getString("umpireid")%>" selected="selected"><%=crsObjUmpire2.getString("umpirename")%></option>
		<%}else{%>
					<option value="<%=crsObjUmpire2.getString("umpireid")%>" ><%=crsObjUmpire2.getString("umpirename")%></option>
		<%}	%>			
					<%}%>  
				</select>									
				<%}%>
			</div>
			<br>
			<div id="MatchUmp3Div">
				<%if(crsObjUmpire3 != null){%>														
				<select name="dpUmpire3<%=mId%>" id="dpUmpire3<%=mId%>" >									
					<%if(umpire3 == null){%>
					<option value=""></option>
					<%}else{%>
					<option value="<%=umpire3_id%>"><%=umpire3%></option>
					<%}%>							
					<option value=""></option>
					<%while(crsObjUmpire3.next()){%>
		<%if(crsObjUmpire3.getString("umpireid").equalsIgnoreCase(umpire3_id)){%>				
					<option value="<%=crsObjUmpire3.getString("umpireid")%>" selected="selected"><%=crsObjUmpire3.getString("umpirename")%></option>
		<%}else{%>
					<option value="<%=crsObjUmpire3.getString("umpireid")%>" ><%=crsObjUmpire3.getString("umpirename")%></option>
		<%}	%>			
					<%}%>  
				</select>									
				<%}%>
			</div>
			<br>
			<div id="MatchUmpCoachDiv">
				<%if(crsObjUmpireCoach != null){%>														
				<select name="dpUmpireCoach" id="dpUmpireCoach<%=mId%>">
					<%if(umpirecoach == null){%>
					<option value=""></option>
					<%}else{%>
					<option value="<%=umpirecoach_id%>"><%=umpirecoach%></option>
					<%}%>	
					
					<option value=""></option>
					<%while(crsObjUmpireCoach.next()){%>
		<%if(crsObjUmpireCoach.getString("umpirecoachid").equalsIgnoreCase(umpirecoach_id)){%>				
					<option value="<%=crsObjUmpireCoach.getString("umpirecoachid")%>" selected="selected"><%=crsObjUmpireCoach.getString("umpirecoachname")%></option>
		<%}else{%>
					<option value="<%=crsObjUmpireCoach.getString("umpirecoachid")%>" ><%=crsObjUmpireCoach.getString("umpirecoachname")%></option>
		<%}%>			
					<%}%>
				</select>
				<%}%>
			</div>
			<br>
			<div id="MatchrefereeDiv">
				<%if(crsObjMatchReferee != null){%>
				<select name="dpreferee" id="dpreferee<%=mId%>">
					<%if(matchreferee == null){%>
						<option value=""></option>
						<%}else{%>
						<option value="<%=referee_id%>" ><%=matchreferee%></option>
						<%}%>	
					
					<option value=""></option>
					<%while(crsObjMatchReferee.next()){%>
				<%if(crsObjMatchReferee.getString("refereeid").equalsIgnoreCase(referee_id)){%>			
					<option value="<%=crsObjMatchReferee.getString("refereeid")%>" selected="selected"><%=crsObjMatchReferee.getString("refereename")%></option>
				<%}else{%>
					<option value="<%=crsObjMatchReferee.getString("refereeid")%>"><%=crsObjMatchReferee.getString("refereename")%></option>
				<%}%>				
			<%}%>
				</select>
				<%}%>
			</div>