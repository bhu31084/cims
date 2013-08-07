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
				java.util.*"%>	
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>    				
<%  	response.setHeader("Pragma","private");
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
			//LogWriter log = new LogWriter();
			String matchId = (String)session.getAttribute("matchId1");
			if(request.getParameter("WicketId")!=null && request.getParameter("WicketId").equalsIgnoreCase("4")){// For retireout
				String strikerPlayerId = request.getParameter("strikerPlayerId");
				String nonStrikerPlayerId = request.getParameter("nonStrikerPlayerId");
				String strikerPlayerName = request.getParameter("strikerPlayerName");
				String nonStrikerPlayerName = request.getParameter("nonStrikerPlayerName");
				
			}
				String id= request.getParameter("Id");
				String InningId = request.getParameter("InningId");
				CachedRowSet  lobjCachedRowSet = null;
				CachedRowSet  Filder2 = null;
				GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
				Vector vparam =  new Vector();
				vparam.add(InningId); // Inning Id
				lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dsp_fieldlist",vparam,"ScoreDB");
				Filder2  = lobjGenerateProc.GenerateStoreProcedure("dsp_fieldlist",vparam,"ScoreDB");
				
				vparam.removeAllElements();
				
		
%>	
<%
	String wicketID=request.getParameter("WicketId");
	//String wkts_request = request.getParameter("w");
	

%>

<html>
	<head>
		<title> Wickets </title>
		<script language="javascript">
			
			
		</script>
	</head>		
	<body>
		<div class="out">
	<% 
		if(wicketID.equalsIgnoreCase("1")||wicketID.equalsIgnoreCase("6")){  // 1 For Stump and 6 for wide + stump
	 %>
           
			<table width="100%" height="100%" border="5">
				<tr>
					<td>
						<table>
<%								if(wicketID.equalsIgnoreCase("1")){
%>							<tr>
								<td colspan="2" align="center"><b>STUMPED</b></td>
							</tr>
<%								}else{
%>							<tr>
								<td colspan="2" align="center"><b>WIDE + STUMPED</b></td>
							</tr>
<%								}
%>						</table>
<br>
<br>
						<table align="center" width="100%" height="100%">

							<tr>
								<td width="50%" align="right">
									Select Wicket Keeper : 
								</td>
								<td align="left">
									<select name="selName" id="selName" width="50%">
										<option value ="">--Select Name--</option>
<%
									while(lobjCachedRowSet.next()){
%>									<option value ="<%=lobjCachedRowSet.getString("team_id")+"~"+lobjCachedRowSet.getString("playername")+"~"+lobjCachedRowSet.getString("id")+"~"+lobjCachedRowSet.getString("player_status")%>" <%=lobjCachedRowSet.getString("is_wkeeper").equalsIgnoreCase("Y")?"selected":""%>><%=lobjCachedRowSet.getString("playername")%></option>
<%									}
%>										
									</select>
							   </td>
							</tr>
							<tr>
								<td colspan="2">
								&nbsp;
								</td>
							</tr> 
							<tr>
							</tr>
							<tr>
				    			<td align="center" colspan="2" >
<%			
									if(wicketID.equalsIgnoreCase("1")){				
%>									
									<input type="button" align="left" id="btnsubmit1" name="btnsubmit1" value="Submit" onclick="callFun.stumpshow('ajaxStumped','<%=id%>')"></input>
<%									}else{
%>
									<input type="button" align="left" id="btnsubmit1" name="btnsubmit1" value="Submit" onclick="callFun.stumpshow('ajaxwidestumped','<%=id%>')" ></input>
<%
									}
%>                                  <input align="center"  type="button" value="Cancel"  onclick="closePopup('BackgroundDiv','PopupDiv')"></input>
								</td>
							</tr>
						</table>
					</td>
				</tr>				
			</table>
<%
		}else if(wicketID.equalsIgnoreCase("17")){	//17 is for caught  by wicket keeper 
%>
            
			<table width="100%" height="100%" border="5">
				<tr>
					<td>
						<table>
<%							//if(wicketID.equalsIgnoreCase("1")){
%>							<tr>
								<td colspan="2" align="center"><b>CAUGHT BY WicketKeeper</b></td>
							</tr>
<%							//}
%>						</table>
						<br>
						<br>
						<table align="center" width="100%" height="100%">
							<tr>
								<td width="50%" align="right">Select Wicket Keeper Name : </td>
								<td align="left">
									<select name="wktselFldName" id="wktselFldName" width="50%">
										<option value ="">--Select Wicket Keeper Name--</option>
<%										while(lobjCachedRowSet.next()){
%>										<option value ="<%=lobjCachedRowSet.getString("team_id")+"~"+lobjCachedRowSet.getString("playername")+"~"+lobjCachedRowSet.getString("id")+"~"+lobjCachedRowSet.getString("player_status")%>" <%=lobjCachedRowSet.getString("is_wkeeper").equalsIgnoreCase("Y")?"selected":""%> ><%=lobjCachedRowSet.getString("playername")%></option>
<%										}// end  of while
%>									</select>
							   </td>
							</tr>
							<tr>
							</tr>
							<tr>
								<td  align="right">Strike Change : </td>
								<td align="left"><select name="wktStrikeChg" id="wktStrikeChg" width="50%">
										<option value ="">--Strike Change--</option>
										<option value ="1">Yes</option>
										<option value ="0">No</option>										
									</select>
							   </td>
							</tr>
							<tr>
								<td colspan="2">
								&nbsp;
								</td>
							</tr> 
							<tr>
								<td colspan="2" align="center" >

									<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callFun.caughtwktshow('ajaxcaughtwkt','<%=id%>')"></input>
                                     <input  type="button" value="Cancel"  onclick="closePopup('BackgroundDiv','PopupDiv')"></input>
                                </td>
							</tr>
						</table>
					</td>
				</tr>				
			</table>
		
<%
			}else if(wicketID.equalsIgnoreCase("3") || wicketID.equalsIgnoreCase("9") || wicketID.equalsIgnoreCase("12") || wicketID.equalsIgnoreCase("13") || wicketID.equalsIgnoreCase("14")
					|| wicketID.equalsIgnoreCase("30") || wicketID.equalsIgnoreCase("31")){//3 is For runout and 9 is for noballrunout 
 %>
            
			<table width="100%" height="100%" border="5">
				<tr>
					<td>
						<table>
<%								if(wicketID.equalsIgnoreCase("3")){
%>							<tr>
								<td colspan="2" align="center"><b>RUNOUT</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("9")){
%>							<tr >
								<td colspan="2" align="center"><b>NOBALL + RUNOUT</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("12")){
%>							<tr>
								<td colspan="2" align="center"><b>WIDE + RUNOUT</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("13")){
%>							<tr>
								<td colspan="2" align="center"><b>Byes + RUNOUT</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("14")){
%>							<tr>
								<td colspan="2" align="center"><b>Leg Byes + RUNOUT</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("30")){
%>							<tr>
								<td colspan="2" align="center"><b>No Ball + Byes + Run Out</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("31")){
%>							<tr>
								<td colspan="2" align="center"><b>No Ball + LegByes + Run Out</b></td>
							</tr>
<%								}
%>

						</table>
<br>

						<table width="100%" height="100%">
							<tr>
								<td width="50%" align="right">Select First Fielder  : </td>
								<td align="left">
									<select name="selFld1Name" id="selFld1Name" width="50%">
										<option value ="">--Select Fielder Name--</option>
<%
									while(lobjCachedRowSet.next()){
%>	
										<option value ="<%=lobjCachedRowSet.getString("team_id")+"~"+lobjCachedRowSet.getString("playername")+"~"+lobjCachedRowSet.getString("id")+"~"+lobjCachedRowSet.getString("player_status")%>"><%=lobjCachedRowSet.getString("playername")%></option>
<%
									}
%>	
									</select>
							   </td>
							</tr>
							<tr>
							</tr>
							<tr>
                                <td align="right">Select Second Fielder :  </td>
								<td align="left">
									<select name="selFld2Name" id="selFld2Name" width="50%">
										<option value ="">--Select Fielder Name--</option>
<%
									while(Filder2.next()){
%>	
										<option value ="<%=Filder2.getString("team_id")+"~"+Filder2.getString("playername")+"~"+Filder2.getString("id")+"~"+Filder2.getString("player_status")%>"><%=Filder2.getString("playername")%></option>
<%
									}
%>	
									</select>
							   </td>
							</tr>
							<tr>
							</tr>
							<tr>
								<td align="right">Select Runs: </td>
								<td align="left">
									<select name="outruns" id="outruns" width="100%">
										<option value ="">--Select Runs  Scored--</option>
										<option value ="0">0</option>
										<option value ="1">1</option>
										<option value ="2">2</option>
										<option value ="3">3</option>
										<option value ="4">4</option>
										<option value ="5">5</option>
										<option value ="6">6</option>
										<option value ="7">7</option>
										
									</select>
							   </td>
							</tr>
							<tr>
							</tr>							
							<tr>
								<td align="right">RunOut Batsman's Name : </td>
								<td align="left">
								    <select name="selrunoutbatName" id="selrunoutbatName" width="50%">
										<option value ="">--Select Batsman Name--</option>
										<option value ="0"><%=request.getParameter("strikerPlayerName")%></option> <!-- 0 For Striker Out-->
										<option value ="1"><%=request.getParameter("nonStrikerPlayerName")%></option> <!-- 1 For nonStriker Out-->

									</select>
							   </td>
							</tr>
							<tr>
								<td align="right">Strike Change : </td>
								<td align="left"><select name="runoutStrikeChg" id="runoutStrikeChg" width="50%">
										<option value ="">--Strike Change--</option>
										<option value ="1">Yes</option>
										<option value ="0">No</option>										
									</select>
							   </td>
							</tr> 
							<tr>
								<td colspan="2">
<%
									if(wicketID.equalsIgnoreCase("3")){
%>
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callFun.runoutshow('ajaxrunout','<%=id%>')"></input>
<%
									}else if(wicketID.equalsIgnoreCase("9")){	
%>									
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callFun.runoutshow('ajaxnoballrunout','<%=id%>')"></input>
<%
									}else if(wicketID.equalsIgnoreCase("12")){
%>
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callFun.runoutshow('ajaxwiderunout','<%=id%>')"></input>			
<%									}else if(wicketID.equalsIgnoreCase("13")){
%>
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callFun.runoutshow('ajaxbyesrunout','<%=id%>')"></input>			
<%									}else if(wicketID.equalsIgnoreCase("14")){
%>
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callFun.runoutshow('ajaxlegbyesrunout','<%=id%>')"></input>			
<%									}else if(wicketID.equalsIgnoreCase("30")){
%>
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callFun.runoutshow('ajaxnoballbyesrunout','<%=id%>')"></input>			
<%									}else if(wicketID.equalsIgnoreCase("31")){
%>
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callFun.runoutshow('ajaxnoballlegbyesrunout','<%=id%>')"></input>			
<%									}
%>                                    <input align="center"  type="button" value="Cancel"  onclick="closePopup('BackgroundDiv','PopupDiv')"></input>
                                </td>
							</tr>
						</table>
					</td>
				</tr>				
			</table>
<%
			}else if(wicketID.equalsIgnoreCase("4") || wicketID.equalsIgnoreCase("18") || wicketID.equalsIgnoreCase("5")|| wicketID.equalsIgnoreCase("15") ||wicketID.equalsIgnoreCase("7")||wicketID.equalsIgnoreCase("8")||wicketID.equalsIgnoreCase("10") || wicketID.equalsIgnoreCase("11") ||wicketID.equalsIgnoreCase("13") || wicketID.equalsIgnoreCase("14")){ // 4- Retire Out  ;5 -Handle the ball/ Obstructing the field ;7-wide + Obstructing the field; 8 - No Ball + Handle the ball/ Obstructing the field; 10 -Retires 11- Time Out // 13 - wide+handle the ball 14 -No ball + handle the ball  15- handle the ball
%>		
			<table width="100%" height="100%" border="5">
				<tr>
					<td>
					<table>
<%								if(wicketID.equalsIgnoreCase("4")){
%>							<tr >
								<td colspan="2" align="center"><b>RETIRED OUT</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("5")){
%>							<tr >
								<td colspan="2" align="center"><b>OBSTRUCTING THE FIELD</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("15")){
%>							<tr >
								<td colspan="2" align="center"><b>HANDLED THE BALL</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("7")){
%>							<tr >
								<td colspan="2" align="center"><b> WIDE + OBSTRUCTING THE FIELD</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("8")){
%>							<tr >
								<td colspan="2" align="center"><b>NO BALL + OBSTRUCTING THE FIELD</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("14")){
%>							<tr >
								<td colspan="2" align="center"><b>NO BALL + HANDLED THE BALL </b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("10")){
%>							<tr >
								<td colspan="2" align="center"><b>RETIRES</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("11")){
%>							<tr >
								<td colspan="2" align="center"><b>TIMED OUT</b></td>
							</tr>
<%								}else if(wicketID.equalsIgnoreCase("13")){
%>							<tr>
								<td colspan="2" align="center"><b>WIDE + HANDLED THE BALL</b></td>
							</tr>	
<%								}else if(wicketID.equalsIgnoreCase("18")){
%>							<tr >
								<td colspan="2" align="center"><b>Retired Not Out</b></td>
							</tr>
<%								}
%> 				
					</table>
<br>
<br>
						<table width="100%" height="100%">
							<tr>
								<td width="50%" align="right">Select Batsman Name:</td>
								<td align="left">
									<select name="selbatName" id="selbatName" width="50%">
										<option value ="">--Select Batsman Name--</option>
										<option value ="0"><%=request.getParameter("strikerPlayerName")%></option> <!-- 0 For Striker Out-->
										<option value ="1"><%=request.getParameter("nonStrikerPlayerName")%></option> <!-- 1 For nonStriker Out-->

									</select>
							   </td>
							</tr>
							<tr>
								<td colspan="2">
								&nbsp;
								</td>
							</tr> 
							<tr>
								
								<td colspan="2">
<%
									if(wicketID.equalsIgnoreCase("4")){//for
%>
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.otherwkt('ajaxretireout','<%=id%>')"></input>
<%	
									}else if(wicketID.equalsIgnoreCase("18")){
%>									
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.otherwkt('ajaxabsenteout','<%=id%>')"></input>
<%
									}
									else if(wicketID.equalsIgnoreCase("5")){
%>									
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.otherwkt('ajaxhandleball','<%=id%>')"></input>
<%
									}else if(wicketID.equalsIgnoreCase("15")){
%>									
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.otherwkt('ajaxhandletheball','<%=id%>')"></input>
<%
									}else if(wicketID.equalsIgnoreCase("7")){
%>										
											<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.otherwkt('ajaxWideHTBOTF','<%=id%>')"></input>
<%
									}
									else if(wicketID.equalsIgnoreCase("8")){
%>										
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.otherwkt('ajaxNoHTBOTF','<%=id%>')"></input>
<%
									}else if(wicketID.equalsIgnoreCase("14")){
%>										
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.otherwkt('ajaxNoHTB','<%=id%>')"></input>
<%
									}
									else if(wicketID.equalsIgnoreCase("10")){//For Retires 
%>										
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.otherwkt('ajaxRETIRES','<%=id%>')"></input>
<%
									}else if(wicketID.equalsIgnoreCase("11")){//For time out 
%>										
										<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.otherwkt('ajaxtimeout','<%=id%>')"></input>
<%
									}else if(wicketID.equalsIgnoreCase("13")){
%>										
											<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.handleball('ajaxWideHTB','<%=id%>')"></input>
<%
									}//End
%>                   
                                     <input align="center"  type="button" value="Cancel"  onclick="closePopup('BackgroundDiv','PopupDiv')"></input>

								</td>
							</tr>
						</table>
					</td>
				</tr>				
			</table>
<%
	}// End of Else if 4 
	else if(wicketID.equalsIgnoreCase("29")){//29 - wrong ;
%>
	<table width="100%" height="100%" border="5">
		<tr>
			<td>
					<table align="center" width="100%" height="100%">
					<tr>
						<td width="50%" align="left">Select Fielder Name : </td>
						<td align="left">
							<select name="selFlderName" id="selFlderName" width="50%">
								<option value ="">--Select Fielder Name--</option>
<%									while(lobjCachedRowSet.next()){
%>								<option value ="<%=lobjCachedRowSet.getString("team_id")+"~"+lobjCachedRowSet.getString("playername")+"~"+lobjCachedRowSet.getString("id")+"~"+lobjCachedRowSet.getString("player_status")%>"><%=lobjCachedRowSet.getString("playername")%></option>
<%									}
%>							</select>
					    </td>
					</tr>
					<tr>
						<td colspan="2">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="50%" align="left">Select Batsman Name:</td>
						<td align="left">
							<select name="selotfbatName" id="selotfbatName" width="50%">
								<option value ="">--Select Batsman Name--</option>
								<option value ="0"><%=request.getParameter("strikerPlayerName")%></option> <!-- 0 For Striker Out-->
								<option value ="1"><%=request.getParameter("nonStrikerPlayerName")%></option> <!-- 1 For nonStriker Out-->
							</select>
					   </td>
					 </tr> 
					 <tr>
						<td colspan="2">
							&nbsp;
						</td>
					</tr> 
					<tr>
						<td colspan="2" align="center" >
							<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit"  onclick="callFun.handleball('ajaxWideHTB','<%=id%>')"></input>
                            <input  type="button" value="Cancel"  onclick="closePopup('BackgroundDiv','PopupDiv')"></input>
                        </td>
					</tr>
				</table>
			</td>
		</tr>				
	</table>			
<%
	}else if(wicketID.equalsIgnoreCase("16")){	//15 is for caught by bowler  type
%>
	<table width="100%" height="100%" border="5">
		<tr>
			<td>
				<table>
					<tr>
						<td colspan="2" align="center"><b>caught by bowler</b></td>
					</tr>
				</table>
				<br>
				<br>
				<table align="center" width="100%" height="100%">
					<tr>
					</tr>
					<tr>
						<td  align="right">Strike Change : </td>
						<td align="left">
						<select name="cbbStrikeChg" id="cbbStrikeChg" width="50%">
							<option value ="">--Strike Change--</option>
							<option value ="1">Yes</option>
							<option value ="0">No</option>										
						</select>
						</td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr> 
					<tr>
						<td colspan="2" align="center" >
							<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callFun.caughtbybowler('ajaxcaughtbybowler','<%=id%>')"></input>
                            <input  type="button" value="Cancel"  onclick="closePopup('BackgroundDiv','PopupDiv')"></input>
                        </td>
					</tr>
				</table>
			</td>
		</tr>				
	</table>
<%
	}// end caught and bowled
	else if(wicketID.equalsIgnoreCase("2")){	//2 is for caught type 
%>
			<table width="100%" height="100%" border="5">
				<tr>
					<td>
						<table>
<%							//if(wicketID.equalsIgnoreCase("1")){
%>							<tr>
								<td colspan="2" align="center"><b>CAUGHT</b></td>
							</tr>
<%							//}
%>						</table>
						<br>
						<br>
						<table align="center" width="100%" height="100%">
							<tr>
								<td width="50%" align="right">Select Fielder Name : </td>
								<td align="left">
									<select name="selFldName" id="selFldName" width="50%">
										<option value ="">--Select Fielder Name--</option>
<%
									while(lobjCachedRowSet.next()){
%>	
										<option value ="<%=lobjCachedRowSet.getString("team_id")+"~"+lobjCachedRowSet.getString("playername")+"~"+lobjCachedRowSet.getString("id")+"~"+lobjCachedRowSet.getString("player_status")%>"><%=lobjCachedRowSet.getString("playername")%></option>
<%
									}
%>	
									</select>
							   </td>
							</tr>
							<tr>
							</tr>
							<tr>
								<td  align="right">Strike Change : </td>
								<td align="left"><select name="StrikeChg" id="StrikeChg" width="50%">
										<option value ="">--Strike Change--</option>
										<option value ="1">Yes</option>
										<option value ="0">No</option>										
									</select>
							   </td>
							</tr>
							<tr>
								<td colspan="2">
								&nbsp;
								</td>
							</tr> 
							<tr>
								<td colspan="2" align="center" >

									<input type="button" align="left" id="btnsubmit" name="btnsubmit" value="Submit" onclick="callFun.caughtshow('ajaxcaught','<%=id%>')"></input>
                                     <input  type="button" value="Cancel"  onclick="closePopup('BackgroundDiv','PopupDiv')"></input>
                                </td>
							</tr>
						</table>
					</td>
				</tr>				
			</table>
		
<%
	} // end else if caught by filder
	}catch(Exception e){
		e.printStackTrace();
		//log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>
		</div>	 
		   
	</body>		
</html>		
