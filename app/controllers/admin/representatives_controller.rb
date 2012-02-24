class Admin::RepresentativesController < Admin::BaseController
  def index
    @representatives =   if params[:q]
        Representative.where("first_name ilike ? or last_name ilike ?", "%#{params[:q]}%", "%#{params[:q]}%")
      else
        Representative.page(params[:page])
      end
    respond_to do |format|
      format.html
      format.json { render :json => @representatives }
    end
  end

  def new
    @representative = Representative.new
    @representative.representation_actions.build
    @regions = Region.all.collect {|state| [state.name, state.id]}
    @provinces = []
    @political_parties = PoliticalParty.all.collect {|political_party| [political_party.name, political_party.id]}
  end

  def create
    @representative = Representative.new(params[:representative])
    if @representative.save
      redirect_to admin_representatives_url, :notice => "Representante creado exitosamente"
    else
      render :new
    end
  end

  def edit
    @representative = Representative.find(params[:id])
    @representative.representation_actions.build
    @regions = Region.all.collect {|state| [state.name, state.id]}
    @provinces = []
    @political_parties = PoliticalParty.all.collect {|political_party| [political_party.name, political_party.id]}
  end

  def update
    @representative = Representative.find(params[:id])
    if @representative.update_attributes(params[:representative])
      redirect_to admin_representatives_url, :notice => "Representante editado exitosamente"
    else
      render :edit
    end
  end

  def destroy
    @representative = Representative.find(params[:id])
    @representative.destroy
    redirect_to admin_representatives_url, :notice => "Representante eliminado exitosamente"
  end
end
