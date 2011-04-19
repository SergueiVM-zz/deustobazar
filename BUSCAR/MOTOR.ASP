<%
'MOTOR DE BUSQUEDA
'Este ASP se ejecuta en el servidor y no es transmitido a cliente para 
'no relentizar la carga.
'Llamara a otro ASP pasandole como parametro el query que genera
'La funcion principal será generar una query correcta
Dim query
query = "select * from subasta, usuario, puja p where p.producto = subasta.id and usuario.id = subasta.ofertante and ("
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
response.write 	query
response.redirect("busqueda.asp?query="&query)
%>