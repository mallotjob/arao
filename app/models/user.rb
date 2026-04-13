class User < ApplicationRecord
  include ::CompanyScoped
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devisable

  belongs_to :company, optional: true
  belongs_to :creator, class_name: "User", foreign_key: :created_by, optional: true
  belongs_to :updater, class_name: "User", foreign_key: :updated_by, optional: true

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
  end

  def all_access?
    all_access
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  private

  def created_by_required_unless_all_access
    return if all_access?
    return if created_by.present?

    errors.add(:created_by, "is required unless user has all access")
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  all_access             :boolean          default(FALSE), not null
#  created_by             :uuid
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  deleted_at             :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  updated_by             :uuid
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :uuid
#
# Indexes
#
#  index_users_on_company_id            (company_id)
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (created_by => users.id)
#  fk_rails_...  (updated_by => users.id)
#
