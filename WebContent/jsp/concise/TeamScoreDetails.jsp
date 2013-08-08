<%-- 
    Document    : TeamScoreDetails.jsp
    Created on  : 07 May, 2000
    Author      : Archana D
    Description : To display the team players details of concise match.    
--%>
<%@ page import="sun.jdbc.rowset.CachedRowSet"%>
<%@ page import="in.co.paramatrix.csms.common.Common"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="in.co.paramatrix.csms.generalamd.GenerateStoreProcedure"%>
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
        CachedRowSet crsObjMtWiseUmpSelfAssest = null;
		CachedRowSet crsCmbMtWiseUmpSelfAssest = null;
		CachedRowSet crsObjSeriesTypeRecord = null;
		CachedRowSet crsObjMtWiseTeamPlayerData = null;
        Calendar cal ;
        int counter = 1;
        String currYear = null;
        String reportHeading=null;
        Vector vparam = new Vector();
        String seaonId = "0";
        String series_name ="";
        String sessionName = null;
		GregorianCalendar currDateObj=new GregorianCalendar();
		cal = new GregorianCalendar(currDateObj.get(Calendar.YEAR),currDateObj.get(Calendar.MONTH),1);		
        GenerateStoreProcedure lobjGenerateProc = new GenerateStoreProcedure();
    	String hidId = request.getParameter("hidId")!=null?request.getParameter("hidId"):"0";  
    	String sessionid = request.getParameter("cmbsession")!=null?request.getParameter("cmbsession"):"0";   
        String seriesid = request.getParameter("seriesTypeList")!=null?request.getParameter("seriesTypeList"):"0";
    	String teamId =  request.getParameter("dpteams")!=null? request.getParameter("dpteams"):"0";;
    	String[] strserArr = null;
        String[] strteamArr = null;
        if(hidId.equalsIgnoreCase("1")){
    		strserArr = seriesid.split("~");
        	strteamArr = teamId.split("~");
    		try{
	        	vparam.add(sessionid);
	        	vparam.add(strserArr[0]);
	        	vparam.add(strteamArr[0]);   
		        crsObjMtWiseTeamPlayerData = lobjGenerateProc.GenerateStoreProcedure("Dsp_Concise_Batsman_Statistics", vparam, "ScoreDB");
		       	vparam.removeAllElements();
	        }catch(Exception e){
	        	e.printStackTrace();
	        }		
    	}        
        
        try{
        	vparam.add("");   
	        crsObjMtWiseUmpSelfAssest = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_seasonlist", vparam, "ScoreDB");
	       	vparam.removeAllElements();
        }catch(Exception e){
        	e.printStackTrace();
        }
        
     
       	try {
			crsObjSeriesTypeRecord = lobjGenerateProc.GenerateStoreProcedure("esp_dsp_getseriestypes", vparam, "ScoreDB");
	   	} catch (Exception e) {
			e.printStackTrace();
	   	}
               
               
%>             

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Umpire Self Assessment Report</title>
         <link rel="stylesheet" type="text/css" href="../../css/menu.css">
         <link rel="stylesheet" type="text/css" href="../../CSS/Styles.css">
<%--     <link href="../../css/form.css" rel="stylesheet" type="text/css" />--%>
<%--     <link href="../../css/formtest.css" rel="stylesheet" type="text/css" />    --%>
		 <script language="javascript">
            function validate() {
                if(document.getElementById("cmbsession").value=="0"){
                    alert("Please Select Season");
                    document.getElementById("cmbsession").focus();
                    return false;
                }else if(document.getElementById("dpteams").value=="0"){
                	alert("Please Select Teams");
                    document.getElementById("dpteams").focus();
                    return false;
                }   
                else{    
                	if(document.getElementById("seriesName").value == ""){
                		document.getElementById("seriesName").value = ""
                		document.getElementById("hdseriesTypeList").value = "0"
                	}
                    document.getElementById("hidId").value="1";
                    document.frmconciseteamscoredetail.action = "/cims/jsp/concise/TeamScoreDetails.jsp";
                    document.frmconciseteamscoredetail.submit();
                }
            }
            function GetXmlHttpObject() {
                var xmlHttp = null;
                try
                {
                    // Firefox, Opera 8.0+, Safari
                    xmlHttp = new XMLHttpRequest();
                }
                catch (e)
                {
                    // Internet Explorer
                    try
                    {
                        xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                    }
                    catch (e)
                    {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                }
                return xmlHttp;
             }            
     
               function onLoad() {	      		 
	      		  obj1 = new SelObj('frmconciseteamscoredetail','seriesTypeList','seriesName');
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
    				if(keyPressed == 40){
				       	selected("seriesTypeList");
       				 }   
       	 	 }
      		 function update(e) {
      			evt = e || window.event;
	  			 var keyPressed = evt.which || evt.keyCode;
	  			if(keyPressed == 13 || keyPressed ==0 || keyPressed ==1){
					document.frmconciseteamscoredetail.seriesName.value = document.frmconciseteamscoredetail.seriesTypeList.options[document.frmconciseteamscoredetail.seriesTypeList.selectedIndex].text;
			    	document.getElementById("seriesName").focus();
			    	hideList();
			    	document.frmconciseteamscoredetail.hdseriesTypeList.value=document.frmconciseteamscoredetail.seriesTypeList.value;
			     }
			     if(keyPressed == 27){
			         document.getElementById("lister").style.display="none";
			     }
        	 }
		     function showList(e) {
			     evt = e || window.event;
	  			 var keyPressed = evt.which || evt.keyCode;
			     
			      if(keyPressed == 40){
				  	document.getElementById("lister").style.display='';
				    document.getElementById("seriesTypeList").focus();
			      }
			      if(document.getElementById("seriesTypeList").value=="0" ||document.getElementById("seriesTypeList").value==""||keyPressed == 0){
				    document.getElementById("lister").style.display='';
				  }
				  if(keyPressed == 27){
			        document.getElementById("lister").style.display="none";
			       }
		      }
      
		      function hideList() {
		        document.getElementById("lister").style.display="none";	
		      }
		      function changeList() {
        		if (document.getElementById("lister").style.display=="none")
          			showList();
        		else
			         hideList();
      		  }
      		  
      		  function getteams(){
      		  	
      		  	var seriesId = document.getElementById("seriesTypeList").value;
      		  	var seasonId = document.getElementById("cmbsession").value;
				alert(seriesId)
				var str = document.getElementById("seriesTypeList").value.split("~");
				var seriesid = str[0]
				var seriesname = str[1]
				alert(seasonId)				
				if(document.getElementById("cmbsession").value == 0){
					alert("Please select Season");
					return false;
				}else{
					//alert("in else")
					var seasonId = document.getElementById("cmbsession").value;					
					xmlHttp=GetXmlHttpObject();
					if (xmlHttp==null){
						alert ("Browser does not support HTTP Request");
				        return;
					}else{
						var url ="/cims/jsp/concise/GetTeamsList.jsp?seasonId="+seasonId+"&seriesId="+seriesid;
						document.getElementById("teamsresponse").style.display='';
						document.getElementById("tempTeamsDiv").style.display='none';
						//xmlHttp.onreadystatechange=stChgLevelResponse;
						xmlHttp.open("post",url,false);
					   	xmlHttp.send(null);	
					   	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){
							var responseResult= xmlHttp.responseText;
							//alert(responseResult)
							document.getElementById("teamsresponse").innerHTML = responseResult;
						}	   	
					}
				}							
      		  }	

	</script>
	<link href="../../css/concise.css" rel="stylesheet" type="text/css" />

    </head>
    <body >      
       <form name="frmconciseteamscoredetail" id="frmconciseteamscoredetail" method="POST">
         <div >
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	          <tr>
	            <td width="599" height="115"><img src="../../images/ConciseLoginLogo.jpg" width="599" height="115" /></td>
	            <td width="174" height="115"><img src="../../images/ConciseTop2.jpg" width="174" height="115" /></td>
	            <td width="211" height="115"><img src="../../images/ConciseTop3.jpg" width="211" height="115" /></td>
	          </tr>
	        </table>    
			</div>         
         <div style="width:100%;">           
           <table width="100%" cellpadding="2" cellspacing="1" class="table">
           <tr>
			<td>
			<table width="100%" border="0">
		  		<tr class="commityRowAlt">
<%--					<td>&nbsp;</td>--%>
					<td width="5%" align="left" nowrap="nowrap"><FONT size="3"><b>Season :</b></font></td>
					<td width="10%" nowrap="nowrap" style="padding-right: 10px;"><select id="cmbsession" name="cmbsession">
	<%--					<option value="0">---Select---</option>--%>
						<%    if(crsObjMtWiseUmpSelfAssest!=null){
	                            while(crsObjMtWiseUmpSelfAssest.next()){
	%>							<option
									value='<%=crsObjMtWiseUmpSelfAssest.getString("id")%>'>
									<%=crsObjMtWiseUmpSelfAssest.getString("name")%></option>
	<%                          }// end of while
	                          }// end of if
	%>
					</select></td>
					<td width="25%" nowrap="nowrap" ><FONT size="3"><b>Series : (Enter letter to search)</b></font></td>
					<td width="20%" nowrap="nowrap"> <input class="inputsearch" type="text"
						name="seriesName" id="seriesName" size="30"
						onKeyUp="javascript:obj1.bldUpdate(event);" autocomplete="OFF"
						value="<%=series_name%>"> <input class="inputsearch" id="show"
						type="button" value="V" onClick="changeList();">
					<div align="left" style="width:250px">
					<div id="lister" style="display:none;position:absolute;z-index:+10;">
					<select class="inputsearch" style="width:6.5cm" id="seriesTypeList"
						name="seriesTypeList" size="5" onclick="update(event)"
						onkeypress="update(event)" onchange="getteams()">
	<%					while (crsObjSeriesTypeRecord.next()) {
	%>					<option value='<%=crsObjSeriesTypeRecord.getString("id")+"~"+crsObjSeriesTypeRecord.getString("name")%>'><%=crsObjSeriesTypeRecord.getString("name")%></option>
	<%	            }
	%>				</select></div>
					</div>
					</td>
					<td width="5%" align="left"  nowrap="nowrap"><FONT size="3"><b>Teams :</b></font></td>
					<td width="20%">
		       			<div id="tempTeamsDiv">
		       			<select>
		       				<option>-Select-</option>
		       			</select>
		       			</div>
			       		<div id="teamsresponse" style="display: none;">  												
						</div>
					</td>									
					<td><input type="button" name="button" value="Search" onclick="validate();"> </td>
				</tr>
			</table>
			</td>
		   </tr>
           </table>
           </div>
           <div></div><br>
         <%  if(crsObjMtWiseTeamPlayerData != null){%>
    		<div style="height: 300px;">
           	 <table width=100% border="1" class="contenttable">			
				<tr class="commityRow">
					<td align=center nowrap style="font-weight: bold;" ><font size=2 >Players</font></b></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>M</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Innings</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>N O</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Runs</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Boundries</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Sixes</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>H S</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Avg</font></td>
					<td nowrap align=center style="font-weight: bold;" ><font size=2>Balls</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>S/R</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>100's</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>50's</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>0's</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Cts</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Sts</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Balls</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Mdn</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Runs</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Wkts</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>Avg</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>S/R</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>E/R</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>5w</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>10w</font></td>
					<td nowrap align=center style="font-weight: bold;"><font size=2>B/B</font></td></b>					
				</tr>
				<tr class="commityRowAlt"> <td nowrap align="left" style="font-weight: bold;" colspan="25"><font size=2><%=strteamArr[1]%></font></td></b></tr>
				<% try{//vparam.add(strserArr[0]);//strteamArr[0])								
				while (crsObjMtWiseTeamPlayerData.next()){
				if (counter % 2 != 0) {%>
		<TR class="commityRow">
<%					} else {%>
		<tr class="commityRowAlt">
<%					}%>				   
					<td align=left nowrap <%=counter++%> style="padding-left: 5px;"><font size=2><%=crsObjMtWiseTeamPlayerData.getString("playername")%></font></b></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2><%=crsObjMtWiseTeamPlayerData.getString("Matches")%></font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2><%=crsObjMtWiseTeamPlayerData.getString("Innings")%></font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2><%=crsObjMtWiseTeamPlayerData.getString("NO")%></font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2><%=crsObjMtWiseTeamPlayerData.getString("Runs")%></font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2><%=crsObjMtWiseTeamPlayerData.getString("Boundaries")%></font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2><%=crsObjMtWiseTeamPlayerData.getString("Sixes")%></font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2><%=crsObjMtWiseTeamPlayerData.getString("Balls")%></font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;"><font size=2>0</font></td>
					<td nowrap align=right style="padding-right: 5px;" ><font size=2>0</font></td>						
				</tr>				   
				<%   }
				}catch(Exception e)	{
					e.printStackTrace();
				}
				%>
			</table>	
           </div>		
    	<%	}else{%>
    		<br><br><br><br><br>
    	<%}%>
           
           <div id="footerDiv">
			<table style="100%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
			  <tr>
			    <td><table width="20%" border="0" cellspacing="0" cellpadding="0">
			      <tr>
			        <td><img src="../../images/SiteFooter1.jpg" width="230" height="122" /></td>
			        <td><img src="../../images/SiteFooter2.jpg" width="240" height="122" /></td>
			        <td><img src="../../images/SiteFooter3.jpg" width="260" height="122" /></td>
			        <td><a href="http://www.paramatrix.co.in"><img src="../../images/SiteFooter4.jpg"  width="250" height="122" border="0" /></a></td>
			      </tr>
			    </table></td>
			  </tr>
			</table>
			</div>             
           <input type="hidden" name="hidId" id="hidId" value="0">
           <input type="hidden" name="reportid" id="reportid" value="">    
           <input type="hidden" name="sessionVal" id="sessionVal" value="">
           <input type="hidden" name="hidSeriesType" id="hidSeriesType"value="" /> 
		   <input type="hidden" id="hdseriesTypeList" name="hdseriesTypeList" value="" /> 
		   <input type="hidden" id="hdseries" name="hdseries" value="" />    
           <script type="text/javascript">
			onLoad();
		   </script>	
		   
        </form>
        
    </body>
</html>
