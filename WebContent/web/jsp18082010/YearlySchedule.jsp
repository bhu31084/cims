<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ include file="loginvalidate.jsp" %>
<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");			
	Common common = new Common();
	String currentYear = sdf.format(new Date()).substring(0,4);
	String currentmonth = sdf.format(new Date()).substring(5,7);
	String monthFlag = "1";
	System.out.println("current year is ***** "+currentYear);	
	System.out.println("current year is ***** "+currentmonth);	
	//String message = "";

	String tab=null;
	
	//tab = request.getParameter("tab")==null?"4":request.getParameter("tab");
	String getcurrentYear = request.getParameter("txtyear")==null?currentYear:request.getParameter("txtyear");
	System.out.println("current year is ***** "+getcurrentYear);
	if(currentYear.equalsIgnoreCase(getcurrentYear)){
		currentYear = currentYear;
	}else{
		currentYear = getcurrentYear;
	}	
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

<link rel="stylesheet" type="text/css" href="../css/fonts-min.css"/>
<link rel="stylesheet" type="text/css" href="../css/tabview.css" />
<%--<link href="../css/commonSpry.css" rel="stylesheet" type="text/css" />--%>
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
<script language="JavaScript" src="../js/popup.js"></script>
<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script> 
<style type="text/css">
.yui-navset div.loading div {
    background:url(../../images/loading.gif) no-repeat center center;
    height:8em; /* hold some space while loading */
}

/*#example-canvas h2 {padding: 0 0 0 0;}*/
</style>
<script>	
	function previousYearData(){				
		var year = document.getElementById("txtyear").value
		var Year = year  - 1;
		document.getElementById("txtyear").value = Year;	
		document.frmyearschedule.submit();		
	}
	
	function NextYearData(){		
		var year = document.getElementById("txtyear").value
		year++;
		document.getElementById("txtyear").value = year ;
		document.frmyearschedule.submit();		
	}
	
	function callSubmit(){			
			try{
				document.getElementById('hdSubmit').value = "submit"			
				if(document.getElementById('txtUserName').value == ""){
					alert(" User Name can not be left Blank !");
					frmyearschedule.txtUserName.focus();
				}else if(document.getElementById('password').value == ""){
					alert(" Password can not be left Blank !");
					frmyearschedule.password.focus();
				}else{
					document.frmyearschedule.submit();			
				}	
		}catch(err){
				alert("callSubmit"+err.description); 
		}
	}	
</script>
</head>
<body class=" yui-skin-sam" bottommargin="0" leftmargin="0" topmargin="0">
<form id="frmyearschedule" name="frmyearschedule" method="get" action="YearlySchedule.jsp">
<jsp:include page="Header.jsp"></jsp:include>
<div id = "pbar" name="pbar" class="divlist" style="left: 450px;top: 300px;" align="center">
<table style="background: transparent;">			
	<tr>
<%--		<td align="center" valign="middle" ><b><img src="../Image/loading.gif" /></b></td>--%>
<td align="center" valign="middle"><img src="../Image/wait24trans.gif" />&nbsp;<font color="red" size="3"><b> Loading ......</b></font></td>
	</tr>
</table>
</div>
<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv" >
</div>
<script>showPopup('BackgroundDiv','pbar')</script>
<div id="outerDiv" style="width: 1003px;height: 1000px;overflow: auto;">
	<table style="width: 1003px;">
		<tr>
			<td valign="top">
 	    	   	 <td valign="top"><%@ include file="commiteeinfo.jsp" %> 	    	   	 
 	    	   </td>
 	    	   </td>
			<td width="700" border="0" valign="top" >
				<div id="FutureSeriesDiv" style="width: 700px;">			   	
			   	<table width="700" border="0" class="contenttable">
			   	<tr>
					<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Schedule</td>
				</tr>
				<tr>
				  	<td align="left">
			    		<input type="button" class="FlatButton" onclick="previousYearData()" value="Previous">&nbsp;&nbsp;&nbsp;
<%--				    </td>--%>
<%--				    <td align="center">--%>
			    		<input align="middle"" type="text" size="4" maxlength="4" id="txtyear" name="txtyear" value="<%=currentYear%>">
<%--				    </td>--%>
<%--				    <td align="right">--%>
			    		&nbsp;&nbsp;&nbsp;<input type="button" class="FlatButton" onclick="NextYearData()" value="Next"> 
			    		<input type="hidden" id="txtcurryear" name="txtcurryear" value="<%=currentYear%>">
				    	<input type="hidden" id="txtcurrMonth" name="txtcurrMonth" value="<%=currentmonth%>">
				    </td>
				</tr>			   			    
			</table>    
		</div>
				<div id="container" style="width: 700px;height: 800px;">					
				</div>
			</td>
			<td width="100" border="0" valign="top"></td>
		</tr>
	</table>
</div>
<table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" >
	<tr>
  		<td>						          				
		</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	</tr>
</table>
<jsp:include page="Footer.jsp"></jsp:include>
<script type="text/javascript">
(function() {
    var tabView = new YAHOO.widget.TabView();
     tabView.addTab( new YAHOO.widget.Tab({
     label: 'Jan',
<%	 if(currentmonth.equalsIgnoreCase("1")){
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=01&currentYear=<%=currentYear%>&monthFlag=<%=monthFlag%>',
	   cacheData: true,
       active: true	
<%	 }else{
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=01&currentYear=<%=currentYear%>&monthFlag=<%=monthFlag%>'
<%	 }
%>	 
    }));
    tabView.addTab( new YAHOO.widget.Tab({
      label: 'Feb',
<%	 if(currentmonth.equalsIgnoreCase("2")){
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=02&currentYear=<%=currentYear%>&monthFlag=<%=monthFlag%>',
	   cacheData: true,
       active: true	
<%	 }else{
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=02&currentYear=<%=currentYear%>&monthFlag=<%=monthFlag%>'
<%	 }
%>      
    }));

    tabView.addTab( new YAHOO.widget.Tab({
      label: 'Mar',
<%	 if(currentmonth.equalsIgnoreCase("03")){
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=03&currentYear=<%=currentYear%>&monthFlag=1',
	   cacheData: true,
       active: true	
<%	 }else{
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=03&currentYear=<%=currentYear%>&monthFlag=1'
<%	 }
%>  
     }));

    tabView.addTab( new YAHOO.widget.Tab({
	   label: 'Apr',
<%	 if(currentmonth.equalsIgnoreCase("04")){
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=04&currentYear=<%=currentYear%>&monthFlag=1',
	   cacheData: true,
       active: true
<%	 }else{
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=04&currentYear=<%=currentYear%>&monthFlag=1'
<%	 }
%>        
    }));

    tabView.addTab( new YAHOO.widget.Tab({
        label: 'May',
<%	 if(currentmonth.equalsIgnoreCase("05")){
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=05&currentYear=<%=currentYear%>&monthFlag=1',
	   cacheData: true,
       active: true
<%	 }else{
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=05&currentYear=<%=currentYear%>&monthFlag=1'
<%	 }
%>          
    }));      

     tabView.addTab( new YAHOO.widget.Tab({
		label: 'June',
<%	 if(currentmonth.equalsIgnoreCase("06")){
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=06&currentYear=<%=currentYear%>&monthFlag=1',
	   cacheData: true,
       active: true	
<%	 }else{
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=06&currentYear=<%=currentYear%>&monthFlag=1'
<%	 }
%>        

    }));
	  tabView.addTab( new YAHOO.widget.Tab({
		label: 'July',
<%	 if(currentmonth.equalsIgnoreCase("07")){
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=07&currentYear=<%=currentYear%>&monthFlag=1',
	   cacheData: true,
       active: true	
<%	 }else{
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=07&currentYear=<%=currentYear%>&monthFlag=1'
<%	 }
%>  		
    }));
     tabView.addTab( new YAHOO.widget.Tab({
		label: 'Aug',
<%	 if(currentmonth.equalsIgnoreCase("08")){
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=08&currentYear=<%=currentYear%>&monthFlag=1',
	   cacheData: true,
       active: true
<%	 }else{
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=08&currentYear=<%=currentYear%>&monthFlag=1'
<%	 }
%>  
    }));    
   tabView.addTab( new YAHOO.widget.Tab({
	   label: 'Sep',
<%	 if(currentmonth.equalsIgnoreCase("09")){
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=09&currentYear=<%=currentYear%>&monthFlag=1',
	   cacheData: true,
       active: true	
<%	 }else{
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=09&currentYear=<%=currentYear%>&monthFlag=1'
<%	 }
%>        
    })); 
       tabView.addTab( new YAHOO.widget.Tab({       
		label: 'Oct',
<%	 if(currentmonth.equalsIgnoreCase("10")){
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=10&currentYear=<%=currentYear%>&monthFlag=1',
	   cacheData: true,
       active: true	
<%	 }else{
%>	   dataSrc: 'getMonthWiseResponse.jsp?month=10&currentYear=<%=currentYear%>&monthFlag=1'
<%	 }
%>        
    }));
    	tabView.addTab( new YAHOO.widget.Tab({       
		 label: 'Nov',
<%	 	if(currentmonth.equalsIgnoreCase("11")){
%>	  	 dataSrc: 'getMonthWiseResponse.jsp?month=11&currentYear=<%=currentYear%>&monthFlag=1',
		 cacheData: true,
       	active: true
<%	 	}else{
%>	  	  dataSrc: 'getMonthWiseResponse.jsp?month=11&currentYear=<%=currentYear%>&monthFlag=1'
<%	 }
%>         
    }));
    tabView.addTab( new YAHOO.widget.Tab({       
		label: 'Dec',
<%	 	if(currentmonth.equalsIgnoreCase("12")){
%>	  	 dataSrc: 'getMonthWiseResponse.jsp?month=12&currentYear=<%=currentYear%>&monthFlag=1',
		 cacheData: true,
       	active: true
<%	 	}else{
%>	  	  dataSrc: 'getMonthWiseResponse.jsp?month=12&currentYear=<%=currentYear%>&monthFlag=1'
<%	 }
%>      
    }));
    
    YAHOO.log("The example has finished loading; as you interact with it, you'll see log messages appearing here.", "info", "example");

    tabView.appendTo('container');
})();
</script>

<!--END SOURCE CODE FOR EXAMPLE =============================== -->
</form>
<script>    	
	closePopup('BackgroundDiv','pbar');	
 </script>	
</body>
</html>
