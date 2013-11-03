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
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
		//String strSeriesTypeId ="";
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

			Map<String,String> seriesMap = null;
			if(null != strTournamentId && !"".equals(strTournamentId) && !"null".equals(strTournamentId)){
				try {
					/*StringBuilder sbSQL = new StringBuilder("SELECT sm.id,stm.name as tournament, stm.id as series_type_id, sn.id as season_id, sn.name as season");
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
					rs.close();*/
					
					StringBuilder sbSQL = new StringBuilder("SELECT tourn.description as tournament_name,");
					sbSQL.append(" seriestypes.description as group_name,");
					sbSQL.append(" series.type as series_type_id,");
					sbSQL.append(" season.id as season_id,");
					sbSQL.append(" season.name as season_name");  
					sbSQL.append(" FROM tournament_series_map as tsm");
					sbSQL.append(" INNER JOIN tournament_mst as tourn on tourn.id = tsm.tournament_id");
					sbSQL.append(" INNER JOIN series_mst as series on series.id = tsm.series_id");
					sbSQL.append(" INNER JOIN seriestypes_mst as seriestypes on seriestypes.id = series.type");
					sbSQL.append(" INNER JOIN seasons_mst as season on series.season = season.id");
					sbSQL.append(" WHERE tourn.id = "+strTournamentId);
					sbSQL.append(" ORDER BY tsm.series_id");

					ResultSet rs = stmt.executeQuery(sbSQL.toString());
					if (rs != null) {
						if(rs.next()){
						
							//For first Records
							// Season and Tournament name will be same for all records
							seriesMap = new HashMap<String, String>();
							
							seriesMap.put(rs.getString("series_type_id"), rs.getString("group_name"));
							strTournamentName = rs.getString("tournament_name");
							strSeasonId = rs.getString("season_id");
							strSeasonName = rs.getString("season_name");
						}
						while(rs.next()){
							// For subsequebt records
							seriesMap.put(rs.getString("series_type_id"), rs.getString("group_name"));
						}
					}
					rs.close();

				
				} catch (Exception e) {
					e.printStackTrace();
					strXmlStatus = "Incomplete";
					strStatus = "FAILURE";
				}
			}

			if(!"".equals(strSeasonName) && !"".equals(strTournamentName) && !"".equals(strSeasonId) &&  seriesMap != null){

				
				Set<String> seriesTypeSet = seriesMap.keySet();
				Iterator<String> iter = seriesTypeSet.iterator();
				
				sbFinalXML.append(" <Tournament name=");
				sbFinalXML.append("'"+strTournamentName+"'");
				//sbFinalXML.append(" id='"+strSeriesTypeId+"'");
				sbFinalXML.append(" />");

				sbFinalXML.append(" <Season name=");
				sbFinalXML.append("'"+strSeasonName+"'");
				sbFinalXML.append(" id='"+strSeasonId+"'");
				sbFinalXML.append(" />");

				sbFinalXML.append(" <Status msg='" + strStatus + "' />");
				sbFinalXML.append(" <Groups>");
				
				try{
					while(iter.hasNext()){
						String strSeriesTypeId =  iter.next();
						String strGroupName = seriesMap.get(strSeriesTypeId);
		
						sbFinalXML.append("<Group name= '"+strGroupName+"' id='"+strSeriesTypeId+"'>");
						GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
						Vector vparam = new Vector();
						vparam.add(strSeriesTypeId);
						vparam.add(strSeasonId);
		
						CachedRowSet crsObjGetMatchPt = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchpointstally", vparam, "ScoreDB");
						vparam.removeAllElements();
		
						if(crsObjGetMatchPt != null ){
							
							while(crsObjGetMatchPt.next()){
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
								
								if(crsObjGetMatchPt.getString("team_id") != null){
									strTeamId = crsObjGetMatchPt.getString("team_id");
								}
								if(crsObjGetMatchPt.getString("team_name") != null){
									strTeamName = crsObjGetMatchPt.getString("team_name");
								}
								
								if(crsObjGetMatchPt.getString("team_id") != null){
									strTeamId = crsObjGetMatchPt.getString("team_id");
								}
								if(crsObjGetMatchPt.getString("team_id") != null){
									strTeamId = crsObjGetMatchPt.getString("team_id");
								}
								if(crsObjGetMatchPt.getString("Played") != null){
									strMatchPlayed = crsObjGetMatchPt.getString("Played");
								}
								if(crsObjGetMatchPt.getString("points") != null){
									strPoints = crsObjGetMatchPt.getString("points");
								}
								if(crsObjGetMatchPt.getString("Win") != null){
									strMatchWin = crsObjGetMatchPt.getString("Win");
								}
								if(crsObjGetMatchPt.getString("Draw") != null){
									strMatchDraw = crsObjGetMatchPt.getString("Draw");
								}
								if(crsObjGetMatchPt.getString("Tie") != null){
									strMatchTie = crsObjGetMatchPt.getString("Tie");
								}
								if(crsObjGetMatchPt.getString("abandon") != null){
									strMatchAban = crsObjGetMatchPt.getString("abandon");
								}
								if(crsObjGetMatchPt.getString("Loss") != null){
									strMatchLost = crsObjGetMatchPt.getString("Loss");
								}
								if(crsObjGetMatchPt.getString("RunRate") != null){
									strNRR= crsObjGetMatchPt.getString("RunRate");
								}
								if(crsObjGetMatchPt.getString("Quotient") != null){
									strQuotient= crsObjGetMatchPt.getString("Quotient");
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
								sbFinalXML.append(" </Table>");
	
							}
						}
						
						sbFinalXML.append("</Group>");
					}
				}
				finally{
					sbFinalXML.append(" </Groups>");
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
