# frozen_string_literal: true

module Services
  module Core
    class PaymentCalculation
    private

      attr_accessor :config

      # @param [Hash] config
      def initialize(config)
        self.config = config
      end

      def recruitment_target
        config[:recruitment_target]
      end

      def monthly_service_fee
        (total_service_fee / number_of_monthly_payments.to_d).round(2)
      end
    end
  end
end
