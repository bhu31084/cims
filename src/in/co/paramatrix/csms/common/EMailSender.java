// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   EMailSender.java

package in.co.paramatrix.csms.common;

import in.co.paramatrix.csms.logwriter.LogWriter;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.net.URL;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;


public class EMailSender {

	public static String host = null;
	public static String port = null;
	public static String from = null;
	public static String username = null;
	public static String password = null;
	static Class class$0;

	public static void sendMail(String email, String CCeamilAddess,
			String message, ByteArrayOutputStream outputStream, String subject) {
		/* 35 */LogWriter lw = null;
		/* 36 */lw = new LogWriter();	
		/* 38 */LogWriter logwriter = new LogWriter();
		/* 39 */URL u = LogWriter.class.getResource("LogWriter.class");
		/* 40 */String PROPERTIE_FILE = u.getPath();
		/* 41 */int length = PROPERTIE_FILE.indexOf("/WEB-INF/");
		/* 42 */PROPERTIE_FILE = (new StringBuilder("/")).append(
				PROPERTIE_FILE.substring(1, length + 8)).append(
				"/MailConfig.properties/").toString();
		/* 43 */PROPERTIE_FILE = PROPERTIE_FILE.replaceAll("%20", " ");

		/* 44 */Properties poolProperties = new Properties();
		/* 47 */try {
			/* 47 */poolProperties.load(new FileInputStream(PROPERTIE_FILE));
			/* 48 */System.out.println((new StringBuilder("in try")).append(
					poolProperties.getProperty("driver")).toString());
		}
		/* 49 */catch (Exception propertyException) {
			/* 50 */propertyException.printStackTrace();
			/* 51 */lw.writeErrLog(propertyException.toString());
		}
		/* 53 */if (host == null) {
			/* 54 */host = poolProperties.getProperty("host");
			/* 55 */port = poolProperties.getProperty("port");
			/* 56 */from = poolProperties.getProperty("from");
			/* 57 */username = poolProperties.getProperty("username");
			/* 58 */password = poolProperties.getProperty("password");
		}
		/* 63 */try {
			/* 63 */Properties props = System.getProperties();
			/* 64 */props.put("mail.smtp.host", host);
			/* 65 */props.put("mail.smtp.port", port);
			/* 67 */// Session mailSession = Session.getInstance(props, null);
			// props.put("mail.smtp.host", host);
			 //props.put("mail.smtp.socketFactory.port", port);
			 //props.put("mail.smtp.socketFactory.class",
			 //"javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true"); 
			 //props.put("mail.smtp.port", port);
			Session mailSession = Session.getDefaultInstance(props,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(username,
									password);
						}
					});

			Message msg = new MimeMessage(mailSession); 
			System.out.println("fromfromfrom-------" + from);
			System.out.println("emailemailemailemail-------" + email);
			System.out.println("CCeamilAddessCCeamil--------------" + CCeamilAddess);
			
			/* 70 */msg.setFrom(new InternetAddress(from));
			/* 71 */InternetAddress address[] = {
			/* 71 */new InternetAddress(email) };
			if (CCeamilAddess != null && CCeamilAddess != "") {
				Address[] toUser = InternetAddress.parse(CCeamilAddess);
				msg.setRecipients(javax.mail.Message.RecipientType.CC,
						toUser);
			}

			/* 72 */msg.setRecipients(javax.mail.Message.RecipientType.TO,
					address);

			/* 73 */msg.setSubject(subject);
			/* 79 */MimeBodyPart mbp1 = new MimeBodyPart();
			/* 80 */MimeBodyPart mbp2 = new MimeBodyPart();
			/* 90 */
			// Set the email attachment file
			MimeBodyPart attachmentPart = new MimeBodyPart();
			byte[] bytes = outputStream.toByteArray();
			DataSource dataSource = new ByteArrayDataSource(bytes,
					"application/pdf");
//			FileDataSource fileDataSource = new FileDataSource(
//					"D:\\eclipse project\\cims\\WebContent\\pdf\\JUNIOR_DOMESTIC_PROGRAMME_2009-10.pdf") {
//				@Override
//				public String getContentType() {
//					return "application/pdf";
//				}
//			};
//			attachmentPart.setDataHandler(new DataHandler(fileDataSource));
//			attachmentPart.setFileName(attachment);
            MimeBodyPart pdfBodyPart = new MimeBodyPart();
            pdfBodyPart.setDataHandler(new DataHandler(dataSource));
            pdfBodyPart.setFileName("Appointment Letter.pdf");
			
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(pdfBodyPart);
			mbp1.setContent(message, "text/html");
			mp.addBodyPart(mbp1);
			msg.setContent(mp);
			msg.setSentDate(new Date());
			/* 101 */Transport.send(msg);
			/* 105 */System.out.println("Successfully message send.");
		}
		/* 108 */catch (Exception e) {
			/* 109 */e.printStackTrace();
		}
	}

	private static BodyPart getFileBodyPart(String txt_file, String content)
			throws MessagingException {
		/* 115 */BodyPart bp = new MimeBodyPart();
		/* 116 */return bp;
	}

	public static void main(String args[]) {
		/* 120 */EMailSender s = new EMailSender();
				String cc = "bhu31084@gmail.com";
		/* 121 */sendMail("bhu31084@gmail.com", cc, "hasdasi", null,
				"aasdsd");
	}

}
