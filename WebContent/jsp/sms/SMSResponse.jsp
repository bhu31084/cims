<!--
	Page Name 	 : SMSResponse2.jsp
	Created By 	 : Dipti Shinde.
	Created Date : 1st  october 2009.
	Description  : To capture response and save date and time in database.
	Company 	 : Paramatrix Tech Pvt Ltd.
-->
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="in.co.paramatrix.csms.sms.SmsSender"%>
<%@ page language="java" import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet,java.io.*,java.lang.*"%>

<%   
	response.setHeader("Pragma", "private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<html>
  <head>
  
  </head>
  <title>SMS Response</title> 
  <body>
    This is SMS Response page <br>
<%
    LogWriter log = new LogWriter();
    try{
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");    	
    	String lsmsisdn 			 = request.getParameter("MSISDN");
    	String lsmessageShortCode	 = request.getParameter("Msg");
    	String lskey1   			 = request.getParameter("Key1");
    	String lskey2    			 = request.getParameter("Key2");
    	String lsmessage  			 = request.getParameter("RestMsg");
    	   	
    	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();
    	CachedRowSet  crsSendMessage = null;
    	Vector vparam =  new Vector();
    	
    	//Message Format : BCCI MTVaeV6:Y
    	
    	int j=0;
		String result[]=new String[5];	
		StringTokenizer messageSt=new StringTokenizer(lsmessage,":");
		
		while(messageSt.hasMoreTokens()){
			String messagePart=messageSt.nextToken();
			result[j]=messagePart;
			j++;
		}	
		String signature = result[0].trim();
		String acceptanceFlag = result[1].trim();
		String state = null;
		
		if(acceptanceFlag.equalsIgnoreCase("Y")){
			state = "A";
		}else if(acceptanceFlag.equalsIgnoreCase("N")){
			state = "R";
		}
		
				
		Date currentDateTime = new Date();
		String	messageflag = "3";
		
		try{
			vparam.add("");//content
			vparam.add("");//type
			vparam.add("");//matchid
			vparam.add("");//receiver
			vparam.add("");//sender
			vparam.add("");//send_ts
			vparam.add(signature);//signature
			vparam.add("");//replyPhone for flag 1
			vparam.add(acceptanceFlag);//reply text
			vparam.add(sdf.format(currentDateTime));//reply_ts
			vparam.add(state);//state
			vparam.add(sdf.format(currentDateTime));//statechange_ts
			vparam.add("2");//flag
			vparam.add("2");//mesg exists flag
			
			crsSendMessage = lobjGenerateProc.GenerateStoreProcedure("esp_amd_send_receive_messages",vparam,"ScoreDB");
	   		vparam.removeAllElements();			
			
		}catch(Exception e){
			e.printStackTrace();
			log.writeErrLog("[SMSResponse.jsp : esp_amd_send_receive_messages]:"+e.toString());
		}
	}catch(Exception e){
			e.printStackTrace();
			log.writeErrLog("[SMSResponse.jsp]:"+e.toString());
	}			
 %>
  </body>
</html>
