class Permission < ApplicationRecord
  has_many :role_permissions
  has_many :roles, through: :role_permissions

  ACTIONS = %w[create read update destroy manage].freeze

  def self.generate_for_models
    models = ApplicationRecord.descendants.reject do |model|
    model.abstract_class? ||
    model.name.start_with?("ActiveStorage", "ActionText")
  end

    models.each do |model|
      ACTIONS.each do |action|
        find_or_create_by!(
          action: action,
          subject: model.name
        )
      end
    end
  end
end

# == Schema Information
#
# Table name: permissions
#
#  id         :uuid             not null, primary key
#  action     :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
