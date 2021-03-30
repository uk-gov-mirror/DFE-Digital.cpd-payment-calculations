# frozen_string_literal: true

QUALIFICATION_NAME = "foo"

describe NpqPaymentCalculationService do
  before do
    @config = {
      recruitment_target: 2000,
      qualifications: {
        QUALIFICATION_NAME => {
          price_per_teacher: BigDecimal(456.78, 10),
          minimum_delivery_months: 19,
        },
      },
    }
    calculator = NpqPaymentCalculationService.new(@config)
    @result = calculator.calculate
  end

  it "returns BigDecimal for all money outputs" do
    expect(@result.dig(:output, :qualifications, QUALIFICATION_NAME, :service_fee)).to be_a(BigDecimal)
    expect(@result.dig(:output, :qualifications, QUALIFICATION_NAME, :monthly_service_fee)).to be_a(BigDecimal)
    expect(@result.dig(:output, :payment_schedule).values).to all(be_a(BigDecimal))
  end

  it "includes config in the output" do
    expect(@result[:input]).to eq(@config)
  end
end
