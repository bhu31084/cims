<%@ page language="java" contentType="application/pdf"
	import="java.io.*,com.lowagie.text.pdf.*,com.lowagie.text.*,sun.jdbc.rowset.CachedRowSet,in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,java.util.*,java.util.*,in.co.paramatrix.csms.logwriter.LogWriter,in.co.paramatrix.common.*"%>
<%
	OutputStream os = response.getOutputStream();
	response.setHeader ("Content-Disposition", "attachment;	filename=umpiringDecisionLog.pdf");
	Document document = new Document(PageSize.A4, 50, 50, 50, 50);
	PdfWriter.getInstance(document, os);

	java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String strMatch_id =(String)session.getAttribute("matchid");
	String loginUserName = null;
	loginUserName = session.getAttribute("usernamesurname").toString();
	CachedRowSet lobjCachedRowSet =	null;
	CachedRowSet lobjCachedRowSetumpirecoach = null;
	CachedRowSet lobjCachedRowSetupdate = null;
	CachedRowSet lobjCachedRowSetappeal	= null;
	CachedRowSet lobjCachedRowSetinsert = null;
	CachedRowSet lobjCachedRowSetumpire = null;
	CachedRowSet lobjCachedRowSetdisplay = null;
	CachedRowSet lobjCachedRowSetdelete = null;
	CachedRowSet crsObjRefereeDetail = null;
	LogWriter log = new LogWriter();
	
	
    //String strMatch_id="117";
    //String umpire_id="34285";
    String umpire_id =(String)session.getAttribute("userid");
	String umpireid= null;
    String umpire_mapid="0";
	int                         editcount                     =0;
	int                         count                           =0;
	
	GenerateStoreProcedure  	lobjGenerateProc 			=	new GenerateStoreProcedure();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	Vector 						vparam 						=  	new Vector();
	String                      username               		 =  null;
	String                      match                   	 = 	null;
	String                      day                     	 =	null;
	String                      gsaction                     =  null;	
	String                      giumpireid                   =  null  ;             
	String                      giappealid                    =null  ;
	String                      gibatsman                     =null;
    String                      giresult                       =null ;          
	String                      gsball                       =  null;
	String                      gibowler                       = null;
	String                      gireasonid                     =  null;
	String                      inningid                       =null;
	String                      inningcount                       =null;
	String                      gdesc                       =null;
	String                      gremark                       =null;
	String                      matchtype                       =null;
	String						teamnames					=null;
	
	gsaction = request.getParameter("Hidden");
	
	//for match details in top table
	
	try{
		vparam.add(strMatch_id); // Match_id
		try{
			lobjCachedRowSet = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_mobileinning",vparam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		}
		vparam.removeAllElements();
		vparam.add("2");//role 2 for umpires
		vparam.add(strMatch_id); // Match_id
	
		try{
			lobjCachedRowSetumpire = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchumpire",vparam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		}
		
		vparam.removeAllElements();
		try{
	 		vparam.add(strMatch_id);
	 		crsObjRefereeDetail = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_referee_feedbackdtls",vparam,"ScoreDB");
	 		vparam.removeAllElements();
	
		}catch(Exception e){
	  		e.printStackTrace();
		}
	
		vparam.removeAllElements();
		vparam.add("6");
		vparam.add(strMatch_id); // Match_id
		try{		
			lobjCachedRowSetumpirecoach = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_matchumpire",vparam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		}	

		while(lobjCachedRowSetumpirecoach.next()){
			umpireid=lobjCachedRowSetumpirecoach.getString("id");
			if(umpireid.equals(umpire_id)){
				umpire_mapid=lobjCachedRowSetumpirecoach.getString("mapid");
			}else{
				if(umpire_id.equals("34290")){
					umpire_mapid=lobjCachedRowSetumpirecoach.getString("mapid");//admin
				}
			}
	
		}
		vparam.removeAllElements();
		vparam.add("0");
	
		try{
			lobjCachedRowSetappeal = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_appealsearch",vparam,"ScoreDB");
		}catch (Exception e) {
			System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
			log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		}	
		vparam.removeAllElements();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	try {
        if( gsaction != null ){
	    	if( gsaction.equals("1") ){
	            giumpireid        = request.getParameter("combUsername"); 
				inningid          = request.getParameter("dpInning");    
				giappealid        = request.getParameter("dpAppeal");
				gireasonid        = request.getParameter("dpReason");
			    gibowler       = request.getParameter("dpBowler");
				giresult           = request.getParameter("dpResult");
				gsball              =request.getParameter("dbover");				
				gibatsman       = request.getParameter("dpBatsmen");
				gdesc       = request.getParameter("dpDesc"); 
				gdesc       = request.getParameter("dpDesc"); 
				gremark       = request.getParameter("txtremark");  
  

				vparam.add(giumpireid);
				vparam.add(umpire_mapid);
				vparam.add(giappealid);
				vparam.add(gireasonid);
				vparam.add(giresult);
				vparam.add(gdesc);
				vparam.add(gsball);
				vparam.add(gibatsman);				
				vparam.add(gibowler);
			    vparam.add(inningid);
			    vparam.add(gremark);
                vparam.add("A");
	 
				try{	
					lobjCachedRowSetinsert =lobjGenerateProc.GenerateStoreProcedure("esp_amd_umpiredecisionmap",vparam,"ScoreDB");
				}catch (Exception e) {
					System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
					log.writeErrLog(page.getClass(),strMatch_id,e.toString());
				}	
                vparam.removeAllElements();
                vparam.add(giumpireid);
				vparam.add(umpire_mapid);
				vparam.add(giappealid);
				vparam.add(gireasonid);
				vparam.add(giresult);
				vparam.add(gdesc);
				vparam.add(gsball);
				vparam.add(gibatsman);				
				vparam.add(gibowler);
			    vparam.add(inningid);			    
			    vparam.add(gremark);               
                vparam.add("S");

               
           		try{     
                	lobjCachedRowSetdisplay=lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
           		}catch (Exception e) {
					System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
					log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		   		}     
                vparam.removeAllElements();
               
			}
			if(gsaction.equals("4")){
	            giumpireid        = request.getParameter("combUsername"); 
				inningid          = request.getParameter("dpInning");    
				giappealid        = request.getParameter("dpAppeal");
				gireasonid        = request.getParameter("dpReason");
			    gibowler       = request.getParameter("dpBowler");
				giresult           = request.getParameter("dpResult");
				gsball              =request.getParameter("dbover");				
				gibatsman       = request.getParameter("dpBatsmen");
				gremark       = request.getParameter("txtremark"); 
				  
  

				vparam.add(giumpireid);
				vparam.add(umpire_mapid);
				vparam.add(giappealid);
				vparam.add(gireasonid);
				vparam.add(giresult);
				vparam.add(gdesc);
				vparam.add(gsball);
				vparam.add(gibatsman);				
				vparam.add(gibowler);
			    vparam.add(inningid);			    
			    vparam.add(gremark);
			    vparam.add("S");  
			   
				try{	              
               		lobjCachedRowSetdisplay=lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
        		}catch (Exception e) {
					System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
					log.writeErrLog(page.getClass(),strMatch_id,e.toString());
				}   
                vparam.removeAllElements();
			}
			if( gsaction.equals("5") ){
	            String editno=request.getParameter("Hiddencount");
				vparam.add(request.getParameter("ump"+editno));
				vparam.add(umpire_mapid);
				vparam.add(request.getParameter("app"+editno));
				vparam.add(request.getParameter("reas"+editno));
				vparam.add(request.getParameter("res"+editno));
				vparam.add(request.getParameter("des"+editno));
				vparam.add(request.getParameter("o"+editno));
				vparam.add(request.getParameter("bat"+editno));				
				vparam.add(request.getParameter("bow"+editno));
			    vparam.add(request.getParameter("i"+editno));			    
			    vparam.add(request.getParameter("rem"+editno));
			    vparam.add("E");
	           
				try{
			   		lobjCachedRowSetupdate =lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
				}catch (Exception e) {
					System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
					log.writeErrLog(page.getClass(),strMatch_id,e.toString());
				}   
                vparam.removeAllElements();              
               
                inningid          = request.getParameter("dpInning");  
	            giumpireid   = request.getParameter("combUsername"); 
				giappealid    = request.getParameter("dpAppeal");
				gireasonid     = request.getParameter("dpReason");
			    gibowler       = request.getParameter("dpBowler");
				giresult        = request.getParameter("dpResult");
				gsball           =request.getParameter("dbover");				
				gibatsman       = request.getParameter("dpBatsmen");
				gdesc       = request.getParameter("dpDesc"); 
				gremark       = request.getParameter("txtremark"); 
  

				vparam.add(giumpireid);
				vparam.add(umpire_mapid);
				vparam.add(giappealid);
				vparam.add(gireasonid);
				vparam.add(giresult);
				vparam.add(gdesc);
				vparam.add(gsball);
				vparam.add(gibatsman);				
				vparam.add(gibowler);
			    vparam.add(inningid);			    
			    vparam.add(gremark);
			    vparam.add("A");
	           
				try{		
			  		lobjCachedRowSetinsert =lobjGenerateProc.GenerateStoreProcedure("esp_amd_umpiredecisionmap",vparam,"ScoreDB");
				}catch (Exception e) {
					System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
					log.writeErrLog(page.getClass(),strMatch_id,e.toString());
				}	  
                vparam.removeAllElements();
               
                vparam.add(giumpireid);
				vparam.add(umpire_mapid);
				vparam.add(giappealid);
				vparam.add(gireasonid);
				vparam.add(giresult);
				vparam.add(gdesc);
				vparam.add(gsball);
				vparam.add(gibatsman);				
				vparam.add(gibowler);
			    vparam.add(inningid); 
			     vparam.add(gremark);  
	            vparam.add("S");
               
           		try{      
               		lobjCachedRowSetdisplay=lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
           		}catch (Exception e) {
					System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
					log.writeErrLog(page.getClass(),strMatch_id,e.toString());
		   		}     
                vparam.removeAllElements();
			}
			if( gsaction.equals("2") ){
				String deleteno=request.getParameter("Hiddencount");
				vparam.add(request.getParameter("ump"+deleteno));
				vparam.add(umpire_mapid);
				vparam.add(request.getParameter("app"+deleteno));
				vparam.add(request.getParameter("reas"+deleteno));
				vparam.add(request.getParameter("res"+deleteno));
				vparam.add(request.getParameter("des"+deleteno));
				vparam.add(request.getParameter("o"+deleteno));
				vparam.add(request.getParameter("bat"+deleteno));				
				vparam.add(request.getParameter("bow"+deleteno));
			    vparam.add(request.getParameter("i"+deleteno));
			    vparam.add(request.getParameter("rem"+deleteno));
			    vparam.add("D");
	         
				try{	
					lobjCachedRowSetdelete =lobjGenerateProc.GenerateStoreProcedure("esp_amd_umpiredecisionmap",vparam,"ScoreDB");
				}catch (Exception e) {
					System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
					log.writeErrLog(page.getClass(),strMatch_id,e.toString());
				}	
                vparam.removeAllElements();       
				vparam.add(request.getParameter("ump"+deleteno));
				vparam.add(umpire_mapid);
				vparam.add(request.getParameter("app"+deleteno));
				vparam.add(request.getParameter("reas"+deleteno));
				vparam.add(request.getParameter("res"+deleteno));
				vparam.add(request.getParameter("des"+deleteno));
				vparam.add(request.getParameter("o"+deleteno));
				vparam.add(request.getParameter("bat"+deleteno));				
				vparam.add(request.getParameter("bow"+deleteno));
			    vparam.add(request.getParameter("i"+deleteno));  
			    vparam.add(request.getParameter("rem"+deleteno));     
             	vparam.add("S");
               
             	try{    
               		lobjCachedRowSetdisplay=lobjGenerateProc.GenerateStoreProcedure("esp_dsp_umpiredecisionmap",vparam,"ScoreDB");
             	}catch (Exception e) {
					System.out.println("*************umpiringDecisionLog.jsp*****************"+e);
					log.writeErrLog(page.getClass(),strMatch_id,e.toString());
			 	}  
                vparam.removeAllElements();
			}
		}//end if 
	}catch (Exception e) {
		e.printStackTrace();
	}
	try{
	document.open();
	document.add(new Paragraph("Umpiring Decision Log", new Font(Font.HELVETICA, 16)));
	document.add(new Paragraph(" "));
	document.add(new Paragraph("Match No : " + strMatch_id));
	document.add(new Paragraph("Match Between : " + crsObjRefereeDetail.getString("team1") + " Vs. " + crsObjRefereeDetail.getString("team2")));
	document.add(new Paragraph("Name of the Zone : " + crsObjRefereeDetail.getString("zone")));
	document.add(new Paragraph("Venue : " + crsObjRefereeDetail.getString("venue")));
	String d1 = null;
	java.util.Date date = ddmmyyyy.parse(crsObjRefereeDetail.getString("date"));
	d1 = sdf.format(date);
	document.add(new Paragraph("Date : " + d1));
	document.add(new Paragraph("Name Of Tournament : " + crsObjRefereeDetail.getString("tournament")));
	document.add(new Paragraph(" "));
	PdfPTable datatable = null;
	if(lobjCachedRowSetumpire!=null) {
	    while(lobjCachedRowSetumpire.next()) { 
	     	matchtype=lobjCachedRowSetumpire.getString("name");
	     	document.add(new Paragraph("Umpire Name : " + lobjCachedRowSetumpire.getString("nickname")));
	     	document.add(new Paragraph("Match Type : " + matchtype == null? "" : matchtype));
	     	datatable = new PdfPTable(9);
			int headerwidths1[] = { 2, 2, 2, 2, 2, 2, 2, 2, 2 };
			datatable.setWidths(headerwidths1);
			datatable.setWidthPercentage(100);
			datatable.getDefaultCell().setPadding(2);
			datatable.addCell(this.getLeftAllignedCell("Inning Number"));
			datatable.addCell(this.getLeftAllignedCell("0ver"));
			datatable.addCell(this.getLeftAllignedCell("Batsmen"));
			datatable.addCell(this.getLeftAllignedCell("Bowler"));
			datatable.addCell(this.getLeftAllignedCell("Appeal"));
			datatable.addCell(this.getLeftAllignedCell("Result"));
			datatable.addCell(this.getLeftAllignedCell("Decision"));
			datatable.addCell(this.getLeftAllignedCell("Reason"));
			datatable.addCell(this.getLeftAllignedCell("Remark"));
		     	
		}
     }
	 document.add(datatable);
	} catch (Exception e) {
		System.out.println(e);
		e.printStackTrace();
	} finally {
		document.close();
		os.flush();

	}
%>
<%!private PdfPCell getBoldRightAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLD)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getBoldLeftAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getLeftAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getLeftAllignedCell(String name, int colspan) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setColspan(colspan);
		cell.setBorder(0);
		cell.setBorderWidth(0);
		return cell;
	}

	private PdfPCell getBoldCenterAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD)));
		cell.setBorder(2);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}

	private PdfPCell getRightAllignedCellWoBorder(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorder(0);

		return cell;
	}

	private PdfPCell getLeftAllignedCellWoBorder(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorder(0);

		return cell;
	}

	private PdfPCell getRightAllignedCell(String name) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);

		return cell;
	}

	private PdfPCell getRightAllignedCell(String name, int size) {
		PdfPCell cell = new PdfPCell(new Phrase(name, FontFactory.getFont(FontFactory.HELVETICA, size, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		return cell;
	}%>
	
