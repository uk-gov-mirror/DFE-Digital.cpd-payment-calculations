# frozen_string_literal: true

describe EcfPaymentCalculationService do
  let(:config) { { recruitment_target: 2000, band_a: 995 } }
  let(:result) { EcfPaymentCalculationService.new(config).calculate }

  it "returns BigDecimal for all money outputs" do
    expect(result.dig(:output, :service_fees, :per_participant_service_fee)).to be_a(BigDecimal)
    expect(result.dig(:output, :service_fees, :total_service_fee)).to be_a(BigDecimal)
    expect(result.dig(:output, :service_fees, :monthly_service_fee)).to be_a(BigDecimal)
    expect(result.dig(:output, :variable_fees, :todo)).to be_a(BigDecimal)
  end

  it "includes config in the output" do
    expect(result[:input]).to eq(config)
  end
end
