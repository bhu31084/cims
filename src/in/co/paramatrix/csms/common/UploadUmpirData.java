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

public class UploadUmpirData extends HttpServlet {

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
			boolean validFile = true;
			List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
			String mapKey = null;
			// Check no of columns matched with requirement
			String columnsInOrder = "SR. NO.,ASSOCIATION,NAME,MIDDLE NAME,SURNAME,ADDRESS,TEL,MOB,EMAIL";

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

				if (validFile) {
					// Get roleId which will be common for all Umpire
					Integer roleId = null;
					String strSQLForRole = "SELECT id FROM roles_mst WHERE name='Analyst' AND status='A'";
					System.out.println(strSQLForRole);
					ResultSet rsForRole = stmt.executeQuery(strSQLForRole);
					if (rsForRole != null) {
						while (rsForRole.next()) {
							roleId = rsForRole.getInt("id");
						}
						rsForRole.close();
					} else {
						errorString = " Entry for Umpire not found in roles_mst. Please Correct/Insert record for playesr entry roles_mst";
						validFile = false;
					}

					// Get the latest season from seasons_mst
					String strSQLForSeason = "SELECT max(id) as id FROM seasons_mst WHERE status='A'";
					System.out.println(strSQLForSeason);
					ResultSet rsForSeason = stmt.executeQuery(strSQLForSeason);
					Integer seasonId = null;
					if (rsForSeason != null) {
						while (rsForSeason.next()) {
							seasonId = rsForSeason.getInt("id");
						}
						rsForSeason.close();
					} else {
						errorString = " Entry for Season not found in seasons_mst. Please Correct/Insert record for season to continue.";
						validFile = false;
					}

					for (int rowNo = 1; rowNo < rows; rowNo++) {
						row = sheet.getRow(rowNo);
						if (row != null) {
							dataMap = new HashMap<String, String>();
							for (int colNo = 0; colNo < headerSize; colNo++) {
								mapKey = columns[colNo];
								Cell cell = row.getCell(colNo);
								if (cell != null) {
									if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
										dataMap.put(mapKey, "" + cell.getNumericCellValue());
									} else if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
										if (cell.getStringCellValue().equalsIgnoreCase("NULL")) {
											dataMap.put(mapKey, null);
										} else {
											dataMap.put(mapKey, cell.getStringCellValue());
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
					System.out.println("---- dataList Size ----" + dataList.size());
					for (int count = 0; count < dataList.size(); count++) {
						List<String> errorList = new ArrayList<String>();
						boolean validData = true;
						Map<String, String> map = (Map<String, String>) dataList.get(count);

						// SR. NO.,ASSOCIATION,NAME,MIDDLE NAME,SURNAME,ADDRESS,TEL,MOB,EMAIL
						String strAssociation = null;
						String strFirstName = null;
						String strMiddleName = null;
						String strLastName = null;
						String strAddress = null;
						String strTelNo = null;
						String strMobile = null;
						String strEmail = null;

						if (map.get("ASSOCIATION") != null) {
							strAssociation = map.get("ASSOCIATION");
						} else {
							errorList.add("Entry for ASSOCIATION not found.");
							validData = false;
						}
						if (map.get("NAME") != null) {
							strFirstName = map.get("NAME");
						} else {
							errorList.add("Entry for NAME not found.");
							validData = false;
						}
						if (map.get("MIDDLE NAME") != null) {
							strMiddleName = map.get("MIDDLE NAME");
						}
						if (map.get("SURNAME") != null) {
							strLastName = map.get("SURNAME");
						}
						if (map.get("ADDRESS") != null) {
							strAddress = map.get("ADDRESS").replaceAll("'", "''");
						} else {
							errorList.add("Entry for ADDRESS not found.");
							validData = false;
						}
						if (map.get("TEL") != null) {
							strTelNo = map.get("TEL");
							if(strTelNo.length() > 45){
								strTelNo = strTelNo.substring(0, 44);
							}
						}
						if (map.get("MOB") != null) {
							strMobile = map.get("MOB");
						} else {
							errorList.add("Entry for MOB not found.");
							validData = false;
						}
						if (map.get("EMAIL") != null) {
							strEmail = map.get("EMAIL");
						} else {
							errorList.add("Entry for EMAIL not found.");
							validData = false;
						}
						System.out.println(validData + " ---" + errorList);
						for (int i = 0; i < errorList.size(); i++) {
							System.out.println(errorList.get(i));
						}
						if (validData) {

							// Check for Players Information already exist in DB
							Integer userId = getUserId(strFirstName, strMiddleName, strLastName, stmt);
							if (userId == null) {

								String displayName = "";

								// Create Display Name
								displayName = strFirstName;
								if (strMiddleName != null && strMiddleName.length() > 0) {
									displayName += " " + strMiddleName.charAt(0);
								}
								if (strLastName != null) {
									displayName += " " + strLastName;
								}

								// Check display name is exit in db
								boolean validDisplayName = false;
								while (!validDisplayName) {
									try {
										int displayCount = 0;
										String strSQL = "SELECT 1 FROM users_mst WHERE displayName ='" + displayName + "'";
										System.out.println(strSQL);
										ResultSet rs = stmt.executeQuery(strSQL);
										if (rs != null && rs.next()) {
											validDisplayName = false;
										} else {
											validDisplayName = true;
										}
										rs.close();
										if (!validDisplayName) {
											displayName = getDisplayName(displayName, displayCount++);
										}
									} catch (Exception e) {
										e.printStackTrace();
									}
								}

								// Create NickName
								String nickName = strFirstName;
								int location = 1;
								boolean validNickName = false;
								while (!validNickName) {
									nickName = getNickName(nickName, location, strLastName);
									location++;
									// Check nickname exist in table
									String strSQL = "SELECT 1 FROM users_mst WHERE nickname ='" + nickName + "'";
									System.out.println(strSQL);
									try {
										ResultSet rs = stmt.executeQuery(strSQL);
										if (rs != null && rs.next()) {
											validNickName = false;
										} else {
											validNickName = true;
										}
										rs.close();
									} catch (Exception e) {
										e.printStackTrace();
									}
								}
								// Insert new entry
								StringBuffer sbQuery = new StringBuffer("INSERT INTO users_mst (");
								if (strMiddleName != null) {
									sbQuery.append("mname,");
								}
								if (strLastName != null) {
									sbQuery.append("sname,");
								}
								sbQuery.append("nickname,");
								sbQuery.append("displayname,");
								sbQuery.append("fname,");
								sbQuery.append("password,");
								sbQuery.append("password_enc,");
								sbQuery.append("status) values(");

								if (strMiddleName != null) {
									sbQuery.append("'" + strMiddleName + "',");
								}
								if (strLastName != null) {
									sbQuery.append("'" + strLastName + "',");
								}
								sbQuery.append("'" + nickName + "',");
								sbQuery.append("'" + displayName + "',");
								sbQuery.append("'" + strFirstName + "',");
								// Password will be default pass2 for every 1st entry
								sbQuery.append("'pass2',");
								sbQuery.append("'0',");
								sbQuery.append("'A')");

								System.out.println(sbQuery);
								stmt.execute(sbQuery.toString());
								System.out.println("----- New record inserted successfully -----");

								// Get newly inserted userid
								userId = getUserId(strFirstName, strMiddleName, strLastName, stmt);

							}

							// Check for entry exist in user-role_map
							StringBuffer sbQuery = new StringBuffer("SELECT user_role_id FROM user_role_map WHERE user_id=" + userId + " AND role=" + roleId);
							System.out.println(sbQuery);
							ResultSet rs = stmt.executeQuery(sbQuery.toString());
							Integer userRoleId = null;
							if (rs != null && rs.next()) {
								userRoleId = rs.getInt("user_role_id");
							}
							rs.close();
							if (userRoleId == null) {
								// insert User record into user_role_map
								sbQuery = new StringBuffer("INSERT INTO user_role_map(user_id,role) values(" + userId + "," + roleId + ")");
								System.out.println(sbQuery);
								stmt.executeUpdate(sbQuery.toString());

								// Get user_role_id from user_role_map of newly inserted row
								sbQuery = new StringBuffer("SELECT user_role_id FROM user_role_map WHERE user_id=" + userId + " AND role=" + roleId);
								System.out.println(sbQuery);
								rs = stmt.executeQuery(sbQuery.toString());
								if (rs != null && rs.next()) {
									userRoleId = rs.getInt("user_role_id");
								}
								rs.close();

							}

							// Get Association/Club ID
							String association = strAssociation.split(" ")[0];
							sbQuery = new StringBuffer("SELECT id FROM clubs_mst WHERE name like '" + association + "%' AND status='A'");
							System.out.println(sbQuery);
							rs = stmt.executeQuery(sbQuery.toString());
							Integer associationId = null;
							if (rs != null && rs.next()) {
								associationId = rs.getInt("id");
							}
							rs.close();
							if (associationId == null) {
								errorList.add(strAssociation + " not avaialble in Associations");
								validData = false;
								System.out.println(" %%%%%%%%%%%% "+strAssociation +" Not Found");
								continue;
							}

							// Insert data in user_club_map
							sbQuery = new StringBuffer("INSERT INTO user_club_map (user_role_id,club,status,season) values(");
							sbQuery.append(userRoleId + "," + associationId + ",'A'," + seasonId + ")");
							System.out.println(sbQuery);
							stmt.executeUpdate(sbQuery.toString());

							// Check address exist into addresses_mst
							Integer addressId = getAddressId(strAddress, stmt);
							if (addressId == null) {
								// Insert record into addresses_mst
								sbQuery = new StringBuffer("INSERT INTO addresses_mst(address1,status) values('" + strAddress + "','A')");
								System.out.println(sbQuery);
								stmt.executeUpdate(sbQuery.toString());

								addressId = getAddressId(strAddress, stmt);
							}

							// Insert record in user_address_map
							sbQuery = new StringBuffer("INSERT INTO users_address_map (user_id,address_id,category) values(");
							sbQuery.append(userId + "," + addressId + ",'R')");
							System.out.println(sbQuery);
							stmt.executeUpdate(sbQuery.toString());

							// Insert users Mobile No
							if (strMobile != null) {
								sbQuery = new StringBuffer("SELECT 1 FROM user_contactnum_map WHERE user_id=" + userId + " and contactnum='" + strMobile + "' and type='M' and category='P'");
								rs = stmt.executeQuery(sbQuery.toString());
								if (rs != null && rs.next()) {
									// No operation
								} else {
									// No records found. Insert new record
									sbQuery = new StringBuffer("INSERT INTO user_contactnum_map (user_id,contactnum,type,category) values(" + userId + ",'" + strMobile + "','M','P')");
									System.out.println(sbQuery);
									stmt.executeUpdate(sbQuery.toString());
								}
							}

							// Insert telephone no
							if (strTelNo != null) {
								sbQuery = new StringBuffer("SELECT 1 FROM user_contactnum_map WHERE user_id=" + userId + " and contactnum='" + strTelNo + "' and type='T' and category='P'");
								rs = stmt.executeQuery(sbQuery.toString());
								if (rs != null && rs.next()) {
									// No operation
								} else {
									// No records found. Insert new record
									sbQuery = new StringBuffer("INSERT INTO user_contactnum_map (user_id,contactnum,type,category) values(" + userId + ",'" + strTelNo + "','T','P')");
									System.out.println(sbQuery);
									stmt.executeUpdate(sbQuery.toString());
								}
							}

							// Insert Office Email Add
							if (strEmail != null) {
								sbQuery = new StringBuffer("SELECT 1 FROM user_email_map WHERE user_id=" + userId + " and email='" + strEmail + "' AND category='P'");
								rs = stmt.executeQuery(sbQuery.toString());
								if (rs != null && rs.next()) {
									// No operation
								} else {
									// No records found. Insert new record
									sbQuery = new StringBuffer("INSERT INTO user_email_map (user_id,email,category) values(" + userId + ",'" + strEmail + "','P')");
									System.out.println(sbQuery);
									stmt.executeUpdate(sbQuery.toString());
								}
							}

						}

					}

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

			response.sendRedirect("/cims/jsp/admin/MatchUploadSummary.jsp");
		}
	}

	private String getDisplayName(String displayName, int i) {
		displayName += "" + i;
		return displayName;
	}

	private Integer getAddressId(String strAddress, Statement stmt) {
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
	}

	private Integer getUserId(String strFirstName, String strMiddleName, String strLastName, Statement stmt) {
		Integer userId = null;
		String strQuery = "SELECT id FROM users_mst WHERE fname='" + strFirstName + "'";
		if (strMiddleName != null) {
			strQuery += " AND mname='" + strMiddleName + "'";
		}
		if (strLastName != null) {
			strQuery += " AND sname ='" + strLastName + "'";
		}
		strQuery += " AND status='A'";

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

	private String getNickName(String nickName, int location, String strLastName) {
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
	}
}