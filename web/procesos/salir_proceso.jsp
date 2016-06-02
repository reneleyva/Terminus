<%@page import="controlador.Usuario;"%>

<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    user = null;
    session.setAttribute("usuario", user);
    
    
    
    out.println("<script type=\"text/javascript\">");
    out.println("location='../salir.html';");
    out.println("</script>");
    
%>
