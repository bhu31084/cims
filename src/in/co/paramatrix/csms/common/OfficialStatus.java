// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   media.java

package in.co.paramatrix.csms.common;

import in.co.paramatrix.csms.generalamd.GenerateStoreProcedure;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.jdbc.rowset.CachedRowSet;

public class OfficialStatus extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			response.setContentType("text/html");
			String match = request.getParameter("match");
			String offical = request.getParameter("offical");
			String status = request.getParameter("status");
			
			
	        PrintWriter out = response.getWriter();
	    	GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
	    	Vector 					vparam 					=  	new Vector();
	    	CachedRowSet  			lobjCachedRowSet		=	null;
	    	vparam.add(match);
			vparam.add(offical);
			vparam.add(offical);
			vparam.add("");
			vparam.add(status);
			vparam.add("3");
			
	    	lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialacceptance ", vparam, "ScoreDB");
	    	
			while(lobjCachedRowSet.next()){
				out.println("Your request post sucessfully");	
			}
				
		 } catch (SQLException e) {
			e.printStackTrace();
		  }
		 
	}
}
