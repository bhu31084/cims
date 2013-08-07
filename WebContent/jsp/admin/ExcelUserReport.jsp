<!--
Page name	 : ExcelReport.jsp
Replaced By  : Vaibhav Gaikar.
Created Date : 2 March 2009
Description  : To export User details in excel
Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,in.co.paramatrix.csms.logwriter.LogWriter"%>
<%@ page import="in.co.paramatrix.common.validator.DataValidator,in.co.paramatrix.common.exceptions.NoEntity,in.co.paramatrix.common.exceptions.InvalidEntity"%>
<%@ page import="in.co.paramatrix.common.authz.AuthZ"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFHeader"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFPrintSetup"%>
<%@ page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>

<%  response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
  
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	CachedRowSet  userDataCrs	 =  null;
    Vector vparam 			     =  new Vector();
	String roleId		= "";
    String nickName		= "";
	String firstName	= "";
	String middleName	= "";
	String lastName		= "";
	String displayName	= "";
	String matchCount	= "";
	String sex			= "";
%>

<%	roleId = request.getParameter("roleId")!=null?request.getParameter("roleId"):"";
	try{
		   HSSFWorkbook wb = new HSSFWorkbook();
		   HSSFSheet sheet = wb.createSheet("new sheet");
		   
		   //set width
   		    sheet.setColumnWidth((short)1,(short)(5000));
		    sheet.setColumnWidth((short)2,(short)(5000));
			sheet.setColumnWidth((short)3,(short)(5000));
			sheet.setColumnWidth((short)4,(short)(5000));
			sheet.setColumnWidth((short)5,(short)(5000));
			sheet.setColumnWidth((short)6,(short)(5000));
			sheet.setColumnWidth((short)7,(short)(5000));
			sheet.setColumnWidth((short)8,(short)(5000));
			sheet.setColumnWidth((short)9,(short)(5000));			
			sheet.setColumnWidth((short)10,(short)(5000));			

		   //set font
			HSSFFont font = wb.createFont();
			font.setFontHeightInPoints((short)12);
			font.setFontName("Courier New");
			font.setItalic(true);
			font.setColor(HSSFColor.RED.index);
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			HSSFCellStyle style = wb.createCellStyle();
			style.setFillBackgroundColor(HSSFColor.ORANGE.index);
			style.setFont(font);
		   
		   	HSSFRow row1 = sheet.createRow((short)2);
			HSSFCell cell1 = row1.createCell((short)1);
			cell1.setCellValue("NickName");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)2);
			cell1.setCellValue("DisplayName");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)3);
			cell1.setCellValue("FirstName");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)4);
			cell1.setCellValue("MiddleName");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)5);
			cell1.setCellValue("LastName");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)6);
			cell1.setCellValue("Sex");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)7);
			cell1.setCellValue("NoOfMatches");
			cell1.setCellStyle(style);
		
     	    vparam.add(roleId);							
			userDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_userExcelReport",vparam,"ScoreDB");
			vparam.removeAllElements();
			if(userDataCrs!=null && userDataCrs.size()>0)
			{
				int i=2;
				while(userDataCrs.next())
				{		
				   nickName    = userDataCrs.getString("nickname")!=null?userDataCrs.getString("nickname"):"";
				   displayName = userDataCrs.getString("displayname")!=null?userDataCrs.getString("displayname"):"";
				   firstName   = userDataCrs.getString("fname")!=null?userDataCrs.getString("fname"):"";
				   middleName  = userDataCrs.getString("mname")!=null?userDataCrs.getString("mname"):"";
				   lastName    = userDataCrs.getString("sname")!=null?userDataCrs.getString("sname"):"";
				   matchCount  = userDataCrs.getString("Matchcount")!=null?userDataCrs.getString("Matchcount"):"";
				   sex		   = userDataCrs.getString("sex")!=null?userDataCrs.getString("sex"):"";
								  
				  // send to exel
					i = i + 1;
					HSSFRow row = sheet.createRow((short)i) ;
					HSSFCell cell = row.createCell((short)1);
					cell.setCellValue(nickName);

					cell = row.createCell((short)2);
					cell.setCellValue(displayName);

					cell = row.createCell((short)3);
					cell.setCellValue(firstName);

					cell = row.createCell((short)4);
					cell.setCellValue(middleName);

					cell = row.createCell((short)5);
					cell.setCellValue(lastName);

					cell = row.createCell((short)6);
					cell.setCellValue(sex);

					cell = row.createCell((short)7);
					cell.setCellValue(matchCount);
				}
				   response.setContentType("application/vnd.ms-excel");
				   response.setHeader("Content-disposition","attachment; filename=\"UserReport.xls\"" ); 
				   java.io.OutputStream outputStream = response.getOutputStream();
		  	       wb.write( outputStream );
		  	       outputStream.flush();
		  	       outputStream.close();
			  }		   
		 }
		 catch (Exception e){
			System.out.println("Exception " +e.getMessage());
		 } 
%>
