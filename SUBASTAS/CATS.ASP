<html>
<head>
<LINK REL="stylesheet" HREF="../css/deusto.css" TYPE="text/css">
</head>
<body background="../images/fondo.jpg">
<!--#include file="../inc/bd.inc"-->
<!--#include file="../inc/utils.inc"-->
<%
	cabecera "ALTA DE SUBASTAS EN DEUSTO BAZAR.COM (PASO 1)"
	Set Conn=Server.CreateObject("ADOdb.Connection")
  	conectarBD(conn)
  
  	Dim id, padre
  	response.write "<h2>¡¡Gracias por elegir DEUSTO BAZAR.COM para vender tus productos!!</h2>"
  	response.write "<h3>Para su fácil localización por parte de los compradores, primero debes elegir una categoría para tu producto. Para ello solo será necesario un click del ratón y podras navegar dentro de las categorias.</h3>"
  	
  	if request("id") = "" then 
  		id = 0
  	else
  		id = Cint(request("id"))
  		response.write "<h4>CATEGORIA: "&pathcategoria(id,conn)&"</h4>"
  	end if
  	
  	Set rs = Conn.Execute("Select * from categoria where id<>0 and cat_padre = "&id)
  	response.write "<center><table border='0' bgcolor='#ffcc00' width='50%'>"
  	while not rs.EOF
  	        Set hijos = conn.execute("Select count(id) from categoria where cat_padre="& rs("id"))
  	        if not hijos.EOF then
  	        	if (CInt(hijos(0)) = 0) then 
  	        		response.write "<tr><td><a href='datos.asp?cat="&rs("id") &"' class='instr'><img src='../images/file.gif' border='0'>"&UCase(rs("descripcion"))&"</a></td></tr>"
  	        	else
  	        		response.write "<tr><td><a href='cats.asp?id="&rs("id") &"' class='instr'><img src='../images/folder.gif' border='0'>"&UCase(rs("descripcion"))&"</a></td></tr>"
  	        	end if
  	        end if
 		rs.movenext
  	wend
  
%>
</body>
</html>