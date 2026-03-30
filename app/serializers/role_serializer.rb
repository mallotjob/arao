class RoleSerializer < ApplicationSerializer
  attributes :name

  # Include associated permissions
  has_many :permissions
end
