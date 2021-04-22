# frozen_string_literal: true

module Services
  module Ecf
    class VariablePaymentsPerParticipant
      include InitializeWithConfig
      delegate :band_a, to: :config

      def call
        variable_payment_per_participant
      end

      private

      def variable_payment_per_participant
        band_a * 0.6
      end

    end
  end
end
