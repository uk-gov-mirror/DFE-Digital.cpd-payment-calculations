# frozen_string_literal: true

module Services
  module Ecf
    class VariablePaymentsAggregator
      include InitializeWithConfig
      delegate :retained_participants, to: :config

      def call
        {
          per_participant: VariablePaymentsPerParticipant.call(config),
          **({variable_payment_schedule: VariablePaymentsSchedule.call(config)} if retained_participants).to_h
        }
      end

    end
  end
end
