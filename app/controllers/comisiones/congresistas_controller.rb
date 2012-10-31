class Comisiones::CongresistasController < ApplicationController
  
  def show
    @commission = Commission.find(params[:comisione_id])
    @partidos_politicos = PoliticalParty.all
  end
end
