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
                    height: 560,
                    modal: true,
                    buttons: {
                        "Actualizar": function() {
                            var horas = $('#horas').val();
                            var minutos = $('#minutos').val();
                            var dia = $('#dia').val();
                            var mes = $('#mes').val();
                            var salida = $('#salida').val();
                            var entrada = $('#entrada').val();
                            var cupo = $('#cupo').val();
                            
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
                            
                            
                        },
                        Cancel: function() {
                            $(this).dialog("close");
                        }
                    }
                });
                
                $('.editar').click( function (e) {
                    e.preventDefault();
                    e.stopPropagation();
                    var id = $(this).closest('.container').find('.viajeId').val();
                   
                    $('#idViajeForm').val(id);
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
                
                
                $('.col1').each( function () {
                    
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
                /*$('.container').on('click', function() {
                    
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
                    
                });*/
                
                $('#salir').click( function() {
                    $('#submit-salir').click();
                });
                
                
                $('.col3').ready( function () {
                    
                    var destino_lat = $(this).find('.destino_lat').val();
                    var destino_long = $(this).find('.destino_long').val();
                    var salida_lat = $(this).find('.salida_lat').val();
                    var salida_long = $(this).find('.salida_long').val();
  
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
                
                
                
            });


