class ExercisesController < ApplicationController
 before_action :set_exercise, only: [:show, :edit, :update, :destroy]
 
  def index
    @exercises = current_user.exercises
  end
  
  def show
  end
  
  def new
    @exercise = current_user.exercises.new
  end
  
  def create
    @exercise = current_user.exercises.new(exercise_params)
    
    if @exercise.save
      flash[:notice] = "Exercise has been created"
      redirect_to [current_user, @exercise]
    else
      flash.now[:alert] = "Exercise has not been created"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @exercise.update(exercise_params)
      flash[:notice] = "Exercise has been updated"
      redirect_to [current_user, @exercise]
    else
      flash[:alert] = "Exercise has not been updated"
      render :edit
    end
  end
  
  def destroy
    @exercise.destroy
    flash[:notice] = "Exercise has been deleted"
    redirect_to user_exercises_path(current_user)
  end
  
  private
  
  def set_exercise
    @exercise = current_user.exercises.find params[:id]
  end
  
  def exercise_params
    params.require(:exercise).permit(:duration_in_min, :workout, :workout_date, :user_id)
  end
  
end