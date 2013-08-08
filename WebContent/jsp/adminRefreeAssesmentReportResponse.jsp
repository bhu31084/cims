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
	try{	
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
        String Remark1 = null;
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
		
		LinkedList<HashMap<String, Integer>> vMatchFeedBack1 = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmMatchFeedback1 = null;
        
        LinkedList<HashMap<String, Integer>> vUmpireCoachMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmUmpireCoachMatchFeedback = null;
        
        LinkedList<HashMap<String, Integer>> vUmpirerefreeMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmUmpirerefreeMatchFeedback = null;
		
		LinkedList<HashMap<String, String>> vMatchRemark = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmMatchRemark = null;
        
        LinkedList<HashMap<String, String>> vMatchRemark1 = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmMatchRemark1 = null;
        
        LinkedList<HashMap<String, String>> vumpircoachMatchRemark = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmumpircoachMatchRemark = null;
        
        LinkedList<HashMap<String, String>> vumpirrefreeMatchRemark = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmumpirrefreeMatchRemark = null;
		
		LinkedList<String> questions = new LinkedList<String>();
		LinkedList<String> teams = new LinkedList<String>();
		LinkedList<String> matchids = new LinkedList<String>();
		LinkedList<String> umpireName1 = new LinkedList<String>();
        LinkedList<String> umpireName2 = new LinkedList<String>();
        LinkedList<String> refereeName = new LinkedList<String>();
                
        String serverMessageForUmpire = null;
		if(seasonId!= null) {
		  vparam = new Vector();
		  vparam.add(umpireId);
		  vparam.add(seasonId);
		  vparam.add(seriseId);
		  vparam.add("1"); // flag 1 for display all match
          vparam.add(""); // match id
		  
		  if(reportId.equalsIgnoreCase("3")){  
		  	crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
										"esp_dsp_matchwiseadminrefreeassessment", vparam, "ScoreDB");
            
            reportHeading ="Referee Assessment";
		 }else{
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
                           umpireName1.add(umpire);
						}
                        umpire = crsObjMtWiseUmpSelfAssest.getString("umpirename");
                        umpireName2.add(coach);
						coach = crsObjMtWiseUmpSelfAssest.getString("umpire1coachname");
                        refereeName.add(referee);
						referee = crsObjMtWiseUmpSelfAssest.getString("umpire2coachname");
                        if (hmMatchFeedback != null) {
							vMatchFeedBack.add(hmMatchFeedback);
						}
						if (hmMatchFeedback1 != null) {
							vMatchFeedBack1.add(hmMatchFeedback1);
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
						if (hmMatchRemark1 != null) {
							vMatchRemark1.add(hmMatchRemark1);
						}
                        if (hmumpircoachMatchRemark != null) {
							vumpircoachMatchRemark.add(hmumpircoachMatchRemark);
						}
                        if (hmumpirrefreeMatchRemark != null) {
							vumpirrefreeMatchRemark.add(hmumpirrefreeMatchRemark);
						}
						hmMatchFeedback = new HashMap<String, Integer>();
						hmMatchFeedback1 = new HashMap<String, Integer>();
					    hmUmpireCoachMatchFeedback = new HashMap<String, Integer>();
                        hmUmpirerefreeMatchFeedback = new HashMap<String, Integer>();
                        hmMatchRemark= new HashMap<String, String>();
                        hmMatchRemark1= new HashMap<String, String>();
                        hmumpircoachMatchRemark= new HashMap<String, String>();
                        hmumpirrefreeMatchRemark= new HashMap<String, String>();
					  }
					  hmMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("score1"));
                      hmMatchFeedback1.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("score2"));
                      hmMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("remark"));
                      hmMatchRemark1.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("remark2"));
                      hmUmpireCoachMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("umpire1rate"));
					  hmumpircoachMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("umpire1coachremark"));
                      hmUmpirerefreeMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("umpire2rate"));
					  hmumpirrefreeMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("umpire2coachremark"));
					  if (!questions.contains(crsObjMtWiseUmpSelfAssest.getString("description"))) {
						 questions.add(crsObjMtWiseUmpSelfAssest.getString("description"));
					  }					
				  }// end of while
				vMatchFeedBack.add(hmMatchFeedback);
				vMatchFeedBack1.add(hmMatchFeedback1);
                vUmpireCoachMatchFeedBack.add(hmUmpireCoachMatchFeedback);
                vUmpirerefreeMatchFeedBack.add(hmUmpirerefreeMatchFeedback);
                vMatchRemark.add(hmMatchRemark);
                vMatchRemark1.add(hmMatchRemark1);
                vumpircoachMatchRemark.add(hmumpircoachMatchRemark);
                vumpirrefreeMatchRemark.add(hmumpirrefreeMatchRemark);
                teams.add(matchName);
                matchids.add(matchid);
                umpireName2.add(coach);
                umpireName1.add(umpire);
                refereeName.add(referee);
			}       
          }catch (Exception e) {
				e.printStackTrace();
		  }
		  Umpirename = umpireName1.get(0);
		}
		
%>
<div>
<INPUT type="hidden" name="umpireId" id="umpireId" value="<%=umpireId%>">
<INPUT type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">

        <DIV id="umpireMatchReportResults" align="left" STYLE="overflow:auto;">
        <table align="left" border="0" width="100%">
        <tr>
            <td align="left">
            <td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="table">
                <tr class="contentDark" rowspan="4">
                    <td align="left" width="5%"><b>Questions \ Match Name </b></td>
<%                  int total_teams = teams.size();
                    if(total_teams > 0) {
                    for(int i=0; i < total_teams; i++) {
                        
%>                  <td align="right" width="95%" >
                        <table border="1" width="100%" >
                        <tr align="left" style="width:100%">
                            <td colspan="4"  style="width:100%" align="left"><b><a href="javascript:openmatchwindow('<%=matchids.get(i)%>','<%=umpireId%>','<%=seasonId%>','<%=seriseId%>','<%=reportId%>')" class="link"><%=teams.get(i)%></a></b></td>
                        </tr>    
                        <tr>
<%						 	if(reportId.equalsIgnoreCase("3")){							
%> 		   					<td align="right" width="25%" nowrap>
		   						 <a href="javascript:umpire(<%=i%>)" class="link" align="center"> R </a><span id="umpire<%=i%>" name="umpire<%=i%>" style="display:none" > &nbsp;&nbsp;(<%=Umpirename%>)</span>
		   					</td>
                            <td align="right" width="25%" nowrap>
                            	<a href="javascript:coach(<%=i%>)" class="link" align="center"> U1 </a> <span id="coach<%=i%>" name="coach<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=umpireName2.get(i + 1)%>) </span> 
                            </td>
                            <td align="right" width="25%" nowrap> 
                            	<a href="javascript:referee(<%=i%>)" class="link" align="center">R</a><span id="refere<%=i%>" name="refere<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=Umpirename%>) </span>
                            </td>
                             <td align="right" width="25%" nowrap> 
                            	<a href="javascript:umpir2(<%=i%>)" class="link" align="center">U2</a><span id="umpir2<%=i%>" name="umpir2<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=refereeName.get(i+1)%>) </span>
                            </td>
<%							}else{
%>							<td align="right" width="25%" nowrap>
		   						 <a href="javascript:umpire(<%=i%>)" class="link" align="center"> C </a><span id="umpire<%=i%>" name="umpire<%=i%>" style="display:none" > &nbsp;&nbsp;(<%=Umpirename%>)</span>
		   					</td>
                            <td align="right" width="25%" nowrap>
                            	<a href="javascript:coach(<%=i%>)" class="link" align="center"> U1 </a> <span id="coach<%=i%>" name="coach<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=umpireName2.get(i + 1)%>) </span> 
                            </td>
                            <td align="right" width="25%" nowrap> 
                            	<a href="javascript:referee(<%=i%>)" class="link" align="center">C</a><span id="refere<%=i%>" name="refere<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=Umpirename%>) </span>
                            </td>
                             <td align="right" width="25%" nowrap> 
                            	<a href="javascript:umpir2(<%=i%>)" class="link" align="center">U2</a><span id="umpir2<%=i%>" name="umpir2<%=i%>" style="display:none"> &nbsp;&nbsp;(<%=refereeName.get(i+1)%>) </span>
                            </td>
<%							}
%>
                        </tr> 
                        </table>
                    </td>
<%                  }
%>                 
                </tr>
<%              LinkedList<Integer> totals = new LinkedList<Integer>();
				LinkedList<Integer> totals1 = new LinkedList<Integer>();
                LinkedList<Integer> coachtotals = new LinkedList<Integer>();
                LinkedList<Integer> refreetotals = new LinkedList<Integer>();
                for(int i = 0; i < total_teams; i++){
                    totals.add(0);
                    totals1.add(0);
                    coachtotals.add(0);
                    refreetotals.add(0);
                }
				for(int j=0; j < questions.size(); j++) {
                    String desc = questions.get(j);
%>								
		<tr>
                  <td nowrap><%=desc%></td>
<%                      int sum=0;
						int sum1= 0;
                        int coachsum = 0;
                        int refreesum= 0;
                        for(int i = 0; i < total_teams; i++) {
                        int point = 0;
                        int point1 = 0;	
                        int coachpoint = 0;
                        int refreepoint = 0;
                        if(vMatchFeedBack.get(i).containsKey(desc)){
                            point = vMatchFeedBack.get(i).get(desc);											
                        }
                        sum = sum + point;										
						totals.add(i, totals.get(i) + point);
						totals.remove(i + 1);
						 if(vMatchFeedBack1.get(i).containsKey(desc)){
                            point1 = vMatchFeedBack1.get(i).get(desc);											
                        }
                        sum1 = sum1 + point1;										
						totals1.add(i, totals1.get(i) + point1);
						totals1.remove(i + 1);
						
                        if (vMatchRemark.get(i).containsKey(desc)){
                            Remark = vMatchRemark.get(i).get(desc);											
                        }
                         if (vMatchRemark1.get(i).containsKey(desc)){
                            Remark1 = vMatchRemark1.get(i).get(desc);											
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
                                    <td align="right" width="25%"><a href="javascript:HidUnHide('<%=i+""+j%>')" class="link"><font color="#B0B0B0"><%=point%></font></a></td>
	                                <td align="right" width="25%"><a href="javascript:hdUmpireCoachText('<%=i+""+j%>')" class="link"><font color="#0099FF"><b><%=coachpoint%></b></font></a></td>
									<td align="right" width="25%"><a href="javascript:HidUnHide1('<%=i+""+j%>')" class="link"><font color="#B0B0B0"><%=point1%></font></a></td>
                                    <td align="right" width="25%"><a href="javascript:hdUmpireRefreeText('<%=i+""+j%>')" class="link"><font color="#716FB0"><b><%=refreepoint%></b></font></a></td>
                                 </tr>
                                <tr>
                                    <td width="25%">
                                        <div id="umpireremark<%=i+""+j%>" name="umpireremark<%=i+""+j%>"  style="display:none">
                                            <textarea  class="textArea" id="umpireremark<%=i%>" name="umpireremark<%=i%>" ><%=Remark%></textarea>
                                        </div>
                                    </td>
                                    <td width="25%">
                                        <div id="umpirecoachremark<%=i+""+j%>" name="umpirecoachremark<%=i+""+j%>"  style="display:none">
                                            <textarea  class="textArea" id="umpirecoachremark<%=i%>" name="umpirecoachremark<%=i%>" ><%=umpireCoachRemark%></textarea>
                                        </div>    
                                    </td>  
                                     <td width="25%">
                                        <div id="umpireremark1<%=i+""+j%>" name="umpireremark1<%=i+""+j%>"  style="display:none">
                                            <textarea  class="textArea" id="umpireremark1<%=i%>" name="umpireremark1<%=i%>" ><%=Remark1%></textarea>
                                        </div>
                                    </td> 
                                    <td width="25%">
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
                      
                    </tr>
<%                  } 
                 }
%>                  </tr>
            </table>
            </td>
        </tr>
        <input type="hidden" name="umpireId" id="umpireId" value="<%=umpireId%>">
        <input type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">
        <input type="hidden" name="seriseId" id="seriseId" value="<%=seriseId%>">
        <input type="hidden" name="reportId" id="reportId" value="<%=reportId%>">
        <input type="hidden" name="cmbsession" id="cmbsession" value="<%=cmbsession%>">
    </table>
    
</div>
<%}catch(Exception e){
	e.printStackTrace();
}	
%>
