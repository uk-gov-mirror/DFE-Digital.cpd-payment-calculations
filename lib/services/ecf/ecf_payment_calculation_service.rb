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
          starting_per_participant_payment: starting_per_participant_fee,
          starting_payment: starting_payment("Start"),
          retention_payment_schedule: (1..4).map { |i| retention_payment("Retention #{i}") },
          completion_per_participant_payment: completion_payment_per_participant,
          completion_payment: completion_payment("Completion"),
        },
      },
    }
  end

private

  def per_participant_variable_payment
    band_a * 0.6
  end

  def starting_per_participant_fee
    per_participant_variable_payment * 0.2
  end

  def starting_payment(payment_type)
    starting_per_participant_fee * retained_participants(payment_type)
  end

  def completion_payment(payment_type)
    completion_payment_per_participant * retained_participants(payment_type)
  end

  def completion_payment_per_participant
    (per_participant_variable_payment * 0.2)
  end

  def retention_payment(_payment_type)
    (per_participant_variable_payment * 0.15)
  end

  def retained_participants(payment_type)
    @config.dig(:retained_participants, payment_type)
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
