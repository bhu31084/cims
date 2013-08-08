<!--
Page name	 : UserMaster.jsp
Replaced By  : Vaibhav Gaikar.
Created Date : 17th Sep 2008
Description  : To add User details in Database
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="in.co.paramatrix.common.validator.DataValidator,in.co.paramatrix.common.exceptions.NoEntity,in.co.paramatrix.common.exceptions.InvalidEntity"%>
<%@ page import="in.co.paramatrix.common.authz.AuthZ"%>
<%  response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
	Common commonUtil		  	 =  new Common();
    CachedRowSet  crsObjRolesCrs =  null;
    CachedRowSet  userDataCrs	 =  null;
    CachedRowSet  updateUserCrs	 =  null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
    Vector vparam 			     =  new Vector();
	String userRole 			 =  "";
	String matchId				 =  "";
	matchId 		    		 = (String)session.getAttribute("matchid");
	LogWriter log 				 =  new LogWriter();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	
	try{	
		vparam.add((String)session.getAttribute("userid"));//
        crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_teams_playermap",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjRolesCrs != null){	
			while(crsObjRolesCrs.next()){	
						userRole = crsObjRolesCrs.getString("role")!=null?userRole = crsObjRolesCrs.getString("role"):"";
			}
		 }
	   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	  }
%>
<html>						
	<head>
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" />
		<script>
			
		</script>	
	</head>
	<body> 
    		<input type=hidden name=hidpaging id=hidpaging value="1"/>
		    <input type=hidden name="hidUserRole" id="hidUserRole" value="<%=userRole%>"/>
			<input type=hidden name=hidpageid id=hidpageid value="" />
			<input type=hidden name=hidpagingno id=hidpagingno value="" />
			<table width="100%" align="center">
					<tr >
					    <td>
		<fieldset><legend class="legend1">Search User's Details
		</legend>
							<table align="center" cellspacing=5> 
								<tr class="contentDark"> 
									<td class="colheadinguser">Role</td>	
									
									<td class="colheadinguser">Display name</td>
									
									<td class="colheadinguser">Username</td>
									
									<td class="colheadinguser">First name</td>
									
									<td class="colheadinguser" >Middle name</td>
									
									<td class="colheadinguser">Last name</td>
								</tr>
								<tr class="contentLight">
										<td>
										 <select class="input" name="selRoleId" id="selRoleId"  >
										 			<option value="0">--select--</option>
<%	try{	
		vparam.add("1");//
        crsObjRolesCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_roles",vparam,"ScoreDB");
		vparam.removeAllElements();	
		if(crsObjRolesCrs != null){	
			while(crsObjRolesCrs.next()){	
%>							
						<option value="<%=crsObjRolesCrs.getString("id")%>" ><%=crsObjRolesCrs.getString("name")%></option>
<%			}
		 }
	   }catch(Exception e){
		log.writeErrLog(page.getClass(),matchId,e.toString());
	}
%>	
							  			  </select>			   
									</td>
									
									<td><input class="input" size=13 type="text" name="searchDisName" id="searchDisName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,' abcdefghijklmnopqrstuvwxyz')"></td>
									
									<td><input class="input" size=13 type="text" name="searchNickName" id="searchNickName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
									
									<td><input class="input" size=13 type="text" name="searchFirstName" id="searchFirstName" onfocus = "this.style.background = '#FFFFCC'" onblur = "searchName();changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
									
									<td><input class="input" size=13 type="text" name="searchMiddleName" id="searchMiddleName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
									
									<td><input class="input" size=13 type="text" name="searchLastName" id="searchLastName" onfocus = "this.style.background = '#FFFFCC'" onblur = "changeColour(this)" value="" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz')"></td>
									

								</tr>
								<tr class="contentDark"> 
									<td align="right" colspan="10"><input type="button" class="btn btn-warning" name="Search"  value="Search" onclick="userSearch()"></td>									
								</tr>	
							</table>	
						</fieldset>
						</td>
					</tr>
				</table>
			</body>
	</html>							