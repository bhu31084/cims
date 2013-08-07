<%-- 
    Document   : PdfReport
    Created on : Jan 2, 2009, 6:25:10 PM
    Author     : bhushanf
--%>


<%@ page import="java.io.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String ReportId = request.getParameter("ReportId");
    String filePath = null;
    String pdfPath = null;
    pdfPath = (String)getServletContext().getRealPath("");
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
        if(ReportId.equalsIgnoreCase("CALLRUM01")){
            //filePath = "D:/workspace/cims/web/helpdoc/CIMSReportsUserManual .pdf";
           filePath =pdfPath+"/helpdoc/CIMSReportsUserManualforAllUsers.pdf";
        }else if(ReportId.equalsIgnoreCase("AUM01")){
             filePath = pdfPath+"/helpdoc/CIMSAdminUserManual.pdf";
        }else if(ReportId.equalsIgnoreCase("CSUM01")){ 
                filePath = pdfPath+"/helpdoc/CIMSScoringUserManual.pdf";
        } else if(ReportId.equalsIgnoreCase("CFRUM01")){
                filePath = pdfPath+"/helpdoc/CIMSFeedbackReportsUserManual.pdf";
        }else if(ReportId.equalsIgnoreCase("CCAPRUM01")){ 
                filePath = pdfPath+"/helpdoc/CIMSCaptainsReportsUserManual.pdf";
        } else if(ReportId.equalsIgnoreCase("CREFRUM01")){ 
                filePath = pdfPath+"/helpdoc/CIMSRefereeFeedbackUserManual.pdf";
        }else if(ReportId.equalsIgnoreCase("CUCRUM01")){ 
                filePath = pdfPath+"/helpdoc/CIMSUmpireCoachUserManual.pdf";
        }else if(ReportId.equalsIgnoreCase("CURUM01")){ 
                filePath = pdfPath+"/helpdoc/CIMSUmpireUserManual.pdf";
        }else if(ReportId.equalsIgnoreCase("Log01")){ 
                filePath = pdfPath+"/helpdoc/CIMSLoginFlow.pdf";
        }else if(ReportId.equalsIgnoreCase("CMOBUM01")){ 
                filePath = pdfPath+"/helpdoc/CIMSMobilePagesUserManual.pdf";
        }       
	
	File f = new File (filePath);
	//set the content type(can be excel/word/powerpoint etc..)
	response.setContentType ("application/pdf");
	//set the header and also the Name by which user will be prompted to save
       if(ReportId.equalsIgnoreCase("CALLRUM01")){ 
            response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSReportsUserManualforAllUsers.pdf\"");
    	}else if(ReportId.equalsIgnoreCase("AUM01")){
                response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSAdminUserManual.pdf\"");
        } else if(ReportId.equalsIgnoreCase("CSUM01")){
                response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSScoringUserManual.pdf\"");
        } else if(ReportId.equalsIgnoreCase("CFRUM01")){
                response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSFeedbackReportsUserManual.pdf\"");
        }else if(ReportId.equalsIgnoreCase("CCAPRUM01")){
                response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSCaptainsReportsUserManual.pdf\"");
        } else if(ReportId.equalsIgnoreCase("CREFRUM01")){
                response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSRefereeFeedbackUserManual.pdf\"");
        }else if(ReportId.equalsIgnoreCase("CUCRUM01")){
                response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSUmpireCoachUserManual.pdf\"");
        } else if(ReportId.equalsIgnoreCase("CURUM01")){
                response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSUmpireUserManual.pdf\"");
        }else if(ReportId.equalsIgnoreCase("Log01")){
                response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSLoginFlow.pdf\"");
        }else if(ReportId.equalsIgnoreCase("CMOBUM01")){
                response.setHeader ("Content-Disposition", "attachment;	filename=\"CIMSMobilePagesUserManual.pdf\"");
        }     
        
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
