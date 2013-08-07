<%-- 
    Document   : UmpiresSelfAssessmentPerformance
    Created on : Dec 17, 2008, 10:50:02 AM
    Author     : viswajeet
--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
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
                Calendar cal ;
                String user_id = null;
                String currYear = null;
                String reportHeading=null;
                Vector vparam = new Vector();
                String sessionId = "0";
                String sessionName = null;
                String umpireHeading = "* U:- Umpire Rating.";
                String coachHeading = "* C:- Umpire Coach Rating.";
                String refereeHeading = "* R:- Referee Rating.";
		GregorianCalendar currDateObj=new GregorianCalendar();
		cal = new GregorianCalendar(currDateObj.get(Calendar.YEAR),currDateObj.get(Calendar.MONTH),1);
		int Year=cal.get(Calendar.YEAR);
                currYear = Year+"-" + (Year+1);
                GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
                String hidId = request.getParameter("hidId")!=null?request.getParameter("hidId"):"0";   
                String sessionVal = request.getParameter("cmbsession")!=null?request.getParameter("cmbsession"):"0";   
                
                
                String reportId = request.getParameter("reportid")!=null?request.getParameter("reportid"):"0";   
                String cmbSession = request.getParameter("cmbsession")!=null?request.getParameter("cmbsession"):currYear;   
               String userRole = session.getAttribute("role").toString();
                String userId = session.getAttribute("userid").toString()!=null?session.getAttribute("userid").toString():"0"; 
                if(reportId.equalsIgnoreCase("1")){
                   reportHeading ="Umpire Assessment Report";
                }else if(reportId.equalsIgnoreCase("2")){ 
                    reportHeading ="Umpire Coach Assessment Report";
                 }else if(reportId.equalsIgnoreCase("3")){
                    reportHeading ="Referee Assessment Report";
                 } 
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
                if(userRole.equalsIgnoreCase("9")){
                   vparam.add("1");  // admin login
                }else{
                    vparam.add("2"); // other than admin login
                }
                    vparam.add(userId); 
                if(reportId.equalsIgnoreCase("1")){
                    crsCmbMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_umpires_self_assessment_performance", vparam, "ScoreDB");
                   
                }else if(reportId.equalsIgnoreCase("2")){
                    crsCmbMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_umpires_coaches_umpires_assessment_performance", vparam, "ScoreDB");
                    
                }else if(reportId.equalsIgnoreCase("3")){
                    crsCmbMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_referee_assessment_performance", vparam, "ScoreDB");
                    
                }
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
            function validate() {
                if(document.getElementById("cmbsession").value=="0"){
                    alert("Please Select Season");
                    return false;
                }else{    
                    document.getElementById("hidId").value="1";
                    document.umpireselfassessmentForm.action = "/cims/jsp/UmpiresSelfAssessmentPerformance.jsp";
                    document.umpireselfassessmentForm.submit();
                }
            }
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
             function mainReport(report_id,session_id,user_id){
                try { 
                    if(document.getElementById(user_id).style.display=='none'){
                    var sessionVal = document.getElementById("sessionVal").value;
                    xmlHttp = this.GetXmlHttpObject();
                    if (xmlHttp == null) {
                        alert("Browser does not support HTTP Request");
                        return;
                    }else{
                        var url = "/cims/jsp/UmpireMatchReportResponse.jsp?reportId="+report_id+"&sessionId="+session_id+"&userId="+user_id+"&cmbsession="+sessionVal;
        		 xmlHttp.open("post", url, false);
                   	 xmlHttp.send(null);
                         if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                            try {
                                var responseResult = xmlHttp.responseText ;
                                document.getElementById(user_id).innerHTML = responseResult
                                
                                document.getElementById(user_id).style.display='';
                                //document.getElementById("plusImage"+user_id).src = "../images/minus.jpg";
                                document.getElementById(user_id).scrollIntoView(true);
                                   
                            } catch(err) {
                              
                             }
                         }//end of if 
                      }// end of else
                      }else{
                         document.getElementById(user_id).style.display='none';
                         document.getElementById("plusImage"+user_id).src = "../images/plusdiv.jpg";
                      }
                  } catch(err) {
                        alert(err.description + 'ajex.js.inningid');
                  }//end of catch	
                   
               }
               
                 function umpire(id){
                 if(document.getElementById("umpire"+id).style.display==''){
                    document.getElementById("umpire"+id).style.display='none';
                 }else{
                    document.getElementById("umpire"+id).style.display='';
                 } 
               }
               
               function coach(id){
                 if(document.getElementById("coach"+id).style.display==''){
                    document.getElementById("coach"+id).style.display='none';
                 }else{
                    document.getElementById("coach"+id).style.display='';
                 } 
               }
               function HidUnHide(id){
                 if(document.getElementById("umpireremark"+id).style.display==''){
                    document.getElementById("umpireremark"+id).style.display='none';
                 }else{
                    document.getElementById("umpireremark"+id).style.display='';
                 }
               }
               function hdUmpireCoachText(id){
                 if(document.getElementById("umpirecoachremark"+id).style.display==''){
                    document.getElementById("umpirecoachremark"+id).style.display='none';
                 }else{
                    document.getElementById("umpirecoachremark"+id).style.display='';
                 }
               }    

	</script>

    </head>
    <body>
     <jsp:include page="Menu.jsp"></jsp:include>
    <table width="100%">
    <tr>
    	<td align="center">
    
    <div>

		
    <br>
    <br>   
    <form name="umpireselfassessmentForm" id="umpireselfassessmentForm" method="POST">
      <table class="table" width="100%">>
         <tr>
            <td width="100%" align="left" class="legend"><%=reportHeading%></td>
	     </tr>
     </table>
     <table width="100%" cellpadding="2" cellspacing="1" class="table">
       <tr> 
         <td>
           <table width="100%" border="0" align="center" class="table">
             <tr class="contentLight">
               <td  align="left"  class="contentDark">Season :
              
                 <select id="cmbsession" name="cmbsession">
             	    <option value="0">---Select---</option>
<%               if(crsObjMtWiseUmpSelfAssest!=null){
                   while(crsObjMtWiseUmpSelfAssest.next()){
%>                  <option value='<%=crsObjMtWiseUmpSelfAssest.getString("id")+"~"+crsObjMtWiseUmpSelfAssest.getString("name")%>'<%=(sessionName.trim()).equalsIgnoreCase(crsObjMtWiseUmpSelfAssest.getString("name").trim())?"selected":"" %>><%=crsObjMtWiseUmpSelfAssest.getString("name")%></option>
<%                 }// end of while
                }// end of if
%>              </select>   
				 <INPUT type="button" name="button" value="Search" onclick="validate();" > 
              </td>
              <td>
                * Click on Name or Score to get details.
              </td>    
             </tr>    
           </table> 
         </td>
       </tr>
       <tr>
         <td>    
<%         if(hidId.equalsIgnoreCase("1")){
%>         <table width="100%" border="0" align="center" class="table">
             <tr class="contentLight">
               <td align="left">
                    * U:- Umpire Rating.
               </td>    
            </tr>   
<%          if(reportId.equalsIgnoreCase("1") || reportId.equalsIgnoreCase("2")){
%>          <tr class="contentLight">
              <td align="left">
                    * C:- Umpire Coach Rating.
              </td>    
            </tr>
<%          }else{
%>          <tr class="contentLight">
              <td align="left">
                 * R:- Referee Rating.
              </td>    
            </tr> 
<%          }
%>            
          </table> 
          <br>
               <table width="100%" border="1" align="center" class="table">
               <tr class="contentDark">
                   
<%                 if(reportId.equalsIgnoreCase("1") ||reportId.equalsIgnoreCase("2") ){  
%>                 <td>Umpire Name</td>
                   <td>Umpire Rating</td>
                   <td>Umpire Coach Rating</td>
<%                 }else if(reportId.equalsIgnoreCase("3")){                 
%>                 <td>Umpire Name</td>
                   <td>Umpire  Rating</td>
                   <td>Referee Rating</td>
<%                  }
%>               
				   <td>FeedBack</td>    
               </tr> 
<%          if(crsCmbMtWiseUmpSelfAssest!=null && crsCmbMtWiseUmpSelfAssest.size()>0){ 
            int i=0;
             while(crsCmbMtWiseUmpSelfAssest.next()){
              if(reportId.equalsIgnoreCase("1")){  
                user_id =   crsCmbMtWiseUmpSelfAssest.getString("user_id");
              }else if(reportId.equalsIgnoreCase("2")){  
                user_id =   crsCmbMtWiseUmpSelfAssest.getString("user_id");
              }else if(reportId.equalsIgnoreCase("3")){  
                 user_id =   crsCmbMtWiseUmpSelfAssest.getString("user_id"); 
              }
              if(i%2==0){
%>             <tr >
<%              }else{
%>              <tr >
<%               }
%>                  <td align="left"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=user_id%>')"><IMG id="plusImage<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" name="plusImage<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" border="0" title="Click On + To Get The Details." height="10px" alt="" src="../images/plusdiv.jpg" /></a><%=crsCmbMtWiseUmpSelfAssest.getString("name")%></td>
                    <td align="right"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=user_id%>')" class="link"><font color="#B0B0B0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("TotalScore")%></b></font></a></td>
                    <td align="right"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=user_id%>')" class="link"><font color="#716FB0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("umpirecoachrate")%></b></font></a></td>
                     <td align="right"><a href="javascript:mainReport('<%=reportId%>','<%=sessionId%>','<%=user_id%>')" class="link"><font color="#716FB0"><b><%=crsCmbMtWiseUmpSelfAssest.getString("feedback_cnt")%></b></font></a></td>
                   
                </tr>
                <tr>
                    <td colspan="4">
                        <div id="<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" name="<%=crsCmbMtWiseUmpSelfAssest.getString("user_id")%>" style='display:none;overflow:auto'>
                        </div>
                    </td>
                </tr>
<%           i=i+1;
              }// end of while
             }// end of if
             else{
%>            <tr>
               <td colspan="4" align="center"> <font color="red" size="4px"> Record Not Found</font>
              </td>
             </tr>
			    
<%			}	
%>
           </table>    
<%          }
%>          </td> 
            </tr>
            </table>
           <input type="hidden" name="hidId" id="hidId" value="0">
           <input type="hidden" name="reportid" id="reportid" value="<%=reportId%>">    
           <input type="hidden" name="sessionVal" id="sessionVal" value="<%=sessionVal%>">    
           <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
				<tr>
					<td>
						<jsp:include page="admin/Footer.jsp"></jsp:include>
					</td>
				</tr>
			</table>
       </form>   
       </div>
       </td>
       </tr>
       </table> 
    </body>
</html>
