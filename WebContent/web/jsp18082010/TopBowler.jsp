<!--
	Author 		 : Archana Dongre
	Created Date : 31/01/09
	Description  : Display top bowler of the series.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	errorPage="error_page.jsp"%>
<%@ page import="in.co.paramatrix.common.ChangeInitial"%>
<%
		try {		
		String seriesId = "";
   		String seasonId = "";	
		String seriesName = "";
		seriesId = request.getParameter("seriesId")==null?"":request.getParameter("seriesId");
		seasonId = request.getParameter("seasonId")==null?"":request.getParameter("seasonId");
		seriesName = request.getParameter("name")==null?"":request.getParameter("name");
		String topBowlerflag = "1";
		
		CachedRowSet 			crsObjGetTopBowler       =	null;
		CachedRowSet 			crsObjGetTopbatsman       =	null;
		
		GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
		Vector 					vparam 					=  	new Vector();
		String message = "";
		String gsplayerId = "";		
		String gsbowler = "";
		String gsassociation= "";
		String gstotal_wicktes = "";
		String gsmatchplayed = "";
		String gsplayerphoto = null;
		String gsbatsmanphoto = null;		
		String gsbatsmanId ="";
		String gsbatsman = "";
		String gsBatassociation= "";
		String gstotal_runs = "";
		
		ChangeInitial chgInitial = new ChangeInitial();
		String iniChgBatsman = null;
		String iniChgBowler = null;
		
		Boolean bowlerflag = false;
		Boolean batsmanflag = false;
		
		vparam.removeAllElements();
		vparam.add(seriesId);
		vparam.add(seasonId);
		vparam.add("");
		vparam.add("");
		vparam.add(topBowlerflag);
		try {
			crsObjGetTopBowler = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_getseries_wise_top_bowler_list", vparam, "ScoreDB");								
			vparam.removeAllElements();			
		} catch (Exception e) {
			System.out.println("*************Login.jsp*****************"+e);			
		}
		
		try {
			vparam.removeAllElements();
			vparam.add(seriesId);
			vparam.add(seasonId);
			vparam.add("");
			vparam.add("");
			vparam.add(topBowlerflag);
			crsObjGetTopbatsman = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_getseries_wise_top_batsman_list", vparam, "ScoreDB");								
			vparam.removeAllElements();			
		} catch (Exception e) {
			System.out.println("*************Login.jsp*****************"+e);			
		}
		%>
<DIV id="TopBowlerDiv" style="width: 295px;height: 400px;">
<table width="295" border="0" >
	<tr>
			<td colspan="3" ><b><%=seriesName%></b></td>
	</tr>
	<%if(crsObjGetTopBowler != null ){			
			if(crsObjGetTopBowler.size() == 0){				
				message = " Data Not Available ";%>
			<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
			<%}else{%>
				<%while(crsObjGetTopBowler.next()){
					if(bowlerflag == true){
						
					}else{
						//id,bowler,association,total_wicktes,matchplayed
						gsplayerphoto = crsObjGetTopBowler.getString("photograph_path");
						gsplayerId = crsObjGetTopBowler.getString("id");
						gsbowler = chgInitial.properCase(crsObjGetTopBowler.getString("bowler"));
						gsassociation= chgInitial.properCase(crsObjGetTopBowler.getString("association"));
						gstotal_wicktes = crsObjGetTopBowler.getString("total_wicktes");
						gsmatchplayed = crsObjGetTopBowler.getString("matchplayed");
						bowlerflag = true;
		  			}
				}		
			%>
	<tr>
		<td align="center">
			<div align="center"><br/>
    			<%if(gsplayerphoto == null){%>
					<img src="../Image/noimage.jpg" width="80" height="80" />											
				<%}else{%>
					<img src="../../<%=gsplayerphoto%>" width="180" height="180" />
				<%}%>
<%--    			<img src="../../<%=gsplayerphoto%>" width="180" height="180" /><br />--%>
    			<br />
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<table border="0" >
            	<tr>
              		<td class="boldtext">&nbsp;</td>
		      		<td class="boldtext" >Name </td>
              		<td class="innertable"><%=gsbowler%></td>
            	</tr>
            	<tr>
              		<td>&nbsp;</td>
              		<td class="boldtext" >Association</td>
              		<td class="innertable"><%=gsassociation%></td>
            	</tr>													                	            	            	
            	<tr>
              		<td>&nbsp;</td>
              		<td class="boldtext" >Wickets</td>
              		<td class="innertable"><%=gstotal_wicktes%></td>              		
            	</tr>		    	            	
            	<tr>
              		<td>&nbsp;</td>
              		<td class="boldtext" >Matches</td>
              		<td class="innertable"><%=gsmatchplayed%></td>
            	</tr>
            	<tr>
              		<td>&nbsp;</td>
              		<td class="boldtext" >Comment</td>
              		<td class="innertable">&nbsp;</td>
            	</tr>
            	<tr>
              		<td>&nbsp;</td>
              		<td class="innertable"></td>
          		</tr>
      		</table>
		</td>
	 </tr>
	<% }
	}	%>
</table>
</DIV>
<br>
<DIV id="TopBatsmanDiv" style="width: 295px;height: 400px;">
<table width="295" border="0" >
	<tr>
			<td colspan="3" ><b><%=seriesName%></b></td>
	</tr>
	<%if(crsObjGetTopbatsman != null ){			
			if(crsObjGetTopbatsman.size() == 0){				
				message = " Data Not Available ";%>
			<tr style="color:red;font-size: 12"><b><%=message%></b></tr>
			<%}else{%>
				<%while(crsObjGetTopbatsman.next()){
					if(batsmanflag == true){
					
					}else{
						//id,bowler,association,total_wicktes,matchplayed
						gsbatsmanphoto = crsObjGetTopbatsman.getString("photograph_path");
						gsbatsmanId = crsObjGetTopbatsman.getString("id");
						gsbatsman = chgInitial.properCase(crsObjGetTopbatsman.getString("batsman"));
						gsBatassociation= chgInitial.properCase(crsObjGetTopbatsman.getString("association"));
						gstotal_runs = crsObjGetTopbatsman.getString("total_runs");
						//gsmatchplayed = crsObjGetTopbatsman.getString("matchplayed");
						batsmanflag = true;						
					}
				}%>	
	<tr>
		<td align="center">
			<div align="center"><br/>
    			<%if(gsbatsmanphoto == null){%>
					<img src="../Image/noimage.jpg" width="80" height="80" />											
				<%}else{%>
					<img src="../../<%=gsbatsmanphoto%>" width="180" height="180" />
				<%}%>
    			<br />
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<table width="295" border="0" >
            	<tr>
              		<td class="boldtext">&nbsp;</td>
		      		<td class="boldtext" >Name </td>
              		<td class="innertable"><%=gsbatsman%></td>
            	</tr>
            	<tr>
              		<td>&nbsp;</td>
              		<td class="boldtext" >Association</td>
              		<td class="innertable"><%=gsBatassociation%></td>
            	</tr>													                	            	            	
            	<tr>
              		<td>&nbsp;</td>
              		<td class="boldtext" >Total Runs</td>
              		<td class="innertable"><%=gstotal_runs%></td>
              		
            	</tr>		    	            	            	
            	<tr>
					<td>&nbsp;</td>
		       		<td class="boldtext" >Matches</td>
		       		<td class="innertable">0</td>
		     	</tr>
            	<tr>
              		<td>&nbsp;</td>
              		<td class="boldtext" >Comment</td>
              		<td class="innertable">&nbsp;</td>
            	</tr>
            	<tr>
              		<td>&nbsp;</td>
              		<td colspan="2" class="innertable"></td>
          		</tr>
      		</table>
		</td>
	 </tr>
	 <%	}
	}	
			%>
</table>
</DIV>
<%} catch (Exception e) {
			System.err.println(e.toString());
		}
%>