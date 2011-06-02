jQuery(function($){

         // bloquear la forma de solcitudes para evitar doble creacion de la solicitud
         $("form#new_solicitud").live('submit',function(event){
                                        var form = $(this);
                                        form.block({message: '<h2><img src=\"/images/ajax-loader.gif\"/> Procesando Solicitud...</h2>'});
                                      });
       });//Jquery
