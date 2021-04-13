module Services
  module Npq
    class VariableFeeSchedule < PaymentCalculation
      def call
        {
          input: config,
          output: {
            variable_fee_schedule: retention_points.transform_values do |values|
              {
                per_teacher_variable_fee: per_teacher_variable_fee,
                total_variable_fee: total_variable_fee(values[:retained_participants]),
              }
            end,
          },
        }
      end

      private
      def retention_points
        config[:retention_points]
      end
    end
  end
end
