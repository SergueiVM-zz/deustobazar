<%
sub conectarBD(conexion)
	conexion.open "DSN=bazar;uid=bazar;pwd=bazar;" 
end sub
function nuevoID(conexion, tabla)
	SQL = "select max(id) from "&tabla
	Set r = conexion.execute(SQL)
	aux = Cint(1)
	if not r.eof then 
		if isnull(r(0)) then
			aux = CInt(1)
		else
			aux = CInt(r(0))
			aux = aux + 1
		end if
	end if
	nuevoID = aux
end function
function pathcategoria (cat, conexion)
'Funcion que se le introduce un codigo de categoria y una conexion a la base de datos
'y devuelve el path de categorias hasta la categoria padre	
	Set r = conexion.execute("select * from categoria where id ="&cat)
	aux = ""
	if not r.eof then 
		if (CInt(r("cat_padre")) = 0 )then
			aux = r("descripcion")
		else
			aux = pathcategoria(r("cat_padre"),conexion) &" > "& r("descripcion")& aux
		end if
	else
		response.write "No hay resultados"
	end if
        pathcategoria = aux
end function
function subcategorias (cat, conexion)
'Funcion que se le introduce un codigo de categoria y una conexion a la base de datos
'y devuelve los codigos de categoria hijas separados por comas	
	Set r = conexion.execute("select * from categoria where cat_padre ="&cat)
	aux = cat
	while not r.eof
		aux = aux&", "& subcategorias( r("id") ,conexion)
		r.movenext
	wend
        subcategorias = aux
end function
function recuperarUsuario(nick, pass, conexion)
'Se le pasa un username y la password y recupera el ID de dicho usuario si existiera en la base de datos
'En caso de no existir devolvera el valor -1
	Set r = conexion.Execute ("Select id from usuario where nick = '"&nick&"' and passwd='"&pass&"'")
	aux = -1
	if not r.eof then
		aux = CInt(r("id"))
	end if
	recuperarUsuario = aux
end function

function nickusuario(id, conexion)
'Se le pasa un id de usuario y recupera el nick de dicho usuario si existiera en la base de datos
'En caso de no existir devolvera el valor "No disponible"
	Set r = conexion.execute ("Select nick from usuario where id = "&id)
	aux = "No Disponible"
	if not r.eof then
		aux = r("nick")
	end if
	nickusuario = aux
end function

function pujamaxima(subasta, conexion)
	Set p = conexion.execute("Select max(importe) as maximapuja, count(id) as totalpujas from puja where producto="&subasta)
	aux = ""
	if not p.eof then
		if (CInt(p("totalpujas")) = 0 )then
			aux = "No hay pujas"
		else				
			aux = p("maximapuja")
		end if
	else
		aux = "No hay pujas"
	end if
	pujamaxima = aux
end function

function ganadorsubasta(subasta, conexion)
	Set p = conexion.execute("Select max(importe) as maximapuja, count(id) as totalpujas from puja where producto="&subasta)
	importe = -1
	ganador = -1
	if not p.eof then
		if (CInt(p("totalpujas")) > 0 )then
			Set s = conexion.execute("select usuario from  puja where producto ="&subasta&" and importe="&p("maximapuja"))
			if not s.eof then
				ganador = s("usuario")
			end if
		end if
	end if
	ganadorsubasta = ganador
end function

function importePujaCorrecto(subasta, importe, conexion)
	'false = 1
	'Verdadero  = 0
	Set r = conexion.execute ("select * from subasta where id="&subasta)
	pujamax = pujamaxima(subasta,conexion)
	aux = 1
	if not r.eof then
		if (Clng(r("precio_salida")) <= Clng(importe)) then
			if ("No hay pujas" <> pujamax) then
				'Si hay pujas
				if (Clng(importe) <= Clng(pujamax)) then
					aux = 1  'Verdadero el importe supera la mayor puja
				else
					aux = 2 
				end if
			else
				aux = 0 'Verdadero, no hay pujas y supera el precio de salida
			end if			
		end if
	end if
	importePujaCorrecto = aux
end function


%>