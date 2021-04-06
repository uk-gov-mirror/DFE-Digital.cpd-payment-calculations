# frozen_string_literal: true

module NpqCalculationSteps
  step "there's an qualification with a price-per-participant of £:decimal_placeholder" do |value|
    @price_per_participant = value
  end

  step "the recruitment target is :value" do |value|
    @recruitment_target = value.to_i
  end

  step "there are :value monthly service fee payments" do |value|
    @number_of_monthly_payments = value.to_i
  end

  step "I run the calculation" do
    config = {
      recruitment_target: @recruitment_target,
      number_of_monthly_payments: @number_of_monthly_payments,
      price_per_participant: @price_per_participant,
    }
    calculator = NpqPaymentCalculationService.new(config)
    @result = calculator.calculate
  end

  step "the service fee payment schedule should be:" do |table|
    aggregate_failures "service fees" do
      table.hashes.each do |row|
        month = row["Month"].to_i
        expected_service_fee_total = CurrencyParser.currency_to_big_decimal(row["Service fee total"])
        expect_with_context(@result.dig(:output, :service_fee_payment_schedule, month), expected_service_fee_total, "Payment for month '#{month}'")
      end
    end
  end

  step "the service fee total should be £:decimal_placeholder" do |expected_amount|
    expect(@result.dig(:output, :service_fee_payment_schedule).values.sum).to eq(expected_amount)
  end
end

RSpec.configure do |config|
  config.include NpqCalculationSteps, npq: true
end
