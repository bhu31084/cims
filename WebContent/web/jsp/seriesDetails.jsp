
<!--
Page Name 	 : /NewWeb/jsp/WebLogin.jsp
Created By 	 : Archana Dongre.
Created Date : 10 feb 2009
Description  : New Web Login Page.
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ include file="loginvalidate.jsp" %>
<%@ page import="in.co.paramatrix.common.ChangeInitial"%>
<%		
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");			
	Common common = new Common();
	//String currentYear = sdf.format(new Date()).substring(0,4);
	//String currentmonth = sdf.format(new Date()).substring(5,7);
	//GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();	
	String season = session.getAttribute("season").toString()==null?"0":session.getAttribute("season").toString();
	//System.out.println("current year is ***** "+currentYear);	
	//System.out.println("current year is ***** "+currentmonth);	
	//String message = "";	
	String seriestypeid = null;	
	String SeriesDescription = "";
	String SeriesType = "";
	String allSeriesflag = "2"; //For the Tournament list sp execution.
	String SeriesDesc = "";
	Vector vParam =  new Vector();	
	CachedRowSet  			crsObjGetSeriesdata			=	null;	
	vParam.add(allSeriesflag);
	vParam.add(season); 
	
	crsObjGetSeriesdata = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_series_list_web",vParam,"ScoreDB");
	vParam.removeAllElements();	
	//Vector 					vparam 					=  	new Vector();
	CachedRowSet 			crsObjGetFirstSeriesdata        =	null;
	CachedRowSet 			crsObjFirstSerPt        =	null;
	CachedRowSet 			crsObjGetTopBowler       =	null;
	CachedRowSet 			crsObjGetTopbatsman       =	null;
	//String seriestypeid = null;
	String gsplayerphoto = null;
	String gsplayerId = "";		
	String gsbowler = "";
	String gsassociation= "";
	String gstotal_wicktes = "";
	String gsmatchplayed = "";
	String gsclublogo = null;	
	String gstotal_runs = "";
	int recentresultCounter = 0;
	ArrayList<String> getmatchIds =  new ArrayList<String>();
	ChangeInitial chgInitial = new ChangeInitial();
	String iniChgBatsman = null;
	String iniChgBowler = null;
	
	String topBowlerflag = "1";	
	Boolean firstSeriesFlag = false;
	String seriesId = "";
	String seriesName = "";
	String gsteamId = "";
	String gsbatsmanphoto = null;
	String gsbatsmanId ="";
	String gsbatsman = "";
	String gsBatassociation= "";
		
	vparam.add(allSeriesflag);
	vparam.add(season);
	crsObjGetFirstSeriesdata = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_series_list_web",vparam,"ScoreDB");
	vparam.removeAllElements();
	if(crsObjGetFirstSeriesdata != null){
		while(crsObjGetFirstSeriesdata.next()){
			if(firstSeriesFlag == true){
				System.out.println("firstSeriesFlag "+firstSeriesFlag);
			}else{
				seriesId = crsObjGetFirstSeriesdata.getString("type");						
				seriesName = crsObjGetFirstSeriesdata.getString("description");
				firstSeriesFlag = true;
			}
		}
	}
	System.out.println("Tournament id is "+ season);
	System.out.println("seriesName is "+ seriesName);
	System.out.println("seriesId "+seriesId);
	vparam.add(seriesId);
	vparam.add(season);
	try {
		crsObjFirstSerPt = lobjGenerateProc.GenerateStoreProcedure(
		"esp_dsp_matchpointstally", vparam, "ScoreDB");
		vparam.removeAllElements();			
	} catch (Exception e) {
		System.out.println("*************Login.jsp*****************"+e);			
	}	
	
	Boolean bowlerflag = false;
	Boolean batsmanflag = false;
		
	vparam.removeAllElements();
	vparam.add(seriesId);
	vparam.add(season);
	vparam.add("");
	vparam.add("");
	vparam.add(topBowlerflag);
	//System.out.println("vector is "+vparam);
	try {
		crsObjGetTopBowler = lobjGenerateProc.GenerateStoreProcedure(
		"esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");								
		vparam.removeAllElements();			
	} catch (Exception e) {
		System.out.println("*************Login.jsp*****************"+e);			
	}
	
	try {
		vparam.removeAllElements();
		vparam.add(seriesId);
		vparam.add(season);
		vparam.add("");
		vparam.add("");
		vparam.add(topBowlerflag);
		//System.out.println("vector is "+vparam);
		crsObjGetTopbatsman = lobjGenerateProc.GenerateStoreProcedure(
		"esp_dsp_getseries_wise_top_batsman_list", vparam, "ScoreDB");								
		vparam.removeAllElements();
	} catch (Exception e) {
		System.out.println("*************Login.jsp*****************"+e);			
	}	
	%>			

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Tournament Ranking</title>
<link href="../css/Main.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/ajaxcallfunctions.js"></script>
<script language="JavaScript" src="../js/popup.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="../css/tabview.css" />
<link href="../css/concise.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/yahoo-dom-event.js"></script>
<script type="text/javascript" src="../js/connection-min.js"></script>
<script type="text/javascript" src="../js/element-beta-min.js"></script>
<script type="text/javascript" src="../js/tabview-min.js"></script>
<script type="text/javascript" src="../js/concise.js"></script>
<!--begin custom header content for this example-->
<style type="text/css">
.yui-navset div.loading div {
    background:url(../../images/loading.gif) no-repeat center center;
    height:8em; /* hold some space while loading */
}

#example-canvas h2 {padding: 0 0 .5em 0;}
</style>
<style type="text/css">
	A { text-decoration:underline;}
	A:link	{color:blue;}
	A:visited{color: blue;}
	A:hover	{color: red;background-color:#66ffff;}
	 .tab { font-weight:bold;font-size:9px; font-family:Arial,Helvetica;color:olive;}
	 .tabc { font-weight:bold; font-size:9px; text-align:center; font-family:Arial,Helvetica;color:navy;}
	 .tabb { font-weight:bold; font-size:9px; font-family:Arial,Helvetica;}
	 .tanc {FONT-WEIGHT: bold;FONT-SIZE: 9px; COLOR: navy; FONT-FAMILY: Arial,Helvetica; TEXT-ALIGN: center;}
	 .tabt { font-weight:bold; font-size:9px; font-family:Arial,Helvetica;TEXT-ALIGN: center;}	 
</style>

<script >
	var series = null;		
	var xmlHttp=null;	
	var seriesname = null;
	var SeriesTypeID =null;
	var teamname = null;
	var teamid = null;
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
	
	function callSubmit(){					
			try{
				document.getElementById('hdSubmit').value = "submit"
			
				if(document.getElementById('txtUserName').value == ""){
					alert(" User Name can not be left Blank !");
					frmSeries.txtUserName.focus();
				}else if(document.getElementById('password').value == ""){
					alert(" Password can not be left Blank !");
					frmSeries.password.focus();
				}else{
					document.frmSeries.submit();			
				}	
		}catch(err){
				alert("callSubmit"+err.description); 
		}
	}
	
	function showTopBowler(seriesId,name){
		var seasonId = document.getElementById("hidseason").value;
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{			
				var url;
		    	url="/cims/web/jsp/TopBowler.jsp?seriesId="+seriesId+"&seasonId="+seasonId+"&name="+name;
		    	document.getElementById("TopBowlerDiv").style.display='';
		    	document.getElementById("TopBowlerInstruDiv").style.display= 'none';
		    	document.getElementById("TopBatsmanDiv").style.display='';
		    	document.getElementById("TopBatsmanInstruDiv").style.display= 'none';		    	
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;					
					var cmbbox = responseResult.split("<br>");								
					var topBowler = document.getElementById("TopBowlerDiv");
					var topBatsman = document.getElementById("TopBatsmanDiv");					
					topBowler.innerHTML = cmbbox[0];
					topBatsman.innerHTML = cmbbox[1];
					
			//document.getElementById("TopBowlerDiv").innerHTML = responseResult;		
				}			   	
		}
	}
	
	function showBowler(){
		document.getElementById("TopBowlerDiv").style.display='';
		
	}
	
	function showBatsman(){
		document.getElementById("TopBatsmanDiv").style.display='';
	}
	
	function ShowFullScoreCard(matchid){
		window.open("/cims/web/jsp/FullScoreCard.jsp?matchid="+matchid,"fullscorecard",'top= 10,left = 10,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=920,height=920');
	}
</script>
</head>

<body bottommargin="0" leftmargin="0" topmargin="0" >
<form method="get" name="frmSeries" id="frmSeries">	
<jsp:include page="Header.jsp"></jsp:include>	
	<div id = "pbar" name="pbar" class="divlist" style="left: 450px;top: 300px;" align="center">
<table style="background: transparent;">			
	<tr>
		<td align="center" valign="middle" ><b><img src="../Image/loading.gif" /></b></td>
	</tr>
</table>
</div>
<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv" >
</div>
<script>showPopup('BackgroundDiv','pbar')</script>
	<div id="allserieslinkDiv">
	<table width="1000" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
    	<tr>
	    	<td style="width: 40%;" align="left" colspan="3"><input type="hidden" name="hidseason" id="hidseason" value="<%=season%>" >
	    	  	<table border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
					<tr>
						   <td style="width: 300px;" valign="top">   	   	  	   	 
					   	   	 <table style="width: 300px; height: 300px;" border="0" class="contenttable">			
					<%--			<tr>--%>
					<%--   				<td background="../Image/top_bluecen.jpg" valign="top"><img src="../Image/topAssociation.jpg" ></td>--%>
					<%--			</tr>--%>
								<tr>
							 		<td background = "../Image/top_bluecen.jpg" colspan="4" valign="top" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Tournament</td>
							   	</tr>
								<tr>
							    <td>&nbsp;</td>
							    <td>&nbsp;</td>
							    <td style="text-align: left;font-size: 13px;"><b>Tournament Name </b></td>
							    <td style="text-align: center;font-size: 13px;"><b>Matches</b></td>		    
							   </tr>
							    <%if(crsObjGetSeriesdata != null){ %>													
							     <%	int colorcounter = 1;
							     while(crsObjGetSeriesdata.next()){
							     	SeriesDescription = crsObjGetSeriesdata.getString("description");
									SeriesType = crsObjGetSeriesdata.getString("type");	   		
							   		%>			          
								 <%  if(colorcounter % 2 == 0 ){%>
			                		<tr bgcolor="#f0f7fd">
			                		<%}else{%>
			                		<tr bgcolor="#e6f1fc">	
			                		<%}%>								  			    
								    <td id="<%=colorcounter++%>">&nbsp;</td>
								    <td style="text-align: right;padding-right: 7px;font-size: 11px;"><a><IMG id="plusImage" name="plusImage" alt="" src="../Image/horizontal_arw.gif" /></a></td>				             
								    <td style="text-align: left;font-size: 11px;">									  			
								     <a id="dpAssociation" name="dpAssociation" href="javascript:showpoints('<%=crsObjGetSeriesdata.getString("type")%>','<%=SeriesDescription%>');showTopBowler('<%=SeriesType%>','<%=SeriesDescription%>')" class="serieslinks"><%=SeriesDescription%></a>
								    </td>
								    <td style="text-align: right;padding-right: 17px;font-size: 12px;"><%=crsObjGetSeriesdata.getString("num_matches_max")%>
								    </td>			    
								   </tr>	
							      <%	
							         }
							      }%>		     	      											          		
								</table>		
					   	   </td>					  	   
					  	   <td  valign="top" class=" yui-skin-sam">
					   	   	 <div id="demo1" class="yui-navset" style="width: 420px;scrollbar-base-color: #e6f1fc;scrollbar-track-color: #e6f1fc;scrollbar-face-color: #e6f1fc;
		    scrollbar-highlight-color: #e6f1fc;scrollbar-3dlight-color: gray;scrollbar-darkshadow-color: #e6f1fc;
		    scrollbar-shadow-color: gray;scrollbar-arrow-color: black;">
					   	   	 	<ul class="yui-nav">
							        <li ><a href="#tab1"><em>Top Bowler</em></a></li>
							        <li ><a href="#tab2"><em>Top Batsman</em></a></li>
							        <li class="selected"><a href="#tab3"><em>Team Ranking</em></a></li>
							    </ul> 					   	  			               
							    <div class="yui-content" style="height: 421px;overflow: auto;" class="scrollBarsHV">
							        <div style="width: 450px;" >
							        	<div id="TopBowlerDiv" style="display: none;" ></div>
										<DIV id="TopBowlerInstruDiv" >
												<table style="width: 450px;" border="0" >
												<tr>
													<td colspan="3" ><b><%=seriesName%></b></td>
												</tr>
												<%if(crsObjGetTopBowler != null ){			
													if(crsObjGetTopBowler.size() == 0){				
													message = " Data Not Available ";%>
												<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
												<%}else{%>
												<%while(crsObjGetTopBowler.next()){
													if(bowlerflag == true){
													}else{
													gsplayerphoto = crsObjGetTopBowler.getString("photograph_path");
													//System.out.println("photo path is "+gsplayerphoto);
													gsplayerId = crsObjGetTopBowler.getString("id");
													gsbowler = crsObjGetTopBowler.getString("bowler");
													iniChgBowler = chgInitial.properCase(gsbowler).trim();
													//System.out.println("finiChgBowler+ghghfd"+iniChgBowler);
													gsassociation= chgInitial.properCase(crsObjGetTopBowler.getString("association"));
													gstotal_wicktes = crsObjGetTopBowler.getString("total_wicktes");
													gsmatchplayed = crsObjGetTopBowler.getString("matchplayed");
													bowlerflag = true;
												} 
											}		
											%>									
												<tr>
													<td align="center" colspan="3">
														<div align="center" >
														<%if(gsplayerphoto == null){%>
																<img src="../Image/noimage.jpg" width="180" height="180" />											
															<%}else{%>
																<img src="../../<%=gsplayerphoto%>" width="180" height="180" />
															<%}%>
														</div>																
													</td>
												</tr>
												<tr>
													<td>
														<table style="width: 450px;" border="0" >
													   	<tr>
			<%--									 		<td class="boldtext">&nbsp;</td>--%>
													  		<td class="boldtext" >Name </td>
													  		<td class="innertable"><%=iniChgBowler%></td>
<%--													  		<td class="innertable"><%=gsbowler%></td>--%>
													   	</tr>
													   	<tr>
			<%--									  		<td>&nbsp;</td>--%>
													   		<td class="boldtext" >Association</td>
															<td class="innertable"><%=gsassociation%></td>
												       	</tr>													                	            	            	
												       	<tr>
			<%--								       		<td>&nbsp;</td>--%>
												      		<td class="boldtext" >Wickets</td>
												       		<td class="innertable"><%=gstotal_wicktes%></td>
												      	</tr>		    	            	
												      	<tr>
			<%--								       		<td>&nbsp;</td>--%>
												       		<td class="boldtext" >Matches</td>
												       		<td class="innertable"><%=gsmatchplayed%></td>
												     	</tr>
												       	<tr>
			<%--								      		<td>&nbsp;</td>--%>
												       		<td class="boldtext" >Comment</td>
												      		<td class="innertable">&nbsp;</td>
												       	</tr>
												       	<tr>
			<%--								       		<td>&nbsp;</td>--%>
												       		<td colspan="2" class="innertable"></td>
												   		</tr>
														</table>
													</td>
												</tr>
												<% }
												}	%>
												</table>
											</div>
					        		</div>
							        <div>
							        	<table style="width: 450px;" border="0" id="colBatsmanName">
											<tr>
												<td>
													<div id="TopBatsmanDiv" style="display: none;"  ></div>
													<DIV id="TopBatsmanInstruDiv" >
														<table style="width: 450px;" border="0" >
														<tr>
															<td colspan="3" ><b><%=seriesName%></b></td>
														</tr>
														<%if(crsObjGetTopbatsman != null ){			
															if(crsObjGetTopbatsman.size() == 0){				
															message = " Data Not Available ";%>
														<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
														<%}else{%>
														<%while(crsObjGetTopbatsman.next()){
														if(batsmanflag == true){
													}else{
														gsbatsmanphoto = crsObjGetTopbatsman.getString("photograph_path");
														gsbatsmanId = crsObjGetTopbatsman.getString("id");
														gsbatsman = crsObjGetTopbatsman.getString("batsman");
														iniChgBatsman = chgInitial.properCase(gsbatsman).trim();
														gsBatassociation= chgInitial.properCase(crsObjGetTopbatsman.getString("association"));
														gstotal_runs = crsObjGetTopbatsman.getString("total_runs");
														//gsmatchplayed = crsObjGetTopbatsman.getString("matchplayed");
														batsmanflag = true;
												}
													}%>
														<tr>
															<td align="center" colspan="3">
																<div align="center">
																<%if(gsbatsmanphoto == null){%>
																	<img src="../Image/noimage.jpg" width="180" height="180" />											
																<%}else{%>
																	<img src="../../<%=gsbatsmanphoto%>" width="180" height="180" />
																<%}%>
																</div>
															</td>
														</tr>
														<tr>
															<td>
																<table style="width: 450px;" border="0" >
																<tr>
					<%--											<td class="boldtext">&nbsp;</td>--%>
																	<td class="boldtext" >Name </td>
																	<td class="innertable" ><%=iniChgBatsman%></td>
																</tr>
																<tr>
					<%--											<td>&nbsp;</td>--%>
																	<td class="boldtext" >Association</td>
																	<td class="innertable"><%=gsBatassociation%></td>
																</tr>													                	            	            	
																<tr>
						<%--										<td>&nbsp;</td>--%>
																	<td class="boldtext" >Total Runs</td>
																	<td class="innertable"><%=gstotal_runs%></td>
																</tr>
																<tr>
					<%--								       		<td>&nbsp;</td>--%>
														       		<td class="boldtext" >Matches</td>
														       		<td class="innertable">0</td>
														     	</tr>		    	            	            	
																<tr>
										<%--<td>&nbsp;</td>--%>
												            		<td class="boldtext" >Comment</td>
												             		<td class="innertable">&nbsp;</td>
												            	</tr>
												            	<tr>
					<%--						             		<td>&nbsp;</td>--%>
												              		<td colspan="2" class="innertable"></td>
												         		</tr>
												     		</table>
														</td>
													</tr>
													 <%	}
													}	%>
												</table>			
												</div>														
											</td>
										</tr>
										</table>
									</div>
									<div>
									<div id="secondpageDiv" style="display: none;height: 800px;overflow: auto;"></div>
					    			<div id="loadpagediv" style="height: 800px;overflow: auto;">
					    				<table style="width: 450px;" border="0" id="tlb11" >
											<tr>
												<td>
													
													<DIV id="MatchPointsDiv" style="display: none;"></div>
													<DIV id="instructionDiv" style="color: black;"> 
														<table border="1" style="width: 450px;" align="center" class="contenttable">									
														<tr>
															<td background = "../Image/top_bluecen.jpg" colspan="11" valign="top" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" ><%=seriesName%></td>															
														</tr>
														<tr >
													   		<td  align="center"  >&nbsp;</td>
													   		<td width="15%" align="right" ><b>Team</b></td>	       		
													   		<td  align="center"><b>Played </b></td>
													   		<td  align="center" ><b>Points </b></td>
													   		<td  align="center" ><b>Win </b></td>
													    	<td  align="center" ><b>Draw </b></td>
													       	<td align="center" ><b>Tie </b></td>	       		
													       	<td  align="center" ><b>Loss </b></td>
<%--													   		<td align="center" ><b>Live </b></td>--%>
													   		<td align="center" ><b>Quotient</b></td>
														</tr>							
														<%if(crsObjFirstSerPt != null ){
																int counter = 1;
																if(crsObjFirstSerPt.size() == 0){				
																message = " Data Not Available ";%>
														<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
															<%}else{
															int colorcounter = 1;%>
															<%while(crsObjFirstSerPt.next()){
																gsteamId = crsObjFirstSerPt.getString("team_id");
															if(colorcounter % 2 == 0 ){%>
									                		<tr bgcolor="#f0f7fd">
									                		<%}else{%>
									                		<tr bgcolor="#e6f1fc">	
									                		<%}%>				
															<td align="center" nowrap="nowrap" id="<%=colorcounter++%>" ><IMG id="plusImage<%=gsteamId%>" name="plusImage<%=gsteamId%>" title="Click On Star To Get The Details." alt="" src="../Image/star.gif" /></td>
															<td align="center" nowrap="nowrap" ><a href="javascript:ShowTeamPositionDetailDiv('<%=gsteamId%>','<%=crsObjFirstSerPt.getString("series")%>')"><%=crsObjFirstSerPt.getString("team_name")%></a></td>
															<td style="text-align: right;padding-right: 15px;"><%=crsObjFirstSerPt.getString("Played")%></td>	
															<td style="text-align: right;padding-right: 15px;" ><%=crsObjFirstSerPt.getString("points")%></td>
															<td style="text-align: right;padding-right: 10px;" ><%=crsObjFirstSerPt.getString("Win")%></td>
															<td style="text-align: right;padding-right: 15px;" ><%=crsObjFirstSerPt.getString("Draw")%></td>
															<td style="text-align: right;padding-right: 7px;"><%=crsObjFirstSerPt.getString("Tie")%></td>														
															<td style="text-align: right;padding-right: 15px;"><%=crsObjFirstSerPt.getString("Loss")%></td>
<%--															<td style="text-align: right;padding-right: 10px;" ><%=crsObjFirstSerPt.getString("Live")%></td>--%>
															<td style="text-align: right;padding-right: 15px;" ><%=crsObjFirstSerPt.getString("Quotient")%></td>													
														</tr>
														<tr>
															<td colspan="12">
																<div id="ShowMatchPtDetailsDiv<%=gsteamId%>" style="display:none" ></div>
															</td>
														</tr>
														<%}%>
												<%		}
													}
											%>																
											</table>
						    			</div>
						    		</div>	
							    </div>
							</div>
					   </td>
						</tr>
					</table>
   			</td>
   		</tr>				   
   	</table>			
	<table width="1000" border="0" cellspacing="0" cellpadding="0" align="center" >
		<tr>
		        		<td>		        			
				          	<br /><br />
				         	<br />
				          	<br />
				          	<br />
				          	<br />
				          	<br />				          	<br />
				          	<br />
				        </td>
					    <td>&nbsp;</td>
					    <td>&nbsp;</td>
		      		</tr>
	</table>

</form>
<script>
(function() {
    var tabView = new YAHOO.widget.TabView('demo1');
    YAHOO.log("The example has finished loading; as you interact with it, you'll see log messages appearing here.", "info", "example");
	//tabView.appendTo('container');
})();

</script>
<jsp:include page="Footer.jsp"></jsp:include>
<script>    	
	closePopup('BackgroundDiv','pbar');	
 </script>
</body>		
</html>	

