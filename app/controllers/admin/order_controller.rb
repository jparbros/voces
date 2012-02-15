class Admin::OrderController < Admin::BaseController
  def new
    @initiatives = Initiative.all
  end

  def create
    Initiative.update_sort params[:initiatives]
    render :nothing => true
  end
end
