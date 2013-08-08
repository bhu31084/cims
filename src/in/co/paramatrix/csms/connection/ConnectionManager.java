// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   ConnectionManager.java

package in.co.paramatrix.csms.connection;

import in.co.paramatrix.csms.logwriter.LogWriter;
import java.io.FileInputStream;
import java.io.PrintStream;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
import java.util.Vector;
import javax.servlet.http.HttpServlet;

// Referenced classes of package in.co.paramatrix.csms.connection:
//            ConnectionParameterReader

public class ConnectionManager extends HttpServlet {

            private String dbid;
            private Vector freeCon;
            private Vector usedCon;
            private ConnectionParameterReader dbParam;
            private String PROPERTIE_FILE;
            LogWriter logwriter;
            Vector tempConnection;
            static Class class$0;

            public ConnectionManager(String dbid) {
/*  25*/        this.dbid = null;
/*  26*/        freeCon = null;
/*  27*/        usedCon = null;
/*  28*/        dbParam = null;
/*  30*/        logwriter = new LogWriter();
/*  31*/        tempConnection = new Vector();
/*  39*/        this.dbid = dbid;
/*  41*/        dbParam = new ConnectionParameterReader();
/*  44*/        setParameter();
/*  45*/        freeCon = new Vector();
/*  47*/        usedCon = new Vector();
            }

            private void setParameter() {
                String dbDriverName;
                String DBURL;
                String DBLOGIN;
                String DBPWD;
                Connection con;
                Statement stmt;
                ResultSet rs;
/*  57*/        URL u = LogWriter.class.getResource("LogWriter.class");
/*  58*/        PROPERTIE_FILE = u.getPath();
/*  59*/        int length = PROPERTIE_FILE.indexOf("/WEB-INF/");
/*  60*/        PROPERTIE_FILE = (new StringBuilder("/")).append(PROPERTIE_FILE.substring(1, length + 8)).append("/DBConnect.properties/").toString();
/*  61*/        PROPERTIE_FILE = PROPERTIE_FILE.replaceAll("%20", " ");
/*  62*/        Properties poolProperties = new Properties();
/*  66*/        try {
/*  66*/            poolProperties.load(new FileInputStream(PROPERTIE_FILE));
                }
/*  68*/        catch (Exception propertyException) {
/*  69*/            propertyException.printStackTrace();
                }
/*  72*/        dbDriverName = poolProperties.getProperty("driver");
/*  73*/        DBURL = poolProperties.getProperty("url");
/*  74*/        DBLOGIN = poolProperties.getProperty("user");
/*  75*/        DBPWD = poolProperties.getProperty("password");
/*  76*/        int mNumberOfConnections = Integer.parseInt(poolProperties.getProperty("numberOfConnections"));
/*  78*/        con = null;
/*  79*/        stmt = null;
/*  80*/        rs = null;
/*  83*/        try {
/*  83*/            Class.forName(dbDriverName);
					try{
/*  87*/            con = DriverManager.getConnection(DBURL, DBLOGIN, DBPWD);
					}catch(Exception e){
						e.printStackTrace();
					}
/*  89*/            stmt = con.createStatement();
/*  90*/            System.out.println("stmt created");
/*  92*/            rs = stmt.executeQuery((new StringBuilder("SELECT DBID,TYPE,DBCLASS,DBURL,DBNAME,DBLOGIN,DBPWD\nFROM DatabaseID WHERE Type = 'CONPOOL' AND DBID = '")).append(dbid).append("'").toString());
/*  97*/            if (rs.next()) {
/*  99*/                System.out.println("login success");
/* 101*/                dbParam.setDBclass(rs.getString("DBCLASS"));
/* 102*/                dbParam.setDBurl(rs.getString("DBURL"));
/* 103*/                dbParam.setDBname(rs.getString("DBNAME"));
/* 104*/                System.out.println((new StringBuilder("ConnectionManager.setParameter()")).append(rs.getString("DBNAME")).toString());
/* 105*/                dbParam.setDBlogin(rs.getString("DBLOGIN"));
/* 106*/                dbParam.setDBpwd(rs.getString("DBPWD"));
                    } else {
/* 110*/                rs.getObject(1);
                    }
                }
/* 115*/        catch (Exception exception) { 
					exception.printStackTrace();
}
/* 120*/        try {
/* 120*/            if (rs != null) {
/* 120*/                rs.close();
/* 120*/                rs = null;
                    }
/* 121*/            if (stmt != null) {
/* 121*/                stmt.close();
/* 121*/                stmt = null;
                    }
/* 122*/            if (con != null) {
/* 122*/                con.close();
/* 122*/                con = null;
                    }
                }
/* 123*/        catch (Exception exception2) { }
/* 120*/        try {
/* 120*/            if (rs != null) {
/* 120*/                rs.close();
/* 120*/                rs = null;
                    }
/* 121*/            if (stmt != null) {
/* 121*/                stmt.close();
/* 121*/                stmt = null;
                    }
/* 122*/            if (con != null) {
/* 122*/                con.close();
/* 122*/                con = null;
                    }
                }
/* 123*/        catch (Exception exception3) { }
/* 129*/        try {
/* 129*/            Class.forName(dbParam.getDBclass());
/* 130*/            String DBNAME = dbParam.getDBname();
/* 131*/            String DBURL1 = dbParam.getDBurl();
/* 133*/            if (DBNAME != null && !DBNAME.trim().equals("")) {
/* 134*/                DBURL1 = (new StringBuilder(String.valueOf(DBURL1))).append(";DatabaseName=").append(DBNAME).toString();
                    }
/* 136*/            for (int min = 0; min < dbParam.getMaxCon(); min++) {
/* 138*/                tempConnection.addElement(DriverManager.getConnection(DBURL1, dbParam.getDBlogin(), dbParam.getDBpwd()));
                    }

                }
/* 141*/        catch (Exception e) {
/* 142*/            e.printStackTrace();
                }
/* 145*/        return;
            }

            public Vector getFreeCon() {
/* 158*/        return freeCon;
            }

            public Vector getUsedCon() {
/* 166*/        return usedCon;
            }

            public ConnectionParameterReader getDBParam() {
/* 174*/        return dbParam;
            }
}
