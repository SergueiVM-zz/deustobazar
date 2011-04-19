<html>
<head>
<LINK REL="stylesheet" HREF="../css/deusto.css" TYPE="text/css">
</head>
<body>
<!--#include file="../inc/utils.inc"-->
<!--#include file="../inc/bd.inc"-->

<%
 
' Paginas en un recordset

Dim oConn, rs, SQL
Dim PaginaActual		' en qué pagina estamos
Dim PaginasTotales		' cuántas páginas tenemos
Dim TamPagina			' cuantos registros por pagina
Dim CuantosRegistros	' para imprimir solo el nº de registro por pagina que queramos

'MODIFICAR AQUI PARA CAMBIAR EL Nº DE REGISTRO POR PAGINA
TamPagina=20

'Leemos qué página mostrar. La primera vez será la inicial
if Request.Querystring("pagina")="" then
	PaginaActual=1
else
	PaginaActual=CInt(Request.Querystring("pagina"))
end if

set oConn=Server.CreateObject("ADODB.Connection")
set rs=Server.CreateObject("ADODB.Recordset")

' Conexión por OLEDB
oConn.Open "DSN=bazar;uid=bazar;pwd=bazar;"

'MOTOR PARA LA BUSQUEDA; TOMA LA QUERY GENERADA POR EL MOTOR (motor.asp)

Dim query
Dim param
param= "clave="&request("clave")&"&"
param= param&"foto="&request("foto")&"&"
param= param&"preciomax="&request("preciomax")&"&"
param= param&"preciomin="&request("preciomin")&"&"
param= param&"cat="&request("cat")&"&"
param= param&"ciudad="&request("ciudad")

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
		query = query & "and ciudad='"&request("ciudad")&"'"
		
	end if

end if
query = query & ")"
SQL = query
'FIN DEL MOTOR DE BUSQUEDA
 

' Defino el tamaño de las páginas
rs.PageSize=TamPagina
rs.CacheSize=TamPagina
' Abro el recordset
rs.Open SQL, oConn, 1, 2

'Cuento las páginas
PaginasTotales=rs.PageCount

'Compruebo que la pagina actual está en el rango
if PaginaActual < 1 then 
	PaginaActual = 1
end if
if PaginaActual > PaginasTotales then
	PaginaActual = PaginasTotales
end if

if PaginasTotales=0 then
        'Por si la consulta no devuelve registros!
	Response.Write("No se encontraron resultados.")

else

	'Vamos a paginar
	rs.AbsolutePage=CInt(PaginaActual)
	response.write("<b>RESULTADOS DE LAS BUQUEDA</b><br>")
	Response.Write("Pagina " & PaginaActual & " de " & PaginasTotales)
	Response.Write("<br><br>")
	Response.Write("<TABLE CELLSPACING='0' CELLPADDING='0' BORDER='0' width='100%'>")
	Response.Write("<TR><TD COLSPAN='2'><B>TITULO</B></TD><TD><B>PRECIO SALIDA</B></TD><TD><B>PRECIO ACTUAL</B></TD><TD><B>CIUDAD</B></TD><TD><B>FECHA FIN</B></TD>")
	response.write("<tr bgcolor='blue'><td colspan='6'><img src='images/x.gif' heigth='1'></td></tr>")
	CuantosRegistros=0
	do while not rs.EOF and CuantosRegistros < TamPagina
		'Pinto una línea de la tabla por cada registro
		
		if (CuantosRegistros mod 2) =0 then
		   Response.Write("<TR bgcolor='#0099ff'>"&VbCrLf)
		else
		   Response.Write("<TR>"&VbCrLf)
		end if
		
		if rs("foto")="NO" then
		   Response.Write("<TD width='25'><img src='images/x.gif' width='25'></TD>")
		else
		   Response.Write("<TD width='25'><img src='images/foto.gif' width='25'></TD>")
		end if
		Response.Write("<TD><a href='../subastas/ficha.asp?id="&rs("id")&"' target='ficha'>"&rs.Fields("titulo")&"<a/></TD>")
		Response.Write("<TD>"&rs("precio_salida")&" pts</TD>")
		
		Set pujas = oConn.Execute("Select max(importe), count(id) from puja where producto="&rs("id"))

		if not pujas.eof then
			pujas.movefirst
			if pujas(1) = 0 then
				response.write ("<td>No hay pujas</td>")
			else				
				Response.Write("<TD>"&pujas(0)&"</TD>")
			end if
		else
		        response.write ("<td><b>No hay pujas</b></td>")
		end if
		Response.Write("<TD>"&rs("ciudad")&"</TD>")
		Response.Write("<TD>"&fecha(rs("fechafin"))&"</TD>")
		

		Response.Write("</TR>")
		response.write("<tr bgcolor='blue'><td colspan='6'><img src='images/x.gif' heigth='1'></td></tr>")
		CuantosRegistros=CuantosRegistros+1
		rs.MoveNext
	loop
	Response.Write("</TABLE>")

end if
rs.Close
oConn.Close
set rs=nothing
set oConn=nothing

'Muestro los enlaces
response.write("<table width='100%' border='0'><tr>")
if PaginaActual > 1 then
	Response.Write("<td align='left'><A HREF=busqueda.asp?"&param&"&pagina="& PaginaActual-1&">20 Anteriores</A></td>")
end if
if PaginaActual < PaginasTotales then
	Response.Write("<td align='right'><A HREF=busqueda.asp?"&param&"&pagina="& PaginaActual+1&">20 Siguientes</A></td>")
end if
response.write ("</tr></table>")

%>
</body>
</html>