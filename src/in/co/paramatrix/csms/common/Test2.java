package in.co.paramatrix.csms.common;

import java.awt.Color;
import java.io.FileOutputStream;
import java.sql.*;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.Row;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPTableEvent;
import com.lowagie.text.pdf.PdfTable;
import com.lowagie.text.pdf.PdfWriter;

public class Test2 {
	Test2() {
		try {
			System.out.println("Started");
			Document document = new Document();
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("D:\\AppointmentLetterForScorerPDF3.pdf"));
			document.open();
			Font font = new Font(Font.HELVETICA, 12, Font.BOLD);
			Font boldUnderline = new Font(Font.HELVETICA, 10, Font.UNDERLINE);
			Font bold = new Font(Font.HELVETICA, 10, Font.BOLD);
			Font subHeader = new Font(Font.HELVETICA, 10, Font.NORMAL);

			Paragraph paragraph = new Paragraph("THE BOARD OF CONTROL FOR CRICKET IN INDIA", font);
			paragraph.setSpacingBefore(30);
			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(paragraph);

//			Image image = Image.getInstance("d:\\bcci.jpg");
//			image.scaleToFit(50, 50);
//			Chunk img = new Chunk(image, 0, 0);
//			paragraph = new Paragraph();
//			paragraph.setSpacingBefore(40);
//			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
//			paragraph.add(img);
//			document.add(paragraph);

			paragraph = new Paragraph("BCCI/HQ/<Match ID>/2011-12", subHeader);
			paragraph.setSpacingBefore(05);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			// Font fonts = FontFactory.getFont("Arial", BaseFont.IDENTITY_H, BaseFont.EMBEDDED, 10, Font.NORMAL, Color.BLACK);
			boldUnderline.setStyle(Font.BOLD);
			boldUnderline.setStyle(Font.UNDERLINE);

			paragraph = new Paragraph("Sub: Letter of Appointment of Match Officials for Domestic Season 2011-12.", boldUnderline);
			paragraph.setSpacingBefore(05);
			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(paragraph);

			paragraph = new Paragraph("Dear Sir,", bold);
			paragraph.setSpacingBefore(10);
			paragraph.setSpacingAfter(10);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			paragraph = new Paragraph("Match Official Names:- ", subHeader);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			PdfPTable table = new PdfPTable(3);
			table.setTotalWidth(new float[]{120, 15, 145});
			table.setLockedWidth(true);

			table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
			table.getDefaultCell().setHorizontalAlignment(table.ALIGN_LEFT);
			table.setWidthPercentage(100);
			table.setHorizontalAlignment(table.ALIGN_LEFT);

			table.addCell(new Paragraph("	1. Umpire 1 ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("Umpire Name ", subHeader));

			table.addCell(new Paragraph("	2. Umpire 2 ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("Umpire Name ", subHeader));
			
			table.addCell(new Paragraph("	3. Umpire 3 ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("Umpire Name ", subHeader));

			table.addCell(new Paragraph("	4. Match Refree ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("Refree Name ", subHeader));
			
			table.addCell(new Paragraph("	5. Umpire Coach ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("Umpire Coach Name ", subHeader));
			document.add(table);

			paragraph = new Paragraph("You have been appointed to officiate in the following match:- ", subHeader);
			paragraph.setSpacingBefore(10);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			table = new PdfPTable(3);
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

			table.addCell(new Paragraph("	7. Match Type ", bold));
			table.addCell(":");
			table.addCell(new Paragraph("MatchTypeName ", subHeader));
			
			document.add(table);
			
			paragraph = new Paragraph("You will be reporting to the Hony. Secretary of <Host Association>", subHeader);
			paragraph.setSpacingBefore(10);
			paragraph.setSpacingAfter(10);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			paragraph = new Paragraph("You will be paid Match fees & TA/DA as per BCCI norms.", subHeader);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			paragraph = new Paragraph("Reporting Pattern of Match Officials:-", boldUnderline);
			paragraph.setSpacingBefore(15);
			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(paragraph);
			
			paragraph = new Paragraph("Men’s Tournament:-", boldUnderline);
			paragraph.setSpacingBefore(5);
			paragraph.setSpacingAfter(5);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
			
			table = new PdfPTable(2);
			table.setTotalWidth(new float[]{20,500});
			table.setLockedWidth(true);
			table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
			table.getDefaultCell().setHorizontalAlignment(table.ALIGN_LEFT);
			table.setWidthPercentage(100);
			table.setHorizontalAlignment(table.ALIGN_LEFT);

			table.addCell(new Paragraph("	 1. ",subHeader));
			table.addCell(new Paragraph("For Multiday matches - Arrives two days before the match & leaves one day after the match.", subHeader));
			table.addCell(new Paragraph("	 2. ",subHeader));
			table.addCell(new Paragraph("For One Day & T20 matches-Arrives one day before the match & leaves one day after the match.", subHeader));
			
			document.add(table);

			paragraph = new Paragraph("Women’s Tournament:-", boldUnderline);
			paragraph.setSpacingBefore(5);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			paragraph = new Paragraph("Arrives one day before the match & leaves one day after the match.", subHeader);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			paragraph = new Paragraph();
			paragraph.setSpacingBefore(15);
			Chunk chunk1 = new Chunk("Note:",boldUnderline);
			Chunk chunk2 = new Chunk("If a match official is officiating different matches at the same venue, consecutively, the reporting pattern will be One day/Two days before the first match, till one day after the last match.",subHeader);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			paragraph.add(chunk1);
			paragraph.add(chunk2);
			document.add(paragraph);

			paragraph = new Paragraph("Thanking you,", subHeader);
			paragraph.setSpacingBefore(20);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			paragraph = new Paragraph("Yours Faithfully,", subHeader);
			paragraph.setSpacingAfter(15);
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
		new Test2();
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