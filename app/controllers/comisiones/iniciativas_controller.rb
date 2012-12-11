class Comisiones::IniciativasController < ApplicationController
  
  def show
    @commission = Commission.find(params[:comisione_id])
    @iniciativas = @commission.initiatives.page(params[:page])
    @temas = Topic.all
  end
  
end
