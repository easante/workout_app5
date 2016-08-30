class ExercisesController < ApplicationController
  def index
  end
  
  def new
    @exercise = current_user.exercises.new
  end
end