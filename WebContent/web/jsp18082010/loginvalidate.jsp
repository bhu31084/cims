<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*"%>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
System.out.println("basePath  ******* "+basePath);
if(!request.getContextPath().equalsIgnoreCase("/cims"))
{
	response.sendRedirect(basePath+"/cims");
}
%>
<%
	String oldPass = request.getParameter("oldPass")==null?"":request.getParameter("oldPass");
	String userId = request.getParameter("userId")==null?"":request.getParameter("userId");
	String newPass = request.getParameter("newpass")==null?"":request.getParameter("newpass");
	Vector vparam =  new Vector();
	GenerateStoreProcedure  lobjGenerateProc = new GenerateStoreProcedure();	
	CachedRowSet  			lobjCachedRowSet		=	null;
	String					userName				= 	"";
	String					userPassword			= 	"";
	String message = "";
	String path ="";
	String user_id ="";
	String user_name ="";
	String user_password="";
	String user_namesurname="";
	String user_role_id = "";
	try{
		if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equalsIgnoreCase("submit"))
	{
		userName 		= 	request.getParameter("txtUserName");
		userPassword 	= 	request.getParameter("password");
		if(userName.equals("report") || userName.equals("association")){
                    path 	=  "/cims/jsp/SelectMatch.jsp";
                }else{
                    path 	=	request.getParameter("cmbLoginType");
		}
		vparam.add(userName); 
		vparam.add(userPassword); 
		lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("slogin",vparam,"ScoreDB");
		vparam.removeAllElements();
		
		if(lobjCachedRowSet!= null){		
			if(lobjCachedRowSet.next()){
				 user_id   =	lobjCachedRowSet.getString("id");
				 user_name =	lobjCachedRowSet.getString("fname");
				 user_password =	lobjCachedRowSet.getString("password");	
				 user_namesurname=	lobjCachedRowSet.getString("usernamesurname");	
				 user_role_id=	lobjCachedRowSet.getString("user_role_id");
				 
				 session.setAttribute("userid", user_id); //session.getAttribute("userid")
	             session.setAttribute("userId", user_id); //session.getAttribute("userid")
	             session.setAttribute("username", user_name);
				 session.setAttribute("usernamesurname", user_namesurname);	
				 /*Added by archana to get the user_role_id of user on 23/04/09*/
				  	session.setAttribute("user_role_id", user_role_id);				  	
				  /*End Archana*/				  
					  		
				if(user_password.equalsIgnoreCase("pass")){
				System.out.println("userId is "+user_password);%>
					<form name="frmChangePass"  method="post">
				      	<input type="hidden" name="hduserName" id="hduserName" value="<%=userName%>">
				      	<input type="hidden" name="hdOldPass" id="hdOldPass" value="<%=userPassword%>">
				      	<input type="hidden" name="hdChangePassword" id="hdChangePassword" value="true">
			        </form>
				<%}else{					
					response.sendRedirect(path);
                    return;
				}      
		    }else{
		    	message = "Username / password not valid.";
		    	System.out.println("message  "+message);
		    }
		}
	}
	}catch(Exception e){
		System.out.println("*************Login.jsp*****************"+e);
		e.getMessage();
		e.printStackTrace();
	}			
%>