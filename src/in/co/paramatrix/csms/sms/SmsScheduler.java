// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 12/09/2011 21:35:24
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   SmsScheduler.java

package in.co.paramatrix.csms.sms;

import in.co.paramatrix.csms.common.EMailSender;
import in.co.paramatrix.csms.generalamd.GenerateStoreProcedure;
import in.co.paramatrix.csms.logwriter.LogWriter;
import java.io.*;
import java.net.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;
import sun.jdbc.rowset.CachedRowSet;

// Referenced classes of package in.co.paramatrix.csms.sms:
//            SmsSender

public class SmsScheduler {

	private String fileStr;
	Vector sendSmsVec;
	Vector checkTimeVec;
	Vector sendMailVec;
	CachedRowSet smsNotSendCrs;
	CachedRowSet smsTimeUpdateCrs;
	CachedRowSet sendMailCrs;
	String smsStatus;
	String errorText;
	GenerateStoreProcedure generateProc;
	GenerateStoreProcedure generateProc1;
	String proxyHost;
	String proxyPort;
	String userName;
	String password;
	String virtualMesg;
	EMailSender smail;
	LogWriter log;

	public SmsScheduler() {
		fileStr = "";
		sendSmsVec = new Vector();
		checkTimeVec = new Vector();
		sendMailVec = new Vector();
		smsNotSendCrs = null;
		smsTimeUpdateCrs = null;
		sendMailCrs = null;
		smsStatus = null;
		errorText = null;
		generateProc = new GenerateStoreProcedure();
		generateProc1 = new GenerateStoreProcedure();
		proxyHost = null;
		proxyPort = null;
		userName = null;
		password = null;
		virtualMesg = null;
		smail = new EMailSender();
		log = new LogWriter();
		URL u = SmsScheduler.class.getResource("SmsScheduler.class");
		fileStr = u.getPath();
		int length = fileStr.indexOf("/WEB-INF/");
		fileStr = (new StringBuilder("/")).append(
				fileStr.substring(1, length + 8)).append(
				"/ProxyConfig.properties").toString();
		fileStr = fileStr.replaceAll("%20", " ");
		String newPath = fileStr.replace("/", "//");
		newPath = newPath.substring(2);
		Properties props = new Properties();
		try {
			FileInputStream fis = new FileInputStream(newPath);
			props.load(fis);
			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
			log.writeErrLog((new StringBuilder(
					"[SmsScheduler]:[SmsScheduler()]")).append(e.toString())
					.toString());
			System.out.println((new StringBuilder(
					"[SmsScheduler]:[SmsScheduler()]")).append(e.toString())
					.toString());
		}
		proxyHost = props.getProperty("proxyHost");
		proxyPort = props.getProperty("proxyPort");
		userName = props.getProperty("userName");
		password = props.getProperty("password");
		virtualMesg = props.getProperty("virtualmessage");
		System.out.println((new StringBuilder("----virtualMesg---")).append(
				virtualMesg).toString());
	}

	private static URL getResource(String string) {
		// TODO Auto-generated method stub
		return null;
	}

	public String sendSMS(String urlToSendSms, String signature, String flag) {
		SmsScheduler smsscheduler = this;
		Date currentDateTime;
		SimpleDateFormat sdf;
		String responseMessage;
		System.out.println("SmsScheduler.sendSMS()");
		currentDateTime = new Date();
		sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		responseMessage = "";
		URL url;
		BufferedReader rd;
		OutputStreamWriter wr;
		Properties sysProps = System.getProperties();
//		sysProps.put("proxySet", "true");
//		if (proxyHost != null && proxyPort != null) {
//			sysProps.put("proxyHost", proxyHost);
//			sysProps.put("proxyPort", proxyPort);
//		}
//		if (userName != null && password != null) {
//			Authenticator authenticator = new Authenticator() {
//
//				public PasswordAuthentication getPasswordAuthentication() {
//					return new PasswordAuthentication(userName, password
//							.toCharArray());
//				}
//
//			};
//			Authenticator.setDefault(authenticator);
//		}
		try {
			String data = (new StringBuilder(String.valueOf(URLEncoder.encode(
					"key1", "UTF-8")))).append("=").append(
					URLEncoder.encode("value1", "UTF-8")).toString();
			data = (new StringBuilder(String.valueOf(data))).append("&")
					.append(URLEncoder.encode("key2", "UTF-8")).append("=")
					.append(URLEncoder.encode("value2", "UTF-8")).toString();
			if (virtualMesg.equalsIgnoreCase("true")) {
				responseMessage = "SUCCESS";

			}
			if (!virtualMesg.equalsIgnoreCase("false")) {
				responseMessage = "FAILURE";
			}
			url = new URL(urlToSendSms.toString().replaceAll(" ", "%20"));

			rd = null;
			wr = null;
			URLConnection conn = url.openConnection();
			conn.setDoOutput(true);
			wr = new OutputStreamWriter(conn.getOutputStream());
			wr.flush();
			rd = new BufferedReader(
					new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = rd.readLine()) != null) {
				responseMessage = (new StringBuilder(String
						.valueOf(responseMessage))).append(line).toString();
			}
			if (wr != null && rd != null) {
				wr.close();
				rd.close();
			}
			if (wr != null && rd != null) {
				wr.close();
				rd.close();
			}
		} catch (Exception e) {
			log.writeErrLog((new StringBuilder(
					"[SmsScheduler]:[sendSMS():RuntimeException : ]")).append(
					e.toString()).toString());
			System.out.println((new StringBuilder(
					"[SmsScheduler]:[sendSMS():RuntimeException : ]")).append(
					e.toString()).toString());
			e.printStackTrace();
			System.out.println("Network error: Sleeping now!!!!!!!!!!!");
			String email = null;
			String messageNetErr = e.getMessage();
			sendMailVec.removeAllElements();
			sendMailVec.add("admin");
			sendMailCrs = generateProc1.GenerateStoreProcedure("esp_dsp_email",
					sendMailVec, "ScoreDB");
			sendMailVec.removeAllElements();
			if (sendMailCrs != null) {
				try {
					while (sendMailCrs.next()) {
						email = sendMailCrs.getString("email");
						EMailSender.sendMail(email, "", messageNetErr,null,
								"SMS sending error");
						Thread.sleep(50000);
					}
				} catch (Exception e2) {

				}
			}
		}

		System.out.println((new StringBuilder(
				"SmsScheduler.sendSMS()responseMessage")).append(
				responseMessage).toString());
		responseMessage = responseMessage.replaceAll("'", "''");
		if (flag.equalsIgnoreCase("1") && responseMessage != null)
			try {
				sendSmsVec.removeAllElements();
				sendSmsVec.add("2");
				sendSmsVec.add(signature.trim());
				if (responseMessage.indexOf("SUCCESS") != -1) {
					sendSmsVec.add(sdf.format(currentDateTime));
					sendSmsVec.add("F");
					sendSmsVec.add("");
				} else {
					int errIndex = responseMessage.indexOf("FAIL");
					errorText = responseMessage.substring(errIndex + 4);
					System.out.println((new StringBuilder(
							"SmsScheduler.sendSMS() : errorText")).append(
							errorText).toString());
					if (errorText.indexOf("NDNC") == -1)
						sendSmsVec.add(sdf.format(""));
					else
						sendSmsVec.add(sdf.format(currentDateTime));
					int errIndex2 = responseMessage.indexOf("Error");
					if (errIndex2 != -1)
						errorText = responseMessage;
					sendSmsVec.add("T");
					sendSmsVec.add(errorText);
				}
				System.out.println((new StringBuilder(
						"esp_dsp_checksendmessage ")).append(sendSmsVec)
						.toString());
				smsTimeUpdateCrs = generateProc1.GenerateStoreProcedure(
						"esp_dsp_checksendmessage", sendSmsVec, "ScoreDB");
				sendSmsVec.removeAllElements();
				if (errorText != null
						&& errorText.trim().equalsIgnoreCase(
								"Credit is insufficient")) {
					String messageNetErr = "Your SMS cannot be sent to official.\nReason : Credit is insufficient";
					String email = null;
					sendMailVec.removeAllElements();
					sendMailVec.add("admin");
					sendMailCrs = generateProc1.GenerateStoreProcedure(
							"esp_dsp_email", sendMailVec, "ScoreDB");
					sendMailVec.removeAllElements();
					if (sendMailCrs != null)
						while (sendMailCrs.next())
							email = sendMailCrs.getString("email");

					EMailSender.sendMail(email, "", messageNetErr,null,
							"SMS sending error");
				} else {
					wait(5000L);
				}
			} catch (Exception e) {
				log.writeErrLog((new StringBuilder(
						"[SmsScheduler]:[sendSMS()] : Database save :"))
						.append(e.toString()).toString());
				log.writeErrLog((new StringBuilder("esp_dsp_checksendmessage"))
						.append(sendSmsVec).toString());
				System.out.println((new StringBuilder(
						"[SmsScheduler]:[sendSMS()] : Database save : "))
						.append(e).toString());
				e.printStackTrace();
			}
		if (flag.equalsIgnoreCase("1")) {
			notifyAll();
			System.out.println("After notifying ");
		}
		return "";
	}

	public void sendFirstSMS() {
		synchronized (this) {
			notifyAll();
		}
	}

	public void sendToSchedular() {
		synchronized (this) {
			System.out.println("In SmsScheduler.sendToSchedular()");
			String contactNum = null;
			String message = null;
			String signature = null;
			String urlToSendMsg = null;
			String responseMessage = null;
			String flag = "1";
			SmsSender smsSender = new SmsSender();
			try {
				checkTimeVec.removeAllElements();
				checkTimeVec.add("1");
				checkTimeVec.add("");
				checkTimeVec.add("");
				checkTimeVec.add("");
				checkTimeVec.add("");
				smsNotSendCrs = generateProc.GenerateStoreProcedure(
						"esp_dsp_checksendmessage", checkTimeVec, "ScoreDB");
				checkTimeVec.removeAllElements();
			} catch (Exception e) {
				log
						.writeErrLog((new StringBuilder(
								"[SmsScheduler]:[sendToSchedular() : check null time :]"))
								.append(e.toString()).toString());
				System.out
						.println((new StringBuilder(
								"[SmsScheduler]:[sendToSchedular() : check null time :]"))
								.append(e).toString());
				e.printStackTrace();
			}
			if (smsNotSendCrs != null && smsNotSendCrs.size() > 0){
				try {
					for (; smsNotSendCrs.next(); System.out
							.println((new StringBuilder(
									"SmsScheduler.sendToSchedular()responseMessage"))
									.append(responseMessage).toString())) {
						contactNum = smsNotSendCrs.getString("reply_phone");
						message = smsNotSendCrs.getString("content");
						signature = smsNotSendCrs.getString("sig");
						urlToSendMsg = smsSender.buildUrl(contactNum, message);
						System.out.println((new StringBuilder(
								"urlToSendMsg        ")).append(urlToSendMsg)
								.toString());
						responseMessage = sendSMS(urlToSendMsg, signature, flag);
					}

				} catch (SQLException e) {
					log.writeErrLog((new StringBuilder(
							"[SmsScheduler]:[sendToSchedular: SQLException]"))
							.append(e.toString()).toString());
					System.out
							.println((new StringBuilder(
									"[SmsScheduler]:[sendToSchedular(): SQLException]"))
									.append(e).toString());
					e.printStackTrace();
				}
			}else{
				try {
					System.out
							.println("SmsScheduler.sendToSchedular() before wait");
					wait(86400000L);
					System.out
							.println("SmsScheduler.sendToSchedular() after wait");
				} catch (Exception e) {
					log.writeErrLog((new StringBuilder(
							"[SmsScheduler]:[sendToSchedular: for wait()]"))
							.append(e.toString()).toString());
					System.out.println((new StringBuilder(
							"[SmsScheduler]:[sendToSchedular(): for wait()]"))
							.append(e).toString());
					e.printStackTrace();
				}
			}
		}	
	}

	public static void main(String arg[]) {
		new SmsScheduler();
	}

}
