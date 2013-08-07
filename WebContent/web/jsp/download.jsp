<%-- 
    Document   : download
    Created on : Jan 2, 2009, 6:25:10 PM
    Author     : bhushanf
--%>


<%@ page import="java.io.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    
    
    String pdfPath = null;
    pdfPath = (String)getServletContext().getRealPath("");
    String filePath = pdfPath+"/pdf/"+request.getParameter("filePath");
    System.out.println(filePath);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%
try{
	//read the file name.
       
	
	File f = new File (filePath);
	//set the content type(can be excel/word/powerpoint etc..)
	response.setContentType ("application/pdf");
	response.setHeader ("Content-Disposition", "attachment;	filename="+request.getParameter("filePath")+"");     
	//response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSReportsUserManualforAllUsers.pdf\"");    
            //get the file name
	String name = f.getName().substring(f.getName().lastIndexOf("/") + 1,f.getName().length());
	//OPen an input stream to the file and post the file contents thru the 
	//servlet output stream to the client m/c
	
		InputStream in = new FileInputStream(f);
		ServletOutputStream outs = response.getOutputStream();
		
		
		int bit = 256;
		int i = 0;


    		try {


        			while ((bit) >= 0) {
        				bit = in.read();
        				outs.write(bit);
        			}
        			//System.out.println("" +bit);


            		} catch (IOException ioe) {
            			//ioe.printStackTrace(System.out);
            		}
            //		System.out.println( "\n" + i + " byt
            //     es sent.");
            //		System.out.println( "\n" + f.length(
            //     ) + " bytes sent.");
            		outs.flush();
            		outs.close();
            		in.close();	
     }catch(Exception e){
     }       		
%>
			    
    </body>
</html>
