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
<%--<jsp:include page="loginvalidate.jsp"></jsp:include>--%>
<%@ include file="loginvalidate.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CIMS 2012</title>
<link href="../css/Main.css" rel="stylesheet" type="text/css" />
<%--<link href="../css/form.css" rel="stylesheet" type="text/css" />--%>
<%--<link href="../css/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />--%>
<link href="../css/commonSpry.css" rel="stylesheet" type="text/css" />
<%--<link href="../Image/Main.css" rel="stylesheet" type="text/css" />--%>
<%--<script src="../js/SpryDOMUtils.js" type="text/javascript"></script>--%>
<%--<script src="../js/cp_unobtrusive.js" type="text/javascript"></script>--%>
<%--<script language="JavaScript" type="text/javascript" src="../js/SpryTabbedPanels.js"></script>--%>
<%--<script language="javascript" type="text/javascript" src="../js/tp_unobtrusive.js"></script>--%>
<script language="JavaScript" src="../js/otherFeedback.js"></script>
<script language="JavaScript" src="../js/popup.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>
<%--<script src="../js/SpryMenuBar.js" type="text/javascript"></script>--%>
<style type="text/css">
<!--
.style1 {color: black;font-weight: bold; background: #f0f7fd;text-align: center;}
.style2 {
	color: #fff;
	font-weight: bold;
	font-size:13px;
	padding-left: 30px;
	}
.style3{font-weight: bold;background: #e6f1fc;text-align: center;}
-->
</style>
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
		
	function getBCCISeniorDetails(){		
		document.getElementById("SeniorOfficeDiv").style.display= '';
		document.getElementById("RanjiTrophyDiv").style.display='none';
		document.getElementById("DulipTrophyDiv").style.display='none';
		document.getElementById("DomesticTournamentsDiv").style.display='none';
	}
	
	function getRanjiDetails(){
		
		document.getElementById("SeniorOfficeDiv").style.display='none';
		document.getElementById("RanjiTrophyDiv").style.display='';
		document.getElementById("DulipTrophyDiv").style.display='none';
		document.getElementById("DomesticTournamentsDiv").style.display='none';
	}
		
	function getDulipDetails(){
		
		document.getElementById("SeniorOfficeDiv").style.display='none';
		document.getElementById("RanjiTrophyDiv").style.display='none';
		document.getElementById("DulipTrophyDiv").style.display='';
		document.getElementById("DomesticTournamentsDiv").style.display='none';
	}
	
	function getDomesticDetails(){
		
		document.getElementById("SeniorOfficeDiv").style.display='none';
		document.getElementById("RanjiTrophyDiv").style.display='none';
		document.getElementById("DulipTrophyDiv").style.display='none';
		document.getElementById("DomesticTournamentsDiv").style.display='';
	}	
	
	function callSubmit(){			
			try{
				document.getElementById('hdSubmit').value = "submit"			
				if(document.getElementById('txtUserName').value == ""){
					alert(" User Name can not be left Blank !");
					frmplayerStatus.txtUserName.focus();
				}else if(document.getElementById('password').value == ""){
					alert(" Password can not be left Blank !");
					frmplayerStatus.password.focus();
				}else{
					document.frmplayerStatus.submit();			
				}	
		}catch(err){
				alert("callSubmit"+err.description); 
		}
	}
</script>

</head>
<body  style="margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-right: 0px;">
<form method="get" name="frmplayerStatus" id="frmplayerStatus">
<div id = "pbar" name="pbar" class="divlist" style="left: 450px;top: 300px;" align="center">
<table style="background: transparent;">			
	<tr>
<%--		<td align="center" valign="middle" ><b><img src="../Image/loading.gif" /></b></td>--%>
<td align="center" valign="middle"><b><img src="../Image/wait24trans.gif" />&nbsp;<font color="red" size="3"> Loading ......</b></font></td>
	</tr>
</table>
</div>
<div name="BackgroundDiv" id="BackgroundDiv" class="backgrounddiv" >
</div>
<script>showPopup('BackgroundDiv','pbar')</script>
<jsp:include page="Header.jsp"></jsp:include>
<div id="outerDiv" style="width: 1003px;height: 500px;">			
	<table style="width: 1003px;">
		<tr>
			<td valign="top">
				<table width="250" border="0" class="contenttable">
				   <tr>
				 	<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >About BCCI</td>
				   </tr>
				   <tr bgcolor="#f0f7fd">		    
				    <td style="text-align: right;padding-right: 7px;font-size: 11px;" id=""><a><IMG id="plusImage" name="plusImage" alt="" src="../Image/horizontal_arw.gif" /></a></td>
				    <td nowrap="nowrap" style="text-align: left;font-size: 14px;text-align: center;" valign="top"><a href="javascript:getBCCISeniorDetails()"><b>BCCI - Senior Office Bearers (2008-11) </b></td>		    		    
				   </tr>
				   <tr bgcolor="#e6f1fc">
				   <td style="text-align: right;padding-right: 7px;font-size: 11px;" id=""><a><IMG id="plusImage" name="plusImage" alt="" src="../Image/horizontal_arw.gif" /></a></td>
				    <td style="text-align: left;font-size: 14px;text-align: center;" valign="top"><a href="javascript:getRanjiDetails()" ><b>The Ranji Trophy </b></td>		    		    
				   </tr>
				   <tr bgcolor="#f0f7fd">		    
				    <td style="text-align: right;padding-right: 7px;font-size: 11px;" id=""><a><IMG id="plusImage" name="plusImage" alt="" src="../Image/horizontal_arw.gif" /></a></td>
				    <td style="text-align: left;font-size: 14px;text-align: center;" valign="top"><a href="javascript:getDulipDetails()"><b>The Duleep Trophy </b></td>		    		    
				   </tr>
				   <tr bgcolor="#e6f1fc">		    
				    <td style="text-align: right;padding-right: 7px;font-size: 11px;" id=""><a><IMG id="plusImage" name="plusImage" alt="" src="../Image/horizontal_arw.gif" /></a></td>
				    <td style="text-align: left;font-size: 14px;text-align: center;" valign="top"><a href="javascript:getDomesticDetails()"><b>Domestic Tournaments 2008-09</b></td>		    		    
				   </tr>	   							  												  												          		
				</table>
			</td>
			<td width="695" border="0" valign="top" class="contenttable">
				<div id="SeniorOfficeDiv" style="width: 690px;height: 550px;">
			   	<table border="0" align="center" width="690">				   		
				   	<tr>
				 		<td background = "../Image/top_bluecen.jpg" valign="top" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >BCCI - Senior Office Bearers (2008-11)</td>
				   	</tr>
				   	<tr >		    
					    <td>
						    <div style="width: 690px;"> 
						    	<table style="width: 690px;" border="0" class="contenttable">
						    	<tr>
							    	  <td class="commityRow" style="width: 40%;">Shashank V Manohar </td>		    		    			   			    
							    <td class="commityRow" style="width: 60%;color: gray;">President </td>		    		    
							   </tr>									   
								   <tr >		    
								    <td class="commityRowAlt">N. Srinivasan</td>		    		    				   	    
							    <td class="commityRowAlt" style="color: gray;">Hon. Secretary </td>		    		    
							   </tr>
								   <tr >		    
								    <td class="commityRow">Sanjay Jagdale </td>		    		    				  		    
							    <td class="commityRow" style="color: gray;">Hon. Joint Secretary </td>
							   </tr>
								   <tr >		    
								    <td class="commityRowAlt">M.P. Pandove </td>		    		    				   		    
							    <td class="commityRowAlt" style="color: gray;">Hon. Treasurer </td>		    		    
							   </tr>
							   <tr >		    
								    <td class="commityRow">N Shivlal Yadav </td>		    		    				   		    
							    <td class="commityRow" style="color: gray;">Vice President </td>
							   </tr>
								   <tr >		    
								    <td class="commityRowAlt">Arun Jaitely </td>		    		    				   		    
							    <td class="commityRowAlt" style="color: gray;">Vice President </td>		    		    
							   </tr>									   
								   <tr >		    
								    <td class="commityRow">Chirayu Amin </td>		    		    				   		    
							    <td class="commityRow" style="color: gray;">Vice President </td>		    		    
							   </tr>
								   <tr >		    
								    <td class="commityRowAlt">Lalit Kumar Modi </td>		    		    				  		    
							    <td class="commityRowAlt" style="color: gray;">Vice President </td>		    		    
							   </tr>
							   <tr >		    
								    <td class="commityRowAlt">Arindam Ganguly  </td>		    		    				  		    
							    	<td class="commityRowAlt" style="color: gray;">Vice President </td>		    		    
							   </tr>
							   </table>
						    </div>
						    <div style="width: 690px;"> 
						    	<table style="width: 690px;" border="0" class="contenttable">								  
								<tr >
						 			<td background = "../Image/top_bluecen.jpg" colspan="2" valign="top" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Administrative Team</td>
						   		</tr> 								   
								   <tr > 		    
								    <td class="commityRow" style="width: 40%;">Prof. R.S. Shetty </td>		    		    				   	    
							    <td class="commityRow" style="width: 60%;color: gray;">General Manager - Game Development</td>		    		    
							   </tr>
								   <tr > 		    
								    <td class="commityRowAlt">Mr.Dinesh Menon</td>		    		    				   		    
							    <td class="commityRowAlt" style="color: gray;">Manager Administration</td>		    		    
							   </tr>									  
								   <tr > 		    
								    <td class="commityRow">Mr.Suru  Nayak</td>		    		    				   	    
							    <td class="commityRow" style="color: gray;">Manager,Cricket Operations</td>		    		    
							   </tr>
								   <tr class="commityRowAlt"> 		    
								    <td class="commityRowAlt">Mr.K.V.P.Rao</td>		    		    				   		    
							    <td class="commityRowAlt" style="color: gray;">Manager,Game Development</td>		    		    
							   </tr>
							   <tr > 		    
								<td class="commityRow">Mr.Devendra Prabhudesai</td>		    		    				   	    
							    <td class="commityRow" style="color: gray;">Manager,Media Relations & Corporate Affairs</td>	
							     </tr>
							   <tr >	    		    
							    <td class="commityRowAlt">Mr.Dalpat Vadolikar</td>		    		    				   	    
							    <td class="commityRowAlt" style="color: gray;">Asst. Manager, Cricket Operations</td>
							   </tr>				  
						    	</table>
						    </div>
			    		</td>
		    		</tr>
				</table>           
				</div>
				<div id="RanjiTrophyDiv" style="width: 700px;height: 655px;display: none; overflow: auto;">
			   	<table>
			   		<tr>
				 		<td background = "../Image/top_bluecen.jpg" colspan="10" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >The Ranji Trophy</td>
				   </tr>
			   		<tr>
			   			<td>
							<div id="abt_bcci_wrap">
							<p>
							<img align="right" style="border: 4px solid #999999" alt="The Ranji Trophy" height="265" hspace="5" src="../Image/ranji_313.jpg" title="The Ranji Trophy" width="192" />The premier annual domestic competition was instituted in 1934, shortly after the national cricket team had played its first Test series at home, against Douglas Jardine&rsquo;s England. India had become a Full Member and even played four Test matches, but the land lacked an inter-provincial championship along the lines of the County championship in England and the Sheffield Shield in Australia. The Mumbai Quadrangular, which featured teams representing the Europeans, Parsis, Hindus and Muslims, was regarded as the main domestic competition at the time, but it had its share of critics on account of its &lsquo;communal&rsquo; overtones. <br />
							<br />
							Anthony De Mello, the BCCI Secretary, prepared a proposal for a national championship. It included an illustration of a trophy - a Grecian urn two feet high, with a figure representing Father Time on the lid. He had barely started to outline the proposal at a meeting of the BCCI representatives in Simla, when the Maharaja of Patiala stepped in and offered to donate the trophy to the Board. He even suggested that the championship be named after K.S. Ranjitsinhji, who had passed away the previous year. 
							</p>		   			</td>
										   		</tr>
										   	</table>
										   	<table>
										   		<tr>
											 		<td background = "../Image/top_bluecen.jpg" colspan="10" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >The First Edition - 1934 to 1935</td>
											   </tr>
										   		<tr>
										   		<td>			   			
							</div>
							<div class="separator tab_sep">
							</div>
							<div id="abt_bcci_wrap">
							<p style="font-weight: bold; font-size: 12px; color: #173884">
							South Zone 
							</p>
							Madras, Mysore, Hyderabad<br />
							</div>
							<div id="abt_bcci_wrap">
							<p style="font-weight: bold; font-size: 12px; color: #173884">
							West Zone 
							</p>
							Western India, Sind, Bombay, Gujarat and Maharashtra <br />
							</div>
							<div id="abt_bcci_wrap">
							<p style="font-weight: bold; font-size: 12px; color: #173884">
							North Zone 
							</p>
							my (Services), United Provinces, Delhi, Southern Punjab<br />
							</div>
							<div id="abt_bcci_wrap">
							<p style="font-weight: bold; font-size: 12px; color: #173884">
							East Zone 
							</p>
							Central India, Central Provinces and Berar<br />
							</div>
							<div id="abt_bcci_wrap">
							<br />
							<p>
							The start of the competition was anti-climactic, with Madras (present-day Tamil Nadu) beating Mysore (present-day Karnataka) by an innings and 23 runs, in a single day! As the tournament settled down, so did the batsmen. Bombay, captained by L.P. Jai, were the first winners. More sides, like Nawanagar and Bengal, joined in the seasons that followed. The competition witnessed some remarkable batting and bowling performances in the late 30s while the first half of the 1940s was dominated by the batsmen. 
							</p>
							<p>
							Sind and a part of Northern India became part of Pakistan in 1947. The &lsquo;Provinces&rsquo; gradually gave way to &lsquo;states,&rsquo; and erstwhile princely states like Nawanagar merged with others. These structural changes led to the creation of a fifth zone &ndash; Central Zone. 
							</p>
							<p>
							The competition was played as a &lsquo;knockout&rsquo; affair till 1957-58, when the format was revised to include an intra-zonal league, which would be followed by a knockout. The top team from each zone would qualify for the knockout stage. One season after this change was made, Bombay / Mumbai embarked on a phenomenal winning streak, bagging the title in succession from 1958-59 to 1969-70. The island-city&rsquo;s dominance might well have prompted Maharashtra to recommend in 1970 that the top two sides from each zone be allowed to play at the knockout stage. The recommendation was accepted. As it turned out, Maharashtra topped the West Zone table that season, with Mumbai coming second. Had the old rule been in place, Mumbai would not have made it. Ironically, Maharashtra ended up losing the final that season to Mumbai! 
							</p>
							<p>
							Mumbai&rsquo;s streak continued till 1972-73 but Erapalli Prasanna&rsquo;s Karnataka broke through in 1973-74, beating Ajit Wadekar&rsquo;s side in the semi-final and went on to win the championship. That ended Mumbai&rsquo;s supremacy in the competition, with sides like Delhi and Karnataka coming to the fore. Their ascent inspired the likes of Tamil Nadu, Hyderabad, Bengal, Haryana, Punjab and Uttar Pradesh in later years, but Mumbai continued to make an impact every now and then. The metropolis has won the championship 37 times in the last 74 years. 
							</p>
							<p>
							The points system was introduced and revised as the years passed, with bonus points being assigned for batting and bowling, as well as performances of the teams. Outright victories obviously fetch the winners more points than those gained on the basis of the first-innings lead. The Ranji Trophy underwent another modification in 1992-93, with the top three sides from each zone being allowed to qualify for the knockouts. In 1996-97, it was decided to follow the intra-zonal league with a &lsquo;Super League,&rsquo; wherein the top three sides from each group were divided into Groups A, B and C. The top eight teams from among these 15 qualified for the quarter-finals. That season also witnessed a unique instance of a five-day Ranji final being played under floodlights, Mumbai edging past Delhi in a &lsquo;batathon&rsquo; at Gwalior. The experiment of playing a first-class game under lights wasn&rsquo;t repeated, and the&rsquo; Super League&rsquo; done away with in 2000-01.&nbsp; 
							</p>
							<p>
							The increasing outcry over the number of one-sided matches in the 2000-01 and 2001-02 seasons prompted the Technical Committee of the BCCI to take a revolutionary step. It was proposed that the 27 teams in the fray be divided into two groups &ndash; Elite and Plate. The top three sides from each zone in the 2001-02 season, would be part of the Elite Group, and the bottom three sides from each zone dispatched to the Plate Group. The 15 &lsquo;Elite&rsquo; sides were divided into two groups of eight and seven teams respectively, and the 12 &lsquo;Plate&rsquo; sides divided into two groups of six. The objective was to provide a level playing-field for the participating sides from the 2002-03 season onwards. The top two sides in the Plate Group that season would be promoted to the Elite Group in 2003-04. On the other hand, the bottom two sides in the Elite Group in 2002-03 would be relegated to the Plate Group. 
							</p>
							<p>
							The modification was a succes and the 2008-09 season will feature an attempt to build on it. Unlike the previous six seasons, 2008-09 will not have a separate Plate Group final. The top two teams will instead be pitch forked to the quarter-finals, where they will be pitted against the top three sides from Elite Group &lsquo;A&rsquo; and the top three sides from Elite Group &lsquo;B.&rsquo; This will mean that every team that begins the season in the Plate Group will also stand a chance of going the distance in the same season. &nbsp; 
							</p><br>
							 	</td>
			   		</tr>
			   		<tr><td colspan="20"></td><hr></tr>
			   	</table>
			   	
			   	
			   	<table width="700" border="0">			   		
			   		<tr>
				 		<td background = "../Image/top_bluecen.jpg" colspan="10" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Present Teams - Participating Teams in 2008</td>
				   </tr>
<%--			   		<tr><td colspan="10">--%>
<%--						<a name="2"></a><h4><a class="tab" href="/the-ranji-trophy.html#" >Present Teams - Participating Teams in 2008<br />--%>
<%--						</a></h4></li>--%>
<%--					</ul>--%>
<%--					</td>--%>
<%--					</tr>--%>
					<tr><td>			

					<p style="font-weight: bold; font-size: 12px; color: #173884">Central Zone</p>
					Uttar Pradesh, Rajasthan, Madhya Pradesh, Railways, Vidarbha.<br>
					
					<p style="font-weight: bold; font-size: 12px; color: #173884">East Zone</p>
					 Assam, Bengal, Jharkhand, Orissa, Tripura<br>
					
					<p style="font-weight: bold; font-size: 12px; color: #173884">North Zone</p>
					Delhi, Haryana, Himachal Pradesh, Jammu and Kashmir, Punjab, Services<br>
					
					<p style="font-weight: bold; font-size: 12px; color: #173884">South Zone</p>
					Andhra Pradesh, Goa, Hyderabad, Karnataka, Kerala, Tamil Nadu<br>
					
					<p style="font-weight: bold; font-size: 12px; color: #173884">West Zone</p>
					Baroda, Gujarat, Maharashtra, Mumbai, Saurashtra<br>		
				
					 		</td></tr>
			   		<tr><td colspan="20"></td><hr></tr>
			   	</table>
			   	<table width="700" border="0" style="border-left: none;border-top: none;border-right: none;border-bottom: none;" class="contenttable">
				<tr><td colspan="20"></td><hr></tr>								                			                				                	
	            </table>    
			   	<table border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;width:57%;margin-left:125px; border-color: #ccc;">	
			   		
			   		<tr>
				 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >The Trophy Finalist 1934-2008</td>
				   </tr>
				    <tr>
					    <td width="25%" height="40" align="center" nowrap="nowrap" bgcolor="#173884"><span class="style2">Year</span></td>
					    <td width="29%" height="40" align="center" nowrap="nowrap" bgcolor="#173884"><span class="style2">Winners</span></td>
					    <td width="46%" height="40" align="center" nowrap="nowrap" bgcolor="#173884"><span class="style2">Runners-up</span></td>
					  </tr>
					  <tr>
					    <td height="25" align="center" valign="middle" nowrap="nowrap" class="style1"><p class="style1">1934-35</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Northern India</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1935-36</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Madras</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1936-37</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Nawanagar</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1937-38</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Hyderabad</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Nawanagar</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1938-39</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Bengal</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Southern Punjab</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1939-40</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Maharashtra</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">United Province</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1940-41</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Maharashtra</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Madras</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1941-42</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mysore</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1942-43</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Baroda</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Hyderabad</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1943-44</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Western India</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1944-45</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Holkar</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1945-46</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Holkar</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Baroda</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1946-47</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Baroda</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Holkar</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1947-48</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Holkar</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1948-49</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Baroda</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1949-50</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Baroda</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Holkar</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1950-51</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Holkar</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Gujarat</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1951-52</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Holkar</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1952-53</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Holkar</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1953-54</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Holkar</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1954-55</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Madras</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Holkar</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1955-56</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1956-57</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Services</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1957-58</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Baroda</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Services</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1958-59</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1959-60</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mysore</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1960-61</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Rajasthan</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1961-62</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Rajasthan</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1962-63</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Rajasthan</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1963-64</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Rajasthan</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1964-65</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Hyderabad</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1965-66</p></td>
					
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Rajasthan</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1966-67</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Rajasthan</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1967-68</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Madras</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1968-69</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1969-70</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Rajashtan</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1970-71</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Maharashtra</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1971-72</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1972-73</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Tamil Nadu</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1973-74</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Karnataka</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Rajasthan</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1974-75</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Karnataka</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1975-76</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Bihar</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1976-77</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Delhi</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1977-78</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Karnataka</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Uttar Pradesh</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1978-79</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Delhi</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Karnataka</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1979-80</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Delhi</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1980-81</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Delhi</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1981-82</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Delhi</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Karnataka</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1982-83</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Karnataka</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1983-84</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Delhi</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1984-85</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Delhi</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1985-86</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Delhi</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Haryana</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1986-87</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Hyderabad</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Delhi</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1987-88</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Tamil Nadu</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Railways</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1988-89</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Delhi</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1989-90</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Bengal</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Delhi</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1990-91</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Haryana</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1991-92</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Delhi</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Tamil Nadu</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1992-93</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Punjab</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Maharashtra</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1993-94</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1994-95</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Punjab</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1995-96</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Karnataka</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Baroda</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1996-97</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Delhi</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1997-98</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Karnataka</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Uttar Pradesh</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">1998-99</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Karnataka</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Madhya Pradesh</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">1999-00</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Hyderabad</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">2000-01</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Baroda</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Railways</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">2001-02</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Railways</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Baroda</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">2002-03</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Tamil Nadu</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">2003-04</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Tamil Nadu</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">2004-05</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Railways</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Punjab</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">2005-06</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Uttar Pradesh</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">2006-07</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Mumbai</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap" class="style1"><p class="style1">Bengal</p></td>
					  </tr>
					  <tr>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">2007-08</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Delhi</p></td>
					    <td height="25" align="center"  valign="middle" nowrap="nowrap"><p class="style3">Uttar Pradesh</p></td>
					  </tr>					  
				</table>
				</br>
				         
				</div>
				<div id="DulipTrophyDiv" style="width: 695px;height: 600px;display: none;">
			   	<table width="700" border="0" >	
			   		<tr>
				 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >The Duleep Trophy </td>
				   </tr>
				   <tr>
				   <td>				   		

<div id="abt_bcci_wrap">
<p>
The abolition of the Pentangulars in 1945-46 was followed by the creation of an inter-zonal competition. However, this tournament was scrapped after three seasons.
</p>
<p>
The Board thought of restarting it more than a decade later. It was felt that since the stronger teams were ruling the roost in the Ranji Trophy, players from relatively &lsquo;weaker&rsquo; states like Kerala, Bihar, Orissa, to name just three, were finding it difficult to gain prominence. It was duly decided to reinstitute an inter-zonal first-class tournament from the 1961-62 season onwards. It was named after K.S. Duleepsinhji, the silken touch artiste of the 1930s. One of the main purposes of the competition was to constitute a &lsquo;selection trial&rsquo; of sorts for the national squad and the players were quick to grasp its significance. 
</p>
<p>
The inaugural match was appropriately staged at Chennai, which had also hosted the first-ever Ranji game in 1934-35, and also India&rsquo;s first-ever Test win in 1951-52. From its inception in 1961-62 to 2002-03, the competition involved five teams &ndash; Central Zone, East Zone, North Zone, South Zone and West Zone and was played in a &lsquo;knockout&rsquo; format.
</p>
<p>
There was a revision in 1993-94. Each team played the other, making a total of ten matches. A points system was worked out and the side topping the group would be declared the winner. This format was followed till 1995-96. However, the creation of the Ranji Trophy &lsquo;Super League&rsquo; in 1996-97, and the consequent increase in the number of games in that tournament, prompted the Board to revert to the original &lsquo;knockout&rsquo; format in the Duleep Trophy. 
</p>
<p>
The abolition of the Ranji &lsquo;Super League&rsquo; in 2000-01 resulted in the Duleep Trophy shifting back to the 1993-94 &lsquo;round-robin&rsquo; system, with each team playing the other four, and the one with the most points being declared the winner.&nbsp;&nbsp;&nbsp; 
</p>
<p>
The tournament underwent a structural change in 2002-03. It was decided to link it to the Ranji Trophy, by bringing the &lsquo;Elite&rsquo; and &lsquo;Plate&rsquo; Group sides into the equation. Three teams were created out of the most consistent players in the &lsquo;Elite&rsquo; Group of the Ranji Trophy, and two teams created from a pool of the best players in the &lsquo;Plate&rsquo; Group. The matches were to be played on a &lsquo;round-robin&rsquo; basis in a designated zone. South Zone played host that season. However, this experiment was short-lived, with the Technical Committee of the BCCI recommending a return to the zonal system in 2003-04. 
</p>
<p>
The Committee also suggested the addition of a sixth team from overseas. The Duleep Trophy continues to be played in this format, with the six sides being divided into two groups, and the number one team from each group qualifying for the final. 
</p>
<%--<div style="text-align: center; width: 100%; padding-bottom: 12px">--%>
<%--<img alt="North Zone, winners of the Duleep Trophy in 2007-08" height="292" src="images/north-zone-winners.jpg" style="border: 4px solid #999999; display: inline" title="North Zone, winners of the Duleep Trophy in 2007-08" width="437" /> --%>
<%--</div>--%>
The 2007-08 season had England &lsquo;A&rsquo; as the sixth team. The &lsquo;star&rsquo; component of the side was Monty Panesar, the left-arm spinner. He was included with a view to preparing himself for England&rsquo;s subsequent Test series in New Zealand, and also to enable him to get a hang of Indian conditions, with England scheduled to tour India in November-December 2008. <br />

				   </td>
				   </tr>				
				</table>
				</br>
				  <table width="700" border="0" style="border-left: none;border-top: none;border-right: none;border-bottom: none;" class="contenttable">
													                			                				                	
	              </table>             
				</div>
				<div id="DomesticTournamentsDiv" style="width: 350px;height: 650px;display: none;">
			   	<table width="350" border="0" >	
			   		<tr>
				 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Domestic Tournaments 2008-09</td>
				   </tr>
				   <tr>
				   	<td>
<div class="separator tab_sep">
</div>
<div id="abt_bcci_wrap" style="height: 600px;overflow: auto;" >
<table>
	<tr bgcolor="#e6f1fc">
 		<td colspan="4" style="font-size: 16px;color: maroon;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Senior Men</td>
   </tr>
   <tr bgcolor="#f0f7fd">
	<td class="smen_name" ><b>Ranji Trophy </td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inner-state league + knockout (first-class)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Duleep Trophy </td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inner-zonal league + final (first-class)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Deodhar Trophy </td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inter-zonal league (limited overs)</td>
	</tr>
	
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Challenger Trophy</td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">India Blues, India Reds, India Greens (limited overs)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Vijay Hazare Trophy</td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inter-state league + knockout (limited overs)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Mushtaq Ali Trophy </td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inner-state league + knockout (Twenty20)</td>
	</tr>	
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Mohd. Nissar Trophy </td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">India and Pakistan's previous season's domestic champions (first class)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Irani Trophy </td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Previous season's Ranji Trophy winner and Rest of India (first-class)</td>
	</tr>
	
	<tr bgcolor="#e6f1fc">
 		<td colspan="4" style="font-size: 16px;color: maroon;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Junior Men</td>
   </tr>
<%--	<tr >--%>
<%-- 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Junior Men</td>--%>
<%--   </tr>--%>
   <tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>C.K.Nayudu Trophy (Under 22)</td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inter-state league + knockout (four-day)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Vinoo Mankad Trophy (Under 19)</td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inter-state league + knockout (limited-overs)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Cooch Behar Trophy (Under 19)</td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inter-state league + knockout (four-day)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Vijay Merchant Trophy (Under 16)</td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inter-state league + knockout (three-day)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>Polly Umrigar Trophy (Under 16)</td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inter-school league + knockout (limited-overs)</td>
	</tr>
	
	<tr bgcolor="#e6f1fc">
 		<td colspan="4" style="font-size: 16px;color: maroon;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Senior Women</td>
   </tr>
<%--	<tr bgcolor="#e6f1fc"> --%>
<%-- 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Senior Women</td>--%>
<%--   </tr>--%>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>All-India League </td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Knockout (two day game)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
	<td class="smen_name"><b>All-India League</td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Knockout (one day game)</td>
	</tr>	
	<tr bgcolor="#e6f1fc">
 		<td colspan="4" style="font-size: 16px;color: maroon;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Challenger Trophy</td>
   </tr>
<%--	<tr>--%>
<%-- 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Challenger Trophy</td>--%>
<%--   </tr>--%>
	<tr bgcolor="#f0f7fd">
		<td class="smen_name"><b>Inter-Zonal Matches</td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">(limited-overs)</td>
	</tr>
	<tr bgcolor="#f0f7fd">
		<td class="smen_name"><b>Twenty20 League</td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Knock out (inter-state)</td>
	</tr>
	<tr bgcolor="#e6f1fc">
 		<td colspan="4" style="font-size: 16px;color: maroon;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Junior Women (Under 19)</td>
   </tr>
<%--	<tr>--%>
<%-- 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Junior Women (Under 19)</td>--%>
<%--   </tr>--%>
	<tr bgcolor="#f0f7fd">
		<td class="smen_name"><b>All-India League </b></td>
	</tr>
	<tr bgcolor="#e6f1fc">	
		<td class="smen_def">Inter-state knockout (one day game)</td>
	</tr>
   
</table>
				   	</td>
				   </tr>				
				</table>
				</br>
				  <table width="695" border="0" style="border-left: none;border-top: none;border-right: none;border-bottom: none;" class="contenttable">
			        			                				                	
	              </table>             
				</div>					
			</td>
			<td width="25" border="0" valign="top"></td>
		</tr>
	</table>
</div>		
			
<table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" >
	<tr>
  		<td>						          	
<br />
<br />
<br />
<br />
<br />
<br />
<br /><br />
   	</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
	</tr>
</table>		
<jsp:include page="Footer.jsp"></jsp:include> 

</form>	
<script>    	
	closePopup('BackgroundDiv','pbar');	
 </script>
</body>		
</html>	

