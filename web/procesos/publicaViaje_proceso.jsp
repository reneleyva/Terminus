<%@page import="controlador.Ruta;"%>
<%@page import="controlador.Usuario;"%>

<%
    
    String destino = request.getParameter("destino");
    String salida = request.getParameter("salida");
    String horas = request.getParameter("horas");
    
    String destino_dir = request.getParameter("destino_input");
    String salida_dir = request.getParameter("salida_input");
    
    String minutos = request.getParameter("minutos");
    String meridiem = request.getParameter("meridiem");
    String fecha = request.getParameter("dia");
    fecha += "/" + request.getParameter("mes") + "/2016";
    int cupo = Integer.parseInt(request.getParameter("cupo"));
    int precio = Integer.parseInt(request.getParameter("precio"));
    
    Ruta ruta = new Ruta();
    Usuario user = (Usuario) session.getAttribute("usuario");
    
    if(meridiem.equals(new String("pm")) && !horas.equals(new String("12"))) {
        Integer h = Integer.parseInt(horas) + 12; 
        horas = h.toString();
    }

    boolean estado = false;

    ruta.conecta();
    int id = ruta.getMaximoId();
    
    id += 1;
    estado = ruta.guardaRuta(id, destino, salida, fecha, horas + ":" + minutos, cupo, 
            user.getIdusuario(), precio, destino_dir, salida_dir);
    ruta.desconecta();

    if (estado) {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Se registró el viaje correctamente!');");
        out.println("location='../paginaUsuario.jsp';");
        out.println("</script>");
    } else {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Hubo un error registrando el viaje.');");
        out.println("location='../paginaUsuario.jsp';");
        out.println("</script>");
    }
%>