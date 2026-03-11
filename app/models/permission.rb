class Permission < ApplicationRecord
  has_many :role_permissions
  has_many :roles, through: :role_permissions
end

# == Schema Information
#
# Table name: permissions
#
#  id         :uuid             not null, primary key
#  action     :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
