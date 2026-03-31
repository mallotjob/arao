module Admin
  module Api
    module V1
      class ProductSerializer < ApplicationSerializer
        attributes :id, :commodity, :height, :length, :width, :quantity, :weight, :aasm_state, :created_at, :updated_at

        # Include associated data
        belongs_to :shipping_time, serializer: Admin::Api::V1::ShippingTimeSerializer
        belongs_to :type_config, serializer: Admin::Api::V1::TypeConfigSerializer
        belongs_to :beneficiary, serializer: Admin::Api::V1::UserSerializer
        belongs_to :balance, serializer: Admin::Api::V1::BalanceSerializer

        # Custom attributes
        attribute :volume do
          object.height * object.length * object.width if object.height && object.length && object.width
        end

        attribute :weight_per_volume do
          volume = object.height * object.length * object.width if object.height && object.length && object.width
          volume && volume > 0 ? (object.weight / volume).round(2) : 0
        end

        attribute :status_display do
          object.aasm_state&.humanize
        end

        attribute :can_transition_to do
          object.aasm.states(permitted: true).map(&:name)
        end

        attribute :beneficiary_name do
          "#{object.beneficiary&.first_name} #{object.beneficiary&.last_name}".strip if object.beneficiary
        end

        attribute :beneficiary_email do
          object.beneficiary&.email
        end

        attribute :beneficiary_company do
          object.beneficiary&.company&.name
        end

        attribute :shipping_time_display do
          object.shipping_time&.name
        end

        attribute :type_config_display do
          object.type_config&.name
        end

        attribute :dimensions do
          {
            height: object.height,
            length: object.length,
            width: object.width
          }
        end

        attribute :is_editable do
          object.aasm_state == "pending"
        end

        attribute :is_deletable do
          object.aasm_state == "pending"
        end
      end
    end
  end
end
