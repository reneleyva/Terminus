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
        
      
        $( document ).ready(function() {
            $('#msg').hide();
        });
    </script>
    <body>
        <div class="container">
            <h1>Inicia sesión</h1> <br>
            

            <form action="procesos/entrar_proceso.jsp" method="post">
                <label for="correo">Correo</label> <br>
                <input type="text" name="correo" placeholder="email@ciencias.unam.mx" required/> <br>
                <label for="password">Contraseña </label> <br>
                <input id="pass1" type="password"  placeholder="*****" name="password" required/> <br>
                <span id="msg" style="position: absolute;"><p>Nooooope</p></span><br>
                
                <input type="submit" id="entrar" value="Entrar"/>
            </form>
        </div>
    </body>
</html>
