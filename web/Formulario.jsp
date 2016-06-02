<%-- 
    Document   : Formulario
    Created on : 14/05/2016, 08:54:30 PM
    Author     : Xavier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario</title>
    </head>
    <body>
        <h1>Guardar Imagenes</h1>
        <img src="resources/img/default_user.png" onclick="guardarImagenFichero(this)">
        <form action="${pageContext.request.contextPath}/Uploader" enctype="MULTIPART/FORM-DATA" method="get">
            <input type="file" name="file" value="Selecciona tu imagen:"/><br/>
            <input type="submit" value="Cargar" />
        </form>
    </body>
</html>
