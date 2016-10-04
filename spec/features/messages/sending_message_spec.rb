require "rails_helper"

RSpec.feature "Sending a message" do
  before do
    @john = User.create!(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password')
    @sarah = User.create!(first_name: 'Sarah', last_name: 'Anderson', email: 'sarah@example.com', password: 'password')
    @henry = User.create!(first_name: 'Henry', last_name: 'Flynn', email: 'henry@example.com', password: 'password')
    
    @room_name = @john.first_name + '-' + @john.last_name
    @room = Room.create!(name: @room_name, user_id: @john.id)
    
    login_as(@john)
    
    Friendship.create(user: @sarah, friend: @john)
    Friendship.create(user: @henry, friend: @john)
  end
  
  scenario "to followers shows in chatroom window" do
    visit '/'
    
    click_link "My Lounge"
    expect(page).to have_content(@room_name)
    
    fill_in "message-field", with: "Hello"
    click_button "Post"
    
    expect(page).to have_content("Hello")
    
    within("#followers") do
      expect(page).to have_link(@sarah.full_name)
      expect(page).to have_link(@henry.full_name)
    end
  end

end