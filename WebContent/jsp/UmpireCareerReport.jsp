<!--
	Page Name 	 : PlayerCareerReport.jsp
	Created By 	 : Vishwajeet Khot.
	Created Date : 13th Nov 2008
	Description  : Player Career Report 
	Company 	 : Paramatrix Tech Pvt Ltd.
	Modified by  : Vaibhavg (Added link  from TopPerformer to this page)  
-->

<%@ page import="sun.jdbc.rowset.CachedRowSet,
            in.co.paramatrix.csms.generalamd.GenerateStoreProcedure,
            java.util.*"
%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%  response.setHeader("Pragma", "private");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "private");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "must-revalidate");
	response.setHeader("Cache-Control", "must-revalidate");
	response.setDateHeader("Expires", 0);
%>
<%  CachedRowSet crsObj           = null;
	
	CachedRowSet crsObjAssociationRecord = null;
	
	CachedRowSet crsObjSeason					 	 = null;
	Vector vparam                                    = new Vector();
	GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();

	String player_name   = "";
	String userId        = "";
	String associationid = "";
	String associatioName= ""; 
	String seriesId= ""; 
	String seasonId= "";
	String roleId= "";
	String hidId = "";
	String clubId = "";
	String start_date ="";
	String date_two ="";
	java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat(
	"yyyy-MM-dd");
	Common common = new Common();
	
	String season_name = "2008-2009";
	//code added by vaibhav
		userId = request.getParameter("userid")!=null?request.getParameter("userid"):"";
		associationid  = request.getParameter("associationid")!=null?request.getParameter("associationid"):"";
		clubId= request.getParameter("clubId")!=null?request.getParameter("clubId"):"";
		player_name    = request.getParameter("playerName")!=null?request.getParameter("playerName"):""; 
		associatioName = request.getParameter("clubName")!=null?request.getParameter("clubName"):"";
		seriesId = request.getParameter("seriesId")!=null?request.getParameter("seriesId"):"0";
		seasonId = request.getParameter("seasonId")!=null?request.getParameter("seasonId"):"";
		roleId = request.getParameter("roleId")!=null?request.getParameter("roleId"):"";
		hidId = request.getParameter("hidid")!=null?request.getParameter("hidid"):"";
		start_date = request.getParameter("txtDateFrom")!=null?request.getParameter("txtDateFrom"):"";
		date_two = request.getParameter("txtDateTo")!=null?request.getParameter("txtDateTo"):"";
		if(hidId.equalsIgnoreCase("1")){
			vparam.add(seasonId);
			vparam.add("");
			vparam.add(roleId);
			vparam.add(clubId);
			vparam.add(common.formatDate(start_date));
			vparam.add(common.formatDate(date_two));
			vparam.add("1");
			crsObj = lobjGenerateProc.GenerateStoreProcedure(
					"esp_dsp_official_consoldated_report", vparam, "ScoreDB");
			vparam.removeAllElements();
		}
			
		try {	crsObjAssociationRecord = lobjGenerateProc.GenerateStoreProcedure(
				"esp_dsp_getclubs_playerlist", vparam, "ScoreDB");
		} catch (Exception e) {
			e.printStackTrace();
			out.println(e);
		}
	
	
	try {
		vparam.removeAllElements();	
		vparam.add("1");
		crsObjSeason = lobjGenerateProc.GenerateStoreProcedure(
			"esp_dsp_season",vparam,"ScoreDB");
		vparam.removeAllElements();	
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e);
	}
	
	if(crsObjSeason!=null){
		while(crsObjSeason.next()){
			seasonId = crsObjSeason.getString("id");
			season_name = crsObjSeason.getString("name");
		}
	}
	 crsObjSeason.beforeFirst();
%>
<html>
<head>
    <title> Official Details </title>
    <script language="JavaScript" src="../js/jsKeyRestrictvalidation.js" type="text/javascript"></script>
	<script language="JavaScript" src="../js/Calender.js" type="text/javascript"></script>
	<script language="JavaScript" src="../js/commonpopup.js" type="text/javascript"></script>
	<script language="JavaScript" src="../js/common.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="../css/tabexample.css"> 
	<link rel="stylesheet" type="text/css" href="../css/common.css">
	<link rel="stylesheet" type="text/css" href="../css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../css/form.css">
    <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
	<link href="../css/form.css" rel="stylesheet" type="text/css" />
	<link href="../css/formtest.css" rel="stylesheet" type="text/css" />
   
    <script language="javascript">
        var xmlHttp=null;
 	    function GetXmlHttpObject() { 
		      try{
		         //Firefox, Opera 8.0+, Safari
		         xmlHttp=new XMLHttpRequest();
		       }
		    catch (e){
		         // Internet Explorer
		         try{
		           xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		         }
		         catch (e){
		           xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		         }
		         }
		     return xmlHttp;
	 	}
	 	
	   	
		 function onLoad() {
	        obj1 = new SelObj('umpireReportForm','clubList','clubName');
	        obj1.bldInitial(); 
		 }
  	      
		function selected(obj){
      	 var eleObjArr1=document.getElementById(obj).options;
		 if (eleObjArr1.length >= 1){
		 eleObjArr1[0].selected = true;
		 }
		} 
	

   function SelObj(formname,selname,textname,str) {
        this.formname = formname;
        this.selname = selname;
        this.textname = textname;
        this.select_str = str || '';
        this.selectArr = new Array();
        this.initialize = initialize;
        this.bldInitial = bldInitial;
        this.bldUpdate = bldUpdate;
      }
      function initialize() {
        if (this.select_str =='') {
          for(var i=0;i<document.forms[this.formname][this.selname].options.length;i++) {
            this.selectArr[i] = document.forms[this.formname][this.selname].options[i];
            this.select_str += document.forms[this.formname][this.selname].options[i].value+":"+
            document.forms[this.formname][this.selname].options[i].text+",";
          }
        } else {
          var tempArr = this.select_str.split(',');
          for(var i=0;i<tempArr.length;i++) {
            var prop = tempArr[i].split(':');
            this.selectArr[i] = new Option(prop[1],prop[0]);
          }
        }
        return;
      }
      function bldInitial() {
        this.initialize();
        for(var i=0;i<this.selectArr.length;i++)
          document.forms[this.formname][this.selname].options[i] = this.selectArr[i];
        document.forms[this.formname][this.selname].options.length = this.selectArr.length;
        return;
      }
      
      function bldUpdate(e) {
       evt = e || window.event;
	   var keyPressed = evt.which || evt.keyCode;
        var str = document.forms[this.formname][this.textname].value.replace('^\\s*','');
        // If there is an empty String, don't search (hide list)
        if(str == '') {
          this.bldInitial();
          hideList();
          return;
        }
        this.initialize();
        // Show List as User Types
        showList(e);
        var j = 0;
         str=str.replace("(","");
        str=str.replace(")","");
        pattern1 = new RegExp("^"+str,"i");
        for(var i=0;i<this.selectArr.length;i++)
          if(pattern1.test(this.selectArr[i].text))
            document.forms[this.formname][this.selname].options[j++] = this.selectArr[i];
	        document.forms[this.formname][this.selname].options.length = j;   
      
       
        if (j==0) {
          hideList();
        }
    
     if(keyPressed == 40)
       {
       	selected("clubList");
       }   
      }
      
     <!-- Functions Below Added by Steven Luke -->
      function update(e) {
        evt = e || window.event;
		var keyPressed = evt.which || evt.keyCode;
      	if(keyPressed == 13 || keyPressed ==0 || keyPressed ==1){
	        document.umpireReportForm.clubName.value = document.umpireReportForm.clubList.options[document.umpireReportForm.clubList.selectedIndex].text;
    	    document.getElementById("clubName").focus();
    	    hideList();
    	    document.getElementById("lister").style.display="none";
    	    document.umpireReportForm.hdclubList.value=document.umpireReportForm.clubList.value;
    	  }
    	  if(keyPressed == 27){
	         document.getElementById("lister").style.display="none";
          }
        
      }
      
      
      function showList(e) {
        evt = e || window.event;
		var keyPressed = evt.which || evt.keyCode;	
	    if(keyPressed == 40)
        {
         document.getElementById("lister").style.display='';
         document.getElementById("clubList").focus();
        }        
        if(document.getElementById("clubList").value=="0" ||document.getElementById("clubList").value==""||keyPressed == 0)
        {
         document.getElementById("lister").style.display='';
        }
        if(keyPressed == 27){
         document.getElementById("lister").style.display="none";
        }
      }
      
       function changeList(event) {
        if (document.getElementById("lister").style.display=="none")
          showList(event);
        else
          hideList();
      }	
      
	
	 function disabledPlayerNameBox() {
	  	//document.playerReportForm.player_name.disabled=true;
	  	document.getElementById("clubName").focus();
     }
     
	 function hideList() {
	   document.getElementById("lister").style.display="none";	
	 }

	 function getData(){
    	 var clubId = document.umpireReportForm.clubList.value;
    	 document.getElementById("clubId").value = clubId;
    	 var userid = document.getElementById("hduserId").value;
         document.getElementById("umpireReportForm").action="/cims/jsp/UmpireCareerReport.jsp?hidid=1";
         document.getElementById("umpireReportForm").submit();
     }    
     
     function mainReport(session_id,user_role_id,role_id,club_id,flag){
         try {
          var userid = document.getElementById("hduserId").value;
          var txtDateFrom  = document.getElementById("txtDateFrom").value;
          var txtDateTo  = document.getElementById("txtDateTo").value;
          xmlHttp = this.GetXmlHttpObject();
        	 if (xmlHttp == null) {
                 alert("Browser does not support HTTP Request");
                 return;
             }else{
            	var url = "/cims/jsp/UmpireCareerReportResponse.jsp?userid="+userid+"&clubId="+club_id+"&seasonId="+session_id+"&roleId="+role_id+"&userRoleId="+user_role_id+"&hidId="+flag+"&txtDateFrom="+txtDateFrom+"&txtDateTo="+txtDateTo;
             	xmlHttp.open("post", url, false);
                xmlHttp.send(null);
            	if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
                     try {
                         var responseResult = xmlHttp.responseText 
                         document.getElementById("umpirecareer").innerHTML = responseResult
                        // document.getElementById(user_role_id).className="umpirereportdiv";
                         //document.getElementById(user_role_id).style.display='';
                         //document.getElementById("plusImage"+user_role_id).src = "../images/minus.jpg";
                         //document.getElementById(user_role_id).scrollIntoView(true);
                         displayPopup(user_role_id, 'umpirecareer' );
                            
                     } catch(err) {
                         alert(err.description + 'ajex.js.reciveDataLastTenOvr()');
                      }
                  }//end of if 
               }// end of else
           
           } catch(err) {
                 alert(err.description + 'ajex.js.inningid');
           }//end of catch	
            
        }
     
  </script>
	
</head>
<body>
<table align="center" style="width: 84.5em;">
    <tr>
    	<td align="center">
<div style="width:84.5em">
<jsp:include page="Menu.jsp"></jsp:include>
<br><br>
<FORM name="umpireReportForm" id="umpireReportForm" action="/cims/jsp/UmpireCareerReport.jsp" method="POST">
<INPUT type="hidden" name="hid" id="hid" value="">
<input type="hidden" id="clubId" name="clubId" value="<%=clubId%>"/>
<input type="hidden" id="hdclubList" name="hdclubList" value=""/>
<input type="hidden" id="hdseriesid" name="hdseriesid" value="<%=seriesId%>"/>
<input type="hidden" id="hdseasonid" name="hdseasonid" value="<%=seasonId%>"/>
<input type="hidden" id="hduserId" name="hduserId" value="<%=userId%>"/>
<table width="1000" border="0" align="center" cellpadding="2"	cellspacing="1" class="table">
  <tr>
   <td width="100%" colspan="3" align="left" class="legend">Official Report</td>
 </tr>
  <tr>
	<td colspan="3" align="right">
			Export : 
			<a href="/cims/jsp/PDFUmpireCareerReport.jsp?associatioName=<%=associatioName%>&seasonId=<%=seasonId%>&roleId=<%=roleId%>&clubId=<%=clubId%>&txtDateFrom=<%=start_date%>&txtDateTo=<%=date_two%>&flag=1" target="_blank">
				<img src="/cims/images/pdf.png" height="20" width="20" />
			</a>
	</td>
  </tr>	
 </table>
 <table width="100%" border="0" align="center" cellpadding="2"	cellspacing="1" class="table">
 <tr>
  	 <td width="33%">
		<DIV align="left" style="width:250px">
			<font color="gray">Enter association name to search</font>
		</DIV> 
	 </td>
	 <td width="33%">&nbsp;</td>
	 <td width="33%">&nbsp;</td>
  </tr>
  <tr>
    <TD nowrap="nowrap" width="33%">Association :
		<input class="inputsearch" type="text" name="clubName" id="clubName" value="<%=associatioName%>" size="35" onKeyUp="javascript:obj1.bldUpdate(event);" <%=seriesId.equalsIgnoreCase("0")?"":"disabled"%>> 
		<input class="btn btn-small"	id="show" type="button" value="V" onClick="changeList(event);" <%=seriesId.equalsIgnoreCase("0")?"":"disabled"%>>
		<DIV  style="width:280px;margin-left:85px">
		  <DIV id="lister" name="lister" style="display:none;position:absolute;z-index:+10;">
			<select   class="inputsearch"	  style="width:5.5cm" id="clubList" name="clubList" size="5"  onclick="update(event)" 	onkeypress="update(event)" >
<%						while (crsObjAssociationRecord.next()) {			
%>							<option value="<%=crsObjAssociationRecord.getString("id")%>" <%=crsObjAssociationRecord.getString("name").equalsIgnoreCase(associatioName)?"selected":""%>><%=crsObjAssociationRecord.getString("name")%></option>
<%   					}
%>
			</select>																					
		  </DIV>
		</DIV>
    </TD>
    <TD width="33%" align="center">Season :
   		<select  name="seasonId" id="seasonId"  <%=seriesId.equalsIgnoreCase("0")?"":"disabled" %>>
		<option >Select </option>
<%		if(crsObjSeason != null){
		while(crsObjSeason.next()){
		if(crsObjSeason.getString("id").equalsIgnoreCase(seasonId)){%>
		<option value="<%=crsObjSeason.getString("id")%>" selected="selected"><%=crsObjSeason.getString("name")%></option>
<%		}else{
%>		<option value="<%=crsObjSeason.getString("id")%>" ><%=crsObjSeason.getString("name")%></option>
<%		}
		}
 		}
%>		</select>
    </TD>
 	<TD width="33%">Official :
   		<select  name="roleId" id="roleId" >
		<option value="0">Select </option>
		<option value="2" <%=roleId.equalsIgnoreCase("2")?"selected":""%>>Umpire</option>
		<option value="4" <%=roleId.equalsIgnoreCase("4")?"selected":""%>>Referee</option>
		<option value="6" <%=roleId.equalsIgnoreCase("6")?"selected":""%>>UmpireCoach</option>
		<option value="3" <%=roleId.equalsIgnoreCase("3")?"selected":""%>>Scorer</option>
		<option value="29" <%=roleId.equalsIgnoreCase("29")?"selected":""%>>Analyst</option>
		</select>
    </TD>
	</TR>
	<TR>
	<TD width="33%" nowrap="nowrap">
		From Date: <input maxlength="10" size="10" type="text"
			class="FlatTextBox150" name="txtDateFrom" id="txtDateFrom" readonly
			value="<%=start_date%>"
			onclick="showCal('FrCalendarFrom','DateFrom','txtDateFrom','selectmatch')">
			<a href="javascript:showCal('FrCalendarFrom','DateFrom','txtDateFrom','umpireReportForm')">
			<IMG src="../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
	</TD>
	<TD width="33%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
		To Date: <input type="text" maxlength="10" size="10" class="FlatTextBox150"
		name="txtDateTo" id="txtDateTo" readonly value="<%=date_two%>"
		onclick="showCal('FrCalendarTo','DateTo','txtDateTo','selectmatch')">
		<a 	href="javascript:showCal('FrCalendarTo','DateTo','txtDateTo','umpireReportForm')">
		<IMG src="../images/cal.gif" border="0" alt=""></a>&nbsp;&nbsp;&nbsp;&nbsp;
	</TD>
 	<TD align="left" width="33%"><INPUT type="button" class="btn btn-warning" name="button" value="Search" onclick="getData();" ></TD>
  </TR>
 
</table>
<br/><br/>		  
<% if(crsObj != null) { 
%> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table">
	  <tr class="contentDark">
		<td>Official Name </td>		
		<td>One Day</td>
		<td>Two Day </td>
		<td>Three Day </td>
		<td>Four Day </td>
		<td>Five Day</td>
		<td>T20</td>
		<td>Total Matches </td>
		<td>Total Days</td>
	  </tr>
<%	while(crsObj.next()){
	int totalMatch= 0 ;
	float totalDay = 0;
	totalMatch = Integer.parseInt(crsObj.getString("oneday")) + Integer.parseInt(crsObj.getString("twoday")) +
	Integer.parseInt(crsObj.getString("threeday")) + Integer.parseInt(crsObj.getString("fourday")) +
	Integer.parseInt(crsObj.getString("fiveday")) + (Integer.parseInt(crsObj.getString("t20")));
	
	totalDay = Integer.parseInt(crsObj.getString("oneday")) + (Integer.parseInt(crsObj.getString("twoday")) * 2) +
	(Integer.parseInt(crsObj.getString("threeday")) * 3) + (Integer.parseInt(crsObj.getString("fourday")) * 4) +
	(Integer.parseInt(crsObj.getString("fiveday")) * 5) + Float.parseFloat(crsObj.getString("t20"))/2;
%>		<tr class="contentLight">
		<td><a href="/cims/jsp/UmpireCareerReportResponse.jsp?associatioName=<%=associatioName%>&userid=<%=userId%>&clubId=<%=clubId%>&seasonId=<%=seasonId %>&roleId=<%=roleId%>&userRoleId=<%=crsObj.getString("user_role_id")%>&hidId=2&txtDateFrom=<%=start_date%>&txtDateTo=<%=date_two%>&official=<%= crsObj.getString("official") %>" target="_blank"><font color="blue"><%= crsObj.getString("official") %></font></a></td>			
		<td><font color="blue"><%= crsObj.getString("oneday") %></font></td>
		<td><font color="blue"><%= crsObj.getString("twoday") %></font></td>
		<td><font color="blue"><%= crsObj.getString("threeday") %></font></td>
		<td><font color="blue"><%= crsObj.getString("fourday") %></font></td>
		<td><font color="blue"><%= crsObj.getString("fiveday") %></font></td>
		<td><font color="blue"><%= crsObj.getString("t20") %></font></td>
		<td><font color="blue"><%= totalMatch %></font></td>
		<td><font color="blue"><%= totalDay%></font></td>
		</tr>
		<tr>
          <td colspan="9" height="100%">
             <div id="<%=crsObj.getString("user_role_id")%>" name="<%=crsObj.getString("user_role_id")%>" class="umpirebackgrounddiv">
             </div>
          </td>
        </tr>
<%	}
%>		

   </table>		
<% }
%>
<script>
	onLoad();
	//disabledPlayerNameBox();
</script>

</FORM>
</div>
</td>
</tr>
</table>
<div id="umpirecareer"  class="umpirereportdiv" style='position: absolute;' >
</div>
<br><br><br><br><br><br><br><br><br>
<jsp:include page="admin/Footer.jsp"></jsp:include>
</body>
</html>                                   

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  