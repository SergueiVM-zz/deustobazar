<html>
<head>
<LINK REL="stylesheet" HREF="../css/deusto.css" TYPE="text/css">
</head>
<body>
aqui empieza el asp<br>
<%
        
	
	Set Conn=Server.CreateObject("ADOdb.Connection")
	
	'conn.ConnectionString = 
	response.write Time()
	response.write "<br>OPen"
	Conn.Open "DSN=bazar;uid=bazar;pwd=bazar;"
	'Conn.Open "DSN=bazar"
	

	response.write "Abierto"
	
  
  	Set rs = Conn.Execute("Select * from categoria")
  	
  	while not rs.EOF
  	        Query = " insert into categoria values("
  	        query = query & rs(0) &",'"
  	        query = query & rs(1) &"',"
  	        query = query & rs(2) &");<br>"
  	        response.write query
 		rs.movenext
  	wend
  	conn.close
  	response.write "Txapado"
  
  



%>
<br>Aqui acaba el asp
</body>
</html>