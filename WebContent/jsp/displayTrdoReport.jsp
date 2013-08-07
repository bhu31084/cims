<%-- 
    Document   : UmpiresSelfAssessmentPerformance
    Created on : Dec 17, 2008, 10:50:02 AM
    Author     : bhushanf
--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%
		response.setHeader("Pragma", "private");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "private");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "must-revalidate");
		response.setHeader("Cache-Control", "must-revalidate");
		response.setDateHeader("Expires", 0);
                CachedRowSet crsObjMtWiseUmpSelfAssest = null;
				CachedRowSet crsCmbMtWiseUmpSelfAssest = null;
                CachedRowSet crsCmbMtWisebatsmantrdo = null;
                CachedRowSet crsCmbMtWisepacertrdo = null;
                CachedRowSet crsCmbMtWisespinnertrdo = null;
                CachedRowSet crsCmbMtWisewkttrdo = null;
                Calendar cal ;
                String currYear = null;
                String reportHeading=null;
                Vector vparam = new Vector();
                String sessionId = "0";
                String sessionName = null;
				GregorianCalendar currDateObj=new GregorianCalendar();
				cal = new GregorianCalendar(currDateObj.get(Calendar.YEAR),currDateObj.get(Calendar.MONTH),1);
				int Year=cal.get(Calendar.YEAR);
                currYear = Year+"-" + (Year+1);
                GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
                String hidId = request.getParameter("hidId")!=null?request.getParameter("hidId"):"0";   
                String sessionVal = request.getParameter("cmbsession")!=null?request.getParameter("cmbsession"):"0";   
                  
                String reportId = request.getParameter("reportid")!=null?request.getParameter("reportid"):"0";   
                String cmbSession = request.getParameter("cmbsession")!=null?request.getParameter("cmbsession"):currYear;   
                if(hidId.equalsIgnoreCase("1")){
                   String sessionArr[] = sessionVal.split("~");
                   if(sessionArr.length > 0){
                    sessionId = sessionArr[0]; 
                    sessionName = sessionArr[1];
                    }
                 }else{
                   sessionName = currYear;    
                 }
                
                vparam.add("");   
                crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_seasonlist", vparam, "ScoreDB");
               vparam.removeAllElements();
               if(hidId.equalsIgnoreCase("1")){
                 vparam.add(sessionId);   
                    crsCmbMtWisebatsmantrdo = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_trdo_batsman", vparam, "ScoreDB");
                    
                    crsCmbMtWisepacertrdo = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_trdo_pacer", vparam, "ScoreDB");
                    
                    crsCmbMtWisespinnertrdo = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_trdo_spinner", vparam, "ScoreDB");
                    
                    crsCmbMtWisewkttrdo = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_trdo_wkt", vparam, "ScoreDB");
                    
                
               vparam.removeAllElements();
               } 
               
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>Umpire Self Assessment Report</title>
<link rel="stylesheet" type="text/css" href="../css/menu.css">
<link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
<link href="../css/form.css" rel="stylesheet" type="text/css" />
<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
<script language="javascript">
			function GetXmlHttpObject() {
                            var xmlHttp = null;
                            try
                            {
                                // Firefox, Opera 8.0+, Safari
                                xmlHttp = new XMLHttpRequest();
                            }
                            catch (e)
                            {
                                // Internet Explorer
                                try
                                {
                                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                                }
                                catch (e)
                                {
                                    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                                }
                            }
                            return xmlHttp;
                         }
                         
                         function validate() {
							document.getElementById("hidId").value="1";
                            document.trdoForm.action = "/cims/jsp/displayTrdoReport.jsp";
							document.trdoForm.submit();
						}
                        function mainReport(report_id,session_id,user_id){
                             var innerName = null;
                             var innerImg = null;
                             if(report_id=="6"){ 
                             innerName="spiner"+user_id;
                             innerImg = "plusspinerImage"+user_id;
                             }else if(report_id=="4"){ 
                                 innerName="bats"+user_id;
                                 innerImg = "plusbatsImage"+user_id;
                             }else if(report_id=="5"){ 
                                 innerName="pacer"+user_id;
                                 innerImg = "pluspacerImage"+user_id;
                             }else if(report_id=="7"){ 
                                 innerName="wkt"+user_id;
                                 innerImg = "pluswktImage"+user_id;
                             }
                             
                             var sessionVal = document.getElementById("sessionVal").value;
                                try { 
                                    if(document.getElementById(innerName).style.display=='none'){
                                        var sessionVal = document.getElementById("sessionVal").value;
                                        xmlHttp = this.GetXmlHttpObject();
                                        if (xmlHttp == null) {
                                            alert("Browser does not support HTTP Request");
                                            return;
                                        }else{
                                            var url = "/cims/jsp/UmpireMatchReport.jsp?reportId="+report_id+"&sessionId="+session_id+"&userId="+user_id+"&cmbsession="+sessionVal;
                                            xmlHttp.open("post", url, false);
                                            xmlHttp.send(null);
                                            if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                                            try {
                                                var responseResult = xmlHttp.responseText ;
                                                document.getElementById(innerName).innerHTML = responseResult
                                                document.getElementById(innerName).style.display='';
                                               document.getElementById(innerImg).src = "/cims/images/minus.jpg";
                                                document.getElementById(innerName).scrollIntoView(true);
                                   
                                            } catch(err) {
                              
                                             }
                                        }//end of if 
                                        }// end of else
                                    }else{
                                    document.getElementById(innerName).style.display='none';
                                    document.getElementById(innerImg).src = "/cims/images/plusdiv.jpg";
                                    }
                            } catch(err) {
                                     alert(err.description + 'ajex.js.inningid');
                             }//end of catch	                                
                                
                                
                        }
                        function HidUnHide(id){
                            if(document.getElementById("remark"+id).style.display==''){
                                document.getElementById("remark"+id).style.display='none';
                            }else{
                                document.getElementById("remark"+id).style.display='';
                                document.getElementById("remark"+id).scrollIntoView(true);
                            }
                        }
                        
		</script>

</head>
<body>
<jsp:include page="Menu.jsp"></jsp:include>
<table width="100%" align="center">
	<tr>
		<td align="center">
		<form name="trdoForm" id="trdoForm" method="POST">
		<table width="100%" border="0" align="center" class="table">
			<tr>
				<td width="100%" align="left" class="legend">TRDO Report</td>
			</tr>
		</table>
		<table width="100%" border="0" align="center" class="table">
			<tr>
				<td>
				<table width="100%" border="0">
					<tr class="contentLight">
						<td>&nbsp;</td>
						<td width="10%" align="left">Season :</td>
						<td width="10%"><select id="cmbsession" name="cmbsession">
							<option value="0">---Select---</option>
							<%  if(crsObjMtWiseUmpSelfAssest!=null){ 
                                while(crsObjMtWiseUmpSelfAssest.next()){
%>
							<option
								value='<%=crsObjMtWiseUmpSelfAssest.getString("id")+"~"+crsObjMtWiseUmpSelfAssest.getString("name")%>'
								<%=sessionName.equalsIgnoreCase(crsObjMtWiseUmpSelfAssest.getString("name"))?"selected":"" %>><%=crsObjMtWiseUmpSelfAssest.getString("name")%></option>
							<%                              }// end of while
                            }// end of if
%>
						</select></td>
						<td align="left">&nbsp;<INPUT type="button"
							class="btn btn-warning btn-small" name="button" value="Search"
							onclick="validate();"> * Click on Person Name or Score
						to get details.</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<%       if(hidId.equalsIgnoreCase("1")){
%>
				<table width="100%" border="0">
					<tr>
						<td width="50%">
						<table style="height: 100%; width: 100%" class="table tableBorder">
							<tr>
								<td colspan="2" align="center"><font color="#AEAEAE"
									size="2px"><b>Batsman</b></font></td>
							</tr>
							<tr class="contentDark">
								<td width="50%">Batsman</td>
								<td width="50%">Total Score</td>
							</tr>
							<%                          if(crsCmbMtWisebatsmantrdo!=null){ 
                            int i=0;
                            while(crsCmbMtWisebatsmantrdo.next()){
                            if(i%2==0){
%>
							<tr>
								<%                          }else{
%>
							
							<tr>
								<%                          }
%>
								<td align="left"><a
									href="javascript:mainReport('4','<%=sessionId%>','<%=crsCmbMtWisebatsmantrdo.getString("user_id")%>')"
									class="link"><IMG
									id="plusbatsImage<%=crsCmbMtWisebatsmantrdo.getString("user_id")%>"
									name="plusbatsImage<%=crsCmbMtWisebatsmantrdo.getString("user_id")%>"
									title="Click On + To Get The Details." height="10px" alt=""
									border="0" src="/cims/images/plusdiv.jpg" /></a>&nbsp;<%=crsCmbMtWisebatsmantrdo.getString("name")%></td>

								<td align="left"><a
									href="javascript:mainReport('4','<%=sessionId%>','<%=crsCmbMtWisebatsmantrdo.getString("user_id")%>')"
									class="link"><%=crsCmbMtWisebatsmantrdo.getString("TotalScore")%></a></td>
							</tr>
							<tr>
								<td colspan="2" style="padding: 0;">
								<div id="bats<%=crsCmbMtWisebatsmantrdo.getString("user_id")%>"
									name="bats<%=crsCmbMtWisebatsmantrdo.getString("user_id")%>"
									style='display: none; overflow: auto'></div>
								</td>
							</tr>
							<%                           i=i+1;
                            }// end of while
                            }// end of if
%>
						</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width="50%">
						<table style="height: 100%; width: 100%" border="0"
							class="table tableBorder">
							<tr>
								<td colspan="2" align="center"><font color="#AEAEAE"
									size="2px"><b>Bowler(Pace)</b></font></td>
							</tr>
							<tr class="contentDark">
								<td width="50%">Pacer</td>
								<td width="50%">Total Score</td>
							</tr>
							<%                          if(crsCmbMtWisepacertrdo!=null){ 
                            int i=0;
                            while(crsCmbMtWisepacertrdo.next()){
                            if(i%2==0){
%>
							<tr>
								<%                          }else{
%>
							
							<tr>
								<%                           }
%>
								<td align="left"><a
									href="javascript:mainReport('5','<%=sessionId%>','<%=crsCmbMtWisepacertrdo.getString("user_id")%>')"
									class="link"><IMG
									id="pluspacerImage<%=crsCmbMtWisepacertrdo.getString("user_id")%>"
									name="pluspacerImage<%=crsCmbMtWisepacertrdo.getString("user_id")%>"
									border="0" title="Click On + To Get The Details." height="10px"
									alt="" src="/cims/images/plusdiv.jpg" /></a>&nbsp;<%=crsCmbMtWisepacertrdo.getString("name")%></td>
								<td align="left"><a
									href="javascript:mainReport('5','<%=sessionId%>','<%=crsCmbMtWisepacertrdo.getString("user_id")%>')"
									class="link"><%=crsCmbMtWisepacertrdo.getString("TotalScore")%></a></td>
							</tr>
							<tr>
								<td colspan="2" style="padding: 0;">
								<div id="pacer<%=crsCmbMtWisepacertrdo.getString("user_id")%>"
									name="pacer<%=crsCmbMtWisepacertrdo.getString("user_id")%>"
									style='display: none; overflow: auto'></div>
								</td>
							</tr>
							<%                          i=i+1;
                            }// end of while
                            }// end of if
%>
						</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width="50%">
						<table style="height: 100%; width: 100%" class="table tableBorder">
							<tr>
								<td colspan="2" align="center"><font color="#AEAEAE"
									size="2px"><b>Bowler(Spin)</b></font></td>
							</tr>
							<tr class="contentDark">
								<td width="50%">Spinner</td>
								<td width="50%">Total Score</td>
							</tr>
							<%                      if(crsCmbMtWisespinnertrdo!=null){ 
                            int i=0;
                            while(crsCmbMtWisespinnertrdo.next()){
                            if(i%2==0){
%>
							<tr>
								<%                           }else{
%>
							
							<tr>
								<%                          }
                                
%>
								<td align="left"><a
									href="javascript:mainReport('6','<%=sessionId%>','<%=crsCmbMtWisespinnertrdo.getString("user_id")%>')"
									class="link"><IMG
									id="plusspinerImage<%=crsCmbMtWisespinnertrdo.getString("user_id")%>"
									name="plusspinerImage<%=crsCmbMtWisespinnertrdo.getString("user_id")%>"
									border="0" title="Click On + To Get The Details." height="10px"
									alt="" src="/cims/images/plusdiv.jpg" /></a>&nbsp;<%=crsCmbMtWisespinnertrdo.getString("name")%></td>
								<td align="left"><a
									href="javascript:mainReport('6','<%=sessionId%>','<%=crsCmbMtWisespinnertrdo.getString("user_id")%>')"
									class="link"><%=crsCmbMtWisespinnertrdo.getString("TotalScore")%></a></td>
							</tr>
							<tr>
								<td colspan="2" style="padding: 0;">
								<div
									id="spiner<%=crsCmbMtWisespinnertrdo.getString("user_id")%>"
									name="spiner<%=crsCmbMtWisespinnertrdo.getString("user_id")%>"style:"display:none;overflow:auto">
								</div>
								</td>
							</tr>
							<%                           i=i+1;
                             }// end of while
                             }// end of if
%>
						</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td width="50%">
						<table style="height: 100%; width: 100%" class="table tableBorder">
							<tr>
								<td colspan="2" align="center"><font color="#AEAEAE"
									size="2px"><b>Wicket Keeper</b></font></td>
							</tr>
							<tr class="contentDark">
								<td width="50%">Wicket keeping</td>
								<td width="50%">Total Score</td>
							</tr>
							<%                          if(crsCmbMtWisewkttrdo!=null){ 
                            int i=0;
                            while(crsCmbMtWisewkttrdo.next()){
                            if(i%2==0){
%>
							<tr>
								<%                          }else{
%>
							
							<tr>
								<%                           }
%>
								<td align="left"><a
									href="javascript:mainReport('7','<%=sessionId%>','<%=crsCmbMtWisewkttrdo.getString("user_id")%>')"
									class="link"><IMG
									id="pluswktImage<%=crsCmbMtWisewkttrdo.getString("user_id")%>"
									name="pluswktImage<%=crsCmbMtWisewkttrdo.getString("user_id")%>"
									title="Click On + To Get The Details." height="10px" border="0"
									alt="" src="/cims/images/plusdiv.jpg" /></a> &nbsp;<%=crsCmbMtWisewkttrdo.getString("name")%></td>
								<td align="left"><a
									href="javascript:mainReport('7','<%=sessionId%>','<%=crsCmbMtWisewkttrdo.getString("user_id")%>')"
									class="link"><%=crsCmbMtWisewkttrdo.getString("TotalScore")%></a></td>
							</tr>
							<tr>
								<td colspan="2" style="padding: 0;">
								<div id="wkt<%=crsCmbMtWisewkttrdo.getString("user_id")%>"
									name="wkt<%=crsCmbMtWisewkttrdo.getString("user_id")%>"
									style='display: none; overflow: auto'></div>
								</td>
							</tr>
							<%                          i=i+1;
                            }// end of while
                            }// end of if
%>
						</table>
						</td>
					</tr>
				</table>
				<%      }
%>
				</td>
			</tr>
		</table>
		<input type="hidden" name="hidId" id="hidId" value="0"> <input
			type="hidden" name="reportid" id="reportid" value="<%=reportId%>">
		<input type="hidden" name="sessionVal" id="sessionVal"
			value="<%=sessionVal%>">

		</div>
		</td>
	</tr>
</table>

</form>
<jsp:include page="admin/Footer.jsp"></jsp:include>
</body>
</html>
