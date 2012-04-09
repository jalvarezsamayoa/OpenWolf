# -*- coding: utf-8 -*-
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def default_body_attributes
    controller_name = controller.controller_path.gsub(/\//, '-')
    action_name     = controller.action_name
    {
      id:    "#{controller_name}-#{action_name}",
      class: "#{controller_name}"
      }
    end

    def menu_item(text, url, title='', image = 'file16.png')
      c_respond = "<li class='cssMenui'>"
      c_respond += link_to(image_tag(image)+ text, url, :title=>title, :class=>"ccMenui")
      c_respond += "</li>"
      return raw(c_respond)
    end

    def menu_item_remote(text, url, update, title='', image = 'file16.png')
      c_respond = "<li class='cssMenui'>"
      if update.nil?
        c_respond = link_to_remote(image_tag(image) + text, :update => update, :url => url, :class=>"ccMenui")
      else
        c_respond = link_to_remote(image_tag(image) + text, :url => url, :class=>"ccMenui")
      end
      c_respond += "</li>"
      return raw(c_respond)
    end

    def submit_popup(text = 'Grabar', image = 'accept16.png')
      c_response =  "<button type='submit' class='positive'>"+image_tag(image,:alt => text)+text+"</button>"
      return raw(c_response)
    end

    def close_popup(divname, text = 'Cancelar', image = 'close16.png')
      c_response = "<a href = 'javascript:void(0)' onclick = \"document.getElementById('#{divname}').style.display='none';\" class='button negative'>"
      c_response += image_tag(image)
      c_response += "#{text}</a>"
      return raw(c_response)
    end

    def close_dialog(divname, text = 'Cancelar', image = 'close16.png')
      c_response = "<a href = 'javascript:void(0)' onclick = \"$('#" + divname + "').dialog('close');\" class='button negative'>"
      c_response += image_tag(image)
      c_response += "#{text}</a>"
      return raw(c_response)
    end


    # RJS Helpers
    def context
      page.instance_variable_get("@context").instance_variable_get("@template")
    end

    def ajax_flash
      if page.context.flash[:error]
        divname = 'error'
        objeto = page.context.flash[:error]
      elsif page.context.flash[:success]
        divname = 'success'
        objeto = page.context.flash[:success]
      else
        divname = 'notice'
        objeto = page.context.flash[:notice]
      end

      page[divname].replace_html objeto
      page[divname].show
      page.context.flash.discard
      page.delay(3) do
        page.visual_effect :fade, divname
      end
    end

    def button(text = 'Grabar', icon = 'accept16.png')
      c_return = '<button type="submit" class="button">'
      c_return += image_tag(icon) + text
      c_return += '</button>'
      raw(c_return)
    end

    def button_create(text = 'Grabar Nuevo')
      return button(text)
    end

    def button_update(text = 'Grabar Cambios')
      return button(text)
    end


    def button_link(url = "#", text = 'Click Me', title = 'Click me', icon = 'accept16.png', positive = true, delete = false  )
      c_icon = image_tag(icon)

      unless delete
        if positive == true
          c_return = link_to c_icon  + text, url, :class => 'button positive', :title => title
        else
          c_return = link_to c_icon  + text, url, :class => 'button negative', :title => title
        end
      else
        c_return = link_to c_icon  + text, url, :class => 'button negative', :title => title, :method => :delete, :confirm => '¿Está seguro de eliminar el registro?'
      end

      return raw(c_return)
    end

    def button_new(url = "#", text = 'Nuevo')
      return button_link(url, text, "Crea nuevo registro.", 'add16.png')
    end

    def button_edit(url = "#", text = 'Editar')
      return button_link(url, text, "Editar información.", 'edit16.png')
    end

    def button_delete(url = "#", text = 'Eliminar')
      return button_link(url, text, "Eliminar el registro.", 'delete16.png', false, true)
    end

    def button_cancel(url = "#", text = 'Cancelar')
      return button_link(url, text, "Cancelar operación.", 'undo16.png', false)
    end


    def button_print(url = "#", text = 'Imprimir')
      c_return = link_to image_tag('printer16.png') + text, url, :class => 'button positive', :title => "Imprime Documento.", :popup => true
      return raw(c_return)
    end

    def button_export(url = "#", text = 'Exportar')
      c_return = link_to image_tag('down16.png') + text, url, :class => 'button positive', :title => "Exporta Documento a Plantilla.", :popup => true
      return raw(c_return)
    end


    def buttons_create(url = "#")
      return button_create + button_cancel(url)
    end

    def buttons_update(url = "#")
      return button_update + button_cancel(url)
    end

    def class_estado_asignacion(solicitud)
      c_result = "class='"
      if solicitud.atrasada?
        c_result += "error"
      elsif solicitud.terminada?
        c_result += "success"
      end
      c_result += "'"
      return raw(c_result)
    end


    # helpers para seguridad
    def nivel_seguridad(u = nil, nivel = 'public')
      return false if u.nil?

      logger.debug { "Verificando nivel: #{nivel}" }
      l_ok = false
      case nivel
      when 'superadmin'
        #      logger.debug { "Es: superadmin" }
        l_ok =  u.has_role?(:superadmin)
        logger.debug { "#{l_ok}" }
      when 'administrador'
        #     logger.debug { "Es: administrador" }
        l_ok =  (u.has_role?(:superadmin) or u.has_role?(:localadmin))
        logger.debug { "#{l_ok}" }
      when 'encargadoudip'
        logger.debug { "Es: encargadoudip" }
        l_ok = (u.has_role?(:superudip))
      when 'personaludip'
        l_ok = (u.has_role?(:superudip) or u.has_role?(:userudip))
      end
      return l_ok
    end

    def si_no(valor)
      valor ? 'Si' : 'No'
    end

    def add_this
      c_return = '<!-- AddThis Button BEGIN -->
<div class="addthis_toolbox addthis_default_style ">
<a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
<a class="addthis_button_tweet"></a>
<a class="addthis_counter addthis_pill_style"></a>
</div>
<script type="text/javascript">var addthis_config = {"data_track_clickback":true};</script>
<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=openwolf"></script>
<!-- AddThis Button END -->'
      return raw(c_return)
    end

    def bookmark_delicious
      c_return = '<img src="http://l.yimg.com/hr/img/delicious.small.gif" height="10" width="10" alt="Delicious" />
<a href="http://www.delicious.com/save" onclick="window.open(\'http://www.delicious.com/save?v=5&noui&jump=close&url=\'+encodeURIComponent(location.href)+\'&title=\'+encodeURIComponent(document.title), \'delicious\',\'tolbar=no,width=550,height=550\'); return false;"> Agregar a Favoritos</a>'
      return raw(c_return)
    end

  end
