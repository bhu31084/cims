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
        String Umpirename = "";  
        String playerRun="0";
        String totalMatch="0";
        boolean flag = false;
        boolean batFlag = false;
        boolean runFlag = false;
        String Remark = null;
        String umpireCoachRemark = null;
        String umpireRefreeRemark = null;
		String BatType = null;
        String BatOrder = null;
        String reportHeading=null;
        String runReportId= null;
		
		String umpireId = request.getParameter("userId")!=null?request.getParameter("userId"):"0";
		String seasonId = request.getParameter("sessionId")!=null?request.getParameter("sessionId"):"0";
        String reportId = request.getParameter("reportId")!=null?request.getParameter("reportId"):"0";
		String cmbsession = request.getParameter("cmbsession")!=null?request.getParameter("cmbsession"):"0";
        String seriseId   = request.getParameter("seriseid")!=null?request.getParameter("seriseid"):"0";
        
        LinkedList<HashMap<String, Integer>> vMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmMatchFeedback = null;
        
        LinkedList<HashMap<String, Integer>> vUmpireCoachMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmUmpireCoachMatchFeedback = null;
        
        LinkedList<HashMap<String, Integer>> vUmpirerefreeMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmUmpirerefreeMatchFeedback = null;
		
		LinkedList<HashMap<String, String>> vMatchRemark = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmMatchRemark = null;
        
        LinkedList<HashMap<String, String>> vumpircoachMatchRemark = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmumpircoachMatchRemark = null;
        
        LinkedList<HashMap<String, String>> vumpirrefreeMatchRemark = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmumpirrefreeMatchRemark = null;
		
		LinkedList<String> questions = new LinkedList<String>();
		LinkedList<String> teams = new LinkedList<String>();
		LinkedList<String> umpireName = new LinkedList<String>();
        LinkedList<String> CoachName = new LinkedList<String>();
        LinkedList<String> refereeName = new LinkedList<String>();
        LinkedList<String> matchids = new LinkedList<String>();
        String serverMessageForUmpire = null;
		if(seasonId!= null) {
		  vparam = new Vector();
		  vparam.add(umpireId);
		  vparam.add(seasonId);
		  vparam.add(seriseId);
		   vparam.add("");
		    vparam.add("");
          if(reportId.equalsIgnoreCase("1")){        
			crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
										"esp_dsp_matchwiseadminselfassessment", vparam, "ScoreDB");
            reportHeading ="Umpire Assessment";
		  }else if(reportId.equalsIgnoreCase("2")){
		  	crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
										"esp_dsp_matchwiseadmincoachassessment", vparam, "ScoreDB");
            reportHeading ="Coach Assessment";
		  } 
		  if(crsObjMtWiseUmpSelfAssest.size() == 0) {
			 serverMessageForUmpire = "No Records Found!";
		  } 
          String matchName = "";
          String matchid = "";
          String umpire="";
          String coach = "";
          String referee = "";   
          
          try {
		 	  if(crsObjMtWiseUmpSelfAssest != null) {
		  		 while(crsObjMtWiseUmpSelfAssest.next()) {
					  if(!matchName.trim().equals(crsObjMtWiseUmpSelfAssest.getString("matchbetween").trim())) {
						if(!matchName.trim().equals("")){
						   teams.add(matchName);
						}
						matchName = crsObjMtWiseUmpSelfAssest.getString("matchbetween");
						if(!matchid.trim().equals("")){
						   matchids.add(matchid);
						}
						matchid = crsObjMtWiseUmpSelfAssest.getString("match_id");
						if(!umpire.trim().equals("")){
                           umpireName.add(umpire);
						}
                        umpire = crsObjMtWiseUmpSelfAssest.getString("umpirename");
                        CoachName.add(coach);
						coach = crsObjMtWiseUmpSelfAssest.getString("umpirecoachname");
                        refereeName.add(referee);
						referee = crsObjMtWiseUmpSelfAssest.getString("refereename");
                        if (hmMatchFeedback != null) {
							vMatchFeedBack.add(hmMatchFeedback);
						}
                        if (hmUmpireCoachMatchFeedback != null) {
							vUmpireCoachMatchFeedBack.add(hmUmpireCoachMatchFeedback);
						}
                        if (hmUmpirerefreeMatchFeedback != null) {
							vUmpirerefreeMatchFeedBack.add(hmUmpirerefreeMatchFeedback);
						}
                        if (hmMatchRemark != null) {
							vMatchRemark.add(hmMatchRemark);
						}
                        if (hmumpircoachMatchRemark != null) {
							vumpircoachMatchRemark.add(hmumpircoachMatchRemark);
						}
                        if (hmumpirrefreeMatchRemark != null) {
							vumpirrefreeMatchRemark.add(hmumpirrefreeMatchRemark);
						}
						hmMatchFeedback = new HashMap<String, Integer>();
                        hmUmpireCoachMatchFeedback = new HashMap<String, Integer>();
                        hmUmpirerefreeMatchFeedback = new HashMap<String, Integer>();
                        hmMatchRemark= new HashMap<String, String>();
                        hmumpircoachMatchRemark= new HashMap<String, String>();
                        hmumpirrefreeMatchRemark= new HashMap<String, String>();
					  }
					  hmMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("score"));
                      hmMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("remark"));
                      hmUmpireCoachMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("umpirerate"));
					  hmumpircoachMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("umpirecoachremark"));
                      hmUmpirerefreeMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("refreerate"));
					  hmumpirrefreeMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("refreeremark"));
					  if (!questions.contains(crsObjMtWiseUmpSelfAssest.getString("description"))) {
						 questions.add(crsObjMtWiseUmpSelfAssest.getString("description"));
					  }					
				  }// end of while
				vMatchFeedBack.add(hmMatchFeedback);
                vUmpireCoachMatchFeedBack.add(hmUmpireCoachMatchFeedback);
                vUmpirerefreeMatchFeedBack.add(hmUmpirerefreeMatchFeedback);
                vMatchRemark.add(hmMatchRemark);
                vumpircoachMatchRemark.add(hmumpircoachMatchRemark);
                vumpirrefreeMatchRemark.add(hmumpirrefreeMatchRemark);
                teams.add(matchName);
                matchids.add(matchid);
                CoachName.add(coach);
                umpireName.add(umpire);
                refereeName.add(referee);
			}       
          }catch (Exception e) {
				e.printStackTrace();
		  }
		  Umpirename = umpireName.get(0);
		}
		
%>
<div>
<INPUT type="hidden" name="umpireId" id="umpireId" value="<%=umpireId%>">
<INPUT type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">
<table width="100%" border="1">
<tr>
    <td width="100%" align="left">
        <DIV id="umpireMatchReportResults" align="left" STYLE="overflow:auto;">
        <table align="left" border="0" width="100%">
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
                <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="table">
                <tr class="contentDark" rowspan="3">
                    <td align="left" width="5%"><b>Questions \ Match Name </b></td>
<%                  int total_teams = teams.size();
                    if(total_teams > 0) {
                    for(int i=0; i < total_teams; i++) {
                        
%>                  <td align="right" width="95%" >
                        <table border="1" width="100%">
                        <tr align="left" style="width:100%">
                            <td colspan="3"  style="width:100%" align="left"><b><a href="javascript:openmatchwindow('<%=matchids.get(i)%>','<%=umpireId%>','<%=seasonId%>','<%=seriseId%>','<%=reportId%>')" class="link"><%=teams.get(i)%></a></b></td>
                        </tr>    
                        <tr>
<%                          if(reportId.equalsIgnoreCase("2")){ 
%>                          <td align="right" width="33%" nowrap> <a href="javascript:umpire(<%=i%>)" class="link" > C </a><span id="umpire<%=i%>" name="umpire<%=i%>" style="display:none" > &nbsp;&nbsp;(<%=Umpirename%>)</span></td>
                            <td align="right" width="33%" nowrap><a href="javascript:coach(<%=i%>)" class="link"> U </a> <span id="coach<%=i%>" name="coach<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=CoachName.get(i + 1)%>) </span> </td>
                            <td align="right" width="33%" nowrap> <a href="javascript:referee(<%=i%>)" class="link">&nbsp;</a><span id="refere<%=i%>" name="refere<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=refereeName.get(i+1)%>) </span></td>
<%                          }else if(reportId.equalsIgnoreCase("1")){
%>      					<td align="right" width="33%" nowrap> <a href="javascript:umpire(<%=i%>)" class="link" > U </a><span id="umpire<%=i%>" name="umpire<%=i%>" style="display:none" > &nbsp;&nbsp;(<%=Umpirename%>)</span></td>
                            <td align="right" width="33%" nowrap><a href="javascript:coach(<%=i%>)" class="link"> C </a> <span id="coach<%=i%>" name="coach<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=CoachName.get(i + 1)%>) </span> </td>
                            <td align="right" width="33%" nowrap> <a href="javascript:referee(<%=i%>)" class="link">R</a><span id="refere<%=i%>" name="refere<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=refereeName.get(i+1)%>) </span> </td>
<%							}else if(reportId.equalsIgnoreCase("3")){ 
%>      					<td align="right" width="33%" nowrap> <a href="javascript:umpire(<%=i%>)" class="link" > R </a><span id="umpire<%=i%>" name="umpire<%=i%>" style="display:none" > &nbsp;&nbsp;(<%=Umpirename%>)</span></td>
                            <td align="right" width="33%" nowrap><a href="javascript:coach(<%=i%>)" class="link"> U </a> <span id="coach<%=i%>" name="coach<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=CoachName.get(i + 1)%>) </span> </td>
                            <td align="right" width="33%" nowrap> <a href="javascript:referee(<%=i%>)" class="link">&nbsp;</a><span id="refere<%=i%>" name="refere<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=refereeName.get(i+1)%>) </span> </td>
<%							}
%>                                              
                        </tr> 
                        </table>
                    </td>
<%                  }
%>                  <td align="right" width="10%">
                        <table width="100%" border="0">
                            <tr><td colspan="3" align="center" width="100%"><b> Total </b></td></tr>
                            <tr>
<%								if(reportId.equalsIgnoreCase("1")){
%>
                                <td width="33%" align="right" valign="bottom"><b>U</b></td>
                                <td width="33%" align="right" valign="bottom"><b>C</b></td>
                                <td width="34%" align="right" valign="bottom"><b>R</b></td>
<%								}else if(reportId.equalsIgnoreCase("2")){
%>                              <td width="33%" align="right" valign="bottom"><b>C</b></td>
                                <td width="33%" align="right" valign="bottom"><b>U</b></td>
                                <td width="34%" align="right" valign="bottom"><b>&nbsp;</b></td>
<%								}else if(reportId.equalsIgnoreCase("3")){
%>                              <td width="33%" align="right" valign="bottom"><b>R</b></td>
                                <td width="33%" align="right" valign="bottom"><b>U</b></td>
                                <td width="34%" align="right" valign="bottom"><b>&nbsp;</b></td>
<%								}
%>                                
                                  
                            </tr>
                        </table>
                    </td>
                </tr>
<%              LinkedList<Integer> totals = new LinkedList<Integer>();
                LinkedList<Integer> coachtotals = new LinkedList<Integer>();
                LinkedList<Integer> refreetotals = new LinkedList<Integer>();
                for(int i = 0; i < total_teams; i++){
                    totals.add(0);
                    coachtotals.add(0);
                    refreetotals.add(0);
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
                        int refreesum= 0;
                        for(int i = 0; i < total_teams; i++) {
                        int point = 0;
                        int coachpoint = 0;
                        int refreepoint = 0;
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
                        
                        if (vumpirrefreeMatchRemark.get(i).containsKey(desc)){
                            umpireRefreeRemark = vumpirrefreeMatchRemark.get(i).get(desc);											
                        }
                        if(vUmpirerefreeMatchFeedBack.get(i).containsKey(desc)){
                            refreepoint = vUmpirerefreeMatchFeedBack.get(i).get(desc);											
                        }
                        refreesum = refreesum + refreepoint;										
						refreetotals.add(i, refreetotals.get(i) + refreepoint);
						refreetotals.remove(i + 1);
                        
                        
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
                                    <td align="right" width="33%"><a href="javascript:HidUnHide('<%=i+""+j%>')" class="link"><font color="#B0B0B0"><%=point%></font></a></td>
<%									if(reportId.equalsIgnoreCase("1")||reportId.equalsIgnoreCase("2") || reportId.equalsIgnoreCase("3") ){ 	
%>                                  <td align="right" width="33%"><a href="javascript:hdUmpireCoachText('<%=i+""+j%>')" class="link"><font color="#0099FF"><b><%=coachpoint%></b></font></a></td>
<%									}else{
%>									<td align="right" width="33%"></td>
<%									}
%>
<%									if(reportId.equalsIgnoreCase("1")||reportId.equalsIgnoreCase("6")){ 	
%>                                  <td align="right" width="33%"><a href="javascript:hdUmpireRefreeText('<%=i+""+j%>')" class="link"><font color="#716FB0"><b><%=refreepoint%></b></font></a></td>
<%									}else{
%>                                  <td align="right" width="33%">&nbsp;</td>
<%									}
%>  

                                 </tr>
                                <tr>
                                    <td width="33%">
                                        <div id="umpireremark<%=i+""+j%>" name="umpireremark<%=i+""+j%>"  style="display:none">
                                            <textarea  class="textArea" id="umpireremark<%=i%>" name="umpireremark<%=i%>" ><%=Remark%></textarea>
                                        </div>
                                    </td>
                                    <td width="33%">
                                        <div id="umpirecoachremark<%=i+""+j%>" name="umpirecoachremark<%=i+""+j%>"  style="display:none">
                                            <textarea  class="textArea" id="umpirecoachremark<%=i%>" name="umpirecoachremark<%=i%>" ><%=umpireCoachRemark%></textarea>
                                        </div>    
                                    </td>   
                                    <td width="33%">
                                        <div id="umpirerefreeremark<%=i+""+j%>" name="umpirerefreeremark<%=i+""+j%>"  style="display:none">
                                            <textarea  class="textArea" id="umpirerefreeremark<%=i%>" name="umpirerefreeremark<%=i%>" ><%=umpireRefreeRemark%></textarea>
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
<%									if(reportId.equalsIgnoreCase("1")){					
%>					                <td align="right" width="33%"><b><FONT color="red" SIZE="2px"><%=sum%></font></b></td>
                                    <td align="right" width="33%"><b><FONT color="red" SIZE="2px"><%=coachsum%></font></b></td>
                                    <td align="right" width="33%"><b><FONT color="red" SIZE="2px"><%=refreesum%></font></b></td>
<%									}else if (reportId.equalsIgnoreCase("2")){
%>                                  <td align="right" width="33%"><b><FONT color="red" SIZE="2px"><%=sum%></font></b></td>
                                    <td align="right" width="33%"><b><FONT color="red" SIZE="2px"><%=coachsum%></font></b></td>
<%--                                    <td align="right" width="33%"><b><FONT color="red" SIZE="2px">&nbsp;</font></b></td> --%>
<%									}else{
%>									<td align="right" width="33%"><b><FONT color="red" SIZE="2px"><%=sum%></font></b></td>
                                    <td align="right" width="33%"><b><FONT color="red" SIZE="2px"><%=coachsum%></font></b></td>
<%--                                    <td align="right" width="33%"><b><FONT color="red" SIZE="2px"></font></b></td> --%>
<%									}
%>
                                </tr>
                             </table>   
                       </td>
                    </tr>
<%                  } 
%>
                    <tr>
                        <td><b>Total</b></td>
<% 
                        int team_sum = 0;
                        int coach_team_sum = 0;
                        int refree_team_sum = 0;
                        for(int i = 0; i < total_teams; i++){ %>
                        <td><table border="1" width="100%">
                            <tr>
<%								if(reportId.equalsIgnoreCase("1")){					
%>	                            <td align="right" width="33%"><b><font color="#B0B0B0"><%=totals.get(i)%></font><b></td>
                                <td align="right" width="33%"><font color="#0099FF"><%=coachtotals.get(i)%></font></td>
                                <td align="right"  width="33%"><b><font color="#716FB0"><%=refreetotals.get(i)%></font><b></td></tr></table></td>
<%								}else if(reportId.equalsIgnoreCase("2")){
%>								<td align="right" width="33%"><b><font color="#B0B0B0"><%=totals.get(i)%></font><b></td>
                                <td align="right" width="33%"><font color="#0099FF"><%=coachtotals.get(i)%></font></td>
                                <td align="right"  width="33%"><b><font color="#716FB0"></font><b></td></tr></table></td>	
<%								}else{
%>								<td align="right" width="33%"><b><font color="#B0B0B0"><%=totals.get(i)%></font><b></td>
                                <td align="right" width="33%"><font color="#0099FF"><%=coachtotals.get(i)%></font></td>
                                <td align="right"  width="33%"><b><font color="#716FB0"></font><b></td></tr></table></td>	
<%								}
%>
                                
<%                      team_sum = team_sum + totals.get(i);
                        coach_team_sum = coach_team_sum + coachtotals.get(i);
                        refree_team_sum = refree_team_sum + refreetotals.get(i);
                        }
%>
                        <td width="100%">
                            <table width="100%" border="1" >
                            <tr>
<%								if(reportId.equalsIgnoreCase("1")){					
%>	                            <td align="right" width="33%"><b><FONT color="blue" SIZE="3.5px"><%=team_sum%></FONT></b></td>
                                <td align="right" width="33%"><b><FONT color="blue" SIZE="3.5px"><%=coach_team_sum%></FONT></b></td>
                                <td align="right" width="33%"><b><FONT color="blue" SIZE="3.5px"><%=refree_team_sum%></FONT></b></td>
<%								}else if(reportId.equalsIgnoreCase("2")){
%>								<td align="right" width="33%"><b><FONT color="blue" SIZE="3.5px"><%=team_sum%></FONT></b></td>
                                <td align="right" width="33%"><b><FONT color="blue" SIZE="3.5px"><%=coach_team_sum%></FONT></b></td>
                                <td align="right" width="33%"><b><FONT color="blue" SIZE="3.5px"></FONT></b></td>
<%								}else{
%>								<td align="right" width="33%"><b><FONT color="blue" SIZE="3.5px"><%=team_sum%></FONT></b></td>
                                <td align="right" width="33%"><b><FONT color="blue" SIZE="3.5px"><%=coach_team_sum%></FONT></b></td>
                                <td align="right" width="33%"><b><FONT color="blue" SIZE="3.5px"></FONT></b></td>
<%								}
%>
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
        </td>
    </tr>    
    </table>     
	
</div>
