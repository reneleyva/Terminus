<%-- 
    Document   : Chrono
    Created on : 23/05/2016, 07:52:38 PM
    Author     : Xavier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controlador.Ruta;"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chronos...</title>
        <script src="resources/js/jquery.js"></script>
        <script src="resources/js/jquery.countdown.min.js"></script>
        
    </head>
    <body>
        <h1>Countdown Clock</h1>
        <div class="clock">
            LOL
        </div>
        <script type="text/javascript">
           $(".clock")
           .countdown("01/01/2018", function(event) {
             $(this).text(
               event.strftime('faltan: %D days %H horas %M minutos %S')
             );
           });
         </script>
    </body>
</html>