class Admin::MainController < Admin::BaseController
  def create
    Initiative.update_all :main => false
    @initiative = Initiative.find params[:initiative_id]
    @initiative.toggle! :main
    @initiative.update_attribute(:main_at, Time.now)
    redirect_to :back
  end
end
