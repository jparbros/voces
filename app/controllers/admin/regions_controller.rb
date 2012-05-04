class Admin::RegionsController < Admin::BaseController

  def index
    @regions = Region.page(params[:page])
  end

  def new
    @region = Region.new
  end

  def edit
    @region = Region.find params[:id]
  end

  def create
    @region = Region.new(params[:region])
    if @region.save
      redirect_to admin_regions_url, :notice => "Circunscripcion creada exitosamente"
    else
      render :new
    end
  end

  def update
    @region = Region.find(params[:id])
    if @region.update_attributes(params[:region])
      redirect_to admin_regions_url, :notice => "Circunscripcion editada exitosamente"
    else
      render :edit
    end
  end

  def destroy
    @region = Region.find(params[:id])
    @region.destroy
    redirect_to admin_regions_url
  end
end
