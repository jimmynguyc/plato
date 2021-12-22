# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string(255)
#  last_name              :string(255)
#  organization_id        :integer
#

require 'test_helper'

module UserTest
  class SubscriptionClassTest < ActiveSupport::TestCase
    test 'returns correct subscription class' do
      assert_equal Subscription::Solo, users(:solo).subscription_class
      assert_equal Subscription::Startup, users(:with_startup_org).subscription_class
      assert_equal Subscription::Business, users(:with_business_org).subscription_class
    end
  end
end
