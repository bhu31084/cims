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
	String player_name= request.getParameter("official")!=null?request.getParameter("official"):"";
	String seriesId = request.getParameter("seriesId")!=null?request.getParameter("seriesId"):"0";
	String 	associatioName  = request.getParameter("associatioName")!=null?request.getParameter("associatioName"):"";
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
			Paragraph paragraph = new Paragraph("Match Umpire Report");

			paragraph.setAlignment(Element.ALIGN_CENTER);
			paragraph.setIndentationLeft(50);

			document.add(paragraph);
			document.add(new Paragraph(" "));
			PdfPTable table = new PdfPTable(2);
			int header[] = { 6, 6};
			table.setWidths(header);
			table.setWidthPercentage(100);
			table.getDefaultCell().setPadding(2);
		    table.getDefaultCell().setBorder(Rectangle.NO_BORDER);
		    
		    table.addCell("Official Name:   "+player_name);
			table.addCell("Association Name:   "+associatioName);
			table.addCell("From Date:  "+start_date);
			table.addCell("End Date:  "+date_two);
			document.add(table);
			document.add(new Paragraph(" "));
			PdfPTable datatable = new PdfPTable(6);
			int headerwidths[] = { 6, 6, 6, 6, 6, 6};
			datatable.setWidths(headerwidths);
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);
			datatable.addCell(this.getBoldRightAllignedCell(" Match "));
			datatable.addCell(this.getBoldRightAllignedCell("Match Type"));
			datatable.addCell(this.getBoldRightAllignedCell("From Date"));
			datatable.addCell(this.getBoldRightAllignedCell("To Date"));
			datatable.addCell(this.getBoldRightAllignedCell("days"));
			datatable.addCell(this.getBoldRightAllignedCell("Tournament"));
			while (crsObj.next()) {

				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("match")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("matchtype")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("from_date")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("to_date")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("days")));
				datatable.addCell(this.getLeftAllignedCell(crsObj.getString("tournament")));
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