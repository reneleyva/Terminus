<%@page import="controlador.Usuario;"%>
<%@page import="java.util.ArrayList;"%>
<%
    String correo = request.getParameter("correo");
    String password = request.getParameter("password");
    //int id = Integer.parseInt(request.getParameter("id_max"));
    Usuario user = new Usuario();
    ArrayList usuarios = new ArrayList();
    
    boolean estado = false;

    user.conecta();
    usuarios = user.getUsuarios();
    user.desconecta();
    
    Usuario entrar = new Usuario();
    for (Object o : usuarios) {
        Usuario u = (Usuario) o;
        if (u.getCorreo().equals(correo)) {
            if (u.getPassword().equals(password)) {
                estado = true;
                entrar = u;
            }
                
        }
    }
    
    session.setAttribute("usuario", entrar); //MAnda al atributo al espacio
    
    if (estado) {
        out.println("<script type=\"text/javascript\">");
        out.println("location='../paginaUsuario.jsp';");
        out.println("alert('Bienvenido "+entrar.getNombre()+"');");
        out.println("</script>");
    } else {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('NOPE!!');");
        out.println("location='../entrar.jsp';");
        out.println("</script>");
        
        out.println("<script>");
        out.println("$('#msg').show();");
        out.println("</script>");
    }
%>