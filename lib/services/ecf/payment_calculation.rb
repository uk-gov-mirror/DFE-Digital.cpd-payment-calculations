# frozen_string_literal: true

module Services
  module Ecf
    class PaymentCalculation
      include InitializeWithConfig

      def call
        {
          input: config.to_h,
          output: {
            service_fees: ServiceFees.call(config),
            variable_payments: VariablePaymentsAggregator.call(config),
          },
        }
      end
    end
  end
end
