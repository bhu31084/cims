
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
				 java.text.SimpleDateFormat,
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
                Calendar cal = 	Calendar.getInstance();
                String matchId = (String)session.getAttribute("matchId1");
                String flag =null;
                String inningId = null;
                String striker = null;
                String nonStriker = null;
                String blower = null;
                String pitchPos = null;
                String groundPos = null;
                String bowlstyle = null;
                String overNum = null;
                String overWkt = null;
                String penalty = null;
                String newBall = null;
                String description = null;
                String runtype = null;
                String dismissalType = null;
                String dismissalBatsman = null;
                String dismissalBy1  = null;
                String dismissalBy2 = null;
                String extratype = null;
                String canreturn = null;
                String extrarun = null;
                String Result	= null;
                String gsdate = "";
                String authentic = "";
                authentic = "Y";
				if(request.getParameter("onlineflag").equalsIgnoreCase("online") && request.getParameter("onlineflag")!=null){
					gsdate = new SimpleDateFormat("MM/dd/yyyy HH:MM:ss").format(cal.getTime());	
					authentic = "Y";
				}               
                if(request.getParameter("onlineflag").equalsIgnoreCase("ofline") && request.getParameter("onlineflag")!=null){
					gsdate = request.getParameter("offlinedate");
					authentic = "N";
				} 
                if(request.getParameter("flag")==null || request.getParameter("flag")=="null"){
                	flag="1"; 
                }else{
                  flag= request.getParameter("flag");
                }
                if(request.getParameter("inning_id").equalsIgnoreCase(null)||request.getParameter("inning_id").equalsIgnoreCase("null")){
                    inningId = "0";
                }else{
                   inningId = request.getParameter("inning_id");
                }
                if(request.getParameter("striker").equalsIgnoreCase(null)||request.getParameter("striker").equalsIgnoreCase("null")){
                   striker ="0";
                }else{
                    striker = request.getParameter("striker");
                }
                if(request.getParameter("non_striker").equalsIgnoreCase(null)||request.getParameter("non_striker").equalsIgnoreCase("null")){
                   nonStriker ="0";
                }else{
                   nonStriker =request.getParameter("non_striker");
                }
                if(request.getParameter("blower").equalsIgnoreCase(null) || request.getParameter("blower").equalsIgnoreCase("null")){
                    blower = "0";
                }else{
                  blower = request.getParameter("blower");
                }
                if(request.getParameter("pitch_pos").equalsIgnoreCase(null) ||request.getParameter("pitch_pos").equalsIgnoreCase("null")){
                    pitchPos = "0";
                }else{
                    pitchPos = request.getParameter("pitch_pos");
                }
                if(request.getParameter("ground_pos").equalsIgnoreCase(null) ||request.getParameter("ground_pos").equalsIgnoreCase("null")){
                    groundPos = "0";
                }else{
                    groundPos = request.getParameter("ground_pos");
                }
                if(request.getParameter("bowlstyle").equalsIgnoreCase(null) ||request.getParameter("bowlstyle").equalsIgnoreCase("null")){
                    bowlstyle = "0";
                }else{
                    bowlstyle = request.getParameter("bowlstyle");
                }
                if(request.getParameter("over_num").equalsIgnoreCase(null) ||request.getParameter("over_num").equalsIgnoreCase("null")){
                    overNum = "0";
                }else{
                    overNum = request.getParameter("over_num");
                }
                if(request.getParameter("over_wkt").equalsIgnoreCase(null) ||request.getParameter("over_wkt").equalsIgnoreCase("null")){
                    overWkt = "Y";
                }else{
                    overWkt = request.getParameter("over_wkt");
                }
                if(request.getParameter("penalty").equalsIgnoreCase(null) ||request.getParameter("penalty").equalsIgnoreCase("null")){
                    penalty = "0";
                }else{
                    penalty = request.getParameter("penalty");
                }
                if(request.getParameter("new_ball").equalsIgnoreCase(null) ||request.getParameter("new_ball").equalsIgnoreCase("null")){
                    newBall = "N";
                }else{
                    newBall = request.getParameter("new_ball");
                }
                if(request.getParameter("description").equalsIgnoreCase(null) ||request.getParameter("description").equalsIgnoreCase("null")){
                    description = "default";
                }else{
                    description = request.getParameter("description");
                }
                if(request.getParameter("runtype").equalsIgnoreCase(null) ||request.getParameter("runtype").equalsIgnoreCase("null")){
                    runtype = "0";
                }else{
                    runtype = request.getParameter("runtype");
                }
                if(request.getParameter("dismissalType").equalsIgnoreCase(null) ||request.getParameter("dismissalType").equalsIgnoreCase("null")){
                    dismissalType = "0";
                }else{
                    dismissalType = request.getParameter("dismissalType");
                }
                if(request.getParameter("dismissalBatsman").equalsIgnoreCase(null) ||request.getParameter("dismissalBatsman").equalsIgnoreCase("null")){
                    dismissalBatsman = "0";
                }else{
                    dismissalBatsman = request.getParameter("dismissalBatsman");
                }
                if(request.getParameter("dismissalBy1").equalsIgnoreCase(null) ||request.getParameter("dismissalBy1").equalsIgnoreCase("null")){
                    dismissalBy1 = "0";
                }else{
                    dismissalBy1 = request.getParameter("dismissalBy1");
                }
                if(request.getParameter("dismissalBy2").equalsIgnoreCase(null) ||request.getParameter("dismissalBy2").equalsIgnoreCase("null")){
                    dismissalBy2 = "0";
                }else{
                    dismissalBy2 = request.getParameter("dismissalBy2");
                }
                if(request.getParameter("extratype").equalsIgnoreCase(null) ||request.getParameter("extratype").equalsIgnoreCase("null")){
                    extratype = "0";
                }else{
                    extratype = request.getParameter("extratype");
                }if(request.getParameter("canreturn").equalsIgnoreCase(null) ||request.getParameter("canreturn").equalsIgnoreCase("null")){
                    canreturn = "N";
                }else{
                    canreturn = request.getParameter("canreturn");
                }
                if(request.getParameter("extrarun").equalsIgnoreCase(null) ||request.getParameter("extrarun").equalsIgnoreCase("null")){
                    extrarun = "0";
                }else{
                    extrarun = request.getParameter("extrarun");
                }
                
                CachedRowSet  crs = null;
				GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
				Vector vparam =  new Vector();

                vparam.add(inningId);
                vparam.add(gsdate);
                vparam.add(striker);
                vparam.add(nonStriker);
                vparam.add(blower);
                vparam.add(pitchPos);
                vparam.add(groundPos);
                vparam.add(bowlstyle);
                vparam.add(overNum);
                vparam.add(overWkt);
                vparam.add(penalty);
                vparam.add(newBall);
                vparam.add(description);
                vparam.add(runtype);
                vparam.add(extratype);
                vparam.add(extrarun);
                vparam.add(dismissalType);
                vparam.add(dismissalBatsman);
                vparam.add(dismissalBy1);
                vparam.add(dismissalBy2);
                vparam.add(canreturn);
                vparam.add(authentic);
                vparam.add(flag);
		        crs = lobjGenerateProc.GenerateStoreProcedure("amd_ball",vparam,"ScoreDB");
				vparam.removeAllElements();
              	while(crs.next()){
              		Result = crs.getString("remark");
              	}
              	//response.flushBuffer();
				out.print(Result);
	}catch(Exception e){
            e.printStackTrace();
             //log.writeErrLog(page.getClass(),matchId,e.toString());
    }	
 %>
