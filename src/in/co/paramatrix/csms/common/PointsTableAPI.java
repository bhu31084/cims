package in.co.paramatrix.csms.common;

import in.co.paramatrix.csms.connection.ConnectionManagerHandler;
import in.co.paramatrix.csms.generalamd.GenerateStoreProcedure;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.jdbc.rowset.CachedRowSet;

public class PointsTableAPI extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String strTournamentId = "";
		if(request.getParameter("tournament") != null){
			strTournamentId = request.getParameter("tournament");
		}
		String strSeasonName = "";
		String strTournamentName = "";
		String strSeasonId = "";
		String strSeriesTypeId ="";
		/*
		if(request.getParameter("season") != null){
			strSeasonName = request.getParameter("season");
		}
		if(request.getParameter("tournament") != null){
			strTournamentName = request.getParameter("tournament");
		}
		*/
		String strStatus = "SUCCESS";
		Connection conn = null;
		Statement stmt = null;
		String strFinalXML = "";
		String strXmlStatus = "Complete";
		StringBuilder sbFinalXML = new StringBuilder("<PointTable>");
		List<Map<String,String>> pointTableList = null;
		
		try {
			
			// Get DB connection
			conn = ConnectionManagerHandler.getConnection("ScoreDB");
			stmt = conn.createStatement();
	
			/*if(!"".equals(strSeasonName)){
				// Get the season ID for requested season from seasons_mst
				String strSQL = "SELECT id FROM seasons_mst WHERE status='A' AND name='"+strSeasonName+"'";
				ResultSet rs = stmt.executeQuery(strSQL);
				if (rs != null && rs.next()) {
					strSeasonId = rs.getString("id");
				}
				rs.close();
			}
			
			if(!"".equals(strTournamentName)){
				//Get Series Id for request tournament
				String strSQL = "Select id from seriestypes_mst WHERE name='" + strTournamentName + "' AND status='A'";
				ResultSet rs = stmt.executeQuery(strSQL);
				if (rs != null && rs.next()) {
					strSeriesTypeId = rs.getString("id");
				}
				rs.close();
			}
			*/

			if(null != strTournamentId && !"".equals(strTournamentId) && !"null".equals(strTournamentId)){
				try {
					StringBuilder sbSQL = new StringBuilder("SELECT sm.id,stm.name as tournament, stm.id as series_type_id, sn.id as season_id, sn.name as season"); 
					sbSQL.append(" FROM series_mst as sm ");
					sbSQL.append(" INNER JOIN seriestypes_mst as stm ON sm.type = stm.id");
					sbSQL.append(" INNER JOIN seasons_mst as sn ON sm.season = sn.id");
					sbSQL.append(" WHERE sm.status='A'");
					sbSQL.append(" AND stm.status = 'A'");
					sbSQL.append(" AND sn.status = 'A'");
					sbSQL.append(" AND sm.id = '"+strTournamentId+"'");
					ResultSet rs = stmt.executeQuery(sbSQL.toString());
					if (rs != null && rs.next()) {
						strSeriesTypeId = rs.getString("series_type_id");
						strTournamentName = rs.getString("tournament");
						strSeasonId = rs.getString("season_id");
						strSeasonName = rs.getString("season");
					}
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
					strXmlStatus = "Incomplete";
					strStatus = "FAILURE";
				}
			}

			if(!"".equals(strSeasonName) && !"".equals(strTournamentName) && !"".equals(strSeasonId) &&  !"".equals(strSeriesTypeId)){
			
				GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
				Vector vparam = new Vector();
				vparam.add(strSeriesTypeId);
				vparam.add(strSeasonId);
			
				CachedRowSet crsObjGetMatchPt = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchpointstally", vparam, "ScoreDB");								
				vparam.removeAllElements();
				
				
				if(crsObjGetMatchPt != null ){
					pointTableList = new ArrayList<Map<String,String>>();
					
					while(crsObjGetMatchPt.next()){
						
						Map<String,String> dataMap = new HashMap<String, String>(12);
						
						dataMap.put("team_id", crsObjGetMatchPt.getString("team_id"));
						dataMap.put("team_name", crsObjGetMatchPt.getString("team_name"));
						dataMap.put("Played", crsObjGetMatchPt.getString("Played"));
						dataMap.put("points", crsObjGetMatchPt.getString("points"));
						dataMap.put("Win", crsObjGetMatchPt.getString("Win"));
						dataMap.put("Draw", crsObjGetMatchPt.getString("Draw"));
						dataMap.put("Tie", crsObjGetMatchPt.getString("Tie"));
						dataMap.put("Aban", crsObjGetMatchPt.getString("abandon"));
						dataMap.put("Loss", crsObjGetMatchPt.getString("Loss"));
						dataMap.put("RunRate", crsObjGetMatchPt.getString("RunRate"));
						dataMap.put("Quotient", crsObjGetMatchPt.getString("Quotient"));
						
						pointTableList.add(dataMap);
					}
			
				}
				
			}else{
				strStatus = "FAILURE";
				strXmlStatus = "Incomplete";
			}
		}catch (Exception e) {
			e.printStackTrace();
			strXmlStatus = "Incomplete";
		}
		finally{
			ConnectionManagerHandler.releaseConnection(conn, "ScoreDB");
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			stmt = null;
			conn = null;
		}
		
		sbFinalXML.append(" <Tournament name=");
		sbFinalXML.append("'"+strTournamentName+"'");
		sbFinalXML.append(" id='"+strSeriesTypeId+"'");
		sbFinalXML.append(" />");
		
		sbFinalXML.append(" <Season name=");
		sbFinalXML.append("'"+strSeasonName+"'");
		sbFinalXML.append(" id='"+strSeasonId+"'");
		sbFinalXML.append(" />");
		
		sbFinalXML.append(" <Status msg='" + strStatus + "' />");
		
		//Get data of Point Table
		if(pointTableList != null && pointTableList.size() > 0){
			
			for(Map<String,String> dataMap : pointTableList){
				if(dataMap != null){
					
					String strTeamId = "";
					String strTeamName = "";
					String strMatchPlayed = "";
					String strMatchWin = "";
					String strMatchLost = "";
					String strMatchTie = "";
					String strMatchDraw = "";
					String strMatchAban = "";
					String strPoints = "";
					String strNRR = "";
					String strNR = "";
					String strQuotient = "";
					
					
					if(dataMap.get("team_id") != null){
						strTeamId = dataMap.get("team_id");
					}
					if(dataMap.get("team_name") != null){
						strTeamName = dataMap.get("team_name");
					}
					if(dataMap.get("Played") != null){
						strMatchPlayed = dataMap.get("Played");
					}
					if(dataMap.get("points") != null){
						strPoints = dataMap.get("points");
					}
					if(dataMap.get("Win") != null){
						strMatchWin = dataMap.get("Win");
					}
					if(dataMap.get("Draw") != null){
						strMatchDraw = dataMap.get("Draw");
					}
					if(dataMap.get("Tie") != null){
						strMatchTie = dataMap.get("Tie");
					}
					if(dataMap.get("Aban") != null){
						strMatchAban = dataMap.get("Aban");
					}
					if(dataMap.get("Loss") != null){
						strMatchLost = dataMap.get("Loss");
					}
					if(dataMap.get("RunRate") != null){
						strNRR= dataMap.get("RunRate");
					}
					if(dataMap.get("NR") != null){
						strNR = dataMap.get("NR");
					}
					if(dataMap.get("Quotient") != null){
						strQuotient = dataMap.get("Quotient");
					}
					
					sbFinalXML.append(" <Table>");
					sbFinalXML.append(" <team name=");
					sbFinalXML.append("'"+strTeamName+"'");
					sbFinalXML.append(" id='"+strTeamId+"'");
					sbFinalXML.append("/>");
					
					sbFinalXML.append(" <MatchPlayed value='" + strMatchPlayed + "' />");
					sbFinalXML.append(" <MatchWon value='" + strMatchWin + "' />");
					sbFinalXML.append(" <MatchLost value='" + strMatchLost + "' />");
					sbFinalXML.append(" <MatchDraw value='" + strMatchDraw + "' />");
					sbFinalXML.append(" <MatchTie value='" + strMatchTie + "' />");
					sbFinalXML.append(" <MatchAban value='" + strMatchAban + "' />");
					sbFinalXML.append(" <Points value='" + strPoints + "' />");
					sbFinalXML.append(" <NR value='" + strNR + "' />");
					sbFinalXML.append(" <NRR value='" + strNRR + "' />");
					sbFinalXML.append(" <Quotient value='" + strQuotient + "' />");
					sbFinalXML.append(" <Group id='' />");
					sbFinalXML.append(" </Table>");
				}
			}
			
			//sbFinalXML.append(" </Table>");
		}
		
		sbFinalXML.append("<xmlstatus>"+strXmlStatus + "</xmlstatus>");
		sbFinalXML.append(" </PointTable>");
		
		strFinalXML = sbFinalXML.toString().replace("&", " and ");
		String output = new String(strFinalXML.getBytes("UTF-8"), "ISO-8859-1");
		response.setContentType("text/xml");
		PrintWriter out = response.getWriter();
		System.out.println(output);
		out.print(output);

	}

}
