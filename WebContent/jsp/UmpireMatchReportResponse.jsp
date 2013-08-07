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

%>
<%
		CachedRowSet crsObjMtWiseUmpSelfAssest = null;
                CachedRowSet displayPlayerRunsCrs = null;
		Vector vparam = null;
                Vector vMatchparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		//String umpire_name = "";
		//String season_name = "";
                String umpirename= "";
                String playerRun="0";
                String totalMatch="0";
                boolean flag = false;
                boolean batFlag = false;
                boolean runFlag = false;
                String Remark = null;
                String umpireCoachRemark = null;
                String BatType = null;
                String BatOrder = null;
                String reportHeading=null;
                String runReportId= null;
                String userId = session.getAttribute("userid").toString()!=null?session.getAttribute("userid").toString():"0"; 
		String umpireId = request.getParameter("userId")!=null?request.getParameter("userId"):"0";
		String seasonId = request.getParameter("sessionId")!=null?request.getParameter("sessionId"):"0";
                String reportId = request.getParameter("reportId")!=null?request.getParameter("reportId"):"0";
		String cmbsession = request.getParameter("cmbsession")!=null?request.getParameter("cmbsession"):"0";
                LinkedList<HashMap<String, Integer>> vMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmMatchFeedback = null;
                LinkedList<HashMap<String, Integer>> vUmpireCoachMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmUmpireCoachMatchFeedback = null;
                LinkedList<HashMap<String, String>> vMatchRemark = new LinkedList<HashMap<String, String>>();
                HashMap<String, String> hmMatchRemark = null;
                LinkedList<HashMap<String, String>> vumpircoachMatchRemark = new LinkedList<HashMap<String, String>>();
                HashMap<String, String> hmumpircoachMatchRemark = null;
		LinkedList<String> questions = new LinkedList<String>();
		LinkedList<String> teams = new LinkedList<String>();
                LinkedList<String> umpie1Name = new LinkedList<String>();
                LinkedList<String> umpie2Name = new LinkedList<String>();
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
                                vparam.add(userId);
                                
                                if(reportId.equalsIgnoreCase("1")){        
				crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_matchwiseumpireselfassessment", vparam, "ScoreDB");
                                 reportHeading ="Umpire Assessment";
				}else if(reportId.equalsIgnoreCase("2")){
                                    crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
                                    "esp_dsp_matchwiseumpirecoachassessment", vparam, "ScoreDB");
                                    reportHeading ="Umpire Coach Assessment";
                                }else if(reportId.equalsIgnoreCase("3")){
                                    crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
                                    "esp_dsp_matchwiserefereeassessment", vparam, "ScoreDB");
                                     reportHeading ="Referee Assessment";
                                } else if(reportId.equalsIgnoreCase("4")){
                                    crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
                                    "esp_dsp_matchwisebattingtrdo", vparam, "ScoreDB");
                                     reportHeading ="Batsman TRDO";
                                }  else if(reportId.equalsIgnoreCase("5")){
                                    crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
                                    "esp_dsp_matchwisepacertrdo", vparam, "ScoreDB");
                                     reportHeading ="Pacer TRDO";
                                }   else if(reportId.equalsIgnoreCase("6")){
                                    crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
                                    "esp_dsp_matchwisespinnertrdo", vparam, "ScoreDB");
                                     reportHeading ="Spinner TRDO";
                                }    else if(reportId.equalsIgnoreCase("7")){
                                    crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
                                    "esp_dsp_matchwisewkrtrdo", vparam, "ScoreDB");
                                     reportHeading ="WicketKeeping TRDO";
                                }  
				if(crsObjMtWiseUmpSelfAssest.size() == 0) {
						serverMessageForUmpire = "No Records Found!";
				} 

                                String matchName = "";
                                String umpire="";
                                String coach = "";
                                String referee = "";  
				try {
					if (crsObjMtWiseUmpSelfAssest != null) {
						while (crsObjMtWiseUmpSelfAssest.next()) {
							
							if (!matchName.trim().equals(crsObjMtWiseUmpSelfAssest.getString("matchbetween").trim())) {
								if(!matchName.trim().equals("")){
									teams.add(matchName);
								}
                                                                matchName = crsObjMtWiseUmpSelfAssest.getString("matchbetween");
								if(!umpire.trim().equals("")){
                                                                umpie1Name.add(umpire);
                                                                }
                                                                umpire = crsObjMtWiseUmpSelfAssest.getString("umpirename");
                                                                umpie2Name.add(coach);
                                                                coach = crsObjMtWiseUmpSelfAssest.getString("umpirecoachname");
                                                                if (hmMatchFeedback != null) {
									vMatchFeedBack.add(hmMatchFeedback);
								}
                                                                if (hmUmpireCoachMatchFeedback != null) {
									vUmpireCoachMatchFeedBack.add(hmUmpireCoachMatchFeedback);
								}
                                                                if (hmMatchRemark != null) {
									vMatchRemark.add(hmMatchRemark);
								}
                                                                if (hmumpircoachMatchRemark != null) {
									vumpircoachMatchRemark.add(hmumpircoachMatchRemark);
								}
								hmMatchFeedback = new HashMap<String, Integer>();
                                                                hmUmpireCoachMatchFeedback = new HashMap<String, Integer>();
                                                                hmMatchRemark= new HashMap<String, String>();
                                                                 hmumpircoachMatchRemark= new HashMap<String, String>();
							}
							hmMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest
									.getInt("score"));
                                                        hmMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest
									.getString("remark"));
                                                        hmUmpireCoachMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest
									.getInt("umpirerate"));
                                                        hmumpircoachMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest
									.getString("umpirecoachremark"));
                                                        
							if (!questions.contains(crsObjMtWiseUmpSelfAssest.getString("description"))) {
								questions.add(crsObjMtWiseUmpSelfAssest.getString("description"));
							}					
						}
						vMatchFeedBack.add(hmMatchFeedback);
                                                vUmpireCoachMatchFeedBack.add(hmUmpireCoachMatchFeedback);
                                                vMatchRemark.add(hmMatchRemark);
                                                vumpircoachMatchRemark.add(hmumpircoachMatchRemark);
                                                teams.add(matchName);
                                                umpie1Name.add(umpire);
                                                umpie2Name.add(coach);
					}       
		
				} catch (Exception e) {
                                    
					System.out.println(e);
				}
				System.out.println("vMatchFeedBack " + vMatchFeedBack);
				System.out.println("questions " + questions);
				System.out.println("matches " + teams);
                                umpirename = umpie1Name.get(0);
			}
		
%>
<div>
<INPUT type="hidden" name="umpireId" id="umpireId" value="<%=umpireId%>">
<INPUT type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">
<table width="100%" align="left" border="1">
<tr>
    <td width="100%" align="left">
        <DIV id="umpireMatchReportResults" align="left" STYLE="overflow:auto">
        <table align="left" border="0" width="70%">
        <tr>
            <td align="left">
<%          if(serverMessageForUmpire != null && !serverMessageForUmpire.equals("")) {
%>
<%          }							
%>
            <td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="0" align="left" cellpadding="2" cellspacing="1" class="table">
                <tr class="contentDark" rowspan="3">
                    <td align="left" width="5%"><b>Questions \ Match Name </b></td>
<%                  int total_teams = teams.size();
                    if(total_teams > 0) {
                    for(int i=0; i < total_teams; i++) {
%>                  <td align="left" width="100%" >
                        <table border="1" width="100%">
                        <tr style="width:100%">
                            <td colspan="2" width="100%"><b><%=teams.get(i)%></b></td>
                        </tr>    
                        <tr>
<%                          if(reportId.equalsIgnoreCase("1")){ 
%>                          <td align="right" width="50%" nowrap ><a href="javascript:umpire(<%=i%>)" class="link"> U </a><span id="umpire<%=i%>" name="umpire<%=i%>" style="display:none">&nbsp;&nbsp; (<%=umpirename%>)</span></td>
                            <td align="right" width="50%" nowrap><a href="javascript:coach(<%=i%>)" class="link"> C </a> <span id="coach<%=i%>" name="coach<%=i%>" style="display:none">&nbsp;&nbsp;(<%=umpie2Name.get(i + 1)%>) </span></td>
<%                          }else if(reportId.equalsIgnoreCase("2")){
%>                          <td align="right" width="50%" nowrap><a href="javascript:umpire(<%=i%>)" class="link">U </a><span id="umpire<%=i%>" name="umpire<%=i%>" style="display:none" >&nbsp;&nbsp;(<%=umpirename%>)</span></td>
                            <td align="right" width="50%" nowrap><a href="javascript:coach(<%=i%>)" class="link"> C</a> <span id="coach<%=i%>" name="coach<%=i%>" style="display:none">&nbsp;&nbsp;(<%=umpie2Name.get(i + 1)%>) </span></td>
<%                          }else if(reportId.equalsIgnoreCase("3")){
%>                          <td align="right" width="50%" nowrap><a href="javascript:umpire(<%=i%>)" class="link"> U </a> <span id="umpire<%=i%>" name="umpire<%=i%>" style="display:none" >&nbsp;&nbsp;(<%=umpirename%>)</span></td>
                            <td align="right" width="50%" nowrap><a href="javascript:coach(<%=i%>)" class="link"> R </a><span id="coach<%=i%>" name="coach<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=umpie2Name.get(i + 1)%>) </span></td>
<%                          }
%>                            
                        </tr> 
                        </table>
                    </td>
<%                  }
%>                  <td align="right" width="1%">
                        <table width="100%" border="1">
                            <tr><td colspan="2" align="right" width="100%"><b>Total &nbsp;&nbsp;&nbsp;</b></td></tr>
                            <tr><td width="50%" align="right"><b>U</b></td><td width="50%" align="right" ><b>C</b></td</tr>
                        </table>
                    </td>
                </tr>
<%              LinkedList<Integer> totals = new LinkedList<Integer>();
                LinkedList<Integer> coachtotals = new LinkedList<Integer>();
                for(int i = 0; i < total_teams; i++){
                    totals.add(0);
                    coachtotals.add(0);
                }
		for(int j=0; j < questions.size(); j++) {
                    String desc = questions.get(j);
%>								
		<tr>
<%              if(reportId.equalsIgnoreCase("4") && desc.equalsIgnoreCase("Batsman Order")){
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
%>                  <td nowrap><%=desc%></td>
<%                      int sum=0;
                        int coachsum = 0;
                        for(int i = 0; i < total_teams; i++) {
                        int point = 0;
                        int coachpoint = 0;
                        if(vMatchFeedBack.get(i).containsKey(desc)){
                            point = vMatchFeedBack.get(i).get(desc);											
                        }
                        sum = sum + point;										
			totals.add(i, totals.get(i) + point);
			totals.remove(i + 1);
                        if (vMatchRemark.get(i).containsKey(desc)){
                            Remark = vMatchRemark.get(i).get(desc);											
                        }
                        if (vumpircoachMatchRemark.get(i).containsKey(desc)){
                            umpireCoachRemark = vumpircoachMatchRemark.get(i).get(desc);											
                        }
                        if(vUmpireCoachMatchFeedBack.get(i).containsKey(desc)){
                            coachpoint = vUmpireCoachMatchFeedBack.get(i).get(desc);											
                        }
                         coachsum = coachsum + coachpoint;										
			coachtotals.add(i, coachtotals.get(i) + coachpoint);
			coachtotals.remove(i + 1);
%>                      <td>
                        <table width="100%">
                        <tr>
<%                          if(flag){
                                flag = false;
                                if(point==1){
                                    BatOrder="Opner";
                                }else{
                                    BatOrder="Middle";
                                }
%>                          <td><a class="link"><b><%=BatOrder%></b></a></td>                                                                                                   
<%                          }else if(batFlag){
                                batFlag = false;
                                if(point==1){
                                    BatType="Left handed";
                                }else{
                                    BatType="Right handed";
                                }
%>                          <td nowrap><a class="link"><b><%=BatType%></b></a></td>                                                                                                   
<%                          }else if(runFlag){
                                runFlag = false;   
%>                          <td nowrap><a class="link"><b><%=playerRun%></b></a></td>                                                                                                   
<%                          }else{
%>                          <td width="100%">
                            <table border="0" width="100%">
                                <tr>
                                    <td align="right" width="50%"><a href="javascript:HidUnHide('<%=i + "" + j%>')" class="link"><b><font color="#B0B0B0"> <%=point%> </font></b></a></td>
                                    <td align="right" width="50%"><a href="javascript:hdUmpireCoachText('<%=i + "" + j%>')" class="link"><b><font color="#716FB0"><%=coachpoint%></font></b></a></td>
                                 </tr>
                                <tr>
                                    <td width="50%">
                                        <div id="umpireremark<%=i+""+j%>" name="umpireremark<%=i+""+j%>"  style="display:none">
                                            <textarea  class="textArea" id="umpireremark<%=i%>" name="umpireremark<%=i%>" ><%=Remark%></textarea>
                                        </div>
                                    </td>
                                    <td width="50%">
                                        <div id="umpirecoachremark<%=i+""+j%>" name="umpirecoachremark<%=i+""+j%>"  style="display:none">
                                            <textarea  class="textArea" id="umpirecoachremark<%=i%>" name="umpirecoachremark<%=i%>" ><%=umpireCoachRemark%></textarea>
                                        </div>    
                                    </td>    
                                </tr> 
                            </table>   
                            </td>
<%                          }
%>                      </tr>   
                        </table>
                        </td>
<%                      } 
%>									
                        <td width="100%">
                             <table border="1" width="100%">
                                <tr>
                                  <td align="right" width="50%"><b><font color="red" size="2.8px"><%=sum%></font></b></td>       
                                    <td align="right" width="50%"><b><font color="red" size="2.8px"><%=coachsum%></font></b></td>      
                                </tr>
                             </table>   
                       </td>
                    </tr>
<%                  } 
%>
                    <tr>
                        <td>Total</td>
<% 
                        int team_sum = 0;
                        int coach_team_sum = 0;
                        for(int i = 0; i < total_teams; i++){ %>
                        <td align="right">
                            <table border="1" width="100%">
                            <tr>
                                <td align="right" width="50%"><b><font color="#B0B0B0"><%=totals.get(i)%></font><b></td>
                                <td align="right" width="50%"><b><font color="#716FB0"><%=coachtotals.get(i)%></font><b></td>
                            </tr>
                            </table></td>
<%                      team_sum = team_sum + totals.get(i);
                        coach_team_sum = coach_team_sum + coachtotals.get(i);
                        }
%>
                        <td width="100%">
                            <table width="100%" border="1">
                            <tr>
                                <td align="right" width="50%"><b><FONT color="blue" size="3px"><%=team_sum%></FONT></b></td>
                                <td align="right" width="50%"><b><FONT color="blue" size="3px"><%=coach_team_sum%></FONT></b></td>
                            </tr>
                            </table>    
                        </td>
                    </tr>
<%                  }
%>                  </tr>
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
        <INPUT type="button" name="button" value="Back" onclick="back();" >
        </td>
    </tr>    
    </table>     
	
</div>
