module Subscription
  class Solo < Base
    class << self
      def seats() = 1
      def monthly_fee() = 2.0
      def annual_monthly_fee() = 2.0
      def extra_seats_fee() = 0.0
    end
  end
end
