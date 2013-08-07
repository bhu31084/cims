<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>

<%
	GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
	Vector 					vparam 					=  	new Vector();
	String flag = "2"; //For the  list sp execution.
	String SeriesDescription = "";
	CachedRowSet  			crsObjGetSeriesdata			=	null;
	vparam.add(flag); 	
	crsObjGetSeriesdata = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_series_list",vparam,"ScoreDB");
	vparam.removeAllElements();
	
	//String seriesId = "";
	//String seasonId = "";	
	//String seriesName = "";
	//seriesId = request.getParameter("seriesId")==null?"":request.getParameter("seriesId");
	//seasonId = request.getParameter("seasonId")==null?"":request.getParameter("seasonId");
	//seriesName = request.getParameter("name")==null?"":request.getParameter("name");
	//topPerformerflag = request.getParameter("topPerformerflag")==null?"":request.getParameter("topPerformerflag");		
%>	



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Spry Tabbed Panels</title>
<link href="../css/SpryTabbedPanels.css" rel="stylesheet" type="text/css"/>
<link href="../css/commonSpry.css" rel="stylesheet" type="text/css" />
<link href="../css/Main.css" rel="stylesheet" type="text/css" />
<%--<link href="../css/samples.css" rel="stylesheet" type="text/css" />--%>
<script language="JavaScript" type="text/javascript" src="../js/SpryTabbedPanels.js"></script>
<script>
	
	/*var scorer = null;
	var series = null;		
	var xmlHttp=null;
	var team = null;
	function GetXmlHttpObject() {
		try{
			//Firefox, Opera 8.0+, Safari
			xmlHttp=new XMLHttpRequest();
		}catch (e){
			// Internet Explorer
			try{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}catch (e){
				xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}
	
	function stChgMatchPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("secondpageDiv").style.display='';				
			document.getElementById("secondpageDiv").innerHTML = responseResult;
		}
	}
		
	function showpoints(seriesId,name){					
		//alert(seriesId)		
		//alert(name)
		var seasonId = "1"; //Season 2008-2009		
			
		xmlHttp=GetXmlHttpObject();
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{			
				var url;
		    	url="getAllSeriesResponse.jsp?seriesId="+seriesId+"&seasonId="+seasonId+"&name="+name;
		    	document.getElementById("secondpageDiv").style.display='';		    
		    	xmlHttp.onreadystatechange=stChgMatchPtResponse;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
		}
	}	
	
	
	function stChgTeamFrontPtResponse(){		
		if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
			var responseResult= xmlHttp.responseText;
			document.getElementById("ShowMatchPtDetailsDiv1"+team).style.display='';
			document.getElementById("ShowMatchPtDetailsDiv1"+team).innerHTML = responseResult;
			team = null;		
		}
	}
	
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
		   	}
		}		
	} */
	
</script>
</head>
<div id="TabbedPanels2" class="VTabbedPanels" align="left" >
  <ul class="TabbedPanelsTabGroup" style="font-size: 11px;">   
    <%if(crsObjGetSeriesdata != null){%>
    <%	while(crsObjGetSeriesdata.next()){
	SeriesDescription = crsObjGetSeriesdata.getString("description"); %>
	<li class="TabbedPanelsTab" id="seriestab"><a style="color: brown;" href="javascript:showpoints('<%=crsObjGetSeriesdata.getString("type")%>','<%=SeriesDescription%>')"><%=SeriesDescription%></a> </li>

<%	}
}%>    
  </ul>  
  <div class="TabbedPanelsContentGroup">
    <div class="TabbedPanelsContent" id="secondpageDiv" >
    	
    </div>
  </div>
</div>

<script language="JavaScript" type="text/javascript">
var TabbedPanels2 = new Spry.Widget.TabbedPanels("TabbedPanels2",{defaultTab: 2 });
</script>

</html>
