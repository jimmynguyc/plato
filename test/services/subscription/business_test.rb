require 'test_helper'

module SubscriptionBusinessTest
  class AmountDue < ActiveSupport::TestCase
    #  def seats() = 20
    #  def monthly_fee() = 60.0
    #  def annual_monthly_fee() = 55.0
    #  def extra_seats_fee() = 6.0

    setup do
      @org = organizations(:business_no_users)
      @subject = Subscription::Business
    end

    def generate_users(n)
      n.times do |n|
        @org.users << User.create!(email: "users#{n}@example.org", password: 'abcd1234')
      end
    end

    test 'monthly subscription' do
      sub = @subject.new(organization: @org, duration: 3.months)
      # 60 * 3
      assert_equal 180.0, sub.amount_due

      sub = @subject.new(organization: @org, duration: 15.months)
      # 60 * 15
      assert_equal 900.0, sub.amount_due
    end

    test 'yearly subscription' do
      sub = @subject.new(organization: @org, duration: 12.months)
      # 55 * 12
      assert_equal 660.0, sub.amount_due

      sub = @subject.new(organization: @org, duration: 24.months)
      # 55 * 24
      assert_equal 1320.0, sub.amount_due
    end

    test 'users within seats' do
      generate_users([*1..@subject.seats].sample)

      sub = @subject.new(organization: @org, duration: 3.months)
      # 60 * 3
      assert_equal 180.0, sub.amount_due
    end

    test 'with extra seats' do
      duration = 3.months
      extra_seats = [*1..20].sample

      generate_users(@subject.seats + extra_seats)

      sub = @subject.new(organization: @org, duration: duration)
      # 60 * 3 + (seats * 6 * 3)
      assert_equal 180.0 + (extra_seats * @subject.extra_seats_fee * duration.in_months), sub.amount_due
    end
  end
end
