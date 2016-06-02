<%@page import="java.util.ArrayList;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Terminus</title>
        <link rel="stylesheet" href="resources/css/style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    </head>
    <script>
        
        function checkRegexp( o, regexp) {
            if ( !( regexp.test( o ) ) ) {
              $('#msgCorreo').show("fast");
              return false;
            } else {
              return true;
            }
        }
    
        function checkForm() {
            var pass1 = $('#pass1').val();
            var pass2 = $('#pass2').val();
            var correo = $('#correo').val();
            var emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
            //alert("pass1: " + pass1 + " pass2: " + pass2);
            var m = $('#msg');
            m.hide("fast");
            if (pass1 !== pass2) {
                m.text("Las constraseñas no coincicen!");
                m.show("fast");
                return false;
            } else if (pass1.length < 5) {
               
                m.text("La constraseña debe ser de almenos 5 caracteres!");
                m.show("fast");
                return false;
            } 
             else
                 return checkRegexp(correo, emailRegex);
        };
        
        $( document ).ready(function() {
            $('#msg').hide();
          });
    </script>
    <body>
        <div class="container">
            <h1>Registrarse</h1> <br>
            <h4>
                <% 
                    
                    
                %>
            </h4>

            <form action="procesos/registrarse_proceso.jsp" method="post" onSubmit="return checkForm()">
                <label for="nombre">Nombre </label> <br>
                <input type="text" name="nombre" required/> <br>
                <label for="apellidos">Apellidos </label> <br>
                <input type="text" name="apellidos" required/> <br>
                <label for="correo">Correo </label> <br>
                <input type="text" id="correo" name="correo" required/> <span id="msgCorreo" style="position: absolute;display:none;">Correo no válido chaval</span><br>
                <label for="password">Contraseña </label> <br>
                <input id="pass1" type="password" name="password" required/> <br>
                <label for="password1">Repite contraseña </label> <br>
                <input id="pass2" type="password" name="password1"  required/><span id="msg" style="position: absolute;">Las contraseñas no coinciden</span><br><br>
                
                <input type="submit" value="Registrarse"/>
            </form>
        </div>
    </body>
</html>
