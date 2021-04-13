module Services
  module NPQ
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
    end
  end
end
