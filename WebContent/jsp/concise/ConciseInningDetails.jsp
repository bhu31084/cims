<!--
Page Name 	 : jsp/ConciseInningDetails.jsp
Created By 	 : Bhushan Fegade.
Created Date : 03 April 2009
Description  : Data Entry for Concise Matches.
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String 	GSDate			=	sdf.format(new Date());
	String query = request.getParameter("query");
	String HidId = request.getParameter("HidId")==null?"0":request.getParameter("HidId");
	String inning = request.getParameter("selinning")==null?"0":request.getParameter("selinning");
	String noball = request.getParameter("txtnoball")==null?"0":request.getParameter("txtnoball");
	String wideball = request.getParameter("txtwideball")==null?"0":request.getParameter("txtwideball");
	String byes = request.getParameter("txtbyes")==null?"0":request.getParameter("txtbyes");
	String legbyes = request.getParameter("txtlegbyes")==null?"0":request.getParameter("txtlegbyes");
	String penalty = request.getParameter("txtpenalty")==null?"0":request.getParameter("txtpenalty");
	String total = request.getParameter("txttotal")==null?"0":request.getParameter("txttotal");
	String wicket = request.getParameter("txtwicket")==null?"0":request.getParameter("txtwicket");
	String over = request.getParameter("txtover")==null?"0":request.getParameter("txtover");
	String MatchId = (String)session.getAttribute("matchId1");

	GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
	Common 					commonUtil				= 	new Common();
	LogWriter 				log 					= 	new LogWriter();
	Vector 					vparam 					=  	new Vector();
	CachedRowSet  			lobjCachedRowSet		=	null;
	CachedRowSet			crsObjinning			=	null;
	CachedRowSet			crsObjinningdeatils		=	null;
	CachedRowSet			crsObjinningdeyails		=	null;
	
	CachedRowSet			crsObjAddInning			=	null;
	String					 msg					=	"";
	
	if(HidId!=null && HidId.equalsIgnoreCase("1")){
		 try{
		 	 vparam.add(inning);
		 	 vparam.add(penalty);
		 	 vparam.add(byes);
		 	 vparam.add(legbyes);
		 	 vparam.add(noball);
		 	 vparam.add(wideball);
		 	 vparam.add(over);
		 	 vparam.add("1"); //1 flag insert
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_innings_deatils",vparam,"ScoreDB");
			 vparam.removeAllElements();
			  if(crsObjAddInning!=null){
			  	while(crsObjAddInning.next()){
			  		msg = crsObjAddInning.getString("result");
			  	}
			  }
		 }catch(Exception e){
		  log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}else if(HidId!=null && HidId.equalsIgnoreCase("2")){
		 try{
		 	 vparam.add(inning);
		 	 vparam.add(penalty);
		 	 vparam.add(byes);
		 	 vparam.add(legbyes);
		 	 vparam.add(noball);
		 	 vparam.add(wideball);
		 	 vparam.add(over);
		 	 vparam.add("2"); //1 flag update
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_innings_deatils",vparam,"ScoreDB");
			 vparam.removeAllElements();
			  if(crsObjAddInning!=null){
			  	while(crsObjAddInning.next()){
			  		msg = crsObjAddInning.getString("result");
			  	}
			  }
		 }catch(Exception e){
		  log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}
	else if(HidId!=null && HidId.equalsIgnoreCase("3")){
		 try{
		 	 vparam.add(inning);
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("7");
		 	 vparam.add("3"); //1 flag insert
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_innings_deatils",vparam,"ScoreDB");
			 vparam.removeAllElements();
			  if(crsObjAddInning!=null){
			  	while(crsObjAddInning.next()){
			  		msg = crsObjAddInning.getString("result");
			  	}
			  }
		 }catch(Exception e){
		  log.writeErrLog(page.getClass(),MatchId,e.toString());
		}
	}else if(HidId!=null && HidId.equalsIgnoreCase("4")){
		try{
		 vparam.add(inning);
		 vparam.add("2"); //1 flag for display match wise data
	 	 crsObjinningdeatils = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_innings_details",vparam,"ScoreDB");
	  	 vparam.removeAllElements();
	  	 if(crsObjinningdeatils!=null){
	  	 	while(crsObjinningdeatils.next()){
		  	 	inning = crsObjinningdeatils.getString("inning")==null?"0":crsObjinningdeatils.getString("inning");
		  	 	penalty  = crsObjinningdeatils.getString("penalty_extras")==null?"": crsObjinningdeatils.getString("penalty_extras");
			  	byes  = crsObjinningdeatils.getString("byes")==null?"": crsObjinningdeatils.getString("byes");
			  	legbyes = crsObjinningdeatils.getString("leg_byes")==null?"0": crsObjinningdeatils.getString("leg_byes");
		  	 	noball = crsObjinningdeatils.getString("no_balls")==null?"0": crsObjinningdeatils.getString("no_balls");
		  	 	wideball = crsObjinningdeatils.getString("wides")==null?"0": crsObjinningdeatils.getString("wides");
		  	 	over = crsObjinningdeatils.getString("total_overs_played")==null?"0": crsObjinningdeatils.getString("total_overs_played");
	  	 	}
	  	 }
	}catch(Exception e){
	  log.writeErrLog(page.getClass(),MatchId,e.toString());	
	}
	}
	if(HidId!=null && (HidId.equalsIgnoreCase("1") || HidId.equalsIgnoreCase("2") || HidId.equalsIgnoreCase("3"))){
		response.sendRedirect("/cims/jsp/concise/ConciseMatchTab.jsp?tab=2");
		return;
	}
	
	try{
	 vparam.add(MatchId);
	 vparam.add("1"); //1 flag for display match wise data
	 crsObjinning = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_innings",vparam,"ScoreDB");
	 vparam.removeAllElements();
	}catch(Exception e){
	  log.writeErrLog(page.getClass(),MatchId,e.toString());	
	}
	try{
	 vparam.add(MatchId);
	 vparam.add("1"); //1 flag for display match wise data
	 crsObjinningdeyails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_innings_details",vparam,"ScoreDB");
	 vparam.removeAllElements();
	}catch(Exception e){
	  log.writeErrLog(page.getClass(),MatchId,e.toString());	
	}
%>

<html>
  <head>
    <title>Inning Details</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<style type="text/css">
	A { text-decoration:none;}
	A:link	{color:black;}
	A:visited{color: blue;}
	A:hover	{color: red;background-color:#66ffff;}
	 .tab { font-weight:bold;font-size:9px; font-family:Arial,Helvetica;color:olive;}
	 .tabc { font-weight:bold; font-size:9px; text-align:center; font-family:Arial,Helvetica;color:navy;}
	 .tabb { font-weight:bold; font-size:9px; font-family:Arial,Helvetica;}
	 .tanc {FONT-WEIGHT: bold;FONT-SIZE: 9px; COLOR: navy; FONT-FAMILY: Arial,Helvetica; TEXT-ALIGN: center;}
	 .tabt { font-weight:bold; font-size:9px; font-family:Arial,Helvetica;TEXT-ALIGN: center;}
	 
</style>
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
  </head>
  <body>

  	
  	<div style="height:10em">
    <table style="width:70em;"  border="0"  cellspacing="1" cellpadding="3">
	  <tr>
        <td colspan="10" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          <center>Match Details Entry Module</center>
        </td>
      </tr>
       <tr>
        <td colspan="10" width="70em" >
          <center><font color="red"><b><%=msg%></b></font></center>
        </td>
      </tr>
      <tr bgcolor="#f0f7ff"  width="70em">
        <td align="center" width="10%"><b>Innings</b></td>
        <td align="center" width="10%"><b>No Balls</b></td>
        <td align="center" width="10%"><b>Wide Balls</b></td>
        <td align="center" width="10%"><b>Byes</b></td>
        <td align="center" width="10%"><b>Leg Byes</b></td>
        <td align="center" width="10%"><b>Penalty</b></td>
        <td align="center" width="10%"><b>Overs</b></td>
        <td align="center" width="10%"><b>Extra's Total</b></td>
        <td align="center" width="10%">&nbsp;</td>
      </tr>
      <tr bgcolor="#e6f1fc" height="5%">
        <td align="center">
          <select id="selinning" name="selinning" tabindex="1">
<%	  	  try{
	  		if(crsObjinning!=null){
	  		int i = 1;
	  		while(crsObjinning.next()){
%>          <option value="<%=crsObjinning.getString("id")%>" <%= crsObjinning.getString("id").equalsIgnoreCase(inning)?"selected":""%>>Inning <%=i%></option>
<%			i++;
			}// end of while
		    }
		 }catch(Exception e){
	 		log.writeErrLog(page.getClass(),MatchId,e.toString());
		 }   	
%>            
          </select>
        </td>
        <td align="center">
          <input type="text" name="txtnoball" id="txtnoball" onfocus="clearTextBox('txtnoball')" onblur="fillZero('txtnoball')"   value="<%=noball%>" class="textBox" tabindex="2"  onKeyPress="return keyRestrict(event,'1234567890');" onblur="calextratotal();">
        </td>
        <td align="center">
          <input type="text" name="txtwideball" id="txtwideball" onfocus="clearTextBox('txtwideball')" onblur="fillZero('txtwideball')"   value="<%=wideball%>" class="textBox" tabindex="3"  onKeyPress="return keyRestrict(event,'1234567890');" onblur="calextratotal();">
        </td>
        <td align="center">
          <input type="text" name="txtbyes" id="txtbyes" onfocus="clearTextBox('txtbyes')" onblur="fillZero('txtbyes')"   value="<%=byes%>" class="textBox" tabindex="4"  onKeyPress="return keyRestrict(event,'1234567890');" onblur="calextratotal();">
        </td>
        <td align="center">
          <input type="text" name="txtlegbyes" id="txtlegbyes" onfocus="clearTextBox('txtlegbyes')" onblur="fillZero('txtlegbyes')"   value="<%=legbyes%>" class="textBox" tabindex="5"  onKeyPress="return keyRestrict(event,'1234567890');" onblur="calextratotal();">
        </td>
        <td align="center">
          <input type="text" name="txtpenalty" id="txtpenalty" onfocus="clearTextBox('txtpenalty')" onblur="fillZero('txtpenalty')"   value="<%=penalty%>" class="textBox" tabindex="6"  onKeyPress="return keyRestrict(event,'1234567890');" onblur="calextratotal();">
        </td>
        <td align="center">
          <input type="text" name="txtover" id="txtover" onfocus="clearTextBox('txtover')" onblur="fillZero('txtover')"   value="<%=over%>" class="textBox" tabindex="7"  onKeyPress="return keyRestrict(event,'1234567890.');" onblur="calextratotal();">
        </td>
        <td align="center">
          <input type="text" name="txttotal" id="txttotal" value="<%=total%>" class="textBox" tabindex="8" readonly onKeyPress="return keyRestrict(event,'1234567890');" onblur="calextratotal();">
        </td>
        
        <td align="center">
<%			if(HidId!=null && HidId.equalsIgnoreCase("4")){
%>			<input type="button" name="btnadd" id="btnadd" value="Edit" class="btn" tabindex="9" onclick="inningdetails(2);">
<%			}else{
%>			<input type="button" name="btnadd" id="btnadd" value="Add" class="btn" tabindex="9" onclick="inningdetails(1);">
<%			}
%>        
      </td>
      </tr>
    </table>
    </div>
    <div id="viewdiv" style="overflow: auto; height:15em;" >
    <table style="width:70em;" border="0"  cellspacing="1" >
	  <tr>
        <td colspan="11" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          <center>View Data</center>
        </td>
      </tr>
      <tr bgcolor="#f0f7ff" >
        <td align="right" width="10%"><b>Innings</b></td>
        <td align="right" width="10%"><b>No Balls</b></td>
        <td align="right" width="10%"><b>Wide Balls</b></td>
        <td align="right" width="10%"><b>Byes</b></td>
        <td align="right" width="10%"><b>Leg Byes</b></td>
        <td align="right" width="10%"><b>Penalty</b></td>
        <td align="right" width="10%"><b>Overs</b></td>
        <td align="right" width="10%"><b>Extra's Total</b></td>
        <td align="center" width="10%">&nbsp;</td>
        <td align="center" width="10%">&nbsp;</td>
      </tr>
<%	  try{
	  if(crsObjinningdeyails!=null){
	  int i = 1;
	  while(crsObjinningdeyails.next()){
	  	  if(i%2==0){
%>    <tr bgcolor="#f0f7ff">
<%	  }else{
%>	  <tr bgcolor="#e6f1fc">	
<%	  }
%>		
    <tr bgcolor="#e6f1fc" >
        <td align="right">Inning <%=i%></td>
        <td align="right"><%=crsObjinningdeyails.getString("no_balls")%></td>
        <td align="right"><%=crsObjinningdeyails.getString("wides")%></td>
        <td align="right"><%=crsObjinningdeyails.getString("byes")%></td>
        <td align="right"><%=crsObjinningdeyails.getString("leg_byes")%></td>
        <td align="right"><%=crsObjinningdeyails.getString("penalty_extras")%></td>
        <td align="right"><%=crsObjinningdeyails.getString("total_overs_played")%></td>
        <td align="right"><%= Integer.parseInt(crsObjinningdeyails.getString("no_balls")) + 
        					   Integer.parseInt(crsObjinningdeyails.getString("wides")) + 
        					   Integer.parseInt(crsObjinningdeyails.getString("byes")) + 
        					   Integer.parseInt(crsObjinningdeyails.getString("leg_byes")) + 
        					   Integer.parseInt(crsObjinningdeyails.getString("penalty_extras"))%>
        </td>
        <td align="center"><a href="/cims/jsp/concise/ConciseMatchTab.jsp?tab=2&inning=<%=crsObjinningdeyails.getString("inning")%>&HidId=4">Edit</a></td>
        <td align="center" ><a href="/cims/jsp/concise/ConciseInningDetails.jsp?selinning=<%=crsObjinningdeyails.getString("inning")%>&HidId=3">Delete</a></td>
      </tr>
<%	i++;
	 }
     }// end of if
     }catch(Exception e){
	  log.writeErrLog(page.getClass(),MatchId,e.toString());
	}
%>      
     
    </table>   
 <input type="hidden" name="HidId" id="HidId" value="0">
  </body>	
</html>