module Admin
  module Api
    module V1
      class CompanySerializer < ApplicationSerializer
        attributes :id, :name, :created_at, :updated_at

        # Include associated data
        has_many :beneficiaries, serializer: Admin::Api::V1::UserSerializer
        has_many :balances, serializer: Admin::Api::V1::BalanceSerializer
        has_many :products, serializer: Admin::Api::V1::ProductSerializer

        # Custom attributes
        attribute :user_count do
          object.users.count
        end

        attribute :beneficiary_count do
          object.beneficiaries.count
        end

        attribute :product_count do
          object.products.count
        end

        attribute :balance_count do
          object.balances.count
        end

        attribute :active_users_count do
          object.users.where.not(current_sign_in_at: nil).count
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
      end
    end
  end
end
