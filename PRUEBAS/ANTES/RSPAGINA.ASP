<%
' Paginas en un recordset
'------------------------
' Carlos de la Orden Dijs
' webmaster@aspfacil.com
'------------------------

Dim oConn, rs, SQL
Dim PaginaActual		' en qué pagina estamos
Dim PaginasTotales		' cuántas páginas tenemos
Dim TamPagina			' cuantos registros por pagina
Dim CuantosRegistros	' para imprimir solo el nº de registro por pagina que queramos

'MODIFICAR AQUI PARA CAMBIAR EL Nº DE REGISTRO POR PAGINA
TamPagina=10

'Leemos qué página mostrar. La primera vez será la inicial
if Request.Querystring("pagina")="" then
	PaginaActual=1
else
	PaginaActual=CInt(Request.Querystring("pagina"))
end if

set oConn=Server.CreateObject("ADODB.Connection")
set rs=Server.CreateObject("ADODB.Recordset")

' Conexión por OLEDB
oConn.Open "DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.Mappath("bazar.mdb")
SQL="SELECT id, nombre  FROM usuario;"

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

'Por si la consulta no devuelve registros!
if PaginasTotales=0 then

	Response.Write("No se encontraron resultados.")

else

	'Vamos a paginar
	rs.AbsolutePage=PaginaActual
	Response.Write("Pagina " & PaginaActual & " de " & PaginasTotales)
	Response.Write("<br><br>")
	Response.Write("<TABLE BORDER=""1"" ALIGN=""center"" STYLE=""font-size:75%"">")
	Response.Write("<TR><TD COLSPAN=""3""><B>RESULTADOS</B></TD>")
	CuantosRegistros=0
	do while not rs.EOF and CuantosRegistros < TamPagina
		'Pinto una línea de la tabla por cada registro
		Response.Write("<TR>"&VbCrLf)
		Response.Write("<TD>"&rs.Fields("Id")&"</TD>")
		Response.Write("<TD>"&rs.Fields("Nombre")&"</TD>")

		Response.Write("</TR>")
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
Response.Write("<hr>")
if PaginaActual > 1 then
	Response.Write("<A HREF=rspagina.asp?pagina="& PaginaActual-1& ">10 Anteriores</A>&nbsp;&nbsp;&nbsp;")
end if
if PaginaActual < PaginasTotales then
	Response.Write("<A HREF=rspagina.asp?pagina=" & PaginaActual+1 &">10 Siguientes</A>")
end if


%>