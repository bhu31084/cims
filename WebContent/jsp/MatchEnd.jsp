<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.util.*"
%>	
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
	String matchId = session.getAttribute("matchId1").toString(); 
	String flag = request.getParameter("flag");
	CachedRowSet matchResultCrs = null;
    GenerateStoreProcedure		generateStProc 	=   new GenerateStoreProcedure(matchId);
	Vector spParamVec = new Vector();
	String result = "";
	String inning1TeamName ="0";
	String inning2TeamName ="0";
	String inning3TeamName ="0";
	String inning4TeamName ="0";
	String inning1 ="0";
	String inning2 ="0";
	String inning3 ="0";
	String inning4 ="0";
	
	spParamVec.add(matchId); 
	spParamVec.add(flag); 
	matchResultCrs = generateStProc.GenerateStoreProcedure("esp_dsp_testresult",spParamVec,"ScoreDB");
	
	if(matchResultCrs != null){	
		while(matchResultCrs.next()){
			inning1TeamName =matchResultCrs.getString("inn1")==null?"0":matchResultCrs.getString("inn1");
			inning2TeamName =matchResultCrs.getString("inn2")==null?"0":matchResultCrs.getString("inn2");
			inning3TeamName =matchResultCrs.getString("inn3")==null?"0":matchResultCrs.getString("inn3");
			inning4TeamName =matchResultCrs.getString("inn4")==null?"0":matchResultCrs.getString("inn4");
			inning1 =matchResultCrs.getString("inn1_score")==null?"0":matchResultCrs.getString("inn1_score");
			inning2 =matchResultCrs.getString("inn2_score")==null?"0":matchResultCrs.getString("inn2_score");
			inning3 =matchResultCrs.getString("inn3_score")==null?"0":matchResultCrs.getString("inn3_score");
			inning4 =matchResultCrs.getString("inn4_score")==null?"0":matchResultCrs.getString("inn4_score");
			result = result + matchResultCrs.getString("result");
			
		}
	}
%>
<html>
<head>
<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>
</head>
<body>
	<table>
		<tr>
			<td>
			    <%=inning1TeamName%> : <%=inning1%> 
			</td>
		</tr>
<% if (inning2.equalsIgnoreCase("0")){
   }else{	
%>
		<tr>
			<td>
				<%=inning2TeamName%> : <%=inning2%>
			</td>
		</tr>
<% }%>
<% if (inning3.equalsIgnoreCase("0")){
   }else{	
%>
	
		<tr>
			<td>
				<%=inning3TeamName%> : <%=inning3%>
			</td>
		</tr>
<% }%>
<% if (inning4.equalsIgnoreCase("0")){
   }else{
%>	
		<tr>
			<td>
				<%=inning4TeamName%> : <%=inning4%>
			</td>
		</tr>
<% }%>
		<tr>
			<td>
			<b>Result : <%=result%></b>
			</td>
		</tr>

	</table>
</body>
</html>