require_relative 'payment_calculation'

module Services
  module Npq
    class ServiceFeeSchedule < PaymentCalculation
      def call
        {
          input: config,
          output: { service_fee_payment_schedule: service_fee_payment_schedule },
        }
      end

      private

      def service_fee_payment_schedule
        [monthly_service_fee] * number_of_monthly_payments
      end

      def per_participant_service_fee
        price_per_participant * 0.4
      end

      def number_of_monthly_payments
        config[:number_of_monthly_payments]
      end

    end
  end
end
