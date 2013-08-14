package in.co.paramatrix.csms.common;

import in.co.paramatrix.csms.connection.ConnectionManagerHandler;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.xmlbeans.impl.piccolo.io.FileFormatException;

public class UploadMatchSchedules extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException {
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String contentType = request.getContentType();
		// here we are checking the content type is not equal to Null and as well as the passed data from mulitpart/form-data is greater than or equal
		// to 0
		if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
			DataInputStream in = new DataInputStream(request.getInputStream());
			// we are taking the length of Content type data
			int formDataLength = request.getContentLength();
			byte dataBytes[] = new byte[formDataLength];
			int byteRead = 0;
			int totalBytesRead = 0;
			// this loop converting the uploaded file into byte code
			while (totalBytesRead < formDataLength) {
				byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
				totalBytesRead += byteRead;
			}

			String file = new String(dataBytes);
			// for saving the file name
			String saveFile = file.substring(file.indexOf("filename=\"") + 10);
			saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
			saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
			int lastIndex = contentType.lastIndexOf("=");
			String boundary = contentType.substring(lastIndex + 1, contentType.length());
			int pos;
			// extracting the index of file
			pos = file.indexOf("filename=\"");
			pos = file.indexOf("\n", pos) + 1;
			pos = file.indexOf("\n", pos) + 1;
			pos = file.indexOf("\n", pos) + 1;

			int boundaryLocation = file.indexOf(boundary, pos) - 4;
			int startPos = ((file.substring(0, pos)).getBytes()).length;
			int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

			// creating a new file with the same name and writing the content in new file
			FileOutputStream fileOut = new FileOutputStream(saveFile);
			fileOut.write(dataBytes, startPos, (endPos - startPos));

			Workbook workbook = null;
			Sheet sheet = null;
			int rows = 0;
			Map<String, String> dataMap = null;
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
			Map<Integer, List<String>> errorMap = new TreeMap<Integer, List<String>>();
			boolean validFile = true;
			List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
			String mapKey = null;
			// Check no of columns matched with requirement
			//String[] columns = {"Sr. No.", "Tournament Name", "Season", "Team1", "Team2", "Venue", "From Date", "To Date", "Match Type"};
			String columnsInOrder = "Sr. No.,Tournament Name,Season,Team1,Team2,Venue,From Date,To Date,Match Type,Round";
			String[] columns = columnsInOrder.split(",");
			HttpSession session = request.getSession(true);
			session.setAttribute("column", columnsInOrder);
			int headerSize = columns.length;
			String errorString = null;
			Map returnMap = new HashMap();
			try {
				File excelFile = new File(saveFile);
				FileInputStream fis = new FileInputStream(excelFile);
				workbook = WorkbookFactory.create(fis);
				sheet = workbook.getSheetAt(0);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
				validFile = false;
			} catch (FileFormatException e) {
				validFile = false;
				e.printStackTrace();
			} catch (Exception e) {
				validFile = false;
				e.printStackTrace();
			}
			Connection conn = null;
			Statement stmt = null;
			try {
				Row row = null;
				if (validFile) {
					rows = sheet.getPhysicalNumberOfRows();
					boolean headerFound=false;
					for(int rowCount=0; rowCount<rows; rowCount++){
						row = sheet.getRow(rowCount);
						if(row != null){
							headerFound = true;
							int noOfcols = row.getPhysicalNumberOfCells();
							if (noOfcols != headerSize) {
								errorString = "Coulmns Provided in sheet not matched with given format. <BR> Columns as per format :" + columnsInOrder + "<BR> Coulmns in Sheet : ";
								for (int i = 0; i < noOfcols; i++) {
									Cell cell = row.getCell(i);
									if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
										errorString += " '" + cell.getStringCellValue() + "'";
									} else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
										errorString += " '" + cell.getNumericCellValue() + "'";
									} else {
										errorString += "  ";
									}

								}
								validFile = false;
							}
							//If header found break the loop
							break;
						}
					}
					
					if(!headerFound){
						errorString = "No record found in Uploaded file.";
						validFile = false;	
					}

				} else {
					errorString = "Problem in reading data in file";
					validFile = false;
				}
				if (validFile) {
					for (int rowNo = 1; rowNo < rows; rowNo++) {
						row = sheet.getRow(rowNo);
						if (row != null) {
							dataMap = new HashMap<String, String>();
							for (int colNo = 1; colNo < 10; colNo++) {
								mapKey = columns[colNo];
								Cell cell = row.getCell(colNo);

								if (cell != null) {
									if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
										if (mapKey.equalsIgnoreCase("From Date") || mapKey.equalsIgnoreCase("To Date")) {
											dataMap.put(mapKey, sdf.format(cell.getDateCellValue()));
										} else {
											dataMap.put(mapKey, "" + cell.getNumericCellValue());
										}
									} else if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
										dataMap.put(mapKey, cell.getStringCellValue());
									} else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
										dataMap.put(mapKey, "" + cell.getBooleanCellValue());
									} else {
										dataMap.put(mapKey, null);
									}
								}
							}
							dataList.add(dataMap);
						}
					}
					
					//Get DB connection
					conn = ConnectionManagerHandler.getConnection("ScoreDB");
					stmt = conn.createStatement();

					// Get Match Category Id for domestic matches
					Integer matchCategoryId = null;
					String strSQLForCat = "Select id from matchcategories_mst WHERE name='Domestic' AND status='A'";
					ResultSet rsForCat = stmt.executeQuery(strSQLForCat);
					if (rsForCat != null) {
						while (rsForCat.next()) {
							matchCategoryId = rsForCat.getInt("id");
						}
						rsForCat.close();
					}

					/*// Get round Id for round 1
					Integer roundId = null;
					String strSQLForRound = "Select id from rounds_mst WHERE name='Round 1' AND status='A'";
					ResultSet rsForRound = stmt.executeQuery(strSQLForRound);
					if (rsForRound != null) {
						while (rsForRound.next()) {
							roundId = rsForRound.getInt("id");
						}
						rsForRound.close();
					}*/

					List<Map<String, String>> availableRecord  = new ArrayList<Map<String, String>>();
					List<Map<String, String>> newRecord = new ArrayList<Map<String, String>>();
					for (int count = 0; count < dataList.size(); count++) {
						List<String> errorList = new ArrayList<String>();
						boolean validData = true;
						Map<String, String> map = (Map<String, String>) dataList.get(count);
						String name = null;
						String season = null;
						String team1 = null;
						String team2 = null;
						String venue = null;
						String fromDate = null;
						String toDate = null;
						String type = null;
						String round = null;

						if (map.get("Tournament Name") != null) {
							name = map.get("Tournament Name");
						} else {
							errorList.add("Entry for Tournament Name not found at row " + count);
							validData = false;
						}
						if (map.get("Season") != null) {
							season = map.get("Season");
						} else {
							errorList.add("Entry for Season not found at row " + count);
							validData = false;
						}
						if (map.get("Team1") != null) {
							team1 = map.get("Team1");
						} else {
							errorList.add("Entry for Team1 not found at row " + count);
							validData = false;
						}
						if (map.get("Team2") != null) {
							team2 = map.get("Team2");
						} else {
							errorList.add("Entry for Team2 not found at row " + count);
							validData = false;
						}
						if (map.get("From Date") != null) {
							fromDate = map.get("From Date");
						} else {
							errorList.add("Entry for From Date not found at row " + count);
							validData = false;
						}
						if (map.get("To Date") != null) {
							toDate = map.get("To Date");
						} else {
							// if To Date is not specified, Consider single day
							// match and apply same date as of from date
							toDate = fromDate;
						}
						if (map.get("Match Type") != null) {
							type = map.get("Match Type");
						} else {
							errorList.add("Entry for Match Type not found at row " + count);
							validData = false;
						}
						if (map.get("Venue") != null) {
							venue = map.get("Venue");
						} else {
							errorList.add("Entry for Venue not found at row " + count);
							validData = false;
						}
						
						if (map.get("Round") != null) {
							round = map.get("Round");
						} else {
							errorList.add("Entry for Round not found at row " + count);
							validData = false;
						}

						//System.out.println("-----------------------------");
						/*System.out.println(
								"Sr. No." + map.get("Venue") + "------"+
								name + "---" +
						season + "---" +
						team1 + "---"+
						 team2 + "---"+
						venue + "---"+
						fromDate + "---"+ 
						toDate + "---"+
						type + "---" +
						round + "---");*/

						// Get SeasonId
						Integer seasonId = null;
						if (season != null) {
							String strSQL = "Select id from seasons_mst WHERE name='" + season + "' AND status='A'";
							ResultSet rs = stmt.executeQuery(strSQL);
							if (rs != null) {
								while (rs.next()) {
									seasonId = rs.getInt("id");
								}	
								rs.close();
							}
							if (seasonId == null) {
								errorList.add("Season Entry is not available for season " + season);
								validData = false;
							}
						}

						// Get TypeId
						Integer typeId = null;
						if (type != null) {
							String strSQL = "Select id from matchtypes_mst WHERE name='" + type + "' AND status='A'";
							ResultSet rs = stmt.executeQuery(strSQL);
							if (rs != null) {
								while (rs.next()) {
									typeId = rs.getInt("id");
								}
								rs.close();
							}
							//System.out.println(typeId + "typeId--------");
							if (typeId == null) {
								errorList.add("Match Type is not available for " + type);
								validData = false;
							}
						}

						// Get Series Type Id
						Integer seriesTypeId = null;
						if (name != null) {
							String strSQL = "Select id from seriestypes_mst WHERE name='" + name + "' AND status='A'";
							ResultSet rs = stmt.executeQuery(strSQL);
							if (rs != null) {
								while (rs.next()) {
									seriesTypeId = rs.getInt("id");
								}
								rs.close();
							}
							if (seriesTypeId == null) {
								errorList.add("Series Type is not available for " + name);
								validData = false;
							}
						}
						
						//System.out.println(seriesTypeId + "seriesTypeId--------  " + name);
						// Get SeriesId
						Integer seriesId = null;
						if (seasonId != null) {
							String strSQL = "Select id from series_mst WHERE type='" + seriesTypeId + "' AND status='A' AND season = " + seasonId;
							ResultSet rs = stmt.executeQuery(strSQL);
							
							if (rs != null) {
								while (rs.next()) {
									seriesId = rs.getInt("id");
								}
								rs.close();
							}
						}
						if(null == seriesId){
							errorList.add("Series is not available for " + name +" for season "+season);
							validData = false;
						}
						
						//System.out.println(seriesId + "-------------seriesId--------");
						/*if (seasonId != null && seriesId == null) {
							// Insert entry for series into DB
							StringBuffer strInsert = new StringBuffer("insert into series_mst (type,season,description,match_category,num_matches_max,player_gender,status)");
							strInsert.append(" values(");
							strInsert.append("'" + typeId + "',");
							strInsert.append("'" + seasonId + "',");
							strInsert.append("'" + name + "',");
							strInsert.append("'" + matchCategoryId + "',");
							strInsert.append("'1',");
							strInsert.append("'M',");
							strInsert.append("'A')");
							stmt.execute(strInsert.toString());

							String strSQL = "Select id from series_mst WHERE description='" + name + "' AND status='A' AND season = " + seasonId;
							ResultSet rs = stmt.executeQuery(strSQL);
							if (rs != null) {
								while (rs.next()) {
									seriesId = rs.getInt("id");
								}
								rs.close();
							}
						}*/

						// Get team 1 Id
						Integer team1Id = null;
						if (team1 != null) {
							String strSQL = "SELECT id FROM teams_mst WHERE (team_name='" + team1 + "' OR nickname='" + team1 + "') AND status='A'";
							ResultSet rs = stmt.executeQuery(strSQL);
							if (rs != null) {
								while (rs.next()) {
									team1Id = rs.getInt("id");
								}
								rs.close();
							}

							if (team1Id == null) {
								errorList.add("No Team record for for " + team1);
								validData = false;
							}
						}
						//System.out.println(team1Id + "-----------team1Id--------");	
						// Get team 2 Id
						Integer team2Id = null;
						if (team2 != null) {
							String strSQL = "SELECT id FROM teams_mst WHERE (team_name='" + team2 + "' OR nickname='" + team2 + "') AND status='A'";
							ResultSet rs = stmt.executeQuery(strSQL);
							if (rs != null) {
								while (rs.next()) {
									team2Id = rs.getInt("id");
								}
								rs.close();
							}
							if (team2Id == null) {
								errorList.add("No Team record for for " + team2);
								validData = false;
							}
						}
						//System.out.println(team2Id + "-------------team2Id--------");
						// Get VenuesId
						Integer venuesId = null;
						if (venue != null) {
							String strSQL = "Select id from venues_mst WHERE name='" + venue + "' AND status='A'";
							ResultSet rs = stmt.executeQuery(strSQL);
							if (rs != null) {
								while (rs.next()) {
									venuesId = rs.getInt("id");
								}
								rs.close();
							}
							if (venuesId == null) {
								errorList.add("No Venue record for for " + venue);
								validData = false;
								venuesId = 0;
							}
						}else{
							venuesId = 0;
						}
						//System.out.println(venuesId + "-------------venuesId--------");
						
						Integer roundsId = null;
						if (round != null) {
							String strSQL = "Select id from rounds_mst WHERE name='" + round+ "' AND status='A'";
							ResultSet rs = stmt.executeQuery(strSQL);
							if (rs != null) {
								while (rs.next()) {
									roundsId = rs.getInt("id");
								}
								rs.close();
							}
							if (roundsId == null) {
								errorList.add("No Round record for for " + round);
								validData = false;
							}
						}
						//System.out.println(roundsId + "-----roundsID--------");
						
						if (validData) {

							boolean dataExist = false;
							// Check data exist for same combination
							StringBuffer strSQL = new StringBuffer("SELECT 1 FROM dbo.matches_mst WHERE status='A'");
							strSQL.append(" AND name ='" + name + "'");
							strSQL.append(" AND type ='" + seriesTypeId + "'");
							strSQL.append(" AND series ='" + seriesId + "'");
							strSQL.append(" AND expected_start =convert(datetime,'" + fromDate + "',102)");
							strSQL.append(" AND expected_end =convert(datetime,'" + toDate + "',102)");
							strSQL.append(" AND team1 ='" + team1Id + "'");
							strSQL.append(" AND team2 ='" + team2Id + "'");
							strSQL.append(" AND venue ='" + venuesId + "'");
							strSQL.append(" AND category ='" + matchCategoryId + "'");
							strSQL.append(" AND round ='" + roundsId + "'");
							System.out.println(strSQL.toString() + "-----ddddd select");
							
							ResultSet rs = stmt.executeQuery(strSQL.toString());
							if (rs != null) {
								while (rs.next()) {
									dataExist = true;
									// avialableRecord.add("Record available for '"+
									// name+"' '"+season +"' '" + team1 +"' '" +
									// team2+"' '" + venue+"' '" + fromDate+"' '" +
									// toDate+"' '" + type+"'");
									Map<String, String> duplicateEntryMap = new HashMap<String, String>();
									duplicateEntryMap.put("Tournament Name", name);
									duplicateEntryMap.put("Season", season);
									duplicateEntryMap.put("Team1", team1);
									duplicateEntryMap.put("Team2", team2);
									duplicateEntryMap.put("Venue", venue);
									duplicateEntryMap.put("From Date", fromDate);
									duplicateEntryMap.put("To Date", toDate);
									duplicateEntryMap.put("Match Type", type);
									duplicateEntryMap.put("Round", round);
									availableRecord.add(duplicateEntryMap);
									break;
								}
								rs.close();
							}

							if (!dataExist) {
								StringBuffer strInsertQuery = new StringBuffer(
										" insert into dbo.matches_mst (name,type,series,expected_start,expected_end,team1,team2,venue,category,round,pitchtypes,weathertype) ");
								strInsertQuery.append(" values(");
								strInsertQuery.append("'" + name + "',");
								strInsertQuery.append("'" + typeId + "',");
								strInsertQuery.append("'" + seriesId + "',");
								strInsertQuery.append("convert(datetime,'" + fromDate + "',102),");
								strInsertQuery.append("convert(datetime,'" + toDate + "',102),");
								strInsertQuery.append("'" + team1Id + "',");
								strInsertQuery.append("'" + team2Id + "',");
								strInsertQuery.append("'" + venuesId + "',");
								strInsertQuery.append("'" + matchCategoryId + "',");
								strInsertQuery.append("'" + roundsId + "',1,1)");
								try {
									//System.out.println(strInsertQuery.toString() + "----- ");
									boolean flag = stmt.execute(strInsertQuery.toString());
										Map<String, String> newEntryMap = new HashMap<String, String>();
										newEntryMap.put("Tournament Name", name);
										newEntryMap.put("Season", season);
										newEntryMap.put("Team1", team1);
										newEntryMap.put("Team2", team2);
										newEntryMap.put("Venue", venue);
										newEntryMap.put("From Date", fromDate);
										newEntryMap.put("To Date", toDate);
										newEntryMap.put("Match Type", type);
										newEntryMap.put("Round", round);
										newRecord.add(newEntryMap);
								} catch (Exception e) {
									errorList.add(e.getMessage());
									e.printStackTrace();
								}
							}
						} else {
							errorMap.put(count, errorList);
						}
					}

					
					returnMap.put("Error", errorMap);
					returnMap.put("duplicateRecord", availableRecord);
					returnMap.put("newRecord", newRecord);
					
				}
				
				returnMap.put("FileError",errorString);
				session.setAttribute("returnMap",returnMap);

			} catch (Exception e) {
				e.printStackTrace();
			}
			finally{
				try {
					if(conn != null && !conn.isClosed()){
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				stmt = null;
				conn = null;
				
			}
			in.close();
			fileOut.close();
			response.sendRedirect("/cims/jsp/admin/MatchUploadSummary.jsp");
		}
	}
}