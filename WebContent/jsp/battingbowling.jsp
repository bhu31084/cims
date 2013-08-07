<%--
  Created by IntelliJ IDEA.
  User: bhushanf
  Date: Aug 13, 2008
  Time: 12:01:56 PM
  To change this template use File | Settings | File Templates.
  modifyed Date:12-09-2008
--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,
                 in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
                 java.util.*,
                 java.lang.*"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>                 
                 
<% response.setHeader("Pragma", "private");
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "must-revalidate");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setDateHeader("Expires", 0);
%>
<%
        LogWriter log = new LogWriter();
	   	String	matchId = request.getParameter("matchId");
		String inningId = request.getParameter("InningId");
		String maxInningId ="";
  	  	String id = "";
		String battingteam ="";
		int totalovers = 0;
		String lastWktTotal = "";
		String remainingOver = "";
		String strikerId ="";
		int strikerrownumber =1;
		int nonstrikerrownumber = 1;
		String nonStrikerId = "";
		String bowlerStrikerId="";
		int bowlerrownumber = 1;
		String previousStrikerbowler = "";
		String remainingOvrs = "";
		boolean scorecardflag = false;
		String temp="";
	
		int lastwkt = 0;
		int team1run = 0;
		int team2run = 0;
		int remainingrun = 0;
		int rowlength = 0;
		String[] preInningId = null;
		String inning_Id = "";
		String flag ="1";
        String runs = "";
        String Srno = "";
        String result = "";
		String bye="";
		String legbye="";
		String noball ="";
		String wide ="";
		String penlaty ="";
		String extratotal ="";
		String match_type = "";
		String teamName ="";
		String intervalid = "";
		String intervalname ="";
		String intervalRemark ="";
		String intervalcount = "0";
		String firstBattingName = "";
		String secondBattingName = "";
		String reqrunflag = "false";
		String battingteamname = "";
		String bowlingteamname ="";
		String authentic="";
		String starttime ="";
		String series = "";
		String venue = "";
		String toss_winner = "";
		String hometeam ="";
		String umpire1 = "";
		String umpire2 ="";
		String umpire3 = "";
		String score1 = "";
		String score2 ="";
		String matchdate = "";
		String elected = "";
		String scorerCardTotal = "";
		String wkts = "";
		String currentover = "";
		String overrate = "";
		String overs="";
		String tournamentName 			= "";
		String matchNo 					= "";
		String zone						= "";
		String teamOne					= "";
		String teamTwo					= "";
		String toss						= "";
		String ground					= "";
		String city						= "";
		String date						= "";
		String umpireOne				= "";
		String umpireTwo				= "";
		String umpireThree				= "";
		String umpireFour				= "";
		String matchReferee				= "";
		String scorerOne				= "";
		String scorerTwo				= "";
		String captainOne				= "";
		String captainTwo				= "";
		String wicketKeeperOne			= "";
		String wicketKeeperTwo			= "";
		String decision					= "";
		String point					= "";
		String hatTrickBowler			= "";
		String victim					= "";
		String inningIdOne				= "";
		String inningIdTwo				= "";
		String inningIdThree			= "";
		String inningIdFour				= "";	
		String matchWinner				= "";
		String umpireOneAsscn    	    = "";
		String umpireTwoAsscn			= "";
		String umpireThreeAsscn			= "";
		String umpireFourAsscn			= "";
		String teamBattingFirst			= "";
		String matchRefassn				= "";
		String electedto				= "";
		String isPrint					= "";
		String result1					= "";
		String matchStatusFlag			="";
		
		
		
		int totalInningMint = 0;
		int intervalleng = 0;
		String intervalidarr[]=null;
		String intervalnamearr[]=null;
		CachedRowSet lobjCachedRowSet = null;
        CachedRowSet bowlerCachedRowSet = null;
       	CachedRowSet crs = null;
        CachedRowSet battingSummaryCachedRowSet = null;
        CachedRowSet battingscorercardCachedRowSet = null;
        CachedRowSet bowlerscoreeCachedRowSet = null;
        CachedRowSet crsInningId = null;
        CachedRowSet extrarunCachedRowSet = null;
    	CachedRowSet matchDetailCachedRowSet = null;
		CachedRowSet prematchtype = null;
		CachedRowSet overrateCachedRowSet = null;
		CachedRowSet officialScoresheetCrs = null;
		CachedRowSet strikernonstrikerCachedRowSet = null;
		CachedRowSet resultCrs = null;
		CachedRowSet intervalCachedRowSet = null;
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(matchId);
        Vector vparam = new Vector();
    	   	
    
    try {
        String total = (request.getParameter("Total") == null) ? "" : request.getParameter("Total");// These For 2nd Inning Only
        
        /*this logic for get batting table*/
      	try{
	      	vparam.add(inningId);
		    battingSummaryCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingscorercard", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();
		} catch (Exception e) {
 		   e.printStackTrace();
		}    
		/*This logic scorer card */
		try{
			vparam.add(inningId);
			vparam.add(matchId); 
		    bowlerscoreeCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_bowlingscorecard", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();		
		}catch (Exception e) {
 		   e.printStackTrace();
		}
		try{ 
			vparam.add(matchId); // // for match details
	       	vparam.add(inningId);// // for Inning details 05/10/208
	        matchDetailCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchtypedetail", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
	        while(matchDetailCachedRowSet.next()){
	        	battingteamname = matchDetailCachedRowSet.getString("battingteam");
	        	bowlingteamname = matchDetailCachedRowSet.getString("bowlingteam");
	        }
	    }catch (Exception e) {
 		   e.printStackTrace();
		}
		try{     
	        vparam.add(inningId);// // for Inning details 05/10/208
	        overrateCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_overrate", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
	       	while(overrateCachedRowSet.next()){
	       		overrate = overrateCachedRowSet.getString("oversRate");
	       	}
        }catch (Exception e) {
 		   e.printStackTrace();
		}
		vparam.add(matchId);
		 resultCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_reportresult",vparam,"ScoreDB");
		 vparam.removeAllElements();
		 if(resultCrs!=null && resultCrs.size() > 0){
			 try{
			
				while(resultCrs.next()){ 
				result1 =  resultCrs.getString("result")==null?"-":resultCrs.getString("result");
				}
			 }catch(Exception e){
				 e.printStackTrace();
				log.writeErrLog(page.getClass(),matchId,e.toString());
			 }
		 }
		
		 vparam.add(matchId);
		 officialScoresheetCrs= lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialscoresheetfortest",vparam,"ScoreDB");
		 vparam.removeAllElements();
		 if(officialScoresheetCrs!=null){
		 try{
			while (officialScoresheetCrs.next()){
				tournamentName       = officialScoresheetCrs.getString("tournament")!=null?officialScoresheetCrs.getString("tournament"):"";
				//matchNo 			 = officialScoresheetCrs.getString("match_no")!=null?officialScoresheetCrs.getString("match_no"):"";
				electedto 			 = officialScoresheetCrs.getString("electedto")!=null?officialScoresheetCrs.getString("electedto"):"";
				zone				 = officialScoresheetCrs.getString("zone")!=null?officialScoresheetCrs.getString("zone"):"";
				teamOne				 = officialScoresheetCrs.getString("team1")!=null?officialScoresheetCrs.getString("team1"):"";
				teamTwo				 = officialScoresheetCrs.getString("team2")!=null?officialScoresheetCrs.getString("team2"):"";
				toss				 = officialScoresheetCrs.getString("tosswinner")!=null?officialScoresheetCrs.getString("tosswinner"):"";
				ground				 = officialScoresheetCrs.getString("ground")!=null?officialScoresheetCrs.getString("ground"):"";
				city				 = officialScoresheetCrs.getString("city")!=null?officialScoresheetCrs.getString("city"):"";
				date				 = officialScoresheetCrs.getString("start_date")!=null?officialScoresheetCrs.getString("start_date"):"";
				matchWinner			 = officialScoresheetCrs.getString("match_winner")!=null?officialScoresheetCrs.getString("match_winner"):"";
				//result1				 = officialScoresheetCrs.getString("result")!=null?officialScoresheetCrs.getString("result"):"";
				umpireOne			 = officialScoresheetCrs.getString("umpire1")!=null?officialScoresheetCrs.getString("umpire1"):"";
				umpireTwo			 = officialScoresheetCrs.getString("umpire2")!=null?officialScoresheetCrs.getString("umpire2"):"";
				umpireThree			 = officialScoresheetCrs.getString("umpire3")!=null?officialScoresheetCrs.getString("umpire3"):"";
				umpireFour			 = officialScoresheetCrs.getString("umpire4")!=null?officialScoresheetCrs.getString("umpire4"):"";
				matchReferee		 = officialScoresheetCrs.getString("matchref")!=null?officialScoresheetCrs.getString("matchref"):"";
				scorerOne			 = officialScoresheetCrs.getString("scorer1")!=null?officialScoresheetCrs.getString("scorer1"):"";
				scorerTwo			 = officialScoresheetCrs.getString("scorer2")!=null?officialScoresheetCrs.getString("scorer2"):"";
				captainOne			 = officialScoresheetCrs.getString("captain1")!=null?officialScoresheetCrs.getString("captain1"):"";
				captainTwo			 = officialScoresheetCrs.getString("captain2")!=null?officialScoresheetCrs.getString("captain2"):"";
				wicketKeeperOne		 = officialScoresheetCrs.getString("wkeeper1")!=null?officialScoresheetCrs.getString("wkeeper1"):"";
				wicketKeeperTwo		 = officialScoresheetCrs.getString("wkeeper2")!=null?officialScoresheetCrs.getString("wkeeper2"):"";	
			    umpireOneAsscn		 = officialScoresheetCrs.getString("umpire1assn")!=null?officialScoresheetCrs.getString("umpire1assn"):"";	
				umpireTwoAsscn		 = officialScoresheetCrs.getString("umpire2assn")!=null?officialScoresheetCrs.getString("umpire2assn"):"";
			    umpireThreeAsscn	 = officialScoresheetCrs.getString("umpire3assn")!=null?officialScoresheetCrs.getString("umpire3assn"):"";
            	umpireFourAsscn		 = officialScoresheetCrs.getString("umpire4assn")!=null?officialScoresheetCrs.getString("umpire4assn"):"";
				matchRefassn		 = officialScoresheetCrs.getString("matchrefassn")!=null?officialScoresheetCrs.getString("matchrefassn"):"";
				teamBattingFirst	 = officialScoresheetCrs.getString("battingteam")!=null?officialScoresheetCrs.getString("battingteam"):"";
				point				 = officialScoresheetCrs.getString("point")!=null?officialScoresheetCrs.getString("point"):"";
			}
		}catch(Exception e){
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}finally{
			officialScoresheetCrs = null;
		 }
		}
		
		try{ 
	        vparam.add(matchId); // // for match details
	        prematchtype = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getprematchtype", vparam, "ScoreDB"); // penalties Type List
	        vparam.removeAllElements();
	        while(prematchtype.next()){
	        	series = prematchtype.getString("series");
	        	venue = prematchtype.getString("venue");
	        	toss_winner = prematchtype.getString("toss_winner");
	        	hometeam = prematchtype.getString("hometeam")==null?"":prematchtype.getString("hometeam");
	        	umpire1 = prematchtype.getString("umpire1")==null?"":prematchtype.getString("umpire1");
	        	umpire2 = prematchtype.getString("umpire2")==null?"":prematchtype.getString("umpire2");
	        	umpire3 = prematchtype.getString("umpire3")==null?"":prematchtype.getString("umpire3");
	        	score1 = prematchtype.getString("score1")==null?"":prematchtype.getString("score1");
	        	score2 = prematchtype.getString("score2")==null?"":prematchtype.getString("score2");
	        	matchdate = prematchtype.getString("matchdate")==null?"":prematchtype.getString("matchdate");        	
	        	elected = prematchtype.getString("elected")==null?"":prematchtype.getString("elected");
	        }
	    }catch (Exception e) {
 		   e.printStackTrace();
		}
		try{     
	        vparam.add(inningId);
			vparam.add(matchId); 
		    battingscorercardCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scorercard", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();	
			while(battingscorercardCachedRowSet.next()){
				scorerCardTotal = battingscorercardCachedRowSet.getString("total");
				wkts = battingscorercardCachedRowSet.getString("wkts");
				currentover = battingscorercardCachedRowSet.getString("overs");
				remainingOvrs	= battingscorercardCachedRowSet.getString("remaining");
				maxInningId		= battingscorercardCachedRowSet.getString("max_inning_id");
				matchStatusFlag = battingscorercardCachedRowSet.getString("match_status_flag");
			}
		 }catch (Exception e) {
 		   e.printStackTrace();
		 } 
		 try{	
			vparam.add(inningId);
		    strikernonstrikerCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_striker_nonstriker_batsman", vparam, "ScoreDB"); // Batsman List
		    vparam.removeAllElements();			
			while(strikernonstrikerCachedRowSet.next()){
				strikerId = strikernonstrikerCachedRowSet.getString("striker");
				nonStrikerId = strikernonstrikerCachedRowSet.getString("nonstriker");	
			}
		 }catch (Exception e) {
 		   e.printStackTrace();
		 }
		 try{ 	
			vparam.add(inningId);
			extrarunCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_battingsummary_total", vparam, "ScoreDB"); // Batsman List
			vparam.removeAllElements();
			while(extrarunCachedRowSet.next()){
				bye   =  extrarunCachedRowSet.getString("byes")==null?"":extrarunCachedRowSet.getString("byes");
				legbye =  extrarunCachedRowSet.getString("legbyes")==null?"":extrarunCachedRowSet.getString("legbyes");
				noball =  extrarunCachedRowSet.getString("noballs")==null?"":extrarunCachedRowSet.getString("noballs");	
				wide = 	  extrarunCachedRowSet.getString("wides")==null?"":extrarunCachedRowSet.getString("wides");
				penlaty = extrarunCachedRowSet.getString("penalty")==null?"":extrarunCachedRowSet.getString("penalty");	
				extratotal = extrarunCachedRowSet.getString("total_extra")==null?"":extrarunCachedRowSet.getString("total_extra");	
			}
		 }catch (Exception e) {
 		   e.printStackTrace();
		 } 	

			/*Interval Popup*/
		vparam.add(inningId);
		intervalCachedRowSet = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_intervalstatus", vparam, "ScoreDB"); // Batsman List
		vparam.removeAllElements();
		while (intervalCachedRowSet.next()) {
			intervalid = intervalCachedRowSet.getString("id");
			intervalname = intervalCachedRowSet.getString("name");
			intervalRemark = intervalCachedRowSet.getString("remark");
			intervalcount = "1";
		}
        if(flag.equalsIgnoreCase("1")){
           vparam.add(inningId);
	       crs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallwicket",vparam,"ScoreDB");
		   vparam.removeAllElements();
           while(crs.next()){
           	Srno = Srno + crs.getString("srno") + "~";
            runs= runs + crs.getString("runs") +"~";
            overs = overs + crs.getString("overs") +"~";
           }
           String SrnoArr[] = Srno.split("~");
           String runsArr[] = runs.split("~");
           String oversArr[] = overs.split("~");
           for(int i=0;i<SrnoArr.length;i++){
				result = result +  SrnoArr[i]+"-"+runsArr[i] +"( "+oversArr[i]+" ovrs ),";
		   }
	 	}

%>

<table cellspacing=0 align=center height=10% width="100%" border="0" class="table" >
<tr class="contentDark">
	<td class="labelname" align=left>TOURNAMENT/VISTING TEAM : </td>
	<td class="labelname" align=left><font color="blue" > <%=tournamentName.equalsIgnoreCase("") ? "-" :tournamentName%></td>
	<td class="labelname" align=left nowrap width="1%" colspan="1">MATCH BETWEEN :<font color="blue">&nbsp;<%=teamOne.equalsIgnoreCase("") ? "-" :teamOne%></font> AND <font color="blue"><%=teamTwo.equalsIgnoreCase("") ? "-" :teamTwo%></font></td>
	
</tr>	 
<tr class="contentDark">
	<td class="labelname" align=left nowrap width="1%">PLAYED ON : </td>
	<td class="labelname" align=left><font color="blue"><%=date.equalsIgnoreCase("") ? "-" :date%>
<%		if(intervalcount.equalsIgnoreCase("1")){
%>			<font color="red">(<%=intervalname%> <%=intervalRemark%> )
<%		} 
%>
	</td>
	<td class="labelname" align=left nowrap width="1%">PLAYED AT GROUND/STADIUM : <font color="blue"><%=ground.equalsIgnoreCase("") ? "-" :ground%></font></td>
</tr>
<tr class="contentDark">
	<td class="labelname" align=left nowrap width="1%">CITY :  <font color="blue">&nbsp;<%=city.equalsIgnoreCase("") ? "-" :city%> </td>
	<td class="labelname" align=left nowrap width="1%">TOSS WON BY :  <font color="blue">&nbsp;<%=toss.equalsIgnoreCase("") ? "-" :toss%> </font></td>
		<td class="labelname" align=left nowrap width="1%">ELECTED TO : <font color="blue"><%=electedto.equalsIgnoreCase("") ? "-" :electedto%> </td>
</tr>

<tr class="contentDark">
	<td class="labelname"  align=left nowrap width="1%">RESULT : </td>
<%	if( matchStatusFlag.equals("A")){
%>	<td class="labelname" colspan ="2" nowrap><font color="blue"><%=result1.equalsIgnoreCase("") ? "-" :result1%></td>
<%	}else{
%>	<td class="labelname" colspan ="2" align=left nowrap><font color="blue"><%=result1.equalsIgnoreCase("") ? "-" :result1%></td>
<%	}%>
</tr>
<tr class="contentDark">
<%	if(maxInningId.equals(inningId) && matchStatusFlag.equals("A")){
%>	<td class="labelname" align=left nowrap width="1%" colspan ="2">[POINT : <font color="blue"><%=point.equalsIgnoreCase("") ? "-" : point%></font>]</td>
	<td class="labelname" align=left nowrap width="1%" >Remaining Overs : <font color="blue"><%=remainingOvrs%></font></td>
<%  }else{
%>	<td class="labelname" align=left nowrap width="1%" colspan ="3">[POINT : <font color="blue"><%=point.equalsIgnoreCase("") ? "-" : point%></font>]</td>
<%	}
%>
</tr>
<tr class="contentDark">
	<td class="labelname" align=left nowrap width="1%">1.UMPIRE :&nbsp;&nbsp;<font color="blue"><%=umpireOne.equalsIgnoreCase("") ? "-" :umpireOne%></td>
	<td class="labelname" align=left nowrap width="1%">2.UMPIRE :&nbsp;&nbsp;<font color="blue"><%=umpireTwo.equalsIgnoreCase("") ? "-" :umpireTwo%> </font> </td>
	<td class="labelname" align=left nowrap width="1%">3.UMPIRE :&nbsp;&nbsp;<font color="blue"><%=umpireThree.equalsIgnoreCase("") ? "-" :umpireThree%></td>
<%--		<td class="labelname" align=left nowrap width="1%">2.UMPIRE: Mr/Ms/Mrs :&nbsp;&nbsp;<font color="blue"><%=umpireTwo.equalsIgnoreCase("") ? "-" :umpireTwo%> </font> </td>--%>
<%--	<td class="labelname" align=left nowrap width="1%">CAPTAIN : &nbsp;--%>
<%--	<font color="blue"><%=captainOne.equalsIgnoreCase("") ? "-" :captainOne%> &nbsp;</font>&&nbsp;<font color="blue"><%=captainTwo.equalsIgnoreCase("") ? "-" :captainTwo%></td>--%>
</tr>
<tr class="contentDark">
<%--	<td class="labelname" align=left nowrap width="1%">2.UMPIRE: Mr/Ms/Mrs :&nbsp;&nbsp;<font color="blue"><%=umpireTwo.equalsIgnoreCase("") ? "-" :umpireTwo%> </font> </td>--%>
	<td class="labelname" align=left nowrap width="1%">CAPTAIN : &nbsp;
	<font color="blue"><%=captainOne.equalsIgnoreCase("") ? "-" :captainOne%> &nbsp;</font>&&nbsp;<font color="blue"><%=captainTwo.equalsIgnoreCase("") ? "-" :captainTwo%></td>
	<td class="labelname" align=left nowrap width="1%">UMPIRE COACH :&nbsp;&nbsp;<font color="blue"><%=umpireFour.equalsIgnoreCase("") ? "-" :umpireFour%></font></td>
	<td class="labelname" align=left nowrap width="1%">REFEREE :<font color="blue">&nbsp;<%=matchReferee.equalsIgnoreCase("") ? "-" :matchReferee%> </font> </td>
</tr>
<tr class="contentDark">
	<td class="labelname" align=left nowrap width="1%">Scorer1 :<font color="blue">&nbsp;<%=scorerOne.equalsIgnoreCase("") ? "-" :scorerOne%> </font> </td>
	<td class="labelname" align=left nowrap width="1%">Scorer2 :&nbsp;&nbsp;<font color="blue"><%=scorerTwo.equalsIgnoreCase("") ? "-" :scorerTwo%> </font> </td>
	<td class="labelname" align=left nowrap width="1%">WICKET KEEPERS : &nbsp;
	<font color="blue"><%=wicketKeeperOne.equalsIgnoreCase("") ? "-" :wicketKeeperOne%> &nbsp;</font>&&nbsp;<font color="blue"><%=wicketKeeperTwo.equalsIgnoreCase("") ? "-" :wicketKeeperTwo%> </font>
	</td>
</tr>
</table>
<br/><br/>
<table align="center" width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
<tr style="width=100%">
	<td width="100%">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
        		<td>
        			<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
		        		<tr class="contentDark">
        		        	<td align="center" width="85%" background="../images/BatsmanHeading.jpg" width="524" height="25"><%=battingteamname%></td>
              			</tr>
			            <tr>
                			<td>
                				<table width="100%" class="table tableBorder" border="0" cellspacing="0" cellpadding="0">
				                	<tr>
				 	                   <td>
                    				   		<table width="100%" border="0" cellspacing="0" cellpadding="1" id="BATT_TABLE" name="BATT_TABLE" >
                       							 <tr>
						                            <td  width="10px">No</td>
						                            <td width="15px">Time</td>
						                            <td width="300px">Batsman</td>
						                            <td width="50px">H.Out</td>
						                            <td width="600px">Bowler</td>
						                            <td width="50px" align="center">Runs</td>
						                            <td width="30px" align="center" >Balls</td>
						                            <td width="35px" align="center">Min</td>
						                            <td width="40px" align="center">4</td>
						                            <td width="40px" align="center">6</td>
						                            <td width="70px" align="center">SR</td>
						                            

                    							 </tr>
<%
												int i=2;
												int rownum = 1;
												while (battingSummaryCachedRowSet.next()) {
										        if(battingSummaryCachedRowSet.getString("batsmanid").equals(strikerId)){
									    	     	strikerrownumber = rownum;
										        }else if(battingSummaryCachedRowSet.getString("batsmanid").equals(nonStrikerId)){
										         	nonstrikerrownumber = rownum;
										        }
											    if(i%2==0){
%>							                   <tr id='<%=battingSummaryCachedRowSet.getString("batsmanid")%>' name='<%=battingSummaryCachedRowSet.getString("batsmanid")%>' class="contentLight">
<%										       } else{
%>									           <tr id='<%=battingSummaryCachedRowSet.getString("batsmanid")%>' name='<%=battingSummaryCachedRowSet.getString("batsmanid")%>' class="contentDark">
<%										        }
%>                     								<td align="left"><%=rownum%></td>
<%													if(battingSummaryCachedRowSet.getString("timein").equals(null) || battingSummaryCachedRowSet.getString("timein").equals(" ") || battingSummaryCachedRowSet.getString("timein").equals("")){
%>													<td></td>						
<%													}else{	
														String displaytime = battingSummaryCachedRowSet.getString("timein");
														String[] displaytimeArr = displaytime.split(":");
															try{
														int timeSec = 0;
													
														 timeSec = new Integer((displaytimeArr[1].toString()));
															
															if(timeSec < 10){
															displaytime = displaytimeArr[0]+":"+"0"+displaytimeArr[1];
															}else{
															displaytime = displaytime;
															}
													}catch(Exception e){
														 e.printStackTrace();
														 log.writeErrLog(page.getClass(),matchId,e.toString());
													}
%>
														<td align="left" valign="middle" class="lefttd"><%=displaytime%></td>
<%													}
													if(battingSummaryCachedRowSet.getString("batsmanid").equals(strikerId) || battingSummaryCachedRowSet.getString("batsmanid").equals(nonStrikerId)){
							                        if((battingSummaryCachedRowSet.getString("batsmanout").equalsIgnoreCase("Retires") || battingSummaryCachedRowSet.getString("batsmanout").equalsIgnoreCase("Retires"))
							                        		&& battingSummaryCachedRowSet.getString("batsmanoutdiv").equalsIgnoreCase("")){
%>													<td align="left"><font color="#6699FF"><%=battingSummaryCachedRowSet.getString("batsman")%><font></td>
													<td class="lefttd" align="left" nowrap="nowrap">Not Out</td>
													<td class="lefttd" align="left">&nbsp;</td>
<%													}else{
%>													<td align="left"><font color="#FF0066"><%=battingSummaryCachedRowSet.getString("batsman")%><font></td>
							                        <td class="lefttd" align="left" nowrap="nowrap"><%=battingSummaryCachedRowSet.getString("howout")%></td>
							                        <td class="lefttd" align="left"><%=battingSummaryCachedRowSet.getString("batsmanoutdiv")%></td>
<%													}}else{
%>													<td align="left"><font color="#FF0066"><%=battingSummaryCachedRowSet.getString("batsman")%><font></td>
							                        <td class="lefttd" align="left" nowrap="nowrap"><%=battingSummaryCachedRowSet.getString("howout")%></td>
							                        <td class="lefttd" align="left"><%=battingSummaryCachedRowSet.getString("batsmanoutdiv")%></td>
<%													}
%>							                        
							                        <td align="right"><%=battingSummaryCachedRowSet.getString("runs").equals("-1")?"":battingSummaryCachedRowSet.getString("runs")%></td>
							                        <td align="right"><%=battingSummaryCachedRowSet.getString("balls").equals("-1")?"":battingSummaryCachedRowSet.getString("balls")%></td>
							                        <td align="right"><%=battingSummaryCachedRowSet.getString("mins").equals("-1")?"":battingSummaryCachedRowSet.getString("mins")%></td>
							                        <td align="right"><%=battingSummaryCachedRowSet.getString("fours").equals("-1")?"":battingSummaryCachedRowSet.getString("fours")%></td>
							                        <td align="right"><%=battingSummaryCachedRowSet.getString("six").equals("-1")?"":battingSummaryCachedRowSet.getString("six")%></td>
							                        <td colspan="1" align="right"><%=battingSummaryCachedRowSet.getString("strike").equals("-1.00")?"":battingSummaryCachedRowSet.getString("strike")%></td>
							                        
                      							</tr>
<%
 								               i=i+1;
								                rownum = rownum + 1; // this is for count rw number	
								                
           									}// end of  while
%>
                     							<tr>
							                        <td></td>
							                        <td></td>
							                        <td align="right" class="lefttd" nowrap>Extras : </td>
							                        <td colspan="2" align="left">&nbsp;&nbsp;
							                          <b>(B&nbsp;<span id="b" name="b"><%=bye%></span>&nbsp;Lb&nbsp;<span id="lb" name="lb"><%=legbye%></span>&nbsp;Nb&nbsp;<span id="nb" name="nb"><%=noball%></span>
                         								 &nbsp;W&nbsp;<span id="w" name="w"><%=wide%></span>)</b>
							                        </td>
							                        <td><span id="Extratotal" name="Extratotal">&nbsp;&nbsp;<%=extratotal%></span></td>
							                     </tr>
							                     <tr>
							                        <td></td>
							                        <td></td>
							                        <td align="right" class="lefttd" nowrap>Penalty : </td>
							                        <td colspan="2" align="left"></td>
							                        <td><span id="open" name="open">&nbsp;&nbsp;<%=penlaty%></span></td>
							                        <td align="right" colspan="2" class="lefttd" nowrap>OverRate : </td>
							                        <td colspan="2" align="left">&nbsp;&nbsp;
							                          <span id="overrate" name="overrate"><%=overrate%></span>
							                        </td>
							                     </tr>
                    							 <tr>
								                    <td></td>
							    	                <td></td>
							        	            <td align="right" class="lefttd" nowrap>Total :</td>
							            	        <td colspan="2">
							                	  		( <span id="batsmanscorerewkt"><%=wkts%></span> wickets;<span id="Batstotalover"><%=currentover%></span> overs)
							                    	</td>
							                    	<td id="battotalruns" align="center"><%=scorerCardTotal%></td>
							                      	<td colspan="5" align="left">(<span id="totlarunrate"></span> runs per over)</td>
                    							</tr>
                    							<tr>
							                    	<td colspan="2" class="lefttd" nowrap>Fall Of Wicket:</td>
							            	        <td colspan="9" align="left"><span id="fallofwicket"><%=result%></span></td>
                    							</tr>
                    						</table>
                   						</td>
                  					</tr>
                			   </table>
                		  	</td>
             		 	</tr>
              		 	<tr>
               				<td align="center"><img src="../images/TableBottom.jpg" width="522" height="14"></td>
             			</tr>
            	   </table>
               </td>
          </tr>
          <tr>
			  <td width="100%">
				  <table width="100%" border="0" cellspacing="0" cellpadding="0">
              	  	  <tr>
               				<td colspan="2">
               					<table width="100%" border="0" class="table tableBorder" align="center" cellpadding="0" cellspacing="0" id="BALL_TABLE">
				                   <tr class="contentDark">
			          	  				<td align="center" colspan="10"  background="../images/BatsmanHeading.jpg" width="450" height="30"><%=bowlingteamname%></td>
						          	 
            					  </tr>
				                  <tr>
				                    <td width="34px"  align="center">No</td>
				                    <td width="110px"  align="center">Bowler</td>
				                    <td width="40"  align="right">&nbsp;Over</td>
				                    <td width="40"  align="right">&nbsp;&nbsp;Maiden</td>
				                    <td width="40"  align="right">Runs</td>
				                    <td width="20"  align="right">Wkt</td>
				                    <td width="25"  align="right">Wd</td>
				                    <td width="20"  align="right">Nb</td>
				                    <td width="45"  align="right">SR</td>
				                    <td width="40"  align="right">Eco</td>
				                  </tr>
<%
								int j = 2;
								int bowlerrowleng = bowlerscoreeCachedRowSet.size();
								int remainingrowleng = 12 - bowlerrowleng;
								int bowlerrownum = 1;
								while(bowlerscoreeCachedRowSet.next()){	
								if(bowlerStrikerId.equals(bowlerscoreeCachedRowSet.getString("bowler_id"))){
									bowlerrownumber = bowlerrownum;
								}
								if(j%2!=0){
%>					              <tr  id="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>" name="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>" class="contentLight" >
<%								}else{
%>                				  <tr  id="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>" name="<%=bowlerscoreeCachedRowSet.getString("bowler_id")%>" class="contentDark" >
<%								}
%>
					                    <td align="center"><%=bowlerrownum%></td>
					                    <td align="left" class="lefttd" ><%=bowlerscoreeCachedRowSet.getString("bowler_name")%></td>
					                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("noofover")%></td>
					                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("maiden")%></td>
					                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("runs")%></td>
					                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("wicket")%></td>
					                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("wideball")%></td>
					                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("noball")%></td>
					                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("sr")%></td>
					                    <td align="right"><%=bowlerscoreeCachedRowSet.getString("eco")%></td>
                 				 </tr>
<%								j=j+1;
								bowlerrownum = bowlerrownum + 1;
							 }// end of while		
							 for(int k=0;k<remainingrowleng;k++){ // this logic for add row which is not in database
								if(k%2!=0){
%>								<tr class="contentLight" >
<%								}else{
%>               				 <tr class="contentDark" >
<%								}
%>
					                    <td>&nbsp;</td>
					                    <td align="left" class="lefttd">&nbsp;</td>
					                    <td>&nbsp;</td>
					                    <td>&nbsp;</td>
					                    <td>&nbsp;</td>
					                    <td>&nbsp;</td>
					                    <td>&nbsp;</td>
					                    <td>&nbsp;</td>
					                    <td>&nbsp;</td>
					                    <td>&nbsp;</td>
										<td>&nbsp;</td>
                 				 </tr>
<%							}// end of for
%>				              </table>
						 </td>
              		  </tr>
              		  <tr>
                		<td align="center" colspan="2"><img src="../images/TableBottom.jpg" width="500" height="14"></td>
              		  </tr>
            	   </table>
                </td>
            </tr>
         </table>
       </td>
	   <td width="193" valign="top">
       </td>
	</tr>
	<tr>
       <td><input type="hidden" name="inningid" id="inningid" value="<%=inningId%>"></td>
	</tr>
</table>


<% } catch (Exception e) {
    e.printStackTrace();
}
%>

