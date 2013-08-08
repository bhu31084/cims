<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"%>
<% try{					
                CachedRowSet  teamPlayersCachedRowSet 	= null;										
				CachedRowSet  crsTeamName				= null;
				CachedRowSet  crsmatchId				= null;
				Vector 			vparam 			= new Vector();
				int		 		flag			= 2;
				String   		team1			= null; 
				String   		team2			= null; 
				String   		captain			= null; 
				String   		wicketkeeper 	= null;
				String   		extraplayer 	= null;
				String 	 		palyerId		= null;	
				String 	 		extras			= null;	
				String 			team2name 		= null;	
				String 			scoring_type    = null;
				
				team1 			= request.getParameter("hdteam1");		
				team2 			= request.getParameter("hdteam2");
				captain 		= request.getParameter("hdCaptain");//request.getParameter("strCaptain");
				wicketkeeper 	= request.getParameter("hdWicketKeeper");//request.getParameter("strWicketkeeper");hdWicketKeeper
			    extraplayer 	= request.getParameter("hd12thMan");
			 	palyerId		= request.getParameter("hdteamPlayers");	
			 	extras			= request.getParameter("hdteamPlayersextra");		
			    	
//CALLING SP
//INSERTINg Team1 Players in the DB
			    String MatchId = (String)session.getAttribute("matchId1");
				GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(MatchId);
				vparam.add(MatchId);
				vparam.add(team1);
				vparam.add(palyerId);
				vparam.add(captain);
				vparam.add(wicketkeeper); 
				vparam.add(extraplayer); 
				vparam.add(extras); 					
				teamPlayersCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_teamplayers1",vparam,"ScoreDB");													
				vparam.removeAllElements();
				out.print("success");
   }catch(Exception e){
	   
   }
%>				