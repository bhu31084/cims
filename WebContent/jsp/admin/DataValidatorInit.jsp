<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="in.co.paramatrix.common.Config" %>
<%@ page import="in.co.paramatrix.common.exceptions.InvalidEntity"%>
<%@ page import="in.co.paramatrix.common.exceptions.InvalidFormat"%>
<%@ page import="in.co.paramatrix.common.exceptions.NoEntity"%>
<%@ page import="in.co.paramatrix.common.exceptions.RuleViolated"%>
<%@ page import="in.co.paramatrix.common.exceptions.NoEntity"%>
<%@ page import="in.co.paramatrix.common.exceptions.NoEntity"%>
<%@ page import="in.co.paramatrix.csms.logwriter.*"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.net.URL"%>
<%@ page import="in.co.paramatrix.common.validator.DataValidator"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Data Validator Initialization</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
  </head>  
  <body>
  
<%
			URL u = LogWriter.class.getResource("LogWriter.class");		
			String fileStr = u.getPath();
			int length = fileStr.indexOf("/WEB-INF/");
			fileStr = "/" + fileStr.substring(1, length + 8) + "/validator/";
			fileStr = fileStr.replaceAll("%20", " ");			
			
			String fileName = fileStr + "validatorConf.txt";
			
			FileReader fileReader = null;
			try {
				fileReader = new FileReader(fileName);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}

			String singleLine = null;
			Vector lvAllLines = new Vector();
			BufferedReader br = new BufferedReader(fileReader);

			try {
				while ((singleLine = br.readLine()) != null) {
					lvAllLines.addElement(singleLine);
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}

			in.co.paramatrix.common.Config config1 = new in.co.paramatrix.common.Config(lvAllLines);
			
			try {
				in.co.paramatrix.common.validator.DataValidator dv = new in.co.paramatrix.common.validator.DataValidator(config1);
				application.setAttribute("DataValidator", dv);
			} catch (InvalidFormat e) {
				System.err.println(e);
			}

%>
  </body>
</html>