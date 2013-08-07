// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 12/09/2011 21:36:20
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   SmsSender.java

package in.co.paramatrix.csms.sms;

import in.co.paramatrix.csms.logwriter.LogWriter;
import java.io.FileInputStream;
import java.io.PrintStream;
import java.net.URL;
import java.util.Properties;

public class SmsSender
{
    private String fileStr;
    LogWriter log;
    public SmsSender()
    {
        fileStr = "";
        log = new LogWriter();
    }

    public String buildUrl(String contactNumber, String message)
    {
    	URL u = SmsSender.class.getResource("SmsSender.class");
        fileStr = u.getPath();
        int length = fileStr.indexOf("/cims/");
        fileStr = (new StringBuilder("/")).append(fileStr.substring(1, length + 5)).append("/jsp/sms/smsConfig.properties").toString();
        fileStr = fileStr.replaceAll("%20", " ");
        String newPath = fileStr.replace("/", "//");
        newPath = newPath.substring(2);
        String url = null;
        Properties props = new Properties();
        try
        {
            FileInputStream fis = new FileInputStream(newPath);
            props.load(fis);
            fis.close();
            String currentProvider = props.getProperty("ProviderName");
            System.out.println((new StringBuilder("Current Provider--->")).append(currentProvider).toString());
            String ProviderName = props.getProperty(currentProvider.trim());
            if(currentProvider.trim().equalsIgnoreCase("Provider1URL"))
            {
                String link = props.getProperty(currentProvider.trim());
                url = (new StringBuilder(String.valueOf(link))).append("?feedid=177390&username=9322266012&password=dpgwg&To=").append(contactNumber).append("&Text=").append(message).append("&time=200902121200&senderid=BCCI").toString();
                System.out.println((new StringBuilder("url :")).append(url).toString());
            } else
            if(currentProvider.trim().equalsIgnoreCase("Provider2URL"))
            {
                String link = props.getProperty(currentProvider.trim());
                url = (new StringBuilder(String.valueOf(link))).append("?page=SendSmsBulk&username=sms@bcciregistration.com&password=bccireg&number=").append(contactNumber).append("&message=").append(message).append("&scheduledate=01/01/09").toString();
                System.out.println((new StringBuilder("url :")).append(url).toString());
            }
        }
        catch(Exception e)
        {
            System.out.println((new StringBuilder("SmsSender.buildUrl()")).append(e.toString()).toString());
            e.printStackTrace();
            log.writeErrLog((new StringBuilder("[SmsSender]:[buildUrl()]")).append(e.toString()).toString());
        }
        return url;
    }

	private static URL getResource(String string) {
		// TODO Auto-generated method stub
		return null;
	}
}
