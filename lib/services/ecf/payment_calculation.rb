# frozen_string_literal: true

module Services
  module Ecf
    class PaymentCalculation < Services::Core::PaymentCalculation
      class << self
        def call(config)
          self.new(config).()
        end
      end

      def call
        {
          input: config,
          output: {
            per_participant_service_fee: per_participant_service_fee,
            total_service_fee: total_service_fee,
            monthly_service_fee: monthly_service_fee,
          },
        }
      end

      private

      def per_participant_service_fee
        band_a * 0.4
      end

      def total_service_fee
        recruitment_target * per_participant_service_fee
      end

      def monthly_service_fee
        (total_service_fee / number_of_monthly_payments).round(0).to_d
      end

      def number_of_monthly_payments
        29
      end

      # config accessors

      def band_a
        BigDecimal(config[:band_a], 10)
      end
    end
  end
end
