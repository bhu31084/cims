<!--
	Author 		 		: Archana Dongre
	Created Date 		: 03/02/2009
	Description  		: Menu for website pages.
	Company 	 		: Paramatrix Tech Pvt Ltd.	
-->

<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>

<%
	GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
	Vector 					vparam 					=  	new Vector();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	//SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	//Calendar cal = Calendar.getInstance();
	//cal.add(Calendar.DATE,0);
	//gsActDate =	new SimpleDateFormat("dd/MM/yyyy").format(cal.getTime());
	//cal.add(Calendar.DATE,8);
	String SeasonId = null;
	
	String currentYear = sdf.format(new Date()).substring(0,4);
	System.out.println("current year is ***** "+currentYear);	
	CachedRowSet  crsObjSeason = null;
	vparam.add("2");//
	crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_season",vparam,"ScoreDB");
	vparam.removeAllElements();	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<title>CIMS 2009</title>
<link href="../css/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<link href="../css/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
<link href="../css/Main.css" rel="stylesheet" type="text/css" />
<link href="../css/commonSpry.css" rel="stylesheet" type="text/css" />
<script src="../js/SpryMenuBar.js" type="text/javascript"></script>
<script>	
</script>
<script type="text/javascript">
<!--	
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
	
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
   
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function getSeason(){
	//alert(document.getElementById("dpseason").value);
}

function clearText(){
	document.getElementById("txtUserName").value = '';
}

function clearpassword(){
	document.getElementById("password").value = '';
}

function validateusername(){	
	/*if(document.getElementById("txtUserName").value == '' ){
		alert("User name Should not be empty")
		document.getElementById("txtUserName").focus();
		return false;
	}else{*/
	xmlHttp=GetXmlHttpObject();
		var username = document.getElementById("txtUserName").value;
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{
				var url;
		    	url="validatelogin.jsp?username="+username;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;					
					document.getElementById("userdata").innerHTML = responseResult;
					if(document.getElementById("txtname").value == "" || document.getElementById("txtname").value == null){
						alert("Invalid user")
						document.getElementById("txtUserName").focus();
						return false;
					}
				}			   	
			}
		//}	
	}


	function validatepassword(){
		/*if(document.getElementById("password").value == ''){
			alert("User name Should not be empty")
			document.getElementById("password").focus();
				return false;
		}else{*/
			if(document.getElementById("password").value != document.getElementById("txtpass").value){
				alert("Invalid password")
				document.getElementById("password").focus();
				return false;
			}else{			
				if(document.getElementById("txtrole").value == "3"){			
					document.getElementById("cmbLoginType").options.selectedIndex = 0;
				}else if(document.getElementById("txtrole").value == "9"){
					document.getElementById("cmbLoginType").options.selectedIndex = 2;
				}else{
					document.getElementById("cmbLoginType").options.selectedIndex = 1;
				}
			}	
		//}
	}
	function getseasonfrmheader(){				
		//alert(document.getElementById("dpseasonList").value)
		var seasonid = document.getElementById("dpseasonList").value
		//document.getElementById("hdseason").value = document.getElementById("dpseasonList").value;
		//alert(document.getElementById("hdseason").value)
		xmlHttp=GetXmlHttpObject();
		//var username = document.getElementById("txtUserName").value;
		if(xmlHttp==null){
			alert ("Browser does not support HTTP Request");
			return;
		}else{
				var url;
		    	url="setSeasonInSession.jsp?seasonid="+seasonid;
				xmlHttp.open("post",url,false);
			   	xmlHttp.send(null);
			   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
					var responseResult= xmlHttp.responseText;
					//alert(responseResult)
					window.location.reload();
					document.getElementById("dpseasonList").value.selected = responseResult;
					document.getElementById("hdseason").innerHTML = responseResult;					
					//window.location.reload();
					//location.reload();
					//window.location.reload();
				}
		}
	}
	
//-->
</script>
</head>
<body bottommargin="0" leftmargin="0" topmargin="0" >
<%--<form id="frmHeader" name="frmHeader" method="get">--%>
<%--<div id="HeaderDiv">--%>
<table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
  <tr>
    <td width="1003">
    <table width="1003" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="2"><table width="1003" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <div id="userdata" style="display: none;"></div>
            <td><img src="../Image/LogoTop.jpg" width="249" height="37" /></td>
            <td width="78" height="37"><img src="../Image/Login.jpg" width="78" height="37" /></td>
            <td width="120" background="../Image/LoginPanelBG.jpg"><input name="txtUserName" type="text" class="inputField" id="txtUserName" value="username" onfocus="clearText()" onclick="clearText()" /></td>
            <td width="120" background="../Image/LoginPanelBG.jpg"><input name="password" type="password" class="inputField" id="password" value="password" onclick="clearpassword()" onfocus="clearpassword()" /></td>
            <td width="120" background="../Image/LoginPanelBG.jpg">
            	<select name="cmbLoginType" id="cmbLoginType" class="inputField"  onfocus="validateusername();validatepassword()">
					<option  value="/cims/jsp/TeamSelection.jsp" >Scorer Login</option>
					<option  value="/cims/jsp/SelectMatch.jsp" >Report Login</option>						
					<option  value="/cims/jsp/admin/Menu.jsp" >Admin Login</option>					
				</select>            	
            </td>
            <td width="42" height="37">
            <img src="../Image/LoginPanelGO.jpg" width="42" height="37" id="imgSubmit" name="imgSubmit" onclick="callSubmit()" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="599" height="115"><img src="../Image/LoginLogo.jpg" width="599" height="115" /></td>
            <td width="180" height="115"><img src="../Image/Top2.jpg" width="174" height="115" /></td>
            <td width="390" height="115"><img src="../Image/Top3.jpg" width="230" height="115" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td width="249" height="29"><img src="../Image/LogoBottom.jpg" width="249" height="29" /></td>
        <td align="right"><table width="500" border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
           
<%--            <td background="../Image/MenuBG.jpg" width="20" height="29" style="color: white;"></td>--%>	
			<td width="56" height="29"><img src="../Image/Season.jpg" alt="Season" name="Season" width="56" height="29" border="0" id="Season" /></td>            
            <td width="47" height="29" style="background-color: black;">
    			<select id="dpseasonList" name="dpseasonList" onchange="getseasonfrmheader();">
				<option value="0"> select</option>
					<% 
				while (crsObjSeason.next()) {	 
					SeasonId = session.getAttribute("season")==null?crsObjSeason.getString("id"):session.getAttribute("season").toString();
				  if(crsObjSeason.getString("id").equalsIgnoreCase(SeasonId)){%>
						<option value="<%=crsObjSeason.getString("id")%>" style="font-size: 12px;" selected="selected"><%=crsObjSeason.getString("name")%></option>
					<%}else{%>
						<option value="<%=crsObjSeason.getString("id")%>" style="font-size: 12px;" ><%=crsObjSeason.getString("name")%></option>
					<%}
		             	}  
					session.setAttribute("season", SeasonId);	
			      %>
				</select>
			</td>			
            <td width="47" height="29"><a href="login.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Home','','../Image/HomeH.jpg',1)" ><img src="../Image/Home.jpg" alt="Home" name="Home" width="47" height="29" border="0" id="Home" /></a></td>            
            <td width="74" height="29"><a href="AboutBcci.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('About','','../Image/AboutH.jpg',1)"><img src="../Image/About.jpg" alt="About" name="About" width="74" height="29" border="0" id="About" /></a></td>
            <td width="65" height="29"><a href="YearlySchedule.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Schedule','','../Image/ScheduleH.jpg',1)"><img src="../Image/Schedule.jpg" alt="Schedule" name="Schedule" width="65" height="29" border="0" id="Schedule" /></a></td>
            <td width="45" height="29"><a href="playersStatus.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Stats','','../Image/StatsH.jpg',1)"><img src="../Image/Stats.jpg" alt="Stats" name="Stats" width="45" height="29" border="0" id="Stats" /></a></td>
            <td width="56" height="29"><a href="resultsofwholeyear.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Results','','../Image/ResultsH.jpg',1)"><img src="../Image/Results.jpg" alt="Results" name="Results" width="56" height="29" border="0" id="Results" /></a></td>
            <td width="85" height="29"><a href="FutureSeriesDetails.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Future Series','','../Image/FutureSeriesH.jpg',0)"><img src="../Image/FutureSeries.jpg" alt="Future Series" name="Future Series" width="85" height="29" border="0" id="Future Series" /></a></td>
<%--        <td width="50" height="29"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Teams','','../Image/TeamsH.jpg',1)"><img src="../Image/Teams.jpg" alt="Teams" name="Teams" width="50" height="29" border="0" id="Teams" /></a></td>--%>
            <!-- <td width="99" height="29" ><a href="SeriesMatchDetailsByOfficials.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Scorer','','../Image/ScorerH.jpg',0)"><img src="../Image/Scorer.jpg" alt="Scorer" name="Scorer " width="53" height="29" border="0" id="Scorer" /></a></td>-->
            <!-- <td width="83" height="29" ><a href="PhotoGallary.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('gallery','','../Image/GalleryH.jpg',0)"><img src="../Image/Gallery.jpg" alt="gallery" name="gallery " width="83" height="29" border="0" id="gallery" /></a></td>-->
<%--        	<td width="104" height="29" style="color: white;background-color: black;"><a href="mobile.jsp">CIMS Mobile</a></td>--%>
            <td width="105" height="29"><a href="mobile.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Mobile','','../Image/MobileH.jpg',1)"><img src="../Image/Mobilemenu.jpg" alt="Mobile" name="Mobile" width="105" height="29" border="0" id="Mobile" /></a></td>
          </tr>
        </table>
        <input type="hidden" name="hdSubmit" id="hdSubmit" value="">    
    </td>                                                            
  </tr>
</table>
<%--</div>--%>
<%--</form>--%>
</body>
</html>
