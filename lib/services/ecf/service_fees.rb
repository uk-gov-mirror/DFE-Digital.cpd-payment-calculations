# frozen_string_literal: true

module Services
  module Ecf
    class ServiceFees
      include InitializeWithConfig
      delegate :band_a, :recruitment_target, to: :config

      def call
        {
          service_fee_per_participant: service_fee_per_participant,
          service_fee_total: service_fee_total,
          service_fee_monthly: service_fee_monthly,
        }
      end

    private

      def number_of_service_fee_payments
        29
      end

      def service_fee_per_participant
        band_a * 0.4
      end

      def service_fee_total
        recruitment_target * service_fee_per_participant
      end

      def service_fee_monthly
        (service_fee_total / number_of_service_fee_payments).round(0)
      end
    end
  end
end
