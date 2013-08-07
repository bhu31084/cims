<!--
Page Name 	 : updateRow.jsp
Created By 	 : Dipti Shinde.
Created Date : 21-Oct-2008
Description  : To update individual ball
Company 	 : Paramatrix Tech Pvt Ltd.
Modified Date: 21-Oct-2008
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>

<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="java.util.*"%>

<html>
<head>
<title>Match Innings</title>
<link href="../css/csms.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../js/callfunction.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/ajax.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/popup.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/common.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/datetimepicker.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/Calender.js" type="text/javascript"></script>
 
<script language="javascript">
	
	function showOvers(inningId,inningNumber){
		try{
			window.open("/cims/jsp/updateInningsOver.jsp?inningsId="+inningId+"&inningNumber="+inningNumber,"CIMSINNINGS","location=no,directories=no,status=Yes,menubar=Yes,scrollbars=Yes,resizable=Yes,top=0,left=0,width="+(window.screen.availWidth)+",height="+(window.screen.availHeight))
		}catch(err){
			alert(err.description + 'updateMatchInnings.jsp.showOvers()');
		}
	}
	
	function previousPage(){
		try{
			var role = document.getElementById('hdRole').value
			if(role == 9){
				document.getElementById("frmupdateMatchInnings").action="../jsp/admin/EditMatch.jsp";//dipti 19 05 2009
			}else{
				document.getElementById("frmupdateMatchInnings").action="/cims/jsp/TeamSelection.jsp";
			}
			document.getElementById("frmupdateMatchInnings").submit();
			//self.close();
			
//			EditMatch.jsp
			/*if (winhandle != null){
				window.opener="";
		        window.close();
			}*/
		}catch(err){
			alert(err.description + 'updateMatchInnings.jsp.previousPage()');
		}
	} 
	
	function matchPoint(matchid){
		try{					
			window.open("/cims/jsp/MatchPoints.jsp?matchid="+matchid,"CIMSINNINGS3","location=no,directories=no,status=Yes,scrollbars=Yes,resizable=Yes,top=50,left=150,width="+(window.screen.availWidth-400)+",height="+(window.screen.availHeight-300))
		}catch(err){
			alert(err.description + 'updateMatchInnings.jsp.matchPoint()');
		}	
	} 

	function updateResult(matchid){
		try{					
			window.open("/cims/jsp/changeResult.jsp?matchId="+matchid+"&flag=1","CIMSINNINGS3","location=no,directories=no,status=Yes,scrollbars=Yes,resizable=Yes,top=50,left=150,width="+(window.screen.availWidth-400)+",height="+(window.screen.availHeight-300))
		}catch(err){
			alert(err.description + 'updateMatchInnings.jsp.updateResult()');
		}	
	}
</script>

</head>
<%	
	try{
		String loginUserName = null;
		String userID = null;
		String role=null;
		loginUserName = session.getAttribute("usernamesurname").toString();
		userID = session.getAttribute("userid").toString();
		session.setAttribute("userId",userID);

		String matchId = request.getParameter("matchId");
		String inningId = request.getParameter("inningsId");
		if(session.getAttribute("InningId") == null){
			session.setAttribute("InningId",inningId);
			session.setAttribute("matchId",matchId);
			session.setAttribute("matchId1",matchId);
		}
		// matchId = request.getParameter("matchId");
		/*else{
           	inningId = (String)session.getAttribute("InningId");
           	matchId = (String)session.getAttribute("matchId1");
		}*/
		if(matchId == null){
			matchId = (String)session.getAttribute("matchId");
		}
		String scorer_Id = (String)session.getAttribute("userid");
		CachedRowSet inningsCrs = null;
		CachedRowSet roleCrs = null;
		GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure();
		Vector spParam = new Vector();
		LogWriter log = new LogWriter();
		
		try{
			if(matchId != null){
System.out.println("matchId=====>"+matchId);			
				spParam.add(matchId); 
			}	
			inningsCrs = spGenerate.GenerateStoreProcedure("esp_dsp_getinnings",spParam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************updateMatchInnings.jsp*****************"+e);
			//e.printStackTrace();
			log.writeErrLog(page.getClass(),matchId,e.toString());
		}
		
		
			spParam.removeAllElements();
	        spParam.add(userID);
			roleCrs = spGenerate.GenerateStoreProcedure("esp_adm_loginrole", spParam, "ScoreDB");

			if(roleCrs!=null){
			while(roleCrs.next()){
			role=roleCrs.getString("role");
			System.out.println("role is "+role);
			}
			}
			
			if(role != null && role.equals("9")){
				session.setAttribute("role",role);
				String r = (String)session.getAttribute("role");
				System.out.println("role....."+r);
			}else{
				session.setAttribute("role",role);//if not admin
			}
%>
<body>
<jsp:include page="MenuScorer.jsp"></jsp:include> 
<br>
<br>
	<form name="frmupdateMatchInnings" id="frmupdateMatchInnings" method="POST">
	
		<div  id="BackgroundOverDiv" class="backgrounddiv">
		</div>
	
		<table  align="center" width="50%">
			<tr>
				<td  align="left">
					<input type="button" value="Back" onclick="previousPage()">
				</td>
			</tr>	
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr class="tenoverupdateball">
				<th align="center" ><b>Match Id : <%=matchId%></b></th>
			</tr>
		</table>
			
		<table align="center" width="50%">
<%				if(inningsCrs != null){	
					int inningNumber = 1;
					while(inningsCrs.next()){
					int inning = inningsCrs.getInt("inning");
%>			<tr class="contentLastDark"><td align="center"><a  href="javascript:showOvers('<%=inning %>','<%=inningNumber%>')">Innings : <%=inningNumber%></a></td></tr>
<%					inningNumber++;
					}
				}
%>			<tr>
				<td>
					<center><input type="button" value="Match Point" onclick="matchPoint(<%=matchId%>)"/>
					<input type="button" value="Edit Result" onclick="updateResult(<%=matchId%>)">
					</center>
				</td>
			</tr>
		</table>
		<br>
		<input type="hidden" id="hdRole" name="hdRole" value="<%=role%>">
	</form>
</html>
<%	}catch(Exception e){
		System.out.println("*************updateMatchInnings.jsp*****************"+e);
		e.printStackTrace();
	}
%>



