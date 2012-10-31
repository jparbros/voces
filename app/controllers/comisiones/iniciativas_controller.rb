class Comisiones::IniciativasController < ApplicationController
  
  def show
    @iniciativas = Initiative.page(params[:page])
    @temas = Topic.all
    @commission = Commission.find(params[:comisione_id])
  end
  
end
