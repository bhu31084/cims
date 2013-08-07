<%-- 
    Document   : mobilemenu
    Created on : Feb 22, 2009, 12:58:08 AM
    Author     : Dongare
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Menu Bar Widget</title>
<link href="../css/samples.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
div {
	clear: both;
}
hr {
}
#MenuBar3 li a {
	background-color: transparent;
}
#MenuBar3 a:hover, #MenuBar3 a:focus {
	background-image: url(../images/itemgradient-hover.gif);
	background-repeat: repeat-x;
}
#MenuBar3 a.MenuBarItemHover, #MenuBar3 a.MenuBarItemSubmenuHover, #MenuBar3 a.MenuBarSubmenuVisible {
	background-image: url(../images/itemgradient-hover.gif);
	background-repeat: repeat-x;
}
#MenuBar3 li {
	background-image: url(../images/itemgradient.gif);
	background-repeat: repeat-x;
}
-->
</style>
<link href="../css/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<script src="../js/SpryMenuBar.js" type="text/javascript"></script>
</head>
<body>
<div>
 <hr />
  <ul id="MenuBar3" class="MenuBarHorizontal">
  <li><a class="MenuBarItemSubmenu" >Item 1</a></li>
  <li><a >Item 2</a></li>
  <li><a >&nbsp;</a></li>
  <li><a >&nbsp;</a></li>
 </ul>
</div>
<script type="text/javascript">
<!--
var MenuBar3 = new Spry.Widget.MenuBar("MenuBar3", {imgDown:"../images/SpryMenuBarDownHover.gif", imgRight:"../images/SpryMenuBarRightHover.gif"});
//-->
</script>
</body>
</html>
