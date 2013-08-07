// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   ConnectionManagerHandler.java

package in.co.paramatrix.csms.connection;

import in.co.paramatrix.csms.logwriter.LogWriter;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.Vector;

// Referenced classes of package in.co.paramatrix.csms.connection:
//            ConnectionManager, ConnectionParameterReader

public class ConnectionManagerHandler {

            static Hashtable dbid = new Hashtable();
            static Vector freeCon = null;
            static Vector usedCon = null;
            static LogWriter lw = new LogWriter();


            public static synchronized Connection getConnection(String DBID) {
/*  30*/        ConnectionManager mgr = null;
/*  33*/        if (!dbid.containsKey(DBID)) {
/*  34*/            mgr = new ConnectionManager(DBID);
/*  36*/            dbid.put(DBID, mgr);
                } else {
/*  40*/            mgr = (ConnectionManager)(ConnectionManager)dbid.get(DBID);
                }
/*  43*/        freeCon = mgr.getFreeCon();
/*  44*/        usedCon = mgr.getUsedCon();
                Connection con;
/*  47*/        if (freeCon.isEmpty()) {
/*  49*/            con = createConnection(mgr.getDBParam());
/*  51*/            usedCon.add(con);
/*  52*/            return con;
                }
/*  56*/        con = (Connection)(Connection)freeCon.elementAt(0);
/*  57*/        freeCon.remove(0);
/*  58*/        boolean flag = checkConnection(con);
/*  59*/        if (flag) {
/*  60*/            usedCon.add(con);
/*  62*/            return con;
                } else {
/*  66*/            con = createConnection(mgr.getDBParam());
/*  67*/            usedCon.add(con);
/*  68*/            return con;
                }
            }

            public static synchronized void releaseConnection(Connection con, String DBID) {
/*  76*/        ConnectionManager mgr = null;
/*  77*/        Connection con1 = null;
/*  78*/        mgr = (ConnectionManager)(ConnectionManager)dbid.get(DBID);
/*  79*/        Vector freeCon = mgr.getFreeCon();
/*  80*/        Vector usedCon = mgr.getUsedCon();
/*  81*/        usedCon.remove(con);
/*  82*/        freeCon.add(con);
/*  85*/        try {
/*  85*/            if (freeCon.size() >= 10) {
/*  87*/                con1 = (Connection)(Connection)freeCon.elementAt(0);
/*  88*/                freeCon.remove(0);
/*  89*/                con1.close();
						
/*  90*/                lw.writeConnLog("release the free connection");
                    }
                }
/*  93*/        catch (Exception e) {
/*  94*/            lw.writeConnLog((new StringBuilder("Error in ConnectionManagerHandler : releaseConnection :")).append(e).toString());
                }
/*  96*/        lw.writeConnLog((new StringBuilder("used : ")).append(usedCon.size()).append(" freeCon : ").append(freeCon.size()).toString());
            }

            private static boolean checkConnection(Connection con) {
/* 101*/        try {
/* 101*/            Statement stmt = con.createStatement();
/* 102*/            ResultSet rs = stmt.executeQuery("select 1");
/* 103*/            rs.close();
/* 104*/            stmt.close();
/* 105*/            return true;
                }
/* 106*/        catch (Exception e) {
/* 107*/            lw.writeConnLog((new StringBuilder("Error in ConnectionManagerHandler : checkConnection ")).append(e).toString());
                }
/* 109*/        return false;
            }

            private static synchronized Connection createConnection(ConnectionParameterReader param) {
/* 114*/        try {
/* 114*/            Class.forName(param.getDBclass());
/* 115*/            String DBNAME = param.getDBname();
/* 116*/            String DBURL = param.getDBurl();
/* 118*/            if (DBNAME != null && !DBNAME.trim().equals("")) {
/* 119*/                DBURL = (new StringBuilder(String.valueOf(DBURL))).append(";DatabaseName=").append(DBNAME).toString();
                    }
/* 121*/            
/* 122*/            lw.writeStoredprocLog("Creating New Connection");
/* 123*/            return DriverManager.getConnection(DBURL, param.getDBlogin(), param.getDBpwd());
                }
/* 124*/        catch (Exception e) {
/* 125*/            lw.writeConnLog((new StringBuilder("Error in ConnectionManagerHandler : createConnection ")).append(e).toString());
                }
/* 127*/        return null;
            }

}
