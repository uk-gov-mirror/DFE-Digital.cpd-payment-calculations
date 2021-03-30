# frozen_string_literal: true

class NpqPaymentCalculationService
  def initialize(config)
    @config = config
  end

  def calculate
    payment_schedule = @config[:qualifications].each_with_object({}) do |(_name, qualification_inputs), schedule|
      (1..qualification_inputs[:minimum_delivery_months]).each do |month|
        schedule[month] = (schedule[month] || 0) + monthly_service_fee(qualification_inputs)
      end
    end

    {
      input: @config,
      output: {
        qualifications: @config[:qualifications].transform_values do |qualification|
          {
            service_fee: total_qualification_service_fee(qualification),
            monthly_service_fee: monthly_service_fee(qualification),
          }
        end,
        payment_schedule: payment_schedule,
      },
    }
  end

  def total_qualification_service_fee(qualification)
    qualification[:price_per_teacher] * 0.4 * @config[:recruitment_target]
  end

private

  def monthly_service_fee(qualification)
    (total_qualification_service_fee(qualification) / qualification[:minimum_delivery_months].to_d).round(2)
  end
end
