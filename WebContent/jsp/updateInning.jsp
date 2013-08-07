<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
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
%>
<%
		try{
                String flag =request.getParameter("flag"); // set flag for update end time 
                String inning_id = request.getParameter("inning_id");
                CachedRowSet  crs = null;
				GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
				Vector vparam =  new Vector();
                vparam.add(flag);
                vparam.add(inning_id);
                crs = lobjGenerateProc.GenerateStoreProcedure("amd_inning",vparam,"ScoreDB");
				vparam.removeAllElements();
              


        }catch(Exception e){
            e.printStackTrace();
            
        }


%>
