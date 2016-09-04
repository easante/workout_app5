class Exercise < ApplicationRecord
  belongs_to :user
  
  alias_attribute :workout_details, :workout
  alias_attribute :activity_date, :workout_date
  
  validates :duration_in_min, numericality: { greater_than: 0.0 }
  validates :workout_details, presence: true
  validates :activity_date, presence: true
  validate :activity_date_cannot_be_in_the_future
  
  default_scope { where('workout_date > ?', 7.days.ago)
                  .order(workout_date: :desc) }
                  
  def activity_date_cannot_be_in_the_future
    if activity_date.present? && activity_date > Date.today
      errors.add(:activity_date, "can't be in the future")
    end
  end
end
