<%-- 
    Document   : editarPerfil
    Created on : 2/05/2016, 01:50:08 AM
    Author     : ReneGL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controlador.Usuario;"%>
<%@page import="controlador.Calificacion;"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar</title>
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
        <link rel="stylesheet" href="resources/css/editarPerfil.css" type="text/css"/>
        <link rel="stylesheet" href="resources/css/jquery-ui.min.css" type="text/css"/>
        <link rel="stylesheet" href="resources/css/jquery.rateyo.min.css"/>
        <script src="http://maps.google.com/maps/api/js"></script>
        <script src="resources/js/jquery.js"></script>
        <script src="resources/js/jquery-ui.min.js"></script>
        <script src="resources/js/jquery.rateyo.min.js"></script>
        
        <script>
        
        function checkRegexp( o, regexp) {
            if ( !( regexp.test( o ) ) ) {
               $('#msgCorreo').css('position', 'absolute');
              $('#msgCorreo').show();
              return false;
            } else {
              return true;
            }
        }
        
        function checkForm() {
            var pass1 = $('#pass1').val();
            var pass2 = $('#pass2').val();
            var correo = $('#correo').val();
            var emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
            //alert("pass1: " + pass1 + " pass2: " + pass2);
            var m = $('#msg');
            m.hide("fast");
            $('#msgCorreo').hide();
            if (pass1 !== pass2) {
                m.text("Las constraseñas no coincicen!");
                m.show("fast");
                return false;
            } else if (pass1.length < 5) {
               
                m.text("La constraseña es muy corta Chaval!!");
                m.show("fast");
                return false;
            } 
             else
                 return checkRegexp(correo, emailRegex);
        };
        
        function ask() {
            var res = confirm("Estas seguro de eliminar???");
            return res;
        }
        
        $( document ).ready(function() {
            $('#msg').hide();
            $('#msgCorreo').hide();
            
            $('#salir').click( function() {
                $('#submit-salir').click();
            });
            
            $('#eliminar-perfil').click( function() {
                $('#submit-eliminar').click();
            });
            
            var prom = $('#stars').closest('.container').find('.promedio').val();
                     
            $('#stars').rateYo({
                starWidth: "25px",
                numStars: 5,
                rating: prom,
                readOnly: true
            });
            
            $('#subir').click( function() {
                $('#file-input').click();
            });
            
            $('#photo').click( function () {
                 $( ".dialogo-foto" ).dialog("open");
            });
            
            $( ".dialogo-foto" ).dialog({
                    autoOpen: false,
                    modal: true,
                    width: 400,
                    height: 430,
                    
                    buttons: {
                      Ok: function() {
                        $('#cargar').click();
                        $( this ).dialog( "close" );
                      }
                    }
                  });
          });
    </script>
    </head>
    
    <body>
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
                            <a class="page-scroll" href="#about" id="publicar" onclick="PF('dlg').show();">Publica Viaje</a>
                        </li>
                        <li>
                            <a class="page-scroll" href="editarPerfil.jsp">Editar Perfil</a>
                        </li>
                         <li>
                            <a class="page-scroll" href="administrarRuta.jsp">Administrar Rutas</a>
                        </li>
                        <li>
                            <a class="page-scroll" href="#" id="salir">Salir</a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid -->
        </nav>
        
        <header>
            <% 
                Usuario user = (Usuario) session.getAttribute("usuario");
                
                String nombre = "";
                String apellidos = "";
                String correo = "";
                String password = "";
                
                if (user != null) {
                    nombre = user.getNombre();
                    apellidos = user.getApellido();
                    correo = user.getCorreo();
                    password = user.getPassword();
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("location='entrar.jsp';");
                    out.println("</script>");
                }
                
                Calificacion cali = new Calificacion();
                        cali.conecta();
                        double promedio = cali.getPromedio(user.getIdusuario());
                        
                        if(promedio == 0)
                            promedio = 5; //Para que no haya muchos 0's
                        cali.desconecta();
                
                user.conecta();
                String foto = user.getFoto(user.getIdusuario());
                System.out.println("FOTO: " + foto);
                user.desconecta();
                
                
            %>
            <div class="container">
                
		<div class="col1">
			<img src=".<%=foto%>" style="height: 190px; width: 180px;" id="photo">
                        
                        
                        <h3><%=user.getNombre()%> <%=user.getApellido()%></h3>
                        <div id="stars" ></div>
                        <input type="hidden" class="promedio" value="<%=promedio%>">
		</div>
                
                    <form action="procesos/editarPerfil_proceso.jsp" method="post" onSubmit="return checkForm()">
                        <table>
                            
                            <tr>
                              <td> <label for="nombre">Nombre </label></td>
                              <td> <input type="text" id="nombre" name="nombre" value="<%= nombre%>" required/> </td>
                              <td><i class="fa fa-pencil"></i></td>
                            </tr>
                            <tr>
                              <td><label for="apellidos">Apellidos </label> </td>
                              <td><input type="text" name="apellidos" value="<%= apellidos%>" required/> </td>
                              <td><i class="fa fa-pencil"></i></td>
                            </tr>
                            <tr>
                              <td> <label for="correo">Correo </label> </td>
                              <td> <input type="text" name="correo" id="correo" value="<%= correo%>" required/></td>
                              <td><i class="fa fa-pencil"></i></td>
                            </tr>
                            
                            <tr>
                              <td> <label for="password">Contraseña </label>  </td>
                              <td> <input id="pass1" type="password" id="pass1" name="password" value="<%= password%>" required/></td>
                              <td><i class="fa fa-pencil"></i></td>
                            </tr>
                            
                            <tr>
                              <td>  <label for="password1">Repite contraseña </label>   </td>
                              <td> <input id="pass2" type="password" id="pass2" name="password1"  value="<%= password%>" required/> </td>
                              <td><i class="fa fa-pencil"></i></td>
                            </tr>
                            
                            <tr >
                              <td>  </td>
                              <td> </td>
                              <td style="padding: 15px;"><input type="submit" value="Guardar" class="submit-button"/></td>
                            </tr>
                            
                            <tr style="border-top: none;">
                              <td>  </td>
                              <td> </td>
                              <td> <a href="#" id="eliminar-perfil">Eliminar Perfil</a></td>
                            </tr>
                          </table>  
                              
                    </form>
                              
                              <form action="procesos/eliminarPerfil_proceso.jsp" onsubmit="return ask()" style="display: none;">
                                  <input type="submit" id="submit-eliminar" value="Eliminar">
                              </form>
                              
                
                
            </div>
                        
                              <div class="dialogo-foto">
                                  <img src=".<%=foto%>" style="height: 240px; width: 230px;">
                                  <form action="./Uploader" enctype="MULTIPART/FORM-DATA" method="post">
                                    <input  id="file-input" type="file" name="file" >

                                    <input type="hidden" id="test" name="id" value="<%=user.getIdusuario()%>">
                                    <input type="submit" value="Cargar" id="cargar" style="display: none;"/>
                                </form>
                              </div>
                              
            <!-- Proceso para salir -->
            <div style="display:none;">  
                
                <form method="POST" action="procesos/salir_proceso.jsp">
                  <fieldset>
                    <input id="submit-salir" type="submit" style="display:none;">
                  </fieldset> 
                </form>
            </div>
                
        </header>
    </body>
</html>
