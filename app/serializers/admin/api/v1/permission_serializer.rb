module Admin
  module Api
    module V1
      class PermissionSerializer < ApplicationSerializer
        attributes :id, :subject, :action, :created_at, :updated_at
        # Include associated data
        has_many :roles, serializer: Admin::Api::V1::RoleSerializer

        # Custom attributes
        attribute :role_count do
          object.roles.count
        end

        attribute :role_names do
          object.roles.pluck(:name) if object.roles.present?
        end

        attribute :full_action do
          "#{object.action} #{object.subject}"
        end

        attribute :is_model_permission do
          object.subject.present? && object.subject.constantize rescue false
        end

        attribute :is_global_permission do
          object.subject.blank?
        end
      end
    end
  end
end
