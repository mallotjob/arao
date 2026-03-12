class Company < ApplicationRecord
  acts_as_paranoid

  has_many :users, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w[active inactive] }

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
