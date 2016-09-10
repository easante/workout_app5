class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  default_scope { order(created_at: :desc).limit(10) }
end
