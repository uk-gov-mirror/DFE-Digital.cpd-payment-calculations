# frozen_string_literal: true

describe EcfPaymentCalculationService do
  let(:config) do
    {
      recruitment_target: 2000,
      band_a: BigDecimal(995, 10),
      retained_participants: {
        "Start" => 1900,
        "Retention 1" => 1700,
        "Retention 2" => 1500,
        "Retention 3" => 1000,
        "Retention 4" => 800,
        "Completion" => 500,
      },
    }
  end
  let(:result) { EcfPaymentCalculationService.new(config).calculate }

  it "returns BigDecimal for all money outputs" do
    expect(result.dig(:output, :service_fees, :per_participant_service_fee)).to be_a(BigDecimal)
    expect(result.dig(:output, :service_fees, :total_service_fee)).to be_a(BigDecimal)
    expect(result.dig(:output, :service_fees, :monthly_service_fee)).to be_a(BigDecimal)
    expect(result.dig(:output, :variable_fees, :per_participant_payment)).to be_a(BigDecimal)
    result.dig(:output, :variable_fees, :retention_payment_schedule).each do |_key, value|
      expect(value[:per_participant]).to be_a(BigDecimal)
      expect(value[:fee]).to be_a(BigDecimal)
    end
  end

  it "includes config in the output" do
    expect(result[:input]).to eq(config)
  end
end
