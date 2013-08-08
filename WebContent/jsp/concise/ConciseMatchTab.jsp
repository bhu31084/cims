<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%
	String tab=null;
	//session.setAttribute("matchId1","718");
	tab = request.getParameter("tab")==null?"1":request.getParameter("tab");
	String inning = request.getParameter("inning")==null?"0":request.getParameter("inning");
	String HidId = request.getParameter("HidId")==null?"0":request.getParameter("HidId");
	String selBatsmen =  request.getParameter("selBatsmen")==null?"0":request.getParameter("selBatsmen");
	String selbowler =  request.getParameter("selBowler")==null?"0":request.getParameter("selBowler");
	String selWicket =  request.getParameter("selWicket")==null?"0":request.getParameter("selWicket");
	String Runs =  request.getParameter("Runs")==null?"0":request.getParameter("Runs");
	String Overs =  request.getParameter("txtOvers")==null?"0":request.getParameter("txtOvers");
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Getting Content from an External Source</title>
<script>
	
</script>
<style type="text/css">
body {
	margin:0;
	padding:0;
}
</style>

<link rel="stylesheet" type="text/css" href="../../css/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="../../css/tabview.css" />
<link href="../../css/concise.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../js/yahoo-dom-event.js"></script>
<script type="text/javascript" src="../../js/connection-min.js"></script>
<script type="text/javascript" src="../../js/element-beta-min.js"></script>
<script type="text/javascript" src="../../js/tabview-min.js"></script>
<script type="text/javascript" src="../../js/common.js"></script>
<script type="text/javascript" src="../../js/concise.js"></script>
<script language="JavaScript" src="../../js/jsKeyRestrictvalidation.js"></script>
<script language="JavaScript" src="../../js/datetimepicker.js" type="text/javascript"></script>
<!--begin custom header content for this example-->
<style type="text/css">
.yui-navset div.loading div {
    background:url(../../images/loading.gif) no-repeat center center;
    height:8em; /* hold some space while loading */
}

#example-canvas h2 {padding: 0 0 .5em 0;}
</style>

<!--end custom header content for this example-->
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
</head>

<body class=" yui-skin-sam">
<!--BEGIN SOURCE CODE FOR EXAMPLE =============================== -->

<form id="concise" name="concise" method="post">
<div style="width: 80em">
<table width="80em" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
	<tr>
      <td width="680" height="108"><img src="../../images/ConciseLoginLogo.jpg" width="680" height="108" /></td>
      <td width="220" height="108"><img src="../../images/ConciseTop2.jpg" width="220" height="108" /></td>
      <td width="230" height="108"><img src="../../images/ConciseTop3.jpg" width="230" height="108" /></td>
    </tr>
</table>    
</div>
<br>
<div id="container" style="width: 85em"></div>
<div style="width: 80em">
<table width="80em" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
 <tr>
    <td><img src="../../images/SiteFooter1.jpg" width="270" height="90" /></td>
    <td><img src="../../images/SiteFooter2.jpg" width="280" height="90" /></td>
    <td><img src="../../images/SiteFooter3.jpg" width="276" height="90" /></td>
    <td><a href="http://www.paramatrix.co.in"><img src="../../images/SiteFooter4.jpg"  width="310" height="90" border="0" /></a></td>
 </tr>
</table>
</div>
<script type="text/javascript">
(function() {
    var tabView = new YAHOO.widget.TabView();
     tabView.addTab( new YAHOO.widget.Tab({
<%	if(tab.equalsIgnoreCase("1")){
%>      label: 'Create Innings',
<%		if(HidId.equalsIgnoreCase("4")){	
%>      	dataSrc: '/cims/jsp/concise/concisecreateinning.jsp?query=ConcisecreateInning&inning=<%=inning%>&HidId=4',
<%		}else{
%>  		dataSrc: '/cims/jsp/concise/concisecreateinning.jsp?query=ConcisecreateInning',
<%		}
%>      cacheData: true,
        active: true
<%	}else{
%>      label: 'Create Innings',
        dataSrc: '/cims/jsp/concise/concisecreateinning.jsp?query=ConcisecreateInning'
<%	}
%>   
    }));
    tabView.addTab( new YAHOO.widget.Tab({
<%	if(tab.equalsIgnoreCase("2")){
%>      label: 'Innings Details',
<%		if(HidId.equalsIgnoreCase("4")){	
%>      dataSrc: 'ConciseInningDetails.jsp?query=ConciseInningDetails&selinning=<%=inning%>&HidId=4',
<%		}else{
%>  	dataSrc:  '/cims/jsp/concise/ConciseInningDetails.jsp?query=ConciseInningDetails',
<%		}
%>      cacheData: true,
        active: true
<%	}else{
%>      label:  'Innings Details',
        dataSrc:  '/cims/jsp/concise/ConciseInningDetails.jsp?query=ConciseInningDetails'
<%	}
%>         
    }));

    tabView.addTab( new YAHOO.widget.Tab({
<%	if(tab.equalsIgnoreCase("3")){
%>      label: 'Batting Details',
<%		if(HidId.equalsIgnoreCase("4")){	
%>      dataSrc: '/cims/jsp/concise/ConciseBatting.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=4&selBatsmen=<%=selBatsmen%>',
<%		}else if(HidId.equalsIgnoreCase("5")){	
%> 		 dataSrc: '/cims/jsp/concise/ConciseBatting.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=5',	
<%		}else{
%>  	dataSrc:  '/cims/jsp/concise/ConciseBatting.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=<%=HidId%>',
<%		}
%>      cacheData: true,
        active: true
<%	}else{
%>      label:  'Batting Details',
        dataSrc:  '/cims/jsp/concise/ConciseBatting.jsp?query=ConciseBatting'
<%	}
%>       
     }));

    tabView.addTab( new YAHOO.widget.Tab({
<%	if(tab.equalsIgnoreCase("4")){
%>      label: 'Bowling Details',
<%		if(HidId.equalsIgnoreCase("4")){	
%>      dataSrc: '/cims/jsp/concise/ConciseBowling.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=4&selBowler=<%=selbowler%>',
<%		}else if(HidId.equalsIgnoreCase("5")){	
%> 		 dataSrc: '/cims/jsp/concise/ConciseBowling.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=5',	
<%		}else{
%>  	dataSrc:  '/cims/jsp/concise/ConciseBowling.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=<%=HidId%>',
<%		}
%>      cacheData: true,
        active: true
<%	}else{
%>      label:  'Bowling Details',
        dataSrc:  '/cims/jsp/concise/ConciseBowling.jsp?query=ConciseBatting'
<%	}
%>    
    }));

    tabView.addTab( new YAHOO.widget.Tab({
<%	if(tab.equalsIgnoreCase("5")){
%>      label: 'Partnership Details',
<%		if(HidId.equalsIgnoreCase("4")){	
%>      dataSrc: '/cims/jsp/concise/ConcisePartnership.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=4&selwicket=<%=selWicket%>',
<%		}else if(HidId.equalsIgnoreCase("5")){	
%> 		 dataSrc: '/cims/jsp/concise/ConcisePartnership.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=5',	
<%		}else{
%>  	dataSrc:  '/cims/jsp/concise/ConcisePartnership.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=<%=HidId%>',
<%		}
%>      cacheData: true,
        active: true
<%	}else{
%>      label:  'Partnership Details',
        dataSrc:  '/cims/jsp/concise/ConcisePartnership.jsp?query=ConciseBatting'
<%	}
%>    
    }));      

     tabView.addTab( new YAHOO.widget.Tab({
<%	if(tab.equalsIgnoreCase("6")){
%>      label: 'Fall Of Wickets',
<%		if(HidId.equalsIgnoreCase("4")){	
%>      	dataSrc: '/cims/jsp/concise/ConciseFallOfWicket.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=4&selWicket=<%=selWicket%>',
<%		}else if(HidId.equalsIgnoreCase("5")){	
%> 		 	dataSrc: '/cims/jsp/concise/ConciseFallOfWicket.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=5',	
<%		}else{
%>  		dataSrc:  '/cims/jsp/concise/ConciseFallOfWicket.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=<%=HidId%>',
<%		}
%>      cacheData: true,
        active: true
<%	}else{
%>      label:  'Fall Of Wickets',
        dataSrc:  '/cims/jsp/concise/ConciseFallOfWicket.jsp?query=ConciseBatting'
<%	}
%>       
    }));
	  tabView.addTab( new YAHOO.widget.Tab({
<%	if(tab.equalsIgnoreCase("7")){
%>      label: 'Scoring Rate',
<%		if(HidId.equalsIgnoreCase("4")){	
%>      dataSrc: '/cims/jsp/concise/ConciseScoringRate.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=4&Runs=<%=Runs%>',
<%		}else if(HidId.equalsIgnoreCase("5")){	
%> 		 dataSrc: '/cims/jsp/concise/ConciseScoringRate.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=5',	
<%		}else{
%>  	dataSrc:  '/cims/jsp/concise/ConciseScoringRate.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=<%=HidId%>',
<%		}
%>      cacheData: true,
        active: true
<%	}else{
%>      label:  'Scoring Rate',
        dataSrc:  '/cims/jsp/concise/ConciseScoringRate.jsp?query=ConciseBatting'
<%	}
%>       
    }));
     tabView.addTab( new YAHOO.widget.Tab({
<%	if(tab.equalsIgnoreCase("8")){
%>      label: 'Indivisual Runs',
<%		if(HidId.equalsIgnoreCase("4")){	
%>      dataSrc: '/cims/jsp/concise/conciseindividualsscoring.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=4&Runs=<%=Runs%>&selBatsman=<%=selBatsmen%>',
<%		}else if(HidId.equalsIgnoreCase("5")){	
%> 		 dataSrc: '/cims/jsp/concise/conciseindividualsscoring.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=5',	
<%		}else{
%>  	dataSrc:  '/cims/jsp/concise/conciseindividualsscoring.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=<%=HidId%>',
<%		}
%>      cacheData: true,
        active: true
<%	}else{
%>      label:  'Indivisual Runs',
        dataSrc:  '/cims/jsp/concise/conciseindividualsscoring.jsp?query=ConciseBatting'
<%	}
%>       
    }));    
   tabView.addTab( new YAHOO.widget.Tab({
<%	if(tab.equalsIgnoreCase("9")){
%>      label: 'Run Rate',
<%		if(HidId.equalsIgnoreCase("4")){	
%>      dataSrc: '/cims/jsp/concise/ConciseRunRate.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=4&txtOvers=<%=Overs%>',
<%		}else if(HidId.equalsIgnoreCase("5")){	
%> 		 dataSrc: '/cims/jsp/concise/ConciseRunRate.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=5',	
<%		}else{
%>  	dataSrc:  '/cims/jsp/concise/ConciseRunRate.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=<%=HidId%>',
<%		}
%>      cacheData: true,
        active: true
<%	}else{
%>      label:  'Run Rate',
        dataSrc:  '/cims/jsp/concise/ConciseRunRate.jsp?query=ConciseBatting'
<%	}
%>       
    })); 
       tabView.addTab( new YAHOO.widget.Tab({       
<%	if(tab.equalsIgnoreCase("10")){
%>      label: 'New Ball',
<%		if(HidId.equalsIgnoreCase("4")){	
%>      dataSrc: '/cims/jsp/concise/ConciseNewBall.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=4&txtOvers=<%=Overs%>',
<%		}else if(HidId.equalsIgnoreCase("5")){	
%> 		 dataSrc: '/cims/jsp/concise/ConciseNewBall.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=5',	
<%		}else{
%>  	dataSrc:  '/cims/jsp/concise/ConciseNewBall.jsp?query=ConciseBatting&selinning=<%=inning%>&HidId=<%=HidId%>',
<%		}
%>      cacheData: true,
        active: true
<%	}else{
%>      label:  'New Ball',
        dataSrc:  '/cims/jsp/concise/ConciseNewBall.jsp?query=ConciseBatting'
<%	}
%>       
    }));
    YAHOO.log("The example has finished loading; as you interact with it, you'll see log messages appearing here.", "info", "example");

    tabView.appendTo('container');
})();
</script>

<!--END SOURCE CODE FOR EXAMPLE =============================== -->
</form>
</body>
</html>
