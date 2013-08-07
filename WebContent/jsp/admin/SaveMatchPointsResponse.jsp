<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires",0);
	String gsmatch_id = request.getParameter("match_id")==null?"0":request.getParameter("match_id");
	String gsteam1_pt = request.getParameter("team1_pt")==null?"0":request.getParameter("team1_pt");
	String gsteam2_pt = request.getParameter("team2_pt")==null?"0":request.getParameter("team2_pt");

	String retval = "";
	String message = "";

	CachedRowSet  crsObjSaveMatchPoints = null;

	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();

		//To save Team Points Data.
		if(request.getParameter("match_id")!= null){
			try{
				vparam.add(gsmatch_id);
				vparam.add(gsteam1_pt);
				vparam.add(gsteam2_pt);
				crsObjSaveMatchPoints = lobjGenerateProc.GenerateStoreProcedure("esp_amd_matchpoints",vparam,"ScoreDB");
				vparam.removeAllElements();
			}catch(Exception e){
				e.printStackTrace();
			}
			if(crsObjSaveMatchPoints != null){
				while(crsObjSaveMatchPoints.next()){
					retval = crsObjSaveMatchPoints.getString("RetVal");
				}
			}
		}
%>
<div id="SavedMatchPointsDiv"><label><font color="red"><%=retval%></font></label></div>