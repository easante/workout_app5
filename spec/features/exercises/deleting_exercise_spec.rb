require "rails_helper"

RSpec.feature "Deleting Exercise" do
  before do
    @owner = User.create!(first_name: "John", last_name: "Doe", email: "owner@example.com", password: "password")
    
    @owner_exercise = @owner.exercises.create!(duration_in_min: 48,
                                                workout: "My body building activity",
                                                workout_date: Date.today)
                                                
    login_as(@owner)
  end
  
  scenario do
    visit "/"
    
    click_link "My Lounge"
    
    path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}"
    link = "//a[contains(@href,\'#{path}\') and .//text()='Destroy']"
    
    find(:xpath, link).click
    
    expect(page).to have_content("Exercise has been deleted")
  end
    
end