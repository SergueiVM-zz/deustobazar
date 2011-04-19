<html>
<head>
<LINK REL="stylesheet" HREF="../css/menu.css" TYPE="text/css">
</head>
<body background="../images/fondo.jpg">

<%
Dim oConn, rs, SQL
Dim PaginaActual		' en qué pagina estamos
Dim PaginasTotales		' cuántas páginas tenemos
Dim TamPagina			' cuantos registros por pagina
Dim CuantosRegistros	' para imprimir solo el nº de registro por pagina que queramos

'MODIFICAR AQUI PARA CAMBIAR EL Nº DE REGISTRO POR PAGINA
TamPagina=7

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
SQL="SELECT * FROM categoria where cat_padre ="&request("id")

' Defino el tamaño de las páginas
rs.PageSize=TamPagina
rs.CacheSize=TamPagina

' Abro el recordset
rs.Open SQL, oConn, 1, 2

'Cuento las páginas
PaginasTotales= CInt(rs.PageCount)

'Compruebo que la pagina actual está en el rango
if PaginaActual < 1 then 
	PaginaActual = 1
end if
if PaginaActual > PaginasTotales then
	PaginaActual = CInt(PaginasTotales)
end if

'Por si la consulta no devuelve registros!
if PaginasTotales=0 then

	Response.Write("No se encontraron resultados.")

else

	'Vamos a paginar
	rs.AbsolutePage = CInt(PaginaActual)

        response.write ("<table border='0' width='100%'><tr><td>")
	Response.Write("<TABLE BORDER='0' width='100%'>")
	Response.Write("<TR><td bgcolor='#ffcc00'>CATEGORIAS</TD>")
       
        Set P = oConn.Execute("Select * from categoria where id="&request("id")&" and id <> 0")

        if P.EOF then
        else
          P.MoveFirst
          response.write("<tr><td><A href='cats.asp?id=" & P("cat_padre") & "'><img src='images/back.gif' border='0'></a></td></tr>")
       end if

	CuantosRegistros=0
	
	do while not rs.EOF and CuantosRegistros < TamPagina
	  	Set cont = oConn.Execute("Select count(*) as cant from categoria where cat_padre="& RS("id"))
          	if cont.EOF then
	     		Response.write("<tr><td>"&RS("descripcion")&"</td></tr>")
          	else
          	
          		if ( Cint(cont("cant")) > 0) then
            			Response.Write("<tr><td><A href='cats.asp?id=" & RS("id") & "'>" & RS("descripcion") & "</a></td></tr>")
	    		else
              			Response.Write("<tr><td><A href='listcat.asp?cat=" & RS("id") & "' target='principal'>" & RS("descripcion") & "</a></td></tr>") 
			end if
          	end if
          	CuantosRegistros=CuantosRegistros+1
	  	rs.MoveNext
	loop
	Response.Write("</TABLE></Td><td valign='top'><table border='0'>")
end if
rs.Close
oConn.Close
set rs=nothing
set oConn=nothing

'Muestro los enlaces

if PaginaActual > 1 then
	Response.Write("<tr><td><A HREF=cats.asp?pagina="& PaginaActual-1& "&id="&request("id")&"><img border='0' src='images/haciaarriba.gif'></A></td></tr>")
else response.write ("<tr><td><img src='images/x.gif' height='20'></td></tr>")
end if
rem response.write ("<tr><td width='20'><img src='images/x.gif' height='1' width='20'></td></tr>")
if PaginaActual < PaginasTotales then
	Response.Write("<tr><td><A HREF=cats.asp?pagina="& PaginaActual+1 &"&id="&request("id")&"><img border='0' src='images/haciaabajo.gif'></A></td></tr>")
else response.write ("<tr><td><img src='images/x.gif' height='20'></td></tr>")
end if
response.write ("</table></td></tr></table>")

%>
</body>
</html>