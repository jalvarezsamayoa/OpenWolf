// filtro_solicitudes.js
// muestra ventana de filtro

// $(document).ready(function(){

//                   });

jQuery(function($){
         //= # observe_field(:solicitud_departamento_id, :url => actualizar_municipios_solicitudes_path, :with => "departamento_id", :method => :get)

         $("#solicitud_departamento_id").change(function() {
                                                  // make a POST call and replace the content
                                                  var depto_id = $(this).val();
                                                  $.ajax({
                                                           type: "GET",
                                                           url: '/solicitudes/actualizar_municipios.js',
                                                           data: "departamento_id="+depto_id,
                                                           dataType: "script"
                                                         });
                                                });

         // observer para actualizacion de usuarios en popup de asignacion de actividades
         // @view actividades/_form.html.haml
         // observe_field(:actividad_institucion_id, :url => actualizar_usuarios_actividades_path, :with => "institucion_id", :method => :get)

         $("#actividad_institucion_id").live('change',function() {
                                               // make a POST call and replace the content
                                               var institucion_id = $(this).val();
                                               $.ajax({
                                                        type: "GET",
                                                        url: '/actividades/actualizar_usuarios.js',
                                                        data: "institucion_id="+institucion_id,
                                                        dataType: "script"
                                                      });
                                             });

         // hacer submit via ajax de la forma para asignacion de actividades a enlaces
         $("form#new_actividad").live('submit',function(event){
                                        event.preventDefault();
                                        var form = $(this);

                                        form.block({message: '<h2><img src=\"/images/ajax-loader.gif\"/> Procesando...</h2>'});

                                        $.ajax({
                                                 type: "POST",
                                                 url: form.attr("action"),
                                                 data: form.serialize(),
                                                 dataType: "script"
                                               });

                                      });


         // bloquear la forma de solcitudes para evitar doble creacion de la solicitud
         $("form#new_solicitud").live('submit',function(event){
                                        var form = $(this);
                                        form.block({message: '<h2><img src=\"/images/ajax-loader.gif\"/> Procesando...</h2>'});
                                      });

          $("form.edit_solicitud").live('submit',function(event){
                                        var form = $(this);
                                        form.block({message: '<h2><img src=\"/images/ajax-loader.gif\"/> Procesando...</h2>'});
                                      });



         $("#solicitudes-y-tareas-tabs").tabs();
         $("#solicitud_fecha_creacion").datepicker();
         $("#solicitud_via_id").focus();

       });//Jquery