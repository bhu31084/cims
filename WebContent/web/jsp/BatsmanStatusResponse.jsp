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
		String batsmanId = "";
		String batsmanName = "";
		String seriesId = null;
		ChangeInitial chgInitial = new ChangeInitial();
		String tempFlag = null;// To get the all matches details of player,used in sp:esp_dsp_getseries_wise_top_batsman_list
		seriesId = request.getParameter("series_id")==null?"0":request.getParameter("series_id");
		batsmanId = request.getParameter("batsmanId")==null?"":request.getParameter("batsmanId");
		seasonId = request.getParameter("seasonId")==null?"":request.getParameter("seasonId");
		batsmanName = request.getParameter("batsmanName")==null?"":request.getParameter("batsmanName");
		String flg = null;
		flg = request.getParameter("flag")==null?"":request.getParameter("flag");		
		
		if(flg.equalsIgnoreCase("a")){
			tempFlag = "7";
		}else{
			tempFlag = "6";
		}
		
		/*System.out.println("*************batsmanId*****************"+batsmanId);	
		System.out.println("*************seasonId*****************"+seasonId);	
		System.out.println("*************batsmanName*****************"+batsmanName);	
		System.out.println("*************seriesId****************"+seriesId);
		System.out.println("*************flag*****************"+flg);
		System.out.println("*************tempFlag*****************"+tempFlag);	*/
		
		CachedRowSet 			crsObjGetbatsmanDetails =	null;
		GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
		Vector 					vparam 					=  	new Vector();
		String message = "";
		String gsteamId = "";
		//String topPerformerflag = "";
		vparam.removeAllElements();
		vparam.add(batsmanId);	
		vparam.add(seasonId);
		//vparam.add(seriesId);
		
		try {
			crsObjGetbatsmanDetails = lobjGenerateProc.GenerateStoreProcedure(
			"dsp_player_wise_batting_statistics", vparam, "ScoreDB");								
			vparam.removeAllElements();			
		} catch (Exception e) {
			System.out.println("*************BatsmanStatusResponse.jsp*****************"+e);			
		}
		%>
		
		
		
		
<DIV id="ShowBatsmanDetailsDiv<%=batsmanId%>" >
<table border="1" width="100%" align="center" class="contenttable">		
		<tr>
			<td colspan="16" style="font-size: 12px;text-align: center;"><b><%=chgInitial.properCase(batsmanName)%></b></td>
		</tr>		
		<tr >
   		<td style="text-align: center;"><b>Mat</b></td>
   		<td style="text-align: center;"><b>Inns</b></td>   		
   		<td style="text-align: center;"><b>Runs </b></td>
   		<td style="text-align: center;"><b>NO </b></td>
		<td style="text-align: center;"><b>Ave</b></td>
		<td style="text-align: center;"><b>SR</b></td>
   		<td style="text-align: center;"><b>HS </b></td>
		<td style="text-align: center;"><b>100</b></td>
		<td style="text-align: center;"><b>50</b></td>
		<td style="text-align: center;"><b>4s</b></td>
		<td style="text-align: center;"><b>6s</b></td>
	</tr>							
	<%if(crsObjGetbatsmanDetails != null ){
			int counter = 1;
			if(crsObjGetbatsmanDetails.size() == 0){				
				message = " Data Not Available ";%>
			<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
			<%}else{%>
			<%while(crsObjGetbatsmanDetails.next()){				
			if(counter % 2 == 0 ){%>
        		<tr bgcolor="#f0f7fd">
        		<%}else{%>
        		<tr bgcolor="#e6f1fc">	
        		<%}%>							
			<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_total_matches")%></b></td>
	   		<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_total_innings")%></b></td>
	   		<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_total_runs")%> </b></td>
	   		<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_Total_Not_Outs")%> </b></td>
	   		<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_average")%> </b></td>
			<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_strike_rate")%></b></td>
			<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_highest_innings_runs")%></b></td>
			<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_centuries")%></b></td>
			<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_half_centuries")%></b></td>
			<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_boundaries_four")%></b></td>
			<td style="text-align: center;"><b><%=crsObjGetbatsmanDetails.getString("batsmans_boundaries_six")%></b></td>											
	</tr>	
		<%}%>
<%				}
}
%>		
<%
	CachedRowSet crsObjPlayerBowlingRecord = null;
	String pageFlag = "2";
	try {
			vparam.add(seriesId);
			vparam.add(seasonId);
			vparam.add("");//club id
			vparam.add(batsmanId);			
			vparam.add(tempFlag);
		
			crsObjPlayerBowlingRecord = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_getseries_wise_top_batsman_list", vparam, "ScoreDB");
			vparam.removeAllElements();
%>
<tr>      
				<td colspan="15">					
					<table width="100%" border="1" align="left" class="contenttable">
						<tr >
							<th>&nbsp;</th>
							<th align="left" style="padding-left: 5px;" class="colheadinguser"><b>Match Between</b></th>
							<th align="left" style="padding-left: 5px;" class="colheadinguser"><b>Venue</b></th>
							<th align="center" class="colheadinguser"><b>Match Date</b></th>
							<th align="center" class="colheadinguser"><b>Inning 1</b></th>
							<th align="center" class="colheadinguser"><b>Inning 2</b></th>
							<th align="center" class="colheadinguser"><b>Runs</b></th>
						</tr>
						
<%	
			int total = 0;
			int row = 1;
			int indTotal = 0;

			String flag="false";
			String seriesIdColumn =null;
							
			if(crsObjPlayerBowlingRecord != null && crsObjPlayerBowlingRecord.size() > 0) {
				while (crsObjPlayerBowlingRecord.next()) {
					String matchdate = crsObjPlayerBowlingRecord.getString("expected_start");
					total = total + Integer.parseInt(crsObjPlayerBowlingRecord.getString("total_runs"));
					
					if(flag.equalsIgnoreCase("false") &&  seriesIdColumn == null){
					seriesIdColumn = crsObjPlayerBowlingRecord.getString("seriesid");
					
								

%>
					 <tr>
					   	<td nowrap colspan="4" style="font-weight: bold;font-size: 11px;"><%=crsObjPlayerBowlingRecord.getString("seriesdesc")%></td>
					 </tr>
<%					}

					if(seriesIdColumn != null){
					//indTotal = indTotal + Integer.parseInt(crsObjPlayerBowlingRecord.getString("total_runs"));
						if(flag.equalsIgnoreCase("false") && !(seriesIdColumn.equalsIgnoreCase(crsObjPlayerBowlingRecord.getString("seriesid")))){
						//indTotal = indTotal + Integer.parseInt(crsObjPlayerBowlingRecord.getString("total_runs"));
						seriesIdColumn = crsObjPlayerBowlingRecord.getString("seriesid");%>
					 <tr>

					 	<td style="text-align: right;" colspan="6">Total</td>
					 	<td style="text-align: right;padding-right: 30px;"><%=indTotal%></td>
					 	
					 </tr>
					 <tr>
					   	<td nowrap colspan="4" style="font-weight: bold;font-size: 11px;"><%=crsObjPlayerBowlingRecord.getString("seriesdesc")%></td>
					 </tr>
					

									 
 <%						indTotal = 0;		
						}//end inner if
				   	}//end outer if
								
%>					
				    <tr >
					  <td align="center"><IMG src="../Image/Dot.jpg"></td>					  
					  <td nowrap align="left" style="padding-left: 5px;"><%=crsObjPlayerBowlingRecord.getString("matchbtwn")%></td>
					  <td nowrap align="left" style="padding-left: 5px;"><%=crsObjPlayerBowlingRecord.getString("venuename")%></td>
					  <td nowrap width="12%" style="text-align: right;padding-right: 5px;"><%=matchdate.substring(0,10)%></td>
					  <td nowrap width="12%" style="text-align: right;padding-right: 10px;"><%=crsObjPlayerBowlingRecord.getString("runs_inn1")%></td>
					  <td nowrap width="12%" style="text-align: right;padding-right: 10px;"><%=crsObjPlayerBowlingRecord.getString("runs_inn2")%></td>
					  <td nowrap width="10%" style="text-align: right;padding-right: 30px;" ><%=crsObjPlayerBowlingRecord.getString("total_runs")%>
<%--					  	<div style="background:#ADADAD;left:680px;position:absolute;z-index=0.5;display:none;width=100%;nowrap;" id='runwicket_<%=row%>' name='runwicket_<%=row%>'></div>--%>
					  </td>
					</tr> 

<%					indTotal = indTotal + Integer.parseInt(crsObjPlayerBowlingRecord.getString("total_runs"));
					row = row +1;


				 }//end while
			 }//end if
%>			
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							 	<td style="text-align: right;">Total</td>
							 	<td style="text-align: right;padding-right: 30px;"><%=indTotal%></td>
							</tr>
						
							<tr>
<%						if(!(pageFlag != null && (pageFlag.equalsIgnoreCase("1")))){			
%>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td style="text-align: right;">Gr Total : </td>
								<td style="text-align: right;padding-right: 30px;"><%=total%></td>
<%						}
%>								
							</tr>
					
						</table>
					</td>
				</tr>		
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