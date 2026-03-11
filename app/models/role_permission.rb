class RolePermission < ApplicationRecord
  belongs_to :role
  belongs_to :permission

  validates :role_id, uniqueness: { scope: :permission_id }
end

# == Schema Information
#
# Table name: role_permissions
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  permission_id :uuid             not null
#  role_id       :uuid             not null
#
# Indexes
#
#  index_role_permissions_on_permission_id  (permission_id)
#  index_role_permissions_on_role_id        (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (permission_id => permissions.id)
#  fk_rails_...  (role_id => roles.id)
#
