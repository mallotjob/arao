class PermissionSerializer < ApplicationSerializer
  attributes :id, :subject, :action, :created_at, :updated_at
end
