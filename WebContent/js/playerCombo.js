
var lenextra = 0;
function addToCombo(fromId_hd,fromId_disp,toId){
try{
	var MAXPLAYERS = 16;
	var parObj= document.getElementById(fromId_disp);
	var parObjHidObj= document.getElementById(fromId_hd);
	var strPara = "";
	var arrindex="";
	var childObj= document.getElementById(toId);
	var captainObj = document.getElementById('cmbCaptain');
	var wkObj = document.getElementById('cmbWicketKeeper');
	var extramanObj = document.getElementById('cmb12thMan');
	var extrasObj = document.getElementById('lbChoosePlayersFromExtra');
	var eleObjArr=document.getElementById(fromId_disp).options
	var eleObjdublicateArr=document.getElementById(fromId_disp).options
	var eleObjArr1=document.getElementById(toId).options;
	var j = eleObjArr1.length;	
	var isMax = false;
	var selectedlength = 0;
	for(var i=0;i< eleObjArr.length;i++){
		if(eleObjArr[i].selected){
				if(j > MAXPLAYERS-1){							
					isMax = true;
				}else{	
				if(!checkDuplicateOptions(fromId_hd,toId)){
					j=j+1;	
				//	strPara =strPara + eleObjArr[i].value + ",";
					selectedlength= selectedlength + 1;
					childObj.options[childObj.options.length]= new Option(eleObjArr[i].text,eleObjArr[i].value)
					childObj.options.selectedIndex = childObj.options.length - 1;
					captainObj.options[captainObj.options.length]= new Option(eleObjArr[i].text,eleObjArr[i].value)
					captainObj.options.selectedIndex = 0;//captainObj.options.length - 1;
					wkObj.options[wkObj.options.length]= new Option(eleObjArr[i].text,eleObjArr[i].value)
					wkObj.options.selectedIndex = 0;//wkObj.options.length - 1;
					extramanObj.options[extramanObj.options.length]= new Option(eleObjArr[i].text,eleObjArr[i].value)
					extramanObj.options.selectedIndex = 0;//wkObj.options.length - 1;
					extrasObj.options[extrasObj.options.length]= new Option(eleObjArr[i].text,eleObjArr[i].value)
					extrasObj.options.selectedIndex = 0;
					arrindex = arrindex + i +"~";
				  }
				}//end of else	  
	        }
		
	        	document.getElementById('btnNext').disabled=false;
		
	  eleObjArr[i].selected =false;
		
	}
		lenextra = document.getElementById('cmbCaptain').options.length;
		document.getElementById('txtselectedpl').value = lenextra;
			//document.getElementById('txtavailable').value = document.getElementById('lbChoosePlayersFrom').options.length;			
			
			//alert(document.getElementById('txtselectedpl').value);
	/*if(j>12 || j<MAXPLAYERS){
	 	alert("Please select "+(MAXPLAYERS-j) +" players,more!" );
	}*/
	if(isMax){
		alert("You can select maximum "+MAXPLAYERS+" players"); 
	}
	/*if(j >=12) { 
	//== MAXPLAYERS){
		document.getElementById('btnNext').disabled=false;
	}*/
	var index = arrindex.split("~");
	var flag = false;
	var j=1;
	for(var i=0;i<index.length-1;i++){
		var indexval = index[i];
		if (i!=0){
			var val =parseInt(indexval) - parseInt(j);
			//document.getElementById(fromId_hd).options.remove(val);//dipti 18 05 2009
			document.getElementById(fromId_hd).remove(val);//dipti 18 05 2009
			j=parseInt(j)+parseInt(1);
		}else{
			var val =parseInt(indexval) 
			//document.getElementById(fromId_hd).options.remove(val);//dipti 18 05 2009
			document.getElementById(fromId_hd).remove(val);//dipti 18 05 2009
		}	
	}
	// beforeRemoveOptionsextra("lbChoosePlayersFrom");
 }catch(err){
	alert('err in palyerCombo.js.addToCombo() '+err.description)
 }
}
function fillCombo (fromId_hd,fromId_disp,toId){
	try{
		var eleObjArr=document.getElementById(fromId_disp).options
		var childObj= document.getElementById(toId);
		if(this.checkDuplicateOptions(fromId_hd,toId)){
			return false;
		}else{
			for(var i=0;i< eleObjArr.length;i++){
			
				if(eleObjArr[i].selected){
					childObj.options[childObj.options.length]= Option(eleObjArr[i].text,eleObjArr[i].value)
					childObj.options.selectedIndex = childObj.options.length-1;	
				}	
			 }
		 }
	}catch(err){
		alert('err in fillcmbo.js.addToCombo() '+err.description)
	}
}
function checkDuplicateOptions(fromId_hd,toId){
	try{
		var childObj= document.getElementById(toId);
		var parObjHidObj= document.getElementById(fromId_hd);
		if(childObj.options.length == 0){
			return false;
		}else{
			var childObjArr = childObj.options;
			for(var i=0;i<childObjArr.length;i++){
				if( childObjArr[i].value == document.getElementById(fromId_hd).value)return true;
			}
		}
		return false;
	}catch(err){
		alert('err in TrainingSheduleProgram.jsp.checkDuplicateOptions() '+err.description)
	}
}
function beforeRemoveOptions(fromId){
 	try{
 		
		var tempArrObj=new Array();
		var eleObjArr=document.getElementById(fromId).options;
		
		for(var i=0;i<eleObjArr.length;i++){
			if(eleObjArr[i].selected){
				tempArrObj[tempArrObj.length]=eleObjArr[i];
				var leng =document.getElementById("lbChoosePlayersFromExtra").options 
				var lengPlayersExtra = document.getElementById("lbSelectedPlayersExtra").options 
				for(var j=0;j<leng.length;j++ ){
					if(eleObjArr[i].value==leng[j].value){
						//document.getElementById("lbChoosePlayersFromExtra").options.remove(j);//dipti 18 05 2009
						document.getElementById("lbChoosePlayersFromExtra").remove(j);//dipti 18 05 2009
					}
				}
				for(var k=0;k<lengPlayersExtra.length;k++ ){
					if(eleObjArr[i].value==lengPlayersExtra[k].value){
//						document.getElementById("lbSelectedPlayersExtra").options.remove(k);//dipti 18 05 2009
						document.getElementById("lbSelectedPlayersExtra").remove(k);//dipti 18 05 2009
					}
				}		
			}
		}
		for(var i=0;i<tempArrObj.length;i++){
			removeOptions(tempArrObj[i],fromId);
			removeOptions(tempArrObj[i],'cmbCaptain');
			removeOptions(tempArrObj[i],'cmbWicketKeeper');
			removeOptions(tempArrObj[i],'cmb12thMan');
			//removeOptions(tempArrObj[i],'lbChoosePlayersFromExtra');
		}
		if(fromId=="lbSelectedPlayers"){
			lenextra = document.getElementById('cmbCaptain').options.length;
 			document.getElementById('txtselectedpl').value = lenextra;
		}
		
	  }catch(err){
		alert('err in beforeRemoveOptions.js.beforeAddToCombo() '+err.description)
		}
}
function beforeRemoveOptionsextra(fromId){
 	try{
		var tempArrObj=new Array();
		var eleObjArr=document.getElementById(fromId).options
		for(var i=0;i<eleObjArr.length;i++){
			if(eleObjArr[i].selected){
				tempArrObj[tempArrObj.length]=eleObjArr[i];
			}
		}
		for(var i=0;i<tempArrObj.length;i++){
			removeOptions(tempArrObj[i],fromId);
			
		}
		//document.getElementById('txtselectedpl').value =tempArrObj.length;
		//alert(tempArrObj.length);
	  }catch(err){
		alert('err in TrainingSheduleProgram.jsp.beforeAddToCombo() '+err.description)
		}
}
function selectedRemoveOptions(fromId){
 	try{
		var tempArrObj=new Array();
		var eleObjArr=document.getElementById("lbSelectedPlayers").options
		for(var i=0;i<leng;i++){
			tempArrObj[tempArrObj.length]=eleObjArr[i];
		}
		for(var i=tempArrObj.length;i>=0;i--){
			removeOptions(tempArrObj[i],fromId);
		}
	}catch(err){
	 }
}

function selectedextraRemoveOptions(fromId,leng){
 	try{
		var tempArrObj=new Array();
		var eleObjArr=document.getElementById("lbSelectedPlayersExtra").options
		for(var i=0;i<leng;i++){
			tempArrObj[tempArrObj.length]=eleObjArr[i];
		}
		for(var i=tempArrObj.length;i>=0;i--){
			removeOptions(tempArrObj[i],fromId);
		}
	}catch(err){
	 }
}
function removeOptions(selElementObj,fromId){
	try{
		//document.getElementById(fromId).options.remove(selElementObj.index);//dipti 18 05 2009
		document.getElementById(fromId).remove(selElementObj.index);//dipti 18 05 2009
	}catch(err){
	}
}
function addToComboextra(fromId_hd,fromId_disp,toId){
try{
	var MAXPLAYERS = 0;
	var parObj= document.getElementById(fromId_disp);	
	
	if(lenextra == 12){	
		alert("You cannot select extra players as Team size is 12,only!"); 				
	}else if(lenextra == 13){	
		MAXPLAYERS = 1; 				
	}else if(lenextra == 14){	
		MAXPLAYERS = 2; 				
	}else if(lenextra == 15){	
		MAXPLAYERS = 3; 				
	}else if(lenextra == 16){	
		MAXPLAYERS = 4; 		
	}else{
	alert("You are required to select atleast 12 players"); 
	}
	var parObjHidObj= document.getElementById(fromId_hd);			
	var strPara = "";
	var childObj= document.getElementById(toId);
	var extrasObj = document.getElementById('lbChoosePlayersFromExtra');
	var eleObjArr=document.getElementById(fromId_disp).options
	var eleObjArr1=document.getElementById(toId).options;
	var j = eleObjArr1.length;	
	var isMax = false;							
	var selectedlength = 0;
	var arrindex = "";
	for(var i=0;i< eleObjArr.length;i++){
		if(eleObjArr[i].selected){
			if(j > MAXPLAYERS-1){							
				isMax = true;
			}else{				
				if(!checkDuplicateOptions(fromId_hd,toId)){
					j=j+1;	
				//	strPara =strPara + eleObjArr[i].value + ",";
					selectedlength= selectedlength + 1;
					childObj.options[childObj.options.length]= new Option(eleObjArr[i].text,eleObjArr[i].value)
					childObj.options.selectedIndex = childObj.options.length - 1;
					//extrasObj.options[extrasObj.options.length]= new Option(eleObjArr[i].text,eleObjArr[i].value)
					//extrasObj.options.selectedIndex = 0;
					arrindex = arrindex + i +"~";
				  }
			  }
	      }
		  eleObjArr[i].selected =false;			
	}
	
	/*if(j<MAXPLAYERS){
	 	alert("Please select "+(MAXPLAYERS-j) +" players,more!" );
	}*/
	if(isMax== 'true'){
		alert("You can select maximum "+MAXPLAYERS+" players"); 
	}else if(isMax == 'false'){
		alert("You can not select more extra players"); 
	}
	/*if(j == MAXPLAYERS){		
		document.getElementById('btnNext').disabled=false;
	}*/
	var index = arrindex.split("~");
	var j=1;
	for(var i=0;i<index.length-1;i++){
		var indexval = index[i];
		if (i!=0){
			var val =parseInt(indexval) - parseInt(j);
			//document.getElementById(fromId_hd).options.remove(val);//dipti 18 05 2009
			document.getElementById(fromId_hd).remove(val);//dipti 18 05 2009
			j=parseInt(j)+parseInt(1);
		}else{
			var val =parseInt(indexval) 
			//document.getElementById(fromId_hd).options.remove(val);//dipti 18 05 2009
			document.getElementById(fromId_hd).remove(val);
		}	
	}
	//beforeRemoveOptionsextra("lbChoosePlayersFromExtra");
 }catch(err){
	alert('err in playercombo.addToComboextra() '+err.description)
 }
}