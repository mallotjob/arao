module Admin
  module Api
    module V1
      class ShippingTimeSerializer < ApplicationSerializer
        attributes :id, :name, :days, :description, :created_at, :updated_at

        # Include associated data
        has_many :products, serializer: Admin::Api::V1::ProductSerializer

        # Custom attributes
        attribute :product_count do
          object.products.count
        end

        attribute :products_by_status do
          {
            pending: object.products.where(aasm_state: "pending").count,
            confirmed: object.products.where(aasm_state: "confirmed").count,
            shipped: object.products.where(aasm_state: "shipped").count,
            completed: object.products.where(aasm_state: "completed").count,
            delivered: object.products.where(aasm_state: "delivered").count
          }
        end

        attribute :is_express do
          object.days && object.days <= 3
        end

        attribute :is_standard do
          object.days && object.days > 3 && object.days <= 7
        end

        attribute :is_slow do
          object.days && object.days > 7
        end

        attribute :display_name do
          "#{object.name} (#{object.days} days)"
        end
      end
    end
  end
end
