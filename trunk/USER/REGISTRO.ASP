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
sub datoscorrectos(id,nombre, apellidos, dir, ciudad, nick, email, pass, repass,resultado, conexion)
	resultado = 0
	aux = false
	if (nombre = "") or (apellidos = "") or (nick="") or (email="") or (pass="") or (repass="") then
		resultado = 1			'FALTA POR RELLENAR ALGUN DATOS OBLIGATORIO
	else
		if emailincorrecto(email) then
			response.write email
			resultado = 2		'LA DIRECCION DE CORREO INTRODUCIDA NO ES CORRECTA
		else
			if (pass <> repass) then 
				resultado = 3	'REVISE EL PASSWORD INTRODUCIDO, NO CORRESPONDE CON LA CONFIRMACION
			else
				if existenick(nick,conexion) then
					resultado=4	'EL USERNAME INTRODUCIDO YA EXISTE EN EL SISTEMA, INTRODUZCA OTRO DISTINTO
				else
				'Todas las premisas para la insercion son correctas y se realiza el alta en la base de datos
					sentencia = "insert into usuario values (" & id & ",'"
        				sentencia = sentencia & nombre &"','"    
        				sentencia = sentencia & apellidos & "','"
        				sentencia = sentencia & dir & "','"
        				sentencia = sentencia & ciudad & "','"
        				sentencia = sentencia & email &"','"
        				sentencia = sentencia & nick &"','"
        				sentencia = sentencia & pass &"')"
					'Ejecutamos la sentencia        
					 Conn.Execute (sentencia)
				end if
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
id = nuevoID(conn,"usuario")
datoscorrectos id,request("nombre"),request("apellidos"), request("dir"),request("ciudad"),request("user"),request("email"),request("passwd"),request("repasswd"),resultado, conn
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
		
	        response.write "<FORM METHOD='POST' ACTION='pref.asp'>"
	        response.write "<input type='hidden' name='user' value="& id &">"
	        Set pref = Conn.Execute ("Select * from categoria where  cat_padre = 0")
	        
      	  	While Not pref.EOF
        		response.write "<input type='checkbox' name="&pref("id")&">"&pref("descripcion")&"<br>"
        		pref.MoveNext
      	  	Wend
        	
        	response.write "<input type=submit value=Finalizar>"
        	response.write "</form>"        	
end select
conn.close
%>
</body>
</html>