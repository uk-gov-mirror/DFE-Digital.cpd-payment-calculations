module CalculationSteps
  step 'I run the calculation' do
    puts 'todo: run calculator here'
    @calculator_result = PaymentCalculationService.calculate
  end

  step 'The output should be :decimal_placeholder' do |sum|
    expect(@calculator_result).to eq(sum)
  end
end

RSpec.configure do |config|
  config.include CalculationSteps
end
