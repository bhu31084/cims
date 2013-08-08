// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   ConnectionParameterReader.java

package in.co.paramatrix.csms.connection;


public class ConnectionParameterReader {

            private String dbid;
            private String dbclass;
            private String dburl;
            private String dbname;
            private String dblogin;
            private String dbpwd;
            private int maxConnection;

            public ConnectionParameterReader() {
/*  14*/        dbid = null;
/*  15*/        dbclass = null;
/*  16*/        dburl = null;
/*  17*/        dbname = null;
/*  18*/        dblogin = null;
/*  19*/        dbpwd = null;
/*  21*/        maxConnection = 5;
            }

            public void setDBid(String dbid) {
/*  28*/        this.dbid = dbid;
            }

            public void setDBclass(String dbclass) {
/*  36*/        this.dbclass = dbclass;
            }

            public void setDBurl(String dburl) {
/*  44*/        this.dburl = dburl;
            }

            public void setDBname(String dbname) {
/*  52*/        this.dbname = dbname;
            }

            public void setDBlogin(String dblogin) {
/*  60*/        this.dblogin = dblogin;
            }

            public void setDBpwd(String dbpwd) {
/*  68*/        this.dbpwd = dbpwd;
            }

            public String getDBid() {
/*  76*/        return dbid;
            }

            public String getDBclass() {
/*  84*/        return dbclass;
            }

            public String getDBurl() {
/*  92*/        return dburl;
            }

            public String getDBname() {
/* 100*/        return dbname;
            }

            public String getDBlogin() {
/* 108*/        return dblogin;
            }

            public String getDBpwd() {
/* 116*/        return dbpwd;
            }

            public int getMaxCon() {
/* 120*/        return maxConnection;
            }
}
