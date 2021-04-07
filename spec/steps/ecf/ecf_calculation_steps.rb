# frozen_string_literal: true

module EcfCalculationSteps
  step "the recruitment target is :decimal_placeholder" do |value|
    @recruitment_target = value
  end

  step "Band A per-participant price is £:decimal_placeholder" do |value|
    @band_a = value
  end

  step "I run the calculation" do
    config = {
      recruitment_target: @recruitment_target,
      band_a: @band_a,
    }
    calculator = EcfPaymentCalculationService.new(config)
    @result = calculator.calculate
  end

  step "The per-participant service fee should be £:decimal_placeholder" do |expected_value|
    expect(@result[:output][:per_participant_service_fee]).to eq(expected_value)
  end

  step "The total service fee should be £:decimal_placeholder" do |expected_value|
    expect(@result[:output][:total_service_fee]).to eq(expected_value)
  end

  step "The monthly service fee should be £:decimal_placeholder" do |expected_value|
    expect(@result[:output][:monthly_service_fee]).to eq(expected_value)
  end

  step "The variable payment schedule should be:" do |table|
    aggregate_failures "variable fees" do
      table.hashes.each do |row|
        # month = row["Month"].to_i
        expected_service_fee_total = CurrencyParser.currency_to_big_decimal(row["Service fee total"])
        expect_with_context(result.dig(:output, :service_fee_payment_schedule, month), expected_service_fee_total, "Payment for month '#{month}'")
      end
    end
  end
end

RSpec.configure do |config|
  config.include EcfCalculationSteps, ecf: true
end
