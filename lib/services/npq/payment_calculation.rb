# frozen_string_literal: true

module Services
  module Npq
    class PaymentCalculation
      include InitializeWithConfig

      def call
        {
          input: config.to_h,
          output: {
            service_fees: ServiceFees.call(config),
            variable_payments: VariablePayments.call(config),
          },
        }
      end
    end
  end
end
