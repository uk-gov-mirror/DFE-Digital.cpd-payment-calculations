# frozen_string_literal: true

QUALIFICATION_NAME = "foo"

describe NpqPaymentCalculationService do
  before do
    @config = {
      recruitment_target: 2000,
      price_per_participant: BigDecimal(456.78, 10),
      number_of_monthly_payments: 19,
    }
    calculator = NpqPaymentCalculationService.new(@config)
    @result = calculator.service_fee_schedule
  end

  it "returns BigDecimal for all money outputs" do
    expect(@result.dig(:output, :service_fee_payment_schedule, 1)).to be_a(BigDecimal)
  end

  it "includes config in the output" do
    expect(@result[:input]).to eq(@config)
  end
end
