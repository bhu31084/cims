// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   Logger.java

package in.co.paramatrix.common;

import in.co.paramatrix.common.exceptions.InitFailed;
import in.co.paramatrix.common.exceptions.InvalidData;
import in.co.paramatrix.common.exceptions.NoInit;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.util.Properties;
import org.apache.log4j.HTMLLayout;
import org.apache.log4j.PropertyConfigurator;
import org.apache.log4j.WriterAppender;

public final class Logger {

            private static Logger instance = null;
            private static Object instanceLock = null;
            private static org.apache.log4j.Logger logger = null;

            public static void init(String className, Properties logger) throws InvalidData {
/*  50*/        synchronized (instanceLock) {
/*  51*/            if (instance == null) {
/*  53*/                try {
/*  53*/                    instance = new Logger(className, logger);
                        }
/*  54*/                catch (InitFailed e) {
/*  55*/                    throw new InvalidData("Data missing/inconsistency in configuration");
                        }
                    }
                }
            }

            public static Logger getInstance() throws NoInit {
/*  68*/        if (instance == null) {
/*  69*/            throw new NoInit("Logger Class not intialized yet.");
                } else {
/*  71*/            return instance;
                }
            }

            private Logger(String className, Properties logConfig) throws InitFailed {
/*  82*/        PropertyConfigurator.configure(logConfig);
/*  85*/        try {
/*  85*/            logger = org.apache.log4j.Logger.getLogger(className);
                }
/*  86*/        catch (Exception e) {
/*  87*/            throw new InitFailed(e.getMessage());
                }
/*  90*/        WriterAppender __writerAppender = null;
/*  91*/        HTMLLayout __htmllayout = new HTMLLayout();
/*  92*/        FileOutputStream commonLog = null;
/*  95*/        try {
/*  95*/            commonLog = new FileOutputStream("Logged.html");
                }
/*  96*/        catch (FileNotFoundException e) {
/*  97*/            System.out.println((new StringBuilder("Message : ")).append(e.getMessage()).toString());
                }
/*  99*/        __writerAppender = new WriterAppender(__htmllayout, commonLog);
/* 100*/        logger.addAppender(__writerAppender);
            }

            public void debug(Object message) {
/* 108*/        logger.debug(message);
            }

            public void info(Object message) {
/* 115*/        logger.info(message);
            }

            public void warn(Object message) {
/* 122*/        logger.warn(message);
            }

            public void error(Object message) {
/* 129*/        logger.error(message);
            }

            public void fatal(Object message) {
/* 136*/        logger.fatal(message);
            }

            static  {
/*  36*/        instanceLock = new int[1];
            }
}
