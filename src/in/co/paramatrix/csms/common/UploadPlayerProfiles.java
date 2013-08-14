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

public class UploadPlayerProfiles extends HttpServlet {

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
			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
			boolean validFile = true;
			List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
			String mapKey = null;
			// Check no of columns matched with requirement
			String columnsInOrder = "Sr. No,First Name,Middle Name,Surname,Name in the score sheet,Date of Birth,Place of Birth(City/District),Style Of Batting,Style of Bowling,Bowling Proficiency,Gender,Association,Age_Group,Season";
// 				"player_profiles_id,players_id,associations_id,first_name,middle_name,last_name,first_name_scr,middle_name_scr,last_name_scr,gender,address1,states_id,date_of_birth,wicket_keeper,disciplineBat,disciplineBowl,spin,med_pace,fast_medium,mobileNo";
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
					row = sheet.getRow(0);
					if (row != null) {
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
					}
				} else {
					errorString = "Problem in reading data in file";
					validFile = false;
				}

				// Get DB connection
				conn = ConnectionManagerHandler.getConnection("ScoreDB");
				stmt = conn.createStatement();

				// Get roleId which will be common for all player
				Integer roleId = null;
				String strSQLForRole = "SELECT id FROM roles_mst WHERE name='player' AND status='A'";
				System.out.println(strSQLForRole);
				ResultSet rsForRole = stmt.executeQuery(strSQLForRole);
				if (rsForRole != null) {
					while (rsForRole.next()) {
						roleId = rsForRole.getInt("id");
					}
					rsForRole.close();
				} else {
					errorString = " Entry for Player not found in roles_mst. Please Correct/Insert record for playesr entry roles_mst";
					validFile = false;
				}

				if (validFile) {
					for (int rowNo = 1; rowNo < rows; rowNo++) {
						row = sheet.getRow(rowNo);
						if (row != null) {
							dataMap = new HashMap<String, String>();
							for (int colNo = 0; colNo < headerSize; colNo++) {
								mapKey = columns[colNo];
								Cell cell = row.getCell(colNo);
								if (cell != null) {
									if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
										if (mapKey.equalsIgnoreCase("Date of Birth")) {
											dataMap.put(mapKey, sdf.format(cell.getDateCellValue()));
										} else {
											dataMap.put(mapKey, "" + cell.getNumericCellValue());
										}
									} else if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
										String strValue = cell.getStringCellValue();
										if (strValue.trim().equals("") || strValue.equalsIgnoreCase("NULL")) {
											dataMap.put(mapKey, null);
										} else {
											dataMap.put(mapKey, strValue.trim());
										}

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

					List<Map<String, String>> availableRecord = new ArrayList<Map<String, String>>();
					List<Map<String, String>> newRecord = new ArrayList<Map<String, String>>();
					Map<Integer, List<String>> errorMap = new TreeMap<Integer, List<String>>();
					for (int count = 0; count < dataList.size(); count++) {
						List<String> errorList = new ArrayList<String>();
						boolean validData = true;
						boolean validClub = true;
						Map<String, String> map = (Map<String, String>) dataList.get(count);

						String strAssociations = null;
						String strFirstName = null;
						String strMiddleName = null;
						String strLastName = null;
						String strGender = null;
						String strDOB = null;
						//Default bat n bowl style is Right Hand 
						int strDisciplineBat = 1;
						int strDisciplineBowl = 1;
						
						String placeOfBirth = null;
						String strNameinthescoresheet = null;
						String ageGroup = null;
						String season = null;
						
						if (map.get("Association") != null) {
							strAssociations =  map.get("Association");
						} else {
							errorList.add("Entry for Association not found ");
							validData = false;
						}
						if (map.get("First Name") != null) {
							strFirstName = map.get("First Name").replaceAll("\\W", " ").replaceAll("  ", " ");
						} else {
							errorList.add("Entry for First Name not found ");
							validData = false;
						}
						if (map.get("Gender") != null) {
							strGender = map.get("Gender");
						} else {
							errorList.add("Entry for Gender not found ");
							validData = false;
						}
						
						if (map.get("Name in the score sheet") != null) {
							strNameinthescoresheet = map.get("Name in the score sheet").trim().replaceAll("\\W", " ").replaceAll("  ", " ");
							
							int strlength = strNameinthescoresheet.length();
							boolean validFlag = false;
							for(int lenCount=0; lenCount < strlength; lenCount ++){
								char ch = strNameinthescoresheet.charAt(lenCount);
								if(!Character.isSpaceChar(ch)){
									validFlag  = true;
									break;
								}
							}
							
							if(!validFlag){
								strNameinthescoresheet = null;
							}
						}
						
						if (map.get("Middle Name") != null) {
							strMiddleName = map.get("Middle Name").replaceAll("\\W", " ").replaceAll("  ", " ");
						}
						if (map.get("Surname") != null) {
							strLastName = map.get("Surname").replaceAll("\\W", " ").replaceAll("  ", " ");
						}
						if (map.get("Age_Group") != null) {
							ageGroup = map.get("Age_Group");
							if(ageGroup.equalsIgnoreCase("U16") || ageGroup.equalsIgnoreCase("U19") || ageGroup.equalsIgnoreCase("U22") || ageGroup.equalsIgnoreCase("SR")){
								//Valid data
							}else{
								errorList.add("Value of age_group should be U16/U19/U22/SR");
								validData = false;
							}
						}
						
						if (map.get("Season") != null) {
							season = map.get("Season");
						}else{
							errorList.add("Entry for Season not found ");
							validData = false;		
						}
						if (map.get("Place of Birth(City/District)") != null) {
							placeOfBirth = map.get("Place of Birth(City/District)").replaceAll("\\W", " ").replaceAll("  ", " ");
						}
						if (map.get("Date of Birth") != null) {
							strDOB = map.get("Date of Birth");
						}
						
						String strBatStyle = map.get("Style Of Batting");
						String strBowlStyle = map.get("Style of Bowling");
						if (strBatStyle != null && (strBatStyle.equalsIgnoreCase("LHB") || strBatStyle.equalsIgnoreCase("Left Hand Batsman"))) {
							strDisciplineBat = 0;
						}
						
						if (strBowlStyle != null && (strBowlStyle.equalsIgnoreCase("Left Arm Bowler"))) {
							strDisciplineBowl = 0;
						}
						
						String strBowlingProf = null;
						if (map.get("Bowling Proficiency") != null && !"Undefined".equalsIgnoreCase(map.get("Bowling Proficiency"))) {
							strBowlingProf = map.get("Bowling Proficiency");
						}else{
							strBowlingProf = "TBA";
							//Update Bowling Proficiency for summary report
							map.put("Bowling Proficiency",strBowlingProf);
						}
						
						// Check for Display Name
						String displayName = "";
						if(strNameinthescoresheet != null && !"".equals(strNameinthescoresheet.trim())){
							displayName = strNameinthescoresheet;	
						}else{
							if((strMiddleName != null && !"".equals(strMiddleName.trim())) || (strLastName != null && !"".equals(strLastName.trim())) ){
								if(strFirstName != null && !"".equals(strFirstName.trim())){
									displayName = strFirstName.substring(0,1) +" ";
								}
								if(strLastName != null && !"".equals(strLastName.trim())){
									if(strMiddleName != null && !"".equals(strMiddleName.trim())){
										displayName += strMiddleName.substring(0,1) +" ";
									}
									displayName += strLastName;
								}else{
									displayName += strMiddleName;
								}
							}else {
								displayName = strFirstName;
							}
							
							displayName.replaceAll("\\W", " ").replaceAll("  ", " ");
						}
						
						//Update 'Name in the score sheet' for Summary Report
						map.put("Name in the score sheet", displayName);
						
						// Check display name is exit in db
						String strSQL = "SELECT 1 FROM users_mst WHERE displayName ='" + displayName + "'";
						System.out.println(strSQL);
						ResultSet rs = stmt.executeQuery(strSQL);
						if (rs != null && rs.next()) {
							Integer userId = getUserId(strFirstName, strMiddleName, strLastName, strDOB, stmt);
							if(userId == null){
								errorList.add("'"+displayName +"' Display name already exist. Please make necessary changes and update record again.");
								validData = false;
							}
						}
						rs.close();
						
						//Get club id
						strSQL = "SELECT id FROM clubs_mst WHERE status='A' AND name='"+strAssociations+"'";
						System.out.println(strSQL);
						Integer associationsId = null;
						rs = stmt.executeQuery(strSQL);
						if (rs != null && rs.next()) {
							associationsId = rs.getInt("id");
						}else{
							errorList.add(strAssociations+ " Association not found");
							validClub = false;
						}
						rs.close();

						//get Team data from teams_mst for given Age Group
						StringBuffer sbQuery = new StringBuffer("SELECT id FROM teams_mst WHERE club="+associationsId);
						sbQuery.append(" AND age_group='"+ageGroup+"' AND SEX='"+strGender+"' AND status='A'");
						System.out.println(sbQuery);
						rs = stmt.executeQuery(sbQuery.toString());
						Integer teamId = null;
						if (rs != null) {
							while (rs.next()) {
								teamId = rs.getInt("id");
								break;
							}
							rs.close();
						}
						if(teamId == null){
							errorList.add("No team found for Age Group "+ageGroup +" and Association "+strAssociations);
							validData = false;
						}
						
						
						if (validData) {

							// Check for Players Information already exist in DB
							Integer userId = getUserId(strFirstName, strMiddleName, strLastName, strDOB, stmt);
							if (userId == null) {

								// Create NickName
								String nickName = strFirstName.substring(0,1);
								//Get last allocated user-id
								int userIdToBeAssigned = 0 ;
								ResultSet rsUsersMst = stmt.executeQuery("SELECT MAX(id) as id FROM users_mst");
								if (rsUsersMst != null) {
									while (rsUsersMst.next()) {
										userIdToBeAssigned = rsUsersMst.getInt("id")+1;
										break;
									}
									rsUsersMst.close();
								}
								
								if(strLastName != null){
									nickName += strLastName.substring(0,1);
								}else if(strMiddleName != null){
									nickName += strMiddleName.substring(0,1);
								}
								nickName += ""+userIdToBeAssigned;
								
								// Insert new entry
								sbQuery = new StringBuffer("INSERT INTO users_mst (");
								sbQuery.append("nickname,");
								sbQuery.append("displayname,");
								sbQuery.append("fname,");
								if (strMiddleName != null) {
									sbQuery.append("mname,");
								}
								if (strLastName != null) {
									sbQuery.append("sname,");
								}
								sbQuery.append("password,");
								sbQuery.append("password_enc,");
								sbQuery.append("dob,");
								if (placeOfBirth != null) {
									sbQuery.append("pob,");
								}
								sbQuery.append("sex,batting_right,bowling_right,");
								if (strBowlingProf != null) {
									sbQuery.append("bowling_proficiency,");
								}
								sbQuery.append("status) values(");
								sbQuery.append("'" + nickName + "',");
								sbQuery.append("'" + displayName + "',");
								sbQuery.append("'" + strFirstName + "',");
								if (strMiddleName != null) {
									sbQuery.append("'" + strMiddleName + "',");
								}
								if (strLastName != null) {
									sbQuery.append("'" + strLastName+ "',");
								}
								// Password will be default pass2 for every 1st entry
								sbQuery.append("'pass2',");
								sbQuery.append("'0',");
								sbQuery.append("convert(datetime,'" + strDOB + "',103),");
								if (placeOfBirth != null) {
									sbQuery.append("'" + placeOfBirth + "',");
								}
								sbQuery.append("'" + strGender + "',");								
								sbQuery.append("'" + strDisciplineBat + "',");
								sbQuery.append("'" + strDisciplineBowl + "',");
								if (strBowlingProf != null) {
									sbQuery.append("'" + strBowlingProf + "',");
								}
								sbQuery.append("'A')");

								System.out.println(sbQuery);
								stmt.execute(sbQuery.toString());
								System.out.println("----- New record inserted successfully -----");
								
								Map<String,String> newRecordMap = new HashMap<String, String>();
								for(int colCnt=1; colCnt<headerSize; colCnt++){
									newRecordMap.put(columns[colCnt], map.get(columns[colCnt]));	
								}
								newRecord.add(newRecordMap);
								
								// Get newly inserted userid
								userId = getUserId(strFirstName, strMiddleName, strLastName, strDOB, stmt);

								//Insert record into authz_users_mst
								sbQuery = new StringBuffer("INSERT INTO authz_users_mst(nickname,active) values('" + nickName + "','Y')");
								System.out.println(sbQuery);
								stmt.executeUpdate(sbQuery.toString());
								
								// insert User record into user_role_map
								sbQuery = new StringBuffer("INSERT INTO user_role_map(user_id,role) values(" + userId + "," + roleId + ")");
								System.out.println(sbQuery);
								stmt.executeUpdate(sbQuery.toString());

							} else {
								
								// Update available Entry
								sbQuery = new StringBuffer("UPDATE users_mst SET ");
								sbQuery.append("batting_right = '" + strDisciplineBat + "',");
								sbQuery.append(" bowling_right = '" + strDisciplineBowl + "',");
								if (strBowlingProf != null) {
									sbQuery.append(" bowling_proficiency = '" + strBowlingProf + "',");
								}
								
								//Check DisplayName is present for this user
								strSQL = "SELECT displayName FROM users_mst WHERE  id="+userId;
								System.out.println(strSQL);
								rs = stmt.executeQuery(strSQL);
								String userDisplayName = null;
								if (rs != null && rs.next()) {
									userDisplayName = rs.getString("displayName");
								}
								rs.close();
								
								if(userDisplayName == null || "".equals(userDisplayName)){
									sbQuery.append(" displayName ='" + displayName + "',");	
								}
								
								sbQuery.append(" status='A' WHERE id=" + userId);
								System.out.println(sbQuery);
								stmt.executeUpdate(sbQuery.toString());
								System.out.println("------ Record for " + strFirstName + " " + strLastName + " Updated successfully -----");
								
								//Check data exist in user_role_map
								if(getUserRoleId(userId, roleId, stmt) == null){
									// insert User record into user_role_map
									sbQuery = new StringBuffer("INSERT INTO user_role_map(user_id,role) values(" + userId + "," + roleId + ")");
									System.out.println(sbQuery);
									stmt.executeUpdate(sbQuery.toString());
								}
								
								Map<String,String> availableRecordMap = new HashMap<String, String>();
								for(int colCnt=1; colCnt<headerSize; colCnt++){
									availableRecordMap.put(columns[colCnt], map.get(columns[colCnt]));	
								}
								availableRecord.add(availableRecordMap);
							}

							Integer userRoleId = getUserRoleId(userId,roleId,stmt);	
							
							if(ageGroup != null && validClub){
								
								//if(teamId != null){
									//Check if data exist for same combination in team_player_map
									sbQuery = new StringBuffer("SELECT 1 FROM team_player_map WHERE team_id="+teamId);
									sbQuery.append(" AND player_id='"+userRoleId+"' AND status='A'");
									System.out.println(sbQuery);
									rs = stmt.executeQuery(sbQuery.toString());
									if (rs != null && rs.next()) {
										//Entry already present.
									}else{
										//Insert new record in team_player_map
										sbQuery = new StringBuffer("INSERT INTO team_player_map(team_id,player_id,status) values("+teamId+","+userRoleId+",'A')");
										System.out.println(sbQuery);
										stmt.executeUpdate(sbQuery.toString());
									}
									rs.close();	
								/*}else{
									errorList.add("No team found for Age Group "+ageGroup +" and Association "+strAssociations);
								}*/
								
							}
							

							// Get the latest season from seasons_mst
							strSQL = "SELECT id FROM seasons_mst WHERE status='A' AND name='"+season+"'";
							System.out.println(strSQL);
							rs = stmt.executeQuery(strSQL);
							Integer seasonId = null;
							if (rs != null && rs.next()) {
								seasonId = rs.getInt("id");
							}
							rs.close();

							if(validClub){
								// Check for data exist in user_club_map
								sbQuery = new StringBuffer("SELECT 1 FROM user_club_map WHERE user_role_id=" + userRoleId+ " AND season=" + seasonId +" AND club='"+associationsId+"' AND status='A'");
								System.out.println(sbQuery);
								rs = stmt.executeQuery(sbQuery.toString());
								if (rs != null && rs.next()) {
									//Entry already available in user_club_map
								}else{
									//Check if entry exist for another season 
									sbQuery = new StringBuffer("SELECT user_role_id FROM user_club_map WHERE user_role_id=" + userRoleId+ " AND season=" + seasonId +" AND status='A'");
									System.out.println(sbQuery);
									rs = stmt.executeQuery(sbQuery.toString());
									if (rs != null && rs.next()) {
										// Inactivate prev season entry
										sbQuery = new StringBuffer("UPDATE user_club_map SET status='I' WHERE user_role_id=" + userRoleId+ " AND season=" + seasonId +" AND status='A'");
										System.out.println(sbQuery);
										stmt.executeUpdate(sbQuery.toString());
									}
									rs.close();
									
									//Check if user has played for same club earlier in the same season
									sbQuery = new StringBuffer("SELECT 1 FROM user_club_map WHERE user_role_id=" + userRoleId+ " AND season=" + seasonId +" AND club='"+associationsId+"' AND status='I'");
									System.out.println(sbQuery);
									rs = stmt.executeQuery(sbQuery.toString());
									if (rs != null && rs.next()) {
										//Entry already available in user_club_map. Activate same record.
										sbQuery = new StringBuffer("UPDATE user_club_map SET status='A' WHERE user_role_id=" + userRoleId+ " AND season=" + seasonId +" AND club='"+associationsId+"' AND status='I'");
										System.out.println(sbQuery);
										stmt.executeUpdate(sbQuery.toString());
									}else{
										// Insert data in user_club_map
										sbQuery = new StringBuffer("INSERT INTO user_club_map (user_role_id,club,status,season) values(");
										sbQuery.append(userRoleId + "," + associationsId + ",'A'," + seasonId + ")");
										System.out.println(sbQuery);
										stmt.executeUpdate(sbQuery.toString());
									}
									
								}							
							}// End of (validClub)
							
						} //End of (validData)
						
						if(errorList.size() > 0 && (strAssociations != null || strFirstName != null || strGender != null || ageGroup != null || strDOB != null)){
							errorMap.put(count, errorList);
						}
					}// End of For Loop (count < dataList.size())

					returnMap.put("Error", errorMap);
					returnMap.put("duplicateRecord", availableRecord);
					returnMap.put("newRecord", newRecord);

				}

				returnMap.put("FileError", errorString);
				session.setAttribute("returnMap", returnMap);

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
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
				in.close();
				fileOut.close();
			}

			response.sendRedirect("/cims/jsp/admin/PlayerProfilesUploadSummary.jsp");
		}
	}

	private Integer getUserRoleId(Integer userId, Integer roleId, Statement stmt) {
		StringBuffer sbQuery = new StringBuffer("SELECT user_role_id FROM user_role_map WHERE user_id=" + userId + " AND role=" + roleId);
		System.out.println(sbQuery);
		try {
			ResultSet rs = stmt.executeQuery(sbQuery.toString());
			if (rs != null) {
				while (rs.next()) {
					return rs.getInt("user_role_id");
				}
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/*private String getDisplayName(String displayName, int i) {
		displayName += "" + i;
		return displayName;
	}*/

	/*private Integer getAddressId(String strAddress, Statement stmt) {
		Integer addressId = null;
		try {
			String strSql = "SELECT id FROM addresses_mst WHERE address1='" + strAddress + "' AND status ='A'";
			ResultSet rs = stmt.executeQuery(strSql);
			if (rs != null) {
				while (rs.next()) {
					addressId = rs.getInt("id");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return addressId;
	}*/

	private Integer getUserId(String strFirstName, String strMiddleName, String strLastName, String strDOB, Statement stmt) {
		Integer userId = null;
		String strQuery = "SELECT id FROM users_mst WHERE fname='" + strFirstName + "'";
		if (strMiddleName != null) {
			strQuery += " AND mname='" + strMiddleName + "'";
		}
		if (strLastName != null) {
			strQuery += " AND sname ='" + strLastName + "'";
		}
		strQuery += "AND dob=convert(datetime,'" + strDOB + "',103) AND status='A'";

		try {
			System.out.println(strQuery);
			ResultSet rsUsersMst = stmt.executeQuery(strQuery);
			if (rsUsersMst != null) {
				while (rsUsersMst.next()) {
					userId = rsUsersMst.getInt("id");
					break;
				}
				rsUsersMst.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	/*private String getNickName(String nickName, int location, String strLastName) {
		if (strLastName != null) {
			if (strLastName.length() > location) {
				nickName += strLastName.substring((location - 1), location);
			} else {
				nickName += "" + location;
			}
		} else {
			nickName += "" + location;
		}
		return nickName;
	}*/
}