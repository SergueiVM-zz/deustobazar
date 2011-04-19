<!--#include file="../inc/bd.inc"-->
<%
  Set Conn=Server.CreateObject("ADOdb.Connection")
  conectarBD(Conn)
  if ((request("user") <> "") and (request("pass")<>"")) then
  	Set compro = Conn.Execute("Select * from usuario where nick = '"&request("user")&"' and passwd='"&request("pass")&"'")
  
  	if not compro.eof then
  		compro.movefirst
  		Session("usuario") = compro("id")
  		response.redirect("main.asp")
  	else
  		response.write "Login incorrecto"
  	end if
  else
  	if (session("usuario") <> "") then
  		response.redirect("main.asp")
  	else
  		response.redirect("logon.html")
  	end if
  end if
%>
