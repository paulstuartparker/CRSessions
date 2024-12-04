# == Schema Information
#
# Table name: locations
#
#  id                 :bigint           not null, primary key
#  additional_details :text
#  address            :string           not null
#  city               :string           not null
#  latitude           :decimal(10, 6)
#  longitude          :decimal(10, 6)
#  name               :string           not null
#  state              :string           not null
#  zip_code           :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_locations_on_latitude_and_longitude  (latitude,longitude)
#
class Location < ApplicationRecord
  has_many :sessions

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :zip_code, presence: true, format: { with: /\A\d{5}\z/, message: "should be 5 digits" }

  def full_address
    "#{address}, #{city}, #{state} #{zip_code}"
  end

  def display_name
    "#{name} (#{city}, #{state})"
  end
end 
