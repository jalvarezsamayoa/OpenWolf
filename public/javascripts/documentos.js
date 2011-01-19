// documentos.js

jQuery(function($){


         $(function(){
             $("#archivar-dialog").dialog({autoOpen: false,
                                           height: 250,
                                           width: 500,
                                           modal: true,
                                           title: "Archivar documento"
                                          });

             $("#trasladar-dialog").dialog({autoOpen: false,
                                           height: 600,
                                           width: 600,
                                            modal: true,
                                            title: "Trasladar documento"
                                          });


             $("#documento_fecha_recepcion").datepicker();
             $("#documento_fecha_documento").datepicker();
             $(".combobox").combobox();
             $("#documento_origen_id").focus();
           });


       });