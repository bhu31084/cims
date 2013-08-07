//if (document.domain.match("cricinfo.com"))
//{
//	document.domain = "cricinfo.com";
//	}
//else if (document.domain.match("cricinfo.org"))
//{
//	document.domain = "cricinfo.org";
//	}

function openS(URL, WindowName) {
        window.open(URL, WindowName, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,titlebar=0,width=500,height=350');

        if (openS.opener == null)
		openS.opener = window;

        openS.opener.name = "opener";
        }

function openE(URL, WindowName) {
  window.open(URL, WindowName, 'left=0,top=0,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,titlebar=0,width=1021,height=720');
        if (openE.opener == null)
		openE.opener = window;
        openE.opener.name = "opener";
        }

function openDesktop(URL, WindowName)
	{
	window.open(URL, WindowName, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=310,height=300,left=0,top=0');

        if (openDesktop.opener == null)
		openDesktop.opener = window;

        openDesktop.opener.name = "opener";
	}
	
function openDesktopInd(URL, WindowName)
	{
	window.open(URL, WindowName, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=529,height=655,left=0,top=0');

	if (openDesktopInd.opener == null)
		openDesktopInd.opener = window;

        openDesktopInd.opener.name = "opener";
	}
	
function openDesktopSl(URL, WindowName)
	{
	window.open(URL, WindowName, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=494,height=315,left=0,top=0');

	if (openDesktopSl.opener == null)
		openDesktopSl.opener = window;

        openDesktopSl.opener.name = "opener";
	}
	
function openSlideShow(URL, WindowName)
	{
	window.open(URL, WindowName, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=825,height=650,left=0,top=0');

        if (openSlideShow.opener == null)
		openSlideShow.opener = window;

        openSlideShow.opener.name = "opener";
	}

// clears the default text in a <input type="text"> with onFocus="clearInputText(this)"
function clearInputText(theText) 
	{
	if (theText.value == theText.defaultValue)
		{
		theText.value = ""
		}
	}

function kill_frames()
	{
	if (window.frames)
		{
		if (parent != self)
			{
			top.location.href = self.location.href;
			}
		}
	return;
	}

function bookmarksite(title,url) {
	if (window.sidebar) // firefox
		window.sidebar.addPanel(title, url, "");
	else if(window.opera && window.print){ // opera
		var elem = document.createElement('a');
		elem.setAttribute('href',url);
		elem.setAttribute('title',title);
		elem.setAttribute('rel','sidebar');
		elem.click();
	}
	else if(document.all)// ie
		window.external.AddFavorite(url, title);
}

function addBookmark(title,url) {
if (window.sidebar) {
window.sidebar.addPanel(title, url,"");
} else if( document.all ) {
window.external.AddFavorite( url, title);
} else if( window.opera && window.print ) {
return true;
}
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
	window.open(theURL,winName,features);
}

function getCookieVal (offset) {
	var endstr = document.cookie.indexOf (";", offset);
	if (endstr == -1)
	endstr = document.cookie.length;
	return unescape(document.cookie.substring(offset, endstr));
}

function GetCookie (name) {
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while (i < clen)
		{
		var j = i + alen;
		if (document.cookie.substring(i, j) == arg)
		return getCookieVal (j);
		i = document.cookie.indexOf(" ", i) + 1;
		if (i == 0) break;
		}
	return null;
}

function hex2dec(strVal)
	{
	// where strVal is a string
	// parseInt('ff',16) == 255
	return parseInt(strVal,16);
	}

function Chr(CharCode)
	{
	return String.fromCharCode(CharCode);
	}

var domaincookie=GetCookie("CI_CQ_data");
if (domaincookie != null) 
	{
	var char1 = domaincookie.substring(0,4);
	var char2 = domaincookie.substring(4,8);
	char1 = hex2dec(char1) % 255;
	char2 = hex2dec(char2) % 255;
	var cqanswer = Chr(char1)+Chr(char2);
	} 
else 
	{
	var cqanswer ="";
	}

function toggleBoxTab(prefix, c, bg1, bg2)
	{
	var cells = document.getElementsByTagName('th');

	for(i=0; i<cells.length; i++)
		{
		if(cells[i].id.indexOf(prefix) == 0)
			{
			if(cells[i].id == prefix+c)
				{
				cells[i].style.backgroundColor=bg1
				}
			else
				{
				cells[i].style.backgroundColor=bg2
				}
			}
		}
	}

function showBoxDiv(prefix, vid)
	{
	// vid gets displayed, anything beginning with prefix gets hidden

	var divs = document.getElementsByTagName('div');

	for(i=0; i<divs.length; i++)
		{
		if(divs[i].id.indexOf(prefix) == 0)
			{
			if(divs[i].id == vid)
				{
				if (document.getElementById) // DOM3 = IE5, NS6
					{
					divs[i].style.display = 'block';
					divs[i].style.visibility = 'visible';
					divs[i].style.height = '';
					}
				else if (document.layers) // Netscape 4
					{
					document.layers[divs[i]].display = 'visible';
					}
				else // IE 4
					{
					document.all.divs[i].visibility = 'visible';
					}
				}
			else if (document.getElementById)
				{
				divs[i].style.display = 'none';
				divs[i].style.visibility = 'hidden';
				divs[i].style.height = '0px';
				}
			else if (document.layers)
				{
				document.divs[i].visibility = 'hidden';
				}
			else // IE 4
				{
				document.all.divs[i].visibility = 'hidden';
				}
			}
		}
	}

function disableSelect(prefix, vid)
	{
	// vid gets enabled, anything beginning with prefix gets disabled

	var selects = document.getElementsByTagName('select');

	for(i=0; i<selects.length; i++)
		{
		if(selects[i].id.indexOf(prefix) == 0)
			{
			if(selects[i].id == vid)
				{
				selects[i].disabled = false;
				}
			else
				{
				selects[i].disabled = true;
				}
			}
		}
	}

function disableDivInputs(prefix, vid)
	{
	// all inputs within div=vid get enabled, anything within div beginning with prefix gets disabled

	var divs = document.getElementsByTagName('div');

	for(i=0; i<divs.length; i++)
		{
		if(divs[i].id.indexOf(prefix) == 0)
			{
			var inputs = divs[i].getElementsByTagName('input');

			for(j=0; j<inputs.length; j++)
				{
				if(divs[i].id == vid)
					{
					inputs[j].disabled = false;
					}
				else
					{
					inputs[j].disabled = true;
					}
				}
			}
		}
	}

/***********************************************
* IFrame SSI script II- © Dynamic Drive DHTML code library (http://www.dynamicdrive.com)
* Visit DynamicDrive.com for hundreds of original DHTML scripts
* This notice must stay intact for legal use
***********************************************/

//Input the IDs of the IFRAMES you wish to dynamically resize to match its content height:
//Separate each ID with a comma. Examples: ["myframe1", "myframe2"] or ["myframe"] or [] for none:
var iframeids=["comments", "livescoresbox"]
//var iframeids=["comments"]

//Should script hide iframe from browsers that don't support this script (non IE5+/NS6+ browsers. Recommended):
var iframehide="yes"

var getFFVersion  = navigator.userAgent.substring(navigator.userAgent.indexOf("Firefox")).split("/")[1]

var FFextraHeight = (parseFloat(getFFVersion) >= 1.0 && parseFloat(getFFVersion) <= 1.9) ? 16 : 4 //extra height in px to add to iframe in FireFox 1.0+ browsers

function resizeCaller()
{
	var dyniframe=new Array()
	for (i=0; i<iframeids.length; i++)
		{
		if (document.getElementById)
			resizeIframe(iframeids[i])

		//reveal iframe for lower end browsers? (see var above):
		if ((document.all || document.getElementById) && iframehide == "no")
			{
				var tempobj = document.all ? document.all[iframeids[i]] : document.getElementById(iframeids[i])
				tempobj.style.display="block";
				//tempobj.style.height=100+"%";
			}
		}
	}

function resizeIframe(frameid)
{
	var currentfr=document.getElementById(frameid)
	if (currentfr && !window.opera)
		{
		currentfr.style.display="block";
		//currentfr.style.height=100+"%";
		if (currentfr.contentDocument && currentfr.contentDocument.body.offsetHeight) //ns6 syntax
			currentfr.height = currentfr.contentDocument.body.offsetHeight+FFextraHeight; 
		else if (currentfr.Document && currentfr.Document.body.scrollHeight) //ie5+ syntax
			currentfr.height = currentfr.Document.body.offsetHeight;
		if (currentfr.addEventListener)
			currentfr.addEventListener("load", readjustIframe, false)
		else if (currentfr.attachEvent)
			{
			currentfr.detachEvent("onload", readjustIframe) // Bug fix line
			currentfr.attachEvent("onload", readjustIframe)
			}
		}
	
	if(window.opera)
	{
		var the_height=currentfr.contentWindow.document.body.scrollHeight;
	    currentfr.height=the_height;
	}	
}

function readjustIframe(loadevt)
	{
	var crossevt=(window.event)? event : loadevt
	var iframeroot=(crossevt.currentTarget)? crossevt.currentTarget : crossevt.srcElement
	if (iframeroot)
		resizeIframe(iframeroot.id);
	}

function loadintoIframe(iframeid, url)
	{
	if (document.getElementById)
		document.getElementById(iframeid).src=url
	}

if (window.addEventListener)
	window.addEventListener("load", resizeCaller, false)
else if (window.attachEvent)
	window.attachEvent("onload", resizeCaller)
else
	window.onload=resizeCaller


