describe PaymentCalculationService do
  it 'Returns a BigDecimal' do
    calculator_result = PaymentCalculationService.calculate
    expect(calculator_result).to be_a(BigDecimal)
  end
end
