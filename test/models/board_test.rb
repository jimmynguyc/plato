# == Schema Information
#
# Table name: boards
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  title           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer
#

require "test_helper"

class BoardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
