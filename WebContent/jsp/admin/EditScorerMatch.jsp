<!--
Page Name 	 : jsp/.jsp
Created By 	 : Vaibhav Gaikar.
Created Date : 13 April 2009
Description  : Add / Remove Edit option for scorer.
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="java.text.SimpleDateFormat"%>

<% 	GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
	CachedRowSet  			crsObjScorer			=	null;
	CachedRowSet  			crsObjMatches			=	null;
	CachedRowSet			crsObjEditMatches		 =   null;
	Vector 					vparam 					=  	new Vector();
%>
<% 
	String firstName = "";
	String middleName = "";
	String lastName = "";
	String hiddenId = "";
	String scorerId = "";
	String matchId = "";
	int cssCounter = 1;
	hiddenId = request.getParameter("hiddenId")!=null?request.getParameter("hiddenId"):"";
	scorerId = request.getParameter("selScorer")!=null?request.getParameter("selScorer"):"";
%>

<%	try{
		 vparam.add("1"); 
		 vparam.add("");
		 vparam.add("");
		 vparam.add("");
		 crsObjScorer = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scorer",vparam,"ScoreDB");
		 vparam.removeAllElements();
	}
	catch(Exception e){
		System.out.println("Exception 6" +e.getMessage());
	}

	try{		
		if (hiddenId!=null && hiddenId.equalsIgnoreCase("2")){  // to get all scorer matches 
				 vparam.add("2"); 
				 vparam.add(scorerId);
				 vparam.add("");
				 vparam.add("");
				 crsObjMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scorer",vparam,"ScoreDB");
				 vparam.removeAllElements();
		}
	}
	catch(Exception e){
		System.out.println ("Exception 4" +e.getMessage());
	}

	try{		
		if (hiddenId!=null && hiddenId.equalsIgnoreCase("3")){
				 vparam.add("6"); 
				 vparam.add(scorerId);
				 vparam.add("");
				 vparam.add("");
				 crsObjEditMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scorer",vparam,"ScoreDB");
				 vparam.removeAllElements();
		}
	}
	catch(Exception e){
		System.out.println ("Exception 4" +e.getMessage());
	}

	
	try{		
		if (hiddenId!=null && hiddenId.equalsIgnoreCase("3")){  // to add scorer matches
			String[] chkMatchId = request.getParameterValues("chkMatchId");
			if (chkMatchId!=null)
			{
				for (int i=0;i<chkMatchId.length;i++)
				{
					scorerId = request.getParameter("hidScorerId")!=null?request.getParameter("hidScorerId"):"";
					vparam.add("3");
					vparam.add(scorerId);
					vparam.add(chkMatchId[i]);
					vparam.add("A");
					crsObjEditMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scorer",vparam,"ScoreDB");
					vparam.removeAllElements();
				}
			}
		}
	}
	catch(Exception e){
		System.out.println ("Exception 4" +e.getMessage());
	}
	
	try{		
		if (hiddenId!=null && hiddenId.equalsIgnoreCase("3")){
				 vparam.add("2"); 
				 vparam.add(scorerId);
				 vparam.add("");
				 vparam.add("");
				 crsObjMatches = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_scorer",vparam,"ScoreDB");
				 vparam.removeAllElements();
		}
	}
	catch(Exception e){
		System.out.println ("Exception 4" +e.getMessage());
	}
%>
<html>
  <head>
     <script>
	    function getScorerMatches(){
		  var scorerId = document.getElementById("selScorer").value ;
		  if (scorerId=="0"){
			alert("Select Scorer");
			return false;
		  }
		  document.getElementById("hiddenId").value =1;
		  document.frmEditScorerMatch.submit();
		}

		 function addScorer(){
			var scorerId = document.getElementById("selScorer").value ;
			if (scorerId=="0"){
				alert("Select Scorer");
				return false;
			}
			
			document.getElementById("hiddenId").value =2;
			document.frmEditScorerMatch.submit();
		}

		function deleteScorer(userid,matchid)
		{
			document.getElementById("hiddenId").value =3;
			document.getElementById("frmEditScorerMatch").action="/cims/jsp/admin/EditScorerMatch.jsp?userid="+userid+"&matchid="+matchid;
			document.getElementById("frmEditScorerMatch").submit();
		}

		function saveData()
		{
			document.getElementById("hiddenId").value = 3
			document.frmEditScorerMatch.submit();
		}

		function selectAll()
		{
			var chkparent  = document.frmEditScorerMatch.chkMain;
			var chkChild  = document.frmEditScorerMatch.chkMatchid;
			if (chkparent.checked)
			{
				for (var i=0;i<chkChild.length;i++)
				{
					chkChild[i].checked =true;
				}
			}
			else
			{
				for (var i=0;i<chkChild.length;i++)
				{
					chkChild[i].checked=false;
				}
			}
		}
	 </script>
	 <link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
		<jsp:include page="Menu.jsp"/>
		<div class="leg">To Give Edit Match Option To Scorer</div>
		<div class="portletContainer">
		<form name="frmEditScorerMatch" id="frmEditScorerMatch" method="post">
			<input type="hidden" name="hiddenId" id="hiddenId" value="">
			</br></br></br>
			<table border=1 width=80% align=center cellspacing=0>
			 
			  <tr class="contentDark">
			  	 <td class="colheadinguser" align=center>Select Match Scorer</td>
				<td>
					<select id="selScorer" name="selScorer"  class="input">
					    <option value="0">-Select-</option>
<%						try
						{		
						if (crsObjScorer!=null)
						{
						while(crsObjScorer.next())
						{
							firstName = crsObjScorer.getString("fname")!=null?crsObjScorer.getString("fname"):"";
							middleName = crsObjScorer.getString("mname")!=null?crsObjScorer.getString("mname"):"";
							lastName = crsObjScorer.getString("sname")!=null?crsObjScorer.getString("sname"):"";
%>
							<option value="<%=crsObjScorer.getString("id")%>" <%=scorerId.equalsIgnoreCase(crsObjScorer.getString("id"))?"selected":""%>>
							<%=firstName%>&nbsp;<%=middleName%>&nbsp;<%=lastName%>
							</option>
<%  
						}
						}// end of if
						}// end of try
						catch(Exception e)
						{
							System.out.println ("Exception fdbdb" +e.getMessage());
						}
%>
					  </select>
					</td>
					
		
					  <td><input type="button" name="Enable" value="Show Matches" onclick="addScorer()" class="btn btn-warning"></td>
					</tr>
				  </table>
				  <br>
				  <br>
				  <table width="80%"  border=1 cellspacing=0 align=center id="tablematches">
					<tr>
						<td colspan=7 align =center><b>Scorer Match Details</b></td>
					</tr>
					<tr >
						<td width=5% align=center class="colheadinguser" nowrap>Select All <input type=checkbox name="chkMain" id="chkMain" onclick="selectAll()"></td>
						<td width=5% align=center class="colheadinguser" nowrap>MatchId</td>
						<td width=20% align=center class="colheadinguser" nowrap>TeamOne</td>
						<td width=20% align=center class="colheadinguser" nowrap>TeamTwo</td>
						<td width=10% align=center class="colheadinguser" nowrap>Expected_Start</td>
						<td width=10% align=center class="colheadinguser" nowrap>Expected_End</td>
						<td width=30% align=center class="colheadinguser" nowrap>Venue</td>
					</tr>
<%	
	if (crsObjMatches!=null)
	{
		while (crsObjMatches.next())
		{
			if (cssCounter%2!=0)
			{
%>
					<tr class="contentLight">
<%			}
			else
			{
%>
					<tr class="contentDark">
<%			}
			cssCounter ++;
%>
<%			String status = crsObjMatches.getString("status")!=null?crsObjMatches.getString("status"):"";
			if(status.trim().equalsIgnoreCase("A"))
			{
%>
						<td width=5% align=center nowrap><input type=checkbox name="chkMatchId" id="chkMatchid"  
						value="<%=crsObjMatches.getString("matchid")%>" checked ></td>
<%			}
			else
			{
%>						<td width=5% align=center nowrap><input type=checkbox name="chkMatchId" id="chkMatchid"  
						value="<%=crsObjMatches.getString("matchid")%>"  ></td>

<%			}
%>
						<td width=5% nowrap align=center><%=crsObjMatches.getString("matchid")!=null?crsObjMatches.getString("matchid"):""%></td>
						<td width=20% nowrap align=center><%=crsObjMatches.getString("teamone")!=null?crsObjMatches.getString("teamone"):""%></td>
						<td width=20% nowrap align=center><%=crsObjMatches.getString("teamtwo")!=null?crsObjMatches.getString("teamtwo"):""%></td>
						<td width=15% nowrap align=center><%=crsObjMatches.getString("expected_start")!=null?crsObjMatches.getString("expected_start"):""%></td>
						<td width=15% nowrap align=center><%=crsObjMatches.getString("expected_end")!=null?crsObjMatches.getString("expected_end"):""%></td>
						<td width=20% nowrap align=center><%=crsObjMatches.getString("venue")!=null?crsObjMatches.getString("venue"):""%></td>
					</tr>
<%		}
	}
%>			
				</table>
				<br>
				<table align=center width="80%">
					<tr>
						<td align=center><input type=button name="save" value="save" onclick="saveData()" class="btn btn-warning"></td>
					</tr>
				</table>
				<input type=hidden name="hidScorerId" id="hidScorerId" value="<%=scorerId%>">
			</form>
			</div>
			<jsp:include page="Footer.jsp"/>
		 </body>
	</html>