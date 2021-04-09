# frozen_string_literal: true

module EcfCalculationSteps
  step "the recruitment target is :decimal_placeholder" do |value|
    @recruitment_target = value
  end

  step "Band A per-participant price is £:decimal_placeholder" do |value|
    @band_a = value
  end

  step "there are the following retention numbers:" do |table|
    @retention_table = table.hashes.map do |values|
      {
        payment_type: values["Payment Type"],
        retained_participants: values["Retained Participants"].to_i,
        expected_per_participant_variable_fee: CurrencyParser.currency_to_big_decimal(values["Expected Per-Participant Variable Payment"]),
        expected_variable_fee: CurrencyParser.currency_to_big_decimal(values["Expected Variable Payment Subtotal"]),
      }
    end
  end

  step "I run the calculation" do
    config = {
      recruitment_target: @recruitment_target,
      band_a: @band_a,
      retained_participants: @retention_table.reduce({}) { |res, hash| res.merge({ hash[:payment_type] => hash[:retained_participants] }) },
    }
    calculator = EcfPaymentCalculationService.new(config)
    @result = calculator.calculate
  end

  step "the per-participant service fee should be £:decimal_placeholder" do |expected_value|
    expect(@result.dig(:output, :service_fees, :per_participant_service_fee)).to eq(expected_value)
  end

  step "the total service fee should be £:decimal_placeholder" do |expected_value|
    expect(@result.dig(:output, :service_fees, :total_service_fee)).to eq(expected_value)
  end

  step "the monthly service fee should be £:decimal_placeholder" do |expected_value|
    expect(@result.dig(:output, :service_fees, :monthly_service_fee)).to eq(expected_value)
  end

  step "the variable payment per-participant should be £:decimal_placeholder" do |expected_value|
    expect(@result.dig(:output, :variable_fees, :per_participant)).to eq(expected_value)
  end

  step "the variable payment schedule should be as above" do
    aggregate_failures "variable fees" do
      actual_schedule = @result.dig(:output, :variable_fees, :retention_payment_schedule)
      expect(actual_schedule.length).to eq(@retention_table.length)
      @retention_table.each do |expectation|
        actual_values = actual_schedule[expectation[:payment_type]]
        expect_with_context(actual_values[:retained_participants], expectation[:retained_participants], "#{expectation[:payment_type]} retention numbers passthrough")
        expect_with_context(actual_values[:per_participant], expectation[:expected_per_participant_variable_fee], "#{expectation[:payment_type]} per participant payment")
        expect_with_context(actual_values[:subtotal], expectation[:expected_variable_fee], "#{expectation[:payment_type]} variable fee")
      end
    end
  end
end

RSpec.configure do |config|
  config.include EcfCalculationSteps, ecf: true
end
