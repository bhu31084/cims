<%--
  User: Gaurav Yadav
  Date: Sept 12, 2008
  Time: 12:40:56 PM
  modifyed Date:12-09-2008
  
  Modifications :
  1.By 		: Saudagar Mulik
  	Date 	: 14 Nov, 2008
  	Desc. 	: Modified code to view in other browsers.
--%>

<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
<%@ page import="java.util.*"%>

<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";

if(!request.getContextPath().equalsIgnoreCase("/cims"))
{
	response.sendRedirect(basePath+"/cims");
}
%>

<%
	
	String oldPass = request.getParameter("oldPass")==null?"":request.getParameter("oldPass");
	String userId = request.getParameter("userId")==null?"":request.getParameter("userId");
	String newPass = request.getParameter("newpass")==null?"":request.getParameter("newpass");	
	
	GenerateStoreProcedure  lobjGenerateProc 		=	new GenerateStoreProcedure();
	Vector 					vparam 					=  	new Vector();
	CachedRowSet  			lobjCachedRowSet		=	null;
	String					userName				= 	"";
	String					userPassword			= 	"";
	String user_id ="";
	String message = "";
	String user_name ="";
	String user_password="";
	String user_namesurname="";
	String user_role_id = "";
        String path ="";
	if(request.getParameter("message")!= null ){
		message = request.getParameter("message");
	}
	
	if(request.getParameter("hdSubmit")!=null && request.getParameter("hdSubmit").equals("submit"))
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
		    }
		}
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cricket Score Management Application Login</title>
   
        
</head>

<body topmargin="0"  onLoad="gaia_setFocus();">
<SCRIPT>

	function catchEnter(e) {
			if (!e) var e = window.event;
			if (e.keyCode) code = e.keyCode;
			else if (e.which) code = e.which;
			
			if (code==13) {
				callSubmit();
			}
	}
	function gaia_setFocus() {
	  var f = null;
	  var chgpass = null;
	  
	  if (document.getElementById) { 
	    f = document.getElementById("frmScorer");
	    chgpass = document.getElementById("hdChangePassword");
	  } else if (window.frmScorer) {
	    f = window.frmScorer;
	  } 
	  
	  if(!chgpass){
		  if (f) {
		    if (f.txtUserName && (f.txtUserName.value == null || f.txtUserName.value == "")) {
		      f.txtUserName.focus();
		    } else if (f.password) {
		      f.password.focus();
		    } else if (f.imgSubmit) {
		      f.imgSubmit.focus();
		    } 
		  }
	  }
	}  
        function callHelp(){
           // window.open("../helpdoc/LoginFlow.pdf","HELP","location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=0,left=50,width="+(window.screen.availWidth-100)+",height="+(window.screen.availHeight-120));
            document.getElementById("frmScorer").action="/cims/jsp/PdfReport.jsp?ReportId=Log01";
           document.getElementById("frmScorer").submit();
        }
	function forgotChk(){
	    if (frmScorer.txtUserName.value == ""){
	            alert ("Enter User Name!");
	            frmScorer.txtUserName.focus();
	            return false;
	    }
	    var userid = document.getElementById('txtUserName').value;
	    document.frmScorer.action ="/cims/jsp/Mail.jsp?userid="+userid;
		document.frmScorer.submit();
	}
         function reportlogin(){
             document.getElementById("txtUserName").value = "report";
             document.getElementById("password").value = "pass1";
             document.getElementById("cmbLoginType").options.selectedIndex=1;
             callSubmit();
          }  
	function callSubmit(){
			try{
				document.getElementById('hdSubmit').value = "submit"
				if(document.getElementById('txtUserName').value == ""){
					alert(" User Name can not be left Blank !");
					frmScorer.txtUserName.focus();
				}else if(document.getElementById('password').value == ""){
					alert(" Password can not be left Blank !");
					frmScorer.password.focus();
				}else{
					document.frmScorer.submit();
				}	
		}catch(err){
				alert("callSubmit"+err.description); 
		}
}
</SCRIPT>

<form  method="post" name="frmScorer" id="frmScorer" onkeypress="catchEnter(event)">

<table width="535" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
    <td width="535" height="111"><img src="/cims/images/Top1.jpg" width="535" height="111" /></td>
</tr>
<tr>
    <td width="535" height="130"><img src="/cims/images/Top2.jpg" width="535" height="130" /></td>
</tr>
<tr>
    <td width="535" height="109"><img src="/cims/images/Top3New.jpg" width="535" height="109" /></td>
</tr>
<tr>
    <td>
    <table width="535" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="206" height="115"><img src="/cims/images/LoginLeft.jpg" width="206" height="115" /></td>
        <td valign="top" width="217">
        <table width="184" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="236" height="5"><img src="/cims/images/LoginTop.jpg" width="236" height="1" /></td>
            </tr>
            <tr>
              <td valign="top"><table width="236" border="0" cellspacing="0" cellpadding="2">
                <tr>
                  <td width="60" height="24"><img src="/cims/images/Username.jpg" width="60" height="24" /></td>
                  <td width="181">
			<input type="text"  class="textBox" name="txtUserName" id="txtUserName" value="<%=userName%>" style="border: 1px solid #000000;width:100px" />
                  </td>
                </tr>
                <tr>
                  <td><img src="/cims/images/Password.jpg" width="60" height="25" /></td>
                  <td>
							<input type="password" name="password"  class="textBox" id="password" value="" style="border: 1px solid #000000;width:100px"/>
                  </td>
                </tr>
                <tr>
                  <td><img src="/cims/images/Type.jpg" width="60" height="25" /></td>
                  <td>
					<select name="cmbLoginType" id="cmbLoginType" class="inputField" style="border: #000000 1px" width="100px">
						<option  value="/cims/jsp/TeamSelection.jsp" selected>Scorer Login</option>
						<option  value="/cims/jsp/SelectMatch.jsp">Report Login</option>						
						<option  value="/cims/jsp/admin/Menu.jsp">Admin Login</option>
						<option  value="/cims/jsp/Press.jsp">Media Login</option>
					</select>	
                  </td>
                </tr>
                <tr>
                  <td width="64" height="19"><img src="/cims/images/Report.jpg" width="64" height="20" id="imgReport" name="imgReport" onmouseover="document.body.style.cursor = 'pointer'" onmouseout="document.body.style.cursor = 'default'" onclick="reportlogin()"/></td>
                  <td width="64" height="19" ><img src="/cims/images/Submit.jpg" width="64" height="19" id="imgSubmit" name="imgSubmit" onclick="callSubmit()"/></td>
                </tr>
               
              </table></td>
            </tr>
          </table></td>
        <td width="93" height="115"><img src="/cims/images/LoginRight.jpg" width="93" height="115" /></td>
    </tr>
    </table>
    </td>
</tr>
<tr>
    <td width="535" height="82"><img src="/cims/images/Top4.jpg" width="535" height="115" /></td>
     <input type="hidden" name="hdSubmit" id="hdSubmit" value="">
</tr>
<tr>
  <td height="83"><a href="http://www.paramatrix.co.in" style="text-decoration: none;"><img src="/cims/images/Top5LOGO.jpg" width="535" height="119" border="0"/></a></td>
</tr>

</table>

<div id="message" style="position:absolute; left: 43%; top: 460px;  width: 250px; cursor: default">
<table align="center" border="0" width="100%">
<TR>
<td align="center"><FONT color="red"><B><%=message%></B></font></td>
</TR>
</table>
</div>
<div id="forgotPass" style="position:absolute; left: 50%; top: 485px; width: 115px" onclick="return forgotChk()" onmouseover="document.body.style.cursor = 'pointer'" onmouseout="document.body.style.cursor = 'default'">
<table align="center" border="0" width="100%" height="18px"  bgcolor="white">
<TR>
<td align="center"><FONT size="2" color="#3366FF">*Forgot password</FONT></td>
</TR>
</table>
</div>


<%if(user_password.equalsIgnoreCase("pass")){
%>
<script>
	var userName = document.getElementById('hduserName').value;
	var prePass = document.getElementById('hdOldPass').value;
	openerobj = window.open("/cims/jsp/ChangePassword.jsp?userName="+userName+"&prePass="+prePass,"CIMS2","location=Yes,directories=no,status=no,menubar=no,scrollbars=Yes,resizable=yes,top=300,left=300,width=400,height=200");
	openerobj.focus();
</script>				
<% }		
%>

<table align="center">
	 <tr>
              <td align="center">
		<a href="javascript:callHelp()" style="color: #000000; height:100%; text-align:center;font-size:9pt;font-family:Arial; vertical-align:top" ><h4><center><u>Help Document</u></center></h4></a>
                </td>
         </tr>
         <tr>
		<td>
			Recommended : Use IE 6.0 or higher and set resolution to 1024*768.
		</td>
	</tr>
</table>

</form>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-12092747-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</body>
