class ComisionesController < ApplicationController
  
  def index
    @commissions = Commission.page(params[:page])
    @temas = Topic.all
  end
  
  def show
    @commission = Commission.find(params[:id])
    @partidos_politicos = PoliticalParty.all
  end
end
