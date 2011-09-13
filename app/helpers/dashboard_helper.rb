# -*- coding: utf-8 -*-
module DashboardHelper
  BASEURL = 'http://chart.apis.google.com/chart'
  MESES = '?chxl=0:|Ene|Feb|Mar|Abr|May|Jun|Jul|Ago|Sep|Oct|Nov|Dic'
  CHARTSIZE = '&chs=360x300'

  #genera un diagrama de pie indicando 
  def solicitudes_por_estado(user = nil, title = 'Solicitudes+por+estado+')
    ano = Date.today.year
    data = get_solicitudes_por_estado(user, ano)
    

   # raise data.inspect

    url = BASEURL
    url += '?cht=p' # pie
    url += '&chco=224499' #color azul
    url += '&chs=400x240' #tamaño grafico
    url += '&chd=t:'+data[0].to_s #porcentajes
    url += '&chdl='+data[1].to_s #labels porcentaje
    url += '&chl='+data[2].to_s  #labels
    url += '&chtt='+title+ano.to_s
    
   
    # http://chart.apis.google.com/chart
   # ?chs=280x150
   # &cht=p
   # &chd=t:20,80
   #  &chdl=20.05|79.05
   # &chp=0.628
   # &chl=En+Tramite|Entregado+Total
    #  &chtt=Solicitudes+por+Estado

    #http://chart.apis.google.com/chart&chs=360x300&cht=p&chd=t:77.5862068965517,22.4137931034483&chp=0.628&chl=En+trámite|Entregada+Total&chtt=Solicitudes+por+Estado


   return url
  end
   
  # genera un diagrama de lineas indicando la cantidad
  # de solicitudes recibidas por mes
  def solicitudes_por_mes(user = nil, title = 'Solicitudes+Recibidas+')
    data_max_range = 0  
    ano = Date.today.year
    data = get_solicitudes_por_mes_en_ano(user, ano, data_max_range)
    
    url = BASEURL
    url += MESES
    url += '&chxr=1,0,'+data[1].to_s+',10'
    url += '&chxs=0,224499,14,0,l,676767'
    url += '&chxt=x,y'
    url += CHARTSIZE
    url += '&cht=lc'
    url += '&chco=008000'
    url += '&chd=t:'+data[0]
    url += '&chg=20,10'
    url += '&chls=1,9,1'
    url += '&chma=0,0,10'
    url += '&chtt='+title+ano.to_s
    url += '&chds=0,'+data[1].to_s
    url += '&chm=o,80C65A,0,-2,8'

   #    http://chart.apis.google.com/chart
   # ?chxl=0:|Jan|Feb|Mar|Jun|Jul|Aug
   # &chxr=0,0,95|1,0,100
   # &chxs=0,224499,14,0,l,676767
   # &chxt=x,y
   # &chs=250x250
   # &cht=lc
   # &chco=008000
   # &chd=t:4.918,14.754,9.836,24.59,19.672,49.18,9.836,24.59,34.426,24.59,39.344,44.262,49.18,59.016,44.262
   # &chg=20,25
   # &chls=1
   # &chma=0,0,10
   #  &chtt=Historico+Solicitudes+Recibidas
        
    return url
  end


  private

  def get_solicitudes_por_estado(user, ano = Date.today.year)
    data = ['','','']
    
    if user.nil?
      logger.debug { "Soilcitudes sin usuario" }
      solicitudes = Solicitud.count(:all,  :conditions => "date_part('year',fecha_creacion) = #{ano}", :group => "estado_id")
      n = Solicitud.creadas_en_ano(ano).count
    else
      logger.debug { "Solicitudes con usuario" }
      solicitudes = user.institucion.solicitudes.count(:all,  :conditions => "date_part('year',fecha_creacion) = #{ano}", :group => "estado_id")
      n = user.institucion.solicitudes.creadas_en_ano(ano).count
    end

    logger.debug { "N: #{n}" }
    logger.debug { "#{solicitudes.inspect}" }

    solicitudes.each do |key, value|
      estado = Estado.find(key).nombre
      cnt = value

      logger.debug { "value: #{value}" }
      p = ((value*100.0)/n)
      logger.debug { "p: #{p}" }
      p = p.round(2).to_s
      logger.debug { "p: #{p}" }
      
      data[0] +=  p + ','
      data[1] +=  p + '|'
      data[2] += estado.tr(' ','+') + '|'

      logger.debug { "data: #{data.inspect}" }
      logger.debug { "========================" }
    end

    data[0] = data[0].chop
    data[1] = data[1].chop
    data[2] = data[2].chop

    return data
  end

  def get_solicitudes_por_mes_en_ano(user, ano, data_max_range)
    data = ['',data_max_range]

    if user.nil?
      solicitudes = Solicitud.count('id', :conditions => "date_part('year',fecha_creacion) = #{ano}", :group => "date_part('month',fecha_creacion)")
    else
      solicitudes = user.institucion.solicitudes.count('id', :conditions => "date_part('year',fecha_creacion) = #{ano}", :group => "date_part('month',fecha_creacion)")
    end

    (1..12).each do |i|
      if solicitudes[i.to_s].nil?
        data[0] += "0,"
      else       
        data[0] += solicitudes[i.to_s].to_s + ","

        if solicitudes[i.to_s] > data[1]
          data[1] = solicitudes[i.to_s]
        end
      end
    end
    data[0] = data[0].chop

#    raise data.inspect
    
    return data
  end
end
