// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   ConnectionPool.java

package in.co.paramatrix.common;

import in.co.paramatrix.common.exceptions.InitFailed;
import in.co.paramatrix.common.exceptions.InternalError;
import in.co.paramatrix.common.exceptions.LimitCrossed;
import in.co.paramatrix.common.exceptions.NoEntity;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

// Referenced classes of package in.co.paramatrix.common:
//            Config, Logger

public class ConnectionPool {

            private Semaphore available;
            private Config __config;
            private static Logger log = null;
            private Hashtable busyCon;
            private Vector freeCon;
            private int maxCon;
            private String url;
            private String userName;
            private String password;
            private int makeAttempt;
            private long connectionTimeOut;
            private Hashtable con_spec;

            public ConnectionPool(Logger __logger, Config __config) throws SQLException {
/*  25*/        available = null;
/*  28*/        this.__config = null;
/*  38*/        busyCon = null;
/*  41*/        freeCon = null;
/*  47*/        maxCon = 0;
/*  50*/        url = null;
/*  53*/        userName = null;
/*  56*/        password = null;
/*  62*/        makeAttempt = 0;
/*  65*/        connectionTimeOut = 0L;
/*  67*/        con_spec = null;
/*  81*/        freeCon = new Vector();
/*  82*/        busyCon = new Hashtable();
/*  86*/        try {
/*  86*/            try {
/*  86*/                try {
/*  86*/                    Class.forName((String)__config.getValue("database-driver"));
                        }
/*  87*/                catch (NoEntity e) {
/*  88*/                    e.printStackTrace();
                        }
                    }
/*  90*/            catch (ClassNotFoundException e) {
/*  91*/                __logger.fatal(e.getMessage());
                    }
/*  94*/            try {
/*  94*/                url = (String)__config.getValue("database-url");
/*  95*/                userName = (String)__config.getValue("database-username");
/*  96*/                password = (String)__config.getValue("database-password");
/*  97*/                maxCon = Integer.parseInt((String)__config.getValue("max-db-conn"));
/*  98*/                makeAttempt = Integer.parseInt((String)__config.getValue("attempt-for-connection"));
/*  99*/                connectionTimeOut = Long.parseLong((String)__config.getValue("timeout-for-connection"));
                    }
/* 100*/            catch (NoEntity e) {
/* 101*/                e.printStackTrace();
                    }
/* 104*/            available = new Semaphore(maxCon, true);
/* 106*/            for (int i = 0; i < maxCon; i++) {
/* 107*/                Connection con = DriverManager.getConnection(url, userName, password);
/* 109*/                freeCon.addElement(con);
                    }

                }
/* 111*/        catch (SQLException e) {
/* 112*/            __logger.error((new StringBuilder("SQL Exception ")).append(e.getMessage()).toString());
/* 113*/            throw new SQLException(e.getMessage());
                }
            }

            public ConnectionPool(Hashtable con_specs) throws InitFailed, InternalError {
/*  25*/        available = null;
/*  28*/        __config = null;
/*  38*/        busyCon = null;
/*  41*/        freeCon = null;
/*  47*/        maxCon = 0;
/*  50*/        url = null;
/*  53*/        userName = null;
/*  56*/        password = null;
/*  62*/        makeAttempt = 0;
/*  65*/        connectionTimeOut = 0L;
/*  67*/        con_spec = null;
/* 125*/        con_spec = con_specs;
/* 127*/        try {
/* 127*/            if (con_spec.containsKey("database-driver")) {
/* 128*/                Class.forName((String)(String)con_spec.get("database-driver"));
                    } else {
/* 130*/                throw new InitFailed("DataBase Driver name not mentioned in the configuration.");
                    }
                }
/* 132*/        catch (ClassNotFoundException e) {
/* 133*/            throw new InitFailed("Driver Class Not Found in config.");
                }
/* 136*/        if (con_spec.containsKey("database-url")) {
/* 137*/            url = (String)(String)con_spec.get("database-url");
                } else {
/* 139*/            throw new InitFailed("Database-url not Found in config.");
                }
/* 142*/        if (con_spec.containsKey("database-username")) {
/* 143*/            userName = (String)(String)con_spec.get("database-username");
                } else {
/* 145*/            throw new InitFailed("Database user name not Found in config.");
                }
/* 148*/        if (con_spec.containsKey("database-password")) {
/* 149*/            password = (String)(String)con_spec.get("database-password");
                } else {
/* 151*/            throw new InitFailed("Database password not Found in config.");
                }
/* 154*/        if (con_spec.containsKey("max-db-conn")) {
/* 155*/            maxCon = Integer.parseInt((String)(String)con_spec.get("max-db-conn"));
                } else {
/* 157*/            throw new InitFailed("Variable max-db-conn not Found in config.");
                }
/* 160*/        if (con_spec.containsKey("attempt-for-connection")) {
/* 161*/            makeAttempt = Integer.parseInt((String)(String)con_spec.get("attempt-for-connection"));
                } else {
/* 163*/            throw new InitFailed("Variable attempt-for-connection not Found in config.");
                }
/* 166*/        if (con_spec.containsKey("timeout-for-connection")) {
/* 167*/            connectionTimeOut = Long.parseLong((String)(String)con_spec.get("timeout-for-connection"));
                } else {
/* 169*/            throw new InitFailed("Variable timeout-for-connection not Found in config.");
                }
/* 172*/        available = new Semaphore(maxCon, true);
/* 174*/        freeCon = new Vector();
/* 175*/        busyCon = new Hashtable();
/* 176*/        for (int i = 0; i < maxCon; i++) {
/* 177*/            Connection con = null;
/* 179*/            try {
/* 179*/                con = DriverManager.getConnection(url, userName, password);
                    }
/* 180*/            catch (SQLException e) {
/* 181*/                throw new InternalError(e.getMessage());
                    }
/* 183*/            freeCon.addElement(con);
                }

            }

            public Connection getConnection() throws LimitCrossed, InternalError {
/* 196*/        return getConnection("0");
            }

            public Connection getConnection(String id) throws LimitCrossed, InternalError {
/* 208*/        if (id == null || id.equals("0")) {
/* 209*/            id = (new Long(Thread.currentThread().getId())).toString();
                }
/* 211*/        if (busyCon.containsKey(new String(id))) {
/* 212*/            return (Connection)busyCon.get(new String(id));
                }
/* 214*/        if (freeCon.isEmpty()) {
/* 215*/            int counter = 0;
/* 218*/            do {
/* 218*/                try {
/* 218*/                    counter++;
/* 219*/                    if (makeAttempt != counter) {
/* 220*/                        boolean flag = available.tryAcquire(connectionTimeOut, TimeUnit.MILLISECONDS);
/* 222*/                        if (flag) {
/* 223*/                            busyCon.put(new String(id), (Connection)freeCon.elementAt(0));
/* 225*/                            freeCon.remove(0);
/* 226*/                            return (Connection)busyCon.get(new String(id));
                                }
                            } else {
/* 229*/                        throw new LimitCrossed("No free connection available");
                            }
                        }
/* 232*/                catch (InterruptedException e) {
/* 233*/                    throw new InternalError((new StringBuilder()).append(e.getMessage()).toString());
                        }
                    } while (true);
                } else {
/* 237*/            busyCon.put(new String(id), (Connection)freeCon.elementAt(0));
/* 238*/            freeCon.remove(0);
/* 239*/            available.tryAcquire();
/* 240*/            return (Connection)busyCon.get(new String(id));
                }
            }

            public void beginXaction() throws SQLException {
/* 252*/        beginXaction("0");
            }

            public void beginXaction(String id) throws SQLException {
/* 264*/        if (id == null || id.equals("0")) {
/* 265*/            id = (new Long(Thread.currentThread().getId())).toString();
                }
/* 267*/        if (busyCon.containsKey(new String(id))) {
/* 268*/            ((Connection)busyCon.get(new String(id))).setAutoCommit(false);
                }
            }

            public void endXaction() throws SQLException {
/* 279*/        endXaction("0");
            }

            public void endXaction(String id) throws SQLException {
/* 291*/        if (id == null || id.equals("0")) {
/* 292*/            id = (new Long(Thread.currentThread().getId())).toString();
                }
/* 294*/        if (busyCon.containsKey(new String(id))) {
/* 295*/            ((Connection)busyCon.get(new String(id))).commit();
                }
            }

            public int getMaxCon() {
/* 305*/        return maxCon;
            }

            public void setMaxCon(int numOfConn) {
/* 316*/        maxCon = numOfConn;
            }

            public int getFreeCon() {
/* 326*/        return freeCon.size();
            }

            public void returnConnection() {
/* 333*/        returnConnection("0");
            }

            public void returnConnection(String id) {
/* 343*/        if (id == null || id.equals("0")) {
/* 344*/            id = (new Long(Thread.currentThread().getId())).toString();
                }
/* 346*/        if (busyCon.containsKey(new String(id))) {
/* 348*/            try {
/* 348*/                Connection con = (Connection)busyCon.get(new String(id));
/* 349*/                if (!con.isClosed()) {
/* 350*/                    busyCon.remove(new String(id));
/* 351*/                    available.release();
/* 352*/                    freeCon.addElement(con);
                        } else {
/* 354*/                    busyCon.remove(new String(id));
/* 355*/                    freeCon.remove(con);
                        }
                    }
/* 357*/            catch (SQLException sqlexception) { }
                }
            }

            public void closeAlldbConnection() throws InternalError {
/* 375*/        for (int i = 0; i < freeCon.size(); i++) {
/* 376*/            Connection con = (Connection)freeCon.get(i);
/* 378*/            try {
/* 378*/                if (!con.isClosed()) {
/* 379*/                    con.close();
                        }
/* 381*/                con = null;
                    }
/* 382*/            catch (SQLException e) {
/* 383*/                throw new InternalError(e.getMessage());
                    }
                }

/* 388*/        for (Enumeration enu = busyCon.keys(); enu.hasMoreElements();) {
/* 390*/            String threadId = (String)(String)enu.nextElement();
/* 391*/            Connection con = (Connection)busyCon.get(threadId);
/* 393*/            try {
/* 393*/                if (!con.isClosed()) {
/* 394*/                    con.close();
                        }
/* 396*/                con = null;
                    }
/* 397*/            catch (SQLException e) {
/* 398*/                throw new InternalError(e.getMessage());
                    }
                }

/* 401*/        busyCon.clear();
/* 402*/        freeCon.clear();
            }

}
