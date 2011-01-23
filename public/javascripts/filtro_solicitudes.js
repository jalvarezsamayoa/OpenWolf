// filtro_solicitudes.js
// muestra ventana de filtro

// $(document).ready(function(){

//                   });

jQuery(function($){

         $('.popup').hide();

         $('.filtro').click(function(){
                              $('#filtro').show();
                            });


         $("#fecha_desde").datepicker();
         $("#fecha_hasta").datepicker();
         $('.ui-datepicker').hide();


         $("#filtros").tabs();
         
         $(".combobox").combobox();


       });