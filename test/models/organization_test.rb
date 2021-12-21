# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan       :string(255)
#

require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
