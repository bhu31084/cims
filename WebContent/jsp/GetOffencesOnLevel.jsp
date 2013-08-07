<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page
	import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%
	response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires",0);
%>
<%
	
	String matchid = request.getParameter("matchid")==null?"0":request.getParameter("matchid");
	String playerId = request.getParameter("playerId")==null?"0":request.getParameter("playerId");
	String gsFlg = request.getParameter("flg")==null?"0":request.getParameter("flg");
	String retval = null;
	
	CachedRowSet  crsObjSortLevel = null;		
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	
		
	if(request.getParameter("matchid")!= null){
			try{
					vparam.add(matchid);//1
					vparam.add(playerId);//1		
					vparam.add(gsFlg);//1					
					crsObjSortLevel = lobjGenerateProc.GenerateStoreProcedure(
							"esp_dsp_referee_breachs_fb",vparam,"ScoreDB");
					vparam.removeAllElements();
				}catch (Exception e) {
					System.out.println("Exception"+e);
		    		e.printStackTrace();
				}
		}%>		
		<%
					if(crsObjSortLevel != null){
						while(crsObjSortLevel.next()){
							retval = crsObjSortLevel.getString("breach_level");					
						}
					}						
						%>			

<div id="LevelDiv"> 
	<table>
		<tr>
		<td>
				<select name="dpLevel" id="dpLevel" onchange="addOffences()">
					<option value="0" >Select </option>
				<%for(int i = Integer.parseInt(retval)+1 ; i<=4 ; i++){
					out.println("i  "+i);
				%>			
					<option value="<%=i%>" >Level&nbsp;<%=i%></option>
					<%}%>					
				</select>
			</td>
		</tr>	
	</table>
</div>
