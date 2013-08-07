<!--
	Author 				: Saudagar Mulik
	Created Date		: 13/09/2008
	Description 		: Ajax response page for WagonWheel.jsp.
	Company 	 		: Paramatrix Tech Pvt Ltd.
	Modification Date	: 13/09/2008
-->
 
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

		String storedProcName = request.getParameter("spName");
		String seasonId = request.getParameter("seasonId");
		String player1 = request.getParameter("id");
		
		Enumeration enumeration = session.getAttributeNames();		
		while(enumeration.hasMoreElements()){
			System.out.print(enumeration.nextElement() + " ");
		}
		

		GenerateStoreProcedure generateStProc = new GenerateStoreProcedure();
		
		/** Image Detail retrieve from database. */
		vSpParam.add("2");
		crsImageDetail = generateStProc.GenerateStoreProcedure(
					"esp_getImageDetail", vSpParam, "ScoreDB");
					
		int size = 6;
		int originX = 0;
		int originY = 0;
		if(crsImageDetail != null && crsImageDetail.next()){
			originX = crsImageDetail.getInt("originX");
			originY = crsImageDetail.getInt("originX");
		}
		
		int offsetX = 0;
		int offsetY = 26;
		
		originX = originX + offsetX;
		originY = originY + offsetY;
				
		/** Image location loaded. */
		URL u = LogWriter.class.getResource("LogWriter.class");
		String fileStr = u.getPath();			
		int length = fileStr.indexOf("/WEB-INF/");		
		fileStr = "/" + fileStr.substring(1, length) + "/images/wagon_wheel.jpg";
		fileStr = fileStr.replaceAll("%20", " ");		
		File file = new File(fileStr);
		BufferedImage img = ImageIO.read(file);
		Graphics2D g = img.createGraphics();
		vSpParam = new Vector();
		vSpParam.add(player1);
		vSpParam.add(seasonId);
		crsDrivenPoints = generateStProc.GenerateStoreProcedure(storedProcName, vSpParam, "ScoreDB");
		
		Hashtable driven_value = new Hashtable();
		
		boolean flag = false;
		
		if(crsDrivenPoints != null){
			while(crsDrivenPoints.next()){
				flag = true;
				String position = crsDrivenPoints.getString("position");			
				int x = crsDrivenPoints.getInt("x");
				int y = crsDrivenPoints.getInt("y");
				int posValue = 0;
				
				if(driven_value.containsKey(position)){
					
					if(posValue < 20){
						driven_value.put(position, new Integer(Integer.parseInt(driven_value.get(position).toString().trim()) + 1));
						posValue = Integer.parseInt(driven_value.get(position).toString());
					}else{
						posValue = 1;
						driven_value.put(position, new Integer(1));
					}
				}else{
					posValue = 1;
					driven_value.put(position,  new Integer(1));
				}
				
				switch(posValue){
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
				
				g.setColor(Color.RED);
				g.fillArc(x-3, y-3, size, size, 0, 360);
				g.drawLine(originX, originY, x , y);
				
				g.setColor(Color.ORANGE);
				g.fillArc(originX - 2, originY - 2, 6, 6, 0, 360);
			}
		}
				
		if(!flag){
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
		g.fill3DRect(5,5,20,14, true);
		
		// Dot 		Black		
		g.setColor(Color.BLACK);
		g.fill3DRect(5, 20, 20, 14, true);
		
		//1 Runs	Light_Gray		
		g.setColor(Color.white);
		g.fill3DRect(210, 35, 20, 15, true);
		
		// 2 Runs	Gray
		g.setColor(Color.BLUE);
		g.fill3DRect(210,20,20,15, true);
		
		// 3 Runs	BLUE
		g.setColor(Color.yellow);
		g.fill3DRect(210,5,20,15, true);
		
		// 4 Runs	CYAN
		g.setColor(Color.cyan);
		g.fill3DRect(180, 20, 20, 15, true);
		
		// 6 Runs	GREEN
		g.setColor(Color.GREEN);
		g.fill3DRect(180,5,20,15, true);
		
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
