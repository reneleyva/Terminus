<%@page import="controlador.Usuario;"%>

<%
    String nombre = request.getParameter("nombre");
    String apellidos = request.getParameter("apellidos");
    String correo = request.getParameter("correo");
    String password = request.getParameter("password");
    //int id = Integer.parseInt(request.getParameter("id_max"));
    Usuario user = new Usuario();
    
    boolean estado = false;

    user.conecta();
    int id = user.getMaximoId();
    id += 1;
    
    if(nombre != null && apellidos != null && correo != null && password != null) {
        estado = user.guarda(id, nombre, apellidos, correo, password, "resources/img/default_user.png");
        user.setNombre(nombre);
        user.setApellido(apellidos);
        user.setCorreo(correo);
        user.setPassword(password);
        user.setIdusuario(id);

        session.setAttribute("usuario", user); //MAnda al atributo al espacio
    }
    
    user.desconecta();
    
   
    
    
    if (estado) {
        out.println("<script type=\"text/javascript\">");
        out.println("location='../paginaUsuario.jsp';");
        out.println("</script>");
    } else {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Algo salío mal!!');");
        out.println("location='../registrarse.jsp';");
        out.println("</script>");
    }
%>

<a href="index.html">Volver a Inicio</a>