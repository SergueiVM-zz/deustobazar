<html>
<head>
<LINK REL="stylesheet" HREF="../css/deusto.css" TYPE="text/css">
</head>
<body background="../images/fondo.jpg">
<!--#include file="../inc/bd.inc"-->
<!--#include file="../inc/utils.inc"-->
<%
	Set Conn=Server.CreateObject("ADOdb.Connection")
 	conectarBD(conn)
 	cabecera "ALTA DE SUBASTAS EN DEUSTO BAZAR.COM (PASO 2)"
	
%>
<h4 align="justify">Por ultimo, debes rellenar la ficha del producto que quieres subastar, esta ficha debe ser lo más completa posible
para que de esta forma tus posibles compradores dispongan de la mayor informacion del producto.</h4>

<form action="subasta.asp" method="post">
<center><table border="0" bgcolor="#ffcc00">
  <tr>
    <td valign="top"><p class="instr">Titulo: </td>
    <td align="left"><input type="text" name="titulo" SIZE="20" MAXLENGTH="20"></td>
  </tr>

  <tr>
    <td valign="top"><p class="instr">Observaciones: </td>
    <td align="left"><textarea name="observaciones" rows="10" cols="30"></textarea></td>
  </tr>
  <tr>
    <td valign="top"><p class="instr">Precio Salida: </td>
    <td align="left"><input type="text" name="precio_salida">PTS.</td>
  </tr>
  <tr>
    <td valign="top"><p class="instr">Duracion: </td>
    <td align="left"><SELECT NAME="dur">
    <OPTION value="1">1 dia</OPTION>
    <OPTION value="7">1 semana</OPTION>
    <OPTION value="15">15 dias</OPTION>
    <OPTION value="30">1 mes</OPTION>
</SELECT></td>
  </tr>
  <tr>
    <td valign="top"><p class="instr">Estado: </td>
    <td align="left"><select name="estado">
  

<%
  	
  	Set rs = Conn.Execute("Select * from estado where id<>0 order by id")
  	
  	while not rs.EOF
  		response.write "<option value='"&rs("id")&"'>"&rs("descripcion")&"</option>"
  		rs.movenext
  	wend
  	response.write "</select></td></tr>"
  	response.write "<input type='hidden' name='cat' value='"&request("cat")&"'>"
  
%>
  <tr>
    <td colspan="2">&nbsp</td>
  </tr>
<%
if (Session("usuario")="") then
  response.write "<tr><td valign='top'><p class='instr'>Usuario: </td><td align='left'><input type='text' name='user'></td></tr>"
  response.write "<tr><td valign='top'><p class='instr'>Password: </td><td align='left'><input type='password' name='pass'></td></tr>"
end if
  
%>
  <tr>
    <td align="center" colspan="2"><input type="Submit" value="Alta subasta"><input type="reset" value="Borrar Formulario"></td>
  </tr>
</table></center>
</form>  

</body>
</html>