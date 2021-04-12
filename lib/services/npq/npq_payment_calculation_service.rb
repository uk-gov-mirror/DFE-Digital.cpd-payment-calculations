# frozen_string_literal: true

class NpqPaymentCalculationService
  def initialize(config)
    @config = config
  end

  def calculate
    service_fee_payment_schedule = (1..number_of_service_fee_payments).each_with_object({}) do |i, schedule|
      schedule[i] = monthly_service_fee
    end

    {
      input: @config,
      output: {
        service_fees: {
          payment_schedule: service_fee_payment_schedule,
        },
        variable_fees:
          retention_points&.transform_values do |values|
            {
              per_participant: per_participant_variable_fee,
              total_variable_fee: total_variable_fee(values[:retained_participants]),
            }
          end,
      },
    }
  end

private

  def per_participant_price
    @config[:per_participant_price]
  end

  def recruitment_target
    @config[:recruitment_target]
  end

  def number_of_service_fee_payments
    @config[:number_of_service_fee_payments]
  end

  def retention_points
    @config[:retention_points]
  end

  def variable_payment_split
    1.0 / retention_points.length
  end

  def total_service_fee
    per_participant_price * 0.4 * recruitment_target
  end

  def monthly_service_fee
    (total_service_fee / number_of_service_fee_payments.to_d).round(2)
  end

  def per_participant_variable_fee
    (per_participant_price * 0.6 * variable_payment_split).round(2)
  end

  def total_variable_fee(retained_participants)
    (per_participant_variable_fee * retained_participants).round(2)
  end
end
