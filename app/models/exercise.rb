class Exercise < ApplicationRecord
  belongs_to :user
  
  alias_attribute :workout_details, :workout
  alias_attribute :activity_date, :workout_date
  
  validates :duration_in_min, numericality: { greater_than: 0.0 }
  validates :workout_details, presence: true
  validates :activity_date, presence: true
end
