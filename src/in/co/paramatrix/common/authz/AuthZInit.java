// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   AuthZInit.java

package in.co.paramatrix.common.authz;

import in.co.paramatrix.common.Config;
import in.co.paramatrix.common.Logger;
import in.co.paramatrix.common.exceptions.InvalidData;
import in.co.paramatrix.common.exceptions.InvalidFormat;
import in.co.paramatrix.common.validator.DataValidator;
import java.io.*;
import java.net.URL;
import java.util.Properties;
import java.util.Vector;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Referenced classes of package in.co.paramatrix.common.authz:
//            AuthZ

public class AuthZInit extends HttpServlet {

            AuthZ auth;
            private final String filePath = getFilePath();
            private final String logFile = "LogConfig.properties";
            private final String authZFile = "AuthZConfig.properties";
            private final String validatorConfFile = "validator/validatorConf.txt";
            static Class class$0;


            public void destroy() {
/*  46*/        super.destroy();
            }

            public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException {
            }

            public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException {
            }

            public void init(ServletConfig servletConfig) throws ServletException {
/*  93*/        Config config = new Config(readConfig((new StringBuilder(String.valueOf(filePath))).append("AuthZConfig.properties").toString()));
/*  95*/        Properties prop = new Properties();
/*  97*/        try {
/*  97*/            prop.load(new FileInputStream((new StringBuilder(String.valueOf(filePath))).append("LogConfig.properties").toString()));
                }
/*  98*/        catch (FileNotFoundException e) {
/*  99*/            System.err.println(e);
                }
/* 100*/        catch (IOException e) {
/* 101*/            System.err.println(e);
                }
/* 106*/        try {
/* 106*/            Logger.init("", prop);
                }
/* 107*/        catch (InvalidData e) {
/* 108*/            System.err.println(e.toString());
                }
/* 113*/        try {
/* 113*/            AuthZ.init(config);
                }
/* 114*/        catch (InvalidData e) {
/* 115*/            System.err.println((new StringBuilder("AuthZInit Constructor : ")).append(e).toString());
                }
/* 119*/        Config configValidator = new Config(readConfig((new StringBuilder(String.valueOf(filePath))).append("validator/validatorConf.txt").toString()));
/* 120*/        ServletContext ctx = servletConfig.getServletContext();
/* 123*/        try {
/* 123*/            DataValidator dv = new DataValidator(configValidator);
/* 124*/            ctx.setAttribute("datavalidator", dv);
/* 125*/            System.out.println((new StringBuilder("Successfully Added DV in Application Session ")).append(dv).toString());
                }
/* 126*/        catch (InvalidFormat e) {
/* 127*/            System.err.println(e);
                }
            }

            private String getFilePath() {
/* 138*/        String configFile = AuthZInit.class.getResource("AuthZInit.class").getPath();
/* 140*/        int length = configFile.indexOf("/WEB-INF/");
/* 141*/        configFile = (new StringBuilder("/")).append(configFile.substring(1, length + 8)).append("/").toString();
/* 142*/        configFile = configFile.replaceAll("%20", " ");
/* 143*/        return configFile;
            }

            private Vector readConfig(String strFile) {
/* 154*/        FileReader fileReader = null;
/* 156*/        try {
/* 156*/            fileReader = new FileReader(strFile);
                }
/* 157*/        catch (FileNotFoundException filenotfoundexception) { }
/* 161*/        BufferedReader br = new BufferedReader(fileReader);
/* 162*/        String singleLine = "";
/* 163*/        Vector lvAllLine = new Vector();
/* 166*/        try {
/* 166*/            while ((singleLine = br.readLine()) != null)  {
/* 166*/                lvAllLine.addElement(singleLine);
                    }
                }
/* 168*/        catch (IOException ioexception) { }
/* 171*/        return lvAllLine;
            }
}
