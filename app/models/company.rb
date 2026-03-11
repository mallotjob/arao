class Company < ApplicationRecord
  has_many :users, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: %w[active inactive] }

  # Default scope to exclude deleted records
  default_scope -> { where(deleted_at: nil) }

  # Scopes
  scope :active, -> { where(status: "active") }
  scope :inactive, -> { where(status: "inactive") }
  scope :including_deleted, -> { unscope(where: :deleted_at) }

  # Soft delete functionality
  def soft_delete!
    update!(deleted_at: Time.current, status: "inactive")
  end

  def restore!
    update!(deleted_at: nil, status: "active")
  end

  def deleted?
    deleted_at.present?
  end

  def active?
    status == "active" && !deleted?
  end

  # Override destroy to use soft delete
  def destroy
    soft_delete!
  end

  # Override delete to use soft delete
  def delete
    soft_delete!
  end

  # Really destroy (bypass soft delete)
  def really_destroy!
    super
  end

  # Class methods for including deleted records
  def self.with_deleted
    unscope(where: :deleted_at)
  end

  def self.only_deleted
    where.not(deleted_at: nil)
  end
end

# == Schema Information
#
# Table name: companies
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  name       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_deleted_at  (deleted_at)
#
