<!--
Page Name 	 : /web3/jsp/Teamlineup.jsp
Created By 	 : Archana Dongre.
Created Date : 10 feb 2009
Description  : New Web Login Page.
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*"%>
<%		
	
	String matchid = request.getParameter("matchid")==null?"":request.getParameter("matchid");
	System.out.println("match_id by request "+matchid);
	String matchId = null;
	if(matchid == null || matchid == ""){
		matchId = (String)session.getAttribute("match_id");		
	}else{
		session.setAttribute("match_id",matchid);
		matchId = (String)session.getAttribute("match_id");		
	}
	System.out.println("match_id "+matchId);	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");				
	
	String team1 = "";
	String team2 = "";
	String team1Id = "";
	String team2Id = "";			
	String message = "";
	String passflag = "2";
	//Boolean playersflag = false;
	CachedRowSet  crsObjgetTeams = null;		
	CachedRowSet  crsObjgetPlayers = null;
	CachedRowSet  crsObjgetteam2Player = null;	
	Vector vParam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	
	ArrayList<String> list =  new ArrayList<String>();
	ArrayList<String> list2 =  new ArrayList<String>();
	
		try{			
			vParam.add(matchId);
			crsObjgetTeams = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getteams_web",vParam,"ScoreDB");
			vParam.removeAllElements();
			if(crsObjgetTeams != null){
				while(crsObjgetTeams.next()){
					team1Id = crsObjgetTeams.getString("team1_id");
					team1 = crsObjgetTeams.getString("team1");
					team2Id = crsObjgetTeams.getString("team2_id");
					team2 = crsObjgetTeams.getString("team2");
					System.out.println("team1 "+team1);
					System.out.println("team2 "+team2);
				}
			}
			
		}catch (Exception e) {
			System.out.println("Exception"+e);
			e.printStackTrace();
		}	
		
		try{
			vParam.add(matchId);
			vParam.add(team1Id);
			crsObjgetPlayers = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_viewplayer_selected_web",vParam,"ScoreDB");
			vParam.removeAllElements();	
		}catch (Exception e) {
			System.out.println("Exception"+e);
			e.printStackTrace();
		}	
		
		try{
			vParam.add(matchId);
			vParam.add(team2Id);
			crsObjgetteam2Player = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_viewplayer_selected_web",vParam,"ScoreDB");
			vParam.removeAllElements();
		
		}catch (Exception e) {
			System.out.println("Exception"+e);
			e.printStackTrace();
		}		
		%>			

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CIMS 2009</title>
<link href="../css/Main.css" rel="stylesheet" type="text/css" />
<%--<link href="../css/form.css" rel="stylesheet" type="text/css" />--%>
<link href="../css/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
<link href="../css/commonSpry.css" rel="stylesheet" type="text/css" />
<%--<link href="../Image/Main.css" rel="stylesheet" type="text/css" />--%>
<%--<script src="../js/SpryDOMUtils.js" type="text/javascript"></script>--%>
<%--<script src="../js/cp_unobtrusive.js" type="text/javascript"></script>--%>
<script language="JavaScript" type="text/javascript" src="../js/SpryTabbedPanels.js"></script>
<%--<script language="javascript" type="text/javascript" src="../js/tp_unobtrusive.js"></script>--%>
<script language="JavaScript" src="../js/otherFeedback.js"></script>
<%--<script src="../js/SpryMenuBar.js" type="text/javascript"></script>--%>

<script >
	var xmlHttp=null;	
	function GetXmlHttpObject() {
		try{
			//Firefox, Opera 8.0+, Safari
			xmlHttp=new XMLHttpRequest();
		}catch (e){
			// Internet Explorer
			try{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}catch (e){
				try{
					xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
				}catch(e){
					alert("Your browser does not support AJAX!");      				
				}	
			}
		}
		return xmlHttp;
	}	
	
	function showTeamPlayers(){		
		//alert("matchid" +matchid)
		document.frmplayerStatus.action="/cims/web/jsp/TeamLineUp.jsp";
       	document.frmplayerStatus.submit();		
	}

	function showWagonWheel(matchid){		
		//alert("matchid "+matchid);
		window.open("/cims/web/jsp/wagonwheel.jsp?matchid="+matchid,"CIMSwagonwheel",'location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=400,left=100,width=600,height=500');		
	}
	function Showinningsummery(matchid){
		//alert(matchid)
		window.open('/cims/web/jsp/InningsDetail.jsp?matchid='+matchId,'inningdetail','top= 50,left = 50,location=no,directories=no,status=yes,menubar=no,scrollbars=no,resizable=no,width=420,height=400');
	}
	function ShowLiveScoreCard(matchid){
		//alert("matchid "+matchid)
		window.open("/cims/web/jsp/liveScoreCard.jsp?matchid="+matchid,"CIMSweb",'location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=310,left=780,width=200,height=252');
	}	
	function ShowFullScoreCard(matchid){
		//alert("Match ID is*** "+matchid)		
		window.open("/cims/web/jsp/FullScoreCard.jsp?matchid="+matchid,"fullscorecard",'top= 50,left = 50,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=920,height=920');
	}
</script>
</head>

<body bottommargin="0" leftmargin="0" topmargin="0" >
<jsp:include page="Header.jsp"></jsp:include>
<form method="get" name="frmplayerStatus" id="frmplayerStatus">		
<div id="outerDiv" style="width: 1003px;height: 500px;">			
	<table style="width: 1003px;">
		<tr>
			<td valign="top">
				<table width="150" border="0" >
				   <tr>
				 	<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Scoring Details</td>
				   </tr>
				   <tr>
	            		<td valign="top" style="text-align: left;padding-left: 10px;font-family: georgia;">
							<a href="javascript:ShowFullScoreCard('<%=matchId%>')" id="<%=matchId%>">Full Scorecard</a>
					    </td>
				    </tr>							    
				    <tr>
		           		<td valign="top" style="text-align: left;padding-left: 10px;font-family: georgia;">
							<a href="javascript:ShowLiveScoreCard('<%=matchId%>')" id="<%=matchId%>" >Desktop ScoreCard</a>
					    </td>
				    </tr>
				    <tr>
		           		<td valign="top" style="text-align: left;padding-left: 10px;font-family: georgia;">
							<a href="javascript:showTeamPlayers('<%=matchId%>')" id="<%=matchId%>" >Team Players</a>
					    </td>
				    </tr>							   
<%--				    <tr>--%>
<%--		           		<td valign="top" style="text-align: left;padding-left: 10px;font-family: georgia;">--%>
<%--							<a href="javascript:Showinningsummery('<%=matchId%>')" id="<%=matchId%>" >Inning Summery</a>--%>
<%--					    </td>--%>
<%--				    </tr>--%>
				    <tr>
		           		<td valign="top" style="text-align: left;padding-left: 10px;font-family: georgia;">
							<a href="javascript:showWagonWheel('<%=matchId%>')" id="<%=matchId%>" >Wagon Wheel </a>
					    </td>
				    </tr>
<%--				    <tr>--%>
<%--		           		<td valign="top" style="text-align: left;padding-left: 10px;font-family: georgia;">--%>
<%--							<a href="javascript:showPitchPad('<%=matchId%>')" id="<%=matchId%>" >Pitch Pad </a>--%>
<%--						</td>--%>
<%--					</tr>				   							  												  												          		--%>
				</table>
			</td>
			<td width="650" border="0" valign="top">
				<div id="MainteamlineupDiv" style="width: 650px;height: 650px;">
			   	<table width="649" border="0" >	
			   		<tr>
				 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Team Composition</td>
				   </tr>				
				</table>
				</br>
				  <table width="650" border="0" style="border-left: none;border-top: none;border-right: none;border-bottom: none;" class="contenttable">
				<%if(crsObjgetPlayers != null ){			
							if(crsObjgetPlayers.size() == 0){
								message = " Data Not Available ";%>
							<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
							<%}else{ %>
							<tr bgcolor="#e6f1fc"><font size="2"><b>Playing First Team <%=team1%></b></font></tr>							
							<%while(crsObjgetPlayers.next()){ 
								if(crsObjgetPlayers.getString("is_captain").equalsIgnoreCase("y")){
									list.add(0, new String(crsObjgetPlayers.getString("name")+"(C)"));
								}else if(crsObjgetPlayers.getString("is_wkeeper").equalsIgnoreCase("y")){
									list.add(0, new String(crsObjgetPlayers.getString("name")+"(WK)"));
								}else{
									list.add(0, new String(crsObjgetPlayers.getString("name")));
								}
							}							
							int i ;%>
								<tr bgcolor="#f0f7fd">
								<%for (i = 0;i<4;i++){ %>
									<td nowrap="nowrap"><img src="../Image/teamicon.jpg" height="12px" width="10px"/>&nbsp;<%=list.get(i)%>&nbsp;</td>
								<%}%>
								</tr>
								<tr bgcolor="#f0f7fd">
								<%for (i = 4;i<8;i++){%>
									<td nowrap="nowrap"><img src="../Image/teamicon.jpg" height="12px" width="10px"/>&nbsp;<%=list.get(i)%>&nbsp;</td>
								<%}%>
								</tr>
								<tr bgcolor="#f0f7fd">														
								<%for (i = 8;i<11;i++){%>
									<td nowrap="nowrap"><img src="../Image/teamicon.jpg" height="12px" width="10px"/>&nbsp;<%=list.get(i)%>&nbsp;</td>
								<%}%>
								<%}
								}%>
								</tr>																	                			                				                	
	              </table>
	              <br>
	              <table width="650" border="0" style="border-left: none;border-top: none;border-right: none;border-bottom: none;" >
				
				<%if(crsObjgetteam2Player != null ){			
							if(crsObjgetteam2Player.size() == 0){				
								message = " Data Not Available ";
								System.out.println("message "+message);%>							
							<%}else{ %>
							<tr bgcolor="#e6f1fc"><font size="2"><b>Playing Second Team <%=team2%></b></font></tr>							
							<%while(crsObjgetteam2Player.next()){ 
								if(crsObjgetteam2Player.getString("is_captain").equalsIgnoreCase("y")){
									list2.add(0, new String(crsObjgetteam2Player.getString("name")+"(C)"));
								}else if(crsObjgetteam2Player.getString("is_wkeeper").equalsIgnoreCase("y")){
									list2.add(0, new String(crsObjgetteam2Player.getString("name")+"(WK)"));
								}else{
									list2.add(0, new String(crsObjgetteam2Player.getString("name")));
								}								
							}
						
							int j ;%>
								<tr bgcolor="#f0f7fd">
								<%for (j = 0;j<4;j++){ %>
									<td nowrap="nowrap"><img src="../Image/teamicon.jpg" height="12px" width="10px"/>&nbsp;<%=list2.get(j)%>&nbsp;</td>
								<%}%>
								</tr>
								<tr bgcolor="#f0f7fd">
								<%for (j = 4;j<8;j++){%>
									<td nowrap="nowrap"><img src="../Image/teamicon.jpg" height="12px" width="10px"/>&nbsp;<%=list2.get(j)%>&nbsp;</td>
								<%}%>
								</tr>
								<tr bgcolor="#f0f7fd">														
								<%for (j = 8;j<11;j++){%>
									<td nowrap="nowrap"><img src="../Image/teamicon.jpg" height="12px" width="10px"/>&nbsp;<%=list2.get(j)%>&nbsp;</td>
								<%}
								}
					}	
								%>
								</tr>	            			                				                	
	              </table>
				</div>
				<div id="wagonwheeldiv" style="display: none;">
					<table>
						<tr>
						</tr>
					</table>
				</div>				
			</td>
			<td width="200" border="0" valign="top"></td>
		</tr>
	</table>
</div>		
</form>				
<table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" >
<tr>
	<td>
		<br />
     	<br />
      	<br />      	
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
	</tr>
</table>
		
<jsp:include page="Footer.jsp"></jsp:include>	
</body>		
</html>	

