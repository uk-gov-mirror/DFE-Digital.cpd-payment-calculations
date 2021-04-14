# frozen_string_literal: true

module Services
  module Npq
    class VariableFeeSchedule < PaymentCalculation
      def call
        {
          input: config,
          output: {
            variable_fee_schedule: variable_fee_schedule,
          },
        }
      end

    private

      def retention_points
        config[:retention_points]
      end

      def per_teacher_variable_fee
        (price_per_participant * 0.6 * payment_split).round(2)
      end

      def total_variable_fee(retained_participants)
        (per_teacher_variable_fee * retained_participants).round(2)
      end

      def payment_split
        1.0 / retention_points.length
      end

      def variable_fee_schedule
        retention_points.transform_values do |values|
          {
            per_teacher_variable_fee: per_teacher_variable_fee,
            total_variable_fee: total_variable_fee(values[:retained_participants]),
          }
        end
      end
    end
  end
end
