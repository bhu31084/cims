<!--
Page Name: SeriesSelectionMaster.jsp
Author 		 : Archana Dongre.
Created Date : 16th Sep 2008
Description  : Selection of Series 
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ include file="AuthZ.jsp" %>
<%
	response.setHeader("Pragma","private");
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
			
		CachedRowSet  crsObjTournamentNm = null;
		CachedRowSet  crsObjSeriesDetail  = null;				
		CachedRowSet  crsObjMatchType = null;
		CachedRowSet  crsObjMatchCategory = null;	
		CachedRowSet  crsObjSeason = null;		
				
		Vector vparam =  new Vector();		
		GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
		
		String insertMessage = null;
		vparam.add("1");//
		crsObjTournamentNm = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_series_ms",vparam,"ScoreDB");		
		crsObjMatchType = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_matchtype_ms",vparam,"ScoreDB");
		crsObjMatchCategory = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_matchcategory_ms",vparam,"ScoreDB");
		crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");	
		vparam.removeAllElements();

		if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit")){
		/*For insertion of record in database.*/
		String gsTournamentId =	request.getParameter("TournamentId");
		String gsSeason=	request.getParameter("SeasonId");

		String gsDescription  =	request.getParameter("description");
		//String gsMatchTypeId =	request.getParameter("MatchTypeId");
		String gsMtchCategory =	request.getParameter("MatchCategoryId");
		String gsMaxMatches =	request.getParameter("maxMateches");

		vparam.add(gsTournamentId);
        vparam.add(gsSeason);
        vparam.add(gsDescription);
      //  vparam.add(gsMatchTypeId);
        vparam.add(gsMtchCategory);
        vparam.add(gsMaxMatches);
		crsObjSeriesDetail = lobjGenerateProc.GenerateStoreProcedure("esp_amd_Series",vparam,"ScoreDB");
		vparam.removeAllElements();//End of Insertion
		if(crsObjSeriesDetail.next()){
			insertMessage = crsObjSeriesDetail.getString("RetVal");
			//System.out.println("insertMessage "+insertMessage);
		}
	}
%>
<html>
<head>
	<title> Official Data </title>
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
	<script language="javascript">
		function callNextPage(){

			if(document.getElementById('dpseason').value == "" || document.getElementById('dpmatchCategory').value == "" ||
			document.getElementById('dptournament').value == "" || document.getElementById('dpMatchType').value == "" ||
			document.getElementById('txttotalmatchNo').value == "" || document.getElementById('txtDescription').value == "" )
			{
				alert("Please enter data in all fields");
			}else {
							 			 	
				 	var TournamentArr = (document.getElementById('dptournament').value).split("~"); // Combo Value
				 	var SeasonArr = (document.getElementById('dpseason').value).split("~");
				 	var MatchCategoryArr = (document.getElementById('dpmatchCategory').value).split("~"); // Combo Value
				 	var MatchTypeArr = (document.getElementById('dpMatchType').value).split("~"); // Combo Value

				 	var MatchCategoryId = MatchCategoryArr[0]; // Set match category Id;
				 	var MatchCategoryName = MatchCategoryArr[1]; // Set match category Name;

				 	var TournamentId = TournamentArr[0]; // Set tournament Id;
				 	var TournamentName = TournamentArr[1]; // Set tournament Name;

				  	var SeasonId = SeasonArr[0]; // Set Season Id;
				 	var SeasonName = SeasonArr[1]; // Set Season Name;

				 	var MatchTypeId = MatchTypeArr[0]; // Set match category Id;
				 	var MatchTypeName = MatchTypeArr[1]; // Set match category Name;

				 	var description = document.getElementById('txtDescription').value;
				 	var season = document.getElementById('dpseason').value;
				 	//this.NumberValidate(season);
				 	var maxMateches = document.getElementById('txttotalmatchNo').value;

					document.getElementById("hdSubmit").value = "submit";

					document.frmSeriesMaster.action ="SeriesSelectionMaster.jsp?TournamentId="+TournamentId+"&MatchTypeId="+MatchTypeId+"&MatchCategoryId="+MatchCategoryId+"&description="+description+"&season="+season+"&maxMateches="+maxMateches+"&SeasonId="+SeasonId;
					document.frmSeriesMaster.submit();
				}
		}
		function cancellation(){
			document.frmSeriesMaster.action = "SeriesSelectionMaster.jsp";
			document.frmSeriesMaster.submit();
		}
		function ChangePage(){
			var flag = "1";
			var r = confirm("Do you Want to Register New Series ?");
            	if (r == true)
            	{
            		window.open("SeriesTypeMaster.jsp?flag="+flag,"CIMS","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=20,left=20,width=500,height=400");
                }else
                	{
                		document.frmSeriesMaster.action = "SeriesSelectionMaster.jsp";
                    }
                   document.frmSeriesMaster.submit();
		}
		/*function NumberValidate(){
				var seasonarr = document.getElementById('txtseason').value;
				var index = seasonarr.indexOf("-");
				alert(index);
				//var subStrPre = seasonarr[0]; // Set venue Id;
				//var subStrPost = seasonarr[1]; // Set venue Name;
				var patt1 = /\d{4}/g;
		 		if(subStrPre.match(patt1) && subStrPost.match(patt1)){
					return true;
				}else{
					alert("Insert Only Numbers In Given Format");
					return false;
				}	
		}*/	 
		// to change textfield color		
			function changeColour(which) {
				if (which.value.length > 0) {   // minimum 2 characters
					which.style.background = "#FFFFFF"; // white
				}
				else {
					which.style.background = "";  // yellow
					//alert ("This box must be filled!");
					//which.focus();
					//return false;
				}
			}
	</script>
</head>
<body > 
<jsp:include page="Menu.jsp"></jsp:include> 
	<FORM name="frmSeriesMaster" id="frmSeriesMaster" method="post">
	<br>	
	<br>	
	<br>	
			
		<table width="780" border="0" align="center" cellpadding="2"
		cellspacing="1" class="table">
			<tr align="center">
				 <td align="left" colspan="9" bgcolor="#FFFFFF" class="leg">Tournament Master
				 </td>
			</tr>
			<tr>
				<td>
					<fieldset><legend class="legend1">Tournament Details
						</legend> <br>
			 		<table width="95%" border="0" align="center" cellpadding="2"
						cellspacing="1" class="table" >
						<tr align="left" class="contentDark">
							<td nowrap="nowrap">&nbsp;Tournament Name :</td>							
						   	<td nowrap="nowrap">
								<select onfocus = "this.style.background = '#FFFFCC'"style="width:6.2cm" class="inputField" name="dptournament" id="dptournament" >
								<!--<option>Select </option>-->
<%if(crsObjTournamentNm != null){
	while(crsObjTournamentNm.next()){					
%>
									<option value="<%=crsObjTournamentNm.getString("id")+"~"+crsObjTournamentNm.getString("name")%>" selected="selected"><%=crsObjTournamentNm.getString("name")%></option>
<%	
							}
						}	
%>
							    </select>
							    <input type="button" class="button1" id="btnmatchtype" name="btnmatchtype" value="..."  size="2" onclick="ChangePage()" >
							</td>							 
						   	<td>Season :</td>						   	
						   	<td>
								<select onfocus = "this.style.background = '#FFFFCC'"style="width:6.2cm" class="inputField" name="dpseason" id="dpseason">
								<!--<option>Select </option>-->
<%if(crsObjSeason != null){
	while(crsObjSeason.next()){					
%>
									<option value="<%=crsObjSeason.getString("id")+"~"+crsObjSeason.getString("name")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>
<%	
							}
						}	
%>
							    </select>
							</td>
						</tr>
						
						<tr class="contentLight">
			   				<td>&nbsp;&nbsp;Match Category :</td>			   				
							<td>
								<select onfocus = "this.style.background = '#FFFFCC'"style="width:6.2cm" class="inputField" name="dpmatchCategory" id="dpmatchCategory">
								<!--<option>Select </option>-->
<%if(crsObjMatchCategory != null){
	while(crsObjMatchCategory.next()){					
%>
									<option value="<%=crsObjMatchCategory.getString("id")+"~"+crsObjMatchCategory.getString("name")%>" selected="selected"><%=crsObjMatchCategory.getString("name")%></option>
<%
							}
						}	
%>
							    </select>
							</td> 
							<td>Match Type:</td>							
							<td>
								<select onfocus = "this.style.background = '#FFFFCC'"style="width:6.2cm" class="inputField" name="dpMatchType" id="dpMatchType" >
								<!--<option>Select </option>-->
<%if(crsObjMatchType != null){
	while(crsObjMatchType.next()){					
%>
									<option value="<%=crsObjMatchType.getString("id")+"~"+crsObjMatchType.getString("name")%>" selected="selected"><%=crsObjMatchType.getString("name")%></option>
<%

							}
						}	
%>
							    </select>
							</td> 							
						</tr>
						<tr class="contentDark">
							<td>&nbsp;&nbsp;Description :</td>							
						   	<td>
						   		<input class="textBoxAdmin" type="text" id="txtDescription" name="txtDescription" value="" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)">								
							</td> 			   								
							<td nowrap="nowrap">No of matches:</td>							
			   				<td>
								<input class="textBoxAdmin" type="text" id="txttotalmatchNo" name="txttotalmatchNo"  size="5" value="5" onfocus = "this.style.background = '#FFFFCC'"  onblur = "changeColour(this)">	
							</td> 							   			
						</tr>			 					
						<tr width="100%" align="right" class="contentLight">				
	       		
				       		<td  align="right" colspan="4">
				       			<input type="button" class="button1" id="btnsubmit" name="btnsubmit" value=" Submit" onclick="callNextPage()">
				      			<input type="button" class="button1" id="btnCancel" name="btnCancel" value="Cancel" onclick="cancellation()" >	 
				      			<input type="hidden" id="hdSubmit" name="hdSubmit" value="">      			     			     			
				       		</td>
				    	</tr>
	    	
												
					</table> 
					<br>
					</fieldset> 	
				</td>
			</tr>						
			<%if(insertMessage != null){
				if(insertMessage.equalsIgnoreCase("This series has been already created for current season!")){%>
				<tr>
					<td align="left"><label style="color: red;"><%=insertMessage%></label></td>
				</tr>
				<%}else{%>
				<tr>
					<td align="left"><label ><%=insertMessage%></label></td>
				</tr>
				<%}
			}%>			
			
	    </table>
	    
	    
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
	<br><br>
		<br>
		<br>
		<br>
			</form>
</body>
<jsp:include page="admin/Footer.jsp"></jsp:include>	
</html>

