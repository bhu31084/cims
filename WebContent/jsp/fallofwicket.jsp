	<%--
  Created by IntelliJ IDEA.
  User: bhushanf
  Date: Aug 13, 2008
  Time: 12:01:56 PM
  To change this template use File | Settings | File Templates.
  modifyed Date:12-09-2008
--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>    
<%  	response.setHeader("Pragma","private");
		response.setHeader("Pragma", "No-cache");
	    response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
%>
<%
		try{
            String matchId = (String)session.getAttribute("matchId1");
            String flag =request.getParameter("flag");
            String inningId = request.getParameter("inningid");
            String time = "";
            String runs = "";
            String Srno = "";
            String overs = "";
            String result = "";
            CachedRowSet  crs = null;
			GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
			Vector vparam =  new Vector();
            if(flag.equalsIgnoreCase("1")){
               vparam.add(inningId);
	           crs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket",vparam,"ScoreDB");
			   vparam.removeAllElements();
        	   while(crs.next()){
            		Srno = Srno + crs.getString("srno") + "~";
            	  	runs = runs + crs.getString("runs") +"~";
            	  	overs = overs + crs.getString("overs") +"~";
              }
              String SrnoArr[] = Srno.split("~");
              String runsArr[] = runs.split("~");
              String oversArr[] = overs.split("~");
              for(int i=0;i<SrnoArr.length;i++){
						result = result +  SrnoArr[i]+"-"+runsArr[i] +"( "+oversArr[i]+" ovrs ),";
			  }
			
			out.print(result);
            }else if(flag.equalsIgnoreCase("2")){ // get last ball time
               vparam.add(inningId);
  	           crs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_balltime",vparam,"ScoreDB");
  			   vparam.removeAllElements();
          	   while(crs.next()){
          			 time = crs.getString("start_time");
                }
          	 out.print(time);
            }
	}catch(Exception e){
            e.printStackTrace();
             //log.writeErrLog(page.getClass(),matchId,e.toString());
    }	
 %>
