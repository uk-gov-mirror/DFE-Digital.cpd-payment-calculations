# frozen_string_literal: true

class EcfPaymentCalculationService
  def initialize(config)
    @config = config
  end

  def calculate
    {
      input: @config,
      output: {
        service_fees: {
          per_participant_service_fee: per_participant_service_fee,
          total_service_fee: total_service_fee,
          monthly_service_fee: monthly_service_fee,
        },
        variable_fees: {
          per_participant_payment: per_participant_variable_payment,
          retention_payment_schedule: retention_payment_schedule,
        },
      },
    }
  end

private

  def per_participant_variable_payment
    band_a * 0.6
  end

  def per_participant_fee(payment_type)
    per_participant_variable_payment * (payment_type.match(/Start|Completion/) ? 0.2 : 0.15)
  end

  def fee(payment_type, retained_participants)
    per_participant_fee(payment_type) * retained_participants
  end

  def retention_payment_schedule
    @config.dig(:retained_participants).each_with_object({}) do |(payment_type, retained_participants), result|
      result[payment_type] = {
        retained_participants: retained_participants,
        per_participant: per_participant_fee(payment_type),
        fee: fee(payment_type, retained_participants),
      }
    end
  end

  def per_participant_service_fee
    band_a * 0.4
  end

  def total_service_fee
    recruitment_target * per_participant_service_fee
  end

  def monthly_service_fee
    number_of_monthly_payments = 29
    (total_service_fee / number_of_monthly_payments).round(0).to_d
  end

  # config accessors

  def band_a
    BigDecimal(@config[:band_a], 10)
  end

  def recruitment_target
    @config[:recruitment_target]
  end
end
