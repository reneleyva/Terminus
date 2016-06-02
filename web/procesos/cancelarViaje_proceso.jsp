<%@page import="controlador.Usuario;"%>
<%@page import="controlador.Viaje;"%>
<%@page import="controlador.Notificacion;"%>
<%@page import="controlador.Conexion;"%>
<%@page import="controlador.Ruta;"%>
<%@page import="java.util.ArrayList;"%>
<%@page import="java.util.Date;"%>
<%@page import="java.text.DateFormat;"%>
<%@page import="java.text.SimpleDateFormat;"%>

<%
    /*Comprobar que el usuario no esté tomando ya otro viaje
      
      restar 1 al cupo del viaje en caso contrario.
    */
    int idRuta = Integer.parseInt(request.getParameter("idViaje_cancelar"));
    Usuario user = (Usuario) session.getAttribute("usuario");
    
    boolean estado = false;
    
    Viaje v = new Viaje();
    v.conecta();
    estado = v.cancelaViaje(idRuta, user.getIdusuario());
    estado = v.sumaAsiento(idRuta);
    v.desconecta();
    
    
    /***Busco la ruta por su id e identifico quien lo publicó***/
    Ruta r = new Ruta();
    ArrayList rutas = new ArrayList();
    
    r.conecta();
    rutas = r.getRutas();
    r.desconecta();
            
    int idPrestador = 0;
    for (Object obj: rutas) {
        Ruta rute = (Ruta) obj;
        System.out.println(rute.toString());
        if (rute.getId() == idRuta) {
            idPrestador = rute.getIdUsuario();
        }
    }
            
    //No cre que pase
    if (idPrestador == 0) {
        throw new Exception("Whaaaaaaaaaat");
    }
            
    Notificacion noti = new Notificacion();
    noti.conecta();
    //Necesito max id construir un mensaje, y fecha. 
            
    int idNoti = noti.getMaximoId()+1;
    String mensaje = "El usuario " + user.getNombre() + "" + user.getApellido() + 
    " Ha cancelado la participación en el viaje que usted publicó!";

    System.out.println(mensaje);
    //Fecha de Hoy
    Date date = new Date();
    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String fecha = dateFormat.format(date);
            
    noti.guarda(idNoti, idPrestador, mensaje, fecha);
    noti.desconecta();
    /*FIN DE LA NOTIFICACION*/
    
   
      
    
    if (estado) {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Has cancelado un Viaje!!');");
        out.println("location='../paginaUsuario.jsp';");
        out.println("</script>");
    } else {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Hubo un error al cancelar el viaje.');");
        out.println("location='../paginaUsuario.jsp';");
        out.println("</script>");
    }
%>

<a href="index.html">Volver a Inicio</a>