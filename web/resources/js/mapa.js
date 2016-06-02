 function ask() {
    var res = confirm('Estas seguro de eliminar este viaje??');
    return res;
}

 $(document).ready(function() {
                
                
                var d = new Date();
                var mesActual = d.getMonth()+1;
                var diaActual = d.getDate();
                var t = 'Hoy es '+diaActual+ '/' + mesActual+'.';
                $('#fechaActual').text(t);
                function updateTip(msg) {
                    var tips = $('.tips');
                        tips
                            .text(msg)
                            .addClass( "ui-state-highlight", 200);
                } 


                $('#dialog-form').dialog({
                    autoOpen: false,
                    maxWidth:540,
                    maxHeight: 500,
                    width: 560,
                    height: 570,
                    modal: true,
                    buttons: {
                        "Crear": function() {
                            
                            var horas = $('#horas').val();
                            var minutos = $('#minutos').val();
                            var dia = $('#dia').val();
                            var mes = $('#mes').val();
                            var salida = $('#salida').val();
                            var entrada = $('#entrada').val();
                            var cupo = $('#cupo').val();
                            var coor1 = $('#destino_coor').val();
                            var coor2 = $('#salida_coor').val();
                            
                            
                            var precio = $('#precio').val();
     
                            
                            horas = parseInt(horas);
                            minutos = parseInt(minutos);
                            dia = parseInt(dia);
                            mes = parseInt(mes);
                            cupo = parseInt(cupo);
                            precio = parseInt(precio);
                            
                            
                            if (isNaN(minutos) || isNaN(horas)) {
                                updateTip("Hora no valida!");
                            } else if (isNaN(dia) || isNaN(mes)) {
                                updateTip("Fecha no valida!");
                            } else if(minutos < 0 || minutos > 60 || horas < 0 || horas > 12) {
                                updateTip("Hora no valida!");
                            } else if (mes < mesActual || mes > 12 || dia < 0 || dia > 31) {
                                updateTip("Fecha no válida!");
                            } else if (salida === "" || entrada === "") {
                                updateTip("Introduce una salida y una entrada!");
                            } else if(coor1 === null || coor1 === '') {
                                updateTip("Busca tu salida y entrada");
                            } else if (isNaN(cupo)) {
                                updateTip("Cupo no válido!");
                            } else if(cupo < 0) {
                                updateTip("Cupo tiene que ser mayor a 1!");
                            } else if(cupo > 10) {
                                updateTip("Cupo no valido! A menos de que traigas micro no caben tantos vatos");
                            } else if (precio < 0 || isNaN(precio)) {
                                updateTip("Precio no válido!");
                            } else if (precio > 500) {
                                updateTip("Demasiado caro!");
                            } else {
                                $('#submit').click();
                            }
                            
                            //$('#submit').click();
                            
                        },
                        Cancel: function() {
                            $(this).dialog("close");
                        }
                    }
                });
                
                $( "#dialogo-notificacion" ).dialog({
                    autoOpen: false,
                    modal: true,
                    width: 400,
                    height: 400,
                    
                    buttons: {
                      Ok: function() {
                        $('#submit-visto').click();
                        $( this ).dialog( "close" );
                      }
                    }
                  });
                
                
                $( ".calificar" ).dialog({
                    
                    width: 400,
                    height: 440,
                    
                    buttons: {
                      Ok: function() {
                        var rating = $(this).find(".rateYo").rateYo("option", "rating");
                        $(this).find('.rating').val(rating);
                        $(this).find('.calificar-submit').click();
                        $( this ).dialog( "close" );
                        
                      }
                    }
                  });
                
                /*Para las estrellas ...*/
                $(".rateYo").rateYo({
                    starWidth: "40px",
                    precision: 1
                }).on("rateyo.change", function (e, data) {
 
                    var rating = data.rating;
                    
                    $(this).next().text(rating);
                });
                
                //Estrellas paneles, **Probablemente ponerlas en el EACH 
                
                
                 $(".panel-stars").each(function () {
                     var prom = $(this).closest('.container').find('.promedio').val();
                     
                     $(this).rateYo({
                        starWidth: "20px",
                        rating: prom,
                        readOnly: true
                    });
                 });
                
                
                
                
                
                $('#notificacion').click( function (e) {
                    e.preventDefault();
                    $(this).removeClass('blink');
                    notiVistas = true;
                    $( "#dialogo-notificacion" ).dialog("open");
                });
                
                
                $('#publica').click( function () {
                    $('#dialog-form').dialog("open");
                
                    
                    var creaMapa = new GMaps({
                        div: '#mapCreacion',
                        lat: 19.432608,
                        lng: -99.133208,
                        zoom: 11
                    });
                    
                    $('#buscar').click( function (e) {
                        
                        e.preventDefault();
                        creaMapa.removeMarkers();
                        
                        var destino = $('#destino').val();
                        var salida = $('#salida').val();

                        if (!destino.trim() || !salida.trim()) {
                            updateTip("Introduce una salida y un destino!");
                            return;
                        } else {
                            destino += ' mexico';
                            salida += ' mexico';
                        }
                        GMaps.geocode({
                            address: destino,
                            callback: function(results, status) {
                              if (status == 'OK') {
                                var latlng = results[0].geometry.location;
                                //POner los inputs a la lat y long. 
                                $('#destino_coor').val(latlng.lat() + ", " + latlng.lng());
                                creaMapa.setCenter(latlng.lat(), latlng.lng());
                                creaMapa.addMarker({
                                  lat: latlng.lat(),
                                  lng: latlng.lng()
                                });
                              }
                            }
                          });
                          
                          
                          GMaps.geocode({
                            address: salida,
                            callback: function(results, status) {
                              if (status == 'OK') {
                                var latlng = results[0].geometry.location;
                                //POner los inputs a la lat y long. 
                                $('#salida_coor').val(latlng.lat() + ", " + latlng.lng());
                                creaMapa.setCenter(latlng.lat(), latlng.lng());
                                creaMapa.addMarker({
                                  lat: latlng.lat(),
                                  lng: latlng.lng()
                                });
                              }
                            }
                          });
                          
                        //creaMapa.resize();
                    });

                    
                    
                });
                
                $('#viaje-aceptar').dialog( {
                    autoOpen: false,
                    maxWidth:200,
                    maxHeight: 200,
                    width: 600,
                    height: 500,
                    modal: true,
                    buttons: {
                        "Tomar Viaje": function() {
                            //$(this).dialog("close");
                            
                            $('#submit-viaje').click();
                        },
                        Cancel: function() {
                            $(this).dialog("close");
                        }
                    }
                });
                
                $('.container').on('click', function() {
                    
                    $('#viaje-aceptar').dialog('open');
                    
                    var destino_lat = $(this).find('.destino_lat').val();
                    var destino_long = $(this).find('.destino_long').val();
                    var salida_lat = $(this).find('.salida_lat').val();
                    var salida_long = $(this).find('.salida_long').val();
                    
                   var mapaConf =  new GMaps({
                        div: '#mapConfirma',
                        lat: salida_lat,
                        lng: salida_long,
                        zoom: 11
                    });
                    
                    
                    mapaConf.addMarker( {
                        lat: destino_lat,
                        lng: destino_long,
                        title: 'destino'
                    });
                    
                    mapaConf.addMarker( {
                        lat: salida_lat,
                        lng: salida_long,
                        title: 'salida'
                    });
                    
                    var id = $(this).find('.viajeId').val();
                    $('#showId').val(id);
                    
                });
                
                
                $('#salir').click( function() {
                    $('#submit-salir').click();
                });
                
                
                /*PARA CANCELAR VIAJE*/
                $('.cancelarViaje').click( function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    var id = $(this).closest('.container').find('.viajeId').val();
                   
                    res = confirm("¿Estás seguro que quieres cancelar este viaje?");
                    if(res) {
                        $('#idViaje_cancelar').val(id);
                        $('#cancelarViaje_submit').click();
                    } 
                });
                
                /*Ñerada para que el panel de viaje tomado no salga dialogo*/
                $('.tomado').off();

                
                $('.col3').each( function () {
                    
                    var destino_lat = $(this).find('.destino_lat').val();
                    var destino_long = $(this).find('.destino_long').val();
                    var salida_lat = $(this).find('.salida_lat').val();
                    var salida_long = $(this).find('.salida_long').val();
                    
                    console.log("long: " + salida_long);
                    console.log("lat: " + salida_lat);
                    
                    var divMapa = $(this).find('.map-canvas')[0];
                    
                    var mapa = new GMaps({
                        div: divMapa,
                        lat: destino_lat,
                        lng: destino_long,
                        zoom: 10
                    });
                    
                    mapa.addMarker( {
                        lat: destino_lat,
                        lng: destino_long,
                        title: 'destino'
                    });
                    
                    mapa.addMarker( {
                        lat: salida_lat,
                        lng: salida_long,
                        title: 'salida'
                    });
                    
                    
                });
                
                /*AdministraRuta*/
                $('#editar').click( function () {
                    $('#dialog-form').dialog("open");
                });
                
                /*Aquí debe empezar lo de la horaaaa*/
                $('.container').each( function() {
                   var fecha =  $(this).find('.fecha_viaje').val();
                   var hora =  $(this).find('.hora_viaje').val();
                   //console.log("fecha: " + fecha);
                   //console.log("hora: " + hora);
                   var fecha_parts = fecha.split("-");
                   
                   var instant = fecha_parts[0] + "/" + fecha_parts[1] + "/"  + fecha_parts[2] + " " + hora;
                   console.log("Instante: " + instant);
                   
                   $(this).find('.restante')
                    .countdown(instant, function(event) {
                      $(this).text(
                        event.strftime('Faltan %D dias %H horas %M minutos %S seg')
                      );
                    });
                });
                
            });