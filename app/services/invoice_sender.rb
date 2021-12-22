class InvoiceSender < ApplicationService
  attr_reader :user, :duration

  def initialize(user:, duration:)
    @user = user
    @duration = duration
  end

  def call
    UserMailer.send_invoice(user: user, duration: duration, amount_due: amount_due).send_later
  end

  private

  def amount_due
    user.subscription_class.new(duration: duration, organization: user.organization).amount_due
  end
end
