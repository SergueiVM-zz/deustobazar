<html>
<head><title></title></head>
<body background="../images/fondo.jpg">

<!--#include file="../inc/bd.inc"-->
<!--#include file="../inc/utils.inc"-->
<%
	Set Conn=Server.CreateObject("ADOdb.Connection")
	conectarBD(conn)
	
	'Prerrequisito es introducir un parametro id con el identificativo 
	'de la subasta
	Dim query

	query = "select s.id as id,titulo, categoria, e.descripcion as estado, observaciones, precio_salida, fechafin, foto" 
	query = query & " from subasta s, usuario u, estado e where"
	query = query & " e.id = s.estado and"
	query = query & " u.id = s.ofertante and"
	query = query & " s.id = "&request("id")
	
	Set rs = conn.execute (query)	
	response.write "<center><table border='1' CELLSPACING='0' CELLPADDING='0' bgcolor='#ffcc00'>"	
	
	while not rs.EOF
	   'response.write rs("id")&"<br>"
	   response.write "<tr><th colspan='3' bgcolor='#0099ff'>"&UCase(rs("titulo"))&"</th></tr>"
	   if rs("foto")<> "NO" then
	   	response.write "<tr><td align='center' valign='middle' rowspan='4' width='150' height='100'><img src='../fotos/super.jpg' width='149' height='99' border='0'></td>"
	   else
	   	response.write "<tr><td align='center' valign='middle' rowspan='4' width='150' height='100'><img src='../fotos/croix.gif' width='149' height='99' border='0'></td>"
	   end if
	   response.write "<td><b>CATEGORIA: </b></td><td>"&pathcategoria(rs("categoria"),conn)&"</td></tr>"
	   
	   response.write "<tr><td><b>ESTADO DEL PRODUCTO:&nbsp&nbsp</b></td><td>"&rs("estado")&"</td></tr>"
	   
	   response.write "<tr><td><b>FINALIZACION: </b></td><td>"&fecha(rs("fechafin"))&"</td></tr>"
	   
	   response.write "<tr><td><b>PRECIO DE SALIDA: </b></td><td>"&rs("precio_salida")&"</td></tr>"
	   
	   response.write "<tr><td colspan='3'><b>OBSERVACIONES</b></td></tr><tr><td colspan='3'>"&rs("observaciones")&"</td></tr>"
	   
	   Set puj = conn.execute("select * from puja p, usuario u where u.id= p.usuario and producto="&rs("id")&" order by importe desc")
	   if not puj.eof then
	   	response.write "<tr><th colspan='3'>PUJAS REALIZADAS PARA ESTA SUBASTA</th></tr>"
	   	response.write "<tr><td colspan='3'><ul>"
	   	while not puj.eof
	   		response.write "<li>"&fecha(puj("fecha"))&" "&puj("importe")&" pts. "&puj("nick")&" "&puj("ciudad")&"</li>"
	   		puj.movenext
	   	wend
	   	response.write "</ul></td></tr>"
	   else
	   	response.write "<tr><th colspan='3'>NO HAY PUJAS PARA ESTA SUBASTA</th></tr>"
	   end if
	   rs.movenext
	wend
	response.write "</table></center>"
	
	'Codigo para pujar
	
	response.write "<form action='pujar.asp' method='post'><center><table border='0' bgcolor='#ffcc00' valign='bottom'>"
	response.write "<tr><td colspan='2'><h2>Haz tu puja</h2></td></tr>"
	response.write "<input type='hidden' name='producto' value='"&request("id")&"'>"
	if (Session("usuario")="") then
  		response.write "<tr><td align='right' valign='top'>Usuario: </td><td align='left'><input type='text' name='user'></td></tr>"
  		response.write "<tr><td align='right' valign='top'>Password: </td><td align='left'><input type='password' name='pass'></td></tr>"
	end if
	response.write "<tr><td align='right' valign='top'>Puja: </td><td align='left'><input type='text' name='importe'> pts</td></tr>"
	response.write "<tr><td colspan='2' align='center'><input type='Submit' value='Alta puja'><input type='reset' value='Borrar Formulario'></td></tr>"
	response.write "</table></center></form>"
		

%>
<div align="center"><img src="../images/cerrar.gif" onclick="window.close()" border="0"></div>
</body>
</html>