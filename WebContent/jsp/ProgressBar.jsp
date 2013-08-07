<%
     response.setHeader("Cache-Control", "private");
     response.setHeader("Pragma","private");
     response.setHeader("Pragma", "No-cache");
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Cache-Control", "no-store");
     response.setHeader("Cache-Control", "must-revalidate");
     response.setHeader("Pragma", "must-revalidate");
     response.setDateHeader("Expires", 0);
%>

<html>
    <head>
	<!-- <script type="text/javascript" src="percentageProgressBar.js"></script> -->
	<script language="javascript" src="../js/xp_progress.js">
	</script>
</head>
<body bgcolor="FFFFCC">
     <table align ="center" float= midle>
        <tr>
            <td>
            Loading please wait......
            <script type="text/javascript">
                var bar1= createBar(300,15,'black',1,'blue','red',100,9,5,"");
            </script>
            </td>
        </tr>
     </table>
</body>
</html>

