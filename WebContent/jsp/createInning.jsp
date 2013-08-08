<%@ 
	page import="sun.jdbc.rowset.CachedRowSet,
		java.text.SimpleDateFormat,java.text.NumberFormat,
		in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
		java.util.*"
%>

<%
		String 	GSDate			= "";
		String 	gsActDate		= "";
		String matchId = (String)session.getAttribute("matchId1"); 										
		String 	gsTeam1 		= request.getParameter("team1");		
		String 	gsTeam2 		= request.getParameter("team2");
		String gsweatherType 	= request.getParameter("tournamentid");
		String gspitchCondition = request.getParameter("venueId");
		String gsTossWinner 	= request.getParameter("team1Id");						
		GenerateStoreProcedure  lobjGenerateProc	= new GenerateStoreProcedure(matchId);								               
        CachedRowSet 			WeatherDayRepo 		= null;
		CachedRowSet 			PitchCondition 		= null;
		CachedRowSet 			selectedTeam 		= null;
		CachedRowSet  			crsweatherPitchDetail 	= null;
		CachedRowSet  			crsmatchId 	= null;
		
		Vector					vparam 				= new Vector();
		Calendar		 		cal 				= Calendar.getInstance();
		//Archana To insert the record in database.										 	
		String weatherDayId		= request.getParameter("dpWeatherDay");
		String pchCondId 		= request.getParameter("dppitchCondition");
		String tossId 			= request.getParameter("dpTossWon");
		String chooseToId 		= request.getParameter("dpChooseTo");
		String 	scoring_type    = null;
		try{
			vparam.add(matchId);
			crsmatchId = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concisematch",vparam,"ScoreDB");																					
			vparam.removeAllElements();	
			if(crsmatchId!=null){
				while(crsmatchId.next()){				
					scoring_type = crsmatchId.getString("scoring_type");
				}
			}
			vparam.removeAllElements();
		}catch(Exception e){
			e.printStackTrace();
		}	
		if(!scoring_type.equalsIgnoreCase("C")){
			vparam.add(matchId);	
			vparam.add(weatherDayId);
			vparam.add(pchCondId);
			vparam.add(tossId);
			vparam.add(chooseToId);					
			crsweatherPitchDetail = lobjGenerateProc.GenerateStoreProcedure("esp_amd_weather_toss_pitch",vparam,"ScoreDB");																					
			vparam.removeAllElements();
			out.println("success");
		}else{
			out.println("notsuccess");
		}

		
				//end Archana 					
%>
