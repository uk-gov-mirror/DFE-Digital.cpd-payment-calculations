# frozen_string_literal: true

describe EcfPaymentCalculationService do
  before do
    @config = { recruitment_target: 2000, band_a: 995 }
    calculator = EcfPaymentCalculationService.new(@config)
    @result = calculator.calculate
  end

  it "returns BigDecimal for all money outputs" do
    expect(@result[:output][:per_participant_service_fee]).to be_a(BigDecimal)
    expect(@result[:output][:total_service_fee]).to be_a(BigDecimal)
    expect(@result[:output][:monthly_service_fee]).to be_a(BigDecimal)
  end

  it "includes config in the output" do
    expect(@result[:input]).to eq(@config)
  end
end
