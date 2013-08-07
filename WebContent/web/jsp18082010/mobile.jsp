<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.sms.SmsSender"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,java.io.*,java.lang.*"%>
<%@ include file="loginvalidate.jsp" %>
<%   
	response.setHeader("Pragma", "private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>

<html>
	<head><!--noreplace nostamp-->
		<title>SEND SMS</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="description" content="Follow cricket on your mobile through WAP and Mobicast on Cricinfo Mobile">
		<meta name="keywords" content="Cricket Mobile, Live cricket scores on Mobile, Cricket WAP, Cricket Mobicast">
		<link type="text/css" rel="stylesheet" href="../css/cricinfomobile.css">
		<link type="text/css" rel="stylesheet" href="../css/commonSpry.css">
		<script type="text/javascript" src="../js/default.js"></script>
		<script type="text/javascript" src="../js/cricinfomobile.js"></script>
		<script type="text/javascript" src="../js/mobile.js"></script>
		<script language="JavaScript" src="../js/popup.js"></script>
		<script type="text/javascript" src="../js/common.js"></script>
		<script language="JavaScript" src="../js/otherFeedback.js"></script>
		<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>
		<style type="text/css">
		
		</style>
		<script language="JavaScript">
			function callSubmit(){		
				try{
					document.getElementById('hdSubmit').value = "submit"			
					if(document.getElementById('txtUserName').value == ""){
						alert(" User Name can not be left Blank !");
						frmmobile.txtUserName.focus();
					}else if(document.getElementById('password').value == ""){
						alert(" Password can not be left Blank !");
						frmmobile.password.focus();
					}else{
						document.frmmobile.submit();			
					}	
				}catch(err){
						alert("callSubmit"+err.description); 
				}
			}
		</script>
	</head>

<body style="margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-bottom: 0px" >
<form id="frmmobile" name="frmmobile" method="get">
<jsp:include page="Header.jsp"></jsp:include>
<div id = "pbar" name="pbar" class="divlist" style="left: 500px;top: 300px;" align="center">
<table style="background: transparent;">			
	<tr>
		<td align="center" valign="middle" ><b><img src="../Image/loading.gif" /></b></td>
	</tr>
</table>
</div>
<table style="background-repeat: repeat-y; background-position: center center;" align="center" width="45%" background="../Image/body-bg.gif" border="0" cellpadding="0" cellspacing="0">
<tbody >    
<%--    <tr><td colspan="3" width="475" align="center"><MARQUEE behavior="alternate"><img src="../Image/mobilebanner.jpg" alt="Cricinfo Mobile" title="Cricinfo Mobile" border="0" ></marquee></td></tr>--%>
	<tr><td colspan="3" width="475" height="60" align="center">&nbsp;</td></tr>
     <!-- Header ends here -->
   
    <tr>
        <td colspan="3" width="465"><table width="465" align="center" border="0" cellpadding="0" cellspacing="0">
        <tbody>
    <tr>     
        <td width="475" height="263">
 <div id = "divMain" name="divMain" >       
        <table width="465" align="center" border="0" cellpadding="0" cellspacing="0" height="263">
        <tbody>
            <tr>
                <td width="16"><img src="../Image/cricinfo_wap_left.gif" width="16" height="263"></td>
                <td style="padding-left: 10px; padding-right: 10px; padding-top: 30px;" valign="top" width="242" background="../Image/cricinfo_panels_bg.gif" height="263"><p class="indboxtopic"><img src="../Image/BCCI_Logo_.jpg"  style="width: 40px;height: 40px;padding-right: 10px;">CIMS WAP</p>
                <!--<p class="indBoxhead">Ball-by-ball commentary on your phone</p>-->
                <p class="WPboxbody">Carry cricket information wherever you go with CIMS's brand new mobile site <b>http://www.bccicricket.org<br>/cims/jsp/mobile/login.jsp</b>.
					Live scores, player statistics and our mobile site offers you a pocket-sized bite
					of Cricket information served right on to your mobile phone.</p>
                
                <td valign="top" width="187" background="../Image/cricinfo_wap_right-new.gif" height="263">
                    <div class="wapkeytext">
                        Just Key in this URL<br>
                        <b>http://www.bccicricket.org<br>/cims/jsp/mobile/login.jsp</b> into your phone's browser or<br>Enter your number & get the link
                    </div>
<%--                <form name="wapform" method="post" action="http://cgi.cricket.org/perl/survey/my_indiamobilewap.pl" onsubmit="return MobileValidate();">--%>
 					<form name="wapform" id="wapform" method="" action="" >
					<br>
                    <table class="wapkeyform" border="0" cellpadding="0" cellspacing="0">
                    <tbody><tr><td>
                        <input name="phonecode" id="phonecode" value="+91" size="1" class="wapkeytextfield" disabled="true" style="background-color: rgb(255, 255, 255);" type="text">
                        <input name="phonenumber" class="wapkeytextfield" id="phonenumber" size="9" maxlength="10" type="text">
                        <input type="hidden" name="hdContact" id="hdContact" value="">
                        <input type="hidden" name="hdMessage" id="hdMessage" value="">
                        <input type="hidden" name="hdFlag" id="hdFlag" value="2">
                        <input name="thanks" value="http://www.cricinfomobile.com/india/" type="hidden">
                        <input name="mobile" value="wap" type="hidden">
						<input type="hidden" name="hdUrl" id="hdUrl" value="">
						<input type="button" align="absmiddle" class="smsbutton" value="Send" onclick="validate()">
                    </td></tr></tbody></table>
                </form>
                </td>
            </tr>
          </tbody></table>
</div>          
           <div id = "divLoad" name="divLoad" align="center" style="display:none">
           <img src="../Image/icon-loading-animated.gif"  width="50" height="50" />
		   </div>
		 </td>
      </tr>
    </tbody></table></td>
</tr>
</tbody></table>

			
<!-- content table ends -->
<script language="javascript">
<!--
	var omniSiteSection1 = "mobile";
	var omniSiteSubSection2 = "mobile home";
//-->
</script>

  <tr>
    <td style="background-repeat: no-repeat; background-position: center;" align="center" background="../Image/footer_bottom1.gif" height="90"><table width="465" align="center" border="0" cellpadding="0" cellspacing="0">
        <tbody><tr>
          <td class="footertext" align="center" style="width: 45%;"><a href="login.jsp" class="footerlinks">CIMS Home</a> | <a href="mobile.jsp" class="footerlinks">Mobile Home</a> |
            <!--<a href="http://www.cricinfomobile.com/india/textservices.html" class="footerlinks">Text Services</a> | <a href="http://www.cricinfomobile.com/india/genie.html" class="footerlinks">Cricinfo Genie</a> | -->
            <a href="http://www.paramatrix.co.in" class="footerlinks">Paramatrix Technology pvt ltd.</a>

            <!-- | <a href="http://www.cricinfomobile.com/india/wallpapers.html" class="footerlinks">Wallpapers</a>-->
            <br>
            </td>
        </tr>
      </tbody></table></td>
  </tr>
<!-- footer ends -->
<div style="padding: 0px; margin-bottom: 20px;"></div>
<script language="javascript">
	var omniCt = "Mobile pages";
	var omniSiteSection1 = "mobile";
</script>
<!--
Modified on	:	17th June 2008
Changes		:	Removed s_omni.prop1 variable the prepend to PageName, Sitesection, Category, Prop5 and Hierarchy variables
-->

<!--SiteCatalyst code version: H.14.
Copyright 1997-2007 Omniture, Inc. More info available at
http://www.omniture.com -->

<script type="text/javascript">
	if(window.location.hostname.indexOf("localcms") == -1){
	    var s_account="wdgespcricinfo";	//(Excludes Wireless)
	}
	else{
	    var s_account = "wdgesptest";
	}
	//alert(window.location.hostname);
	//alert(s_account);
</script>

<%--<script language="JavaScript" src="../js/omniture_global.js"></script>--%>


</script>
<!-- End SiteCatalyst code version: H.14. -->

</body>
</html>