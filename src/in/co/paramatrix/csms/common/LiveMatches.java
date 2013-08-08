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

public class LiveMatches extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
			"yyyy/MM/dd");
			
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
			"yyyy-MM-dd");
			
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
			"dd/MM/yyyy");
	
	
			String date_one = sdf2.format(new Date());
			String date_two = sdf2.format(new Date());
			Common common = new Common();
			response.setContentType("application/xml");
	        PrintWriter out = response.getWriter();
	    	GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
	    	Vector 					vparam 					=  	new Vector();
	    	CachedRowSet  			lobjCachedRowSet		=	null;
	    	vparam.add(common.formatDate(date_one));
			vparam.add(common.formatDate(date_two));
	    	lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getmatches", vparam, "ScoreDB");
	    	vparam.removeAllElements();
	    	String matchXML = "<matches>";
	    	String matcgId = "";
			while(lobjCachedRowSet.next()){
					
				matcgId = matcgId + "<match>"+ lobjCachedRowSet.getString("matches_id") +"</match>";
			}
			matchXML = matchXML + matcgId + "</matches>";
			System.out.println(matchXML);
			out.print(matchXML);
				
		 } catch (SQLException e) {
			e.printStackTrace();
		  }
		 
	}
}
