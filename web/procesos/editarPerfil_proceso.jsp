<%@page import="controlador.Usuario;"%>

<%
    String nombre = request.getParameter("nombre");
    String apellidos = request.getParameter("apellidos");
    String correo = request.getParameter("correo");
    String password = request.getParameter("password");
    //int id = Integer.parseInt(request.getParameter("id_max"));
    Usuario user = (Usuario) session.getAttribute("usuario");
    
    boolean estado = false;

    user.conecta();
    estado = user.actualiza(user.getIdusuario(), nombre, apellidos, correo, password, "");
    user.desconecta();
    
    
    if (estado) {
        out.println("<script type=\"text/javascript\">");
        
        out.println("location='../editarPerfil.jsp';");
        out.println("</script>");
    } else {
        out.println("<script type=\"text/javascript\">");
        out.println("location='../editarPerfil.jsp';");
        out.println("</script>");
    }
%>

<a href="index.html">Volver a Inicio</a>