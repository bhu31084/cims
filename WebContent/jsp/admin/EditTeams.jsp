<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<% 
   
    String matchId = request.getParameter("matchid")==null?"0":request.getParameter("matchid");
    String flag = request.getParameter("flag")==null?"0":request.getParameter("flag");
    String matchteamplayerid = request.getParameter("match_team_player_id")==null?"0":request.getParameter("match_team_player_id");
    String teamPlayerId = request.getParameter("team_player_id")==null?"0":request.getParameter("team_player_id");
    String teamId = request.getParameter("team_id")==null?"0":request.getParameter("team_id");
    String newTeamPlayerId = request.getParameter("new_team_player_id")==null?"0":request.getParameter("new_team_player_id");
    String player1 =  request.getParameter("player1")==null?"0":request.getParameter("player1");
    String player2 =  request.getParameter("player2")==null?"0":request.getParameter("player2");
    String inningId = request.getParameter("id")==null?"0":request.getParameter("id");
    String spflag = request.getParameter("spflag")==null?"0":request.getParameter("spflag");
    String team1id = "";
    String team2id = "";
    String team1name = "";
    String team2name = "";
    String Result = null;
    
    CachedRowSet lobjCachedRowSet =	null;
    CachedRowSet crsObjUpdatePlayer = null;
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
	Vector vparam = new Vector();
try{
    if(flag.equalsIgnoreCase("4")){
        vparam.add(inningId); // inningId
        vparam.add(player1); // player1
        vparam.add(player2); // player2
        vparam.add(spflag); // spflag
        lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_amd_swaplayer",vparam,"ScoreDB");
		if(lobjCachedRowSet != null && lobjCachedRowSet.size() > 0){	
		      while(lobjCachedRowSet.next()){
		         Result=lobjCachedRowSet.getString("result")==null?"Error in database plase try again":lobjCachedRowSet.getString("result"); 
		      }
		}
		out.print(Result);
   	}else if(flag.equalsIgnoreCase("1")){
        vparam.add(matchId); // matchId
		lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_twoteam",vparam,"ScoreDB");
		if(lobjCachedRowSet != null && lobjCachedRowSet.size() > 0){	
            while(lobjCachedRowSet.next()){
                team1id = lobjCachedRowSet.getString("team1id")==null?"0":lobjCachedRowSet.getString("team1id");
                team2id = lobjCachedRowSet.getString("team2id")==null?"0":lobjCachedRowSet.getString("team2id");
                team1name = lobjCachedRowSet.getString("team1")==null?"0":lobjCachedRowSet.getString("team1");
                team2name = lobjCachedRowSet.getString("team2")==null?"0":lobjCachedRowSet.getString("team2");
            }
		}
     }else if(flag.equalsIgnoreCase("2")){
          vparam.add(matchteamplayerid); 
          vparam.add(teamPlayerId); 
          vparam.add(teamId); 
          vparam.add(newTeamPlayerId); 
          vparam.add(matchId); // matchId
          vparam.add("1"); //flag
          crsObjUpdatePlayer = lobjGenerateProc.GenerateStoreProcedure("esp_amd_update_match_player",vparam,"ScoreDB");
          if(crsObjUpdatePlayer!=null){
              while(crsObjUpdatePlayer.next()){
                 Result=crsObjUpdatePlayer.getString("result")==null?"Error in database plase try again":crsObjUpdatePlayer.getString("result");
              }
          }
          out.print(Result);
     } else if(flag.equalsIgnoreCase("3")){
          vparam.add("0"); 
          vparam.add("0"); 
          vparam.add("0"); 
          vparam.add(newTeamPlayerId); 
          vparam.add(matchId); // matchId
          vparam.add("2"); //flag
          crsObjUpdatePlayer = lobjGenerateProc.GenerateStoreProcedure("esp_amd_update_match_player",vparam,"ScoreDB");
          if(crsObjUpdatePlayer!=null){
              while(crsObjUpdatePlayer.next()){
                 Result=crsObjUpdatePlayer.getString("result")==null?"Error in database plase try again":crsObjUpdatePlayer.getString("result");
              }
          }
          out.print(Result);
     } 
 	 	
if(flag.equalsIgnoreCase("1")){	
%>
<html>
<body>
	<SELECT name="team" id="team">
            <OPTION value="<%=team1id%>"><%=team1name%></OPTION>
            <OPTION value="<%=team2id%>"><%=team2name%></OPTION>	
	</select>					

</body>
</html>
<%} // end of if  
  }catch (Exception e) {
    e.printStackTrace();
    }
%>