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
    end
  end
end
