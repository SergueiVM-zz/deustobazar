<html>
<head>
<LINK REL="stylesheet" HREF="../css/deusto.css" TYPE="text/css">
</head>

<body background="../images/fondo.jpg">
<!--#include file="../inc/utils.inc"-->
<!--#include file="../inc/bd.inc"-->

<%
  Set Conn=Server.CreateObject("ADOdb.Connection")
  conectarBD(conn)
  
  Set cat = Conn.Execute("Select id from categoria where cat_padre = 0")
  dim sentencia
  response.write request.querystring
  
  while not cat.EOF
    	if request(cat("id")) <> "" then
  		sentencia = "insert into preferencias values ("&request("user")&","&cat("id")&")"
  		conn.execute(sentencia)
 	end if
 	cat.movenext
  wend
  
session("usuario")=request("user")  
mensaje "SE HA REALIZADO EL ALTA CON EXITO<br>Esta usted conectado al sistema"

%>

</body>
</html>
