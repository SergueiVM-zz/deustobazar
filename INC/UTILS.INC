<%
function fecha(fech)
'Funcion que se le introduce una variable de tipo fecha y devuelve un string con la fecha en
'formato DD/MM/AA

	cadena = ""
	cadena = day(fech) & "-" & month(fech) &"-"& year(fech)
	fecha = cadena
end function

function compararfecha(fech1, fech2)
'0 Las fechas son iguales
'1 La fecha 1 es mayor que la fecha 2
'2 La fecha 2 es mayor que la fecha 1
'Tomamos como mayor a la fecha que este mas lejos del año 0, es decir 2000 es mayor que 1999
	if (Cint(year(fech1)) > Cint(year(fech2))) then 
		
		compararfecha = 1
	else
		if (Cint(year(fech1)) < Cint(year(fech2))) then 
			
			compararfecha = 2
		else
			'Comprobamos el mes
			if (Cint(month(fech1)) > Cint(month(fech2))) then 
				compartarfecha = 1
			else
				if (Cint(month(fech1)) < Cint(month(fech2))) then 
					compararfecha = 2
				else
					'Comparamos el dia
					if (Cint(day(fech1)) > Cint(day(fech2))) then 
						compararfecha = 1
					else
						if (Cint(day(fech1)) < Cint(day(fech2))) then 
							compararfecha = 2
						else			
							compararfecha = 0
						end if
					end if
				end if
			end if
		end if
	end if
end function

sub linea(str)
   response.write str&"<br>"
end sub
sub mensaje (texto)
response.write "<center><table CELLPADDING=0 CELLSPACING=0 BORDER=0 width='70%' height='30%'>" ' 
response.write("<tr><td colspan='3' bgcolor='blue' height='1'><img src='images/x.gif' height='1'></td></tr>")

response.write "<tr><td bgcolor='blue'><img src='../images/x.gif' width='1'></td>"
response.write "<td align='center' valign=middle><p class='instr'><font size=+3>"&texto&"</font></td>"
response.write "<td bgcolor='blue'><img src='../images/x.gif' width='1'></td></tr>"

response.write("<tr><td colspan='3' bgcolor='blue' height='1'><img src='images/x.gif' height='1'></td></tr>")
response.write "</table></center>"
end sub

sub cabecera(titulo)
response.write "<center><table width='100%' CELLPADDING='0' CELLSPACING='0' BORDER='0'><tr bgcolor='#ffcc00'><td align='right'><B>"
response.write UCase(titulo)
response.write "</B></td></tr><tr><td><img src='../images/x.gif' border='0' height='30'></td></tr></table></center>"
end sub

sub msg(mensaje)
response.write "<script>alert('"&mensaje&"')</script>"
end sub


%>