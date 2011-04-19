/*
   Libreria de funciones JavaScript 1.2
   Proyecto de fin de carrera "Deusto Bazar.com"
   Universidad de Deusto. Curso 2000 - 2001
   Serguei Vicario y Francico Javier Gonzalez

   Autor: Serguei Vicario (Smurf Dad)
   E-mail: smurfdad@wanadoo.es
           1sevicar@rigel.deuto.es
   Web:    http://smurfdad.pagina.de

   Se prohibe expresamente la utilizacion de esta libreria total o
   parcialmente sin por lo menos enviarle un e-mail a su autor para
   su regocijo personal.
                             Firmado.
                                  Smurf Dad
   
*/

function valiemail(text) {
  if (text.value == "" || text.value.indexOf('@', 0) == -1) 
        return false;
  else return true;
}

function valipass(pass, repass) {
  if (pass.value == repass.value && pass.value != "") 
        return true;
  else return false;
}
function comprobar(nombre, apellidos, dir, ciudad, user, email,pass, repass) {
  var cmail = valiemail(email);
  var cpass = valipass(pass, repass)

  if (cmail && cpass)
        alert("CORRECTO");
  else alert("NO CORRECTO");
}
