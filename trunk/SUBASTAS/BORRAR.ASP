<html>
<head><title></title></head>
<body background="../images/fondo.jpg">

<!--#include file="../inc/bd.inc"-->
<!--#include file="../inc/utils.inc"-->
<%
Set Conn=Server.CreateObject("ADOdb.Connection")
conectarBD(Conn)

if (pujamaxima(request("id"),conn) = "No hay pujas") then
	'Si entramos aqui, es que no hay pujas en esa subasta y podemos borrar la subasta.
	conn.execute ("delete from subasta where id="&request("id"))
	Mensaje "Se ha borrardo con exito la subasta."
else
	Mensaje "No se ha podido borrar la subasta porque hay pujas en juego"
end if

  
%>
<div align="center"><a href="../user/main.asp?action=1" target="main"><img src="../images/cerrar.gif" onclick="window.close()" border="0"></a></div>
</body>
</html>
