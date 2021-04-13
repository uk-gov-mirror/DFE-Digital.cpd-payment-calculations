# frozen_string_literal: true
module Services
  module Npq
    class PaymentCalculation < ::Services::Core::PaymentCalculation
      class << self
        def call(config)
          self.new(config).call
        end
      end

      def call
        raise "abstract method needs to be overridden"
      end

      private
      def price_per_participant
        config[:price_per_participant]
      end

      def number_of_monthly_payments
        config[:number_of_monthly_payments]
      end

      def payment_split
        1.0 / retention_points.length
      end

      def total_service_fee
        price_per_participant * 0.4 * recruitment_target
      end

      def monthly_service_fee
        (total_service_fee / number_of_monthly_payments.to_d).round(2)
      end

      def per_teacher_variable_fee
        (price_per_participant * 0.6 * payment_split).round(2)
      end

      def total_variable_fee(retained_participants)
        (per_teacher_variable_fee * retained_participants).round(2)
      end
    end
  end
end
