require 'test_helper'

module SubscriptionStartupTest
  class AmountDue < ActiveSupport::TestCase
    #  def seats() = 5
    #  def monthly_fee() = 20.0
    #  def annual_monthly_fee() = 18.0
    #  def extra_seats_fee() = 7.0

    setup do
      @org = organizations(:startup_no_users)
      @subject = Subscription::Startup
    end

    def generate_users(n)
      n.times do |n|
        @org.users << User.create!(email: "users#{n}@example.org", password: 'abcd1234')
      end
    end

    test 'monthly subscription' do
      sub = @subject.new(organization: @org, duration: 3.months)
      # 20 * 3
      assert_equal 60.0, sub.amount_due

      sub = @subject.new(organization: @org, duration: 15.months)
      # 20 * 15
      assert_equal 300.0, sub.amount_due
    end

    test 'yearly subscription' do
      sub = @subject.new(organization: @org, duration: 12.months)
      # 18 * 12
      assert_equal 216.0, sub.amount_due

      sub = @subject.new(organization: @org, duration: 24.months)
      # 18 * 24
      assert_equal 432.0, sub.amount_due
    end

    test 'users within seats' do
      generate_users([*1..@subject.seats].sample)

      sub = @subject.new(organization: @org, duration: 3.months)
      # 20 * 3
      assert_equal 60.0, sub.amount_due
    end

    test 'with extra seats' do
      duration = 3.months
      extra_seats = [*1..20].sample

      generate_users(@subject.seats + extra_seats)

      sub = @subject.new(organization: @org, duration: duration)
      # 20 * 3 + (seats * 7 * 3)
      assert_equal 60.0 + (extra_seats * @subject.extra_seats_fee * duration.in_months), sub.amount_due
    end
  end
end
