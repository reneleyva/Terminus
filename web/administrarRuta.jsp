<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controlador.Usuario;"%>
<%@page import="controlador.Viaje;"%>
<%@page import="controlador.Ruta;"%>
<%@page import="java.util.ArrayList;"%>

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
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
        <script src="resources/js/jquery.js"></script>
        <script src="resources/js/jquery-ui.min.js"></script>
        <script src="resources/js/gmap.js"></script>
        <script src="resources/js/jquery.countdown.min.js"></script>
        <script src="resources/js/mapaAdministraRuta.js"></script>
        
        
        <style>
            .eliminar, .editar {
                font-weight: bold;
                font-size: 20px;
                background: white;
                color: #F05F40;
            }
            
            .container {
                width: 80%;
            }
            .col1 {
                width: 30%;
               
            }
            
            .col2 {
                width: 40%;
                
            }
            
            .col3 {
                width: 30%;
                
            }
        </style>
    </head>
    <body>
       
        <%
            Usuario user = (Usuario) session.getAttribute("usuario");
               if (user == null) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("location='entrar.jsp';");
                    out.println("</script>");
                }
        %>
        <nav id="mainNav" >
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
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
                            <a href="#" id="publica"> Publica Viaje</a>
                        </li>
                        <li>
                            <a href="#"> Notificaciones </a>
                        </li>
                        <li>
                            <a href="editarPerfil.jsp"> Editar Perfil </a>
                        </li>
                        <li>
                            <a href="administrarRuta.jsp"> Administrar Rutas </a>
                        </li>
                        <li>
                            <a href="#" id="salir"> Salir </a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid -->
        </nav>
        <header>
            <h2>Tus Viajes</h2>
            <%
               
                
                Ruta r = new Ruta();
                ArrayList viajes = new ArrayList();
                
                r.conecta();
                viajes = r.getRutas();
                r.desconecta();
                
                boolean tieneViaje = false;
         
                for (Object o : viajes) {
                    Ruta current = (Ruta) o;
                    if(current.getIdUsuario() == user.getIdusuario()) {
                        tieneViaje = true;
                       
                     	String destino = current.getDestino();
                        String salida = current.getSalida();
                        String[] destino_coor = destino.split(", ");
                        String[] salida_coor = salida.split(", ");
                        String hora = current.getHora();
                        String fecha = current.getFecha();
                        String destino_dir = current.getDestino_dir();
                        String salida_dir = current.getSalida_dir();
                        int idUsuario = current.getIdUsuario();
                        int precio = current.getPrecio();
                        int cupo = current.getCupo();
                        int id = current.getId();
                        

            %>
            
            <form onsubmit="return ask();" action="procesos/eliminaViaje_proceso.jsp">
                <div class="container">
                    <div class="col1">
                        <div class="map-canvas" style="height:160px; width:220px"></div>
                        <input type="hidden" class="destino_lat" value="<%=destino_coor[0]%>" >
                        <input type="hidden" class="destino_long" value="<%=destino_coor[1]%>">
                        <input type="hidden" class="salida_lat" value="<%=salida_coor[0]%>" >
                        <input type="hidden" class="salida_long" value="<%=salida_coor[1]%>" >
                    </div>
                    <div class="col2">
                        <h3><%= destino_dir %> - <%=salida_dir%></h3>
                        <h4 class="restante">Quedan 0 hrs.</h4>
                        <h4>Fecha: <%=fecha%></h4>
                        <h4>Hora: <%= hora%></h4>
                        <input type="submit" value="Eliminar Viaje" class="eliminar">
                        <button class="editar" >Editar Viaje</button>
                    </div>

                    <div class="col3">
                        <h3>$<%=precio%> por asiento</h3>
                        <h3><%=cupo%> asientos disponibles</h3>
                        
                    </div>
                        
                    <input type="hidden" class="fecha_viaje" value="<%=fecha%>">
                    <input type="hidden" class="hora_viaje" value="<%=hora%>">
                    <input type="hidden" class="viajeId" name="viajeId" value="<%=id%>">
                </div>
            </form>
            
            <%
                
                } 
             }

             if (!tieneViaje) {

            %>
            
            <h4>No hay Viajes que mostrar</h4>
            
            <%
               } 
            %>
            
            <div id="dialog-form" title="Publica Viaje">
                <p class="tips">Todos los campos son requeridos</p>
                <form method="POST" action="procesos/editarViaje_proceso.jsp">
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
                    <input type="text" name="mes" id="mes" placeholder="mes" style="width: 30px" maxlength="2"><span id="fechaActual">Hoy es 00/00</span><br>
                    <label for="cupo">Cupo</label>
                    <input type="text" name="cupo" id="cupo"  style="width: 50px" maxlength="2"> <br>
                    <label for="precio">Precio por asiento ($)</label>
                    <input type="text" name="precio" id="precio"  style="width: 50px">
                    
                    <input id="idViajeForm" type="hidden" name="idViajeForm">
                    
                    <input  id="destino_coor" name="destino" type="text" value="" style="display:none;">
                    <input id="salida_coor" name="salida" type="text" value="" style="display:none;">
                    
                    <input id="submit" type="submit" tabindex="-1" value="LOL" style="display:none;">
                  </fieldset>
                    
                </form>
                
              </div>
            
            <div id="viaje-aceptar" title="Tomar este viaje">
                <p class="validateTips">¿Quieres tomar este viaje?</p> <br>
                <div id="mapConfirma" style="height:400px; width:600px"></div>
                <form method="POST" action="procesos/aceptaViaje_proceso.jsp">
                  <fieldset>
                    <input id="showId" type="hidden"  name="viajeId">
                    <!-- Allow form submission with keyboard without duplicating the dialog button -->
                    <input id="submit-viaje" type="submit" tabindex="-1" value="LOL" style="display:none;">
                  </fieldset>
                    
                </form>
              </div>
              
            <div style="display:none;">  
                
                <form method="POST" action="Procesos/salir_proceso.jsp">
                  <fieldset>
                    <input id="submit-salir" type="submit" tabindex="-1" style="display:none;">
                  </fieldset>
                    
                </form>
              </div>
            
        </header>
    </body>
</html>
