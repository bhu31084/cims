/*modifyed Date:12-09-2008*/
var cmb = new fillcmbo();

function fillcmbo() { 

	this.addToCombo = function(fromId_hd,fromId_disp,toId){
		try{
			var childObj= $(toId);
			if(this.checkDuplicateOptions(fromId_hd,toId)){
				return false;
			}else{
				childObj.options[childObj.options.length]= new Option(fromId_disp,fromId_hd)
				childObj.options.selectedIndex = childObj.options.length-1;
			}
		}catch(err){
			alert('err in fillcmbo.js.addToCombo() '+err.description)
		}
  	}

	this.checkDuplicateOptions =function(fromId_hd,toId){
		try{
			var childObj= $(toId);
			if(childObj.options.length == 1){
				return false;
			}else{
				var childObjArr = childObj.options;
				for(var i=0;i<childObjArr.length;i++){
					if( childObjArr[i].value == fromId_hd)return true;
				}
			}
			return false;
		}catch(err){
			alert('err in fillcmbo.js..checkDuplicateOptions() '+err.description)
		}
	}

    this.beforeRemoveOptions = function(fromId){
  		try{
			var tempArrObj=new Array();
			var eleObjArr=$(fromId).options.selectedIndex;
			this.removeOptions(eleObjArr,fromId);
  		}catch(err){
			alert('err in fillcmbo.js.beforeAddToCombo() '+err.description)
  		}
	}

    this.removeOptions = function(selElementObj,fromId){
	  	try{
			if($(fromId).options.length == 1 || selElementObj.value == ''){
				return;
			}else{
				//$(fromId).options.remove(selElementObj);
				$(fromId).remove(selElementObj);
			}
		}catch(err){
			alert('err in fillcmbo.js.removeOptions() '+err.description)
		}
	}
}	