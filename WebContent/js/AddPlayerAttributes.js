
function addToCombo(fromId_hd,fromId_disp,toId){	
	try{
		var arrindex="";
		var selectedlength = 0;
		var parObj= document.getElementById(fromId_disp);
		var parObjHidObj= document.getElementById(fromId_hd);
		var childObj= document.getElementById(toId);
		var eleObjArr=document.getElementById(fromId_disp).options
		var eleObjdublicateArr=document.getElementById(fromId_disp).options
		var eleObjArr1=document.getElementById(toId).options;
		var j = eleObjArr1.length;	
		
		for(var i=0;i< eleObjArr.length;i++){
			if(eleObjArr[i].selected){
				if(!checkDuplicateOptions(fromId_hd,toId)){					
					childObj.options[childObj.options.length]= new Option(eleObjArr[i].text,eleObjArr[i].value)
					childObj.options.selectedIndex = childObj.options.length - 1;
					arrindex = arrindex + i +"~";
				//	selectedRemoveOptions(fromId_hd)
				}
			}
			 eleObjArr[i].selected =false;
		}
		 var index = arrindex.split("~");
		  	 var flag = false;
		 	 var j=1;
			 for(var i=0;i<index.length-1;i++){
			 var indexval = index[i];
				if (i!=0){
					var val =parseInt(indexval) - parseInt(j);
					document.getElementById(fromId_hd).options.remove(val);
					j = parseInt(j)+parseInt(1);
				}else{
					var val =parseInt(indexval) 
					document.getElementById(fromId_hd).options.remove(val);
				}	
			}	 		
	 }catch(err){
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
				if( childObjArr[i].value == document.getElementById(fromId_hd).value)
				return true;
			}
		}
		return false;
	}catch(err){
		alert('err in checkDuplicateOptions() '+err.description)
	}
}
