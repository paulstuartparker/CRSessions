class Session < ApplicationRecord
  belongs_to :location

  validates :title, presence: true
  validates :style, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  
  # For recurring sessions
  validates :recurrence_rule, presence: true, if: :recurring?
  
  scope :happening_today, -> { 
    where('start_time >= ? AND start_time <= ?', 
          Time.current.beginning_of_day, 
          Time.current.end_of_day)
  }
  
  scope :upcoming, -> { where('start_time > ?', Time.current) }
  
  def recurring?
    recurrence_rule.present?
  end
end 