<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> Menu Admin</title>
<script src="../../js/SpryMenuBar.js" type="text/javascript"></script>
<link href="../../css/MenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<link href="../../css/MenuBarVertical.css" rel="stylesheet" type="text/css" />
</head>

<body>
<ul  id="MenuBar1" class="MenuBarHorizontal">
<li><a  href="/cims/jsp/admin/UserMaster.jsp">User Master</a>  </li>
  <li><a  href="/cims/jsp/admin/RoleMaster.jsp">Role Master</a>  </li>
<li><a class="MenuBarItemSubmenu" >Series Master</a>
      <ul>
        <li><a  href="/cims/jsp/admin/SeriesTypeMaster.jsp">Series Registration</a>           
        </li>
        <li><a href="/cims/jsp/admin/SeriesSelectionMaster.jsp">Series Selection</a></li>
      </ul>
  </li>
  <li><a href="/cims/jsp/admin/RegionMaster.jsp">Region Master</a></li>
 
   <li><a class="MenuBarItemSubmenu" >Team Master</a>
      <ul>
        <li ><a href="/cims/jsp/admin/TeamMaster.jsp">Team Registration</a></li>
        <li><a href="/cims/jsp/admin/TeamPlayerMap.jsp ">Team Player Map Master</a></li>
      </ul>
  </li>
  <li><a class="MenuBarItemSubmenu" >General Master</a>
      <ul>
        <li><a  href="/cims/jsp/admin/AppealMaster.jsp ">Appeal Master</a>           
        </li>
        <li><a href="/cims/jsp/admin/ResultMaster.jsp">Result Master</a></li>
         <li><a href="/cims/jsp/admin/RoundMaster.jsp">Round Master</a></li>
          <li><a href="/cims/jsp/admin/WeathertypeMaster.jsp  ">Weather Master</a></li>
      </ul>
  </li>
</ul>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"MenuBarDownHover.gif", imgRight:"MenuBarRightHover.gif"});
</script>
</body>
</html>
