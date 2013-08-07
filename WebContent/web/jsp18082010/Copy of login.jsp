<!--
Page Name 	 : /web/jsp/login.jsp
Created By 	 : Archana Dongre.
Created Date : 10 feb 2009
Description  : New Web Login Page.
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="in.co.paramatrix.common.ChangeInitial"%>
<%@ page import="java.util.*"%>
<%@ include file="loginvalidate.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">

<%	
	String flag = "1"; //For the series list sp execution.
	String SeriesName = "";
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("dd/MM/yyyy");
	java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat("DD/MM/yyyy");	
	CachedRowSet  			crsObjGetSeries			=	null;
	CachedRowSet			crsObjTodayMatches      =   null;
	CachedRowSet 			crsObjGetMatchPt        =	null;
	CachedRowSet 			crsObjGetTopBowler       =	null;
	CachedRowSet 			crsObjGetTopbatsman       =	null;
	CachedRowSet 			crsObjRecentResults        =	null;
	CachedRowSet 			crsObjUpcomingMatches        =	null;
	CachedRowSet 			crsObjGetFirstSeriesdata        =	null;
	CachedRowSet 			crsObjFirstSerPt        =	null;
	CachedRowSet 			crsObjGetAssociations        =	null;			
	Boolean Assocount = false;
	String gsclubId = null;
	String gsclubName = null;	
	CachedRowSet  crsObjGetAssociationsOne = null;	
	CachedRowSet  crsObjGetAssocSeries = null;	
	String SeriesDescription = "";
	String topBowlerflag = "1";	
	Boolean firstSeriesFlag = false;	
    Common common = new Common();
    String seriesId = "";
    String getmatchId = "";
    String seasonId = "";	
    String season = "1";
    String clubname = null;
    String clublogo = null;
    String gsteamId = "";
	String topPerformerflag = "";
	String SeriesType = "";	
	String seriesName = "";
	String seriestypeid = null;
	String gsplayerphoto = null;
	String gsplayerId = "";		
	String gsbowler = "";
	String gsassociation= "";
	String gstotal_wicktes = "";
	String gsmatchplayed = "";
	String gsclublogo = null;
	
	ArrayList<String> getmatchIds =  new ArrayList<String>();
	ChangeInitial chgInitial = new ChangeInitial();
	String iniChgBatsman = null;
	String iniChgBowler = null;
	
	
	int j = 1;
	int assoCount = 0;
	String tab1 = "1";
	String res = null;
	String loadFlag = "false";
	String gsbatsmanphoto = null;
	String gsbatsmanId ="";
	String gsbatsman = "";
	String gsBatassociation= "";
	String gstotal_runs = "";
	int recentresultCounter = 0;

	String currentYear = sdf.format(new Date()).substring(0,4);
	String date_one = sdf2.format(new Date());	
	String date_two = sdf2.format(new Date());
	//To get the series list on load
	vparam.add(flag); 	
	crsObjGetSeries = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_series_list_web",vparam,"ScoreDB");
	vparam.removeAllElements();
	
	//to get the association list points,club_name,club_id
	vparam.add(season);//season id
	vparam.add("");//@club int, 
	vparam.add("");//@seriestype int,
	vparam.add("");//@teamid int,	
	vparam.add("1");//@flag int
	crsObjGetAssociations = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_associationwise_points",vparam,"ScoreDB");
	vparam.removeAllElements();
	
	try{
			//to get the association list points,club_name,club_id
			vparam.add(season);//season id
			vparam.add("");//@club int, 
			vparam.add("");//@seriestype int,
			vparam.add("");//@teamid int,	
			vparam.add("1");//@flag int
			crsObjGetAssociationsOne = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_associationwise_points",vparam,"ScoreDB");
			vparam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
			e.printStackTrace();
		}
		if(crsObjGetAssociationsOne != null){
			while(crsObjGetAssociationsOne.next()){
				if(Assocount == true){
																				
				}else{					
					gsclubId = crsObjGetAssociationsOne.getString("club_id");
					gsclublogo = crsObjGetAssociationsOne.getString("club_logo_path");
					gsclubName = crsObjGetAssociationsOne.getString("club_name");
					Assocount = true;
				}		
			}
		}
		//System.out.println("gsclubId "+gsclubId);
		//System.out.println("gsclubName "+gsclubName);	
		
		try{
			//to get the association list points,club_name,club_id
			vparam.add(season);//season id
			vparam.add(gsclubId);//@club int, 
			vparam.add("");//@seriestype int,
			vparam.add("");//@teamid int,	
			vparam.add("2");//@flag int on second step
			crsObjGetAssocSeries = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_associationwise_points",vparam,"ScoreDB");
			vparam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
			e.printStackTrace();
		}	
	
	//To get all todays matches.	
	crsObjTodayMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getmatches_web", vparam, "ScoreDB");
	vparam.removeAllElements();
	
	//System.out.println(" total match result set size "+crsObjTodayMatches.size());
	
	
	String allSeriesflag = "2"; //For the series list sp execution.
	String SeriesDesc = "";
	CachedRowSet  			crsObjGetSeriesdata			=	null;
	
	vparam.add(allSeriesflag); 	
	crsObjGetSeriesdata = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_series_list_web",vparam,"ScoreDB");
	vparam.removeAllElements();
	
	//To show first series data on page load
	vparam.add(allSeriesflag); 	
	crsObjGetFirstSeriesdata = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_series_list_web",vparam,"ScoreDB");
	vparam.removeAllElements();
	if(crsObjGetFirstSeriesdata != null){
		while(crsObjGetFirstSeriesdata.next()){
			if(firstSeriesFlag == true){
							
			}else{
				seriesId = crsObjGetFirstSeriesdata.getString("type");						
				seriesName = crsObjGetFirstSeriesdata.getString("description");
				firstSeriesFlag = true;
			}
		}
	}
	//System.out.println("Series id is "+ season);
	//System.out.println("seriesName is "+ seriesName);
	//System.out.println("seriesId "+seriesId);
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
	
	//To get the recent results and upcomming matches.
	
	vparam.removeAllElements();	
	vparam.add("1");//flag 1 (recent results)
	vparam.add("0");//To show top five matches on first page 
	crsObjRecentResults = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_fixtures_web", vparam, "ScoreDB");
	vparam.removeAllElements();	
	
	vparam.removeAllElements();	
	vparam.add("2");//flag 2 (Upcomming Matches)
	vparam.add("1");//To show top five matches on first page 		
	crsObjUpcomingMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_match_fixtures_web", vparam, "ScoreDB");
	vparam.removeAllElements();	
	
	loadFlag = "true";
		
	if(request.getParameter("message")!= null ){
		message = request.getParameter("message");
	}
	
	%>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CIMS 2009</title>
<style type="text/css">
body {
	margin:0;
	padding:0;
}

.divlist{
	   display:none;
	   position:absolute;
	   z-index:100;
	   background:#FFF;
	   position: absolute;
       border: solid #7E7E7E;
       border-width: 5px 0 0 5px;
       border: solid #7E7E7E 5px;
       background-color: #ededed;
     /*  background-color: transparent;*/
       padding-bottom: 1px;
       opacity: .9;
       filter: alpha(opacity=90);
       font-family: Arial, sans-serif;
       width:400px;
       height:115px;
}

.backgrounddiv{
	position:absolute;
	width:115%;
	height:120%;
	display: none;
	top:0px;
	left:0px;
	z-index:10;
	filter: alpha(opacity=40);
 	filter: progid:DXImageTransform.Microsoft.Alpha(opacity=40);
  	-moz-opacity: 0.50;
    opacity:0.5;
	background: #000;
}
</style>

<link rel="stylesheet" type="text/css" href="../css/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="../css/tabview.css" />
<link href="../css/concise.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/yahoo-dom-event.js"></script>
<script type="text/javascript" src="../js/connection-min.js"></script>
<script type="text/javascript" src="../js/element-beta-min.js"></script>
<script type="text/javascript" src="../js/tabview-min.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script type="text/javascript" src="../js/concise.js"></script>
<script language="JavaScript" src="../js/jsKeyRestrictvalidation.js"></script>
<script language="JavaScript" src="../js/datetimepicker.js" type="text/javascript"></script>
<!--begin custom header content for this example-->
<style type="text/css">
.yui-navset div.loading div {
    background:url(../../images/loading.gif) no-repeat center center;
    height:8em; /* hold some space while loading */
}

#example-canvas h2 {padding: 0 0 .5em 0;}
</style>
<link href="../css/Main.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/otherFeedback.js"></script>
<script language="JavaScript" src="../js/popup.js"></script>
<%--<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>--%>
<script language="javascript" type="text/javascript" src="../js/AssociationAjax.js"></script>
<script >
	var swidth=300;
	var sheight=250;
	var sbcolor= "#F4FCFF";  /*"#9DBBFF";*/
	var sspeed=3;
	var restart=sspeed;
	rspeed=sspeed;
	wholemessage = '<div align="center" class=tabb>'+
'<br>SRI LANKA, Colombo : Sri Lanka cricket '+
'<br>team captain Thillakeratne Dilshan (L)'+
'<br>congratulates Indian cricketer '+
'<br>Irfan Pathan (C) and Yusuf Pathan (R)'+
'<br>after their victory in theTwenty20'+
'<br>International (ODI) match between India'+
'<br>and Sri Lanka at the R Premadasa Stadium '+
'<br>in Colombo on February 10, 2009.'+
'<br>India beat by Sri Lanka 3 wickets.© AFP'+
'</div>';
	var time = 60000;
	function goup(){
		if(sspeed!=rspeed*8){
			sspeed=sspeed*2;
			restart=sspeed;
		}
	}
	function godown(){
		if(sspeed>rspeed){
			sspeed=sspeed/2;
			restart=sspeed;
		}
	}
	function start(){
		//alert("in start")
				
		if(document.getElementById)ns6marquee(document.getElementById('slider'));
		else if(document.all)iemarquee(slider);
				else if(document.layers)ns4marquee(document.slider1.document.slider2);
			}
		function iemarquee(whichdiv){
			iediv=eval(whichdiv);
			iediv.style.pixelTop=sheight+"px";
			iediv.innerHTML=wholemessage;
			sizeup=iediv.offsetHeight;
			ieslide();
		}
		function ieslide(){
			if(iediv.style.pixelTop>=sizeup*(-1)){
				iediv.style.pixelTop-=sspeed+"px";
				setTimeout("ieslide()",100);
			}else{
				iediv.style.pixelTop=sheight+"px";
				ieslide();
			}
		}
		function ns4marquee(whichlayer){
			ns4layer=eval(whichlayer);
			ns4layer.top=sheight;
			ns4layer.document.write(wholemessage);
			ns4layer.document.close();
			sizeup=ns4layer.document.height;
			ns4slide();
		}
		function ns4slide(){
			if(ns4layer.top>=sizeup*(-1)){
				ns4layer.top-=sspeed;
				setTimeout("ns4slide()",100);
			}else{
				ns4layer.top=sheight;
				ns4slide();
			}
		}
		function ns6marquee(whichdiv){
			ns6div=eval(whichdiv);
			ns6div.style.top=sheight+"px";
			ns6div.innerHTML=wholemessage;
			sizeup=ns6div.offsetHeight;
			ns6slide();
		}
		function ns6slide(){
			if(parseInt(ns6div.style.top)>=sizeup*(-1)){
				ns6div.style.top=parseInt(ns6div.style.top)-sspeed+"px";
				setTimeout("ns6slide()",100);
			}else{
				ns6div.style.top=sheight+"px";
				ns6slide();
			}
		}

		function getTeamLineUp(matchId){			
			document.frmScorer.action = "TeamLineUp.jsp?matchid="+matchId;			
			document.frmScorer.submit();
		}
		
		function getAssociationDetails(clubid,season){			
			document.getElementById("Assodiv").style.display = ''			
		}		
		
		function ShowliveScoreCard(matchid){			
			window.open("liveScoreCard.jsp?matchid="+matchid,"CIMSweb","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=290,left=690,width=180,height=252");
		}
		
		var i = 0;
		var live_match_id = 0;
		
		function displaylivescorecard(){				
		if( document.getElementById("hdmatchid").value != null){
		var matches = document.getElementById("hdmatchid").value
	//	if(matches != null){
		matchids = matches.replace("["," ");
		matchids = matchids.replace("]"," ");			
		var matcharr = new Array();
		matcharr = matchids.split(",");					
		matchid = matcharr[live_match_id];
		var leng = parseInt(matcharr.length); //- parseInt(1);
		if(live_match_id == leng){			
			live_match_id = 0;
				matchid = matcharr[live_match_id];							
			}
		//alert(live_match_id)
		//alert(matchid)
		timerId = setTimeout("getlivematchscorecard("+matchid+")",time);
		live_match_id++;
		}else{
			
		}			
	}
	function hideMatcheDiv(){
		if(document.getElementById("matchesDiv").style.display==''){
			document.getElementById("matchplusImage").src = "../Image/Arrow.gif"; 
			document.getElementById("matchesDiv").style.display='none';
			return;
		}else{
			document.getElementById("matchplusImage").src = "../Image/ArrowCurve.gif"; 
			document.getElementById("matchesDiv").style.display='';
			return;
		}
	}		
				
</script>
<style type="text/css">
	A { text-decoration:none;}
	A:link	{color:black;}
	A:visited{color: blue;}
	A:hover	{color: red;background-color:#66ffff;}
	 .tab { font-weight:bold;font-size:9px; font-family:Arial,Helvetica;color:olive;}
	 .tabc { font-weight:bold; font-size:9px; text-align:center; font-family:Arial,Helvetica;color:navy;}
	 .tabb { font-weight:bold; font-size:9px; font-family:Arial,Helvetica;}
	 .tanc {FONT-WEIGHT: bold;FONT-SIZE: 9px; COLOR: navy; FONT-FAMILY: Arial,Helvetica; TEXT-ALIGN: center;}
	 .tabt { font-weight:bold; font-size:9px; font-family:Arial,Helvetica;TEXT-ALIGN: center;}
	 
</style>					
</head>
 <%if(crsObjTodayMatches.size() == 0){%>
 <body bottommargin="0" leftmargin="0" topmargin="0" onload="start();">
<% }else{%>
 <body bottommargin="0" leftmargin="0" topmargin="0" onload="start();displaylivescorecard()">
 <%}%>
 	<form method="post" id="frmScorer" name="frmScorer" onkeypress="catchEnter(event)">
 	  <div id = "pbar" name="pbar" class="divlist" style="left: 250px;top: 250px;">
		<table>
			<br>
			<br>
			<br>
			<tr>
				<td align="center" valign="middle"><b><img src="../Image/wait24trans.gif" />&nbsp;<font color="red" size="3"> Loading ......</b></font></td>
			</tr>
		</table>
		</div>
		<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv" >
		</div>
		<script>showPopup('BackgroundDiv','pbar')</script>
 	  <jsp:include page="Header.jsp"></jsp:include> 	  
 	  <div id="outerDiv" style="width: 1003px;background-color: #F4FCFF;float: left">
 	    <table>
 	    	<tr>
 	    	   <td valign="top"><%@ include file="commiteeinfo.jsp" %> 	    	   	 
 	    	   </td>
 	    	   <td valign="top">
 	    	   	 <div id="SecondColDiv" style="width: 600px;">
		 	     	<table id="" border="1" style="width: 600px;" class="contenttable">
		 	     		<tr>
		 	     		   <td style="height: 252px;width: 280px;padding-left: 1px;" valign="top" >
					   	   	 <table style="height: 252px;width: 280px;" border="0" class="contenttable" align="c">
							   <tr>
							 	<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Association</td>
							   </tr>
							   <tr>
<%--							    <td>&nbsp;</td>--%>
<%--							    <td style="text-align: left;font-size: 13px;"><b>Association Name </b></td>--%>
<%--							    <td style="text-align: left;font-size: 13px;"><b>Pts</b></td>--%>
<%--							    <td style="text-align: center;font-size: 13px;"><b>Rnk</b></td>--%>
							   </tr>
							    <%if(crsObjGetAssociations != null){
							    	int colorcounter = 1;%>													
							     <%	while(crsObjGetAssociations.next()){
							   			clubname = crsObjGetAssociations.getString("club_name");
							   			clublogo = crsObjGetAssociations.getString("club_logo_path");
							   		if(assoCount == 7){
							   		}else{
							   		if(colorcounter % 2 == 0 ){%>
					        		<tr bgcolor="#f0f7fd">
					        		<%}else{%>
					        		<tr bgcolor="#e6f1fc">	
					        		<%}%>	
							    <td style="text-align: right;padding-right: 7px;font-size: 11px;font-family: Arial;" id="<%=colorcounter++%>"><a><IMG id="plusImage" name="plusImage" alt="" src="../Image/<%=clublogo%>" /></a></td>				             
							    <td style="text-align: left;font-size: 11px;font-family: Arial; ">									  			
							     <a href="javascript:getAssociationData('<%=crsObjGetAssociations.getString("club_id")%>','<%=clubname%>','<%=season%>','<%=clublogo%>');" id="dpAssociation" name="dpAssociation" ><%=clubname%></a>
							    </td>
<%--							    <td style="text-align: right;padding-right: 7px;font-size: 11px;font-family: Arial;"><%=crsObjGetAssociations.getString("points")%>--%>
<%--							    </td>--%>
<%--							    <td style="text-align: right;padding-right: 10px;font-size: 11px;font-family: Arial;"><%=j++%></td>--%>
							   </tr>	
							      <%	assoCount++;
							      }
							         }
							           }%>
							   <tr>	
							    <td></td>						   	
							    <td colspan="1" style="text-align: right; "><a href="AssociationDetails.jsp" class="serieslinks" >More >></a></td>
							   </tr>
							   </table>
					   	   </td>
		 	     		   <td width="310" valign="top" align="center" >
								<table border="0" align="center" cellpadding="0" cellspacing="0"  border="0" class="contenttable">					
									<tr>
									 	<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Association Details</td>
									</tr>
								    <tr>
								    	<td align="left">
								    		<div id="AssoDivById" style="display: none;overflow:auto;height: 210px;" class="scrollBarsHV"></div>
								    		<div id="loadPageDiv" style="overflow:auto;height: 210px;" class="scrollBarsHV">
								    		<table width="310" border="0" style="height: 210px;">				    			
								    			<tr>
													<td colspan="3" ></td>
												</tr>
												<tr>
													<td colspan="1" style="text-align: right;font-size: 14px;" valign="top"><IMG src="../Image/<%=gsclublogo%>"></td>
													<td colspan="2" style="text-align: left;padding-right:10px;font-size: 14px;"><b><%=gsclubName%></b></td>
												</tr>							
								    			<tr>
								    			<!-- club_name,series_name,points,club_id,seriestype_id,series_id-->				    				
								    				<td></td>
								    				<td style="text-align: left;padding-right:10px;font-size: 12px;"><b>Series Name</b></td>
								    				<td style="text-align: right;font-size: 12px;" width="30"><b>Pts</b></td>
								    			</tr>
								    			<%if(crsObjGetAssocSeries != null){%>
								          <%	int colorcount = 1;
								          while(crsObjGetAssocSeries.next()){
								          			seriestypeid = crsObjGetAssocSeries.getString("seriestype_id");
								          if(colorcount % 2 == 0 ){%>
							        		<tr bgcolor="#f0f7fd">
							        		<%}else{%>
							        		<tr bgcolor="#e6f1fc">	
							        		<%}%>
								             <td style="text-align: right;padding-right:10px;font-size: 11px;" id="<%=colorcount++%>">
								             <IMG id="plusImage<%=seriestypeid%>" name="plusImage<%=seriestypeid%>" alt="" src="../Image/Arrow.gif" />
								             </td><td style="text-align: left;padding-right:10px;font-size: 11px;" valign="middle"><a style="text-decoration: none;" href="javascript:ShowSeriesPositionDetailDiv('<%=gsclubId%>','<%=seriestypeid%>','<%=season%>')" >
								             <%=crsObjGetAssocSeries.getString("series_name")%>
								             </a></td>
								             <td style="text-align: right;padding-right:10px;font-size: 11px;">&nbsp;&nbsp;<%=crsObjGetAssocSeries.getString("points")%>
								             </td>
								          </tr>	
								          <tr>
											<td colspan="3">
												<div id="ShowseriesPtDetailsDiv<%=seriestypeid%>" style="display:none" ></div>
											</td>
										  </tr>	
								          <%   }
								            }%>	
								    			
								    		</table>
								    		</div>
								    	</td>
								    </tr>								    		    			    
								</table>
							</td>
		 	     		</tr>
		 	     		
		 	     		<tr>
		 	     			<td style="width: 280px;" valign="top" >   	   	  	   	 
					   	   	 <div id="serieslistdiv">
					   	   	 <table style="width: 280px; height: 460px;" border="0" class="contenttable" id="seriestable">			
								<tr>
							 	<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Series</td>
							   </tr>
								<tr>
							    <td>&nbsp;</td>
							    <td style="text-align: left;font-size: 13px;"><b>Series Name </b></td>
							    <td style="text-align: center;font-size: 13px;"><b>Matches</b></td>		    
							   </tr>
							    <%if(crsObjGetSeries != null){ %>													
							     <%	int colorcounter = 1;
							     while(crsObjGetSeries.next()){
							     	SeriesDescription = crsObjGetSeries.getString("description");
									SeriesType = crsObjGetSeries.getString("type");	   		
							   		if(colorcounter % 2 == 0 ){%>
					        		<tr bgcolor="#f0f7fd">
					        		<%}else{%>
					        		<tr bgcolor="#e6f1fc">	
					        		<%}%>			    			    
								    <td style="text-align: right;padding-right: 7px;font-size: 11px;" id="<%=colorcounter++%>"><a><IMG id="plusImage" name="plusImage" alt="" src="../Image/Arrow.gif" /></a></td>				             
								    <td style="text-align: left;font-size: 11px;">									  			
								     <a href="javascript:SeriesMatchPointsTally('<%=SeriesType%>','<%=SeriesDescription%>');showTopBowler('<%=SeriesType%>','<%=SeriesDescription%>')" id="dpAssociation<%=SeriesType%>" name="dpAssociation<%=SeriesType%>" class="serieslinks"><%=SeriesDescription%></a>
								    </td>
								    <td style="text-align: right;padding-right: 17px;font-size: 12px;"><%=crsObjGetSeries.getString("num_matches_max")%>
								    </td>			    
								   </tr>	
							      <%	
							         }
							      }%>		     
							      <tr>
							    		<td></td>
							    		<td></td>
							    		<td colspan="2" align="right"><a href="seriesDetails.jsp" class="serieslinks" id="linkmoresetfocus" name="linkmoresetfocus">More >></a></td>
							   	  </tr>											          		
								</table>
								</div>		
					   	   </td>
					   	   <td  valign="top" class=" yui-skin-sam">
					   	   	 <div id="demo" class="yui-navset" style="width: 320px;scrollbar-base-color: #e6f1fc;scrollbar-track-color: #e6f1fc;scrollbar-face-color: #e6f1fc;
		    scrollbar-highlight-color: #e6f1fc;scrollbar-3dlight-color: gray;scrollbar-darkshadow-color: #e6f1fc;
		    scrollbar-shadow-color: gray;scrollbar-arrow-color: black;">
					   	   	 	<ul class="yui-nav">
							        <li class="selected"><a href="#tab1"><em>Top Bowler</em></a></li>
							        <li ><a href="#tab2"><em>Top Batsman</em></a></li>
							        <li><a href="#tab3"><em>Team Ranking</em></a></li>
							    </ul> 					   	  			               
							    <div class="yui-content" style="height: 421px;overflow: auto;" class="scrollBarsHV">
							        <div style="width: 295px;" >
							        	<div id="TopBowlerDiv" style="display: none;" ></div>
										<DIV id="TopBowlerInstruDiv" >
												<table style="width: 295px;" border="0" >
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
														<div align="center">
														<%if(gsplayerphoto == null){%>
																<img src="../Image/noimage.jpg" width="80" height="80" />											
															<%}else{%>
																<img src="../../<%=gsplayerphoto%>" width="180" height="180" />
															<%}%>
														</div>																
													</td>
												</tr>
												<tr>
													<td>
														<table style="width:295px;" border="0" >
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
							        	<table style="width: 295px;" border="0" id="colBatsmanName">
											<tr>
												<td>
													<div id="TopBatsmanDiv" style="display: none;"  ></div>
													<DIV id="TopBatsmanInstruDiv" >
														<table style="width: 295px;" border="0" >
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
																	<img src="../Image/noimage.jpg" width="80" height="80" />											
																<%}else{%>
																	<img src="../../<%=gsbatsmanphoto%>" width="180" height="180" />
																<%}%>
																</div>
															</td>
														</tr>
														<tr>
															<td>
																<table style="width: 295px;" border="0" >
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
							        <div >
							        	<table style="width: 295px;" border="0" id="tlb11" >
											<tr>
												<td>
													<DIV id="MatchPointsDiv" style="display: none;"></div>
													<DIV id="instructionDiv" style="color: black;" > 
														<table border="0" style="width: 282px;" align="center"  >									
														<tr>
															<td colspan="5"><b><%=seriesName%></b></td>
														</tr>
														<tr >
													   		<td >&nbsp;</td>
													   		<td align="center"><b>Team</b></td>	       		
													   		<td align="center"><b>Played </b></td>
													   		<td align="center"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pts </b></td>
													   		<td align="center"><b>&nbsp;&nbsp;&nbsp;Win </b></td>
															<td align="center"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quo</b></td>
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
															<td align="center" id="<%=colorcounter++%>" ><IMG id="plusImage<%=gsteamId%>" name="plusImage<%=gsteamId%>" alt="" src="../Image/Arrow.gif" /></td>
															<td align="center" nowrap="nowrap" ><a href="javascript:ShowTeamPositionDetailDiv('<%=gsteamId%>','<%=crsObjFirstSerPt.getString("series")%>')" ><%=crsObjFirstSerPt.getString("team_name")%></a></td>
															<td align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjFirstSerPt.getString("Played")%></td>	
															<td align="right" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjFirstSerPt.getString("points")%></td>
															<td align="right" >&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjFirstSerPt.getString("Win")%></td>
															<td align="right" >&nbsp;&nbsp;&nbsp;<%=crsObjFirstSerPt.getString("Quotient")%></td>													
														</tr>
														<tr>
															<td colspan="7">
																<div id="ShowMatchPtDetailsDiv<%=gsteamId%>" style="display:none" ></div>
															</td>
														</tr>
														<%}%>
												<%		}
													}
											%>		
														<tr>
															<td colspan="7" ><div id="tosetfocus" ><b>Click On Team name To get The Match Details </b></div></td>
														</tr>
											</table>
												</div>
											</td>
										</tr>
										</table>
							        </div>
							    </div>
							</div>
					   </td>
		 	     		</tr>	 	     		
		 	     		<tr>
		 	     			<td style="width: 280px;" valign="top" class=" yui-skin-sam">
						   	     <div id="container" style="width: 280px;height: 575px;overflow: auto;" class="scrollBarsHV">
								</div>
						   	</td>
		 	     			<td valign="top">
		 	     			   <table>
		 	     			    	<tr>
		 	     			     		<td style="width: 310px;height: 220px;" valign="top">
											<table style="width:310px;height: 220px;" border="0" class="contenttable">		
											   <tr>
											 	<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Advertisements</td>
											   </tr>
												<tr>
													<td >
														<ilayer width=&{swidth}; height=&{sheight}; name="slider1" bgcolor=&{sbcolor};>
														<layer name="slider2" width=&{swidth}; onMouseover="sspeed=0;" onMouseout="sspeed=restart"></layer>
														</ilayer>
														<script language="JavaScript">if (document.getElementById || document.all){document.write('<span style="height:'+sheight+';"><div style="position:relative;overflow:hidden;width:'+swidth+';height:'+sheight+';clip:rect(0 '+swidth+' '+sheight+' 0);background-color:'+sbcolor+';" onMouseover="sspeed=0;" onMouseout="sspeed=restart"><div id="slider" style="position:relative;width:'+swidth+';"></div></div></span>')}</script>
													</td>							
												</tr>
											</table>		
										   </td>
		 	     			      	</tr>
		 	     			      	<tr>
		 	     			      	    <td align="center" style="background-color: #F4FCFF">
									   	   	<table style="width: 300px;height: 250px;" class="contenttable" class="scrollBarsHV">
									   	   	<tr>
											 	<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >News</td>
											   </tr>
									   	   	<tr>
									   	   		<td style="width: 300px;height: 250px;" valign="top">
										   	      <iframe frameborder="0" width="310" height="250" marginwidth="0" marginheight="0"									
										            src="http://www.google.com/uds/modules/elements/newsshow/iframe.html?q=BCCI%20cricket&topic=s,h&rsz=small&format=300x250">									
													</iframe>									
										   	    </td> 
									   	   	</tr>
									   	   	</table>
								   	   </td> 
		 	     			      	</tr>
		 	     			      </table>
		 	     			   </td>
		 	     			</tr>		 	     				
		 	     	</table>
		 	     </div>
 	    	   </td>
 	    	   <td valign="top">
	    	   	 	<table  border="1" class="contenttable" style="width: 180px;height: 282px;">					
					<tr style="height: 10px;">
				 		<td colspan="2" style="font-size: 11px;color: white;font-weight: bolder; width: 180px;" valign="top"><img src="../Image/live-scores.gif"/></td>
				    </tr>
					<tr style="height: 10px;" bgcolor="#f0f7fd">
				 		<td colspan="2" style="font-size: 12px;color: white; width: 180px;" valign="top"><img id="matchplusImage" src="../Image/Arrow.gif" style="text-decoration: none;"/><a href="javascript:hideMatcheDiv()" style="text-decoration: none;" >
				 		Show Live Matches</a></td>
				    </tr>					
					<tr>					
						<td valign="top" colspan="2">
							<div id="matchesDiv" style="display: none">
							<table border="0" style="width: 100%">							
							 <%
							 	if(crsObjTodayMatches!= null){
									if(crsObjTodayMatches.size()==0){
										message = "";%>
									<tr style="color:red;font-size: 12"><td colspan="2" valign="top"><b><%=message%></b></td></tr>
									<%}else{
									System.out.println("no of live matches "+crsObjTodayMatches.size());
									 int m = 0;
									 int mcounter = 1;
									while(crsObjTodayMatches.next()){ 
									getmatchIds.add(m,crsObjTodayMatches.getString("matches_id"));
									getmatchId = crsObjTodayMatches.getString("matches_id");
									System.out.println("getmatchId "+getmatchId);								
									if(mcounter % 2 == 0 ){%>
			                		<tr bgcolor="#f0f7fd" >
			                		<%}else{%>
			                		<tr bgcolor="#e6f1fc" >	
			                		<%}%>																	
										<td id="<%=mcounter++%>" nowrap="nowrap" colspan="2">
											<a href="javascript:getlivematchscorecard('<%=getmatchId%>')" style="text-decoration: none;" id="<%=getmatchId%>" ><%=crsObjTodayMatches.getString("team_one")%> vs <%=crsObjTodayMatches.getString("team_two")%>
										</a></td>
									</tr>										
									<%}%>
									<input type="hidden" id="hdmatchid" name="hdmatchid" value="<%=getmatchIds%>">
										<%System.out.println("sb is "+(getmatchIds));	
										System.out.println("sb is "+(getmatchIds).size());
									}
								}	%>															 	
							</table>
							</div>
						</td>
					</tr>
					
					<%if(getmatchId == null || getmatchId == "" ){
					 %>
					 <tr style="color:red;font-size: 12"><td colspan="4" valign="top"><b>No Match Scheduled For Today</b></td></tr>
		<%	}else{
				try {				
		CachedRowSet crsObjbatDetails = null;
		CachedRowSet crsObjballDetails = null;		
		Vector val = new Vector();		
		val = new Vector();
		val.add(getmatchId);
		crsObjbatDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_miniscorercard_summary_batsman",val, "ScoreDB");
		val = new Vector();
		val.add(getmatchId);
		crsObjballDetails = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_miniscorercard_summary_bowler",val, "ScoreDB");
			
			if(crsObjbatDetails != null && crsObjbatDetails.next()){
				if(crsObjbatDetails.size()==0){ %>
					
				<%}else{
		%>			<tr>
						<td valign="top">
						<div id="livescorecard" style="display:none" class="scrollBarsHV">
						</div>
						<div id="loadScoreDiv" style="width:170px;height: 210px;" class="scrollBarsHV">
							<table border="0" width="170" > 
								<tr> 
									<td width="170" valign="top">						
										<DIV style="width: 170px;height: 210px;" id="leftdiv">
											<table title="Live Score" style="width: 170px;height: 210px;" border="0" 
												class="contenttable">								
												<tr bgcolor="#BBDFF7"><td colspan="5" style="font-weight: bold;font-size: 11px;text-align: center;" ><%=sdf.format(new Date())%></td></tr>
												<tr bgcolor="#8CC8F0"><td colspan="5" style="font-weight: bold;font-size: 11px;text-align: center;"  ><%=crsObjbatDetails.getString("Team1")%> Vs. <%=crsObjbatDetails.getString("Team2")%></td></tr>
												<tr bgcolor="#e6f1fc"><td colspan="5" style="font-weight: bold;font-size: 11px;text-align: center;" >Status:<%=crsObjbatDetails.getString("result")%> </td></tr>
												<tr bgcolor="#BBDFF7">
													<td colspan="3" align="center" style="font-weight: bold;font-size: 11px;text-align: center;" ><%=crsObjbatDetails.getString("BATTING")%></td>
													<td colspan="2" align="center" style="font-weight: bold;font-size: 11px;text-align: center;"><%=crsObjbatDetails.getString("BOWLING")%></td>
												</tr>
												<tr bgcolor="#8CC8F0"><td align="center" style="font-weight: bold;text-align: left;font-size: 11px">Batsman</td>
													<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">R</td>
													<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">B</td>
													<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">4s</td>
													<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">6s</td>
												</tr>
												
												<tr bgcolor="#e6f1fc">									
													<td style="font-size: 9px;text-align: left;"><%=crsObjbatDetails.getString("striker")%> *</td>
													<td style="font-size: 9px;text-align: right;"><%=crsObjbatDetails.getString("Striker_Score")%></td>
													<td style="font-size: 9px;text-align: right;"><%=crsObjbatDetails.getString("Striker_balls")%></td>
													<td style="font-size: 9px;text-align: right;padding-right: 10px;"><%=crsObjbatDetails.getString("Striker_fours")%></td>
													<td style="font-size: 9px;text-align: right;padding-right: 10px;"><%=crsObjbatDetails.getString("Striker_six")%></td>
												</tr>	
												<tr bgcolor="#e6f1fc">
													<td style="font-size: 9px;text-align: left;"><%=crsObjbatDetails.getString("nonstriker")%> </td>
													<td style="font-size: 9px;text-align: right;"><%=crsObjbatDetails.getString("NonStriker_Score")%></td>
													<td style="font-size: 9px;text-align: right;"><%=crsObjbatDetails.getString("NonStriker_balls")%></td>
													<td style="font-size: 9px;text-align: right;padding-right: 10px;"><%=crsObjbatDetails.getString("NonStriker_fours")%></td>
													<td style="font-size: 9px;text-align: right;padding-right: 10px;"><%=crsObjbatDetails.getString("NonStriker_six")%></td>
												</tr>
												<%}
												%>
												<tr bgcolor="#8CC8F0"><td align="center" style="font-weight: bold;font-size: 9px;text-align: left;">Bowler</td>
													<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">O</td>
													<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">M</td>		
													<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">W</td>		
													<td align="center" style="font-weight: bold;font-size: 11px;text-align: center;">R</td>										
												</tr>									
											<%	if(crsObjballDetails != null && crsObjballDetails.next()){ %>
												<tr bgcolor="#e6f1fc">
													<td style="text-align: left;font-size: 9px"><%=crsObjballDetails.getString("bowlername")%> *</td>
													<td style="text-align: right;font-size: 9px"><%=crsObjballDetails.getString("overs")%></td>
													<td style="text-align: right;font-size: 9px"><%=crsObjballDetails.getString("maiden")%></td>
													<td style="text-align: right;padding-right: 10px;font-size: 9px"><%=crsObjballDetails.getString("wicket")%></td>
													<td style="text-align: right;padding-right: 10px;font-size: 9px"><%=crsObjballDetails.getString("runs")%></td>										
												</tr>
												<%}%>
											</table>
											</DIV>					
									</td>
									</tr>	
									<tr>
									<td style="width: 170px;height: 210px;">
									<div id="rightdiv" style="height: 210px;vertical-align: bottom;" >
										<table border="0" width="170" style="text-align: justify;">
										<tr bgcolor="#8CC8F0"><td ><a href="javascript:ShowliveScoreCard('<%=getmatchId%>')"  style="color: maroon;" ><%=crsObjbatDetails.getString("Team1")%> Vs. <%=crsObjbatDetails.getString("Team2")%></a></td></tr>
										<tr bgcolor="#e6f1fc"><td ><a href="javascript:getTeamLineUp('<%=getmatchId%>')" id="<%=getmatchId%>" style="color: maroon;" >Players</a></td></tr>
										<tr bgcolor="#8CC8F0"><td ><a href="javascript:ShowFullScoreCard('<%=getmatchId%>')" id="<%=getmatchId%>" style="color: maroon;" >ScoreCard</a></td></tr>
										<tr bgcolor="#e6f1fc"><td >Refreshed after every minute. </td></tr>
										</table>
									</div>
									</td>
								<%}
					} catch (Exception e) {
						System.err.println(e.toString());
					}
			%>						</tr>
												
							</table>
						</div>		
							</td>			
						</tr>
						<%}%>				
					</table> 	
 	    	   </td><!-- third column/div end -->	
 	    	</tr>
 	    </table><!-- outer main table end -->
 	  </div>
 	  <table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" >
	<tr>
  	<td></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
	</tr>
</table> 
 	  <jsp:include page="Footer.jsp"></jsp:include>	  
 	  <script>
(function() {
    var tabView = new YAHOO.widget.TabView('demo');

    YAHOO.log("The example has finished loading; as you interact with it, you'll see log messages appearing here.", "info", "example");

})();

</script>
 	  <script type="text/javascript">
(function() {
    var tabView = new YAHOO.widget.TabView();
     tabView.addTab( new YAHOO.widget.Tab({
     label: 'Recent Results',
<%	 if(tab1.equalsIgnoreCase("1")){
%>	   dataSrc: 'RecentUpcommingMatchs.jsp?getflag=R',
	   cacheData: true,
       active: true	
<%	 }else{
%>	   dataSrc: 'RecentUpcommingMatchs.jsp?getflag=R'
<%	 }
%>	 
    }));
    tabView.addTab( new YAHOO.widget.Tab({
      label: 'Match Fixtures',
<%	 if(tab1.equalsIgnoreCase("2")){
%>	   dataSrc: 'RecentUpcommingMatchs.jsp?getflag=U',
	   cacheData: true,
       active: true	
<%	 }else{
%>	   dataSrc: 'RecentUpcommingMatchs.jsp?getflag=U'
<%	 }
%>      
    }));
    
    YAHOO.log("The example has finished loading; as you interact with it, you'll see log messages appearing here.", "info", "example");

    tabView.appendTo('container');
})();
</script>
	
 	</form>
 			
 </body> 
<SCRIPT>	
var scorer = null;
	var series = null;		
	var xmlHttp=null;
	var team = null;
	var teamname = null;
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
	
	function catchEnter(e) {
			if (!e) var e = window.event;
			if (e.keyCode) code = e.keyCode;
			else if (e.which) code = e.which;
			
			if (code==13) {
				callSubmit();
			}
	}
	function gaia_setFocus() {
	  var f = null;
	  var chgpass = null;
	  
	  if (document.getElementById) { 
	    f = document.getElementById("frmScorer");
	    chgpass = document.getElementById("hdChangePassword");
	  } else if (window.frmScorer) {
	    f = window.frmScorer;
	  } 
	  
	  if(!chgpass){
		  if (f) {
		    if (f.txtUserName && (f.txtUserName.value == null || f.txtUserName.value == "")) {
		      f.txtUserName.focus();
		    } else if (f.password) {
		      f.password.focus();
		    } else if (f.imgSubmit) {
		      f.imgSubmit.focus();
		    } 
		  }
	  }
	}  
   
    function callHelp(){
       // window.open("../helpdoc/LoginFlow.pdf","HELP","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=0,left=50,width="+(window.screen.availWidth-100)+",height="+(window.screen.availHeight-120));
        document.getElementById("frmScorer").action="PdfReport.jsp?ReportId=Log01";
       document.getElementById("frmScorer").submit();
    }
	
	function forgotChk(){
	    if (frmScorer.txtUserName.value == ""){
	            alert ("Enter User Name!");
	            frmScorer.txtUserName.focus();
	            return false;
	    }
	    var userid = document.getElementById('txtUserName').value;
	    document.frmScorer.action ="/cims/jsp/Mail.jsp?userid="+userid;
		document.frmScorer.submit();
	}
	
    function reportlogin(){
        document.getElementById("txtUserName").value = "report";
        document.getElementById("password").value = "pass1";
        document.getElementById("cmbLoginType").options.selectedIndex=1;
        callSubmit();
    } 
      
      function getMatches(matchId){		
		if(document.getElementById("matchdetailsDiv"+matchId).style.display==''){
			document.getElementById("matchdetailsDiv"+matchId).style.display = 'none'
		}else{
			document.getElementById("matchdetailsDiv"+matchId).style.display = ''		
		}		
		
	} 
	
	function callSubmit(){
			try{
				document.getElementById('hdSubmit').value = "submit"
			
				if(document.getElementById('txtUserName').value == ""){
					alert(" User Name can not be left Blank !");
					frmScorer.txtUserName.focus();
				}else if(document.getElementById('password').value == ""){
					alert(" Password can not be left Blank !");
					frmScorer.password.focus();
				}else{
					document.frmScorer.submit();			
				}	
		}catch(err){
				alert("callSubmit"+err.description); 
		}
	}
	
	function writetostatus(input){
	    window.status=input
	    return true
	}
	
	function getlivematchscorecard(matchid){
		writetostatus("Please Wait ")
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{			
				var url;
		    	url="getlivematchresponse.jsp?matchid="+matchid;
		    	//document.getElementById("MatchPointsDiv").innerHTML = "";
		    	document.getElementById("livescorecard").style.display='';
		    	document.getElementById("loadScoreDiv").style.display= 'none'; 		    	
		    	//xmlHttp.onreadystatechange=stChgMatchResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;					
					document.getElementById("livescorecard").innerHTML = responseResult;
					writetostatus("Done...... ")
					displaylivescorecard();		
				}			   	
			}
		}	
	
<%--	function stChgTopBowlerResponse(){				--%>
<%--		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){--%>
<%--			var responseResult= xmlHttp.responseText;--%>
<%--			alert(responseResult)--%>
<%--			var cmbbox = responseResult.split("<br>");--%>
<%--			alert(cmbbox)			--%>
<%--			var topBowler = document.getElementById("TopBowlerDiv");--%>
<%--			var topBatsman = document.getElementById("TopBatsmanDiv");					--%>
<%--			topBowler.innerHTML = cmbbox[0];--%>
<%--			topBatsman.innerHTML = cmbbox[1];--%>
<%--			//document.getElementById("TopBowlerDiv").innerHTML = responseResult;		--%>
<%--		}--%>
<%--	}--%>
	
	function showTopBowler(seriesId,name){		
		var seasonId = "1"; //Season 2008-2009
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{			
				var url;
		    	url="TopBowler.jsp?seriesId="+seriesId+"&seasonId="+seasonId+"&name="+name;
		    	document.getElementById("TopBowlerDiv").style.display='';
		    	document.getElementById("TopBowlerInstruDiv").style.display= 'none';
<%--		    	document.getElementById("busyIconBowlerDiv").style.display='none';--%>
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
		//document.getElementById("TopPlayerInstruDiv").style.display= 'none';
	}
	
<%--	function stChgMatchResponse(){				--%>
<%--		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){--%>
<%--			var responseResult= xmlHttp.responseText;					--%>
<%--			document.getElementById("MatchPointsDiv").innerHTML = responseResult;		--%>
<%--		}--%>
<%--	}--%>
<%--		--%>
	
	function SeriesMatchPointsTally(seriesId,name){
		//MakeCursorHourglass();
		//document.getElementById("txtsetfocuslabel").focus();
		
		var seasonId = "1"; //Season 2008-2009				
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{
				var url;
		    	url="TeamRanking.jsp?seriesId="+seriesId+"&seasonId="+seasonId+"&name="+name;
		    	//document.getElementById("MatchPointsDiv").innerHTML = "";
		    	document.getElementById("MatchPointsDiv").style.display='';
		    	document.getElementById("instructionDiv").style.display= 'none';
		    	
		    	//xmlHttp.onreadystatechange=stChgMatchResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;			
					document.getElementById("MatchPointsDiv").innerHTML = responseResult;
					//document.getElementById('MatchPointsDiv').scrollIntoView(true);	
					//document.getElementById('serieslistdiv').scrollIntoView(true);
					//document.getElementById("dpAssociation"+seriesId).focus();
				}			   	
			}
	}
	
<%--	function stChgTeamMatchPtResponse(){		--%>
<%--		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){--%>
<%--			var responseResult= xmlHttp.responseText;			--%>
<%--			document.getElementById("ShowMatchPtDetailsDiv"+teamname).style.display='';--%>
<%--			document.getElementById("ShowMatchPtDetailsDiv"+teamname).innerHTML = responseResult;--%>
<%--			teamname = null;		--%>
<%--		}--%>
<%--	}--%>
	
	function ShowTeamPositionDetailDiv(teamsId,seriesId){
		
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowMatchPtDetailsDiv"+teamsId).style.display==''){
				document.getElementById("plusImage"+teamsId).src = "../Image/Arrow.gif"; 
				document.getElementById("ShowMatchPtDetailsDiv"+teamsId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="ShowMatchPointsResponse.jsp?teamsId="+teamsId+"&seriesId="+seriesId;		    	
		    	document.getElementById("plusImage"+teamsId).src = "../Image/ArrowCurve.gif"; 
		    	teamname = teamsId;							
				//xmlHttp.onreadystatechange=stChgTeamMatchPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;			
					document.getElementById("ShowMatchPtDetailsDiv"+teamname).style.display='';
					document.getElementById("ShowMatchPtDetailsDiv"+teamname).innerHTML = responseResult;
					//document.getElementById("  div name  ").scrollIntoView(true);
					teamname = null;		
				}
		   	}
		}		
	}      
	
	function WagonWheelGraph(){
		window.open()	
	}
	
<%--	function stChgMatchPtResponse(){		--%>
<%--		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){--%>
<%--			var responseResult= xmlHttp.responseText;			--%>
<%--			//document.getElementById("secondpageDiv").style.display='';				--%>
<%--			document.getElementById("secondpageDiv").innerHTML = responseResult;--%>
<%--		}--%>
<%--	}--%>
		
	function showpoints(seriesId,name){							
		var seasonId = "1"; //Season 2008-2009			
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{			
				var url;
		    	url="getAllSeriesResponse.jsp?seriesId="+seriesId+"&seasonId="+seasonId+"&name="+name;
		    	document.getElementById("secondpageDiv").style.display='';		    
		    	//xmlHttp.onreadystatechange=stChgMatchPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;			
					//document.getElementById("secondpageDiv").style.display='';				
					document.getElementById("secondpageDiv").innerHTML = responseResult;
				}
		}
	}	
	
	
<%--	function stChgTeamFrontPtResponse(){		--%>
<%--		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){--%>
<%--			var responseResult= xmlHttp.responseText;--%>
<%--			document.getElementById("ShowMatchPtDetailsDiv1"+team).style.display='';--%>
<%--			document.getElementById("ShowMatchPtDetailsDiv1"+team).innerHTML = responseResult;--%>
<%--			team = null;		--%>
<%--		}--%>
<%--	}--%>
	
	function ShowTeamPositionDetailDiv1(teamId,seriesId){
		
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null){
			alert ("Browser does not support HTTP Request");
	        return;
		}else{
			if(document.getElementById("ShowMatchPtDetailsDiv1"+teamId).style.display==''){
				document.getElementById("plusImage"+teamId).src = "../Image/star.gif"; 
				document.getElementById("ShowMatchPtDetailsDiv1"+teamId).style.display='none';
				return;
			}else{
				var url ;		    	
		    	url="ShowMatchesNestedResponse.jsp?teamId="+teamId+"&seriesId="+seriesId;		    	
		    	document.getElementById("plusImage"+teamId).src = "../Image/star-hover.gif"; 
		    	team = teamId;							
				xmlHttp.onreadystatechange=stChgTeamFrontPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					document.getElementById("ShowMatchPtDetailsDiv1"+team).style.display='';
					document.getElementById("ShowMatchPtDetailsDiv1"+team).innerHTML = responseResult;
					team = null;
				}
		   	}
		}		
	}   
		
	function CheckUserId(){	
		if(document.getElementById("txtUserName").value != ''){
			var txtUserName = document.getElementById("txtUserName").value
			window.open('ForgotPassword.jsp?txtUserName='+txtUserName,'forgotPass','top= 50,left = 50,location=no,directories=no,status=yes,menubar=no,scrollbars=no,resizable=no,width=500,height=300');			
		}else{
			alert("Please Insert User Name ");
		}
	}
	
	function ShowDesktopScoreCard(matchId){		
		window.open('ScorecardSummary.jsp?matchid='+matchId,'inningdetail','top= 50,left = 50,location=no,directories=no,status=yes,menubar=no,scrollbars=no,resizable=no,width=420,height=380');
	}
	
	function ShowQuickScoreCard(matchID){
	
	}
	
	function ShowFullScoreCard(matchid){
		//alert("Match ID is*** "+matchid)
		//var flag = "ShowRefresh";
		//window.open("FullScoreCard.jsp?matchid="+matchid,"fullscorecard");
		window.open("FullScoreCard.jsp?matchid="+matchid,"fullscorecard",'top= 10,left = 10,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=920,height=920');
	}	
	//function to get the scrolling response of advertisement on load os the login page
	function MakeCursorHourglass()
{
	document.body.style.cursor = "wait";
}

function MakeCursorNormal()
{
	document.body.style.cursor = "default";
}
	
	
</SCRIPT>
<script>    	
	closePopup('BackgroundDiv','pbar');	
 </script> 
</html>
