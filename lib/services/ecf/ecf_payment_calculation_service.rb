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
          service_fee_per_participant: service_fee_per_participant,
          service_fee_total: service_fee_total,
          service_fee_monthly: service_fee_monthly,
        },
        variable_payments: {
          per_participant: variable_payment_per_participant,
          variable_payment_schedule: variable_payment_schedule,
        },
      },
    }
  end

private

  def recruitment_target
    @config[:recruitment_target]
  end

  def band_a
    @config[:band_a]
  end

  def service_fee_per_participant
    band_a * 0.4
  end

  def service_fee_total
    recruitment_target * service_fee_per_participant
  end

  def service_fee_monthly
    number_of_service_fee_payments = 29
    (service_fee_total / number_of_service_fee_payments).round(0)
  end

  def variable_payment_per_participant
    band_a * 0.6
  end

  def variable_payment_schedule
    @config.dig(:retained_participants).each_with_object({}) do |(payment_type, retained_participants), result|
      result[payment_type] = {
        retained_participants: retained_participants,
        per_participant: variable_payment_per_participant_for(payment_type),
        subtotal: variable_payment_subtotal_for(payment_type, retained_participants),
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
