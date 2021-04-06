# frozen_string_literal: true

class NpqPaymentCalculationService
  def initialize(config)
    @config = config
  end

  def calculate
    service_fee_payment_schedule = (1..@config[:number_of_monthly_payments]).each_with_object({}) do |i, schedule|
      schedule[i] = monthly_service_fee
    end
    {
      input: @config,
      output: {
        service_fee_payment_schedule: service_fee_payment_schedule,
      },
    }
  end

private

  def total_service_fee
    @config[:price_per_participant] * 0.4 * @config[:recruitment_target]
  end

  def monthly_service_fee
    (total_service_fee / @config[:number_of_monthly_payments].to_d).round(2)
  end
end
