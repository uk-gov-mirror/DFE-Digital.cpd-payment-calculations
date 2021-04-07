# frozen_string_literal: true

class NpqPaymentCalculationService
  def initialize(config)
    @config = config
  end

  def service_fee_schedule
    service_fee_payment_schedule = (1..number_of_monthly_payments).each_with_object({}) do |i, schedule|
      schedule[i] = monthly_service_fee
    end
    {
      input: @config,
      output: {
        service_fee_payment_schedule: service_fee_payment_schedule,
      },
    }
  end

  def variable_fee_schedule
    {
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
    @config[:retention_points]
  end

  def price_per_participant
    @config[:price_per_participant]
  end

  def recruitment_target
    @config[:recruitment_target]
  end

  def number_of_monthly_payments
    @config[:number_of_monthly_payments]
  end

  def payment_split
    1.0 / retention_points.length
  end

  def total_service_fee
    price_per_participant * 0.4 * recruitment_target
  end

  def monthly_service_fee
    (total_service_fee / number_of_monthly_payments.to_d).round(2)
  end

  def per_teacher_variable_fee
    (price_per_participant * 0.6 * payment_split).round(2)
  end

  def total_variable_fee(retained_participants)
    (per_teacher_variable_fee * retained_participants).round(2)
  end
end
