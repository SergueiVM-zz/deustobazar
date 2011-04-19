<HTML>
 <HEAD>
   <TITLE>Amena</TITLE>
   
   


<!------------------------FUNCIONES PARA PONER LOS MENUS-------------------------------->
 <script language="JavaScript" src="cambio.js"></script> 
<SCRIPT LANGUAGE="JavaScript">
ns4 = (document.layers)? true:false
ie4 = (document.all)? true:false
if (document.layers) {n=1;ie=0}
if (document.all) {n=0;ie=1}
//alert (n)
//alert (ie)
var esperando = null


        
        function colocar (numero, posicion)
        {
            if(ie) {
                        eval ('items' + numero + '.style.top = posicion') 
                   }
                   
            if(n) {
                        eval ('document.layers.items' + numero + '.top = posicion') 
                  }  
        }
/*
        function colocar (numero, posicion)
        {
            if(ie) {
            
                        //alert(numero)
                        //alert(posicion)
                        if (eval ('parseInt(items' + numero + '.style.top.split("px")) < posicion')) 
                        {
                            eval ('items' + numero + '.style.top = parseInt(items' + numero + '.style.top.split("px")) + 1');
                            eval("esperando=setTimeout('colocar(" + numero + "," + posicion + ")',5)");
                        }
                   }
                   
            if(n) {
                        //alert(numero)
                        //alert(posicion)
                        if (eval ('document.layers.items' + numero + '.top < posicion')) 
                        {
                            eval ('document.layers.items' + numero + '.top = document.layers.items' + numero + '.top + 1') 
                            eval("esperando=setTimeout('colocar(" + numero + "," + posicion + ")',5)")
                        }
                  }  
        }
*/        
        function bajar_opcion(i)
        {
        scroll_links = 0
            if(ie) {
                    //alert ('colocar(' + i + ',' + alturanueva + ')')
                   
                    eval('colocar(' + i + ',' + alturanueva + ')')
//                    eval('alturanueva = alturanueva + parseInt(items' + i + '.scrollHeight.split("px")) + 10')
                    eval('alturanueva = alturanueva + items' + i + '.scrollHeight + 10')
                    //alert(alturanueva);
                        if (alturanueva >= 376)
                            {
                           // alert('aparece scroll');
                            scroll_links = 1
                            }
                    if (i < 15)
                        {
                             eval("esperando=setTimeout('bajar_opcion(" + (i + 1) + ")',2)")           
                        }else{
                        init()
                        }
                    }
                
            if(n) {
                    eval ('colocar(' + i + ',' + alturanueva + ')')
                    eval('alturanueva = alturanueva + document.layers.items' + i + '.document.height + 10')
                    //alert(alturanueva);
                        if (alturanueva >= 376) 
                            {
                            //alert('aparece scroll');
                            scroll_links = 1
                            }
                    if (i < 15)
                        {
                        eval("esperando=setTimeout('bajar_opcion(" + (i + 1) + ")',2)")   
                        }else{
                        init()
                        }
                   }         
        }
        
        function pintar_menu()
        {
            if(ie) {
                    items1.style.top = 75
                   alturanueva = 75 + items1.scrollHeight + 10
                  // alert(alturanueva);
                    bajar_opcion(2)
                   }
                  
            if(n) {
                    document.layers.items1.top = 75
                    alturanueva = 75 + document.layers.items1.document.height + 10
                    bajar_opcion(2)
                  }    
        }   



<!------------------------FUNCIONES PARA EL SCROLL-------------------------------------->
var esperando = null

function mostrar(capa){
        if (n) {
                eval("document." + capa + ".visibility='show'")
        }
        if (ie) {
                eval(capa + ".style.visibility='visible'")
        }
}

function ocultar(capa){
        if (n) {
                eval("document." + capa + ".visibility='hide'")
        }
        if (ie) {
                eval(capa + ".style.visibility='hidden'")
        }
}

//function init(){
// 	n = (document.layers) ? 1:0
//	ie = (document.all) ? 1:0
//	speed = 0
//	statdyn = "dynamic"
//	started = 0
//	if (n){
//		s1 = document.lista
//		maxw = s1.clip.width
//		}
//	if (ie){
//		s1 = document.all.lista.style
//		maxw = s1.pixelWidth
//		}
//	document.onmousemove = mouseMove
//	
//	if (n) document.captureEvents(Event.MOUSEMOVE)
//
//        if (ie) {
//                lista.style.height = '100%';
//       }
//}

function init()
{
	if (scroll_links == 1)
    {   
        if (n)  
            {
               document.layers.scroll1.visibility='show'
            }
                
            
        if (ie) 
            {
               scroll1.style.visibility='visible'
            }
         
	speed = 0
	statdyn = "dynamic"
	started = 0
	document.onmousemove = mouseMove
	
	if (n) document.captureEvents(Event.MOUSEMOVE)
    }
    else
            {
           // alert('no sale');
            }
    
}


function mouseMove(e) {
	if (n) {var x=e.pageX; var y=e.pageY}
	if (ie) {var x=event.x; var y=event.y}
	if(x > 130 && x < 150 && y > 120 && y < 307){
		speed = Math.round((y-213)/5)
		if (started == 0) {
			started = 1
			slide()
		}
	}
	else {
		speed = 0
		started = 0
	}
}

function slide(){
	if(statdyn == "dynamic"){
		scroll(-speed)
		}
	if (started != 0) setTimeout("slide()",10)
}

function scroll(cantidad){

                if(ie) {
                        valor = parseInt(items1.style.top) + cantidad;
                        if(((cantidad > 0)&&(valor <= 75))||(isNaN(valor))||(cantidad<0)) {
                                for (i=1;i <= 15;i++)
                                   {
                                    eval("valor = parseInt(items" + i + ".style.top) + cantidad");
                                    if (isNaN(valor)) { valor = 0}
                                    eval("items" + i + ".style.top = valor");
                                   }
                        }
                }
                
                if(n) {
                        valor = parseInt(document.items1.top) + cantidad
                        if(((cantidad > 0)&&(valor <= 110))||(isNaN(valor))||(cantidad<0)) {
                               for (i=1;i <= 15;i++)
                                   {
                                    eval("valor = parseInt(document.items" + i + ".top) + cantidad");
                                    if (isNaN(valor)) { valor = 0}
                                    eval("document.items" + i + ".top = valor");
                                    }
                        }
                }                       
}

function cambio(capa,Nombre,Img){
        if (n) eval("document.layers['" + capa + "'].document." + Nombre + ".src = '" + Img + "'")
        else if (ie) eval(Nombre + '.src = "' + Img + '"')
}

</script>

<STYLE TYPE='text/css'>  P  {}
  
A.otroA  {font-family : Arial,Helvetica,SanSeriff; color : blue; text-decoration: none;	font-size : 12px; font-weight: bold;}
A.negro {font-family : Arial,Helvetica,SanSeriff; color : red; text-decoration: none; font-size : 12px; font-weight: bold;} 
A.blanco {font-family : Arial,Helvetica,SanSeriff; color : blue; text-decoration: none; font-size : 12px; font-weight: bold;} 

.Anegro  {
  	font-family : Arial,Helvetica,SanSeriff;
  	color : black;
  	text-decoration: none;
	font-size : 12px;
	font-weight: bold;
  }
  
</STYLE>



 </HEAD>
 
 <BODY>
 <!-- Definición de estilos -->


<div  id="cabecera" style="position:absolute; left:0px; top:0px; width:150px; height:60px; z-index:20;  border: 1px none #000000; visibility: visible;">
<!-- <img src="/images/packs.gif"> -->

</div>

<div id="scroll1" style="position:absolute; left:125px; top:120px; width:41px; height:134px; z-index:5; visibility: hidden">
        <img name="scroll" border="0" src="scroll.gif" alt="scroll">
</div>

        


			
<div id="items1" style="position:absolute; left:10px; top:0px; width:100px; height:15px; z-index:1; overflow: visible">
<A class="blanco" HREF="pack.asp?id=279" TARGET="DER"  onMouseOver="linkOver('items1','pack.asp?id=279','Motorola TimePort P7389')">Motorola TimePort P7389</A>
</div>
	
<% 
  Set Conn=Server.CreateObject("ADOdb.Connection")
  Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.Mappath("bazar.mdb") 

  Set P = Conn.Execute("Select * from categoria where id="&request("id"))
  
  dim pos
  pos = 0

  if P.EOF then

  else
    P.MoveFirst
    response.write("<tr><td><A href='categorias.asp?id=" & P("cat_padre") & "'><img src='images/back.gif' border='0'></a></td></tr>")

  end if
	
  Set RS = Conn.Execute("SELECT * FROM categoria where cat_padre ="&request("id"))
  If RS.EOF Then
    Response.Write "La consulta devuelve un número de registros cero"
  Else
    
    RS.MoveFirst
    While Not RS.EOF
      pos = pos + 1

      Set cont = Conn.Execute("Select count(*) from categoria where cat_padre="& RS("id"))
      if cont.eof then
      else
        cont.MoveFirst     

        if ( cont(0) >0) then
'Hojas que tienen mas hojas        	
            response.write "<div id=items" + pos +" style=position:absolute; left:10px; top:0px; width:100px; height:15px; z-index:1; overflow: visible>"
            response.write "<A class=blanco HREF='categorias.asp?id="&RS("id")& "' onMouseOver=linkOver('items"&pos&','categorias.asp?id="&RS("id")& "',"&rs("id")&")>"&rs("id")&"</A></div>"
     

'          Response.Write("<tr><td><A href='categorias.asp?id=" & RS("id") & "'>" & RS("descripcion") & "</a></td></tr>")
'fin hojas con hijos
	else

rem Aqui se insertara el codigo que se quiera ejecutar cuando se llege a un nodo terminal
rem Actualmente solo muestra el nombre de la categoria, en el futuro tendra un enlace a todos
rem aquellos producto que esten catalogados en dicha categoria mostrando el listado de producto
 

        


rem Aqui termina el area de tratamiento
        end if
      end if

      RS.MoveNext
    Wend
  End If


response.write "<script>"
response.write " cuantos =" & pos
response.write " pintar_menu();"
response.write "</script>"
  
%>


</BODY>
</HTML>
