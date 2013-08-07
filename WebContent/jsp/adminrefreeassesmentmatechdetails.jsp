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
        CachedRowSet displayOfficialCrs = null;
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
        String umpire1 = "";
        String umpire2 = "";
        String refereeumpire1 = "";
        String cname[] = null;
        String score_max="0";
		String refereeumpire2 = "";
		String umpireId = request.getParameter("umpireId")!=null?request.getParameter("umpireId"):"0";
		String seasonId = request.getParameter("seasonId")!=null?request.getParameter("seasonId"):"0";
         String match = request.getParameter("match")!=null?request.getParameter("match"):"0";
        String seriseId   = request.getParameter("seriseId")!=null?request.getParameter("seriseId"):"0";
        String reportId = request.getParameter("reportId")!=null?request.getParameter("reportId"):"0";
        
        LinkedList<HashMap<String, Integer>> vMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmMatchFeedback = null;
		LinkedList<HashMap<String, String>> vUmpire1FeedBack = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmUmpire1FeedBack = null;
		
		
		LinkedList<HashMap<String, Integer>> vMatchFeedBack1 = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmMatchFeedback1 = null;
		LinkedList<HashMap<String, String>> vUmpire2FeedBack = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmUmpire2FeedBack = null;
		
        
        LinkedList<HashMap<String, Integer>> vUmpireCoachMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmUmpireCoachMatchFeedback = null;
        LinkedList<HashMap<String, String>> vRefereeUmpire1FeedBack = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmRefereeUmpire1FeedBack = null;
        
        
        LinkedList<HashMap<String, Integer>> vUmpirerefreeMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmUmpirerefreeMatchFeedback = null;
		LinkedList<HashMap<String, String>> vRefereeUmpire2FeedBack = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmRefereeUmpire2FeedBack = null;
		
		
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
		  
		  vparam.add(match); // match id
		  displayOfficialCrs = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_match_official_detail", vparam, "ScoreDB");
		  vparam.removeAllElements();
		  vparam.add(umpireId);
		  vparam.add(seasonId);
		  vparam.add(seriseId);
          vparam.add("2"); // flag 2 for pertocular match
          vparam.add(match); // match id
		  
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
						if (hmUmpire1FeedBack != null) {
							vUmpire1FeedBack.add(hmUmpire1FeedBack);
						}
							if (hmUmpire2FeedBack != null) {
							vUmpire2FeedBack.add(hmUmpire2FeedBack);
						}
						
                        
                        if (hmUmpireCoachMatchFeedback != null) {
							vUmpireCoachMatchFeedBack.add(hmUmpireCoachMatchFeedback);
						}
                        if (hmUmpirerefreeMatchFeedback != null) {
							vUmpirerefreeMatchFeedBack.add(hmUmpirerefreeMatchFeedback);
						}
						if (hmRefereeUmpire1FeedBack != null) {
							vRefereeUmpire1FeedBack.add(hmRefereeUmpire1FeedBack);
						}
						if (hmRefereeUmpire2FeedBack != null) {
							vRefereeUmpire2FeedBack.add(hmRefereeUmpire2FeedBack);
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
                        
                        hmUmpire1FeedBack = new HashMap<String, String>();
                        hmUmpire2FeedBack = new HashMap<String, String>();
                        hmRefereeUmpire1FeedBack = new HashMap<String, String>();
                        hmRefereeUmpire2FeedBack = new HashMap<String, String>();
                         
                        hmMatchRemark= new HashMap<String, String>();
                        hmMatchRemark1= new HashMap<String, String>();
                        hmumpircoachMatchRemark= new HashMap<String, String>();
                        hmumpirrefreeMatchRemark= new HashMap<String, String>();
					  }
					  umpire1 = "";
					  umpire2 = "";
					  refereeumpire1 = "";
					  refereeumpire2 = "";
					  if(crsObjMtWiseUmpSelfAssest.getString("cnames")!=null){
					   cname = crsObjMtWiseUmpSelfAssest.getString("cnames").split(",");
					   score_max = crsObjMtWiseUmpSelfAssest.getString("score_max");
					
					   if(crsObjMtWiseUmpSelfAssest.getInt("score_max")>0){
						   for(int i=0;i<cname.length;i++){
						   		if(crsObjMtWiseUmpSelfAssest.getInt("score1")==(i+1)){
						   			umpire1 = cname[i];
						   		}
						   		if(crsObjMtWiseUmpSelfAssest.getInt("score2")==(i+1)){
						   			umpire2 = cname[i];
						   		}
						   		if(crsObjMtWiseUmpSelfAssest.getInt("umpire1rate")==(i+1)){
						   			refereeumpire1 = cname[i];
						   		}
						   		if(crsObjMtWiseUmpSelfAssest.getInt("umpire2rate")==(i+1)){
						   			refereeumpire2 = cname[i];
						   		}
						   } 
					   }
					  }
					  
					  
					  
					  hmMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("score1"));
					  hmUmpire1FeedBack.put(crsObjMtWiseUmpSelfAssest.getString("description"), umpire1);
                      
                      hmMatchFeedback1.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("score2"));
                      hmUmpire2FeedBack.put(crsObjMtWiseUmpSelfAssest.getString("description"), umpire2);
                      
                      hmMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("remark"));
                      hmRefereeUmpire1FeedBack.put(crsObjMtWiseUmpSelfAssest.getString("description"), refereeumpire1);
                      
                      hmMatchRemark1.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("remark2"));
                      hmRefereeUmpire2FeedBack.put(crsObjMtWiseUmpSelfAssest.getString("description"), refereeumpire2);
                     
                      hmUmpireCoachMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("umpire1rate"));
					  hmumpircoachMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("umpire1coachremark"));
                      hmUmpirerefreeMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("umpire2rate"));
					  hmumpirrefreeMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("umpire2coachremark"));
					  if (!questions.contains(crsObjMtWiseUmpSelfAssest.getString("description"))) {
						 questions.add(crsObjMtWiseUmpSelfAssest.getString("description"));
					  }					
				  }// end of while
				vMatchFeedBack.add(hmMatchFeedback);
				vUmpire1FeedBack.add(hmUmpire1FeedBack);
				
				vMatchFeedBack1.add(hmMatchFeedback1);
				vUmpire2FeedBack.add(hmUmpire2FeedBack);
				
				vUmpireCoachMatchFeedBack.add(hmUmpireCoachMatchFeedback);
                vRefereeUmpire1FeedBack.add(hmRefereeUmpire1FeedBack);
                
                vUmpirerefreeMatchFeedBack.add(hmUmpirerefreeMatchFeedback);
                vRefereeUmpire2FeedBack.add(hmRefereeUmpire2FeedBack);
              
				vMatchRemark.add(hmMatchRemark);
                vMatchRemark1.add(hmMatchRemark1);
                vumpircoachMatchRemark.add(hmumpircoachMatchRemark);
                vumpirrefreeMatchRemark.add(hmumpirrefreeMatchRemark);
                teams.add(matchName);
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
  <title>Umpire Self Assessment Report</title>
  <link rel="stylesheet" type="text/css" href="../css/menu.css">
  <link rel="stylesheet" type="text/css" href="../css/Styles.css">
  <link href="../css/form.css" rel="stylesheet" type="text/css" />
  <link href="../css/formtest.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" type="text/css" href="../css/common.css">   
  <script>
  	function displayRefree(match,refree_id,refree,role){
  		window.open("/cims/jsp/RefereeReportOnUmpires.jsp?match="+match+"&refree_id="+refree_id+"&refree="+refree+"&flag=1","refree","location=Yes,directories=Yes,status=yes,menubar=Yes,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-0)+",height="+(window.screen.availHeight-0));
  	}  	
  	function displayUmpire(match,umpire_id,umpire,role){
  		window.open("/cims/jsp/UmpiresSelfAssessment.jsp?match="+match+"&umpire_id="+umpire_id+"&umpire="+umpire+"&flag=1","umpire","location=Yes,directories=Yes,status=yes,menubar=Yes,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-0)+",height="+(window.screen.availHeight-0));	
  	}  	
  	
  </script>
</head>
<body>         
<div>
<INPUT type="hidden" name="umpireId" id="umpireId" value="<%=umpireId%>">
<INPUT type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">
<table border="0" width="100%" cellpadding="2" cellspacing="1" class="table">
<tr>
	<td width="100%" align="left">
    	<DIV id="umpireMatchReportResults" align="left" STYLE="overflow:auto;">
        <table align="left" border="0" width="100%">
        <tr>
           <td>
              <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="table">
              <tr class="contentDark" rowspan="4">
                <td align="left" width="35%"><b>Questions \ Match Name</b></td>
<%              int total_teams = teams.size();
                if(total_teams > 0) {
                for(int i=0; i < total_teams; i++) {
%>              <td align="right" width="95%" >
    	            <table  border="0" width="100%" cellpadding="2" cellspacing="1" class="table">
                    <tr align="left" style="width:100%" class="contentDark">
                       <td colspan="4"  style="width:100%" align="center"><b><%=teams.get(i)%></b></td>
                    </tr>    
<% 	
		displayOfficialCrs.beforeFirst();
		if(displayOfficialCrs!=null){
			//System.out.println("--displayOfficialCrs--"+displayOfficialCrs.size()+"for===i"+i);
			//displayOfficialCrs.moveToCurrentRow();
			//System.out.println("--displayOfficialCrs-2----"+displayOfficialCrs.size());
			while(displayOfficialCrs.next()){
				
				if(reportId.equalsIgnoreCase("3")){
%>                     
                    <tr class="contentDark">
					   <td align="center" width="25%" nowrap>
					   R (<a href="javascript:void(0);" onclick="displayRefree('<%=match %>','<%=displayOfficialCrs.getString("refree_id") %>','<%=displayOfficialCrs.getString("refree")%>','<%=displayOfficialCrs.getString("refree_role")%>')">
					   <%=displayOfficialCrs.getString("refree")%></a>)</td>
					   <td align="center" width="25%" nowrap>U1 (<a href="javascript:void(0);" onclick="displayUmpire('<%=match %>','<%=displayOfficialCrs.getString("umpire1_id") %>','<%=displayOfficialCrs.getString("umpire1")%>','<%=displayOfficialCrs.getString("umpire1_role")%>')">
					   <%=displayOfficialCrs.getString("umpire1")%></a> ) </td>
                       <td align="center" width="25%" nowrap>
                       R (<a href="javascript:void(0);" onclick="displayRefree('<%=match %>','<%=displayOfficialCrs.getString("refree_id") %>','<%=displayOfficialCrs.getString("refree")%>','<%=displayOfficialCrs.getString("refree_role")%>')">
					   <%=displayOfficialCrs.getString("refree")%></a>)</td>
                       <td align="center" width="25%" nowrap>U2(<a href="javascript:void(0);" onclick="displayUmpire('<%=match %>','<%=displayOfficialCrs.getString("umpire2_id") %>','<%=displayOfficialCrs.getString("umpire2")%>','<%=displayOfficialCrs.getString("umpire2_role")%>')">
					   <%=displayOfficialCrs.getString("umpire2")%></a> ) </td>
                   </tr>
<% 				}else{
%>					<tr class="contentDark">
					   <td align="center" width="25%" nowrap>C (<%=displayOfficialCrs.getString("umpirecoach")%>)</td>
					   <td align="center" width="25%" nowrap>U1 (<%=displayOfficialCrs.getString("umpire1")%>) </td>
                       <td align="center" width="25%" nowrap>C(<%=displayOfficialCrs.getString("umpirecoach")%>) </td>
                       <td align="center" width="25%" nowrap>U2(<%=displayOfficialCrs.getString("umpire2")%>) </td>
                   </tr>
			
<% 			//System.out.println("11111---" + displayOfficialCrs.size());	
				} 
					
			} // end of crs while
		}// end of if	
%>
                   </table>
                </td>
<%              }// end of for loop
%>           </tr>
<%           LinkedList<Integer> totals = new LinkedList<Integer>();
			 LinkedList<Integer> totals1 = new LinkedList<Integer>();
             LinkedList<Integer> coachtotals = new LinkedList<Integer>();
             LinkedList<Integer> refreetotals = new LinkedList<Integer>();
             for(int i = 0; i < total_teams; i++){
               totals.add(0);
               totals1.add(0);
               coachtotals.add(0);
               refreetotals.add(0);
             }// end of for loop
			 for(int j=0; j < questions.size(); j++) {
               String desc = questions.get(j);
%>			<tr>
               <td ><%=desc%></td>
<%             int sum=0;
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
                 if(vUmpire1FeedBack.get(i).containsKey(desc)){
                   umpire1 = vUmpire1FeedBack.get(i).get(desc);											
                }
                sum = sum + point;										
				totals.add(i, totals.get(i) + point);
				totals.remove(i + 1);
				if(vMatchFeedBack1.get(i).containsKey(desc)){
                   point1 = vMatchFeedBack1.get(i).get(desc);											
                }
                if(vUmpire2FeedBack.get(i).containsKey(desc)){
                   umpire2 = vUmpire2FeedBack.get(i).get(desc);											
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
                if(vRefereeUmpire1FeedBack.get(i).containsKey(desc)){
                   refereeumpire1 = vRefereeUmpire1FeedBack.get(i).get(desc);											
                }
                
                coachsum = coachsum + coachpoint;										
				coachtotals.add(i, coachtotals.get(i) + coachpoint);
				coachtotals.remove(i + 1);
                if (vumpirrefreeMatchRemark.get(i).containsKey(desc)){
                   umpireRefreeRemark = vumpirrefreeMatchRemark.get(i).get(desc);											
                }
                if(vUmpirerefreeMatchFeedBack.get(i).containsKey(desc)){
                  refreepoint  = vUmpirerefreeMatchFeedBack.get(i).get(desc);											
                }
                if(vRefereeUmpire2FeedBack.get(i).containsKey(desc)){
                  refereeumpire2  = vRefereeUmpire2FeedBack.get(i).get(desc);											
                }
                refreesum = refreesum + refreepoint;										
				refreetotals.add(i, refreetotals.get(i) + refreepoint);
				refreetotals.remove(i + 1);
%>              <td>
                <table border="0" width="100%" cellpadding="2" cellspacing="1" class="table">
                  <tr>
                    <td width="100%">
                      <table border="0" width="100%" cellpadding="2" cellspacing="1" class="table">
                        <tr>
                          <td align="right" width="25%"><font color="#B0B0B0"><%=point%>&nbsp;(<%=umpire1%>)</td>
	                      <td align="right" width="25%"><font color="#0099FF"><b><%=coachpoint%>&nbsp;(<%=refereeumpire1%>)</b></font></td>
						  <td align="right" width="25%"><font color="#B0B0B0"><%=point1%>&nbsp;(<%=umpire2%>)</font></td>
                          <td align="right" width="25%"><font color="#716FB0"><b><%=refreepoint%>&nbsp;(<%=refereeumpire2%>)</b></font></td>
                        </tr>
                        <tr>
                          <td width="25%">
                             <div id="umpireremark<%=i+""+j%>" name="umpireremark<%=i+""+j%>"  >
                                 <textarea  class="textArea1" id="umpireremark<%=i%>" name="umpireremark<%=i%>" cols="2"><%=Remark%></textarea>
                              </div>
                          </td>
                          <td width="25%">
                              <div id="umpirecoachremark<%=i+""+j%>" name="umpirecoachremark<%=i+""+j%>"  >
                                 <textarea  class="textArea1" id="umpirecoachremark<%=i%>" name="umpirecoachremark<%=i%>" ><%=umpireCoachRemark%></textarea>
                              </div>    
                          </td>  
                          <td width="25%">
                              <div id="umpireremark1<%=i+""+j%>" name="umpireremark1<%=i+""+j%>"  >
                                  <textarea  class="textArea1" id="umpireremark1<%=i%>" name="umpireremark1<%=i%>" ><%=Remark1%></textarea>
                              </div>
                          </td> 
                          <td width="25%">
                             <div id="umpirerefreeremark<%=i+""+j%>" name="umpirerefreeremark<%=i+""+j%>" >
                                 <textarea  class="textArea1" id="umpirerefreeremark<%=i%>" name="umpirerefreeremark<%=i%>" ><%=umpireRefreeRemark%></textarea>
                             </div>    
                          </td>    
                        </tr> 
                      </table>   
                    </td>
                  </tr>   
                </table>
                </td>
<%             }// end of total_team for loop 
%>         </tr>
<%        } 
        }
%>      </tr>
        </table>
      </td>
     </tr>
   </table>
   <br>
   <table align="center" border="0" width="70%">
   	<tr>
        <td align="center">
        <input type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">
        <input type="hidden" name="umpireId" id="umpireId" value="<%=umpireId%>">
        <input type="hidden" name="seriseId" id="seriseId" value="<%=seriseId%>">
             
        <INPUT type="button" name="button" value="Back" onclick="back();" >
        </td>
    </tr>    
    </table>     
	
</div>
</body>
</html>
<%}catch(Exception e){
	e.printStackTrace();
}	
%>
