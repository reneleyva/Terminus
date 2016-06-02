<%@page import="controlador.Ruta;"%>
<%@page import="controlador.Usuario;"%>

<%
    
    String destino = request.getParameter("destino");
    String salida = request.getParameter("salida");
    String horas = request.getParameter("horas");
    String minutos = request.getParameter("minutos");
    String meridiem = request.getParameter("meridiem");
    
    String destino_dir = request.getParameter("destino_input");
    String salida_dir = request.getParameter("salida_input");
    
    String fecha = request.getParameter("dia");
    fecha += "/" + request.getParameter("mes") + "/2016";
    int cupo = Integer.parseInt(request.getParameter("cupo"));
    int precio = Integer.parseInt(request.getParameter("precio"));
    int id = Integer.parseInt(request.getParameter("idViajeForm"));
    
    Ruta ruta = new Ruta();
    Usuario user = (Usuario) session.getAttribute("usuario");
    System.out.println("Usuario!!!" + user.getIdusuario());
    boolean estado = false;

    ruta.conecta();
    estado = ruta.actualizaRuta(id, destino, salida, fecha, horas + ":" + minutos, cupo, 
            user.getIdusuario(), precio, destino_dir, salida_dir);
    ruta.desconecta();

    if (estado) {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Se actualizó el viaje correctamente!');");
        out.println("location='../administrarRuta.jsp';");
        out.println("</script>");
    } else {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Hubo un error actualizando el viaje.');");
        out.println("location='../administrarRuta.jsp';");
        out.println("</script>");
    }
%>