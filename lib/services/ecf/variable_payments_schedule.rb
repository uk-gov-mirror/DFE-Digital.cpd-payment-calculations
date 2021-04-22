# frozen_string_literal: true

module Services
  module Ecf
    class VariablePaymentsSchedule
      include InitializeWithConfig
      delegate :retained_participants, to: :config

      def call
        variable_payment_schedule
      end

      private

      def variable_payment_schedule
        retained_participants.each_with_object({}) do |(payment_type, number_retained), result|
          result[payment_type] = {
            retained_participants: number_retained,
            per_participant: variable_payment_per_participant_for(payment_type),
            subtotal: variable_payment_subtotal_for(payment_type, number_retained),
          }
        end
      end

      def variable_payment_per_participant_for(payment_type)
        variable_payment_per_participant * (payment_type.match(/Start|Completion/) ? 0.2 : 0.15)
      end

      def variable_payment_subtotal_for(payment_type, number_retained)
        variable_payment_per_participant_for(payment_type) * number_retained
      end

      def variable_payment_per_participant
        VariablePaymentsPerParticipant.call(config)
      end

    end
  end
end
