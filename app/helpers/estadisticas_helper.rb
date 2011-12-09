# -*- coding: utf-8 -*-
module EstadisticasHelper

  def estadisticas_solicitudes_completadas_por_ano(solicitudes, opts = {})

    series = (opts[:series] ||= 1)

    opts = {:titulo => "Solicitudes Completadas por Año"}
    opts[:rango] = generar_rango(solicitudes, "total_solicitudes")
    opts[:series] = generar_series(opts[:rango], series)
    opts[:labels] = generar_labels(solicitudes, "ano", series)
    opts[:data] = generar_data(solicitudes, "total_solicitudes")

    estadisticas_bar_chart(opts)
  end

  def estadisticas_solicitudes_completadas_por_mes_ano(solicitudes)

    series = calcular_series(solicitudes, "ano")

    opts = {:titulo => "Solicitudes Completadas por Año"}
    opts[:rango] = generar_rango(solicitudes, "total_solicitudes")
    opts[:series] = generar_series(opts[:rango], series)
    opts[:slabels] = generar_series_labels(solicitudes, "ano", "ano")

    opts[:data] = generar_data_mes_ano(solicitudes, "total_solicitudes", "ano")

    opts[:colors] = generar_colores(series)

    estadisticas_bar_chart(opts)
  end


  private


  def generar_data_mes_ano(datos, campo, group_by)
    
    data = {}
 
    anos = datos.group_by {|g| g.send(group_by)}
  
    anos.each do |ano, meses|
      data[ano] = [0,0,0,0,0,0,0,0,0,0,0,0]

      puts data.inspect
      
      meses.each do |dato|      
        data[ano][dato.mes.to_i - 1] = dato.send(campo)
      end
    end #groups each

    puts data.inspect

    data_string = ""
    data.each do |key, val|
      data_string += val.join(',')     
      data_string.chomp!(",")
      data_string += "|"
    end
    data_string.chomp!("|")

    return data_string
  end

  def estadisticas_bar_chart(opts = {})

    rango = (opts[:rango] ||= "0,100")
    series = (opts[:series] ||= rango)
    series_labels = (opts[:slabels] ||= 'Solicitudes')
    title = (opts[:titulo] ||= "Titulo de la grafica")

    data = (opts[:data] ||= "10,50,60,80,40,60,30")

    labels = (opts[:labels] ||= "|Ene|Feb|Mar|Abr|May|Jun|Jul|Ago|Sep|Oct|Nov|Dic")
    size = (opts[:size] ||= "600x225")

    colors = (opts[:colors] ||= "A2C180,FF9900")

    url = "http://chart.apis.google.com/chart"
    url += "?chxl=1:#{labels}"
    url += "&chxr=0,#{rango}"
    url += "&chxt=y,x"
    url += "&chbh=a,1,12"
    url += "&chs=#{size}"
    url += "&cht=bvg"
    url += "&chco=#{colors}"
    url += "&chdl=#{series_labels}"
    url += "&chds=#{series}"
    url += "&chd=t:#{data}"
    url += "&chtt=#{title}"

    # http://chart.apis.google.com/chart
    # ?chxl=1:|Ene|Feb|Mar|Abr|May|Jun|Jul|Ago|Sep|Oct|Nov|Dic
    # &chxr=0,0,1000
    # &chxt=y,x
    # &chbh=a
    # &chs=300x225
    # &cht=bvg
    # &chco=A2C180
    # &chds=0,1000
    # &chd=t:10,50,60,80,40,60,30
    # &chtt=Vertical+bar+chart

    return url
  end

  def calcular_series(datos, group_by)
    groups = datos.group_by {|g| g.send(group_by)}
    n = groups.size
    return n
  end


  def generar_series_labels(datos, campo, group_by)
    labels = ""

    groups = datos.group_by {|g| g.send(group_by)}

    groups.each do |group, sub_data|
      label = sub_data[0].send(campo)
      labels += "#{label}|"
    end
    labels.chomp!("|")

    return labels
  end



  def generar_series(rango, series = 1)
    escalas = ""
    series.times do
      escalas += rango + ","
    end
    escalas.chomp!(",")
    return escalas
  end

  def generar_data(datos, campo, group_by = nil)
    data = ""

    if group_by

      groups = datos.group_by {|g| g.send(group_by)}

      groups.each do |group, sub_data|

        sub_data.each do |dato|
          data += "#{dato.send(campo)},"
        end

        data.chomp!(",")
        data += "|"

      end
      data.chomp!("|")

    else
      datos.each do |dato|
        data += "#{dato.send(campo)},"
      end
      data.chomp!(',')
    end

    return data
  end

  def generar_labels(datos, campo, series)
    labels = ""

    datos.each do |dato|
      labels += "|#{dato.send(campo)}"
    end
    return labels
  end

  def generar_rango(datos, campo)
    return "0,0" if datos.blank?
    max = datos.max_by {|dato| dato.send(campo).to_i }
    rango = "0,#{max.send(campo)}"
    return rango
  end

  def generar_colores(series)
    colors = ""

    color = 0xA2C180

    series.times do
      colors += color.to_s(16).upcase + ","
      color += 0x33
    end
    colors.chomp!(",")

    return colors
  end

end
