<%@page import="controlador.Usuario;"%>
<%@page import="controlador.Notificacion;"%>
<%@page import="java.util.ArrayList;"%>

<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    
    Notificacion n = new Notificacion();
    ArrayList noti = new ArrayList();
    
    n.conecta();
    noti = n.getNotificaciones();
    n.desconecta();
    
    for (Object o : noti) {
        Notificacion current = (Notificacion) o;
        
        if (current.getIdUsuario() == user.getIdusuario()) {
            current.conecta();
            current.notificacionVista(current.getId());
            current.desconecta();
        }
    }
    
    out.println("<script type=\"text/javascript\">");
    out.println("location='../paginaUsuario.jsp';");
    out.println("</script>");
    
%>
