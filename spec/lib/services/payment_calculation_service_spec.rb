describe PaymentCalculationService do
  it 'Return BigDecimal for all money outputs' do
    config = { :recruitment_target => 2000, :band_a => 995, :band_b => 979, :band_c => 966, :setup_cost => 123.456 }
    calculator = PaymentCalculationService.new(config)
    expect(calculator.per_participant_service_fee).to be_a(BigDecimal)
    expect(calculator.total_service_fee).to be_a(BigDecimal)
    expect(calculator.monthly_service_fee).to be_a(BigDecimal)
  end
end
