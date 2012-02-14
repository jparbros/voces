class HomeController < ApplicationController

  def show
    @iniciativa = Initiative.to_home
  end
end
