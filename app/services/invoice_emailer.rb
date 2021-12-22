class InvoiceSender < ApplicationService
  attr_reader :user, :duration

  def initialize(user:, duration:)
    @user = user
    @duration = duration
  end

  def call
    amount_due
  end

  private

  def amount_due
    subscription.new(duration: duration, organization: user.organization).amount_due
  end

  def subscription
    case user.subscription_type
    when 'business'
      Subscription::Business
    when 'startup'
      Subscription::Startup
    else
      Subscription::Solo
    end
  end
end
