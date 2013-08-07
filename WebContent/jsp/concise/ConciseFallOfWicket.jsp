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
	CachedRowSet  			crsObjfallofwkt			=	null;
	CachedRowSet  			crsObjbatsmandetails	=	null;
	String					msg						=	"";

	
	String wicket = request.getParameter("selWicket")==null?"0":request.getParameter("selWicket");
	String OutBatsman = request.getParameter("selOutBatsman")==null?"0":request.getParameter("selOutBatsman");
	String NotOutBatsman = request.getParameter("selNotOutBatsman")==null?"0":request.getParameter("selNotOutBatsman");
	String Runs = request.getParameter("txtRun")==null?"0":request.getParameter("txtRun");
	String Overs = request.getParameter("txtOvers")==null?"0":request.getParameter("txtOvers");
	String nobatsrun = request.getParameter("txtnobatsrun")==null?"0":request.getParameter("txtnobatsrun");
	
	
	if(HidId!=null && HidId.equalsIgnoreCase("1")){
		 try{
		 	 vparam.add(cmbinning);
		 	 vparam.add(wicket);
		 	 vparam.add(Runs);
		 	 vparam.add(Overs);
		 	 vparam.add(OutBatsman);
		 	 vparam.add(NotOutBatsman);
		 	 vparam.add(nobatsrun);
		 	 vparam.add("1"); //1 flag insert
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_fallofwkt",vparam,"ScoreDB");
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
		 	 vparam.add(Runs);
		 	 vparam.add(Overs);
		 	 vparam.add(OutBatsman);
		 	 vparam.add(NotOutBatsman);
		 	 vparam.add(nobatsrun);
		 	 vparam.add("2"); //2 flag update
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_fallofwkt",vparam,"ScoreDB");
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
		 	 vparam.add("");
		 	 vparam.add("0.0");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("");
		 	 vparam.add("3"); //3 flag delete
		 	 crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_fallofwkt",vparam,"ScoreDB");
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
	 	 crsObjbatsmandetails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallofwkt",vparam,"ScoreDB");
	  	 vparam.removeAllElements();
	  	 if(crsObjbatsmandetails!=null){
	  	 	while(crsObjbatsmandetails.next()){
		  	 	cmbinning = crsObjbatsmandetails.getString("inning")==null?"0":crsObjbatsmandetails.getString("inning");
		  	 	wicket	  = crsObjbatsmandetails.getString("fall_order")==null?"0": crsObjbatsmandetails.getString("fall_order");
			  	Runs   = crsObjbatsmandetails.getString("team_score")==null?"0": crsObjbatsmandetails.getString("team_score");
			  	Overs   = crsObjbatsmandetails.getString("num_over")==null?"0": crsObjbatsmandetails.getString("num_over");
		  	 	OutBatsman  = crsObjbatsmandetails.getString("out_batter")==null?"": crsObjbatsmandetails.getString("out_batter");
		  	 	NotOutBatsman  = crsObjbatsmandetails.getString("notout_batter")==null?"0": crsObjbatsmandetails.getString("notout_batter");
		  	 	nobatsrun  = crsObjbatsmandetails.getString("notout_batter_score")==null?"0": crsObjbatsmandetails.getString("notout_batter_score");
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
	 crsObjfallofwkt = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_fallofwicketdetails",vparam,"ScoreDB");
	 vparam.removeAllElements();
	}catch(Exception e){
	  log.writeErrLog(page.getClass(),MatchId,e.toString());	
	}
	
	if(HidId!=null && (HidId.equalsIgnoreCase("1") || HidId.equalsIgnoreCase("2") || HidId.equalsIgnoreCase("3"))){
		response.sendRedirect("/cims/jsp/concise/ConciseMatchTab.jsp?tab=6&inning="+cmbinning);
		return;
	}

%>	
<html>
  <head>
    <title>Fall of Wickets Details</title>
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
	  <tr height="20%">
        <td colspan="8"  width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          <center>Fall of Wickets Details Entry Module</center>
        </td>
      </tr>
      <tr>
        <td colspan="8" width="100%" >
          <center><font color="red"><b><%=msg%></b></font></center>
        </td>
      </tr>
      <tr bgcolor="#f0f7ff" width="100%">
        <td align="center" width="10%">Innings</td>
        <td align="center" width="10%">Wickets</td>
        <td align="center" width="10%">Runs</td>
        <td align="center" width="10%">Overs</td>
        <td align="center" width="20%">Out Batsman</td>
        <td align="center" width="20%">Not Out Batsman</td>
        <td align="center" width="10%">Not Out Score</td>
        <td align="center" width="10%">&nbsp;</td>
      </tr>
      <tr bgcolor="#e6f1fc" height="5%">
        <td align="center">
          <select id="selinning" name="selinning" tabindex="1" onchange="fallofwkt('5');" >
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
          <select id="selWicket" name="selWicket" tabindex="2">
            <option value="0">select</option>
<%			
			for(int i=1;i<12;i++){
%>          <option value="<%=i%>" <%=wicket.equalsIgnoreCase(""+i+"")?"selected":"" %>><%=i%></option>
<%				}
%>              
          </select>
        </td>
		 <td align="center">
          <input type="text" name="txtRun" id="txtRun" onfocus="clearTextBox('txtRun')" onblur="fillZero('txtRun')" value="<%=Runs%>" class="textBox" tabindex="3" onKeyPress="return keyRestrict(event,'1234567890');">
        </td>
		 <td align="center">
          <input type="text" name="txtOvers" id="txtOvers" onfocus="clearTextBox('txtOvers')" onblur="fillZero('txtOvers')" value="<%=Overs%>" class="textBox" tabindex="4" onKeyPress="return keyRestrict(event,'1234567890.');">
        </td>
        <td align="center">
          <select id="selOutBatsman" name="selOutBatsman" tabindex="5">
            <option value="0">select</option>
<%	  	  try{
	  		if(crsObjbattinglist!=null){
	  		while(crsObjbattinglist.next()){         
%>          <option value="<%=crsObjbattinglist.getString("id")%>"
					<%=crsObjbattinglist.getString("id").equalsIgnoreCase(OutBatsman)?"selected":"" %>>
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
          <select id="selNotOutBatsman" name="selNotOutBatsman" tabindex="6">
            <option value="0">select</option>
<%	  	  try{
	  		if(crsObjbattinglist!=null){
	  		int i = 0;
	  		while(crsObjbattinglist.next()){  
	  		if(i==0){
	 				crsObjbattinglist.first();
	  			}        
%>          <option value="<%=crsObjbattinglist.getString("id")%>"
					<%=crsObjbattinglist.getString("id").equalsIgnoreCase(NotOutBatsman)?"selected":"" %>>
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
          <input type="text" name="txtnobatsrun" id="txtnobatsrun" onfocus="clearTextBox('txtnobatsrun')" onblur="fillZero('txtnobatsrun')"  value="<%=nobatsrun%>" class="textBox" tabindex="7" onKeyPress="return keyRestrict(event,'1234567890');">
        </td>
         <td align="center">
<%			if(HidId!=null && HidId.equalsIgnoreCase("4")){
%>			<input type="button" name="btnadd" id="btnadd" value="Edit" class="btn" tabindex="8" onclick="fallofwicketadd(2);">
<%			}else{
%>			<input type="button" name="btnadd" id="btnadd" value="Add" class="btn" tabindex="8" onclick="fallofwicketadd(1);">
<%			}
%>   
		 </td>
      </tr>
    </table>
    </div>
    <div id="viewdiv" name="viewdiv" style="overflow: auto; height:15em;" >
    <table style="width:70em;" border="0"  cellspacing="1" >
	  <tr height="15%">
        <td colspan="9" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          <center>View Data</center>
        </td>
      </tr>
      <tr bgcolor="#f0f7ff" width="100%">
        <td align="right" width="10%"><b>Innings</b></td>
        <td align="right" width="10%"><b>Wickets</b></td>
        <td align="right" width="10%"><b>Runs</b></td>
        <td align="right" width="10%"><b>Overs</b></td>
        <td align="center" width="15%"><b>Out Batsman<b></td>
        <td align="center" width="15%"><b>Not Out Batsman<b></td>
        <td align="right" width="10%"><b>Not Out Score<b></td>
        <td align="center" width="10%"><b>Edit</b></td>
        <td align="center" width="10%"><b>Delete</b></td>
      </tr>
<%	  try{
	  if(crsObjfallofwkt!=null){
	    int i = 1;
	  while(crsObjfallofwkt.next()){
	  if(i%2==0){	
%>    <tr bgcolor="#f0f7ff">
<%	  }else{	
%>	  <tr bgcolor="#e6f1fc">	
<%	  }
%>      <td align="right"><%=crsObjfallofwkt.getString("inning")==null?"-":crsObjfallofwkt.getString("inning")%></td>
        <td align="right"><%=crsObjfallofwkt.getString("fall_order")==null?"-":crsObjfallofwkt.getString("fall_order")%></td>
        <td align="right"><%=crsObjfallofwkt.getString("team_score")==null?"-":crsObjfallofwkt.getString("team_score")%></td>
        <td align="right"><%=crsObjfallofwkt.getString("num_over")==null?"-":crsObjfallofwkt.getString("num_over")%></td>
        <td align="center"><%=crsObjfallofwkt.getString("outbatsman")==null?"-":crsObjfallofwkt.getString("outbatsman")%></td>
        <td align="center"><%=crsObjfallofwkt.getString("notoutbatsman")==null?"-":crsObjfallofwkt.getString("notoutbatsman")%></td>
        <td align="right"><%=crsObjfallofwkt.getString("notout_batter_score")==null?"-":crsObjfallofwkt.getString("notout_batter_score")%></td>
        <td align="center"><a href="/cims/jsp/concise/ConciseMatchTab.jsp?tab=6&inning=<%=crsObjfallofwkt.getString("inning")%>&HidId=4&selWicket=<%=crsObjfallofwkt.getString("fall_order")%>">Edit</a></td>
        <td align="center" ><a href="/cims/jsp/concise/ConciseFallOfWicket.jsp?selinning=<%=crsObjfallofwkt.getString("inning")%>&HidId=3&selWicket=<%=crsObjfallofwkt.getString("fall_order")%>">Delete</a></td>
      </tr>
<%	 	  i++;		
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