<!--
	Author 		 : Archana Dongre
	Created Date : 31/01/09
	Description  : Display match Ranking summry.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="error_page.jsp"%>
<%@ page import="in.co.paramatrix.common.ChangeInitial"%>	
<%
		try {		
   		String seasonId = "";	
		String bowlerId = "";
		String bowlerName = "";
		String seriesId = null;
		ChangeInitial chgInitial = new ChangeInitial();
		String tempFlag = null;// To get the all matches details of player,used in sp:esp_dsp_getseries_wise_top_batsman_list
		bowlerId = request.getParameter("bowlerId")==null?"":request.getParameter("bowlerId");
		seasonId = request.getParameter("seasonId")==null?"":request.getParameter("seasonId");
		bowlerName = request.getParameter("bowlerName")==null?"":request.getParameter("bowlerName");
		seriesId = request.getParameter("series_id")==null?"0":request.getParameter("series_id");
		String flg = null;
		flg = request.getParameter("flag")==null?"":request.getParameter("flag");		
		
		if(flg.equalsIgnoreCase("ba")){
			tempFlag = "7";
		}else{
			tempFlag = "6";
		}
		
		/*System.out.println("*************bowlerId*****************"+bowlerId);	
		System.out.println("*************seasonId*****************"+seasonId);	
		System.out.println("*************bowlerName*****************"+bowlerName);	
		System.out.println("*************seriesId****************"+seriesId);	
		System.out.println("*************flag*****************"+flg);
		System.out.println("*************tempFlag*****************"+tempFlag);*/
		
		CachedRowSet 			crsObjGetbowlersDetails =	null;
		GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
		Vector 					vparam 					=  	new Vector();
		String message = "";
		String gsteamId = "";
		//String topPerformerflag = "";
		vparam.removeAllElements();
		vparam.add(bowlerId);
		vparam.add(seasonId);	
		vparam.add(seriesId);
		
		try {
			crsObjGetbowlersDetails = lobjGenerateProc.GenerateStoreProcedure(
			"dsp_player_wise_bowling_statistics", vparam, "ScoreDB");								
			vparam.removeAllElements();			
		} catch (Exception e) {
			System.out.println("*************BowlerStatusResponse.jsp*****************"+e);			
		}
		%>
<DIV id="ShowBatsmanDetailsDiv<%=bowlerId%>" >
<table border="1" width="100%" align="center" class="contenttable">		
		<tr>
			<td colspan="12" style="padding-left: 5px;"><b><%=chgInitial.properCase(bowlerName)%></b></td>
		</tr>	
		<tr >
   		<td style="text-align: center;"><b>Match</b></td>
   		<td style="text-align: center;"><b>Inns</b></td>
   		<td style="text-align: center;"><b>Balls </b></td>
   		<td style="text-align: center;"><b>Runs </b></td>
   		<td style="text-align: center;"><b>Wkts </b></td>
		<td style="text-align: center;"><b>BBI</b></td>
		<td style="text-align: center;"><b>BBM</b></td>
		<td style="text-align: center;"><b>Ave</b></td>
		<td style="text-align: center;"><b>Econ</b></td>
		<td style="text-align: center;"><b>SR</b></td>
		<td style="text-align: center;"><b>5w</b></td>
		<td style="text-align: center;"><b>10w</b></td>
	</tr>							
	<%if(crsObjGetbowlersDetails != null ){
			int counter = 1;
			if(crsObjGetbowlersDetails.size() == 0){				
				message = " Data Not Available ";%>
			<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
			<%}else{%>
			<%while(crsObjGetbowlersDetails.next()){				
			if(counter % 2 == 0 ){%>
        		<tr bgcolor="#f0f7fd">
        		<%}else{%>
        		<tr bgcolor="#e6f1fc">	
        		<%}%>        		
		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("bowlers_total_matches")%></b></td>
   		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("bowlers_total_innings")%></b></td>
   		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("Bowlers_Total_Bowled_Balls")%> </b></td>
   		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("bowlers_total_runs")%> </b></td>
   		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("bowlers_wicket_count")%> </b></td>
		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("best_bowling_inning")%></b></td>
		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("best_Bowling_Match")%></b></td>
		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("bowlers_average")%></b></td>
		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("bowlers_economy")%></b></td>
		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("bowlers_strike_rate")%></b></td>
		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("Innings_Five_Wickets_Count")%></b></td>
		<td style="text-align: center;"><b><%=crsObjGetbowlersDetails.getString("Innings_Ten_Wickets_Count")%></b></td>												
	</tr>	
		<%}%>
<%				}
}
%>		

<%
	CachedRowSet crsObjPlayerBowlingRecord = null;
	String pageFlag = "1";
	//Vector vparam = new Vector();
	//GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		try {
			vparam.add(seriesId);
			vparam.add(seasonId);
			vparam.add("");//club id
			vparam.add(bowlerId);
			vparam.add(tempFlag);
		
			crsObjPlayerBowlingRecord = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");
			vparam.removeAllElements();			
%>
			<tr>      
				<td colspan="15">					
					<table width="100%" border="1" align="left" class="contenttable">
						<tr >							
							<th align="left" class="colheadinguser">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Match Between</b></th>
							<th align="left" class="colheadinguser"><b>Venue</b></th>
							<th align="left" class="colheadinguser"><b>Match Date</b></th>
							<th align="center" class="colheadinguser"><b>Inning 1</b></th>
							<th align="center" class="colheadinguser"><b>Inning 2</b></th>
							<th align="center" class="colheadinguser"><b>Wkts</b></th>
						</tr>
						
<%		int total = 0;
		int row = 1;
		int indTotal = 0;
		String flag="false";
		String seriesIdColumn =null;
		if(crsObjPlayerBowlingRecord != null && crsObjPlayerBowlingRecord.size() > 0) {
			while (crsObjPlayerBowlingRecord.next()) {
			String matchdate = crsObjPlayerBowlingRecord.getString("expected_start");
			total = total + Integer.parseInt(crsObjPlayerBowlingRecord.getString("total_wicktes"));
			
				if(flag.equalsIgnoreCase("false") &&  seriesIdColumn == null){
					seriesIdColumn = crsObjPlayerBowlingRecord.getString("seriesid");
%>
					 <tr >
					   	<td nowrap colspan="5" style="font-weight: bold;font-size: 11px;"><%=crsObjPlayerBowlingRecord.getString("description")%></td>
					 </tr>
<%				}
				if(seriesIdColumn != null){
						if(flag.equalsIgnoreCase("false") && !(seriesIdColumn.equalsIgnoreCase(crsObjPlayerBowlingRecord.getString("seriesid")))){
						
						seriesIdColumn = crsObjPlayerBowlingRecord.getString("seriesid");%>
					 <tr >

					 	<td colspan="5" style="text-align: right;">Total</td>
					 	<td style="text-align: center;"><%=indTotal%></td>
					 </tr>
					 <tr >

					   	<td style="font-weight: bold;font-size: 11px;"><%=crsObjPlayerBowlingRecord.getString("description")%></td>
					 </tr>
									 
<%					indTotal = 0;				
					}//end inner if
			   	}//end outer if
							
%>						
				    <tr style="height: 2px;">					 
					  <td nowrap align="left"><IMG src="../Image/Dot.jpg"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=crsObjPlayerBowlingRecord.getString("matchbtwn")%></td>
					  <td nowrap align="left" style="text-align: left;padding-left: 10px;"><%=crsObjPlayerBowlingRecord.getString("venuename")%></td>
					  <td nowrap width="12%" style="text-align: right;padding-right: 10px;"><%=matchdate.substring(0,10)%></td>
					  <td nowrap width="12%" style="text-align: right;padding-right: 10px;"><%=crsObjPlayerBowlingRecord.getString("wkt_inn1")%></td>
					  <td nowrap width="12%" style="text-align: right;padding-right: 10px;"><%=crsObjPlayerBowlingRecord.getString("wkt_inn2")%></td>
					  
					  <td nowrap width="12%"  style="text-align: center;" ><%=crsObjPlayerBowlingRecord.getString("total_wicktes")%>
<%--					  	<div style="background:#ADADAD;left:620px;position:absolute;z-index=0.5;display:none;width=100%;nowrap;" id='runwicket_<%=row%>' name='runwicket_<%=row%>'></div>--%>
					  </td>
					</tr> 
<%					indTotal = indTotal + Integer.parseInt(crsObjPlayerBowlingRecord.getString("total_wicktes"));
					row = row +1;
				 }
			 }
%>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>																
								<td style="text-align: right;">Total</td>
					 			<td style="text-align: center;"><%=indTotal%></td>							 	
							</tr>
<%						if(!(pageFlag != null && (pageFlag.equalsIgnoreCase("2")))){			
%>								
							<tr style="height: 2px;">

								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>												
								<td class="colheadinguser" style="text-align: right;">Gr Total : </td>
								<td class="colheadinguser" style="text-align: right;padding-right: 35px;"><%=total%></td>
							</tr>
<%						}
%>							
						</table>
					</td>
				</tr>
		</table>
	</body>
<%
		} catch (Exception e) {
			e.printStackTrace();
		}
%>


</DIV>
<%} catch (Exception e) {
			System.err.println(e.toString());
		}
%>