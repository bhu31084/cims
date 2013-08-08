
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="in.co.paramatrix.common.authz.AuthZ"%>
<%@ page import="in.co.paramatrix.common.Config"%>
<%@ page import="in.co.paramatrix.common.Logger"%>
<%@ page import="in.co.paramatrix.common.exceptions.InvalidData"%>
<%@ page import="java.io.*"%>
<%@ page import="in.co.paramatrix.common.authz.*"%>
<jsp:include page="Menu.jsp"></jsp:include>
<%
	AuthZ authz = AuthZ.getInstance();
	authz.destroy();
	long time1 = System.currentTimeMillis();
    init();
	long time2 = System.currentTimeMillis();

	log.debug("AuthZ Instance 'DESTROYED' at "+ new Date(time1));
	log.debug("New Instance of Authz is 'CREATED' at "+ new Date(time2));
	log.debug("Time required to restart is " + (time2 - time1));
%>
<div style="width:100%;text-align: center;padding:20px 0 0 0;clear:both;">
	<p align="">
		<font color="#524D9C" size="4">
			AuthZ Instance <B>'DESTROYED'</B> at <B><%= new Date(time1)%></B>.<br>
			New Instance of Authz is <B>'CREATED'</B> at <B><%= new Date(time2)%></B>.<br>
			Time required to <B>restart</B> is <B><%=time2 - time1%></B>.<BR>
		</font>
	</p>
</div>
<%!
	AuthZ auth;
	Logger log;
	
	final private String filePath = getFilePath();
	final private String logFile = "LogConfig.properties";
	final private String authZFile = "AuthZConfig.properties";

	public void init() {
		
		Config config = new Config(readConfig(filePath + authZFile));

		Properties prop = new Properties();
		try {
			prop.load(new FileInputStream(filePath + logFile));
		} catch (FileNotFoundException e) {
			System.err.println(e);
		} catch (IOException e) {
			System.err.println(e);
		}


		/** Logger initializes. */
		try {
			Logger.init("", prop);
		} catch (InvalidData e) {
			System.err.println(e.toString());
		}
	
		try{
			log = Logger.getInstance();
		}catch(Exception e){
		
		}		
		/** AuthZ initializes. */
		try {
			AuthZ.init(config);
		} catch (InvalidData e) {
			System.err.println("AuthZInit Constructor : " + e);
		}
	}

	private String getFilePath() {
		String configFile = AuthZInit.class.getResource("AuthZInit.class").getPath();
		int length = configFile.indexOf("/WEB-INF/");
		configFile = "/" + configFile.substring(1, length + 8) + "/";
		configFile = configFile.replaceAll("%20", " ");
		return configFile;
	}

	
	private Vector<String> readConfig(String strFile) {
		FileReader fileReader = null;
		try {
			fileReader = new FileReader(strFile);
		} catch (FileNotFoundException e) {
			//log.error(e.getMessage());
		}
		BufferedReader br = new BufferedReader(fileReader);
		String singleLine = "";
		Vector<String> lvAllLine = new Vector<String>();
		try {
			while ((singleLine = br.readLine()) != null) {
				lvAllLine.addElement(singleLine);
			}
		} catch (IOException e) {
			// log.error(e.getMessage());
		}
		return lvAllLine;
	}
%>
<div style="height : 200px;clear:both;;"></div>
<jsp:include page="Footer.jsp"></jsp:include>	
