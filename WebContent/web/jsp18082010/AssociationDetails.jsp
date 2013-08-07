<!--
Page Name 	 : /NewWeb/jsp/WebLogin.jsp
Created By 	 : Archana Dongre.
Created Date : 10 feb 2009
Description  : New Web Login Page.
Company 	 : Paramatrix Tech Pvt Ltd.
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ include file="loginvalidate.jsp" %>
<%		
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");			
	Common common = new Common();
	//String currentYear = sdf.format(new Date()).substring(0,4);
	//String currentmonth = sdf.format(new Date()).substring(5,7);
	String season = session.getAttribute("season").toString();
	//System.out.println("current year is ***** "+currentYear);	
	//System.out.println("current year is ***** "+currentmonth);	
	//String message = "";
	String clublogo = null;
	String gsclublogo = null;
	String clubname = null;
	Boolean Assocount = false;
	String gsclubId = null;
	String gsclubName = null;
	String seriestypeid = null;		
	CachedRowSet  crsObjGetAssociations = null;
	CachedRowSet  crsObjGetAssociationsOne = null;	
	CachedRowSet  crsObjGetAssocSeries = null;	
	Vector vParam =  new Vector();	
	int i = 0;
//GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
				
		try{
			//to get the association list points,club_name,club_id
			vParam.add(season);//season id
			vParam.add("");//@club int, 
			vParam.add("");//@seriestype int,
			vParam.add("");//@teamid int,	
			vParam.add("1");//@flag int
			crsObjGetAssociations = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_associationwise_points",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
			e.printStackTrace();
		}			
		
		try{
			//to get the association list points,club_name,club_id
			vParam.add(season);//season id
			vParam.add("");//@club int, 
			vParam.add("");//@seriestype int,
			vParam.add("");//@teamid int,	
			vParam.add("1");//@flag int
			crsObjGetAssociationsOne = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_associationwise_points",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
			e.printStackTrace();
		}
		if(crsObjGetAssociationsOne != null){
			while(crsObjGetAssociationsOne.next()){
				if(Assocount == true){
																				
				}else{					
					gsclubId = crsObjGetAssociationsOne.getString("club_id");
					gsclubName = crsObjGetAssociationsOne.getString("club_name");
					gsclublogo = crsObjGetAssociationsOne.getString("club_logo_path");
					Assocount = true;
				}		
			}
		}
		System.out.println("gsclubId "+gsclubId);
		System.out.println("gsclubName "+gsclubName);	
		
		try{
			//to get the association list points,club_name,club_id
			vParam.add(season);//season id
			vParam.add(gsclubId);//@club int, 
			vParam.add("");//@seriestype int,
			vParam.add("");//@teamid int,	
			vParam.add("2");//@flag int on second step
			crsObjGetAssocSeries = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_associationwise_points",vParam,"ScoreDB");
			vParam.removeAllElements();
		}catch (Exception e) {
			System.out.println("Exception"+e);
			e.printStackTrace();
		}	
		
		
		%>			

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />--%>
<title>Association Ranking</title>
<link href="../css/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="../js/AssociationAjax.js"></script>
<script>
function callSubmit(){					
			try{
				document.getElementById('hdSubmit').value = "submit"
			
				if(document.getElementById('txtUserName').value == ""){
					alert(" User Name can not be left Blank !");
					frmAssociation.txtUserName.focus();
				}else if(document.getElementById('password').value == ""){
					alert(" Password can not be left Blank !");
					frmAssociation.password.focus();
				}else{
					document.frmAssociation.submit();			
				}	
		}catch(err){
				alert("callSubmit"+err.description); 
		}
	}
</script>
</head>
<body bottommargin="0" leftmargin="0" topmargin="0" >

<form method="get" name="frmAssociation" id="frmAssociation" >
<jsp:include page="Header.jsp"></jsp:include>
	<table width="1003" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
    	<tr>
	    	<td valign="top" style="padding-left: 10px;text-align: left;width: 30%" >
		    	<div style="height: 500px;">
		    	<table border="0" align="center" cellpadding="0" cellspacing="0">
				   <tr>
				 	<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Associations</td>
				   </tr>
				   <tr>
				    <td style="left: 10px;top : 0px;" valign="top">
				        <table width="300" border="0" class="contenttable" style="height: 250px;">
				          <tr>
				            <td style="text-align: right;padding-right: 7px;font-size: 14px;"></td>
				            <td style="text-align: left;padding-right: 7px;font-size: 14px;"><b>Association Name </b></td>
			          	  </tr>
				         <%if(crsObjGetAssociations != null){%>
				          <%	int colorcounter = 1;
				          while(crsObjGetAssociations.next()){
				          		clublogo = crsObjGetAssociations.getString("club_logo_path");
				          		clubname = crsObjGetAssociations.getString("club_name");
				          if(colorcounter % 2 == 0 ){%>
			        		<tr bgcolor="#f0f7fd" id="<%i++;%>">
			        		<%}else{%>
			        		<tr bgcolor="#e6f1fc">
			        		<%}%>
				             <td style="text-align: right;padding-right:7px;font-size: 12px;" id="<%=colorcounter++%>" nowrap="nowrap" valign="middle"><IMG id="plusImage" name="plusImage" alt="" src="../Image/<%=clublogo%>"/>
				             </td><td style="text-align: left;font-size:12px;"><a style="text-decoration: none;" href="javascript:getAssociationData('<%=crsObjGetAssociations.getString("club_id")%>','<%=clubname%>','<%=season%>','<%=clublogo%>')">
				            <%=clubname%></a>
				             </td>
			          		</tr>
				          <%
				          }
				            }%>
				   		</table>
				   	</td>
				   </tr>
				 </table>
			  </div>					
			</td>			
			<td width="50%" valign="top" align="left">
				<table border="0" align="center" cellpadding="0" cellspacing="0"  border="0" >					
					<tr>
				 	<td background = "../Image/top_bluecen.jpg" colspan="4" style="font-size: 16px;color: white;font-weight: bolder;font-family: georgia;padding-left: 7px;" >Associations Details</td>
				   </tr>				    
				    <tr>
				    	<td align="left">
				    		<div id="AssoDivById" style="display: none;height: 800px;overflow: auto;" ></div>
				    		<div id="loadPageDiv" style="height: 800px;overflow: auto;">
				    		<table width="400" border="0" class="contenttable">				    			
				    			<tr>
									<td colspan="3" ></td>
								</tr>
								<tr>
									<td colspan="1" style="text-align: right;font-size: 14px;" valign="top"><IMG src="../Image/<%=gsclublogo%>"></td>
									<td colspan="2" style="text-align: left;padding-right:10px;font-size: 14px;"><b><%=gsclubName%></b></td>
								</tr>							
				    			<tr>
				    			<!-- club_name,series_name,points,club_id,seriestype_id,series_id-->				    				
				    				<td></td>
				    				<td style="text-align: center;padding-right:10px;font-size: 12px;"><b>Tournament Name</b></td>
				    				<td style="text-align: center;padding-right:10px;font-size: 12px;" width="30"><b>Pts</b></td>
				    			</tr>
				    			<%if(crsObjGetAssocSeries != null){%>													
				          <% int colorcounter = 1;
				          while(crsObjGetAssocSeries.next()){
				          seriestypeid = crsObjGetAssocSeries.getString("seriestype_id");
				          	if(colorcounter % 2 == 0 ){%>
			        		<tr bgcolor="#f0f7fd">
			        		<%}else{%>
			        		<tr bgcolor="#e6f1fc">	
			        		<%}%>	
				             <td style="text-align: right;padding-right:10px;font-size: 12px;" id="<%=colorcounter++%>">
				             <IMG id="plusImage<%=seriestypeid%>" name="plusImage<%=seriestypeid%>" alt="" src="../Image/Arrow.gif" />
				             </td><td style="text-align: left;padding-right:10px;font-size: 12px;" valign="middle"><a style="text-decoration: none;" href="javascript:ShowSeriesPositionDetailDiv('<%=gsclubId%>','<%=seriestypeid%>','<%=season%>')">
				             <%=crsObjGetAssocSeries.getString("series_name")%>
				             </a></td>
				             <td style="text-align: right;padding-right:10px;font-size: 12px;">&nbsp;&nbsp;<%=crsObjGetAssocSeries.getString("points")%>
				             </td>
				          </tr>	
				          <tr>
							<td colspan="3">
								<div id="ShowseriesPtDetailsDiv<%=seriestypeid%>" style="display:none" ></div>
							</td>
						  </tr>	
				          <%   }
				            }%>	
				    			
				    		</table>
				    		</div>
				    	</td>
				    </tr>				    			    
				</table>
			</td>
			<td width="40">&nbsp;</td>
	</tr>	
	</table>	   					 		
	<table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" >
		<tr>
		        		<td>
		        		<br />
				        </td>
					    <td>&nbsp;</td>
					    <td>&nbsp;</td>
		      		</tr>
	</table>

</form>
<jsp:include page="Footer.jsp"></jsp:include>
</body>		
</html>	

