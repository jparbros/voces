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
    if iniciativa.archived?
      list << content_tag(:li, 'Archivado', :id => "archivado_#{iniciativa.id}", :class => 'archived')
    else
      list << content_tag(:li, 'En comisión', :id => "presentacion_#{iniciativa.id}", :class => iniciativa.presented? ? 'presentation' : '')
      list << content_tag(:li, 'Dictamen', :id => "comision_#{iniciativa.id}", :class => iniciativa.commissioned? ? 'commission' : '')
      list << content_tag(:li, 'Debate en Pleno', :id => "en_pleno_#{iniciativa.id}", :class => iniciativa.plenaried? ? 'plenary' : '')
      list << content_tag(:li, 'Promulgación y vigencia', :id => "proyecto_#{iniciativa.id}", :class => iniciativa.projected? ? 'project' : '')
    end
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
      'Inmediatamente después que un proyecto de ley ha sido presentado según las normas constitucionales y reglamentarias, es enviado a una o varias Comisiones ordinarias.'
    when 'dictum'
      'El proyecto de ley ha sido estudiado y debatido por las Comisiones ordinarias, las que han elaborado y presentado dictamen (informe sobre el proyecto).'
    when 'debate_in_plenary'
      'El proyecto, que ya cuenta con dictamen o es exonerado de él, pasa al Pleno del Congreso para su debate y votación.'
    when 'promulgation_and_enforcement'
      'Si el Presidente de la República promulga la ley sin observaciones la manda publicar y entra en vigencia y se integra al ordenamiento jurídico nacional como nueva ley.'
    when 'archived'
      'El proyecto de ley es archivado cuando es rechazado de plano por la Comisiones ordinarios o cuando, sometida a votación, es rechazada por el Pleno.'
    end
  end
end
