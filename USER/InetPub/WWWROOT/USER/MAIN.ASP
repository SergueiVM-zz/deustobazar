<!--#include file="../inc/utils.inc"-->
<!--#include file="../inc/bd.inc"-->
<%
sub presInit
	response.write "<html><head><LINK REL='stylesheet' HREF='../css/deusto.css' TYPE='text/css'></head><body background='../images/fondo.jpg'>"
end sub
sub presFin
	response.write "</body></html>"
end sub
function subastafinalizada(subasta, conexion)
	aux = false
	set r = conexion.execute("select fechafin from subasta where id="&subasta)
	if not r.eof then
		res = compararfecha(r(0),date)
		if res = 2 then
			aux = true
		end if
	end if
	subastafinalizada = aux
end function

sub menu
  	response.write "<center><table border='0' width='90%' CELLPADDING=0 CELLSPACING=0 BORDER=0>"
  	response.write "<tr>"
  	'onmouseover=activar('subastas') onmouseout=desactivar('subastas')
  	response.write "<td><a href='main.asp?action=1'><img src='images/subastas.gif' border='0'></a></td>"
  	response.write "<td><a href='main.asp?action=2'><img src='images/pujas.gif' border='0'></a></td>"
  	response.write "<td><a href='main.asp?action=3'><img src='images/datos.gif' border='0'></a></td>"
  	response.write "<td><a href='main.asp?action=4'><img src='images/opinion.gif' border='0'></a></td>"
  	response.write "<td><a href='main.asp?action=5'><img src='images/salir.gif' border='0'></a></td>"
  	response.write "</tr>"
  	response.write "<tr><td colspan=5 align=right>"&fecha(date)&"</td></tr>"
  	response.write "</table></center>"
  	
end sub

sub listasubastas(usuario,conexion)
'Muestra un listado de todas las subasta que ha realizado el usuario y si estan en activo o no
	Set r = conexion.execute("select * from subasta where ofertante = "&usuario)
	Response.Write("<TABLE CELLSPACING='0' CELLPADDING='0' BORDER='0' width='100%'>")
	Response.Write("<TR bgcolor='#ffcc00'><TD COLSPAN='2'><B>TITULO</B></TD><td><b>CATEGORIA</b></td><TD><B>PRECIO SALIDA</B></TD><TD><B>PUJA ACTUAL</B></TD><td><b>GANADOR ACTUAL</b></td><TD><B>FINALIZACION</B></TD><td></td>")
	response.write("<tr bgcolor='blue'><td colspan='8'><img src='../images/x.gif' heigth='1'></td></tr>")
	CuantosRegistros = 1

	while not r.EOF 
		'Pinto una línea de la tabla por cada registro
		if (CuantosRegistros mod 2) = 0 then
			Response.Write("<TR bgcolor='#0099ff'>"&VbCrLf)
		else
			Response.Write("<TR>"&VbCrLf)
		end if
		
		if r("foto")="NO" then
			Response.Write("<TD width='25'><img src='../images/x.gif' width='25'></TD>")
		else
			Response.Write("<TD width='25'><img src='../images/foto.gif' width='25'></TD>")
		end if
		'Response.Write("<TD><a href='../subastas/ficha.asp?id="&r("id")&"' target='ficha'>"&r("titulo")&"<a/></TD>")
		Response.Write("<TD>"&r("titulo")&"</TD>")
		Response.write("<td>"&pathcategoria(r("categoria"),conexion)&"</td>")
		Response.Write("<TD>"&r("precio_salida")&" pts</TD>")
		
		Set p = conexion.execute("Select max(importe) as maximapuja, count(id) as totalpujas from puja where producto="&r("id"))
		maxpuja = pujamaxima(r("id"),conexion)
		if (maxpuja = "No hay pujas") then 
			response.write "<td>"&maxpuja&"</td>"
		else
			response.write "<td>"&maxpuja&" pts.</td>"
		end if
		ganador = ganadorsubasta(r("id"),conexion)
		if CInt(ganador) = -1 then
			response.write "<td>"&nickusuario(ganador,conexion)&"</td>"
		else
			response.write "<td><a href='opinion.asp?user="&ganador&"' target='opinion' onclick=window.open('opinion.asp?user="&ganador&"','opinion','menubar=no,scrollbars=yes,width=500,height=450')>"&nickusuario(ganador,conexion)&"</a></td>"
		end if
		
		If (compararfecha(Date,CDate(r("fechafin")))=1) then
			Response.Write("<TD bgcolor=green align='center'><b>FINALIZADA "&fecha(r("fechafin"))&"</b></TD>")
		else
			Response.Write("<TD align='center'>"&fecha(r("fechafin"))&"</TD>")
		end if
		
		response.write "<td><a href='../subastas/borrar.asp?id="&r("id")&"' target='borrar' onclick=window.open('../subastas/borrar.asp?id="&r("id")&"','borrar','menubar=no,scrollbars=no,width=500,height=400')><img src='../images/papelera.gif' border='0'></a></Td>"

		Response.Write("</TR>")
		response.write("<tr bgcolor='blue'><td colspan='8'><img src='../images/x.gif' heigth='1'></td></tr>")
	
		r.MoveNext
		CuantosRegistros = CuantosRegistros + 1
	wend
	Response.Write("</TABLE>")
end sub

sub listapujas(usuario,conexion)
'Muestra un listado de todas las pujas que ha realizado el usuario y si estan en activo o no
	
	SQL = "select distinct(producto) from puja subasta where usuario = "&usuario
	'Con esta query recupero todas las subastas en las que ha pujado el usuario
	Set r = conexion.execute(SQL)
	CuantosRegistros = 1
	response.write "<TABLE CELLSPACING='0' CELLPADDING='0' BORDER='0' width='100%'>"
	response.write "<tr bgcolor='#ffcc00'><td colspan='2'><b>TITULO</b></td><td><b>FINALIZACION</b></td><td><b>PRECIO SALIDA</b></td><td><b>OFERTANTE</b></td><td><b>PUJA GANADORA</b></td><td><b>GANADOR ACTUAL</b></td></tr>"
	response.write("<tr bgcolor='blue'><td colspan='7'><img src='../images/x.gif' heigth='1'></td></tr>")
	while not r.EOF 
		'Pinto una línea de la tabla por cada registro
		query = "select titulo, categoria, precio_salida, fechafin, ofertante, foto from  subasta where id =" & r("producto")
		Set subasta = conexion.execute(query)

		if (CuantosRegistros mod 2) = 0 then
			Response.Write("<TR bgcolor='#0099ff'>"&VbCrLf)
		else
			Response.Write("<TR>"&VbCrLf)
		end if
		if subasta("foto")="NO" then
			Response.Write("<TD width='25'><img src='../images/x.gif' width='25'></TD>")
		else
			Response.Write("<TD width='25'><img src='../images/foto.gif' width='25'></TD>")
		end if
		
		

		If (compararfecha(Date,CDate(subasta("fechafin")))=1) then
			response.write "<TD>"&subasta("titulo")&"</td>"
			Response.Write("<TD bgcolor=green align='center'><b>FINALIZADA "&fecha(subasta("fechafin"))&"</b></TD>")
		else
			response.write "<td><a href='../subastas/ficha.asp?id="&r("producto")&"' target='ficha' onclick=window.open('../subastas/ficha.asp?id="&r("producto")&"','ficha','menubar=no,scrollbars=yes,width=500,height=450')>"&subasta("titulo")&"<a/></td>"
			Response.Write("<TD align='center'>"&fecha(subasta("fechafin"))&"</TD>")
		end if

		response.write "<td>"&subasta("precio_salida")&" pts.</td>"
		
		response.write "<td><a href='opinion.asp?user="&subasta("ofertante")&"' target='opinion' onclick=window.open('opinion.asp?user="&subasta("ofertante")&"','opinion','menubar=no,scrollbars=yes,width=500,height=450')>"&nickusuario(subasta("ofertante"),conexion)&"<a/></td>"
		
		
		response.write "<td>"&pujamaxima(r("producto"),conexion)&" pts.</td>"
		

		response.write "<td>"&nickusuario(ganadorsubasta(r("producto"),conexion),conexion)&"</td>"
		response.write "</TR>"
		
	
		response.write("<tr bgcolor='blue'><td colspan='7'><img src='../images/x.gif' heigth='1'></td></tr>")
		r.MoveNext
		CuantosRegistros = CuantosRegistros + 1
	wend
	response.write "</table>"
	
end sub

sub datos(usuario,conexion)
	Set r = conexion.execute("select * from usuario where id ="&usuario)
	if r.eof then 
		response.write "NO ES POSIBLE MOSTRAR LOS DATOS DEL USUARIO"
	else
		response.write "<form action='actualizar.asp' method='get'>"
		response.write "<center><table border='0' bgcolor='#ffcc00'>"
  		response.write "<tr><td>Nombre: </td>"
                response.write "<td align='left'><input type='text' name='nombre' value='"&r("nombre")&"'></td></tr>"

  		response.write "<tr><td>Apellidos: </td>"
    		response.write "<td align='left'><input type='text' name='apellidos' value='"&r("apellidos")&"'></td></tr>"
  		response.write "<tr><td>Direccion: </td>"
    		response.write "<td align='left'><input type='text' name='dir' value='"&r("direccion")&"'></td></tr>"
  		response.write "<tr><td>Ciudad: </td>"
    		response.write "<td align='left'><SELECT NAME='ciudad'>"
    		response.write "<OPTION>"&r("ciudad")&"</OPTION>"
    		response.write "<OPTION>A Coru&ntilde;a</OPTION>"
    		response.write "<OPTION>Albacete</OPTION>"
    		response.write "<OPTION>Alicante</OPTION>"
    		response.write "<OPTION>Almer&iacute;a</OPTION>"
    		response.write "<OPTION>Avila</OPTION>"
    		response.write "<OPTION>Badajoz</OPTION>"
    		response.write "<OPTION>Barcelona</OPTION>"
    		response.write "<OPTION>Bilbao</OPTION>"
    		response.write "<OPTION>Burgos</OPTION>"
    		response.write "<OPTION>Caceres</OPTION>"
    		response.write "<OPTION>C&aacute;diz</OPTION>"
    		response.write "<OPTION>Castell&oacute;n</OPTION>"
    		response.write "<OPTION>Ciudad Real</OPTION>"
    		response.write "<OPTION>C&oacute;rdoba</OPTION>"
    		response.write "<OPTION>Cuenca</OPTION>"
    		response.write "<OPTION>Donostia</OPTION>"
    		response.write "<OPTION>Gij&oacute;n</OPTION>"
    		response.write "<OPTION>Girona</OPTION>"
    		response.write "<OPTION>Granada</OPTION>"
    		response.write "<OPTION>Guadalajara</OPTION>"
    		response.write "<OPTION>Huelva</OPTION>"
    		response.write "<OPTION>Huesca</OPTION>"
    		response.write "<OPTION>Ibiza</OPTION>"
    		response.write "<OPTION>Ja&eacute;n</OPTION>"
    		response.write "<OPTION>Las Palmas</OPTION>"
    		response.write "<OPTION>Logro&ntilde;o</OPTION>"
    		response.write "<OPTION>Le&oacute;n</OPTION>"
    		response.write "<OPTION>Lleida</OPTION>"
    		response.write "<OPTION>Lugo</OPTION>"
    		response.write "<OPTION>Madrid</OPTION>"
    		response.write "<OPTION>M&aacute;laga</OPTION>"
    		response.write "<OPTION>Mallorca</OPTION>"
    		response.write "<OPTION>Murcia</OPTION>"
    		response.write "<OPTION>Ourense</OPTION>"
    		response.write "<OPTION>Oviedo</OPTION>"
    		response.write "<OPTION>Pamplona</OPTION>"		
    		response.write "<OPTION>Pontevedra</OPTION>"
    		response.write "<OPTION>Salamanca</OPTION>"
    		response.write "<OPTION>Santander</OPTION>"
    		response.write "<OPTION>Santiago</OPTION>"
    		response.write "<OPTION>Segovia</OPTION>"
    		response.write "<OPTION>Sevilla</OPTION>"
    		response.write "<OPTION>Soria</OPTION>"
    		response.write "<OPTION>Tarragona</OPTION>"
    		response.write "<OPTION>Tenerife</OPTION>"
    		response.write "<OPTION>Teruel</OPTION>"
    		response.write "<OPTION>Toledo</OPTION>"
    		response.write "<OPTION>Valencia</OPTION>"
    		response.write "<OPTION>Valladolid</OPTION>"
    		response.write "<OPTION>Vigo</OPTION>"
    		response.write "<OPTION>Vitoria</OPTION>"
    		response.write "<OPTION>Zamora</OPTION>"
    		response.write "<OPTION>Zaragoza</OPTION></SELECT></td></tr>"
  		response.write "<tr><td>E-mail: </td>"
    		response.write "<td align='left'><input type='text' name='email' value='"&r("email")&"'></td></tr>"
  		response.write "<tr><td>Password: </td>"
    		response.write "<td align='left'><input type='password' name='passwd' value='"&r("passwd")&"'></td></tr>"
  		response.write "<tr><td>Confirmacion password: </td>"
    		response.write "<td align='left'><input type='password' name='repasswd' value='"&r("passwd")&"'></td></tr>"
  		response.write "<tr><td colspan='2'><img src='../images/x.gif' height='40'></td></tr><tr><td></td><td><input type='Submit' value='Actualizar'></td></tr>"
		response.write "</table></center></form>"
	end if
	

end sub
sub opiniones(usuario, conexion)
	Set r = conexion.execute("select * from opinion where ofertante="&usuario)    
	    
	cabecera "opinones recibidas por el usuario: "&nickusuario(Session("usuario"),conexion)
	
	if  r.eof then 
		'No hay opiniones sobre el usuario
		response.write "<h4 align='center'>No hay opinones sobre este usuario.</h4>"
	else
		'Mostramos las opiniones sobre el usuario
		response.write "<center><table CELLSPACING='0' CELLPADDING='0' border='0' width='100%'>"
		response.write "<tr bgcolor='#ffcc00'><td><b>EMISOR</b></td><td><img src='../images/x.gif' width='20'></td><td><b>COMENTARIO</b></td><td><img src='../images/x.gif' width='20'></td><td width='60'><b>FECHA</b></td></tr>"
		response.write("<tr bgcolor='blue'><td colspan='5'><img src='../images/x.gif' heigth='1'></td></tr>")
		cont = 1
		while not r.eof
		
			if (cont mod 2) = 0 then
				Response.Write("<TR bgcolor='#0099ff'>"&VbCrLf)
			else
				Response.Write("<TR>"&VbCrLf)
			end if
		
			response.write "<td valign='top'>"&nickusuario(r("pujador"),conn)&"</td><td><img src='../images/x.gif' width='20'></td>"
			response.write "<td>"&r("comentario")&"</td><td><img src='../images/x.gif' width='20'></td>"
			response.write "<td>"&fecha(r("fecha"))&"</td>"
			response.write "</tr>"
			response.write("<tr bgcolor='blue'><td colspan='5'><img src='../images/x.gif' heigth='1'></td></tr>")
			r.movenext
			cont = cont + 1
		wend
		response.write "</table></center>"
	end if	
	response.write "<br>&nbsp<br>&nbsp"
	Cabecera "Opinar de los usuarios con los que se ha manenido relaciones comerciales"
	'Formulario para que el usuario pueda opininar sobre otros usuario con los que ha mantenido relaciones
	'comerciales
	Dim rep 'Variable para evitar la repeticion de nombres
	rep = ""
	response.write "<center><table border='0' bgcolor='#ffcc00'><form action='opinar.asp' method='post'>"
	'Recuperacion de nombre de los ganadores de las subastas ofertadas por el usuario
	response.write "<tr><td>Usuario: </td><td><select name='usuario'>"
	
	sql = "select id from subasta where ofertante = "&usuario
	Set s = conexion.execute(sql)
	while not s.eof
		finsubasta = subastafinalizada(s("id"),conexion)
		if finsubasta then
			ganador = Cint(ganadorsubasta(s("id"), conexion))
			
			if (ganador <> Cint(usuario)) and (ganador <> -1)then
				if (instr(1,rep,"#"&ganador&"#") = 0)then
					rep = rep & "#"&ganador&"#"
					response.write "<option value='"&ganador&"'>"&nickusuario(ganador,conexion)&"</option>"
				end if		
			end if
		end if
		s.movenext
	wend
	
		
	'recuperacion del nombre del ofertante de las subastas ganadas por el usuario
	sql = "select distinct(producto) as subasta from puja p where usuario="&usuario
	response.write sql
	Set p = conexion.execute(sql)
	
	while not p.eof
		ganador = Cint(ganadorsubasta(p("subasta"), conexion))
				
		if Cint(ganador) = Cint(usuario) and subastafinalizada(p("subasta"),conexion) then
			ofertante = ofertantesubasta(p("subasta"), conexion)
			if ofertante <> Cint(usuario) then
				if (instr(1,rep,"#"&ofertante&"#") = 0)then
					rep = rep & "#"&ofertante&"#"
					response.write "<option value='"&ofertante&"'>"&nickusuario(ofertante,conexion)&"</option>"
				end if		
			end if
		end if
		p.movenext
	wend
	response.write "</td></tr>"
	response.write "<tr><td colspan='2'>OPINION</td></tr>"
	response.write "<tr><td colspan='2'><textarea name='opinion' rows='5'></textarea></td></tr>"
	response.write "<tr><td colspan='2'><input type='submit' value='Enviar opinion'></td></tr>"
	response.write "</form></table></center>"
	
	
	
	
	
end sub

sub desconexion
	Session("usuario") = ""
	response.redirect "../index2.html"
end sub
  
  Set Conn=Server.CreateObject("ADOdb.Connection")
  conectarBD(Conn)

  
  if request("action") ="" then
  'Bienvenida
  	presinit
  	Menu
	response.write "<center><table width='100%' height='80%'>"
	response.write "<tr height='90%'>"
	response.write "<td>&nbsp</td>"
	response.write "</tr>"
	response.write "<tr height='10%'>"
	response.write "<td align='center'>Si quieres darte de baja en Deusto Bazar.com, pulsa <a href='baja.asp'>Aqui</a>.</td>"
	response.write "</tr>"
	response.write "</table></center>"
	presfin
     
     
  else
  	select case request("action") 

  		case "1"
  			presinit
  			Menu
  			cabecera "Subastas ofertadas por: "&nickusuario(session("usuario"),conn)
  			listasubastas Session("usuario"), conn
  			presfin
  		case "2"
  			presinit
  			Menu
  			cabecera "Pujas realizadas por: "&nickusuario(session("usuario"),conn)
  			listapujas Session("usuario"), conn
  			presfin
  		case "3"
  			presinit
  			Menu
  			cabecera "Datos personales de: "&nickusuario(session("usuario"),conn)
  			datos Session("usuario"), conn
  			presfin
  		case "4"
  			presinit
  			Menu
  			cabecera "Opiniones de: "&nickusuario(session("usuario"),conn)
  			opiniones Session("usuario"), conn
  			presfin
  			
  		case "5"
  			desconexion
 			
  	end select
  end if
  
 
  
  
  
  
%>
