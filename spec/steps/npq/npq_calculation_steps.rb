# frozen_string_literal: true

module NpqCalculationSteps
  step "there's an qualification with a price-per-participant of £:decimal_placeholder" do |value|
    @price_per_participant = value
  end

  step "the recruitment target is :value" do |value|
    @recruitment_target = value.to_i
  end

  step "there are :value monthly service fee payments" do |value|
    @number_of_monthly_payments = value.to_i
  end

  def calculate_service_fee_schedule
    config = {
      recruitment_target: @recruitment_target,
      number_of_monthly_payments: @number_of_monthly_payments,
      price_per_participant: @price_per_participant,
    }
    calculator = NpqPaymentCalculationService.new(config)
    calculator.service_fee_schedule
  end

  step "the service fee payment schedule should be:" do |table|
    result = calculate_service_fee_schedule
    aggregate_failures "service fees" do
      table.hashes.each do |row|
        month = row["Month"].to_i
        expected_service_fee_total = CurrencyParser.currency_to_big_decimal(row["Service fee total"])
        expect_with_context(result.dig(:output, :service_fee_payment_schedule, month), expected_service_fee_total, "Payment for month '#{month}'")
      end
    end
  end

  step "the service fee total should be £:decimal_placeholder" do |expected_amount|
    result = calculate_service_fee_schedule
    expect(result.dig(:output, :service_fee_payment_schedule).values.sum).to eq(expected_amount)
  end

  step "there are the following retention points:" do |table|
    @retention_table = {}

    table.hashes.each do |row|
      @retention_table[row["Payment Type"]] = {
        retained_participants: row["Retained Participants"].to_i,
        expected_per_teacher_variable_fee: CurrencyParser.currency_to_big_decimal(row["Expected Per-Teacher Variable Fee"]),
        expected_variable_fee: CurrencyParser.currency_to_big_decimal(row["Expected Variable Fee"]),
      }
    end
  end

  def calculate_variable_fee_schedule
    retention_points = {}
    @retention_table.each do |retention_point, values|
      retention_points[retention_point] = {
        retained_participants: values[:retained_participants],
        percentage: values[:percentage],
      }
    end

    config = {
      recruitment_target: @recruitment_target,
      number_of_monthly_payments: @number_of_monthly_payments,
      price_per_participant: @price_per_participant,
      retention_points: retention_points,
    }
    calculator = NpqPaymentCalculationService.new(config)
    calculator.variable_fee_schedule
  end

  step "expected variable fees should be as above" do
    result = calculate_variable_fee_schedule
    aggregate_failures "variable fees" do
      @retention_table.each do |retention_point, values|
        expect_with_context(
          result.dig(:output, :variable_fee_schedule, retention_point, :per_teacher_variable_fee), values[:expected_per_teacher_variable_fee], "Payment for retention point '#{retention_point}'"
        )

        expect_with_context(
          result.dig(:output, :variable_fee_schedule, retention_point, :total_variable_fee), values[:expected_variable_fee], "Total variable fee '#{retention_point}'"
        )
      end
    end
  end
end

RSpec.configure do |config|
  config.include NpqCalculationSteps, npq: true
end
