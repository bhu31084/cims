<!--
Page name	 : UserMaster.jsp
Replaced By  : Vaibhav Gaikar.
Created Date : 31st March 2009
Description  : To get user photograph in Database
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
<%@ page import="java.io.File,java.io.*,javax.imageio.ImageIO,java.awt.image.BufferedImage"%>

<%  response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
 	String userId = "";
	String photoGraph = "";
	String matchId = "";
	Common commonUtil		  	 =  new Common();
    CachedRowSet  userDataCrs	 =  null;
    SimpleDateFormat sdf 	     =  new SimpleDateFormat("dd/MM/yyyy");
    Vector vparam 			     =  new Vector();
	matchId 					 = (String)session.getAttribute("matchid");
	LogWriter log 				 = new LogWriter();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure(matchId);
	FileInputStream fis     = null;
	File inputFile			= null;
	OutputStream os			= response.getOutputStream();
	BufferedImage buffImage = null;
	userId = session.getAttribute("imageUserId").toString();
	vparam.add("");
	vparam.add("");
	vparam.add("");
	vparam.add("");
	vparam.add("");
	vparam.add("");
	vparam.add(userId);
	vparam.add("");
	vparam.add("");
	vparam.add("");
	vparam.add("2");
	userDataCrs = lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_userInfo",vparam,"ScoreDB");
	vparam.removeAllElements();	
	try
	{
		if (userDataCrs!=null && userDataCrs.size() > 0 )
		{
			while  (userDataCrs.next())
			{
				photoGraph = userDataCrs.getString("photograph_path")!=null?userDataCrs.getString("photograph_path"):"";
			}
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception uplosd image" +e.getMessage());
	}
		String realPath = getServletContext().getRealPath("/");
		String absolutePath = ""+realPath+photoGraph;
		fis = new FileInputStream(absolutePath);  
		buffImage = ImageIO.read(fis);
%>
<html>
 <head>
	<title>User Master</title>   
	<link href="../../css/adminForm.css" rel="stylesheet" type="text/css" /> 
	<script language="JavaScript" src="../../js/Calender.js" type="text/javascript"></script>
	<script language="JavaScript" src="../../js/timer.js" type="text/javascript"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js">
	</script>  
	<script>	 
	</script>
 </head>
 <body>
	<form name="frmUser" id="frmUser" method=post>
<%			
			try
			{
%>			<div width="20%" height="20%">
						<img src="<%=ImageIO.write(buffImage, "png", os)%>"  width="2px" height=2px/>
				</div>	
<%		}
			catch (IOException e) 
			{
				e.printStackTrace();
			}
%>
	</form>
	</body>
</html>
