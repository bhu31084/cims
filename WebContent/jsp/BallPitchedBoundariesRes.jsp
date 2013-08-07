<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="java.awt.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="in.co.paramatrix.csms.logwriter.*"%>
<%@ page import="java.util.Hashtable"%>

<%
		try {
			response.setHeader("Pragma", "private");
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "private");
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Cache-Control", "no-store");
			response.setHeader("Pragma", "must-revalidate");
			response.setHeader("Cache-Control", "must-revalidate");
			response.setDateHeader("Expires", 0);

			Hashtable pitchData = new Hashtable();

			String storedProcName = request.getParameter("spName");
			String seasonId = request.getParameter("seasonId");
			String player1 = request.getParameter("id");		
		

			int originX = 0;
			int originY = 0;
			int size = 6;

			CachedRowSet crsImageDetail = null;
			CachedRowSet crsPointsDetail = null;

			Vector vSpParam = new Vector();

			GenerateStoreProcedure generateStProc = new GenerateStoreProcedure("0");
			vSpParam.add("1");
			crsImageDetail = generateStProc.GenerateStoreProcedure(
					"esp_getImageDetail", vSpParam, "ScoreDB");

			if (crsImageDetail.next()) {
				originX = crsImageDetail.getInt("originX");
				originY = crsImageDetail.getInt("originY");
			}
						
			URL u = LogWriter.class.getResource("LogWriter.class");
			String fileStr = u.getPath();
			
			int length = fileStr.indexOf("/WEB-INF/");
			
			fileStr = "/" + fileStr.substring(1, length) + "/images/Pitch.jpg";
			fileStr = fileStr.replaceAll("%20", " ");
			File file = new File(fileStr);
			BufferedImage img = ImageIO.read(file);

			Graphics2D g = img.createGraphics();
			vSpParam = new Vector();
			vSpParam.add(player1);
			vSpParam.add(seasonId);
			crsPointsDetail = generateStProc.GenerateStoreProcedure(storedProcName, vSpParam, "ScoreDB");

			boolean flag = false;

			while (crsPointsDetail.next()) {
				flag = true;
				int runs = crsPointsDetail.getInt("runs");
				int x = crsPointsDetail.getInt("gridX") * 10 + originX;
				int y = crsPointsDetail.getInt("gridY") * 10 + originY;
				//int wicket = crsPointsDetail.getInt("wicket");
				String pitch_id = crsPointsDetail.getString("pitched_at");
				int value = 1;
				if (pitchData.containsKey(pitch_id.toString().trim())) {
					value = Integer.parseInt(pitchData.get(pitch_id).toString().trim());
					if (value >= 9) {
						pitchData.put(pitch_id, new Integer(1));
					} else {
						value = value + 1;
						pitchData.put(pitch_id, new Integer(value));
					}
				} else {
					pitchData.put(pitch_id, new Integer(1));
				}

				switch (value) {
				case 1:
					x = x + 3;
					y = y + 3;
					break;
				case 2:
					x = x + 0;
					y = y + 0;
					break;
				case 3:
					x = x + 0;
					y = y + 6;
					break;
				case 4:
					x = x + 6;
					y = y + 0;
					break;
				case 5:
					x = x + 6;
					y = y + 6;
					break;
				case 6:
					x = x + 0;
					y = y + 3;
					break;
				case 7:
					x = x + 3;
					y = y + 0;
					break;
				case 8:
					x = x + 3;
					y = y + 9;
					break;
				case 9:
					x = x + 9;
					y = y + 3;
					break;
				}

/*
		wicket	RED
		0		BLACK		
		1		white
		2		BLUE
		3		YELLOW
		4		CYAN
		6		GREEN
		Other 	GRAY
		*/

				switch (runs) {
				case 0:
					/*if (wicket != 0) {
						g.setColor(Color.red);
					} else {
						g.setColor(Color.BLACK);
					}*/
					g.fillArc(x, y, size, size, 0, 360);
					break;
					
				case 1:
					/*if (wicket != 0) {
						g.setColor(Color.red);
					} else {
						g.setColor(Color.white);
					}*/
					g.fillArc(x, y, size, size, 0, 360);
					break;
					
				case 2:
					/*if (wicket != 0) {
						g.setColor(Color.red);
					} else {
						g.setColor(Color.BLUE);
					}*/
					g.fillArc(x, y, size, size, 0, 360);
					break;
					
				case 3:
					/*if (wicket != 0) {
						g.setColor(Color.red);
					} else {
						g.setColor(Color.YELLOW);
					}*/
					g.fillArc(x, y, size, size, 0, 360);
					break;
					
				case 4:
					/*if (wicket != 0) {
						g.setColor(Color.red);
					} else {
						g.setColor(Color.cyan);
					}*/
					g.fillArc(x, y, size, size, 0, 360);
					break;
					
				case 6:
					/*if (wicket != 0) {
						g.setColor(Color.red);
					} else {
						g.setColor(Color.green);
					}*/
					g.fillArc(x, y, size, size, 0, 360);
					break;
						
				default:
					/*if (wicket != 0) {
						g.setColor(Color.red);
					} else {
						g.setColor(Color.gray);
					}*/
					g.fillArc(x, y, size, size, 0, 360);
					break;
				}
			}
			
			if(!flag){
				g.setColor(Color.white);
				g.drawString("No data.", 50, 80);
			}
			
			response.setContentType("image/png");
			OutputStream os = response.getOutputStream();

			try {
				ImageIO.write(img, "png", os);
			} catch (IOException e) {
				e.printStackTrace();
			}
			os.close();
		} catch (Exception e) {
			out.println(e);
			e.printStackTrace();
		}
	%>