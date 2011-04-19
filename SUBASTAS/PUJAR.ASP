<html>
<head><title></title></head>
<body background="../images/fondo.jpg">

<!--#include file="../inc/bd.inc"-->
<!--#include file="../inc/utils.inc"-->
<%
Dim resultado
Sub comprobarDatos (importe, usuario, subasta, error, conexion)
	error = 0
	if importe = "" then 
		error= 1	'FALTA EL importe de la puja
	else
		if usuario = "-1" then
			error = 2
		else
			if (importePujaCorrecto(subasta, importe, conexion)= 1) then
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

comprobardatos request("importe"), Session("usuario"), request("producto"), resultado, conn
select case resultado  			
	case 1
		response.write "FALTA EL IMPORTE DE LA PUJA"
	case 2
		response.write "EL USUARIO NO ESTA IDENTIFICADO EN EL SISTEMA O NO ESTA REGISTRADO"
	case 3
		response.write "LA PUJA REALIZADA NO SUPERA LA PUJA GANADORA ACTUAL O ES INFERIOR AL PRECIO DE SALIDA"
	case 0
  		Dim id
  		id = Session("usuario")
  		insert = "insert into puja values ("
  		insert = insert & nuevoID(conn,"puja")
  		insert = insert & "," & request("producto")
  		insert = insert & "," & id
  		insert = insert & ",to_date('"& fecha(Date)&"','dd-mm-yyyy')"
  		insert = insert & ",0000"
  		insert = insert & "," & request("importe")
  		insert = insert & ")"
  		'response.write insert
  		Conn.execute(insert) 			
  		mensaje("LA PUJA DE HA DADO DE ALTA CON EXITO")	
  		
end select
conn.close
%>
<div align="center"><img src="../images/cerrar.gif" onclick="window.close()" border="0"></div>
</body>
</html>