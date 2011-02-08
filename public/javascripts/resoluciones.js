jQuery(function($){
         $("#resolucion_fecha").datepicker();

         $("#resolucion_fecha_notificacion").datepicker();
         $("#resolucion_fecha_notificacion_input").hide();

         $("#resolucion_nueva_fecha_input").hide();
         $("#resolucion_nueva_fecha").datepicker();


         // observer para la actualizacion de razones de resoluciones
         // @view resoluciones/_form.html.hml
         // observe_field(:resolucion_tiporesolucion_id, :url => actualizar_razones_resoluciones_path, :with => "tiporesolucion_id", :method => :get)

         $("#resolucion_tiporesolucion_id").live('change',function() {
                                                   // make a POST call and replace the content
                                                   var tiporesolucion_id = $(this).val();
                                                   $.ajax({
                                                            type: "GET",
                                                            url: '/resoluciones/actualizar_razones.js',
                                                            data: "tiporesolucion_id="+tiporesolucion_id,
                                                            dataType: "script"
                                                          });
                                                 });

       });//Jquery