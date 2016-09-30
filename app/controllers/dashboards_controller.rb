class DashboardsController < ApplicationController
  def index
    @athletes = User.all
  end
end