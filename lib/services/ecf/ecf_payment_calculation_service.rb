# frozen_string_literal: true

class EcfPaymentCalculationService
  def initialize(config)
    @config = config
  end

  def calculate
    {
      input: @config,
      output: {
        service_fees:{
          per_participant_service_fee: per_participant_service_fee,
          total_service_fee: total_service_fee,
          monthly_service_fee: monthly_service_fee,
        },
        variable_fees:{
          starting_per_teacher_payment: 123,
          starting_payment: 12356,
          completion_per_teacher_payment: 123,
          completion_payment: 34589,
          retention_payment_schedule: [
            # todo
          ],
        }
      },
    }
  end

private

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
