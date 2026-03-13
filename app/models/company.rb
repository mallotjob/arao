class Company < ApplicationRecord
  include ::CompanyScoped
  acts_as_paranoid

  has_many :users, dependent: :restrict_with_error
  has_many :beneficiaries, dependent: :restrict_with_error
  has_many :type_configs, dependent: :restrict_with_error
  has_many :balances, dependent: :restrict_with_error
  has_many :products, through: :balances

  validates :name, presence: true, uniqueness: true

  # Default scope to exclude deleted records
  default_scope -> { where(deleted_at: nil) }

  # Scopes
  scope :active, -> { where(deleted_at: nil) }
  scope :inactive, -> { where.not(deleted_at: nil) }

  def active?
   !deleted?
  end
end

# == Schema Information
#
# Table name: companies
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_deleted_at  (deleted_at)
#
