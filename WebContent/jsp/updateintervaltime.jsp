<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				in.co.paramatrix.csms.common.Common,
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
	     Common commonUtil= new Common();
	    CachedRowSet intervalCachedRowSet = null;
	    CachedRowSet displayintervalCachedRowSet = null;
  		String 						matchId				=  (String)session.getAttribute("matchId1");
	    GenerateStoreProcedure		lobjGenerateProc 	=   new GenerateStoreProcedure(matchId);
	    Vector vparam = new Vector();
		String gsstartdate = null;
		String gsenddate = null;
		String hdstartdate = null;
		String inningid = request.getParameter("inningid");  
		String intervalid = request.getParameter("intervalid");  
		String startdate = request.getParameter("startdate")==null?"":commonUtil.formatDatewithTime(request.getParameter("startdate"));
		String enddate = request.getParameter("enddate")==null?"":commonUtil.formatDatewithTime(request.getParameter("enddate"));
		String gshdstartdate = request.getParameter("hdstartdate")==null?"":commonUtil.formatDatewithTime(request.getParameter("hdstartdate"));
		String gsflag = request.getParameter("flag")==null?"2": request.getParameter("flag");
		
		
	   	vparam.add(inningid);
		vparam.add(intervalid);
		vparam.add(startdate);
		vparam.add(enddate);
		vparam.add(gshdstartdate);
		vparam.add(gsflag);
		intervalCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_amd_adjustinterval", vparam, "ScoreDB"); // Batsman List
	    vparam.removeAllElements();
  }catch(Exception e){
		e.printStackTrace();
	}
%>