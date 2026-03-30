class CompanySerializer < ApplicationSerializer
  attributes :name, :deleted_at, :created_at, :updated_at
end
