<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controlador.Usuario;"%>
<%@page import="controlador.Viaje;"%>
<%@page import="controlador.Ruta;"%>
<%@page import="controlador.Calificacion;"%>
<%@page import="java.util.ArrayList;"%>
<%@page import="java.util.Date;"%>
<%@page import="controlador.Notificacion;"%>
<%@page import="controlador.Conexion;"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ride Ciencias</title>
        
        <link rel="stylesheet" href="resources/css/bootstrap.min.css" type="text/css"/>
        <!-- Custom Fonts -->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'/>
        <link href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'/>
        <link rel="stylesheet" href="resources/font-awesome/css/font-awesome.min.css" type="text/css"/>

        <!-- Plugin CSS -->
        <link rel="stylesheet" href="resources/css/animate.min.css" type="text/css"/>
        
        <!-- Custom CSS -->
        <link rel="stylesheet" href="resources/css/creative.css" type="text/css"/>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css' />
        <link href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css' />
        <link rel="stylesheet" href="resources/css/paginaUsuarioStyle.css" type="text/css"/>
        <link rel="stylesheet" href="resources/css/jquery-ui.min.css" type="text/css"/>
        <link rel="stylesheet" href="resources/css/jquery.rateyo.min.css"/>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
        <script src="resources/js/jquery.js"></script>
        <script src="resources/js/jquery-ui.min.js"></script>
        <script src="resources/js/gmap.js"></script>
        <script src="resources/js/jquery.countdown.min.js"></script>
        <script src="resources/js/jquery.rateyo.min.js"></script>
        <script src="resources/js/mapa.js"></script>
        
        <style>
            .ui-dialog .ui-dialog-buttonpane { 
                text-align: center;
            }
            .ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset { 
                float: none;
            }
        </style>
        <script>
            
        </script>
    </head>
    <body>
        
        <nav id="mainNav" >
            <div class="container-fluid">
                
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand page-scroll" href="paginaUsuario.jsp">RideCiencias</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a class="page-scroll" href="#" id="publica"> Publica Viaje</a>
                        </li>
                        <li>
                            <a class="page-scroll" href="#" id="notificacion"> Notificaciones</a>
                        </li>
                        <li>
                            <a class="page-scroll" href="editarPerfil.jsp"> Editar Perfil </a>
                        </li>
                        <li>
                            <a class="page-scroll" href="administrarRuta.jsp"> Administrar Rutas </a>
                        </li>
                        <li>
                            <a href="#" id="salir"> Salir </a>
                        </li>
                    </ul>
                </div>
                
            </div>
        </nav>
        <header>
            
            
            <!--Se generan los paneles de Viajes-->
            <% 
                
                Usuario user = (Usuario) session.getAttribute("usuario");
                if (user == null) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("location='entrar.jsp';");
                    out.println("</script>");
                }
                
                ArrayList rutas = new ArrayList();
                Ruta r = new Ruta();
                r.conecta();
                rutas = r.getRutas();
                r.desconecta();
                
                ArrayList viajes = new ArrayList();
                Viaje v = new Viaje();
                v.conecta();
                viajes = v.getViajes();
                v.desconecta();
                boolean viajeTomado = false;
                
                if (rutas.size() == 0) {
                
            %>
            <h2>No hay viajes que Mostrar!</h2>
            <%
                } else {
                    
                    /*Si ya tiene un viaje*/
                    
                   int idRutaTomada = 0;
                   Viaje tomado = null;
                    for (Object o : viajes) {
                        Viaje current = (Viaje) o;
                       System.out.println(current.toString());
                        if (current.getIdUsuario() == user.getIdusuario()) {
                            viajeTomado = true;
                            tomado = current;
                            idRutaTomada = current.getIdRuta();
                            
                        }
                            
                    }
                    
                    //Tiene un viaje pendiente
                    if (viajeTomado && tomado.getCalificado() == 'F') {

                        
                        Ruta ruta = null;
                        //Busca el viaje que está tomando
                        for (Object o : rutas) {
                            Ruta c = (Ruta) o;
                            if(c.getId() == idRutaTomada)
                                ruta = c;
                        }
                        
                        
                        String destino = ruta.getDestino();
                        String salida = ruta.getSalida();
                        String[] destino_coor = destino.split(", ");
                        String[] salida_coor = salida.split(", ");
                        String fecha = ruta.getFecha();
                        String[] fecha_parts = fecha.split("-");
                        String hora = ruta.getHora();
                        int cupo = ruta.getCupo();
                        String destino_dir = ruta.getDestino_dir();
                        String salida_dir = ruta.getSalida_dir();
                        int idUsuario = ruta.getIdUsuario();
                        String name = "";

                        Conexion conex = new Conexion();
                        conex.conectar();
                        name = conex.getNombreUsuario(idUsuario);
                        conex.desconectar();

                        int id = ruta.getId();
                        //Para calificacion
                        Calificacion cali = new Calificacion();
                        cali.conecta();
                        double promedio = cali.getPromedio(ruta.getIdUsuario());
                        
                        if(promedio == 0)
                            promedio = 5; //Para que no haya muchos 0's
                        cali.desconecta();

                        /*Checar si es mayor a la fecha actual, de otra manera 
                            construir Notificacion de calificar */
                        Date date = new Date(Integer.parseInt(fecha_parts[0])-1900, 
                                Integer.parseInt(fecha_parts[1])-1, Integer.parseInt(fecha_parts[2]));
                        date.setHours(Integer.parseInt(hora.split(":")[0]));
                        date.setMinutes(Integer.parseInt(hora.split(":")[1]));
                        Date hoy = new Date();
                        
                        //VEr si viaje está ya calificado. 
                        Viaje viaje = new Viaje();
                        Viaje otro = null;
                        v.conecta();
                        otro = v.buscaViaje(3);
                        v.desconecta();
                        //System.out.println(otro.toString());
                        Usuario u = new Usuario();
                        u.conecta();
                        String f =u.getFoto(idUsuario);
                        u.desconecta();

                        if (hoy.compareTo(date) <= 0) {
                            

                %>
                    <h2>Tienes un Viaje pendiente</h2>
                    <!--Panel del viaje que tomó-->
                   <form method="POST" action="procesos/aceptaViaje_proceso.jsp"> 
                       <div class="container tomado">
                           <div class="col1">
                                   <img src=".<%=f%>" style="height: 160px; width: 150px;">
                                   <h3><%=name%></h3>
                                   <div class="panel-stars" ></div>
                                   <input type="hidden" class="promedio" value="<%=promedio%>">
                         
                           </div>
                           <div class="col2">
                               <h3 class="restante">13:00 quedan 2 hrs.</h3>
                               <h4><%=destino_dir%> - <%=salida_dir%> iDRuta: <%= ruta.getId()%></h4>
                               <h4><%=cupo%> asientos disponibles</h4>
                               <button class="cancelarViaje">CANCELAR</button>
                           </div>
                           <div class="col3">
                               <div class="map-canvas" style="height:170px; width:240px"></div>
                               <input type="hidden" class="destino_lat" value="<%=destino_coor[0]%>" >
                                <input type="hidden" class="destino_long" value="<%=destino_coor[1]%>">
                                <input type="hidden" class="salida_lat" value="<%=salida_coor[0]%>" >
                                <input type="hidden" class="salida_long" value="<%=salida_coor[1]%>" >
                                <input type="hidden" class="fecha_viaje" value="<%=fecha%>">
                                <input type="hidden" class="hora_viaje" value="<%=hora%>">
                           </div>
                           <div class="col4">
                               <h3><%=cupo%> asientos disponibles</h3>
                           </div>
                           <input type="hidden" class="viajeId" name="containerId" value="<%=ruta.getId()%>">
                       </div>
                   </form>
                <%    
                    } else {
                        //Para el nombre del que publico la ruta
                        Conexion con = new Conexion();
                        con.conectar();
                        String nombre = con.getNombreUsuario(idUsuario);
                        con.desconectar();

                        Usuario tmp = new Usuario();
                        tmp.conecta();
                        String foto = tmp.getFoto(idUsuario);
                        tmp.desconecta();
                %>
                
               
                <!--PANEL CALIFICAR-->
                <div class="calificar" title="Califica a este usuario!">
                    <img  src=".<%=foto%>" style="height: 200px; width: 190px;">
                        <h3><%=nombre%></h3>
                        <div class="rateYo"></div> 
                        <div class="counter"></div>
                        
                        
                         <!--FORM para calificar-->
                         <form action="procesos/califica.jsp" method="POST" style="display:none;">
                            <label>idUsuario</label>
                            <input type="text" class="idUsuario" value="<%=idUsuario%>" name="idUsuario"> <br>
                            <label>idRuta</label>
                            <input type="text" class="idRuta" value="<%=id%>" name="idRuta">
                            <input type="text" class="rating" name="rating" value="0">
                            <input type="submit" class="calificar-submit" value="ACEPTAR">      
                        </form>
                </div>
                <%
                    }
                    } else {
                %>
                    <h2>Proximos Viajes</h2>
                <%
                    //No tiene viajes mostralos. 
                    int numPaneles = 0; //Para ver si no hubo paneles
                    for (int i = rutas.size()-1; i >= 0; i--) {
                       
                        Ruta current = (Ruta) rutas.get(i);
                        int id = current.getId();
                        
                        String destino = current.getDestino();
                        String salida = current.getSalida();
                        String[] destino_coor = destino.split(", ");
                        String[] salida_coor = salida.split(", ");
                        String hora = current.getHora();
                        String destino_dir = current.getDestino_dir();
                        String salida_dir = current.getSalida_dir();
                        int idUsuario = current.getIdUsuario();
                        int precio = current.getPrecio();
                        int cupo = current.getCupo();
                        
                        /*Fecha***/
                        String fecha = current.getFecha();
                        
                        String[] fecha_parts = fecha.split("-");
                       
                        Date date = new Date(Integer.parseInt(fecha_parts[0])-1900, 
                                Integer.parseInt(fecha_parts[1])-1, Integer.parseInt(fecha_parts[2]));
                        date.setHours(Integer.parseInt(hora.split(":")[0]));
                        date.setMinutes(Integer.parseInt(hora.split(":")[1]));
                        Date hoy = new Date();
                        
                        //System.out.println("Date: " + date.toString() + "Hoy: " + hoy.toString());
                        
                        //Para calificacion
                        Calificacion cali = new Calificacion();
                        cali.conecta();
                        double promedio = cali.getPromedio(idUsuario);
                       
                        if(promedio == 0)
                            promedio = 5; //Para que no haya muchos 0's
                        cali.desconecta();
                        
                        String name = "";

                        Conexion conex = new Conexion();
                        conex.conectar();
                        name = conex.getNombreUsuario(idUsuario);
                        conex.desconectar();
                        
                        /*Falta comparar fecha*/
                        if (cupo > 0) {
                            numPaneles++;
                      
            %>
                <!--Aquí se generan los paneles-->
                
                <form method="POST" action="procesos/aceptaViaje_proceso.jsp"> 
                    <div class="container">
                        <div class="col1">
                                <img class="foto-perfil" src=".<%=user.getPerfil()%>" style="height: 160px; width: 150px;">
                                <h3 ><%=name%></h3>
                                <div class="panel-stars" ></div>
                                <input type="hidden" class="promedio" value="<%=promedio%>">
                        </div>
                        <div class="col2">
                            <h3><%=destino_dir%> - <%=salida_dir%></h3>
                            <h4 class="restante"> Quedan 2 hrs.</h4>
                            <h4 class="fecha">Fecha: <%=fecha_parts[1]%>/<%=fecha_parts[2]%>/<%=fecha_parts[0]%></h4>
                            <h4>Hora: <%=hora%></h4>
                            <input type="hidden" class="fecha_viaje" value="<%=fecha%>">
                            <input type="hidden" class="hora_viaje" value="<%=hora%>">
                        </div>
                        <div class="col3">
                            <div class="map-canvas"></div>
                            <input type="hidden" class="destino_lat" value="<%=destino_coor[0]%>" >
                            <input type="hidden" class="destino_long" value="<%=destino_coor[1]%>">
                            <input type="hidden" class="salida_lat" value="<%=salida_coor[0]%>" >
                            <input type="hidden" class="salida_long" value="<%=salida_coor[1]%>" >
                        </div>
                        <div class="col4">
                            <h3>$<%=precio%> por asiento</h3>
                            <h4><%=cupo%> asientos disponibles</h4>
                        </div>
                        <input type="hidden" class="viajeId" name="containerId" value="<%=id%>">
                    </div>
                </form>
            <% 
                       } 
                    }
                } //Fin del otro else si tomóun viaje. 
            } //Fin del else gigante
            
           
            %>
            
            <!--Primer panel
            <form method="POST" action="procesos/aceptaViaje_proceso.jsp"> 
                <div class="container">
                    <div class="col1">
                            <img src="resources/img/default_user.png" style="height: 160px; width: 150px;">
                            <img src="resources/img/5-stars-icon.png" alt="" style="height: 15px; width: 80px;">
                    </div>
                    <div class="col2">
                        <h3>13:00 quedan 2 hrs.</h3>
                        <h4>Metro C.U - Neza</h4>
                        <h4>2 asientos disponibles</h4>
                    </div>
                    <div class="col3">
                        <div class="map-canvas" style="height:170px; width:240px"></div>
                        <input type="hidden" class="destino_lat" value="19.326284" >
                        <input type="hidden" class="destino_long" value="-99.183225">
                        <input type="hidden" class="salida_lat" value="19.432608" >
                        <input type="hidden" class="salida_long" value="-99.133208">
                    </div>
                    <div class="col4">
                        <h3>$20 por asiento</h3>
                    </div>
                    <input type="hidden" class="viajeId" name="containerId" value="1">
                </div>
            </form>-->
            
            <!-- Segundo Panel!!***
            <form method="POST" action="procesos/aceptaViaje_proceso.jsp"> 
                <div class="container tomado">
                    <div class="col1">
                            <img src="resources/img/default_user.png" style="height: 160px; width: 150px;">
                            <img src="resources/img/5-stars-icon.png" alt="" style="height: 15px; width: 80px;">
                    </div>
                    <div class="col2">
                        <h3>13:00 quedan 2 hrs.</h3>
                        <h4>Metro C.U - Neza</h4>
                        <h4>2 asientos disponibles</h4>
                        <button class="cancelarViaje">CANCELAR</button>
                    </div>
                    <div class="col3">
                        <div class="map-canvas" style="height:170px; width:240px"></div>
                        <input type="hidden" class="destino_lat" value="40.712784" >
                        <input type="hidden" class="destino_long" value="-74.005941">
                        <input type="hidden" class="salida_lat" value="19.432608" >
                        <input type="hidden" class="salida_long" value="-99.133208">
                    </div>
                    <div class="col4">
                        <h3>2 asientos disponibles</h3>
                    </div>
                    <input type="hidden" class="viajeId" name="containerId" value="1">
                </div>
            </form>-->
            
            <!-- PARA CANCELAR VIAJE, Esta OCULTO-->
            <form action="procesos/cancelarViaje_proceso.jsp" style="display:none;" method="POST">
                <input type="hidden" id="idViaje_cancelar" name="idViaje_cancelar">
                <input type="submit" id="cancelarViaje_submit">
             </form>
            
            
            <div id="dialog-form" title="Publica Viaje">
                <p class="tips">Todos los campos son requeridos</p>
                <form method="POST" action="procesos/publicaViaje_proceso.jsp">
                  <fieldset>
                    <label for="destino">Destino</label>
                    <input type="text" name="destino_input" id="destino" >
                    <label for="salida">Salida</label>
                    <input type="text" name="salida_input" id="salida" >
                    <button id="buscar">Buscar</button><br>
                   
                    <div id="mapCreacion" style="height:250px; width:480px"></div> <br>
                    <label for="horas minutos" >Hora</label>
                    <input type="text" name="horas" id="horas" style="width: 50px" maxlength="2">:
                    <input type="text" name="minutos" id="minutos"  style="width: 50px" maxlength="2">
                    <select name="meridiem" id="meridiem">
                        <option value="am">AM</option>
                        <option value="pm">PM</option>
                    </select> <br>
                    <label for="fecha">Fecha</label>
                    <input type="text" name="dia" id="dia" placeholder="dia" style="width: 30px" maxlength="2">
                    <label for="" >/</label>
                    <input type="text" name="mes" id="mes" placeholder="mes" style="width: 30px" maxlength="2"><span id="fechaActual">Hoy es 19/7</span><br>
                    <label for="cupo">Cupo</label>
                    <input type="text" name="cupo" id="cupo"  style="width: 50px" maxlength="2"> <br>
                    <label for="precio">Precio por asiento ($)</label>
                    <input type="text" name="precio" id="precio"  style="width: 50px">

                    <input  id="destino_coor" name="destino" type="hidden" value="" >
                    <input id="salida_coor" name="salida" type="hidden" value="" >
                    
                    <input id="submit" type="submit" tabindex="-1" value="LOL" style="display:none;">
                  </fieldset>
                    
                </form>
              </div>
            
            <div id="viaje-aceptar" title="Tomar este viaje">
                <p class="validateTips">¿Quieres tomar este viaje?</p> <br>
                <div id="mapConfirma" style="height:300px; width:500px"></div>
          
                <form method="POST" action="procesos/aceptaViaje_proceso.jsp">
                  <fieldset>
                    <input id="showId" type="hidden"  name="viajeId">
                    
                    <input id="submit-viaje" type="submit" tabindex="-1" value="LOL" style="display:none;">
                  </fieldset>
                    
                </form>
            </div>
              
            
            <!-- Proceso para salir -->
            <div style="display:none;">  
                
                <form method="POST" action="procesos/salir_proceso.jsp">
                  <fieldset>
                    <input id="submit-salir" type="submit" tabindex="-1" style="display:none;">
                  </fieldset> 
                </form>
            </div>
            
            <!-- NOTIFICACIONES-->
            <div id="dialogo-notificacion" title="Notificaciones">
                    <!--FORMA PARA DAR COMO VISTAS LAS NOTIFICACIONES-->
                    <form action="procesos/notificaciones_vistas.jsp" method="POST" style="display:none;">
                        <input type="submit" id="submit-visto">
                    </form>
                    
                    <ul>
                        <%
                            ArrayList notificiones = new ArrayList();
                            ArrayList noti = new ArrayList();
                            Notificacion n = new Notificacion();
                            n.conecta();
                            notificiones = n.getNotificaciones();
                            n.desconecta();
                            
                            for (Object o : notificiones) {
                                Notificacion current = (Notificacion) o;
                                 System.out.println(current.toString());
                                if (current.getVisto() == 'F') {
                                   
                                    noti.add(current);
                                }
                            }
                            
                        
                            //Recorrer las notificaciones 
                            int numNoti = 0;
                            for (Object o : noti) {
                                
                                Notificacion current = (Notificacion) o;
                               
                                
                                //REvisa fehca 
                                String fecha = current.getFecha();
                        
                                String[] fecha_parts = fecha.split("-");

                                Date date = new Date(Integer.parseInt(fecha_parts[0])-1900, 
                                        Integer.parseInt(fecha_parts[1])-1, Integer.parseInt(fecha_parts[2]));
                                Date hoy = new Date();
                                hoy.setHours(0);
                                hoy.setMinutes(0);
                                hoy.setSeconds(0);
                             
                                //System.out.println("Fecha Noti: " + date.toString());
                                //System.out.println("Fecha Hoy: " + hoy.toString());
                                
                                if (current.getIdUsuario() == user.getIdusuario()) {
                                   
                                    numNoti++;
                                    String m = current.getMensaje();
                                
                        %>
                        <li>
                            <p><%=m%></p> 
                        </li>
                        
                        
                        <%
                                }
                            } 

                            if (numNoti == 0) {
                        %>
                                
                            <p><b>NO HAY NOTIFICACIONES QUE MOSTRAR</b></p> 
                        <%
                            } else {
                               out.println("<script type=\"text/javascript\">");
                               out.println("$('#notificacion').addClass('blink');");
                               out.println("</script>");
                            }
                        %>
                    </ul>
                    
                   
                    
                    
                       
            </div>
            
        </header>
    </body>
</html>
