require 'test_helper'

module SubscriptionSoloTest
  class AmountDue < ActiveSupport::TestCase
    #  def seats() = 1
    #  def monthly_fee() = 2.0
    #  def annual_monthly_fee() = 2.0
    #  def extra_seats_fee() = 0.0

    setup do
      @org = nil
      @subject = Subscription::Solo
    end

    test 'monthly subscription' do
      sub = @subject.new(organization: @org, duration: 3.months)
      # 2 * 3
      assert_equal 6.0, sub.amount_due

      sub = @subject.new(organization: @org, duration: 15.months)
      # 2 * 15
      assert_equal 30.0, sub.amount_due
    end
  end
end
