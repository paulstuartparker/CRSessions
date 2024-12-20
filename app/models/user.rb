# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  location_id            :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_location_id           (location_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :location, optional: true

  enum :role, { admin: "admin", location_user: "location_user" }

  after_initialize :set_default_role, if: :new_record?

  validate :location_user_has_location

  accepts_nested_attributes_for :location

  def set_default_role
    self.role ||= :location_user
  end

  private

  def location_user_has_location
    if role == "location_user" && location.blank?
      errors.add(:location, "Location is required for location_user role")
    end
  end
end
