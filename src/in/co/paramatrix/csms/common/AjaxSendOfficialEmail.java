package in.co.paramatrix.csms.common;

import in.co.paramatrix.csms.generalamd.GenerateStoreProcedure;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.jdbc.rowset.CachedRowSet;



/**
 * Servlet implementation class AjaxSendEmail
 */
public class AjaxSendOfficialEmail extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		ByteArrayOutputStream outputStream = null;
		ByteArrayOutputStream analysisOutputStream = null;
        
		try {

			EMailSender smail = null;
			CachedRowSet  crsObjRemarkData = null;
			CachedRowSet  crsObjMatchData = null;			
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy/MM/dd");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
					"dd/MM/yyyy");

			ReadOfficialCount setCount = new ReadOfficialCount();
			String gsflag = request.getParameter("gsflag")!=null?request.getParameter("gsflag"):"";
			String usertype = "";
			String reamrk = "";
			usertype = "scorer";
			String scorer1 = setCount.getProxy(usertype);
			if (scorer1.length() == 1) {
				scorer1 = "0" + scorer1;
			}
			String scorer2 = setCount.getProxy(usertype);
			if (scorer2.length() == 1) {
				scorer2 = "0" + scorer2;
			}
			usertype = "analysis";
			String videoanalysis = setCount.getProxy(usertype);
			if(videoanalysis.length() == 1){
				videoanalysis = "0"+videoanalysis;
			}
			String applicationUrl = Common.getUrl();
			String personName = "";
			String officialId= "";
			//System.out.println("Umpire's Counter set to --->"+setCount.setCounter(usertype));	
			String matchId = request.getParameter("matchId");
			String flag = request.getParameter("flag");
			String analysis_id = request.getParameter("analysis_id");
			String analysis = request.getParameter("analysis");
			String analysis1_id = request.getParameter("analysis1_id");
			String analysis1 = request.getParameter("analysis1");
			String scorer1id = request.getParameter("scorer1id");
			String scorer1nm = request.getParameter("scorer1nm");
			String scorer2id = request.getParameter("scorer2id");
			String scorer2nm = request.getParameter("scorer2nm");
			String official = "";
			String subName = "";
			
			String matchdate = request.getParameter("matchdate");
			String team1nck = request.getParameter("team1nickname")==null?"":request.getParameter("team1nickname");
			String team2nck = request.getParameter("team2nickname")==null?"":request.getParameter("team2nickname");	
			String team1id = request.getParameter("team1id")==null?"":request.getParameter("team1id");
			String team2id = request.getParameter("team2id")==null?"":request.getParameter("team2id");
			String clubname = request.getParameter("clubname")==null?"":request.getParameter("clubname");
			String matchtypeflag = 	request.getParameter("matchtypeflag")==null?"":request.getParameter("matchtypeflag");
			String team1 = request.getParameter("team1");
			String team2 = request.getParameter("team2");
			String venue = request.getParameter("venue");
			String email = request.getParameter("email");
			System.out.println("venue" + venue);
			String seriesname =	request.getParameter("seriesname");	
			String matchenddate =	request.getParameter("matchenddate");	
			String matchpredate = request.getParameter("matchpre_date")==null?"":request.getParameter("matchpre_date");
			String mailumpirecoachname = "";
			String mailflag = request.getParameter("mailflag")==null?"":request.getParameter("mailflag");

			String scorer1Association = "";
			String scorer1userEmailAddress = "";
			String scorer1AssociationEmailAddress = "";
			
			
			String scorer2Association = "";
			String scorer2userEmailAddress = "";
			String scorer2AssociationEmailAddress = "";
			
			
			String analysisAssociation = "";
			String analysisEmailAddress = "";
			String analysisAssociationEmailAddress = "";
			
			String analysis1Association = "";
			String analysis1EmailAddress = "";
			String analysis1AssociationEmailAddress = "";
			
			CachedRowSet crsObjEmail = null;
			CachedRowSet crsObjAssociation = null;
			Vector vparam = new Vector();
			GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
			if (matchtypeflag.equals("0")) {
				matchdate = matchdate;
			} else {
				matchdate = matchdate + " To " + matchenddate;
			}
			try {
				vparam.add(scorer1id);// display all series name.
				crsObjAssociation = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_officialassociation", vparam, "ScoreDB");
				vparam.removeAllElements();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (crsObjAssociation != null) {
				while (crsObjAssociation.next()) {
					if (crsObjAssociation.getString("name") == null
							|| crsObjAssociation.getString("name").equals("")) {
						scorer1Association = "Not Specified";
					} else {
						scorer1Association = crsObjAssociation
								.getString("name");
						scorer1AssociationEmailAddress = crsObjAssociation
						.getString("email_address");
						reamrk = crsObjAssociation.getString("remark");
						
					}
				}
			}
			try {
				vparam.removeAllElements();
				vparam.add(scorer1id);// display all series name.
				crsObjEmail = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_get_users_email_address", vparam, "ScoreDB");
				vparam.removeAllElements();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (crsObjEmail != null) {
				while (crsObjEmail.next()) {
					if (crsObjEmail.getString("email") == null
							|| crsObjEmail.getString("email").equals("")) {
						scorer1userEmailAddress = "";
					} else {
						scorer1userEmailAddress = crsObjEmail
								.getString("email");
					}
				}
			}
			
			
			try {
				vparam.add(scorer2id);// display all series name.
				crsObjAssociation = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_officialassociation", vparam, "ScoreDB");
				vparam.removeAllElements();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (crsObjAssociation != null) {
				while (crsObjAssociation.next()) {
					if (crsObjAssociation.getString("name") == null
							|| crsObjAssociation.getString("name").equals("")) {
						scorer2Association = "Not Specified";
					} else {
						scorer2Association = crsObjAssociation
								.getString("name");
						scorer2AssociationEmailAddress = crsObjAssociation
						.getString("email_address");
						reamrk = crsObjAssociation.getString("remark");
					}
				}
			}
			try {
				vparam.removeAllElements();
				vparam.add(scorer2id);// display all series name.
				crsObjEmail = lobjGenerateProc.GenerateStoreProcedure(
						"esp_dsp_get_users_email_address", vparam, "ScoreDB");
				vparam.removeAllElements();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (crsObjEmail != null) {
				while (crsObjEmail.next()) {
					if (crsObjEmail.getString("email") == null
							|| crsObjEmail.getString("email").equals("")) {
						scorer2userEmailAddress = "";
					} else {
						scorer2userEmailAddress = crsObjEmail
								.getString("email");
					}
				}
			}
			
			
			
			try{
				
				vparam.add(analysis_id);//display all series name.
				crsObjAssociation = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialassociation",vparam,"ScoreDB");
				vparam.removeAllElements();
				}catch(Exception e){
					e.printStackTrace();
				}
				if(crsObjAssociation != null){
					while(crsObjAssociation.next()){
						analysisAssociation = crsObjAssociation.getString("name");
						analysisAssociationEmailAddress = crsObjAssociation.getString("email_address");
						reamrk = crsObjAssociation.getString("remark");
					}
				}
				try{
					vparam.add(analysis_id);//display all series name.referee_id
					crsObjEmail =  lobjGenerateProc.GenerateStoreProcedure("esp_dsp_get_users_email_address",vparam,"ScoreDB");
					vparam.removeAllElements();
				}catch(Exception e){
						e.printStackTrace();
				}
				if(crsObjEmail != null){
					while(crsObjEmail.next()){
						if(crsObjEmail.getString("email") == null || crsObjEmail.getString("email").equals("")){
							analysisEmailAddress = "";
					  	}else{
					  		analysisEmailAddress = crsObjEmail.getString("email");
					  		System.out.println(analysisEmailAddress + "analysisEmailAddress");
					  	}					
					}			
				}
				
				try{
					
					vparam.add(analysis1_id);//display all series name.
					crsObjAssociation = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialassociation",vparam,"ScoreDB");
					vparam.removeAllElements();
					}catch(Exception e){
						e.printStackTrace();
					}
					if(crsObjAssociation != null){
						while(crsObjAssociation.next()){
							analysis1Association = crsObjAssociation.getString("name");
							analysis1AssociationEmailAddress = crsObjAssociation.getString("email_address");
							reamrk = crsObjAssociation.getString("remark");
						}
					}
					try{
						vparam.add(analysis1_id);//display all series name.referee_id
						crsObjEmail =  lobjGenerateProc.GenerateStoreProcedure("esp_dsp_get_users_email_address",vparam,"ScoreDB");
						vparam.removeAllElements();
					}catch(Exception e){
							e.printStackTrace();
					}
					if(crsObjEmail != null){
						while(crsObjEmail.next()){
							if(crsObjEmail.getString("email") == null || crsObjEmail.getString("email").equals("")){
								analysis1EmailAddress = "";
						  	}else{
						  		analysis1EmailAddress = crsObjEmail.getString("email");
						  		System.out.println(analysis1EmailAddress + "analysisEmailAddress");
						  	}					
						}			
					}
				
				
				String scorerMsg1 = "";
				String scorerMsg2 ="";
				String scorerMsg3 ="";
				String scorerMsg ="";
				String scorer2Msg2 ="";
				String scorer2Msg ="";
				
				String analysisMsg = "";
				String analysisMsg1 = "";
				String analysisMsg2 = "";
				String analysisMsg3 = "";
				String analysis1Msg2 = "";
				String analysis1Msg = "";
				vparam.add(matchId);//display teams
				crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure(
			       	"esp_dsp_modifymatch",vparam,"ScoreDB");
			    vparam.removeAllElements();
			    String msg = "";
				while(crsObjMatchData.next()){
					email = crsObjMatchData.getString("email");		
					scorerMsg1 ="<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
						"<tr class='refereeContentDark'>"+
						"<td colspan='1'><b>Dear Sir,</b></td>"+
						"<td colspan='4'></td></tr>"+
						
						"<tr class='refereeContentDark'>"+
						"<td colspan='5'>&nbsp;</td></tr>"+
						
						"<tr class='refereeContentLight'>"+
						"<td colspan='3'>Please read the attached appointment and select, one of the below given "+
						"link to confirm your status. </td>"+
						"<td colspan='1'></td></tr>"; 
					
					scorerMsg2 = "<tr class='refereeContentDark'>"
					+ "<td colspan='2'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+scorer1id+"&status=Y'>Accept</a></b>"
					+ "<td colspan='2'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+scorer1id+"&status=N'>Reject</a></b>"
					+ "</tr>";
					
					scorer2Msg2 = "<tr class='refereeContentDark'>"
						+ "<td colspan='2'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+scorer2id+"&status=Y'>Accept</a></b>"
						+ "<td colspan='2'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+scorer2id+"&status=N'>Reject</a></b>"
						+ "</tr>";
					scorerMsg3 = "<tr class='refereeContentDark'>"+
					"<td colspan='4'></td>"+
					"</tr></table>"+
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentLight'><td>Thanking you,</td></tr>"+
					"<tr class='refereeContentDark'><td>Yours Faithfully,</td></tr>"+
					"<tr class='refereeContentDark'><td>&nbsp;</td></tr>"+
					"<tr class='refereeContentLight'><td>Prof. Ratnakar. S. Shetty</td></tr>"+
					"<tr class='refereeContentLight'><td>Chief Administrative Officer, BCCI</td></tr>"+
					"<tr class='refereeContentLight'><td>c.c. Hon Jt Secretary, BCCI</td></tr>"+
					"</table>" +
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentLight'><td>&nbsp;</td></tr>"+
					"<tr class='refereeContentLight'><td>(This is an electronically generated document & does not require a signature)</td></tr>"+
					"</table>";
					
					scorerMsg = scorerMsg1 + scorerMsg2 + scorerMsg3;
					scorer2Msg = scorerMsg1 + scorer2Msg2 + scorerMsg3;
					outputStream = new ByteArrayOutputStream();
					String path = (String)getServletContext().getRealPath("");
					String filePath =path+"/images/BCCI_Logo_.jpg";
					ScorerAttachment.scorerAttachment(filePath,matchId, crsObjMatchData, outputStream, reamrk);
					analysisMsg1 ="<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentDark'>"+
					"<td colspan='1'><b>Dear Sir,</b></td>"+
					"<td colspan='4'></td></tr>"+
					
					"<tr class='refereeContentDark'>"+
					"<td colspan='5'>&nbsp;</td></tr>"+
					
					"<tr class='refereeContentLight'>"+
					"<td colspan='3'>Please read the attached appointment and select, one of the below given "+
					"link to confirm your status. </td>"+
					"<td colspan='1'></td></tr>";
					
					analysisMsg2 = "<tr class='refereeContentDark'>"
					+ "<td colspan='1'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+analysis_id+"&status=Y'>Accept</a></b>"
					+ "<td colspan='3'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+analysis_id+"&status=N'>Reject</a></b>"
					+ "</tr>"; 
					
					analysis1Msg2 = "<tr class='refereeContentDark'>"
						+ "<td colspan='1'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+analysis1_id+"&status=Y'>Accept</a></b>"
						+ "<td colspan='3'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+analysis1_id+"&status=N'>Reject</a></b>"
						+ "</tr>";
					
					analysisMsg3 = "<tr class='refereeContentDark'>"+
					"<td ></td><td colspan='4'>"+
					"</tr></table>"+
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentLight'><td>Thanking you,</td></tr>"+
					"<tr class='refereeContentDark'><td>Yours Faithfully,</td></tr>"+
					"<tr class='refereeContentDark'><td>&nbsp;</td></tr>"+
					"<tr class='refereeContentLight'><td>Prof. Ratnakar. S. Shetty</td></tr>"+
					"<tr class='refereeContentLight'><td>Chief Administrative Officer, BCCI</td></tr>"+
					"</table>" +
					"<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
					"<tr class='refereeContentLight'><td>&nbsp;</td></tr>"+
					"<tr class='refereeContentLight'><td>(This is an electronically generated document & does not require a signature)</td></tr>"+
					"</table>";
	
					analysisMsg = analysisMsg1 + analysisMsg2 + analysisMsg3;
					analysis1Msg = analysisMsg1 + analysis1Msg2 + analysisMsg3;
					analysisOutputStream = new ByteArrayOutputStream();
					VedioAnalysis.vedioAnalysis(filePath,matchId, crsObjMatchData, analysisOutputStream,reamrk);
				}
				
				if(gsflag.equalsIgnoreCase("scorer")){
					String appointmentLetter = "";
					if(reamrk.equalsIgnoreCase("")){
						appointmentLetter = "Appointment Letter";
					}else{
						appointmentLetter = "Revised Appointment Letter (Revised on "+ sdf2.format(new Date()) +" )";
					}
					
					if(scorer1AssociationEmailAddress.equalsIgnoreCase("") || scorer1AssociationEmailAddress==null){
						scorer1AssociationEmailAddress = "cims@bcci.tv";
					}
					if(scorer2AssociationEmailAddress.equalsIgnoreCase("") || scorer2AssociationEmailAddress==null){
						scorer2AssociationEmailAddress = "cims@bcci.tv";
					}
					if(email.equalsIgnoreCase("") || email==null){
						email = "cims@bcci.tv";
					}
					scorer1AssociationEmailAddress = scorer1AssociationEmailAddress +","+email+","+ Common.joinSecetoryEmail();;
					scorer2AssociationEmailAddress = scorer2AssociationEmailAddress +","+email+","+ Common.joinSecetoryEmail();;
					smail.sendMail(scorer1userEmailAddress,scorer1AssociationEmailAddress,scorerMsg,outputStream, appointmentLetter);
					smail.sendMail(scorer2userEmailAddress,scorer2AssociationEmailAddress,scorer2Msg,outputStream, appointmentLetter);
					
					vparam.removeAllElements();
			        vparam.add("2");//display teams
			        vparam.add(matchId);//display teams
			        vparam.add("");//display teams
			        crsObjRemarkData = lobjGenerateProc.GenerateStoreProcedure(
				       	"esp_amd_officialremark",vparam,"ScoreDB");
				    vparam.removeAllElements();
				}else if(gsflag.equalsIgnoreCase("analysis")){
					String appointmentLetter = "";
					if(reamrk.equalsIgnoreCase("")){
						appointmentLetter = "Appointment Letter";
					}else{
						appointmentLetter = "Revised Appointment Letter (Revised on "+ sdf2.format(new Date()) +" )";
					}
					
					if(analysisAssociationEmailAddress.equalsIgnoreCase("") || analysisAssociationEmailAddress==null){
						analysisAssociationEmailAddress = "cims@bcci.tv";
					}
					if(analysis1AssociationEmailAddress.equalsIgnoreCase("") || analysis1AssociationEmailAddress==null){
						analysis1AssociationEmailAddress = "cims@bcci.tv";
					}
					if(email.equalsIgnoreCase("") || email==null){
						email = "cims@bcci.tv";
					}
					analysisAssociationEmailAddress = analysisAssociationEmailAddress +","+email+","+ Common.joinSecetoryEmail();;
					analysis1AssociationEmailAddress = analysis1AssociationEmailAddress +","+email+","+ Common.joinSecetoryEmail();;
					smail.sendMail(analysisEmailAddress,analysisAssociationEmailAddress,analysisMsg,analysisOutputStream, appointmentLetter);
					smail.sendMail(analysis1EmailAddress,analysis1AssociationEmailAddress,analysis1Msg,analysisOutputStream, appointmentLetter);
					vparam.removeAllElements();
			        vparam.add("4");//display teams
			        vparam.add(matchId);//display teams
			        vparam.add("");//display teams
			        crsObjRemarkData = lobjGenerateProc.GenerateStoreProcedure(
				       	"esp_amd_officialremark",vparam,"ScoreDB");
				    vparam.removeAllElements();
				}else{
					analysisAssociationEmailAddress = analysisAssociationEmailAddress +","+email+","+ Common.joinSecetoryEmail();;
					analysis1AssociationEmailAddress = analysis1AssociationEmailAddress +","+email+","+ Common.joinSecetoryEmail();;
					scorer1AssociationEmailAddress = scorer1AssociationEmailAddress +","+email+","+ Common.joinSecetoryEmail();
					scorer2AssociationEmailAddress = scorer2AssociationEmailAddress +","+email+","+ Common.joinSecetoryEmail();
					
					smail.sendMail(analysisEmailAddress,analysisAssociationEmailAddress,analysisMsg,analysisOutputStream,"Appointment Letter");
					smail.sendMail(analysis1EmailAddress,analysis1AssociationEmailAddress,analysis1Msg,analysisOutputStream,"Appointment Letter");
					smail.sendMail(scorer1userEmailAddress,scorer1AssociationEmailAddress,scorerMsg,outputStream,"Appointment Letter");			
					smail.sendMail(scorer2userEmailAddress,scorer2AssociationEmailAddress,scorer2Msg,outputStream,"Appointment Letter");
				}	
				
						
			out.print("Email Send Success");
			
			

		} catch (Exception e) {
			out.print("error" + e.getMessage());
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
