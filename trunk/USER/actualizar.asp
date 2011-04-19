<html>
<head><title></title>
<LINK REL="stylesheet" HREF="../css/deusto.css" TYPE="text/css">
</head>
<body background="../images/fondo.jpg">
<!--#include file="../inc/utils.inc"-->
<!--#include file="../inc/bd.inc"-->
<% 

function existenick(nick, conexion)
	resultado = false
   	Set r = conexion.execute("Select count(*) from usuario where nick = '"&request("user")&"'")
   	if not r.eof then
   		if (CInt(r(0))>0) then 
   			resultado = true
   		end if
   	end if
   	existenick = resultado
end function
function emailincorrecto(email)
	aux = false
	if instr(email,"@") then
		aux = false
	else
		aux = true
	end if
	comprobaremail = aux
	
end function
sub datoscorrectos(id,nombre, apellidos, dir, ciudad,  email, pass, repass,resultado, conexion)
	resultado = 0
	aux = false
	if (nombre = "") or (apellidos = "") or (email="") or (pass="") or (repass="") then
		resultado = 1			'FALTA POR RELLENAR ALGUN DATOS OBLIGATORIO
	else
		if emailincorrecto(email) then
			response.write email
			resultado = 2		'LA DIRECCION DE CORREO INTRODUCIDA NO ES CORRECTA
		else
			if (pass <> repass) then 
				resultado = 3	'REVISE EL PASSWORD INTRODUCIDO, NO CORRESPONDE CON LA CONFIRMACION
			else
				'Todas las premisas para la insercion son correctas y se realiza el alta en la base de datos
				sentencia = "update usuario set "
        				sentencia = sentencia &"nombre = '"&nombre&"' ,"
        				sentencia = sentencia &"apellidos ='"&apellidos&"' ,"
        				sentencia = sentencia &"direccion ='"&dir&"' ,"
        				sentencia = sentencia &"ciudad = '"&ciudad&"' ,"
        				sentencia = sentencia &"email = '"&email&"' ,"
       	    				sentencia = sentencia &"passwd='"& pass&"' "
        				sentencia = sentencia &"where id = "&id
					'Ejecutamos la sentencia        
					Conn.Execute (sentencia)
			end if
		end if
	end if
end sub


'Conexion con la BD
Set Conn=Server.CreateObject("ADOdb.Connection")
conectarBD(conn)

Dim resultado
'Recuperamos identificativo de usuario
dim id 
id = Session("usuario")
datoscorrectos id,request("nombre"),request("apellidos"), request("dir"),request("ciudad"),request("email"),request("passwd"),request("repasswd"),resultado, conn
select case resultado
	case 1
		response.write "FALTA POR RELLENAR ALGUN DATOS OBLIGATORIO"
	case 2
		response.write "LA DIRECCION DE CORREO INTRODUCIDA NO ES CORRECTA"
	case 3
		response.write "REVISE EL PASSWORD INTRODUCIDO, NO CORRESPONDE CON LA CONFIRMACION"
	case 4
		response.write "EL USERNAME INTRODUCIDO YA EXISTE EN EL SISTEMA, INTRODUZCA OTRO DISTINTO"
	case 0
		'Como se ha producido correctamente la insercion le mostramos las preferencias 
		'para que seleccione sobre cuales quiere estar informado
		Mensaje("Se han actualizado sus datos")
		Response.write "<a href='main.asp' target='main'>Volver a la pantalla de usuario</a>"
		
end select
conn.close
%>
</body>
</html>