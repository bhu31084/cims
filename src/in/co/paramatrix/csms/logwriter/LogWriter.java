// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   LogWriter.java

package in.co.paramatrix.csms.logwriter;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintStream;
import java.net.URL;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class LogWriter {

            String gsFileName;
            File gfFileName;
            FileWriter gfwLogWriter;
            Calendar rightNow;
            String loggedTime;
            String match_id;
            private String fileStr;
            static Class class$0;

            public LogWriter() {
/*  19*/        gsFileName = null;
/*  21*/        gfFileName = null;
/*  23*/        gfwLogWriter = null;
/*  25*/        rightNow = null;
/*  27*/        loggedTime = null;
/*  29*/        match_id = null;
/*  31*/        fileStr = "";
/*  34*/        URL u = LogWriter.class.getResource("LogWriter.class");
/*  35*/        fileStr = u.getPath();
/*  36*/        int length = fileStr.indexOf("/WEB-INF/");
/*  37*/        fileStr = (new StringBuilder("/")).append(fileStr.substring(1, length + 8)).append("/logs/").toString();
/*  38*/        fileStr = fileStr.replaceAll("%20", " ");
/*  40*/        rightNow = new GregorianCalendar();
/*  41*/        loggedTime = (new StringBuilder(String.valueOf(rightNow.get(5)))).append("/").append(rightNow.get(2) + 1).append("/").append(rightNow.get(1)).append(" ").append(rightNow.get(11)).append(":").append(rightNow.get(12)).append(":").append(rightNow.get(13)).append(":").append(rightNow.get(14)).toString();
            }

            public LogWriter(String match_id) {
/*  19*/        gsFileName = null;
/*  21*/        gfFileName = null;
/*  23*/        gfwLogWriter = null;
/*  25*/        rightNow = null;
/*  27*/        loggedTime = null;
/*  29*/        this.match_id = null;
/*  31*/        fileStr = "";
/*  52*/        this.match_id = match_id;
/*  53*/        URL u = LogWriter.class.getResource("LogWriter.class");
/*  54*/        fileStr = u.getPath();
/*  55*/        int length = fileStr.indexOf("/WEB-INF/");
/*  56*/        fileStr = (new StringBuilder("/")).append(fileStr.substring(1, length + 8)).append("/logs/").toString();
/*  57*/        fileStr = fileStr.replaceAll("%20", " ");
/*  59*/        rightNow = new GregorianCalendar();
/*  60*/        loggedTime = (new StringBuilder(String.valueOf(rightNow.get(5)))).append("/").append(rightNow.get(2) + 1).append("/").append(rightNow.get(1)).append(" ").append(rightNow.get(11)).append(":").append(rightNow.get(12)).append(":").append(rightNow.get(13)).append(":").append(rightNow.get(14)).toString();
            }

            public void writeErrLog(String lsinfo) {
                String fileName;
/*  79*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append("qssErr.txt").toString();
/*  80*/        gfFileName = new File(fileName);
/*  82*/        try {
/*  82*/            if (!gfFileName.exists()) {
/*  83*/                fileName = (new StringBuilder(String.valueOf(fileStr))).append("qssErr.txt").toString();
/*  84*/                gfFileName = new File(fileName);
                    }
/*  87*/            gfwLogWriter = new FileWriter(fileName, true);
/*  89*/            gfwLogWriter.write((new StringBuilder(String.valueOf(lsinfo))).append("  ").append(loggedTime).append(";").append('\n').toString());
                }
/*  92*/        catch (Exception exception) { }
/*  92*/       
/*  96*/        try {
/*  96*/            gfwLogWriter.close();
                }
/*  97*/        catch (Exception ex1) {
/*  98*/            System.out.println((new StringBuilder("error in Logs 1 ")).append(ex1).toString());
                }
/* 100*/       
/*  96*/        try {
/*  96*/            gfwLogWriter.close();
                }
/*  97*/        catch (Exception ex1) {
/*  98*/            System.out.println((new StringBuilder("error in Logs 1 ")).append(ex1).toString());
                }
/* 101*/        return;
            }

            public void writeErrLog(Class class_name, String file_name, String message) {
                String fileName;
/* 110*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append(file_name).append("_err.log").toString();
/* 111*/        System.out.println(fileName);
/* 112*/        gfFileName = new File(fileName);
/* 114*/        try {
/* 114*/            if (!gfFileName.exists()) {
/* 115*/                gfFileName = new File(fileName);
                    }
/* 117*/            gfwLogWriter = new FileWriter(fileName, true);
/* 118*/            gfwLogWriter.write((new StringBuilder(String.valueOf(class_name.getName()))).append(",").append(message).append(",").append(loggedTime).append("\n").toString());
                }
/* 120*/        catch (Exception ex) {
/* 121*/            System.err.println((new StringBuilder("[LogWriter][writeErrLog] ")).append(ex.toString()).toString());
                }
/* 121*/       
/* 124*/        try {
/* 124*/            gfwLogWriter.close();
                }
/* 125*/        catch (Exception ex1) {
/* 126*/            System.out.println((new StringBuilder("[LogWriter][writeErrLog] ")).append(ex1.toString()).toString());
                }
/* 128*/       
/* 124*/        try {
/* 124*/            gfwLogWriter.close();
                }
/* 125*/        catch (Exception ex1) {
/* 126*/            System.out.println((new StringBuilder("[LogWriter][writeErrLog] ")).append(ex1.toString()).toString());
                }
/* 129*/        return;
            }

            public void writeStoredprocLog(Class class_name, String file_name, String message) {
                String fileName;
/* 138*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append(file_name).append("_sp.log").toString();
/* 139*/        gfFileName = new File(fileName);
/* 141*/        try {
/* 141*/            if (!gfFileName.exists()) {
/* 142*/                fileName = (new StringBuilder(String.valueOf(fileStr))).append("qssOut.txt").toString();
/* 143*/                gfFileName = new File(fileName);
                    }
/* 145*/            gfwLogWriter = new FileWriter(fileName, true);
/* 146*/            gfwLogWriter.write((new StringBuilder(String.valueOf(class_name.getName()))).append(",").append(message).append(",").append(loggedTime).append("\n").toString());
                }
/* 149*/        catch (Exception ex) {
/* 150*/            System.err.println((new StringBuilder("[LogWriter][writeStoredprocLog] ")).append(ex.toString()).toString());
                }
/* 150*/       
/* 153*/        try {
/* 153*/            gfwLogWriter.close();
                }
/* 154*/        catch (Exception ex1) {
/* 155*/            System.out.println((new StringBuilder("[LogWriter][writeStoredprocLog] ")).append(ex1).toString());
                }
/* 157*/        
/* 153*/        try {
/* 153*/            gfwLogWriter.close();
                }
/* 154*/        catch (Exception ex1) {
/* 155*/            System.out.println((new StringBuilder("[LogWriter][writeStoredprocLog] ")).append(ex1).toString());
                }
/* 158*/        return;
            }

            public void writeStoredprocLog(Class class_name, String message) {
                String fileName;
/* 168*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append(match_id).append("_sp.log").toString();
/* 169*/        gfFileName = new File(fileName);
/* 171*/        try {
/* 171*/            if (!gfFileName.exists()) {
/* 172*/                fileName = (new StringBuilder(String.valueOf(fileStr))).append("qssOut.txt").toString();
/* 173*/                gfFileName = new File(fileName);
                    }
/* 175*/            gfwLogWriter = new FileWriter(fileName, true);
/* 176*/            gfwLogWriter.write((new StringBuilder(String.valueOf(class_name.getName()))).append(",").append(message).append(",").append(loggedTime).append("\n").toString());
                }
/* 179*/        catch (Exception ex) {
/* 180*/            System.err.println((new StringBuilder("[LogWriter][writeStoredprocLog] ")).append(ex.toString()).toString());
                }
/* 180*/       
/* 183*/        try {
/* 183*/            gfwLogWriter.close();
                }
/* 184*/        catch (Exception ex1) {
/* 185*/            System.out.println((new StringBuilder("[LogWriter][writeStoredprocLog] ")).append(ex1).toString());
                }
/* 187*/       
/* 183*/        try {
/* 183*/            gfwLogWriter.close();
                }
/* 184*/        catch (Exception ex1) {
/* 185*/            System.out.println((new StringBuilder("[LogWriter][writeStoredprocLog] ")).append(ex1).toString());
                }
/* 188*/        return;
            }

            public void writeStoredprocLog(String message) {
                String fileName;
/* 192*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append(match_id).append("_sp.log").toString();
/* 193*/        gfFileName = new File(fileName);
/* 195*/        try {
/* 195*/            if (!gfFileName.exists()) {
/* 196*/                gfFileName = new File(fileName);
                    }
/* 198*/            gfwLogWriter = new FileWriter(fileName, true);
/* 200*/            gfwLogWriter.write((new StringBuilder(String.valueOf(message))).append(", ").append(loggedTime).append('\n').toString());
                }
/* 202*/        catch (Exception exception) { }

/* 205*/        try {
/* 205*/            gfwLogWriter.close();
                }
/* 206*/        catch (Exception ex1) {
/* 207*/            System.out.println((new StringBuilder("error in Logs 2 ")).append(ex1).toString());
                }
/* 205*/        try {
/* 205*/            gfwLogWriter.close();
                }
/* 206*/        catch (Exception ex1) {
/* 207*/            System.out.println((new StringBuilder("error in Logs 2 ")).append(ex1).toString());
                }
/* 210*/        return;
            }

            public void writeAccessLog(String lsinfo) {
                String fileName;
/* 214*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append("qssAccess.txt").toString();
/* 215*/        gfFileName = new File(fileName);
/* 217*/        try {
/* 217*/            if (!gfFileName.exists()) {
/* 218*/                fileName = (new StringBuilder(String.valueOf(fileStr))).append("qssAccess.txt").toString();
/* 219*/                gfFileName = new File(fileName);
                    }
/* 221*/            gfwLogWriter = new FileWriter(fileName, true);
/* 223*/            gfwLogWriter.write((new StringBuilder(String.valueOf(lsinfo))).append(", ").append(loggedTime).append('\r').append('\n').toString());
                }
/* 225*/        catch (Exception exception) { }
/* 228*/        try {
/* 228*/            gfwLogWriter.close();
                }
/* 229*/        catch (Exception ex1) {
/* 230*/            System.out.println((new StringBuilder("error in Logs 3 ")).append(ex1).toString());
                }
/* 228*/        try {
/* 228*/            gfwLogWriter.close();
                }
/* 229*/        catch (Exception ex1) {
/* 230*/            System.out.println((new StringBuilder("error in Logs 3 ")).append(ex1).toString());
                }
/* 233*/        return;
            }

            public void writeConnLog(String conInfo) {
                String fileName;
/* 238*/        String lsInfo = null;
/* 239*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append("conPool.txt").toString();
/* 240*/        gfFileName = new File(fileName);
/* 242*/        try {
/* 242*/            if (!gfFileName.exists()) {
/* 243*/                fileName = (new StringBuilder(String.valueOf(fileStr))).append("conPool.txt").toString();
/* 244*/                gfFileName = new File(fileName);
                    }
/* 246*/            gfwLogWriter = new FileWriter(fileName, true);
/* 248*/            lsInfo = (new StringBuilder(String.valueOf(conInfo))).append(",").append(loggedTime).toString();
/* 249*/            gfwLogWriter.write((new StringBuilder(String.valueOf(lsInfo))).append('\r').append('\n').toString());
                }
/* 251*/        catch (Exception exception) { }
/* 251*/       
/* 254*/        try {
/* 254*/            gfwLogWriter.close();
                }
/* 255*/        catch (Exception ex1) {
/* 256*/            System.out.println((new StringBuilder("error in Logs 4 ")).append(ex1).toString());
                }
/* 258*/       
/* 254*/        try {
/* 254*/            gfwLogWriter.close();
                }
/* 255*/        catch (Exception ex1) {
/* 256*/            System.out.println((new StringBuilder("error in Logs 4 ")).append(ex1).toString());
                }
/* 259*/        return;
            }

            public void writeDBFLog(String lsInfoString) {
                String fileName;
/* 264*/        String lsInfo = null;
/* 265*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append("DBF.txt").toString();
/* 266*/        gfFileName = new File(fileName);
/* 268*/        try {
/* 268*/            if (!gfFileName.exists()) {
/* 269*/                fileName = (new StringBuilder(String.valueOf(fileStr))).append("DBF.txt").toString();
/* 270*/                gfFileName = new File(fileName);
                    }
/* 272*/            gfwLogWriter = new FileWriter(fileName, true);
/* 274*/            lsInfo = (new StringBuilder(String.valueOf(lsInfoString))).append(",").append(loggedTime).toString();
/* 275*/            gfwLogWriter.write((new StringBuilder(String.valueOf(lsInfo))).append('\r').append('\n').toString());
                }
/* 276*/        catch (Exception exception) { }
/* 276*/        
/* 279*/        try {
/* 279*/            gfwLogWriter.close();
                }
/* 280*/        catch (Exception ex1) {
/* 281*/            System.out.println((new StringBuilder("error in Logs 6 ")).append(ex1).toString());
                }
/* 283*/        
/* 279*/        try {
/* 279*/            gfwLogWriter.close();
                }
/* 280*/        catch (Exception ex1) {
/* 281*/            System.out.println((new StringBuilder("error in Logs 6 ")).append(ex1).toString());
                }
/* 284*/        return;
            }

            public void writeTimeLog(String lsInfoString) {
                String fileName;
/* 289*/        String lsInfo = null;
/* 290*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append("testPer.txt").toString();
/* 291*/        gfFileName = new File(fileName);
/* 293*/        try {
/* 293*/            if (!gfFileName.exists()) {
/* 294*/                fileName = (new StringBuilder(String.valueOf(fileStr))).append("testPer.txt").toString();
/* 295*/                gfFileName = new File(fileName);
                    }
/* 297*/            gfwLogWriter = new FileWriter(fileName, true);
/* 299*/            lsInfo = (new StringBuilder(String.valueOf(lsInfoString))).append(" ,  ").append(loggedTime).toString();
/* 300*/            gfwLogWriter.write((new StringBuilder(String.valueOf(lsInfo))).append('\r').append('\n').toString());
                }
/* 301*/        catch (Exception exception) { }
/* 301*/        
/* 304*/        try {
/* 304*/            gfwLogWriter.close();
                }
/* 305*/        catch (Exception ex1) {
/* 306*/            System.out.println((new StringBuilder("error in Logs 7 ")).append(ex1).toString());
                }
/* 308*/        
/* 304*/        try {
/* 304*/            gfwLogWriter.close();
                }
/* 305*/        catch (Exception ex1) {
/* 306*/            System.out.println((new StringBuilder("error in Logs 7 ")).append(ex1).toString());
                }
/* 309*/        return;
            }

            public void writeFileErrLog(String errInfo, String UserID) {
                String fileName;
/* 313*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append("qssXMLFileErr.txt").toString();
/* 314*/        gfFileName = new File(fileName);
/* 316*/        try {
/* 316*/            if (!gfFileName.exists()) {
/* 317*/                fileName = (new StringBuilder(String.valueOf(fileStr))).append("qssXMLFileErr.txt").toString();
/* 318*/                gfFileName = new File(fileName);
                    }
/* 321*/            gfwLogWriter = new FileWriter(fileName, true);
/* 323*/            gfwLogWriter.write((new StringBuilder(String.valueOf(errInfo))).append("  ").append(loggedTime).append("-~->User Id : ").append(UserID).append(" ;").append('\n').toString());
                }
/* 326*/        catch (Exception exception) { }
/* 326*/        
/* 330*/        try {
/* 330*/            gfwLogWriter.close();
                }
/* 331*/        catch (Exception ex1) {
/* 332*/            System.out.println((new StringBuilder("error in Logs 8 ")).append(ex1).toString());
                }
/* 334*/        
/* 330*/        try {
/* 330*/            gfwLogWriter.close();
                }
/* 331*/        catch (Exception ex1) {
/* 332*/            System.out.println((new StringBuilder("error in Logs 8 ")).append(ex1).toString());
                }
/* 335*/        return;
            }

            public void writeParseErrLog(String errInfo) {
                String fileName;
/* 339*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append("parseErr.txt").toString();
/* 340*/        gfFileName = new File(fileName);
/* 342*/        try {
/* 342*/            if (!gfFileName.exists()) {
/* 343*/                fileName = (new StringBuilder(String.valueOf(fileStr))).append("parseErr.txt").toString();
/* 344*/                gfFileName = new File(fileName);
                    }
/* 347*/            gfwLogWriter = new FileWriter(fileName, true);
/* 349*/            gfwLogWriter.write((new StringBuilder(String.valueOf(errInfo))).append("  ").append(loggedTime).append(";").append('\n').toString());
                }
/* 351*/        catch (Exception exception) { }
/* 351*/        try {
/* 355*/            gfwLogWriter.close();
                }
/* 356*/        catch (Exception ex1) {
/* 357*/            System.out.println((new StringBuilder("error in Logs 9 ")).append(ex1).toString());
                }
/* 359*/        try {
/* 355*/            gfwLogWriter.close();
                }
/* 356*/        catch (Exception ex1) {
/* 357*/            System.out.println((new StringBuilder("error in Logs 9 ")).append(ex1).toString());
                }
/* 360*/        return;
            }

            public void writeDBLog(String errInfo) {
                String fileName;
/* 364*/        fileName = (new StringBuilder(String.valueOf(fileStr))).append("DBLog.txt").toString();
/* 365*/        gfFileName = new File(fileName);
/* 367*/        try {
/* 367*/            if (!gfFileName.exists()) {
/* 368*/                fileName = (new StringBuilder(String.valueOf(fileStr))).append("DBLog.txt").toString();
/* 369*/                gfFileName = new File(fileName);
                    }
/* 372*/            gfwLogWriter = new FileWriter(fileName, true);
/* 374*/            gfwLogWriter.write((new StringBuilder(String.valueOf(errInfo))).append("  ").append(loggedTime).append(";").append('\n').toString());
                }
/* 376*/        catch (Exception exception) { }
/* 376*/        
/* 380*/        try {
/* 380*/            gfwLogWriter.close();
                }
/* 381*/        catch (Exception ex1) {
/* 382*/            System.out.println((new StringBuilder("error in Logs 10 ")).append(ex1).toString());
                }
/* 384*/        
/* 380*/        try {
/* 380*/            gfwLogWriter.close();
                }
/* 381*/        catch (Exception ex1) {
/* 382*/            System.out.println((new StringBuilder("error in Logs 10 ")).append(ex1).toString());
                }
/* 385*/        return;
            }
}
