<%@ page import="sun.jdbc.rowset.CachedRowSet,
				in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
				java.text.SimpleDateFormat,
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
	try{
		String matchId = (String)session.getAttribute("matchId");
		String InningId= (String)session.getAttribute("InningId");
		System.out.println("InningId "+InningId);
		String Flag = "3";
		String result="";
	    GenerateStoreProcedure spGenerate =	new GenerateStoreProcedure(matchId);
		Vector spParam = new Vector();
	    CachedRowSet crsObjinningCalculation = null;
	    CachedRowSet crsObjbattinglist = null;
		CachedRowSet wicketTypesCrs = null;
		CachedRowSet fielderNameCrs = null;
		Calendar cal = 	Calendar.getInstance();
		Hashtable battingid  =  new java.util.Hashtable();
		Hashtable battingname =  new java.util.Hashtable();
		Hashtable filderid =  new java.util.Hashtable();
		Hashtable fildername =  new java.util.Hashtable();
		Hashtable wkttypeid =  new java.util.Hashtable();
		Hashtable wkttypename =  new java.util.Hashtable();
		String hId = request.getParameter("hId")!=null?request.getParameter("hId"):"0";
		if(hId!=null && hId.equalsIgnoreCase("1")){
			String batsman = request.getParameter("batsman")!=null?request.getParameter("batsman"):"0";
			String filder1 = request.getParameter("filder1")!=null?request.getParameter("filder1"):"0";
			String filder2 = request.getParameter("filder2")!=null?request.getParameter("filder2"):"0";
			String HowOut = request.getParameter("HowOut")!=null?request.getParameter("HowOut"):"0";
			String bowler = request.getParameter("bowler")!=null?request.getParameter("bowler"):"0";
			String ball = request.getParameter("ball")!=null?request.getParameter("ball"):"0";
			try{
			 spParam.add(InningId);
			 spParam.add(batsman);
			 spParam.add(filder1);
			 spParam.add(filder2);
			 spParam.add(HowOut);
			 spParam.add(ball);
		   	 crsObjinningCalculation	= spGenerate.GenerateStoreProcedure("esp_amd_editdismissals", spParam, "ScoreDB"); 
		   	 spParam.removeAllElements();
		   	 if(crsObjinningCalculation!=null){
		   	 	while(crsObjinningCalculation.next()){
		   	 		result = crsObjinningCalculation.getString("result");
		   	 	}
		   	 }
		   	 
		   	}catch(Exception e){
				e.printStackTrace();
			}
		}else{
		  try{
			spParam.add(InningId);
			spParam.add(Flag);
		   	crsObjinningCalculation	= spGenerate.GenerateStoreProcedure("esp_dsp_matchanalysis", spParam, "ScoreDB"); 
		   	spParam.removeAllElements();
	  	  }catch (Exception e) {
 			e.printStackTrace();
 	  	  }
 	  	  try{
		   spParam.add(InningId);
		   crsObjbattinglist = spGenerate.GenerateStoreProcedure(
		   "dsp_batsmenList",spParam,"ScoreDB");
		   spParam.removeAllElements();
		   if(crsObjbattinglist!=null){
		  	int i=0;
	  		while(crsObjbattinglist.next()){ 
	  			battingid.put(i,crsObjbattinglist.getString("id"));
	  			battingname.put(i,crsObjbattinglist.getString("playername"));
	  			i++;	
	  		}
	  	   }		
		  }catch(Exception e){
		   e.printStackTrace();
		  }
		  try{
		    spParam.add("1");
		    wicketTypesCrs = spGenerate.GenerateStoreProcedure(
		    "dsp_types",spParam,"ScoreDB");
		    spParam.removeAllElements();
		    if(wicketTypesCrs!=null){
		  	  int i=0;
	  		  while(wicketTypesCrs.next()){
	  		   wkttypeid.put(i,wicketTypesCrs.getString("id"));
	  		   wkttypename.put(i,wicketTypesCrs.getString("name"));
	  			i++;
			  }
		    }		  
		  }catch(Exception e){
		    e.printStackTrace();
		  }
		  try{
			 spParam.add(InningId);
			 fielderNameCrs = spGenerate.GenerateStoreProcedure(
			 "dsp_fieldlist",spParam,"ScoreDB");
			 spParam.removeAllElements();
			 if(fielderNameCrs!=null){
			  int i = 0;
		  	   while(fielderNameCrs.next()){ 
		  		filderid.put(i,fielderNameCrs.getString("id"));
		  		fildername.put(i,fielderNameCrs.getString("playername"));
		  		i++;	
		  	   }
		  	 }	 
		 }catch(Exception e){
		  e.printStackTrace();
		 }
	   }	
%>					
<%	if(!hId.equalsIgnoreCase("1")){
%>
	<div id="showWicketsDiv" >
	  <table width="100%" height="100%" border="1" >
	    <tr>
	      <td colspan="6" align="center"><font size="3"><b> Wicket's Details </b></font> </td>
		<tr>
		<tr class="contentLastDark">
		  <td align="center"><b>Over Number </b></td>
		  <td align="center"><b>Batsman</b></td>
		  <td align="center"><b>Fielder one</b></td>
		  <td align="center"><b>Fielder Two</b></td>
		  <td align="center"><b>Wicket Type </b></td>
		  <td align="center"><b>Bowler Name</b></td>	
		  <td align="center">&nbsp;</td>														
		</tr>
<%		if(crsObjinningCalculation != null){	
			int j = 0;						
			while(crsObjinningCalculation.next()){%>
		<tr>
			<td align="center"><%=crsObjinningCalculation.getString("over_num")%></td>	
			<td align="center">
      		<select id="selBatsmen<%=j%>" name="selBatsmen<%=j%>" tabindex="1" disabled="disabled">
<%				for(int i = 0; i< battingid.size();i++){
%>			    <option value="<%=battingid.get(i).toString()%>" 
				<%= crsObjinningCalculation.getString("id").equalsIgnoreCase(battingid.get(i).toString())?"selected":""%>>
				<%=battingname.get(i)%></option>
<%				}
%>	      	</select>			
			</td>	
	
			<td align="center">
			<select id="selFielderOne<%=j%>" name="selFielderOne<%=j%>" tabindex="2" disabled="disabled">
              <option value="0">select</option>
<%			  for(int i = 0; i< filderid.size();i++){
%>			  <option value="<%=filderid.get(i).toString()%>"
			  <%= crsObjinningCalculation.getString("fiderid1").equalsIgnoreCase(filderid.get(i).toString())?"selected":""%>>
			  <%=fildername.get(i)%></option>
<%			  }
%>         </select>
	       </td>

			<td align="center">
			<select id="selFielderTwo<%=j%>" name="selFielderTwo<%=j%>" tabindex="3" disabled="disabled">
              <option value="0">select</option>
<%			  for(int i = 0; i< filderid.size();i++){
%>			  <option value="<%=filderid.get(i).toString()%>"
			  <%= crsObjinningCalculation.getString("filderid2").equalsIgnoreCase(filderid.get(i).toString())?"selected":""%>>
			  <%=fildername.get(i)%></option>
<%			  }
%>          </select>
			</td>
			
			<td align="center">
			<select id="selHowOut<%=j%>" name="selHowOut<%=j%>" tabindex="4" disabled="disabled">
            	
<%				for(int i = 0; i< wkttypeid.size();i++){
%>			    <option value="<%=wkttypeid.get(i).toString()%>"
				<%= crsObjinningCalculation.getString("out").equalsIgnoreCase(wkttypeid.get(i).toString())?"selected":""%>>
				<%=wkttypename.get(i)%></option>
<%				}
%>          </select>
			</td>	
	
			<td align="center">
            <select id="selBowler<%=j%>" name="selBowler<%=j%>" tabindex="5" disabled="disabled">
<%			  for(int i = 0; i< filderid.size();i++){
%>			  <option value="<%=filderid.get(i).toString()%>"
			  <%= crsObjinningCalculation.getString("bowlerid").equalsIgnoreCase(filderid.get(i).toString())?"selected":""%>>
			  <%=fildername.get(i)%></option>
<%			  }
%>           </select>			
			</td>				
			<td><input type="button" name="edit<%=j%>" id="edit<%=j%>" value = "Edit" onclick="editdata('<%=j%>')">
				<input type="hidden" name="hdball<%=j%>" id="hdball<%=j%>" value="<%=crsObjinningCalculation.getString("ball")%>">
			</td>				
		  </tr>
<%			j++;
			}
		}
%>	 </table>
<%	 }else{
		out.println(result);
	 }
%>
<% }catch(Exception e){
		e.printStackTrace();
    }
   	
%>