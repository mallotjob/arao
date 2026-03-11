require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
