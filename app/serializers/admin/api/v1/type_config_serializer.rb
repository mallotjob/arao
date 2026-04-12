module Admin
  module Api
    module V1
      class TypeConfigSerializer < ApplicationSerializer
        attributes :id, :name, :created_at, :updated_at

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

        attribute :average_weight do
          products = object.products
          if products.any?
            (products.sum(:weight) / products.count).round(2)
          else
            0
          end
        end

        attribute :average_volume do
          products = object.products
          if products.any?
            total_volume = products.sum do |p|
              (p.height * p.length * p.width) || 0
            end
            (total_volume / products.count).round(2)
          else
            0
          end
        end

        attribute :is_popular do
          object.products.count >= 10
        end

        attribute :display_name do
          object.name
        end
      end
    end
  end
end
