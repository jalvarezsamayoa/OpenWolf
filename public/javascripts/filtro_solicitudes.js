// filtro_solicitudes.js
// muestra ventana de filtro

// $(document).ready(function(){

//                   });

jQuery(function($){

         $('.filtro').click(function(){
                              $('#filtro').show();
                            });

         $(function(){
             $("#fecha_desde").datepicker();
             $("#fecha_hasta").datepicker();
           });

         $(function(){
             $("#filtros").tabs();
           });
       });