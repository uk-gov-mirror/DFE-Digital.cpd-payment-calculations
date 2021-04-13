module Services
  module Core
    class PaymentCalculation
      private
      attr_accessor :config

      # @param [Hash] config
      def initialize(config)
        self.config = config
      end

      def recruitment_target
        config[:recruitment_target]
      end
    end
  end
end
