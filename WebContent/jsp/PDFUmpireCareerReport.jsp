<%@ page language="java" contentType="application/pdf"
	import="java.io.*,com.lowagie.text.pdf.*,com.lowagie.text.*,sun.jdbc.rowset.CachedRowSet,
	in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*,java.util.*,
	in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.common.*"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%
	OutputStream os = response.getOutputStream();
	response.setHeader ("Content-Disposition", "attachment;	filename=UmpireCareerReport.pdf");
	Document document = new Document(PageSize.A4, 50, 50, 50, 50);
	PdfWriter.getInstance(document, os);
	
	CachedRowSet crsObj           = null;
	
	CachedRowSet crsObjAssociationRecord = null;
	
	CachedRowSet crsObjSeason					 	 = null;
	Vector vparam                                    = new Vector();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
	"yyyy-MM-dd");
	Common common = new Common();
	String clubId= request.getParameter("clubId")!=null?request.getParameter("clubId"):"";
	String associatioName  = request.getParameter("associatioName")!=null?request.getParameter("associatioName"):"";
	String seriesId = request.getParameter("seriesId")!=null?request.getParameter("seriesId"):"0";
	String seasonId = request.getParameter("seasonId")!=null?request.getParameter("seasonId"):"";
	String roleId = request.getParameter("roleId")!=null?request.getParameter("roleId"):"";
	String flag = request.getParameter("flag")!=null?request.getParameter("flag"):"";
	String start_date = request.getParameter("txtDateFrom")!=null?request.getParameter("txtDateFrom"):"";
	String date_two = request.getParameter("txtDateTo")!=null?request.getParameter("txtDateTo"):"";
	String userRoleId = request.getParameter("userRoleId")!=null?request.getParameter("userRoleId"):"";
	
		vparam.add(seasonId);
		vparam.add(userRoleId);
		vparam.add(roleId);
		vparam.add(clubId);
		vparam.add(common.formatDate(start_date));
		vparam.add(common.formatDate(date_two));
		vparam.add(flag);
		crsObj = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_official_consoldated_report", vparam, "ScoreDB");
		vparam.removeAllElements();
	
	ReplaceApostroph replaceApos = new ReplaceApostroph();
	LogWriter log = new LogWriter();
	
	StringBuffer sbIds = new StringBuffer();
	StringBuffer sbrefereeIds = new StringBuffer();//For referee fields
	StringBuffer sbgrEquipIds = new StringBuffer();
	try {
			document.open();

			
			Paragraph paragraph = new Paragraph("Official Report");

			paragraph.setAlignment(Element.ALIGN_CENTER);
			paragraph.setIndentationLeft(50);

			document.add(paragraph);
			document.add(new Paragraph(" "));
			PdfPTable table = new PdfPTable(3);
			int header[] = { 8, 6, 6};
			table.setWidths(header);
			table.setWidthPercentage(100);
			table.getDefaultCell().setPadding(2);
		    table.getDefaultCell().setBorder(Rectangle.NO_BORDER);
		    table.addCell("Association Name: "+associatioName);
			table.addCell("From Date: "+start_date);
			table.addCell("End Date: "+date_two);
			document.add(table);
			document.add(new Paragraph(" "));
			PdfPTable datatable = new PdfPTable(9);
			int headerwidths[] = { 6, 6, 6, 6, 6, 6, 6, 6, 6 };
			datatable.setWidths(headerwidths);	
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);
			
			datatable.addCell(this.getBoldRightAllignedCell(" Official Name "));
			datatable.addCell(this.getBoldRightAllignedCell("One Day"));
			datatable.addCell(this.getBoldRightAllignedCell("Two Day"));
			datatable.addCell(this.getBoldRightAllignedCell(" Three Day "));
			datatable.addCell(this.getBoldRightAllignedCell("Four Day"));
			datatable.addCell(this.getBoldRightAllignedCell("Five Day"));
			datatable.addCell(this.getBoldRightAllignedCell(" T20 "));
			datatable.addCell(this.getBoldRightAllignedCell("Total Matches "));
			datatable.addCell(this.getBoldRightAllignedCell("Total Days"));
			while (crsObj.next()) {
				int totalMatch= 0 ;
				float totalDay = 0;
				totalMatch = Integer.parseInt(crsObj.getString("oneday")) + Integer.parseInt(crsObj.getString("twoday")) +
				Integer.parseInt(crsObj.getString("threeday")) + Integer.parseInt(crsObj.getString("fourday")) +
				Integer.parseInt(crsObj.getString("fiveday")) + (Integer.parseInt(crsObj.getString("t20")));
				
				totalDay = Integer.parseInt(crsObj.getString("oneday")) + (Integer.parseInt(crsObj.getString("twoday")) * 2) +
				(Integer.parseInt(crsObj.getString("threeday")) * 3) + (Integer.parseInt(crsObj.getString("fourday")) * 4) +
				(Integer.parseInt(crsObj.getString("fiveday")) * 5) + Float.parseFloat(crsObj.getString("t20"))/2;
				
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("official")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("oneday")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("twoday")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("threeday")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("fourday")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("fiveday")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("t20")));
				datatable.addCell(this.getLeftAllignedCell(String.valueOf(totalMatch)));
				datatable.addCell(this.getLeftAllignedCell(String.valueOf(totalDay)));
				
			}

			document.add(datatable);

						
		} catch(Exception e){
			e.printStackTrace();
		}	finally {
			document.close();
		}
	
%><%!private PdfPCell getBoldRightAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLD)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getBoldLeftAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getLeftAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getLeftAllignedCell(String name, int colspan) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setColspan(colspan);
		cell.setBorder(0);
		cell.setBorderWidth(0);
		return cell;
	}

	private PdfPCell getBoldCenterAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
		cell.setBorder(2);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getRightAllignedCellWoBorder(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorder(0);

		return cell;
	}

	private PdfPCell getLeftAllignedCellWoBorder(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorder(0);

		return cell;
	}

	private PdfPCell getRightAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);

		return cell;
	}

	private PdfPCell getRightAllignedCell(String name, int size) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, size, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}%>