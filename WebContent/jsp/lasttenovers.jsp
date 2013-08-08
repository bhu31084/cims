<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<%	String matchId = (String)session.getAttribute("matchId1");
   	String inningId = (String)session.getAttribute("InningId");
	String pageNumber = request.getParameter("pageNumber");
	String flag	= request.getParameter("lastTenOverFlag");
	CachedRowSet lobjCachedRowSet =	null;
	LogWriter log = new LogWriter();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
	Vector vparam = new Vector();
	String gsovers = "";
	String gsbowler	= "";
	String gsruns =	"";
	String gswickets = "";
	String gsTotal = "";	
	String gsNoOfPages = "";	
		
try{
	vparam.add(pageNumber); // pageNumber
	vparam.add(inningId); // inning_id
	vparam.add(flag); // flag 1 for paging and 0 for last 10 ovrs
	lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsplasttenoverdtls_paging_flag",vparam,"ScoreDB");
	
	if(lobjCachedRowSet != null && lobjCachedRowSet.size() > 0){	
		while(lobjCachedRowSet.next()){
			gsovers = gsovers + lobjCachedRowSet.getString("over_num") + " ~ ";
			gsbowler= gsbowler + lobjCachedRowSet.getString("bowler") + " , ";
			gsruns= gsruns + lobjCachedRowSet.getString("runs") + " , ";
			gswickets= gswickets + lobjCachedRowSet.getString("wickets") + " , ";
			gsTotal = gsTotal + lobjCachedRowSet.getString("totalruns") + " , ";
			gsNoOfPages = gsNoOfPages + lobjCachedRowSet.getString("noofpages") + " , ";
			
		}
	}
}catch (Exception e) {
	System.out.println("*************lasttenovers.jsp*****************"+e);
	System.out.println("matchId---"+matchId);
	e.printStackTrace();
	log.writeErrLog(page.getClass(),matchId,e.toString());
}  		
	
%>
<html>
<body>
<%=":"+gsovers+"$"+gsbowler+"$"+gsruns+"$"+gswickets+"$"+gsTotal+"$"+gsNoOfPages+":"%>
<%--<input type="hidden" id="hdOvers" name="hdOvers" value="<%=gsovers%>">--%>
</body>
</html>
