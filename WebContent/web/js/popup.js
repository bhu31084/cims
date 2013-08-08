/*modifyed Date:12-09-2008*/
function showPopup(mainDiv, popup) {
   // alert("1")
    try {
        var scrolledX, scrolledY;
       //  alert("11")
        if (self.pageYOffset) {
            scrolledX = self.pageXOffset;
            scrolledY = self.pageYOffset;
           //  alert("21")
        } else if (document.documentElement && document.documentElement.scrollTop) {
            scrolledX = document.documentElement.scrollLeft;
            scrolledY = document.documentElement.scrollTop;
           //  alert("31")
        } else if (document.body) {
            scrolledX = document.body.scrollLeft;
            scrolledY = document.body.scrollTop;
           //  alert("41")
        }
        var centerX, centerY;
        // alert("51")
        if (self.innerHeight) {
            centerX = self.innerWidth;
            centerY = self.innerHeight;
           //  alert("61")
        } else if (document.documentElement && document.documentElement.clientHeight) {
            centerX = document.documentElement.clientWidth;
            centerY = document.documentElement.clientHeight;
          //   alert("71")
        } else if (document.body) {
            centerX = document.body.clientWidth;
            centerY = document.body.clientHeight;
          //   alert("81")
        }
        var backgroundDiv = $(mainDiv);
        backgroundDiv.style.display = "block";
		// alert("12")
        var popupDiv = $(popup);

       	popupDiv.style.left = 50//scrolledX + (centerX - parseInt((popupDiv.style.width).replace("px","")) ) / 2;
        popupDiv.style.top = 50//scrolledY + (centerY - parseInt((popupDiv.style.height).replace("px","")) ) / 2;
		/*if(popup=="BowlList"){
			popupDiv.style.left = scrolledX + (centerX - 450 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY - 450 ) / 2;
    	   //  alert("13")
		}else if(popup=="wagondiv"){
			popupDiv.style.left = scrolledX + (centerX - 550 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY - 650 ) / 2;
    	  //   alert("14")
		}else if(popup=="totallandmark"  || popup=="batsmanlandmark" || popup=="partnershiplandmark"){
			/*popupDiv.style.left = scrolledX + (centerX - 550 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY + 50 ) / 2;*/
		/* popupDiv.style.left = scrolledX + (centerX - 450 ) / 2;
	    	 popupDiv.style.top = scrolledY + (centerY - 200 ) / 2;
	    	//  alert("15")
		}else if(popup=="selectedOverBallsDiv"){
			popupDiv.style.left = scrolledX + (centerX - 930 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY -650) / 2;
    	    // alert("16")
		}else if(popup=="updateIntervalDiv"){
			popupDiv.style.left = scrolledX + (centerX - 750 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY -650) / 2;
    	  //   alert("17")
		}else if(popup=="updateWicketBallTimeDiv"){
			popupDiv.style.left = scrolledX + (centerX - 750 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY-600) / 2;
    	   //  alert("18")
		}else if(popup=="updatePenaltyDiv"){
			popupDiv.style.left = scrolledX + (centerX - 750 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY-600) / 2;
    	   //  alert("19")
		}else if(popup=="updateRunsDiv"){
			popupDiv.style.left = scrolledX + (centerX - 930 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY+3) / 2;
    	  //   alert("10")
		}else if(popup=="offlinediv" ||popup=="bowlerlandmark"){
			popupDiv.style.left = scrolledX + (centerX - 450 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY + 70) / 2;
    	  //   alert("121")
		}else if( popup=="BatList") {
			popupDiv.style.left = scrolledX + (centerX - 450 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY + 190) / 2;
    	   //  alert("221")
		}else if(popup=="updateWicketDiv"){
			popupDiv.style.left = scrolledX + (centerX - 930) / 2;
    	    popupDiv.style.top = scrolledY + (centerY +350) / 2;
    	   //  alert("321")
		}else if(popup=="addBallDiv"){
			popupDiv.style.left = scrolledX + (centerX - 930 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY+3) / 2;
    	    // alert("421")
		}else if(popup=="updateInningsTimeDiv"){
			popupDiv.style.left = scrolledX + (centerX - 750 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY-600) / 2;
    	    // alert("521")
		}else{*/
	        popupDiv.style.left = scrolledX + (centerX - 300 ) / 2;
    	    popupDiv.style.top = scrolledY + (centerY - 200 ) / 2;
    	    // alert("621")
    	/* }   */
        popupDiv.style.display = "block";
        // alert("721")
        return true;
        // alert("821")

    } catch(err) {
        alert(err.description + 'Popup.js.myPopup()');
    }
}

function closePopup( backgroundDiv, popup ){
	document.getElementById(backgroundDiv).style.display = "none";
    document.getElementById(popup).style.display = "none";
   /* var offlinediv = document.getElementById("offlinediv").style.display;
    var selectpreviousinning = document.getElementById("selectpreviousinning").style.display;
    var linkintervaldiv = document.getElementById("linkintervaldiv").style.display;
    var updateRunsDiv = document.getElementById("updateRunsDiv").style.display;
    var selectedOverBallsDiv = document.getElementById("selectedOverBallsDiv").style.display;
    var moreundo = document.getElementById("moreundo").style.display;
    var endmatchdiv = document.getElementById("endmatchdiv").style.display;
    var modifiedtime = document.getElementById("modifiedtime").style.display;
    var wagondiv = document.getElementById("wagondiv").style.display;
    var partnershiplandmark = document.getElementById("partnershiplandmark").style.display;
	var batsmanlandmark = document.getElementById("batsmanlandmark").style.display;
	var totallandmark = document.getElementById("totallandmark").style.display;
	var retireRemarkList = document.getElementById("retireRemarkList").style.display;
	var swapBowlerRemarkList = document.getElementById("swapBowlerRemarkList").style.display;
	var penaltyremarkList = document.getElementById("penaltyremarkList").style.display;
	var remarkList = document.getElementById("remarkList").style.display;
	var BowlList = document.getElementById("BowlList").style.display;
	var BatList = document.getElementById("BatList").style.display;
	var PopupDiv = document.getElementById("PopupDiv").style.display;
	var pbar = document.getElementById("pbar").style.display;
	var bowler = document.getElementById("bowlerlandmark").style.display;
	
	if(offlinediv=="block" || selectpreviousinning=="block"  || linkintervaldiv=="block"  || updateRunsDiv=="block"  || selectedOverBallsDiv=="block"  ||
      moreundo=="block" || endmatchdiv=="block"  || modifiedtime=="block"  || wagondiv=="block"  || partnershiplandmark=="block"  || batsmanlandmark=="block" ||
      totallandmark=="block"  || retireRemarkList=="block"  || swapBowlerRemarkList=="block"  || penaltyremarkList=="block"  || remarkList=="block"  || BowlList=="block"  ||
      BatList=="block"  || PopupDiv=="block"  || pbar=="block" || bowler=="block"){
      	var backgroundDiv = $(backgroundDiv);
        backgroundDiv.style.display = "block";
    } else{
    	 document.getElementById(backgroundDiv).style.display = "none";
    	document.getElementById(popup).style.display = "none";
    }   */
    return true;
}

/*function back(mainDiv, subDiv) {
    document.getElementById(mainDiv).style.display = "none";
    document.getElementById(subDiv).style.display = "none";
}*/
		
		