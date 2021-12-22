require 'active_support/concern'

module Subscribable
  extend ActiveSupport::Concern

  def subscription_class
    case subscription_type
    when 'business'
      Subscription::Business
    when 'startup'
      Subscription::Startup
    when 'solo'
      Subscription::Solo
    end
  end
end
