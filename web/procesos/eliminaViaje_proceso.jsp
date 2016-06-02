<%@page import="controlador.Usuario;"%>
<%@page import="controlador.Ruta;"%>
<%@page import="controlador.Notificacion;"%>
<%@page import="controlador.Viaje;"%>
<%@page import="java.util.ArrayList;"%>
<%@page import="java.util.Date;"%>
<%@page import="java.text.DateFormat;"%>
<%@page import="java.text.SimpleDateFormat;"%>

<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    int id = Integer.parseInt(request.getParameter("viajeId"));
    Ruta ruta = new Ruta();
    boolean estado = false;

    Viaje v = new Viaje();
    ArrayList viajes = new ArrayList();
    v.conecta();
    viajes = v.getViajes();
    v.desconecta();
    
    for (Object o : viajes ) {
        Viaje current = (Viaje) o;
        if (current.getIdRuta() == id) {
            //SE les notifica a todos
            Notificacion noti = new Notificacion();
            noti.conecta();
            //Necesito max id construir un mensaje, y fecha. 

            int idNoti = noti.getMaximoId()+1;
            String mensaje = "El usuario " + user.getNombre() + "" + user.getApellido() + 
            "Ha cancelado el viaje que usted tomó!";

            System.out.println(mensaje);
            //Fecha de Hoy
            Date date = new Date();
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            String fecha = dateFormat.format(date);

            noti.guarda(idNoti, current.getIdUsuario(), mensaje, fecha);
            noti.desconecta();
            /*FIN DE LA NOTIFICACION*/
        }
    }
    
    
    
    
    ruta.conecta();
    estado = ruta.elimina(id);
    ruta.desconecta();
    
    if (estado) {
        out.println("<script type=\"text/javascript\">");
         out.println("alert('Se eliminó exitosamente!!.');");
        out.println("location='../administrarRuta.jsp';");
        out.println("</script>");
    } else {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Hubo un error al eliminar.');");
        out.println("location='../administrarRuta.jsp';");
        out.println("</script>");
    }
%>