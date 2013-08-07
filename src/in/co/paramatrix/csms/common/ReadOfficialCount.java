// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   ReadOfficialCount.java

package in.co.paramatrix.csms.common;

import java.io.*;
import java.net.URL;
import java.util.Properties;

public class ReadOfficialCount {

            private String fileStr;
            String str;
            String key;
            int umpval;
            int umpchval;
            int refval;  
            int scorerval;
            static Class class$0;

            public ReadOfficialCount() {
/*  11*/        fileStr = "";
            }

            public String getProxy(String user) {
/*  17*/        URL u = ReadOfficialCount.class.getResource("ReadOfficialCount.class");
/*  18*/        fileStr = u.getPath();
/*  19*/        int length = fileStr.indexOf("/WEB-INF/");
/*  20*/        fileStr = (new StringBuilder("/")).append(fileStr.substring(1, length + 8)).append("/Message.properties").toString();
/*  21*/        fileStr = fileStr.replaceAll("%20", " ");
/*  22*/        String newPath = fileStr.replace("/", "//");
/*  23*/        newPath = newPath.substring(2);
/*  26*/        String url = null;
/*  27*/        Properties props = new Properties();
/*  30*/        try {
/*  30*/            FileInputStream fis = new FileInputStream(newPath);
/*  31*/            props.load(fis);
/*  32*/            fis.close();
                }
/*  33*/        catch (Exception exception) { }
/*  37*/        if (user.equalsIgnoreCase("ump")) {
/*  38*/            String Umpire = props.getProperty("A2");
/*  39*/            return Umpire;
                }
/*  40*/        if (user.equalsIgnoreCase("umpch")) {
/*  41*/            String UmpireCoach = props.getProperty("H2");
/*  42*/            return UmpireCoach;
                }
/*  43*/        if (user.equalsIgnoreCase("ref")) {
/*  44*/            String Referee = props.getProperty("C2");
/*  45*/            return Referee;
                } else {
/*  47*/            String Scorer = props.getProperty("9B");
/*  48*/            return Scorer;
                }
            }

            public String setCounter(String user) {
/*  56*/        URL u = ReadOfficialCount.class.getResource("ReadOfficialCount.class");
/*  57*/        fileStr = u.getPath();
/*  58*/        int length = fileStr.indexOf("/WEB-INF/");
/*  59*/        fileStr = (new StringBuilder("/")).append(fileStr.substring(1, length + 8)).append("/Message.properties").toString();
/*  60*/        fileStr = fileStr.replaceAll("%20", " ");
/*  61*/        String newPath = fileStr.replace("/", "//");
/*  62*/        newPath = newPath.substring(2);
/*  63*/        System.out.print((new StringBuilder("\n")).append(newPath).toString());
/*  65*/        String url = null;
/*  66*/        Properties props = new Properties();
/*  69*/        try {
/*  69*/            FileInputStream fis = new FileInputStream(newPath);
/*  70*/            props.load(fis);
/*  71*/            fis.close();
                }
/*  72*/        catch (Exception exception) { }
/*  74*/        String Umpire = "";
/*  75*/        String UmpireCoach = "";
/*  76*/        String Referee = "";
/*  77*/        String Scorer = "";
/*  78*/        if (user.equalsIgnoreCase("ump")) {
/*  79*/            key = "A2";
/*  80*/            Umpire = props.getProperty("A2");
/*  81*/            if (Integer.parseInt(Umpire) != 10000) {
/*  82*/                umpval = Integer.parseInt(Umpire) + 1;
/*  83*/                String s = (new Integer(umpval)).toString();
/*  84*/                props.setProperty(key, s);
                    } else {
/*  86*/                props.setProperty(key, "1");
                    }
/*  90*/            try {
/*  90*/                props.store(new FileOutputStream(newPath), null);
                    }
/*  91*/            catch (FileNotFoundException e) {
/*  93*/                e.printStackTrace();
                    }
/*  94*/            catch (IOException e) {
/*  96*/                e.printStackTrace();
                    }
/*  99*/            String Umpire1 = props.getProperty("A2");
/* 101*/            return Umpire1;
                }
/* 103*/        if (user.equalsIgnoreCase("umpch")) {
/* 104*/            key = "H2";
/* 105*/            UmpireCoach = props.getProperty("H2");
/* 106*/            if (Integer.parseInt(UmpireCoach) != 10000) {
/* 107*/                umpchval = Integer.parseInt(UmpireCoach) + 1;
/* 108*/                String s = (new Integer(umpchval)).toString();
/* 109*/                props.setProperty(key, s);
                    } else {
/* 111*/                props.setProperty(key, "5000");
                    }
/* 115*/            try {
/* 115*/                props.store(new FileOutputStream(newPath), null);
/* 116*/                System.out.println("UmpireCh is *****************");
                    }
/* 117*/            catch (FileNotFoundException e) {
/* 119*/                e.printStackTrace();
                    }
/* 120*/            catch (IOException e) {
/* 122*/                e.printStackTrace();
                    }
/* 124*/            String UmpireCh = props.getProperty("H2");
/* 125*/            System.out.println((new StringBuilder("UmpireCh is *****************")).append(UmpireCh).toString());
/* 126*/            return UmpireCh;
                }
/* 127*/        if (user.equalsIgnoreCase("ref")) {
/* 128*/            key = "C2";
/* 129*/            Referee = props.getProperty("C2");
/* 130*/            if (Integer.parseInt(Referee) != 10000) {
/* 131*/                refval = Integer.parseInt(Referee) + 1;
/* 132*/                String s = (new Integer(refval)).toString();
/* 133*/                props.setProperty(key, s);
                    } else {
/* 135*/                props.setProperty(key, "7000");
                    }
/* 139*/            try {
/* 139*/                props.store(new FileOutputStream(newPath), null);
                    }
/* 140*/            catch (FileNotFoundException e) {
/* 142*/                e.printStackTrace();
                    }
/* 143*/            catch (IOException e) {
/* 145*/                e.printStackTrace();
                    }
/* 147*/            String matchReferee = props.getProperty("C2");
/* 148*/            return matchReferee;
                }
/* 150*/        key = "9B";
/* 151*/        Scorer = props.getProperty("9B");
/* 152*/        if (Integer.parseInt(Scorer) != 10000) {
/* 153*/            scorerval = Integer.parseInt(Scorer) + 1;
/* 154*/            String s = (new Integer(scorerval)).toString();
/* 155*/            props.setProperty(key, s);
                } else {
/* 157*/            props.setProperty(key, "1");
                }
/* 161*/        try {
/* 161*/            props.store(new FileOutputStream(newPath), null);
                }
/* 162*/        catch (FileNotFoundException e) {
/* 164*/            e.printStackTrace();
                }
/* 165*/        catch (IOException e) {
/* 167*/            e.printStackTrace();
                }
/* 169*/        String matchScorer = props.getProperty("9B");
/* 170*/        return matchScorer;
            }
}
