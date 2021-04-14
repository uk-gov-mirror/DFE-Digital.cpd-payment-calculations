# frozen_string_literal: true

module Services
  module Npq
    class PaymentCalculation < ::Services::Core::PaymentCalculation
      class << self
        def call(config)
          new(config).call
        end
      end

      def call
        raise "abstract method needs to be overridden"
      end

    private

      def total_service_fee
        recruitment_target * per_participant_service_fee
      end

      def price_per_participant
        config[:price_per_participant]
      end

      def per_participant_service_fee
        raise "abstract method needs to be overridden"
      end
    end
  end
end
