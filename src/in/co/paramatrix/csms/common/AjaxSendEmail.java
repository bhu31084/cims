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
public class AjaxSendEmail extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		ByteArrayOutputStream outputStream = null;
		try {

			EMailSender smail = null;
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
					"yyyy/MM/dd");
			java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");
			java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(
					"dd/MM/yyyy");

			ReadOfficialCount setCount = new ReadOfficialCount();
			String usertype = "";
			String reamrk = "";
			String applicationUrl = Common.getUrl();
			CachedRowSet  crsObjMatchData = null;
			CachedRowSet  crsObjRemarkData = null;
			
			usertype = "ump";
			String ump1count = setCount.getProxy(usertype);
			if (ump1count.length() == 1) {
				ump1count = "0" + ump1count;
			}
			String ump2count = setCount.getProxy(usertype);
			if (ump2count.length() == 1) {
				ump2count = "0" + ump1count;
			}
			usertype = "ref";
			String refcount = setCount.getProxy(usertype);
			if(refcount.length() == 1){
				refcount = "0"+refcount;
			}
			usertype = "umpch";			
			String umpchcount = setCount.getProxy(usertype);
			if(umpchcount.length() == 1){
				umpchcount = "0"+umpchcount;
			}
			
			String matchId = request.getParameter("matchId");
			String ump1_id = request.getParameter("ump1_id");
			String ump2_id = request.getParameter("ump2_id");
			String ump3_id = request.getParameter("ump3_id");
			String referee_id = request.getParameter("referee_id");
			String referee = request.getParameter("referee");
			String umpcoach_id = request.getParameter("umpcoach_id");
			String umpcoach = request.getParameter("umpcoach");
			String matchtypeflag = request.getParameter("matchtypeflag") == null ? ""
					: request.getParameter("matchtypeflag");
			String ump1 = request.getParameter("ump1") == null ? "0" : request
					.getParameter("ump1");
			String ump2 = request.getParameter("ump2") == null ? "0" : request
					.getParameter("ump2");
			String ump3 = request.getParameter("ump3") == null ? "0" : request
					.getParameter("ump3");
			String matchdate = request.getParameter("matchdate");

			String team1nck = request.getParameter("team1nickname") == null ? ""
					: request.getParameter("team1nickname");
			String team2nck = request.getParameter("team2nickname") == null ? ""
					: request.getParameter("team2nickname");

			String team1id = request.getParameter("team1id") == null ? ""
					: request.getParameter("team1id");
			String team2id = request.getParameter("team2id") == null ? ""
					: request.getParameter("team2id");
			String clubname = request.getParameter("clubname") == null ? ""
					: request.getParameter("clubname");

			String team1 = request.getParameter("team1");
			String team2 = request.getParameter("team2");
			String email = request.getParameter("email");
			String venue = request.getParameter("venue") == null ? "" : request
					.getParameter("venue");
			String seriesname = request.getParameter("seriesname");
			String matchenddate = request.getParameter("matchenddate");
			String matchpredate = request.getParameter("matchpre_date") == null ? ""
					: request.getParameter("matchpre_date");

			String flag = request.getParameter("flg");
			String mailumpire1name = "";
			String mailumpire2name = "";
			String mailumpire3name = "";
			String mailflag = request.getParameter("mailflag") == null ? ""
					: request.getParameter("mailflag");

			mailumpire2name = ump2;
			mailumpire3name = ump3;
			mailumpire1name = ump1;
			String umpire1Association = "";
			String umpire1AssociationEmailAddress = "";
			String umpire1userEmailAddress = "";
			
			String umpire2Association = "";
			String umpire2userEmailAddress = "";
			String umpire2AssociationEmailAddress = "";
			
			String umpire3Association = "";
			String umpire3userEmailAddress = "";
			String umpire3AssociationEmailAddress = "";
			
			String refereeAssociation = "";
			String refereeEmailAddress = "";
			String refereeAssociationEmailAddress = "";
			
			String umpireCoachAssociation = "";
			String umpireCoachEmailAddress = "";
			String umpireCoachAssociationEmailAddress = "";
			
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
				vparam.add(ump1_id);// display all series name.
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
						umpire1Association = "Not Specified";
						
					} else {
						umpire1Association = crsObjAssociation
								.getString("name");
						umpire1AssociationEmailAddress = crsObjAssociation
						.getString("email_address");
						reamrk = crsObjAssociation
						.getString("remark");
						umpire1AssociationEmailAddress = umpire1AssociationEmailAddress;
						
					}
				}
			}
			try {
				vparam.add(ump1_id);// display all series name.
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
						umpire1userEmailAddress = "";
					} else {
						umpire1userEmailAddress = crsObjEmail
								.getString("email");
					}
				}
			}

			try {
				vparam.add(ump3_id);// display all series name.
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
						umpire3Association = "Not Specified";
						
					} else {
						umpire3Association = crsObjAssociation
								.getString("name");
						umpire3AssociationEmailAddress = crsObjAssociation
						.getString("email_address");
						reamrk = crsObjAssociation
						.getString("remark");
						umpire3AssociationEmailAddress = umpire3AssociationEmailAddress;
						
					}
				}
			}
			try {
				vparam.add(ump3_id);// display all series name.
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
						umpire3userEmailAddress = "";
					} else {
						umpire3userEmailAddress = crsObjEmail
								.getString("email");
					}
				}
			}			
			
			
			
			try {
				vparam.add(ump2_id);// display all series name.
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
						umpire2Association = "Not Specified";
						
					} else {
						umpire2Association = crsObjAssociation
								.getString("name");
						umpire2AssociationEmailAddress = crsObjAssociation
						.getString("email_address");
						umpire2AssociationEmailAddress =  umpire2AssociationEmailAddress;
					}
				}
			}
			
			try {
				vparam.add(ump2_id);// display all series name.
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
						umpire2userEmailAddress = "";
					} else {
						umpire2userEmailAddress = crsObjEmail
								.getString("email");
					}
				}
			}
			
			try{
				
				vparam.add(referee_id);//display all series name.
				crsObjAssociation = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialassociation",vparam,"ScoreDB");
				vparam.removeAllElements();
				}catch(Exception e){
					e.printStackTrace();
				}
				if(crsObjAssociation != null){
					while(crsObjAssociation.next()){
						refereeAssociation = crsObjAssociation.getString("name");
						refereeAssociationEmailAddress = crsObjAssociation.getString("email_address");
						reamrk = crsObjAssociation.getString("remark");
						refereeAssociationEmailAddress = refereeAssociationEmailAddress;
					}
				}
				try{
					vparam.add(referee_id);//display all series name.referee_id
					crsObjEmail =  lobjGenerateProc.GenerateStoreProcedure("esp_dsp_get_users_email_address",vparam,"ScoreDB");
					vparam.removeAllElements();
				}catch(Exception e){
						e.printStackTrace();
				}
				if(crsObjEmail != null){
					while(crsObjEmail.next()){
						if(crsObjEmail.getString("email") == null || crsObjEmail.getString("email").equals("")){
							refereeEmailAddress = "";
					  	}else{
					  		refereeEmailAddress = crsObjEmail.getString("email");
					  	}					
					}			
				}
				
				
				
				try{
					vparam.add(umpcoach_id);//display all series name.
					crsObjAssociation = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_officialassociation",vparam,"ScoreDB");
					vparam.removeAllElements();
					}catch(Exception e){
						e.printStackTrace();
					}
					if(crsObjAssociation != null){	
						while(crsObjAssociation.next()){
							umpireCoachAssociation = crsObjAssociation.getString("name");
							umpireCoachAssociationEmailAddress = crsObjAssociation.getString("email_address");
							reamrk = crsObjAssociation.getString("remark");
							umpireCoachAssociationEmailAddress = umpireCoachAssociationEmailAddress;
					
						}
					}
					
					try{
					vparam.add(umpcoach_id);//display all series name.	umpcoach_id		
					crsObjEmail =  lobjGenerateProc.GenerateStoreProcedure("esp_dsp_get_users_email_address",vparam,"ScoreDB");
					vparam.removeAllElements();
					}catch(Exception e){
						e.printStackTrace();
					}
					if(crsObjEmail != null){	
						while(crsObjEmail.next()){					  					  
							  if(crsObjEmail.getString("email") == null || crsObjEmail.getString("email").equals("")){
								  umpireCoachEmailAddress = " ";						  						  	
							  }else{
								  umpireCoachEmailAddress = crsObjEmail.getString("email");
							  }
						}			
					}
			
					vparam.add(matchId);//display teams
					crsObjMatchData = lobjGenerateProc.GenerateStoreProcedure(
				       	"esp_dsp_modifymatch",vparam,"ScoreDB");
				    vparam.removeAllElements();
				    String msg = "";
				    String umpire2msg1 = "";
				    String umpire2msg2 = "";
				    String umpire1msg2 = "";
				    String umpire3msg2 = "";
				    String umpire2msg3 = "";
				    String umpire2msg = "";
				    String umpire1msg = "";
				    String umpire3msg = "";
				    String refreeMsg2 = "";
				    String refreeMsg = "";
				    String umpireCoachMsg ="";
				    String umpireCoachMsg2="";
					while(crsObjMatchData.next()){
						email = crsObjMatchData.getString("email");	
						umpire2msg1 ="<table width='700' border='0' align='center' cellpadding='2' cellspacing='1' class='table'>"+
						"<tr class='refereeContentDark'>"+
						"<td colspan='1'><b>Dear Sir,</b></td>"+
						"<td colspan='4'></td></tr>"+
						
						"<tr class='refereeContentDark'>"+
						"<td colspan='5'>&nbsp;</td></tr>"+
						
						"<tr class='refereeContentLight'>"+
						"<td colspan='3'>Please read the attached appointment and select, one of the below given "+
						"link to confirm your status. </td>"+
						"<td colspan='1'></td></tr>";
											
						
						umpire2msg2 = "<tr class='refereeContentDark'>"+
						 "<td colspan='2'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+ump2_id+"&status=Y'>Accept</a></b>"
						+ "<td colspan='2'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+ump2_id+"&status=N'>Reject</a></b>"
						+ "</tr>";
						
						
						umpire1msg2 = "<tr class='refereeContentDark'>"+
						 "<td colspan='2'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+ump1_id+"&status=Y'>Accept</a></b>"
						+ "<td colspan='2'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+ump1_id+"&status=N'>Reject</a></b>"
						+ "</tr>";
						
						umpire3msg2 = "<tr class='refereeContentDark'>"+
						 "<td colspan='2'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+ump3_id+"&status=Y'>Accept</a></b>"
						+ "<td colspan='2'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+ump3_id+"&status=N'>Reject</a></b>"
						+ "</tr>";
						
						refreeMsg2= "<tr class='refereeContentDark'>"+
						 "<td colspan='2'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+referee_id+"&status=Y'>Accept</a></b>"
							+ "<td colspan='2'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+referee_id+"&status=N'>Reject</a></b>"
							+ "</tr>";
						
						
						umpireCoachMsg2 ="<tr class='refereeContentDark'>"+
						 "<td colspan='2'>To Accept please click Accept link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+umpcoach_id+"&status=Y'>Accept</a></b>"
							+ "<td colspan='2'>To Reject please click Reject link <b><a href='"+applicationUrl+"/OfficialStatus?match="+ matchId +"&offical="+umpcoach_id+"&status=N'>Reject</a></b>"
							+ "</tr>";
						
						umpire2msg3= "<tr class='refereeContentDark'><td  colspan='4' align='left'>&nbsp;</td></tr>" 
						+ "<tr class='refereeContentDark'>"
						+ "<td colspan='4'><b><u>Note: </u></b> &nbsp; If a match official is officiating different matches at the same venue, consecutively, the </td>"
						+ "</tr>"
						+ "<tr class='refereeContentDark'>"
						+ "<td colspan='4'>reporting pattern will be One day/Two days before the first match, till one day after the last match.</td>"
						+ "</tr>"+
						
						
						"<tr class='refereeContentDark'>"+
						"<td ></td><td colspan='3'>"+
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
						umpire2msg = umpire2msg1 + umpire2msg2 + umpire2msg3;
						umpire1msg = umpire2msg1 + umpire1msg2 + umpire2msg3;
						umpire3msg = umpire2msg1 + umpire3msg2 + umpire2msg3;
						refreeMsg = umpire2msg1 + refreeMsg2 + umpire2msg3;
						umpireCoachMsg = umpire2msg1 + umpireCoachMsg2 + umpire2msg3;
						outputStream = new ByteArrayOutputStream();
						String path = (String)getServletContext().getRealPath("");
						String filePath =path+"/images/BCCI_Logo_.jpg";
						
						
						MatchOfficialAttachment.matchOfficialAttachment(filePath,matchId, crsObjMatchData, outputStream,reamrk);
					
					}
					String appointmentLetter = "";
					if(reamrk.equalsIgnoreCase("")){
						appointmentLetter = "Appointment Letter";
					}else{
						appointmentLetter = "Revised Appointment Letter (Revised on "+ sdf2.format(new Date()) +" )";
					}
					if(umpire2AssociationEmailAddress.equalsIgnoreCase("") || umpire2AssociationEmailAddress==null){
						umpire2AssociationEmailAddress = "cims@bcci.tv";
					}
					if(umpire1AssociationEmailAddress.equalsIgnoreCase("") || umpire1AssociationEmailAddress==null){
						umpire1AssociationEmailAddress = "cims@bcci.tv";
					}
					if(umpire3AssociationEmailAddress.equalsIgnoreCase("") || umpire3AssociationEmailAddress==null){
						umpire3AssociationEmailAddress = "cims@bcci.tv";
					}
					if(refereeAssociationEmailAddress.equalsIgnoreCase("") || refereeAssociationEmailAddress==null){
						umpire2AssociationEmailAddress = "cims@bcci.tv";
					}
					if(umpireCoachAssociationEmailAddress.equalsIgnoreCase("") || umpireCoachAssociationEmailAddress==null){
						umpireCoachAssociationEmailAddress = "cims@bcci.tv";
					}
					if(email.equalsIgnoreCase("") || email==null){
						email = "cims@bcci.tv";
					}
					umpire2AssociationEmailAddress = umpire2AssociationEmailAddress +","+ email +","+ Common.joinSecetoryEmail();		
					umpire1AssociationEmailAddress = umpire1AssociationEmailAddress +","+ email +","+ Common.joinSecetoryEmail();
					umpire3AssociationEmailAddress = umpire3AssociationEmailAddress +","+ email +","+ Common.joinSecetoryEmail();
					refereeAssociationEmailAddress = refereeAssociationEmailAddress +","+ email +","+ Common.joinSecetoryEmail();
					umpireCoachAssociationEmailAddress = umpireCoachAssociationEmailAddress +","+ email +","+ Common.joinSecetoryEmail();
					
					smail.sendMail(umpire2userEmailAddress,umpire2AssociationEmailAddress, umpire2msg,outputStream, appointmentLetter);
					smail.sendMail(umpire1userEmailAddress, umpire1AssociationEmailAddress, umpire1msg,outputStream, appointmentLetter);
					smail.sendMail(umpire3userEmailAddress, umpire3AssociationEmailAddress, umpire3msg,outputStream, appointmentLetter);
					smail.sendMail(refereeEmailAddress,refereeAssociationEmailAddress,refreeMsg,outputStream, appointmentLetter);
			        smail.sendMail(umpireCoachEmailAddress,umpireCoachAssociationEmailAddress,umpireCoachMsg,outputStream, appointmentLetter);
			        
			        vparam.removeAllElements();
			        vparam.add("1");//display teams
			        vparam.add(matchId);//display teams
			        vparam.add("");//display teams
			        crsObjRemarkData = lobjGenerateProc.GenerateStoreProcedure(
				       	"esp_amd_officialremark",vparam,"ScoreDB");
				    vparam.removeAllElements();
			
			out.print("Email Send Success");
			
			

		} catch (Exception e) {
			out.print("error" + e.getMessage());
		}
	}

}
