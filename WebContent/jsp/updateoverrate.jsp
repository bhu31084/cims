<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.text.SimpleDateFormat,
				java.util.*"
%>	
<%  	response.setHeader("Pragma","private");
		response.setHeader("Pragma", "No-cache");
	    response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");  
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);

	try{
	    CachedRowSet overrateCachedRowSet = null;
    	String matchId	= (String)session.getAttribute("matchId1");
	    GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
        Vector vparam = new Vector();
		String overrate = "0";
		String flag  = request.getParameter("flag");  
		String inningid = request.getParameter("inningid"); 
		if (flag.equalsIgnoreCase("1")){ // cal over rate
			vparam.add(inningid);// // for Inning details 05/10/208
        	overrateCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_overrate", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
    	   	while(overrateCachedRowSet.next()){
       			overrate = overrateCachedRowSet.getString("oversRate");
       		}
       		out.print(overrate);
       }else if(flag.equalsIgnoreCase("2")){ // patenership detail;
       		String strikerId = request.getParameter("strikerId");
       		String nonStrikerId = request.getParameter("nonStrikerId");
       		String strikerName = request.getParameter("strikerName");
       		String nonStrikerName = request.getParameter("nonStrikerName");
       		String partershiprun = request.getParameter("partershiprun");
       		String totalball = request.getParameter("totalball");
       		String matchtime = request.getParameter("matchtime");
       		String result = "";
       		vparam.add(inningid);// // for Inning details 05/10/208
       		vparam.add(strikerId);
       		vparam.add(nonStrikerId);
       		vparam.add(strikerName);
       		vparam.add(nonStrikerName);
       		vparam.add(partershiprun);
       		vparam.add(totalball);
       		vparam.add(matchtime);
        	overrateCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_currentpatenership", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
    	   	while(overrateCachedRowSet.next()){
       			result = overrateCachedRowSet.getString("result");
       		}
       		out.print(result);
       }else if(flag.equalsIgnoreCase("3")){ // patenership detail;	
       		String type = request.getParameter("type");
       		vparam.add(inningid);// // for Inning details 05/10/208
        	vparam.add(type);// // for type 22/10/208
        	overrateCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_ball_sc_map", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
       }
  }catch(Exception e){
		e.printStackTrace();
	}
%>