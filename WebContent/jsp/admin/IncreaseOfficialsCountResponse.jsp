<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="in.co.paramatrix.csms.common.EMailSender"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="in.co.paramatrix.csms.common.ReadOfficialCount"%>

<%	
	String usertype = request.getParameter("usertype")==null?"":request.getParameter("usertype");
	ReadOfficialCount setCount = new ReadOfficialCount();
	String incrementcount = "";
	if(usertype.equalsIgnoreCase("ump")){
		incrementcount = setCount.setCounter(usertype);
	}else if(usertype.equalsIgnoreCase("umpch")){
		incrementcount = setCount.setCounter(usertype);
	}else if(usertype.equalsIgnoreCase("ref")){
		incrementcount = setCount.setCounter(usertype);
	}else{
		incrementcount = setCount.setCounter(usertype);
	}
%>
<div id="umpcounter"><%=incrementcount%>
</div>