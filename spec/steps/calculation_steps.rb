module CalculationSteps

  step 'the recruitment target is :decimal_placeholder' do |value|
    @recruitment_target = value
  end

  step 'Band A per-participant price is £:decimal_placeholder' do |value|
    @band_a = value
  end

  step 'Band B per-participant price is £:decimal_placeholder' do |value|
    @band_b = value
  end

  step 'Band C per-participant price is £:decimal_placeholder' do |value|
    @band_c = value
  end

  step 'The set-up cost is £:decimal_placeholder' do |value|
    @setup_cost = value
  end

  step 'I run the calculation' do
    config = {
      recruitment_target: @recruitment_target,
      band_a: @band_a,
      band_b: @band_b,
      band_c: @band_c,
      setup_cost: @setup_cost,
    }
    calculator = PaymentCalculationService.new(config)
    @result = calculator.calculate
  end

  step 'The per-participant service fee is £:decimal_placeholder' do |expected_value|
    expect(@result[:output][:per_participant_service_fee]).to eq(expected_value)
  end

  step 'The total service fee is £:decimal_placeholder' do |expected_value|
    expect(@result[:output][:total_service_fee]).to eq(expected_value)
  end

  step 'The monthly service fee is £:decimal_placeholder' do |expected_value|
    expect(@result[:output][:monthly_service_fee]).to eq(expected_value)
  end
end

RSpec.configure do |config|
  config.include CalculationSteps
end
