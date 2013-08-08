// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   GenerateStoreProcedure.java

package in.co.paramatrix.csms.generalamd;

import in.co.paramatrix.csms.connection.ConnectionManagerHandler;
import in.co.paramatrix.csms.logwriter.LogWriter;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Vector;
import sun.jdbc.rowset.CachedRowSet;

public class GenerateStoreProcedure {

            LogWriter lw;
            private static final String COLLON = "'";
            private static final String COMMA = ",";

            public GenerateStoreProcedure() {
/*  27*/        lw = null;
/*  32*/        lw = new LogWriter();
            }

            public GenerateStoreProcedure(String match_id) {
/*  27*/        lw = null;
/*  36*/        lw = new LogWriter(match_id);
            }

            public CachedRowSet GenerateStoreProcedure(String spName, Vector parameters, String DBID) {
                Connection dbCconn;
                CachedRowSet rset;
                Long timeBeforeSPExecute;
                Long timeAfterSPExecute;
/*  40*/        dbCconn = null;
/*  41*/        rset = null;
/*  43*/        timeBeforeSPExecute = Long.valueOf(0L);
/*  44*/        timeAfterSPExecute = Long.valueOf(0L);
/*  47*/        try {
/*  47*/            dbCconn = ConnectionManagerHandler.getConnection(DBID);
/*  48*/            if (dbCconn != null) {
/*  49*/                Statement stmt = dbCconn.createStatement();
/*  50*/                String strQuery = (new StringBuilder("exec ")).append(spName).append(" ").append(getParamString(parameters)).toString();
/*  52*/                timeBeforeSPExecute = Long.valueOf(System.currentTimeMillis());
						System.out.println(strQuery );
/*  54*/                ResultSet rs = stmt.executeQuery(strQuery);
/*  56*/                timeAfterSPExecute = Long.valueOf(System.currentTimeMillis());
						System.out.println(strQuery );
/*  58*/                lw.writeStoredprocLog((new StringBuilder(String.valueOf(strQuery))).append(" * ").append(timeAfterSPExecute.longValue() - timeBeforeSPExecute.longValue()).toString());
/*  61*/                rset = new CachedRowSet();
/*  62*/                rset.populate(rs);
/*  63*/                rs.close();
/*  64*/                stmt.close();
                    }
                }
/*  66*/        catch (SQLException e) {
/*  67*/            String errsp = (new StringBuilder("Error In : GenerateStoreProcedure :  exec ")).append(spName).append(" ").append(getParamString(parameters)).append(" * ").append(timeAfterSPExecute.longValue() - timeBeforeSPExecute.longValue()).append(" * ").append(new Date()).toString();
/*  68*/            e.printStackTrace();
/*  72*/            lw.writeErrLog(errsp);
/*  73*/            lw.writeErrLog(e.toString());
                }
/*  77*/        try {
/*  77*/            ConnectionManagerHandler.releaseConnection(dbCconn, DBID);
				}
/*  78*/        catch (Exception exception1) { }
/*  77*/        try {
/*  77*/            ConnectionManagerHandler.releaseConnection(dbCconn, DBID);
                }
/*  78*/        catch (Exception exception2) { }
				return rset;
            }

            private static String getParamString(Vector parameters) {
/*  85*/        StringBuffer param = new StringBuffer();
/*  87*/        if (parameters == null || parameters.size() == 0) {
/*  88*/            return param.toString();
                }
/*  91*/        int i = 0;
/*  92*/        for (i = 0; i < parameters.size() - 1; i++) {
/*  93*/            param.append(getCoatedParam((String)(String)parameters.elementAt(i))).append(",");
                }

/*  96*/        param.append(getCoatedParam((String)(String)parameters.elementAt(i)));
/*  98*/        return param.toString();
            }

            private static String getCoatedParam(String param) {
/* 102*/        return "'" + param + "'";
            }
}
