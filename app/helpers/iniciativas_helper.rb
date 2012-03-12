# encoding: utf-8
module IniciativasHelper

  def temas(inicitiva)
    list = inicitiva.topics.collect {|topic| content_tag(:li, link_to(topic.name, tema_path(topic))) }.join('')
    unsorted_list = content_tag(:ul, raw(list), :class => :temas)
    concat raw(unsorted_list)
  end

  def estado_de_iniciativa(iniciativa)
    list = []
    list << content_tag(:li, 'Etapa del proyecto')
    list << content_tag(:li, 'En comisión', :id => "presentacion_#{iniciativa.id}", :class => iniciativa.presented? ? 'presentation' : '')
    list << content_tag(:li, 'Dictamen', :id => "comision_#{iniciativa.id}", :class => iniciativa.commissioned? ? 'commission' : '')
    list << content_tag(:li, 'Debate en Pleno', :id => "en_pleno_#{iniciativa.id}", :class => iniciativa.plenaried? ? 'plenary' : '')
    list << content_tag(:li, 'Promulgación y vigencia', :id => "proyecto_#{iniciativa.id}", :class => iniciativa.projected? ? 'project' : '')
    concat raw(content_tag(:ul, raw(list.join('')), :class => :estado))
  end

  def votacion_oficial(iniciativa)
    list = []
    list << content_tag(:li, 'Votacion oficial')
    if iniciativa.official_voted?
      list << content_tag(:li, "A favor: #{iniciativa.official_percentage_up}%", :style => "width:#{iniciativa.official_pixel_votes_up}px", :class => 'a-favor')
      list << content_tag(:li, "En contra #{iniciativa.official_percentage_down}%", :style => "width:#{iniciativa.official_pixel_votes_down}px", :class => 'en-contra')
    else
      list << content_tag(:li, 'Proyecto no votado', :class => 'no-votada')
    end
    concat raw(content_tag(:ul, raw(list.join('')), :class => 'votacion-oficial'))
  end

  def votacion_local(iniciativa)
    list = []
    list << content_tag(:li, 'Votacion en 131 Voces')
    list << content_tag(:li, :style => "#{(iniciativa.voted?)? "width:#{iniciativa.pixel_votes_up}px" : '' }", :class => "#{(iniciativa.voted?)? 'a-favor' : 'no-votada'}") do
      "A favor: #{iniciativa.percentage_votes_up}%"
    end
    list << content_tag(:li, :style => "#{(iniciativa.voted?)? "width:#{iniciativa.pixel_votes_down}px" : '' }", :class => "#{(iniciativa.voted?)? 'en-contra' : 'no-votada'}") do
      "En contra #{iniciativa.percentage_votes_down}%"
    end
    concat raw(content_tag(:ul, raw(list.join('')), :class => 'votacion-local'))
  end

  def state_description(state)
    concat case state
    when 'presentation'
      'Fecha en que la Mesa Directiva de la Cámara turna la iniciativa a las comisiones, para su estudio, discusión y dictaminación.'
    when 'commission'
      'En esta etapa se analiza y se discute el contenido de la iniciativa, para hacer un dictamen o desecharla.'
    when 'plenary'
      'El dictamen preparado por la comisión correspondiente se presenta ante todos los diputados para su discusión y aprobación o descarte.'
    when 'project'
      'El dictamen se convierte en proyecto y pasa a la cámara revisora. Si es una minuta, se envía al Ejecutivo.'
    when 'rejected_by_commission'
      'El dictamen fue rechazado por la comision.'
    when 'rejected_by_board'
      'El dictamen fue rechazado por la mesa directiva.'
    end
  end
end
