var seguimientosPage = {
  setupDialogoNuevoSeguimiento: function(){

    // asignacion de funcionalida de dialogo
    // dialogo es requerido por seguimientos/new.js.erb
    $("div#newseguimiento").dialog({ title: "Agregar nuevo seguimiento",
                                     height: 375,
                                     width: 700,
                                     modal: true,
                                     autoOpen: false });

    // asignacion de funcionalid a forma creacion de seguimientos
    // seguimientos/_new.html.haml
    $("form#new_seguimiento").live('submit',function(event){
                                     event.preventDefault();
                                     var form = $(this);
                                     var texto = form.find('textarea#seguimiento_textoseguimiento');
                                     if (texto.val() == '') {
                                       texto.focus();
                                       alert('Debe ingresar una descripción para grabar el seguimiento.');
                                       return false;
                                     };

                                     form.block({message: '<h2><img src=\"/images/ajax-loader.gif\"/> Procesando...</h2>'});

                                     $.ajax({
                                              type: "POST",
                                              url: form.attr("action"),
                                              data: form.serialize(),
                                              dataType: "script"
                                            });

                                   });
  }

};

$(document).ready(function(){
                    seguimientosPage.setupDialogoNuevoSeguimiento();
                  });