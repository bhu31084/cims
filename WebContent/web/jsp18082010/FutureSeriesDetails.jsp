<!--
Page Name 	 : /web3/jsp/FutureSeriesDetails.jsp
Created By 	 : Archana Dongre.
Created Date : 3 march 2009
Description  : To show future series.
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*"%>
<%@ include file="loginvalidate.jsp" %>
<%		
	
	String seriesname = "";				
	CachedRowSet  crsObjFutureSeries = null;
	CachedRowSet  crsObjgetPlayers = null;
	CachedRowSet  crsObjGetMatches  = null;
	CachedRowSet  crsObjgetteam2Player = null;
	Vector vParam =  new Vector();
	//Vector vparam =  new Vector();
	String seriesid = null;
	//GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	
	ArrayList<String> list =  new ArrayList<String>();
	ArrayList<String> list2 =  new ArrayList<String>();
	
		try{			
			vParam.add("1");//Flag for series list on fist step
			vParam.add("");//Series id which is blank in first step
			crsObjFutureSeries = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_futureseries",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("*************** FutureSeriesDetails.jsp************");
			e.printStackTrace();
		}		
		%>			

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CIMS 2009</title>
<link href="../css/Main.css" rel="stylesheet" type="text/css" />
<link href="../css/commonSpry.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/otherFeedback.js"></script>
<script language="JavaScript" src="../js/popup.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>

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
	
	function callSubmit(){		
			try{
				document.getElementById('hdSubmit').value = "submit"			
				if(document.getElementById('txtUserName').value == ""){
					alert(" User Name can not be left Blank !");
					frmfutureseries.txtUserName.focus();
				}else if(document.getElementById('password').value == ""){
					alert(" Password can not be left Blank !");
					frmfutureseries.password.focus();
				}else{
					document.frmfutureseries.submit();			
				}	
		}catch(err){
				alert("callSubmit"+err.description); 
		}
	}
	
	function coordinates(event,seriesId,seriesname)
	{
		x=event.screenX;
		y=event.screenY;
		//alert("X=" + x + " Y=" + y);
		getseriesmatches(seriesId,seriesname,x,y);
		
	}
	
<%--	overDetails = function(id){--%>
<%--	    document.getElementById('MatchesDiv'+id).style.display = 'block'--%>
<%--	    //var over = document.getElementById('achorover_num'+id).value;--%>
<%--	    //var eachover  = parseInt(over) - parseInt(1);--%>
<%--	    //ajexObj.sendDataToolTip('toolTip',eachover); --%>
<%--	}--%>
	
	function getseriesmatches(seriesId,seriesname){					
			if(document.getElementById("MatchesDiv"+seriesId).style.display == ''){
				document.getElementById("plusImage").src = "../Image/horizontal_arw.gif";
				document.getElementById("MatchesDiv"+seriesId).style.display = 'none';
			}else{
				document.getElementById("plusImage").src = "../Image/vertical_arw.gif";
				document.getElementById("MatchesDiv"+seriesId).style.display = '';
			}	
			
			//window.open("futureseriesmatches.jsp?seriesId="+seriesId+"&name="+seriesname,"CIMSfutureseries","location=yes,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,top="+y +",left="+ x + ",width=350,height=300");		
	}
	
	
</script>
</head>

<body  style="margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-right: 0px;" >

<form method="get" name="frmfutureseries" id="frmfutureseries">	
<jsp:include page="Header.jsp"></jsp:include>	
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
<div id="outerDiv" style="width: 1003px;height: 500px;">			
	<table style="width: 1003px;">
		<tr>
			<td valign="top">
				<table width="150" border="0" >
				   <tr>
					<td valign="top"><%@ include file="commiteeinfo.jsp" %> 	    	   	 
 	    	   		</td>
				    </tr>				   							  												  												          		
				</table>
			</td>
			<td width="650" border="0" valign="top">
				<div id="FutureSeriesDiv" style="width: 650px;height: 650px;">			   	
			   	<table width="649" border="0" >	
			   		<tr>
				 		<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Future Tournament</td>
				   </tr>				
				</table>				
				  <table width="649" border="0" style="border-left: none;border-top: none;border-right: none;border-bottom: none;" class="contenttable">
					
				<%if(crsObjFutureSeries != null ){			
				int counter =1;
							if(crsObjFutureSeries.size() == 0){
								message = " Data Not Available ";%>
							<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
							<%}else{							
							while(crsObjFutureSeries.next()){ 							
									seriesname = crsObjFutureSeries.getString("description");
									seriesid = crsObjFutureSeries.getString("id");
									if(counter % 2 == 0 ){%>
					        		<tr bgcolor="#f0f7fd">
					        		<%}else{%>
					        		<tr bgcolor="#e6f1fc">	
					        		<%}%>							
										<td id="<%=counter++%>"><a><IMG id="plusImage" name="plusImage" alt="" src="../Image/horizontal_arw.gif" /></a></td>
										<td nowrap="nowrap" ><a href="javascript:getseriesmatches('<%=seriesid%>','<%=seriesname%>')" ><%=seriesname%></a>
										<%
											try {
												vparam.add("2"); // flag to get the matches under selected series.
												vparam.add(seriesid);
												crsObjGetMatches = lobjGenerateProc.GenerateStoreProcedure(
												"esp_dsp_futureseries", vparam, "ScoreDB");								
												vparam.removeAllElements();			
											} catch (Exception e) {
												System.out.println("*************FutureSeriesDetailsAjaxResponse*****************"+e);			
											}
										%>
										<DIV id="MatchesDiv<%=seriesid%>" style="display:none;width=100%;nowrap;z">
										<table border="1" width="350" align="center" class="contenttable">				
												<tr>
													<td background = "../Image/top_bluecen.jpg" valign="top" colspan="5" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;height: 30px;" ><%=seriesname%></td>
												</tr>
												<%if(crsObjGetMatches != null){
													int innercounter = 1;
													if(crsObjGetMatches.size() == 0){
													message = " Data Not Available ";%>
													<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
													<%}else{%>
														<tr>
															<td nowrap="nowrap" style="padding: 5px;"><b>Start Date </b></td>
															<td nowrap="nowrap" style="padding: 5px;"><b>End Date </b> </td>
															<td nowrap="nowrap" style="padding: 5px;"><b>Match Between </b> </td>
															<td nowrap="nowrap" style="padding: 5px;"><b>Venue </b></td>
														</tr>
														<%while(crsObjGetMatches.next()){ 
														if(innercounter % 2 == 0 ){%>
														<tr bgcolor="#e6f1fc">
										        		<%}else{%>
										        		<tr bgcolor="#f0f7fd">	
										        		<%}%>
														<td id="<%=innercounter++%>" nowrap="nowrap" style="padding: 5px;"><%=crsObjGetMatches.getString("expected_start").substring(0,11)%></td>
																<td nowrap="nowrap" style="padding: 5px;"><%=crsObjGetMatches.getString("expected_end").substring(0,11)%></td>
																<td nowrap="nowrap" style="padding: 5px;"><%=crsObjGetMatches.getString("team1")%> Vs <%=crsObjGetMatches.getString("team2")%></td>
																<td nowrap="nowrap" style="padding: 5px;"><%=crsObjGetMatches.getString("venue")%></td>															
														</tr>	
												<%		}
													}
												}%>
													
										</table>
										</DIV>
										</td>
<%--										<div style="background:#ADADAD;left:750px;position:absolute;z-index=0.5;display:none;width=100%;nowrap;z" id='over_<%=seriesid%>' name='over_<%=seriesid%>'>--%>
<%--										<lable id='over<%=seriesid%>'><lable></div>--%>
									</tr>
							<%}
							}
						}	%>	
	              </table>	              
				</div>
			</td>
			<td width="200" border="0" valign="top"></td>
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
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />      	

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

