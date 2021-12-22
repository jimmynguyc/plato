module Subscription
  class Base
    attr_reader :duration, :organization

    def initialize(duration:, organization: nil)
      @duration = duration
      @organization = organization
    end

    def seats() = self.class.seats
    def monthly_fee() = self.class.monthly_fee
    def annual_monthly_fee() = self.class.annual_monthly_fee
    def extra_seats_fee() = self.class.extra_seats_fee

    def amount_due
      subscription_total + extra_seats_total
    end

    private

    def annual_billing?
      duration % 1.year == 0
    end

    def subscription_total
      fee = annual_billing? ? annual_monthly_fee : monthly_fee
      fee * duration.in_months
    end

    def extra_seats_total
      extra_seats = [organization_users_count, seats].max - seats
      extra_seats * extra_seats_fee * duration.in_months
    end

    def organization_users_count
      organization&.users&.count || 0
    end
  end
end
