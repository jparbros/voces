class HomeController < ApplicationController

  def show
    @iniciativas = Initiative.to_home
    @iniciativa = @iniciativas.first
  end
end
