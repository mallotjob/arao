module Admin
  module Api
    module V1
      class RoleSerializer < ApplicationSerializer
        attributes :id, :name, :description, :created_at, :updated_at

        # Custom attributes
        attribute :user_count do
          object.users.count
        end

        attribute :permission_count do
          object.permissions.count
        end
      end
    end
  end
end
