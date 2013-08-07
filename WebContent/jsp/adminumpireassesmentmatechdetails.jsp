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
        CachedRowSet displayOfficialCrs = null;
		Vector vparam = null;
        Vector vMatchparam = new Vector();
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		//String umpire_name = "";
		//String season_name = "";
        String Umpirename = "";  
        String playerRun="0";
        String totalMatch="0";
        String score_max="0";
        String umpirename="";
		String umpircoachename="";
		String umpirerefereename="";
        String cname[] = null;
        String cnameremark = null;
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
		
		String umpireId = request.getParameter("umpireId")!=null?request.getParameter("umpireId"):"0";
		String seasonId = request.getParameter("seasonId")!=null?request.getParameter("seasonId"):"0";
         String match = request.getParameter("match")!=null?request.getParameter("match"):"0";
        String seriseId   = request.getParameter("seriseId")!=null?request.getParameter("seriseId"):"0";
        String reportId = request.getParameter("reportId")!=null?request.getParameter("reportId"):"0";
       
        LinkedList<HashMap<String, Integer>> vMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmMatchFeedback = null;
        LinkedList<HashMap<String, String>> vMatchUmpireCname = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmMatchUmpireCname = null;
      
        LinkedList<HashMap<String, Integer>> vUmpireCoachMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmUmpireCoachMatchFeedback = null;
        LinkedList<HashMap<String, String>> vMatchUmpireCoachCname = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmMatchUmpireCoachCname = null;
        
        LinkedList<HashMap<String, Integer>> vUmpirerefreeMatchFeedBack = new LinkedList<HashMap<String, Integer>>();
		HashMap<String, Integer> hmUmpirerefreeMatchFeedback = null;
		LinkedList<HashMap<String, String>> vMatchUmpirerefreeCname = new LinkedList<HashMap<String, String>>();
        HashMap<String, String> hmMatchUmpirerefreeCname = null;
		
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
          crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure(
										"esp_dsp_matchwiseadminselfassessment", vparam, "ScoreDB");
          reportHeading ="Umpire Assessment";
		  
		  if(crsObjMtWiseUmpSelfAssest.size() == 0) {
			 serverMessageForUmpire = "No Records Found!";
		  } 
          String matchName = "";
          String umpire="";
          String coach = "";
          String referee = "";   
          
          try {
		 	  if(crsObjMtWiseUmpSelfAssest != null) {
		  		 while(crsObjMtWiseUmpSelfAssest.next()) {
		  			if(match.equalsIgnoreCase(crsObjMtWiseUmpSelfAssest.getString("match_id").trim())){ 
					  if(!matchName.trim().equals(crsObjMtWiseUmpSelfAssest.getString("matchbetween").trim())) {
						if(!matchName.trim().equals("")){
						   teams.add(matchName);
						}
						matchName = crsObjMtWiseUmpSelfAssest.getString("matchbetween");
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
						if (hmMatchUmpireCname != null) {
							vMatchUmpireCname.add(hmMatchUmpireCname);
						}
                        
                        if (hmUmpireCoachMatchFeedback != null) {
							vUmpireCoachMatchFeedBack.add(hmUmpireCoachMatchFeedback);
						}
						if (hmMatchUmpireCoachCname != null) {
							vMatchUmpireCoachCname.add(hmMatchUmpireCoachCname);
						}
						
                        if (hmUmpirerefreeMatchFeedback != null) {
							vUmpirerefreeMatchFeedBack.add(hmUmpirerefreeMatchFeedback);
						}
						if (hmMatchUmpirerefreeCname != null) {
							vMatchUmpirerefreeCname.add(hmMatchUmpirerefreeCname);
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
						hmMatchUmpireCname= new HashMap<String, String>();
                        
                        hmUmpireCoachMatchFeedback = new HashMap<String, Integer>();
                        hmMatchUmpireCoachCname= new HashMap<String, String>();
                        
                        hmUmpirerefreeMatchFeedback = new HashMap<String, Integer>();
                        hmMatchUmpirerefreeCname= new HashMap<String, String>();
                        
                        
                        hmMatchRemark= new HashMap<String, String>();
                        hmumpircoachMatchRemark= new HashMap<String, String>();
                        hmumpirrefreeMatchRemark= new HashMap<String, String>();
					  }
					  umpirename = "";
					  umpircoachename = "";
					  umpirerefereename = "";
					  if(crsObjMtWiseUmpSelfAssest.getString("cnames")!=null){
					  cname = crsObjMtWiseUmpSelfAssest.getString("cnames").split(",");
					  score_max = crsObjMtWiseUmpSelfAssest.getString("score_max");
					  
					  if(crsObjMtWiseUmpSelfAssest.getInt("score_max")>0){
						   for(int i=0;i<cname.length;i++){
						   		if(crsObjMtWiseUmpSelfAssest.getInt("score")==(i+1)){
						   			umpirename = cname[i];
						   		}
						   		if(crsObjMtWiseUmpSelfAssest.getInt("umpirerate")==(i+1)){
						   			umpircoachename = cname[i];
						   		}
						   		if(crsObjMtWiseUmpSelfAssest.getInt("refreerate")==(i+1)){
						   			umpirerefereename = cname[i];
						   		}
						   } 
					  }
					  }	
					  hmMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("score"));
                      hmMatchUmpireCname.put(crsObjMtWiseUmpSelfAssest.getString("description"), umpirename);
                      hmMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("remark"));
                      
                      hmUmpireCoachMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("umpirerate"));
					  hmumpircoachMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("umpirecoachremark"));
                      hmMatchUmpireCoachCname.put(crsObjMtWiseUmpSelfAssest.getString("description"), umpircoachename);
                      
                      hmUmpirerefreeMatchFeedback.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getInt("refreerate"));
					  hmumpirrefreeMatchRemark.put(crsObjMtWiseUmpSelfAssest.getString("description"), crsObjMtWiseUmpSelfAssest.getString("refreeremark"));
					  hmMatchUmpirerefreeCname.put(crsObjMtWiseUmpSelfAssest.getString("description"), umpirerefereename);
					  if (!questions.contains(crsObjMtWiseUmpSelfAssest.getString("description"))) {
						 questions.add(crsObjMtWiseUmpSelfAssest.getString("description"));
					  }	
		  			}//	  
				  }// end of while
				vMatchFeedBack.add(hmMatchFeedback);
				vMatchUmpireCname.add(hmMatchUmpireCname);
				
                vUmpireCoachMatchFeedBack.add(hmUmpireCoachMatchFeedback);
                vMatchUmpireCoachCname.add(hmMatchUmpireCoachCname);
                
                vUmpirerefreeMatchFeedBack.add(hmUmpirerefreeMatchFeedback);
                vMatchUmpirerefreeCname.add(hmMatchUmpirerefreeCname);
                 
                vMatchRemark.add(hmMatchRemark);
                vumpircoachMatchRemark.add(hmumpircoachMatchRemark);
                vumpirrefreeMatchRemark.add(hmumpirrefreeMatchRemark);
                teams.add(matchName);
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
  	function displayUmpCoach(match,umpcoach_id,umpcoach,role){
  		window.open("/cims/jsp/UmpireReport.jsp?match="+match+"&umpcoach_id="+umpcoach_id+"&umpcoach="+umpcoach+"&flag=1","umpirecoach","location=Yes,directories=Yes,status=yes,menubar=Yes,scrollbars=Yes,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-0)+",height="+(window.screen.availHeight-0));	
  	} 	
  	
  </script>
</head>
<body > 
<div>
<INPUT type="hidden" name="umpireId" id="umpireId" value="<%=umpireId%>">
<INPUT type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">
<table border="0" width="100%" cellpadding="2" cellspacing="1" class="table">
<tr>
  <td width="100%" align="left">
  	<DIV id="umpireMatchReportResults" align="left" STYLE="overflow:auto;">
      <table border="0" width="100%" cellpadding="2" cellspacing="1" class="table">
        <tr>
          <td align="left">
          <td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="table">
       	     <tr class="contentDark" rowspan="3">
               <td align="left" width="5%"><b>Questions \ Match Name </b></td>
<%             int total_teams = teams.size();
               if(total_teams > 0) {
               for(int i=0; i < total_teams; i++) {
%>             <td align="right" width="95%" >
                  <table width="100%" border="1" align="left" cellpadding="0" cellspacing="0" class="table">
                    <tr align="left" style="width:100%" class="contentDark">
                       <td colspan="3"  style="width:100%" align="center"><b><%=teams.get(i)%></b></td>
                    </tr>   
                    <% 	if(displayOfficialCrs!=null){
                    	displayOfficialCrs.beforeFirst();
                    	while(displayOfficialCrs.next()){
							
					%> 
                    <tr class="contentDark">
                    <%if(Umpirename != null){ %>
	 				   <td align="center" width="33%" nowrap> <a href="javascript:void(0);"  onclick="displayUmpire('<%=match %>','<%=displayOfficialCrs.getString("umpire1_id") %>','<%=displayOfficialCrs.getString("umpire1")%>','<%=displayOfficialCrs.getString("umpire1_role")%>')" class="link" > U &nbsp;&nbsp;(<%=Umpirename%>)</a></td>
	 			    <%}else{ %>
	 			    <td>&nbsp;</td> 
	 			    <%} %>
	 			    <%if(displayOfficialCrs.getString("umpirecoach") != null){ %>
                       <td align="center" width="33%" nowrap><a href="javascript:void(0);"  onclick="displayUmpCoach('<%=match %>','<%=displayOfficialCrs.getString("umpirecoach_id") %>','<%=displayOfficialCrs.getString("umpirecoach") == null ? "":displayOfficialCrs.getString("umpirecoach")%>','<%=displayOfficialCrs.getString("umpirecoach_role") == null ? "":displayOfficialCrs.getString("umpirecoach_role")%>')" class="link"> C </a>&nbsp;&nbsp;(<%=displayOfficialCrs.getString("umpirecoach") == null ? "" : displayOfficialCrs.getString("umpirecoach")%>)</td>
                    <%}else{ %>
	 			    <td>&nbsp;</td> 
	 			    <%}%> 
	 			    <%if(displayOfficialCrs.getString("refree") != null){ %>
	 			 
                       <td align="center" width="33%" nowrap> <a href="javascript:void(0);"  onclick="displayRefree('<%=match %>','<%=displayOfficialCrs.getString("refree_id") %>','<%=displayOfficialCrs.getString("refree")%>','<%=displayOfficialCrs.getString("refree_role")%>')" class="link">R&nbsp;&nbsp;(<%=displayOfficialCrs.getString("refree")%>)</a></td>
                   <%}else{ %>
	 			    <td>&nbsp;</td> 
	 			    <%}%>
                    </tr> 
                    <%}
					} %>
                  </table>
               </td>
<%             }
%>           </tr>
<%            LinkedList<Integer> totals = new LinkedList<Integer>();
              LinkedList<Integer> coachtotals = new LinkedList<Integer>();
              LinkedList<Integer> refreetotals = new LinkedList<Integer>();
              for(int i = 0; i < total_teams; i++){
                 totals.add(0);
                 coachtotals.add(0);
                 refreetotals.add(0);
              }
              for(int j=0; j < questions.size(); j++) {
                 String desc = questions.get(j);
%>			 <tr>
               <td nowrap><%=desc%></td>
<%             int sum=0;
               int coachsum = 0;
               int refreesum= 0;
               for(int i = 0; i < total_teams; i++) {
                  int point = 0;
                  int coachpoint = 0;
                  int refreepoint = 0;
                 
                  
                  if(vMatchFeedBack.get(i).containsKey(desc)){
                    point = vMatchFeedBack.get(i).get(desc);											
                  }
                  if(vMatchUmpireCname.get(i).containsKey(desc)){
                    umpirename = vMatchUmpireCname.get(i).get(desc);											
                  }
                  sum = sum + point;										
				  totals.add(i, totals.get(i) + point);
				  totals.remove(i + 1);
                  if (vMatchRemark.get(i).containsKey(desc)){
                  Remark = vMatchRemark.get(i).get(desc);											
              	  }
	              if(vumpircoachMatchRemark.get(i).containsKey(desc)){
	                umpireCoachRemark = vumpircoachMatchRemark.get(i).get(desc);											
	              }
	              if(vUmpireCoachMatchFeedBack.get(i).containsKey(desc)){
	                 coachpoint = vUmpireCoachMatchFeedBack.get(i).get(desc);											
	              }
	              if(vMatchUmpireCoachCname.get(i).containsKey(desc)){
	                 umpircoachename = vMatchUmpireCoachCname.get(i).get(desc);											
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
	              if(vMatchUmpirerefreeCname.get(i).containsKey(desc)){
	                  umpirerefereename = vMatchUmpirerefreeCname.get(i).get(desc);											
	              }
              refreesum = refreesum + refreepoint;										
			  refreetotals.add(i, refreetotals.get(i) + refreepoint);
			  refreetotals.remove(i + 1);
%>            <td>
                <table width="100%" class="tableBorderZero">
                <tr>
                   <td width="100%">
                     <table border="0" width="100%">
                       <tr>
                         <td align="right" width="33%"><a href="javascript:HidUnHide('<%=i+""+j%>')" class="link"><font color="#B0B0B0"><%=point%>&nbsp;(&nbsp;<%=umpirename%>&nbsp;)</font></a></td>
<%						 if(reportId.equalsIgnoreCase("1")||reportId.equalsIgnoreCase("2") || reportId.equalsIgnoreCase("3") ){ 	
%>                       <td align="right" width="33%"><a href="javascript:hdUmpireCoachText('<%=i+""+j%>')" class="link"><font color="#0099FF"><b><%=coachpoint%>&nbsp;(&nbsp;<%=umpircoachename%>&nbsp;)</b></font></a></td>
<%						 }else{
%>						 <td align="right" width="33%"></td>
<%						 }
						 if(reportId.equalsIgnoreCase("1")||reportId.equalsIgnoreCase("6")){ 	
%>                       <td align="right" width="33%"><a href="javascript:hdUmpireRefreeText('<%=i+""+j%>')" class="link"><font color="#716FB0"><b><%=refreepoint%>&nbsp;(&nbsp;<%=umpirerefereename%>&nbsp;)</b></font></a></td>
<%						 }else{
%>                       <td align="right" width="33%">&nbsp;</td>
<%						 }
%>                    </tr>
                      <tr>
                        <td width="33%">
                          <div id="umpireremark<%=i+""+j%>" name="umpireremark<%=i+""+j%>">
                            <textarea  class="textAreaforassessment" id="umpireremark<%=i%>" name="umpireremark<%=i%>" ><%=Remark%></textarea>
                          </div>
                        </td>
                        <td width="33%">
                          <div id="umpirecoachremark<%=i+""+j%>" name="umpirecoachremark<%=i+""+j%>">
                             <textarea  class="textAreaforassessment" id="umpirecoachremark<%=i%>" name="umpirecoachremark<%=i%>" ><%=umpireCoachRemark%></textarea>
                          </div>    
                        </td>   
                        <td width="33%">
                           <div id="umpirerefreeremark<%=i+""+j%>" name="umpirerefreeremark<%=i+""+j%>">
                              <textarea  class="textAreaforassessment" id="umpirerefreeremark<%=i%>" name="umpirerefreeremark<%=i%>" ><%=umpireRefreeRemark%></textarea>
                           </div>    
                        </td>    
                       </tr> 
                     </table>   
                    </td>
                  </tr>   
                  </table>
                </td>
<%            } 
%>			  </tr>
<%         }}  
%>
        </table>
    	<br>
    <table align="center" border="0" width="70%">
    <tr>
        <td align="center">
        <input type="hidden" name="seasonId" id="seasonId" value="<%=seasonId%>">
        <input type="hidden" name="reportId" id="reportId" value="<%=reportId%>">
               <INPUT type="button" name="button" value="Back" onclick="back();" >
        </td>
    </tr>    
    </table>     
</div>
</body>
</html>
