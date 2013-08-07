<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"
%>
<% 	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
			
	String matchId = (String)session.getAttribute("matchId1");
	String overNumber =	request.getParameter("overNumber");
	String toolTipFlag = request.getParameter("tooltipflag");
	String inningId = (String)session.getAttribute("InningId");
	CachedRowSet ballsInOverCrs = null;
	LogWriter log = new LogWriter();
	GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
	Vector spParamVec = new Vector();
	String gsruns =	"";
	String allBallIds = "";
	String flag = "false";//flag to add blank tr in between current and next over
	
try{		
	try{	
		spParamVec.add(overNumber); // over no
		spParamVec.add(inningId); //inn id
		if(toolTipFlag.equalsIgnoreCase("0")){
			ballsInOverCrs = spGenerate.GenerateStoreProcedure("esp_dsp_ballsinover",spParamVec,"ScoreDB");
		}else if(toolTipFlag.equalsIgnoreCase("1")){//to display clicked over balls plus next over's balls 
													//which is not yet completed
			//To display tool tip
			ballsInOverCrs = spGenerate.GenerateStoreProcedure("esp_dsp_overdetails",spParamVec,"ScoreDB");
		}
		spParamVec.removeAllElements();
	}catch (Exception e) {
	   System.out.println("*************updateOver.jsp*****************"+e);
	   log.writeErrLog(page.getClass(),matchId,e.toString());
	}		
%>	
<%if(toolTipFlag.equalsIgnoreCase("0")){
%>
<html>
	<head>
		<title> Balls In Over </title>
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">	  
    	<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
    	<link rel="stylesheet" type="text/css" href="../CSS/csms.css">
	</head>		
	<body>
	
	
	<table align="center" border="1" width="95%">
		<tr>
			<td colspan="15" ><center><b>Over Number : <%=(Integer.parseInt(overNumber)+1)%> </b> </center></td>
		</tr>
		<tr class="tenoverupdateball">
			<th>&nbsp;</th>
			<th>Ball No</th>
			<th>Bowler</th>
			<th>Batsman</th>
			<th>Non Striker</th>
			<th>Over</th>
			<th>Runs</th>
			<th>Wides</th>
			<th>No balls</th>
			<th>Leg byes</th>
			<th>Byes</th>
			<th>Wkt</th>
			<th>Over the wkt</th>
			<th>Date</th>
			<th>&nbsp;</th>
		</tr>
<%	if(ballsInOverCrs!=null){		
		int i = 1;
		while(ballsInOverCrs.next()){
			allBallIds = allBallIds + ballsInOverCrs.getString("ball_id") + "~";
			if(ballsInOverCrs.getInt("overno") == (Integer.parseInt(overNumber)+2) && flag.equalsIgnoreCase("false")){
				flag = "true";
				i = 1;//to start next over ballno with 1
%>		<tr><!--For over which is not completed-->
			<td colspan="15"><center><b>Over Number : <%=(Integer.parseInt(overNumber)+2)%> </b> </center></td>
		</tr>
<%			}//end if
		if(ballsInOverCrs.getString("authentic").equalsIgnoreCase("N")){
%>		<tr class="contentOffline">
<%			}else if(ballsInOverCrs.getString("authentic").equalsIgnoreCase("M")){
%>		<tr class="contentUpdated">
<%			}else{	
%>		<tr class="contentLastDark" > 
<%			}
%>
			<td><input type="checkbox" id="chkBallId" name="chkBallId" value="<%=ballsInOverCrs.getString("ball_id")%>"></td>
			<td><%=i%></td>
			<td nowrap class="lefttd"><%=ballsInOverCrs.getString("Bowler")%></td>
			<td nowrap class="lefttd"><%=ballsInOverCrs.getString("Batsman")%></td>
			<td nowrap class="lefttd"><%=ballsInOverCrs.getString("NonStriker")%></td>
			<td nowrap><%=ballsInOverCrs.getString("overno")%></td>
			<td><%=ballsInOverCrs.getString("runs")%></td>
			<td><%=ballsInOverCrs.getString("wideball")%></td>
			<td><%=ballsInOverCrs.getString("noball")%></td>
			<td><%=ballsInOverCrs.getString("legbeyes")%></td>
			<td><%=ballsInOverCrs.getString("byes")%></td>
			<td><%=ballsInOverCrs.getString("wkt")%></td>
			<td><%=ballsInOverCrs.getString("over_wkt")%></td>
			<td nowrap="nowrap"><%=ballsInOverCrs.getString("ball_date")%></td>
			<td class="lefttd"><a href="javascript:callFun.updateOverRuns('<%=i%>',
																'<%=ballsInOverCrs.getString("ball_id")%>',
																'<%=ballsInOverCrs.getString("runs")%>',
																'<%=ballsInOverCrs.getString("wideball")%>',
																'<%=ballsInOverCrs.getString("noball")%>',
																'<%=ballsInOverCrs.getString("legbeyes")%>',
																'<%=ballsInOverCrs.getString("byes")%>',
																'<%=ballsInOverCrs.getString("wkt")%>',
																'<%=ballsInOverCrs.getString("overno")%>',
																'<%=ballsInOverCrs.getString("ball_date")%>',
																'<%=ballsInOverCrs.getString("strikerid")%>',
																'<%=ballsInOverCrs.getString("Bowler")%>',
																'<%=ballsInOverCrs.getString("BowlerId")%>')">EDIT</a></td>
		</tr>	
<%			i=i+1;
		}//end while
	}//end if
%>
	</table>
		<br>
	<table>
		<tr>
			<td><input type="button" align="center" value="Swap Batsman"  
				onclick="callFun.updateBall(''),callFun.updateScore('<%=overNumber%>')"></input></td>
			<td><input type="button" align="center" value="Swap All Batsman" 
				 onclick="callFun.updateBall('<%=allBallIds%>'),callFun.updateScore('<%=overNumber%>')"></input></td>
			<td><input type="button" align="center" value="Cancel"  
				onclick="closePopup('BackgroundDiv','selectedOverBallsDiv');closePopup('BackgroundDiv','updateRunsDiv'),
				closePopup('BackgroundDiv','updateWicketDiv')"></input></td>		
		</tr>
	</table>
	</body>
</html>	
<%}else if(toolTipFlag.equalsIgnoreCase("1")){
%>
<%
			String result = "";
			if(ballsInOverCrs!=null){		 
				int i = 0;
				String runs = "";
				String wideball = "";
				String noball = "";
				String legbyes= "";
				String byes = "";
				String wicket = "";
				String over	=	"";
				boolean overflag = false;
				String previousover = null;
				
				while(ballsInOverCrs.next()){
					over = ballsInOverCrs.getString("overno");
					if(over.equalsIgnoreCase(previousover)){
						overflag = false;
					}else{
						if(previousover!=null){
							overflag = true;
						}
						previousover = ballsInOverCrs.getString("overno");
					}
					if(overflag){
						result = result.substring(0,(result.length()-1)) + "~"; // remove last ball comma and add Delta 
					}
					runs = ballsInOverCrs.getString("runs");
					wideball = ballsInOverCrs.getString("wideball");
					
					if(!(wideball.equalsIgnoreCase("0"))){
						wideball = "W";
					}
					
					noball = ballsInOverCrs.getString("noball");
					if(!(noball.equalsIgnoreCase("0"))){
						noball = "NB";
					}
					
					legbyes = ballsInOverCrs.getString("legbeyes");
					if(legbyes.equalsIgnoreCase("Y")){
						legbyes = "LB";
					}
					
					byes = ballsInOverCrs.getString("byes");
					if(byes.equalsIgnoreCase("Y")){
						byes = "B";
					}
					
					wicket = ballsInOverCrs.getString("wkt");
					if(wicket.equalsIgnoreCase("Y")){
						wicket = "WKT";
					}
					
					result = result +  runs  ;
					if(wideball.equalsIgnoreCase("W")){
						result = result + wideball ;
					}
					
					if(noball.equalsIgnoreCase("NB")){
						result = result + noball  ;
					}
					
					if(legbyes.equalsIgnoreCase("LB")){
						result = result + legbyes  ;
					}
					
					if(byes.equalsIgnoreCase("B")){
						result = result + byes  ;
					}
					
					if(wicket.equalsIgnoreCase("WKT")){
						result = result +wicket  ;
					}
						result = result + ",";
					
					i=i+1;
				}//while end
			}//end if
			out.println(result.substring(0,(result.length()-1))); 
}//end else if "1"
		}catch(Exception e){
			System.out.println("*************updateOver.jsp*****************"+e);
			e.printStackTrace();
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		
		finally{
			matchId = null;
			inningId = null;
			overNumber = null;
			toolTipFlag = null;
			ballsInOverCrs = null;
			log = null;
			spGenerate = null;
			spParamVec = null;
			gsruns = null;
			allBallIds = null;
		}
%>
		
