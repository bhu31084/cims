package in.co.paramatrix.csms.common;

import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class Test {
	// sqlserver://127.0.0.1:1433;DatabaseName=BCCI_SCORER
	// public static final String DB_URL = "jdbc:sqlserver://AMOL-PC/SQLEXPRESS;DatabaseName=master";

	public static final String DB_URL = "jdbc:sqlserver://localhost:1433;DatabaseName=BCCI_SCORER_UAT";
	public static final String DB_USERNAME = "sa";
	public static final String DB_PASSWORD = "sa";
	public static final String DB_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

	static Connection con = null;
	Test() {

		try {

			// Class.forName(DB_DRIVER);
			// con = DriverManager.getConnection(DB_URL, DB_USERNAME,DB_PASSWORD);
			System.out.println("Started");
			Document document = new Document();
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("d:\\AppointmentLetterForScorerPDF.pdf"));
			document.open();
			Font font = new Font(Font.HELVETICA, 12, Font.BOLD);
			Font boldUnderline = new Font(Font.HELVETICA, 10, Font.UNDERLINE);
			Font bold = new Font(Font.HELVETICA, 10, Font.BOLD);
			Font subHeader = new Font(Font.HELVETICA, 10, Font.NORMAL);

			Paragraph paragraph = new Paragraph("THE BOARD OF CONTROL FOR CRICKET IN INDIA", font);
			paragraph.setSpacingBefore(30);
			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(paragraph);
//
//			Image image = Image.getInstance("");
//			image.scaleToFit(50, 50);
//			Chunk img = new Chunk(image, 0, 0);
//			paragraph = new Paragraph();
//			paragraph.setSpacingBefore(40);
//			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
//			paragraph.add(img);
//			document.add(paragraph);

			paragraph = new Paragraph("BCCI/HQ/2559/2010-2011", subHeader);
			paragraph.setSpacingBefore(05);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			// Font fonts = FontFactory.getFont("Arial", BaseFont.IDENTITY_H, BaseFont.EMBEDDED, 10, Font.NORMAL, Color.BLACK);
			boldUnderline.setStyle(Font.BOLD);
			boldUnderline.setStyle(Font.UNDERLINE);

			paragraph = new Paragraph("Sub: Letter of Appointment of Scorers for Domestic Season 2011-12.", boldUnderline);
			paragraph.setSpacingBefore(05);
			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(paragraph);

			paragraph = new Paragraph("Dear Sir,", bold);
			paragraph.setSpacingBefore(05);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			paragraph = new Paragraph("You have been appointed as a scorer for the following match:- ", subHeader);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			PdfPTable table = new PdfPTable(3);
			table.setTotalWidth(new float[]{120, 15, 145});
			table.setLockedWidth(true);

			table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
			table.getDefaultCell().setHorizontalAlignment(table.ALIGN_LEFT);
			table.setWidthPercentage(100);
			table.setHorizontalAlignment(table.ALIGN_LEFT);
			
			table.addCell(new Paragraph("	1. Tournament Name ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("IRANI TROPHY ", subHeader));

			table.addCell(new Paragraph("	2. Team1 ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("Mumbai ", subHeader));

			table.addCell(new Paragraph("	3. Team2 ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("Delhi ", subHeader));

			table.addCell(new Paragraph("	4. Date From ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("Aug 1 2011", subHeader));

			table.addCell(new Paragraph("	5. Date To ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("Aug 5 2011 ", subHeader));

			table.addCell(new Paragraph("	6. Venue ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("Mumbai ", subHeader));

			document.add(table);

			paragraph = new Paragraph("Scorers Names:- ", subHeader);
			paragraph.setSpacingBefore(05);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			table = new PdfPTable(3);
			table.setTotalWidth(new float[]{120, 15, 145});
			table.setLockedWidth(true);

			table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
			table.getDefaultCell().setHorizontalAlignment(table.ALIGN_LEFT);
			table.setWidthPercentage(100);
			table.setHorizontalAlignment(table.ALIGN_LEFT);
			
			table.addCell(new Paragraph("	1. Online Scorer ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("ABCD XYZ ", subHeader));

			table.addCell(new Paragraph("	2. Manual Scorere ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("PQRS TUVY", subHeader));

			document.add(table);
			
			paragraph = new Paragraph("You are required to report to the Hon. Secretary: <Host Association>.", subHeader);
			paragraph.setSpacingBefore(10);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
			
			paragraph = new Paragraph("You are requested to strictly follow the instructions given below:", subHeader);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
			
			table = new PdfPTable(2);
			table.setTotalWidth(new float[]{25,500});
			table.setLockedWidth(true);

			table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
			table.getDefaultCell().setHorizontalAlignment(table.ALIGN_LEFT);
			table.getDefaultCell().setVerticalAlignment(table.ALIGN_TOP);
			table.setWidthPercentage(100);
			table.setHorizontalAlignment(table.ALIGN_LEFT);
			table.addCell(new Paragraph("	 1. ",bold));
			table.addCell(new Paragraph("You shall check the name of the players provided by the Team Manager and verify it with the names entered in the Online Registration System.", bold));
			table.addCell(new Paragraph("	 2. ",bold));
			table.addCell(new Paragraph("The name entered in the Online Registration System should be considered as final.", bold));
			table.addCell(new Paragraph("	 3. ",bold));
			table.addCell(new Paragraph("Any name which is provided by the Team Manager, not found registered in the Online System, should be brought to the notice of the Match Referee and the concerned Team Manager.", bold));
			table.addCell(new Paragraph("	 4. ",bold));
			table.addCell(new Paragraph("Any player who complains that his name entered in the Online registration system is incorrect, should be asked to write to BCCI through his Association.", bold));

			document.add(table);
			
			paragraph = new Paragraph("You will be paid match fees and TA/DA by the Staging Association as per BCCI norms.", subHeader);
			paragraph.setSpacingBefore(15);
			paragraph.setSpacingAfter(10);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
			
			paragraph = new Paragraph("Reporting pattern of the Online and Manual scorer:", bold);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
			
			paragraph = new Paragraph("One day before the first match, till last day of the last match.", subHeader);
			paragraph.setSpacingAfter(20);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
			
			paragraph = new Paragraph("Thanking you,", subHeader);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
			
			paragraph = new Paragraph("Yours Faithfully,", subHeader);
			paragraph.setSpacingAfter(30);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
		
			paragraph = new Paragraph("Prof. R.S.Shetty", bold);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
			paragraph = new Paragraph("Chief Administrative Officer, BCCI", bold);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
			
			document.close();

			System.out.println("End");
		} catch (Exception e) {
			System.out.println("An exception has occurred" + e);
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		new Test();
	}

	private String getNickName(String nickName, int location, String strLastName) {
		if (strLastName != null) {
			if (strLastName.length() > location) {
				nickName += strLastName.substring((location - 1), location);
			} else {
				nickName += "" + location;
			}
		} else {
			nickName += "" + location;
		}
		System.out.println("---nick----" + nickName);
		return nickName;
	}
}