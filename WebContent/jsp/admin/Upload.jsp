<!--
Page name	 : UserMaster.jsp
Replaced By  : Vaibhav Gaikar.
Created Date : 17th Sep 2008
Description  : To add User details in Database
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="org.apache.commons.fileupload.*,java.util.*, java.io.File, java.lang.Exception" %>		
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="in.co.paramatrix.csms.logwriter.LogWriter"%>
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
	String filePath  = "";
	String remark = "";
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	CachedRowSet crsNickNameUserId = null ;
	Vector vparam = new Vector();

	boolean isMultipart = FileUpload.isMultipartContent(request);

	DiskFileUpload upload = new DiskFileUpload();

	List items = upload.parseRequest(request);

	Iterator itr = items.iterator();
	while(itr.hasNext()) 
	{
		FileItem item = (FileItem) itr.next();
		if(item.isFormField()) {
       		String fieldName = item.getFieldName();
		
			if(fieldName.equals("name")){		
				request.setAttribute("msg", "Thank You: " + item.getString());
			}
	} else {
		String nickName = (String)session.getAttribute("userNickname");
		userId = (String)session.getAttribute("userimageUserId");
		File fullFile  = new File(item.getName());  
		//File savedFile = new File(getServletContext().getRealPath("/WEB-INF"+"/photo"),""+nickName+fullFile.getName());
		File savedFile = new File(getServletContext().getRealPath("/photos"),""+nickName+fullFile.getName());
		item.write(savedFile);		
		
		filePath = savedFile.getPath()	;	
		String configFilePath = getServletContext().getRealPath("/");
		filePath = filePath.replace(configFilePath,"");
	}
}
		vparam.add(userId);
		crsNickNameUserId = 	lobjGenerateProc.GenerateStoreProcedure("dbo.esp_dsp_getuserphotograph",vparam,"ScoreDB");
		vparam.removeAllElements();
		
		if (crsNickNameUserId!=null && crsNickNameUserId.size() > 0)
		{
				while (crsNickNameUserId.next())
				{
					String str = crsNickNameUserId.getString("photograph_path");
				}

		}

		vparam.add(userId);
		vparam.add(filePath);
		crsNickNameUserId = 	lobjGenerateProc.GenerateStoreProcedure("dbo.amd_photograh",vparam,"ScoreDB");
		if (crsNickNameUserId!=null)
		{
			while(crsNickNameUserId.next())
			{
				String Retval = crsNickNameUserId.getString("Retvalue");
				if (Retval.equalsIgnoreCase("1"))
				{
					 remark = crsNickNameUserId.getString("Remark");
					 out.println("<font color=red>Image uplaoded Successfully</font>");
				}
				else
				{
					out.println("<font color=red>Image uplaoding failed</font>");
				}
			}
		}
%>

<html>
		<head></head>
		<body>
				<table align=center>
						<tr>
							<td><a href="UserMaster.jsp">Click Here to go back to UserMaster</a></td>
						</tr>
				</table>
		</body>
</html>

