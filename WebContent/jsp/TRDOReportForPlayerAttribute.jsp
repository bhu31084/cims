<!--
	Page Name 	 : TrdoReport.jsp
	Created By 	 : Archana Dongre.
	Created Date : 4th Dec 2008
	Description  : TRDO report on Players Strengths and weaknesses.
	Company 	 : Paramatrix Tech Pvt Ltd.
--> 
<%@ page import="sun.jdbc.rowset.CachedRowSet,
            in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
            java.util.*"%>
<%@ page import="in.co.paramatrix.common.*"%>            
<%@ page import="java.util.*,in.co.paramatrix.csms.logwriter.LogWriter"%>
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
<%	
	String role = "4";
	ReplaceApostroph replaceApos = new ReplaceApostroph();
	LogWriter log = new LogWriter();
	
	String match_id = session.getAttribute("matchid").toString();
	String user_id = session.getAttribute("userid").toString();
	String loginUserName = session.getAttribute("usernamesurname").toString();
	String userRole = session.getAttribute("role").toString();
	String hdFlag = request.getParameter("hdFlag")==null?"0":request.getParameter("hdFlag");
	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MMM-dd");
	java.text.SimpleDateFormat ddmmyyyy = new java.text.SimpleDateFormat("dd/MM/yyyy");
	
	String userMatchOfficial_id = "0"; 
	StringBuffer sbIds = new StringBuffer();
    String playerId = "0";
	String playerroleId =null;
	String playerRun = "0";
        String totalMatch = "0";
	String message="";
	String flag = "false";
	String reportId = request.getParameter("dpRole")!=null?request.getParameter("dpRole"):"0";
	
	CachedRowSet crsObjplayerDetail = null;	
	CachedRowSet crsObjgetMatchOffId = null;
	CachedRowSet displayCrs = null;
    CachedRowSet displayPlayerRunsCrs = null;	
    CachedRowSet matchSummeryCrs = null;
    CachedRowSet messageCrs = null;
    CachedRowSet matchOfficialsCrs = null;
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure(match_id);
	
	Vector vMatchparam = new Vector();
	Vector vPlayerDetailparam = new Vector();
	 //To get the match official id of referee.
	try{		
            vMatchparam.add(user_id);
            vMatchparam.add(match_id);
            crsObjgetMatchOffId = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_matchrefreeofficialid",vMatchparam,"ScoreDB");			
            if(crsObjgetMatchOffId != null){
                while(crsObjgetMatchOffId.next()){
                    userMatchOfficial_id = crsObjgetMatchOffId.getString("official")==null?"0":crsObjgetMatchOffId.getString("official"); 
                }
            }		
            vMatchparam.removeAllElements();	
	}catch (Exception e) {
            System.out.println("Exception"+e);
            e.printStackTrace();
            log.writeErrLog(page.getClass(),match_id,e.toString());
	}
	
        vMatchparam.add(match_id); // match_id
		try{
			matchSummeryCrs = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_matchdetails_pitchreport", vMatchparam, "ScoreDB");
		}catch (Exception e) {
                    log.writeErrLog(page.getClass(),match_id,e.toString());
                }
        vMatchparam.removeAllElements();
	//To display the matchPlayerMapId id's of players
	try{
            vPlayerDetailparam.add(match_id);
            crsObjplayerDetail = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_userroleid_for_breaches",vPlayerDetailparam,"ScoreDB");
            vPlayerDetailparam.removeAllElements();	
	}catch (Exception e) {
             e.printStackTrace();
             log.writeErrLog(page.getClass(),match_id,e.toString());
	}
	//To get match officials --dipti
	try{
		vPlayerDetailparam.removeAllElements();	
		vPlayerDetailparam.add(match_id);
		matchOfficialsCrs = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_matchidsearch",vPlayerDetailparam,"ScoreDB");
		vPlayerDetailparam.removeAllElements();	
	}catch(Exception e){
		e.printStackTrace();
        log.writeErrLog(page.getClass(),match_id,e.toString());
	}
        if(hdFlag!=null && hdFlag.equalsIgnoreCase("2")){
            String[] retrieve_ids = request.getParameter("hidden_ids").split(",");
            int retrieve_ids_length = retrieve_ids.length;
            playerId = request.getParameter("dpPlayer")!=null?request.getParameter("dpPlayer"):"";
            for (int count = 0; count < retrieve_ids_length; count = count + 2) {
                String umpire1 = retrieve_ids[count];	
                vMatchparam.add(match_id);
		vMatchparam.add(playerId);
		vMatchparam.add(userMatchOfficial_id);
                vMatchparam.add(retrieve_ids[count]);
                if(retrieve_ids[count+1].equalsIgnoreCase("Y")){
			vMatchparam.add(request.getParameter("ump2"+umpire1));
			if(request.getParameter("rem_ump2"+ retrieve_ids[count]) != null){
			//System.out.println(":::::::::::::::::::"+request.getParameter("rem_ump2"+ retrieve_ids[count]));
				vMatchparam.add(replaceApos.replacesingleqt((String)request.getParameter("rem_ump2"+ retrieve_ids[count])));
			}else{
				vMatchparam.add(request.getParameter("rem_ump2"+ retrieve_ids[count]));
			}
		}else if(retrieve_ids[count+1].equalsIgnoreCase("N")){
			vMatchparam.add("0");
			if(request.getParameter("rem_ump2"+ retrieve_ids[count]) != null){
			//System.out.println(":::::::::2::::::::::"+request.getParameter("rem_ump2"+ retrieve_ids[count]));
				vMatchparam.add(replaceApos.replacesingleqt((String)request.getParameter("rem_ump2"+ retrieve_ids[count])));
			}else{
				vMatchparam.add(request.getParameter("rem_ump2"+ retrieve_ids[count]));
			}
		}
		vMatchparam.add(reportId);//Report Id of captain report				
		try{
                    messageCrs = lobjGenerateProc.GenerateStoreProcedure(
                    	"esp_amd_userappraisal", vMatchparam, "ScoreDB");
                }catch(Exception e){
                    e.printStackTrace();
                    log.writeErrLog(page.getClass(),match_id,e.toString());
                }    
                vMatchparam.removeAllElements();
                if (messageCrs.next()) {//to display message saved/updated
				message = messageCrs.getString("retval");
				flag = "true";
			}
           }
                
        }
        if(hdFlag!=null && (hdFlag.equalsIgnoreCase("1") || hdFlag.equalsIgnoreCase("2") )){
            playerId = request.getParameter("dpPlayer")!=null?request.getParameter("dpPlayer"):"";
            vMatchparam.add(match_id); // match_id
            vMatchparam.add(playerId);
            vMatchparam.add(userMatchOfficial_id);
            vMatchparam.add(reportId); // report id
            displayCrs = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_umpirereports", vMatchparam, "ScoreDB");
            vMatchparam.removeAllElements();
            vMatchparam.add(playerId);
            vMatchparam.add(reportId);
            displayPlayerRunsCrs = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_batsman_total_runs", vMatchparam, "ScoreDB");
         
             if(displayPlayerRunsCrs!=null){               
                while(displayPlayerRunsCrs.next()){
                    playerRun = displayPlayerRunsCrs.getString("playerStaticstic");
                    totalMatch = displayPlayerRunsCrs.getString("totalmatch");
                }
                if(reportId.equalsIgnoreCase("9")){
                    playerRun = playerRun + " Runs. Matches:-"+totalMatch;
                }else if(reportId.equalsIgnoreCase("10") || reportId.equalsIgnoreCase("11")){
                    playerRun = playerRun + " Wkts. Matches:-"+totalMatch; 
                }else if(reportId.equalsIgnoreCase("12")){
                    playerRun = playerRun + " Stumpings / catches. Matches:-"+totalMatch;
                }
             }
        }
%>
<html>
<head>
<title> TRDO Report On Players</title>

<link href="../css/form.css" rel="stylesheet" type="text/css" />
<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=request.getContextPath()%>/js/jsKeyRestrictvalidation.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/trim.js"></script>
<script language="JavaScript">

function getRecord(){
    document.getElementById("hdFlag").value="1";
    document.getElementById("frmTrdoReport").action="/cims/jsp/TRDOReportForPlayerAttribute.jsp";
    document.getElementById("frmTrdoReport").submit();
} 
function parentTrig( parent, trigger, chield ){
    this.parent = function(){
	return parent;
    }
    this.trigger = function(){
	return trigger;
    }
    this.chield = function(){
	return chield;
    }
}
var deptArray = new Array();
function mapParentTrig( parent, trigger, chield ){
    deptArray[deptArray.length] = new parentTrig( parent, trigger, chield );
    var parentObj = document.getElementById(parent );
    parentObj.onchange = function(){
        enebleDisableQue( parent );
    }
}

function enebleDisableQue( myId ){
    for( var i=0; i<deptArray.length; i++ ){
        if( myId == deptArray[i].parent() ){
            enebleDisableObject(deptArray[i].chield(), true );
            var parentObj = document.getElementById(myId );
            if(parentObj.options[parentObj.selectedIndex].value == (deptArray[i].trigger())) {
                enebleDisableObject(deptArray[i].chield(), false );
            }
        }
    }
}

function enebleDisableObject( id, disable ){
    document.getElementById(id).disabled = disable;
    if(document.getElementById("remAnch_"+id ).innerHTML != " "){
        document.getElementById("remAnch_"+id ).disabled = disable;//to disable anchor tag
	document.getElementById("rem_"+id ).disabled = disable;//to disable textarea tag
    }
}

function doOnLoad(){
    for( var i=0; i<deptArray.length; i++ ){
        enebleDisableQue( deptArray[i].parent() );
    }
}
function assign(){
    if(document.getElementById('hidden_ids').value != ""){			
    var isComplete = true;       
        var str = document.getElementById('hidden_ids').value.split(",");
           for(var count = 0; count < str.length; count = count + 2){
                if(str[count+1] == ("Y")){
                    if(document.getElementById("ump2"+str[count]).value == "0"){
                       var removeTag = document.getElementById( 'que_'+str[count]).innerHTML.replace('<B>','')
						removeTag = removeTag.replace('</B>','')
                                                removeTag = removeTag.replace('&nbsp;','')
                                                removeTag = removeTag.replace('&nbsp;*&nbsp;','')
                        alert("Please Fill Question - "+removeTag);
                        document.getElementById("ump2"+str[count]).focus()
                        return false
                        isComplete = false;
                    }
                }
            }
	if(!isComplete){				
    	return false;
       }else{
             document.getElementById("hdFlag").value="2";
             document.getElementById("frmTrdoReport").action="/cims/jsp/TRDOReportForPlayerAttribute.jsp";
             document.getElementById("frmTrdoReport").submit();
        }
    }else{
       	if(document.getElementById("dpPlayer").value=="0" ){
           alert("Please select match player option");
           return false;
		}else if(document.getElementById("dpRole").value=="0" ){
             alert("Please select role option");
             return false;
		} 
    }
}
		
function setFocus(){
    var elem = document.getElementById('frmPitchOutfieldReportLimited').elements;
    var flag = "false"
    for(var i = 0; i < elem.length; i++){
        if(flag == "false"){
            if(elem[i].type == 'select-one') {
		if(elem[i].disabled == false && elem[i].value == '0'){//not selected cmb
                    var id = elem[i].id;
                    document.getElementById(id).focus()
                    flag = "true"
		}
            }
    	}
    }
}
		
function enterRemark(id){//hide / unhide div on click of remark
    var remarkDiv = document.getElementById( 'remDiv_'+id );
    var remarkTextArea = document.getElementById( 'rem_ump2'+id );
    if( remarkDiv.style.display == 'none' ){
	remarkDiv.style.display = ''
	remarkTextArea.focus();
    }else{
	if(remarkTextArea.innerHTML == ""){
            remarkDiv.style.display = 'none'
	}
    }
}

function getKeyCode(e){
	 if (window.event)
	        return window.event.keyCode;
	 else if (e)
	    return e.which;
	 else
	    return null;
	}
	
	function imposeMaxLength(Object, MaxLen,event,id,flag){
		
	  if(flag == 1){
		  if(Object.value.length > MaxLen){
			alert("Please enter maximum 500 characters only.")
			document.getElementById(id).focus()
			return false
		  }	else{
			return true
		  }			  
	  }
	  var keyvalue = getKeyCode(event);
	  if(keyvalue==8 || keyvalue==0 || keyvalue==1){
		return true;
	  }else{
		/*  if(Object.value.length > MaxLen){
				alert("falg 2 Please enter maximum 500 characters only.")
				document.getElementById(id).focus()
				return false
		 }else{*/	
		    return (Object.value.length < MaxLen);
		// }
	  }	
	}

	function callTooltip(anchorid,textareaid){
		document.getElementById(anchorid).title = document.getElementById(textareaid).innerHTML
	}
	
     </script>         
</head>
<body>
<div class="container">
<jsp:include page="Menu.jsp"></jsp:include>
<table style="width:100%;">
    <tr>
    	<td>
	<div>	
		

		<div id="content" style="width: 100%;" align="center">
		<FORM name="frmTrdoReport" id="frmTrdoReport" method="post"><br><br>
		<table width="100%" border="0" cellpadding="2" cellspacing="1" class="table">
			<tr align="left">
				<td align="left" colspan="2" class="legend">TRDO Report For Player's Attribute</td>
			</tr>
		    <tr>
		        <td colspan="2" width="90%" class="contentDark" colspan="2" align="right"><b><%=loginUserName%>&nbsp; DATE :</b> <%=sdf.format(new Date())%></td>
		    </tr>
		<%  if(matchSummeryCrs != null){
		    while(matchSummeryCrs.next()){				
		%>   <tr class="contentLight">
		        <td width="15%" ><b>Match:</b></td>
				<td width="80%" style="text-align: left" ><%=matchSummeryCrs.getString("id")%></td>
		     </tr>
		     <tr class="contentDark">
		        <td width="15%"  ><b>Teams :</b></td>
		        <td width="80%" style="text-align: left" ><%=matchSummeryCrs
												.getString("team1")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=matchSummeryCrs
												.getString("team2")%></td>
		     </tr>										
		     <tr class="contentLight">										
				<td width="15%"><b>Match Date : </b></td>
		<%	if (matchSummeryCrs.getString("displaymatchdate") == null || matchSummeryCrs.getString("displaymatchdate").equals("")) {%>
				<td align="left">-</td>
		<%	} else {
		           String d1 = null;
				java.util.Date date = ddmmyyyy.parse(matchSummeryCrs.getString("displaymatchdate"));
				d1 = sdf.format(date);
				
				String d2 = null;
				java.util.Date enddate = ddmmyyyy.parse(matchSummeryCrs.getString("startdate"));
				d2 = sdf.format(enddate);
				
		        %>
				<td width="80%" style="text-align: left"><%=d1 %> TO  <%=d2 %></td>
		<%	}%>
		     </tr>
		     <tr class="contentDark">
		        <td width="15%"><b>Venue:</b></td>
				<td width="80%"  style="text-align: left"><%=matchSummeryCrs.getString("venue")%></td>
		     </tr>
 			<tr class="contentLight">
				<td width="15%"><b>Name Of Tournament :</b></td>
<%				if (matchSummeryCrs.getString("tournament") == null
					|| matchSummeryCrs.getString("tournament").equals("")) {
%>				<td>----</td>
<%				} else {
%>				<td align="left"><%=matchSummeryCrs.getString("tournament")%></td>
<%				}
%>
			</tr>
		<%  }//end while
		    }//end if
		%>	
		<%
		//esp_dsp_matchidsearch
			if(matchOfficialsCrs != null){
				while(matchOfficialsCrs.next()){
		%>	<tr class="contentDark">
				<td width="10%" >Officials:</td>
				<td width="10%" style="text-align: left">
				Umpire 1 : <%=matchOfficialsCrs.getString("umpire1").equalsIgnoreCase("") ? "   -":matchOfficialsCrs.getString("umpire1") %>,&nbsp;&nbsp;&nbsp;
				Umpire 2 : <%=matchOfficialsCrs.getString("umpire2").equalsIgnoreCase("") ? "   -":matchOfficialsCrs.getString("umpire2") %>
				</td>
				
			</tr>
			<tr class="contentLight">
				<td width="10%" >&nbsp;</td>
				<td width="10%" style="text-align: left">Umpire 3 :<%=matchOfficialsCrs.getString("umpire3").equalsIgnoreCase("") ? "   -":matchOfficialsCrs.getString("umpire3")%></td>
			</tr>
			<tr class="contentDark">
				<td width="10%" >&nbsp;</td>
				<td width="10%" style="text-align: left">
				Referee : <%=matchOfficialsCrs.getString("matchreferee").equalsIgnoreCase("") ? "   -":matchOfficialsCrs.getString("matchreferee")%>,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				Umpire Coach :<%=matchOfficialsCrs.getString("umpirecoach").equalsIgnoreCase("") ? "   -":matchOfficialsCrs.getString("umpirecoach") %></td>
			</tr>
		<%		
				}
			}
		%>	
		</table>
		 <br>
		 <br>
		<%	if(flag.equalsIgnoreCase("true")){%>	
		<table width="100%">
	            <tr>
	                <td class="message"><center><%=message%></center>
	                </td>
	            </tr>
		</table>			
		<%	}//end if	
		%>     
		<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		    <tr class="contentLight">
		        <td align="left" width="40%">Match Players:
			<select name="dpPlayer" id="dpPlayer">
		            <option value="0" >Select </option>			
		<%	if(crsObjplayerDetail != null){
			while(crsObjplayerDetail.next()){
		%>	    <option value="<%=crsObjplayerDetail.getString("users_id")%>" <%= playerId.equalsIgnoreCase(crsObjplayerDetail.getString("users_id"))?"selected":"" %> ><%=crsObjplayerDetail.getString("playername")%></option>
		<%	
			}// end of while
			}
		%>	</select><input type="hidden" id="hdPlayerName" name="hdPlayerName" value="">
		                 <input type="hidden" id="hdFlag" name="hdFlag" value="0">   
			</td>
			<td align="left">Role:      			       			
		              <select name="dpRole" id="dpRole" onchange="getRecord();">
		              	<option value="0">-Select-</option>					
		                <option value="9" <%= reportId.equalsIgnoreCase("9")?"selected":"" %>>Batting</option>
				       	<option value="10" <%= reportId.equalsIgnoreCase("10")?"selected":"" %>>PACER</option>
				       	<option value="11"  <%= reportId.equalsIgnoreCase("11")?"selected":"" %>>SPINNER</option>
				       	<option value="12"  <%= reportId.equalsIgnoreCase("12")?"selected":"" %>>WicketKeeping</option>
		           </select>
		        </td>			
		   </tr>
		</table>	
		 <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		<%  if (displayCrs != null) {
		    int counter = 1;
		    while (displayCrs.next()) {
		    sbIds.append(displayCrs.getString("id"));
		    sbIds.append(",");
		    sbIds.append(displayCrs.getString("scoring_required"));
		    sbIds.append(",");
		    if (counter % 2 != 0) {
		%> <tr class="contentDark">
		<%  }else {
		%> <tr class="contentLight">
		<%}   if(!displayCrs.getString("parent").equalsIgnoreCase("0")){
		%>   <td id="que_<%=displayCrs.getString("id")%>"><b>&nbsp;&nbsp;*&nbsp;<%=displayCrs.getString("description")%></b></td>
		     <td>     
		<%      }else{  
		%>   <td id="que_<%=displayCrs.getString("id")%>"><b>&nbsp;<%=displayCrs.getString("description")%></b></td>
		     <td>
		<%     }
		    if (displayCrs.getString("scoring_required").equalsIgnoreCase("Y")) {
		        String[] valueArr = displayCrs.getString("cnames").toString().split(",");
		%>  <select style="width:2.5cm" name="ump2<%=displayCrs.getString("id")%>" id="ump2<%=displayCrs.getString("id")%>">
		<%   if(displayCrs.getString("selected").equalsIgnoreCase("0")){%><option value="0" selected="selected">- Select -</option>
		<%   }else{
		%>          <option value="0">- Select -</option>
		<%   }
		     for (int count = valueArr.length; count > 0; count--) {
		        if(displayCrs.getString("selected").equalsIgnoreCase(""+count)){
		%>          <option value="<%=count%>" selected="selected"><%=valueArr[count - 1]%></option>
		<%	}else{
		%>          <option value="<%=count%>"><%=valueArr[count - 1]%></option>
		<%	}
		     }// end of for
		%>	</select>
			<a id="remAnch_<%=displayCrs.getString("id")%>"
					name="remAnch_<%=displayCrs.getString("id")%>"
					href="javascript:void('')"
					onmouseover="callTooltip('remAnch_<%=displayCrs.getString("id")%>','rem_ump2<%=displayCrs.getString("id")%>')"
					onclick="enterRemark('<%=displayCrs.getString("id")%>')">Remark</a> 
		<%     if (displayCrs.getString("remark").trim().equalsIgnoreCase("")) {
		%>      	<div id="remDiv_<%=displayCrs.getString("id")%>" name="remDiv_<%=displayCrs.getString("id")%>" style="display:none"><textarea
					class="textArea" id="rem_ump2<%=displayCrs.getString("id")%>"
					name="rem_ump2<%=displayCrs.getString("id")%>" rows="4" cols="20"
					maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump2<%=displayCrs.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=displayCrs.getString("id")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
				</div>
		<%
		        } else {
		%>		<div id="remDiv_<%=displayCrs.getString("id")%>"
					name="remDiv_<%=displayCrs.getString("id")%>"><textarea
					class="textArea" id="rem_ump2<%=displayCrs.getString("id")%>"
					name="rem_ump2<%=displayCrs.getString("id")%>" rows="4" cols="20"
					maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump2<%=displayCrs.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=displayCrs.getString("id")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
				</div>
		<%      }
		    } else {
		          if(displayCrs.getString("parent").equalsIgnoreCase("0") && displayCrs.getString("trig").equalsIgnoreCase("0") ){
		          }else if(displayCrs.getString("parent").equalsIgnoreCase("0") && displayCrs.getString("trig").equalsIgnoreCase("2") ){
		%>         <div id="remDiv_<%=displayCrs.getString("id")%>"
		             name="remDiv_<%=displayCrs.getString("id")%>"><%=playerRun%></div>     
		        
		<%          }else{
		%>      <a id="remAnch_<%=displayCrs.getString("id")%>"
		            name="remAnch_<%=displayCrs.getString("id")%>"
		            href="javascript:void('')"
		            onmouseover="callTooltip('remAnch_<%=displayCrs.getString("id")%>','rem_ump2<%=displayCrs.getString("id")%>')"
		            onclick="enterRemark('<%=displayCrs.getString("id")%>')">Remark</a>
		<%      if (displayCrs.getString("remark").trim().equalsIgnoreCase("")) {
		%>	<div id="remDiv_<%=displayCrs.getString("id")%>"
		             name="remDiv_<%=displayCrs.getString("id")%>" style="display:none">
		             <textarea class="textArea" id="rem_ump2<%=displayCrs.getString("id")%>"
			     name="rem_ump2<%=displayCrs.getString("id")%>" rows="4" cols="20"
		             maxlength="500"
		             onblur="imposeMaxLength(this,500,event,'rem_ump2<%=displayCrs.getString("id")%>','1')"
		            onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=displayCrs.getString("id")%>','2')"><%=displayCrs.getString("remark").trim()%></textarea>
			</div>
		<%      } else {
		%>      <div id="remDiv_<%=displayCrs.getString("id")%>"
		             name="remDiv_<%=displayCrs.getString("id")%>">
		             <textarea class="textArea" id="rem_ump2<%=displayCrs.getString("id")%>"
		                        name="rem_ump2<%=displayCrs.getString("id")%>" rows="4" cols="20"
					maxlength="500"
					onblur="imposeMaxLength(this,500,event,'rem_ump2<%=displayCrs.getString("id")%>','1')"
					onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz -_/.,%@&?!1234567890'),imposeMaxLength(this,500,event,'rem_ump2<%=displayCrs.getString("id")%>','2')"><%=displayCrs.getString("remark").trim()%>
		             </textarea>
		         </div>
		<%      }
		    }//end else
		%>  </td>
		   </tr>
		<%
			counter++;
		     }   
		    }//end while
		}//end if
		%>
		
		<input type="hidden" id="hid" name="hid" />
		<input type="hidden" id="hidden_ids" name="hidden_ids" value="<%=sbIds%>" />
		</table>
		<center>NOTE : Please enter maximum 500 characters for remark.</center>
		<br>
		
		<%  if (!userRole.equals("9")) {%>
		    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
		        <tr>
		            <td align="center">
		                <input class="button1"  type="button" align="center" class="contentDark" id="btnSubmit" name="btnSubmit" value="Submit" onclick="assign()">
		            </td>
			</tr>
		    </table>
		<%}%>
		
	 </form>
			<jsp:include page="admin/Footer.jsp"></jsp:include>
		 </div>
	</div>	
	
	</td>
	</tr>
	</table>
</div>
</body>
</html>