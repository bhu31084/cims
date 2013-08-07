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
<%@ page import="in.co.paramatrix.common.ChangeInitial"%>
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
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*" %>

<%  response.setHeader("Pragma","private");
	response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");  
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>

<%  GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
	CachedRowSet  matchsearchDataCrs	 =  null;
    ChangeInitial chgInitial = new ChangeInitial();
    Vector vparam 			     =  new Vector();
	String fromdate		= "";
    String todate		= "";
	String tournament_id	= "";
	String match_id	= "";
	String searchFlag	= "";
	String userid = "";
	
	String matchno = "";
   	String tournament = "";
   	String venue = "";
   	String startdate = "";
   	String enddate = "";
   	String team1  = "";
   	String team2  = "";
    String umpire1 = "";
   	String umpire2 = "";
   	String umpire3 = "";
   	String umpirecoach  = "";
   	String matchreferee = "";
   	String scorer1  = "";
   	String scorer2  = "";
   	String 	gsFromDate = "";
	String 	gsToDate = "";
	//int srno = 0;
	Common commonUtil= new Common();	
	searchFlag = request.getParameter("flag")==null?"0":request.getParameter("flag");		
	try{
		   fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
		   todate = request.getParameter("todate")==null?"0":request.getParameter("todate");	   		
		   tournament_id = request.getParameter("tournamentid")==null?"0":request.getParameter("tournamentid");	   		
		   gsFromDate =commonUtil.formatDate(fromdate);
		   gsToDate =commonUtil.formatDate(todate);   
		   
		   HSSFWorkbook wb = new HSSFWorkbook();
		   
		   HSSFSheet sheet = wb.createSheet("new sheet");		  
		   
		   //set width
   		    sheet.setColumnWidth((short)0,(short)(1500));
		    sheet.setColumnWidth((short)1,(short)(5000));
			sheet.setColumnWidth((short)2,(short)(3000));
			sheet.setColumnWidth((short)3,(short)(3500));
			sheet.setColumnWidth((short)4,(short)(4000));
			sheet.setColumnWidth((short)5,(short)(4000));
			sheet.setColumnWidth((short)6,(short)(4000));
			sheet.setColumnWidth((short)7,(short)(4000));
		   
			//set font
			HSSFFont font = wb.createFont();
			font.setFontHeightInPoints((short)10);
			font.setFontName("Courier New");			
			font.setColor(HSSFColor.RED.index);
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);	
			HSSFCellStyle style = wb.createCellStyle();
			style.setFillBackgroundColor(HSSFColor.ORANGE.index);
			style.setFont(font);
		   
		   	HSSFRow row1 = sheet.createRow((short)2);
			HSSFCell cell1 = row1.createCell((short)0);
			cell1.setCellValue("Sr No");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)1);
			cell1.setCellValue("Tournament");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)2);
			cell1.setCellValue("Venue");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)3);
			cell1.setCellValue("Match Date");
			cell1.setCellStyle(style);

			cell1 = row1.createCell((short)4);
			cell1.setCellValue("Team Name");
			cell1.setCellStyle(style);
			
			cell1 = row1.createCell((short)5);
			cell1.setCellValue("Umpires");
			cell1.setCellStyle(style);
			
			cell1 = row1.createCell((short)6);
			cell1.setCellValue("Umpire Coach");
			cell1.setCellStyle(style);
			
			cell1 = row1.createCell((short)7);
			cell1.setCellValue("Match Referee");
			cell1.setCellStyle(style);
					
			vparam.add(gsFromDate);
			vparam.add(gsToDate);
			vparam.add(tournament_id);
			vparam.add(userid);
     	    vparam.add(searchFlag);	     	   					
			matchsearchDataCrs = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_exporttoexcel_matchesbydate",vparam,"ScoreDB");
			vparam.removeAllElements();
			if(matchsearchDataCrs!=null && matchsearchDataCrs.size()>0)
			{
				int i=2;
				int srno = 0;
				while(matchsearchDataCrs.next())
				{	
				   //matchno = matchsearchDataCrs.getString("match_id")!=null?matchsearchDataCrs.getString("match_id"):"";
				   tournament = matchsearchDataCrs.getString("series_name")!=null?chgInitial.properCase(matchsearchDataCrs.getString("series_name")).trim():"";
				   venue = matchsearchDataCrs.getString("venue_name")!=null?chgInitial.properCase(matchsearchDataCrs.getString("venue_name")).trim():"";
				   startdate  = matchsearchDataCrs.getString("start_ts")!=null?matchsearchDataCrs.getString("start_ts").substring(0,11):"";
				   enddate = matchsearchDataCrs.getString("end_ts")!=null?matchsearchDataCrs.getString("end_ts").substring(0,11):"";
				   team1  = matchsearchDataCrs.getString("team_one")!=null?chgInitial.properCase(matchsearchDataCrs.getString("team_one")).trim():"";
				   team2  = matchsearchDataCrs.getString("team_two")!=null?chgInitial.properCase(matchsearchDataCrs.getString("team_two")).trim():"";
				   
				   umpire1 = matchsearchDataCrs.getString("umpire1")!=null?chgInitial.properCase(matchsearchDataCrs.getString("umpire1")).trim():"";
				   umpire2 = matchsearchDataCrs.getString("umpire2")!=null?chgInitial.properCase(matchsearchDataCrs.getString("umpire2")).trim():"";
				   umpire3 = matchsearchDataCrs.getString("umpire3")!=null?chgInitial.properCase(matchsearchDataCrs.getString("umpire3")).trim():"";
				   umpirecoach  = matchsearchDataCrs.getString("umpirecoach")!=null?chgInitial.properCase(matchsearchDataCrs.getString("umpirecoach")).trim():"";
				   matchreferee = matchsearchDataCrs.getString("matchreferee")!=null?chgInitial.properCase(matchsearchDataCrs.getString("matchreferee")).trim():"";
				   scorer1  = matchsearchDataCrs.getString("scorer")!=null?chgInitial.properCase(matchsearchDataCrs.getString("scorer")).trim():"";
				   scorer2  = matchsearchDataCrs.getString("scorer2")!=null?chgInitial.properCase(matchsearchDataCrs.getString("scorer2")).trim():"";
				 				  
				  // send to exel
					i = i + 1;
					srno = srno + 1;
					//css for the row data in excel sheet.
					HSSFFont cellfont = wb.createFont();
					cellfont.setFontHeightInPoints((short)9);
					cellfont.setFontName("Arial");					
					HSSFCellStyle cellstyle = wb.createCellStyle();
					cellstyle.setFillBackgroundColor(HSSFColor.ORANGE.index);
					cellstyle.setFont(cellfont);
					cellstyle.setWrapText(true);								
					//cellstyle.setDataFormat(org.apache.poi.hssf.usermodel.HSSFDataFormat.);					
					
					HSSFRow row = sheet.createRow((short)i);
					HSSFCell cell = row.createCell((short)0);
					cell.setCellValue(srno);
					cell.setCellStyle(cellstyle);

					cell = row.createCell((short)1);
					cell.setCellValue(tournament);
					cell.setCellStyle(cellstyle);

					cell = row.createCell((short)2);
					cell.setCellValue(venue);
					cell.setCellStyle(cellstyle);

					cell = row.createCell((short)3);
					cell.setCellValue(startdate+" To "+enddate);
					cell.setCellStyle(cellstyle);

					cell = row.createCell((short)4);
					cell.setCellValue(team1+" Vs "+team2);
					cell.setCellStyle(cellstyle);

					cell = row.createCell((short)5);
					cell.setCellValue(umpire1+" & "+umpire2);
					cell.setCellStyle(cellstyle);

					cell = row.createCell((short)6);
					cell.setCellValue(umpirecoach);
					cell.setCellStyle(cellstyle);

					cell = row.createCell((short)7);
					cell.setCellValue(matchreferee);
					cell.setCellStyle(cellstyle);
				}
				   response.setContentType("application/vnd.ms-excel");
				   response.setHeader("Content-disposition","attachment; filename=\"MatchDetailsReport.xls\"" ); 
				   java.io.OutputStream outputStream = response.getOutputStream();
		  	       wb.write( outputStream );
		  	       outputStream.flush();
		  	       outputStream.close();
			  }		   
		 }
		 catch (Exception e)
		 {
			System.out.println("Exception " +e.getMessage());
		 } 
%>
