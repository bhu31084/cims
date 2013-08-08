<!--
Page Name 	 : jsp/ConciseBatting.jsp
Created By 	 : Bhushan Fegade.
Created Date : 07 April 2009
Description  : Data Entry for batting details.
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
	String MatchId = (String)session.getAttribute("matchId1");
	String cmbinning = request.getParameter("selinning")==null?"0":request.getParameter("selinning");
	GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
	Common 					commonUtil				= 	new Common();
	LogWriter 				log 					= 	new LogWriter();
	Vector 					vparam 					=  	new Vector();
	CachedRowSet  			crsObjinning			=	null;
	CachedRowSet  			crsObjbattinglist		=	null;
	CachedRowSet  			crsObjAddInning			=	null;
	CachedRowSet  			crsObjpatership			=	null;
	CachedRowSet  			crsObjbatsmandetails	=	null;
	
	String					msg						=	"";
	
	String wicket = request.getParameter("selwicket")==null?"0":request.getParameter("selwicket");
	String BatsmanOne = request.getParameter("selBatsmanOne")==null?"0":request.getParameter("selBatsmanOne");
	String BatsmanTwo = request.getParameter("selBatsmanTwo")==null?"0":request.getParameter("selBatsmanTwo");
	String Runs = request.getParameter("txtRuns")==null?"0":request.getParameter("txtRuns");
	String Balls = request.getParameter("txtBalls")==null?"0":request.getParameter("txtBalls");
	String Minutes = request.getParameter("txtMinutes")==null?"0":request.getParameter("txtMinutes");
	
	if(HidId!=null && HidId.equalsIgnoreCase("1")){
		 try{
		 	 vparam.add(cmbinning);
		 	 vparam.add(wicket);
		 	 vparam.add(BatsmanOne);
		 	 vparam.add(BatsmanTwo);
		 	 vparam.add(Runs);
		 	 vparam.add(Minutes);
		 	 vparam.add(Balls);
		 	 vparam.add("1"); //1 flag insert
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_concise_patershipdetails",vparam,"ScoreDB");
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
		 	 vparam.add(cmbinning);
		 	 vparam.add(wicket);
		 	 vparam.add(BatsmanOne);
		 	 vparam.add(BatsmanTwo);
		 	 vparam.add(Runs);
		 	 vparam.add(Minutes);
		 	 vparam.add(Balls);
		 	 vparam.add("2"); //2 flag update
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_concise_patershipdetails",vparam,"ScoreDB");
			 vparam.removeAllElements();
			 if(crsObjAddInning!=null){
			  	while(crsObjAddInning.next()){
			  		msg = crsObjAddInning.getString("result");
			  	}
			  }
		 }catch(Exception e){
		  log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}else if(HidId!=null && HidId.equalsIgnoreCase("3")){
		 try{
		 	 vparam.add(cmbinning);
		 	 vparam.add(wicket);
		 	 vparam.add(BatsmanOne);
		 	 vparam.add(BatsmanTwo);
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("3"); //3 flag delete
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_concise_patershipdetails",vparam,"ScoreDB");
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
		 vparam.add(cmbinning);
		 vparam.add(wicket); //1 flag for display match wise data
	 	 crsObjbatsmandetails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_patenershipdetails",vparam,"ScoreDB");
	  	 vparam.removeAllElements();
	  	 if(crsObjbatsmandetails!=null){
	  	 	while(crsObjbatsmandetails.next()){
		  	 	cmbinning = crsObjbatsmandetails.getString("inning")==null?"0":crsObjbatsmandetails.getString("inning");
		  	 	wicket	  = crsObjbatsmandetails.getString("wicket")==null?"0": crsObjbatsmandetails.getString("wicket");
			  	BatsmanOne   = crsObjbatsmandetails.getString("batter1")==null?"0": crsObjbatsmandetails.getString("batter1");
			  	BatsmanTwo  = crsObjbatsmandetails.getString("batter2")==null?"0": crsObjbatsmandetails.getString("batter2");
		  	 	Runs  = crsObjbatsmandetails.getString("runs")==null?"": crsObjbatsmandetails.getString("runs");
		  	 	Minutes  = crsObjbatsmandetails.getString("minutes")==null?"0": crsObjbatsmandetails.getString("minutes");
		  	 	Balls  = crsObjbatsmandetails.getString("balls")==null?"0": crsObjbatsmandetails.getString("balls");
	  	 	}
	  	 }
		}catch(Exception e){
		  log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
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
	 vparam.add(cmbinning);
	 crsObjbattinglist = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenList",vparam,"ScoreDB");
	 vparam.removeAllElements();
	}catch(Exception e){
	  log.writeErrLog(page.getClass(),MatchId,e.toString());	
	}
	try{
	 vparam.add(cmbinning);
	 crsObjpatership = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_concise_patenership",vparam,"ScoreDB");
	 vparam.removeAllElements();
	}catch(Exception e){
	  log.writeErrLog(page.getClass(),MatchId,e.toString());	
	}
	
	if(HidId!=null && (HidId.equalsIgnoreCase("1") || HidId.equalsIgnoreCase("2") || HidId.equalsIgnoreCase("3"))){
		response.sendRedirect("/cims/jsp/concise/ConciseMatchTab.jsp?tab=5&inning="+cmbinning);
		return;
	}
%>	

<html>
  <head>
    <title>Partnership Details</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="../../css/concise.css" rel="stylesheet" type="text/css" />
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
    <table style="width:70em;" border="0"  cellspacing="1" cellpadding="5">
	  <tr>
        <td colspan="8" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          <center>Partnership Details Entry Module</center>
        </td>
      </tr>
       <tr>
        <td colspan="8" width="100%" >
          <center><font color="red"><b><%=msg%></b></font></center>
        </td>
      </tr>
      <tr bgcolor="#f0f7ff" width="100%">
        <td align="center" width="10%">Innings</td>
        <td align="center" width="10%">Wicket</td>
        <td align="center" width="20%">Batsman 1</td>
        <td align="center" width="20%">Batsman 2</td>
        <td align="center" width="10%">Runs</td>
        <td align="center" width="10%">Balls</td>
        <td align="center" width="10%">Minutes</td>
        <td align="center" width="10%">&nbsp;</td>
      </tr>
      <tr bgcolor="#e6f1fc" height="5%">
        <td align="center">
          <select id="selinning" name="selinning" tabindex="1" onchange="patnership('5');">
            <option value="0">select</option>
<%       try{	
		 if(crsObjinning!=null){
	  		int i = 1;
	  		while(crsObjinning.next()){
%>           <option value="<%=crsObjinning.getString("id")%>" <%= crsObjinning.getString("id").equalsIgnoreCase(cmbinning)?"selected":""%>>Inning<%=i%></option>
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
          <select id="selwicket" name="selwicket" tabindex="2">
            <option value="0">0</option>
<%			
			for(int i=1;i<12;i++){
%>          <option value="<%=i%>" <%=wicket.equalsIgnoreCase(""+i+"")?"selected":""%>><%=i%></option>
<%				}
%>             
          </select>
        </td>
        <td align="center">
          <select id="selBatsmanOne" name="selBatsmanOne" tabindex="3">
            <option value="0">select</option>
<%	  	  try{
	  		if(crsObjbattinglist!=null){
	  		while(crsObjbattinglist.next()){         
%>          <option value="<%=crsObjbattinglist.getString("id")%>" 
					<%= crsObjbattinglist.getString("id").equalsIgnoreCase(BatsmanOne)?"selected":"" %>>
			<%=crsObjbattinglist.getString("playername")%></option>
<%			}// end of while
			crsObjbattinglist.first();
		    }
		    
		 }catch(Exception e){
	 		log.writeErrLog(page.getClass(),MatchId,e.toString());
		 }   	
%>                
          </select>
        </td>
        <td align="center">
          <select id="selBatsmanTwo" name="selBatsmanTwo" tabindex="4">
            <option value="0">select</option>
<%	  	  try{
	  		if(crsObjbattinglist!=null){
	  		int i = 0;
	  		while(crsObjbattinglist.next()){  
	  		if(i==0){
	 				crsObjbattinglist.first();
	  			}        
%>          <option value="<%=crsObjbattinglist.getString("id")%>"
					<%= crsObjbattinglist.getString("id").equalsIgnoreCase(BatsmanTwo)?"selected":"" %>>
			<%=crsObjbattinglist.getString("playername")%></option>
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
          <input type="text" name="txtRuns" id="txtRuns" onfocus="clearTextBox('txtRuns')" onblur="fillZero('txtRuns')" value="<%=Runs%>" class="textBox" tabindex="5" onKeyPress="return keyRestrict(event,'1234567890');">
        </td>
        <td align="center">
          <input type="text" name="txtBalls" id="txtBalls" onfocus="clearTextBox('txtBalls')" onblur="fillZero('txtBalls')" value="<%=Balls%>" class="textBox" tabindex="6" onKeyPress="return keyRestrict(event,'1234567890');">
        </td>
		 <td align="center">
          <input type="text" name="txtMinutes" id="txtMinutes" onfocus="clearTextBox('txtMinutes')" onblur="fillZero('txtMinutes')" value="<%=Minutes%>" class="textBox" tabindex="7" onKeyPress="return keyRestrict(event,'1234567890');">
        </td>
        <td align="center">
<%			if(HidId!=null && HidId.equalsIgnoreCase("4")){
%>			<input type="button" name="btnadd" id="btnadd" value="Edit" class="btn" tabindex="6" onclick="addpaternship(2);">
<%			}else{
%>			<input type="button" name="btnadd" id="btnadd" value="Add" class="btn" tabindex="6" onclick="addpaternship(1);">
<%			}
%>        
        </td>
      </tr>
    </table>
    </div>
	<div id="viewdiv" name="viewdiv" style="overflow: auto; height:15em;" >
    <table style="width:70em;" border="0"  cellspacing="1" >
	  <tr>
        <td colspan="9" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          <center>View Data</center>
        </td>
      </tr>
      <tr bgcolor="#f0f7ff" width="100%">
        <td align="center" width="10%"><b>Innings</b></td>
         <td align="right" width="10%"><b>Wicket</b></td>
        <td align="center" width="15%"><b>Batsman 1</b></td>
        <td align="center" width="15%"><b>Batsman 2</b></td>
        <td align="right" width="10%"><b>Runs</b></td>
        <td align="right" width="10%"><b>Balls</b></td>
        <td align="right" width="10%"><b>Minutes</b></td>
        <td align="center" width="10%"><b>Edit</b></td>
        <td align="center" width="10%"><b>Delete</b></td>
      </tr>
<%	  try{
	  if(crsObjpatership!=null){
	    int i = 1;
	  while(crsObjpatership.next()){		
	  if(i%2==0){	
%>    <tr bgcolor="#f0f7ff">
<%	  }else{	
%>	  <tr bgcolor="#e6f1fc">	
<%	  }
	 		
%>
        <td align="center"><%=crsObjpatership.getString("inning")==null?"-": crsObjpatership.getString("inning")%></td>
        <td align="right"><%=crsObjpatership.getString("wicket")==null?"-":crsObjpatership.getString("wicket")%></td>
        <td align="center"><%=crsObjpatership.getString("batter1name")==null?"-":crsObjpatership.getString("batter1name")%></td>
        <td align="center"><%=crsObjpatership.getString("batter2name")==null?"-":crsObjpatership.getString("batter2name")%></td>
        <td align="right"><%=crsObjpatership.getString("runs")==null?"-":crsObjpatership.getString("runs")%></td>
        <td align="right"><%=crsObjpatership.getString("balls")==null?"-":crsObjpatership.getString("balls")%></td>
        <td align="right"><%=crsObjpatership.getString("minutes")==null?"-":crsObjpatership.getString("minutes")%></td>
        <td align="center"><a href="/cims/jsp/concise/ConciseMatchTab.jsp?tab=5&inning=<%=crsObjpatership.getString("inning")%>&HidId=4&selWicket=<%=crsObjpatership.getString("wicket")%>">Edit</a></td>
        <td align="center" ><a href="/cims/jsp/concise/ConcisePartnership.jsp?selinning=<%=crsObjpatership.getString("inning")%>&HidId=3&selwicket=<%=crsObjpatership.getString("wicket")%>">Delete</a></td>
      </tr>
<%	  i++; 
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