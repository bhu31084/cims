/*modifyed Date:12-09-2008*/
function displayPopup(mainDiv, popup) {
    try {
    	var scrolledX, scrolledY;
        if (self.pageYOffset) {
            scrolledX = self.pageXOffset;
            scrolledY = self.pageYOffset;
        } else if (document.documentElement && document.documentElement.scrollTop) {
            scrolledX = document.documentElement.scrollLeft;
            scrolledY = document.documentElement.scrollTop;
        } else if (document.body) {
            scrolledX = document.body.scrollLeft;
            scrolledY = document.body.scrollTop;
        }
        var centerX, centerY;
        if (self.innerHeight) {
            centerX = self.innerWidth;
            centerY = self.innerHeight;
        } else if (document.documentElement && document.documentElement.clientHeight) {
            centerX = document.documentElement.clientWidth;
            centerY = document.documentElement.clientHeight;
        } else if (document.body) {
            centerX = document.body.clientWidth;
            centerY = document.body.clientHeight;
        }
        
        var backgroundDiv = $(mainDiv);
        backgroundDiv.style.display = "block";
        var popupDiv = $(popup);
       	popupDiv.style.left = 50+"px"//scrolledX + (centerX - parseInt((popupDiv.style.width).replace("px","")) ) / 2;
        popupDiv.style.top = 50+"px"//scrolledY + (centerY - parseInt((popupDiv.style.height).replace("px","")) ) / 2;
        //popupDiv.style.left = scrolledX + (centerX - 450 ) / 2+"px";
    	//popupDiv.style.top = scrolledY + (centerY - 200 ) / 2+"px";
    	popupDiv.style.display = "block";
        return true;

    } catch(err) {
        alert(err.description + 'commonpopup.js.displayPopup()');
    }
}

function closeDisplayPopup( backgroundDiv, popup ){
	document.getElementById(backgroundDiv).style.display = "none";
    document.getElementById(popup).style.display = "none";

}

/*function back(mainDiv, subDiv) {
    document.getElementById(mainDiv).style.display = "none";
    document.getElementById(subDiv).style.display = "none";
}*/
		
		