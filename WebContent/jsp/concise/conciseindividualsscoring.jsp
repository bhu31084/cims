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
	Common commonUtil = new Common();
	LogWriter log = new LogWriter();
	Vector<String> vparam = new Vector<String>();
	CachedRowSet crsObjinning = null;
	CachedRowSet crsObjAddInning = null;
	CachedRowSet crsObjbatsmandetails = null;
	CachedRowSet crsObjrate = null;
	CachedRowSet crsObjbattinglist = null;
	String msg = "";
	
	String __inningId = "0";
	
	String Runs = request.getParameter("Runs")==null?"0":request.getParameter("Runs");
	String Overs = request.getParameter("txtOvers")==null?"0":request.getParameter("txtOvers");
	String Minutes = request.getParameter("txtMinutes")==null?"0":request.getParameter("txtMinutes");
	String batsman = request.getParameter("selBatsman")==null?"0":request.getParameter("selBatsman");
	String fours = request.getParameter("txtfours")==null?"0":request.getParameter("txtfours");
	String sixes = request.getParameter("txtsixes")==null?"0":request.getParameter("txtsixes");
	
	if(HidId!=null && HidId.equalsIgnoreCase("1")){
		try{
			vparam.add(cmbinning);
		 	vparam.add(batsman);	
		 	vparam.add(Runs);
		 	vparam.add(Overs);
		 	vparam.add(Minutes);
		 	vparam.add(fours);
		 	vparam.add(sixes);
		 	vparam.add("1"); //1 flag insert
		 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_indivisual_details",vparam,"ScoreDB");
			vparam.removeAllElements();
			if(crsObjAddInning!=null){
				while(crsObjAddInning.next()){
					msg = crsObjAddInning.getString("result");
				}
			}
		}catch(Exception e){
		  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	} else if(HidId!=null && HidId.equalsIgnoreCase("2")){
		try{
			vparam.add(cmbinning);
		 	vparam.add(batsman);	
		 	vparam.add(Runs);
		 	vparam.add(Overs);
		 	vparam.add(Minutes);
		 	vparam.add(fours);
		 	vparam.add(sixes);
		 	vparam.add("2"); //2 flag update
		 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_indivisual_details",vparam,"ScoreDB");
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
		 	vparam.add(batsman);	
		 	vparam.add(Runs);
		 	vparam.add("");
		 	vparam.add("");
		 	vparam.add("");
		 	vparam.add("");
		 	vparam.add("3"); //3 flag delete
		 	crsObjAddInning = lobjGenerateProc.GenerateStoreProcedure("esp_amd_indivisual_details",vparam,"ScoreDB");
			vparam.removeAllElements();
			if(crsObjAddInning!=null){
				while(crsObjAddInning.next()){
			  		msg = crsObjAddInning.getString("result");
			  	}
			}
		}catch(Exception e){
		  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	} else if(HidId!=null && HidId.equalsIgnoreCase("4")) {
		try{
		 	vparam.add(cmbinning);
		 	vparam.add(batsman);
		 	vparam.add(Runs);
		 	vparam.add("1");
		 	crsObjbatsmandetails = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_indivisualscoring",vparam,"ScoreDB");
	  	 	vparam.removeAllElements();
	  	 	if(crsObjbatsmandetails!=null){
	  	 		while(crsObjbatsmandetails.next()){
			  	 	cmbinning = crsObjbatsmandetails.getString("inning")==null?"0":crsObjbatsmandetails.getString("inning");
			  	 	batsman = crsObjbatsmandetails.getString("batter")==null?"0":crsObjbatsmandetails.getString("batter");
			  	 	Runs	  = crsObjbatsmandetails.getString("runs")==null?"0": crsObjbatsmandetails.getString("runs");
				  	Overs   = crsObjbatsmandetails.getString("balls")==null?"0": crsObjbatsmandetails.getString("balls");
				  	Minutes   = crsObjbatsmandetails.getString("minutes")==null?"0": crsObjbatsmandetails.getString("minutes");
			  	 	fours   = crsObjbatsmandetails.getString("fours")==null?"0": crsObjbatsmandetails.getString("fours");
			  	 	sixes  = crsObjbatsmandetails.getString("sixes")==null?"0": crsObjbatsmandetails.getString("sixes");
	  	 		}
	  	 	}
		}catch(Exception e){
		  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
		}
	}
	
	if(HidId!=null && (HidId.equalsIgnoreCase("1") || HidId.equalsIgnoreCase("2") || HidId.equalsIgnoreCase("3"))){
		response.sendRedirect("/cims/jsp/concise/ConciseMatchTab.jsp?tab=8&inning="+cmbinning);
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
	
%>	

<html>
  <head>
    <title>Scoring Rate Details</title>
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
    		<table style="width:70em" border="0" cellspacing="1" cellpadding="3">
				<tr>
			        <td colspan="8" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
			          	<center>Indivisual Scroing Details Entry Module</center>
			        </td>
		      	</tr>
		      	<tr>
			        <td colspan="8" width="100%" >
			          	<center><font color="red"><b><%=msg%></b></font></center>
			        </td>
		      	</tr>
			    <tr bgcolor="#f0f7fd">
			        <td align="center" width="10%">Innings</td>
			        <td align="center" width="10%">Batsman</td>
			        <td align="center" width="10%">Runs</td>
			        <td align="center" width="15%">Balls</td>
					<td align="center" width="15%">Minutes</td>
					<td align="center" width="10%">&nbsp; 4 &nbsp;</td>
					<td align="center" width="10%">&nbsp; 6 &nbsp;</td>
			        <td align="center" width="15%">&nbsp;</td>
				</tr>
		      	<tr bgcolor="#e6f1fc" height="5%">
		        	<td align="center">
		          		<select id="selinning" name="selinning" tabindex="1" onchange="indivisualscore('5');" >
				<%try{
		 			if(crsObjinning != null){
 						if(cmbinning.equals("0")){
 							for(int i = 1; crsObjinning.next(); i++){
 								if(i == 1){
 									__inningId = crsObjinning.getString("id");
 								}
 							%>		 							
						<option value="<%=crsObjinning.getString("id")%>">Inning <%=i%></option>
							<%}		 									 							
 						}else{
 							for(int i = 1; crsObjinning.next(); i++){%>
						<option value="<%=crsObjinning.getString("id")%>" <%= crsObjinning.getString("id").equalsIgnoreCase(cmbinning)?"selected":""%>>Inning <%=i%></option>
							<%}
 							__inningId = cmbinning;
 						}
		    		}
		 		}catch(Exception e){
	 				log.writeErrLog(page.getClass(),MatchId,e.toString());
		 		}%>
          				</select>
        			</td>
        
        
		        <%try{
		    	 	vparam.add(__inningId);
		    	 	crsObjbattinglist = lobjGenerateProc.GenerateStoreProcedure("dsp_batsmenList",vparam,"ScoreDB");
		    	  	vparam.removeAllElements();
		    	}catch(Exception e){
		    	  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
		    	}
		    	
		    	try{
		    	 	vparam.add(__inningId);
		    	 	vparam.add("");
		    	 	vparam.add("");
		    	 	vparam.add("2"); 
		    	 	crsObjrate = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_indivisualscoring",vparam,"ScoreDB");
		    	  	vparam.removeAllElements();
		    	}catch(Exception e){
		    	  	log.writeErrLog(page.getClass(),MatchId,e.toString());	
		    	}%>
        
        
        			<td align="center">
          				<select id="selBatsman" name="selBatsman" tabindex="2">
<%	  	  try{
	  		if(crsObjbattinglist!=null){
	  		while(crsObjbattinglist.next()){         
%>          <option value="<%=crsObjbattinglist.getString("id")%>"
			<%=crsObjbattinglist.getString("id").equalsIgnoreCase(batsman)?"selected":"" %>>
			<%=crsObjbattinglist.getString("playername")%></option>
<%			}// end of while
			}
		    
		 }catch(Exception e){
	 		log.writeErrLog(page.getClass(),MatchId,e.toString());
		 }   	
%>            
          </select>
        </td>
        <td align="center">
        	<select id="Runs" name="Runs" tabindex="3">
<%				for(int i=50;i<1000;i=i+50){	        		
%>      		<option value="<%=i%>" <%=Runs.equalsIgnoreCase(""+i+"")?"selected":"" %>><%=i%></option>
<%				}
%>
         	</select>
        </td>
		<td align="center">
          <input type="text" name="txtOvers" id="txtOvers"  onfocus="clearTextBox('txtOvers')" onblur="fillZero('txtOvers')" value="<%=Overs%>" class="textBox" tabindex="4" onKeyPress="return keyRestrict(event,'1234567890.');">
        </td>
		<td align="center">
          <input type="text" name="txtMinutes" id="txtMinutes" onfocus="clearTextBox('txtMinutes')" onblur="fillZero('txtMinutes')" value="<%=Minutes%>" class="textBox" tabindex="5" onKeyPress="return keyRestrict(event,'1234567890');">
        </td>
        <td align="center">
          <input type="text" name="txtfours" id="txtfours" onfocus="clearTextBox('txtfours')" onblur="fillZero('txtfours')" value="<%=fours%>" class="textBox" tabindex="6" onKeyPress="return keyRestrict(event,'1234567890');">
        </td>
        <td align="center">
          <input type="text" name="txtsixes" id="txtsixes"  onfocus="clearTextBox('txtsixes')" onblur="fillZero('txtsixes')" value="<%=sixes%>" class="textBox" tabindex="7" onKeyPress="return keyRestrict(event,'1234567890');">
        </td>
         <td align="center">
<%			if(HidId!=null && HidId.equalsIgnoreCase("4")){
%>			<input type="button" name="btnadd" id="btnadd" value=" SAVE " class="btn" tabindex="8" onclick="indivisualscoringadd(2);">
<%			}else{
%>			<input type="button" name="btnadd" id="btnadd" value=" ADD " class="btn" tabindex="8" onclick="indivisualscoringadd(1);">
<%			}
%> 			
		 </td>
      </tr>
    </table>
	</div>
    <div id="viewdiv" style="overflow: auto; height:15em;" >
    <table style="width:70em;" border="0"  cellspacing="1" cellpadding="3" >
	  <tr>
        <td colspan="9" width="100%" background = "../../images/top_bluecen.jpg" valign="middle" class="tabHeading">
          <center>View Data</center>
        </td>
      </tr>
      <tr bgcolor="#f0f7ff">
        <td align="right" width="10%"><b>Innings</b></td>
        <td align="right" width="10%"><b>Batsman</b></td>
        <td align="right" width="10%"><b>Runs</b></td>
        <td align="right" width="10%"><b>Overs</b></td>
        <td align="right" width="15%"><b>Minutes</b></td>
     	<td align="right" width="10%"><b>&nbsp; 4</b></td>
		<td align="right" width="10%"><b>&nbsp; 6</b></td>
        <td align="center" width="10%"><b>Edit</b></td>
        <td align="center" width="10%"><b>Delete</b></td>
      </tr>
<%	  try{
	  if(crsObjrate!=null){
	    int i = 1;
	  while(crsObjrate.next()){		
  		if(i%2==0){	
%>    <tr bgcolor="#f0f7ff">
<%	  }else{	
%>	  <tr bgcolor="#e6f1fc">	
<%	  }
	  		
%>      <td align="right"><%=crsObjrate.getString("inning")==null?"-":crsObjrate.getString("inning")%></td>
        <td align="right"><%=crsObjrate.getString("battername")==null?"-":crsObjrate.getString("battername")%></td>
        <td align="right"><%=crsObjrate.getString("runs")==null?"-":crsObjrate.getString("runs")%></td>
        <td align="right"><%=crsObjrate.getString("balls")==null?"-":crsObjrate.getString("balls")%></td>
        <td align="right"><%=crsObjrate.getString("minutes")==null?"-":crsObjrate.getString("minutes")%></td>
        <td align="right"><%=crsObjrate.getString("fours")==null?"-":crsObjrate.getString("fours")%></td>
        <td align="right"><%=crsObjrate.getString("sixes")==null?"-":crsObjrate.getString("sixes")%></td>
        <td align="center"><a href="/cims/jsp/concise/ConciseMatchTab.jsp?tab=8&inning=<%=crsObjrate.getString("inning")%>&HidId=4&Runs=<%=crsObjrate.getString("runs")%>&selBatsmen=<%=crsObjrate.getString("batter")%>">Edit</a></td>
        <td align="center" ><a href="/cims/jsp/concise/conciseindividualsscoring.jsp?selinning=<%=crsObjrate.getString("inning")%>&HidId=3&Runs=<%=crsObjrate.getString("runs")%>&selBatsman=<%=crsObjrate.getString("batter")%>">Delete</a></td>
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
    	</div>       
  	</body>	
</html>