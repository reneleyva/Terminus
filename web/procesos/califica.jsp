<%@page import="controlador.Usuario;"%>
<%@page import="controlador.Calificacion;"%>
<%@page import="controlador.Notificacion;"%>
<%@page import="java.util.Date;"%>
<%@page import="java.text.DateFormat;"%>
<%@page import="java.text.SimpleDateFormat;"%>

<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
    int idRuta = Integer.parseInt(request.getParameter("idRuta"));
    double rating = Double.parseDouble(request.getParameter("rating"));
    
    boolean estado = false;
    
    Calificacion c = new Calificacion();
    c.conecta();
    int id = c.getMaximoId();
    estado = c.guardaCalificacion(id+1, idUsuario, idRuta, rating);
    
    estado = c.viajeCalificado(user.getIdusuario(), idRuta);  
    c.desconecta();
    
    Notificacion noti = new Notificacion();
    noti.conecta();
    //Necesito max id construir un mensaje, y fecha. 
            
    int idNoti = noti.getMaximoId()+1;
    String mensaje = "El usuario " + user.getNombre() + " " + user.getApellido() + 
    " Te ha calificado con: " + rating + " estrellas!";

    System.out.println(mensaje);
    //Fecha de Hoy
    Date date = new Date();
    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String fecha = dateFormat.format(date);
            
    noti.guarda(idNoti, idUsuario, mensaje, fecha);
    noti.desconecta();
    /*FIN DE LA NOTIFICACION*/
   
    
    
    if (estado) {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Gracias por calificar.');");
        out.println("location='../paginaUsuario.jsp';");
        out.println("</script>");
    } else {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Hubo un error al calificar.');");
        out.println("location='../editarPerfil.jsp';");
        out.println("</script>");
    }
%>
