// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 12/09/2011 21:36:38
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   SmsServlet.java

package in.co.paramatrix.csms.sms;

import in.co.paramatrix.csms.logwriter.LogWriter;
import java.io.IOException;
import java.io.PrintStream;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.*;

// Referenced classes of package in.co.paramatrix.csms.sms:
//            SmsScheduler

public class SmsServlet extends HttpServlet {
	SmsScheduler smsScheduler;
	LogWriter log;
	public SmsServlet() {
		smsScheduler = new SmsScheduler();
		log = new LogWriter();
	}

	public void init() {
		try {
			ServletContext context = getServletContext();
			context.setAttribute("smsService", smsScheduler);
			(new Thread() {

				public void run() {
					do {
						System.out.println("SmsServlet.init()");
						smsScheduler.sendToSchedular();
					} while (true);
				}
			}).start();
		} catch (Exception e) {
			System.out.println("SmsServlet.init()");
			log.writeErrLog((new StringBuilder("[SmsServlet]:[init()]"))
					.append(e.toString()).toString());
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		java.io.PrintWriter out = response.getWriter();
	}

	
}
