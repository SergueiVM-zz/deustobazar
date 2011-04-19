<html>
<head>
<LINK REL="stylesheet" HREF="../css/deusto.css" TYPE="text/css">
</head>
<body background="../images/fondo.jpg">
<!--#include file="../inc/utils.inc"-->
<!--#include file="../inc/bd.inc"-->
<%

set Conn=Server.CreateObject("ADODB.Connection")
conectarBD conn

' Conexión por DSN

query = "select s.id as id, titulo, fechafin, precio_salida, ciudad, foto"
query = query&" from subasta s, usuario u where u.id = s.ofertante and ("
if request("clave") <> "" then
	query = query & "(titulo like '%"& request("clave")&"%' or observaciones like '%"&request("clave")&"%')"
	
	if request("foto") = "on" then
		query = query & " and foto not like 'NO'"
	end if
	if (request("preciomax") <> "") then
		query = query & " and precio_salida <= "&request("preciomax")
	end if
	if (request("preciomin") <> "") then
		query = query & " and precio_salida >= "&request("preciomin")
	end if
	if request("ciudad")<>"" then
		query = query & " and ciudad='"&request("ciudad")&"'"
		
	end if
	if (request("categoria") <> "0") then
		query = query &" and categoria in ("& subcategorias(request("categoria"),conn)&")"
	end if
	

end if
query = query & " and fechafin >=  to_date('" & fecha(Date) & "','dd-mm-yyyy'))"
SQL = query
'FIN DEL MOTOR DE BUSQUEDA


response.write "<P><H2>RESULTADO DE LA BUSQUEDA</H2></P>"
	if (request("categoria") <> "0") then
		response.write "<h4>Dentro de la categoria <b>"&pathcategoria(request("categoria"),conn)&"</b></h4>"
	end if



Set rs = conn.execute(SQL)

Dim CuantosRegistros
CuantosRegistros = 1

Response.Write("<TABLE CELLSPACING='0' CELLPADDING='0' BORDER='0' width='100%'>")
Response.Write("<TR bgcolor='#ffcc00'><TD COLSPAN='2'><B>TITULO</B></TD><TD><B>PRECIO SALIDA</B></TD><TD><B>PRECIO ACTUAL</B></TD><TD><B>CIUDAD</B></TD><TD><B>FECHA FIN</B></TD>")
response.write("<tr bgcolor='blue'><td colspan='6'><img src='images/x.gif' heigth='1'></td></tr>")

while not rs.EOF 
	'Pinto una línea de la tabla por cada registro
	if (CuantosRegistros mod 2) = 0 then
		Response.Write("<TR bgcolor='#0099ff'>"&VbCrLf)
	else
		Response.Write("<TR>"&VbCrLf)
	end if
		
	if rs("foto")="NO" then
		Response.Write("<TD width='25'><img src='images/x.gif' width='25'></TD>")
	else
		Response.Write("<TD width='25'><img src='images/foto.gif' width='25'></TD>")
	end if
	Response.Write("<TD><a href='../subastas/ficha.asp?id="&rs("id")&"' target='ficha' onclick=window.open('../subastas/ficha.asp?id="&rs("id")&"','ficha','menubar=no;scrollbar=yes')>"&rs.Fields("titulo")&"<a/></TD>")
	Response.Write("<TD>"&rs.Fields("precio_salida")&" pts.</TD>")
		
	maxpuja = pujamaxima(rs("id"),conn)
	if (maxpuja = "No hay pujas") then 
		response.write "<td>"&maxpuja&"</td>"
	else
		response.write "<td>"&maxpuja&" pts.</td>"
	end if
	Response.Write("<TD>"&rs("ciudad")&"</TD>")
	Response.Write("<TD>"&fecha(rs("fechafin"))&"</TD>")
		

	Response.Write("</TR>")
	response.write("<tr bgcolor='blue'><td colspan='6'><img src='images/x.gif' heigth='1'></td></tr>")
	CuantosRegistros=CuantosRegistros+1
	rs.MoveNext
wend
Response.Write("</TABLE>")



Conn.Close

%>
</body>
</html>