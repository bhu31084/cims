<%-- 
    Document   : swappalyer
    Created on : Feb 9, 2009, 4:08:39 PM
    Author     : bhushanf
--%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%
            String flag = request.getParameter("id") == null ? "" : request.getParameter("id");
            String inningId = request.getParameter("inningId") == null ? "" : request.getParameter("inningId");
            String teamPlayerId = "";
            String teamPlayerName = "";
            CachedRowSet crsObjPlayerList = null;
            GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
            Vector vparam = new Vector();
            vparam.add(inningId);
            vparam.add(flag);// flag 1 for batsman and 2 for bowler
            crsObjPlayerList = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_swaplayer", vparam, "ScoreDB");
            vparam.removeAllElements();
            if (crsObjPlayerList != null) {
                while (crsObjPlayerList.next()) {
                    teamPlayerId = teamPlayerId + crsObjPlayerList.getString("id") + "~";
                    teamPlayerName = teamPlayerName + crsObjPlayerList.getString("playername") + "~";
                }
            }

%>
<div >
    <table width="100%" height="100%" border="5" >
        <tr>
            <td>Player 1</td>
            <td>Player 2</td>
        </tr>   
        <tr>
<%          for(int j=0;j<2;j++){
%>            
            <td><select name="cmbteamplayer<%=j%>" id="cmbteamplayer<%=j%>">
<%              if (!teamPlayerId.equalsIgnoreCase("")) {
	               String teamPlayerIdArr[] = teamPlayerId.split("~");
	               String teamPlayerNameArr[] = teamPlayerName.split("~");
	               for (int i = 0; i < teamPlayerIdArr.length; i++) {
	%>                  <option value="<%= teamPlayerIdArr[i]%>"><%=teamPlayerNameArr[i]%> </option>   
	<%              }// end of for
                }
%>
                </select>
            </td>
<%          }
%>           
        </tr>  
        <tr>
            <td align="right"><input type="button" class="button1" name="btnadd" id="btnadd" value="Swap" 
            onclick="AddPlayer('<%=inningId%>','<%=flag%>')"></td>
            <td colspan="1"><input type="button" class="button1" name="btnadd" id="btnadd" value="Exit" 
            onclick="exit()"></td>
        </tr>    
    </table>
</div>