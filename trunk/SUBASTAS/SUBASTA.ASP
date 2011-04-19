<html>
<head><title></title></head>
<body background="../images/fondo.jpg">

<!--#include file="../inc/bd.inc"-->
<!--#include file="../inc/utils.inc"-->
<%
Dim resultado
Sub comprobarDatos (titulo, preciosalida, usuario, error)
	error = 0
	if titulo = "" then 
		error = 1	'FALTA TITULO DE LA SUBASTA
		else 
			if preciosalida = "" then 
				error= 2	'FALTA EL PRECIO DE SALIDA
			else
				if usuario = "-1" then
					error = 3
				end if
			end if
	end if
	
	
end sub

Set Conn=Server.CreateObject("ADOdb.Connection")
conectarBD(conn)
  
if Session("usuario") <> "" then
else
	Session("usuario")= recuperarUsuario(request("user"),request("pass"),conn) 
end if

comprobardatos request("titulo"), request("precio_salida"), Session("usuario"), resultado
select case resultado  			
	case 1
		response.write "FALTA EL TITULO DE LA SUBASTA"
	case 2
		response.write "FALTA EL PRECIO DE SALIDA"
	case 3
		response.write "EL USUARIO NO ESTA IDENTIFICADO EN EL SISTEMA O NO ESTA REGISTRADO"
	case 0
  			Dim id
  			id = Session("usuario")
  			insert = "insert into subasta values ("
  			insert = insert & nuevoID(conn,"subasta") & ",'" & request("titulo")
  			insert = insert & "'," & request("cat")
  			insert = insert & "," & request("estado")
  			insert = insert & ",'NO'"
  			insert = insert & ",'"& request("observaciones")
  			insert = insert & "'," &request("precio_salida")
  			insert = insert & ",to_date('"& fecha(Date+request("dur"))
  			insert = insert & "','dd-mm-yyyy'),"&id&")"
  			'response.write insert
  			Conn.execute(insert) 			
  			mensaje("LA SUBASTA DE HA DADO DE ALTA CON EXITO")	
  			response.write "<center><a href='../index2.html' target='main'>Volver a la pagina principal</a></center>"
end select
  	

conn.close
%>
</body>
</html>