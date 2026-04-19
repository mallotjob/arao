module Admin
  module Api
    module V1
      class UserSerializer < ApplicationSerializer
        attributes :id, :email, :first_name, :last_name, :username, :all_access, :phone_number

        # Include associated data
        has_many :roles, serializer: Admin::Api::V1::RoleSerializer
        belongs_to :company, serializer: Admin::Api::V1::CompanySerializer
        belongs_to :creator, serializer: Admin::Api::V1::SimpleUserSerializer
        belongs_to :updater, serializer: Admin::Api::V1::SimpleUserSerializer

        # Custom attributes
        attribute :full_name do
          "#{object.first_name} #{object.last_name}"
        end

        attribute :permissions do
          object.roles.flat_map(&:permissions).uniq if object.roles.present?
        end

        # Include authentication token if present
        attribute :auth_token do
          object.auth_token if object.respond_to?(:auth_token)
        end

        # Format timestamps
        def created_at
          object.created_at.iso8601 if object.created_at
        end

        def updated_at
          object.updated_at.iso8601 if object.updated_at
        end

        # Include created_by and updated_by with dates
        attribute :created_by_info do
          {
            user_id: object.created_by,
            user_name: object.creator&.full_name,
            created_at: object.created_at&.iso8601
          } if object.created_by
        end

        attribute :updated_by_info do
          {
            user_id: object.updated_by,
            user_name: object.updater&.full_name,
            updated_at: object.updated_at&.iso8601
          } if object.updated_by
        end

        # Exclude sensitive data
        def attributes(*args)
          hash = super
          hash.delete(:password_digest) if hash.key?(:password_digest)
          hash.delete(:reset_password_token) if hash.key?(:reset_password_token)
          hash.delete(:confirmation_token) if hash.key?(:confirmation_token)
          hash.delete(:encrypted_password) if hash.key?(:encrypted_password)
          hash.delete(:remember_created_at) if hash.key?(:remember_created_at)
          hash.delete(:reset_password_sent_at) if hash.key?(:reset_password_sent_at)
          hash
        end
      end
    end
  end
end
