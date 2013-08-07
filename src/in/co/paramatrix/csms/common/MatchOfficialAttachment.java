package in.co.paramatrix.csms.common;

import java.io.OutputStream;
import java.util.Date;

import sun.jdbc.rowset.CachedRowSet;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class MatchOfficialAttachment {
	
	public static OutputStream matchOfficialAttachment(String imagePath, String macthId,CachedRowSet  crsObjMatchData,
			OutputStream outputStream, String reamrk) {
		
		
		try {
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
			"dd/MM/yyyy");
			String season = crsObjMatchData.getString("season_name");
			String TournamentName = crsObjMatchData.getString("series_name");
		    String Team1 = crsObjMatchData.getString("team_one");
		    String Team2 = crsObjMatchData.getString("team_two");
			String DateFrom = crsObjMatchData.getString("from_date").substring(0,12).trim();
			String DateTo = crsObjMatchData.getString("to_date").substring(0,12).trim();
			String venue = crsObjMatchData.getString("venue_name");
			String matchTypeName = crsObjMatchData.getString("matchtype_name"); 
			String clubName = crsObjMatchData.getString("club_name");
			String umpire1 = crsObjMatchData.getString("umpire1");
			String umpire2 = crsObjMatchData.getString("umpire2");
			String umpire3 = crsObjMatchData.getString("umpire3");
			if(umpire3.equalsIgnoreCase("")  || umpire3==null){
				umpire3 = "N.A.";
			}
			String matchreferee = crsObjMatchData.getString("matchreferee");
			String umpirecoach = crsObjMatchData.getString("umpirecoach");
			Document document = new Document();

			PdfWriter.getInstance(document, outputStream);
			document.open();
			Font font = new Font(Font.HELVETICA, 12, Font.BOLD);
			Font boldUnderline = new Font(Font.HELVETICA, 10, Font.UNDERLINE);
			Font bold = new Font(Font.HELVETICA, 10, Font.BOLD);
			Font subHeader = new Font(Font.HELVETICA, 10, Font.NORMAL);

			Paragraph paragraph = new Paragraph("THE BOARD OF CONTROL FOR CRICKET IN INDIA", font);
			paragraph.setSpacingBefore(30);
			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
			document.add(paragraph);

			Image image = Image.getInstance(imagePath);
			image.scaleToFit(50, 50);
			Chunk img = new Chunk(image, 0, 0);
			paragraph = new Paragraph();
			paragraph.setSpacingBefore(40);
			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
			paragraph.add(img);
			document.add(paragraph);

			paragraph = new Paragraph("BCCI/HQ/"+ "<Match Id >"+ macthId+"/"+season , subHeader);
			paragraph.setSpacingBefore(05);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			// Font fonts = FontFactory.getFont("Arial", BaseFont.IDENTITY_H, BaseFont.EMBEDDED, 10, Font.NORMAL, Color.BLACK);
			boldUnderline.setStyle(Font.BOLD);
			boldUnderline.setStyle(Font.UNDERLINE);
			if(reamrk.equalsIgnoreCase("")){
			paragraph = new Paragraph("Sub: Letter of Appointment of Match Officials for Domestic Season "+season +".", boldUnderline);
			}else{
				paragraph = new Paragraph("Sub: Revised Appointment Letter (Revised on "+ sdf2.format(new Date()) +" ) of Match Officials for Domestic Season "+season +".", boldUnderline);
			}
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
			table.setTotalWidth(new float[] { 120, 15, 145	 });
			table.setLockedWidth(true);

			table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
			table.getDefaultCell().setHorizontalAlignment(table.ALIGN_LEFT);
			table.setWidthPercentage(100);
			table.setHorizontalAlignment(table.ALIGN_LEFT);

			table.addCell(new Paragraph("	1. Umpire 1 ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(umpire1 , subHeader));

			table.addCell(new Paragraph("	2. Umpire 2 ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(umpire2 , subHeader));
			
			table.addCell(new Paragraph("	3. Umpire 3 ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(umpire3 , subHeader));

			table.addCell(new Paragraph("	4. Match Refree ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(matchreferee, subHeader));
			
			table.addCell(new Paragraph("	5. Umpire Coach ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(umpirecoach, subHeader));
			
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
			table.addCell(new Paragraph(TournamentName , subHeader));

			table.addCell(new Paragraph("	2. Team1 ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(Team1 , subHeader));

			table.addCell(new Paragraph("	3. Team2 ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(Team2 , subHeader));

			table.addCell(new Paragraph("	4. Date From ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(DateFrom , subHeader));

			table.addCell(new Paragraph("	5. Date To ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(DateTo , subHeader));

			table.addCell(new Paragraph("	6. Venue ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(venue , subHeader));

			table.addCell(new Paragraph("	7. Match Type ", bold));
			table.addCell(":");
			table.addCell(new Paragraph(matchTypeName , subHeader));
			
			document.add(table);
			
			paragraph = new Paragraph("You will be reporting to the Hony. Secretary of "+clubName , subHeader);
			paragraph.setSpacingBefore(10);
			paragraph.setSpacingAfter(10);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			paragraph = new Paragraph("You will be paid Match fees & TA/DA as applicable to you.", subHeader);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);

			paragraph = new Paragraph("Reporting Pattern of Match Officials (Men & Women):-", boldUnderline);
			paragraph.setSpacingBefore(15);
			paragraph.setAlignment(Paragraph.ALIGN_CENTER);
			paragraph.setSpacingAfter(15);
			document.add(paragraph);

			
			table = new PdfPTable(2);
			table.setTotalWidth(new float[]{20,500});
			table.setLockedWidth(true);
			table.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
			table.getDefaultCell().setHorizontalAlignment(table.ALIGN_LEFT);
			table.setWidthPercentage(100);
			table.setHorizontalAlignment(table.ALIGN_LEFT);

			table.addCell(new Paragraph("	 1. ",subHeader));
			table.addCell(new Paragraph("For Multiday matches – Arrive two days before the match & leave one day after the match.", subHeader));
			table.addCell(new Paragraph("	 2. ",subHeader));
			table.addCell(new Paragraph("For One Day & T20 matches as follows:-", subHeader));
			table.addCell(new Paragraph("  ",subHeader));
			table.addCell(new Paragraph(" A) 1st set of officials: - Arrive two days before the match & leave one day after the match.", subHeader));
			table.addCell(new Paragraph(" ",subHeader));
			table.addCell(new Paragraph(" B) 2nd set of officials: - Arrive one day before the match & leave one day after the match.", subHeader));
			document.add(table);

			
			paragraph = new Paragraph();
			paragraph.setSpacingBefore(15);
			Chunk chunk1 = new Chunk("Note:",boldUnderline);
			Chunk chunk2 = new Chunk("Multiday Knockout matches can be extended by one day, in case there is no first innings result at the end of the scheduled last day.",subHeader);
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
			paragraph = new Paragraph("c.c. Hon Jt Secretary, BCCI", bold);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);			
			document.add(paragraph);
			paragraph = new Paragraph("This is an electronically generated document & does not require a signature",
					bold);
			paragraph.setAlignment(Paragraph.ALIGN_LEFT);
			document.add(paragraph);
			document.close();
			return outputStream;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
}
