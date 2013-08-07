// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   media.java

package in.co.paramatrix.csms.common;

import java.io.IOException;
import java.io.PrintStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sun.jdbc.rowset.CachedRowSet;
import in.co.paramatrix.csms.generalamd.GenerateStoreProcedure;

import java.sql.SQLException;
import java.util.*;

public class media extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String seriesId = request.getParameter("login_page_series_id");
		GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
		Vector vparam = new Vector();
		CachedRowSet lobjCachedRowSet = null;
		if (seriesId != null && seriesId != "") {
			HttpSession session = request.getSession(true);

			vparam.add("Report");
			vparam.add("pass1");
			lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure(
					"slogin", vparam, "ScoreDB");
			if (lobjCachedRowSet != null) {
				try {
					if (lobjCachedRowSet.next()) {
						session.setAttribute("userid", lobjCachedRowSet
								.getString("id")); // session.getAttribute(
													// "userid")
						session.setAttribute("userId", lobjCachedRowSet
								.getString("id")); // session.getAttribute(
													// "userid")
						session.setAttribute("username", lobjCachedRowSet
								.getString("fname"));
						session.setAttribute("usernamesurname",
								lobjCachedRowSet.getString("usernamesurname"));

						/*
						 * Added by archana to get the user_role_id of user on
						 * 23/04/09
						 */
						session.setAttribute("user_role_id", lobjCachedRowSet
								.getString("user_role_id"));
						/* End Archana */
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			response.sendRedirect("/cims/jsp/SelectMatch.jsp?seriesId1="
					+ seriesId);
		} else {
			/* 23 */response.sendRedirect("/cims/jsp/SelectMatch.jsp?seriesId1="
					+ seriesId);
		}
	}
}
