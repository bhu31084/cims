<%@ page import="sun.jdbc.rowset.CachedRowSet,
                 in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
                 java.util.*"%>
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
    try {
    	CachedRowSet lobjCachedRowSet = null;
    	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
        Vector vparam = new Vector();
       	String val = request.getParameter("val");
       	System.out.println("inningid--" + request.getParameter("inning"));
     	System.out.println("matchId1--" + request.getParameter("matchid"));
     	session.setAttribute("InningId",request.getParameter("inning"));
	   	session.setAttribute("matchId1",request.getParameter("matchid"));
    	if(val.equals("1")){
    	  vparam.add("1");
          lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("dummy_truncate", vparam, "ScoreDB"); // Batsman List
          vparam.removeAllElements();
          response.sendRedirect("/cims/jsp/selectbatsmanbowlers.jsp");
    	}else if(val.equals("2")){
    		 response.sendRedirect("/cims/jsp/selectbatsmanbowlers.jsp");
    	}

	} catch (Exception e) {
   	 e.printStackTrace();
   	 }
%>   	 
<html>
<head>
<title>demo</title>
	<script language="javascript">
		function remove(){
			document.getElementById("val").value = "1"
			document.demo.action = "/cims/jsp/demo.jsp"
			
			document.demo.submit();
		}
		function ok(){
			var abc="a";
			winhandle = window.open("/cims/jsp/temp.jsp?bowlerName="+abc+"&BowlerId="+abc+" &BatsMan1=abc~10" +"&BatsMan2=abc~11&Inning="+document.getElementById("inning").value+"&matchid="+document.getElementById("matchid").value,"CIMS","location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,top=0,left=0,width="+(window.screen.availWidth-20)+",height="+(window.screen.availHeight-30));	
		 		//document.Selection.action = "jsp/scorer.jsp?bowlerName="+bowlerName+"&BowlerId="+BowlerId+" &BatsMan1="+bat1+" &BatsMan2="+bat2;
				//document.Selection.submit();		 	
				if (winhandle != null){
			        window.opener="";
			        window.close();
    			}
		}
	</script>
</head>
<body>
<form name="demo">
<input type="hidden" name="val" id="val" value="" >
<input type="text" name="inning" id="inning" value="1">
<input type="text" name="matchid" id="matchid" value="1">
<input type="button" name="new" id="new" value="New Match" onclick="remove()">
<input type="button" name="old" id="old" value="Old Match" onclick="ok()">
</form>
</body>
</html>
