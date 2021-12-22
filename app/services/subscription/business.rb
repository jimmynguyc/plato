module Subscription
  class Business < Base
    class << self
      def seats() = 20
      def monthly_fee() = 60.0
      def annual_monthly_fee() = 55.0
      def extra_seats_fee() = 6.0
    end
  end
end
