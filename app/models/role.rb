class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  has_many :role_permissions
  has_many :permissions, through: :role_permissions

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

# == Schema Information
#
# Table name: roles
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
