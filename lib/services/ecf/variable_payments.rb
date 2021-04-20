# frozen_string_literal: true

module Services
  module Ecf
    class VariablePayments
      include InitializeWithConfig
      delegate :band_a, :retained_participants, to: :config

      def call
        {
          per_participant: variable_payment_per_participant,
          variable_payment_schedule: variable_payment_schedule,
        }
      end

    private

      def variable_payment_per_participant
        band_a * 0.6
      end

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

      def variable_payment_subtotal_for(payment_type, retained_participants)
        variable_payment_per_participant_for(payment_type) * retained_participants
      end
    end
  end
end
