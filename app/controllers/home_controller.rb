class HomeController < ApplicationController

  def show
    @iniciativa = Initiative.to_home
    @representantes = Representative.monitoreados
    @imagenes = ['minero.png','viejita.png','estudiante.png','chica.png','viejito.png','mama.png']
  end
end
