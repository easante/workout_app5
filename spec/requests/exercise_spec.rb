require 'rails_helper'

RSpec.describe "Exercises", type: :request do

  before do
    @john = User.create(email: "john@example.com", password: "password", first_name: "John", last_name: "Doe")

    @exercise =  @john.exercises.create!(duration_in_min: 55, workout: "Push ups", workout_date: 3.days.ago)
  end

  describe 'GET /users/:id/exercises' do
    context 'with no signed in user' do
      before { get "/users/#{@john.id}/exercises" }

      it "redirects to signin page" do
        flash_message = "You need to sign in or sign up before continuing."
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user' do
      before do
        login_as(@john)
        get "/users/#{@john.id}/exercises"
      end

      it "is successful" do
        expect(response.status).to eq 200
      end
    end
  end
end