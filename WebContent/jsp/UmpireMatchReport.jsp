<!--
	Page Name 	 : UmpireMatchReport.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 22th Nov 2008
	Description  : Umpire Match Report 
	Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
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

%>
<%
		CachedRowSet crsObjMtWiseUmpSelfAssest = null;
                CachedRowSet displayPlayerRunsCrs = null;
		Vector vparam = null;
                String rem =null;
                Vector vMatchparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		//String umpire_name = "";
		//String season_name = "";
                String playerRun="0";
                String totalMatch="0";
                boolean flag = false;
                boolean batFlag = false;
                boolean runFlag = false;
                String Remark = null;
                String BatType = null;
                String BatOrder = null;
                String reportHeading=null;
                String runReportId= null;
		String umpireId = request.getParameter("userId")!=null?request.getParameter("userId"):"0";
		String seasonId = request.getParameter("sessionId")!=null?request.getParameter("sessionId"):"0";
                String reportId = request.getParameter("reportId")!=null?request.getParameter("reportId"):"0";
		String cmbsession = request.getParameter("cmbsession")!=null?request.getParameter("cmbsession"):"0";
                LinkedList<HashMap<String, Integer>> vMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmMatchFeedback = null;
                LinkedList<HashMap<String, String>> vMatchRemark = new LinkedList<HashMap<String, String>>();
                HashMap<String, String> hmMatchRemark = null;
		LinkedList<String> questions = new LinkedList<String>();
		LinkedList<String> teams = new LinkedList<String>();
		LinkedList<String> refree = new LinkedList<String>();
		String serverMessageForUmpire = null;
		
                if(reportId.equalsIgnoreCase("4")){
                    runReportId = "9";
                }else if(reportId.equalsIgnoreCase("5")){
                    runReportId = "10";
                }else if(reportId.equalsIgnoreCase("6")){
                    runReportId = "11";
                }else if(reportId.equalsIgnoreCase("7")){
                    runReportId = "12";
                }
                if(reportId.equalsIgnoreCase("4") || reportId.equalsIgnoreCase("5") || reportId.equalsIgnoreCase("6") || reportId.equalsIgnoreCase("7")){    
                vMatchparam.add(umpireId);
                 vMatchparam.add(runReportId);
                 displayPlayerRunsCrs = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_batsman_total_runs", vMatchparam, "ScoreDB");
         
                if(displayPlayerRunsCrs!=null){               
                while(displayPlayerRunsCrs.next()){
                    playerRun = displayPlayerRunsCrs.getString("playerStaticstic");
                    totalMatch = displayPlayerRunsCrs.getString("totalmatch");
                }
                if(reportId.equalsIgnoreCase("4")){
                    playerRun = playerRun + " Runs. Matches:-"+totalMatch;
                }else if(reportId.equalsIgnoreCase("5") || reportId.equalsIgnoreCase("6")){
                    playerRun = playerRun + " Wkts. Matches:-"+totalMatch; 
                }else if(reportId.equalsIgnoreCase("7")){
                    playerRun = playerRun + " Stumpings / catches. Matches:-"+totalMatch;
                }
                }
              }
                
                
                
			if(seasonId!= null) {
				vparam = new Vector();
				vparam.add(umpireId);
				vparam.add(seasonId);
                               if(reportId.equalsIgnoreCase("4")){
                                    crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
                                    "esp_dsp_matchwisebattingtrdo", vparam, "ScoreDB");
                                     reportHeading ="Batsman TRDO";
                                     rem="bats";
                                }  else if(reportId.equalsIgnoreCase("5")){
                                    crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
                                    "esp_dsp_matchwisepacertrdo", vparam, "ScoreDB");
                                     reportHeading ="Pacer TRDO";
                                     rem="pacer";
                                }   else if(reportId.equalsIgnoreCase("6")){
                                    crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
                                    "esp_dsp_matchwisespinnertrdo", vparam, "ScoreDB");
                                     reportHeading ="Spinner TRDO";
                                     rem="spiner";
                                }    else if(reportId.equalsIgnoreCase("7")){
                                    crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
                                    "esp_dsp_matchwisewkrtrdo", vparam, "ScoreDB");
                                     reportHeading ="WicketKeeping TRDO";
                                     rem="wkt";
                                }  
				if(crsObjMtWiseUmpSelfAssest.size() == 0) {
						serverMessageForUmpire = "No Records Found!";
				} 

			
				
				String matchName = "";
				String refreeName = "";
				try {
					if (crsObjMtWiseUmpSelfAssest != null) {
						while (crsObjMtWiseUmpSelfAssest.next()) {
							
							if (!matchName.trim().equals(crsObjMtWiseUmpSelfAssest.getString("matchbetween").trim())) {
								if(!matchName.trim().equals("")){
									teams.add(matchName);
									refree.add(refreeName);
								}
								matchName = crsObjMtWiseUmpSelfAssest.getString("matchbetween");
								refreeName = crsObjMtWiseUmpSelfAssest.getString("refree_name");
								if (hmMatchFeedback != null) {
									vMatchFeedBack.add(hmMatchFeedback);
								}
                                                                if (hmMatchRemark != null) {
									vMatchRemark.add(hmMatchRemark);
								}
								hmMatchFeedback = new HashMap<String, Integer>();
                                                                hmMatchRemark= new HashMap<String, String>();
							}
							hmMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest
									.getInt("score"));
                                                        hmMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest
									.getString("remark"));
							if (!questions.contains(crsObjMtWiseUmpSelfAssest.getString("description"))) {
								questions.add(crsObjMtWiseUmpSelfAssest.getString("description"));
							}					
						}
						vMatchFeedBack.add(hmMatchFeedback);
                                                vMatchRemark.add(hmMatchRemark);
                                                teams.add(matchName);
                                                refree.add(refreeName);
                                                
					}
		
				} catch (Exception e) {
					System.out.println(e);
				}
				System.out.println("vMatchFeedBack " + vMatchFeedBack);
				System.out.println("questions " + questions);
				System.out.println("matches " + teams);
			}
		
%>

<div>
<INPUT type="hidden" name="umpireId" id="umpireId" value="<%=umpireId%>">
<INPUT type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">
<table width="100%" align="left" border="0">
	<tr>
		<td width="100%" align="left">
		<DIV id="umpireMatchReportResults" align="left">
		<table align="center" border="0" width="100%">
			<tr>
				<td align="left">
		<%
					 if(serverMessageForUmpire != null && !serverMessageForUmpire.equals("")) {
		%>
								<font color=red><%=serverMessageForUmpire%></font>
		<%	}							
		%>
				<td>
			</tr>
			<tr>
				<td><b>* To get the remark,please click on particular question's score.</b>
				<br>
                                <br>     
				<table width="80%" border="0" align="left" cellpadding="2"	cellspacing="1" class="table tableBorder">
					<tr class="contentDark" rowspan="3">
						<th align="left" width="5%"><b>Questions \ Match Name </b></th>
						<%
						int total_teams = teams.size();
						
						if(total_teams > 0) {
							for(int i=0; i < total_teams; i++) { %>
								<th align="right" width="1%"><b><%=teams.get(i)%></b><br/>
								<font color="red"><b>R:- (<%=refree.get(i)%>)</b></font></th>
							<% } %>
							<th align="right" width="1%"><b>Total</b></th>
							</tr>
							<%
							LinkedList<Integer> totals = new LinkedList<Integer>();
							for(int i = 0; i < total_teams; i++){
								totals.add(0);
							}
							 for(int j=0; j < questions.size(); j++) {
								String desc = questions.get(j);%>								
								<tr>
<%                                                               if(reportId.equalsIgnoreCase("4") && desc.equalsIgnoreCase("Batsman Order")){
                                                                        flag = true;
                                                                 }else if(reportId.equalsIgnoreCase("4") && desc.equalsIgnoreCase("Type Of Batsman")){  
                                                                        batFlag = true;
                                                                 }else if(reportId.equalsIgnoreCase("5") && desc.equalsIgnoreCase("Type of Bowling")){  
                                                                        batFlag = true;
                                                                 }else if(reportId.equalsIgnoreCase("6") && desc.equalsIgnoreCase("Type of Bowling")){  
                                                                        batFlag = true;
                                                                 }else if((reportId.equalsIgnoreCase("4") ||reportId.equalsIgnoreCase("5")||reportId.equalsIgnoreCase("6")||reportId.equalsIgnoreCase("7")) && (desc.trim()).equalsIgnoreCase("Performance")){
                                                                        runFlag = true;
                                                                 }
%>                                                                     
									<td><%=desc%></td>
									<%
										int sum=0;
									 for(int i = 0; i < total_teams; i++) {
										int point = 0;
										if(vMatchFeedBack.get(i).containsKey(desc)){
											point = vMatchFeedBack.get(i).get(desc);											
										}
										sum = sum + point;										
										totals.add(i, totals.get(i) + point);
										totals.remove(i + 1);
                                                                                if (vMatchRemark.get(i).containsKey(desc)){
                                                                                    Remark = vMatchRemark.get(i).get(desc);											
                                                                                }
										%>
										<td align="right">
                                                                                     <table>
                                                                                         <tr>
<%                                                                                        if(flag){
                                                                                           flag = false;
                                                                                             if(point==1){
                                                                                               BatOrder="Opner";
                                                                                             }else{
                                                                                                 BatOrder="Middle";
                                                                                             }
                                                                                           %>                                                                                             
																							<td>
<a class="link"><font color="#716FB0"><b><%=BatOrder%></b></font></a></td>                                                                                                   
<%                                                                                          }else if(batFlag){
                                                                                                batFlag = false;
                                                                                                  if(point==1){
                                                                                                    BatType="Left handed";
                                                                                                   }else{
                                                                                                     BatType="Right handed";
                                                                                                    }
%>                                                                                                  <td nowrap>
<a class="link"><font color="#716FB0"><b><%=BatType%></b></font></a></td>                                                                                                   
<%                                                                                            }else if(runFlag){
                                                                                                     runFlag = false;   
%>                                                                                                  <td nowrap>
<a class="link"><font color="#716FB0"><b><%=playerRun%></b></font></a></td>                                                                                                   
<%                                                                                               }else{
%>                                                                                             
                                                                                             <td>
<a href="javascript:HidUnHide('<%=rem%><%=i+""+j%>')" class="link"><font color="#716FB0"><b> <%=point%></b></font></a></td>
<%                                                                                         }
%>                                                                                             
                                                                                         </tr>   
                                                                                         <tr><td><div id="remark<%=rem%><%=i+""+j%>" name="remark<%=rem%><%=i+""+j%>"  style="display:none">
                                                                                         <textarea  class="textArea" id="remarktext<%=i%>" name="remarktext<%=i%>" ><%=Remark%></textarea>
                                                                                         </div></td></tr>   
                                                                                      </table>
                                                                                </td>
									<% } %>									
										<td align="right"><b><font color="red" size="2.8px"><%=sum%></font></b></td>
								</tr>
							<%} %>
							<tr>
								<td>Total</td>
								<% 
								int team_sum = 0;
								for(int i = 0; i < total_teams; i++){ %>
									<td align="right"><font color="#716FB0"><b><%=totals.get(i)%><b></font></td>
								<%
								team_sum = team_sum + totals.get(i);
								}%>
								<td align="right"><b><FONT color="red" size="2.8px"><%=team_sum%></FONT></b></td>
							</tr>
						<% } %>
					</tr>
				</table>
				</td>
			</tr>
		</table>
                 <br>
                <table align="center" border="0" width="70%">
                    <tr>
                        <td align="center">
                            <input type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">
                            <input type="hidden" name="reportId" id="reportId" value="<%=reportId%>">
                            <input type="hidden" name="cmbsession" id="cmbsession" value="<%=cmbsession%>">
                    </tr>    
                </table>     
    </div>	

