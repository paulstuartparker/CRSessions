# == Schema Information
#
# Table name: sessions
#
#  id              :bigint           not null, primary key
#  end_time        :datetime         not null
#  notes           :text
#  recurrence_rule :integer
#  recurring       :boolean
#  start_time      :datetime         not null
#  style           :string           not null
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  location_id     :bigint           not null
#
# Indexes
#
#  index_sessions_on_location_id  (location_id)
#  index_sessions_on_start_time   (start_time)
#  index_sessions_on_style        (style)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
class Session < ApplicationRecord
  belongs_to :location

  enum :recurrence_rule, {
    weekly: 0,
    monthly: 1,
    first_sunday: 2,
    last_thursday: 3
  }

  scope :happening_today, -> { where(start_time: Time.current.all_day) }
  scope :upcoming, -> { where("start_time > ?", Time.current).order(start_time: :asc) }

  validates :title, presence: true
  validates :style, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :location, presence: true
end
