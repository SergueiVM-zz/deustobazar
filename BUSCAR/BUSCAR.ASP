<HTML>
<!--#include file="../inc/utils.inc"-->
<!--#include file="../inc/bd.inc"-->

  
  <HEAD>
    <TITLE>Buscar en DEUSTO BAZAR.com</TITLE>
    <LINK REL="STYLESHEET" TYPE="text/css" HREF="../css/deusto.css">
  </HEAD>
  
  <BODY background="../images/fondo.jpg">
<%
	cabecera "Buscar en deusto bazar.com"
%>
    <h4 align="center">¿Quieres buscar un objeto en DeustoBazar.com?<br>
	Usa la búsqueda avanzada, escribiendo el texto y uno o varios criterios diferentes.
    </h4>
    <CENTER>
    <FORM METHOD="POST" ACTION="busqueda.asp">
    <TABLE WIDTH="440" BORDER="0" bgcolor="#ffcc00">
      <TR>
        <TD WIDTH="90"  ALIGN="LEFT"><p class="instr">Palabra clave: </TD>
        <TD><INPUT TYPE="Text" NAME="clave" VALUE="" SIZE="20"></TD>
      </TR>
      <TR>
        <TD WIDTH="90" ALIGN="LEFT" ><p class="instr">Fotos:</TD>
        <TD WIDTH="338"><INPUT TYPE="CheckBox" NAME="foto">Unicamente los art&iacute;culos con fotos</TD>
      </TR>
      <TR>
        <TD WIDTH="90" ><p class="instr">Categor&iacute;a</TD>
        <TD WIDTH="338">
          <SELECT NAME="categoria">
            <OPTION SELECTED="SELECTED" value="0">-- Todas categor&iacute;as --</OPTION>
<%
         Set Conn=Server.CreateObject("ADOdb.Connection")
         conectarBD(conn)
         
         Set RS = Conn.Execute("select * from categoria where cat_padre=0")
         If RS.EOF Then
           Response.Write "La consulta devuelve un número de registros cero"
         Else
           RS.MoveFirst
           While Not RS.EOF
              Response.Write ("<option value='" & rs("id") & "'>" & rs("descripcion") & "</option>")
              RS.MoveNext
           Wend
         End If

%>
          </select>
        </TD>
      </TR>
     
      <TR>
        <TD WIDTH="90"  ALIGN="left"><p class="instr">Precio: </TD>
        <TD WIDTH="338">Entre
          <INPUT TYPE="Text" NAME="preciomin" VALUE="" SIZE="6"> y
          <INPUT TYPE="text" NAME="preciomax" SIZE="6">
        </TD>
      </TR>

      <TR>
        <TD width=90 align=left><p class="instr">Ciudad: </TD>
	<TD width=338>
	  <select name="ciudad">
            <OPTION></OPTION>
            <OPTION>A Coru&ntilde;a</OPTION>
            <OPTION>Albacete</OPTION>
            <OPTION>Alicante</OPTION>
            <OPTION>Almer&iacute;a</OPTION>
            <OPTION>Avila</OPTION>
            <OPTION>Badajoz</OPTION>
            <OPTION>Barcelona</OPTION>
            <OPTION>Bilbao</OPTION>
            <OPTION>Burgos</OPTION>
            <OPTION>Caceres</OPTION>
            <OPTION>C&aacute;diz</OPTION>
            <OPTION>Castell&oacute;n</OPTION>
            <OPTION>Ciudad Real</OPTION>
            <OPTION>C&oacute;rdoba</OPTION>
            <OPTION>Cuenca</OPTION>
            <OPTION>Donostia</OPTION>
            <OPTION>Gij&oacute;n</OPTION>
            <OPTION>Girona</OPTION>
            <OPTION>Granada</OPTION>
            <OPTION>Guadalajara</OPTION>
            <OPTION>Huelva</OPTION>
            <OPTION>Huesca</OPTION>
            <OPTION>Ibiza</OPTION>
            <OPTION>Ja&eacute;n</OPTION>
            <OPTION>Las Palmas</OPTION>
            <OPTION>Logro&ntilde;o</OPTION>
            <OPTION>Le&oacute;n</OPTION>
            <OPTION>Lleida</OPTION>
            <OPTION>Lugo</OPTION>
            <OPTION>Madrid</OPTION>
            <OPTION>M&aacute;laga</OPTION>
            <OPTION>Mallorca</OPTION>
            <OPTION>Murcia</OPTION>
            <OPTION>Ourense</OPTION>
            <OPTION>Oviedo</OPTION>
            <OPTION>Pamplona</OPTION>
            <OPTION>Pontevedra</OPTION>
            <OPTION>Salamanca</OPTION>
            <OPTION>Santander</OPTION>
            <OPTION>Santiago</OPTION>
            <OPTION>Segovia</OPTION>
            <OPTION>Sevilla</OPTION>
            <OPTION>Soria</OPTION>
            <OPTION>Tarragona</OPTION>
            <OPTION>Tenerife</OPTION>
            <OPTION>Teruel</OPTION>
            <OPTION>Toledo</OPTION>
            <OPTION>Valencia</OPTION>
            <OPTION>Valladolid</OPTION>
            <OPTION>Vigo</OPTION>
            <OPTION>Vitoria</OPTION>
            <OPTION>Zamora</OPTION>
            <OPTION>Zaragoza</OPTION>
          </select>
        </TD>
      </TR>
      <TR>
        <TD COLSPAN="3" ALIGN="center"><input type="submit" value="Buscar"></TD>
      </TR>
    </TABLE>
  </FORM></CENTER>
</BODY>
</HTML>