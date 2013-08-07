<!--
	Author 				: Saudagar Mulik
	Created Date		: 13/09/2008
	Description 		: Ajax response page for WagonWheel.jsp.
	Company 	 		: Paramatrix Tech Pvt Ltd.
	Modification Date	: 13/09/2008
-->
 
<%@page import="java.util.List"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.awt.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="in.co.paramatrix.csms.logwriter.*"%>
<%@ page import="java.awt.geom.*"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.lang.Integer"%>

<%
	CachedRowSet crsDrivenPoints = null;
	CachedRowSet crsImageDetail = null;
	Vector vSpParam = new Vector();

	String inning_id = session.getAttribute("InningId").toString();
	String player1 = request.getParameter("id");
	String player2 = "1";
	String type = request.getParameter("type");

	Enumeration enumeration = session.getAttributeNames();
	while (enumeration.hasMoreElements()) {
		System.out.print(enumeration.nextElement() + " ");
	}

	String match_id = null;
	if (session.getAttribute("matchid") == null) {
		match_id = session.getAttribute("matchId1").toString();
		session.setAttribute("matchid", match_id);
	} else {
		match_id = session.getAttribute("matchid").toString();
		session.setAttribute("matchId1", match_id);
	}
	GenerateStoreProcedure generateStProc = new GenerateStoreProcedure(
			match_id);

	/** Image Detail retrieve from database. */
	vSpParam.add("2");
	crsImageDetail = generateStProc.GenerateStoreProcedure("esp_getImageDetail", vSpParam, "ScoreDB");

	int size = 6;
	int originX = 0;
	int originY = 0;
	if (crsImageDetail != null && crsImageDetail.next()) {
		originX = crsImageDetail.getInt("originX");
		originY = crsImageDetail.getInt("originY");
	}

	int offsetX = 0;
	int offsetY = 0;

	//originX = originX + offsetX;
	//originY = originY + offsetY;

	//originX = 112;
	//originY = 144;

	/** Image location loaded. */
	URL u = LogWriter.class.getResource("LogWriter.class");
	String fileStr = u.getPath();
	int length = fileStr.indexOf("/WEB-INF/");
	fileStr = "/" + fileStr.substring(1, length)+ "/images/wagon_wheel.jpg";
	fileStr = fileStr.replaceAll("%20", " ");
	File file = new File(fileStr);
	BufferedImage img = ImageIO.read(file);
	Graphics2D g = img.createGraphics();

	vSpParam = new Vector();
	vSpParam.add(inning_id);
	vSpParam.add(player1);
	vSpParam.add(player2);
	vSpParam.add(type);
	crsDrivenPoints = generateStProc.GenerateStoreProcedure("esp_dsp_WagonWheel", vSpParam, "ScoreDB");

	Hashtable driven_value = new Hashtable();

	boolean flag = false;
	char rightHanded = 'Y';

	String side1_label = "Off side";
	String side2_label = "Leg side";
	String side3_label = "Right handed";

	CachedRowSet profileDetail = null;
	vSpParam = new Vector();
	vSpParam.add(player1);
	profileDetail = generateStProc.GenerateStoreProcedure("esp_dsp_playerProfDetails", vSpParam, "ScoreDB");

	if (profileDetail.next()) {
		if (profileDetail.getObject("bat") != null) {
			rightHanded = profileDetail.getObject("bat").toString().charAt(0);
		}
	}

	if (type.equals("0") && rightHanded == 'N') {
		side1_label = "Leg side";
		side2_label = "Off side";
		side3_label = "Left handed";
	}

	// 218-110 218-200
	int __25_i = 0;
	final int[][] __25 = {
			{ 218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218 },
			{ 110,200,190,180,150,160,185,125,130,150,175,165,120,115,179,118,187,148,159,133 } };

	//90-338,140-338
	int __26_i = 0;
	final int[][] __26 = {
			{ 90,140, 99,120,105,135,115, 95,110,130,122,118, 92,108,128,138,127,112,133, 93 },
			{ 338,338,338,338,338,338,338,338,338,338,338,338,338,338,338,338,338,338,338,338 } };

	int __27_i = 0;
	final int[][] __27 = {
			{ 23, 24, 26, 28, 30, 33, 35, 39, 65, 42, 46, 49, 50, 53, 60, 65, 69, 72, 75, 77 },
			{ 293,296,299,301,304,308,310,313,330,317,320,322,323,324,328,331,332,333,333,336 } };

	//10 -(110, 255)
	int __29_i = 0;
	final int[][] __29 = {
			{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 },
			{ 110,255,150,180,125,135,200,185,165,145,190,173,210,230,150,180,115,195,190,168 } };

	//97-137, 24

	int __32_i = 0;
	final int[][] __32 = {
			{ 97,137,125,132,100,110,105,130,135,122,128,103,108,112,118, 99,107,102,127,118},
			{ 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24 } 
		};

	//85-23 16-78
	int __36_i = 0;
	final int[][] __36 = {
			{ 85, 33, 47, 21, 14, 12, 11, 21, 34, 60, 71, 82, 88, 12, 20, 31, 23, 44, 72, 10, 50 },
			{ 22, 51, 39, 64, 84, 94, 96, 67, 50, 31, 26, 23, 23, 90, 70, 51, 63, 39, 26, 24, 36 } 
		};

	//217-272 147-338
	int __39_i = 0;
	final int[][] __39 = {
			{ 139, 172, 217, 215, 203, 190, 171, 188, 203, 210, 144, 160, 185, 202, 208, 176, 158, 198, 215, 196 },
			{ 337, 326, 263, 273, 298, 313, 326, 315, 298, 287, 335, 331, 318, 300, 290, 324, 332, 304, 274, 308 } 
		};

	if (type.equals("0")) {
		g.setColor(Color.DARK_GRAY);
		g.fill3DRect(0, 160, 53, 20, true);
		g.fill3DRect(173, 160, 53, 20, true);

		g.setColor(Color.white);
		g.drawString(side1_label, 3, 175);
		g.drawString(side2_label, 175, 175);

		g.drawString(side3_label, 75, 320);
	}

	if (crsDrivenPoints != null) {
		while (crsDrivenPoints.next()) {
			flag = true;
			String position = crsDrivenPoints.getString("position");
			int x = crsDrivenPoints.getInt("x");
			int y = crsDrivenPoints.getInt("y");
			int runs = crsDrivenPoints.getInt("runs");
			int wicket = crsDrivenPoints.getInt("wicket");
			int boundry_pos = crsDrivenPoints.getInt("boundry_pos");

			int posValue = 0;

			if (driven_value.containsKey(position)) {

				if (posValue < 16) {
					posValue = Integer.parseInt(driven_value.get(position).toString());
					driven_value.put(position, new Integer(Integer.parseInt(driven_value.get(position).toString().trim()) + 1));
				} else {
					posValue = 1;
					driven_value.put(position, new Integer(1));
				}
			} else {
				posValue = 1;
				driven_value.put(position, new Integer(1));
			}

			switch (posValue) {
			case 1:
				break;
			case 2:
				x = x + 12;
				y = y + 7;
				break;
			case 3:
				x = x + 1;
				y = y - 11;
				break;
			case 4:
				x = x - 7;
				y = y + 9;
				break;
			case 5:
				x = x + 3;
				y = y - 5;
				break;
			case 6:
				x = x + 0;
				y = y + 6;
				break;
			case 7:
				x = x + 5;
				y = y + 0;
				break;
			case 8:
				x = x - 9;
				y = y + 0;
				break;
			case 9:
				x = x + 0;
				y = y - 2;
				break;
			case 10:
				x = x + 6;
				y = y + 6;
				break;
			case 11:
				x = x - 8;
				y = y + 3;
				break;
			case 12:
				x = x + 4;
				y = y + 3;
				break;
			case 13:
				x = x + -7;
				y = y + 3;
				break;
			case 14:
				x = x + -4;
				y = y + 3;
				break;
			case 15:
				x = x + 4;
				y = y + -3;
				break;
			case 16:
				x = x - 2;
				y = y - 3;
				break;
			case 17:
				x = x - 5;
				y = y - 6;
				break;
			case 18:
				x = x - 7;
				y = y + 3;
				break;
			case 19:
				x = x - 2;
				y = y + 1;
				break;
			case 20:
				x = x + 2;
				y = y - 3;
				break;
			}

			x = x + offsetX;

			switch (runs) {
			case 0:
				if (wicket != 0) {
					g.setColor(Color.red);
				} else {
					g.setColor(Color.BLACK);
				}
				g.drawLine(originX, originY, x, y);
				g.fillArc(x - 3, y - 3, size, size, 0, 360);
				break;
			case 1:
				if (wicket != 0) {
					g.setColor(Color.red);
				} else {
					g.setColor(Color.white);
				}
				g.drawLine(originX, originY, x, y);
				g.fillArc(x - 3, y - 3, size, size, 0, 360);
				break;
			case 2:
				if (wicket != 0) {
					g.setColor(Color.red);
				} else {
					g.setColor(Color.BLUE);
				}
				g.drawLine(originX, originY, x, y);
				g.fillArc(x - 3, y - 3, size, size, 0, 360);
				break;
			case 3:
				if (wicket != 0) {
					g.setColor(Color.red);
				} else {
					g.setColor(Color.MAGENTA);
				}
				g.drawLine(originX, originY, x, y);
				g.fillArc(x - 3, y - 3, size, size, 0, 360);
				break;

			case 4:
				switch (boundry_pos) {
				case 25:

					if(__25_i > 20) {
						__25_i = 0;
					}
					x = __25[0][__25_i];
					y = __25[1][__25_i++];
					
					
					break;
				case 26:

					if(__26_i > 20) {
						__26_i = 0;
					}
					x = __26[0][__26_i];
					y = __26[1][__26_i++];
					break;
					
				case 27:

					if(__27_i > 20) {
						__27_i = 0;
					}
					x = __27[0][__27_i];
					y = __27[1][__27_i++];
					break;
					
				case 29:

					if(__29_i > 20) {
						__29_i = 0;
					}
					x = __29[0][__29_i];
					y = __29[1][__29_i++];
					break;
					
				case 32:

					if(__32_i > 20) {
						__32_i = 0;
					}
					x = __32[0][__32_i];
					y = __32[1][__32_i++];
					break;
					
				case 36:

					if(__36_i > 20) {
						__36_i = 0;
					}
					x = __36[0][__36_i];
					y = __36[1][__36_i++];
					break;
					
				case 39:

					if(__39_i > 20) {
						__39_i = 0;
					}
					x = __39[0][__39_i];
					y = __39[1][__39_i++];
					break;
				}

				g.setColor(Color.cyan);
				g.drawLine(originX, originY, x, y);
				g.fillArc(x - 3, y - 3, size, size, 0, 360);
				break;
			case 6:

				switch (boundry_pos) {
				case 25:

					if(__25_i > 20) {
						__25_i = 0;
					}
					x = __25[0][__25_i];
					y = __25[1][__25_i++];
					
					
					break;
				case 26:

					if(__26_i > 20) {
						__26_i = 0;
					}
					x = __26[0][__26_i];
					y = __26[1][__26_i++];
					break;
					
				case 27:

					if(__27_i > 20) {
						__27_i = 0;
					}
					x = __27[0][__27_i];
					y = __27[1][__27_i++];
					break;
					
				case 29:

					if(__29_i > 20) {
						__29_i = 0;
					}
					x = __29[0][__29_i];
					y = __29[1][__29_i++];
					break;
					
				case 32:

					if(__32_i > 20) {
						__32_i = 0;
					}
					x = __32[0][__32_i];
					y = __32[1][__32_i++];
					break;
					
				case 36:

					if(__36_i > 20) {
						__36_i = 0;
					}
					x = __36[0][__36_i];
					y = __36[1][__36_i++];
					break;
					
				case 39:

					if(__39_i > 20) {
						__39_i = 0;
					}
					x = __39[0][__39_i];
					y = __39[1][__39_i++];
					break;
				}
				g.setColor(Color.YELLOW);
				//Shape shape = new QuadCurve2D.Float(originX, originY, 1f, 1f, x, y);
				//g.draw(shape);						
				g.drawLine(originX, originY, x, y);
				g.fillArc(x - 3, y - 3, size, size, 0, 360);

				break;
			default:
				if (wicket != 0) {
					g.setColor(Color.red);
				} else {
					g.setColor(Color.orange);
				}
				g.drawLine(originX, originY, x, y);
				g.fillArc(x - 3, y - 3, size, size, 0, 360);
				break;
			}
			g.setColor(Color.ORANGE);
			g.fillArc(originX - 2, originY - 2, 6, 6, 0, 360);
		}
	}

	if (!flag) {
		g.setColor(Color.white);
		g.drawString("No data.", 95, 60);
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

	// Wicket	RED				
	g.setColor(Color.red);
	g.fill3DRect(5, 5, 20, 14, true);

	// Dot 		Black		
	g.setColor(Color.BLACK);
	g.fill3DRect(5, 20, 20, 14, true);

	//1 Runs	Light_Gray		
	g.setColor(Color.white);
	g.fill3DRect(210, 35, 20, 15, true);

	// 2 Runs	Gray
	g.setColor(Color.BLUE);
	g.fill3DRect(210, 20, 20, 15, true);

	// 3 Runs	BLUE
	g.setColor(Color.MAGENTA);
	g.fill3DRect(210, 5, 20, 15, true);

	// 4 Runs	CYAN
	g.setColor(Color.cyan);
	g.fill3DRect(180, 20, 20, 15, true);

	// 6 Runs	GREEN
	g.setColor(Color.YELLOW);
	g.fill3DRect(180, 5, 20, 15, true);

	// Other Runs	GRAY
	//g.setColor(Color.GRAY);
	//g.fill3DRect(40,5,20,10, true);

	//g.setColor(Color.white);
	//g.drawString("On Side", 10, 340);
	//g.setColor(Color.BLACK);
	//g.drawString("Off Side", 175, 340);

	g.setColor(Color.BLACK);
	g.drawString("Wicket", 30, 15);
	g.drawString("No Run", 30, 30);
	g.drawString("1", 215, 47);
	g.drawString("3", 215, 17);
	g.drawString("4", 187, 32);
	g.drawString("6", 187, 17);

	g.setColor(Color.yellow);
	g.drawString("2", 215, 32);

	response.setContentType("image/png");
	OutputStream os = response.getOutputStream();
	try {
		ImageIO.write(img, "png", os);
	} catch (IOException e) {
		e.printStackTrace();
	}
	os.close();
%>
