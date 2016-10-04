class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private
  
  def current_room
    @room ||= Room.find(session[:current_room]) if session[:current_room]
  end
  
  helper_method :current_room
end
