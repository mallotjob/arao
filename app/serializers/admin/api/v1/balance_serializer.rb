module Admin
  module Api
    module V1
      class BalanceSerializer < ApplicationSerializer
        attributes :id, :weight, :volume, :created_at, :updated_at

        # Include associated data
        belongs_to :product, serializer: Admin::Api::V1::ProductSerializer
        belongs_to :company, serializer: Admin::Api::V1::CompanySerializer

        # Custom attributes
        attribute :weight_per_volume do
          object.volume && object.volume > 0 ? (object.weight / object.volume).round(2) : 0
        end

        attribute :product_commodity do
          object.product&.commodity
        end

        attribute :product_status do
          object.product&.aasm_state
        end

        attribute :product_quantity do
          object.product&.quantity
        end

        attribute :company_name do
          object.company&.name
        end

        attribute :beneficiary_name do
          "#{object.product&.beneficiary&.first_name} #{object.product&.beneficiary&.last_name}".strip if object.product&.beneficiary
        end

        attribute :total_weight do
          object.weight * (object.product&.quantity || 1)
        end

        attribute :total_volume do
          object.volume * (object.product&.quantity || 1)
        end

        attribute :is_active do
          object.product&.aasm_state != "delivered"
        end
      end
    end
  end
end
