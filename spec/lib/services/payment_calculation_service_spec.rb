describe PaymentCalculationService do
  before do
    @config = { recruitment_target: 2000, band_a: 995, band_b: 979, band_c: 966, setup_cost: 123.456 }
    calculator = PaymentCalculationService.new(@config)
    @result = calculator.calculate
  end

  it 'Return BigDecimal for all money outputs' do
    expect(@result[:output][:per_participant_service_fee]).to be_a(BigDecimal)
    expect(@result[:output][:total_service_fee]).to be_a(BigDecimal)
    expect(@result[:output][:monthly_service_fee]).to be_a(BigDecimal)
  end

  it 'Includes config in the output' do
    expect(@result[:input]).to eq(@config)
  end
end
